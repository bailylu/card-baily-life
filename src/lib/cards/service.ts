import { and, asc, eq } from 'drizzle-orm';
import { getDb } from '$lib/db/client';
import { card_catalog, user_cards, users } from '$lib/db/schema';
import { parseCardForm, type CardFormValues } from './form';
import { getReminderPreview } from './reminders';

export const OPEN_TEST_USER_ID = 'open-test-user';
const OPEN_TEST_EMAIL = 'open-test@card.baily.life';

type CardStyle = {
	label: string;
	gradient: string;
	accent: string;
	text: string;
};

const DEFAULT_STYLE: CardStyle = {
	label: '标准卡',
	gradient: 'linear-gradient(135deg, #334155 0%, #0f172a 100%)',
	accent: 'rgba(255, 255, 255, 0.18)',
	text: '#ffffff'
};

const BANK_STYLES: Record<string, CardStyle> = {
	招商银行: {
		label: '红金卡',
		gradient: 'linear-gradient(135deg, #ef4444 0%, #7f1d1d 55%, #f59e0b 100%)',
		accent: 'rgba(253, 186, 116, 0.28)',
		text: '#fff7ed'
	},
	建设银行: {
		label: '蓝白金',
		gradient: 'linear-gradient(135deg, #2563eb 0%, #0f172a 72%)',
		accent: 'rgba(147, 197, 253, 0.32)',
		text: '#eff6ff'
	},
	中信银行: {
		label: '黑金卡',
		gradient: 'linear-gradient(135deg, #111827 0%, #000000 58%, #ca8a04 100%)',
		accent: 'rgba(250, 204, 21, 0.28)',
		text: '#fefce8'
	},
	交通银行: {
		label: '商务蓝',
		gradient: 'linear-gradient(135deg, #0369a1 0%, #172554 100%)',
		accent: 'rgba(125, 211, 252, 0.28)',
		text: '#f0f9ff'
	},
	浦发银行: {
		label: '紫色联名',
		gradient: 'linear-gradient(135deg, #7c3aed 0%, #3b0764 100%)',
		accent: 'rgba(216, 180, 254, 0.3)',
		text: '#faf5ff'
	},
	光大银行: {
		label: '阳光橙',
		gradient: 'linear-gradient(135deg, #f97316 0%, #7c2d12 100%)',
		accent: 'rgba(254, 215, 170, 0.3)',
		text: '#fff7ed'
	},
	平安银行: {
		label: '绿色生活',
		gradient: 'linear-gradient(135deg, #16a34a 0%, #14532d 100%)',
		accent: 'rgba(187, 247, 208, 0.28)',
		text: '#f0fdf4'
	},
	工商银行: {
		label: '经典红',
		gradient: 'linear-gradient(135deg, #dc2626 0%, #450a0a 100%)',
		accent: 'rgba(254, 202, 202, 0.26)',
		text: '#fef2f2'
	},
	农业银行: {
		label: '翡翠绿',
		gradient: 'linear-gradient(135deg, #059669 0%, #064e3b 100%)',
		accent: 'rgba(167, 243, 208, 0.28)',
		text: '#ecfdf5'
	},
	广发银行: {
		label: '活力银',
		gradient: 'linear-gradient(135deg, #64748b 0%, #111827 58%, #38bdf8 100%)',
		accent: 'rgba(226, 232, 240, 0.28)',
		text: '#f8fafc'
	}
};

export type DashboardCard = {
	id: string;
	catalog_id: number | null;
	custom_name: string | null;
	last_four: string;
	statement_day: number;
	due_day: number;
	annual_fee_month: number | null;
	annual_fee_day: number | null;
	lead_days: number;
	bank_name: string | null;
	card_name: string | null;
	card_tier: string | null;
	displayName: string;
	cardStyle: CardStyle;
	isDemo: boolean;
};

export function getDisplayName(card: {
	bank_name: string | null;
	card_name: string | null;
	custom_name: string | null;
}) {
	return card.custom_name || [card.bank_name, card.card_name].filter(Boolean).join(' ') || '自定义信用卡';
}

export function getCardStyle(bankName: string | null, cardTier: string | null): CardStyle {
	if (cardTier?.includes('白金') && !bankName) {
		return {
			label: '白金卡',
			gradient: 'linear-gradient(135deg, #f8fafc 0%, #94a3b8 48%, #1e293b 100%)',
			accent: 'rgba(15, 23, 42, 0.16)',
			text: '#0f172a'
		};
	}

	if (!bankName) return DEFAULT_STYLE;
	return BANK_STYLES[bankName] ?? DEFAULT_STYLE;
}

export async function ensureCurrentUserId(db: D1Database, userId?: string | null) {
	if (userId) return userId;

	const drizzle = getDb(db);
	const now = Math.floor(Date.now() / 1000);
	await drizzle
		.insert(users)
		.values({
			id: OPEN_TEST_USER_ID,
			email: OPEN_TEST_EMAIL,
			created_at: now,
			last_login_at: now
		})
		.onConflictDoNothing();
	return OPEN_TEST_USER_ID;
}

export async function listCatalog(db: D1Database) {
	const rows = await getDb(db)
		.select()
		.from(card_catalog)
		.where(eq(card_catalog.country, 'CN'))
		.orderBy(asc(card_catalog.bank_name), asc(card_catalog.card_name));

	return rows.map((card) => ({
		...card,
		cardStyle: getCardStyle(card.bank_name, card.card_tier)
	}));
}

