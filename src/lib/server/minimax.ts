import { env as privateEnv } from '$env/dynamic/private';

const DEFAULT_MODEL = 'MiniMax-M3';
const DEFAULT_BASE_URL = 'https://api.minimax.io/v1';

function envValue(platform: App.Platform | undefined, key: keyof App.Platform['env']) {
	return String(platform?.env?.[key] ?? privateEnv[key] ?? '').trim();
}

function normalizeBaseUrl(value: string) {
	return (value || DEFAULT_BASE_URL).replace(/\/+$/, '');
}

export function extractMiniMaxContent(result: unknown) {
	const choice = (result as { choices?: Array<{ message?: { content?: unknown } }> })?.choices?.[0];
	const content = choice?.message?.content;
	if (typeof content === 'string') return content;
	if (Array.isArray(content)) {
		return content
			.map((item) => (typeof item === 'string' ? item : (item as { text?: string })?.text ?? ''))
			.join('');
	}
	return '';
}

export function parseJsonContent<T>(content: string) {
	const trimmed = content.trim();
	const fenced = trimmed.match(/```(?:json)?\s*([\s\S]*?)```/i)?.[1];
	const source = fenced ?? trimmed.match(/\{[\s\S]*\}/)?.[0] ?? trimmed;
	return JSON.parse(source) as T;
}

export async function callMiniMaxJson<T>(
	platform: App.Platform | undefined,
	messages: Array<{ role: 'system' | 'user' | 'assistant'; content: string }>
) {
	const apiKey = envValue(platform, 'MINIMAX_API_KEY');
	if (!apiKey) throw new Error('还没有配置 MINIMAX_API_KEY');

	const baseUrl = normalizeBaseUrl(envValue(platform, 'MINIMAX_API_BASE_URL'));
	const model = envValue(platform, 'MINIMAX_MODEL') || DEFAULT_MODEL;
	const response = await fetch(`${baseUrl}/chat/completions`, {
		method: 'POST',
		headers: {
			Authorization: `Bearer ${apiKey}`,
			'Content-Type': 'application/json'
		},
		body: JSON.stringify({
			model,
			thinking: { type: 'disabled' },
			temperature: 0.1,
			max_completion_tokens: 900,
			messages
		})
	});

	const result = await response.json().catch(() => null);
	if (!response.ok) {
		const message = (result as { error?: { message?: string }; message?: string } | null)?.error?.message
			?? (result as { message?: string } | null)?.message
			?? `MiniMax 请求失败：${response.status}`;
		throw new Error(message);
	}

	return parseJsonContent<T>(extractMiniMaxContent(result));
}
