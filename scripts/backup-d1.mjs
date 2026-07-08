import { mkdirSync } from 'node:fs';
import { spawnSync } from 'node:child_process';
import path from 'node:path';

const root = path.resolve(import.meta.dirname, '..');
const database = process.argv[2] ?? 'card-baily-life';
const stamp = new Date().toISOString().replace(/[:.]/g, '-');
const outputDir = path.join(root, 'secure-backups', 'd1');
const output = path.join(outputDir, `${database}-${stamp}.sql`);

mkdirSync(outputDir, { recursive: true });

const result = spawnSync(
	'npx',
	['wrangler', 'd1', 'export', database, '--remote', '--output', output, '--skip-confirmation'],
	{
		cwd: root,
		stdio: 'inherit'
	}
);

if (result.status !== 0) {
	process.exit(result.status ?? 1);
}

console.log(`D1 backup written to ${path.relative(root, output)}`);
