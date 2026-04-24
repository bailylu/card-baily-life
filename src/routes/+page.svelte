<script lang="ts">
	import type { PageData } from './$types';
	let { data }: { data: PageData } = $props();
</script>

<svelte:head>
	<title>card.baily.life — 信用卡提醒</title>
</svelte:head>

<main class="relative min-h-screen overflow-hidden bg-slate-950 px-4 text-white">
	<div class="absolute inset-0 bg-[radial-gradient(circle_at_10%_10%,_rgba(59,130,246,0.38),_transparent_30%),radial-gradient(circle_at_90%_20%,_rgba(14,165,233,0.18),_transparent_28%),linear-gradient(135deg,_#020617_0%,_#0f172a_52%,_#111827_100%)]"></div>
	<div class="absolute left-1/2 top-16 h-72 w-72 -translate-x-1/2 rounded-full bg-blue-500/15 blur-3xl"></div>
	<div class="absolute -bottom-16 right-0 h-96 w-96 rounded-full bg-cyan-500/10 blur-3xl"></div>

	<div class="relative mx-auto flex min-h-screen max-w-6xl flex-col justify-center py-12">
		<nav class="absolute left-0 right-0 top-6 flex items-center justify-between">
			<div class="flex items-center gap-3 text-sm font-semibold">
				<span class="grid h-10 w-10 place-items-center rounded-2xl bg-white text-xl shadow-lg shadow-blue-950/30">💳</span>
				<div>
					<p>贝利卡管家</p>
					<p class="text-xs font-normal text-slate-400">你的信用卡专属小管家</p>
				</div>
			</div>
			{#if data.user}
				<a
					href="/dashboard"
					class="rounded-full bg-white/10 px-4 py-2 text-sm text-white/85 ring-1 ring-white/15 hover:bg-white/15"
				>
					进入我的卡片
				</a>
			{:else}
				<div class="flex items-center gap-2">
					<a href="/login?mode=login" class="rounded-full px-4 py-2 text-sm text-white/75 hover:text-white">
						登录
					</a>
					<a
						href="/login?mode=register"
						class="rounded-full bg-white/10 px-4 py-2 text-sm text-white/85 ring-1 ring-white/15 hover:bg-white/15"
					>
						注册
					</a>
				</div>
			{/if}
		</nav>

		<div class="grid items-center gap-10 lg:grid-cols-[1.05fr_0.95fr]">
			<section class="pt-20">
				<p class="inline-flex rounded-full bg-white/10 px-3 py-1 text-sm text-blue-100 ring-1 ring-white/15">
					给信用卡做一个简单、干净的提醒台
				</p>
				<h1 class="mt-6 max-w-3xl text-5xl font-black tracking-tight text-white sm:text-6xl">
					别再错过账单日、还款日和年费日
				</h1>
				<p class="mt-6 max-w-2xl text-lg leading-8 text-slate-300">
					把每张信用卡的关键日期放在一个地方。先记录，后续通过邮箱等方式提醒你，避免忘还款、漏年费，也不用在备忘录里翻来翻去。
				</p>
				<div class="mt-8 flex">
					<a
						href={data.user ? '/dashboard' : '/login?mode=register'}
						class="inline-flex items-center justify-center rounded-2xl bg-blue-500 px-6 py-4 font-semibold text-white shadow-2xl shadow-blue-500/25 hover:bg-blue-400"
					>
						{data.user ? '进入我的卡片' : '开始使用'}
					</a>
				</div>
				<div class="mt-8 grid max-w-xl gap-3 text-sm text-slate-300 sm:grid-cols-3">
					<div class="rounded-2xl bg-white/8 p-4 ring-1 ring-white/10">
						<p class="text-xl font-bold text-white">先录入</p>
						<p class="mt-1">账单日、还款日、年费日</p>
					</div>
					<div class="rounded-2xl bg-white/8 p-4 ring-1 ring-white/10">
						<p class="text-xl font-bold text-white">再预览</p>
						<p class="mt-1">未来 30 天提醒清单</p>
					</div>
						<div class="rounded-2xl bg-white/8 p-4 ring-1 ring-white/10">
							<p class="text-xl font-bold text-white">后通知</p>
							<p class="mt-1">Bark / PushPlus / Telegram</p>
						</div>
				</div>
			</section>

			<section class="relative lg:translate-y-8">
				<div class="absolute -inset-4 rounded-[2rem] bg-gradient-to-br from-blue-500/25 to-cyan-500/10 blur-2xl"></div>
				<div class="relative overflow-hidden rounded-[2rem] border border-white/15 bg-white/10 p-5 shadow-2xl backdrop-blur">
					<div class="absolute right-6 top-6 rounded-full bg-emerald-400/10 px-3 py-1 text-xs text-emerald-200 ring-1 ring-emerald-300/20">
						演示卡片
					</div>
					<img
						src="/images/apple-card.png"
						alt="Apple Card 示例卡面"
						class="block w-full rounded-3xl shadow-xl ring-1 ring-white/20"
					/>
					<div class="mt-4 grid grid-cols-3 gap-3 text-center">
						<div class="rounded-2xl bg-white/10 p-4 ring-1 ring-white/10">
							<p class="text-xs text-slate-300">账单日</p>
							<p class="mt-1 text-lg font-bold">每月 12 日</p>
						</div>
						<div class="rounded-2xl bg-white/10 p-4 ring-1 ring-white/10">
							<p class="text-xs text-slate-300">还款日</p>
							<p class="mt-1 text-lg font-bold">每月 30 日</p>
						</div>
						<div class="rounded-2xl bg-white/10 p-4 ring-1 ring-white/10">
							<p class="text-xs text-slate-300">提前提醒</p>
							<p class="mt-1 text-lg font-bold">5 天</p>
						</div>
					</div>
					<div class="mt-4 rounded-2xl bg-slate-950/60 p-4 ring-1 ring-white/10">
							<div class="flex items-center justify-between">
								<p class="font-semibold">未来 30 天</p>
								<span class="rounded-full bg-emerald-400/10 px-2 py-1 text-xs text-emerald-200">即时通知</span>
							</div>
						<div class="mt-3 space-y-2 text-sm text-slate-300">
							<div class="flex justify-between rounded-xl bg-white/5 px-3 py-2">
								<span>还款提醒</span>
								<span class="text-white">5 天后</span>
							</div>
							<div class="flex justify-between rounded-xl bg-white/5 px-3 py-2">
								<span>账单提醒</span>
								<span class="text-white">17 天后</span>
							</div>
						</div>
					</div>
				</div>
			</section>
		</div>
	</div>
</main>
