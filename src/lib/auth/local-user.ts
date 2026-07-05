import type { InferSelectModel } from 'drizzle-orm';
import { users } from '../db/schema.ts';

export type LocalUser = InferSelectModel<typeof users>;

export type LocalUserStore = {
	findByEmail(email: string): Promise<LocalUser | null>;
	createUser(email: string, now: number): Promise<LocalUser>;
	updateLastLogin(userId: string, now: number): Promise<void>;
};

type ClerkEmailAddress = {
	id?: string | null;
	emailAddress?: string | null;
};

type ClerkUserLike = {
	primaryEmailAddressId?: string | null;
	emailAddresses?: ClerkEmailAddress[] | null;
} | null;

function createShortUserId() {
	const alphabet = 'ABCDEFGHJKLMNPQRSTUVWXYZ23456789';
	const bytes = new Uint8Array(8);
	crypto.getRandomValues(bytes);
	return `BL-${Array.from(bytes, (byte) => alphabet[byte % alphabet.length]).join('')}`;
}

function normalizeEmail(email: string) {
	return email.trim().toLowerCase();
}

export function getPrimaryEmailFromClerkUser(user: ClerkUserLike) {
	const emailAddresses = user?.emailAddresses ?? [];
	const primary =
		emailAddresses.find((email) => email.id && email.id === user?.primaryEmailAddressId) ??
		emailAddresses[0];
	const email = primary?.emailAddress;
	if (!email) return null;
	const normalized = normalizeEmail(email);
	return normalized || null;
}

export async function resolveLocalUserFromEmail(
	store: LocalUserStore,
	emailInput: string | null | undefined,
	now = Math.floor(Date.now() / 1000)
) {
	const email = normalizeEmail(emailInput ?? '');
	if (!email) return null;

	const existing = await store.findByEmail(email);
	if (existing) {
		await store.updateLastLogin(existing.id, now);
		return { ...existing, last_login_at: now };
	}

	return store.createUser(email, now);
}

export function createLocalUser(email: string, now: number): LocalUser {
	return {
		id: createShortUserId(),
		email,
		password_hash: null,
		created_at: now,
		last_login_at: now
	};
}
