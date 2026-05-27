<script lang="ts">
	import ApplicationFlow from '$lib/components/ApplicationFlow.svelte';
	import RelatedCardLinks from '$lib/components/RelatedCardLinks.svelte';
	import type { PageData } from './$types';

	let { data }: { data: PageData } = $props();
	let promotion = $derived(data.promotion);
	let isAirlinePromotion = $derived(promotion.id.includes('航司') || promotion.name.includes('航司'));

	const airlineBenefits = [
		'交易累计南航里程：指定渠道每交易人民币 10 元累计 1 个南航里程',
		'“36+1”新生活：网球、羽毛球、健身等运动项目，以及代驾、接送机、酒店住宿、健康关怀等服务',
		'8 点机场 / 高铁贵宾休息室',
		'2 小时航班延误险，最高可达 1000 元',
		'1500 万元航空意外险',
		'30000 元盗刷保障险',
		'汽车道路救援',
		'预约挂号及陪护',
		'消费分期最高可达 30 万元',
		'1-36 期多样化分期可选'
	];
</script>

<svelte:head>
	<title>{promotion.name} — 贝利卡管家</title>
</svelte:head>

<main class="min-h-screen bg-[#f5f7fb] text-slate-950">
	<header class="border-b border-slate-200/80 bg-white/90 backdrop-blur">
		<div class="mx-auto flex max-w-6xl items-center justify-between px-6 py-4">
			<a href="/dashboard" class="text-sm font-semibold text-blue-600 hover:text-blue-700">← 返回我的卡片</a>
			<a href="/me" class="rounded-full border border-slate-200 bg-white px-4 py-2 text-sm font-semibold text-slate-700 hover:border-blue-200 hover:text-blue-700">
				订阅活动通知
			</a>
		</div>
	</header>

	<div class="mx-auto max-w-6xl px-6 py-8">
		<section class="overflow-hidden rounded-3xl border border-slate-200 bg-white shadow-sm">
			<div class="grid gap-8 bg-gradient-to-br from-white via-slate-50 to-blue-50/70 p-7 lg:grid-cols-[minmax(0,1fr)_460px] lg:p-10">
				<div class="flex min-w-0 items-center">
					<h1 class="max-w-3xl text-5xl font-black leading-[1.08] tracking-tight text-slate-950">
						{promotion.name}
					</h1>
				</div>

				<div class="flex items-center justify-center">
					<div class="relative w-full max-w-[460px]">
						<div class="absolute inset-6 rounded-[2rem] bg-blue-200/50 blur-3xl"></div>
						<img
							src={promotion.image}
							alt={promotion.alt}
							class="relative aspect-[1.586] w-full rounded-[1.7rem] object-cover shadow-2xl shadow-slate-300"
						/>
					</div>
				</div>
			</div>
		</section>

		{#if isAirlinePromotion}
			<section class="mt-8 rounded-3xl border border-slate-200 bg-white p-6 shadow-sm">
				<h2 class="text-xl font-black text-slate-950">权益介绍</h2>
				<div class="mt-5 grid gap-3 sm:grid-cols-2">
					{#each airlineBenefits as benefit}
						<div class="rounded-2xl bg-slate-50 p-4 text-sm font-semibold leading-6 text-slate-700 ring-1 ring-slate-200">
							{benefit}
						</div>
					{/each}
				</div>
			</section>

		{/if}

		<section class="mt-8 grid gap-8 lg:grid-cols-[minmax(0,1fr)_340px]">
			{#if isAirlinePromotion}
				<ApplicationFlow
					applyQrAlt="中信航司联名信用卡新户专属申请二维码"
					rewardDescription="完成渠道要求后添加贝利小助手微信，备注办卡信息，方便核对资格和红包领取。"
				/>
			{:else}
				<div class="rounded-3xl border border-slate-200 bg-white p-6 shadow-sm">
					<h2 class="text-xl font-black text-slate-950">怎么申请</h2>
					<div class="mt-6 space-y-4">
						<div class="rounded-2xl bg-slate-50 p-5 ring-1 ring-slate-200">
							<h3 class="font-bold text-slate-950">1. 确认这张卡是否适合你</h3>
							<p class="mt-2 text-sm leading-6 text-slate-500">先看推荐理由、活动门槛、权益和年费，再决定要不要继续申请。</p>
						</div>
						<div class="rounded-2xl bg-slate-50 p-5 ring-1 ring-slate-200">
							<h3 class="font-bold text-slate-950">2. 通过专属入口申请</h3>
							<p class="mt-2 text-sm leading-6 text-slate-500">这里可以放银行申请入口、二维码、渠道说明或客服微信。当前通用详情页先承载推荐内容，后续可继续加专属申请模块。</p>
						</div>
						<div class="rounded-2xl bg-slate-50 p-5 ring-1 ring-slate-200">
							<h3 class="font-bold text-slate-950">3. 订阅后续活动通知</h3>
							<p class="mt-2 text-sm leading-6 text-slate-500">如果活动、返利或申请规则有变化，可以在“我的信息”里开启通知。</p>
						</div>
					</div>
				</div>
			{/if}

			<aside class="rounded-3xl border border-slate-200 bg-white p-6 shadow-sm lg:sticky lg:top-24 lg:self-start">
				<h2 class="text-lg font-black text-slate-950">{isAirlinePromotion ? '办卡前确认' : '绑定关系'}</h2>
				<div class="mt-5 space-y-3 text-sm leading-6 text-slate-600">
					{#if isAirlinePromotion}
						<p>适合关注南航里程、贵宾厅、出行保障、道路救援和医疗陪护权益的人。</p>
						<p>里程、保险、分期和服务权益以中信银行及渠道页面最新说明为准。</p>
					{:else}
						<p>推荐 ID：<span class="font-semibold text-slate-950">{promotion.id}</span></p>
						<p>首页按钮会跳到后台填写的地址；留空时默认就是这个详情页。</p>
						<p>需要更完整的专题页时，可以在后台把跳转地址改成已有页面或外部申请链接。</p>
					{/if}
				</div>
			</aside>
		</section>

		{#if isAirlinePromotion}
			<RelatedCardLinks current="airlines" />
		{/if}
	</div>
</main>
