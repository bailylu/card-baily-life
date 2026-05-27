<script lang="ts">
	import { onMount } from 'svelte';
	import CardFace from '$lib/components/CardFace.svelte';
	import type { PageData } from './$types';

	let { data }: { data: PageData } = $props();

	let featuredCards = $derived(data.featuredCards);
	let featuredIndex = $state(0);
	let featuredCard = $derived(featuredCards[featuredIndex]);

	const remindersPerPage = 8;
	let reminderPage = $state(1);
	let totalReminderPages = $derived(Math.max(1, Math.ceil(data.reminders.length / remindersPerPage)));
	let pagedReminders = $derived(
		data.reminders.slice((reminderPage - 1) * remindersPerPage, reminderPage * remindersPerPage)
	);
	let reminderStart = $derived(data.reminders.length === 0 ? 0 : (reminderPage - 1) * remindersPerPage + 1);
	let reminderEnd = $derived(Math.min(reminderPage * remindersPerPage, data.reminders.length));
	let expandedCardIds = $state<Set<string | number>>(new Set());

	function toggleCardDetails(cardId: string | number) {
		expandedCardIds = new Set(expandedCardIds);
		if (expandedCardIds.has(cardId)) {
			expandedCardIds.delete(cardId);
		} else {
			expandedCardIds.add(cardId);
		}
	}

	onMount(() => {
		const timer = window.setInterval(() => {
			if (featuredCards.length > 0) {
				featuredIndex = (featuredIndex + 1) % featuredCards.length;
			}
		}, 6000);

		return () => window.clearInterval(timer);
	});
</script>

<svelte:head>
	<title>我的卡片 — 贝利卡管家</title>
</svelte:head>

