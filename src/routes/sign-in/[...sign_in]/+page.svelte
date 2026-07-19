<script lang="ts">
	import { SignIn } from 'svelte-clerk';
</script>

<svelte:head>
	<title>登录 — 贝利卡管家</title>
</svelte:head>

<main class="bls-page min-h-screen px-4 py-10 text-white">
	<div class="mx-auto flex min-h-[calc(100vh-5rem)] max-w-5xl items-center justify-center">
		<section class="bls-panel w-full max-w-md p-6">
			<div class="mb-6">
				<a href="/" class="text-sm font-semibold text-[var(--bls-cyan)] hover:text-[var(--bls-gold-bright)]">← 返回首页</a>
				<h1 class="mt-6 text-3xl font-black text-white">登录 / 注册</h1>
				<p class="mt-2 text-sm leading-6 text-[var(--bls-muted)]">登录或注册后即可管理卡片、提醒和通知设置。没有账号可直接点组件内的「注册」。</p>
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
