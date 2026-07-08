import { fail, redirect } from '@sveltejs/kit';
import { and, asc, eq } from 'drizzle-orm';
import type { Actions, PageServerLoad } from './$types';
import { buildClerkSignInUrl } from '$lib/auth/clerk-sign-in';
import { getDb } from '$lib/db/client';
import { lounge_comments } from '$lib/db/schema';

export const load: PageServerLoad = async ({ locals, platform }) => {
	if (!platform?.env.DB) {
		return { user: locals.user, comments: [], commentsUnavailable: true };
	}

	const comments = await getDb(platform.env.DB)
		.select()
		.from(lounge_comments)
		.orderBy(asc(lounge_comments.created_at))
		.catch(() => []);

	return {
		user: locals.user,
		comments,
		commentsUnavailable: false
	};
};

export const actions: Actions = {
	addComment: async ({ request, locals, platform, url }) => {
		if (!locals.user) redirect(302, buildClerkSignInUrl(url, platform?.env, '/lounges'));
		if (!platform?.env.DB) return fail(503, { commentError: '留言暂时不可用' });

		const formData = await request.formData();
		const recordSeq = String(formData.get('recordSeq') ?? '').trim();
		const channelId = String(formData.get('channelId') ?? '').trim();
		const body = String(formData.get('body') ?? '').trim();

		if (!recordSeq || !channelId) return fail(400, { commentError: '缺少机场或渠道信息' });
		if (!body) return fail(400, { commentError: '请输入留言内容' });
		if (body.length > 500) return fail(400, { commentError: '留言最多 500 个字' });

		try {
			await getDb(platform.env.DB).insert(lounge_comments).values({
				id: crypto.randomUUID(),
				record_seq: recordSeq,
				channel_id: channelId,
				user_id: locals.user.id,
				user_email: locals.user.email,
				body,
				created_at: Math.floor(Date.now() / 1000)
			});
		} catch {
			return fail(503, { commentError: '留言暂时不可用，请先应用数据库迁移' });
		}

		return { commentSuccess: true, commentTarget: `${recordSeq}:${channelId}` };
	},
	deleteComment: async ({ request, locals, platform, url }) => {
		if (!locals.user) redirect(302, buildClerkSignInUrl(url, platform?.env, '/lounges'));
		if (!platform?.env.DB) return fail(503, { commentError: '留言暂时不可用' });

		const id = String((await request.formData()).get('id') ?? '').trim();
		if (!id) return fail(400, { commentError: '缺少留言 ID' });

		try {
			await getDb(platform.env.DB)
				.delete(lounge_comments)
				.where(and(eq(lounge_comments.id, id), eq(lounge_comments.user_id, locals.user.id)));
		} catch {
			return fail(503, { commentError: '留言暂时不可用，请先应用数据库迁移' });
		}

		return { commentDeleted: true };
	}
};
