<script lang="ts">
	type Props = {
		rewardDescription?: string;
		applyQrAlt?: string;
	};

	let {
		rewardDescription = '激活后 60 天内计积分消费满 30,000 元，可获 30,000 点万豪积分；完成达标后添加贝利小助手微信，领取渠道红包。',
		applyQrAlt = '中信信用卡新户专属申请二维码'
	}: Props = $props();

	let steps = $derived([
		{
			title: '确认新户资格',
			description: '适合从未持有中信信用卡，或已销户满 180 天的用户。先确认资格，再进入申请。'
		},
		{
			title: '通过专属链接申请',
			description: '必须扫描贝利这边的新户专属二维码，或通过专属活动链接提交申请；自己直接去银行申请不包含渠道福利。申请结果以银行审核为准。'
		},
		{
			title: '激活并完成绑定任务',
			description: '卡片获批并激活后，按渠道页面提示完成指定绑定任务即可；不需要额外理解成复杂操作。'
		},
		{
			title: '达标后加微信领取红包',
			description: rewardDescription
		}
	]);
</script>

<div class="rounded-3xl border border-slate-200 bg-white p-6 shadow-sm">
	<h2 class="text-xl font-black text-slate-950">申请流程</h2>
	<div class="mt-6 space-y-4">
		{#each steps as step, index}
			<div class="flex gap-4 rounded-2xl bg-slate-50 p-4 ring-1 ring-slate-200">
				<div class="grid h-9 w-9 shrink-0 place-items-center rounded-full bg-blue-600 text-sm font-black text-white">
					{index + 1}
				</div>
				<div class="min-w-0 flex-1">
					<h3 class="font-bold text-slate-950">{step.title}</h3>
					<p class="mt-1 text-sm leading-6 text-slate-500">{step.description}</p>
					{#if index === 1}
						<div class="mt-4 grid gap-3 rounded-2xl bg-white p-4 ring-1 ring-blue-100 sm:grid-cols-[140px_minmax(0,1fr)]">
							<img
								src="/images/referrals/citic-marriott-apply-qr.png"
								alt={applyQrAlt}
								class="aspect-square w-full rounded-xl border border-blue-100 bg-white object-cover"
							/>
							<div class="flex flex-col justify-center">
								<p class="text-sm font-bold text-slate-950">扫码走贝利专属渠道</p>
								<p class="mt-1 text-sm leading-6 text-slate-500">
									200 元京东 E 卡属于渠道福利，需要通过这里的二维码或专属链接申请，后续达标后按渠道规则发放。
								</p>
							</div>
						</div>
					{/if}
					{#if index === 3}
						<div class="mt-4 grid gap-3 rounded-2xl bg-white p-4 ring-1 ring-blue-100 sm:grid-cols-[140px_minmax(0,1fr)]">
							<img
								src="/images/referrals/baily-assistant-wechat.jpg"
								alt="贝利小助手微信二维码"
								class="aspect-square w-full rounded-xl border border-blue-100 bg-white object-cover object-center"
							/>
							<div class="flex flex-col justify-center">
								<p class="text-sm font-bold text-slate-950">添加贝利小助手领取红包</p>
								<p class="mt-1 text-sm leading-6 text-slate-500">
									完成达标后，扫码添加微信并备注办卡信息，方便核对渠道资格和红包领取。
								</p>
							</div>
						</div>
					{/if}
				</div>
			</div>
		{/each}
	</div>
</div>
