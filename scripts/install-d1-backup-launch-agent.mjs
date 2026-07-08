import { mkdirSync, writeFileSync } from 'node:fs';
import { homedir } from 'node:os';
import path from 'node:path';
import { spawnSync } from 'node:child_process';

const root = path.resolve(import.meta.dirname, '..');
const label = 'life.baily.card.d1-backup';
const launchAgentsDir = path.join(homedir(), 'Library', 'LaunchAgents');
const plistPath = path.join(launchAgentsDir, `${label}.plist`);
const logDir = path.join(root, 'secure-backups', 'logs');
const targetDir = process.env.D1_BACKUP_TARGET_DIR ?? '';
const retentionDays = process.env.D1_BACKUP_RETENTION_DAYS ?? '30';
const intervalDays = Number(process.env.D1_BACKUP_INTERVAL_DAYS ?? 1);
const startIntervalSeconds =
	Number.isFinite(intervalDays) && intervalDays > 0 ? Math.round(intervalDays * 24 * 60 * 60) : 24 * 60 * 60;

mkdirSync(launchAgentsDir, { recursive: true });
mkdirSync(logDir, { recursive: true });

const env = [
	'<key>PATH</key>',
	'<string>/opt/homebrew/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin</string>',
	'<key>D1_BACKUP_RETENTION_DAYS</key>',
	`<string>${retentionDays}</string>`
];

if (targetDir) {
	env.push('<key>D1_BACKUP_TARGET_DIR</key>', `<string>${targetDir}</string>`);
}

const plist = `<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
	<key>Label</key>
	<string>${label}</string>
	<key>ProgramArguments</key>
	<array>
		<string>/usr/bin/env</string>
		<string>npm</string>
		<string>run</string>
		<string>backup:d1</string>
	</array>
	<key>WorkingDirectory</key>
	<string>${root}</string>
	<key>EnvironmentVariables</key>
	<dict>
		${env.join('\n\t\t')}
	</dict>
	<key>StartInterval</key>
	<integer>${startIntervalSeconds}</integer>
	<key>StandardOutPath</key>
	<string>${path.join(logDir, 'd1-backup.out.log')}</string>
	<key>StandardErrorPath</key>
	<string>${path.join(logDir, 'd1-backup.err.log')}</string>
</dict>
</plist>
`;

writeFileSync(plistPath, plist);

spawnSync('launchctl', ['unload', plistPath], { stdio: 'ignore' });
const load = spawnSync('launchctl', ['load', plistPath], { stdio: 'inherit' });

if (load.status !== 0) {
	process.exit(load.status ?? 1);
}

console.log(`Installed D1 backup LaunchAgent: ${plistPath}`);
console.log(`Schedule: every ${intervalDays} day(s) after the agent is loaded`);
console.log(`Retention: ${retentionDays} day(s)`);
if (targetDir) {
	console.log(`Cloud copy target: ${targetDir}`);
} else {
	console.log('Cloud copy target: not set. Set D1_BACKUP_TARGET_DIR before installing to copy backups to Google Drive or another sync folder.');
}
