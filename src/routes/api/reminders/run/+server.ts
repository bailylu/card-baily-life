import { json, error } from '@sveltejs/kit';
import { env as privateEnv } from '$env/dynamic/private';
import type { RequestHandler } from './$types';
import { dispatchDueReminders } from '$lib/notifications/reminder-dispatch';

function isLocalhost(url: URL) {
	return url.hostname === '127.0.0.1' || url.hostname === 'localhost';
}

function assertAuthorized(request: Request, url: URL) {
	if (isLocalhost(url)) return;

	const token = privateEnv.REMINDER_RUN_TOKEN;
	const authorization = request.headers.get('authorization') ?? '';
	if (!token || authorization !== `Bearer ${token}`) {
		error(401, 'Unauthorized');
	}
}

export const POST: RequestHandler = async ({ request, platform, url }) => {
	assertAuthorized(request, url);
	if (!platform?.env.DB) error(503, 'D1 database is not available');

	const dryRun = url.searchParams.get('dryRun') === '1';
	const todayParam = url.searchParams.get('today');
	const today = todayParam && isLocalhost(url) ? new Date(`${todayParam}T12:00:00`) : undefined;
	const summary = await dispatchDueReminders(platform.env.DB, { dryRun, today });
	return json({ ok: summary.errors.length === 0, dryRun, summary });
};
