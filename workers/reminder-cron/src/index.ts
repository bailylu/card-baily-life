export interface Env {
	REMINDER_ENDPOINT: string;
	REMINDER_RUN_TOKEN: string;
}

type ReminderRunResponse = {
	ok?: boolean;
	dryRun?: boolean;
	summary?: {
		checkedUsers?: number;
		dueReminders?: number;
		skippedByPreference?: number;
		sent?: number;
		duplicates?: number;
		errors?: string[];
	};
};

async function runReminderJob(env: Env, options: { dryRun?: boolean } = {}) {
	if (!env.REMINDER_RUN_TOKEN) {
		throw new Error('REMINDER_RUN_TOKEN is not configured');
	}

	const endpoint = new URL(env.REMINDER_ENDPOINT);
	if (options.dryRun) endpoint.searchParams.set('dryRun', '1');

	const response = await fetch(endpoint, {
		method: 'POST',
		headers: {
			authorization: `Bearer ${env.REMINDER_RUN_TOKEN}`,
			'content-type': 'application/json'
		}
	});

	const result = (await response.json().catch(() => null)) as ReminderRunResponse | null;
	if (!response.ok || !result?.ok) {
		throw new Error(
			`Reminder run failed: ${response.status} ${JSON.stringify(result ?? {})}`
		);
	}

	console.log('Reminder run completed', JSON.stringify(result.summary ?? {}));
	return result;
}

export default {
	async scheduled(_event: ScheduledEvent, env: Env, ctx: ExecutionContext) {
		ctx.waitUntil(runReminderJob(env));
	},
	async fetch(request: Request, env: Env) {
		const url = new URL(request.url);
		const result = await runReminderJob(env, { dryRun: url.searchParams.get('dryRun') === '1' });
		return Response.json({ ok: true, result });
	}
};
