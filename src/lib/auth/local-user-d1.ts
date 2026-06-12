import { eq } from 'drizzle-orm';
import { getDb } from '$lib/db/client';
import { users } from '$lib/db/schema';
import {
	createLocalUser,
	getPrimaryEmailFromClerkUser,
	resolveLocalUserFromEmail,
	type LocalUserStore
} from '$lib/auth/local-user';

type ClerkEmailAddress = {
	id?: string | null;
	emailAddress?: string | null;
};

type ClerkUserLike = {
	primaryEmailAddressId?: string | null;
	emailAddresses?: ClerkEmailAddress[] | null;
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
			await drizzle.insert(users).values(user);
			return user;
		},
		async updateLastLogin(userId, now) {
			await drizzle.update(users).set({ last_login_at: now }).where(eq(users.id, userId));
		}
	};
}

export async function resolveLocalUserFromClerkUser(db: D1Database, clerkUser: ClerkUserLike) {
	const email = getPrimaryEmailFromClerkUser(clerkUser);
	return resolveLocalUserFromEmail(createD1LocalUserStore(db), email);
}
