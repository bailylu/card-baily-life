type CrmEnv = {
	DB?: D1Database;
	CRM_API_BASE?: string;
	CRM_API_KEY?: string;
};

type SyncEvent = 'register' | 'login' | 'magic_login' | 'settings_saved' | 'card_saved';

type UserRow = {
	id: string;
	email: string;
	created_at: number;
	last_login_at: number | null;
	card_count: number;
};

type ChannelRow = {
	type: string;
	count: number;
};

async function getCardUserSnapshot(env: CrmEnv, userId: string) {
	if (!env.DB) return null;

	const user = await env.DB.prepare(
		`SELECT u.id, u.email, u.created_at, u.last_login_at, COUNT(uc.id) AS card_count
		 FROM users u
		 LEFT JOIN user_cards uc ON uc.user_id = u.id
		 WHERE u.id = ?
		 GROUP BY u.id`
	)
		.bind(userId)
		.first<UserRow>();

	if (!user) return null;

	const channels = await env.DB.prepare(
		`SELECT type, COUNT(*) AS count
		 FROM notification_channels
		 WHERE user_id = ? AND enabled = 1
		 GROUP BY type`
	)
		.bind(userId)
		.all<ChannelRow>();

	return {
		user,
		channels: Object.fromEntries((channels.results ?? []).map((row) => [row.type, row.count > 0]))
	};
}

export async function syncCardUserToCrm(env: CrmEnv | undefined, userId: string, event: SyncEvent) {
	const base = String(env?.CRM_API_BASE || 'https://crm.baily.life').replace(/\/+$/, '');
	const apiKey = env?.CRM_API_KEY;
	if (!env?.DB || !apiKey) return;

	try {
		const snapshot = await getCardUserSnapshot(env, userId);
		if (!snapshot) return;

		const { user, channels } = snapshot;
		const response = await fetch(`${base}/api/users/upsert`, {
			method: 'POST',
			headers: {
				'Content-Type': 'application/json',
				'X-CRM-API-Key': apiKey
			},
			body: JSON.stringify({
				uid: user.id,
				email: user.email,
				display_name: user.email,
				source: 'card',
				product: 'card',
				product_status: 'active',
				role: 'user',
				event: `card_${event}`,
				metadata: {
					card_uid: user.id,
					card_count: user.card_count,
					notification_channels: channels,
					created_at: user.created_at,
					last_login_at: user.last_login_at
				}
			})
		});

		if (!response.ok) {
			console.warn('CRM sync failed', response.status, await response.text());
		}
	} catch (error) {
		console.warn('CRM sync failed', error);
	}
}
