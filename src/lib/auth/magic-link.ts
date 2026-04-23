import { eq } from 'drizzle-orm';
import { getDb } from '$lib/db/client';
import { allowlist, magic_links, users } from '$lib/db/schema';

const MAGIC_LINK_TTL = 60 * 15; // 15 minutes

export async function isAllowed(db: D1Database, email: string): Promise<boolean> {
	const drizzle = getDb(db);
	const rows = await drizzle
		.select()
		.from(allowlist)
		.where(eq(allowlist.email, email.toLowerCase()))
		.limit(1);
	return rows.length > 0;
}

export async function createMagicToken(db: D1Database, email: string): Promise<string> {
	const drizzle = getDb(db);
	const token = crypto.randomUUID().replace(/-/g, '') + crypto.randomUUID().replace(/-/g, '');
	const now = Math.floor(Date.now() / 1000);
	await drizzle.insert(magic_links).values({
		token,
		email: email.toLowerCase(),
		expires_at: now + MAGIC_LINK_TTL
	});
	return token;
}

export async function verifyMagicToken(
	db: D1Database,
	token: string
): Promise<{ email: string; userId: string } | null> {
	const drizzle = getDb(db);
	const now = Math.floor(Date.now() / 1000);

	const rows = await drizzle
		.select()
		.from(magic_links)
		.where(eq(magic_links.token, token))
		.limit(1);
	const link = rows[0];

	if (!link || link.used_at || link.expires_at < now) return null;

	// Mark used
	await drizzle
		.update(magic_links)
		.set({ used_at: now })
		.where(eq(magic_links.token, token));

	// Upsert user
	const email = link.email;
	let userRows = await drizzle.select().from(users).where(eq(users.email, email)).limit(1);
	let userId: string;

	if (userRows.length === 0) {
		userId = crypto.randomUUID();
		await drizzle.insert(users).values({ id: userId, email, created_at: now, last_login_at: now });
	} else {
		userId = userRows[0].id;
		await drizzle.update(users).set({ last_login_at: now }).where(eq(users.id, userId));
	}

	return { email, userId };
}
