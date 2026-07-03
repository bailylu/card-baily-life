import crypto from 'node:crypto';
import fs from 'node:fs';
import path from 'node:path';
import process from 'node:process';
import { execFileSync } from 'node:child_process';

const root = process.cwd();
const sourceRoot = process.argv[2] || '/tmp/Cardentify';
const importAll = process.argv.includes('--all');
const shouldApplyLocal = process.argv.includes('--apply-local');
const allowedCountries = new Set(['CN', 'HK', 'US', 'JP', 'TW']);
const localDbArgIndex = process.argv.indexOf('--db');
const localDbPath =
	localDbArgIndex >= 0
		? process.argv[localDbArgIndex + 1]
		: path.join(
				root,
				'.wrangler/state/v3/d1/miniflare-D1DatabaseObject/2c5b4d7bce8f76f122f8e0c6a3eb5005c8110c9505584a8e56e3a0fbddd61307.sqlite'
			);

const selectedBanks = [
	'Agricultural Bank of China',
	'Bank of China',
	'Bank of Communications',
	'China Citic Bank',
	'China Construction Bank',
	'China Guangfa Bank',
	'China Industrial Bank',
	'China Merchants Bank',
	'China Minsheng Bank',
	'China Zheshang Bank',
	'Huaxia Bank',
	'Industrial and Commercial Bank of China',
	'Ping An Bank',
	'Postal Savings Bank of China',
	'Shanghai Pudong Development Bank'
];

const bankNameMap = new Map([
	['中国农业银行', '农业银行'],
	['中国银行', '中国银行'],
	['交通银行', '交通银行'],
	['中信银行', '中信银行'],
	['中国建设银行', '建设银行'],
	['广发银行', '广发银行'],
	['兴业银行', '兴业银行'],
	['招商银行', '招商银行'],
	['中国民生银行', '民生银行'],
	['浙商银行', '浙商银行'],
	['华夏银行', '华夏银行'],
	['中国工商银行', '工商银行'],
	['平安银行', '平安银行'],
	['中国邮政储蓄银行', '邮储银行'],
	['浦发银行', '浦发银行']
]);

const tierMap = new Map([
	['Standard', '普卡'],
	['Gold', '金卡'],
	['Platinum', '白金卡'],
	['Diamond', '钻石卡'],
	['Infinite', '无限卡'],
	['Signature', '御玺卡'],
	['World', '世界卡'],
	['World Elite', '世界之极卡'],
	['Titanium', '钛金卡']
]);

const imageDir = path.join(root, 'static/images/cards/cardentify');
const migrationPath = path.join(root, 'migrations/0012_import_cardentify_cards.sql');
const summaryPath = path.join(root, 'docs/cardentify-import.md');

function sql(value) {
	if (value == null || value === '') return 'NULL';
	return `'${String(value).replaceAll("'", "''")}'`;
}

function slugify(input) {
	const ascii = input
		.normalize('NFKD')
		.replace(/[^\w\s-]/g, '')
		.trim()
		.toLowerCase()
		.replace(/[-\s]+/g, '-')
		.replace(/^-+|-+$/g, '');
	if (ascii) return ascii.slice(0, 80);
	return crypto.createHash('sha1').update(input).digest('hex').slice(0, 12);
}

function findCardImage(bankDir, card) {
	const ext = card.ext || 'png';
	const exact = path.join(bankDir, `${card.description}.${ext}`);
	if (fs.existsSync(exact)) return exact;

	const files = fs.readdirSync(bankDir);
	const matched = files.find((file) => {
		const parsed = path.parse(file);
		return parsed.name === card.description && parsed.ext.slice(1).toLowerCase() === ext.toLowerCase();
	});
	return matched ? path.join(bankDir, matched) : null;
}

