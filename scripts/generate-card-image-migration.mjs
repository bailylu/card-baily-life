import { existsSync, readFileSync, writeFileSync } from 'node:fs';
import path from 'node:path';

const root = process.cwd();
const csvPath = path.join(root, 'docs/card-image-verified.csv');
const verifiedDir = path.join(root, 'static/images/cards/verified');
const migrationPath = path.join(root, 'migrations/0008_apply_verified_card_images.sql');
const previewPath = path.join(root, 'docs/card-image-verified-preview.md');
const validStatuses = new Set(['verified', 'missing', 'replace_needed']);

function parseCsvLine(line) {
	const cells = [];
	let cell = '';
	let inQuotes = false;

	for (let index = 0; index < line.length; index += 1) {
		const char = line[index];
		const next = line[index + 1];

		if (char === '"' && inQuotes && next === '"') {
			cell += '"';
			index += 1;
			continue;
		}

		if (char === '"') {
			inQuotes = !inQuotes;
			continue;
		}

		if (char === ',' && !inQuotes) {
			cells.push(cell);
			cell = '';
			continue;
		}

		cell += char;
	}

	cells.push(cell);
	return cells;
}

function sql(value) {
	return `'${value.replaceAll("'", "''")}'`;
}

const lines = readFileSync(csvPath, 'utf8')
	.trim()
	.split(/\r?\n/)
	.filter(Boolean);
const [headerLine, ...rowLines] = lines;
const headers = parseCsvLine(headerLine);
const requiredHeaders = ['bank_name', 'card_name', 'image_file', 'status', 'notes'];

if (headers.join(',') !== requiredHeaders.join(',')) {
	throw new Error(`CSV 表头必须是：${requiredHeaders.join(',')}`);
}

const rows = rowLines.map((line, lineIndex) => {
	const values = parseCsvLine(line);
	if (values.length !== headers.length) {
		throw new Error(`第 ${lineIndex + 2} 行列数不正确`);
	}

	return Object.fromEntries(headers.map((header, index) => [header, values[index].trim()]));
});

const errors = [];
const verifiedRows = [];

for (const [index, row] of rows.entries()) {
	if (!validStatuses.has(row.status)) {
		errors.push(`第 ${index + 2} 行状态无效：${row.status}`);
	}

	if (row.status === 'verified') {
		if (!row.image_file) {
			errors.push(`第 ${index + 2} 行已 verified，但 image_file 为空`);
		} else if (!existsSync(path.join(verifiedDir, row.image_file))) {
			errors.push(`第 ${index + 2} 行图片不存在：static/images/cards/verified/${row.image_file}`);
		} else {
			verifiedRows.push(row);
		}
	}
}

if (errors.length > 0) {
	throw new Error(errors.join('\n'));
}

const migration = [
	'-- Generated from docs/card-image-verified.csv.',
	'-- Only rows marked as verified are mapped to card_catalog.image_url.',
	'',
	'UPDATE card_catalog',
	'SET image_url = NULL',
	'WHERE image_url IS NOT NULL;',
	'',
	...verifiedRows.map(
		(row) =>
			`UPDATE card_catalog SET image_url = ${sql(`/images/cards/verified/${row.image_file}`)} WHERE bank_name = ${sql(row.bank_name)} AND card_name = ${sql(row.card_name)};`
	),
	''
].join('\n');

const preview = [
	'# Verified card image preview',
	'',
	`- Total cards: ${rows.length}`,
	`- Verified cards: ${verifiedRows.length}`,
	`- Missing / replace needed: ${rows.length - verifiedRows.length}`,
	'',
	'## Verified',
	'',
	verifiedRows.length
		? verifiedRows
				.map(
					(row) =>
						`### ${row.bank_name} ${row.card_name}\n\n![${row.bank_name} ${row.card_name}](/Users/baily/Downloads/Playground/card-baily-life/static/images/cards/verified/${row.image_file})\n\n- File: \`${row.image_file}\`\n- Notes: ${row.notes || '-'}\n`
				)
				.join('\n')
		: '暂无 verified 图片。',
	'',
	'## Waiting for images',
	'',
	'| bank | card | status | notes |',
	'|---|---|---|---|',
	...rows
		.filter((row) => row.status !== 'verified')
		.map((row) => `| ${row.bank_name} | ${row.card_name} | ${row.status} | ${row.notes || ''} |`),
	''
].join('\n');

writeFileSync(migrationPath, migration);
writeFileSync(previewPath, preview);

console.log(`Generated ${path.relative(root, migrationPath)} with ${verifiedRows.length} verified mappings.`);
console.log(`Generated ${path.relative(root, previewPath)}.`);
