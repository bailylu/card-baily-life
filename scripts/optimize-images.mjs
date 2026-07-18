import { existsSync, readFileSync, readdirSync, statSync, writeFileSync } from 'node:fs';
import path from 'node:path';
import sharp from 'sharp';

const root = process.cwd();
const imagesRoot = path.join(root, 'static/images');

const MAX_WIDTH = 800;
const JPEG_QUALITY = 82;
const WEBP_QUALITY = 82;
const PNG_COMPRESSION_LEVEL = 9;
const MIN_SIZE_TO_PROCESS = 20 * 1024;

const rasterExtensions = new Set(['.png', '.jpg', '.jpeg', '.webp']);

function collectAllImageFiles(dir) {
	const results = [];
	for (const entry of readdirSync(dir, { withFileTypes: true })) {
		const entryPath = path.join(dir, entry.name);
		if (entry.isDirectory()) {
			results.push(...collectAllImageFiles(entryPath));
		} else if (['.png', '.jpg', '.jpeg', '.webp', '.svg'].includes(path.extname(entry.name).toLowerCase())) {
			results.push(path.relative(root, entryPath));
		}
	}
	return results;
}

async function optimizeRaster(file, ext) {
	const input = readFileSync(file);
	let pipeline = sharp(input).rotate();
	const meta = await pipeline.metadata();

	if (meta.width && meta.width > MAX_WIDTH) {
		pipeline = pipeline.resize({ width: MAX_WIDTH, withoutEnlargement: true });
	}

	const output =
		ext === '.png'
			? await pipeline.png({ compressionLevel: PNG_COMPRESSION_LEVEL }).toBuffer()
			: ext === '.webp'
				? await pipeline.webp({ quality: WEBP_QUALITY }).toBuffer()
				: await pipeline.jpeg({ quality: JPEG_QUALITY, mozjpeg: true }).toBuffer();

	if (output.length < input.length) {
		writeFileSync(file, output);
		return { before: input.length, after: output.length };
	}
	return null;
}

async function optimizeEmbeddedSvg(file) {
	const raw = readFileSync(file, 'utf8');
	const before = Buffer.byteLength(raw, 'utf8');
	// base64 数据不含 ">"，[^>]* 可以安全覆盖整个标签
	const tags = raw.match(/<image\b[^>]*>/g) ?? [];
	let updated = raw;

	for (const tag of tags) {
		const hrefMatch = tag.match(/xlink:href="data:image\/[a-zA-Z+]+;base64,([^"]+)"/);
		if (!hrefMatch) continue;

		const buffer = Buffer.from(hrefMatch[1], 'base64');
		let pipeline = sharp(buffer);
		const meta = await pipeline.metadata();
		if (meta.width && meta.width > MAX_WIDTH) {
			pipeline = pipeline.resize({ width: MAX_WIDTH, withoutEnlargement: true });
		}

		const outBuffer = await pipeline.webp({ quality: WEBP_QUALITY }).toBuffer();
		if (outBuffer.length >= buffer.length) continue;

		// 保持 width/height 原值：<image> 会把位图拉伸到声明的盒子，
		// 改掉宽高会与引用它的 <use transform> 矩阵失配，导致渲染缩小错位
		const newTag = tag.replace(
			/xlink:href="data:image\/[a-zA-Z+]+;base64,[^"]+"/,
			`xlink:href="data:image/webp;base64,${outBuffer.toString('base64')}"`
		);
		updated = updated.replace(tag, newTag);
	}

	const after = Buffer.byteLength(updated, 'utf8');
	if (after < before) {
		writeFileSync(file, updated);
		return { before, after };
	}
	return null;
}

async function optimizeFile(relativeFile) {
	const file = path.join(root, relativeFile);
	if (!existsSync(file)) return;

	const ext = path.extname(file).toLowerCase();
	const size = statSync(file).size;
	if (size < MIN_SIZE_TO_PROCESS) return;

	const result = ext === '.svg' ? await optimizeEmbeddedSvg(file) : rasterExtensions.has(ext) ? await optimizeRaster(file, ext) : null;

	if (result) {
		const percent = Math.round((1 - result.after / result.before) * 100);
		console.log(`  ${relativeFile}: ${(result.before / 1024).toFixed(0)}KB -> ${(result.after / 1024).toFixed(0)}KB (-${percent}%)`);
	}
}

const args = process.argv.slice(2);
const files = args.includes('--all') ? collectAllImageFiles(imagesRoot) : args.filter((arg) => arg.startsWith('static/images/'));

if (files.length === 0) {
	console.log('No image files to optimize.');
	process.exit(0);
}

console.log(`Optimizing ${files.length} image file(s)...`);
for (const file of files) {
	await optimizeFile(file);
}
