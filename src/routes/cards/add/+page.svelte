<script lang="ts">
	import CardFace from '$lib/components/CardFace.svelte';
	import type { ActionData, PageData } from './$types';
	let { data, form }: { data: PageData; form: ActionData } = $props();

	type RequestValues = {
		bankName: string;
		cardName: string;
		cardTier: string;
		notes: string;
	};

	const emptyRequestValues: RequestValues = { bankName: '', cardName: '', cardTier: '', notes: '' };

	function isRequestValues(value: unknown): value is RequestValues {
		return (
			!!value &&
			typeof value === 'object' &&
			'bankName' in value &&
			'cardName' in value &&
			'cardTier' in value &&
			'notes' in value
		);
	}

	let search = $state('');
	let selectedCountry = $state('全部地区');
	let selectedType = $state('全部类型');
	let selectedBank = $state('全部银行');
	let selectedNetwork = $state('全部卡组织');
	let selectedTier = $state('全部等级');
	let currentPage = $state(1);
	let showNotificationWarning = $state(false);
	const cardsPerPage = 12;
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
	function displayCardType(tags: string | null | undefined) {
		if (tags?.includes('借记卡')) return '借记卡';
		if (tags?.includes('信用卡')) return '信用卡';
		return '其它';
	}
	function normalizeNetwork(network: string | null | undefined) {
		const value = network?.trim();
		if (!value) return null;
		const upper = value.toUpperCase();
		if (upper === 'VISA') return 'Visa';
		if (upper === 'MASTERCARD') return 'Mastercard';
		if (upper === 'AMEX' || upper === 'AMERICAN EXPRESS') return 'American Express';
		if (upper === 'UNIONPAY') return '银联';
		if (upper === 'JCB') return 'JCB';
		return value;
	}
	let regionCatalog = $derived(
		selectedCountry === '全部地区'
			? data.catalog
			: data.catalog.filter((card) => displayCountry(card.country) === selectedCountry)
	);
	let countries = $derived([
		'全部地区',
		...countryOrder
	]);
	let cardTypes = $derived([
		'全部类型',
		...Array.from(new Set(data.catalog.map((card) => displayCardType(card.tags)))).sort()
	]);
	let banks = $derived([
		'全部银行',
		...Array.from(new Set(regionCatalog.map((card) => card.bank_name))).sort((a, b) => a.localeCompare(b, 'zh-Hans-CN'))
	]);
	let networks = $derived([
		'全部卡组织',
		...Array.from(
			new Set(regionCatalog.map((card) => normalizeNetwork(card.network)).filter((network): network is string => !!network))
		).sort((a, b) => a.localeCompare(b, 'zh-Hans-CN'))
	]);
	let tiers = $derived([
		'全部等级',
		...Array.from(
			new Set(data.catalog.map((card) => card.card_tier).filter((tier): tier is string => !!tier))
		).sort()
	]);
	let filteredCatalog = $derived(
		data.catalog.filter((card) => {
			const keyword = search.trim().toLowerCase();
			const matchesCountry = selectedCountry === '全部地区' || displayCountry(card.country) === selectedCountry;
			const matchesType = selectedType === '全部类型' || displayCardType(card.tags) === selectedType;
			const matchesBank = selectedBank === '全部银行' || card.bank_name === selectedBank;
			const matchesNetwork = selectedNetwork === '全部卡组织' || normalizeNetwork(card.network) === selectedNetwork;
			const matchesTier = selectedTier === '全部等级' || card.card_tier === selectedTier;
			const matchesSearch =
				!keyword ||
				`${displayCountry(card.country)} ${card.bank_name} ${card.card_name} ${card.card_tier ?? ''} ${card.network ?? ''} ${card.tags ?? ''}`
					.toLowerCase()
					.includes(keyword);
			return matchesCountry && matchesType && matchesBank && matchesNetwork && matchesTier && matchesSearch;
		})
	);
	let totalPages = $derived(Math.max(1, Math.ceil(filteredCatalog.length / cardsPerPage)));
	let visibleCatalog = $derived(
		filteredCatalog.slice((currentPage - 1) * cardsPerPage, currentPage * cardsPerPage)
	);
	let pageStart = $derived(filteredCatalog.length === 0 ? 0 : (currentPage - 1) * cardsPerPage + 1);
	let pageEnd = $derived(Math.min(currentPage * cardsPerPage, filteredCatalog.length));

	$effect(() => {
		search;
		selectedCountry;
		selectedType;
		selectedBank;
		selectedNetwork;
		selectedTier;
		currentPage = 1;
	});

	$effect(() => {
		if (!banks.includes(selectedBank)) selectedBank = '全部银行';
		if (!networks.includes(selectedNetwork)) selectedNetwork = '全部卡组织';
	});

	$effect(() => {
		if (currentPage > totalPages) currentPage = totalPages;
	});

	let requestValues = $derived(
		form && 'requestValues' in form && isRequestValues(form.requestValues)
			? form.requestValues
			: emptyRequestValues
	);
	let shouldOpenRequest = $derived(
		!!form &&
			(('requestError' in form && !!form.requestError) ||
				('requestSuccess' in form && !!form.requestSuccess))
	);

	type CatalogVariant = { label: string; imageUrl: string | null };

	function parseVariants(json: string | null | undefined): CatalogVariant[] {
		if (!json) return [];
		try {
			const arr = JSON.parse(json);
			return Array.isArray(arr) ? arr : [];
		} catch { return []; }
	}

	function getCardImages(card: PageData['catalog'][number]): string[] {
		const imgs: string[] = [];
		if (card.image_url) imgs.push(card.image_url);
		for (const v of parseVariants((card as { variants?: string | null }).variants ?? null)) {
			if (v.imageUrl) imgs.push(v.imageUrl);
		}
		return imgs;
	}

	let selectedCardId = $state<number | null>(null);
	let variantIndexes = $state<Record<number, number>>({});

	function stepVariant(cardId: number, delta: number, total: number, event: MouseEvent) {
		event.preventDefault();
		event.stopPropagation();
		const cur = variantIndexes[cardId] ?? 0;
		variantIndexes = { ...variantIndexes, [cardId]: (cur + delta + total) % total };
	}

	let selectedImageUrl = $derived(() => {
		if (!selectedCardId) return '';
		const card = data.catalog.find((c) => c.id === selectedCardId);
		if (!card) return '';
		const imgs = getCardImages(card);
		return imgs[variantIndexes[selectedCardId] ?? 0] ?? '';
	});

	function handleAddCardSubmit(event: SubmitEvent) {
		if (data.hasNotificationChannel) return;
		event.preventDefault();
		showNotificationWarning = true;
	}
