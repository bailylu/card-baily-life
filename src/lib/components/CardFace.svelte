<script lang="ts">
	type CardStyle = {
		label: string;
		gradient: string;
		accent: string;
		text: string;
	};

	let {
		imageUrl,
		bankName,
		displayName,
		lastFour = '1234',
		cardStyle,
		class: className = ''
	}: {
		imageUrl?: string | null;
		bankName?: string | null;
		displayName: string;
		lastFour?: string;
		cardStyle: CardStyle;
		class?: string;
	} = $props();
</script>

<div class={`relative aspect-[1.586/1] overflow-hidden rounded-2xl shadow-sm ${className}`}>
	{#if imageUrl}
		<img src={imageUrl} alt={`${displayName} 卡面`} class="h-full w-full object-cover" loading="lazy" />
	{:else}
		<div
			class="relative h-full w-full overflow-hidden p-4"
			style={`background: ${cardStyle.gradient}; color: ${cardStyle.text};`}
		>
			<div
				class="absolute -right-10 -top-10 h-28 w-28 rounded-full"
				style={`background: ${cardStyle.accent};`}
			></div>
			<div
				class="absolute bottom-4 right-6 h-8 w-14 rounded-full blur-sm"
				style={`background: ${cardStyle.accent};`}
			></div>
			<div class="relative flex h-full flex-col justify-between">
				<div class="flex items-center justify-between text-xs opacity-80">
					<span>{bankName ?? 'card.baily.life'}</span>
					<span>{cardStyle.label}</span>
				</div>
				<div>
					<h3 class="text-lg font-semibold">{displayName}</h3>
					<p class="mt-3 font-mono text-sm tracking-[0.35em] opacity-80">•••• {lastFour}</p>
				</div>
			</div>
		</div>
	{/if}
</div>
