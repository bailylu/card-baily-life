import { redirect } from '@sveltejs/kit';
import type { RequestHandler } from './$types';
import { verifyMagicToken } from '$lib/auth/magic-link';
import { createSession, setSessionCookie } from '$lib/auth/session';

export const GET: RequestHandler = async ({ url, platform, cookies }) => {
	const token = url.searchParams.get('token') ?? '';
	const db = platform!.env.DB;
	const secureCookie = url.protocol === 'https:';

	const result = await verifyMagicToken(db, token);
	if (!result) {
		redirect(302, '/login?error=invalid');
	}

	const sessionId = await createSession(db, result.userId);
	setSessionCookie(cookies, sessionId, secureCookie);
	redirect(302, '/dashboard');
};
