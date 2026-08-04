import { redirect } from '@sveltejs/kit';
import type { PageServerLoad } from './$types';

const BIN_LOOKUP_URL = 'https://binlist.net/';

// /bin 直接跳转到 binlist.net。
// 用 302（临时跳转）而不是 301，浏览器不会长期记住，撤销时删掉本文件即可，
// 原来的查询页 +page.svelte 仍保留在仓库里。
export const load: PageServerLoad = () => {
	redirect(302, BIN_LOOKUP_URL);
};
