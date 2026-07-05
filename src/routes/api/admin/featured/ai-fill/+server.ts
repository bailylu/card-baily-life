import { isAdmin } from '$lib/admin/access';
import { getDb } from '$lib/db/client';
import { featured_promotions } from '$lib/db/schema';
import { callMiniMaxJson } from '$lib/server/minimax';
import { json, type RequestHandler } from '@sveltejs/kit';
import { asc } from 'drizzle-orm';

type ExistingPromotion = {
	id: string;
	bank: string;
	name: string;
	description: string;
	metric_1_value: string;
	href: string;
};

type FeaturedFill = {
	bank: string;
	name: string;
	description: string;
	expected_yield: string;
	href: string;
	image_hint: string;
	duplicate_candidates: Array<{ id: string; name: string; reason: string }>;
};

function slugify(input: string) {
	return input
		.trim()
		.toLowerCase()
		.normalize('NFKD')
		.replace(/[^\p{Letter}\p{Number}]+/gu, '-')
		.replace(/^-+|-+$/g, '')
		.slice(0, 80);
}

function sanitizeFill(value: Partial<FeaturedFill>, promotions: ExistingPromotion[], query: string): FeaturedFill {
	const name = String(value.name ?? query).trim().slice(0, 80);
	const fallbackId = slugify(name) || slugify(query) || 'card';
	const href = String(value.href ?? '').trim().slice(0, 240) || `/refer/${fallbackId}`;
	const duplicateCandidates = (value.duplicate_candidates ?? [])
		.map((item) => {
			const id = String(item?.id ?? '').trim();
			const matched = promotions.find((promotion) => promotion.id === id);
			return matched
				? {
						id: matched.id,
						name: matched.name,
						reason: String(item?.reason ?? '名称或活动相近').slice(0, 80)
					}
				: null;
		})
		.filter((item): item is FeaturedFill['duplicate_candidates'][number] => !!item)
		.slice(0, 5);

	return {
		bank: String(value.bank ?? '首页推荐').trim().slice(0, 80) || '首页推荐',
		name,
		description: String(value.description ?? '').trim().slice(0, 260),
		expected_yield: String(value.expected_yield ?? '').trim().slice(0, 40) || '待补充',
		href,
		image_hint: String(value.image_hint ?? '').trim().slice(0, 120),
		duplicate_candidates: duplicateCandidates
	};
}

export const POST: RequestHandler = async ({ request, locals, platform }) => {
	if (!locals.user) return json({ error: '请先登录' }, { status: 401 });
	if (!isAdmin(locals.user, platform?.env)) return json({ error: '没有权限' }, { status: 403 });
	if (!platform?.env.DB) return json({ error: '当前环境没有数据库绑定' }, { status: 503 });

	const body = (await request.json().catch(() => null)) as { query?: string } | null;
	const query = String(body?.query ?? '').trim();
	if (!query) return json({ error: '请输入卡片或活动名称' }, { status: 400 });
	if (query.length > 160) return json({ error: '输入内容太长了' }, { status: 400 });

	const promotions = await getDb(platform.env.DB)
		.select({
			id: featured_promotions.id,
			bank: featured_promotions.bank,
			name: featured_promotions.name,
			description: featured_promotions.description,
			metric_1_value: featured_promotions.metric_1_value,
			href: featured_promotions.href
		})
		.from(featured_promotions)
		.orderBy(asc(featured_promotions.sort_order), asc(featured_promotions.name));

	try {
		const parsed = await callMiniMaxJson<Partial<FeaturedFill>>(platform, [
			{
				role: 'system',
				content:
					'你是信用卡首页推荐后台的数据录入助手。只返回 JSON，不要解释，不要 Markdown。字段必须是：bank, name, description, expected_yield, href, image_hint, duplicate_candidates。description 必须是一句话，适合首页推荐卡片。expected_yield 要短，例如：1500 元、免 2000 元年费、最高 30000 点。duplicate_candidates 只允许引用用户提供的现有推荐 id。'
			},
			{
				role: 'user',
				content: [
					`用户输入：${query}`,
					`现有首页推荐：${promotions
						.map((promotion) => `#${promotion.id} ${promotion.bank} ${promotion.name} 收益:${promotion.metric_1_value} 描述:${promotion.description}`)
						.join('；')}`,
					'请推断首页推荐表单字段。href 如果不确定，返回空字符串或 /refer/基于名称的短链接。image_hint 写建议使用哪类卡面或图片。'
				].join('\n')
			}
		]);

		return json({ fill: sanitizeFill(parsed, promotions, query) });
	} catch (error) {
		return json({ error: error instanceof Error ? error.message : 'AI 识别失败' }, { status: 502 });
	}
};