function inferTags(card) {
	const tags = ['Cardentify'];
	if (card.card?.type === 'Credit') tags.push('信用卡');
	else if (card.card?.type === 'Debit') tags.push('借记卡');
	else if (card.card?.type) tags.push(`类型:${card.card.type}`);
	if (card.source) tags.push(`来源:${card.source}`);
	if (Array.isArray(card.bin) && card.bin.length > 0) tags.push(`BIN:${card.bin.join('/')}`);
	return tags.join(',');
}

function collectRows() {
	const rows = [];
	const bankDirs = importAll
		? fs
				.readdirSync(path.join(sourceRoot, 'Cards'), { withFileTypes: true })
				.filter((entry) => entry.isDirectory())
				.map((entry) => entry.name)
				.sort()
		: selectedBanks;

	for (const bankDirName of bankDirs) {
		const bankDir = path.join(sourceRoot, 'Cards', bankDirName);
		const dataPath = path.join(bankDir, 'data.json');
		if (!fs.existsSync(dataPath)) continue;

		const data = JSON.parse(fs.readFileSync(dataPath, 'utf8'));
		const originalBankName = data.bank.native_name || data.bank.english_name || bankDirName;
		const bankName = bankNameMap.get(originalBankName) ?? originalBankName;
		const cards = importAll
			? data.cards.filter((card) => allowedCountries.has(card.card?.country || data.bank.country || 'UNKNOWN'))
			: data.cards.filter((card) => card.card?.country === 'CN' && card.card?.type === 'Credit');
		for (const card of cards) {
			const imagePath = findCardImage(bankDir, card);
			if (!imagePath) {
				console.warn(`Missing image: ${bankDirName}/${card.description}.${card.ext}`);
				continue;
			}

			const sourceExt = path.extname(imagePath).slice(1).toLowerCase() || (card.ext ?? 'png');
			const ext = sourceExt === 'svg' ? 'svg' : 'jpg';
			const fileBase = `${slugify(bankName)}-${slugify(card.description)}-${crypto
				.createHash('sha1')
				.update(`${bankDirName}/${card.description}`)
				.digest('hex')
				.slice(0, 8)}`;
			const fileName = `${fileBase}.${ext}`;
			const targetPath = path.join(imageDir, fileName);
			const imageUrl = `/images/cards/cardentify/${fileName}`;
			const country = card.card?.country || data.bank.country || 'UNKNOWN';
			const network = card.card?.brand ?? null;
			const cardTier = tierMap.get(card.card?.level) ?? card.card?.level ?? null;
			const notes = `Cardentify import; original bank: ${originalBankName}; type: ${card.card?.type ?? 'unknown'}; source: ${card.source ?? 'unknown'}`;

			rows.push({
				country,
				bankName,
				cardName: card.description,
				cardTier,
				network,
				tags: inferTags(card),
				imageUrl,
				notes,
				sourceImage: imagePath,
				sourceExt,
				targetPath
			});
		}
	}
	return rows;
}

function convertImage(row) {
	if (row.sourceExt === 'svg') {
		fs.copyFileSync(row.sourceImage, row.targetPath);
		return;
	}

	try {
		execFileSync('sips', ['-s', 'format', 'jpeg', '-s', 'formatOptions', '80', row.sourceImage, '--out', row.targetPath], {
			stdio: 'ignore'
		});
	} catch {
		fs.copyFileSync(row.sourceImage, row.targetPath);
	}
}

function writeAssets(rows) {
	fs.rmSync(imageDir, { recursive: true, force: true });
	fs.mkdirSync(imageDir, { recursive: true });
	for (const row of rows) {
		convertImage(row);
	}
}

