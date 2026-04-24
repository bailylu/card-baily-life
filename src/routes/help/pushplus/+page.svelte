<svelte:head>
	<title>PushPlus 通知配置 — 贝利卡管家</title>
</svelte:head>

<main class="min-h-screen bg-gray-50">
	<header class="border-b border-gray-200 bg-white">
		<div class="mx-auto max-w-3xl px-4 py-5">
			<a href="/me" class="text-sm text-gray-400 hover:text-gray-700">← 返回我的信息</a>
			<h1 class="mt-2 text-2xl font-bold text-gray-900">PushPlus 通知配置</h1>
			<p class="mt-2 text-sm leading-6 text-gray-500">
				PushPlus 适合安卓或微信用户。你只需要获取自己的 Token，填回贝利卡管家即可通过微信接收提醒。
			</p>
		</div>
	</header>

	<div class="mx-auto max-w-3xl space-y-5 px-4 py-8">
		<section class="rounded-2xl border border-gray-200 bg-white p-5">
			<h2 class="text-lg font-semibold text-gray-900">一、登录 PushPlus</h2>
			<p class="mt-3 text-sm leading-6 text-gray-600">
				打开 PushPlus 官网并登录。通常需要先关注 PushPlus 的微信公众号，之后才能接收微信提醒。
			</p>
			<img
				src="/images/tutorials/pushplus-msg.png"
				alt="PushPlus 一对一消息说明示例"
				class="mt-4 w-full rounded-2xl border border-gray-200 shadow-sm"
			/>
		</section>

		<section class="rounded-2xl border border-gray-200 bg-white p-5">
			<h2 class="text-lg font-semibold text-gray-900">二、复制 Token</h2>
			<ol class="mt-4 space-y-3 text-sm leading-6 text-gray-600">
				<li><strong class="text-gray-900">1. 进入一对一消息：</strong>在 PushPlus 控制台找到“一对一消息”相关页面。</li>
				<li><strong class="text-gray-900">2. 找到 Token：</strong>复制你的用户 Token 或消息 Token。</li>
				<li><strong class="text-gray-900">3. 填回贝利卡管家：</strong>把 Token 粘贴到 PushPlus 通知输入框。</li>
			</ol>
		</section>

		<section class="rounded-2xl border border-gray-200 bg-white p-5">
			<h2 class="text-lg font-semibold text-gray-900">三、测试通知</h2>
			<p class="mt-3 text-sm leading-6 text-gray-600">
				保存前可以直接点击“测试通知”。如果微信里马上收到贝利卡管家的测试消息，就说明 PushPlus 配置成功。
			</p>
			<div class="mt-4 rounded-xl bg-gray-50 p-4 text-sm text-gray-600">
				<p class="font-semibold text-gray-900">注意</p>
				<p class="mt-1">PushPlus 的发送接口是异步处理的，偶尔会有几秒延迟。如果长时间收不到，可以检查 Token 是否正确、公众号是否已关注。</p>
			</div>
		</section>

		<section class="rounded-2xl border border-blue-100 bg-blue-50 p-5 text-sm leading-6 text-blue-800">
			<p><strong>填写总结：</strong></p>
			<p class="mt-1">贝利卡管家只需要 PushPlus Token。填入后，账单日、还款日和年费日会通过 PushPlus 发送微信提醒。</p>
			<a
				href="https://www.pushplus.plus/doc/function/one.html"
				target="_blank"
				rel="noreferrer"
				class="mt-3 inline-block font-medium text-blue-600 hover:text-blue-700"
			>
				查看 PushPlus 官方文档
			</a>
		</section>
	</div>
</main>
