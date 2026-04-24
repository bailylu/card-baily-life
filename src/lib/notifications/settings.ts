import { eq } from 'drizzle-orm';
import { getDb } from '$lib/db/client';
import { notification_channels } from '$lib/db/schema';

export type NotificationSettings = {
	barkKey: string;
	telegramBotToken: string;
	telegramChatId: string;
	pushPlusToken: string;
};

export const emptyNotificationSettings: NotificationSettings = {
	barkKey: '',
	telegramBotToken: '',
	telegramChatId: '',
	pushPlusToken: ''
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
	const rows = await getDb(db)
		.select()
		.from(notification_channels)
		.where(eq(notification_channels.user_id, userId));

	const settings = { ...emptyNotificationSettings };

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
	return {
		barkKey: String(formData.get('barkKey') ?? '').trim(),
		telegramBotToken: String(formData.get('telegramBotToken') ?? '').trim(),
		telegramChatId: String(formData.get('telegramChatId') ?? '').trim(),
		pushPlusToken: String(formData.get('pushPlusToken') ?? '').trim()
	};
}
