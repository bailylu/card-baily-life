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

	// 与 app.css 的 --bls-* 设计变量保持一致，让 Clerk 组件融入全站深色风格。
	// elements 里把 Clerk 自带的卡片壳去掉（避免「卡中卡」），按钮与输入框按全站设计重绘。
	const clerkAppearance = {
		variables: {
			colorPrimary: '#e8b53d',
			colorBackground: '#121829',
			colorInputBackground: '#0c111e',
			colorText: '#ecf1fb',
			colorTextSecondary: '#828fab',
			colorInputText: '#ecf1fb',
			colorNeutral: '#c2cce0',
			colorDanger: '#ff5a5a',
			colorSuccess: '#4df08a',
			borderRadius: '8px'
		},
		elements: {
			rootBox: { width: '100%' },
			cardBox: { width: '100%', background: 'transparent', border: '0', boxShadow: 'none' },
			card: { background: 'transparent', border: '0', boxShadow: 'none', padding: '0' },
			headerTitle: { fontWeight: '900', fontSize: '1.3rem', letterSpacing: '0.01em' },
			headerSubtitle: { color: '#828fab', fontSize: '0.85rem' },
			socialButtonsBlockButton: {
				background: 'rgba(255, 255, 255, 0.05)',
				border: '2px solid rgba(150, 170, 210, 0.22)',
				borderRadius: '8px',
				minHeight: '2.8rem',
				fontWeight: '700'
			},
			dividerLine: { background: 'rgba(150, 170, 210, 0.22)' },
			dividerText: { color: '#828fab' },
			formFieldLabel: { fontWeight: '700', color: '#c2cce0' },
			formFieldInput: {
				background: '#0c111e',
				border: '2px solid rgba(150, 170, 210, 0.22)',
				borderRadius: '8px',
				minHeight: '2.75rem',
				color: '#ecf1fb'
			},
			formButtonPrimary: {
				background: 'linear-gradient(180deg, #ffda7b, #e8b53d)',
				color: '#0a0e18',
				fontWeight: '900',
				fontSize: '0.95rem',
				minHeight: '2.9rem',
				borderRadius: '8px',
				border: '0',
				boxShadow: '0 0 0 1px #e8b53d, 0 0 14px rgba(232, 181, 61, 0.35)',
				textTransform: 'none'
			},
			footer: { background: 'transparent' },
			footerActionLink: { color: '#2fe6d4', fontWeight: '700' }
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
		appearance={clerkAppearance}
	>
		{@render appContent()}
	</ClerkProvider>
{/if}
