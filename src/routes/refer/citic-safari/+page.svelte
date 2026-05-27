<script lang="ts">
	import ApplicationFlow from '$lib/components/ApplicationFlow.svelte';
	import RelatedCardLinks from '$lib/components/RelatedCardLinks.svelte';

	const benefits = [
		'8 点境内外机场贵宾厅 / 16 点高铁贵宾厅，+9 元可享餐食',
		'2 次境内 + 1 次境外道路救援',
		'5 次预约挂号 + 全程陪同',
		'中信 36+1 权益，消费达标每月最高 3 点',
		'2 点儿童涂氟',
		'1 点儿童证件照，海马体 / 天真蓝二选一',
		'自带双倍积分，50:1 兑换里程，可叠加悦卡 8 倍积分',
		'延误 2 小时最高赔付 1000 元'
	];
</script>

<svelte:head>
	<title>中信 Safari 卡申请流程 — 贝利卡管家</title>
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
			<div class="grid gap-8 bg-gradient-to-br from-white via-slate-50 to-blue-50/70 p-7 lg:grid-cols-[minmax(0,1fr)_420px] lg:p-10">
				<div class="flex min-w-0 items-center">
					<h1 class="max-w-3xl text-5xl font-black leading-[1.08] tracking-tight text-slate-950">
						Safari 联名信用卡
					</h1>
				</div>

				<div class="flex items-center justify-center">
					<div class="relative w-full max-w-[420px]">
						<div class="absolute inset-6 rounded-[2rem] bg-blue-200/50 blur-3xl"></div>
						<img
							src="/images/cards/citic-safari-card-cropped.webp"
							alt="中信银行 Safari 信用卡"
							class="relative aspect-[1.586] w-full rounded-[1.7rem] object-cover shadow-2xl shadow-slate-300"
						/>
					</div>
				</div>
			</div>
		</section>

		<section class="mt-8 rounded-3xl border border-slate-200 bg-white p-6 shadow-sm">
			<h2 class="text-xl font-black text-slate-950">权益介绍</h2>
			<div class="mt-5 grid gap-3 sm:grid-cols-2">
				{#each benefits as benefit}
					<div class="rounded-2xl bg-slate-50 p-4 text-sm font-semibold leading-6 text-slate-700 ring-1 ring-slate-200">
						{benefit}
					</div>
				{/each}
			</div>
		</section>

		<section id="apply" class="mt-8 grid gap-8 lg:grid-cols-[minmax(0,1fr)_340px]">
			<ApplicationFlow
				applyQrAlt="中信 Safari 联名信用卡新户专属申请二维码"
				rewardDescription="完成渠道要求后添加贝利小助手微信，备注办卡信息，领取对应渠道红包。"
			/>

			<aside class="rounded-3xl border border-slate-200 bg-white p-6 shadow-sm lg:sticky lg:top-24 lg:self-start">
				<h2 class="text-lg font-black text-slate-950">办卡前确认</h2>
				<div class="mt-5 space-y-3 text-sm leading-6 text-slate-600">
					<p>适用场景：贵宾厅、里程兑换、亲子权益、道路救援和航延保障。</p>
					<p>积分权益：自带双倍积分，50:1 兑换里程，可叠加悦卡 8 倍积分。</p>
					<p>申请结果：以银行审核及渠道页面最新说明为准。</p>
				</div>
				<div class="mt-6 rounded-2xl bg-amber-50 p-4 text-sm leading-6 text-amber-800 ring-1 ring-amber-100">
					权益次数、达标要求、可兑换项目和赔付规则可能随银行活动调整，实际以中信银行及渠道页面最新说明为准。
				</div>
			</aside>
		</section>

		<RelatedCardLinks current="safari" />
	</div>
</main>
