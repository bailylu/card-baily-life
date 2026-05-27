<script lang="ts">
	import ApplicationFlow from '$lib/components/ApplicationFlow.svelte';
	import RelatedCardLinks from '$lib/components/RelatedCardLinks.svelte';

	const benefits = [
		'限时消费 3 万元，奖励 30,000 点万豪积分，限中信新户',
		'每年送 1 晚万豪酒店住宿，12500 积分房券',
		'持卡期间享万豪旅享家金卡会籍',
		'日常消费每 10 元可获 1 个万豪积分，酒店消费每 10 元可获 2 个万豪积分',
		'酒店优惠：9 折住宿优惠，8 折餐饮优惠',
		'每年 4 次机场或 8 次高铁贵宾厅权益，即 4 点龙腾；机场每次扣 1 点，高铁站每次扣 0.5 点；餐食体验厅每次额外 +9 元',
		'道路救援：2 次境内、1 次境外',
		'预约挂号及陪诊：3 次/年',
		'盗刷险、航延险和航意险'
	];
</script>

<svelte:head>
	<title>中信万豪精逸白金卡申请流程 — 贝利卡管家</title>
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
				<div class="flex min-w-0 flex-col justify-center">
					<h1 class="max-w-3xl text-5xl font-black leading-[1.08] tracking-tight text-slate-950">
						万豪精逸白金卡
					</h1>
				</div>

				<div class="flex items-center justify-center">
					<div class="relative w-full max-w-[420px]">
						<div class="absolute inset-6 rounded-[2rem] bg-blue-200/50 blur-3xl"></div>
						<img
							src="/images/cards/citic-marriott-bonvoy.webp"
							alt="中信银行万豪精逸白金卡"
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
			<ApplicationFlow applyQrAlt="中信万豪精逸白金卡新户专属申请二维码" />

			<aside class="rounded-3xl border border-slate-200 bg-white p-6 shadow-sm lg:sticky lg:top-24 lg:self-start">
				<h2 class="text-lg font-black text-slate-950">办卡前确认</h2>
				<div class="mt-5 space-y-3 text-sm leading-6 text-slate-600">
					<p>权益活动：限时消费 3 万元，奖励 30,000 点万豪积分，限中信新户。</p>
					<p>核心权益：每年 1 晚万豪酒店住宿、万豪旅享家金卡会籍、贵宾厅、道路救援、预约挂号及陪诊。</p>
					<p>保险权益：盗刷险、航延险和航意险。</p>
				</div>
				<div class="mt-6 rounded-2xl bg-amber-50 p-4 text-sm leading-6 text-amber-800 ring-1 ring-amber-100">
					权益次数、消费达标、房券使用和贵宾厅扣点规则可能随银行活动调整，实际以中信银行及渠道页面最新说明为准。
				</div>
			</aside>
		</section>

		<RelatedCardLinks current="marriott" />
	</div>
</main>
