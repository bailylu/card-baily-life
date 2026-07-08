import type { Handle } from '@sveltejs/kit';
import { createClerkClient } from '@clerk/backend';
import { withClerkHandler } from 'svelte-clerk/server';
import { resolveLocalUserFromClerkUser } from '$lib/auth/local-user-d1';
import { getSessionCookie, getUserFromSession } from '$lib/auth/session';

const securityHeaders = {
	'X-Content-Type-Options': 'nosniff',
	'Referrer-Policy': 'strict-origin-when-cross-origin',
	'X-Frame-Options': 'SAMEORIGIN',
	'Permissions-Policy': 'camera=(), microphone=(), geolocation=(), payment=(), usb=(), interest-cohort=()',
	'Cross-Origin-Opener-Policy': 'same-origin-allow-popups'
};

const loadLocalUser: Handle = async ({ event, resolve }) => {
	const sessionId = getSessionCookie(event.cookies);
	const auth = event.locals.auth?.();
	const clerkUserId = auth && 'userId' in auth ? auth.userId : null;

	if (clerkUserId && event.platform?.env.DB) {
		const clerkClient = createClerkClient({
			secretKey: event.platform.env.CLERK_SECRET_KEY,
			publishableKey: event.platform.env.PUBLIC_CLERK_PUBLISHABLE_KEY
		});
		const clerkUser = await clerkClient.users.getUser(clerkUserId);
		event.locals.user = await resolveLocalUserFromClerkUser(event.platform.env.DB, clerkUser);
	} else if (sessionId && event.platform?.env.DB) {
		event.locals.user = await getUserFromSession(event.platform.env.DB, sessionId);
	} else {
		event.locals.user = null;
	}
	const response = await resolve(event);
	for (const [name, value] of Object.entries(securityHeaders)) {
		response.headers.set(name, value);
	}
	return response;
};

export const handle: Handle = async ({ event, resolve }) => {
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
