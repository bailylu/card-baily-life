<script lang="ts">
	import ApplicationFlow from '$lib/components/ApplicationFlow.svelte';
	import RelatedCardLinks from '$lib/components/RelatedCardLinks.svelte';

	const airlines = ['东航', '厦航', '川航', '南航', '海航', '深航'];
	const benefits = [
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
	<title>中信航司联名信用卡申请流程 — 贝利卡管家</title>
</svelte:head>

<main class="refer-dark min-h-screen text-slate-950">
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
				<div>
					<div class="flex flex-wrap items-center gap-2">
						<span class="rounded-full bg-blue-600 px-3 py-1 text-xs font-bold text-white">申请流程</span>
						<span class="rounded-full bg-white/80 px-3 py-1 text-xs font-semibold text-blue-700 ring-1 ring-blue-100">航司组合</span>
					</div>
					<p class="mt-8 text-sm font-bold text-blue-700">中信银行 · 航空里程组合</p>
					<h1 class="mt-3 max-w-3xl text-4xl font-black leading-tight tracking-tight text-slate-950">
						航司联名信用卡
					</h1>
					<p class="mt-5 max-w-2xl text-base leading-8 text-slate-600">
						把东航、厦航、川航、南航、海航和深航的中信航司联名卡放在一个入口里比较。适合先按常飞航线和里程用途筛选，再看活动门槛和渠道福利。
					</p>

					<div class="mt-7 flex flex-wrap gap-2">
						{#each airlines as airline}
							<span class="rounded-full bg-white px-4 py-2 text-sm font-bold text-slate-700 ring-1 ring-slate-200">
								{airline}
							</span>
						{/each}
					</div>

					<div class="mt-7 grid gap-3 sm:grid-cols-3">
						<div class="rounded-2xl bg-white/75 p-4 ring-1 ring-slate-200/80">
							<p class="text-xs font-semibold text-slate-400">核心关注</p>
							<p class="mt-2 text-sm font-bold text-slate-950">里程累积</p>
						</div>
						<div class="rounded-2xl bg-white/75 p-4 ring-1 ring-slate-200/80">
							<p class="text-xs font-semibold text-slate-400">适合人群</p>
							<p class="mt-2 text-sm font-bold text-slate-950">常旅客 / 差旅</p>
						</div>
						<div class="rounded-2xl bg-white/75 p-4 ring-1 ring-slate-200/80">
							<p class="text-xs font-semibold text-slate-400">后续接入</p>
							<p class="mt-2 text-sm font-bold text-slate-950">活动和返利</p>
						</div>
					</div>
				</div>

				<div class="flex items-center justify-center">
					<div class="relative w-full max-w-[420px]">
						<div class="absolute inset-6 rounded-[2rem] bg-blue-200/50 blur-3xl"></div>
						<img
							src="/images/cards/citic-airlines-combo.webp"
							alt="中信银行航司联名信用卡组合"
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
				applyQrAlt="中信航司联名信用卡新户专属申请二维码"
				rewardDescription="完成渠道要求后添加贝利小助手微信，备注办卡信息，方便核对资格和红包领取。"
			/>

			<aside class="rounded-3xl border border-slate-200 bg-white p-6 shadow-sm lg:sticky lg:top-24 lg:self-start">
				<h2 class="text-lg font-black text-slate-950">办卡前确认</h2>
				<div class="mt-5 space-y-3 text-sm leading-6 text-slate-600">
					<p>适合关注南航里程、贵宾厅、出行保障、道路救援和医疗陪护权益的人。</p>
					<p>里程、保险、分期和服务权益以中信银行及渠道页面最新说明为准。</p>
				</div>
				<div class="mt-6 rounded-2xl bg-amber-50 p-4 text-sm leading-6 text-amber-800 ring-1 ring-amber-100">
					中信航司联名卡会根据航司、卡等级和活动周期变化，后续可以在这里补充每张卡的年费、里程比例、达标奖励和渠道福利。
				</div>
			</aside>
		</section>

		<RelatedCardLinks current="airlines" />
	</div>
</main>
