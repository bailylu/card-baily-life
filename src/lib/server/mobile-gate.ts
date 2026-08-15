/**
 * 手机访问暂停闸门。
 *
 * 手机浏览器打开页面时不再进入应用，而是返回一张「请用电脑访问」的提示页。
 * 恢复手机访问：把 MOBILE_GATE_ENABLED 改成 false 即可（不用动 hooks）。
 *
 * 自查通道：手机上访问 ?allow_mobile=1 会种一个 12 小时的放行 cookie，
 * ?allow_mobile=0 清除。提示页里不放这个入口，只给自己人用。
 */

export const MOBILE_GATE_ENABLED = true;

export const MOBILE_GATE_BYPASS_COOKIE = 'allow_mobile';
export const MOBILE_GATE_BYPASS_PARAM = 'allow_mobile';
export const MOBILE_GATE_PATH = '/desktop-only';
export const MOBILE_GATE_PLACEHOLDER = '%bls.mobilegate%';
const BYPASS_MAX_AGE = 60 * 60 * 12;

// 手机（含安卓平板）。iPad 在 iPadOS 上伪装成 macOS Safari，无法可靠识别，按电脑放行。
const MOBILE_UA =
	/(iphone|ipod|android|windows phone|iemobile|blackberry|bb10|webos|opera mini|mobi)/i;

// 搜索引擎与抓取工具一律放行，否则移动端索引会整体掉光。
const CRAWLER_UA =
	/(bot\b|bot\/|crawler|spider|slurp|baiduspider|bytespider|yisouspider|sogou|yandex|duckduckbot|applebot|petalbot|facebookexternalhit|whatsapp|telegram|feedfetcher|lighthouse|pagespeed|headlesschrome)/i;

// 只拦页面导航，接口和静态资源照常。
const ALWAYS_ALLOWED_PREFIXES = ['/api/', '/_app/', '/icons/', '/images/'];
const ALWAYS_ALLOWED_PATHS = [
	'/manifest.webmanifest',
	'/robots.txt',
	'/favicon.ico',
	'/service-worker.js'
];

export function isCrawlerUserAgent(userAgent: string | null): boolean {
	return !!userAgent && CRAWLER_UA.test(userAgent);
}

export function isMobileRequest(headers: Headers): boolean {
	// Chrome/Edge 默认带客户端提示，比 UA 更准，优先用它。
	const hint = headers.get('sec-ch-ua-mobile');
	if (hint === '?1') return true;

	const userAgent = headers.get('user-agent');
	return !!userAgent && MOBILE_UA.test(userAgent);
}

function isDocumentRequest(headers: Headers): boolean {
	const dest = headers.get('sec-fetch-dest');
	if (dest) return dest === 'document';
	return (headers.get('accept') ?? '').includes('text/html');
}

function isGatedPath(pathname: string): boolean {
	if (ALWAYS_ALLOWED_PATHS.includes(pathname)) return false;
	if (ALWAYS_ALLOWED_PREFIXES.some((prefix) => pathname.startsWith(prefix))) return false;
	return true;
}

export type MobileGateDecision =
	| { action: 'allow' }
	| { action: 'bypass'; enabled: boolean }
	| { action: 'block' };

export function decideMobileGate(request: Request, url: URL, cookieHeader: string | null): MobileGateDecision {
	const bypassParam = url.searchParams.get(MOBILE_GATE_BYPASS_PARAM);
	if (bypassParam === '1' || bypassParam === '0') {
		return { action: 'bypass', enabled: bypassParam === '1' };
	}

	if (!MOBILE_GATE_ENABLED) return { action: 'allow' };
	if (request.method !== 'GET' && request.method !== 'HEAD') return { action: 'allow' };

	// 前端窄屏兜底会跳到这里，所以它必须无条件出提示页，否则会来回跳。
	if (url.pathname === MOBILE_GATE_PATH) return { action: 'block' };

	if (!isGatedPath(url.pathname)) return { action: 'allow' };
	if (!isDocumentRequest(request.headers)) return { action: 'allow' };
	if (isCrawlerUserAgent(request.headers.get('user-agent'))) return { action: 'allow' };
	if (hasBypassCookie(cookieHeader)) return { action: 'allow' };
	if (!isMobileRequest(request.headers)) return { action: 'allow' };

	return { action: 'block' };
}

function hasBypassCookie(cookieHeader: string | null): boolean {
	if (!cookieHeader) return false;
	return cookieHeader
		.split(';')
		.map((part) => part.trim())
		.some((part) => part === `${MOBILE_GATE_BYPASS_COOKIE}=1`);
}

export function buildBypassResponse(url: URL, enabled: boolean, secure: boolean): Response {
	const target = new URL(url);
	target.searchParams.delete(MOBILE_GATE_BYPASS_PARAM);

	// 故意不加 HttpOnly：前端窄屏兜底脚本要读它来判断是否放行。
	const cookie = enabled
		? `${MOBILE_GATE_BYPASS_COOKIE}=1; Path=/; Max-Age=${BYPASS_MAX_AGE}; SameSite=Lax${secure ? '; Secure' : ''}`
		: `${MOBILE_GATE_BYPASS_COOKIE}=; Path=/; Max-Age=0; SameSite=Lax${secure ? '; Secure' : ''}`;

	return new Response(null, {
		status: 302,
		headers: {
			location: `${target.pathname}${target.search}`,
			'set-cookie': cookie,
			'cache-control': 'no-store'
		}
	});
}

