import type { LayoutServerLoad } from './$types';
import { buildClerkProps } from 'svelte-clerk/server';

export const load: LayoutServerLoad = ({ locals, platform }) => {
	return {
		...buildClerkProps(locals.auth()),
		clerkPublishableKey: platform?.env.PUBLIC_CLERK_PUBLISHABLE_KEY ?? ''
	};
};
