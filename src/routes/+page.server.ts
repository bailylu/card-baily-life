import type { PageServerLoad } from './$types';
import { buildClerkSignInUrl } from '$lib/auth/clerk-sign-in';

export const load: PageServerLoad = async ({ locals, platform, url }) => {
	return {
		user: locals.user,
		clerkSignInUrl: buildClerkSignInUrl(url, platform?.env)
	};
};
