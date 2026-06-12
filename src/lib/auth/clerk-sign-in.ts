const DEFAULT_CLERK_ACCOUNT_PORTAL_URL = 'https://accounts.baily.life';

export function buildClerkSignInUrl(
	requestUrl: URL,
	env?: App.Platform['env'],
	returnTo = '/dashboard'
) {
	const accountPortalUrl = env?.PUBLIC_CLERK_ACCOUNT_PORTAL_URL || DEFAULT_CLERK_ACCOUNT_PORTAL_URL;
	const configuredSignInUrl = env?.PUBLIC_CLERK_SIGN_IN_URL;
	const signInUrl =
		configuredSignInUrl && configuredSignInUrl !== '/login'
			? new URL(configuredSignInUrl, accountPortalUrl)
			: new URL('/sign-in', accountPortalUrl);
	const redirectUrl = /^https?:\/\//i.test(returnTo)
		? new URL(returnTo)
		: new URL(returnTo, requestUrl.origin);

	signInUrl.searchParams.set('redirect_url', redirectUrl.toString());
	return signInUrl.toString();
}
