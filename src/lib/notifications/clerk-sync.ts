import { eq } from 'drizzle-orm';
import { getDb } from '$lib/db/client';
import { users } from '$lib/db/schema';
import { saveNotificationChannels, type NotificationSettings } from './settings';

/** How long a mirrored copy of Clerk's notify config is trusted before we refresh it. */
const SYNC_INTERVAL_SECONDS = 5 * 60;

type ChannelConfig = Record<string, unknown>;

function asObject(value: unknown): ChannelConfig {
	return value && typeof value === 'object' ? (value as ChannelConfig) : {};
}

function asText(value: unknown) {
	return typeof value === 'string' ? value.trim() : '';
}

function channelIsEnabled(channel: ChannelConfig, requiredSecret: boolean) {
	if (!requiredSecret) return false;
	return channel.on !== false;
}

export type ClerkChannelSettings = Pick<
	NotificationSettings,
	'barkKey' | 'pushPlusToken' | 'telegramBotToken' | 'telegramChatId' | 'feishuWebhook' | 'dingtalkWebhook'
>;

/** Parses the `notify` block Clerk private metadata carries; null when nothing is configured there. */
export function notificationChannelsFromClerkMetadata(privateMetadata: unknown): ClerkChannelSettings | null {
	const notify = asObject(asObject(privateMetadata).notify);
	if (Object.keys(notify).length === 0) return null;

	const bark = asObject(notify.bark);
	const pushplus = asObject(notify.pushplus);
	const telegram = asObject(notify.telegram);
	const feishu = asObject(notify.feishu);
	const dingtalk = asObject(notify.dingtalk);

	const barkKey = asText(bark.key);
	const pushPlusToken = asText(pushplus.token);
	const telegramBotToken = asText(telegram.botToken);
	const telegramChatId = asText(telegram.chatId);
	const feishuWebhook = asText(feishu.webhook);
	const dingtalkWebhook = asText(dingtalk.webhook);
	const telegramReady = Boolean(telegramBotToken && telegramChatId);

	return {
		barkKey: channelIsEnabled(bark, Boolean(barkKey)) ? barkKey : '',
		pushPlusToken: channelIsEnabled(pushplus, Boolean(pushPlusToken)) ? pushPlusToken : '',
		telegramBotToken: channelIsEnabled(telegram, telegramReady) ? telegramBotToken : '',
		telegramChatId: channelIsEnabled(telegram, telegramReady) ? telegramChatId : '',
		feishuWebhook: channelIsEnabled(feishu, Boolean(feishuWebhook)) ? feishuWebhook : '',
		dingtalkWebhook: channelIsEnabled(dingtalk, Boolean(dingtalkWebhook)) ? dingtalkWebhook : ''
	};
}

/**
 * Mirrors Clerk's private-metadata notify config into local D1 so the reminder-cron worker
 * (which only reads local tables) can send through channels users configured via Clerk.
 * Throttled by `notify_synced_at` since this runs on every authenticated request.
 */
export async function syncNotificationChannelsFromClerk(
	db: D1Database,
	userId: string,
	clerkUserId: string,
	privateMetadata: unknown,
	now = Math.floor(Date.now() / 1000)
) {
	const drizzle = getDb(db);
	const [user] = await drizzle.select().from(users).where(eq(users.id, userId)).limit(1);

	const alreadyLinked = user?.clerk_user_id === clerkUserId;
	const fresh = user?.notify_synced_at != null && now - user.notify_synced_at < SYNC_INTERVAL_SECONDS;
	if (alreadyLinked && fresh) return;

	const mirrored = notificationChannelsFromClerkMetadata(privateMetadata);
	if (mirrored) await saveNotificationChannels(db, userId, mirrored, now);

	await drizzle.update(users).set({ clerk_user_id: clerkUserId, notify_synced_at: now }).where(eq(users.id, userId));
}
