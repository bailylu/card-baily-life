<script lang="ts">
	import { SignIn } from 'svelte-clerk';
	import type { PageData } from './$types';
	let { data }: { data: PageData } = $props();
	let showSignIn = $state(false);
	let isSignInPending = $state(false);
	let signInPendingTimer: ReturnType<typeof setTimeout> | null = null;

	// 3 rows of background cards, looped for seamless scroll
	const row1 = Array.from({ length: 14 }, (_, i) => String(i + 1).padStart(3, '0')); // 001-014
	const row2 = Array.from({ length: 14 }, (_, i) => String(i + 15).padStart(3, '0')); // 015-028
	const row3 = Array.from({ length: 14 }, (_, i) => String(i + 29).padStart(3, '0')); // 029-042

	function loop(arr: string[]) {
		return [...arr, ...arr, ...arr];
	}

	function openSignIn() {
		isSignInPending = false;
		showSignIn = true;
	}

	function closeSignIn() {
		if (signInPendingTimer) clearTimeout(signInPendingTimer);
		isSignInPending = false;
		showSignIn = false;
	}

	function markSignInPending() {
		isSignInPending = true;
		if (signInPendingTimer) clearTimeout(signInPendingTimer);
		signInPendingTimer = setTimeout(() => {
			isSignInPending = false;
		}, 15000);
	}

	function handleSignInInteraction(event: MouseEvent | KeyboardEvent) {
		const target = event.target;
		if (!(target instanceof HTMLElement)) return;

		if (event instanceof KeyboardEvent) {
			if (event.key !== 'Enter') return;
			markSignInPending();
			return;
		}

		const button = target.closest('button');
		const label = button?.textContent?.trim().toLowerCase() ?? '';
		if (label.includes('continue') || label.includes('继续') || label.includes('登录')) {
			markSignInPending();
		}
	}

	function handleSignInInput(event: Event) {
		const target = event.target;
		if (!(target instanceof HTMLElement)) return;

		const dialog = target.closest('[role="dialog"]');
		if (!(dialog instanceof HTMLElement)) return;

		const dialogText = dialog.textContent?.toLowerCase() ?? '';
		const isVerificationStep =
			dialogText.includes('verification') ||
			dialogText.includes('code') ||
			dialogText.includes('验证码') ||
			dialogText.includes('验证');
		if (!isVerificationStep) return;

		const inputText = Array.from(dialog.querySelectorAll('input'))
			.map((input) => input.value)
			.join('');
		if (inputText.replace(/\D/g, '').length >= 6 || inputText.length >= 6) markSignInPending();
	}
</script>

<svelte:head>
	<title>贝利卡管家</title>
</svelte:head>

