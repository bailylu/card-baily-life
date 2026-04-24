import { redirect } from '@sveltejs/kit';
import type { PageServerLoad } from './$types';
import { buildReminderPreview, listUserCards } from '$lib/cards/service';

function timeout<T>(ms: number): Promise<T> {
	return new Promise((_, reject) => {
		setTimeout(() => reject(new Error('D1 query timeout')), ms);
	});
}

function emptyDashboard(user: App.Locals['user']) {
	return { user, cards: [], reminders: [], configMissing: true };
}

export const load: PageServerLoad = async ({ locals, platform }) => {
	if (!locals.user) redirect(302, '/login');

	if (!platform?.env.DB) {
		return emptyDashboard(locals.user);
	}

	try {
		const userId = locals.user.id;
		const cards = await Promise.race([
			(async () => {
				return listUserCards(platform.env.DB, userId);
			})(),
			timeout<Awaited<ReturnType<typeof listUserCards>>>(2500)
		]);

		return {
			user: locals.user,
			cards,
			reminders: buildReminderPreview(cards),
			configMissing: false
		};
	} catch {
		return emptyDashboard(locals.user);
	}
};
