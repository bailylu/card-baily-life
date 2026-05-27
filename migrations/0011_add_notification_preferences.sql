CREATE TABLE IF NOT EXISTS notification_preferences (
  user_id TEXT PRIMARY KEY REFERENCES users(id) ON DELETE CASCADE,
  statement_enabled INTEGER NOT NULL DEFAULT 1,
  due_enabled INTEGER NOT NULL DEFAULT 1,
  annual_fee_enabled INTEGER NOT NULL DEFAULT 1,
  offer_enabled INTEGER NOT NULL DEFAULT 0,
  updated_at INTEGER NOT NULL
);
