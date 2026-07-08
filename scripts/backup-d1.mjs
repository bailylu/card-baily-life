import { copyFileSync, mkdirSync, rmSync } from 'node:fs';
import { spawnSync } from 'node:child_process';
import path from 'node:path';

const root = path.resolve(import.meta.dirname, '..');
const database = process.argv[2] ?? 'card-baily-life';
const stamp = new Date().toISOString().replace(/[:.]/g, '-');
const outputDir = path.join(root, 'secure-backups', 'd1');
const output = path.join(outputDir, `${database}-${stamp}.sql`);
const compressedOutput = `${output}.gz`;
const targetDir = process.env.D1_BACKUP_TARGET_DIR;

mkdirSync(outputDir, { recursive: true });

const result = spawnSync(
	'npx',
	['wrangler', 'd1', 'export', database, '--remote', '--output', output, '--skip-confirmation'],
	{
		cwd: root,
		encoding: 'utf8'
	}
);

const scrubWranglerOutput = (value) =>
	value
		.split('\n')
		.filter((line) => !line.includes('X-Amz-Signature=') && !line.includes('d1-sqlio-outgoing-prod'))
		.join('\n')
		.trim();

const stdout = scrubWranglerOutput(result.stdout ?? '');
const stderr = scrubWranglerOutput(result.stderr ?? '');
if (stdout) {
	console.log(stdout);
}
if (stderr) {
	console.error(stderr);
}

if (result.status !== 0) {
	process.exit(result.status ?? 1);
}

const gzip = spawnSync('gzip', ['-f', output], {
	cwd: root,
	stdio: 'inherit'
});

if (gzip.status !== 0) {
	process.exit(gzip.status ?? 1);
}

console.log(`D1 backup written to ${path.relative(root, compressedOutput)}`);

if (targetDir) {
	const targetPath = path.resolve(targetDir);
	mkdirSync(targetPath, { recursive: true });
	const remoteCopy = path.join(targetPath, path.basename(compressedOutput));
	copyFileSync(compressedOutput, remoteCopy);
	console.log(`D1 backup copied to ${remoteCopy}`);
}

const retentionDays = Number(process.env.D1_BACKUP_RETENTION_DAYS ?? 30);
if (Number.isFinite(retentionDays) && retentionDays > 0) {
	for (const dir of [outputDir, targetDir].filter(Boolean)) {
		const find = spawnSync('find', [path.resolve(dir), '-name', `${database}-*.sql.gz`, '-type', 'f', '-mtime', `+${retentionDays}`, '-print'], {
			cwd: root,
			encoding: 'utf8'
		});

		if (find.status !== 0) {
			continue;
		}

		for (const file of find.stdout.split('\n').filter(Boolean)) {
			rmSync(file, { force: true });
			console.log(`Removed expired backup ${file}`);
		}
	}
}
