-- Link local users to Clerk identities and track the notify config mirror freshness.
ALTER TABLE users ADD COLUMN clerk_user_id TEXT;
ALTER TABLE users ADD COLUMN notify_synced_at INTEGER;
CREATE UNIQUE INDEX users_clerk_user_id_idx ON users(clerk_user_id);
