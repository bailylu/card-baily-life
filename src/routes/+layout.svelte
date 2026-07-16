<script lang="ts">
	import '../app.css';
	import { onMount } from 'svelte';
	import { zhCN } from '@clerk/localizations';
	import { ClerkProvider } from 'svelte-clerk';
	import PwaInstall from '$lib/components/PwaInstall.svelte';
	import { registerServiceWorker } from '$lib/pwa';
	import type { LayoutData } from './$types';

	let { children, data }: { children: import('svelte').Snippet; data: LayoutData } = $props();

	const clerkLocalization = {
		...zhCN,
		// Clerk dashboard 应用名是 "Baily's blog"，这里统一显示产品名
		signIn: {
			...zhCN.signIn,
			start: {
				...zhCN.signIn?.start,
				title: '登录贝利卡管家',
				titleCombined: '登录或注册贝利卡管家',
				subtitle: '欢迎回来，登录后继续管理卡片和提醒。',
				subtitleCombined: '未注册的邮箱会自动注册。',
				actionText: '还没有账号？',
				actionLink: '注册'
			}
		},
		signUp: {
			...zhCN.signUp,
			start: {
				...zhCN.signUp?.start,
				title: '注册贝利卡管家',
				titleCombined: '登录或注册贝利卡管家',
				subtitle: '创建账号后即可管理账单日、还款日和年费提醒。',
				subtitleCombined: '未注册的邮箱会自动注册。',
				actionText: '已经有账号了？',
				actionLink: '登录'
			}
		}
	};

	onMount(() => {
		registerServiceWorker();
	});
</script>

<svelte:head>
	<link rel="manifest" href="/manifest.webmanifest" />
	<meta name="theme-color" content="#0a0e18" />
</svelte:head>

{#snippet appContent()}
	{@render children()}
	<PwaInstall />
{/snippet}

{#if data.localMock}
	{@render appContent()}
{:else}
	<ClerkProvider
		publishableKey={data.clerkPublishableKey}
		signInUrl="/sign-in"
		signUpUrl="/sign-up"
		signInFallbackRedirectUrl="/dashboard"
		signUpFallbackRedirectUrl="/dashboard"
		signInForceRedirectUrl="/dashboard"
		signUpForceRedirectUrl="/dashboard"
		localization={clerkLocalization as never}
	>
		{@render appContent()}
	</ClerkProvider>
{/if}
