import type { LayoutServerLoad } from './$types';
import { buildClerkProps } from 'svelte-clerk/server';

export const load: LayoutServerLoad = ({ locals, platform, url, cookies }) => {
	const localMock =
		['127.0.0.1', 'localhost'].includes(url.hostname) &&
		Boolean(url.searchParams.get('mock_email') || cookies.get('local_mock_email'));

	return {
		...buildClerkProps(locals.auth()),
		clerkPublishableKey: localMock ? '' : (platform?.env.PUBLIC_CLERK_PUBLISHABLE_KEY ?? ''),
		localMock
	};
};
