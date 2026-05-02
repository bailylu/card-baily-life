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
	let selectedBank = $state('全部银行');
	let currentPage = $state(1);
	let showNotificationWarning = $state(false);
	const cardsPerPage = 10;
	let banks = $derived([
		'全部银行',
		...Array.from(new Set(data.catalog.map((card) => card.bank_name))).sort()
	]);
	let filteredCatalog = $derived(
		data.catalog.filter((card) => {
			const keyword = search.trim().toLowerCase();
			const matchesBank = selectedBank === '全部银行' || card.bank_name === selectedBank;
			const matchesSearch =
				!keyword ||
				`${card.bank_name} ${card.card_name} ${card.card_tier ?? ''} ${card.network ?? ''} ${card.tags ?? ''}`
					.toLowerCase()
					.includes(keyword);
			return matchesBank && matchesSearch;
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
		selectedBank;
		currentPage = 1;
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

<main class="min-h-screen bg-gray-50 px-4 py-8">
	<div class="mx-auto max-w-2xl">
		<a href="/dashboard" class="text-sm text-blue-600 hover:text-blue-700">← 返回我的卡片</a>
		<h1 class="mt-4 text-2xl font-bold text-gray-900">添加卡片</h1>
		<p class="mt-1 text-sm text-gray-500">先从卡片库搜索，也可以提交想添加的新卡。</p>

		{#if form?.error}
			<div class="mt-4 rounded-xl border border-red-200 bg-red-50 p-4 text-sm text-red-700">
				{form.error}
			</div>
		{/if}

		{#if data.configMissing}
			<div class="mt-4 rounded-xl border border-amber-200 bg-amber-50 p-4 text-sm text-amber-700">
				当前运行环境没有 D1 绑定，无法保存卡片。
			</div>
		{/if}

		<form method="POST" action="?/addCard" class="mt-6 space-y-5 rounded-xl border border-gray-200 bg-white p-5" onsubmit={handleAddCardSubmit}>
			<section>
				<div class="flex items-center justify-between gap-3">
					<span class="text-sm font-medium text-gray-700">选择卡片种类</span>
					<a href="#request-card" class="text-xs font-medium text-blue-600 hover:text-blue-700">找不到也可以提交给我补充</a>
				</div>
				<div class="mt-4 grid gap-3 sm:grid-cols-[1fr_auto]">
					<input
						bind:value={search}
						type="search"
						placeholder="搜索银行或卡名，例如 招商、白金、Safari"
						class="w-full rounded-xl border border-gray-200 px-4 py-3 text-sm outline-none focus:border-blue-500 focus:ring-4 focus:ring-blue-100"
					/>
					<select
						bind:value={selectedBank}
						class="rounded-xl border border-gray-200 px-4 py-3 text-sm outline-none focus:border-blue-500 focus:ring-4 focus:ring-blue-100"
					>
						{#each banks as bank}
							<option value={bank}>{bank}</option>
						{/each}
					</select>
				</div>
				<div class="mt-3 flex flex-wrap gap-2">
					{#each banks as bank}
						<button
							type="button"
							class={`rounded-full px-3 py-1 text-xs font-medium ring-1 ${
								selectedBank === bank
									? 'bg-blue-600 text-white ring-blue-600'
									: 'bg-white text-gray-500 ring-gray-200 hover:text-gray-900'
							}`}
							onclick={() => (selectedBank = bank)}
						>
							{bank}
						</button>
					{/each}
				</div>
				<div class="mt-3 grid gap-3 sm:grid-cols-2">
					{#each visibleCatalog as card}
						{@const imgs = getCardImages(card)}
						{@const varIdx = variantIndexes[card.id] ?? 0}
						{@const currentImg = imgs[varIdx] ?? null}
						<label class="cursor-pointer">
							<input class="peer sr-only" type="radio" name="catalog_id" value={card.id} bind:group={selectedCardId} />
								<div class="rounded-2xl border border-gray-200 bg-white p-4 transition peer-checked:border-blue-500 peer-checked:ring-2 peer-checked:ring-blue-100">
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
										<span class="inline-flex rounded-full bg-gray-100 px-2 py-0.5 text-[11px] font-semibold text-gray-500">
											{card.bank_name}
										</span>
										<p class="text-base font-semibold leading-snug text-gray-950">{card.card_name}</p>
									</div>
								</div>
						</label>
					{/each}
					{#if filteredCatalog.length > 0 && currentPage === totalPages}
						<a
							href="#request-card"
							class="flex min-h-48 flex-col justify-center rounded-2xl border border-dashed border-blue-200 bg-blue-50/50 p-5 text-sm transition hover:border-blue-300 hover:bg-blue-50"
						>
							<p class="font-semibold text-gray-900">没有更多卡片了？</p>
							<p class="mt-2 leading-6 text-gray-500">
								如果没有找到心仪的卡片，可以在下方提交银行和卡名，我会尽快补进卡片库。
							</p>
							<span class="mt-4 inline-flex w-fit rounded-full bg-white px-3 py-1 text-xs font-medium text-blue-700 ring-1 ring-blue-100">
								去填写需要的卡
							</span>
						</a>
					{/if}
				</div>
				{#if filteredCatalog.length === 0}
					<div class="mt-4 rounded-2xl border border-dashed border-gray-300 bg-gray-50 p-5 text-sm text-gray-500">
						没有找到匹配的卡。可以先选“自定义卡片”保存，也可以在页面底部提交给我补充卡片库。
					</div>
				{:else}
					<div class="mt-4 flex flex-col gap-3 rounded-2xl bg-gray-50 p-3 text-sm text-gray-500 sm:flex-row sm:items-center sm:justify-between">
						<p>显示 {pageStart}-{pageEnd} / 共 {filteredCatalog.length} 张卡</p>
						<div class="flex items-center gap-2">
							<button
								type="button"
								class="rounded-lg border border-gray-200 bg-white px-3 py-2 disabled:cursor-not-allowed disabled:opacity-40"
								disabled={currentPage === 1}
								onclick={() => (currentPage -= 1)}
							>
								上一页
							</button>
							<span class="px-2 text-gray-400">{currentPage} / {totalPages}</span>
							<button
								type="button"
								class="rounded-lg border border-gray-200 bg-white px-3 py-2 disabled:cursor-not-allowed disabled:opacity-40"
								disabled={currentPage === totalPages}
								onclick={() => (currentPage += 1)}
							>
								下一页
							</button>
						</div>
					</div>
				{/if}
			</section>

			<section class="rounded-2xl bg-gray-50 p-4">
				<div>
					<h2 class="text-sm font-semibold text-gray-900">卡片信息</h2>
					<p class="mt-1 text-xs text-gray-500">备注名称只在你的卡片列表里显示，方便自己识别。</p>
				</div>
				<div class="mt-4 grid gap-4 sm:grid-cols-2">
					<label class="block sm:col-span-2">
						<span class="text-sm font-medium text-gray-700">备注名称</span>
						<input
							name="custom_name"
							class="mt-1 w-full rounded-lg border border-gray-300 px-3 py-2"
							placeholder="例如：日常用招商白金"
						/>
					</label>
					<input type="hidden" name="selected_image_url" value={selectedImageUrl()} />
					<label class="block">
						<span class="text-sm font-medium text-gray-700">卡片尾号</span>
						<input
							name="last_four"
							inputmode="numeric"
							maxlength="4"
							required
							class="mt-1 w-full rounded-lg border border-gray-300 px-3 py-2"
							placeholder="1234"
						/>
					</label>
					<label class="block">
						<span class="text-sm font-medium text-gray-700">提前提醒天数</span>
						<select
							name="lead_days"
							class="mt-1 w-full rounded-lg border border-gray-300 px-3 py-2"
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
					</label>
				</div>
			</section>

			<section class="rounded-2xl bg-blue-50/60 p-4">
				<div>
					<h2 class="text-sm font-semibold text-gray-900">循环提醒日期</h2>
					<p class="mt-1 text-xs leading-5 text-gray-500">
						账单日和还款日按每个自然月循环。例如设置 1 日，就会按每月 1 日计算；月末日期按当月日历处理。
					</p>
				</div>
				<div class="mt-4 grid gap-4 sm:grid-cols-2">
					<div class="block">
						<div class="flex items-center justify-between">
							<span class="text-sm font-medium text-gray-700">账单日（每月）</span>
							<label class="flex cursor-pointer items-center gap-1.5 text-xs text-gray-500">
								<input type="hidden" name="remind_statement" value="0" />
								<input type="checkbox" name="remind_statement" value="1" checked class="h-4 w-4 rounded accent-blue-600" />
								开启提醒
							</label>
						</div>
						<select
							name="statement_day"
							required
							class="mt-1 w-full rounded-lg border border-gray-300 px-3 py-2"
						>
							<option value="">选择账单日</option>
							{#each Array.from({ length: 31 }, (_, index) => index + 1) as day}
								<option value={day}>{day} 日</option>
							{/each}
						</select>
					</div>
					<div class="block">
						<div class="flex items-center justify-between">
							<span class="text-sm font-medium text-gray-700">还款日（每月）</span>
							<label class="flex cursor-pointer items-center gap-1.5 text-xs text-gray-500">
								<input type="hidden" name="remind_due" value="0" />
								<input type="checkbox" name="remind_due" value="1" checked class="h-4 w-4 rounded accent-blue-600" />
								开启提醒
							</label>
						</div>
						<select
							name="due_day"
							required
							class="mt-1 w-full rounded-lg border border-gray-300 px-3 py-2"
						>
							<option value="">选择还款日</option>
							{#each Array.from({ length: 31 }, (_, index) => index + 1) as day}
								<option value={day}>{day} 日</option>
							{/each}
						</select>
					</div>
				</div>
			</section>

			<section class="rounded-2xl bg-amber-50/70 p-4">
				<div class="flex items-center justify-between">
					<div>
						<h2 class="text-sm font-semibold text-gray-900">年费提醒（可选）</h2>
						<p class="mt-1 text-xs text-gray-500">年费通常一年一次，填写月份和日期后，每年提醒一次；不需要就留空。</p>
					</div>
					<label class="flex cursor-pointer items-center gap-1.5 text-xs text-gray-500">
						<input type="hidden" name="remind_annual_fee" value="0" />
						<input type="checkbox" name="remind_annual_fee" value="1" checked class="h-4 w-4 rounded accent-amber-500" />
						开启提醒
					</label>
				</div>
				<div class="mt-4 grid gap-4 sm:grid-cols-2">
					<label class="block">
						<span class="text-sm font-medium text-gray-700">年费月份</span>
						<select name="annual_fee_month" class="mt-1 w-full rounded-lg border border-gray-300 px-3 py-2">
							<option value="">不设置</option>
							{#each Array.from({ length: 12 }, (_, index) => index + 1) as month}
								<option value={month}>{month} 月</option>
							{/each}
						</select>
					</label>
					<label class="block">
						<span class="text-sm font-medium text-gray-700">年费日期</span>
						<select name="annual_fee_day" class="mt-1 w-full rounded-lg border border-gray-300 px-3 py-2">
							<option value="">不设置</option>
							{#each Array.from({ length: 31 }, (_, index) => index + 1) as day}
								<option value={day}>{day} 日</option>
							{/each}
						</select>
					</label>
				</div>
			</section>

			<button class="w-full rounded-lg bg-blue-600 px-4 py-3 font-medium text-white hover:bg-blue-700">
				保存提醒
			</button>
		</form>

		{#if showNotificationWarning}
			<div class="fixed inset-0 z-50 flex items-center justify-center bg-gray-950/50 px-4">
				<div class="w-full max-w-md rounded-3xl bg-white p-6 shadow-2xl">
					<div class="flex items-start gap-3">
						<div class="flex h-10 w-10 shrink-0 items-center justify-center rounded-full bg-amber-100 text-xl">!</div>
						<div>
							<h2 class="text-lg font-semibold text-gray-950">还没有设置通知渠道</h2>
							<p class="mt-2 text-sm leading-6 text-gray-600">
								你还没有填写 Bark、PushPlus 或 Telegram。保存后系统可以记录这张卡，但到期时无法给你发送提醒。请先到“我的”页面配置至少一种通知方式。
							</p>
						</div>
					</div>
					<div class="mt-6 flex flex-col gap-3 sm:flex-row sm:justify-end">
						<button
							type="button"
							class="rounded-xl border border-gray-200 px-4 py-2 text-sm font-medium text-gray-600 hover:bg-gray-50"
							onclick={() => (showNotificationWarning = false)}
						>
							先不保存
						</button>
						<a href="/me" class="rounded-xl bg-blue-600 px-4 py-2 text-center text-sm font-medium text-white hover:bg-blue-700">
							去设置通知
						</a>
					</div>
				</div>
			</div>
		{/if}

			<details id="request-card" class="group mt-6 rounded-xl border border-gray-200 bg-white p-5" open={shouldOpenRequest}>
				<summary class="cursor-pointer list-none">
					<div class="flex flex-col gap-2 sm:flex-row sm:items-start sm:justify-between">
						<div>
							<h2 class="text-sm font-semibold text-gray-900">没有找到想添加的卡？</h2>
							<p class="mt-1 text-sm text-gray-500">点击展开，提交给我审核后再加入卡片库。</p>
						</div>
						<span class="rounded-full bg-blue-50 px-3 py-1 text-xs font-medium text-blue-700">
							<span class="group-open:hidden">展开提交</span>
							<span class="hidden group-open:inline">收起表单</span>
						</span>
					</div>
				</summary>
			<div class="mt-5 flex flex-col gap-2 sm:flex-row sm:items-start sm:justify-between">
				<div>
					<h3 class="text-sm font-semibold text-gray-900">提交新卡模板</h3>
					<p class="mt-1 text-sm text-gray-500">
						把银行、卡名和卡等级提交给我。我审核通过后，会把它加入卡片库。
					</p>
				</div>
				<span class="rounded-full bg-blue-50 px-3 py-1 text-xs font-medium text-blue-700">待审核入库</span>
			</div>

			{#if form && 'requestError' in form && form.requestError}
				<div class="mt-4 rounded-xl border border-red-200 bg-red-50 p-3 text-sm text-red-700">
					{form.requestError}
				</div>
			{/if}
			{#if form && 'requestSuccess' in form && form.requestSuccess}
				<div class="mt-4 rounded-xl border border-emerald-200 bg-emerald-50 p-3 text-sm text-emerald-700">
					已提交，我之后会审核并补充到卡片库。
				</div>
			{/if}

			<form method="POST" action="?/requestCard" class="mt-5 space-y-4">
				<div class="grid gap-4 sm:grid-cols-2">
					<label class="block">
						<span class="text-sm font-medium text-gray-700">银行名称</span>
						<input
							name="request_bank_name"
							value={requestValues.bankName}
							placeholder="例如：招商银行"
							class="mt-1 w-full rounded-lg border border-gray-300 px-3 py-2"
						/>
					</label>
					<label class="block">
						<span class="text-sm font-medium text-gray-700">卡片名称</span>
						<input
							name="request_card_name"
							value={requestValues.cardName}
							placeholder="例如：经典白金信用卡"
							class="mt-1 w-full rounded-lg border border-gray-300 px-3 py-2"
						/>
					</label>
				</div>
				<div class="grid gap-4 sm:grid-cols-2">
					<label class="block">
						<span class="text-sm font-medium text-gray-700">卡片等级（可选）</span>
						<input
							name="request_card_tier"
							value={requestValues.cardTier}
							placeholder="例如：白金 / 金卡 / 普卡"
							class="mt-1 w-full rounded-lg border border-gray-300 px-3 py-2"
						/>
					</label>
					<label class="block">
						<span class="text-sm font-medium text-gray-700">补充说明（可选）</span>
						<input
							name="request_notes"
							value={requestValues.notes}
							placeholder="例如：年费、权益、官网链接"
							class="mt-1 w-full rounded-lg border border-gray-300 px-3 py-2"
						/>
					</label>
				</div>
				<p class="text-xs leading-5 text-gray-400">
					后续我会做一个后台审核页，通过后自动进入卡片库；现在先把提交记录保存下来。
				</p>
				<button class="rounded-lg border border-blue-200 bg-blue-50 px-4 py-2 text-sm font-medium text-blue-700 hover:bg-blue-100">
					提交给我审核
				</button>
			</form>
		</details>
	</div>
</main>
