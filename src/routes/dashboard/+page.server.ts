import type { PageServerLoad } from './$types';
import {
	buildReminderPreview,
	ensureCurrentUserId,
	getDemoDashboardCards,
	listUserCards
} from '$lib/cards/service';

function timeout<T>(ms: number): Promise<T> {
	return new Promise((_, reject) => {
		setTimeout(() => reject(new Error('D1 query timeout')), ms);
	});
}

function demoDashboard(user: App.Locals['user']) {
	const cards = getDemoDashboardCards();
	return { user, cards, reminders: buildReminderPreview(cards), configMissing: true };
}

export const load: PageServerLoad = async ({ locals, platform }) => {
	if (!platform?.env.DB) {
		return demoDashboard(locals.user);
	}

	try {
		const cards = await Promise.race([
			(async () => {
				const userId = await ensureCurrentUserId(platform.env.DB, locals.user?.id);
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
		return demoDashboard(locals.user);
	}
};
