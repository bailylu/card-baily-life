<script lang="ts">
	type CardKey = 'marriott' | 'safari' | 'airlines';

	type Props = {
		current: CardKey;
	};

	let { current }: Props = $props();

	const cards: Array<{
		key: CardKey;
		name: string;
		description: string;
		image: string;
		href: string;
	}> = [
		{
			key: 'marriott',
			name: '万豪精逸白金卡',
			description: '适合看重万豪积分、房券、酒店权益和贵宾厅的人。',
			image: '/images/cards/citic-marriott-bonvoy.webp',
			href: '/refer/citic-marriott'
		},
		{
			key: 'safari',
			name: 'Safari 联名信用卡',
			description: '贵宾厅、里程兑换、亲子权益、道路救援和航延保障。',
			image: '/images/cards/citic-safari-card-cropped.webp',
			href: '/refer/citic-safari'
		},
		{
			key: 'airlines',
			name: '中信5大航司联名信用卡',
			description: '南航里程、36+1 新生活、贵宾厅和出行保障组合。',
			image: '/images/cards/citic-airlines-123-horizontal.png',
			href: '/refer/%E8%88%AA%E5%8F%B8%E8%81%94%E5%90%8D%E4%BF%A1%E7%94%A8%E5%8D%A1'
		}
	];

	let relatedCards = $derived(cards.filter((card) => card.key !== current));
</script>

<section class="mt-8 rounded-3xl border border-slate-200 bg-white p-6 shadow-sm">
	<div class="flex items-center justify-between gap-4">
		<h2 class="text-xl font-black text-slate-950">也可以看看这些卡</h2>
	</div>
	<div class="mt-5 grid gap-4 md:grid-cols-2">
		{#each relatedCards as card}
			<a href={card.href} class="group grid gap-4 rounded-2xl bg-slate-50 p-4 ring-1 ring-slate-200 transition hover:-translate-y-0.5 hover:bg-white hover:shadow-lg hover:shadow-slate-200 sm:grid-cols-[180px_minmax(0,1fr)]">
				<img src={card.image} alt={card.name} class="aspect-[1.586] w-full rounded-xl bg-white object-contain ring-1 ring-slate-200" loading="lazy" />
				<div class="min-w-0">
					<h3 class="text-lg font-black text-slate-950">{card.name}</h3>
					<p class="mt-2 text-sm leading-6 text-slate-500">{card.description}</p>
					<span class="mt-4 inline-flex rounded-full bg-blue-600 px-4 py-2 text-xs font-bold text-white shadow-sm shadow-blue-600/20 group-hover:bg-blue-700">
						查看权益
					</span>
				</div>
			</a>
		{/each}
	</div>
</section>
