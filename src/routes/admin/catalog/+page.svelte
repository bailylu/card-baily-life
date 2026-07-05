<script lang="ts">
	import CardFace from '$lib/components/CardFace.svelte';
	import type { ActionData, PageData } from './$types';

	let { data, form }: { data: PageData; form: ActionData } = $props();

	let previewUrl = $state<string | null>(null);
	let imageDataUrl = $state<string | null>(null);
	let selectedFile = $state<File | null>(null);
	let rotation = $state(0);
	let editingId = $state<number | null>(null);
	let aiQuery = $state('');
	let aiLoading = $state(false);
	let aiError = $state('');
	let aiMessage = $state('');
	let aiDuplicateCandidates = $state<Array<{ id: number; bank_name: string; card_name: string; reason: string }>>([]);
	let country = $state('CN');
	let bankEntryMode = $state<'select' | 'custom'>('select');
	let bankName = $state('');
	let cardName = $state('');
	let cardType = $state('信用卡');
	let cardTier = $state('');
	const FALLBACK_CARD_TIERS = ['普卡', '金卡', '白金', '钻石', '黑金', 'Signature', 'Infinite'];
	const countryLabels: Record<string, string> = {
		CN: '中国大陆',
		HK: '中国香港',
		TW: '中国台湾',
		JP: '日本',
		US: '美国'
	};
	const countryOrder = ['CN', 'HK', 'TW', 'JP', 'US'];
	const CARD_TYPES = ['信用卡', '借记卡', '其它'];
	const FALLBACK_NETWORKS = ['银联', 'American Express', 'JCB', 'Mastercard', 'Visa', 'Visa / 银联'];
	function displayCountry(value: string | null | undefined) {
		return value ? countryLabels[value] ?? value : '未知地区';
	}
	function displayCardType(value: string | null | undefined) {
		if (value?.includes('借记卡')) return '借记卡';
		if (value?.includes('信用卡')) return '信用卡';
		return '其它';
	}
	function tagsWithoutType(value: string | null | undefined) {
		return (value ?? '')
			.split(/[,，、\s]+/)
			.map((tag) => tag.trim())
			.filter((tag) => tag && !CARD_TYPES.includes(tag))
			.join('、');
	}

	let network = $state('');
	let selectedNetworks = $state<string[]>([]);

	function networksToString(nets: string[]) {
		return nets.join(' / ');
	}

	function stringToNetworks(str: string) {
		const allowed = new Set([...FALLBACK_NETWORKS, ...networkOptions]);
		return str.split(/[/,，、]+/).map(s => s.trim()).filter(s => allowed.has(s));
	}

	function toggleNetwork(net: string) {
		selectedNetworks = selectedNetworks.includes(net)
			? selectedNetworks.filter(n => n !== net)
			: [...selectedNetworks, net];
		network = networksToString(selectedNetworks);
	}
	let tags = $state('');
	let notes = $state('');
	let catalogCountry = $state('全部');
	let catalogType = $state('全部');
	let catalogBank = $state('全部');
	let catalogNetwork = $state('全部');
	let catalogTier = $state('全部');
	let currentPage = $state(1);
	const PAGE_SIZE = 24;

	type Variant = { label: string; imageUrl: string | null; file: File | null };
	let variants = $state<Variant[]>([]);

	function parseVariants(json: string | null): Variant[] {
		if (!json) return [];
		try {
			const arr = JSON.parse(json);
			if (!Array.isArray(arr)) return [];
			return arr.map((v: { label?: string; imageUrl?: string | null }) => ({ label: v.label ?? '', imageUrl: v.imageUrl ?? null, file: null }));
		} catch { return []; }
	}

	function addVariant() {
		variants = [...variants, { label: '', imageUrl: null, file: null }];
	}

	function removeVariant(i: number) {
		variants = variants.filter((_, idx) => idx !== i);
	}

	async function onVariantFileChange(event: Event, i: number) {
		const input = event.currentTarget as HTMLInputElement;
		const file = input.files?.[0];
		if (!file) return;
		variants[i].file = file;
		try {
			variants[i].imageUrl = await imageToDataUrl(file, 0);
		} catch {
			variants[i].imageUrl = URL.createObjectURL(file);
		}
		variants = [...variants];
	}

	const countryOptions = $derived([
		...countryOrder.filter((code) => data.cards.some((card) => card.country === code)),
		...Array.from(new Set(data.cards.map((card) => card.country).filter((code): code is string => !!code && !countryOrder.includes(code))))
	]);
	const bankOptions = $derived([
		...new Set(
			data.cards
				.filter((card) => !country || card.country === country)
				.map((card) => card.bank_name)
		)
	]);
	const networkOptions = $derived([
		...FALLBACK_NETWORKS,
		...new Set(
			data.cards
				.map((card) => card.network)
				.flatMap((value) => (value ?? '').split(/[/,，、]+/).map((item) => item.trim()))
				.filter(Boolean)
		)
	].filter((value, index, arr) => arr.indexOf(value) === index));
	const tierOptions = $derived([
		...new Set([
			...data.cards.map((card) => card.card_tier).filter((tier): tier is string => !!tier?.trim()),
			...FALLBACK_CARD_TIERS
		])
	]);
	const catalogBankOptions = $derived([
		...new Set(
			data.cards
				.filter((card) => catalogCountry === '全部' || card.country === catalogCountry)
				.filter((card) => catalogType === '全部' || displayCardType(card.tags) === catalogType)
				.map((card) => card.bank_name)
		)
	]);
	const visibleCards = $derived(
		data.cards
			.filter((card) => catalogCountry === '全部' || card.country === catalogCountry)
			.filter((card) => catalogType === '全部' || displayCardType(card.tags) === catalogType)
			.filter((card) => catalogBank === '全部' || card.bank_name === catalogBank)
			.filter((card) => catalogNetwork === '全部' || (card.network ?? '').split(/[/,，、]+/).map((item) => item.trim()).includes(catalogNetwork))
			.filter((card) => catalogTier === '全部' || card.card_tier === catalogTier)
	);
	const totalPages = $derived(Math.max(1, Math.ceil(visibleCards.length / PAGE_SIZE)));
	const pagedCards = $derived(visibleCards.slice((currentPage - 1) * PAGE_SIZE, currentPage * PAGE_SIZE));

	$effect(() => {
		country;
		if (bankEntryMode === 'select' && bankName && bankOptions.length > 0 && !bankOptions.includes(bankName)) bankName = '';
	});

	$effect(() => {
		catalogCountry;
		catalogType;
		catalogBank;
		catalogNetwork;
		catalogTier;
		currentPage = 1;
	});

	$effect(() => {
		if (catalogBank !== '全部' && !catalogBankOptions.includes(catalogBank)) catalogBank = '全部';
	});

	$effect(() => {
		if (currentPage > totalPages) currentPage = totalPages;
		if (currentPage < 1) currentPage = 1;
	});

	function revokePreview() {
		if (previewUrl?.startsWith('blob:')) URL.revokeObjectURL(previewUrl);
	}

	function splitTags(value: string | null) {
		return (value ?? '')
			.split(/[,，、\s]+/)
			.map((tag) => tag.trim())
			.filter(Boolean)
			.slice(0, 6);
	}

	function imageToDataUrl(file: File, degrees: number) {
		return new Promise<string>((resolve, reject) => {
			const objectUrl = URL.createObjectURL(file);
			const image = new Image();

			image.onload = () => {
				try {
					const normalizedDegrees = ((degrees % 360) + 360) % 360;
					const isSideways = normalizedDegrees === 90 || normalizedDegrees === 270;
					const maxSide = 640;
					const scale = Math.min(1, maxSide / Math.max(image.naturalWidth, image.naturalHeight));
					const drawWidth = Math.round(image.naturalWidth * scale);
					const drawHeight = Math.round(image.naturalHeight * scale);
					const canvas = document.createElement('canvas');
					canvas.width = isSideways ? drawHeight : drawWidth;
					canvas.height = isSideways ? drawWidth : drawHeight;

					const context = canvas.getContext('2d');
					if (!context) throw new Error('无法生成预览图');

					context.translate(canvas.width / 2, canvas.height / 2);
					context.rotate((normalizedDegrees * Math.PI) / 180);
					context.drawImage(image, -drawWidth / 2, -drawHeight / 2, drawWidth, drawHeight);
					resolve(canvas.toDataURL('image/jpeg', 0.75));
				} catch (error) {
					reject(error);
				} finally {
					URL.revokeObjectURL(objectUrl);
				}
			};

			image.onerror = () => {
				URL.revokeObjectURL(objectUrl);
				reject(new Error('图片预览失败，请换一张 JPG、PNG 或 WEBP'));
			};

			image.src = objectUrl;
		});
	}

	async function renderSelectedFile(degrees: number) {
		if (!selectedFile) return;

		revokePreview();
		try {
			imageDataUrl = await imageToDataUrl(selectedFile, degrees);
			previewUrl = imageDataUrl;
		} catch {
			imageDataUrl = null;
			previewUrl = URL.createObjectURL(selectedFile);
		}
	}

	async function onFileChange(event: Event) {
		const input = event.currentTarget as HTMLInputElement;
		const file = input.files?.[0];
		selectedFile = file ?? null;
		rotation = 0;
		imageDataUrl = null;
		if (!selectedFile) {
			revokePreview();
			previewUrl = null;
			return;
		}
		await renderSelectedFile(rotation);
	}

	async function rotateImage() {
		if (!selectedFile) return;
		rotation = (rotation + 90) % 360;
		await renderSelectedFile(rotation);
	}

	function editCard(card: PageData['cards'][number]) {
		editingId = card.id;
		country = card.country ?? 'CN';
		bankEntryMode = 'select';
		bankName = card.bank_name;
		cardName = card.card_name;
		cardType = displayCardType(card.tags);
		cardTier = card.card_tier ?? '';
		network = card.network ?? '';
		selectedNetworks = stringToNetworks(network);
		tags = tagsWithoutType(card.tags);
		notes = card.notes ?? '';
		selectedFile = null;
		imageDataUrl = null;
		rotation = 0;
		revokePreview();
		previewUrl = card.image_url;
		variants = parseVariants(card.variants ?? null);
	}

	function resetForm() {
		editingId = null;
		country = 'CN';
		bankEntryMode = 'select';
		bankName = '';
		cardName = '';
		cardType = '信用卡';
		cardTier = '';
		network = '';
		selectedNetworks = [];
		tags = '';
		notes = '';
		selectedFile = null;
		imageDataUrl = null;
		rotation = 0;
		revokePreview();
		previewUrl = null;
		variants = [];
	}

	function preventEnterSubmit(event: KeyboardEvent) {
		if (event.key !== 'Enter') return;
		if (event.target instanceof HTMLTextAreaElement) return;
		event.preventDefault();
	}

	function goToPage(page: number) {
		currentPage = Math.min(totalPages, Math.max(1, page));
	}

	async function runAiFill() {
		const query = aiQuery.trim();
		aiError = '';
		aiMessage = '';
		aiDuplicateCandidates = [];
		if (!query) {
			aiError = '先输入卡片名称';
			return;
		}

		aiLoading = true;
		try {
			const response = await fetch('/api/admin/catalog/ai-fill', {
				method: 'POST',
				headers: { 'Content-Type': 'application/json' },
				body: JSON.stringify({ query })
			});
			const result = await response.json() as {
				error?: string;
				fill?: {
					country?: string;
					card_type?: string;
					bank_name?: string;
					card_name?: string;
					card_tier?: string;
					networks?: string[];
					tags?: string[];
					notes?: string;
					duplicate_candidates?: Array<{ id: number; bank_name: string; card_name: string; reason: string }>;
				};
			};
			if (!response.ok || !result.fill) throw new Error(result.error || 'AI 识别失败');

			const fill = result.fill;
			const nextCountry = fill.country || 'CN';
			const nextBank = fill.bank_name?.trim() || '';
			const banksForCountry = [
				...new Set(
					data.cards
						.filter((card) => card.country === nextCountry)
						.map((card) => card.bank_name)
				)
			];

			country = nextCountry;
			cardType = fill.card_type || '信用卡';
			cardName = fill.card_name?.trim() || query;
			cardTier = fill.card_tier?.trim() || '';
			selectedNetworks = (fill.networks ?? []).map((item) => item.trim()).filter(Boolean);
			network = networksToString(selectedNetworks);
			tags = (fill.tags ?? []).map((item) => item.trim()).filter(Boolean).join('、');
			notes = fill.notes?.trim() || '';
			if (nextBank && banksForCountry.includes(nextBank)) {
				bankEntryMode = 'select';
				bankName = nextBank;
			} else {
				bankEntryMode = 'custom';
				bankName = nextBank;
			}
			aiDuplicateCandidates = fill.duplicate_candidates ?? [];
			aiMessage = aiDuplicateCandidates.length > 0
				? `已填入表单，并找到 ${aiDuplicateCandidates.length} 个可能重复项。`
				: '已根据卡片名称填入表单，请复核后保存。';
		} catch (error) {
			aiError = error instanceof Error ? error.message : 'AI 识别失败';
		} finally {
			aiLoading = false;
		}
	}

