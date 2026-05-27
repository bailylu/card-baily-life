import { getReminderPreview, type ReminderPreview, type ReminderType } from '../cards/reminders.ts';
import type { NotificationSettings } from './settings.ts';

type Fetcher = typeof fetch;

type DispatchOptions = {
	today?: Date;
	dryRun?: boolean;
	fetcher?: Fetcher;
};

type DispatchSummary = {
	checkedUsers: number;
	dueReminders: number;
	skippedByPreference: number;
	sent: number;
	duplicates: number;
	errors: string[];
};

type UserCardRow = {
	id: string;
	user_id: string;
	custom_name: string | null;
	last_four: string;
	statement_day: number;
	due_day: number;
	annual_fee_month: number | null;
	annual_fee_day: number | null;
	lead_days: number;
	bank_name: string | null;
	card_name: string | null;
	remind_statement: number;
	remind_due: number;
	remind_annual_fee: number;
};

const TYPE_TITLES: Record<ReminderType, string> = {
	statement: '账单日提醒',
	due: '还款日提醒',
	annual_fee: '年费日提醒'
};

function getReminderDisplayName(card: {
	bank_name: string | null;
	card_name: string | null;
	custom_name: string | null;
}) {
	return card.custom_name || [card.bank_name, card.card_name].filter(Boolean).join(' ') || '自定义信用卡';
}

function getReminderCatalogName(card: { bank_name: string | null; card_name: string | null }) {
	return [card.bank_name, card.card_name].filter(Boolean).join(' ') || null;
}

export function isReminderTypeEnabled(type: ReminderType, settings: NotificationSettings) {
	if (type === 'statement') return settings.statementEnabled;
	if (type === 'due') return settings.dueEnabled;
	return settings.annualFeeEnabled;
}

export function filterReminderPreviewsBySettings<T extends Pick<ReminderPreview, 'type'>>(
	previews: T[],
	settings: NotificationSettings
) {
	return previews.filter((preview) => isReminderTypeEnabled(preview.type, settings));
}

