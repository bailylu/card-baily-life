import { eq } from 'drizzle-orm';
import { getDb } from '$lib/db/client';
import { notification_channels, notification_preferences } from '$lib/db/schema';

export type NotificationSettings = {
	barkKey: string;
	telegramBotToken: string;
	telegramChatId: string;
	pushPlusToken: string;
	statementEnabled: boolean;
	dueEnabled: boolean;
	annualFeeEnabled: boolean;
	offerEnabled: boolean;
};

export const emptyNotificationSettings: NotificationSettings = {
	barkKey: '',
	telegramBotToken: '',
	telegramChatId: '',
	pushPlusToken: '',
	statementEnabled: true,
	dueEnabled: true,
	annualFeeEnabled: true,
	offerEnabled: false
};

function readConfig(config: string) {
	try {
		const parsed = JSON.parse(config);
		return parsed && typeof parsed === 'object' ? (parsed as Record<string, unknown>) : {};
	} catch {
		return {};
	}
}

export async function getNotificationSettings(db: D1Database, userId: string) {
	const drizzle = getDb(db);
	const rows = await drizzle
		.select()
		.from(notification_channels)
		.where(eq(notification_channels.user_id, userId));
	const preferenceRows = await drizzle
		.select()
		.from(notification_preferences)
		.where(eq(notification_preferences.user_id, userId))
		.limit(1);

	const settings = { ...emptyNotificationSettings };
	const preferences = preferenceRows[0];

	if (preferences) {
		settings.statementEnabled = preferences.statement_enabled !== 0;
		settings.dueEnabled = preferences.due_enabled !== 0;
		settings.annualFeeEnabled = preferences.annual_fee_enabled !== 0;
		settings.offerEnabled = preferences.offer_enabled !== 0;
	}

	for (const row of rows) {
		const config = readConfig(row.config);
		if (row.type === 'bark' && typeof config.key === 'string') settings.barkKey = config.key;
		if (row.type === 'telegram') {
			if (typeof config.botToken === 'string') settings.telegramBotToken = config.botToken;
			if (typeof config.chatId === 'string') settings.telegramChatId = config.chatId;
		}
		if (row.type === 'pushplus' && typeof config.token === 'string') settings.pushPlusToken = config.token;
	}

	return settings;
}

export async function saveNotificationSettings(
	db: D1Database,
	userId: string,
	settings: NotificationSettings
) {
	const drizzle = getDb(db);
	const now = Math.floor(Date.now() / 1000);

	await drizzle.delete(notification_channels).where(eq(notification_channels.user_id, userId));
	await drizzle
		.insert(notification_preferences)
		.values({
			user_id: userId,
			statement_enabled: settings.statementEnabled ? 1 : 0,
			due_enabled: settings.dueEnabled ? 1 : 0,
			annual_fee_enabled: settings.annualFeeEnabled ? 1 : 0,
			offer_enabled: settings.offerEnabled ? 1 : 0,
			updated_at: now
		})
		.onConflictDoUpdate({
			target: notification_preferences.user_id,
			set: {
				statement_enabled: settings.statementEnabled ? 1 : 0,
				due_enabled: settings.dueEnabled ? 1 : 0,
				annual_fee_enabled: settings.annualFeeEnabled ? 1 : 0,
				offer_enabled: settings.offerEnabled ? 1 : 0,
				updated_at: now
			}
		});

	const values = [];
	if (settings.barkKey) {
		values.push({
			id: crypto.randomUUID(),
			user_id: userId,
			type: 'bark',
			config: JSON.stringify({ key: settings.barkKey }),
			enabled: 1,
			created_at: now
		});
	}
	if (settings.telegramBotToken || settings.telegramChatId) {
		values.push({
			id: crypto.randomUUID(),
			user_id: userId,
			type: 'telegram',
			config: JSON.stringify({
				botToken: settings.telegramBotToken,
				chatId: settings.telegramChatId
			}),
			enabled: 1,
			created_at: now
		});
	}
	if (settings.pushPlusToken) {
		values.push({
			id: crypto.randomUUID(),
			user_id: userId,
			type: 'pushplus',
			config: JSON.stringify({ token: settings.pushPlusToken }),
			enabled: 1,
			created_at: now
		});
	}

	if (values.length > 0) await drizzle.insert(notification_channels).values(values);
}

export function settingsFromForm(formData: FormData): NotificationSettings {
	const enabled = (name: string) => formData.getAll(name).includes('1');

	return {
		barkKey: String(formData.get('barkKey') ?? '').trim(),
		telegramBotToken: String(formData.get('telegramBotToken') ?? '').trim(),
		telegramChatId: String(formData.get('telegramChatId') ?? '').trim(),
		pushPlusToken: String(formData.get('pushPlusToken') ?? '').trim(),
		statementEnabled: enabled('statementEnabled'),
		dueEnabled: enabled('dueEnabled'),
		annualFeeEnabled: enabled('annualFeeEnabled'),
		offerEnabled: enabled('offerEnabled')
	};
}
