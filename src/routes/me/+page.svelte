<script lang="ts">
	import { SignOutButton } from 'svelte-clerk';
	import MobileBottomNav from '$lib/components/MobileBottomNav.svelte';
	import type { ActionData, PageData } from './$types';

	let { data, form }: { data: PageData; form: ActionData } = $props();
	const notificationSetupUrl = 'https://baily.life/?os=1&app=notify';
	let notificationStatus = $derived(data.notificationStatus);
	let notificationPreferences = $derived(
		form && 'notificationPreferences' in form && form.notificationPreferences
			? form.notificationPreferences
			: data.notificationPreferences
	);

	const categories = [
		{
			name: 'statementEnabled',
			title: '账单日提醒',
			description: '每月账单日相关提醒。',
			enabled: () => notificationPreferences.statementEnabled
		},
		{
			name: 'dueEnabled',
			title: '还款日提醒',
			description: '避免错过信用卡还款。',
			enabled: () => notificationPreferences.dueEnabled
		},
		{
			name: 'annualFeeEnabled',
			title: '年费提醒',
			description: '年费日或免年费复核提醒。',
			enabled: () => notificationPreferences.annualFeeEnabled
		},
		{
			name: 'offerEnabled',
			title: '权益活动通知',
			description: '好卡推荐、开卡活动和权益变化。',
			enabled: () => notificationPreferences.offerEnabled
		}
	] as const;
</script>

<svelte:head>
	<title>我的信息 — 贝利卡管家</title>
</svelte:head>