function normalizeBarkKey(input: string) {
	const value = input.trim();
	if (!value) return '';
	if (!/^https?:\/\//i.test(value)) return value;

	try {
		const url = new URL(value);
		return url.pathname.split('/').filter(Boolean)[0] ?? value;
	} catch {
		return value;
	}
}

function buildReminderText(reminder: ReminderPreview) {
	const name = reminder.catalogName ?? reminder.cardName;
	return `${name}（尾号 ${reminder.lastFour}）${reminder.typeLabel} 是 ${reminder.targetDate}，请及时确认。`;
}

async function sendBarkReminder(fetcher: Fetcher, key: string, reminder: ReminderPreview) {
	const barkKey = normalizeBarkKey(key);
	const title = `贝利卡管家：${TYPE_TITLES[reminder.type]}`;
	const content = buildReminderText(reminder);
	const url = `https://api.day.app/${encodeURIComponent(barkKey)}/${encodeURIComponent(title)}/${encodeURIComponent(content)}`;
	const response = await fetcher(url);
	const result = await response.json().catch(() => null) as { code?: number; message?: string } | null;
	if (!response.ok || (typeof result?.code === 'number' && result.code !== 200)) {
		throw new Error(result?.message ? `Bark ${reminder.typeLabel}发送失败：${result.message}` : `Bark ${reminder.typeLabel}发送失败`);
	}
}

async function sendPushPlusReminder(fetcher: Fetcher, token: string, reminder: ReminderPreview) {
	const response = await fetcher('https://www.pushplus.plus/send', {
		method: 'POST',
		headers: { 'content-type': 'application/json' },
		body: JSON.stringify({
			token,
			title: `贝利卡管家：${TYPE_TITLES[reminder.type]}`,
			content: buildReminderText(reminder),
			template: 'txt'
		})
	});

	const result = await response.json().catch(() => null) as { code?: number; msg?: string } | null;
	if (!response.ok || result?.code !== 200) {
		throw new Error(result?.msg ? `PushPlus ${reminder.typeLabel}发送失败：${result.msg}` : `PushPlus ${reminder.typeLabel}发送失败`);
	}
}

function groupCardsByUser(rows: UserCardRow[]) {
	const grouped = new Map<string, UserCardRow[]>();
	for (const row of rows) {
		const userRows = grouped.get(row.user_id) ?? [];
		userRows.push(row);
		grouped.set(row.user_id, userRows);
	}
	return grouped;
}

async function wasAlreadySent(db: D1Database, reminder: ReminderPreview, channel: string) {
	const row = await db
		.prepare(
			`SELECT id FROM reminder_sent
			 WHERE user_card_id = ? AND reminder_type = ? AND target_date = ? AND channel = ?
			 LIMIT 1`
		)
		.bind(reminder.cardId, reminder.type, reminder.targetDate, channel)
		.first();
	return !!row;
}

async function markSent(db: D1Database, reminder: ReminderPreview, channel: string) {
	await db
		.prepare(
			`INSERT OR IGNORE INTO reminder_sent (user_card_id, reminder_type, target_date, channel, sent_at)
			 VALUES (?, ?, ?, ?, ?)`
		)
		.bind(reminder.cardId, reminder.type, reminder.targetDate, channel, Math.floor(Date.now() / 1000))
		.run();
}

export async function dispatchDueReminders(db: D1Database, options: DispatchOptions = {}): Promise<DispatchSummary> {
	const { getNotificationSettings } = await import('./settings.ts');
	const today = options.today ?? new Date();
	const fetcher = options.fetcher ?? fetch;
	const summary: DispatchSummary = {
		checkedUsers: 0,
		dueReminders: 0,
		skippedByPreference: 0,
		sent: 0,
		duplicates: 0,
		errors: []
	};

	const { results } = await db
		.prepare(
			`SELECT
				user_cards.id,
				user_cards.user_id,
				user_cards.custom_name,
				user_cards.last_four,
				user_cards.statement_day,
				user_cards.due_day,
				user_cards.annual_fee_month,
				user_cards.annual_fee_day,
				user_cards.lead_days,
				user_cards.remind_statement,
				user_cards.remind_due,
				user_cards.remind_annual_fee,
				card_catalog.bank_name,
				card_catalog.card_name
			FROM user_cards
			LEFT JOIN card_catalog ON user_cards.catalog_id = card_catalog.id`
		)
		.all<UserCardRow>();

	const users = groupCardsByUser(results ?? []);
	summary.checkedUsers = users.size;

	for (const [userId, cards] of users) {
		const settings = await getNotificationSettings(db, userId);
		const previews = getReminderPreview(
			cards.map((card) => ({
				id: card.id,
				displayName: getReminderDisplayName(card),
				catalogName: getReminderCatalogName(card),
				last_four: card.last_four,
				statement_day: card.statement_day,
				due_day: card.due_day,
				annual_fee_month: card.annual_fee_month,
				annual_fee_day: card.annual_fee_day,
				lead_days: card.lead_days,
				bank_name: card.bank_name,
				remind_statement: card.remind_statement !== 0,
				remind_due: card.remind_due !== 0,
				remind_annual_fee: card.remind_annual_fee !== 0
			})),
			today,
			31
		).filter((preview) => preview.daysUntilRemind === 0);

		summary.dueReminders += previews.length;
		const enabledPreviews = filterReminderPreviewsBySettings(previews, settings);
		summary.skippedByPreference += previews.length - enabledPreviews.length;

		const channels: string[] = [];
		if (settings.barkKey) channels.push('bark');
		if (settings.pushPlusToken) channels.push('pushplus');

		if (channels.length === 0) continue;

		for (const reminder of enabledPreviews) {
			for (const channel of channels) {
				if (await wasAlreadySent(db, reminder, channel)) {
					summary.duplicates += 1;
					continue;
				}

				if (!options.dryRun) {
					try {
						if (channel === 'bark') await sendBarkReminder(fetcher, settings.barkKey, reminder);
						if (channel === 'pushplus') await sendPushPlusReminder(fetcher, settings.pushPlusToken, reminder);
						await markSent(db, reminder, channel);
					} catch (error) {
						summary.errors.push(error instanceof Error ? error.message : `${channel} 发送失败`);
						continue;
					}
				}
				summary.sent += 1;
			}
		}
	}

	return summary;
}
