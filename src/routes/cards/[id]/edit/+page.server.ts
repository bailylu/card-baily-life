import { error, fail, redirect } from '@sveltejs/kit';
import type { Actions, PageServerLoad } from './$types';
import {
	deleteUserCard,
	ensureCurrentUserId,
	getUserCard,
	listCatalog,
	parseCardForm,
	updateUserCard
} from '$lib/cards/service';

export const load: PageServerLoad = async ({ locals, params, platform }) => {
	if (!platform?.env.DB) return { user: locals.user, catalog: [], card: null, configMissing: true };

	try {
		const userId = await ensureCurrentUserId(platform.env.DB, locals.user?.id);
		const card = await getUserCard(platform.env.DB, userId, params.id);
		if (!card) error(404, '找不到这张卡片');

		return {
			user: locals.user,
			catalog: await listCatalog(platform.env.DB),
			card,
			configMissing: false
		};
	} catch (caught) {
		if (caught && typeof caught === 'object' && 'status' in caught) throw caught;
		return { user: locals.user, catalog: [], card: null, configMissing: true };
	}
};

export const actions: Actions = {
	save: async ({ request, locals, params, platform }) => {
		if (!platform?.env.DB) return fail(500, { error: '当前运行环境没有 D1 绑定' });

		try {
			const result = parseCardForm(await request.formData());
			if (result.error || !result.values) return fail(400, { error: result.error });

			const userId = await ensureCurrentUserId(platform.env.DB, locals.user?.id);
			await updateUserCard(platform.env.DB, userId, params.id, result.values);
		} catch {
			return fail(500, { error: 'D1 数据库暂不可用，请检查 Cloudflare Pages Dev 或部署配置' });
		}

		redirect(303, '/dashboard');
	},
	delete: async ({ locals, params, platform }) => {
		if (!platform?.env.DB) return fail(500, { error: '当前运行环境没有 D1 绑定' });

		try {
			const userId = await ensureCurrentUserId(platform.env.DB, locals.user?.id);
			await deleteUserCard(platform.env.DB, userId, params.id);
		} catch {
			return fail(500, { error: 'D1 数据库暂不可用，请检查 Cloudflare Pages Dev 或部署配置' });
		}

		redirect(303, '/dashboard');
	}
};
