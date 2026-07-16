<script lang="ts">
	import { page } from '$app/state';

	type TabId = 'cards' | 'lounges' | 'me';

	let { active = undefined as TabId | undefined } = $props();

	let path = $derived(page.url.pathname);

	let current = $derived.by((): TabId => {
		if (active) return active;
		if (path.startsWith('/me')) return 'me';
		if (path.startsWith('/lounges')) return 'lounges';
		return 'cards';
	});

	const tabs: Array<{
		id: TabId;
		href: string;
		label: string;
		icon: 'cards' | 'bell' | 'lounge' | 'me';
	}> = [
		{ id: 'cards', href: '/dashboard', label: '卡片', icon: 'cards' },
		{ id: 'lounges', href: '/lounges', label: '贵宾厅', icon: 'lounge' },
		{ id: 'me', href: '/me', label: '我的', icon: 'me' }
	];

</script>

<nav class="app-tabbar" aria-label="主导航">
	{#each tabs as tab}
		<a
			href={tab.href}
			target={tab.id === 'me' ? 'mobile-app-frame' : undefined}
			data-sveltekit-reload={tab.id === 'me' ? '' : undefined}
			class="app-tab"
			class:is-active={current === tab.id}
			aria-current={current === tab.id ? 'page' : undefined}
		>
			<span class="app-tab-icon" aria-hidden="true">
				{#if tab.icon === 'cards'}
					<svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8">
						<rect x="2.5" y="5" width="19" height="14" rx="2.5" />
						<path d="M2.5 10h19" />
						<path d="M6.5 15h4" stroke-linecap="round" />
					</svg>
				{:else if tab.icon === 'bell'}
					<svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8">
						<path
							d="M12 3.5a5 5 0 0 0-5 5v2.2c0 .7-.2 1.4-.7 2L5 14.5h14l-1.3-1.8c-.5-.6-.7-1.3-.7-2V8.5a5 5 0 0 0-5-5Z"
							stroke-linejoin="round"
						/>
						<path d="M10 17.5a2 2 0 0 0 4 0" stroke-linecap="round" />
					</svg>
				{:else if tab.icon === 'lounge'}
					<svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8">
						<path d="M3 17h18" stroke-linecap="round" />
						<path d="M5 17V9.5A2.5 2.5 0 0 1 7.5 7h9A2.5 2.5 0 0 1 19 9.5V17" />
						<path d="M8 12h8" stroke-linecap="round" />
						<path d="M7 20h2M15 20h2" stroke-linecap="round" />
					</svg>
				{:else}
					<svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8">
						<circle cx="12" cy="8.5" r="3.2" />
						<path
							d="M5.5 19c1.4-3 3.7-4.5 6.5-4.5s5.1 1.5 6.5 4.5"
							stroke-linecap="round"
						/>
					</svg>
				{/if}
			</span>
			<span class="app-tab-label">{tab.label}</span>
		</a>
	{/each}
</nav>
