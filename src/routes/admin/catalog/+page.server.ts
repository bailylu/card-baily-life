import { fail, redirect } from '@sveltejs/kit';
import { asc, eq } from 'drizzle-orm';
import type { Actions, PageServerLoad } from './$types';
import { isAdmin } from '$lib/admin/access';
import { getDb } from '$lib/db/client';
import { card_catalog } from '$lib/db/schema';

const MAX_IMAGE_BYTES = 350 * 1024;
const ACCEPTED_IMAGE_TYPES = new Set(['image/jpeg', 'image/png', 'image/webp', 'image/svg+xml']);
const ACCEPTED_DATA_URL_PREFIX = /^data:image\/(jpeg|png|webp);base64,/;

function slugify(input: string) {
	return input
		.trim()
		.toLowerCase()
		.normalize('NFKD')
		.replace(/[^\p{Letter}\p{Number}]+/gu, '-')
		.replace(/^-+|-+$/g, '')
		.slice(0, 80);
}

function validateText(value: FormDataEntryValue | null, label: string) {
	const text = String(value ?? '').trim();
	if (!text) throw new Error(`请填写${label}`);
	if (text.length > 80) throw new Error(`${label}不能超过 80 个字符`);
	return text;
}

type Variant = { label: string; imageUrl: string | null };

function parseVariants(json: string | null): Variant[] {
	if (!json) return [];
	try {
		const parsed = JSON.parse(json);
		if (!Array.isArray(parsed)) return [];
		return parsed.filter((v): v is Variant => typeof v === 'object' && v !== null);
	} catch {
		return [];
	}
}

async function fileToDataUrl(file: File) {
	if (file.size === 0) return null;
	if (file.size > MAX_IMAGE_BYTES) throw new Error('卡面图片不能超过 350KB，请先压缩后再上传');
	if (!ACCEPTED_IMAGE_TYPES.has(file.type)) throw new Error('只支持 JPG、PNG、WEBP 或 SVG 图片');

	const buffer = await file.arrayBuffer();
	const bytes = new Uint8Array(buffer);
	let binary = '';
	for (const byte of bytes) binary += String.fromCharCode(byte);
	return `data:${file.type};base64,${btoa(binary)}`;
}

function validateImageDataUrl(value: FormDataEntryValue | null) {
	const dataUrl = String(value ?? '').trim();
	if (!dataUrl) return null;
	if (!ACCEPTED_DATA_URL_PREFIX.test(dataUrl)) throw new Error('旋转后的图片格式无效，请使用 JPG、PNG 或 WEBP');

	const base64 = dataUrl.split(',')[1] ?? '';
	const bytes = Math.ceil((base64.length * 3) / 4);
	if (bytes > MAX_IMAGE_BYTES) throw new Error('旋转后的卡面图片不能超过 350KB，请先压缩后再上传');

	return dataUrl;
}

export const load: PageServerLoad = async ({ locals, platform, url }) => {
	if (!locals.user) redirect(302, '/login');
	if (!isAdmin(locals.user, platform?.env)) redirect(302, '/dashboard');
	const saved = url.searchParams.get('saved') === '1';
	if (!platform?.env.DB) return { cards: [], configMissing: true, saved };

	const cards = await getDb(platform.env.DB)
		.select()
		.from(card_catalog)
		.orderBy(asc(card_catalog.bank_name), asc(card_catalog.card_name));

	return { cards, configMissing: false, saved };
};

