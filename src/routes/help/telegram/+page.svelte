<svelte:head>
	<title>Telegram 通知配置 — 贝利卡管家</title>
</svelte:head>

<main class="min-h-screen bg-gray-50">
	<header class="border-b border-gray-200 bg-white">
		<div class="mx-auto max-w-3xl px-4 py-5">
			<a href="/me" class="text-sm text-gray-400 hover:text-gray-700">← 返回我的信息</a>
			<h1 class="mt-2 text-2xl font-bold text-gray-900">Telegram 通知配置</h1>
			<p class="mt-2 text-sm leading-6 text-gray-500">
				只需要准备两个值：机器人 Token 和 Chat ID。填回“我的信息”页面后，就可以用 Telegram 接收提醒。
			</p>
		</div>
	</header>

	<div class="mx-auto max-w-3xl space-y-5 px-4 py-8">
		<section class="rounded-2xl border border-gray-200 bg-white p-5">
			<h2 class="text-lg font-semibold text-gray-900">一、获取 Bot Token</h2>
			<ol class="mt-4 space-y-3 text-sm leading-6 text-gray-600">
				<li><strong class="text-gray-900">1. 打开 BotFather：</strong>在 Telegram 搜索 <span class="font-mono text-gray-900">@BotFather</span>。</li>
				<li><strong class="text-gray-900">2. 创建机器人：</strong>发送 <span class="font-mono text-gray-900">/newbot</span>，按提示填写机器人名称和用户名。</li>
				<li><strong class="text-gray-900">3. 复制 Token：</strong>创建成功后，BotFather 会返回一串类似 <span class="font-mono text-gray-900">123456789:ABC...</span> 的 Token。</li>
			</ol>
		</section>

		<section class="rounded-2xl border border-gray-200 bg-white p-5">
			<h2 class="text-lg font-semibold text-gray-900">二、获取个人 Chat ID</h2>
			<div class="mt-4 space-y-4 text-sm leading-6 text-gray-600">
				<div class="rounded-xl bg-gray-50 p-4">
					<p class="font-semibold text-gray-900">推荐方式</p>
					<p class="mt-1">搜索 <span class="font-mono text-gray-900">@getuseridbot</span> 或 <span class="font-mono text-gray-900">@userinfobot</span>，发送 <span class="font-mono text-gray-900">/start</span> 后复制返回的数字 ID。</p>
				</div>
				<div class="rounded-xl bg-gray-50 p-4">
					<p class="font-semibold text-gray-900">手动方式</p>
					<p class="mt-1">先给你创建的机器人发一条消息，然后在浏览器打开：</p>
					<code class="mt-2 block overflow-x-auto rounded-lg bg-white px-3 py-2 text-xs text-gray-700">https://api.telegram.org/bot你的TOKEN/getUpdates</code>
					<p class="mt-2">在返回的 JSON 中找到 <span class="font-mono text-gray-900">message → from → id</span>，这个数字就是个人 Chat ID。</p>
				</div>
			</div>
		</section>

		<section class="rounded-2xl border border-gray-200 bg-white p-5">
			<h2 class="text-lg font-semibold text-gray-900">三、群组或频道 Chat ID</h2>
			<ol class="mt-4 space-y-3 text-sm leading-6 text-gray-600">
				<li><strong class="text-gray-900">1. 添加机器人：</strong>把机器人加入群组或频道，必要时设为管理员。</li>
				<li><strong class="text-gray-900">2. 发送消息：</strong>在群组或频道里发一条测试消息。</li>
				<li><strong class="text-gray-900">3. 查看接口：</strong>打开 <span class="font-mono text-gray-900">getUpdates</span>，找到 <span class="font-mono text-gray-900">chat → id</span>。</li>
			</ol>
			<p class="mt-4 rounded-xl bg-amber-50 p-3 text-sm text-amber-700">群组或频道的 Chat ID 通常以 <span class="font-mono">-100</span> 开头。</p>
		</section>

		<section class="rounded-2xl border border-blue-100 bg-blue-50 p-5 text-sm leading-6 text-blue-800">
			<p><strong>填写总结：</strong></p>
			<p class="mt-1">Bot Token 填 BotFather 给你的机器人 Token；Chat ID 填个人、群组或频道对应的数字 ID。两项都填写后 Telegram 通知才会开启。</p>
		</section>
	</div>
</main>
