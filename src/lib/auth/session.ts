import { eq, gt } from 'drizzle-orm';
import { getDb } from '$lib/db/client';
import { sessions, users } from '$lib/db/schema';
import {
	clearSessionCookie,
	getSessionCookieName,
	getSessionTtl,
	setSessionCookie
} from '$lib/auth/session-cookie';

export function getSessionCookie(cookies: { get(name: string): string | undefined }) {
	return cookies.get(getSessionCookieName());
}

export async function createSession(db: D1Database, userId: string): Promise<string> {
	const drizzle = getDb(db);
	const id = crypto.randomUUID().replace(/-/g, '') + crypto.randomUUID().replace(/-/g, '');
	const now = Math.floor(Date.now() / 1000);
	await drizzle.insert(sessions).values({
		id,
		user_id: userId,
		expires_at: now + getSessionTtl(),
		created_at: now
	});
	return id;
}

export async function getUserFromSession(db: D1Database, sessionId: string) {
	const drizzle = getDb(db);
	const now = Math.floor(Date.now() / 1000);
	const rows = await drizzle
		.select({ user: users })
		.from(sessions)
		.innerJoin(users, eq(sessions.user_id, users.id))
		.where(eq(sessions.id, sessionId))
		.limit(1);
	const row = rows[0];
	if (!row) return null;
	// check expiry in JS since we joined
	const session = await drizzle
		.select()
		.from(sessions)
		.where(eq(sessions.id, sessionId))
		.limit(1);
	if (!session[0] || session[0].expires_at < now) return null;
	return row.user;
}

export async function deleteSession(db: D1Database, sessionId: string) {
	const drizzle = getDb(db);
	await drizzle.delete(sessions).where(eq(sessions.id, sessionId));
}

export { clearSessionCookie, setSessionCookie };
