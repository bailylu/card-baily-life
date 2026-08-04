import { json } from '@sveltejs/kit';
import type { RequestHandler } from './$types';
import { lookupBin } from '$lib/bin/lookup';
import { BIN_MAX_LENGTH, BIN_MIN_LENGTH, detectNetwork, isValidBin } from '$lib/bin/network';

export const GET: RequestHandler = async ({ url, platform, setHeaders }) => {
	const raw = (url.searchParams.get('bin') ?? '').trim();

	// 这里是硬闸门：超过 8 位一律拒绝，完整卡号不可能被转发给第三方。
	if (raw.length > BIN_MAX_LENGTH) {
		return json(
			{ error: `只需要卡号前 ${BIN_MIN_LENGTH}-${BIN_MAX_LENGTH} 位，请不要输入完整卡号` },
			{ status: 400 }
		);
	}
	if (!isValidBin(raw)) {
		return json({ error: `请输入卡号前 ${BIN_MIN_LENGTH}-${BIN_MAX_LENGTH} 位数字` }, { status: 400 });
	}

	const network = detectNetwork(raw);
	const result = await lookupBin(platform?.env.DB, raw);

	setHeaders({ 'cache-control': 'public, max-age=3600' });

	return json({
		bin: raw,
		network,
		detail: result.detail,
		source: result.source,
		unavailable: result.unavailable,
		// 排查上游可用性时用：?debug=1 会带上 binlist 返回的状态码
		...(url.searchParams.get('debug') === '1' ? { upstreamStatus: result.upstreamStatus } : {})
	});
};
