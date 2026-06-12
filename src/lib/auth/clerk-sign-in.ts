export function buildClerkSignInUrl(
	requestUrl: URL,
	env?: App.Platform['env'],
	returnTo = '/dashboard'
) {
	const configuredSignInUrl =
		env?.PUBLIC_CLERK_SIGN_IN_URL && env.PUBLIC_CLERK_SIGN_IN_URL !== '/login'
			? env.PUBLIC_CLERK_SIGN_IN_URL
			: '/sign-in';
	const signInUrl = new URL(configuredSignInUrl, requestUrl.origin);
	const redirectUrl = /^https?:\/\//i.test(returnTo)
		? new URL(returnTo)
		: new URL(returnTo, requestUrl.origin);

	signInUrl.searchParams.set('redirect_url', redirectUrl.toString());
	return signInUrl.toString();
}
