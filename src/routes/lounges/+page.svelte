<script lang="ts">
	import { enhance } from '$app/forms';
	import cipData from '$lib/data/cip.json';
	import type { ActionData, PageData } from './$types';

	type Channel = (typeof cipData.channels)[number];
	type RecordItem = (typeof cipData.records)[number];
	type Service = RecordItem['services'][number];
	type LoungeComment = PageData['comments'][number];
	type CommentTarget = {
		key: string;
		recordSeq: string;
		channelId: string;
		mode: 'service' | 'channel';
		city: string;
		airport: string;
		channelName: string;
		anchorX: number;
		anchorY: number;
		arrowTop: number;
		arrowSide: 'left' | 'right';
		note?: {
			title: string;
			body?: string;
			sourceUrl?: string;
			sourceLabel?: string;
		};
	};

	let { data: pageData, form }: { data: PageData; form: ActionData } = $props();
	const data = cipData;

	let search = $state('');
	let selectedCity = $state('全部城市');
	let selectedChannel = $state('全部渠道');
	let selectedFeatures = $state<string[]>([]);
	let activeCommentTarget = $state<CommentTarget | null>(null);

	const commentsByTarget = $derived(
		pageData.comments.reduce(
			(map, comment) => {
				const key = `${comment.record_seq}:${comment.channel_id}`;
				if (!map[key]) map[key] = [];
				map[key].push(comment);
				return map;
			},
			{} as Record<string, LoungeComment[]>
		)
	);
	const activeComments = $derived(activeCommentTarget ? (commentsByTarget[activeCommentTarget.key] ?? []) : []);
	const cityHotOrder = [
		'北京',
		'上海',
		'广州',
		'深圳',
		'杭州',
		'成都',
		'重庆',
		'南京',
		'武汉',
		'西安',
		'天津',
		'苏州',
		'无锡苏州',
		'青岛',
		'长沙',
		'郑州',
		'宁波',
		'厦门',
		'福州',
		'济南',
		'合肥',
		'昆明',
		'大连',
		'沈阳',
		'哈尔滨',
		'长春',
		'石家庄',
		'南昌',
		'南宁',
		'贵阳',
		'太原',
		'兰州',
		'海口',
		'三亚',
		'珠海',
		'温州',
		'泉州',
		'烟台',
		'徐州',
		'常州',
		'南通',
		'呼和浩特',
		'乌鲁木齐',
		'银川',
		'西宁',
		'拉萨'
	];
	const cityHotRank = new Map(cityHotOrder.map((city, index) => [city, index]));

	function cityRank(city: string) {
		return cityHotRank.get(city) ?? 1000;
	}

	function compareCity(a: string, b: string) {
		const rankDiff = cityRank(a) - cityRank(b);
		if (rankDiff !== 0) return rankDiff;
		return a.localeCompare(b, 'zh-Hans-CN');
	}

	function compareRecord(a: RecordItem, b: RecordItem) {
		const cityDiff = compareCity(a.city, b.city);
		if (cityDiff !== 0) return cityDiff;
		const airportDiff = a.airport.localeCompare(b.airport, 'zh-Hans-CN');
		if (airportDiff !== 0) return airportDiff;
		return Number(a.seq) - Number(b.seq);
	}

	const cities = $derived([
		'全部城市',
		...Array.from(new Set(data.records.map((item) => item.city))).sort(compareCity)
	]);

	function channelDisplayName(name: string) {
		if (name.startsWith('农行')) return '农行';
		if (name.startsWith('建行')) return '建行';
		if (name.startsWith('银联')) return '银联';
		return name;
	}

	const channelDisplayOrder = ['农行', '招行', '工行', '建行', '兴业', '广发', '交行', '银联'];
	const channelDisplayRank = new Map(channelDisplayOrder.map((name, index) => [name, index]));

	function compareChannel(a: Channel, b: Channel) {
		const rankDiff =
			(channelDisplayRank.get(channelDisplayName(a.name)) ?? 1000) -
			(channelDisplayRank.get(channelDisplayName(b.name)) ?? 1000);
		if (rankDiff !== 0) return rankDiff;
		return channelDisplayName(a.name).localeCompare(channelDisplayName(b.name), 'zh-Hans-CN');
	}

	const orderedChannels = $derived([...data.channels].sort(compareChannel));

	function channelNote(channel: Channel) {
		const sourceByChannel: Record<string, { title: string; body?: string; sourceUrl: string; sourceLabel: string }> = {
			农行: {
				title: '农行贵宾厅权益规则',
				body: '精粹级全部温暖为每卡每年 6 次，积分另换 3 次，消费达标维持无限次。',
				sourceUrl: 'https://www.abchina.com/cn/CreditCard/AboutUs/Update/202511/t20251117_2510181.htm',
				sourceLabel: '中国农业银行公告'
			},
			招行: {
				title: '招行机场贵宾厅查询',
				sourceUrl: 'https://market.cmbchina.com/MPage/online/220531115056699/vip/airport_vip/jcxz-city.html',
				sourceLabel: '招商银行机场贵宾厅'
			},
			工行: {
				title: '工行机场贵宾厅参考',
				sourceUrl: 'https://www.flyert.com/forum.php?mod=viewthread&tid=4184221',
				sourceLabel: '飞客茶馆整理'
			},
			建行: {
				title: '建行龙卡机场贵宾厅服务',
				sourceUrl: 'https://creditcard3.ccb.com/cn/creditcard/news/detail/20241113_1731465211.html',
				sourceLabel: '中国建设银行公告'
			},
			交行: {
				title: '交行机场贵宾服务',
				sourceUrl: 'https://www.bankcomm.com/BankCommSite/upload/infos/201712/19/85209/OTO_PC/jichangguibin2017.html',
				sourceLabel: '交通银行机场贵宾'
			},
			兴业: {
				title: '兴业机场贵宾服务',
				sourceUrl: 'https://creditcard.cib.com.cn/minisite/jichangguibin/pc/index.html',
				sourceLabel: '兴业银行机场贵宾'
			},
			广发: {
				title: '广发机场贵宾服务',
				sourceUrl: 'https://card.cgbchina.com.cn/subsite/201110/4269435/index.html',
				sourceLabel: '广发信用卡机场贵宾'
			}
		};

		return sourceByChannel[channelDisplayName(channel.name)] ?? null;
	}

	const channelOptions = $derived(['全部渠道', ...orderedChannels.map((channel) => channelDisplayName(channel.name))]);

	const visibleChannels = $derived(
		selectedChannel === '全部渠道'
			? orderedChannels
			: orderedChannels.filter((channel) => channelDisplayName(channel.name) === selectedChannel)
	);

	function serviceFor(record: RecordItem, channel: Channel) {
		return record.services.find((service) => service.channelId === channel.id);
	}

	function channelForService(service: Service) {
		return data.channels.find((channel) => channel.id === service.channelId);
	}

	function recordHasVip(record: RecordItem) {
		return record.services.some((service) =>
			service.tags.some((tag) => tag.includes('贵宾楼') || tag.includes('VIP'))
		);
	}

	const featureOptions: {
		id: string;
		icon: string;
		label: string;
		match: (service: Service) => boolean;
	}[] = [
		{
			id: 'cip',
			icon: '🛂',
			label: 'CIP 通道',
			match: (service) =>
				service.covered && (service.code.includes('C') || service.tags.some((tag) => tag.includes('CIP')))
		},
		{
			id: 'food',
			icon: '🍽️',
			label: '热食',
			match: (service) =>
				service.covered &&
				(service.code.includes('H') || service.tags.some((tag) => tag.includes('热食') || tag.includes('餐')))
		},
		{
			id: 'vip',
			icon: '🏛️',
			label: '贵宾楼 / VIP',
			match: (service) =>
				service.covered &&
				(service.code.includes('V') || service.tags.some((tag) => tag.includes('贵宾楼') || tag.includes('VIP')))
		},
		{
			id: 'companion',
			icon: '👥',
			label: '可带人',
			match: (service) => service.covered && service.status.startsWith('+')
		},
		{
			id: 'reserve',
			icon: '📅',
			label: '需预约',
			match: (service) =>
				service.covered && (service.code.includes('Y') || service.tags.some((tag) => tag.includes('预约')))
		},
		{
			id: 'after-security',
			icon: '🧳',
			label: '安检后',
			match: (service) =>
				service.covered && (service.code.includes('X') || service.tags.some((tag) => tag.includes('安检后')))
		}
	];

	function toggleFeature(featureId: string) {
		selectedFeatures = selectedFeatures.includes(featureId)
			? selectedFeatures.filter((item) => item !== featureId)
			: [...selectedFeatures, featureId];
	}

	function clearFeatures() {
		selectedFeatures = [];
	}

	function recordMatchesFeatures(record: RecordItem) {
		if (selectedFeatures.length === 0) return true;
		return selectedFeatures.every((featureId) => {
			const option = featureOptions.find((item) => item.id === featureId);
			return option ? record.services.some((service) => option.match(service)) : true;
		});
	}

	function serviceMatchesSelectedFeatures(service: Service) {
		if (selectedFeatures.length === 0) return false;
		return selectedFeatures.some((featureId) => {
			const option = featureOptions.find((item) => item.id === featureId);
			return option ? option.match(service) : false;
		});
	}

	function recordMatchesChannel(record: RecordItem) {
		if (selectedChannel === '全部渠道') return true;
		return record.services.some((service) => channelDisplayName(service.channelName) === selectedChannel && service.covered);
	}

	function recordMatchesSearch(record: RecordItem) {
		const keyword = search.trim().toLowerCase();
		if (!keyword) return true;
		return `${record.city} ${record.airport} ${record.section} ${record.services
			.map((service) => `${service.channelName} ${service.statusLabel} ${service.code} ${service.tags.join(' ')}`)
			.join(' ')}`
			.toLowerCase()
			.includes(keyword);
	}

	const filteredRecords = $derived(
		data.records
			.filter((record) => {
				const matchesCity = selectedCity === '全部城市' || record.city === selectedCity;
				return matchesCity && recordMatchesChannel(record) && recordMatchesSearch(record) && recordMatchesFeatures(record);
			})
			.sort(compareRecord)
	);
	const mobileRecords = $derived(filteredRecords.filter((record) => mobileServices(record).length > 0));

	const vipCount = $derived(data.records.filter(recordHasVip).length);

	function activeServices(record: RecordItem) {
		return record.services
			.filter((service) => service.covered)
			.sort(
				(a, b) =>
					(channelDisplayRank.get(channelDisplayName(a.channelName)) ?? 1000) -
					(channelDisplayRank.get(channelDisplayName(b.channelName)) ?? 1000)
			);
	}

	function mobileServices(record: RecordItem) {
		const services = activeServices(record);
		if (selectedFeatures.length === 0) return services;
		return services.filter(serviceMatchesSelectedFeatures);
	}

	function serviceTone(service: Service) {
		if (service.status.startsWith('+')) return 'is-companion';
		if (service.tags.some((tag) => tag.includes('贵宾楼') || tag.includes('VIP'))) return 'is-vip';
		if (service.tags.some((tag) => tag.includes('热食'))) return 'is-food';
		return 'is-available';
	}

	function statusText(service: Service) {
		if (service.status === '+1') return '可带 1 位同行成人';
		if (service.status === '+2') return '可带 2 位同行成人';
		return '可用';
	}

	function codeParts(code: string) {
		if (!code) return [];
		if (code === '暂停') return ['当前暂停'];
		if (code === '新开') return ['新开通'];
		if (code === '本地卡') return ['本地卡限定'];
		if (code === '仅黑金无限') return ['仅黑金 / 无限卡'];
		if (code === '借记卡V') return ['借记卡可用', '贵宾楼 / VIP'];

		const parts: string[] = [];
		if (code.includes('C')) parts.push('CIP通道+休息室');
		if (code.includes('D')) parts.push('贵宾区休息+独立安检');
		if (code.includes('V')) parts.push('贵宾楼 / VIP');
		if (code.includes('X')) parts.push('仅安检后休息室');
		if (code.includes('H')) parts.push('饭点热食');
		if (code.includes('Y')) parts.push('需提前预约');
		return parts;
	}

	function serviceSummary(service: Service) {
		return Array.from(new Set([statusText(service), ...codeParts(service.code), ...service.tags])).filter(Boolean);
	}

	function serviceVisualItems(service: Service) {
		const items = serviceSummary(service).filter((item) => item !== '可用');
		const hasCipRoom = items.some((item) => item.includes('CIP通道+休息室'));
		const hasMealWindow = items.some((item) => item.includes('饭点热食'));
		return items.filter((item) => {
			if (hasCipRoom && item === '休息室') return false;
			if (hasMealWindow && item === '热食') return false;
			return true;
		});
	}

	function mobileVisualItems(service: Service) {
		if (selectedFeatures.length > 0) {
			return selectedFeatures
				.map((featureId) => featureOptions.find((option) => option.id === featureId))
				.filter((option): option is (typeof featureOptions)[number] => option !== undefined)
				.filter((option) => option.match(service))
				.map((option) => option.label);
		}

		const seenIcons = new Set<string>();
		return serviceVisualItems(service).filter((item) => {
			const icon = serviceIcon(item);
			if (seenIcons.has(icon)) return false;
			seenIcons.add(icon);
			return true;
		});
	}

	function serviceIcon(item: string) {
		if (item.includes('同行')) return '👥';
		if (item.includes('CIP')) return '🛂';
		if (item.includes('休息室')) return '🛋️';
		if (item.includes('热食') || item.includes('餐')) return '🍽️';
		if (item.includes('贵宾楼') || item.includes('VIP')) return '🏛️';
		if (item.includes('安检')) return '🧳';
		if (item.includes('预约')) return '📅';
		if (item.includes('暂停')) return '⏸️';
		if (item.includes('新开')) return '✨';
		if (item.includes('借记')) return '💳';
		return '✓';
	}

	function channelSummary(record: RecordItem) {
		const services = activeServices(record);
		if (!services.length) return '暂无覆盖渠道';
		return services.map((service) => channelDisplayName(service.channelName)).join(' / ');
	}

	function commentKey(record: RecordItem, channel: Channel) {
		return `${record.seq}:${channel.id}`;
	}

	function channelCommentKey(channel: Channel) {
		return `channel:${channel.id}`;
	}

	function serviceCommentCount(record: RecordItem, service: Service) {
		const channel = channelForService(service);
		if (!channel) return 0;
		return commentsByTarget[commentKey(record, channel)]?.length ?? 0;
	}

	function openServiceComments(record: RecordItem, service: Service, event: MouseEvent) {
		const channel = channelForService(service);
		if (!channel) return;
		openComments(record, channel, event);
	}

	function popupAnchor(event: MouseEvent) {
		const target = event.currentTarget as HTMLElement;
		const rect = target.getBoundingClientRect();
		const width = Math.min(440, window.innerWidth - 32);
		const height = Math.min(680, window.innerHeight - 32);
		const gap = 14;
		let arrowSide: 'left' | 'right' = 'left';
		let anchorX = rect.right + gap;

		if (anchorX + width > window.innerWidth - 16) {
			anchorX = Math.max(16, rect.left - width - gap);
			arrowSide = 'right';
		}

		let anchorY = rect.top + rect.height / 2 - 96;
		anchorY = Math.min(Math.max(16, anchorY), Math.max(16, window.innerHeight - height - 16));

		const arrowTop = Math.min(Math.max(rect.top + rect.height / 2 - anchorY, 32), height - 32);

		return { anchorX, anchorY, arrowTop, arrowSide };
	}

	function commentPopoverStyle(target: CommentTarget) {
		return `left:${target.anchorX}px;top:${target.anchorY}px;--lounge-arrow-top:${target.arrowTop}px;`;
	}

	function openComments(record: RecordItem, channel: Channel, event: MouseEvent) {
		activeCommentTarget = {
			key: commentKey(record, channel),
			recordSeq: String(record.seq),
			channelId: channel.id,
			mode: 'service',
			city: record.city,
			airport: record.airport,
			channelName: channelDisplayName(channel.name),
			...popupAnchor(event)
		};
	}

	function openChannelComments(channel: Channel, event: MouseEvent) {
		const note = channelNote(channel);
		activeCommentTarget = {
			key: channelCommentKey(channel),
			recordSeq: 'channel',
			channelId: channel.id,
			mode: 'channel',
			city: '渠道规则',
			airport: channelDisplayName(channel.name),
			channelName: channelDisplayName(channel.name),
			...popupAnchor(event),
			note: note ?? undefined
		};
	}

	function formatCommentTime(timestamp: number) {
		return new Intl.DateTimeFormat('zh-CN', {
			year: 'numeric',
			month: '2-digit',
			day: '2-digit',
			hour: '2-digit',
			minute: '2-digit'
		}).format(new Date(timestamp * 1000));
	}