</script>

<svelte:head>
	<title>卡库管理 — 贝利卡管家</title>
</svelte:head>

<main class="bls-page admin-dark px-4 py-8">
	<div class="mx-auto max-w-7xl">
		<div class="mb-6 flex items-center justify-between">
			<div>
				<a href="/dashboard" class="text-sm font-bold text-[var(--bls-cyan)] hover:text-[var(--bls-gold-bright)]">← 返回我的卡片</a>
				<p class="bls-label mt-6 text-[var(--bls-cyan)]">Catalog Control</p>
				<h1 class="mt-2 text-3xl font-black text-white">卡库管理</h1>
				<p class="mt-2 text-sm text-[var(--bls-muted)]">维护添加卡片页使用的卡库资料、卡面、地区银行和卡组织信息。</p>
			</div>
			<a href="/cards/add" class="bls-btn px-4 py-2 text-sm">
				查看卡库
			</a>
		</div>

		{#if data.configMissing}
			<div class="mb-4 rounded-xl border border-amber-200 bg-amber-50 p-4 text-sm text-amber-700">
				当前运行环境没有 D1 绑定，无法保存卡库。
			</div>
		{/if}

		{#if form && 'error' in form && form.error}
			<div class="mb-4 rounded-xl border border-red-200 bg-red-50 p-4 text-sm text-red-700">{form.error}</div>
		{/if}

		{#if data.saved || (form && 'success' in form && form.success)}
			<div class="mb-4 rounded-xl border border-emerald-200 bg-emerald-50 p-4 text-sm text-emerald-700">已保存到卡库。</div>
		{/if}

		<div class="space-y-6">
			<section class="rounded-3xl border border-gray-200 bg-white p-5 shadow-sm">
				<div class="flex items-center justify-between gap-3">
					<h2 class="text-lg font-semibold text-gray-950">{editingId ? '编辑卡片' : '新增 / 更新卡片'}</h2>
					{#if editingId}
						<button type="button" class="rounded-full bg-gray-100 px-3 py-1.5 text-xs font-medium text-gray-600 hover:bg-gray-200" onclick={resetForm}>
							取消编辑
						</button>
					{/if}
				</div>
				<p class="mt-1 text-sm text-gray-500">点右侧编辑后会修改原记录；不点编辑则保存为新卡。不传新图会保留原卡面。</p>

				<div class="admin-callout admin-callout-cyan mt-5 p-4">
					<div class="flex flex-wrap items-end gap-3">
						<label class="min-w-0 flex-1">
							<span class="text-sm font-bold text-gray-700">AI 识别卡片</span>
							<input
								bind:value={aiQuery}
								onkeydown={(event) => {
									if (event.key === 'Enter') {
										event.preventDefault();
										void runAiFill();
									}
								}}
								class="mt-2 w-full rounded-xl border border-gray-200 px-3 py-3 text-sm outline-none focus:border-blue-500"
								placeholder="输入卡片名称，例如：中信银行万豪旅享家精逸白金卡"
							/>
						</label>
						<button
							type="button"
							class="bls-btn px-4 py-3 text-sm disabled:cursor-not-allowed disabled:opacity-50"
							disabled={aiLoading}
							onclick={() => void runAiFill()}
						>
							{aiLoading ? '识别中...' : 'AI 识别'}
						</button>
					</div>
					<p class="mt-2 text-xs leading-5 text-gray-400">只填文字字段，图片仍然手动上传；保存前请复核识别结果。</p>
					{#if aiError}
						<p class="mt-3 text-sm font-bold text-red-600">{aiError}</p>
					{/if}
					{#if aiMessage}
						<p class="mt-3 text-sm font-bold text-blue-600">{aiMessage}</p>
					{/if}
					{#if aiDuplicateCandidates.length}
						<div class="mt-3 space-y-2">
							<p class="text-xs font-bold text-gray-500">可能已存在：</p>
							{#each aiDuplicateCandidates as candidate}
								<button
									type="button"
									class="block w-full rounded-[4px] border-2 border-[var(--bls-line)] bg-[rgba(9,14,26,0.56)] px-3 py-2 text-left text-xs text-[var(--bls-body)] hover:border-[var(--bls-cyan)]"
									onclick={() => {
										const matched = data.cards.find((card) => card.id === candidate.id);
										if (matched) editCard(matched);
									}}
								>
									<span class="font-black text-white">{candidate.bank_name} {candidate.card_name}</span>
									<span class="ml-2 text-[var(--bls-muted)]">{candidate.reason}</span>
								</button>
							{/each}
						</div>
					{/if}
				</div>

				<form method="POST" action={editingId ? `?/save&id=${editingId}` : '?/save'} enctype="multipart/form-data" class="mt-5 space-y-4">
					<input type="hidden" name="id" value={editingId ?? ''} />
					<div class="grid gap-4 sm:grid-cols-2">
						<label class="block">
							<span class="text-sm font-medium text-gray-700">国家 / 地区</span>
							<select bind:value={country} name="country" required class="mt-2 w-full rounded-xl border border-gray-200 px-3 py-3 text-sm outline-none focus:border-blue-500">
								{#each countryOptions as option}
									<option value={option}>{displayCountry(option)}</option>
								{/each}
								{#if !countryOptions.includes('CN')}
									<option value="CN">中国大陆</option>
								{/if}
								{#if !countryOptions.includes('HK')}
									<option value="HK">中国香港</option>
								{/if}
								{#if !countryOptions.includes('TW')}
									<option value="TW">中国台湾</option>
								{/if}
								{#if !countryOptions.includes('JP')}
									<option value="JP">日本</option>
								{/if}
								{#if !countryOptions.includes('US')}
									<option value="US">美国</option>
								{/if}
							</select>
						</label>
						<label class="block">
							<span class="text-sm font-medium text-gray-700">卡种类别</span>
							<select bind:value={cardType} name="card_type" required class="mt-2 w-full rounded-xl border border-gray-200 px-3 py-3 text-sm outline-none focus:border-blue-500">
								{#each CARD_TYPES as type}
									<option value={type}>{type}</option>
								{/each}
							</select>
						</label>
						<label class="block">
							<span class="text-sm font-medium text-gray-700">银行名称</span>
							<div class="mt-2 grid gap-2 sm:grid-cols-[minmax(0,1fr)_auto]">
								{#if bankEntryMode === 'select'}
									<select bind:value={bankName} name="bank_name" required class="w-full rounded-xl border border-gray-200 px-3 py-3 text-sm outline-none focus:border-blue-500">
										<option value="">选择已有银行</option>
										{#each bankOptions as bank}
											<option value={bank}>{bank}</option>
										{/each}
									</select>
									<button
										type="button"
										class="rounded-lg border border-gray-200 px-3 py-2 text-xs font-bold text-gray-600 hover:border-blue-500 hover:text-blue-700"
										onclick={() => {
											bankEntryMode = 'custom';
											bankName = '';
										}}
									>
										新增银行
									</button>
								{:else}
									<input bind:value={bankName} name="bank_name" required onkeydown={preventEnterSubmit} class="w-full rounded-xl border border-gray-200 px-3 py-3 text-sm outline-none focus:border-blue-500" placeholder="输入新银行名称" />
									<button
										type="button"
										class="rounded-lg border border-gray-200 px-3 py-2 text-xs font-bold text-gray-600 hover:border-blue-500 hover:text-blue-700"
										onclick={() => {
											bankEntryMode = 'select';
											bankName = '';
										}}
									>
										选择已有
									</button>
								{/if}
							</div>
							<p class="mt-2 text-xs text-gray-400">
								当前地区已有 {bankOptions.length} 个银行；新增银行会随卡片一起入库。
							</p>
						</label>
						<label class="block">
							<span class="text-sm font-medium text-gray-700">卡片名称</span>
							<input bind:value={cardName} name="card_name" required onkeydown={preventEnterSubmit} class="mt-2 w-full rounded-xl border border-gray-200 px-3 py-3 text-sm outline-none focus:border-blue-500" placeholder="例如：经典白金信用卡" />
						</label>
					</div>

					<div class="grid gap-4 sm:grid-cols-2">
						<div class="block">
							<span class="text-sm font-medium text-gray-700">卡片等级（可选）</span>
							<input type="hidden" name="card_tier" value={cardTier} />
							<div class="mt-2 flex flex-wrap gap-2">
								{#each tierOptions as tier}
									<button
										type="button"
										onclick={() => { cardTier = cardTier === tier ? '' : tier; }}
										class="rounded-lg border px-3 py-1.5 text-sm font-medium transition {cardTier === tier ? 'border-blue-500 bg-blue-50 text-blue-700' : 'border-gray-200 text-gray-600 hover:border-gray-300 hover:bg-gray-50'}"
									>
										{tier}
									</button>
								{/each}
							</div>
						</div>
						<div class="block">
							<span class="text-sm font-medium text-gray-700">卡组织（可选，可多选）</span>
							<input type="hidden" name="network" value={network} />
							<div class="mt-2 flex flex-wrap gap-2">
								{#each networkOptions as net}
									<button
										type="button"
										onclick={() => toggleNetwork(net)}
										class="rounded-lg border px-3 py-1.5 text-sm font-medium transition {selectedNetworks.includes(net) ? 'border-blue-500 bg-blue-50 text-blue-700' : 'border-gray-200 text-gray-600 hover:border-gray-300 hover:bg-gray-50'}"
									>
										{net}
									</button>
								{/each}
							</div>
						</div>
					</div>

					<label class="block">
						<span class="text-sm font-medium text-gray-700">权益标签（可选）</span>
						<input bind:value={tags} name="tags" onkeydown={preventEnterSubmit} class="mt-2 w-full rounded-xl border border-gray-200 px-3 py-3 text-sm outline-none focus:border-blue-500" placeholder="例如：酒店,里程,高端权益" />
					</label>

					<label class="block">
						<span class="text-sm font-medium text-gray-700">卡面图片</span>
						<input
							name="image"
							type="file"
							accept="image/png,image/jpeg,image/webp,image/svg+xml"
							class="mt-2 w-full rounded-xl border border-dashed border-gray-300 px-3 py-3 text-sm file:mr-4 file:rounded-lg file:border-0 file:bg-blue-50 file:px-3 file:py-2 file:text-sm file:font-medium file:text-blue-700"
							onchange={onFileChange}
						/>
						<input type="hidden" name="image_data_url" value={imageDataUrl ?? ''} />
						<span class="mt-2 block text-xs text-gray-400">上传后自动压缩至 640px / JPEG 75%，通常 20–40KB；显示时自动适配信用卡比例。</span>
					</label>

					<label class="block">
						<span class="text-sm font-medium text-gray-700">备注（可选）</span>
						<textarea bind:value={notes} name="notes" rows="3" class="mt-2 w-full rounded-xl border border-gray-200 px-3 py-3 text-sm outline-none focus:border-blue-500" placeholder="例如：官网展示图 / 需要复核权益"></textarea>
					</label>

					<!-- 变体图片 -->
					<div>
						<div class="mb-2 flex items-center justify-between">
							<span class="text-sm font-medium text-gray-700">变体图片（可选，如金卡 / 白金卡 / 黑金卡）</span>
							<button type="button" onclick={addVariant} class="rounded-lg border border-blue-200 bg-blue-50 px-3 py-1 text-xs font-medium text-blue-700 hover:bg-blue-100">+ 添加变体</button>
						</div>
						<input type="hidden" name="variant_count" value={variants.length} />
						{#each variants as variant, i}
							<div class="mb-3 rounded-xl border border-gray-200 bg-gray-50 p-3">
								<div class="flex items-center gap-2 mb-2">
									<input
										bind:value={variant.label}
										name="variant_label_{i}"
										placeholder="变体名称，如：白金版"
										class="flex-1 rounded-lg border border-gray-200 px-3 py-1.5 text-sm outline-none focus:border-blue-500"
									/>
									<button type="button" onclick={() => removeVariant(i)} class="text-xs text-red-400 hover:text-red-600">删除</button>
								</div>
								<input type="hidden" name="variant_existing_url_{i}" value={variant.imageUrl ?? ''} />
								<input
									type="file"
									name="variant_image_{i}"
									accept="image/png,image/jpeg,image/webp"
									class="w-full rounded-lg border border-dashed border-gray-300 px-2 py-2 text-xs file:mr-3 file:rounded-lg file:border-0 file:bg-blue-50 file:px-2 file:py-1 file:text-xs file:font-medium file:text-blue-700"
									onchange={(e) => onVariantFileChange(e, i)}
								/>
								{#if variant.imageUrl}
									<div class="mt-2 max-w-[160px]">
										<img src={variant.imageUrl} alt={variant.label} class="w-full rounded-lg object-cover aspect-[1.586/1]" />
									</div>
								{/if}
							</div>
						{/each}
					</div>

					{#if previewUrl}
						<div>
							<div class="mb-2 flex items-center justify-between gap-3">
								<p class="text-sm font-medium text-gray-700">上传预览</p>
								<button
									type="button"
									class="rounded-full bg-blue-50 px-3 py-1.5 text-xs font-semibold text-blue-700 hover:bg-blue-100 disabled:cursor-not-allowed disabled:opacity-40"
									disabled={!selectedFile}
									onclick={rotateImage}
								>
									旋转 90°
								</button>
							</div>
							<div class="max-w-sm">
								<CardFace
									imageUrl={previewUrl}
									bankName="预览银行"
									displayName="预览卡片"
									cardStyle={{ label: '预览', gradient: 'linear-gradient(135deg,#111827,#1d4ed8)', accent: 'rgba(255,255,255,0.18)', text: '#fff' }}
								/>
							</div>
						</div>
					{/if}

					<button class="w-full rounded-2xl bg-blue-600 px-5 py-3 text-sm font-semibold text-white shadow-sm hover:bg-blue-700">
						{editingId ? '完成修改' : '保存到卡库'}
					</button>
				</form>
			</section>

			<section class="rounded-3xl border border-gray-200 bg-white p-5 shadow-sm">
				<div class="flex items-center justify-between">
					<h2 class="text-lg font-semibold text-gray-950">当前卡库</h2>
					<span class="text-sm text-gray-400">{visibleCards.length} / {data.cards.length} 张</span>
				</div>
				<div class="mt-4 space-y-3">
					<div class="grid gap-3 md:grid-cols-5">
						<select bind:value={catalogCountry} class="rounded-xl border border-gray-200 px-3 py-3 text-sm outline-none focus:border-blue-500">
							<option value="全部">全部地区</option>
							{#each countryOptions as option}
								<option value={option}>{displayCountry(option)}</option>
							{/each}
						</select>
						<select bind:value={catalogType} class="rounded-xl border border-gray-200 px-3 py-3 text-sm outline-none focus:border-blue-500">
							<option value="全部">全部类型</option>
							{#each CARD_TYPES as type}
								<option value={type}>{type}</option>
							{/each}
						</select>
						<select bind:value={catalogBank} class="rounded-xl border border-gray-200 px-3 py-3 text-sm outline-none focus:border-blue-500">
							<option value="全部">全部银行</option>
							{#each catalogBankOptions as bank}
								<option value={bank}>{bank}</option>
							{/each}
						</select>
						<select bind:value={catalogNetwork} class="rounded-xl border border-gray-200 px-3 py-3 text-sm outline-none focus:border-blue-500">
							<option value="全部">全部卡组织</option>
							{#each networkOptions as net}
								<option value={net}>{net}</option>
							{/each}
						</select>
						<select bind:value={catalogTier} class="rounded-xl border border-gray-200 px-3 py-3 text-sm outline-none focus:border-blue-500">
							<option value="全部">全部等级</option>
							{#each tierOptions as tier}
								<option value={tier}>{tier}</option>
							{/each}
						</select>
					</div>

					<div class="flex flex-wrap gap-2">
						<button
							type="button"
							class={`rounded-full px-3 py-1.5 text-xs font-semibold ring-1 transition ${catalogCountry === '全部' ? 'bg-blue-600 text-white ring-blue-600' : 'bg-white text-gray-600 ring-gray-200 hover:bg-gray-50'}`}
							onclick={() => (catalogCountry = '全部')}
						>
							全部地区
						</button>
						{#each countryOptions as option}
							<button
								type="button"
								class={`rounded-full px-3 py-1.5 text-xs font-semibold ring-1 transition ${catalogCountry === option ? 'bg-blue-600 text-white ring-blue-600' : 'bg-white text-gray-600 ring-gray-200 hover:bg-gray-50'}`}
								onclick={() => (catalogCountry = option)}
							>
								{displayCountry(option)}
							</button>
						{/each}
					</div>
					<div class="flex flex-wrap gap-2">
						<button
							type="button"
							class={`rounded-full px-3 py-1.5 text-xs font-semibold ring-1 transition ${catalogType === '全部' ? 'bg-blue-600 text-white ring-blue-600' : 'bg-white text-gray-600 ring-gray-200 hover:bg-gray-50'}`}
							onclick={() => (catalogType = '全部')}
						>
							全部类型
						</button>
						{#each CARD_TYPES as type}
							<button
								type="button"
								class={`rounded-full px-3 py-1.5 text-xs font-semibold ring-1 transition ${catalogType === type ? 'bg-blue-600 text-white ring-blue-600' : 'bg-white text-gray-600 ring-gray-200 hover:bg-gray-50'}`}
								onclick={() => (catalogType = type)}
							>
								{type}
							</button>
						{/each}
					</div>
					<div class="flex flex-wrap gap-2">
						<button
							type="button"
							class={`rounded-full px-3 py-1.5 text-xs font-semibold ring-1 transition ${catalogNetwork === '全部' ? 'bg-blue-600 text-white ring-blue-600' : 'bg-white text-gray-600 ring-gray-200 hover:bg-gray-50'}`}
							onclick={() => (catalogNetwork = '全部')}
						>
							全部卡组织
						</button>
						{#each networkOptions as net}
							<button
								type="button"
								class={`rounded-full px-3 py-1.5 text-xs font-semibold ring-1 transition ${catalogNetwork === net ? 'bg-blue-600 text-white ring-blue-600' : 'bg-white text-gray-600 ring-gray-200 hover:bg-gray-50'}`}
								onclick={() => (catalogNetwork = net)}
							>
								{net}
							</button>
						{/each}
					</div>
				</div>
				<div class="mt-5 grid gap-4 sm:grid-cols-2 lg:grid-cols-3 xl:grid-cols-4">
					{#each pagedCards as card}
						<article class="rounded-2xl border border-gray-100 bg-gray-50 p-3">
								<CardFace
									imageUrl={card.image_url}
									bankName={card.bank_name}
									displayName={card.card_name}
									cardStyle={{
									label: card.card_tier ?? card.network ?? '信用卡',
									gradient: 'linear-gradient(135deg,#111827,#1d4ed8)',
									accent: 'rgba(255,255,255,0.16)',
									text: '#fff'
								}}
							/>
								<div class="mt-3 flex items-start justify-between gap-3">
									<div>
											<p class="text-xs text-gray-400">{card.bank_name}</p>
											<p class="font-semibold text-gray-950">{card.card_name}</p>
										<p class="mt-1 text-xs text-gray-500">{card.card_tier ?? '未填写等级'} · {card.image_url ? '已有卡面' : '暂无卡面'}</p>
										{#if card.network || splitTags(card.tags).length}
											<div class="mt-2 flex flex-wrap gap-1.5">
												{#if card.network}
													<span class="rounded-full bg-blue-50 px-2 py-1 text-[11px] font-semibold text-blue-700 ring-1 ring-blue-100">
														卡组织：{card.network}
													</span>
												{/if}
												{#each splitTags(card.tags) as tag}
													<span class="rounded-full bg-emerald-50 px-2 py-1 text-[11px] font-semibold text-emerald-700 ring-1 ring-emerald-100">
														{tag}
													</span>
												{/each}
											</div>
										{/if}
									</div>
									<div class="flex shrink-0 flex-col gap-2">
										<button type="button" class="whitespace-nowrap rounded-full bg-white px-3 py-1.5 text-xs font-medium text-blue-600 ring-1 ring-blue-100 hover:bg-blue-50" onclick={() => editCard(card)}>
											编辑
										</button>
										{#if card.image_url}
											<form method="POST" action="?/clearImage">
												<input type="hidden" name="id" value={card.id} />
												<button class="w-full whitespace-nowrap rounded-full bg-white px-3 py-1.5 text-xs font-medium text-orange-600 ring-1 ring-orange-100 hover:bg-orange-50">
													清除图
												</button>
											</form>
										{/if}
										<form method="POST" action="?/deleteCard">
											<input type="hidden" name="id" value={card.id} />
											<button class="w-full whitespace-nowrap rounded-full bg-white px-3 py-1.5 text-xs font-medium text-red-600 ring-1 ring-red-100 hover:bg-red-50">
												删除
											</button>
										</form>
									</div>
								</div>
						</article>
					{/each}
				</div>
				<div class="mt-6 flex flex-wrap items-center justify-between gap-3 border-t border-white/10 pt-4">
					<p class="text-sm text-gray-400">
						第 {currentPage} / {totalPages} 页 · 当前显示 {pagedCards.length} 张，共 {visibleCards.length} 张
					</p>
					<div class="flex items-center gap-2">
						<button
							type="button"
							class="bls-btn-ghost px-3 py-2 text-xs font-bold disabled:cursor-not-allowed disabled:opacity-40"
							disabled={currentPage <= 1}
							onclick={() => goToPage(currentPage - 1)}
						>
							上一页
						</button>
						{#each Array.from({ length: Math.min(totalPages, 5) }, (_, index) => {
							const start = Math.min(Math.max(currentPage - 2, 1), Math.max(totalPages - 4, 1));
							return start + index;
						}) as page}
							<button
								type="button"
								class={`rounded-[4px] border-2 px-3 py-2 text-xs font-black ${page === currentPage ? 'border-[var(--bls-cyan)] bg-[rgba(47,230,212,0.14)] text-[var(--bls-cyan)]' : 'border-[var(--bls-line)] text-[var(--bls-body)] hover:border-[var(--bls-cyan)]'}`}
								onclick={() => goToPage(page)}
							>
								{page}
							</button>
						{/each}
						<button
							type="button"
							class="bls-btn-ghost px-3 py-2 text-xs font-bold disabled:cursor-not-allowed disabled:opacity-40"
							disabled={currentPage >= totalPages}
							onclick={() => goToPage(currentPage + 1)}
						>
							下一页
						</button>
					</div>
				</div>
			</section>
		</div>
	</div>
</main>
