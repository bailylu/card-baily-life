<script lang="ts">
	import CardFace from '$lib/components/CardFace.svelte';
	import type { ActionData, PageData } from './$types';

	let { data, form }: { data: PageData; form: ActionData } = $props();

	let previewUrl = $state<string | null>(null);
	let imageDataUrl = $state<string | null>(null);
	let selectedFile = $state<File | null>(null);
	let rotation = $state(0);
	let editingId = $state<number | null>(null);
	let bankName = $state('');
	let cardName = $state('');
	let cardTier = $state('');
	const CARD_TIERS = ['白金', '金卡'];
	const NETWORKS = ['Visa', 'Mastercard', '银联', 'Amex', 'JCB'];

	let network = $state('');
	let selectedNetworks = $state<string[]>([]);

	function networksToString(nets: string[]) {
		return nets.join(' / ');
	}

	function stringToNetworks(str: string) {
		return str.split(/[/,，、\s]+/).map(s => s.trim()).filter(s => NETWORKS.includes(s));
	}

	function toggleNetwork(net: string) {
		selectedNetworks = selectedNetworks.includes(net)
			? selectedNetworks.filter(n => n !== net)
			: [...selectedNetworks, net];
		network = networksToString(selectedNetworks);
	}
	let tags = $state('');
	let notes = $state('');
	let selectedBank = $state('全部');

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

	const bankOptions = $derived([...new Set(data.cards.map((card) => card.bank_name))]);
	const visibleCards = $derived(selectedBank === '全部' ? data.cards : data.cards.filter((card) => card.bank_name === selectedBank));

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
					const maxSide = 1200;
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
					resolve(canvas.toDataURL('image/jpeg', 0.86));
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
		bankName = card.bank_name;
		cardName = card.card_name;
		cardTier = card.card_tier ?? '';
		network = card.network ?? '';
		selectedNetworks = stringToNetworks(network);
		tags = card.tags ?? '';
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
		bankName = '';
		cardName = '';
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

</script>

<svelte:head>
	<title>卡库管理 — 贝利卡管家</title>
</svelte:head>

<main class="min-h-screen bg-gray-50 px-4 py-8">
	<div class="mx-auto max-w-5xl">
		<div class="mb-6 flex items-center justify-between">
			<div>
				<a href="/dashboard" class="text-sm font-medium text-blue-600 hover:text-blue-700">← 返回我的卡片</a>
				<h1 class="mt-3 text-3xl font-bold text-gray-950">卡库管理</h1>
				<p class="mt-2 text-sm text-gray-500">上传卡面、填写银行和卡片名称，保存后会立即进入卡片库。</p>
			</div>
			<a href="/cards/add" class="rounded-full bg-white px-4 py-2 text-sm font-medium text-gray-700 ring-1 ring-gray-200 hover:bg-gray-50">
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

		<div class="grid gap-6 lg:grid-cols-[0.9fr_1.1fr]">
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

				<form method="POST" action={editingId ? `?/save&id=${editingId}` : '?/save'} enctype="multipart/form-data" class="mt-5 space-y-4">
					<input type="hidden" name="id" value={editingId ?? ''} />
					<div class="grid gap-4 sm:grid-cols-2">
						<label class="block">
							<span class="text-sm font-medium text-gray-700">银行名称</span>
							<input bind:value={bankName} name="bank_name" required onkeydown={preventEnterSubmit} class="mt-2 w-full rounded-xl border border-gray-200 px-3 py-3 text-sm outline-none focus:border-blue-500" placeholder="例如：招商银行" />
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
								{#each CARD_TIERS as tier}
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
								{#each NETWORKS as net}
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
						<span class="mt-2 block text-xs text-gray-400">当前最简版图片存入 D1，建议先压缩到 350KB 内；显示时会自动适配信用卡比例。</span>
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
				{#if bankOptions.length > 0}
					<div class="mt-4 flex flex-wrap gap-2">
						<button
							type="button"
							class={`rounded-full px-3 py-1.5 text-xs font-semibold ring-1 transition ${selectedBank === '全部' ? 'bg-blue-600 text-white ring-blue-600' : 'bg-white text-gray-600 ring-gray-200 hover:bg-gray-50'}`}
							onclick={() => (selectedBank = '全部')}
						>
							全部银行
						</button>
						{#each bankOptions as bank}
							<button
								type="button"
								class={`rounded-full px-3 py-1.5 text-xs font-semibold ring-1 transition ${selectedBank === bank ? 'bg-blue-600 text-white ring-blue-600' : 'bg-white text-gray-600 ring-gray-200 hover:bg-gray-50'}`}
								onclick={() => (selectedBank = bank)}
							>
								{bank}
							</button>
						{/each}
					</div>
				{/if}
				<div class="mt-5 grid max-h-[44rem] gap-4 overflow-y-auto pr-1 sm:grid-cols-2">
					{#each visibleCards as card}
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
			</section>
		</div>
	</div>
</main>
