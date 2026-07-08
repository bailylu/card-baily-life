CREATE TABLE IF NOT EXISTS lounge_comments (
  id TEXT PRIMARY KEY,
  record_seq TEXT NOT NULL,
  channel_id TEXT NOT NULL,
  user_id TEXT NOT NULL REFERENCES users(id) ON DELETE CASCADE,
  user_email TEXT NOT NULL,
  body TEXT NOT NULL,
  created_at INTEGER NOT NULL
);

CREATE INDEX IF NOT EXISTS lounge_comments_target_idx
  ON lounge_comments(record_seq, channel_id, created_at);
