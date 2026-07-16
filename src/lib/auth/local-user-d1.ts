import { eq } from 'drizzle-orm';
import { getDb } from '$lib/db/client';
import { users } from '$lib/db/schema';
import {
	createLocalUser,
	getPrimaryEmailFromClerkUser,
	resolveLocalUserFromEmail,
	type LocalUserStore
} from '$lib/auth/local-user';
import { syncNotificationChannelsFromClerk } from '$lib/notifications/clerk-sync';

type ClerkEmailAddress = {
	id?: string | null;
	emailAddress?: string | null;
};

type ClerkUserLike = {
	id?: string | null;
	primaryEmailAddressId?: string | null;
	emailAddresses?: ClerkEmailAddress[] | null;
	privateMetadata?: unknown;
} | null;

export function createD1LocalUserStore(db: D1Database): LocalUserStore {
	const drizzle = getDb(db);

	return {
		async findByEmail(email) {
			const rows = await drizzle.select().from(users).where(eq(users.email, email)).limit(1);
			return rows[0] ?? null;
		},
		async createUser(email, now) {
			const user = createLocalUser(email, now);
			try {
				await drizzle.insert(users).values(user);
				return user;
			} catch {
				// Concurrent first logins can race on the unique email index.
				const existing = await drizzle.select().from(users).where(eq(users.email, email)).limit(1);
				if (existing[0]) return existing[0];
				throw new Error(`failed to create local user for ${email}`);
			}
		},
		async updateLastLogin(userId, now) {
			await drizzle.update(users).set({ last_login_at: now }).where(eq(users.id, userId));
		}
	};
}

export async function resolveLocalUserFromClerkUser(db: D1Database, clerkUser: ClerkUserLike) {
	const email = getPrimaryEmailFromClerkUser(clerkUser);
	const user = await resolveLocalUserFromEmail(createD1LocalUserStore(db), email);

	if (user && clerkUser?.id) {
		await syncNotificationChannelsFromClerk(db, user.id, clerkUser.id, clerkUser.privateMetadata).catch(() => {});
	}

	return user;
}
