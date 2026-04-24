import { error, fail, redirect } from '@sveltejs/kit';
import type { Actions, PageServerLoad } from './$types';
import {
	deleteUserCard,
	getUserCard,
	parseCardForm,
	updateUserCard
} from '$lib/cards/service';

export const load: PageServerLoad = async ({ locals, params, platform }) => {
	if (!locals.user) redirect(302, '/login');
	if (!platform?.env.DB) return { user: locals.user, catalog: [], card: null, configMissing: true };

	try {
		const userId = locals.user.id;
		const card = await getUserCard(platform.env.DB, userId, params.id);
		if (!card) error(404, '找不到这张卡片');

		return {
			user: locals.user,
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
		if (!locals.user) redirect(302, '/login');
		if (!platform?.env.DB) return fail(500, { error: '当前运行环境没有 D1 绑定' });

		try {
			const result = parseCardForm(await request.formData());
			if (result.error || !result.values) return fail(400, { error: result.error });

			const userId = locals.user.id;
			const existingCard = await getUserCard(platform.env.DB, userId, params.id);
			if (!existingCard) return fail(404, { error: '找不到这张卡片' });
			await updateUserCard(platform.env.DB, userId, params.id, {
				...result.values,
				catalogId: existingCard.catalog_id
			});
		} catch {
			return fail(500, { error: 'D1 数据库暂不可用，请检查 Cloudflare Pages Dev 或部署配置' });
		}

		redirect(303, '/dashboard');
	},
	delete: async ({ locals, params, platform }) => {
		if (!locals.user) redirect(302, '/login');
		if (!platform?.env.DB) return fail(500, { error: '当前运行环境没有 D1 绑定' });

		try {
			const userId = locals.user.id;
			await deleteUserCard(platform.env.DB, userId, params.id);
		} catch {
			return fail(500, { error: 'D1 数据库暂不可用，请检查 Cloudflare Pages Dev 或部署配置' });
		}

		redirect(303, '/dashboard');
	}
};
