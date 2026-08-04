<script lang="ts">
	import MobileBottomNav from '$lib/components/MobileBottomNav.svelte';
	import {
		BIN_MAX_LENGTH,
		BIN_MIN_LENGTH,
		detectNetwork,
		normalizeBinInput,
		isValidBin
	} from '$lib/bin/network';
	import type { BinDetail } from '$lib/bin/lookup';

	type ApiResponse = {
		bin: string;
		network: ReturnType<typeof detectNetwork>;
		detail: BinDetail | null;
		source: 'cache' | 'live' | 'stale' | 'none';
		unavailable: boolean;
		error?: string;
	};

	let input = $state('');
	let loading = $state(false);
	let result = $state<ApiResponse | null>(null);
	let errorMessage = $state('');

	// 卡组织在本地即时判断，不等网络，也不消耗外部额度。
	let liveNetwork = $derived(detectNetwork(input));
	let canSubmit = $derived(isValidBin(input) && !loading);

	function onInput(event: Event) {
		input = normalizeBinInput((event.target as HTMLInputElement).value);
		if (result && result.bin !== input) result = null;
		errorMessage = '';
	}

	async function lookup() {
		if (!canSubmit) return;
		loading = true;
		errorMessage = '';

		try {
			const response = await fetch(`/api/bin?bin=${encodeURIComponent(input)}`);
			const payload = (await response.json()) as ApiResponse;

			if (!response.ok) {
				errorMessage = payload.error ?? '查询失败，请稍后再试';
				result = null;
			} else {
				result = payload;
			}
		} catch {
			errorMessage = '网络请求失败，请检查网络后重试';
			result = null;
		} finally {
			loading = false;
		}
	}

	const cardTypeLabel: Record<string, string> = {
		debit: '借记卡',
		credit: '贷记卡（信用卡）',
		charge: '记账卡'
	};

	const examples = [
		{ bin: '622202', label: '银联 · 中国' },
		{ bin: '453242', label: 'Visa · 建行' },
		{ bin: '552853', label: '万事达' },
		{ bin: '378282', label: '美国运通' }
	];

	function useExample(bin: string) {
		input = bin;
		result = null;
		errorMessage = '';
		lookup();
	}

	let sourceNote = $derived.by(() => {
		if (!result) return '';
		if (result.unavailable) return '外部数据源暂时不可用，以下只有本地识别结果';
		if (result.source === 'stale') return '外部数据源暂时不可用，展示的是上次缓存的结果';
		if (result.source === 'cache') return '来自本站缓存';
		return '来自 binlist 实时查询';
	});
</script>

<svelte:head>
	<title>卡 BIN 查询 · 贝利卡管家</title>
	<meta
		name="description"
		content="输入银行卡号前 6-8 位，查询发卡行、卡组织、发卡国家和卡片类型。无需登录，不保存任何输入。"
	/>
</svelte:head>

