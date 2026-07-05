import { isAdmin } from '$lib/admin/access';
import { getDb } from '$lib/db/client';
import { card_catalog } from '$lib/db/schema';
import { callMiniMaxJson } from '$lib/server/minimax';
import { json, type RequestHandler } from '@sveltejs/kit';
import { asc } from 'drizzle-orm';

const COUNTRY_LABELS: Record<string, string> = {
	CN: '中国大陆',
	HK: '中国香港',
	TW: '中国台湾',
	JP: '日本',
	US: '美国'
};
const CARD_TYPES = new Set(['信用卡', '借记卡', '其它']);

type ExistingCard = {
	id: number;
	country: string | null;
	bank_name: string;
	card_name: string;
	card_tier: string | null;
	network: string | null;
	tags: string | null;
};

type AiFill = {
	country: string;
	card_type: string;
	bank_name: string;
	card_name: string;
	card_tier: string;
	networks: string[];
	tags: string[];
	notes: string;
	duplicate_candidates: Array<{ id: number; bank_name: string; card_name: string; reason: string }>;
};

function stringifyOptions(cards: ExistingCard[]) {
	const countries = Object.entries(COUNTRY_LABELS).map(([code, label]) => `${code}:${label}`).join(', ');
	const banks = [...new Set(cards.map((card) => `${card.country ?? 'CN'}:${card.bank_name}`))].slice(0, 160).join(', ');
	const tiers = [...new Set(cards.map((card) => card.card_tier).filter(Boolean))].join(', ') || '普卡, 金卡, 白金';
	const networks = [
		...new Set(
			cards
				.map((card) => card.network)
				.flatMap((value) => (value ?? '').split(/[/,，、]+/).map((item) => item.trim()))
				.filter(Boolean)
		)
	].join(', ') || '银联, Visa, Mastercard, American Express, JCB';
	return { countries, banks, tiers, networks };
}

function arrayFrom(value: unknown) {
	if (Array.isArray(value)) return value.map((item) => String(item).trim()).filter(Boolean);
	if (typeof value === 'string') return value.split(/[,，、/]+/).map((item) => item.trim()).filter(Boolean);
	return [];
}

function sanitizeFill(value: Partial<AiFill>, cards: ExistingCard[]): AiFill {
	const country = value.country && COUNTRY_LABELS[value.country] ? value.country : 'CN';
	const cardType = value.card_type && CARD_TYPES.has(value.card_type) ? value.card_type : '信用卡';
	const bankName = String(value.bank_name ?? '').trim().slice(0, 80);
	const cardName = String(value.card_name ?? '').trim().slice(0, 80);
	const cardTier = String(value.card_tier ?? '').trim().slice(0, 40);
	const networks = arrayFrom(value.networks).slice(0, 5);
	const tags = arrayFrom(value.tags).filter((tag) => !CARD_TYPES.has(tag)).slice(0, 8);
	const notes = String(value.notes ?? '').trim().slice(0, 240);

	const duplicateCandidates = (value.duplicate_candidates ?? [])
		.map((item) => {
			const id = Number(item?.id);
			const matched = cards.find((card) => card.id === id);
			return matched
				? {
						id: matched.id,
						bank_name: matched.bank_name,
						card_name: matched.card_name,
						reason: String(item?.reason ?? '名称相近').slice(0, 80)
					}
				: null;
		})
		.filter((item): item is AiFill['duplicate_candidates'][number] => !!item)
		.slice(0, 5);

	return {
		country,
		card_type: cardType,
		bank_name: bankName,
		card_name: cardName,
		card_tier: cardTier,
		networks,
		tags,
		notes,
		duplicate_candidates: duplicateCandidates
	};
}

export const POST: RequestHandler = async ({ request, locals, platform }) => {
	if (!locals.user) return json({ error: '请先登录' }, { status: 401 });
	if (!isAdmin(locals.user, platform?.env)) return json({ error: '没有权限' }, { status: 403 });

	if (!platform?.env.DB) return json({ error: '当前环境没有数据库绑定' }, { status: 503 });

	const body = (await request.json().catch(() => null)) as { query?: string } | null;
	const query = String(body?.query ?? '').trim();
	if (!query) return json({ error: '请输入卡片名称' }, { status: 400 });
	if (query.length > 120) return json({ error: '卡片名称太长了' }, { status: 400 });

	const cards = await getDb(platform.env.DB)
		.select({
			id: card_catalog.id,
			country: card_catalog.country,
			bank_name: card_catalog.bank_name,
			card_name: card_catalog.card_name,
			card_tier: card_catalog.card_tier,
			network: card_catalog.network,
			tags: card_catalog.tags
		})
		.from(card_catalog)
		.orderBy(asc(card_catalog.bank_name), asc(card_catalog.card_name));

	const options = stringifyOptions(cards);

	try {
		const parsed = await callMiniMaxJson<Partial<AiFill>>(platform, [
				{
					role: 'system',
					content:
						'你是信用卡卡库后台的数据录入助手。只返回 JSON，不要解释，不要 Markdown。字段必须是：country, card_type, bank_name, card_name, card_tier, networks, tags, notes, duplicate_candidates。country 只能用 CN/HK/TW/JP/US；card_type 只能用 信用卡/借记卡/其它。duplicate_candidates 只允许引用用户提供的现有卡 id。'
				},
				{
					role: 'user',
					content: [
						`用户输入：${query}`,
						`可用地区：${options.countries}`,
						`已有银行按地区：${options.banks}`,
						`已有等级参考：${options.tiers}`,
						`已有卡组织参考：${options.networks}`,
						`现有卡片：${cards
							.slice(0, 220)
							.map((card) => `#${card.id} ${card.country ?? 'CN'} ${card.bank_name} ${card.card_name}`)
							.join('；')}`,
						'请推断最适合的录入字段。tags 放权益或分类词，例如 里程、酒店、返现、高端权益、航司、商旅。notes 用一句后台备注。'
					].join('\n')
				}
		]);
		return json({ fill: sanitizeFill(parsed, cards) });
	} catch (error) {
		return json({ error: error instanceof Error ? error.message : 'AI 识别失败' }, { status: 502 });
	}
};
