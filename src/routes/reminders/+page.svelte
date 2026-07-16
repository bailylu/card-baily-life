<script lang="ts">
	import MobileBottomNav from '$lib/components/MobileBottomNav.svelte';
	import type { PageData } from './$types';

	let { data }: { data: PageData } = $props();
</script>

<svelte:head>
	<title>未来 30 天提醒 — 贝利卡管家</title>
</svelte:head>

<main class="bls-page app-shell reminders-page">
	<header class="reminders-page-header">
		<a href="/dashboard" aria-label="返回卡片">‹</a>
		<div>
			<h1>未来 30 天</h1>
			<p>{data.reminders.length} 条提醒</p>
		</div>
	</header>

	<div class="reminders-page-main">
		{#if data.configMissing}
			<p class="reminders-empty">数据连接暂时不可用。</p>
		{:else if data.reminders.length === 0}
			<p class="reminders-empty">未来 30 天暂无提醒。</p>
		{:else}
			<div class="reminders-page-list">
				{#each data.reminders as reminder}
					<article>
						<div class="reminder-date-badge">
							<strong>{reminder.daysUntilTarget}</strong>
							<span>天后</span>
						</div>
						<div class="min-w-0">
							<h2>{reminder.catalogName ?? reminder.cardName}</h2>
							<p>{reminder.typeLabel} · 尾号 {reminder.lastFour || '—'}</p>
							<time datetime={reminder.targetDate}>{reminder.targetDate}</time>
						</div>
					</article>
				{/each}
			</div>
		{/if}
	</div>

	<MobileBottomNav active="cards" />
</main>
