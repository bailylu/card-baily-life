import { fail, redirect } from '@sveltejs/kit';
import type { Actions, PageServerLoad } from './$types';
import { getDb } from '$lib/db/client';
import { notification_preferences } from '$lib/db/schema';
import { buildClerkSignInUrl } from '$lib/auth/clerk-sign-in';
import {
	emptyNotificationSettings,
	getNotificationSettings,
	type NotificationSettings
} from '$lib/notifications/settings';

const TEST_TITLE = '贝利卡管家测试通知';
const TEST_CONTENT = '这是一条即时测试通知，点击测试后会立即发送。正式的账单日、还款日和年费日提醒默认会在当天中午 12:00 发送。';

type UnifiedNotificationSettings = NotificationSettings & {
	feishuWebhook: string;
	dingtalkWebhook: string;
	source: 'clerk' | 'local';
};

const emptyUnifiedNotificationSettings: UnifiedNotificationSettings = {
	...emptyNotificationSettings,
	feishuWebhook: '',
	dingtalkWebhook: '',
	source: 'local'
};

function withUnifiedDefaults(
	settings: NotificationSettings,
	extra: Partial<Pick<UnifiedNotificationSettings, 'feishuWebhook' | 'dingtalkWebhook' | 'source'>> = {}
): UnifiedNotificationSettings {
	return {
		...settings,
		feishuWebhook: extra.feishuWebhook ?? '',
		dingtalkWebhook: extra.dingtalkWebhook ?? '',
		source: extra.source ?? 'local'
	};
}

function getClerkUserId(locals: App.Locals) {
	const auth = locals.auth?.();
	return auth && 'userId' in auth ? auth.userId : null;
}

function asObject(value: unknown) {
	return value && typeof value === 'object' ? (value as Record<string, unknown>) : {};
}

function asText(value: unknown) {
	return typeof value === 'string' ? value.trim() : '';
}

function channelIsEnabled(channel: Record<string, unknown>, requiredSecret: boolean) {
	if (!requiredSecret) return false;
	return channel.on !== false;
}

async function readClerkPrivateMetadata(env: App.Platform['env'], clerkUserId: string) {
	if (!env.CLERK_SECRET_KEY) return null;

	const response = await fetch(`https://api.clerk.com/v1/users/${encodeURIComponent(clerkUserId)}`, {
		headers: { authorization: `Bearer ${env.CLERK_SECRET_KEY}` }
	});
	if (!response.ok) return null;

	const clerkUser = await response.json().catch(() => null);
	return asObject(asObject(clerkUser).private_metadata);
}

async function getUnifiedNotificationSettings(
	db: D1Database,
	userId: string,
	env: App.Platform['env'],
	clerkUserId: string | null
): Promise<UnifiedNotificationSettings> {
	const localSettings = await getNotificationSettings(db, userId);
	if (!clerkUserId) return withUnifiedDefaults(localSettings);

	const privateMetadata = await readClerkPrivateMetadata(env, clerkUserId);
	const notify = asObject(privateMetadata?.notify);
	if (Object.keys(notify).length === 0) return withUnifiedDefaults(localSettings);

	const bark = asObject(notify.bark);
	const pushplus = asObject(notify.pushplus);
	const telegram = asObject(notify.telegram);
	const feishu = asObject(notify.feishu);
	const dingtalk = asObject(notify.dingtalk);

	const barkKey = asText(bark.key);
	const pushPlusToken = asText(pushplus.token);
	const telegramBotToken = asText(telegram.botToken);
	const telegramChatId = asText(telegram.chatId);
	const feishuWebhook = asText(feishu.webhook);
	const dingtalkWebhook = asText(dingtalk.webhook);
	const telegramReady = Boolean(telegramBotToken && telegramChatId);

	return {
		...localSettings,
		barkKey: channelIsEnabled(bark, Boolean(barkKey)) ? barkKey : '',
		pushPlusToken: channelIsEnabled(pushplus, Boolean(pushPlusToken)) ? pushPlusToken : '',
		telegramBotToken: channelIsEnabled(telegram, telegramReady) ? telegramBotToken : '',
		telegramChatId: channelIsEnabled(telegram, telegramReady) ? telegramChatId : '',
		feishuWebhook: channelIsEnabled(feishu, Boolean(feishuWebhook)) ? feishuWebhook : '',
		dingtalkWebhook: channelIsEnabled(dingtalk, Boolean(dingtalkWebhook)) ? dingtalkWebhook : '',
		source: 'clerk'
	};
}

