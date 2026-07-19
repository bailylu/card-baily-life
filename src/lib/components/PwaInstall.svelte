<script lang="ts">
	import { browser } from '$app/environment';
	import { onMount } from 'svelte';

	type BeforeInstallPromptEvent = Event & {
		prompt: () => Promise<void>;
		userChoice: Promise<{ outcome: 'accepted' | 'dismissed' }>;
	};

	let deferred: BeforeInstallPromptEvent | null = $state(null);
	let visible = $state(false);
	let isStandalone = $state(false);
	let isIos = $state(false);
	let dismissed = $state(false);

	const DISMISS_KEY = 'bls-pwa-install-dismissed';

	function checkStandalone() {
		if (!browser) return false;
		const mq = window.matchMedia('(display-mode: standalone)').matches;
		const ios = Boolean((navigator as Navigator & { standalone?: boolean }).standalone);
		return mq || ios;
	}

	onMount(() => {
		if (!browser) return;

		isStandalone = checkStandalone();
		isIos = /iphone|ipad|ipod/i.test(navigator.userAgent);
		dismissed = localStorage.getItem(DISMISS_KEY) === '1';

		// 桌面端不展示安装引导，只在移动端提示
		if (window.matchMedia('(min-width: 768px)').matches) return;

		if (isStandalone || dismissed) return;

		const onBip = (e: Event) => {
			e.preventDefault();
			deferred = e as BeforeInstallPromptEvent;
			visible = true;
		};

		window.addEventListener('beforeinstallprompt', onBip);

		// iOS 没有 beforeinstallprompt，延迟展示引导
		if (isIos && !isStandalone) {
			const t = setTimeout(() => {
				if (!checkStandalone() && localStorage.getItem(DISMISS_KEY) !== '1') {
					visible = true;
				}
			}, 2500);
			return () => {
				window.removeEventListener('beforeinstallprompt', onBip);
				clearTimeout(t);
			};
		}

		return () => window.removeEventListener('beforeinstallprompt', onBip);
	});

	async function install() {
		if (deferred) {
			await deferred.prompt();
			const choice = await deferred.userChoice;
			if (choice.outcome === 'accepted') {
				visible = false;
			}
			deferred = null;
			return;
		}
	}

	function dismiss() {
		visible = false;
		dismissed = true;
		try {
			localStorage.setItem(DISMISS_KEY, '1');
		} catch {
			// ignore
		}
	}
</script>

{#if visible && !isStandalone}
	<div class="pwa-install" role="dialog" aria-label="安装应用">
		<div class="pwa-install-inner">
			<div class="pwa-install-copy">
				<p class="pwa-install-title">安装「贝利卡管家」</p>
				{#if isIos && !deferred}
					<p class="pwa-install-desc">点 Safari 底部分享 →「添加到主屏幕」，像 App 一样使用。</p>
				{:else}
					<p class="pwa-install-desc">添加到主屏幕，全屏打开，查卡和提醒更快。</p>
				{/if}
			</div>
			<div class="pwa-install-actions">
				{#if deferred}
					<button type="button" class="pwa-install-btn" onclick={install}>安装</button>
				{/if}
				<button type="button" class="pwa-install-dismiss" onclick={dismiss}>稍后</button>
			</div>
		</div>
	</div>
{/if}

<style>
	.pwa-install {
		position: fixed;
		z-index: 80;
		right: 0.75rem;
		bottom: calc(var(--app-safe-bottom, 0px) + 0.75rem);
		left: 0.75rem;
		pointer-events: none;
	}

	/* 页面有底部导航栏时抬高，避免盖住导航 */
	:global(body:has(.app-tabbar)) .pwa-install {
		bottom: calc(var(--app-tabbar-h, 3.75rem) + var(--app-safe-bottom, 0px) + 0.65rem);
	}

	.pwa-install-inner {
		pointer-events: auto;
		display: flex;
		align-items: center;
		justify-content: space-between;
		gap: 0.75rem;
		padding: 0.85rem 0.95rem;
		border: 1px solid rgba(232, 181, 61, 0.35);
		border-radius: 14px;
		background: rgba(12, 16, 28, 0.96);
		box-shadow: 0 16px 40px rgba(0, 0, 0, 0.45);
		backdrop-filter: blur(14px);
	}

	.pwa-install-copy {
		min-width: 0;
		flex: 1;
	}

	.pwa-install-title {
		margin: 0;
		font-size: 0.9rem;
		font-weight: 900;
		color: #fff;
	}

	.pwa-install-desc {
		margin: 0.2rem 0 0;
		font-size: 0.72rem;
		line-height: 1.4;
		color: var(--bls-muted, #8b95a8);
	}

	.pwa-install-actions {
		display: flex;
		flex-shrink: 0;
		align-items: center;
		gap: 0.4rem;
	}

	.pwa-install-btn {
		border: 0;
		border-radius: 999px;
		background: linear-gradient(180deg, #ffda7b, #e8b53d);
		color: #0a0e18;
		font-size: 0.78rem;
		font-weight: 900;
		padding: 0.45rem 0.85rem;
		cursor: pointer;
	}

	.pwa-install-dismiss {
		border: 1px solid rgba(150, 170, 210, 0.25);
		border-radius: 999px;
		background: transparent;
		color: var(--bls-muted, #8b95a8);
		font-size: 0.75rem;
		font-weight: 700;
		padding: 0.42rem 0.7rem;
		cursor: pointer;
	}

	/* 桌面端不展示（JS 也有同样的判断，这里兜底） */
	@media (min-width: 768px) {
		.pwa-install {
			display: none;
		}
	}
</style>
