export function registerServiceWorker() {
	if (typeof window === 'undefined') return;
	if (!('serviceWorker' in navigator)) return;

	const register = () => {
		// 放在 /icons/ 下：CF 静态 exclude 稳定，且避开自定义域名根路径 404 缓存
		navigator.serviceWorker.register('/icons/sw.js', { scope: '/' }).catch((err) => {
			console.warn('[pwa] sw register failed', err);
		});
	};

	if (document.readyState === 'complete') register();
	else window.addEventListener('load', register, { once: true });
}
