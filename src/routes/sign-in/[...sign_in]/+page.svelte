<script lang="ts">
	import { SignIn } from 'svelte-clerk';
</script>

<svelte:head>
	<title>登录 — 贝利卡管家</title>
</svelte:head>

<main class="bls-page min-h-screen px-4 py-10 text-white">
	<div class="mx-auto flex min-h-[calc(100vh-5rem)] max-w-5xl items-center justify-center">
		<section class="bls-panel relative w-full max-w-md overflow-hidden p-6">
			<div class="pointer-events-none absolute inset-x-0 top-0 h-[3px] bg-gradient-to-r from-transparent via-[var(--bls-gold)] to-transparent"></div>
			<div class="mb-4 flex items-center justify-between gap-3">
				<div class="flex items-center gap-2.5">
					<img src="/images/brand/logo-mark.svg" alt="" class="h-9 w-9" />
					<div>
						<p class="text-sm font-black leading-tight text-white">贝利卡管家</p>
						<p class="bls-label mt-0.5 text-[10px] text-[var(--bls-cyan)]">Card Desk</p>
					</div>
				</div>
				<a href="/" class="text-sm font-semibold text-[var(--bls-cyan)] hover:text-[var(--bls-gold-bright)]">← 返回首页</a>
			</div>
			<SignIn
				withSignUp={true}
				signUpUrl="/sign-up"
				fallbackRedirectUrl="/dashboard"
				forceRedirectUrl="/dashboard"
				signUpFallbackRedirectUrl="/dashboard"
				signUpForceRedirectUrl="/dashboard"
			/>
		</section>
	</div>
</main>