export const actions: Actions = {
	save: async ({ request, locals, platform, url }) => {
		if (!locals.user) redirect(302, '/login');
		if (!isAdmin(locals.user, platform?.env)) redirect(302, '/dashboard');
		if (!platform?.env.DB) return fail(500, { error: '当前运行环境没有 D1 绑定' });

		try {
			const formData = await request.formData();
			const id = Number(url.searchParams.get('id') || formData.get('id'));
			const editingId = Number.isInteger(id) && id > 0 ? id : null;
			const bankName = validateText(formData.get('bank_name'), '银行名称');
			const cardName = validateText(formData.get('card_name'), '卡片名称');
			const cardTier = String(formData.get('card_tier') ?? '').trim();
			const network = String(formData.get('network') ?? '').trim();
			const tags = String(formData.get('tags') ?? '').trim();
			const notes = String(formData.get('notes') ?? '').trim();
			const image = formData.get('image');
			const imageUrl = validateImageDataUrl(formData.get('image_data_url')) ?? (image instanceof File ? await fileToDataUrl(image) : null);
			const nowNote = notes || `admin:${slugify(`${bankName}-${cardName}`)}`;
			const db = getDb(platform.env.DB);

			// 处理变体
			const variantCount = Number(formData.get('variant_count') ?? 0);
			const newVariants: Variant[] = [];
			for (let i = 0; i < variantCount; i++) {
				const label = String(formData.get(`variant_label_${i}`) ?? '').trim();
				const variantFile = formData.get(`variant_image_${i}`);
				const existingUrl = String(formData.get(`variant_existing_url_${i}`) ?? '').trim() || null;
				const variantImageUrl =
					variantFile instanceof File && variantFile.size > 0
						? await fileToDataUrl(variantFile)
						: existingUrl;
				newVariants.push({ label, imageUrl: variantImageUrl });
			}
			const variantsJson = newVariants.length > 0 ? JSON.stringify(newVariants) : null;

			const existing = editingId
				? await db
						.select({ id: card_catalog.id, image_url: card_catalog.image_url, variants: card_catalog.variants })
						.from(card_catalog)
						.where(eq(card_catalog.id, editingId))
						.limit(1)
				: [];
			const matched = existing[0];

			if (editingId && !matched) {
				throw new Error('要编辑的卡片不存在，请刷新页面后重试');
			}

			if (editingId && matched) {
				await db
					.update(card_catalog)
					.set({
						bank_name: bankName,
						card_name: cardName,
						card_tier: cardTier || null,
						network: network || null,
						tags: tags || null,
						notes: nowNote,
						image_url: imageUrl ?? matched.image_url,
						variants: variantsJson ?? matched.variants
					})
					.where(eq(card_catalog.id, matched.id));
			} else {
				await db.insert(card_catalog).values({
					country: 'CN',
					bank_name: bankName,
					card_name: cardName,
					card_tier: cardTier || null,
					network: network || null,
					tags: tags || null,
					image_url: imageUrl,
					variants: variantsJson,
					annual_fee_cny: null,
					notes: nowNote
				});
			}
		} catch (error) {
			return fail(400, {
				error: error instanceof Error ? error.message : '保存失败'
			});
		}

		redirect(303, '/admin/catalog?saved=1');
	},
	clearImage: async ({ request, locals, platform }) => {
		if (!locals.user) redirect(302, '/login');
		if (!isAdmin(locals.user, platform?.env)) redirect(302, '/dashboard');
		if (!platform?.env.DB) return fail(500, { error: '当前运行环境没有 D1 绑定' });

		const formData = await request.formData();
		const id = Number(formData.get('id'));
		if (!Number.isInteger(id) || id <= 0) return fail(400, { error: '卡片 ID 无效' });

		await getDb(platform.env.DB)
			.update(card_catalog)
			.set({ image_url: null })
			.where(eq(card_catalog.id, id));

		redirect(303, '/admin/catalog?saved=1');
	},
	deleteCard: async ({ request, locals, platform }) => {
		if (!locals.user) redirect(302, '/login');
		if (!isAdmin(locals.user, platform?.env)) redirect(302, '/dashboard');
		if (!platform?.env.DB) return fail(500, { error: '当前运行环境没有 D1 绑定' });

		const formData = await request.formData();
		const id = Number(formData.get('id'));
		if (!Number.isInteger(id) || id <= 0) return fail(400, { error: '卡片 ID 无效' });

		await getDb(platform.env.DB).delete(card_catalog).where(eq(card_catalog.id, id));

		redirect(303, '/admin/catalog?saved=1');
	}
};
