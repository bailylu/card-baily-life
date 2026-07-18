import { execSync } from 'node:child_process';
import { chmodSync, existsSync } from 'node:fs';

const hooksDir = 'scripts/git-hooks';

if (!existsSync('.git')) {
	process.exit(0);
}

chmodSync(`${hooksDir}/pre-commit`, 0o755);
execSync(`git config core.hooksPath ${hooksDir}`);
console.log(`Git hooks path set to ${hooksDir}.`);
