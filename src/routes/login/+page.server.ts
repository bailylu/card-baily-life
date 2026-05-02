import { fail, redirect } from '@sveltejs/kit';
import type { Actions, PageServerLoad } from './$types';
import { loginWithPassword, registerWithPassword } from '$lib/auth/account';
import { createSession, setSessionCookie } from '$lib/auth/session';
import { syncCardUserToCrm } from '$lib/crm-sync';

function normalizeMode(value: string | null) {
	return value === 'login' ? 'login' : 'register';
}

export const load: PageServerLoad = async ({ locals, url }) => {
	if (locals.user) redirect(302, '/dashboard');
	return { mode: normalizeMode(url.searchParams.get('mode')) };
};

export const actions: Actions = {
	default: async ({ request, platform, cookies, url }) => {
		if (!platform?.env.DB) return fail(500, { error: '当前环境没有数据库绑定，请稍后再试' });

		const formData = await request.formData();
		const email = `${formData.get('email') ?? ''}`;
		const password = `${formData.get('password') ?? ''}`;
		const mode = normalizeMode(`${formData.get('mode') ?? url.searchParams.get('mode') ?? ''}`);
		const result =
			mode === 'login'
				? await loginWithPassword(platform.env.DB, email, password)
				: await registerWithPassword(platform.env.DB, email, password);

		if (!result.ok) {
			return fail(400, { error: result.error, email, mode });
		}

		const sessionId = await createSession(platform.env.DB, result.userId);
		await syncCardUserToCrm(platform.env, result.userId, result.created ? 'register' : 'login');
		setSessionCookie(cookies, sessionId, url.protocol === 'https:');
		redirect(303, '/dashboard');
	}
};
