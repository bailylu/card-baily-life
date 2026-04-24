import { eq } from 'drizzle-orm';
import { fail, redirect } from '@sveltejs/kit';
import type { Actions, PageServerLoad } from './$types';
import { getDb } from '$lib/db/client';
import { users } from '$lib/db/schema';
import { hashPassword, verifyPassword } from '$lib/auth/password';

export const load: PageServerLoad = async ({ locals }) => {
	if (!locals.user) redirect(302, '/login');
	return {};
};

export const actions: Actions = {
	default: async ({ request, locals, platform }) => {
		if (!locals.user) redirect(302, '/login');
		if (!platform?.env.DB) return fail(503, { error: '数据连接暂时不可用' });

		const formData = await request.formData();
		const currentPassword = String(formData.get('currentPassword') ?? '');
		const newPassword = String(formData.get('newPassword') ?? '');
		const confirmPassword = String(formData.get('confirmPassword') ?? '');

		if (newPassword.length < 6) return fail(400, { error: '新密码至少需要 6 位' });
		if (newPassword !== confirmPassword) return fail(400, { error: '两次输入的新密码不一致' });

		const drizzle = getDb(platform.env.DB);
		const rows = await drizzle.select().from(users).where(eq(users.id, locals.user.id)).limit(1);
		const user = rows[0];
		if (!user?.password_hash || !(await verifyPassword(currentPassword, user.password_hash))) {
			return fail(400, { error: '当前密码不正确' });
		}

		await drizzle
			.update(users)
			.set({ password_hash: await hashPassword(newPassword) })
			.where(eq(users.id, locals.user.id));

		return { success: true };
	}
};
