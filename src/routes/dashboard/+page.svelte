<script lang="ts">
	import type { PageData } from './$types';
	let { data }: { data: PageData } = $props();
</script>

<svelte:head>
	<title>我的卡片 — card.baily.life</title>
</svelte:head>

<div class="min-h-screen bg-gray-50">
	<header class="bg-white border-b border-gray-200">
		<div class="max-w-2xl mx-auto px-4 py-4 flex items-center justify-between">
			<h1 class="text-lg font-semibold text-gray-900">💳 我的卡片</h1>
			<form method="POST" action="/logout">
				<button type="submit" class="text-sm text-gray-500 hover:text-gray-700">退出</button>
			</form>
		</div>
	</header>

	<main class="max-w-2xl mx-auto px-4 py-8">
		<div class="bg-white rounded-xl border border-gray-200 p-8 text-center">
			<p class="text-gray-500 text-sm">还没有卡片</p>
			<p class="text-xs text-gray-400 mt-1">M2 上线后可以添加</p>
		</div>

		<div class="mt-4 text-center text-xs text-gray-400">
			登录邮箱：{data.user.email}
		</div>
	</main>
</div>