/**
 * 兜底脚本：注入到每张 SSR 页面的 <head>，在水合前跑。
 * 专治「手机开了请求桌面站点」——UA 伪装成电脑，但触摸屏 + 物理屏幕仍然是手机。
 * 判定条件是「粗指针（触屏）且屏幕短边小于 768」，电脑把窗口拖窄不会被误伤。
 */
export function buildMobileGateClientScript(): string {
	return `<script>(function(){try{
if(location.pathname===${JSON.stringify(MOBILE_GATE_PATH)})return;
if(document.cookie.indexOf(${JSON.stringify(`${MOBILE_GATE_BYPASS_COOKIE}=1`)})>-1)return;
var coarse=window.matchMedia&&window.matchMedia('(pointer: coarse)').matches;
var shortSide=Math.min(screen.width||9999,screen.height||9999);
if(coarse&&shortSide<768)location.replace(${JSON.stringify(MOBILE_GATE_PATH)});
}catch(e){}})();</script>`;
}

export function buildMobileGateResponse(url: URL): Response {
	return new Response(renderMobileGatePage(url.host), {
		status: 200,
		headers: {
			'content-type': 'text/html; charset=utf-8',
			'cache-control': 'no-store',
			vary: 'User-Agent, Sec-CH-UA-Mobile'
		}
	});
}

function renderMobileGatePage(host: string): string {
	return `<!doctype html>
<html lang="zh-CN">
<head>
<meta charset="utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1, viewport-fit=cover" />
<meta name="robots" content="noindex" />
<meta name="theme-color" content="#0a0e18" />
<title>请用电脑访问 · 贝利卡管家</title>
<style>
	:root {
		--bls-bg-void: #06090f;
		--bls-bg: #0a0e18;
		--bls-panel: #121829;
		--bls-inset: #0c111e;
		--bls-line: rgba(150, 170, 210, 0.22);
		--bls-ink: #ecf1fb;
		--bls-body: #c2cce0;
		--bls-muted: #828fab;
		--bls-gold: #e8b53d;
	}
	* { box-sizing: border-box; }
	html, body { margin: 0; padding: 0; }
	body {
		min-height: 100vh;
		display: flex;
		align-items: center;
		justify-content: center;
		padding: 24px;
		color-scheme: dark;
		color: var(--bls-ink);
		background:
			radial-gradient(circle at 8% 0%, rgba(91, 157, 255, 0.2), transparent 30rem),
			radial-gradient(circle at 92% 18%, rgba(47, 230, 212, 0.09), transparent 28rem),
			linear-gradient(135deg, var(--bls-bg-void), var(--bls-bg) 46%, #0b1826);
		font-family: "Noto Sans SC", -apple-system, BlinkMacSystemFont, "PingFang SC", "Microsoft YaHei", sans-serif;
	}
	.card {
		width: 100%;
		max-width: 420px;
		padding: 28px 22px 24px;
		border: 1px solid var(--bls-line);
		border-radius: 14px;
		background: var(--bls-panel);
		box-shadow: 0 0 0 1px rgba(150, 170, 210, 0.08), 4px 4px 0 rgba(0, 0, 0, 0.5);
	}
	.badge {
		display: inline-block;
		padding: 4px 10px;
		border: 1px solid rgba(232, 181, 61, 0.5);
		border-radius: 999px;
		font-size: 12px;
		letter-spacing: 0.08em;
		color: var(--bls-gold);
	}
	h1 { margin: 16px 0 10px; font-size: 22px; font-weight: 900; letter-spacing: 0.01em; }
	p { margin: 0 0 12px; font-size: 15px; line-height: 1.7; color: var(--bls-body); }
	.url {
		display: flex;
		align-items: center;
		justify-content: space-between;
		gap: 10px;
		margin: 18px 0 14px;
		padding: 12px 14px;
		border: 1px solid var(--bls-line);
		border-radius: 10px;
		background: var(--bls-inset);
	}
	.url code { font-size: 15px; font-weight: 700; color: var(--bls-gold); word-break: break-all; }
	button {
		flex: none;
		min-height: 36px;
		padding: 0 14px;
		border: 1px solid var(--bls-line);
		border-radius: 8px;
		background: transparent;
		color: var(--bls-body);
		font-size: 13px;
		cursor: pointer;
	}
	button:active { background: rgba(150, 170, 210, 0.12); }
	.note { margin: 0; font-size: 13px; color: var(--bls-muted); }
</style>
</head>
<body>
	<main class="card">
		<span class="badge">手机端暂停服务</span>
		<h1>请在电脑上打开贝利卡管家</h1>
		<p>手机访问已暂时关闭。卡片管理、账单与年费提醒等功能，目前只在电脑浏览器上提供。</p>
		<div class="url">
			<code id="site-url">${escapeHtml(host)}</code>
			<button type="button" id="copy-btn">复制</button>
		</div>
		<p class="note">在电脑浏览器地址栏输入上面的网址即可继续使用。恢复手机访问后会另行通知。</p>
	</main>
	<script>
		document.getElementById('copy-btn').addEventListener('click', function () {
			var btn = this;
			var text = document.getElementById('site-url').textContent;
			var done = function () {
				btn.textContent = '已复制';
				setTimeout(function () { btn.textContent = '复制'; }, 1600);
			};
			if (navigator.clipboard && navigator.clipboard.writeText) {
				navigator.clipboard.writeText(text).then(done, function () { btn.textContent = '复制失败'; });
			} else {
				btn.textContent = '请手动复制';
			}
		});
	</script>
</body>
</html>`;
}

function escapeHtml(value: string): string {
	return value
		.replace(/&/g, '&amp;')
		.replace(/</g, '&lt;')
		.replace(/>/g, '&gt;')
		.replace(/"/g, '&quot;');
}
