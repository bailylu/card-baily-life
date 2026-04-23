import type { Handle } from '@sveltejs/kit';
import { getSessionCookie, getUserFromSession } from '$lib/auth/session';

export const handle: Handle = async ({ event, resolve }) => {
	const sessionId = getSessionCookie(event.cookies);
	if (sessionId && event.platform?.env.DB) {
		event.locals.user = await getUserFromSession(event.platform.env.DB, sessionId);
	} else {
		event.locals.user = null;
	}
	return resolve(event);
};
