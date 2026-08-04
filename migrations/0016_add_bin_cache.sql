-- BIN 查询结果缓存。
-- binlist 免费额度只有 5 次/小时，靠这张表把同一个 BIN 的重复查询挡在本地。
-- found = 0 表示 binlist 返回 404（查无此 BIN），这种结果同样缓存，避免反复消耗额度。

CREATE TABLE IF NOT EXISTS bin_cache (
  bin TEXT PRIMARY KEY,
  found INTEGER NOT NULL DEFAULT 0,
  scheme TEXT,
  brand TEXT,
  card_type TEXT,
  prepaid INTEGER,
  country_alpha2 TEXT,
  country_name TEXT,
  country_emoji TEXT,
  country_currency TEXT,
  bank_name TEXT,
  bank_url TEXT,
  bank_phone TEXT,
  bank_city TEXT,
  fetched_at INTEGER NOT NULL
);

CREATE INDEX IF NOT EXISTS idx_bin_cache_fetched_at ON bin_cache(fetched_at);
