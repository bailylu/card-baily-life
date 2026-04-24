<script lang="ts">
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

		<form method="POST" action="?/addCard" class="mt-6 space-y-5 rounded-xl border border-gray-200 bg-white p-5">
			<section>
				<div class="flex items-center justify-between gap-3">
					<span class="text-sm font-medium text-gray-700">选择卡片种类</span>
					<span class="text-xs text-gray-400">找不到也可以提交给我补充</span>
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
						<label class="cursor-pointer">
							<input class="peer sr-only" type="radio" name="catalog_id" value={card.id} />
							<div class="rounded-2xl border border-gray-200 bg-white p-4 transition peer-checked:border-blue-500 peer-checked:ring-2 peer-checked:ring-blue-100">
								<div
									class="relative overflow-hidden rounded-xl p-4 shadow-sm"
									style={`background: ${card.cardStyle.gradient}; color: ${card.cardStyle.text};`}
								>
									<div
										class="absolute -right-8 -top-8 h-24 w-24 rounded-full"
										style={`background: ${card.cardStyle.accent};`}
									></div>
									<div class="relative">
										<div class="flex items-center justify-between text-xs opacity-80">
											<span>{card.bank_name}</span>
											<span>{card.cardStyle.label}</span>
										</div>
										<p class="mt-8 text-base font-semibold">{card.card_name}</p>
										<p class="mt-3 font-mono text-xs tracking-[0.3em] opacity-80">•••• 1234</p>
									</div>
								</div>
								<p class="mt-3 text-sm font-medium text-gray-900">{card.bank_name} {card.card_name}</p>
							</div>
						</label>
					{/each}
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
					<label class="block">
						<span class="text-sm font-medium text-gray-700">账单日（每月）</span>
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
					</label>
					<label class="block">
						<span class="text-sm font-medium text-gray-700">还款日（每月）</span>
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
					</label>
				</div>
			</section>

			<section class="rounded-2xl bg-amber-50/70 p-4">
				<div>
					<h2 class="text-sm font-semibold text-gray-900">年费提醒（可选）</h2>
					<p class="mt-1 text-xs text-gray-500">年费通常一年一次，填写月份和日期后，每年提醒一次；不需要就留空。</p>
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
				保存卡片
			</button>
		</form>

			<details class="group mt-6 rounded-xl border border-gray-200 bg-white p-5" open={shouldOpenRequest}>
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
