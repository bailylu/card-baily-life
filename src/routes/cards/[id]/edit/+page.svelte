<script lang="ts">
	import type { ActionData, PageData } from './$types';
	let { data, form }: { data: PageData; form: ActionData } = $props();
</script>

<svelte:head>
	<title>编辑卡片 — card.baily.life</title>
</svelte:head>

<main class="min-h-screen bg-gray-50 px-4 py-8">
	<div class="mx-auto max-w-2xl">
		<a href="/dashboard" class="text-sm text-blue-600 hover:text-blue-700">← 返回我的卡片</a>
		<h1 class="mt-4 text-2xl font-bold text-gray-900">编辑卡片</h1>

		{#if form?.error}
			<div class="mt-4 rounded-xl border border-red-200 bg-red-50 p-4 text-sm text-red-700">
				{form.error}
			</div>
		{/if}

		{#if data.card}
			<form method="POST" action="?/save" class="mt-6 space-y-5 rounded-xl border border-gray-200 bg-white p-5">
				<section>
					<div class="flex items-center justify-between gap-3">
						<span class="text-sm font-medium text-gray-700">卡片种类</span>
						<span class="text-xs text-gray-400">切换后会保留日期设置</span>
					</div>
					<div class="mt-3 grid gap-3 sm:grid-cols-2">
						<label class="cursor-pointer">
							<input class="peer sr-only" type="radio" name="catalog_id" value="" checked={data.card.catalog_id === null} />
							<div class="rounded-2xl border border-gray-200 bg-gray-50 p-4 transition peer-checked:border-blue-500 peer-checked:ring-2 peer-checked:ring-blue-100">
								<div class="relative overflow-hidden rounded-xl bg-gradient-to-br from-slate-700 to-slate-950 p-4 text-white shadow-sm">
									<div class="absolute -right-8 -top-8 h-24 w-24 rounded-full bg-white/10"></div>
									<div class="relative">
										<div class="flex items-center justify-between text-xs opacity-80">
											<span>card.baily.life</span>
											<span>自定义</span>
										</div>
										<p class="mt-8 text-base font-semibold">自定义信用卡</p>
										<p class="mt-3 font-mono text-xs tracking-[0.3em] opacity-80">•••• {data.card.last_four}</p>
									</div>
								</div>
								<p class="mt-3 text-sm font-medium text-gray-900">自定义卡片</p>
								<p class="mt-1 text-xs text-gray-500">适合没有在卡片库中的卡</p>
							</div>
						</label>

						{#each data.catalog as card}
							<label class="cursor-pointer">
								<input
									class="peer sr-only"
									type="radio"
									name="catalog_id"
									value={card.id}
									checked={data.card.catalog_id === card.id}
								/>
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
											<p class="mt-3 font-mono text-xs tracking-[0.3em] opacity-80">•••• {data.card.last_four}</p>
										</div>
									</div>
									<p class="mt-3 text-sm font-medium text-gray-900">{card.bank_name} {card.card_name}</p>
									<p class="mt-1 text-xs text-gray-500">{card.card_tier ?? '标准卡'} · 年费以实际账单为准</p>
								</div>
							</label>
						{/each}
					</div>
				</section>

				<label class="block">
					<span class="text-sm font-medium text-gray-700">自定义名称</span>
					<input
						name="custom_name"
						value={data.card.custom_name ?? ''}
						class="mt-1 w-full rounded-lg border border-gray-300 px-3 py-2"
					/>
				</label>

				<div class="grid gap-4 sm:grid-cols-2">
					<label class="block">
						<span class="text-sm font-medium text-gray-700">卡片尾号</span>
						<input
							name="last_four"
							inputmode="numeric"
							maxlength="4"
							required
							value={data.card.last_four}
							class="mt-1 w-full rounded-lg border border-gray-300 px-3 py-2"
						/>
					</label>
					<label class="block">
						<span class="text-sm font-medium text-gray-700">提前提醒天数</span>
						<input
							name="lead_days"
							type="number"
							min="0"
							max="30"
							required
							value={data.card.lead_days}
							class="mt-1 w-full rounded-lg border border-gray-300 px-3 py-2"
						/>
					</label>
				</div>

				<div class="grid gap-4 sm:grid-cols-2">
					<label class="block">
						<span class="text-sm font-medium text-gray-700">账单日</span>
						<input
							name="statement_day"
							type="number"
							min="1"
							max="31"
							required
							value={data.card.statement_day}
							class="mt-1 w-full rounded-lg border border-gray-300 px-3 py-2"
						/>
					</label>
					<label class="block">
						<span class="text-sm font-medium text-gray-700">还款日</span>
						<input
							name="due_day"
							type="number"
							min="1"
							max="31"
							required
							value={data.card.due_day}
							class="mt-1 w-full rounded-lg border border-gray-300 px-3 py-2"
						/>
					</label>
				</div>

				<div class="grid gap-4 sm:grid-cols-2">
					<label class="block">
						<span class="text-sm font-medium text-gray-700">年费月份（可选）</span>
						<input
							name="annual_fee_month"
							type="number"
							min="1"
							max="12"
							value={data.card.annual_fee_month ?? ''}
							class="mt-1 w-full rounded-lg border border-gray-300 px-3 py-2"
						/>
					</label>
					<label class="block">
						<span class="text-sm font-medium text-gray-700">年费日期（可选）</span>
						<input
							name="annual_fee_day"
							type="number"
							min="1"
							max="31"
							value={data.card.annual_fee_day ?? ''}
							class="mt-1 w-full rounded-lg border border-gray-300 px-3 py-2"
						/>
					</label>
				</div>

				<button class="w-full rounded-lg bg-blue-600 px-4 py-3 font-medium text-white hover:bg-blue-700">
					保存修改
				</button>
			</form>

			<form method="POST" action="?/delete" class="mt-4">
				<button class="w-full rounded-lg border border-red-200 bg-white px-4 py-3 font-medium text-red-600 hover:bg-red-50">
					删除这张卡片
				</button>
			</form>
		{/if}
	</div>
</main>
