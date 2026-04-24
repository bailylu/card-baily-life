<script lang="ts">
	import type { PageData } from './$types';
	let { data }: { data: PageData } = $props();

	const remindersPerPage = 10;
	let reminderPage = $state(1);
	let totalReminderPages = $derived(Math.max(1, Math.ceil(data.reminders.length / remindersPerPage)));
	let pagedReminders = $derived(
		data.reminders.slice((reminderPage - 1) * remindersPerPage, reminderPage * remindersPerPage)
	);
	let reminderStart = $derived(data.reminders.length === 0 ? 0 : (reminderPage - 1) * remindersPerPage + 1);
	let reminderEnd = $derived(Math.min(reminderPage * remindersPerPage, data.reminders.length));
</script>

<svelte:head>
	<title>我的卡片 — card.baily.life</title>
</svelte:head>

<div class="min-h-screen bg-gray-50">
	<header class="bg-white border-b border-gray-200">
		<div class="max-w-2xl mx-auto px-4 py-4 flex items-center justify-between">
			<div>
				<h1 class="text-lg font-semibold text-gray-900">💳 我的卡片</h1>
			</div>
			<div class="flex items-center gap-3">
				<details class="group relative">
					<summary class="cursor-pointer list-none rounded-full px-3 py-2 text-sm font-medium text-blue-600 hover:bg-blue-50 hover:text-blue-700">
						我的
					</summary>
					<div class="absolute right-0 z-10 mt-2 w-36 overflow-hidden rounded-xl border border-gray-200 bg-white py-1 text-sm shadow-xl">
						<a href="/me" class="block px-4 py-2 text-gray-700 hover:bg-gray-50">我的信息</a>
						<a href="/me/password" class="block px-4 py-2 text-gray-700 hover:bg-gray-50">修改密码</a>
						<form method="POST" action="/logout">
							<button class="block w-full px-4 py-2 text-left text-gray-500 hover:bg-gray-50 hover:text-gray-800">
								退出
							</button>
						</form>
					</div>
				</details>
			</div>
		</div>
	</header>

	<main class="max-w-2xl mx-auto px-4 py-8">
		{#if data.configMissing}
			<div class="mb-4 rounded-xl border border-amber-200 bg-amber-50 p-4 text-sm text-amber-700">
				数据连接暂时不可用，稍后刷新后会展示已保存的卡片。
			</div>
		{/if}

		<section class="space-y-3">
			<div class="flex items-center justify-between">
				<h2 class="text-sm font-semibold text-gray-700">卡片列表</h2>
				<div class="flex items-center gap-3">
					<span class="text-xs text-gray-400">{data.cards.length} 张</span>
					<a
						href="/cards/add"
						class="rounded-full bg-blue-600 px-3 py-1.5 text-xs font-medium text-white hover:bg-blue-700"
					>
						添加信用卡
					</a>
				</div>
			</div>

			{#if data.cards.length === 0}
				<div class="bg-white rounded-xl border border-gray-200 p-8 text-center">
					<p class="text-gray-500 text-sm">还没有卡片</p>
					<p class="text-xs text-gray-400 mt-1">添加第一张卡片后，这里会显示账单日和还款日。</p>
					<a
						href="/cards/add"
						class="mt-5 inline-flex rounded-lg bg-blue-600 px-4 py-2 text-sm font-medium text-white hover:bg-blue-700"
					>
						添加卡片
					</a>
				</div>
				{:else}
					<div class="grid gap-4 sm:grid-cols-2">
						{#each data.cards as card}
							<article>
								<a
									href={card.isDemo ? '/dashboard' : `/cards/${card.id}/edit`}
									class="block rounded-[1.4rem] border border-gray-200 bg-white p-3 shadow-sm transition hover:-translate-y-0.5 hover:shadow-md"
								>
									<div
										class="relative aspect-[1.586/1] overflow-hidden rounded-2xl p-4 shadow-sm"
										style={`background: ${card.cardStyle.gradient}; color: ${card.cardStyle.text};`}
									>
										<div
											class="absolute -right-10 -top-10 h-28 w-28 rounded-full"
											style={`background: ${card.cardStyle.accent};`}
										></div>
										<div
											class="absolute bottom-4 right-6 h-8 w-14 rounded-full blur-sm"
											style={`background: ${card.cardStyle.accent};`}
										></div>
										<div class="relative flex h-full flex-col justify-between">
											<div class="flex items-center justify-between text-xs opacity-80">
												<span>{card.bank_name ?? 'card.baily.life'}</span>
												<span>{card.cardStyle.label}</span>
											</div>
											<div>
												<h3 class="text-lg font-semibold">{card.displayName}</h3>
												<p class="mt-3 font-mono text-sm tracking-[0.35em] opacity-80">•••• {card.last_four}</p>
											</div>
										</div>
									</div>

									<div class="mt-3 flex items-start justify-between gap-3">
										<div class="min-w-0">
											<h3 class="line-clamp-1 font-medium text-gray-900">{card.displayName}</h3>
											<p class="mt-1 text-xs text-gray-400">{card.card_tier ?? '标准卡'} · 尾号 {card.last_four}</p>
										</div>
									</div>
									<div class="mt-3 grid grid-cols-3 gap-2 text-center text-xs">
										<div class="rounded-xl bg-gray-50 px-2 py-2">
											<p class="text-gray-400">账单</p>
											<p class="mt-1 font-semibold text-gray-900">{card.statement_day} 日</p>
										</div>
										<div class="rounded-xl bg-gray-50 px-2 py-2">
											<p class="text-gray-400">还款</p>
											<p class="mt-1 font-semibold text-gray-900">{card.due_day} 日</p>
										</div>
										<div class="rounded-xl bg-gray-50 px-2 py-2">
											<p class="text-gray-400">提前</p>
											<p class="mt-1 font-semibold text-gray-900">{card.lead_days} 天</p>
										</div>
									</div>
								</a>
							</article>
						{/each}
					</div>
				{/if}
			</section>

		<section class="mt-8 space-y-3">
			<div class="flex items-center justify-between">
				<h2 class="text-sm font-semibold text-gray-700">未来 30 天提醒</h2>
				<span class="text-xs text-gray-400">{data.reminders.length} 条</span>
			</div>

				{#if data.reminders.length === 0}
					<div class="rounded-xl border border-gray-200 bg-white p-5 text-sm text-gray-500">
						暂无 30 天内提醒。
					</div>
				{:else}
					<div class="overflow-hidden rounded-xl border border-gray-200 bg-white">
						{#each pagedReminders as reminder}
							<div class="flex items-center justify-between gap-4 border-b border-gray-100 p-4 last:border-b-0">
								<div class="min-w-0">
									<p class="text-sm font-medium text-gray-900">
										{reminder.catalogName ?? reminder.cardName} · {reminder.typeLabel}
									</p>
									<p class="mt-1 text-xs text-gray-400">
										{#if reminder.catalogName && reminder.catalogName !== reminder.cardName}
											备注 {reminder.cardName} ·
										{/if}
										尾号 {reminder.lastFour} · 提醒日 {reminder.remindDate}
									</p>
								</div>
								<div class="text-right">
									<p class="text-sm font-semibold text-gray-900">{reminder.targetDate}</p>
									<p class="mt-1 text-xs text-gray-400">{reminder.daysUntilTarget} 天后</p>
								</div>
							</div>
						{/each}
					</div>
					{#if data.reminders.length > remindersPerPage}
						<div class="flex flex-col gap-3 text-xs text-gray-400 sm:flex-row sm:items-center sm:justify-between">
							<p>显示 {reminderStart}-{reminderEnd} 条，共 {data.reminders.length} 条</p>
							<div class="flex items-center gap-2">
								<button
									type="button"
									disabled={reminderPage === 1}
									onclick={() => (reminderPage = Math.max(1, reminderPage - 1))}
									class="rounded-full border border-gray-200 bg-white px-3 py-1.5 font-medium text-gray-600 hover:bg-gray-50 disabled:cursor-not-allowed disabled:opacity-40"
								>
									上一页
								</button>
								<span class="px-2 text-gray-500">{reminderPage} / {totalReminderPages}</span>
								<button
									type="button"
									disabled={reminderPage === totalReminderPages}
									onclick={() => (reminderPage = Math.min(totalReminderPages, reminderPage + 1))}
									class="rounded-full border border-gray-200 bg-white px-3 py-1.5 font-medium text-gray-600 hover:bg-gray-50 disabled:cursor-not-allowed disabled:opacity-40"
								>
									下一页
								</button>
							</div>
						</div>
					{/if}
				{/if}
			</section>

		{#if data.user}
			<div id="my-info" class="mt-4 text-center text-xs text-gray-400">
				当前登录邮箱：{data.user.email}
			</div>
		{:else}
			<div class="mt-4 text-center text-xs text-gray-400">开放测试版：当前使用公共测试用户</div>
		{/if}
	</main>
</div>
