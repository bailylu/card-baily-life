import { eq } from 'drizzle-orm';
import { getDb } from '$lib/db/client';
import { users } from '$lib/db/schema';
import { hashPassword, verifyPassword } from './password';

type AuthResult =
	| { ok: true; userId: string; created: boolean }
	| { ok: false; error: string };

function createShortUserId() {
	const alphabet = 'ABCDEFGHJKLMNPQRSTUVWXYZ23456789';
	const bytes = new Uint8Array(8);
	crypto.getRandomValues(bytes);
	return `BL-${Array.from(bytes, (byte) => alphabet[byte % alphabet.length]).join('')}`;
}

export function normalizeEmail(email: string) {
	return email.trim().toLowerCase();
}

export function validateCredentials(email: string, password: string) {
	if (!/^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(email)) return '请输入有效邮箱';
	if (password.length < 6) return '密码至少需要 6 位';
	if (password.length > 128) return '密码过长';
	return null;
}

export async function registerWithPassword(
	db: D1Database,
	emailInput: string,
	password: string
): Promise<AuthResult> {
	const email = normalizeEmail(emailInput);
	const validationError = validateCredentials(email, password);
	if (validationError) return { ok: false, error: validationError };

	const drizzle = getDb(db);
	const now = Math.floor(Date.now() / 1000);
	const rows = await drizzle.select().from(users).where(eq(users.email, email)).limit(1);
	const user = rows[0];

	if (!user) {
		const userId = createShortUserId();
		await drizzle.insert(users).values({
			id: userId,
			email,
			password_hash: await hashPassword(password),
			created_at: now,
			last_login_at: now
		});
		return { ok: true, userId, created: true };
	}

	if (!user.password_hash) {
		await drizzle
			.update(users)
			.set({ password_hash: await hashPassword(password), last_login_at: now })
			.where(eq(users.id, user.id));
		return { ok: true, userId: user.id, created: false };
	}

	return { ok: false, error: '这个邮箱已经注册，请直接登录' };
}

export async function loginWithPassword(
	db: D1Database,
	emailInput: string,
	password: string
): Promise<AuthResult> {
	const email = normalizeEmail(emailInput);
	const validationError = validateCredentials(email, password);
	if (validationError) return { ok: false, error: validationError };

	const drizzle = getDb(db);
	const now = Math.floor(Date.now() / 1000);
	const rows = await drizzle.select().from(users).where(eq(users.email, email)).limit(1);
	const user = rows[0];

	if (!user?.password_hash) {
		return { ok: false, error: '账号不存在，请先注册' };
	}

	if (!(await verifyPassword(password, user.password_hash))) {
		return { ok: false, error: '邮箱或密码不正确' };
	}

	await drizzle.update(users).set({ last_login_at: now }).where(eq(users.id, user.id));
	return { ok: true, userId: user.id, created: false };
}

export async function registerOrLoginWithPassword(
	db: D1Database,
	emailInput: string,
	password: string
): Promise<AuthResult> {
	const registered = await registerWithPassword(db, emailInput, password);
	if (registered.ok || registered.error !== '这个邮箱已经注册，请直接登录') return registered;
	return loginWithPassword(db, emailInput, password);
}
