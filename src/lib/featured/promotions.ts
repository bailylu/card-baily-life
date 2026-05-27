import { asc, eq } from 'drizzle-orm';
import { getDb } from '$lib/db/client';
import { featured_promotions } from '$lib/db/schema';

export type FeaturedPromotion = {
	id: string;
	bank: string;
	partner: string;
	name: string;
	description: string;
	image: string;
	alt: string;
	href: string;
	metrics: Array<{ label: string; value: string }>;
	sortOrder: number;
	enabled: boolean;
};

export const defaultFeaturedPromotions: FeaturedPromotion[] = [
	{
		id: 'citic-marriott',
		bank: '中信银行',
		partner: 'Marriott Bonvoy',
		name: '万豪旅享家精逸白金卡',
		description:
			'新户 60 天内计积分消费满 30,000 元，可拿 30,000 点万豪积分；叠加消费积分和渠道福利，首年回血空间高于刚性年费。',
		image: '/images/cards/citic-marriott-bonvoy.webp',
		alt: '中信银行万豪联名信用卡',
		href: '/refer/citic-marriott',
		metrics: [
			{ label: '限时奖励', value: '最高 33,000 点' },
			{ label: '渠道福利', value: '200 元京东 E 卡' },
			{ label: '持有权益', value: '房券 / 金卡 / 10 晚' }
		],
		sortOrder: 10,
		enabled: true
	},
	{
		id: 'citic-safari',
		bank: '中信银行',
		partner: 'American Express',
		name: 'Safari 联名信用卡',
		description:
			'模拟第二张推荐卡：适合关注旅行、餐饮和日常返利的人群。后续可由后台发布活动，替换成真实申请亮点和权益说明。',
		image: '/images/cards/citic-safari-card-cropped.webp',
		alt: '中信银行 Safari 信用卡',
		href: '/refer/citic-safari',
		metrics: [
			{ label: '推荐场景', value: '旅行 / 餐饮' },
			{ label: '活动状态', value: '模拟展示' },
			{ label: '后续接入', value: '后台发布' }
		],
		sortOrder: 20,
		enabled: true
	},
	{
		id: 'citic-airlines',
		bank: '中信银行',
		partner: '航空里程组合',
		name: '中信5大航司联名信用卡',
		description: '东航、厦航、川航、南航、海航和深航首年年费减免。',
		image: '/images/cards/citic-airlines-123-horizontal.png',
		alt: '中信银行5大航司联名信用卡',
		href: '/refer/citic-airlines',
		metrics: [
			{ label: '覆盖航司', value: '东航 / 厦航 / 川航' },
			{ label: '更多选择', value: '南航 / 海航 / 深航' },
			{ label: '推荐逻辑', value: '按航线和里程选' }
		],
		sortOrder: 30,
		enabled: true
	}
];

type PromotionRow = typeof featured_promotions.$inferSelect;

export function promotionFromRow(row: PromotionRow): FeaturedPromotion {
	return {
		id: row.id,
		bank: row.bank,
		partner: row.partner,
		name: row.name,
		description: row.description,
		image: row.image_url,
		alt: row.alt,
		href: row.href,
		metrics: [
			{ label: row.metric_1_label, value: row.metric_1_value },
			{ label: row.metric_2_label, value: row.metric_2_value },
			{ label: row.metric_3_label, value: row.metric_3_value }
		],
		sortOrder: row.sort_order,
		enabled: row.enabled === 1
	};
}

export async function listFeaturedPromotions(db: D1Database, options: { includeDisabled?: boolean } = {}) {
	const rows = await getDb(db).select().from(featured_promotions).orderBy(asc(featured_promotions.sort_order));
	const promotions = rows
		.map(promotionFromRow)
		.filter((promotion) => options.includeDisabled || promotion.enabled);
	return promotions.length > 0 || options.includeDisabled ? promotions : defaultFeaturedPromotions;
}

export async function deleteFeaturedPromotion(db: D1Database, id: string) {
	await getDb(db).delete(featured_promotions).where(eq(featured_promotions.id, id));
}
