import { redirect } from '@sveltejs/kit';
import type { PageServerLoad } from './$types';
import { buildReminderPreview, listUserCards } from '$lib/cards/service';
import { buildClerkSignInUrl } from '$lib/auth/clerk-sign-in';

export const load: PageServerLoad = async ({ locals, platform, url }) => {
	if (!locals.user) redirect(302, buildClerkSignInUrl(url, platform?.env, '/reminders'));

	if (!platform?.env.DB) {
		return { reminders: [], configMissing: true };
	}

	const cards = await listUserCards(platform.env.DB, locals.user.id);
	return {
		reminders: buildReminderPreview(cards),
		configMissing: false
	};
};
