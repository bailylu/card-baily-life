import type { Handle } from '@sveltejs/kit';
import { createClerkClient } from '@clerk/backend';
import { withClerkHandler } from 'svelte-clerk/server';
import { createD1LocalUserStore, resolveLocalUserFromClerkUser } from '$lib/auth/local-user-d1';
import { createLocalUser, resolveLocalUserFromEmail } from '$lib/auth/local-user';
import { getSessionCookie, getUserFromSession } from '$lib/auth/session';
import {
	buildBypassResponse,
	buildMobileGateClientScript,
	buildMobileGateResponse,
	decideMobileGate,
	MOBILE_GATE_ENABLED,
	MOBILE_GATE_PLACEHOLDER
} from '$lib/server/mobile-gate';

const securityHeaders = {
	'X-Content-Type-Options': 'nosniff',
	'Referrer-Policy': 'strict-origin-when-cross-origin',
	'X-Frame-Options': 'SAMEORIGIN',
	'Permissions-Policy': 'camera=(), microphone=(), geolocation=(), payment=(), usb=(), interest-cohort=()',
	'Cross-Origin-Opener-Policy': 'same-origin-allow-popups'
};

const LOCAL_MOCK_EMAIL_COOKIE = 'local_mock_email';

function getLocalMockEmail(event: Parameters<Handle>[0]['event']) {
	if (!['127.0.0.1', 'localhost'].includes(event.url.hostname)) return null;

	const requestedEmail = event.url.searchParams.get('mock_email')?.trim().toLowerCase();
	const email = requestedEmail ?? event.cookies.get(LOCAL_MOCK_EMAIL_COOKIE)?.trim().toLowerCase();
	if (!email || !/^\S+@\S+\.\S+$/.test(email)) return null;

	if (requestedEmail) {
		event.cookies.set(LOCAL_MOCK_EMAIL_COOKIE, email, {
			path: '/',
			httpOnly: true,
			secure: false,
			sameSite: 'lax',
			maxAge: 60 * 60 * 8
		});
	}

	return email;
}

function emailFromSessionClaims(auth: ReturnType<App.Locals['auth']> | null | undefined) {
	const claims = auth && 'sessionClaims' in auth ? auth.sessionClaims : null;
	if (!claims || typeof claims !== 'object') return null;

	const record = claims as Record<string, unknown>;
	const candidates = [
		record.email,
		record.email_address,
		record.primary_email_address,
		typeof record.email_addresses === 'string' ? record.email_addresses : null
	];

	for (const value of candidates) {
		if (typeof value === 'string' && value.includes('@')) return value;
	}
	return null;
}

// app.html 里的 %bls.mobilegate% 占位符：闸门开着就换成兜底脚本，关掉就抹掉。
function resolveWithMobileGateScript(
	event: Parameters<Handle>[0]['event'],
	resolve: Parameters<Handle>[0]['resolve']
) {
	const snippet = MOBILE_GATE_ENABLED ? buildMobileGateClientScript() : '';
	return resolve(event, {
		transformPageChunk: ({ html }) => html.replace(MOBILE_GATE_PLACEHOLDER, snippet)
	});
}

const loadLocalUser: Handle = async ({ event, resolve }) => {
	const localMockEmail = getLocalMockEmail(event);
	if (localMockEmail) {
		event.locals.user = event.platform?.env.DB
			? await resolveLocalUserFromEmail(createD1LocalUserStore(event.platform.env.DB), localMockEmail)
			: createLocalUser(localMockEmail, Math.floor(Date.now() / 1000));
		const response = await resolveWithMobileGateScript(event, resolve);
		for (const [name, value] of Object.entries(securityHeaders)) {
			response.headers.set(name, value);
		}
		return response;
	}

	const sessionId = getSessionCookie(event.cookies);
	const auth = event.locals.auth?.();
	const clerkUserId = auth && 'userId' in auth ? auth.userId : null;

	event.locals.user = null;

	if (clerkUserId && event.platform?.env.DB) {
		try {
			const secretKey = event.platform.env.CLERK_SECRET_KEY;
			const publishableKey = event.platform.env.PUBLIC_CLERK_PUBLISHABLE_KEY;
			let clerkUser: {
				id?: string | null;
				primaryEmailAddressId?: string | null;
				emailAddresses?: Array<{ id?: string | null; emailAddress?: string | null }> | null;
				privateMetadata?: unknown;
			} | null = null;

			if (secretKey) {
				const clerkClient = createClerkClient({ secretKey, publishableKey });
				clerkUser = await clerkClient.users.getUser(clerkUserId);
			}

			if (!clerkUser) {
				const claimEmail = emailFromSessionClaims(auth);
				if (claimEmail) {
					clerkUser = {
						id: clerkUserId,
						emailAddresses: [{ id: 'claim', emailAddress: claimEmail }],
						primaryEmailAddressId: 'claim'
					};
				}
			}

			if (clerkUser) {
				event.locals.user = await resolveLocalUserFromClerkUser(event.platform.env.DB, clerkUser);
			}
		} catch (error) {
			console.error('[auth] failed to resolve local user from Clerk', error);
			event.locals.user = null;
		}
	} else if (sessionId && event.platform?.env.DB) {
		try {
			event.locals.user = await getUserFromSession(event.platform.env.DB, sessionId);
		} catch (error) {
			console.error('[auth] failed to resolve local user from session', error);
			event.locals.user = null;
		}
	}

	const response = await resolveWithMobileGateScript(event, resolve);
	for (const [name, value] of Object.entries(securityHeaders)) {
		response.headers.set(name, value);
	}
	return response;
};

export const handle: Handle = async ({ event, resolve }) => {
	// 手机访问闸门放在最前面：命中就直接返回提示页，连 Clerk / D1 都不用走。
	const gate = decideMobileGate(event.request, event.url, event.request.headers.get('cookie'));
	if (gate.action === 'bypass') {
		return buildBypassResponse(event.url, gate.enabled, event.url.protocol === 'https:');
	}
	if (gate.action === 'block') {
		const response = buildMobileGateResponse(event.url);
		for (const [name, value] of Object.entries(securityHeaders)) {
			response.headers.set(name, value);
		}
		return response;
	}

	const clerkHandle = withClerkHandler({
		publishableKey: event.platform?.env.PUBLIC_CLERK_PUBLISHABLE_KEY,
		secretKey: event.platform?.env.CLERK_SECRET_KEY,
		signInUrl: '/sign-in',
		signUpUrl: '/sign-up'
	});

	return clerkHandle({
		event,
		resolve: (clerkEvent) => loadLocalUser({ event: clerkEvent, resolve })
	});
};
