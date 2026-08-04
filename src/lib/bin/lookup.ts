import { eq } from 'drizzle-orm';
import { getDb } from '$lib/db/client';
import { bin_cache } from '$lib/db/schema';

const BINLIST_ENDPOINT = 'https://lookup.binlist.net';
// BIN 归属变化极慢，90 天足够新；缓存过期后失败仍会回退到旧值。
const CACHE_TTL_SECONDS = 90 * 24 * 60 * 60;
const FETCH_TIMEOUT_MS = 6000;

export type BinDetail = {
	bin: string;
	found: boolean;
	scheme: string | null;
	brand: string | null;
	cardType: string | null;
	prepaid: boolean | null;
	country: {
		alpha2: string | null;
		name: string | null;
		emoji: string | null;
		currency: string | null;
	} | null;
	bank: {
		name: string | null;
		url: string | null;
		phone: string | null;
		city: string | null;
	} | null;
};

export type LookupResult = {
	detail: BinDetail | null;
	/** cache = 命中缓存；live = 刚从 binlist 取回；stale = 上游失败，回退到过期缓存 */
	source: 'cache' | 'live' | 'stale' | 'none';
	/** 上游限流或不可用，且没有任何缓存可用 */
	unavailable: boolean;
	fetchedAt: number | null;
	/** 上游 HTTP 状态码；网络层直接失败时为 null。用于区分限流(429)和封禁(403) */
	upstreamStatus: number | null;
};

type CacheRow = typeof bin_cache.$inferSelect;

function rowToDetail(row: CacheRow): BinDetail {
	return {
		bin: row.bin,
		found: row.found === 1,
		scheme: row.scheme,
		brand: row.brand,
		cardType: row.card_type,
		prepaid: row.prepaid === null ? null : row.prepaid === 1,
		country:
			row.country_alpha2 || row.country_name
				? {
						alpha2: row.country_alpha2,
						name: row.country_name,
						emoji: row.country_emoji,
						currency: row.country_currency
					}
				: null,
		bank: row.bank_name
			? { name: row.bank_name, url: row.bank_url, phone: row.bank_phone, city: row.bank_city }
			: null
	};
}

function payloadToDetail(bin: string, payload: unknown): BinDetail {
	const raw = (payload ?? {}) as Record<string, unknown>;
	const rawCountry = (raw.country ?? {}) as Record<string, unknown>;
	const rawBank = (raw.bank ?? {}) as Record<string, unknown>;
	const str = (value: unknown) => (typeof value === 'string' && value.trim() ? value.trim() : null);

	const country = {
		alpha2: str(rawCountry.alpha2),
		name: str(rawCountry.name),
		emoji: str(rawCountry.emoji),
		currency: str(rawCountry.currency)
	};
	const bank = {
		name: str(rawBank.name),
		url: str(rawBank.url),
		phone: str(rawBank.phone),
		city: str(rawBank.city)
	};

	const scheme = str(raw.scheme);
	const brand = str(raw.brand);
	const cardType = str(raw.type);

	// binlist 查不到时并不总是返回 404，也可能是 200 + 一堆空对象。
	// 只要没有任何一个有意义的字段，就按「没查到」处理。
	const found = Boolean(scheme || brand || cardType || country.name || country.alpha2 || bank.name);

	return {
		bin,
		found,
		scheme,
		brand,
		cardType,
		prepaid: typeof raw.prepaid === 'boolean' ? raw.prepaid : null,
		country: country.name || country.alpha2 ? country : null,
		bank: bank.name ? bank : null
	};
}

async function readCache(db: D1Database, bin: string): Promise<CacheRow | null> {
	try {
		const rows = await getDb(db).select().from(bin_cache).where(eq(bin_cache.bin, bin)).limit(1);
		return rows[0] ?? null;
	} catch {
		// 迁移还没跑时不要让整个页面挂掉，退化成不带缓存的直连。
		return null;
	}
}

async function writeCache(db: D1Database, detail: BinDetail, fetchedAt: number) {
	const values = {
		bin: detail.bin,
		found: detail.found ? 1 : 0,
		scheme: detail.scheme,
		brand: detail.brand,
		card_type: detail.cardType,
		prepaid: detail.prepaid === null ? null : detail.prepaid ? 1 : 0,
		country_alpha2: detail.country?.alpha2 ?? null,
		country_name: detail.country?.name ?? null,
		country_emoji: detail.country?.emoji ?? null,
		country_currency: detail.country?.currency ?? null,
		bank_name: detail.bank?.name ?? null,
		bank_url: detail.bank?.url ?? null,
		bank_phone: detail.bank?.phone ?? null,
		bank_city: detail.bank?.city ?? null,
		fetched_at: fetchedAt
	};

	try {
		const { bin: _bin, ...updatable } = values;
		await getDb(db)
			.insert(bin_cache)
			.values(values)
			.onConflictDoUpdate({ target: bin_cache.bin, set: updatable });
	} catch {
		// 缓存写失败不影响本次返回结果。
	}
}

type FetchOutcome =
	| { kind: 'ok'; detail: BinDetail; status: number }
	| { kind: 'not-found'; status: number }
	| { kind: 'unavailable'; status: number | null };

async function fetchFromBinlist(bin: string): Promise<FetchOutcome> {
	try {
		const response = await fetch(`${BINLIST_ENDPOINT}/${bin}`, {
			headers: { 'Accept-Version': '3' },
			signal: AbortSignal.timeout(FETCH_TIMEOUT_MS)
		});

		if (response.status === 404) return { kind: 'not-found', status: 404 };
		if (!response.ok) return { kind: 'unavailable', status: response.status };

		return { kind: 'ok', detail: payloadToDetail(bin, await response.json()), status: 200 };
	} catch {
		// 超时或网络层直接失败，拿不到状态码
		return { kind: 'unavailable', status: null };
	}
}

/**
 * 查询单个 BIN。优先走 D1 缓存，缓存过期才打 binlist；
 * binlist 限流（429）时回退到过期缓存，实在没有才报不可用。
 */
export async function lookupBin(db: D1Database | undefined, bin: string): Promise<LookupResult> {
	const now = Math.floor(Date.now() / 1000);
	const cached = db ? await readCache(db, bin) : null;

	if (cached && now - cached.fetched_at < CACHE_TTL_SECONDS) {
		return {
			detail: rowToDetail(cached),
			source: 'cache',
			unavailable: false,
			fetchedAt: cached.fetched_at,
			upstreamStatus: null
		};
	}

	const fetched = await fetchFromBinlist(bin);

	if (fetched.kind === 'unavailable') {
		if (cached) {
			return {
				detail: rowToDetail(cached),
				source: 'stale',
				unavailable: false,
				fetchedAt: cached.fetched_at,
				upstreamStatus: fetched.status
			};
		}
		return {
			detail: null,
			source: 'none',
			unavailable: true,
			fetchedAt: null,
			upstreamStatus: fetched.status
		};
	}

	const detail: BinDetail =
		fetched.kind === 'not-found'
			? {
					bin,
					found: false,
					scheme: null,
					brand: null,
					cardType: null,
					prepaid: null,
					country: null,
					bank: null
				}
			: fetched.detail;

	if (db) await writeCache(db, detail, now);

	return {
		detail,
		source: 'live',
		unavailable: false,
		fetchedAt: now,
		upstreamStatus: fetched.status
	};
}
