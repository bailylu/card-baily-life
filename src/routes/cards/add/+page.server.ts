import { fail, redirect } from '@sveltejs/kit';
import type { Actions, PageServerLoad } from './$types';
import {
	createUserCard,
	ensureCurrentUserId,
	listCatalog,
	parseCardForm
} from '$lib/cards/service';

export const load: PageServerLoad = async ({ locals, platform }) => {
	if (!platform?.env.DB) return { user: locals.user, catalog: [], configMissing: true };

	try {
		return {
			user: locals.user,
			catalog: await listCatalog(platform.env.DB),
			configMissing: false
		};
	} catch {
		return { user: locals.user, catalog: [], configMissing: true };
	}
};

export const actions: Actions = {
	default: async ({ request, locals, platform }) => {
		if (!platform?.env.DB) return fail(500, { error: '当前运行环境没有 D1 绑定' });

		try {
			const result = parseCardForm(await request.formData());
			if (result.error || !result.values) return fail(400, { error: result.error });

			const userId = await ensureCurrentUserId(platform.env.DB, locals.user?.id);
			await createUserCard(platform.env.DB, userId, result.values);
		} catch {
			return fail(500, { error: 'D1 数据库暂不可用，请检查 Cloudflare Pages Dev 或部署配置' });
		}

		redirect(303, '/dashboard');
	}
};
