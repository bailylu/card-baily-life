<script lang="ts">
	import type { ActionData, PageData } from './$types';

	let { data, form }: { data: PageData; form: ActionData } = $props();

	let editing = $state<PageData['promotions'][number] | null>(null);
	let formId = $state('');
	let formBank = $state('');
	let formPartner = $state('');
	let formName = $state('');
	let formDescription = $state('');
	let formMetric1Label = $state('');
	let formMetric1Value = $state('');
	let formMetric2Label = $state('');
	let formMetric2Value = $state('');
	let formMetric3Label = $state('');
	let formMetric3Value = $state('');
	let formHref = $state('');
	let formSortOrder = $state(100);
	let formImage = $state('');
	let formAlt = $state('');
	let formEnabled = $state(true);
	let imageInput = $state<HTMLInputElement | null>(null);
	let uploadRotation = $state<'none' | 'left' | 'right'>('none');
	let processedImageDataUrl = $state('');
	let uploadPreviewUrl = $state('');
	let uploadError = $state('');

	let defaultHref = $derived(formId ? `/refer/${formId}` : '/refer/推荐ID');

	let preview = $derived({
		bank: formBank || '首页推荐',
		partner: formPartner || '办卡活动',
		name: formName || '卡片 / 活动名称',
		description: formDescription || '这里会实时预览首页轮播里显示的活动简介。左侧修改任意字段，右侧会同步变化。',
		image: uploadPreviewUrl || formImage || '/images/cards/citic-airlines-combo.webp',
		alt: formAlt || formName || '首页推荐活动图片',
		href: formHref || defaultHref,
		metrics: [
			{ label: formMetric1Label || '亮点 1', value: formMetric1Value || '内容' },
			{ label: formMetric2Label || '亮点 2', value: formMetric2Value || '内容' },
			{ label: formMetric3Label || '亮点 3', value: formMetric3Value || '内容' }
		]
	});

	function fillForm(promotion: PageData['promotions'][number] | null) {
		formId = promotion?.id ?? '';
		formBank = promotion?.bank ?? '';
		formPartner = promotion?.partner ?? '';
		formName = promotion?.name ?? '';
		formDescription = promotion?.description ?? '';
		formMetric1Label = metric(promotion, 0).label;
		formMetric1Value = metric(promotion, 0).value;
		formMetric2Label = metric(promotion, 1).label;
		formMetric2Value = metric(promotion, 1).value;
		formMetric3Label = metric(promotion, 2).label;
		formMetric3Value = metric(promotion, 2).value;
		formHref = promotion?.href ?? '';
		formSortOrder = promotion?.sortOrder ?? 100;
		formImage = promotion?.image ?? '';
		formAlt = promotion?.alt ?? '';
		formEnabled = promotion?.enabled ?? true;
		clearUploadPreview();
	}

	function startEdit(promotion: PageData['promotions'][number]) {
		editing = promotion;
		fillForm(promotion);
	}

	function resetEdit() {
		editing = null;
		fillForm(null);
	}

	function metric(promotion: PageData['promotions'][number] | null | undefined, index: number) {
		return promotion?.metrics[index] ?? { label: '', value: '' };
	}

	function clearUploadPreview() {
		uploadRotation = 'none';
		processedImageDataUrl = '';
		uploadPreviewUrl = '';
		uploadError = '';
		if (imageInput) imageInput.value = '';
	}

	function setUploadRotation(rotation: 'none' | 'left' | 'right') {
		uploadRotation = rotation;
		void processSelectedImage();
	}

	function handleImageChange() {
		void processSelectedImage();
	}

	async function processSelectedImage() {
		const file = imageInput?.files?.[0];
		uploadError = '';
		processedImageDataUrl = '';
		uploadPreviewUrl = '';
		if (!file) return;

		if (uploadRotation === 'none') {
			uploadPreviewUrl = URL.createObjectURL(file);
			return;
		}

		try {
			const bitmap = await createImageBitmap(file);
			const rotateRight = uploadRotation === 'right';
			const canvas = document.createElement('canvas');
			canvas.width = bitmap.height;
			canvas.height = bitmap.width;
			const context = canvas.getContext('2d');
			if (!context) throw new Error('无法处理图片');
			context.translate(canvas.width / 2, canvas.height / 2);
			context.rotate((rotateRight ? 90 : -90) * Math.PI / 180);
			context.drawImage(bitmap, -bitmap.width / 2, -bitmap.height / 2);
			bitmap.close();

			const dataUrl = canvas.toDataURL('image/jpeg', 0.88);
			processedImageDataUrl = dataUrl;
			uploadPreviewUrl = dataUrl;
		} catch {
			uploadError = '图片旋转失败，请换一张 JPG、PNG 或 WEBP 再试。';
		}
	}
