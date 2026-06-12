<script lang="ts">
	import '../app.css';
	import { ClerkProvider } from 'svelte-clerk';
	import type { LayoutData } from './$types';
	let { children, data }: { children: import('svelte').Snippet; data: LayoutData } = $props();
</script>

<ClerkProvider publishableKey={data.clerkPublishableKey} signInUrl="/sign-in" signUpUrl="/sign-up" signInFallbackRedirectUrl="/dashboard" signUpFallbackRedirectUrl="/dashboard">
	{@render children()}
</ClerkProvider>
