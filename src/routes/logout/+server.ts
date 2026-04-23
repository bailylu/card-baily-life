import { redirect } from '@sveltejs/kit';
import type { RequestHandler } from './$types';
import { getSessionCookie, deleteSession, clearSessionCookie } from '$lib/auth/session';

export const POST: RequestHandler = async ({ cookies, platform }) => {
	const sessionId = getSessionCookie(cookies);
	if (sessionId && platform?.env.DB) {
		await deleteSession(platform.env.DB, sessionId);
	}
	clearSessionCookie(cookies);
	redirect(302, '/');
};
