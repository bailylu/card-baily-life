import { error } from '@sveltejs/kit';
import type { PageServerLoad } from './$types';
import { defaultFeaturedPromotions, listFeaturedPromotions } from '$lib/featured/promotions';

export const load: PageServerLoad = async ({ params, platform }) => {
	const promotions = platform?.env.DB
		? await listFeaturedPromotions(platform.env.DB, { includeDisabled: true })
		: defaultFeaturedPromotions;
	const promotion = promotions.find((item) => item.id === params.id);

	if (!promotion) {
		error(404, '推荐内容不存在');
	}

	return { promotion };
};
