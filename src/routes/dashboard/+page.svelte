<script lang="ts">
	import { page } from '$app/state';
	import { onMount } from 'svelte';
	import { SignOutButton } from 'svelte-clerk';
	import CardFace from '$lib/components/CardFace.svelte';
	import MobileBottomNav from '$lib/components/MobileBottomNav.svelte';
	import type { PageData } from './$types';

	let { data }: { data: PageData } = $props();

	let cardSaved = $derived(page.url.searchParams.get('card_saved') === '1');
	let featuredCards = $derived(data.featuredCards);
	let cardSearch = $state('');
	let selectedCountry = $state('全部地区');
	let selectedBank = $state('全部银行');
	let recommendationSeed = $state(1);

	onMount(() => {
		recommendationSeed = Date.now() ^ Math.floor(Math.random() * 0x7fffffff);
	});

	function seededRandom(seed: number) {
		let value = seed >>> 0;
		return () => {
			value += 0x6d2b79f5;
			let result = value;
			result = Math.imul(result ^ (result >>> 15), result | 1);
			result ^= result + Math.imul(result ^ (result >>> 7), result | 61);
			return ((result ^ (result >>> 14)) >>> 0) / 4294967296;
		};
	}
	const countryLabels: Record<string, string> = {
		CN: '中国大陆',
		HK: '中国香港',
		US: '美国',
		JP: '日本',
		TW: '中国台湾'
	};
	const countryOrder = ['中国大陆', '中国香港', '中国台湾', '日本', '美国'];
	function displayCountry(country: string | null | undefined) {
		return country ? countryLabels[country] ?? country : '未知地区';
	}
	function featuredMetric(card: PageData['featuredCards'][number]) {
		return card.metrics[0] ?? { label: '奖励收益', value: '1500 元' };
	}
	let cardCountries = $derived([
		'全部地区',
		...countryOrder
	]);
	let countryFilteredCards = $derived(
		data.cards.filter((card) => selectedCountry === '全部地区' || displayCountry(card.country) === selectedCountry)
	);
	let cardBanks = $derived([
		'全部银行',
		...Array.from(new Set(countryFilteredCards.map((card) => card.bank_name).filter(Boolean))).sort()
	]);
	$effect(() => {
		selectedCountry;
		if (!cardBanks.includes(selectedBank)) {
			selectedBank = '全部银行';
		}
	});
	let visibleCards = $derived(
		countryFilteredCards.filter((card) => {
			const keyword = cardSearch.trim().toLowerCase();
			const matchesBank = selectedBank === '全部银行' || card.bank_name === selectedBank;
			const matchesSearch =
				!keyword ||
				`${displayCountry(card.country)} ${card.bank_name ?? ''} ${card.card_name ?? ''} ${card.card_tier ?? ''} ${card.network ?? ''} ${card.tags ?? ''} ${card.last_four}`
					.toLowerCase()
					.includes(keyword);
			return matchesBank && matchesSearch;
			})
	);
	type DashboardGridItem =
		| { kind: 'featured'; key: string; card: PageData['featuredCards'][number] }
		| { kind: 'saved'; key: string; card: PageData['cards'][number] };
	let mixedCards = $derived.by(() => {
		const random = seededRandom(recommendationSeed);
		const savedItems: DashboardGridItem[] = visibleCards.map((card) => ({
			kind: 'saved',
			key: `saved-${card.id}`,
			card
		}));
		const featuredItems: DashboardGridItem[] = featuredCards
			.map((card) => ({
				kind: 'featured' as const,
				key: `featured-${card.id}`,
				card
			}))
			.sort(() => random() - 0.5)
			.slice(0, 3);

		if (savedItems.length === 0) return featuredItems;
		if (featuredItems.length === 0) return savedItems;

		const result = [...savedItems];
		featuredItems.forEach((item) => {
			const firstAllowedSlot = Math.min(2, result.length);
			const slot = firstAllowedSlot + Math.floor(random() * (result.length - firstAllowedSlot + 1));
			result.splice(slot, 0, item);
		});
		return result;
	});

	const remindersPerPage = 8;
	let reminderPage = $state(1);
	let totalReminderPages = $derived(Math.max(1, Math.ceil(data.reminders.length / remindersPerPage)));
	let pagedReminders = $derived(
		data.reminders.slice((reminderPage - 1) * remindersPerPage, reminderPage * remindersPerPage)
	);
	let reminderStart = $derived(data.reminders.length === 0 ? 0 : (reminderPage - 1) * remindersPerPage + 1);
	let reminderEnd = $derived(Math.min(reminderPage * remindersPerPage, data.reminders.length));
	let expandedCardIds = $state<Set<string | number>>(new Set());
	let closestDueReminder = $derived(
		data.reminders.find((reminder) => reminder.typeLabel === '还款日') ?? data.reminders[0] ?? null
	);
	let mobileReminders = $derived(closestDueReminder ? [closestDueReminder] : []);

	function toggleCardDetails(cardId: string | number) {
		expandedCardIds = new Set(expandedCardIds);
		if (expandedCardIds.has(cardId)) {
			expandedCardIds.delete(cardId);
		} else {
			expandedCardIds.add(cardId);
		}
	}

