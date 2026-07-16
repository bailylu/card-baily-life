<script lang="ts">
	import { SignIn } from 'svelte-clerk';
</script>

<svelte:head>
	<title>注册 — 贝利卡管家</title>
</svelte:head>

<main class="min-h-screen bg-slate-50 px-4 py-10 text-slate-950">
	<div class="mx-auto flex min-h-[calc(100vh-5rem)] max-w-5xl items-center justify-center">
		<section class="w-full max-w-md rounded-3xl border border-slate-200 bg-white p-6 shadow-xl shadow-slate-200/70">
			<div class="mb-6">
				<a href="/" class="text-sm font-semibold text-blue-600 hover:text-blue-700">← 返回首页</a>
				<h1 class="mt-6 text-3xl font-black">登录 / 注册</h1>
				<p class="mt-2 text-sm leading-6 text-slate-500">注册与登录已合并到同一界面，可随时切换。</p>
			</div>
			<!-- 统一走带注册能力的 SignIn，避免注册另开页面/窗口 -->
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