<main class="bls-page bin-page app-shell">
	<header class="app-shell-topbar">
		<div class="app-shell-title min-w-0">
			<p class="truncate">BIN 查询</p>
			<p class="truncate">发卡行 · 卡组织 · 发卡国</p>
		</div>
		<a href="/dashboard" class="bls-btn-ghost shrink-0 px-3 py-2 text-xs">卡片</a>
	</header>

	<div class="bin-shell">
		<nav class="bin-nav">
			<a
				href="/dashboard"
				class="text-sm font-bold text-[var(--bls-cyan)] hover:text-[var(--bls-gold-bright)]"
			>
				← 返回我的卡片
			</a>
			<div class="bin-nav-links">
				<a href="/lounges" class="bls-nav-link">贵宾厅</a>
				<a href="https://baily.life/" target="_blank" rel="noreferrer" class="bls-nav-link">贝利主页</a>
			</div>
		</nav>

		<section class="bin-hero bls-panel">
			<p class="bls-label text-[var(--bls-cyan)]">BIN Lookup</p>
			<h1>卡 BIN 查询</h1>
			<p class="bin-hero-desc">
				银行卡号的前 6-8 位叫 BIN（发卡行识别码），它决定了这张卡属于哪家银行、哪个卡组织、哪个国家发行。
				输入前几位即可查询，无需登录。
			</p>
			<p class="bin-warning">
				<strong>只输入前 {BIN_MIN_LENGTH}-{BIN_MAX_LENGTH} 位就够了。</strong>
				本页面最多只接受 {BIN_MAX_LENGTH} 位，多余的数字会被自动丢弃，你的完整卡号不会、也无法被提交。
			</p>
		</section>

		<section class="bin-form bls-panel">
			<label class="bin-field" for="bin-input">
				<span>卡号前 {BIN_MIN_LENGTH}-{BIN_MAX_LENGTH} 位</span>
				<input
					id="bin-input"
					class="bls-input bin-input"
					type="text"
					inputmode="numeric"
					autocomplete="off"
					maxlength={BIN_MAX_LENGTH}
					placeholder="例如 622202"
					value={input}
					oninput={onInput}
					onkeydown={(event) => event.key === 'Enter' && lookup()}
				/>
			</label>

			<div class="bin-actions">
				<button type="button" class="bls-btn bin-submit" disabled={!canSubmit} onclick={lookup}>
					{loading ? '查询中…' : '查询'}
				</button>
				{#if liveNetwork}
					<span class="bin-live-network">
						本地识别：<strong>{liveNetwork.name}</strong>
						<em>{liveNetwork.nameEn} · 完整卡号 {liveNetwork.lengths.join(' / ')} 位</em>
					</span>
				{:else if input.length > 0}
					<span class="bin-live-network bin-live-network-muted">本地暂未识别出卡组织</span>
				{/if}
			</div>

			<div class="bin-examples">
				<span>试试：</span>
				{#each examples as example}
					<button type="button" class="bls-chip bin-example" onclick={() => useExample(example.bin)}>
						{example.bin}
						<em>{example.label}</em>
					</button>
				{/each}
			</div>

			{#if errorMessage}
				<p class="bin-error">{errorMessage}</p>
			{/if}
		</section>

		{#if result}
			<section class="bin-result bls-panel">
				<div class="bin-result-head">
					<div>
						<p class="bls-label text-[var(--bls-gold-bright)]">Result</p>
						<h2>{result.bin} <span>••••</span></h2>
					</div>
					{#if sourceNote}
						<span class="bin-source" class:bin-source-warn={result.unavailable || result.source === 'stale'}>
							{sourceNote}
						</span>
					{/if}
				</div>

				{#if !result.network && !result.detail?.found}
					<p class="bin-empty">
						没有查到这个 BIN 的信息。可能是输入有误，也可能是该发卡行不在公开数据库里
						——binlist 对中国大陆中小银行的覆盖比较有限。
					</p>
				{:else}
					<dl class="bin-grid">
						<div>
							<dt>卡组织</dt>
							<dd>
								{#if result.network}
									{result.network.name}
									<em>{result.network.nameEn}</em>
								{:else if result.detail?.scheme}
									{result.detail.scheme}
								{:else}
									<span class="bin-unknown">未知</span>
								{/if}
							</dd>
						</div>

						<div>
							<dt>发卡行</dt>
							<dd>
								{#if result.detail?.bank?.name}
									{result.detail.bank.name}
									{#if result.detail.bank.city}<em>{result.detail.bank.city}</em>{/if}
								{:else}
									<span class="bin-unknown">未收录</span>
								{/if}
							</dd>
						</div>

						<div>
							<dt>发卡国家 / 地区</dt>
							<dd>
								{#if result.detail?.country?.name}
									{result.detail.country.emoji ?? ''}
									{result.detail.country.name}
									{#if result.detail.country.currency}<em>{result.detail.country.currency}</em>{/if}
								{:else}
									<span class="bin-unknown">未收录</span>
								{/if}
							</dd>
						</div>

						<div>
							<dt>卡片类型</dt>
							<dd>
								{#if result.detail?.cardType}
									{cardTypeLabel[result.detail.cardType] ?? result.detail.cardType}
									{#if result.detail.prepaid}<em>预付卡</em>{/if}
								{:else}
									<span class="bin-unknown">未收录</span>
								{/if}
							</dd>
						</div>

						<div>
							<dt>卡片等级</dt>
							<dd>
								{#if result.detail?.brand}
									{result.detail.brand}
								{:else}
									<span class="bin-unknown">未收录</span>
								{/if}
							</dd>
						</div>

						<div>
							<dt>完整卡号长度</dt>
							<dd>
								{#if result.network}
									{result.network.lengths.join(' / ')} 位
								{:else}
									<span class="bin-unknown">未知</span>
								{/if}
							</dd>
						</div>
					</dl>

					{#if result.detail?.bank?.url || result.detail?.bank?.phone}
						<div class="bin-bank-contact">
							{#if result.detail.bank.url}
								<a
									href={result.detail.bank.url.startsWith('http')
										? result.detail.bank.url
										: `https://${result.detail.bank.url}`}
									target="_blank"
									rel="noreferrer"
								>
									{result.detail.bank.url}
								</a>
							{/if}
							{#if result.detail.bank.phone}
								<span>{result.detail.bank.phone}</span>
							{/if}
						</div>
					{/if}
				{/if}
			</section>
		{/if}

		<section class="bin-note bls-panel">
			<h3>关于这个查询</h3>
			<ul>
				<li>卡组织和卡号长度由本站按公开的 IIN 规则本地判断，稳定可靠。</li>
				<li>发卡行、发卡国家等信息来自 binlist.net 的公开数据，为社区维护，中国大陆中小银行覆盖有限，仅供参考。</li>
				<li>BIN 查询<strong>无法</strong>验证一张卡是否真实存在、是否有效，也查不到余额、有效期或持卡人信息。</li>
				<li>本页面不保存你输入的任何内容，只在服务端缓存 BIN 前缀对应的公开发卡行信息。</li>
			</ul>
		</section>
	</div>

	<MobileBottomNav />
</main>

<style>
	.bin-shell {
		margin: 0 auto;
		display: flex;
		max-width: 56rem;
		flex-direction: column;
		gap: 1.25rem;
		padding: 1.5rem 1rem 3rem;
	}

	.bin-nav {
		display: flex;
		flex-wrap: wrap;
		align-items: center;
		justify-content: space-between;
		gap: 0.75rem;
	}

	.bin-nav-links {
		display: flex;
		align-items: center;
		gap: 0.5rem;
	}

	.bin-hero {
		padding: 1.5rem;
	}

	.bin-hero h1 {
		margin-top: 0.35rem;
		font-size: 1.6rem;
		font-weight: 900;
		color: #fff;
	}

	.bin-hero-desc {
		margin-top: 0.6rem;
		font-size: 0.9rem;
		line-height: 1.7;
		color: var(--bls-body);
	}

	.bin-warning {
		margin-top: 0.9rem;
		border: 2px solid var(--bls-gold);
		background: rgba(232, 181, 61, 0.12);
		padding: 0.7rem 0.85rem;
		font-size: 0.82rem;
		line-height: 1.6;
		color: var(--bls-gold-bright);
	}

	.bin-form {
		display: flex;
		flex-direction: column;
		gap: 0.9rem;
		padding: 1.25rem;
	}

	.bin-field {
		display: flex;
		flex-direction: column;
		gap: 0.4rem;
	}

	.bin-field > span {
		font-size: 0.8rem;
		font-weight: 700;
		color: var(--bls-body);
	}

	.bin-input {
		font-family: ui-monospace, SFMono-Regular, Menlo, monospace;
		font-size: 1.35rem;
		letter-spacing: 0.28em;
	}

	.bin-actions {
		display: flex;
		flex-wrap: wrap;
		align-items: center;
		gap: 0.85rem;
	}

	.bin-submit {
		min-width: 7rem;
		padding: 0.6rem 1.4rem;
	}

	.bin-submit:disabled {
		cursor: not-allowed;
		opacity: 0.45;
	}

	.bin-live-network {
		display: flex;
		flex-direction: column;
		font-size: 0.82rem;
		color: var(--bls-body);
	}

	.bin-live-network strong {
		color: var(--bls-cyan);
	}

	.bin-live-network em {
		font-size: 0.72rem;
		font-style: normal;
		color: var(--bls-muted);
	}

	.bin-live-network-muted {
		color: var(--bls-muted);
	}

	.bin-examples {
		display: flex;
		flex-wrap: wrap;
		align-items: center;
		gap: 0.45rem;
		font-size: 0.78rem;
		color: var(--bls-muted);
	}

	.bin-example {
		display: inline-flex;
		align-items: center;
		gap: 0.4rem;
		cursor: pointer;
		font-family: ui-monospace, SFMono-Regular, Menlo, monospace;
	}

	.bin-example em {
		font-family: inherit;
		font-size: 0.7rem;
		font-style: normal;
		color: var(--bls-muted);
	}

	.bin-error {
		border: 2px solid var(--bls-red);
		background: rgba(255, 90, 90, 0.12);
		padding: 0.6rem 0.8rem;
		font-size: 0.82rem;
		color: #ffd9d9;
	}

	.bin-result {
		padding: 1.25rem;
	}

	.bin-result-head {
		display: flex;
		flex-wrap: wrap;
		align-items: flex-start;
		justify-content: space-between;
		gap: 0.75rem;
		border-bottom: 2px solid rgba(255, 255, 255, 0.08);
		padding-bottom: 0.85rem;
	}

	.bin-result-head h2 {
		margin-top: 0.25rem;
		font-family: ui-monospace, SFMono-Regular, Menlo, monospace;
		font-size: 1.4rem;
		font-weight: 900;
		letter-spacing: 0.16em;
		color: #fff;
	}

	.bin-result-head h2 span {
		color: var(--bls-muted);
	}

	.bin-source {
		font-size: 0.72rem;
		font-weight: 700;
		color: var(--bls-muted);
	}

	.bin-source-warn {
		color: var(--bls-gold-bright);
	}

	.bin-grid {
		display: grid;
		gap: 0.85rem;
		padding-top: 1rem;
		grid-template-columns: repeat(auto-fit, minmax(13rem, 1fr));
	}

	.bin-grid dt {
		font-size: 0.72rem;
		font-weight: 700;
		letter-spacing: 0.08em;
		color: var(--bls-muted);
	}

	.bin-grid dd {
		margin-top: 0.2rem;
		font-size: 0.95rem;
		font-weight: 700;
		color: #fff;
	}

	.bin-grid dd em {
		margin-left: 0.4rem;
		font-size: 0.75rem;
		font-style: normal;
		font-weight: 600;
		color: var(--bls-muted);
	}

	.bin-unknown {
		font-weight: 600;
		color: var(--bls-muted);
	}

	.bin-empty {
		padding-top: 1rem;
		font-size: 0.88rem;
		line-height: 1.7;
		color: var(--bls-body);
	}

	.bin-bank-contact {
		display: flex;
		flex-wrap: wrap;
		gap: 1rem;
		border-top: 2px solid rgba(255, 255, 255, 0.08);
		margin-top: 1rem;
		padding-top: 0.85rem;
		font-size: 0.82rem;
		color: var(--bls-muted);
	}

	.bin-bank-contact a {
		color: var(--bls-cyan);
	}

	.bin-note {
		padding: 1.15rem 1.25rem;
	}

	.bin-note h3 {
		font-size: 0.95rem;
		font-weight: 900;
		color: #fff;
	}

	.bin-note ul {
		margin-top: 0.6rem;
		display: flex;
		flex-direction: column;
		gap: 0.45rem;
		font-size: 0.82rem;
		line-height: 1.65;
		color: var(--bls-body);
	}

	.bin-note li {
		padding-left: 0.9rem;
		position: relative;
	}

	.bin-note li::before {
		content: '·';
		position: absolute;
		left: 0.2rem;
		color: var(--bls-cyan);
		font-weight: 900;
	}

	@media (max-width: 640px) {
		.bin-shell {
			padding: 1rem 0.85rem 5rem;
		}

		.bin-hero h1 {
			font-size: 1.35rem;
		}

		.bin-input {
			font-size: 1.15rem;
			letter-spacing: 0.2em;
		}
	}
</style>
