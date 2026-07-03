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

<main class="bls-page">
	<header class="bls-nav">
		<div class="mx-auto flex max-w-4xl items-center justify-between px-4 py-5">
			<div>
				<a href="/dashboard" class="text-sm font-semibold text-[var(--bls-cyan)] hover:text-[var(--bls-gold-bright)]">← 返回我的卡片</a>
				<h1 class="mt-2 text-2xl font-black text-white">我的信息</h1>
			</div>
			<form method="POST" action="/logout">
				<button class="bls-btn-ghost px-4 py-2 text-sm">退出</button>
			</form>
		</div>
	</header>

	<div class="relative mx-auto max-w-4xl space-y-6 px-4 py-8">
		<section class="bls-panel p-5">
				<div class="flex items-start justify-between gap-4">
					<div>
						<p class="bls-label text-[var(--bls-cyan)]">Notification</p>
						<h2 class="mt-1 text-lg font-black text-white">即时通知设置</h2>
						<p class="mt-1 text-sm text-[var(--bls-muted)]">选择一种适合你的免费即时通知方式；填写 Token 后自动开启，留空表示关闭。</p>
					</div>
			</div>

			{#if form?.error}
				<div class="mt-4 border-2 border-[var(--bls-red)] bg-[rgba(255,90,90,0.13)] p-3 text-sm text-red-200">{form.error}</div>
			{/if}
			{#if form?.success}
				<div class="mt-4 border-2 border-[var(--bls-green)] bg-[rgba(77,240,138,0.13)] p-3 text-sm text-emerald-100">已保存提醒设置。</div>
			{/if}
			{#if form?.testSuccess}
				<div class="mt-4 border-2 border-[var(--bls-green)] bg-[rgba(77,240,138,0.13)] p-3 text-sm text-emerald-100">{form.testSuccess}</div>
			{/if}
			{#if form?.testWarning}
				<div class="mt-4 border-2 border-[var(--bls-gold)] bg-[rgba(232,181,61,0.13)] p-3 text-sm text-[var(--bls-gold-bright)]">{form.testWarning}</div>
			{/if}

				<form method="POST" class="mt-6 space-y-4">
					<div class="border-2 border-[rgba(47,230,212,0.3)] bg-[rgba(47,230,212,0.06)] p-4">
						<div class="flex items-start justify-between gap-4">
							<div>
								<p class="font-semibold text-white">通知分类</p>
								<p class="mt-1 text-sm leading-6 text-[var(--bls-muted)]">
									选择你愿意接收哪些内容。账单、还款、年费是卡片提醒；权益活动用于之后的好卡推荐和活动通知。
								</p>
							</div>
							<span class="bls-chip-active shrink-0 px-3 py-1 text-xs font-medium">
								可随时关闭
							</span>
						</div>
						<div class="mt-4 grid gap-3 sm:grid-cols-2">
							{#each categories as category}
								<label class="flex cursor-pointer items-center justify-between gap-4 border-2 border-white/10 bg-white/[0.04] p-4 hover:border-[var(--bls-cyan)]">
									<span>
										<span class="block font-semibold text-white">{category.title}</span>
										<span class="mt-1 block text-sm text-[var(--bls-muted)]">{category.description}</span>
									</span>
									<input type="hidden" name={category.name} value="0" />
									<input
										type="checkbox"
										name={category.name}
										value="1"
										checked={category.enabled()}
										class="h-5 w-5 shrink-0 accent-[var(--bls-cyan)]"
									/>
								</label>
							{/each}
						</div>
					</div>

					<div class="grid gap-4 sm:grid-cols-2">
						<div class="border-2 border-[rgba(77,240,138,0.28)] bg-[rgba(77,240,138,0.06)] p-4">
							<div class="flex items-start justify-between gap-3">
								<div>
									<p class="font-semibold text-white">Bark 通知</p>
									<p class="mt-1 text-xs text-[var(--bls-muted)]">适合 iPhone 用户，App 免费，响应很快。</p>
										<a
											href="/help/bark"
											class="mt-1 inline-block text-xs font-medium text-[var(--bls-cyan)] hover:text-[var(--bls-gold-bright)]"
										>
											如何获取 Bark Key
										</a>
								</div>
								<span class="bls-chip px-2 py-1 text-xs font-medium text-[var(--bls-green)]">可选</span>
						</div>
							<input
								name="barkKey"
								value={settings.barkKey}
								placeholder="Bark Key 或完整推送地址"
								autocomplete="off"
								class="bls-input mt-4 w-full px-4 py-3"
							/>
							<p class="mt-2 text-xs text-[var(--bls-muted)]">留空关闭；可填写 Bark Key，也可以直接粘贴 Bark App 里的完整推送地址。</p>
					</div>

					<div class="border-2 border-[rgba(232,181,61,0.28)] bg-[rgba(232,181,61,0.06)] p-4">
						<div class="flex items-start justify-between gap-3">
								<div>
									<p class="font-semibold text-white">PushPlus 通知</p>
									<p class="mt-1 text-xs text-[var(--bls-muted)]">适合安卓或微信用户，通过微信接收提醒。</p>
										<a
											href="/help/pushplus"
											class="mt-1 inline-block text-xs font-medium text-[var(--bls-cyan)] hover:text-[var(--bls-gold-bright)]"
										>
											如何获取 PushPlus Token
										</a>
								</div>
							<span class="bls-chip px-2 py-1 text-xs font-medium text-[var(--bls-gold-bright)]">可选</span>
						</div>
						<input
							name="pushPlusToken"
							value={settings.pushPlusToken}
							placeholder="微信通知 Token"
							class="bls-input mt-4 w-full px-4 py-3"
						/>
						<p class="mt-2 text-xs text-[var(--bls-muted)]">留空关闭；填写后会通过 PushPlus 发送微信提醒。</p>
					</div>
				</div>

				<div class="border-2 border-[rgba(91,157,255,0.3)] bg-[rgba(91,157,255,0.07)] p-4">
						<div class="flex items-start justify-between gap-3">
							<div>
								<p class="font-semibold text-white">Telegram 通知</p>
								<p class="mt-1 text-xs text-[var(--bls-muted)]">适合已经常用 Telegram 的用户。</p>
									<a href="/help/telegram" class="mt-1 inline-block text-xs font-medium text-[var(--bls-cyan)] hover:text-[var(--bls-gold-bright)]">如何获取 Telegram 配置</a>
							</div>
						<span class="bls-chip px-2 py-1 text-xs font-medium text-[var(--bls-blue)]">Token + Chat ID</span>
					</div>
					<div class="mt-4 grid gap-4 sm:grid-cols-2">
						<input
							name="telegramBotToken"
							value={settings.telegramBotToken}
							placeholder="Bot Token，例如 123456:ABC..."
							class="bls-input w-full px-4 py-3"
						/>
						<input
							name="telegramChatId"
							value={settings.telegramChatId}
							placeholder="Chat ID"
							class="bls-input w-full px-4 py-3"
						/>
					</div>
						<p id="telegram-guide" class="mt-3 text-xs leading-5 text-[var(--bls-muted)]">
							简易流程：向 BotFather 创建机器人，复制 Bot Token；给机器人发一条消息后获取 Chat ID。两项都填写才会开启。
						</p>
					</div>

						<div class="flex flex-col gap-3 border-t-2 border-white/10 pt-5 sm:flex-row sm:items-center sm:justify-between">
							<div class="order-2 sm:order-1">
								<button
									type="submit"
									formaction="?/testNotification"
									class="bls-btn-ghost w-full px-5 py-2.5 text-sm font-semibold sm:w-auto"
								>
									测试通知
								</button>
								<p class="mt-2 text-xs text-[var(--bls-muted)]">点击后立即发送，用来确认 Token 是否可用。</p>
							</div>
						<button
							type="submit"
							formaction="?/saveSettings"
							class="bls-btn order-1 px-8 py-3 text-base sm:order-2 sm:min-w-40"
						>
							保存设置
						</button>
					</div>
				</form>
			</section>

		<section class="bls-panel p-5">
			<p class="bls-label text-[var(--bls-gold-bright)]">Security</p>
			<h2 class="mt-1 text-lg font-black text-white">修改密码</h2>
			<p class="mt-1 text-sm text-[var(--bls-muted)]">如果你的账号设置过本地密码，可以在这里直接更新。</p>

			{#if form?.passwordError}
				<div class="mt-4 border-2 border-[var(--bls-red)] bg-[rgba(255,90,90,0.13)] p-3 text-sm text-red-200">{form.passwordError}</div>
			{/if}
			{#if form?.passwordSuccess}
				<div class="mt-4 border-2 border-[var(--bls-green)] bg-[rgba(77,240,138,0.13)] p-3 text-sm text-emerald-100">密码已更新。</div>
			{/if}

			<form method="POST" action="?/changePassword" class="mt-5 grid gap-4 sm:grid-cols-3">
				<label class="block">
					<span class="text-sm font-medium text-[var(--bls-body)]">当前密码</span>
					<input
						name="currentPassword"
						type="password"
						required
						class="bls-input mt-2 w-full px-4 py-3"
					/>
				</label>
				<label class="block">
					<span class="text-sm font-medium text-[var(--bls-body)]">新密码</span>
					<input
						name="newPassword"
						type="password"
						required
						minlength="6"
						class="bls-input mt-2 w-full px-4 py-3"
					/>
				</label>
				<label class="block">
					<span class="text-sm font-medium text-[var(--bls-body)]">确认新密码</span>
					<input
						name="confirmPassword"
						type="password"
						required
						minlength="6"
						class="bls-input mt-2 w-full px-4 py-3"
					/>
				</label>
				<div class="sm:col-span-3">
					<button class="bls-btn px-5 py-3 text-sm">保存新密码</button>
				</div>
			</form>
		</section>
	</div>
</main>
