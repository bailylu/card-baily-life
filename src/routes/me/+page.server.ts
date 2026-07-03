import { fail, redirect } from '@sveltejs/kit';
import { eq } from 'drizzle-orm';
import type { Actions, PageServerLoad } from './$types';
import { getDb } from '$lib/db/client';
import { users } from '$lib/db/schema';
import { buildClerkSignInUrl } from '$lib/auth/clerk-sign-in';
import { hashPassword, verifyPassword } from '$lib/auth/password';
import { syncCardUserToCrm } from '$lib/crm-sync';
import {
	emptyNotificationSettings,
	getNotificationSettings,
	saveNotificationSettings,
	settingsFromForm,
	type NotificationSettings
} from '$lib/notifications/settings';

const TEST_TITLE = '贝利卡管家测试通知';
const TEST_CONTENT = '这是一条即时测试通知，点击测试后会立即发送。正式的账单日、还款日和年费日提醒默认会在当天中午 12:00 发送。';

function validateNotificationSettings(settings: NotificationSettings) {
	if ((settings.telegramBotToken && !settings.telegramChatId) || (!settings.telegramBotToken && settings.telegramChatId)) {
		return 'Telegram Bot Token 和 Chat ID 需要一起填写';
	}

	return '';
}

function normalizeBarkKey(input: string) {
	const value = input.trim();
	if (!value) return '';
	if (!/^https?:\/\//i.test(value)) return value;

	try {
		const url = new URL(value);
		return url.pathname.split('/').filter(Boolean)[0] ?? value;
	} catch {
		return value;
	}
}

async function sendBarkTest(key: string) {
	const barkKey = normalizeBarkKey(key);
	const url = `https://api.day.app/${encodeURIComponent(barkKey)}/${encodeURIComponent(TEST_TITLE)}/${encodeURIComponent(TEST_CONTENT)}`;
	const response = await fetch(url);
	if (!response.ok) throw new Error('Bark 推送失败，请检查 Key');
}

async function sendPushPlusTest(token: string) {
	const response = await fetch('https://www.pushplus.plus/send', {
		method: 'POST',
		headers: { 'content-type': 'application/json' },
		body: JSON.stringify({
			token,
			title: TEST_TITLE,
			content: TEST_CONTENT,
			template: 'txt'
		})
	});

	const result = await response.json().catch(() => null) as { code?: number; msg?: string } | null;
	if (!response.ok || result?.code !== 200) {
		throw new Error(result?.msg ? `PushPlus 推送失败：${result.msg}` : 'PushPlus 推送失败，请检查 Token');
	}
}

async function sendTelegramTest(botToken: string, chatId: string) {
	const response = await fetch(`https://api.telegram.org/bot${botToken}/sendMessage`, {
		method: 'POST',
		headers: { 'content-type': 'application/json' },
		body: JSON.stringify({
			chat_id: chatId,
			text: `${TEST_TITLE}\n\n${TEST_CONTENT}`
		})
	});

	const result = await response.json().catch(() => null) as { ok?: boolean; description?: string } | null;
	if (!response.ok || !result?.ok) {
		throw new Error(result?.description ? `Telegram 推送失败：${result.description}` : 'Telegram 推送失败，请检查 Token 和 Chat ID');
	}
}

async function sendTestNotification(settings: NotificationSettings) {
	const tasks: Array<[string, () => Promise<void>]> = [];
	if (settings.barkKey) tasks.push(['Bark', () => sendBarkTest(settings.barkKey)]);
	if (settings.pushPlusToken) tasks.push(['PushPlus', () => sendPushPlusTest(settings.pushPlusToken)]);
	if (settings.telegramBotToken && settings.telegramChatId) {
		tasks.push(['Telegram', () => sendTelegramTest(settings.telegramBotToken, settings.telegramChatId)]);
	}

	if (tasks.length === 0) return { sent: [], errors: ['请先填写至少一种即时通知配置'] };

	const sent: string[] = [];
	const errors: string[] = [];
	for (const [name, task] of tasks) {
		try {
			await task();
			sent.push(name);
		} catch (error) {
			errors.push(error instanceof Error ? error.message : `${name} 推送失败`);
		}
	}

	return { sent, errors };
}

export const load: PageServerLoad = async ({ locals, platform, url }) => {
	if (!locals.user) redirect(302, buildClerkSignInUrl(url, platform?.env, '/me'));
	if (!platform?.env.DB) {
		return {
			user: locals.user,
			settings: emptyNotificationSettings
		};
	}

	const settings = await getNotificationSettings(platform.env.DB, locals.user.id);
	return {
		user: locals.user,
		settings
	};
};

export const actions: Actions = {
	saveSettings: async ({ request, locals, platform, url }) => {
		if (!locals.user) redirect(302, buildClerkSignInUrl(url, platform?.env, '/me'));
		if (!platform?.env.DB) return fail(503, { error: '数据连接暂时不可用' });

		const settings = settingsFromForm(await request.formData());
		const validationError = validateNotificationSettings(settings);
		if (validationError) return fail(400, { error: validationError, settings });

		await saveNotificationSettings(platform.env.DB, locals.user.id, settings);
		await syncCardUserToCrm(platform.env, locals.user.id, 'settings_saved');
		return { success: true, settings };
	},
	testNotification: async ({ request, locals, platform, url }) => {
		if (!locals.user) redirect(302, buildClerkSignInUrl(url, platform?.env, '/me'));

		const settings = settingsFromForm(await request.formData());
		const validationError = validateNotificationSettings(settings);
		if (validationError) return fail(400, { error: validationError, settings });

		const result = await sendTestNotification(settings);
		if (result.errors.length > 0 && result.sent.length === 0) {
			return fail(400, { error: result.errors.join('；'), settings });
		}

		return {
			testSuccess: result.sent.length > 0 ? `测试通知已发送：${result.sent.join('、')}` : '',
			testWarning: result.errors.join('；'),
			settings
		};
	},
	changePassword: async ({ request, locals, platform, url }) => {
		if (!locals.user) redirect(302, buildClerkSignInUrl(url, platform?.env, '/me'));
		if (!platform?.env.DB) return fail(503, { passwordError: '数据连接暂时不可用' });

		const formData = await request.formData();
		const currentPassword = String(formData.get('currentPassword') ?? '');
		const newPassword = String(formData.get('newPassword') ?? '');
		const confirmPassword = String(formData.get('confirmPassword') ?? '');

		if (newPassword.length < 6) return fail(400, { passwordError: '新密码至少需要 6 位' });
		if (newPassword !== confirmPassword) return fail(400, { passwordError: '两次输入的新密码不一致' });

		const drizzle = getDb(platform.env.DB);
		const rows = await drizzle.select().from(users).where(eq(users.id, locals.user.id)).limit(1);
		const user = rows[0];

		if (!user?.password_hash) {
			return fail(400, { passwordError: '当前账号使用 Clerk 登录，暂未设置本地密码。' });
		}

		if (!(await verifyPassword(currentPassword, user.password_hash))) {
			return fail(400, { passwordError: '当前密码不正确' });
		}

		await drizzle
			.update(users)
			.set({ password_hash: await hashPassword(newPassword) })
			.where(eq(users.id, locals.user.id));

		return { passwordSuccess: true };
	}
};
