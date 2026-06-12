<script lang="ts">
	import { SignUp } from 'svelte-clerk';
</script>

<svelte:head>
	<title>注册 — 贝利卡管家</title>
</svelte:head>

<main class="min-h-screen bg-slate-50 px-4 py-10 text-slate-950">
	<div class="mx-auto flex min-h-[calc(100vh-5rem)] max-w-5xl items-center justify-center">
		<section class="w-full max-w-md rounded-3xl border border-slate-200 bg-white p-6 shadow-xl shadow-slate-200/70">
			<div class="mb-6">
				<a href="/" class="text-sm font-semibold text-blue-600 hover:text-blue-700">← 返回首页</a>
				<h1 class="mt-6 text-3xl font-black">创建贝利卡管家账号</h1>
				<p class="mt-2 text-sm leading-6 text-slate-500">账号由 Clerk 托管，注册后自动进入你的卡片提醒台。</p>
			</div>
			<SignUp signInUrl="/sign-in" fallbackRedirectUrl="/dashboard" />
		</section>
	</div>
</main>
