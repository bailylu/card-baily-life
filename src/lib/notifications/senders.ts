type Fetcher = typeof fetch;

export function normalizeBarkKey(input: string) {
	const value = input.trim();
	if (!value) return '';
	if (!/^https?:\/\//i.test(value)) return value;

	try {
		const url = new URL(value);
		return url.pathname.split('/').filter(Boolean)[0] ?? value;
	} catch {
		return value;
	}
}

export async function sendBark(fetcher: Fetcher, key: string, title: string, content: string) {
	const barkKey = normalizeBarkKey(key);
	const url = `https://api.day.app/${encodeURIComponent(barkKey)}/${encodeURIComponent(title)}/${encodeURIComponent(content)}`;
	const response = await fetcher(url);
	const result = (await response.json().catch(() => null)) as { code?: number; message?: string } | null;
	if (!response.ok || (typeof result?.code === 'number' && result.code !== 200)) {
		throw new Error(result?.message ? `Bark 推送失败：${result.message}` : 'Bark 推送失败，请检查 Key');
	}
}

export async function sendPushPlus(fetcher: Fetcher, token: string, title: string, content: string) {
	const response = await fetcher('https://www.pushplus.plus/send', {
		method: 'POST',
		headers: { 'content-type': 'application/json' },
		body: JSON.stringify({ token, title, content, template: 'txt' })
	});

	const result = (await response.json().catch(() => null)) as { code?: number; msg?: string } | null;
	if (!response.ok || result?.code !== 200) {
		throw new Error(result?.msg ? `PushPlus 推送失败：${result.msg}` : 'PushPlus 推送失败，请检查 Token');
	}
}

export async function sendTelegram(
	fetcher: Fetcher,
	botToken: string,
	chatId: string,
	title: string,
	content: string
) {
	const response = await fetcher(`https://api.telegram.org/bot${botToken}/sendMessage`, {
		method: 'POST',
		headers: { 'content-type': 'application/json' },
		body: JSON.stringify({ chat_id: chatId, text: `${title}\n\n${content}` })
	});

	const result = (await response.json().catch(() => null)) as { ok?: boolean; description?: string } | null;
	if (!response.ok || !result?.ok) {
		throw new Error(
			result?.description ? `Telegram 推送失败：${result.description}` : 'Telegram 推送失败，请检查 Token 和 Chat ID'
		);
	}
}

export async function sendFeishu(fetcher: Fetcher, webhook: string, title: string, content: string) {
	const response = await fetcher(webhook, {
		method: 'POST',
		headers: { 'content-type': 'application/json' },
		body: JSON.stringify({
			msg_type: 'text',
			content: { text: `${title}\n\n${content}` }
		})
	});

	const result = (await response.json().catch(() => null)) as {
		code?: number;
		msg?: string;
		StatusCode?: number;
		StatusMessage?: string;
	} | null;
	const codeFailed = typeof result?.code === 'number' && result.code !== 0;
	const statusFailed = typeof result?.StatusCode === 'number' && result.StatusCode !== 0;
	if (!response.ok || codeFailed || statusFailed) {
		throw new Error(result?.msg || result?.StatusMessage || '飞书推送失败，请检查 Webhook');
	}
}

export async function sendDingTalk(fetcher: Fetcher, webhook: string, title: string, content: string) {
	const response = await fetcher(webhook, {
		method: 'POST',
		headers: { 'content-type': 'application/json' },
		body: JSON.stringify({
			msgtype: 'text',
			text: { content: `${title}\n\n${content}` }
		})
	});

	const result = (await response.json().catch(() => null)) as { errcode?: number; errmsg?: string } | null;
	if (!response.ok || (typeof result?.errcode === 'number' && result.errcode !== 0)) {
		throw new Error(result?.errmsg ? `钉钉推送失败：${result.errmsg}` : '钉钉推送失败，请检查 Webhook');
	}
}