export async function listUserCards(db: D1Database, userId: string) {
	const drizzle = getDb(db);
	const rows = await drizzle
		.select({
			id: user_cards.id,
			catalog_id: user_cards.catalog_id,
			custom_name: user_cards.custom_name,
			last_four: user_cards.last_four,
			statement_day: user_cards.statement_day,
			due_day: user_cards.due_day,
			annual_fee_month: user_cards.annual_fee_month,
			annual_fee_day: user_cards.annual_fee_day,
			lead_days: user_cards.lead_days,
			bank_name: card_catalog.bank_name,
			card_name: card_catalog.card_name,
			card_tier: card_catalog.card_tier
		})
		.from(user_cards)
		.leftJoin(card_catalog, eq(user_cards.catalog_id, card_catalog.id))
		.where(eq(user_cards.user_id, userId))
		.orderBy(asc(user_cards.created_at));

	return rows.map((card) => ({
		...card,
		displayName: getDisplayName(card),
		cardStyle: getCardStyle(card.bank_name, card.card_tier),
		isDemo: false
	}));
}

export function getDemoDashboardCards(): DashboardCard[] {
	const cards = [
		{
			id: 'demo-cmb-platinum',
			bank_name: '招商银行',
			card_name: '经典白金信用卡',
			card_tier: '白金',
			last_four: '0318',
			statement_day: 5,
			due_day: 23,
			annual_fee_month: 3,
			annual_fee_day: 18,
			lead_days: 3
		},
		{
			id: 'demo-ccb-global',
			bank_name: '建设银行',
			card_name: '龙卡全球支付信用卡',
			card_tier: '白金',
			last_four: '9527',
			statement_day: 12,
			due_day: 30,
			annual_fee_month: null,
			annual_fee_day: null,
			lead_days: 5
		},
		{
			id: 'demo-spdb-amex',
			bank_name: '浦发银行',
			card_name: '美国运通白金信用卡',
			card_tier: '白金',
			last_four: '8888',
			statement_day: 20,
			due_day: 8,
			annual_fee_month: 8,
			annual_fee_day: 8,
			lead_days: 7
		},
		{
			id: 'demo-custom-green',
			bank_name: null,
			card_name: null,
			card_tier: '自定义',
			custom_name: '测试绿色生活卡',
			last_four: '6666',
			statement_day: 28,
			due_day: 15,
			annual_fee_month: 12,
			annual_fee_day: 31,
			lead_days: 3
		}
	];

	return cards.map((card) => ({
		...card,
		catalog_id: null,
		custom_name: 'custom_name' in card ? (card.custom_name ?? null) : null,
		displayName: getDisplayName({
			bank_name: card.bank_name,
			card_name: card.card_name,
			custom_name: 'custom_name' in card ? (card.custom_name ?? null) : null
		}),
		cardStyle:
			card.id === 'demo-custom-green'
				? BANK_STYLES['平安银行']
				: getCardStyle(card.bank_name, card.card_tier),
		isDemo: true
	}));
}

export async function getUserCard(db: D1Database, userId: string, cardId: string) {
	const rows = await getDb(db)
		.select()
		.from(user_cards)
		.where(and(eq(user_cards.user_id, userId), eq(user_cards.id, cardId)))
		.limit(1);
	return rows[0] ?? null;
}

export async function createUserCard(db: D1Database, userId: string, values: CardFormValues) {
	const now = Math.floor(Date.now() / 1000);
	await getDb(db).insert(user_cards).values({
		id: crypto.randomUUID(),
		user_id: userId,
		catalog_id: values.catalogId,
		custom_name: values.customName,
		last_four: values.lastFour,
		statement_day: values.statementDay,
		due_day: values.dueDay,
		annual_fee_month: values.annualFeeMonth,
		annual_fee_day: values.annualFeeDay,
		lead_days: values.leadDays,
		created_at: now
	});
}

export async function updateUserCard(
	db: D1Database,
	userId: string,
	cardId: string,
	values: CardFormValues
) {
	await getDb(db)
		.update(user_cards)
		.set({
			catalog_id: values.catalogId,
			custom_name: values.customName,
			last_four: values.lastFour,
			statement_day: values.statementDay,
			due_day: values.dueDay,
			annual_fee_month: values.annualFeeMonth,
			annual_fee_day: values.annualFeeDay,
			lead_days: values.leadDays
		})
		.where(and(eq(user_cards.user_id, userId), eq(user_cards.id, cardId)));
}

export async function deleteUserCard(db: D1Database, userId: string, cardId: string) {
	await getDb(db)
		.delete(user_cards)
		.where(and(eq(user_cards.user_id, userId), eq(user_cards.id, cardId)));
}

export function buildReminderPreview(cards: DashboardCard[]) {
	return getReminderPreview(
		cards.map((card) => ({
			id: card.id,
			displayName: card.displayName,
			last_four: card.last_four,
			statement_day: card.statement_day,
			due_day: card.due_day,
			annual_fee_month: card.annual_fee_month,
			annual_fee_day: card.annual_fee_day,
			lead_days: card.lead_days
		}))
	);
}

export { parseCardForm, type CardFormValues };
