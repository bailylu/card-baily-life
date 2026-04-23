CREATE TABLE allowlist (
  email TEXT PRIMARY KEY,
  note TEXT,
  added_at INTEGER NOT NULL
);

CREATE TABLE users (
  id TEXT PRIMARY KEY,
  email TEXT UNIQUE NOT NULL,
  created_at INTEGER NOT NULL,
  last_login_at INTEGER
);

CREATE TABLE magic_links (
  token TEXT PRIMARY KEY,
  email TEXT NOT NULL,
  expires_at INTEGER NOT NULL,
  used_at INTEGER
);

CREATE TABLE sessions (
  id TEXT PRIMARY KEY,
  user_id TEXT NOT NULL REFERENCES users(id),
  expires_at INTEGER NOT NULL,
  created_at INTEGER NOT NULL
);

CREATE TABLE card_catalog (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  country TEXT NOT NULL,
  bank_name TEXT NOT NULL,
  card_name TEXT NOT NULL,
  card_tier TEXT,
  image_url TEXT,
  annual_fee_cny INTEGER,
  notes TEXT
);

CREATE TABLE user_cards (
  id TEXT PRIMARY KEY,
  user_id TEXT NOT NULL REFERENCES users(id) ON DELETE CASCADE,
  catalog_id INTEGER REFERENCES card_catalog(id),
  custom_name TEXT,
  last_four TEXT NOT NULL,
  statement_day INTEGER NOT NULL,
  due_day INTEGER NOT NULL,
  annual_fee_month INTEGER,
  annual_fee_day INTEGER,
  lead_days INTEGER NOT NULL DEFAULT 3,
  created_at INTEGER NOT NULL,
  CHECK (catalog_id IS NOT NULL OR custom_name IS NOT NULL),
  CHECK (statement_day BETWEEN 1 AND 31),
  CHECK (due_day BETWEEN 1 AND 31)
);

CREATE TABLE notification_channels (
  id TEXT PRIMARY KEY,
  user_id TEXT NOT NULL REFERENCES users(id) ON DELETE CASCADE,
  type TEXT NOT NULL,
  config TEXT NOT NULL,
  enabled INTEGER NOT NULL DEFAULT 1,
  created_at INTEGER NOT NULL
);

CREATE TABLE reminder_sent (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  user_card_id TEXT NOT NULL,
  reminder_type TEXT NOT NULL,
  target_date TEXT NOT NULL,
  channel TEXT NOT NULL,
  sent_at INTEGER NOT NULL,
  UNIQUE (user_card_id, reminder_type, target_date, channel)
);

-- 初始白名单（你自己）
INSERT INTO allowlist (email, note, added_at) VALUES
  ('bailytalk0318@gmail.com', '管理员', unixepoch());
