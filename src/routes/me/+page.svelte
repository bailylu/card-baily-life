<script lang="ts">
	import type { ActionData, PageData } from './$types';

	let { data, form }: { data: PageData; form: ActionData } = $props();
	let settings = $derived(form && 'settings' in form && form.settings ? form.settings : data.settings);

	const categories = [
		{
			name: 'statementEnabled',
			title: '账单日提醒',
			description: '每月账单日相关提醒。',
			enabled: () => settings.statementEnabled
		},
		{
			name: 'dueEnabled',
			title: '还款日提醒',
			description: '避免错过信用卡还款。',
			enabled: () => settings.dueEnabled
		},
		{
			name: 'annualFeeEnabled',
			title: '年费提醒',
			description: '年费日或免年费复核提醒。',
			enabled: () => settings.annualFeeEnabled
		},
		{
			name: 'offerEnabled',
			title: '权益活动通知',
			description: '好卡推荐、开卡活动和权益变化。',
			enabled: () => settings.offerEnabled
		}
	] as const;
</script>

<svelte:head>
	<title>我的信息 — 贝利卡管家</title>
</svelte:head>

<main class="min-h-screen bg-gray-50">
	<header class="border-b border-gray-200 bg-white">
		<div class="mx-auto flex max-w-3xl items-center justify-between px-4 py-5">
			<div>
				<a href="/dashboard" class="text-sm text-gray-400 hover:text-gray-700">← 返回我的卡片</a>
				<h1 class="mt-2 text-2xl font-bold text-gray-900">我的信息</h1>
			</div>
			<form method="POST" action="/logout">
				<button class="text-sm text-gray-400 hover:text-gray-700">退出</button>
			</form>
		</div>
	</header>

	<div class="mx-auto max-w-3xl space-y-6 px-4 py-8">
		<section class="rounded-2xl border border-gray-200 bg-white p-5">
			<p class="text-sm font-semibold text-gray-900">账号</p>
			<div class="mt-4 text-sm text-gray-500">
				<div class="rounded-xl bg-gray-50 p-4">
					<p class="text-xs text-gray-400">登录邮箱</p>
					<p class="mt-1 break-all font-medium text-gray-900">{data.user.email}</p>
				</div>
			</div>
		</section>

		<section class="rounded-2xl border border-gray-200 bg-white p-5">
				<div class="flex items-start justify-between gap-4">
					<div>
						<h2 class="text-lg font-semibold text-gray-900">即时通知设置</h2>
						<p class="mt-1 text-sm text-gray-500">选择一种适合你的免费即时通知方式；填写 Token 后自动开启，留空表示关闭。</p>
					</div>
					<a href="/me/password" class="shrink-0 text-sm font-medium text-blue-600 hover:text-blue-700">修改密码</a>
			</div>

			{#if form?.error}
				<div class="mt-4 rounded-xl border border-red-200 bg-red-50 p-3 text-sm text-red-700">{form.error}</div>
				{/if}
				{#if form?.success}
					<div class="mt-4 rounded-xl border border-emerald-200 bg-emerald-50 p-3 text-sm text-emerald-700">已保存提醒设置。</div>
				{/if}
				{#if form?.testSuccess}
					<div class="mt-4 rounded-xl border border-emerald-200 bg-emerald-50 p-3 text-sm text-emerald-700">{form.testSuccess}</div>
				{/if}
				{#if form?.testWarning}
					<div class="mt-4 rounded-xl border border-amber-200 bg-amber-50 p-3 text-sm text-amber-700">{form.testWarning}</div>
				{/if}

				<form method="POST" class="mt-6 space-y-4">
					<div class="rounded-2xl border border-blue-100 bg-blue-50/45 p-4">
						<div class="flex items-start justify-between gap-4">
							<div>
								<p class="font-semibold text-gray-900">通知分类</p>
								<p class="mt-1 text-sm leading-6 text-gray-500">
									选择你愿意接收哪些内容。账单、还款、年费是卡片提醒；权益活动用于之后的好卡推荐和活动通知。
								</p>
							</div>
							<span class="shrink-0 rounded-full border border-blue-100 bg-white px-3 py-1 text-xs font-medium text-gray-500">
								可随时关闭
							</span>
						</div>
						<div class="mt-4 grid gap-3 sm:grid-cols-2">
							{#each categories as category}
								<label class="flex cursor-pointer items-center justify-between gap-4 rounded-2xl border border-blue-100 bg-white p-4">
									<span>
										<span class="block font-semibold text-gray-900">{category.title}</span>
										<span class="mt-1 block text-sm text-gray-500">{category.description}</span>
									</span>
									<input type="hidden" name={category.name} value="0" />
									<input
										type="checkbox"
										name={category.name}
										value="1"
										checked={category.enabled()}
										class="h-5 w-5 shrink-0 rounded border-gray-300 accent-blue-600"
									/>
								</label>
							{/each}
						</div>
					</div>

					<div class="grid gap-4 sm:grid-cols-2">
						<div class="rounded-2xl border border-emerald-100 bg-emerald-50/50 p-4">
							<div class="flex items-start justify-between gap-3">
								<div>
									<p class="font-semibold text-gray-900">🔔 Bark 通知</p>
									<p class="mt-1 text-xs text-gray-500">适合 iPhone 用户，App 免费，响应很快。</p>
										<a
											href="/help/bark"
											class="mt-1 inline-block text-xs font-medium text-blue-600 hover:text-blue-700"
										>
											如何获取 Bark Key
										</a>
								</div>
								<span class="rounded-full bg-emerald-100 px-2 py-1 text-xs font-medium text-emerald-700">可选</span>
						</div>
							<input
								name="barkKey"
								value={settings.barkKey}
								placeholder="Bark Key 或完整推送地址"
								autocomplete="off"
								class="mt-4 w-full rounded-xl border border-gray-200 bg-white px-4 py-3 outline-none focus:border-blue-500 focus:ring-4 focus:ring-blue-100"
							/>
							<p class="mt-2 text-xs text-gray-500">留空关闭；可填写 Bark Key，也可以直接粘贴 Bark App 里的完整推送地址。</p>
					</div>

					<div class="rounded-2xl border border-lime-100 bg-lime-50/50 p-4">
						<div class="flex items-start justify-between gap-3">
								<div>
									<p class="font-semibold text-gray-900">💬 PushPlus 通知</p>
									<p class="mt-1 text-xs text-gray-500">适合安卓或微信用户，通过微信接收提醒。</p>
										<a
											href="/help/pushplus"
											class="mt-1 inline-block text-xs font-medium text-blue-600 hover:text-blue-700"
										>
											如何获取 PushPlus Token
										</a>
								</div>
							<span class="rounded-full bg-lime-100 px-2 py-1 text-xs font-medium text-lime-700">可选</span>
						</div>
						<input
							name="pushPlusToken"
							value={settings.pushPlusToken}
							placeholder="微信通知 Token"
							class="mt-4 w-full rounded-xl border border-gray-200 bg-white px-4 py-3 outline-none focus:border-blue-500 focus:ring-4 focus:ring-blue-100"
						/>
						<p class="mt-2 text-xs text-gray-500">留空关闭；填写后会通过 PushPlus 发送微信提醒。</p>
					</div>
				</div>

				<div class="rounded-2xl border border-sky-100 bg-sky-50/60 p-4">
						<div class="flex items-start justify-between gap-3">
							<div>
								<p class="font-semibold text-gray-900">✈️ Telegram 通知</p>
								<p class="mt-1 text-xs text-gray-500">适合已经常用 Telegram 的用户。</p>
									<a href="/help/telegram" class="mt-1 inline-block text-xs font-medium text-blue-600 hover:text-blue-700">如何获取 Telegram 配置</a>
							</div>
						<span class="rounded-full bg-sky-100 px-2 py-1 text-xs font-medium text-sky-700">Token + Chat ID</span>
					</div>
					<div class="mt-4 grid gap-4 sm:grid-cols-2">
						<input
							name="telegramBotToken"
							value={settings.telegramBotToken}
							placeholder="Bot Token，例如 123456:ABC..."
							class="w-full rounded-xl border border-gray-200 bg-white px-4 py-3 outline-none focus:border-blue-500 focus:ring-4 focus:ring-blue-100"
						/>
						<input
							name="telegramChatId"
							value={settings.telegramChatId}
							placeholder="Chat ID"
							class="w-full rounded-xl border border-gray-200 bg-white px-4 py-3 outline-none focus:border-blue-500 focus:ring-4 focus:ring-blue-100"
						/>
					</div>
						<p id="telegram-guide" class="mt-3 text-xs leading-5 text-gray-500">
							简易流程：向 BotFather 创建机器人，复制 Bot Token；给机器人发一条消息后获取 Chat ID。两项都填写才会开启。
						</p>
					</div>

						<div class="flex flex-col gap-3 border-t border-gray-100 pt-5 sm:flex-row sm:items-center sm:justify-between">
							<div class="order-2 sm:order-1">
								<button
									type="submit"
									formaction="?/testNotification"
									class="w-full rounded-xl border border-blue-200 bg-white px-5 py-2.5 text-sm font-semibold text-blue-600 hover:bg-blue-50 sm:w-auto"
								>
									测试通知
								</button>
								<p class="mt-2 text-xs text-gray-400">点击后立即发送，用来确认 Token 是否可用。</p>
							</div>
						<button
							type="submit"
							formaction="?/saveSettings"
							class="order-1 rounded-xl bg-blue-600 px-8 py-3 text-base font-semibold text-white shadow-sm hover:bg-blue-700 sm:order-2 sm:min-w-40"
						>
							保存设置
						</button>
					</div>
				</form>
			</section>
	</div>
</main>