</script>

<svelte:head>
	<title>首页推荐管理 — 贝利卡管家</title>
</svelte:head>

<main class="min-h-screen bg-gray-50 px-5 py-8 lg:px-8">
	<div class="mx-auto max-w-[1680px]">
		<div class="mb-8 flex items-start justify-between gap-6">
			<div>
				<a href="/dashboard" class="text-sm font-medium text-blue-600 hover:text-blue-700">← 返回我的卡片</a>
				<h1 class="mt-3 text-3xl font-bold text-gray-950">首页推荐管理</h1>
				<p class="mt-2 text-sm text-gray-500">首页只展示卡名、一句活动说明、卡图和立即办卡入口。</p>
			</div>
			<div class="flex gap-2">
				<a href="/admin/catalog" class="rounded-full bg-white px-4 py-2 text-sm font-medium text-gray-700 ring-1 ring-gray-200 hover:bg-gray-50">
					卡库管理
				</a>
				<a href="/dashboard" class="rounded-full bg-blue-600 px-4 py-2 text-sm font-medium text-white hover:bg-blue-700">
					查看首页
				</a>
			</div>
		</div>

		{#if data.configMissing}
			<div class="mb-4 rounded-xl border border-amber-200 bg-amber-50 p-4 text-sm text-amber-700">
				推荐数据暂时不可用，当前展示默认推荐。请稍后刷新后再编辑。
			</div>
		{/if}

		{#if form && 'error' in form && form.error}
			<div class="mb-4 rounded-xl border border-red-200 bg-red-50 p-4 text-sm text-red-700">{form.error}</div>
		{/if}

		{#if data.saved}
			<div class="mb-4 rounded-xl border border-emerald-200 bg-emerald-50 p-4 text-sm text-emerald-700">已保存首页推荐。</div>
		{/if}

		<div class="grid gap-8 xl:grid-cols-[minmax(600px,0.9fr)_minmax(760px,1.1fr)]">
			<section class="rounded-3xl border border-gray-200 bg-white p-6 shadow-sm">
				<div class="flex items-center justify-between">
					<h2 class="text-lg font-semibold text-gray-950">{editing ? '编辑推荐' : '新增推荐'}</h2>
					{#if editing}
						<button type="button" class="rounded-full bg-gray-100 px-3 py-1.5 text-xs font-medium text-gray-600 hover:bg-gray-200" onclick={resetEdit}>
							取消编辑
						</button>
					{/if}
				</div>

				<form method="POST" action="?/save" enctype="multipart/form-data" class="mt-6 space-y-5">
					<label class="block">
						<span class="text-sm font-medium text-gray-700">推荐 ID</span>
						<input name="id" required bind:value={formId} class="mt-2 w-full rounded-xl border border-gray-200 px-3 py-3 text-sm outline-none focus:border-blue-500" placeholder="例如 citic-marriott" />
						<span class="mt-2 block text-xs leading-5 text-gray-400">用于生成默认详情页地址，例如 /refer/citic-marriott。</span>
					</label>

					<label class="block">
						<span class="text-sm font-medium text-gray-700">卡片名称</span>
						<input name="name" required bind:value={formName} class="mt-2 w-full rounded-xl border border-gray-200 px-3 py-3 text-sm outline-none focus:border-blue-500" placeholder="例如：万豪旅享家精逸白金卡" />
					</label>

					<label class="block">
						<span class="text-sm font-medium text-gray-700">活动一句话</span>
						<textarea name="description" required rows="3" bind:value={formDescription} class="mt-2 w-full rounded-xl border border-gray-200 px-3 py-3 text-sm outline-none focus:border-blue-500" placeholder="例如：新户 60 天内消费达标，可拿 30,000 点万豪积分。"></textarea>
					</label>

					<input type="hidden" name="bank" value={formBank || '首页推荐'} />
					<input type="hidden" name="partner" value={formPartner || '办卡活动'} />
					<input type="hidden" name="metric_1_label" value={formMetric1Label || '活动'} />
					<input type="hidden" name="metric_1_value" value={formMetric1Value || '查看详情'} />
					<input type="hidden" name="metric_2_label" value={formMetric2Label || '入口'} />
					<input type="hidden" name="metric_2_value" value={formMetric2Value || '立即办卡'} />
					<input type="hidden" name="metric_3_label" value={formMetric3Label || '状态'} />
					<input type="hidden" name="metric_3_value" value={formMetric3Value || '推荐中'} />

					<label class="block">
						<span class="text-sm font-medium text-gray-700">排序</span>
						<input name="sort_order" type="number" bind:value={formSortOrder} class="mt-2 w-full rounded-xl border border-gray-200 px-3 py-3 text-sm outline-none focus:border-blue-500" />
					</label>

					<label class="block rounded-2xl bg-blue-50/60 p-4 ring-1 ring-blue-100">
						<span class="text-sm font-medium text-gray-700">立即办卡跳转</span>
						<input name="href" bind:value={formHref} class="mt-2 w-full rounded-xl border border-blue-100 bg-white px-3 py-3 text-sm outline-none focus:border-blue-500" placeholder={defaultHref} />
						<span class="mt-2 block text-xs leading-5 text-blue-700">
							留空会自动生成 {defaultHref}；如果银行有直接申请链接，也可以贴在这里。
						</span>
					</label>

					<label class="block">
						<span class="text-sm font-medium text-gray-700">图片地址</span>
						<input name="image_url" bind:value={formImage} class="mt-2 w-full rounded-xl border border-gray-200 px-3 py-3 text-sm outline-none focus:border-blue-500" placeholder="/images/cards/example.webp" />
					</label>

					<label class="block">
						<span class="text-sm font-medium text-gray-700">上传活动图片</span>
						<input
							bind:this={imageInput}
							name="image"
							type="file"
							accept="image/png,image/jpeg,image/webp"
							onchange={handleImageChange}
							class="mt-2 w-full rounded-xl border border-dashed border-gray-300 px-3 py-3 text-sm file:mr-4 file:rounded-lg file:border-0 file:bg-blue-50 file:px-3 file:py-2 file:text-sm file:font-medium file:text-blue-700"
						/>
						<span class="mt-2 block text-xs text-gray-400">可不上传，填图片地址即可；上传图会优先使用，建议 1000×630 左右。</span>
					</label>
					<input type="hidden" name="processed_image" value={processedImageDataUrl} />

					<div class="rounded-2xl bg-gray-50 p-4 ring-1 ring-gray-100">
						<div class="flex flex-wrap items-center justify-between gap-3">
							<span class="text-sm font-medium text-gray-700">上传图片方向</span>
							<div class="flex rounded-full bg-white p-1 ring-1 ring-gray-200">
								<button
									type="button"
									class={`rounded-full px-3 py-1.5 text-xs font-semibold ${uploadRotation === 'none' ? 'bg-blue-600 text-white' : 'text-gray-500 hover:text-blue-700'}`}
									onclick={() => setUploadRotation('none')}
								>
									原图
								</button>
								<button
									type="button"
									class={`rounded-full px-3 py-1.5 text-xs font-semibold ${uploadRotation === 'left' ? 'bg-blue-600 text-white' : 'text-gray-500 hover:text-blue-700'}`}
									onclick={() => setUploadRotation('left')}
								>
									左转 90°
								</button>
								<button
									type="button"
									class={`rounded-full px-3 py-1.5 text-xs font-semibold ${uploadRotation === 'right' ? 'bg-blue-600 text-white' : 'text-gray-500 hover:text-blue-700'}`}
									onclick={() => setUploadRotation('right')}
								>
									右转 90°
								</button>
							</div>
						</div>
						<p class="mt-2 text-xs leading-5 text-gray-400">竖版图片可以先选左转或右转，预览正常后再保存。</p>
						{#if uploadPreviewUrl}
							<img src={uploadPreviewUrl} alt="上传图片预览" class="mt-4 aspect-[1.586] w-full rounded-xl object-cover ring-1 ring-gray-200" />
						{/if}
						{#if uploadError}
							<p class="mt-3 text-sm text-red-600">{uploadError}</p>
						{/if}
					</div>

					<label class="block">
						<span class="text-sm font-medium text-gray-700">图片说明</span>
						<input name="alt" bind:value={formAlt} class="mt-2 w-full rounded-xl border border-gray-200 px-3 py-3 text-sm outline-none focus:border-blue-500" placeholder="默认使用卡片名称" />
					</label>

					<label class="flex items-center gap-3 rounded-2xl bg-gray-50 p-4 text-sm font-medium text-gray-700">
						<input name="enabled" type="checkbox" bind:checked={formEnabled} class="h-5 w-5 rounded border-gray-300 text-blue-600" />
						启用并展示在首页轮播
					</label>

					<button class="w-full rounded-2xl bg-blue-600 px-5 py-3 text-sm font-semibold text-white shadow-sm hover:bg-blue-700">
						{editing ? '保存修改' : '新增推荐'}
					</button>
				</form>
			</section>

			<section class="rounded-3xl border border-gray-200 bg-white p-6 shadow-sm">
				<div class="flex items-center justify-between">
					<h2 class="text-lg font-semibold text-gray-950">首页效果预览</h2>
					<span class="text-sm text-gray-400">{data.promotions.length} 条</span>
				</div>

				<div class="mt-6 overflow-hidden rounded-3xl border border-slate-200 bg-white shadow-sm">
					<div class="bg-gradient-to-br from-white via-slate-50 to-blue-50/70 p-7">
						<p class="text-sm font-bold text-blue-700">精选推荐</p>
						<h3 class="mt-1 text-2xl font-black tracking-tight text-slate-950">什么卡值得申？</h3>

						<div class="mt-6 grid items-center gap-8 lg:grid-cols-[minmax(0,0.82fr)_minmax(460px,1.18fr)]">
							<div class="min-w-0">
								<h4 class="max-w-2xl text-4xl font-black leading-[1.08] tracking-tight text-slate-950">
									{preview.name}
								</h4>
								<p class="mt-5 max-w-xl text-base leading-8 text-slate-600">
									{preview.description}
								</p>
								<div class="mt-7">
									<a href={preview.href} class="inline-flex rounded-2xl bg-blue-600 px-5 py-3 text-sm font-bold text-white shadow-lg shadow-blue-600/20 hover:bg-blue-700">
										立即办卡
									</a>
								</div>
							</div>
							<div class="flex min-w-0 items-center justify-center">
								<div class="relative w-full max-w-[540px]">
									<div class="absolute inset-6 rounded-[2rem] bg-blue-200/50 blur-3xl"></div>
									<img
										src={preview.image}
										alt={preview.alt}
										class="relative aspect-[1.586] w-full rounded-[1.7rem] object-cover shadow-2xl shadow-slate-300"
									/>
								</div>
							</div>
						</div>
					</div>
				</div>

				<div class="mt-6 flex items-center justify-between">
					<h2 class="text-lg font-semibold text-gray-950">当前推荐</h2>
					<span class="text-sm text-gray-400">{data.promotions.length} 条</span>
				</div>
				<div class="mt-5 space-y-4">
					{#each data.promotions as promotion}
						<article class="rounded-2xl border border-gray-100 bg-gray-50 p-4">
							<div class="grid gap-4 sm:grid-cols-[220px_minmax(0,1fr)]">
								<img src={promotion.image} alt={promotion.alt} class="aspect-[1.586] w-full rounded-xl object-cover ring-1 ring-gray-200" />
								<div class="min-w-0">
									<div class="flex flex-wrap items-center gap-2">
										<span class="rounded-full bg-white px-2.5 py-1 text-xs font-semibold text-gray-600 ring-1 ring-gray-200">排序 {promotion.sortOrder}</span>
										<span class={`rounded-full px-2.5 py-1 text-xs font-semibold ring-1 ${promotion.enabled ? 'bg-emerald-50 text-emerald-700 ring-emerald-100' : 'bg-gray-100 text-gray-500 ring-gray-200'}`}>
											{promotion.enabled ? '已启用' : '已关闭'}
										</span>
									</div>
									<h3 class="mt-3 text-xl font-black text-gray-950">{promotion.name}</h3>
									<p class="mt-2 line-clamp-2 text-sm leading-6 text-gray-500">{promotion.description}</p>
									<div class="mt-4 flex gap-2">
										<button type="button" class="rounded-full bg-white px-3 py-1.5 text-xs font-medium text-blue-600 ring-1 ring-blue-100 hover:bg-blue-50" onclick={() => startEdit(promotion)}>
											编辑
										</button>
										<form method="POST" action="?/deletePromotion">
											<input type="hidden" name="id" value={promotion.id} />
											<button class="rounded-full bg-white px-3 py-1.5 text-xs font-medium text-red-600 ring-1 ring-red-100 hover:bg-red-50">
												删除
											</button>
										</form>
									</div>
								</div>
							</div>
						</article>
					{/each}
				</div>
			</section>
		</div>
	</div>
</main>
