import { redirect } from '@sveltejs/kit';
import type { RequestHandler } from './$types';
import { getSessionCookie, deleteSession, clearSessionCookie } from '$lib/auth/session';

function clearClerkCookies(cookies: Parameters<RequestHandler>[0]['cookies'], secure: boolean) {
	const names = cookies.getAll().map((cookie) => cookie.name);
	for (const name of names) {
		if (
			name === '__session' ||
			name.startsWith('__session_') ||
			name === '__client_uat' ||
			name.startsWith('__client_uat') ||
			name.startsWith('__clerk') ||
			name.startsWith('clerk_')
		) {
			cookies.delete(name, { path: '/', secure, sameSite: 'lax' });
		}
	}
}

async function performLogout({ cookies, platform, url }: Pick<Parameters<RequestHandler>[0], 'cookies' | 'platform' | 'url'>) {
	const sessionId = getSessionCookie(cookies);
	const secureCookie = url.protocol === 'https:';
	if (sessionId && platform?.env.DB) {
		await deleteSession(platform.env.DB, sessionId);
	}
	clearSessionCookie(cookies, secureCookie);
	// Best-effort browser cookie clear; Clerk client signOut still revokes the session.
	clearClerkCookies(cookies, secureCookie);
	// 本地开发的 mock 登录 cookie（仅 localhost 存在）
	cookies.delete('local_mock_email', { path: '/', secure: secureCookie, sameSite: 'lax' });
}

export const POST: RequestHandler = async ({ cookies, platform, url, request }) => {
	await performLogout({ cookies, platform, url });

	if (request.headers.get('accept')?.includes('application/json')) {
		return new Response(null, { status: 204 });
	}

	redirect(302, '/');
};

export const GET: RequestHandler = async ({ cookies, platform, url }) => {
	await performLogout({ cookies, platform, url });
	redirect(302, '/');
};
