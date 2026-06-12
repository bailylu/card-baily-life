import { redirect } from '@sveltejs/kit';
import type { PageServerLoad } from './$types';
import { buildReminderPreview, listUserCards } from '$lib/cards/service';
import { isAdmin } from '$lib/admin/access';
import { defaultFeaturedPromotions, listFeaturedPromotions } from '$lib/featured/promotions';
import { buildClerkSignInUrl } from '$lib/auth/clerk-sign-in';

function timeout<T>(ms: number): Promise<T> {
	return new Promise((_, reject) => {
		setTimeout(() => reject(new Error('D1 query timeout')), ms);
	});
}

function emptyDashboard(user: App.Locals['user'], admin: boolean) {
	return {
		user,
		cards: [],
		reminders: [],
		featuredCards: defaultFeaturedPromotions,
		configMissing: true,
		isAdmin: admin
	};
}

export const load: PageServerLoad = async ({ locals, platform, url }) => {
	if (!locals.user) redirect(302, buildClerkSignInUrl(url, platform?.env, '/dashboard'));

	const admin = isAdmin(locals.user, platform?.env);

	if (!platform?.env.DB) {
		return emptyDashboard(locals.user, admin);
	}

	try {
		const userId = locals.user.id;
		const cards = await Promise.race([
			(async () => {
				return listUserCards(platform.env.DB, userId);
			})(),
			timeout<Awaited<ReturnType<typeof listUserCards>>>(2500)
		]);
		const featuredCards = await Promise.race([
			listFeaturedPromotions(platform.env.DB),
			timeout<Awaited<ReturnType<typeof listFeaturedPromotions>>>(2500)
		]).catch(() => defaultFeaturedPromotions);

		return {
			user: locals.user,
			cards,
			reminders: buildReminderPreview(cards),
			featuredCards,
			configMissing: false,
			isAdmin: admin
		};
	} catch {
		return emptyDashboard(locals.user, admin);
	}
};
