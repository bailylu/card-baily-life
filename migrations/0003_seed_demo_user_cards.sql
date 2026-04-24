INSERT INTO users (id, email, created_at, last_login_at)
VALUES ('open-test-user', 'open-test@card.baily.life', unixepoch(), unixepoch())
ON CONFLICT(id) DO NOTHING;

INSERT INTO user_cards (
  id,
  user_id,
  catalog_id,
  custom_name,
  last_four,
  statement_day,
  due_day,
  annual_fee_month,
  annual_fee_day,
  lead_days,
  created_at
)
SELECT
  'demo-cmb-platinum',
  'open-test-user',
  id,
  NULL,
  '0318',
  5,
  23,
  3,
  18,
  3,
  unixepoch()
FROM card_catalog
WHERE bank_name = '招商银行' AND card_name = '经典白金信用卡'
ON CONFLICT(id) DO NOTHING;

INSERT INTO user_cards (
  id,
  user_id,
  catalog_id,
  custom_name,
  last_four,
  statement_day,
  due_day,
  annual_fee_month,
  annual_fee_day,
  lead_days,
  created_at
)
SELECT
  'demo-ccb-global',
  'open-test-user',
  id,
  NULL,
  '9527',
  12,
  30,
  NULL,
  NULL,
  5,
  unixepoch()
FROM card_catalog
WHERE bank_name = '建设银行' AND card_name = '龙卡全球支付信用卡'
ON CONFLICT(id) DO NOTHING;

INSERT INTO user_cards (
  id,
  user_id,
  catalog_id,
  custom_name,
  last_four,
  statement_day,
  due_day,
  annual_fee_month,
  annual_fee_day,
  lead_days,
  created_at
)
SELECT
  'demo-spdb-amex',
  'open-test-user',
  id,
  NULL,
  '8888',
  20,
  8,
  8,
  8,
  7,
  unixepoch()
FROM card_catalog
WHERE bank_name = '浦发银行' AND card_name = '美国运通白金信用卡'
ON CONFLICT(id) DO NOTHING;

INSERT INTO user_cards (
  id,
  user_id,
  catalog_id,
  custom_name,
  last_four,
  statement_day,
  due_day,
  annual_fee_month,
  annual_fee_day,
  lead_days,
  created_at
)
VALUES (
  'demo-custom-green',
  'open-test-user',
  NULL,
  '测试绿色生活卡',
  '6666',
  28,
  15,
  12,
  31,
  3,
  unixepoch()
)
ON CONFLICT(id) DO NOTHING;
