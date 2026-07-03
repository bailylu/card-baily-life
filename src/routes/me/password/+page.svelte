<script lang="ts">
	import type { ActionData } from './$types';
	let { form }: { form: ActionData } = $props();
</script>

<svelte:head>
	<title>修改密码 — 贝利卡管家</title>
</svelte:head>

<main class="bls-page">
	<header class="bls-nav">
		<div class="mx-auto max-w-xl px-4 py-5">
			<a href="/me" class="text-sm font-semibold text-[var(--bls-cyan)] hover:text-[var(--bls-gold-bright)]">← 返回我的信息</a>
			<h1 class="mt-2 text-2xl font-black text-white">修改密码</h1>
		</div>
	</header>

	<div class="relative mx-auto max-w-xl px-4 py-8">
		<section class="bls-panel p-6">
			{#if form?.error}
				<div class="mb-5 border-2 border-[var(--bls-red)] bg-[rgba(255,90,90,0.13)] p-3 text-sm text-red-200">{form.error}</div>
			{/if}
			{#if form?.success}
				<div class="mb-5 border-2 border-[var(--bls-green)] bg-[rgba(77,240,138,0.13)] p-3 text-sm text-emerald-100">密码已更新。</div>
			{/if}

			<form method="POST" class="space-y-5">
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
				<button class="bls-btn w-full px-4 py-3">
					保存新密码
				</button>
			</form>
		</section>
	</div>
</main>