</script>

<svelte:head>
	<title>我的卡片 — 贝利卡管家</title>
</svelte:head>

<div class="bls-page app-shell">
	<header class="app-shell-topbar dashboard-card-topbar">
		<div class="flex min-w-0 items-center gap-2.5">
			<img src="/images/brand/logo-mark.svg" alt="" class="h-9 w-9 shrink-0" />
			<div class="app-shell-title min-w-0">
				<p class="truncate">我的卡片</p>
				<p class="truncate">{data.cards.length} 张卡 · {data.reminders.length} 条提醒</p>
			</div>
		</div>
		<a href="/cards/add" class="bls-btn shrink-0 px-3 py-2 text-xs">添加</a>
	</header>

	<header class="bls-nav dashboard-nav-shell fixed inset-x-0 top-0 z-50">
		<div class="mx-auto flex max-w-7xl flex-wrap items-center justify-between gap-3 px-4 py-3 sm:px-6 sm:py-4">
			<a href="/dashboard" class="flex items-center gap-3">
				<img src="/images/brand/logo-mark.svg" alt="" class="h-10 w-10 shrink-0" />
				<div>
					<p class="text-base font-black text-white">贝利卡管家</p>
					<p class="text-xs text-[var(--bls-muted)]">账单日、还款日、年费日</p>
				</div>
			</a>
			<div class="dashboard-actions flex shrink-0 items-center gap-2 sm:gap-3">
				<details class="group relative">
					<summary class="bls-btn-ghost cursor-pointer list-none px-4 py-2 text-sm font-semibold hover:border-[var(--bls-cyan)] hover:text-[var(--bls-cyan)]">
						我的
					</summary>
					<div class="dashboard-account-menu bls-panel absolute right-0 mt-2 w-48 overflow-hidden p-2 text-sm">
						<div class="border-b-2 border-white/10 px-3 py-2">
							<p class="bls-label text-[var(--bls-gold-bright)]">Account</p>
							<p class="mt-1 truncate text-xs text-[var(--bls-muted)]">{data.user?.email ?? '个人中心'}</p>
						</div>
						<a href="https://baily.life/" target="_blank" rel="noreferrer" class="dashboard-menu-mobile-link mt-2 border-2 border-transparent px-3 py-2 text-[var(--bls-body)] hover:border-[var(--bls-cyan)] hover:bg-white/5 hover:text-white">贝利主页</a>
						<a href="/lounges" class="dashboard-menu-mobile-link border-2 border-transparent px-3 py-2 text-[var(--bls-body)] hover:border-[var(--bls-cyan)] hover:bg-white/5 hover:text-white">贵宾厅清单</a>
						<a href="https://wx.zsxq.com/group/15555858118552" target="_blank" rel="noreferrer" class="dashboard-menu-mobile-link border-2 border-transparent px-3 py-2 text-[var(--bls-body)] hover:border-[var(--bls-cyan)] hover:bg-white/5 hover:text-white">知识星球</a>
						<a href="/me" class="mt-2 block border-2 border-transparent px-3 py-2 text-[var(--bls-body)] hover:border-[var(--bls-cyan)] hover:bg-white/5 hover:text-white">我的信息</a>
						{#if data.isAdmin}
							<a href="/admin/catalog" class="block border-2 border-transparent px-3 py-2 text-[var(--bls-body)] hover:border-[var(--bls-cyan)] hover:bg-white/5 hover:text-white">卡库管理</a>
							<a href="/admin/featured" class="block border-2 border-transparent px-3 py-2 text-[var(--bls-body)] hover:border-[var(--bls-cyan)] hover:bg-white/5 hover:text-white">首页推荐</a>
						{/if}
						{#if data.localMock}
							<a
								href="/"
								class="block w-full border-2 border-transparent px-3 py-2 text-left text-[var(--bls-muted)] hover:border-[var(--bls-red)] hover:bg-white/5 hover:text-white"
							>
								退出模拟登录
							</a>
						{:else}
						<SignOutButton redirectUrl="/">
							{#snippet children({ signOut })}
								<button
									type="button"
									class="block w-full border-2 border-transparent px-3 py-2 text-left text-[var(--bls-muted)] hover:border-[var(--bls-red)] hover:bg-white/5 hover:text-white"
									onclick={async () => {
										try {
											await fetch('/logout', {
												method: 'POST',
												headers: { accept: 'application/json' }
											});
										} catch {
											// ignore network errors; still sign out of Clerk
										}
										signOut();
									}}
								>
									退出
								</button>
							{/snippet}
						</SignOutButton>
						{/if}
					</div>
				</details>
			</div>
			<div class="dashboard-nav-links items-center gap-2">
				<a
					href="https://baily.life/"
					target="_blank"
					rel="noreferrer"
					class="bls-nav-link"
				>
					贝利主页
				</a>
				<a href="/lounges" class="bls-nav-link">
					贵宾厅
				</a>
				<a
					href="https://wx.zsxq.com/group/15555858118552"
					target="_blank"
					rel="noreferrer"
					class="bls-nav-link"
				>
					知识星球
				</a>
			</div>
		</div>
	</header>

	<main class="dashboard-main app-shell-main relative mx-auto max-w-7xl px-4 pb-5 pt-24 sm:px-6 sm:pb-8 sm:pt-28">
		{#if cardSaved}
			<div class="mb-6 border-2 border-[var(--bls-green)] bg-[rgba(77,240,138,0.12)] p-4 text-sm font-semibold text-emerald-100">
				卡片已保存，提醒设置已经加入你的卡片列表。
			</div>
		{/if}

		{#if data.configMissing}
			<div class="mb-6 border-2 border-[var(--bls-gold)] bg-[rgba(232,181,61,0.13)] p-4 text-sm text-[var(--bls-gold-bright)]">
				数据连接暂时不可用，稍后刷新后会展示已保存的卡片。
			</div>
		{/if}

		<section class="app-reminder-mobile-only mb-5">
			<div class="mb-2 flex items-center justify-between">
				<div>
					<p class="bls-label text-[var(--bls-gold-bright)]">Next Payment</p>
					<h2 class="mt-0.5 text-base font-black text-white">最近还款</h2>
				</div>
				<span class="text-xs font-bold text-[var(--bls-cyan)]">30 天内</span>
			</div>
			{#if mobileReminders.length === 0}
				<div class="rounded-lg border-2 border-white/5 bg-white/[0.04] px-3 py-3 text-xs text-[var(--bls-muted)]">
					暂无还款提醒，添加卡片后会自动出现。
				</div>
			{:else}
				<div class="app-reminder-strip">
					{#each mobileReminders as reminder}
						<a href="/reminders" class="app-reminder-chip">
							<strong class="line-clamp-1">{reminder.catalogName ?? reminder.cardName}</strong>
							<span class="line-clamp-1">{reminder.typeLabel} · 尾号 {reminder.lastFour}</span>
							<em>{reminder.daysUntilTarget} 天后 · {reminder.targetDate}</em>
							<b aria-hidden="true">›</b>
						</a>
					{/each}
				</div>
			{/if}
		</section>

		<div class="grid gap-6 xl:grid-cols-[minmax(0,1fr)_360px] xl:gap-8">
			<section>
				<div class="mb-4 flex items-center justify-between">
					<div>
						<p class="bls-label text-[var(--bls-cyan)]">Card Desk</p>
						<h1 class="mt-1 text-xl font-black text-white">我的卡片</h1>
					</div>
					<a href="/cards/add" class="bls-btn hidden px-3 py-2 text-xs sm:inline-flex sm:text-sm md:inline-flex">
						添加信用卡
					</a>
				</div>

				{#if data.cards.length === 0}
					<div class="mobile-saved-cards-empty bls-panel p-8 text-center">
						<p class="text-sm text-[var(--bls-muted)]">还没有添加信用卡</p>
						<a href="/cards/add" class="bls-btn mt-5 px-4 py-2 text-sm">添加卡片</a>
					</div>
				{/if}

				{#if data.cards.length === 0 && featuredCards.length === 0}
					<div class="bls-panel p-10 text-center">
						<p class="text-sm text-[var(--bls-muted)]">还没有卡片</p>
						<a href="/cards/add" class="bls-btn mt-5 px-4 py-2 text-sm">添加卡片</a>
					</div>
				{:else}
					{#if data.cards.length > 6}
						<div class="bls-panel mb-5 hidden p-3 lg:block">
							<div class="grid gap-3 md:grid-cols-[minmax(0,1fr)_150px_150px]">
								<input
									bind:value={cardSearch}
									type="search"
									placeholder="搜索卡名、银行、尾号"
									class="bls-input w-full px-3 py-2 text-sm"
								/>
								<select bind:value={selectedCountry} class="bls-input px-3 py-2 text-sm">
									{#each cardCountries as country}
										<option value={country}>{country}</option>
									{/each}
								</select>
								<select bind:value={selectedBank} class="bls-input px-3 py-2 text-sm">
									{#each cardBanks as bank}
										<option value={bank}>{bank}</option>
									{/each}
								</select>
							</div>
						</div>
						<details class="bls-panel mb-4 p-3 lg:hidden">
							<summary class="flex cursor-pointer list-none items-center justify-between text-sm font-black text-white">
								<span>筛选卡片</span>
								<span class="text-xs text-[var(--bls-muted)]">{visibleCards.length} 张</span>
							</summary>
							<div class="mt-3 grid gap-3">
								<input
									bind:value={cardSearch}
									type="search"
									placeholder="搜索卡名、银行、尾号"
									class="bls-input w-full px-3 py-2 text-sm"
								/>
								<select bind:value={selectedCountry} class="bls-input px-3 py-2 text-sm">
									{#each cardCountries as country}
										<option value={country}>{country}</option>
									{/each}
								</select>
								<select bind:value={selectedBank} class="bls-input px-3 py-2 text-sm">
									{#each cardBanks as bank}
										<option value={bank}>{bank}</option>
									{/each}
								</select>
							</div>
						</details>
					{/if}

						<div class="grid gap-3 lg:grid-cols-3 lg:gap-5">
							{#each mixedCards as item (item.key)}
								{#if item.kind === 'featured'}
									<a
										href={item.card.href}
										class="dashboard-featured-card-mobile group bls-card grid grid-cols-[112px_minmax(0,1fr)] items-center gap-3 p-2 lg:hidden"
									>
										<div class="relative overflow-hidden rounded-xl border-2 border-white/10 bg-[var(--bls-inset)]">
											<img
												src={item.card.image}
												alt={item.card.alt}
												class="aspect-[1.586] w-full object-cover"
												loading="lazy"
											/>
											<span class="bls-rec-badge bls-rec-badge-compact">推荐</span>
										</div>
										<div class="min-w-0">
											<p class="text-xs font-bold text-[var(--bls-cyan)]">{item.card.bank}</p>
											<h3 class="mt-1 line-clamp-2 text-sm font-bold leading-5 text-white group-hover:text-[var(--bls-cyan)]">{item.card.name}</h3>
											<p class="mt-1 text-xs font-black text-[var(--bls-gold-bright)]">
												{featuredMetric(item.card).label} {featuredMetric(item.card).value}
											</p>
										</div>
									</a>
									<a
										href={item.card.href}
										class="group bls-feature-card relative hidden p-2 lg:block lg:p-3"
									>
										<div class="relative">
											<div class="relative overflow-hidden rounded-[4px] border-2 border-white/10 bg-[var(--bls-inset)]">
												<img
													src={item.card.image}
													alt={item.card.alt}
													class="aspect-[1.586] w-full object-cover"
													loading="lazy"
												/>
												<span class="bls-rec-badge">推荐</span>
											</div>
											<div class="relative mt-3 min-w-0">
												<p class="text-xs font-bold text-[var(--bls-cyan)]">{item.card.bank}</p>
												<h3 class="mt-1 line-clamp-1 text-base font-black text-white group-hover:text-[var(--bls-gold-bright)]">{item.card.name}</h3>
												<p class="mt-2 text-sm font-black text-[var(--bls-gold-bright)]">
													{featuredMetric(item.card).label} {featuredMetric(item.card).value}
												</p>
												<span class="bls-btn mt-3 px-3 py-2 text-xs">
													立即办卡
												</span>
											</div>
										</div>
									</a>
								{:else}
									<article class="group bls-card p-2 lg:p-3">
										<a
											href={item.card.isDemo ? '/dashboard' : `/cards/${item.card.id}/edit`}
											class="grid grid-cols-[112px_minmax(0,1fr)] items-center gap-3 lg:block"
										>
											<CardFace
												imageUrl={item.card.image_url}
												bankName={item.card.bank_name}
												displayName={item.card.displayName}
												lastFour={item.card.last_four}
												cardStyle={item.card.cardStyle}
												class="rounded-xl"
											/>

											<div class="min-w-0 lg:mt-4">
												<h3 class="line-clamp-2 text-sm font-bold leading-5 text-white group-hover:text-[var(--bls-cyan)] lg:line-clamp-1 lg:text-base">{item.card.displayName}</h3>
												<p class="mt-1 text-xs text-[var(--bls-muted)] lg:text-sm">{displayCountry(item.card.country)} · {item.card.card_tier ?? '标准卡'} · 尾号 {item.card.last_four}</p>
											</div>
										</a>
										<button
											type="button"
											onclick={() => toggleCardDetails(item.card.id)}
											class="mt-2 hidden w-full rounded-[4px] border-2 border-white/5 bg-white/[0.04] px-3 py-2 text-left text-xs text-[var(--bls-muted)] transition hover:border-[var(--bls-cyan)] hover:text-[var(--bls-cyan)] lg:mt-3 lg:block"
											aria-expanded={expandedCardIds.has(item.card.id)}
										>
											<span class="flex items-center justify-between gap-3">
												<span class="min-w-0 truncate">查看详情</span>
												<span class={`shrink-0 text-sm transition ${expandedCardIds.has(item.card.id) ? 'rotate-180' : ''}`}>⌄</span>
											</span>
										</button>
										{#if expandedCardIds.has(item.card.id)}
											<div class="mt-2 grid grid-cols-3 gap-2 text-center text-xs">
												<div class="rounded-[4px] border-2 border-white/5 bg-white/[0.04] px-2 py-3">
													<p class="text-[var(--bls-muted)]">账单</p>
													<p class="mt-1 font-bold text-white">{item.card.statement_day} 日</p>
												</div>
												<div class="rounded-[4px] border-2 border-white/5 bg-white/[0.04] px-2 py-3">
													<p class="text-[var(--bls-muted)]">还款</p>
													<p class="mt-1 font-bold text-white">{item.card.due_day} 日</p>
												</div>
												<div class="rounded-[4px] border-2 border-white/5 bg-white/[0.04] px-2 py-3">
													<p class="text-[var(--bls-muted)]">提前</p>
													<p class="mt-1 font-bold text-white">{item.card.lead_days} 天</p>
												</div>
											</div>
										{/if}
									</article>
								{/if}
							{/each}
							{#if data.cards.length > 0 && visibleCards.length === 0}
								<div class="bls-panel p-8 text-center sm:col-span-2 lg:col-span-3">
								<p class="text-sm text-[var(--bls-muted)]">没有找到匹配的卡片。</p>
								<button
									type="button"
									class="bls-btn-ghost mt-4 px-4 py-2 text-sm"
									onclick={() => {
										cardSearch = '';
										selectedCountry = '全部地区';
										selectedBank = '全部银行';
									}}
								>
									清空筛选
								</button>
							</div>
						{/if}
					</div>
				{/if}

				<a
					href="https://wx.zsxq.com/group/15555858118552"
					target="_blank"
					rel="noreferrer"
					class="dashboard-ad-card dashboard-ad-card-planet dashboard-card-list-planet"
				>
					<span class="min-w-0">
						<span class="bls-label text-[var(--bls-gold-bright)]">Knowledge Planet</span>
						<span class="mt-1 block text-base font-black text-white">加入贝利知识星球</span>
						<span class="mt-1 block text-xs leading-5 text-[var(--bls-muted)]">信用卡、积分与权益玩法，一起交流。</span>
					</span>
					<span class="dashboard-ad-cta">立即加入</span>
				</a>
			</section>

			<aside id="reminders" class="dashboard-reminders-aside">
				<div class="dashboard-right-rail space-y-4">
					<div class="bls-panel dashboard-reminders-panel overflow-hidden p-5">
						<div class="flex items-center justify-between">
							<div>
								<h2 class="text-lg font-bold text-white">未来 30 天</h2>
								<p class="mt-1 text-sm text-[var(--bls-muted)]">临近账单和还款提醒</p>
							</div>
							<span class="bls-chip-active px-3 py-1 text-xs font-semibold">{data.reminders.length} 条</span>
						</div>

						{#if data.reminders.length === 0}
							<div class="mt-5 rounded-[4px] border-2 border-white/5 bg-white/[0.04] p-4 text-sm text-[var(--bls-muted)]">暂无 30 天内提醒。</div>
						{:else}
							<div class="dashboard-reminders-list mt-5 divide-y divide-white/10 overflow-y-auto pr-1">
								{#each pagedReminders as reminder}
									<div class="flex items-start justify-between gap-4 py-4">
										<div class="min-w-0">
											<p class="line-clamp-1 text-sm font-semibold text-white">{reminder.catalogName ?? reminder.cardName}</p>
											<p class="mt-1 text-xs text-[var(--bls-muted)]">{reminder.typeLabel} · 尾号 {reminder.lastFour}</p>
										</div>
										<div class="shrink-0 text-right">
											<p class="text-sm font-bold text-[var(--bls-gold-bright)]">{reminder.daysUntilTarget} 天后</p>
											<p class="mt-1 text-xs text-[var(--bls-muted)]">{reminder.targetDate}</p>
										</div>
									</div>
								{/each}
							</div>
							{#if data.reminders.length > remindersPerPage}
								<div class="mt-4 flex items-center justify-between border-t border-white/10 pt-4 text-xs text-[var(--bls-muted)]">
									<p>{reminderStart}-{reminderEnd} / {data.reminders.length}</p>
									<div class="flex items-center gap-2">
										<button
											type="button"
											disabled={reminderPage === 1}
											onclick={() => (reminderPage = Math.max(1, reminderPage - 1))}
											class="bls-btn-ghost px-3 py-1.5 font-semibold disabled:cursor-not-allowed disabled:opacity-40"
										>
											上一页
										</button>
										<button
											type="button"
											disabled={reminderPage === totalReminderPages}
											onclick={() => (reminderPage = Math.min(totalReminderPages, reminderPage + 1))}
											class="bls-btn-ghost px-3 py-1.5 font-semibold disabled:cursor-not-allowed disabled:opacity-40"
										>
											下一页
										</button>
									</div>
								</div>
							{/if}
						{/if}
					</div>

					<div class="dashboard-ad-stack grid gap-3">
						<a
							href="https://wx.zsxq.com/group/15555858118552"
							target="_blank"
							rel="noreferrer"
							class="dashboard-ad-card dashboard-ad-card-planet"
						>
							<span class="min-w-0">
								<span class="bls-label text-[var(--bls-gold-bright)]">Knowledge Planet</span>
								<span class="mt-1 block text-lg font-black text-white">加入贝利知识星球</span>
								<span class="mt-1 block text-xs leading-5 text-[var(--bls-muted)]">和 1500 位小伙伴一起玩卡，系统整理信用卡、积分和权益玩法。</span>
							</span>
							<span class="dashboard-ad-cta">立即加入</span>
						</a>
					</div>
				</div>
			</aside>
		</div>
	</main>

	<MobileBottomNav />
</div>
