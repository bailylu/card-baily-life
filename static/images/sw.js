/* 贝利卡管家 — 轻量 Service Worker（可安装 + 基础离线壳） */
const CACHE = 'card-baily-v1';
const PRECACHE = ['/', '/dashboard', '/manifest.webmanifest', '/icons/icon-192.png', '/icons/icon-512.png'];

self.addEventListener('install', (event) => {
	event.waitUntil(
		caches
			.open(CACHE)
			.then((cache) => cache.addAll(PRECACHE).catch(() => undefined))
			.then(() => self.skipWaiting())
	);
});

self.addEventListener('activate', (event) => {
	event.waitUntil(
		caches
			.keys()
			.then((keys) => Promise.all(keys.filter((k) => k !== CACHE).map((k) => caches.delete(k))))
			.then(() => self.clients.claim())
	);
});

self.addEventListener('fetch', (event) => {
	const req = event.request;
	if (req.method !== 'GET') return;

	const url = new URL(req.url);
	if (url.origin !== self.location.origin) return;

	// 导航：网络优先，失败回 dashboard 缓存
	if (req.mode === 'navigate') {
		event.respondWith(
			fetch(req)
				.then((res) => {
					const copy = res.clone();
					caches.open(CACHE).then((c) => c.put(req, copy)).catch(() => undefined);
					return res;
				})
				.catch(async () => {
					const cached = await caches.match(req);
					return cached || caches.match('/dashboard') || caches.match('/');
				})
		);
		return;
	}

	// 静态资源：缓存优先
	if (
		url.pathname.startsWith('/_app/') ||
		url.pathname.startsWith('/icons/') ||
		url.pathname.startsWith('/images/') ||
		url.pathname === '/manifest.webmanifest'
	) {
		event.respondWith(
			caches.match(req).then(
				(hit) =>
					hit ||
					fetch(req).then((res) => {
						const copy = res.clone();
						caches.open(CACHE).then((c) => c.put(req, copy)).catch(() => undefined);
						return res;
					})
			)
		);
	}
});
