import type { users } from '$lib/db/schema';
import type { InferSelectModel } from 'drizzle-orm';

type User = InferSelectModel<typeof users>;

const DEFAULT_ADMIN_EMAILS = new Set(['bailytalk0318@gmail.com', '451248901@qq.com']);

export function isAdmin(user: User | null, env?: { ADMIN_EMAIL?: string }) {
	if (!user) return false;
	const adminEmail = env?.ADMIN_EMAIL?.trim().toLowerCase();
	if (adminEmail) return user.email.toLowerCase() === adminEmail;
	return DEFAULT_ADMIN_EMAILS.has(user.email.toLowerCase());
}
