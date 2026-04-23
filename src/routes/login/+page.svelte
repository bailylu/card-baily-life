<script lang="ts">
	import type { PageData } from './$types';
	let { data }: { data: PageData } = $props();

	let email = $state('');
	let status = $state<'idle' | 'loading' | 'sent' | 'error'>('idle');

	async function submit() {
		status = 'loading';
		try {
			const res = await fetch('/api/auth/magic-link', {
				method: 'POST',
				headers: { 'Content-Type': 'application/json' },
				body: JSON.stringify({ email })
			});
			status = res.ok ? 'sent' : 'error';
		} catch {
			status = 'error';
		}
	}
</script>

<svelte:head>
	<title>登录 — card.baily.life</title>
</svelte:head>

<main class="min-h-screen flex flex-col items-center justify-center bg-gray-50 px-4">
	<div class="max-w-sm w-full space-y-6">
		<div class="text-center">
			<h1 class="text-2xl font-bold text-gray-900">登录</h1>
			<p class="mt-1 text-sm text-gray-500">输入邮箱，我们会发一个登录链接</p>
		</div>

		{#if data.error === 'invalid'}
			<div class="bg-red-50 border border-red-200 rounded-lg p-3 text-sm text-red-700">
				链接已失效或已使用，请重新获取。
			</div>
		{/if}

		{#if status === 'sent'}
			<div class="bg-green-50 border border-green-200 rounded-lg p-4 text-center">
				<p class="text-green-800 font-medium">邮件已发送</p>
				<p class="text-green-700 text-sm mt-1">请查收 {email} 的邮件，点击链接登录。</p>
			</div>
		{:else}
			<form onsubmit={(e) => { e.preventDefault(); submit(); }} class="space-y-4">
				<div>
					<label for="email" class="block text-sm font-medium text-gray-700 mb-1">邮箱</label>
					<input
						id="email"
						type="email"
						bind:value={email}
						required
						placeholder="you@example.com"
						class="w-full px-3 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500"
					/>
				</div>

				<button
					type="submit"
					disabled={status === 'loading'}
					class="w-full py-2.5 px-4 bg-blue-600 text-white rounded-lg font-medium hover:bg-blue-700 disabled:opacity-50"
				>
					{status === 'loading' ? '发送中…' : '发送登录链接'}
				</button>
			</form>

			{#if status === 'error'}
				<p class="text-sm text-center text-red-600">发送失败，请稍后重试。</p>
			{/if}
		{/if}

		<p class="text-center">
			<a href="/" class="text-sm text-gray-500 hover:text-gray-700">← 返回首页</a>
		</p>
	</div>
</main>
