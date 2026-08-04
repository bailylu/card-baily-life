import { redirect } from '@sveltejs/kit';
import type { PageServerLoad } from './$types';

const MASTERCARD_BIN_URL = 'https://developer.mastercard.com/product/bin-table-resource/';

// /bin 直接跳转到万事达官方 BIN 页面。
// 用 302（临时跳转）而不是 301，浏览器不会长期记住，撤销时删掉本文件即可，
// 原来的查询页 +page.svelte 仍保留在仓库里。
export const load: PageServerLoad = () => {
	redirect(302, MASTERCARD_BIN_URL);
};
