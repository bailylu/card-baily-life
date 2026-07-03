import { fail, redirect } from '@sveltejs/kit';
import { eq } from 'drizzle-orm';
import type { Actions, PageServerLoad } from './$types';
import { isAdmin } from '$lib/admin/access';
import { getDb } from '$lib/db/client';
import { featured_promotions } from '$lib/db/schema';
import { defaultFeaturedPromotions, listFeaturedPromotions } from '$lib/featured/promotions';

const MAX_IMAGE_BYTES = 500 * 1024;
const ACCEPTED_IMAGE_TYPES = new Set(['image/jpeg', 'image/png', 'image/webp']);

function requiredText(formData: FormData, name: string, label: string, max = 220) {
	const value = String(formData.get(name) ?? '').trim();
	if (!value) throw new Error(`请填写${label}`);
	if (value.length > max) throw new Error(`${label}不能超过 ${max} 个字符`);
	return value;
}

function optionalText(formData: FormData, name: string, fallback: string, max = 220) {
	const value = String(formData.get(name) ?? '').trim() || fallback;
	if (value.length > max) throw new Error(`${name}不能超过 ${max} 个字符`);
	return value;
}

async function fileToDataUrl(file: File) {
	if (file.size === 0) return null;
	if (file.size > MAX_IMAGE_BYTES) throw new Error('活动图片不能超过 500KB，请先压缩后再上传');
	if (!ACCEPTED_IMAGE_TYPES.has(file.type)) throw new Error('活动图片只支持 JPG、PNG 或 WEBP');

	const buffer = await file.arrayBuffer();
	const bytes = new Uint8Array(buffer);
	let binary = '';
	for (const byte of bytes) binary += String.fromCharCode(byte);
	return `data:${file.type};base64,${btoa(binary)}`;
}

function normalizedProcessedImage(value: FormDataEntryValue | null) {
	if (typeof value !== 'string' || !value) return null;
	const match = value.match(/^data:(image\/(?:jpeg|png|webp));base64,([A-Za-z0-9+/=]+)$/);
	if (!match) throw new Error('处理后的图片格式无效，请重新上传');
	const byteLength = Math.floor((match[2].length * 3) / 4);
	if (byteLength > MAX_IMAGE_BYTES) throw new Error('处理后的活动图片不能超过 500KB，请先压缩后再上传');
	return value;
}

function normalizeHref(value: string) {
	if (value.startsWith('/')) return value;
	if (/^https?:\/\//i.test(value)) return value;
	return `/${value}`;
}

function optionalHref(formData: FormData, id: string) {
	const value = String(formData.get('href') ?? '').trim();
	return normalizeHref(value || `/refer/${id}`);
}

export const load: PageServerLoad = async ({ locals, platform, url }) => {
	if (!locals.user) redirect(302, '/login');
	if (!isAdmin(locals.user, platform?.env)) redirect(302, '/dashboard');
	const saved = url.searchParams.get('saved') === '1';
	if (!platform?.env.DB) return { promotions: defaultFeaturedPromotions, configMissing: true, saved };

	try {
		return {
			promotions: await listFeaturedPromotions(platform.env.DB, { includeDisabled: true }),
			configMissing: false,
			saved
		};
	} catch {
		return { promotions: defaultFeaturedPromotions, configMissing: true, saved };
	}
};

export const actions: Actions = {
	save: async ({ request, locals, platform }) => {
		if (!locals.user) redirect(302, '/login');
		if (!isAdmin(locals.user, platform?.env)) redirect(302, '/dashboard');
		if (!platform?.env.DB) return fail(500, { error: '当前运行环境没有 D1 绑定' });

		try {
			const formData = await request.formData();
			const id = String(formData.get('id') ?? crypto.randomUUID()).trim() || crypto.randomUUID();
			const existing = await getDb(platform.env.DB)
				.select({ image_url: featured_promotions.image_url })
				.from(featured_promotions)
				.where(eq(featured_promotions.id, id))
				.limit(1);
			const imageFile = formData.get('image');
			const processedImage = normalizedProcessedImage(formData.get('processed_image'));
			const uploadedImage = processedImage ?? (imageFile instanceof File ? await fileToDataUrl(imageFile) : null);
			const imageUrl = uploadedImage ?? String(formData.get('image_url') ?? existing[0]?.image_url ?? '').trim();
			if (!imageUrl) throw new Error('请填写图片地址或上传活动图片');

			const now = Math.floor(Date.now() / 1000);
			const sortOrder = Number(formData.get('sort_order') || 100);
			const name = requiredText(formData, 'name', '卡片名称', 80);
			const values = {
				id,
				bank: optionalText(formData, 'bank', '首页推荐', 80),
				partner: optionalText(formData, 'partner', '办卡活动', 80),
				name,
				description: requiredText(formData, 'description', '活动简介', 260),
				image_url: imageUrl,
				alt: optionalText(formData, 'alt', name, 100),
				href: optionalHref(formData, id),
				metric_1_label: '预计收益',
				metric_1_value: requiredText(formData, 'metric_1_value', '预计收益', 40),
				metric_2_label: optionalText(formData, 'metric_2_label', '入口', 24),
				metric_2_value: optionalText(formData, 'metric_2_value', '立即办卡', 40),
				metric_3_label: optionalText(formData, 'metric_3_label', '状态', 24),
				metric_3_value: optionalText(formData, 'metric_3_value', '推荐中', 40),
				sort_order: Number.isFinite(sortOrder) ? sortOrder : 100,
				enabled: formData.get('enabled') === 'on' ? 1 : 0,
				created_at: now,
				updated_at: now
			};

			if (existing.length > 0) {
				await getDb(platform.env.DB)
					.update(featured_promotions)
					.set({
						bank: values.bank,
						partner: values.partner,
						name: values.name,
						description: values.description,
						image_url: values.image_url,
						alt: values.alt,
						href: values.href,
						metric_1_label: values.metric_1_label,
						metric_1_value: values.metric_1_value,
						metric_2_label: values.metric_2_label,
						metric_2_value: values.metric_2_value,
						metric_3_label: values.metric_3_label,
						metric_3_value: values.metric_3_value,
						sort_order: values.sort_order,
						enabled: values.enabled,
						updated_at: now
					})
					.where(eq(featured_promotions.id, id));
			} else {
				await getDb(platform.env.DB).insert(featured_promotions).values(values);
			}
		} catch (error) {
			return fail(400, { error: error instanceof Error ? error.message : '保存失败' });
		}

		redirect(303, '/admin/featured?saved=1');
	},
	deletePromotion: async ({ request, locals, platform }) => {
		if (!locals.user) redirect(302, '/login');
		if (!isAdmin(locals.user, platform?.env)) redirect(302, '/dashboard');
		if (!platform?.env.DB) return fail(500, { error: '当前运行环境没有 D1 绑定' });

		const id = String((await request.formData()).get('id') ?? '').trim();
		if (!id) return fail(400, { error: '推荐 ID 无效' });
		await getDb(platform.env.DB).delete(featured_promotions).where(eq(featured_promotions.id, id));
		redirect(303, '/admin/featured?saved=1');
	}
};
