<script lang="ts">
	import type { ActionData } from './$types';
	let { form }: { form: ActionData } = $props();
</script>

<svelte:head>
	<title>修改密码 — 贝利卡管家</title>
</svelte:head>

<main class="min-h-screen bg-gray-50">
	<header class="border-b border-gray-200 bg-white">
		<div class="mx-auto max-w-xl px-4 py-5">
			<a href="/me" class="text-sm text-gray-400 hover:text-gray-700">← 返回我的信息</a>
			<h1 class="mt-2 text-2xl font-bold text-gray-900">修改密码</h1>
		</div>
	</header>

	<div class="mx-auto max-w-xl px-4 py-8">
		<section class="rounded-2xl border border-gray-200 bg-white p-6">
			{#if form?.error}
				<div class="mb-5 rounded-xl border border-red-200 bg-red-50 p-3 text-sm text-red-700">{form.error}</div>
			{/if}
			{#if form?.success}
				<div class="mb-5 rounded-xl border border-emerald-200 bg-emerald-50 p-3 text-sm text-emerald-700">密码已更新。</div>
			{/if}

			<form method="POST" class="space-y-5">
				<label class="block">
					<span class="text-sm font-medium text-gray-700">当前密码</span>
					<input
						name="currentPassword"
						type="password"
						required
						class="mt-2 w-full rounded-xl border border-gray-200 px-4 py-3 outline-none focus:border-blue-500 focus:ring-4 focus:ring-blue-100"
					/>
				</label>
				<label class="block">
					<span class="text-sm font-medium text-gray-700">新密码</span>
					<input
						name="newPassword"
						type="password"
						required
						minlength="6"
						class="mt-2 w-full rounded-xl border border-gray-200 px-4 py-3 outline-none focus:border-blue-500 focus:ring-4 focus:ring-blue-100"
					/>
				</label>
				<label class="block">
					<span class="text-sm font-medium text-gray-700">确认新密码</span>
					<input
						name="confirmPassword"
						type="password"
						required
						minlength="6"
						class="mt-2 w-full rounded-xl border border-gray-200 px-4 py-3 outline-none focus:border-blue-500 focus:ring-4 focus:ring-blue-100"
					/>
				</label>
				<button class="w-full rounded-xl bg-blue-600 px-4 py-3 font-semibold text-white hover:bg-blue-700">
					保存新密码
				</button>
			</form>
		</section>
	</div>
</main>