<main class="bls-page home-has-mobile-cta px-4 text-white">
	<div class="absolute inset-0 bg-[radial-gradient(circle_at_10%_10%,_rgba(91,157,255,0.26),_transparent_30%),radial-gradient(circle_at_90%_20%,_rgba(47,230,212,0.13),_transparent_28%),linear-gradient(135deg,_#06090f_0%,_#0a0e18_52%,_#0b1826_100%)]"></div>
	<div class="absolute left-1/2 top-16 h-72 w-72 -translate-x-1/2 rounded-full bg-blue-500/15 blur-3xl"></div>
	<div class="absolute -bottom-16 right-0 h-96 w-96 rounded-full bg-cyan-500/10 blur-3xl"></div>

	<div class="relative mx-auto flex min-h-screen max-w-6xl flex-col justify-center py-12">
		<!-- Background floating credit cards -->
		<div class="pointer-events-none absolute inset-x-[-12rem] bottom-16 top-36 z-0 overflow-hidden opacity-35 blur-[0.2px] [mask-image:radial-gradient(ellipse_at_center,black_42%,transparent_78%)]">
			<div class="flex h-full flex-col justify-center gap-8">
				<div class="background-card-row float-row-slow" style="--row-delay: 0s">
					{#each loop(row1) as id, i}
						<figure class="background-card" style="--item-delay: {(i % 14) * 0.16}s">
							<img src="/images/kamian/card-{id}.webp" alt="" class="h-full w-full object-contain p-1" />
						</figure>
					{/each}
				</div>
				<div class="background-card-row float-row-medium reverse" style="--row-delay: 0.8s">
					{#each loop(row2) as id, i}
						<figure class="background-card" style="--item-delay: {(i % 14) * 0.16}s">
							<img src="/images/kamian/card-{id}.webp" alt="" class="h-full w-full object-contain p-1" />
						</figure>
					{/each}
				</div>
				<div class="background-card-row float-row-fast" style="--row-delay: 1.6s">
					{#each loop(row3) as id, i}
						<figure class="background-card" style="--item-delay: {(i % 14) * 0.16}s">
							<img src="/images/kamian/card-{id}.webp" alt="" class="h-full w-full object-contain p-1" />
						</figure>
					{/each}
				</div>
			</div>
		</div>

		<nav class="absolute left-0 right-0 top-4 z-20 flex items-center justify-between gap-2 sm:top-6">
			<div class="flex min-w-0 items-center gap-2 text-sm font-semibold sm:gap-3 sm:text-base">
				<img src="/images/brand/logo-mark.svg" alt="" class="h-9 w-9 shrink-0 sm:h-11 sm:w-11" />
				<div class="min-w-0">
					<p class="truncate">贝利卡管家</p>
					<p class="hidden text-sm font-normal text-slate-400 sm:block">你的信用卡专属小管家</p>
				</div>
			</div>
			{#if data.user}
				<a
					href="/dashboard"
					class="bls-btn-ghost shrink-0 px-3 py-1.5 text-xs sm:px-4 sm:py-2 sm:text-sm"
				>
					进入我的卡片
				</a>
			{/if}
		</nav>

		<div class="relative z-10 mt-12 grid items-center gap-4 sm:mt-0 sm:gap-10 lg:grid-cols-[1.05fr_0.95fr]">
			<section class="bls-panel relative overflow-hidden p-5 pt-8 backdrop-blur-sm sm:p-8 sm:pt-10 lg:pt-8">
				<div class="pointer-events-none absolute inset-0 bg-gradient-to-br from-white/10 via-slate-950/35 to-slate-950/65"></div>
				<div class="relative">
					<p class="bls-chip inline-flex px-2.5 py-1 text-xs sm:px-3 sm:text-sm">
						信用卡提醒，简单一点
					</p>
					<h1 class="mt-4 max-w-3xl text-3xl font-extrabold leading-[1.15] text-white sm:mt-6 sm:text-5xl sm:leading-[1.08] lg:text-[3.5rem]">
						别再错过账单日<br />还款日和年费日
					</h1>
					<p class="mt-3 max-w-xl text-sm leading-6 text-slate-300 sm:mt-6 sm:text-lg sm:leading-9">
						把账单、还款、年费这些容易忘的日子统一记好。提前看见，按时处理，不用再靠备忘录和临时想起。
					</p>
					<div class="mt-5 flex sm:mt-8">
						{#if data.user}
							<a
								href="/dashboard"
								class="bls-btn inline-flex items-center justify-center px-5 py-3 text-sm sm:px-6 sm:py-4 sm:text-base"
							>
								进入我的卡片
							</a>
						{:else}
							<button
								type="button"
								onclick={openSignIn}
								class="bls-btn inline-flex items-center justify-center px-5 py-3 text-sm sm:px-6 sm:py-4 sm:text-base"
							>
								开始使用
							</button>
						{/if}
					</div>
					<div class="mt-8 hidden max-w-xl gap-3 text-sm text-slate-300 sm:grid sm:grid-cols-3">
						<div class="border-2 border-white/10 bg-white/8 p-4">
							<p class="text-xl font-bold text-white">免费使用</p>
							<p class="mt-1">基础提醒不收费，不绑套餐</p>
						</div>
						<div class="border-2 border-white/10 bg-white/8 p-4">
							<p class="text-xl font-bold text-white">开源透明</p>
							<p class="mt-1">逻辑看得见，数据不藏着</p>
						</div>
						<div class="border-2 border-white/10 bg-white/8 p-4">
							<p class="text-xl font-bold text-white">隐私可控</p>
							<p class="mt-1">只记提醒信息，不碰卡密</p>
						</div>
					</div>
				</div>
			</section>

			<section class="relative">
				<div class="absolute -inset-4 rounded-[2rem] bg-gradient-to-br from-blue-500/25 to-cyan-500/10 blur-2xl"></div>
				<div class="relative mx-auto overflow-hidden border-2 border-white/15 bg-white/10 p-3 shadow-2xl backdrop-blur sm:p-5">
					<img
						src="/images/apple-card.png"
						alt="Apple Card 示例卡面"
						class="block w-full rounded-2xl shadow-xl ring-1 ring-white/20 sm:rounded-3xl"
					/>
					<div class="mt-2.5 grid grid-cols-3 gap-2 text-center sm:mt-4 sm:gap-3">
						<div class="rounded-xl bg-white/10 px-2 py-1.5 ring-1 ring-white/10 sm:rounded-2xl sm:p-4">
							<p class="text-[10px] text-slate-300 sm:text-xs">账单日</p>
							<p class="mt-0.5 text-[11px] font-bold sm:mt-1 sm:text-lg">每月 12 日</p>
						</div>
						<div class="rounded-xl bg-white/10 px-2 py-1.5 ring-1 ring-white/10 sm:rounded-2xl sm:p-4">
							<p class="text-[10px] text-slate-300 sm:text-xs">还款日</p>
							<p class="mt-0.5 text-[11px] font-bold sm:mt-1 sm:text-lg">每月 30 日</p>
						</div>
						<div class="rounded-xl bg-white/10 px-2 py-1.5 ring-1 ring-white/10 sm:rounded-2xl sm:p-4">
							<p class="text-[10px] text-slate-300 sm:text-xs">提前提醒</p>
							<p class="mt-0.5 text-[11px] font-bold sm:mt-1 sm:text-lg">5 天</p>
						</div>
					</div>
					<div class="mt-2.5 rounded-xl bg-slate-950/60 p-2.5 ring-1 ring-white/10 sm:mt-4 sm:rounded-2xl sm:p-4">
						<div class="flex items-center justify-between">
							<p class="text-[11px] font-semibold sm:text-base">未来 30 天</p>
							<span class="rounded-full bg-emerald-400/10 px-2 py-0.5 text-[10px] text-emerald-200 sm:py-1 sm:text-xs">即时通知</span>
						</div>
						<div class="mt-1.5 space-y-1 text-[11px] text-slate-300 sm:mt-3 sm:space-y-2 sm:text-sm">
							<div class="flex justify-between rounded-lg bg-white/5 px-2.5 py-1 sm:rounded-xl sm:px-3 sm:py-2">
								<span>还款提醒</span>
								<span class="text-white">5 天后</span>
							</div>
							<div class="flex justify-between rounded-lg bg-white/5 px-2.5 py-1 sm:rounded-xl sm:px-3 sm:py-2">
								<span>账单提醒</span>
								<span class="text-white">17 天后</span>
							</div>
						</div>
					</div>
				</div>
			</section>
		</div>
	</div>

	{#if !data.user}
		<div class="home-mobile-cta-bar md:hidden">
			<button type="button" onclick={openSignIn} class="bls-btn">
				开始使用
			</button>
		</div>
	{:else}
		<div class="home-mobile-cta-bar md:hidden">
			<a href="/dashboard" class="bls-btn">
				进入我的卡片
			</a>
		</div>
	{/if}

	{#if showSignIn}
		<div class="fixed inset-0 z-50 grid place-items-center bg-slate-950/70 px-4 py-8 backdrop-blur-sm" role="dialog" aria-modal="true">
			<button
				type="button"
				class="absolute inset-0 cursor-default"
				aria-label="关闭登录弹窗"
				onclick={closeSignIn}
			></button>
			<div
				role="dialog"
				aria-modal="true"
				aria-label="登录或注册"
				tabindex="-1"
				class="relative w-full max-w-md rounded-[2rem] border border-white/15 bg-white p-5 pt-12 text-slate-950 shadow-2xl shadow-slate-950/35"
				onclick={handleSignInInteraction}
				onkeydown={handleSignInInteraction}
				oninput={handleSignInInput}
			>
				<button
					type="button"
					class="absolute right-4 top-4 grid h-9 w-9 place-items-center rounded-full bg-slate-100 text-xl leading-none text-slate-500 hover:bg-slate-200"
					aria-label="关闭登录弹窗"
					onclick={closeSignIn}
				>
					×
				</button>
				{#if isSignInPending}
					<div class="mb-4 flex items-center gap-3 rounded-2xl bg-blue-50 px-4 py-3 text-sm font-semibold text-blue-700 ring-1 ring-blue-100">
						<span class="h-4 w-4 animate-spin rounded-full border-2 border-blue-200 border-t-blue-600"></span>
						<span>正在登录，请稍候...</span>
					</div>
				{/if}
				<SignIn
					routing="hash"
					withSignUp={true}
					signUpUrl="#/sign-up"
					fallbackRedirectUrl="/dashboard"
					forceRedirectUrl="/dashboard"
					signUpFallbackRedirectUrl="/dashboard"
					signUpForceRedirectUrl="/dashboard"
				/>
			</div>
		</div>
	{/if}
</main>

<style>
	.background-card-row {
		display: flex;
		gap: 1.5rem;
		width: max-content;
		animation: background-card-scroll 56s linear infinite;
	}
	.background-card-row.reverse {
		animation-direction: reverse;
	}
	.float-row-slow {
		margin-left: -6rem;
		animation-duration: 68s;
	}
	.float-row-medium {
		margin-left: -14rem;
		animation-duration: 58s;
	}
	.float-row-fast {
		margin-left: -2rem;
		animation-duration: 48s;
	}
	.background-card {
		aspect-ratio: 1.586;
		width: clamp(170px, 14vw, 230px);
		background: rgba(255, 255, 255, 0.14);
		border-radius: 1.25rem;
		outline: 1px solid rgba(255, 255, 255, 0.26);
		overflow: hidden;
		box-shadow: 0 24px 64px rgba(2, 6, 23, 0.42);
		animation: background-card-float 6s ease-in-out infinite;
		animation-delay: calc(var(--row-delay) + var(--item-delay));
	}
	@keyframes background-card-scroll {
		0% {
			transform: translateX(0);
		}
		100% {
			transform: translateX(-33.333%);
		}
	}
	@keyframes background-card-float {
		0%,
		100% {
			transform: translateY(0) rotate(-1deg);
		}
		50% {
			transform: translateY(-16px) rotate(1deg);
		}
	}
	@media (prefers-reduced-motion: reduce) {
		.background-card-row,
		.background-card {
			animation: none;
		}
	}
</style>
