import { fail, redirect } from '@sveltejs/kit';
import type { Actions, PageServerLoad } from './$types';
import { getDb } from '$lib/db/client';
import { card_requests } from '$lib/db/schema';
import {
	createUserCard,
	listCatalog,
	parseCardForm
} from '$lib/cards/service';
import { notifyAdminCardRequest } from '$lib/notifications/admin';
import { getNotificationSettings } from '$lib/notifications/settings';

function hasNotificationChannel(settings: Awaited<ReturnType<typeof getNotificationSettings>>) {
	return Boolean(
		settings.barkKey ||
			settings.pushPlusToken ||
			(settings.telegramBotToken && settings.telegramChatId)
	);
}

export const load: PageServerLoad = async ({ locals, platform }) => {
	if (!locals.user) redirect(302, '/login');
	if (!platform?.env.DB) return { user: locals.user, catalog: [], configMissing: true, hasNotificationChannel: false };

	try {
		const settings = await getNotificationSettings(platform.env.DB, locals.user.id);
		return {
			user: locals.user,
			catalog: await listCatalog(platform.env.DB),
			configMissing: false,
			hasNotificationChannel: hasNotificationChannel(settings)
		};
	} catch {
		return { user: locals.user, catalog: [], configMissing: true, hasNotificationChannel: false };
	}
};

export const actions: Actions = {
	addCard: async ({ request, locals, platform }) => {
		if (!locals.user) redirect(302, '/login');
		if (!platform?.env.DB) return fail(500, { error: '当前运行环境没有 D1 绑定' });

		try {
			const result = parseCardForm(await request.formData());
			if (result.error || !result.values) return fail(400, { error: result.error });

			const userId = locals.user.id;
			await createUserCard(platform.env.DB, userId, result.values);
		} catch {
			return fail(500, { error: 'D1 数据库暂不可用，请检查 Cloudflare Pages Dev 或部署配置' });
		}

		redirect(303, '/dashboard');
	},
	requestCard: async ({ request, locals, platform }) => {
		if (!locals.user) redirect(302, '/login');
		if (!platform?.env.DB) return fail(500, { requestError: '当前运行环境没有 D1 绑定' });

		const formData = await request.formData();
		const bankName = String(formData.get('request_bank_name') ?? '').trim();
		const cardName = String(formData.get('request_card_name') ?? '').trim();
		const cardTier = String(formData.get('request_card_tier') ?? '').trim();
		const notes = String(formData.get('request_notes') ?? '').trim();

		if (!bankName || !cardName) {
			return fail(400, {
				requestError: '请填写银行名称和卡片名称',
				requestValues: { bankName, cardName, cardTier, notes }
			});
		}

			try {
				await getDb(platform.env.DB).insert(card_requests).values({
					id: crypto.randomUUID(),
					user_id: locals.user.id,
				bank_name: bankName,
				card_name: cardName,
				card_tier: cardTier || null,
				notes: notes || null,
					status: 'pending',
					created_at: Math.floor(Date.now() / 1000)
				});

				notifyAdminCardRequest(platform.env, {
					userEmail: locals.user.email,
					bankName,
					cardName,
					cardTier,
					notes
				}).catch((error) => {
					console.warn('Failed to send admin card request notification', error);
				});
			} catch {
				return fail(500, { requestError: '提交失败，请稍后再试' });
			}

		return { requestSuccess: true };
	}
};
