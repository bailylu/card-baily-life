<script lang="ts">
	import type { PageData } from './$types';
	let { data }: { data: PageData } = $props();
</script>

<svelte:head>
	<title>card.baily.life — 信用卡提醒</title>
</svelte:head>

<main class="min-h-screen flex flex-col items-center justify-center bg-gray-50 px-4">
	<div class="max-w-md w-full text-center space-y-6">
		<h1 class="text-3xl font-bold text-gray-900">💳 信用卡提醒</h1>
		<p class="text-gray-600">账单日、还款日、年费日，一个都不漏。</p>

		{#if data.user}
			<a
				href="/dashboard"
				class="block w-full py-3 px-4 bg-blue-600 text-white rounded-lg font-medium hover:bg-blue-700"
			>
				进入我的卡片
			</a>
		{:else}
			<a
				href="/dashboard"
				class="block w-full py-3 px-4 bg-blue-600 text-white rounded-lg font-medium hover:bg-blue-700"
			>
				开始使用
			</a>
		{/if}

		<p class="text-xs text-gray-400">当前为开放测试，无需登录</p>
	</div>
</main>
