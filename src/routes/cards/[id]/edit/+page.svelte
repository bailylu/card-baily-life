<script lang="ts">
	import CardFace from '$lib/components/CardFace.svelte';
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
		<p class="mt-1 text-sm text-gray-500">只修改备注、尾号和提醒日期；卡片种类不能在这里更换。</p>

		{#if form?.error}
			<div class="mt-4 rounded-xl border border-red-200 bg-red-50 p-4 text-sm text-red-700">
				{form.error}
			</div>
		{/if}

		{#if data.card}
			<form method="POST" action="?/save" class="mt-6 space-y-5 rounded-xl border border-gray-200 bg-white p-5">
				<input type="hidden" name="catalog_id" value={data.card.catalog_id ?? ''} />

				<section class="rounded-2xl bg-gray-50 p-4">
					<div class="flex items-center justify-between gap-3">
						<div>
							<h2 class="text-sm font-semibold text-gray-900">当前卡片</h2>
							<p class="mt-1 text-xs text-gray-500">如需更换卡种，请删除后重新添加。</p>
						</div>
						<span class="rounded-full bg-gray-200 px-3 py-1 text-xs font-medium text-gray-600">不可更换</span>
					</div>
						<CardFace
							imageUrl={data.card.image_url}
							bankName={data.card.bank_name}
							displayName={data.card.displayName}
							lastFour={data.card.last_four}
							cardStyle={data.card.cardStyle}
							class="mt-4"
						/>
					</section>

				<section class="rounded-2xl bg-gray-50 p-4">
					<h2 class="text-sm font-semibold text-gray-900">卡片信息</h2>
					<p class="mt-1 text-xs text-gray-500">备注名称只在你的卡片列表里显示，方便自己识别。</p>
					<div class="mt-4 grid gap-4 sm:grid-cols-2">
						<label class="block sm:col-span-2">
							<span class="text-sm font-medium text-gray-700">备注名称</span>
							<input
								name="custom_name"
								value={data.card.custom_name ?? ''}
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
								value={data.card.last_four}
								class="mt-1 w-full rounded-lg border border-gray-300 px-3 py-2"
							/>
						</label>
						<label class="block">
							<span class="text-sm font-medium text-gray-700">提前提醒天数</span>
							<select name="lead_days" class="mt-1 w-full rounded-lg border border-gray-300 px-3 py-2" required>
								<option value="0" selected={data.card.lead_days === 0}>当天提醒</option>
								<option value="1" selected={data.card.lead_days === 1}>提前 1 天</option>
								<option value="3" selected={data.card.lead_days === 3}>提前 3 天</option>
								<option value="5" selected={data.card.lead_days === 5}>提前 5 天</option>
								<option value="7" selected={data.card.lead_days === 7}>提前 7 天</option>
								<option value="10" selected={data.card.lead_days === 10}>提前 10 天</option>
								<option value="15" selected={data.card.lead_days === 15}>提前 15 天</option>
							</select>
						</label>
					</div>
				</section>

				<section class="rounded-2xl bg-blue-50/60 p-4">
					<h2 class="text-sm font-semibold text-gray-900">循环提醒日期</h2>
					<p class="mt-1 text-xs leading-5 text-gray-500">账单日和还款日按每个自然月循环，月末日期按当月日历处理。</p>
					<div class="mt-4 grid gap-4 sm:grid-cols-2">
						<label class="block">
							<span class="text-sm font-medium text-gray-700">账单日（每月）</span>
							<select name="statement_day" required class="mt-1 w-full rounded-lg border border-gray-300 px-3 py-2">
								{#each Array.from({ length: 31 }, (_, index) => index + 1) as day}
									<option value={day} selected={data.card.statement_day === day}>{day} 日</option>
								{/each}
							</select>
						</label>
						<label class="block">
							<span class="text-sm font-medium text-gray-700">还款日（每月）</span>
							<select name="due_day" required class="mt-1 w-full rounded-lg border border-gray-300 px-3 py-2">
								{#each Array.from({ length: 31 }, (_, index) => index + 1) as day}
									<option value={day} selected={data.card.due_day === day}>{day} 日</option>
								{/each}
							</select>
						</label>
					</div>
				</section>

				<section class="rounded-2xl bg-amber-50/70 p-4">
					<h2 class="text-sm font-semibold text-gray-900">年费提醒（可选）</h2>
					<p class="mt-1 text-xs text-gray-500">年费通常一年一次，填写月份和日期后，每年提醒一次；不需要就留空。</p>
					<div class="mt-4 grid gap-4 sm:grid-cols-2">
						<label class="block">
							<span class="text-sm font-medium text-gray-700">年费月份</span>
							<select name="annual_fee_month" class="mt-1 w-full rounded-lg border border-gray-300 px-3 py-2">
								<option value="">不设置</option>
								{#each Array.from({ length: 12 }, (_, index) => index + 1) as month}
									<option value={month} selected={data.card.annual_fee_month === month}>{month} 月</option>
								{/each}
							</select>
						</label>
						<label class="block">
							<span class="text-sm font-medium text-gray-700">年费日期</span>
							<select name="annual_fee_day" class="mt-1 w-full rounded-lg border border-gray-300 px-3 py-2">
								<option value="">不设置</option>
								{#each Array.from({ length: 31 }, (_, index) => index + 1) as day}
									<option value={day} selected={data.card.annual_fee_day === day}>{day} 日</option>
								{/each}
							</select>
						</label>
					</div>
				</section>

				<button class="w-full rounded-lg bg-blue-600 px-4 py-3 font-medium text-white hover:bg-blue-700">
					保存修改
				</button>
			</form>

			<form method="POST" action="?/delete" class="mt-4 rounded-xl border border-red-100 bg-white p-5">
				<p class="text-sm font-semibold text-gray-900">删除卡片</p>
				<p class="mt-1 text-xs text-gray-500">删除后，这张卡片和它的提醒预览会从你的列表移除。</p>
				<button class="mt-4 w-full rounded-lg border border-red-200 bg-red-50 px-4 py-3 font-medium text-red-600 hover:bg-red-100">
					删除这张卡片
				</button>
			</form>
		{/if}
	</div>
</main>
