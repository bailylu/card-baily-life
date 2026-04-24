<script lang="ts">
	import type { ActionData, PageData } from './$types';
	let { data, form }: { data: PageData; form: ActionData } = $props();
	let email = $derived(form && 'email' in form && typeof form.email === 'string' ? form.email : '');
	let mode = $derived(form && 'mode' in form && form.mode === 'login' ? 'login' : data.mode);
	let isLogin = $derived(mode === 'login');
</script>

<svelte:head>
	<title>{isLogin ? '登录' : '注册'} — 信用卡提醒</title>
</svelte:head>

<main class="relative min-h-screen overflow-hidden bg-slate-950 px-4 py-10 text-white">
	<div class="absolute inset-0 bg-[radial-gradient(circle_at_18%_8%,_rgba(59,130,246,0.4),_transparent_30%),radial-gradient(circle_at_90%_30%,_rgba(14,165,233,0.16),_transparent_30%),linear-gradient(135deg,_#020617,_#0f172a)]"></div>
	<div class="relative mx-auto grid min-h-[calc(100vh-5rem)] max-w-6xl items-center gap-10 lg:grid-cols-[0.95fr_1.05fr]">
		<section class="lg:pr-8">
			<div class="flex flex-wrap items-center gap-3">
				<a href="/" class="inline-flex items-center gap-2 text-sm text-slate-300 hover:text-white">← 返回首页</a>
				<p class="inline-flex rounded-full bg-emerald-400/15 px-3 py-1 text-sm font-semibold text-emerald-100 ring-1 ring-emerald-300/30">
					{isLogin ? '已有账号直接登录' : '无需邮箱验证即可注册'}
				</p>
			</div>
			<h1 class="mt-8 max-w-2xl text-4xl font-black tracking-tight sm:text-[3.35rem] sm:leading-[1.08]">
				{isLogin ? '登录你的信用卡管家' : '马上注册你的信用卡管家'}
			</h1>
			<p class="mt-5 max-w-xl text-lg leading-8 text-slate-300">
				{isLogin ? '输入邮箱和密码，回到你的卡片提醒台。' : '填写邮箱和密码，马上开始记录账单日、还款日和年费日。'}
				</p>
				<div class="mt-8 rounded-3xl bg-white/8 p-5 ring-1 ring-white/10">
					<p class="text-sm font-semibold text-white">后续即时通知方式</p>
					<div class="mt-4 flex flex-wrap gap-2 text-sm text-slate-200">
						<span class="rounded-full bg-emerald-400/15 px-3 py-1 font-semibold text-emerald-100 ring-1 ring-emerald-300/25">🔔 Bark 通知</span>
						<span class="rounded-full bg-sky-400/15 px-3 py-1 font-semibold text-sky-100 ring-1 ring-sky-300/25">✈️ Telegram 通知</span>
						<span class="rounded-full bg-lime-400/15 px-3 py-1 font-semibold text-lime-100 ring-1 ring-lime-300/25">💬 PushPlus 微信通知</span>
				</div>
			</div>
			<div class="mt-4 rounded-3xl bg-white/8 p-5 text-sm text-slate-300 ring-1 ring-white/10">
				<p class="font-semibold text-white">只记录必要信息</p>
				<p class="mt-2">添加卡片时只需要尾号和日期，不需要填写完整卡号。</p>
			</div>
		</section>

		<section class="mx-auto w-full max-w-xl rounded-[2rem] border border-white/15 bg-white p-8 text-slate-950 shadow-2xl sm:p-10">
			<div>
				<div class="grid grid-cols-2 gap-3 rounded-3xl bg-slate-100 p-2 text-sm font-semibold">
					<a
						href="/login?mode=register"
						class={`rounded-2xl px-4 py-3 text-center transition ${
							!isLogin
								? 'bg-blue-600 text-white shadow-lg shadow-blue-600/20'
								: 'bg-white text-slate-500 ring-1 ring-slate-200 hover:text-slate-900'
						}`}
					>
						<span class="block text-lg">注册</span>
						<span class={`mt-1 block text-xs ${!isLogin ? 'text-blue-100' : 'text-slate-400'}`}>新用户开始使用</span>
					</a>
					<a
						href="/login?mode=login"
						class={`rounded-2xl px-4 py-3 text-center transition ${
							isLogin
								? 'bg-blue-600 text-white shadow-lg shadow-blue-600/20'
								: 'bg-white text-slate-500 ring-1 ring-slate-200 hover:text-slate-900'
						}`}
					>
						<span class="block text-lg">登录</span>
						<span class={`mt-1 block text-xs ${isLogin ? 'text-blue-100' : 'text-slate-400'}`}>已有账号返回</span>
					</a>
				</div>
				<h2 class="mt-5 text-3xl font-bold">{isLogin ? '登录' : '注册'}</h2>
				<p class="mt-2 text-sm leading-6 text-slate-500">
					{isLogin ? '使用注册邮箱和密码登录。' : '新邮箱会创建一个新的提醒账号。'}
				</p>
			</div>

			{#if form?.error}
				<div class="mt-5 rounded-2xl border border-red-200 bg-red-50 p-4 text-sm text-red-700">
					{form.error}
				</div>
			{/if}

			<form method="POST" class="mt-8 space-y-6">
				<input type="hidden" name="mode" value={mode} />
				<label class="block">
					<span class="text-sm font-medium text-slate-700">邮箱</span>
					<input
						name="email"
						type="email"
						value={email}
						required
						autocomplete="email"
						placeholder="you@example.com"
						class="mt-2 w-full rounded-2xl border border-slate-200 px-4 py-4 outline-none transition focus:border-blue-500 focus:ring-4 focus:ring-blue-100"
					/>
				</label>

				<label class="block">
					<span class="text-sm font-medium text-slate-700">密码</span>
					<input
						name="password"
						type="password"
						required
						minlength="6"
						autocomplete="current-password"
						placeholder="至少 6 位"
						class="mt-2 w-full rounded-2xl border border-slate-200 px-4 py-4 outline-none transition focus:border-blue-500 focus:ring-4 focus:ring-blue-100"
					/>
				</label>

				<button class="w-full rounded-2xl bg-blue-600 px-4 py-4 text-lg font-semibold text-white shadow-xl shadow-blue-600/20 hover:bg-blue-700">
					{isLogin ? '登录' : '注册并进入'}
				</button>
			</form>
		</section>
	</div>
</main>