function validateNotificationSettings(settings: UnifiedNotificationSettings) {
	if ((settings.telegramBotToken && !settings.telegramChatId) || (!settings.telegramBotToken && settings.telegramChatId)) {
		return 'Telegram Bot Token 和 Chat ID 需要一起填写';
	}

	return '';
}

function buildNotificationStatus(settings: UnifiedNotificationSettings) {
	const channels = [
		{ id: 'bark', name: 'Bark', configured: Boolean(settings.barkKey) },
		{ id: 'pushplus', name: 'PushPlus', configured: Boolean(settings.pushPlusToken) },
		{
			id: 'telegram',
			name: 'Telegram',
			configured: Boolean(settings.telegramBotToken && settings.telegramChatId)
		},
		{ id: 'feishu', name: '飞书', configured: Boolean(settings.feishuWebhook) },
		{ id: 'dingtalk', name: '钉钉', configured: Boolean(settings.dingtalkWebhook) }
	];

	const enabled = channels.filter((channel) => channel.configured).map((channel) => channel.name);
	const disabled = channels.filter((channel) => !channel.configured).map((channel) => channel.name);

	return {
		configured: enabled.length > 0,
		enabled,
		disabled,
		source: settings.source
	};
}

function buildNotificationPreferences(settings: NotificationSettings) {
	return {
		statementEnabled: settings.statementEnabled,
		dueEnabled: settings.dueEnabled,
		annualFeeEnabled: settings.annualFeeEnabled,
		offerEnabled: settings.offerEnabled
	};
}

function preferencesFromForm(formData: FormData) {
	const enabled = (name: string) => formData.getAll(name).includes('1');
	return {
		statementEnabled: enabled('statementEnabled'),
		dueEnabled: enabled('dueEnabled'),
		annualFeeEnabled: enabled('annualFeeEnabled'),
		offerEnabled: enabled('offerEnabled')
	};
}

