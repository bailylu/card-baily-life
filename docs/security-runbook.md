# Security Runbook

This project stores user card reminder settings, notification channels, lounge comments, and auth/session records. Treat the D1 database and Cloudflare/Clerk secrets as sensitive production assets.

## Routine Checklist

- Keep Cloudflare, GitHub, Clerk, and email/provider accounts on hardware-key or authenticator MFA.
- Do not commit `.dev.vars`, `.env*`, `.wrangler`, `.claude`, `backups`, `secure-backups`, SQLite files, or exported SQL backups.
- Use Cloudflare Pages environment variables/secrets for production secrets. Rotate secrets after contractor, device, or token changes.
- Review GitHub deploy keys/tokens and Cloudflare API tokens monthly. Prefer least-privilege tokens.
- Run `npm run check`, `npm test`, and `npm run build` before deploy.

## Database Backup

Create a remote D1 SQL export before risky deploys, schema changes, or bulk data edits:

```bash
npm run backup:d1
```

The export is compressed as `.sql.gz`, written to `secure-backups/d1/`, and ignored by Git. Move important backups to an encrypted external location after export.

To also copy each backup into Google Drive or another synced folder, set `D1_BACKUP_TARGET_DIR`:

```bash
D1_BACKUP_TARGET_DIR="$HOME/Library/CloudStorage/GoogleDrive-ACCOUNT/My Drive/card-baily-life-d1" npm run backup:d1
```

On macOS, install an automatic backup job:

```bash
D1_BACKUP_TARGET_DIR="/path/to/Google Drive/card-baily-life-d1" npm run backup:d1:install
```

The scheduled job runs daily and keeps 30 days by default. Override the cadence and retention with `D1_BACKUP_INTERVAL_DAYS` and `D1_BACKUP_RETENTION_DAYS`:

```bash
D1_BACKUP_TARGET_DIR="$HOME/Library/Mobile Documents/com~apple~CloudDocs/card-baily-life-d1-backups" D1_BACKUP_INTERVAL_DAYS=7 D1_BACKUP_RETENTION_DAYS=30 npm run backup:d1:install
```

Recommended cadence:

- Before every migration or large import.
- Daily while the product is actively changing.
- Weekly long-term archive.

## Restore / Incident Response

If data is deleted or corrupted:

1. Stop writes by disabling risky admin actions or pausing deployment traffic if needed.
2. Identify the last known good backup or Cloudflare D1 Time Travel bookmark.
3. Prefer restoring into a fork/copy first, then inspect row counts and important user records.
4. Restore production only after verifying the candidate database.
5. Rotate Cloudflare API tokens, Clerk secret keys, CRM/API provider keys, and reminder/admin tokens if compromise is possible.
6. Check GitHub recent commits, Cloudflare Pages deployments, D1 query history/insights, and admin logs.

## Secret Rotation Priority

1. Cloudflare account/API tokens and Pages deployment access.
2. Clerk secret key and publishable key/domain configuration.
3. D1 database access via Cloudflare account permissions.
4. `REMINDER_RUN_TOKEN`, `CRM_API_KEY`, MiniMax/API provider keys, Telegram/admin bot tokens.
5. Any local `.dev.vars` copies on developer machines.

## Application Controls

- Session cookies are HttpOnly, Secure in production, SameSite=Lax.
- Admin routes should require an authenticated local user and an allowlisted admin email from environment configuration.
- Destructive data operations should be scoped to the current `locals.user.id`.
- Public endpoints that trigger side effects must require a secret token or authenticated session.
- Avoid logging magic links, tokens, raw secrets, or user notification channel config in production logs.