<main class="bls-page app-shell me-page">
	<header class="app-shell-topbar">
		<div class="app-shell-title min-w-0">
			<p class="truncate">我的</p>
			<p class="truncate">{data.user?.email ?? '通知与账号'}</p>
		</div>
		{#if data.localMock}
			<a href="/dashboard" class="bls-btn-ghost shrink-0 px-3 py-2 text-xs">卡片</a>
		{:else}
		<SignOutButton redirectUrl="/">
			{#snippet children({ signOut })}
				<button
					type="button"
					class="bls-btn-ghost shrink-0 px-3 py-2 text-xs"
					onclick={async () => {
						try {
							await fetch('/logout', {
								method: 'POST',
								headers: { accept: 'application/json' }
							});
						} catch {
							// ignore network errors; still sign out of Clerk
						}
						signOut();
					}}
				>
					退出
				</button>
			{/snippet}
		</SignOutButton>
		{/if}
	</header>

	<header class="bls-nav">
		<div class="mx-auto flex max-w-4xl items-center justify-between px-4 py-5">
			<div>
				<a href="/dashboard" class="text-sm font-semibold text-[var(--bls-cyan)] hover:text-[var(--bls-gold-bright)]">← 返回我的卡片</a>
				<h1 class="mt-2 text-2xl font-black text-white">我的信息</h1>
			</div>
			{#if data.localMock}
				<a href="/dashboard" class="bls-btn-ghost px-4 py-2 text-sm">返回卡片</a>
			{:else}
			<SignOutButton redirectUrl="/">
				{#snippet children({ signOut })}
					<button
						type="button"
						class="bls-btn-ghost px-4 py-2 text-sm"
						onclick={async () => {
							try {
								await fetch('/logout', {
									method: 'POST',
									headers: { accept: 'application/json' }
								});
							} catch {
								// ignore network errors; still sign out of Clerk
							}
							signOut();
						}}
					>
						退出
					</button>
				{/snippet}
			</SignOutButton>
			{/if}
		</div>
	</header>

	<div class="app-shell-main relative mx-auto max-w-4xl space-y-6 px-4 py-8">
		<section class="mobile-account-card">
			<div class="mobile-account-avatar">{data.user?.email?.slice(0, 1).toUpperCase() ?? 'B'}</div>
			<div class="min-w-0">
				<h1>我的账户</h1>
				<p>{data.user?.email ?? '未登录'}</p>
			</div>
			<span>{data.localMock ? '本地预览' : '已登录'}</span>
		</section>

		<section class="bls-panel p-5">
			<p class="bls-label text-[var(--bls-cyan)]">Tools</p>
			<h2 class="mt-1 text-lg font-black text-white">常用工具</h2>
			<div class="mt-4 grid gap-3 sm:grid-cols-2">
				<a
					href="/bin"
					class="flex items-center justify-between gap-3 border-2 border-white/10 bg-white/[0.04] p-4 hover:border-[var(--bls-cyan)]"
				>
					<span>
						<span class="block font-semibold text-white">BIN 查询</span>
						<span class="mt-1 block text-sm text-[var(--bls-muted)]">
							输入卡号前 6-8 位，查发卡行、卡组织和发卡国
						</span>
					</span>
					<span class="shrink-0 text-[var(--bls-cyan)]">→</span>
				</a>
				<a
					href="/lounges"
					class="flex items-center justify-between gap-3 border-2 border-white/10 bg-white/[0.04] p-4 hover:border-[var(--bls-cyan)]"
				>
					<span>
						<span class="block font-semibold text-white">贵宾厅清单</span>
						<span class="mt-1 block text-sm text-[var(--bls-muted)]">按机场查可用的贵宾厅渠道</span>
					</span>
					<span class="shrink-0 text-[var(--bls-cyan)]">→</span>
				</a>
			</div>
		</section>

		<section class="me-preferences-panel bls-panel p-5">
			<div class="flex items-start justify-between gap-4">
				<div>
					<p class="bls-label text-[var(--bls-cyan)]">Preference</p>
					<h2 class="mt-1 text-lg font-black text-white">通知分类</h2>
					<p class="mt-2 max-w-2xl text-sm leading-6 text-[var(--bls-muted)]">
						选择你愿意接收哪些内容。账单、还款、年费是卡片提醒；权益活动用于好卡推荐和活动通知。
					</p>
				</div>
				<span class="bls-chip-active shrink-0 px-3 py-1 text-xs font-medium">
					可随时关闭
				</span>
			</div>

			{#if form?.preferencesSuccess}
				<div class="mt-4 border-2 border-[var(--bls-green)] bg-[rgba(77,240,138,0.13)] p-3 text-sm text-emerald-100">通知分类已保存。</div>
			{/if}

			<form method="POST" action="?/savePreferences" class="me-preference-form mt-5">
				<div class="grid gap-3 sm:grid-cols-2">
					{#each categories as category}
						<label class="me-setting-row flex cursor-pointer items-center justify-between gap-4 border-2 border-white/10 bg-white/[0.04] p-4 hover:border-[var(--bls-cyan)]">
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

				<div class="mt-4 flex justify-end">
					<button class="bls-btn px-5 py-2.5 text-sm font-semibold">保存通知分类</button>
				</div>
			</form>
		</section>

		<section class="me-notification-panel bls-panel p-5">
			<div class="flex flex-col gap-5 sm:flex-row sm:items-start sm:justify-between">
				<div>
					<p class="bls-label text-[var(--bls-cyan)]">Notification</p>
					<h2 class="mt-1 text-lg font-black text-white">即时通知设置</h2>
					<p class="mt-2 max-w-2xl text-sm leading-6 text-[var(--bls-muted)]">
						通知设置由贝利主站统一管理。你只需要在主站配置一次，所有贝利应用都会使用同一份通知方式。
					</p>
				</div>
				<span class={notificationStatus.configured ? 'bls-chip-active shrink-0 px-3 py-1 text-sm font-semibold' : 'bls-chip shrink-0 px-3 py-1 text-sm font-semibold'}>
					{notificationStatus.configured ? '已配置' : '未配置'}
				</span>
			</div>

			{#if form?.error}
				<div class="mt-4 border-2 border-[var(--bls-red)] bg-[rgba(255,90,90,0.16)] p-4 text-sm text-red-100">
					<p class="font-black text-red-100">发送失败</p>
					<p class="mt-1 leading-6">{form.error}</p>
				</div>
			{/if}
			{#if form?.testSuccess}
				<div class="mt-4 border-2 border-[var(--bls-green)] bg-[rgba(77,240,138,0.16)] p-4 text-sm text-emerald-100">
					<p class="font-black text-emerald-100">测试通知已发送</p>
					<p class="mt-1 leading-6">{form.testSuccess}</p>
				</div>
			{/if}
			{#if form?.testWarning}
				<div class="mt-4 border-2 border-[var(--bls-gold)] bg-[rgba(232,181,61,0.16)] p-4 text-sm text-[var(--bls-gold-bright)]">
					<p class="font-black">部分渠道未发送</p>
					<p class="mt-1 leading-6">{form.testWarning}</p>
				</div>
			{/if}
			<div class="mt-6 grid items-stretch gap-4 sm:grid-cols-2">
				<div class="flex flex-col border-2 border-white/10 bg-white/[0.04] p-4">
					<div>
						<p class="text-sm font-semibold text-[var(--bls-muted)]">当前状态</p>
						<p class="mt-2 text-2xl font-black text-white">{notificationStatus.configured ? '已配置' : '未配置'}</p>
						<p class="mt-2 text-xs leading-5 text-[var(--bls-muted)]">
							这里只展示状态，不再保存或展示任何通知 Token。
						</p>
					</div>
					<div class="mt-auto grid gap-3 pt-5 sm:grid-cols-2">
						<a
							href={notificationSetupUrl}
							target="_blank"
							rel="noreferrer"
							class="bls-btn inline-flex justify-center px-4 py-3 text-center text-sm font-semibold"
						>
							前往主站设置通知
						</a>
						<form method="POST" action="?/testNotification">
							<button class="bls-btn w-full px-4 py-3 text-sm font-black">发送测试通知</button>
						</form>
					</div>
				</div>

				<div class="flex flex-col border-2 border-[rgba(47,230,212,0.25)] bg-[rgba(47,230,212,0.06)] p-4">
					<div>
						<p class="text-sm font-semibold text-[var(--bls-muted)]">已启用渠道</p>
						{#if notificationStatus.enabled.length > 0}
							<div class="mt-3 flex flex-wrap gap-2">
								{#each notificationStatus.enabled as channel}
									<span class="bls-chip-active px-3 py-1 text-sm font-semibold">{channel}</span>
								{/each}
							</div>
						{:else}
							<p class="mt-3 text-sm text-[var(--bls-muted)]">暂未配置通知渠道。</p>
						{/if}

						<p class="mt-4 text-sm font-semibold text-[var(--bls-muted)]">未配置渠道</p>
						<div class="mt-3 flex flex-wrap gap-2">
							{#each notificationStatus.disabled as channel}
								<span class="bls-chip px-3 py-1 text-sm font-semibold">{channel}</span>
							{/each}
						</div>
					</div>

				</div>
			</div>
		</section>

		<a
			href="https://wx.zsxq.com/group/15555858118552"
			target="_blank"
			rel="noreferrer"
			class="dashboard-ad-card dashboard-ad-card-planet me-planet-ad"
		>
			<span class="min-w-0">
				<span class="bls-label text-[var(--bls-gold-bright)]">Knowledge Planet</span>
				<span class="mt-1 block text-base font-black text-white">加入贝利知识星球</span>
				<span class="mt-1 block text-xs leading-5 text-[var(--bls-muted)]">和 1500 位小伙伴一起玩卡，掌握信用卡、积分和权益玩法。</span>
			</span>
			<span class="dashboard-ad-cta">立即加入</span>
		</a>
	</div>

	<MobileBottomNav active="me" />
</main>