async function saveNotificationPreferences(
	db: D1Database,
	userId: string,
	preferences: ReturnType<typeof preferencesFromForm>
) {
	const drizzle = getDb(db);
	const now = Math.floor(Date.now() / 1000);
	await drizzle
		.insert(notification_preferences)
		.values({
			user_id: userId,
			statement_enabled: preferences.statementEnabled ? 1 : 0,
			due_enabled: preferences.dueEnabled ? 1 : 0,
			annual_fee_enabled: preferences.annualFeeEnabled ? 1 : 0,
			offer_enabled: preferences.offerEnabled ? 1 : 0,
			updated_at: now
		})
		.onConflictDoUpdate({
			target: notification_preferences.user_id,
			set: {
				statement_enabled: preferences.statementEnabled ? 1 : 0,
				due_enabled: preferences.dueEnabled ? 1 : 0,
				annual_fee_enabled: preferences.annualFeeEnabled ? 1 : 0,
				offer_enabled: preferences.offerEnabled ? 1 : 0,
				updated_at: now
			}
		});
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

async function sendFeishuTest(webhook: string) {
	const response = await fetch(webhook, {
		method: 'POST',
		headers: { 'content-type': 'application/json' },
		body: JSON.stringify({
			msg_type: 'text',
			content: { text: `${TEST_TITLE}\n\n${TEST_CONTENT}` }
		})
	});

	const result = (await response.json().catch(() => null)) as {
		code?: number;
		msg?: string;
		StatusCode?: number;
		StatusMessage?: string;
	} | null;
	const codeFailed = typeof result?.code === 'number' && result.code !== 0;
	const statusFailed = typeof result?.StatusCode === 'number' && result.StatusCode !== 0;
	if (!response.ok || codeFailed || statusFailed) {
		throw new Error(result?.msg || result?.StatusMessage || '飞书推送失败，请检查 Webhook');
	}
}

async function sendDingTalkTest(webhook: string) {
	const response = await fetch(webhook, {
		method: 'POST',
		headers: { 'content-type': 'application/json' },
		body: JSON.stringify({
			msgtype: 'text',
			text: { content: `${TEST_TITLE}\n\n${TEST_CONTENT}` }
		})
	});

	const result = (await response.json().catch(() => null)) as { errcode?: number; errmsg?: string } | null;
	if (!response.ok || (typeof result?.errcode === 'number' && result.errcode !== 0)) {
		throw new Error(result?.errmsg ? `钉钉推送失败：${result.errmsg}` : '钉钉推送失败，请检查 Webhook');
	}
}

async function sendTestNotification(settings: UnifiedNotificationSettings) {
	const tasks: Array<[string, () => Promise<void>]> = [];
	if (settings.barkKey) tasks.push(['Bark', () => sendBarkTest(settings.barkKey)]);
	if (settings.pushPlusToken) tasks.push(['PushPlus', () => sendPushPlusTest(settings.pushPlusToken)]);
	if (settings.telegramBotToken && settings.telegramChatId) {
		tasks.push(['Telegram', () => sendTelegramTest(settings.telegramBotToken, settings.telegramChatId)]);
	}
	if (settings.feishuWebhook) tasks.push(['飞书', () => sendFeishuTest(settings.feishuWebhook)]);
	if (settings.dingtalkWebhook) tasks.push(['钉钉', () => sendDingTalkTest(settings.dingtalkWebhook)]);

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
			notificationStatus: buildNotificationStatus(emptyUnifiedNotificationSettings),
			notificationPreferences: buildNotificationPreferences(emptyNotificationSettings)
		};
	}

	const settings = await getUnifiedNotificationSettings(
		platform.env.DB,
		locals.user.id,
		platform.env,
		getClerkUserId(locals)
	);
	return {
		user: locals.user,
		notificationStatus: buildNotificationStatus(settings),
		notificationPreferences: buildNotificationPreferences(settings)
	};
};

export const actions: Actions = {
	savePreferences: async ({ request, locals, platform, url }) => {
		if (!locals.user) redirect(302, buildClerkSignInUrl(url, platform?.env, '/me'));
		if (!platform?.env.DB) return fail(503, { error: '数据连接暂时不可用' });

		const notificationPreferences = preferencesFromForm(await request.formData());
		await saveNotificationPreferences(platform.env.DB, locals.user.id, notificationPreferences);

		return { preferencesSuccess: true, notificationPreferences };
	},
	testNotification: async ({ locals, platform, url }) => {
		if (!locals.user) redirect(302, buildClerkSignInUrl(url, platform?.env, '/me'));
		if (!platform?.env.DB) return fail(503, { error: '数据连接暂时不可用' });

		const settings = await getUnifiedNotificationSettings(
			platform.env.DB,
			locals.user.id,
			platform.env,
			getClerkUserId(locals)
		);
		const validationError = validateNotificationSettings(settings);
		if (validationError) return fail(400, { error: validationError });

		const result = await sendTestNotification(settings);
		if (result.errors.length > 0 && result.sent.length === 0) {
			return fail(400, { error: result.errors.join('；') });
		}

		return {
			testSuccess: result.sent.length > 0 ? `测试通知已发送：${result.sent.join('、')}` : '',
			testWarning: result.errors.join('；')
		};
	}
};