function writeMigration(rows) {
	const lines = [
		importAll
			? '-- Import all card faces from HarukaKinen/Cardentify.'
			: '-- Import selected CN credit card faces from HarukaKinen/Cardentify.',
		'-- Source: https://github.com/HarukaKinen/Cardentify',
		'-- Note: upstream repository does not currently declare an explicit license; verify usage rights before broad redistribution.',
		''
	];

	for (const row of rows) {
		lines.push(
			`INSERT INTO card_catalog (country, bank_name, card_name, card_tier, network, tags, image_url, variants, annual_fee_cny, notes)`,
			`SELECT ${sql(row.country)}, ${sql(row.bankName)}, ${sql(row.cardName)}, ${sql(row.cardTier)}, ${sql(row.network)}, ${sql(row.tags)}, ${sql(row.imageUrl)}, NULL, NULL, ${sql(row.notes)}`,
			`WHERE NOT EXISTS (SELECT 1 FROM card_catalog WHERE country = ${sql(row.country)} AND bank_name = ${sql(row.bankName)} AND card_name = ${sql(row.cardName)});`,
			`UPDATE card_catalog SET image_url = CASE WHEN image_url IS NULL OR image_url LIKE '/images/cards/cardentify/%' THEN ${sql(row.imageUrl)} ELSE image_url END, network = COALESCE(network, ${sql(row.network)}), tags = COALESCE(tags, ${sql(row.tags)}), notes = COALESCE(notes, ${sql(row.notes)}) WHERE country = ${sql(row.country)} AND bank_name = ${sql(row.bankName)} AND card_name = ${sql(row.cardName)};`,
			''
		);
	}

	fs.writeFileSync(migrationPath, `${lines.join('\n')}\n`);
}

function writeSummary(rows) {
	const byBank = new Map();
	const byCountry = new Map();
	const byType = new Map();
	for (const row of rows) byBank.set(row.bankName, (byBank.get(row.bankName) ?? 0) + 1);
	for (const row of rows) byCountry.set(row.country, (byCountry.get(row.country) ?? 0) + 1);
	for (const row of rows) {
		const type = row.tags.includes('信用卡') ? '信用卡' : row.tags.includes('借记卡') ? '借记卡' : '其它';
		byType.set(type, (byType.get(type) ?? 0) + 1);
	}
	const lines = [
		'# Cardentify Import',
		'',
		`- Source: https://github.com/HarukaKinen/Cardentify`,
		`- Imported cards: ${rows.length}`,
		`- Image directory: \`static/images/cards/cardentify/\``,
		`- Migration: \`${path.relative(root, migrationPath)}\``,
		importAll
			? '- Scope: all cards with available image files.'
			: '- Scope: CN credit cards from selected common banks; debit cards were skipped.',
		'- License note: upstream repository does not currently declare an explicit license. Treat these assets as review/reference material until usage rights are confirmed.',
		'',
		'## Countries',
		''
	];
	for (const [country, count] of [...byCountry.entries()].sort((a, b) => b[1] - a[1])) {
		lines.push(`- ${country}: ${count}`);
	}
	lines.push(
		'',
		'## Types',
		''
	);
	for (const [type, count] of [...byType.entries()].sort((a, b) => b[1] - a[1])) {
		lines.push(`- ${type}: ${count}`);
	}
	lines.push(
		'',
		'## Banks',
		''
	);
	for (const [bank, count] of [...byBank.entries()].sort((a, b) => a[0].localeCompare(b[0], 'zh-Hans-CN'))) {
		lines.push(`- ${bank}: ${count}`);
	}
	fs.writeFileSync(summaryPath, `${lines.join('\n')}\n`);
}

function applyLocal() {
	if (!fs.existsSync(localDbPath)) {
		throw new Error(`Local D1 sqlite not found: ${localDbPath}`);
	}
	execFileSync('sqlite3', [localDbPath], {
		input: fs.readFileSync(migrationPath),
		stdio: ['pipe', 'inherit', 'inherit']
	});
}

const rows = collectRows();
writeAssets(rows);
writeMigration(rows);
writeSummary(rows);
if (shouldApplyLocal) applyLocal();

console.log(`Imported ${rows.length} cards from Cardentify.`);
console.log(`Images: ${path.relative(root, imageDir)}`);
console.log(`Migration: ${path.relative(root, migrationPath)}`);
console.log(`Summary: ${path.relative(root, summaryPath)}`);
