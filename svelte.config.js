import adapter from '@sveltejs/adapter-cloudflare';

/** @type {import('@sveltejs/kit').Config} */
const config = {
	compilerOptions: {
		// Force runes mode for the project, except for libraries. Can be removed in svelte 6.
		runes: ({ filename }) => (filename.split(/[/\\]/).includes('node_modules') ? undefined : true)
	},
	kit: {
		// adapter-auto only supports some environments, see https://svelte.dev/docs/kit/adapter-auto for a list.
		// If your environment is not supported, or you settled on a specific environment, switch out the adapter.
		// See https://svelte.dev/docs/kit/adapters for more information about adapters.
		// 用通配 exclude 静态资源，避免 CF _routes.json 100 条上限把 manifest/sw 挤掉导致 404
		adapter: adapter({
			routes: {
				include: ['/*'],
				exclude: [
					'/_app/*',
					'/icons/*',
					'/images/*',
					'/manifest.webmanifest',
					'/service-worker.js',
					'/sw.js',
					'/robots.txt',
					'/mobile-app-mock.html',
					'/mobile-preview.html'
				]
			}
		})
	}
};

export default config;