<div class="min-h-screen bg-[#f5f7fb] text-slate-950">
	<header class="relative z-50 border-b border-slate-200/80 bg-white/90 backdrop-blur">
		<div class="mx-auto flex max-w-7xl items-center justify-between gap-3 px-4 py-3 sm:px-6 sm:py-4">
			<a href="/dashboard" class="flex items-center gap-3">
				<span class="grid h-10 w-10 place-items-center rounded-xl bg-blue-600 text-lg text-white shadow-lg shadow-blue-600/20">💳</span>
				<div>
					<p class="text-base font-bold text-slate-950">贝利卡管家</p>
					<p class="text-xs text-slate-400">账单日、还款日、年费日</p>
				</div>
			</a>
			<div class="flex shrink-0 items-center gap-2 sm:gap-3">
				<a href="/cards/add" class="rounded-full bg-blue-600 px-3 py-2 text-sm font-semibold text-white shadow-lg shadow-blue-600/20 hover:bg-blue-700 sm:px-4">
					添加信用卡
				</a>
				<details class="group relative">
					<summary class="cursor-pointer list-none rounded-full border border-slate-200 bg-white px-4 py-2 text-sm font-semibold text-slate-700 hover:border-blue-200 hover:text-blue-700">
						我的
					</summary>
					<div class="absolute right-0 z-50 mt-2 w-40 overflow-hidden rounded-xl border border-slate-200 bg-white py-1 text-sm shadow-xl">
						<a href="/me" class="block px-4 py-2 text-slate-700 hover:bg-slate-50">我的信息</a>
						{#if data.isAdmin}
							<a href="/admin/catalog" class="block px-4 py-2 text-slate-700 hover:bg-slate-50">卡库管理</a>
							<a href="/admin/featured" class="block px-4 py-2 text-slate-700 hover:bg-slate-50">首页推荐</a>
						{/if}
						<a href="/me/password" class="block px-4 py-2 text-slate-700 hover:bg-slate-50">修改密码</a>
						<form method="POST" action="/logout">
							<button class="block w-full px-4 py-2 text-left text-slate-500 hover:bg-slate-50 hover:text-slate-800">
								退出
							</button>
						</form>
					</div>
				</details>
			</div>
		</div>
	</header>

	<main class="mx-auto max-w-7xl px-4 py-5 sm:px-6 sm:py-8">
		{#if data.configMissing}
			<div class="mb-6 rounded-xl border border-amber-200 bg-amber-50 p-4 text-sm text-amber-700">
				数据连接暂时不可用，稍后刷新后会展示已保存的卡片。
			</div>
		{/if}

		<section class="overflow-hidden rounded-3xl border border-slate-200 bg-white shadow-sm">
			<div class="bg-gradient-to-br from-white via-slate-50 to-blue-50/70 p-4 sm:p-5 lg:p-6">
				<p class="text-xs font-bold text-blue-700">精选推荐</p>
				<h1 class="mt-1 text-xl font-black text-slate-950">什么卡值得申？</h1>

				<div class="mt-4 grid items-center gap-5 lg:min-h-[260px] xl:grid-cols-[minmax(0,0.82fr)_minmax(480px,1.18fr)]">
					<div class="flex min-w-0 flex-col justify-between gap-5 sm:pl-4 lg:min-h-[220px] lg:pl-6">
						<div>
							<h2 class="max-w-2xl text-3xl font-black leading-[1.1] text-slate-950 sm:text-4xl">
								{featuredCard.name}
							</h2>
							<p class="mt-3 max-w-xl text-sm leading-7 text-slate-600 sm:mt-4">
								{featuredCard.description}
							</p>
						</div>
						<div class="flex flex-wrap gap-3">
							<a href={featuredCard.href} class="rounded-xl bg-blue-600 px-4 py-2.5 text-sm font-bold text-white shadow-lg shadow-blue-600/20 hover:bg-blue-700">
								立即办卡
							</a>
						</div>
					</div>
					<div class="flex min-w-0 items-start justify-center pt-1 sm:pt-2">
						<div class="relative w-full max-w-[420px] sm:max-w-[480px]">
							<div class="absolute inset-6 rounded-[2rem] bg-blue-200/50 blur-3xl"></div>
							<img
								src={featuredCard.image}
								alt={featuredCard.alt}
								class="relative aspect-[1.586] w-full rounded-[1.35rem] object-cover shadow-2xl shadow-slate-300"
							/>
						</div>
					</div>
				</div>

				<div class="mt-4 flex justify-center gap-2 sm:justify-end">
					{#each featuredCards as card, index}
						<button
							type="button"
							aria-label={`查看第 ${index + 1} 张推荐卡：${card.name}`}
							onclick={() => (featuredIndex = index)}
							class={`h-8 min-w-8 rounded-full px-2.5 text-xs font-black transition ${
								featuredIndex === index
									? 'bg-blue-600 text-white shadow-lg shadow-blue-600/20'
									: 'bg-white text-slate-500 ring-1 ring-slate-200 hover:text-blue-700'
							}`}
						>
							{index + 1}
						</button>
					{/each}
				</div>
			</div>
		</section>

		<div class="mt-6 grid gap-6 sm:mt-8 xl:grid-cols-[minmax(0,1fr)_360px] xl:gap-8">
			<section>
				<div class="mb-4 flex items-center justify-between">
					<h2 class="text-lg font-bold text-slate-950">卡片列表</h2>
					<span class="rounded-full bg-white px-3 py-1 text-xs font-semibold text-slate-500 ring-1 ring-slate-200">{data.cards.length} 张</span>
				</div>

				{#if data.cards.length === 0}
					<div class="rounded-2xl border border-slate-200 bg-white p-10 text-center shadow-sm">
						<p class="text-sm text-slate-500">还没有卡片</p>
						<a href="/cards/add" class="mt-5 inline-flex rounded-xl bg-blue-600 px-4 py-2 text-sm font-semibold text-white hover:bg-blue-700">添加卡片</a>
					</div>
				{:else}
					<div class="grid gap-3 sm:gap-5 sm:grid-cols-2 lg:grid-cols-3">
						{#each data.cards as card}
							<article class="group rounded-2xl border border-slate-200 bg-white p-2 shadow-sm transition hover:-translate-y-1 hover:border-blue-200 hover:shadow-xl hover:shadow-slate-200 sm:p-3">
								<a
									href={card.isDemo ? '/dashboard' : `/cards/${card.id}/edit`}
									class="grid grid-cols-[112px_minmax(0,1fr)] items-center gap-3 sm:block"
								>
									<CardFace
										imageUrl={card.image_url}
										bankName={card.bank_name}
										displayName={card.displayName}
										lastFour={card.last_four}
										cardStyle={card.cardStyle}
										class="rounded-xl"
									/>

									<div class="min-w-0 sm:mt-4">
										<h3 class="line-clamp-2 text-sm font-bold leading-5 text-slate-950 group-hover:text-blue-700 sm:line-clamp-1 sm:text-base">{card.displayName}</h3>
										<p class="mt-1 text-xs text-slate-400 sm:text-sm">{card.card_tier ?? '标准卡'} · 尾号 {card.last_four}</p>
									</div>
								</a>
								<button
									type="button"
									onclick={() => toggleCardDetails(card.id)}
									class="mt-2 w-full rounded-xl bg-slate-50 px-3 py-2 text-left text-xs text-slate-500 transition hover:bg-blue-50 hover:text-blue-700 sm:mt-3"
									aria-expanded={expandedCardIds.has(card.id)}
								>
									<span class="flex items-center justify-between gap-3">
										<span class="min-w-0 truncate">查看详情</span>
										<span class={`shrink-0 text-sm transition ${expandedCardIds.has(card.id) ? 'rotate-180' : ''}`}>⌄</span>
									</span>
								</button>
								{#if expandedCardIds.has(card.id)}
									<div class="mt-2 grid grid-cols-3 gap-2 text-center text-xs">
										<div class="rounded-xl bg-slate-50 px-2 py-3">
											<p class="text-slate-400">账单</p>
											<p class="mt-1 font-bold text-slate-950">{card.statement_day} 日</p>
										</div>
										<div class="rounded-xl bg-slate-50 px-2 py-3">
											<p class="text-slate-400">还款</p>
											<p class="mt-1 font-bold text-slate-950">{card.due_day} 日</p>
										</div>
										<div class="rounded-xl bg-slate-50 px-2 py-3">
											<p class="text-slate-400">提前</p>
											<p class="mt-1 font-bold text-slate-950">{card.lead_days} 天</p>
										</div>
									</div>
								{/if}
							</article>
						{/each}
					</div>
				{/if}
			</section>

			<aside class="order-first xl:sticky xl:top-24 xl:order-none xl:self-start">
				<div class="rounded-2xl border border-slate-200 bg-white p-5 shadow-sm">
					<div class="flex items-center justify-between">
						<div>
							<h2 class="text-lg font-bold text-slate-950">未来 30 天</h2>
							<p class="mt-1 text-sm text-slate-500">临近账单和还款提醒</p>
						</div>
						<span class="rounded-full bg-blue-50 px-3 py-1 text-xs font-semibold text-blue-700">{data.reminders.length} 条</span>
					</div>

					{#if data.reminders.length === 0}
						<div class="mt-5 rounded-xl bg-slate-50 p-4 text-sm text-slate-500">暂无 30 天内提醒。</div>
					{:else}
						<div class="mt-5 divide-y divide-slate-100">
							{#each pagedReminders as reminder}
								<div class="flex items-start justify-between gap-4 py-4">
									<div class="min-w-0">
										<p class="line-clamp-1 text-sm font-semibold text-slate-950">{reminder.catalogName ?? reminder.cardName}</p>
										<p class="mt-1 text-xs text-slate-400">{reminder.typeLabel} · 尾号 {reminder.lastFour}</p>
									</div>
									<div class="shrink-0 text-right">
										<p class="text-sm font-bold text-slate-950">{reminder.daysUntilTarget} 天后</p>
										<p class="mt-1 text-xs text-slate-400">{reminder.targetDate}</p>
									</div>
								</div>
							{/each}
						</div>
						{#if data.reminders.length > remindersPerPage}
							<div class="mt-4 flex items-center justify-between border-t border-slate-100 pt-4 text-xs text-slate-400">
								<p>{reminderStart}-{reminderEnd} / {data.reminders.length}</p>
								<div class="flex items-center gap-2">
									<button
										type="button"
										disabled={reminderPage === 1}
										onclick={() => (reminderPage = Math.max(1, reminderPage - 1))}
										class="rounded-full border border-slate-200 px-3 py-1.5 font-semibold text-slate-600 hover:bg-slate-50 disabled:cursor-not-allowed disabled:opacity-40"
									>
										上一页
									</button>
									<button
										type="button"
										disabled={reminderPage === totalReminderPages}
										onclick={() => (reminderPage = Math.min(totalReminderPages, reminderPage + 1))}
										class="rounded-full border border-slate-200 px-3 py-1.5 font-semibold text-slate-600 hover:bg-slate-50 disabled:cursor-not-allowed disabled:opacity-40"
									>
										下一页
									</button>
								</div>
							</div>
						{/if}
					{/if}
				</div>
				{#if data.user}
					<p class="mt-4 text-center text-xs text-slate-400">当前登录邮箱：{data.user.email}</p>
				{/if}
			</aside>
		</div>
	</main>
</div>
