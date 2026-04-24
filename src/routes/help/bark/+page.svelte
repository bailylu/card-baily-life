<svelte:head>
	<title>Bark 通知配置 — 贝利卡管家</title>
</svelte:head>

<main class="min-h-screen bg-gray-50">
	<header class="border-b border-gray-200 bg-white">
		<div class="mx-auto max-w-3xl px-4 py-5">
			<a href="/me" class="text-sm text-gray-400 hover:text-gray-700">← 返回我的信息</a>
			<h1 class="mt-2 text-2xl font-bold text-gray-900">Bark 通知配置</h1>
			<p class="mt-2 text-sm leading-6 text-gray-500">
				Bark 适合 iPhone 用户。你只需要在 Bark App 里复制推送 Key，填回贝利卡管家即可接收即时提醒。
			</p>
		</div>
	</header>

	<div class="mx-auto max-w-3xl space-y-5 px-4 py-8">
		<section class="rounded-2xl border border-gray-200 bg-white p-5">
			<h2 class="text-lg font-semibold text-gray-900">一、安装并打开 Bark</h2>
			<p class="mt-3 text-sm leading-6 text-gray-600">
				在 iPhone 上安装 Bark App。打开后，首页会显示一条测试推送地址，地址里包含你的 Bark Key。
			</p>
			<img
				src="/images/tutorials/bark-example.jpg"
				alt="Bark App 中复制测试推送地址示例"
				class="mt-4 max-w-xs rounded-2xl border border-gray-200 shadow-sm"
			/>
		</section>

		<section class="rounded-2xl border border-gray-200 bg-white p-5">
			<h2 class="text-lg font-semibold text-gray-900">二、复制 Bark Key</h2>
			<div class="mt-4 space-y-3 text-sm leading-6 text-gray-600">
				<p>你可以复制完整的测试推送地址，也可以只复制地址里的 Key。</p>
				<div class="rounded-xl bg-gray-50 p-4">
					<p class="font-semibold text-gray-900">完整地址示例</p>
					<code class="mt-2 block overflow-x-auto rounded-lg bg-white px-3 py-2 text-xs text-gray-700">
						https://api.day.app/你的BarkKey/推送内容
					</code>
				</div>
				<div class="rounded-xl bg-gray-50 p-4">
					<p class="font-semibold text-gray-900">只填 Key 也可以</p>
					<code class="mt-2 block overflow-x-auto rounded-lg bg-white px-3 py-2 text-xs text-gray-700">
						你的BarkKey
					</code>
				</div>
			</div>
		</section>

		<section class="rounded-2xl border border-blue-100 bg-blue-50 p-5 text-sm leading-6 text-blue-800">
			<p><strong>填写到贝利卡管家：</strong></p>
			<p class="mt-1">回到“我的信息”，在 Bark 通知里粘贴 Bark Key 或完整推送地址，然后点击“测试通知”。如果手机马上收到通知，就说明配置成功。</p>
			<a
				href="https://bark.day.app/#/tutorial"
				target="_blank"
				rel="noreferrer"
				class="mt-3 inline-block font-medium text-blue-600 hover:text-blue-700"
			>
				查看 Bark 官方教程
			</a>
		</section>
	</div>
</main>