</script>

<svelte:head>
	<title>贵宾厅清单 — 贝利卡管家</title>
</svelte:head>

<main class="bls-page lounge-page">
	<div class="lounge-shell">
		<nav class="lounge-nav">
			<a href="/dashboard" class="text-sm font-bold text-[var(--bls-cyan)] hover:text-[var(--bls-gold-bright)]">← 返回我的卡片</a>
			<div class="lounge-nav-links">
				<a href="https://baily.life/" target="_blank" rel="noreferrer" class="bls-nav-link">贝利主页</a>
				<a href="https://wx.zsxq.com/group/15555858118552" target="_blank" rel="noreferrer" class="bls-nav-link">知识星球</a>
			</div>
		</nav>

		<section class="lounge-hero bls-panel">
			<div>
				<p class="bls-label text-[var(--bls-cyan)]">Airport Lounge Desk</p>
				<h1>贵宾厅 / 贵宾楼清单</h1>
				<p>
					按机场查询可用渠道，所有简写已经展开成具体服务形式：CIP、贵宾楼、热食、预约、带人规则都会直接显示。
				</p>
			</div>
			<div class="lounge-stat-grid">
				<div>
					<strong>{data.stats.airports}</strong>
					<span>机场</span>
				</div>
				<div>
					<strong>{data.stats.cities}</strong>
					<span>城市</span>
				</div>
				<div>
					<strong>{vipCount}</strong>
					<span>贵宾楼 / VIP</span>
				</div>
			</div>
		</section>

		<section class="lounge-filter bls-panel">
			<div class="lounge-filter-grid">
				<label>
					<span>搜索</span>
					<input bind:value={search} type="search" placeholder="输入城市、机场、银行、CIP、热食、预约" />
				</label>
				<label>
					<span>地区 / 城市</span>
					<select bind:value={selectedCity}>
						{#each cities as city}
							<option value={city}>{city}</option>
						{/each}
					</select>
				</label>
				<label>
					<span>渠道</span>
					<select bind:value={selectedChannel}>
						{#each channelOptions as channel}
							<option value={channel}>{channel}</option>
						{/each}
					</select>
				</label>
			</div>
			<div class="lounge-quick-filters">
				<div class="lounge-quick-title">
					<span>快速筛选权益</span>
					{#if selectedFeatures.length > 0}
						<button type="button" onclick={clearFeatures}>清除条件</button>
					{/if}
				</div>
				<div class="lounge-feature-options">
					{#each featureOptions as option}
						<button
							type="button"
							class:active={selectedFeatures.includes(option.id)}
							aria-pressed={selectedFeatures.includes(option.id)}
							onclick={() => toggleFeature(option.id)}
						>
							<span aria-hidden="true">{option.icon}</span>
							<span>{option.label}</span>
						</button>
					{/each}
				</div>
			</div>
		</section>

		<section class="lounge-table-panel bls-panel">
			<div class="lounge-section-head">
				<div>
					<p class="bls-label text-[var(--bls-cyan)]">Airport Matrix</p>
					<h2>机场权益表</h2>
				</div>
				<span>{filteredRecords.length} / {data.records.length} 条</span>
			</div>

			<div class="lounge-table-wrap">
				<table class="lounge-table">
					<thead>
						<tr>
							<th>地区 / 机场</th>
							{#each visibleChannels as channel}
								{@const note = channelNote(channel)}
								<th>
									{#if note}
										<a
											href={note.sourceUrl}
											target="_blank"
											rel="noreferrer"
											class="lounge-channel-note-button"
										>
											<span>{channelDisplayName(channel.name)}</span>
											<small>官方列表</small>
										</a>
									{:else}
										{channelDisplayName(channel.name)}
									{/if}
								</th>
							{/each}
						</tr>
					</thead>
					<tbody>
						{#each filteredRecords as record (record.seq)}
							<tr>
								<td class="lounge-airport-cell">
									<strong>{record.city}</strong>
									<span>{record.airport}</span>
								</td>
								{#each visibleChannels as channel}
									{@const service = serviceFor(record, channel)}
									{@const comments = commentsByTarget[commentKey(record, channel)] ?? []}
									{@const visualItems = service ? serviceVisualItems(service) : []}
									<td>
										<button
											type="button"
											class={`lounge-service-cell ${comments.length > 0 ? 'has-comments' : ''}`}
											onclick={(event) => openComments(record, channel, event)}
										>
											{#if service?.covered}
												<span
													class={`lounge-service ${serviceTone(service)} ${
														serviceMatchesSelectedFeatures(service) ? 'is-highlighted' : ''
													}`}
												>
													{#if visualItems.length > 0}
														{#each visualItems as item}
															<span class="lounge-service-pill">
																<span aria-hidden="true">{serviceIcon(item)}</span>
																<span>{item}</span>
															</span>
														{/each}
													{:else}
														<span class="lounge-service-pill">
															<span aria-hidden="true">✓</span>
															<span>已覆盖</span>
														</span>
													{/if}
												</span>
											{:else}
												<span class="lounge-none">未覆盖</span>
											{/if}
											{#if comments.length > 0}
												<span class="lounge-cell-comment-badge" aria-label={`${comments.length} 条留言`}>
													<span aria-hidden="true">💬</span>
													<span>{comments.length}</span>
												</span>
											{/if}
										</button>
									</td>
								{/each}
							</tr>
						{/each}
					</tbody>
				</table>
			</div>
		</section>

		<section class="lounge-mobile-list">
			<div class="lounge-section-head lounge-mobile-head">
				<div>
					<p class="bls-label text-[var(--bls-cyan)]">Airport List</p>
					<h2>机场清单</h2>
				</div>
				<span>{mobileRecords.length} 条</span>
			</div>
			{#each mobileRecords as record (record.seq)}
				{@const services = mobileServices(record)}
				<article class="lounge-record bls-panel">
					<div class="lounge-record-head">
						<div>
							<span>{record.city}</span>
							<h3>{record.airport}</h3>
						</div>
						<small>{services.length} 家银行</small>
					</div>
					<div class="lounge-mobile-services">
						{#if services.length === 0}
							<span class="lounge-none">暂无覆盖</span>
						{:else}
							{#each services as service}
								{@const visualItems = serviceVisualItems(service)}
								{@const mobileItems = mobileVisualItems(service)}
								{@const count = serviceCommentCount(record, service)}
								<button
									type="button"
									class={`lounge-mobile-service-row ${
										serviceMatchesSelectedFeatures(service) ? 'is-highlighted' : ''
									}`}
									onclick={(event) => openServiceComments(record, service, event)}
								>
									<span class="lounge-mobile-bank">
										<span>{channelDisplayName(service.channelName)}</span>
									</span>
									<span class="lounge-mobile-tags">
										{#if mobileItems.length > 0}
											{#each mobileItems as item}
												<span class="lounge-service-pill" title={item} aria-label={item}>
													<span aria-hidden="true">{serviceIcon(item)}</span>
												</span>
											{/each}
										{:else}
											<span class="lounge-service-pill" title="已覆盖" aria-label="已覆盖">
												<span aria-hidden="true">✓</span>
											</span>
										{/if}
									</span>
									{#if count > 0}
										<span class="lounge-mobile-comment-cue" aria-label={`${count} 条留言`}>
											<span aria-hidden="true">💬</span>
											<span>{count}</span>
										</span>
									{/if}
								</button>
							{/each}
						{/if}
					</div>
				</article>
			{/each}
		</section>

		{#if activeCommentTarget}
			<div class="lounge-comment-overlay">
				<button
					type="button"
					class="lounge-comment-backdrop"
					aria-label="关闭留言"
					onclick={() => (activeCommentTarget = null)}
				></button>
				<section
					class={`lounge-comment-popover is-arrow-${activeCommentTarget.arrowSide}`}
					style={commentPopoverStyle(activeCommentTarget)}
					role="dialog"
					aria-modal="true"
					tabindex="-1"
				>
					<div class="lounge-comment-head">
						<div>
							<p class="bls-label text-[var(--bls-cyan)]">{activeCommentTarget.channelName}</p>
							<h2>{activeCommentTarget.city} · {activeCommentTarget.airport}</h2>
						</div>
						<button type="button" aria-label="关闭留言" onclick={() => (activeCommentTarget = null)}>×</button>
					</div>

					{#if form?.commentError}
						<div class="lounge-comment-error">{form.commentError}</div>
					{/if}
					{#if form?.commentSuccess}
						<div class="lounge-comment-success">留言已发布。</div>
					{/if}

					<div class="lounge-comment-list">
						{#if activeCommentTarget.note}
							<article class="lounge-chat-message is-system">
								<div class="lounge-chat-avatar">规</div>
								<div class="lounge-chat-bubble">
									<strong>{activeCommentTarget.note.title}</strong>
									{#if activeCommentTarget.note.body}
										<p>{activeCommentTarget.note.body}</p>
									{/if}
									{#if activeCommentTarget.note.sourceUrl}
										<a href={activeCommentTarget.note.sourceUrl} target="_blank" rel="noreferrer">
											{activeCommentTarget.note.sourceLabel ?? '查看来源'}
										</a>
									{/if}
								</div>
							</article>
						{/if}

						{#if activeComments.length === 0}
							<p class="lounge-comment-empty">
								{activeCommentTarget.mode === 'channel'
									? '还没有渠道留言，可以补充规则变化、官方公告或适用卡等级。'
									: '还没有留言，可以补充实测信息、入口位置或规则变化。'}
							</p>
						{:else}
							{#each activeComments as comment}
								<article class="lounge-chat-message">
									<div class="lounge-chat-avatar">{comment.user_email.slice(0, 1).toUpperCase()}</div>
									<div class="lounge-chat-bubble">
										<div class="lounge-chat-meta">
											<strong>{comment.user_email}</strong>
											<span>{formatCommentTime(comment.created_at)}</span>
										</div>
										<p>{comment.body}</p>
										{#if pageData.user?.id === comment.user_id}
											<form method="POST" action="?/deleteComment" use:enhance>
												<input type="hidden" name="id" value={comment.id} />
												<button type="submit">删除</button>
											</form>
										{/if}
									</div>
								</article>
							{/each}
						{/if}
					</div>

					{#if pageData.user}
						<form method="POST" action="?/addComment" class="lounge-comment-form" use:enhance>
							<input type="hidden" name="recordSeq" value={activeCommentTarget.recordSeq} />
							<input type="hidden" name="channelId" value={activeCommentTarget.channelId} />
							<textarea
								name="body"
								rows="3"
								maxlength="500"
								placeholder={activeCommentTarget.mode === 'channel'
									? '补充这家银行渠道的规则变化、官方链接或适用卡等级'
									: '写下入口位置、实测体验、规则变化等'}
							></textarea>
							<button class="bls-btn" type="submit">发布留言</button>
						</form>
					{:else}
						<a href="/login" class="bls-btn lounge-comment-login">登录后留言</a>
					{/if}
				</section>
			</div>
		{/if}
	</div>
</main>

<style>
	.lounge-page {
		padding: 2rem 1rem 4rem;
		background:
			radial-gradient(circle at 18% 8%, rgba(25, 91, 150, 0.28), transparent 26rem),
			radial-gradient(circle at 88% 10%, rgba(47, 230, 212, 0.13), transparent 24rem),
			linear-gradient(180deg, #0f1726 0%, #0b121e 52%, #09101a 100%);
	}

	.lounge-shell {
		position: relative;
		z-index: 1;
		width: min(1380px, 100%);
		margin: 0 auto;
	}

	.lounge-nav {
		display: flex;
		align-items: center;
		justify-content: space-between;
		gap: 1rem;
		margin-bottom: 1.4rem;
	}

	.lounge-nav-links {
		display: flex;
		gap: 0.75rem;
	}

	.lounge-hero {
		display: grid;
		grid-template-columns: minmax(0, 1fr) 420px;
		gap: 1.5rem;
		align-items: center;
		padding: 1.5rem;
		background: rgba(18, 27, 43, 0.92);
	}

	.lounge-hero h1,
	.lounge-section-head h2 {
		margin: 0.25rem 0 0;
		color: #fff;
		font-weight: 950;
	}

	.lounge-hero h1 {
		font-size: clamp(2rem, 4.6vw, 3.65rem);
		line-height: 1.02;
	}

	.lounge-hero p:not(.bls-label) {
		max-width: 760px;
		margin: 0.9rem 0 0;
		color: var(--bls-body);
		font-size: 1rem;
		line-height: 1.85;
	}

	.lounge-stat-grid {
		display: grid;
		grid-template-columns: repeat(3, 1fr);
		border: 2px solid var(--bls-line);
		background: rgba(255, 255, 255, 0.035);
	}

	.lounge-stat-grid div {
		padding: 1.25rem 0.75rem;
		text-align: center;
	}

	.lounge-stat-grid div + div {
		border-left: 2px solid var(--bls-line);
	}

	.lounge-stat-grid strong {
		display: block;
		color: var(--bls-gold-bright);
		font-size: 2.2rem;
		line-height: 1;
	}

	.lounge-stat-grid span {
		display: block;
		margin-top: 0.5rem;
		color: var(--bls-muted);
		font-size: 0.78rem;
		font-weight: 900;
	}

	.lounge-filter,
	.lounge-table-panel {
		margin-top: 1rem;
		padding: 1rem;
		background: rgba(18, 27, 43, 0.9);
	}

	.lounge-filter-grid {
		display: grid;
		grid-template-columns: minmax(0, 1fr) 190px 190px;
		gap: 0.75rem;
		align-items: end;
	}

	.lounge-filter label > span {
		display: block;
		margin-bottom: 0.4rem;
		color: var(--bls-muted);
		font-size: 0.75rem;
		font-weight: 900;
	}

	.lounge-filter input,
	.lounge-filter select {
		width: 100%;
		border: 2px solid rgba(170, 188, 224, 0.34);
		border-radius: 4px;
		background: rgba(10, 16, 27, 0.88);
		color: #f7fbff;
		font-size: 1rem;
		font-weight: 750;
		padding: 0.78rem 0.85rem;
	}

	.lounge-filter input::placeholder {
		color: var(--bls-dim);
	}

	.lounge-quick-filters {
		display: grid;
		gap: 0.65rem;
		margin-top: 0.85rem;
		border-top: 1px solid rgba(170, 188, 224, 0.16);
		padding-top: 0.85rem;
	}

	.lounge-quick-title {
		display: flex;
		align-items: center;
		justify-content: space-between;
		gap: 0.75rem;
		color: var(--bls-muted);
		font-size: 0.78rem;
		font-weight: 950;
	}

	.lounge-quick-title button,
	.lounge-feature-options button {
		border: 2px solid rgba(170, 188, 224, 0.25);
		border-radius: 4px;
		background: rgba(10, 16, 27, 0.72);
		color: #dce8fb;
		font-weight: 900;
		transition:
			border-color 0.18s ease,
			background 0.18s ease,
			color 0.18s ease,
			transform 0.18s ease;
	}

	.lounge-quick-title button {
		padding: 0.35rem 0.55rem;
		font-size: 0.78rem;
	}

	.lounge-feature-options {
		display: flex;
		flex-wrap: wrap;
		gap: 0.5rem;
	}

	.lounge-feature-options button {
		display: inline-flex;
		align-items: center;
		gap: 0.4rem;
		padding: 0.52rem 0.68rem;
		font-size: 0.9rem;
	}

	.lounge-feature-options button.active {
		border-color: var(--bls-cyan);
		background: rgba(47, 230, 212, 0.14);
		color: #fff;
		box-shadow: 0 0 0 1px rgba(47, 230, 212, 0.16) inset;
	}

	.lounge-feature-options button:hover,
	.lounge-quick-title button:hover {
		border-color: rgba(47, 230, 212, 0.55);
	}

	.lounge-feature-options button:active {
		transform: translateY(1px);
	}

	.lounge-section-head {
		display: flex;
		align-items: end;
		justify-content: space-between;
		gap: 1rem;
		margin-bottom: 0.9rem;
	}

	.lounge-section-head h2 {
		font-size: 1.45rem;
	}

	.lounge-section-head > span {
		border: 2px solid rgba(47, 230, 212, 0.35);
		background: rgba(47, 230, 212, 0.08);
		color: var(--bls-cyan);
		font-size: 0.82rem;
		font-weight: 950;
		padding: 0.42rem 0.65rem;
	}

	.lounge-table-wrap {
		overflow: auto;
		border: 2px solid rgba(170, 188, 224, 0.26);
		background: rgba(12, 20, 33, 0.82);
		max-height: calc(100vh - 9rem);
	}

	.lounge-table {
		width: 100%;
		min-width: 1320px;
		border-collapse: separate;
		border-spacing: 0;
		font-size: 1rem;
	}

	.lounge-table th,
	.lounge-table td {
		border-right: 1px solid rgba(175, 194, 232, 0.2);
		border-bottom: 1px solid rgba(175, 194, 232, 0.24);
		padding: 1.05rem;
		text-align: center;
		vertical-align: middle;
	}

	.lounge-table th {
		position: sticky;
		top: 0;
		z-index: 2;
		background: #172238;
		color: var(--bls-gold-bright);
		font-size: 0.9rem;
		font-weight: 950;
		letter-spacing: 0;
	}

	.lounge-channel-note-button {
		display: inline-grid;
		justify-items: center;
		gap: 0.18rem;
		width: 100%;
		border: 0;
		background: transparent;
		color: inherit;
		font: inherit;
		cursor: pointer;
		text-decoration: none;
	}

	.lounge-channel-note-button span {
		color: var(--bls-gold-bright);
		font-weight: 950;
	}

	.lounge-channel-note-button small {
		color: var(--bls-cyan);
		font-size: 0.72rem;
		font-weight: 950;
		letter-spacing: 0;
	}

	.lounge-channel-note-button:hover span {
		color: #fff2b8;
	}

	.lounge-channel-note-button:hover small {
		color: #b8fff8;
	}

	.lounge-table th:first-child,
	.lounge-table td:first-child {
		position: sticky;
		left: 0;
		z-index: 1;
		background: #152033;
		min-width: 210px;
	}

	.lounge-table th:nth-child(2),
	.lounge-table td:nth-child(2) {
		min-width: 190px;
	}

	.lounge-table th:first-child {
		z-index: 3;
	}

	.lounge-table td {
		color: #d8e4f6;
	}

	.lounge-service-cell {
		position: relative;
		display: grid;
		width: 100%;
		min-height: 6.9rem;
		align-content: center;
		border: 1px solid transparent;
		background: transparent;
		color: inherit;
		text-align: inherit;
		cursor: pointer;
		padding: 0;
	}

	.lounge-service-cell:hover {
		border-color: rgba(47, 230, 212, 0.34);
		background: rgba(47, 230, 212, 0.035);
	}

	.lounge-service-cell.has-comments {
		border-color: rgba(255, 218, 123, 0.26);
		box-shadow: inset 0 0 0 1px rgba(255, 218, 123, 0.12);
	}

	.lounge-table td strong {
		display: block;
		color: #fff;
		font-weight: 950;
		font-size: 1rem;
	}

	.lounge-airport-cell strong {
		color: var(--bls-gold-bright);
	}

	.lounge-table td > span,
	.lounge-channel-summary {
		display: block;
		margin-top: 0.35rem;
		color: #aebdd5;
		font-size: 0.9rem;
		line-height: 1.6;
	}

	.lounge-airport-cell > span {
		color: #fff;
		font-size: 1rem;
		font-weight: 950;
	}

	.lounge-service {
		display: flex;
		flex-wrap: wrap;
		align-content: center;
		gap: 0.4rem;
		min-width: 180px;
		border-left: 3px solid transparent;
		background: transparent;
		padding: 0.68rem;
		text-align: left;
		transition:
			background 0.18s ease,
			border-color 0.18s ease,
			box-shadow 0.18s ease;
	}

	.lounge-service strong {
		flex: 0 0 100%;
		color: #fff;
		font-size: 0.95rem;
	}

	.lounge-service-pill {
		display: inline-flex;
		align-items: center;
		gap: 0.3rem;
		border: 1px solid rgba(255, 255, 255, 0.14);
		border-radius: 4px;
		background: rgba(255, 255, 255, 0.07);
		color: #e8f1ff;
		font-size: 0.78rem;
		font-weight: 900;
		line-height: 1;
		padding: 0.34rem 0.44rem;
	}

	.lounge-service-pill > span:first-child {
		font-size: 0.95rem;
		line-height: 1;
	}

	.lounge-service-pill > span:last-child {
		line-height: 1.25;
	}

	.lounge-service.is-highlighted {
		border-left-color: var(--bls-cyan);
		background: rgba(47, 230, 212, 0.1);
		box-shadow: inset 0 0 0 1px rgba(47, 230, 212, 0.1);
	}

	.lounge-service.is-highlighted.is-vip {
		border-left-color: var(--bls-gold);
		background: rgba(232, 181, 61, 0.09);
	}

	.lounge-service.is-highlighted.is-companion {
		border-left-color: var(--bls-blue);
		background: rgba(91, 157, 255, 0.08);
	}

	.lounge-service.is-highlighted.is-food {
		border-left-color: var(--bls-cyan);
		background: rgba(47, 230, 212, 0.1);
	}

	.lounge-none {
		display: inline-flex;
		justify-content: center;
		color: #8290aa;
		font-size: 0.9rem;
		font-weight: 850;
	}

	.lounge-cell-comment-badge {
		position: absolute;
		right: 0.45rem;
		bottom: 0.45rem;
		display: inline-flex;
		min-width: 1.55rem;
		height: 1.35rem;
		align-items: center;
		justify-content: center;
		gap: 0.16rem;
		border: 1px solid rgba(255, 218, 123, 0.58);
		border-radius: 999px;
		background: rgba(232, 181, 61, 0.2);
		color: #fff0b0;
		font-size: 0.7rem;
		font-weight: 950;
		line-height: 1;
		padding: 0 0.32rem;
		opacity: 1;
	}

	.lounge-cell-comment-badge > span:first-child {
		font-size: 0.78rem;
	}

	.lounge-service-cell:hover .lounge-cell-comment-badge {
		opacity: 1;
		border-color: var(--bls-gold);
		background: rgba(232, 181, 61, 0.26);
		color: #ffffff;
	}

	.lounge-comment-overlay {
		position: fixed;
		inset: 0;
		z-index: 80;
		pointer-events: none;
	}

	.lounge-comment-backdrop {
		position: absolute;
		inset: 0;
		border: 0;
		background: rgba(3, 7, 14, 0.24);
		backdrop-filter: blur(2px);
		pointer-events: auto;
	}

	.lounge-comment-popover {
		position: fixed;
		z-index: 1;
		display: flex;
		flex-direction: column;
		width: min(440px, calc(100vw - 2rem));
		height: min(680px, calc(100vh - 2rem));
		overflow: auto;
		border: 2px solid rgba(170, 188, 224, 0.32);
		border-radius: 12px;
		background: #f8fbff;
		box-shadow: 0 24px 80px rgba(0, 0, 0, 0.45);
		color: #101827;
		padding: 1rem;
		pointer-events: auto;
		transform-origin: left var(--lounge-arrow-top, 64px);
		animation: lounge-comment-pop 180ms cubic-bezier(0.2, 0.8, 0.2, 1);
	}

	.lounge-comment-popover::before {
		position: absolute;
		top: var(--lounge-arrow-top, 64px);
		width: 16px;
		height: 16px;
		content: '';
		background: #f8fbff;
	}

	.lounge-comment-popover.is-arrow-left::before {
		left: -9px;
		border-bottom: 2px solid rgba(170, 188, 224, 0.32);
		border-left: 2px solid rgba(170, 188, 224, 0.32);
		transform: translateY(-50%) rotate(45deg);
	}

	.lounge-comment-popover.is-arrow-right {
		transform-origin: right var(--lounge-arrow-top, 64px);
	}

	.lounge-comment-popover.is-arrow-right::before {
		right: -9px;
		border-right: 2px solid rgba(170, 188, 224, 0.32);
		border-top: 2px solid rgba(170, 188, 224, 0.32);
		transform: translateY(-50%) rotate(45deg);
	}

	@keyframes lounge-comment-pop {
		from {
			opacity: 0;
			transform: translateY(6px) scale(0.96);
		}
		to {
			opacity: 1;
			transform: translateY(0) scale(1);
		}
	}

	.lounge-comment-head {
		display: flex;
		align-items: flex-start;
		justify-content: space-between;
		gap: 1rem;
		border-bottom: 1px solid rgba(20, 35, 58, 0.12);
		padding-bottom: 1rem;
	}

	.lounge-comment-head h2 {
		margin: 0.25rem 0 0;
		color: #101827;
		font-size: 1.25rem;
		font-weight: 950;
	}

	.lounge-comment-head button {
		width: 2.25rem;
		height: 2.25rem;
		border: 0;
		border-radius: 999px;
		background: #e8edf5;
		color: #566173;
		font-size: 1.5rem;
		font-weight: 800;
		line-height: 1;
	}

	.lounge-comment-list {
		display: grid;
		gap: 0.75rem;
		margin-top: 1rem;
		padding-right: 0.1rem;
	}

	.lounge-comment-empty {
		border: 1px dashed rgba(20, 35, 58, 0.14);
		border-radius: 10px;
		background: #fff;
		color: #667085;
		font-size: 0.95rem;
		padding: 0.9rem;
	}

	.lounge-chat-message {
		display: flex;
		align-items: flex-start;
		gap: 0.65rem;
	}

	.lounge-chat-message.is-system .lounge-chat-bubble {
		border-color: rgba(184, 129, 22, 0.18);
		background: #fff8e8;
	}

	.lounge-chat-avatar {
		display: grid;
		flex: 0 0 auto;
		place-items: center;
		width: 2rem;
		height: 2rem;
		border-radius: 999px;
		background: #dbe8ff;
		color: #0b4b9f;
		font-size: 0.82rem;
		font-weight: 950;
	}

	.lounge-chat-message.is-system .lounge-chat-avatar {
		background: #ffe7a6;
		color: #8a5200;
	}

	.lounge-chat-bubble {
		min-width: 0;
		max-width: calc(100% - 2.65rem);
		border: 1px solid rgba(20, 35, 58, 0.1);
		border-radius: 12px;
		border-top-left-radius: 4px;
		background: #fff;
		padding: 0.78rem 0.85rem;
	}

	.lounge-chat-bubble strong {
		color: #101827;
		font-size: 0.94rem;
		font-weight: 950;
	}

	.lounge-chat-bubble p {
		margin: 0.45rem 0 0;
		color: #344054;
		font-size: 0.95rem;
		line-height: 1.65;
		white-space: pre-wrap;
	}

	.lounge-chat-bubble a {
		display: inline-flex;
		margin-top: 0.55rem;
		color: #0b63ce;
		font-size: 0.86rem;
		font-weight: 850;
	}

	.lounge-chat-meta {
		display: flex;
		align-items: center;
		justify-content: space-between;
		gap: 0.8rem;
	}

	.lounge-chat-meta span {
		color: #8a95a8;
		font-size: 0.78rem;
	}

	.lounge-chat-bubble form {
		margin-top: 0.65rem;
	}

	.lounge-chat-bubble button {
		border: 0;
		background: transparent;
		color: #d92d20;
		font-size: 0.85rem;
		font-weight: 800;
	}

	.lounge-comment-form {
		display: grid;
		gap: 0.8rem;
		margin-top: auto;
		padding-top: 1rem;
	}

	.lounge-comment-form textarea {
		width: 100%;
		resize: vertical;
		border: 1px solid rgba(20, 35, 58, 0.18);
		border-radius: 8px;
		background: #fff;
		color: #101827;
		font-size: 1rem;
		line-height: 1.6;
		padding: 0.85rem;
	}

	.lounge-comment-error,
	.lounge-comment-success {
		margin-top: 1rem;
		border-radius: 8px;
		padding: 0.75rem 0.9rem;
		font-size: 0.95rem;
		font-weight: 850;
	}

	.lounge-comment-error {
		background: #fff1f0;
		color: #b42318;
	}

	.lounge-comment-success {
		background: #ecfdf3;
		color: #027a48;
	}

	.lounge-comment-login {
		margin-top: 1rem;
		display: inline-flex;
	}

	.lounge-mobile-list {
		display: none;
		margin-top: 1rem;
	}

	.lounge-record {
		padding: 1rem;
	}

	.lounge-record-head {
		display: flex;
		align-items: center;
		justify-content: space-between;
		gap: 1rem;
	}

	.lounge-record-head strong,
	.lounge-record h3 {
		display: block;
		color: #fff;
		font-weight: 950;
	}

	.lounge-record-head > span {
		color: var(--bls-cyan);
		font-size: 0.78rem;
		font-weight: 950;
	}

	.lounge-record h3 {
		margin: 0.8rem 0 0;
		font-size: 1.25rem;
	}

	.lounge-mobile-services {
		display: grid;
		gap: 0.55rem;
		margin-top: 0.9rem;
	}

	.lounge-mobile-service-row {
		display: grid;
		grid-template-columns: 4.8rem minmax(0, 1fr) auto;
		align-items: center;
		gap: 0.6rem;
		width: 100%;
		border: 1px solid rgba(170, 188, 224, 0.18);
		border-radius: 6px;
		background: rgba(10, 16, 27, 0.52);
		padding: 0.55rem 0.6rem;
		text-align: left;
		transition:
			border-color 0.18s ease,
			background 0.18s ease,
			transform 0.18s ease;
	}

	.lounge-mobile-service-row.is-highlighted {
		border-color: rgba(47, 230, 212, 0.58);
		background: rgba(47, 230, 212, 0.11);
	}

	.lounge-mobile-service-row:active {
		transform: translateY(1px);
	}

	.lounge-mobile-bank {
		display: inline-flex;
		align-items: center;
		gap: 0.3rem;
		min-width: 0;
		color: #eaf3ff;
		font-size: 0.94rem;
		font-weight: 950;
	}

	.lounge-mobile-bank > span:first-child {
		overflow: hidden;
		text-overflow: ellipsis;
		white-space: nowrap;
	}

	.lounge-mobile-comment-dot {
		display: inline-grid;
		flex: 0 0 auto;
		min-width: 1.15rem;
		height: 1.15rem;
		place-items: center;
		border-radius: 999px;
		background: rgba(232, 181, 61, 0.24);
		color: #fff1b8;
		font-size: 0.68rem;
	}

	.lounge-mobile-tags {
		display: flex;
		flex-wrap: wrap;
		justify-content: flex-end;
		gap: 0.3rem;
		min-width: 0;
	}

	.lounge-mobile-comment-cue {
		display: inline-flex;
		min-width: 1.45rem;
		height: 1.35rem;
		align-items: center;
		justify-content: center;
		gap: 0.12rem;
		border: 1px solid rgba(255, 218, 123, 0.58);
		border-radius: 999px;
		background: rgba(232, 181, 61, 0.18);
		color: #fff0b0;
		font-size: 0.66rem;
		font-weight: 950;
		line-height: 1;
		padding: 0 0.25rem;
		opacity: 1;
	}

	.lounge-mobile-comment-cue > span:first-child {
		font-size: 0.76rem;
	}

	@media (max-width: 1024px) {
		.lounge-hero,
		.lounge-filter-grid {
			grid-template-columns: 1fr;
		}

		.lounge-table-panel {
			display: none;
		}

		.lounge-mobile-list {
			display: grid;
			gap: 0.75rem;
		}

		.lounge-stat-grid {
			grid-template-columns: repeat(3, minmax(0, 1fr));
		}

		.lounge-feature-options {
			display: grid;
			grid-template-columns: repeat(2, minmax(0, 1fr));
		}

		.lounge-feature-options button {
			justify-content: center;
		}
	}

	@media (max-width: 640px) {
		.lounge-page {
			padding: 0.9rem 0.85rem 3rem;
		}

		.lounge-comment-overlay {
			display: flex;
			align-items: flex-end;
			padding: 0.75rem;
		}

		.lounge-comment-popover {
			position: relative;
			left: auto !important;
			top: auto !important;
			width: 100%;
			height: min(88vh, 720px);
			transform-origin: center bottom;
		}

		.lounge-comment-popover::before {
			display: none;
		}

		.lounge-nav-links {
			display: none;
		}

		.lounge-hero,
		.lounge-filter,
		.lounge-record {
			padding: 0.9rem;
		}

		.lounge-nav {
			margin-bottom: 1rem;
		}

		.lounge-hero {
			gap: 0.75rem;
		}

		.lounge-hero .bls-label {
			font-size: 0.64rem;
			letter-spacing: 0.12em;
		}

		.lounge-hero h1 {
			margin-top: 0.2rem;
			font-size: 1.7rem;
			line-height: 1.08;
		}

		.lounge-hero p:not(.bls-label) {
			display: none;
		}

		.lounge-stat-grid {
			grid-template-columns: repeat(3, minmax(0, 1fr));
			border-width: 1px;
		}

		.lounge-stat-grid div {
			padding: 0.62rem 0.35rem;
		}

		.lounge-stat-grid div + div {
			border-left: 1px solid var(--bls-line);
			border-top: 0;
		}

		.lounge-stat-grid strong {
			font-size: 1.45rem;
		}

		.lounge-stat-grid span {
			margin-top: 0.25rem;
			font-size: 0.64rem;
		}

		.lounge-filter-grid {
			gap: 0;
		}

		.lounge-filter-grid label:not(:first-child) {
			display: none;
		}

		.lounge-filter label > span {
			margin-bottom: 0.35rem;
			font-size: 0.72rem;
		}

		.lounge-filter input {
			padding: 0.72rem 0.78rem;
			font-size: 0.95rem;
		}

		.lounge-quick-filters {
			margin-top: 0.7rem;
			padding-top: 0.7rem;
		}

		.lounge-quick-title {
			font-size: 0.72rem;
		}

		.lounge-feature-options {
			grid-template-columns: repeat(3, minmax(0, 1fr));
			gap: 0.45rem;
		}

		.lounge-feature-options button {
			min-height: 2.35rem;
			gap: 0.25rem;
			padding: 0.44rem 0.25rem;
			font-size: 0.78rem;
			line-height: 1.15;
		}

		.lounge-mobile-list {
			gap: 0.48rem;
			margin-top: 0.85rem;
		}

		.lounge-mobile-head {
			align-items: center;
			margin-bottom: 0.1rem;
		}

		.lounge-mobile-head h2 {
			font-size: 1.36rem;
		}

		.lounge-mobile-head > span {
			border: 1px solid rgba(47, 230, 212, 0.75);
			background: rgba(47, 230, 212, 0.1);
			padding: 0.45rem 0.55rem;
			color: #6ffff0;
			font-size: 0.78rem;
			line-height: 1;
		}

		.lounge-record {
			border-color: rgba(170, 188, 224, 0.26);
			background:
				linear-gradient(135deg, rgba(25, 91, 150, 0.34), rgba(12, 20, 34, 0.94) 58%),
				rgba(18, 27, 43, 0.92);
			padding: 0.68rem;
		}

		.lounge-record-head {
			align-items: start;
		}

		.lounge-record-head > div {
			min-width: 0;
		}

		.lounge-record-head span {
			color: #a9dfff;
			font-size: 0.86rem;
			font-weight: 850;
		}

		.lounge-record h3 {
			margin-top: 0.25rem;
			font-size: 1.08rem;
			line-height: 1.25;
		}

		.lounge-record-head small {
			flex: 0 0 auto;
			color: #dbeafe;
			font-size: 0.76rem;
			font-weight: 900;
			line-height: 1.4;
		}

		.lounge-mobile-services {
			display: grid;
			grid-template-columns: repeat(2, minmax(0, 1fr));
			gap: 0.34rem;
			margin-top: 0.55rem;
		}

		.lounge-mobile-service-row {
			display: flex;
			align-items: center;
			justify-content: space-between;
			gap: 0.25rem;
			min-width: 0;
			min-height: 2.05rem;
			padding: 0.32rem 0.36rem;
			border-radius: 6px;
			background: rgba(7, 13, 23, 0.44);
		}

		.lounge-mobile-bank {
			flex: 0 1 auto;
			min-width: 2.15rem;
			font-size: 0.78rem;
		}

		.lounge-mobile-tags {
			flex: 0 0 auto;
			gap: 0.22rem;
		}

		.lounge-mobile-tags .lounge-service-pill {
			display: inline-grid;
			width: 1.3rem;
			height: 1.3rem;
			place-items: center;
			padding: 0;
			font-size: 0.66rem;
		}

		.lounge-mobile-tags .lounge-service-pill > span:first-child {
			font-size: 0.78rem;
		}

		.lounge-mobile-comment-cue {
			min-width: 1.28rem;
			width: 1.28rem;
			height: 1.28rem;
			padding: 0;
		}

		.lounge-mobile-comment-cue > span:first-child {
			font-size: 0.72rem;
		}
	}
</style>
