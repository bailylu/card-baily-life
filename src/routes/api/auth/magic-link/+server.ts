import { json } from '@sveltejs/kit';
import type { RequestHandler } from './$types';
import { isAllowed, createMagicToken } from '$lib/auth/magic-link';

export const POST: RequestHandler = async ({ request, platform }) => {
	const body = await request.json() as { email?: string };
	const { email } = body;
	if (!email || typeof email !== 'string') {
		return json({ error: 'invalid' }, { status: 400 });
	}

	const db = platform!.env.DB;
	const allowed = await isAllowed(db, email);

	// Always return success to prevent email enumeration
	if (!allowed) return json({ ok: true });

	const token = await createMagicToken(db, email);
	const appUrl = platform!.env.APP_URL;
	const link = `${appUrl}/auth/verify?token=${token}`;

	// TODO M3: send via CF Email Service
	// For now, log to console (visible in CF Workers logs)
	console.log(`[magic-link] ${email} → ${link}`);

	return json({ ok: true });
};
