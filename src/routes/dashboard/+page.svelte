<script lang="ts">
	import type { PageData } from './$types';
	let { data }: { data: PageData } = $props();

	const testCardStyles = [
		{
			label: '黑金卡',
			name: '高端权益',
			gradient: 'linear-gradient(135deg, #111827 0%, #000000 58%, #ca8a04 100%)',
			accent: 'rgba(250, 204, 21, 0.28)',
			text: '#fefce8'
		},
		{
			label: '蓝白金',
			name: '差旅商务',
			gradient: 'linear-gradient(135deg, #2563eb 0%, #0f172a 72%)',
			accent: 'rgba(147, 197, 253, 0.32)',
			text: '#eff6ff'
		},
		{
			label: '绿色生活',
			name: '日常消费',
			gradient: 'linear-gradient(135deg, #16a34a 0%, #14532d 100%)',
			accent: 'rgba(187, 247, 208, 0.28)',
			text: '#f0fdf4'
		},
		{
			label: '紫色联名',
			name: '主题联名',
			gradient: 'linear-gradient(135deg, #7c3aed 0%, #3b0764 100%)',
			accent: 'rgba(216, 180, 254, 0.3)',
			text: '#faf5ff'
		}
	];
</script>

<svelte:head>
	<title>我的卡片 — card.baily.life</title>
</svelte:head>

<div class="min-h-screen bg-gray-50">
	<header class="bg-white border-b border-gray-200">
		<div class="max-w-2xl mx-auto px-4 py-4 flex items-center justify-between">
			<h1 class="text-lg font-semibold text-gray-900">💳 我的卡片</h1>
			<a href="/cards/add" class="text-sm font-medium text-blue-600 hover:text-blue-700">添加卡片</a>
		</div>
	</header>

	<main class="max-w-2xl mx-auto px-4 py-8">
		{#if data.configMissing}
			<div class="mb-4 rounded-xl border border-amber-200 bg-amber-50 p-4 text-sm text-amber-700">
				当前显示演示卡片。连接 D1 后会展示真实保存的卡片。
			</div>
		{/if}

		<section class="space-y-3">
			<div class="flex items-center justify-between">
				<h2 class="text-sm font-semibold text-gray-700">卡片列表</h2>
				<span class="text-xs text-gray-400">{data.cards.length} 张</span>
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

				<div class="grid gap-3 sm:grid-cols-2">
					{#each testCardStyles as style}
						<div
							class="relative overflow-hidden rounded-2xl p-4 shadow-sm"
							style={`background: ${style.gradient}; color: ${style.text};`}
						>
							<div
								class="absolute -right-8 -top-8 h-24 w-24 rounded-full"
								style={`background: ${style.accent};`}
							></div>
							<div
								class="absolute bottom-3 right-5 h-8 w-12 rounded-full blur-sm"
								style={`background: ${style.accent};`}
							></div>
							<div class="relative">
								<div class="flex items-center justify-between text-xs opacity-80">
									<span>card.baily.life</span>
									<span>{style.label}</span>
								</div>
								<p class="mt-10 text-lg font-semibold">{style.name}</p>
								<p class="mt-3 font-mono text-sm tracking-[0.35em] opacity-80">•••• 0318</p>
							</div>
						</div>
					{/each}
				</div>
			{:else}
				<div class="space-y-3">
					{#each data.cards as card}
						<article class="rounded-xl border border-gray-200 bg-white p-4">
							<div
								class="relative mb-4 overflow-hidden rounded-2xl p-4 shadow-sm"
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
								<div class="relative">
									<div class="flex items-center justify-between text-xs opacity-80">
										<span>{card.bank_name ?? 'card.baily.life'}</span>
										<span>{card.cardStyle.label}</span>
									</div>
									<h3 class="mt-10 text-lg font-semibold">{card.displayName}</h3>
									<p class="mt-3 font-mono text-sm tracking-[0.35em] opacity-80">•••• {card.last_four}</p>
								</div>
							</div>

							<div class="flex items-start justify-between gap-3">
								<div>
									<h3 class="font-medium text-gray-900">{card.displayName}</h3>
									<p class="mt-1 text-xs text-gray-400">
										{card.card_tier ?? '自定义'} · 尾号 {card.last_four}
									</p>
								</div>
								{#if card.isDemo}
									<span class="shrink-0 rounded-full bg-amber-50 px-2 py-1 text-xs font-medium text-amber-700">
										演示
									</span>
								{:else}
									<a
										href={`/cards/${card.id}/edit`}
										class="shrink-0 text-sm font-medium text-blue-600 hover:text-blue-700"
									>
										编辑
									</a>
								{/if}
							</div>
							<div class="mt-4 grid grid-cols-3 gap-2 text-center text-sm">
								<div class="rounded-lg bg-gray-50 p-3">
									<p class="text-xs text-gray-400">账单日</p>
									<p class="mt-1 font-semibold text-gray-900">{card.statement_day} 日</p>
								</div>
								<div class="rounded-lg bg-gray-50 p-3">
									<p class="text-xs text-gray-400">还款日</p>
									<p class="mt-1 font-semibold text-gray-900">{card.due_day} 日</p>
								</div>
								<div class="rounded-lg bg-gray-50 p-3">
									<p class="text-xs text-gray-400">提前提醒</p>
									<p class="mt-1 font-semibold text-gray-900">{card.lead_days} 天</p>
								</div>
							</div>
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
					{#each data.reminders as reminder}
						<div class="flex items-center justify-between gap-4 border-b border-gray-100 p-4 last:border-b-0">
							<div>
								<p class="text-sm font-medium text-gray-900">
									{reminder.cardName} · {reminder.typeLabel}
								</p>
								<p class="mt-1 text-xs text-gray-400">
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
			{/if}
		</section>

		{#if data.user}
			<div class="mt-4 text-center text-xs text-gray-400">当前登录邮箱：{data.user.email}</div>
		{:else}
			<div class="mt-4 text-center text-xs text-gray-400">开放测试版：当前使用公共测试用户</div>
		{/if}
	</main>
</div>