</script>

<svelte:head>
	<title>添加卡片 — card.baily.life</title>
</svelte:head>

<main class="bls-page px-4 py-6 sm:px-6 sm:py-8">
	<div class="relative mx-auto max-w-7xl">
		<div>
			<a href="/dashboard" class="text-sm font-semibold text-[var(--bls-cyan)] hover:text-[var(--bls-gold-bright)]">← 返回我的卡片</a>
			<h1 class="mt-3 text-3xl font-black tracking-tight text-white">添加卡片</h1>
			<p class="mt-2 text-sm text-[var(--bls-muted)]">先从卡片库选择卡面，再在右侧填写提醒信息。</p>
		</div>

		{#if form?.error}
			<div class="mt-4 border-2 border-[var(--bls-red)] bg-[rgba(255,90,90,0.13)] p-4 text-sm text-red-200">
				{form.error}
			</div>
		{/if}

		{#if data.configMissing}
			<div class="mt-4 border-2 border-[var(--bls-gold)] bg-[rgba(232,181,61,0.13)] p-4 text-sm text-[var(--bls-gold-bright)]">
				当前运行环境没有 D1 绑定，无法保存卡片。
			</div>
		{/if}

		<form method="POST" action="?/addCard" class="mt-6 grid items-start gap-6 lg:grid-cols-[minmax(0,1fr)_420px]" onsubmit={handleAddCardSubmit}>
			<section class="bls-panel p-5 sm:p-6">
				<div class="flex flex-col gap-3 sm:flex-row sm:items-end sm:justify-between">
					<div>
						<p class="bls-label text-[var(--bls-cyan)]">Card Library</p>
						<h2 class="mt-1 text-xl font-black text-white">选择卡片种类</h2>
					</div>
					<div class="flex flex-wrap items-center gap-2">
						<span class="bls-chip px-3 py-1.5 text-xs font-semibold">{filteredCatalog.length} 张可选</span>
						<a href="#request-card" class="bls-chip-active px-3 py-1.5 text-xs font-bold">
							找不到卡片？提交补充
						</a>
					</div>
				</div>
				<div class="mt-5 grid gap-3">
					<input
						bind:value={search}
						type="search"
						placeholder="搜索银行或卡名"
						class="bls-input w-full px-4 py-3 text-sm"
					/>
					<div class="grid gap-3 sm:grid-cols-2 xl:grid-cols-[120px_120px_minmax(0,1fr)_130px_120px]">
						<select
							bind:value={selectedCountry}
							class="bls-input px-4 py-3 text-sm"
						>
							{#each countries as country}
								<option value={country}>{country}</option>
							{/each}
						</select>
						<select
							bind:value={selectedType}
							class="bls-input px-4 py-3 text-sm"
						>
							{#each cardTypes as type}
								<option value={type}>{type}</option>
							{/each}
						</select>
						<select
							bind:value={selectedBank}
							class="bls-input px-4 py-3 text-sm"
						>
							{#each banks as bank}
								<option value={bank}>{bank}</option>
							{/each}
						</select>
						<select
							bind:value={selectedNetwork}
							class="bls-input px-4 py-3 text-sm"
						>
							{#each networks as network}
								<option value={network}>{network}</option>
							{/each}
						</select>
						<select
							bind:value={selectedTier}
							class="bls-input px-4 py-3 text-sm"
						>
							{#each tiers as tier}
								<option value={tier}>{tier}</option>
							{/each}
						</select>
					</div>
				</div>
				<div class="-mx-1 mt-4 flex gap-2 overflow-x-auto px-1 pb-1 sm:mx-0 sm:flex-wrap sm:overflow-visible sm:px-0 sm:pb-0">
					{#each countries as country}
						<button
							type="button"
							class={`shrink-0 px-3 py-1.5 text-xs font-bold sm:py-1 ${
								selectedCountry === country
									? 'bls-chip-active'
									: 'bls-chip hover:border-[var(--bls-cyan)] hover:text-[var(--bls-cyan)]'
							}`}
							onclick={() => (selectedCountry = country)}
						>
							{country}
						</button>
					{/each}
				</div>
				<div class="-mx-1 mt-2 flex gap-2 overflow-x-auto px-1 pb-1 sm:mx-0 sm:flex-wrap sm:overflow-visible sm:px-0 sm:pb-0">
					{#each cardTypes as type}
						<button
							type="button"
							class={`shrink-0 px-3 py-1.5 text-xs font-bold sm:py-1 ${
								selectedType === type
									? 'bls-chip-active'
									: 'bls-chip hover:border-[var(--bls-cyan)] hover:text-[var(--bls-cyan)]'
							}`}
							onclick={() => (selectedType = type)}
						>
							{type}
						</button>
					{/each}
				</div>
				<div class="-mx-1 mt-2 flex gap-2 overflow-x-auto px-1 pb-1 sm:mx-0 sm:flex-wrap sm:overflow-visible sm:px-0 sm:pb-0">
					{#each networks as network}
						<button
							type="button"
							class={`shrink-0 px-3 py-1.5 text-xs font-bold sm:py-1 ${
								selectedNetwork === network
									? 'bls-chip-active'
									: 'bls-chip hover:border-[var(--bls-cyan)] hover:text-[var(--bls-cyan)]'
							}`}
							onclick={() => (selectedNetwork = network)}
						>
							{network}
						</button>
					{/each}
				</div>
				<div class="mt-5 grid grid-cols-2 gap-3 md:grid-cols-3 xl:gap-4">
					{#each visibleCatalog as card}
						{@const imgs = getCardImages(card)}
						{@const varIdx = variantIndexes[card.id] ?? 0}
						{@const currentImg = imgs[varIdx] ?? null}
						<label class="cursor-pointer">
							<input class="peer sr-only" type="radio" name="catalog_id" value={card.id} bind:group={selectedCardId} />
								<div class="bls-card p-2.5 peer-checked:border-[var(--bls-cyan)] peer-checked:shadow-[var(--bls-ring-cyan)] sm:p-3">
									<div class="relative">
										<CardFace
											imageUrl={currentImg}
											bankName={card.bank_name}
											displayName={card.card_name}
											cardStyle={card.cardStyle}
											class="rounded-xl"
										/>
										{#if imgs.length > 1}
											<div class="absolute inset-0 flex items-center justify-between px-1 pointer-events-none">
												<button type="button" class="pointer-events-auto rounded-full bg-black/40 p-1 text-white hover:bg-black/60" onclick={(e) => stepVariant(card.id, -1, imgs.length, e)}>‹</button>
												<button type="button" class="pointer-events-auto rounded-full bg-black/40 p-1 text-white hover:bg-black/60" onclick={(e) => stepVariant(card.id, 1, imgs.length, e)}>›</button>
											</div>
											<div class="absolute bottom-1.5 left-0 right-0 flex justify-center gap-1">
												{#each imgs as _, i}
													<span class="h-1 w-1 rounded-full {i === varIdx ? 'bg-white' : 'bg-white/40'}"></span>
												{/each}
											</div>
										{/if}
									</div>
									<div class="mt-3 space-y-1">
										<span class="bls-chip inline-flex px-2 py-0.5 text-[10px] font-semibold sm:text-[11px]">
											{displayCountry(card.country)} · {card.bank_name}
										</span>
										<p class="line-clamp-2 text-sm font-bold leading-snug text-white">{card.card_name}</p>
										<p class="text-xs text-[var(--bls-muted)]">{displayCardType(card.tags)} · {normalizeNetwork(card.network) ?? '卡组织未标注'} · {card.card_tier ?? '等级未标注'}</p>
									</div>
								</div>
						</label>
					{/each}
					{#if filteredCatalog.length > 0 && currentPage === totalPages}
						<a
							href="#request-card"
							class="flex min-h-48 flex-col justify-center border-2 border-dashed border-[rgba(47,230,212,0.35)] bg-[rgba(47,230,212,0.06)] p-5 text-sm transition hover:border-[var(--bls-cyan)]"
						>
							<p class="font-semibold text-white">没有更多卡片了？</p>
							<p class="mt-2 leading-6 text-[var(--bls-muted)]">
								如果没有找到心仪的卡片，可以在下方提交银行和卡名，我会尽快补进卡片库。
							</p>
							<span class="bls-chip-active mt-4 inline-flex w-fit px-3 py-1 text-xs font-bold">
								去填写需要的卡
							</span>
						</a>
					{/if}
				</div>
				{#if filteredCatalog.length === 0}
					<div class="mt-4 border-2 border-dashed border-[var(--bls-line-strong)] bg-white/[0.04] p-5 text-sm text-[var(--bls-muted)]">
						没有找到匹配的卡。可以先选“自定义卡片”保存，也可以在页面底部提交给我补充卡片库。
					</div>
				{:else}
					<div class="mt-4 flex items-center justify-between gap-2 border-2 border-white/5 bg-white/[0.04] px-3 py-2 text-xs text-[var(--bls-muted)] sm:text-sm">
						<button
							type="button"
							class="bls-btn-ghost px-3 py-1.5 disabled:cursor-not-allowed disabled:opacity-40 sm:py-2"
							disabled={currentPage === 1}
							onclick={() => (currentPage -= 1)}
						>
							上一页
						</button>
						<span class="text-[var(--bls-muted)]">{pageStart}-{pageEnd} / {filteredCatalog.length}</span>
						<button
							type="button"
							class="bls-btn-ghost px-3 py-1.5 disabled:cursor-not-allowed disabled:opacity-40 sm:py-2"
							disabled={currentPage === totalPages}
							onclick={() => (currentPage += 1)}
						>
							下一页
						</button>
					</div>
				{/if}
			</section>

			<aside class="add-card-panel-aside">
			<div class="add-card-floating-panel space-y-4">
			<section class="bls-panel p-5">
				<div>
					<h2 class="text-base font-black text-white">卡片信息</h2>
					<p class="mt-1 text-xs text-[var(--bls-muted)]">备注名称只在你的卡片列表里显示，方便自己识别。</p>
				</div>
				<div class="mt-4 grid grid-cols-2 gap-3 sm:gap-4">
					<label class="col-span-2 block">
						<span class="text-sm font-medium text-[var(--bls-body)]">备注名称</span>
						<input
							name="custom_name"
							class="bls-input mt-1 w-full px-3 py-2"
							placeholder="例如：日常用招商白金"
						/>
					</label>
					<input type="hidden" name="selected_image_url" value={selectedImageUrl()} />
					<label class="block">
						<span class="text-sm font-medium text-[var(--bls-body)]">卡片尾号</span>
						<input
							name="last_four"
							inputmode="numeric"
							maxlength="4"
							required
							class="bls-input mt-1 w-full px-3 py-2"
							placeholder="1234"
						/>
					</label>
					<label class="block">
						<span class="text-sm font-medium text-[var(--bls-body)]">还款 / 年费提前提醒</span>
						<select
							name="lead_days"
							class="bls-input mt-1 w-full px-3 py-2"
							required
						>
							<option value="0">当天提醒</option>
							<option value="1">提前 1 天</option>
							<option value="3" selected>提前 3 天</option>
							<option value="5">提前 5 天</option>
							<option value="7">提前 7 天</option>
							<option value="10">提前 10 天</option>
							<option value="15">提前 15 天</option>
						</select>
						<p class="mt-1 text-xs text-[var(--bls-muted)]">账单日默认当天提醒，不使用提前天数。</p>
					</label>
				</div>
			</section>

			<section class="bls-panel p-5">
				<div>
					<h2 class="text-base font-black text-white">循环提醒日期</h2>
					<p class="mt-1 text-xs leading-5 text-[var(--bls-muted)]">
						账单日和还款日按每个自然月循环；账单日当天提醒，还款日按上面的提前天数提醒。月末日期按当月日历处理。
					</p>
				</div>
				<div class="mt-4 grid grid-cols-2 gap-3 sm:gap-4">
					<div class="block">
						<div class="flex items-center justify-between">
							<span class="text-sm font-medium text-[var(--bls-body)]">账单日（每月）</span>
							<label class="flex cursor-pointer items-center gap-1.5 text-xs text-[var(--bls-muted)]">
								<input type="hidden" name="remind_statement" value="0" />
								<input type="checkbox" name="remind_statement" value="1" checked class="h-4 w-4 accent-[var(--bls-cyan)]" />
								开启提醒
							</label>
						</div>
						<select
							name="statement_day"
							required
							class="bls-input mt-1 w-full px-3 py-2"
						>
							<option value="">选择账单日</option>
							{#each Array.from({ length: 31 }, (_, index) => index + 1) as day}
								<option value={day}>{day} 日</option>
							{/each}
						</select>
					</div>
					<div class="block">
						<div class="flex items-center justify-between">
							<span class="text-sm font-medium text-[var(--bls-body)]">还款日（每月）</span>
							<label class="flex cursor-pointer items-center gap-1.5 text-xs text-[var(--bls-muted)]">
								<input type="hidden" name="remind_due" value="0" />
								<input type="checkbox" name="remind_due" value="1" checked class="h-4 w-4 accent-[var(--bls-cyan)]" />
								开启提醒
							</label>
						</div>
						<select
							name="due_day"
							required
							class="bls-input mt-1 w-full px-3 py-2"
						>
							<option value="">选择还款日</option>
							{#each Array.from({ length: 31 }, (_, index) => index + 1) as day}
								<option value={day}>{day} 日</option>
							{/each}
						</select>
					</div>
				</div>
			</section>

			<section class="bls-panel p-5">
				<div class="flex items-center justify-between">
					<div>
						<h2 class="text-base font-black text-white">年费提醒（可选）</h2>
						<p class="mt-1 text-xs text-[var(--bls-muted)]">年费通常一年一次，填写月份和日期后，每年提醒一次；不需要就留空。</p>
					</div>
					<label class="flex cursor-pointer items-center gap-1.5 text-xs text-[var(--bls-muted)]">
						<input type="hidden" name="remind_annual_fee" value="0" />
						<input type="checkbox" name="remind_annual_fee" value="1" checked class="h-4 w-4 accent-[var(--bls-gold)]" />
						开启提醒
					</label>
				</div>
				<div class="mt-4 grid grid-cols-2 gap-3 sm:gap-4">
					<label class="block">
						<span class="text-sm font-medium text-[var(--bls-body)]">年费月份</span>
						<select name="annual_fee_month" class="bls-input mt-1 w-full px-3 py-2">
							<option value="">不设置</option>
							{#each Array.from({ length: 12 }, (_, index) => index + 1) as month}
								<option value={month}>{month} 月</option>
							{/each}
						</select>
					</label>
					<label class="block">
						<span class="text-sm font-medium text-[var(--bls-body)]">年费日期</span>
						<select name="annual_fee_day" class="bls-input mt-1 w-full px-3 py-2">
							<option value="">不设置</option>
							{#each Array.from({ length: 31 }, (_, index) => index + 1) as day}
								<option value={day}>{day} 日</option>
							{/each}
						</select>
					</label>
				</div>
			</section>

			<button class="bls-btn w-full px-4 py-4 text-base">
				保存提醒
			</button>
			</div>
			</aside>
		</form>

		{#if showNotificationWarning}
			<div class="fixed inset-0 z-50 flex items-center justify-center bg-black/70 px-4 backdrop-blur-sm">
				<div class="bls-panel w-full max-w-md p-6">
					<div class="flex items-start gap-3">
						<div class="grid h-10 w-10 shrink-0 place-items-center border-2 border-[var(--bls-gold)] bg-[rgba(232,181,61,0.13)] text-xl text-[var(--bls-gold-bright)]">!</div>
						<div>
							<h2 class="text-lg font-semibold text-white">还没有设置通知渠道</h2>
							<p class="mt-2 text-sm leading-6 text-[var(--bls-body)]">
								你还没有填写 Bark、PushPlus 或 Telegram。保存后系统可以记录这张卡，但到期时无法给你发送提醒。请先到“我的”页面配置至少一种通知方式。
							</p>
						</div>
					</div>
					<div class="mt-6 flex flex-col gap-3 sm:flex-row sm:justify-end">
						<button
							type="button"
							class="bls-btn-ghost px-4 py-2 text-sm font-medium"
							onclick={() => (showNotificationWarning = false)}
						>
							先不保存
						</button>
						<a href="/me" class="bls-btn px-4 py-2 text-center text-sm">
							去设置通知
						</a>
					</div>
				</div>
			</div>
		{/if}

			<details id="request-card" class="group bls-panel mt-6 p-5 sm:p-6" open={shouldOpenRequest}>
				<summary class="cursor-pointer list-none">
					<div class="flex flex-col gap-3 sm:flex-row sm:items-start sm:justify-between">
						<div>
							<p class="bls-label text-[var(--bls-cyan)]">Card Request</p>
							<h2 class="mt-1 text-xl font-black text-white">没有找到想添加的卡？</h2>
							<p class="mt-2 text-sm text-[var(--bls-muted)]">提交银行和卡名，我审核后补进卡片库。</p>
						</div>
						<span class="bls-chip-active px-3 py-1.5 text-xs font-bold">
							<span class="group-open:hidden">展开提交</span>
							<span class="hidden group-open:inline">收起表单</span>
						</span>
					</div>
				</summary>
			<div class="mt-5 border-2 border-white/5 bg-white/[0.04] p-4">
				<div class="flex flex-col gap-2 sm:flex-row sm:items-start sm:justify-between">
					<div>
						<h3 class="text-sm font-bold text-white">提交新卡模板</h3>
						<p class="mt-1 text-sm text-[var(--bls-muted)]">
							把银行、卡名和卡等级提交给我。我审核通过后，会把它加入卡片库。
						</p>
					</div>
					<span class="bls-chip w-fit px-3 py-1 text-xs font-bold">待审核入库</span>
				</div>
			</div>

			{#if form && 'requestError' in form && form.requestError}
				<div class="mt-4 border-2 border-[var(--bls-red)] bg-[rgba(255,90,90,0.13)] p-3 text-sm text-red-200">
					{form.requestError}
				</div>
			{/if}
			{#if form && 'requestSuccess' in form && form.requestSuccess}
				<div class="mt-4 border-2 border-[var(--bls-green)] bg-[rgba(77,240,138,0.13)] p-3 text-sm text-emerald-100">
					已提交，我之后会审核并补充到卡片库。
				</div>
			{/if}

			<form method="POST" action="?/requestCard" class="mt-5 space-y-4">
				<div class="grid gap-4 sm:grid-cols-2">
					<label class="block">
						<span class="text-sm font-medium text-[var(--bls-body)]">银行名称</span>
						<input
							name="request_bank_name"
							value={requestValues.bankName}
							placeholder="例如：招商银行"
							class="bls-input mt-1 w-full px-3 py-2"
						/>
					</label>
					<label class="block">
						<span class="text-sm font-medium text-[var(--bls-body)]">卡片名称</span>
						<input
							name="request_card_name"
							value={requestValues.cardName}
							placeholder="例如：经典白金信用卡"
							class="bls-input mt-1 w-full px-3 py-2"
						/>
					</label>
				</div>
				<div class="grid gap-4 sm:grid-cols-2">
					<label class="block">
						<span class="text-sm font-medium text-[var(--bls-body)]">卡片等级（可选）</span>
						<input
							name="request_card_tier"
							value={requestValues.cardTier}
							placeholder="例如：白金 / 金卡 / 普卡"
							class="bls-input mt-1 w-full px-3 py-2"
						/>
					</label>
					<label class="block">
						<span class="text-sm font-medium text-[var(--bls-body)]">补充说明（可选）</span>
						<input
							name="request_notes"
							value={requestValues.notes}
							placeholder="例如：年费、权益、官网链接"
							class="bls-input mt-1 w-full px-3 py-2"
						/>
					</label>
				</div>
				<p class="text-xs leading-5 text-[var(--bls-muted)]">
					后续我会做一个后台审核页，通过后自动进入卡片库；现在先把提交记录保存下来。
				</p>
				<button class="bls-btn px-4 py-2.5 text-sm">
					提交给我审核
				</button>
			</form>
		</details>
	</div>
</main>
