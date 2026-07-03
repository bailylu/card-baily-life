-- Import all card faces from HarukaKinen/Cardentify.
-- Source: https://github.com/HarukaKinen/Cardentify
-- Note: upstream repository does not currently declare an explicit license; verify usage rights before broad redistribution.

INSERT INTO card_catalog (country, bank_name, card_name, card_tier, network, tags, image_url, variants, annual_fee_cny, notes)
SELECT 'JP', 'アプラス', 'Ｔカード プラス', '普卡', 'JCB', 'Cardentify,信用卡,来源:Apple Pay,BIN:358277', '/images/cards/cardentify/ae496c81a5a2-t-d931947f.svg', NULL, NULL, 'Cardentify import; original bank: アプラス; type: Credit; source: Apple Pay'
WHERE NOT EXISTS (SELECT 1 FROM card_catalog WHERE country = 'JP' AND bank_name = 'アプラス' AND card_name = 'Ｔカード プラス');
UPDATE card_catalog SET image_url = CASE WHEN image_url IS NULL OR image_url LIKE '/images/cards/cardentify/%' THEN '/images/cards/cardentify/ae496c81a5a2-t-d931947f.svg' ELSE image_url END, network = COALESCE(network, 'JCB'), tags = COALESCE(tags, 'Cardentify,信用卡,来源:Apple Pay,BIN:358277'), notes = COALESCE(notes, 'Cardentify import; original bank: アプラス; type: Credit; source: Apple Pay') WHERE country = 'JP' AND bank_name = 'アプラス' AND card_name = 'Ｔカード プラス';

INSERT INTO card_catalog (country, bank_name, card_name, card_tier, network, tags, image_url, variants, annual_fee_cny, notes)
SELECT 'JP', 'アプラス', 'アプラスカード (Mastercard)', '普卡', 'Mastercard', 'Cardentify,信用卡,来源:Apple Pay,BIN:521498', '/images/cards/cardentify/ae496c81a5a2-mastercard-b68f2a1b.jpg', NULL, NULL, 'Cardentify import; original bank: アプラス; type: Credit; source: Apple Pay'
WHERE NOT EXISTS (SELECT 1 FROM card_catalog WHERE country = 'JP' AND bank_name = 'アプラス' AND card_name = 'アプラスカード (Mastercard)');
UPDATE card_catalog SET image_url = CASE WHEN image_url IS NULL OR image_url LIKE '/images/cards/cardentify/%' THEN '/images/cards/cardentify/ae496c81a5a2-mastercard-b68f2a1b.jpg' ELSE image_url END, network = COALESCE(network, 'Mastercard'), tags = COALESCE(tags, 'Cardentify,信用卡,来源:Apple Pay,BIN:521498'), notes = COALESCE(notes, 'Cardentify import; original bank: アプラス; type: Credit; source: Apple Pay') WHERE country = 'JP' AND bank_name = 'アプラス' AND card_name = 'アプラスカード (Mastercard)';

INSERT INTO card_catalog (country, bank_name, card_name, card_tier, network, tags, image_url, variants, annual_fee_cny, notes)
SELECT 'JP', 'アークスRARAカード', 'アークスRARA JCB カード', '普卡', 'JCB', 'Cardentify,信用卡,来源:Apple Pay,BIN:354037', '/images/cards/cardentify/rara-rara-jcb-27c480b7.svg', NULL, NULL, 'Cardentify import; original bank: アークスRARAカード; type: Credit; source: Apple Pay'
WHERE NOT EXISTS (SELECT 1 FROM card_catalog WHERE country = 'JP' AND bank_name = 'アークスRARAカード' AND card_name = 'アークスRARA JCB カード');
UPDATE card_catalog SET image_url = CASE WHEN image_url IS NULL OR image_url LIKE '/images/cards/cardentify/%' THEN '/images/cards/cardentify/rara-rara-jcb-27c480b7.svg' ELSE image_url END, network = COALESCE(network, 'JCB'), tags = COALESCE(tags, 'Cardentify,信用卡,来源:Apple Pay,BIN:354037'), notes = COALESCE(notes, 'Cardentify import; original bank: アークスRARAカード; type: Credit; source: Apple Pay') WHERE country = 'JP' AND bank_name = 'アークスRARAカード' AND card_name = 'アークスRARA JCB カード';

INSERT INTO card_catalog (country, bank_name, card_name, card_tier, network, tags, image_url, variants, annual_fee_cny, notes)
SELECT 'JP', 'イオンカード', 'TGC CARD', '普卡', 'JCB', 'Cardentify,信用卡,来源:Apple Pay,BIN:358419', '/images/cards/cardentify/1e7da59a750e-tgc-card-e438ffdd.svg', NULL, NULL, 'Cardentify import; original bank: イオンカード; type: Credit; source: Apple Pay'
WHERE NOT EXISTS (SELECT 1 FROM card_catalog WHERE country = 'JP' AND bank_name = 'イオンカード' AND card_name = 'TGC CARD');
UPDATE card_catalog SET image_url = CASE WHEN image_url IS NULL OR image_url LIKE '/images/cards/cardentify/%' THEN '/images/cards/cardentify/1e7da59a750e-tgc-card-e438ffdd.svg' ELSE image_url END, network = COALESCE(network, 'JCB'), tags = COALESCE(tags, 'Cardentify,信用卡,来源:Apple Pay,BIN:358419'), notes = COALESCE(notes, 'Cardentify import; original bank: イオンカード; type: Credit; source: Apple Pay') WHERE country = 'JP' AND bank_name = 'イオンカード' AND card_name = 'TGC CARD';

INSERT INTO card_catalog (country, bank_name, card_name, card_tier, network, tags, image_url, variants, annual_fee_cny, notes)
SELECT 'CN', '农业银行', '悠然白金卡蓝色版', '白金卡', 'UnionPay', 'Cardentify,信用卡,来源:Apple Pay,BIN:625998', '/images/cards/cardentify/e6fbd563258c-be7fcc47df81-2f3178a4.jpg', NULL, NULL, 'Cardentify import; original bank: 中国农业银行; type: Credit; source: Apple Pay'
WHERE NOT EXISTS (SELECT 1 FROM card_catalog WHERE country = 'CN' AND bank_name = '农业银行' AND card_name = '悠然白金卡蓝色版');
UPDATE card_catalog SET image_url = CASE WHEN image_url IS NULL OR image_url LIKE '/images/cards/cardentify/%' THEN '/images/cards/cardentify/e6fbd563258c-be7fcc47df81-2f3178a4.jpg' ELSE image_url END, network = COALESCE(network, 'UnionPay'), tags = COALESCE(tags, 'Cardentify,信用卡,来源:Apple Pay,BIN:625998'), notes = COALESCE(notes, 'Cardentify import; original bank: 中国农业银行; type: Credit; source: Apple Pay') WHERE country = 'CN' AND bank_name = '农业银行' AND card_name = '悠然白金卡蓝色版';

INSERT INTO card_catalog (country, bank_name, card_name, card_tier, network, tags, image_url, variants, annual_fee_cny, notes)
SELECT 'CN', '农业银行', '金穗借记卡普卡', '普卡', 'UnionPay', 'Cardentify,借记卡,来源:Apple Pay,BIN:622848', '/images/cards/cardentify/e6fbd563258c-98709c4fb4b0-fb016a2b.jpg', NULL, NULL, 'Cardentify import; original bank: 中国农业银行; type: Debit; source: Apple Pay'
WHERE NOT EXISTS (SELECT 1 FROM card_catalog WHERE country = 'CN' AND bank_name = '农业银行' AND card_name = '金穗借记卡普卡');
UPDATE card_catalog SET image_url = CASE WHEN image_url IS NULL OR image_url LIKE '/images/cards/cardentify/%' THEN '/images/cards/cardentify/e6fbd563258c-98709c4fb4b0-fb016a2b.jpg' ELSE image_url END, network = COALESCE(network, 'UnionPay'), tags = COALESCE(tags, 'Cardentify,借记卡,来源:Apple Pay,BIN:622848'), notes = COALESCE(notes, 'Cardentify import; original bank: 中国农业银行; type: Debit; source: Apple Pay') WHERE country = 'CN' AND bank_name = '农业银行' AND card_name = '金穗借记卡普卡';

INSERT INTO card_catalog (country, bank_name, card_name, card_tier, network, tags, image_url, variants, annual_fee_cny, notes)
SELECT 'CN', '农业银行', '腹有诗书气自华（春）', '普卡', 'UnionPay', 'Cardentify,借记卡,来源:Apple Pay,BIN:622848', '/images/cards/cardentify/e6fbd563258c-7c11d94d8a24-6c85cffb.jpg', NULL, NULL, 'Cardentify import; original bank: 中国农业银行; type: Debit; source: Apple Pay'
WHERE NOT EXISTS (SELECT 1 FROM card_catalog WHERE country = 'CN' AND bank_name = '农业银行' AND card_name = '腹有诗书气自华（春）');
UPDATE card_catalog SET image_url = CASE WHEN image_url IS NULL OR image_url LIKE '/images/cards/cardentify/%' THEN '/images/cards/cardentify/e6fbd563258c-7c11d94d8a24-6c85cffb.jpg' ELSE image_url END, network = COALESCE(network, 'UnionPay'), tags = COALESCE(tags, 'Cardentify,借记卡,来源:Apple Pay,BIN:622848'), notes = COALESCE(notes, 'Cardentify import; original bank: 中国农业银行; type: Debit; source: Apple Pay') WHERE country = 'CN' AND bank_name = '农业银行' AND card_name = '腹有诗书气自华（春）';

INSERT INTO card_catalog (country, bank_name, card_name, card_tier, network, tags, image_url, variants, annual_fee_cny, notes)
SELECT 'HK', 'American Express', 'Platinum Credit Card', '白金卡', 'AMEX', 'Cardentify,信用卡,来源:Apple Pay,BIN:341282', '/images/cards/cardentify/american-express-platinum-credit-card-87fb2fb1.jpg', NULL, NULL, 'Cardentify import; original bank: American Express; type: Credit; source: Apple Pay'
WHERE NOT EXISTS (SELECT 1 FROM card_catalog WHERE country = 'HK' AND bank_name = 'American Express' AND card_name = 'Platinum Credit Card');
UPDATE card_catalog SET image_url = CASE WHEN image_url IS NULL OR image_url LIKE '/images/cards/cardentify/%' THEN '/images/cards/cardentify/american-express-platinum-credit-card-87fb2fb1.jpg' ELSE image_url END, network = COALESCE(network, 'AMEX'), tags = COALESCE(tags, 'Cardentify,信用卡,来源:Apple Pay,BIN:341282'), notes = COALESCE(notes, 'Cardentify import; original bank: American Express; type: Credit; source: Apple Pay') WHERE country = 'HK' AND bank_name = 'American Express' AND card_name = 'Platinum Credit Card';

INSERT INTO card_catalog (country, bank_name, card_name, card_tier, network, tags, image_url, variants, annual_fee_cny, notes)
SELECT 'US', 'American Express', 'Blue Cash Everyday', 'Everyday', 'AMEX', 'Cardentify,信用卡,来源:Apple Pay,BIN:341109', '/images/cards/cardentify/american-express-blue-cash-everyday-2e362f71.jpg', NULL, NULL, 'Cardentify import; original bank: American Express; type: Credit; source: Apple Pay'
WHERE NOT EXISTS (SELECT 1 FROM card_catalog WHERE country = 'US' AND bank_name = 'American Express' AND card_name = 'Blue Cash Everyday');
UPDATE card_catalog SET image_url = CASE WHEN image_url IS NULL OR image_url LIKE '/images/cards/cardentify/%' THEN '/images/cards/cardentify/american-express-blue-cash-everyday-2e362f71.jpg' ELSE image_url END, network = COALESCE(network, 'AMEX'), tags = COALESCE(tags, 'Cardentify,信用卡,来源:Apple Pay,BIN:341109'), notes = COALESCE(notes, 'Cardentify import; original bank: American Express; type: Credit; source: Apple Pay') WHERE country = 'US' AND bank_name = 'American Express' AND card_name = 'Blue Cash Everyday';

INSERT INTO card_catalog (country, bank_name, card_name, card_tier, network, tags, image_url, variants, annual_fee_cny, notes)
SELECT 'HK', 'American Express', 'American Express Explorer(TM) Credit Card', 'Explorer', 'AMEX', 'Cardentify,信用卡,来源:Apple Pay,BIN:379390', '/images/cards/cardentify/american-express-american-express-explorertm-credit-card-48549458.jpg', NULL, NULL, 'Cardentify import; original bank: American Express; type: Credit; source: Apple Pay'
WHERE NOT EXISTS (SELECT 1 FROM card_catalog WHERE country = 'HK' AND bank_name = 'American Express' AND card_name = 'American Express Explorer(TM) Credit Card');
UPDATE card_catalog SET image_url = CASE WHEN image_url IS NULL OR image_url LIKE '/images/cards/cardentify/%' THEN '/images/cards/cardentify/american-express-american-express-explorertm-credit-card-48549458.jpg' ELSE image_url END, network = COALESCE(network, 'AMEX'), tags = COALESCE(tags, 'Cardentify,信用卡,来源:Apple Pay,BIN:379390'), notes = COALESCE(notes, 'Cardentify import; original bank: American Express; type: Credit; source: Apple Pay') WHERE country = 'HK' AND bank_name = 'American Express' AND card_name = 'American Express Explorer(TM) Credit Card';

INSERT INTO card_catalog (country, bank_name, card_name, card_tier, network, tags, image_url, variants, annual_fee_cny, notes)
SELECT 'US', 'American Express', 'Hilton Honors American Express Aspire Card', '普卡', 'AMEX', 'Cardentify,信用卡,来源:Apple Pay,BIN:379799', '/images/cards/cardentify/american-express-hilton-honors-american-express-aspire-card-d0abd038.jpg', NULL, NULL, 'Cardentify import; original bank: American Express; type: Credit; source: Apple Pay'
WHERE NOT EXISTS (SELECT 1 FROM card_catalog WHERE country = 'US' AND bank_name = 'American Express' AND card_name = 'Hilton Honors American Express Aspire Card');
UPDATE card_catalog SET image_url = CASE WHEN image_url IS NULL OR image_url LIKE '/images/cards/cardentify/%' THEN '/images/cards/cardentify/american-express-hilton-honors-american-express-aspire-card-d0abd038.jpg' ELSE image_url END, network = COALESCE(network, 'AMEX'), tags = COALESCE(tags, 'Cardentify,信用卡,来源:Apple Pay,BIN:379799'), notes = COALESCE(notes, 'Cardentify import; original bank: American Express; type: Credit; source: Apple Pay') WHERE country = 'US' AND bank_name = 'American Express' AND card_name = 'Hilton Honors American Express Aspire Card';

INSERT INTO card_catalog (country, bank_name, card_name, card_tier, network, tags, image_url, variants, annual_fee_cny, notes)
SELECT 'US', 'American Express', 'Rewards Checking Card', '普卡', 'AMEX', 'Cardentify,借记卡,来源:Apple Pay,BIN:370914', '/images/cards/cardentify/american-express-rewards-checking-card-5bc7871b.jpg', NULL, NULL, 'Cardentify import; original bank: American Express; type: Debit; source: Apple Pay'
WHERE NOT EXISTS (SELECT 1 FROM card_catalog WHERE country = 'US' AND bank_name = 'American Express' AND card_name = 'Rewards Checking Card');
UPDATE card_catalog SET image_url = CASE WHEN image_url IS NULL OR image_url LIKE '/images/cards/cardentify/%' THEN '/images/cards/cardentify/american-express-rewards-checking-card-5bc7871b.jpg' ELSE image_url END, network = COALESCE(network, 'AMEX'), tags = COALESCE(tags, 'Cardentify,借记卡,来源:Apple Pay,BIN:370914'), notes = COALESCE(notes, 'Cardentify import; original bank: American Express; type: Debit; source: Apple Pay') WHERE country = 'US' AND bank_name = 'American Express' AND card_name = 'Rewards Checking Card';

INSERT INTO card_catalog (country, bank_name, card_name, card_tier, network, tags, image_url, variants, annual_fee_cny, notes)
SELECT 'US', 'Apple', 'Apple Cash', NULL, 'VISA', 'Cardentify,借记卡,来源:Apple Pay', '/images/cards/cardentify/apple-apple-cash-aa12c7a0.jpg', NULL, NULL, 'Cardentify import; original bank: Apple; type: Debit; source: Apple Pay'
WHERE NOT EXISTS (SELECT 1 FROM card_catalog WHERE country = 'US' AND bank_name = 'Apple' AND card_name = 'Apple Cash');
UPDATE card_catalog SET image_url = CASE WHEN image_url IS NULL OR image_url LIKE '/images/cards/cardentify/%' THEN '/images/cards/cardentify/apple-apple-cash-aa12c7a0.jpg' ELSE image_url END, network = COALESCE(network, 'VISA'), tags = COALESCE(tags, 'Cardentify,借记卡,来源:Apple Pay'), notes = COALESCE(notes, 'Cardentify import; original bank: Apple; type: Debit; source: Apple Pay') WHERE country = 'US' AND bank_name = 'Apple' AND card_name = 'Apple Cash';

INSERT INTO card_catalog (country, bank_name, card_name, card_tier, network, tags, image_url, variants, annual_fee_cny, notes)
SELECT 'US', 'Apple', 'Apple Card', '普卡', 'Mastercard', 'Cardentify,信用卡,来源:Apple Pay', '/images/cards/cardentify/apple-apple-card-32d4d320.jpg', NULL, NULL, 'Cardentify import; original bank: Apple; type: Credit; source: Apple Pay'
WHERE NOT EXISTS (SELECT 1 FROM card_catalog WHERE country = 'US' AND bank_name = 'Apple' AND card_name = 'Apple Card');
UPDATE card_catalog SET image_url = CASE WHEN image_url IS NULL OR image_url LIKE '/images/cards/cardentify/%' THEN '/images/cards/cardentify/apple-apple-card-32d4d320.jpg' ELSE image_url END, network = COALESCE(network, 'Mastercard'), tags = COALESCE(tags, 'Cardentify,信用卡,来源:Apple Pay'), notes = COALESCE(notes, 'Cardentify import; original bank: Apple; type: Credit; source: Apple Pay') WHERE country = 'US' AND bank_name = 'Apple' AND card_name = 'Apple Card';

INSERT INTO card_catalog (country, bank_name, card_name, card_tier, network, tags, image_url, variants, annual_fee_cny, notes)
SELECT 'TW', '永豐銀行', '現金回饋晶緻卡', 'Precious', 'JCB', 'Cardentify,信用卡,来源:Apple Pay,BIN:356670', '/images/cards/cardentify/d5e7cfe33407-ebc20b92e17a-1086d5b7.svg', NULL, NULL, 'Cardentify import; original bank: 永豐銀行; type: Credit; source: Apple Pay'
WHERE NOT EXISTS (SELECT 1 FROM card_catalog WHERE country = 'TW' AND bank_name = '永豐銀行' AND card_name = '現金回饋晶緻卡');
UPDATE card_catalog SET image_url = CASE WHEN image_url IS NULL OR image_url LIKE '/images/cards/cardentify/%' THEN '/images/cards/cardentify/d5e7cfe33407-ebc20b92e17a-1086d5b7.svg' ELSE image_url END, network = COALESCE(network, 'JCB'), tags = COALESCE(tags, 'Cardentify,信用卡,来源:Apple Pay,BIN:356670'), notes = COALESCE(notes, 'Cardentify import; original bank: 永豐銀行; type: Credit; source: Apple Pay') WHERE country = 'TW' AND bank_name = '永豐銀行' AND card_name = '現金回饋晶緻卡';

INSERT INTO card_catalog (country, bank_name, card_name, card_tier, network, tags, image_url, variants, annual_fee_cny, notes)
SELECT 'TW', '永豐銀行', '夢行鈦商悠遊卡', '钛金卡', 'Mastercard', 'Cardentify,信用卡,来源:Apple Pay,BIN:519923', '/images/cards/cardentify/d5e7cfe33407-3cf8a5663000-ec2d64cf.jpg', NULL, NULL, 'Cardentify import; original bank: 永豐銀行; type: Credit; source: Apple Pay'
WHERE NOT EXISTS (SELECT 1 FROM card_catalog WHERE country = 'TW' AND bank_name = '永豐銀行' AND card_name = '夢行鈦商悠遊卡');
UPDATE card_catalog SET image_url = CASE WHEN image_url IS NULL OR image_url LIKE '/images/cards/cardentify/%' THEN '/images/cards/cardentify/d5e7cfe33407-3cf8a5663000-ec2d64cf.jpg' ELSE image_url END, network = COALESCE(network, 'Mastercard'), tags = COALESCE(tags, 'Cardentify,信用卡,来源:Apple Pay,BIN:519923'), notes = COALESCE(notes, 'Cardentify import; original bank: 永豐銀行; type: Credit; source: Apple Pay') WHERE country = 'TW' AND bank_name = '永豐銀行' AND card_name = '夢行鈦商悠遊卡';

INSERT INTO card_catalog (country, bank_name, card_name, card_tier, network, tags, image_url, variants, annual_fee_cny, notes)
SELECT 'TW', '永豐銀行', '鈦豐卡', '钛金卡', 'Mastercard', 'Cardentify,信用卡,来源:Apple Pay,BIN:524196', '/images/cards/cardentify/d5e7cfe33407-6ae2aad5e91b-ebd465db.jpg', NULL, NULL, 'Cardentify import; original bank: 永豐銀行; type: Credit; source: Apple Pay'
WHERE NOT EXISTS (SELECT 1 FROM card_catalog WHERE country = 'TW' AND bank_name = '永豐銀行' AND card_name = '鈦豐卡');
UPDATE card_catalog SET image_url = CASE WHEN image_url IS NULL OR image_url LIKE '/images/cards/cardentify/%' THEN '/images/cards/cardentify/d5e7cfe33407-6ae2aad5e91b-ebd465db.jpg' ELSE image_url END, network = COALESCE(network, 'Mastercard'), tags = COALESCE(tags, 'Cardentify,信用卡,来源:Apple Pay,BIN:524196'), notes = COALESCE(notes, 'Cardentify import; original bank: 永豐銀行; type: Credit; source: Apple Pay') WHERE country = 'TW' AND bank_name = '永豐銀行' AND card_name = '鈦豐卡';

INSERT INTO card_catalog (country, bank_name, card_name, card_tier, network, tags, image_url, variants, annual_fee_cny, notes)
SELECT 'TW', '永豐銀行', '鈦豐Combo卡', '钛金卡', 'Mastercard', 'Cardentify,信用卡,来源:Apple Pay,BIN:524196', '/images/cards/cardentify/d5e7cfe33407-combo-6791a52b.jpg', NULL, NULL, 'Cardentify import; original bank: 永豐銀行; type: Credit; source: Apple Pay'
WHERE NOT EXISTS (SELECT 1 FROM card_catalog WHERE country = 'TW' AND bank_name = '永豐銀行' AND card_name = '鈦豐Combo卡');
UPDATE card_catalog SET image_url = CASE WHEN image_url IS NULL OR image_url LIKE '/images/cards/cardentify/%' THEN '/images/cards/cardentify/d5e7cfe33407-combo-6791a52b.jpg' ELSE image_url END, network = COALESCE(network, 'Mastercard'), tags = COALESCE(tags, 'Cardentify,信用卡,来源:Apple Pay,BIN:524196'), notes = COALESCE(notes, 'Cardentify import; original bank: 永豐銀行; type: Credit; source: Apple Pay') WHERE country = 'TW' AND bank_name = '永豐銀行' AND card_name = '鈦豐Combo卡';

INSERT INTO card_catalog (country, bank_name, card_name, card_tier, network, tags, image_url, variants, annual_fee_cny, notes)
SELECT 'TW', '永豐銀行', 'me Combo卡', '钛金卡', 'Mastercard', 'Cardentify,信用卡,来源:Apple Pay,BIN:524189', '/images/cards/cardentify/d5e7cfe33407-me-combo-dd7b1c21.jpg', NULL, NULL, 'Cardentify import; original bank: 永豐銀行; type: Credit; source: Apple Pay'
WHERE NOT EXISTS (SELECT 1 FROM card_catalog WHERE country = 'TW' AND bank_name = '永豐銀行' AND card_name = 'me Combo卡');
UPDATE card_catalog SET image_url = CASE WHEN image_url IS NULL OR image_url LIKE '/images/cards/cardentify/%' THEN '/images/cards/cardentify/d5e7cfe33407-me-combo-dd7b1c21.jpg' ELSE image_url END, network = COALESCE(network, 'Mastercard'), tags = COALESCE(tags, 'Cardentify,信用卡,来源:Apple Pay,BIN:524189'), notes = COALESCE(notes, 'Cardentify import; original bank: 永豐銀行; type: Credit; source: Apple Pay') WHERE country = 'TW' AND bank_name = '永豐銀行' AND card_name = 'me Combo卡';

INSERT INTO card_catalog (country, bank_name, card_name, card_tier, network, tags, image_url, variants, annual_fee_cny, notes)
SELECT 'TW', '永豐銀行', 'Vogue聯名Mastercard卡', '钛金卡', 'Mastercard', 'Cardentify,信用卡,来源:Apple Pay,BIN:524115', '/images/cards/cardentify/d5e7cfe33407-voguemastercard-09da964f.jpg', NULL, NULL, 'Cardentify import; original bank: 永豐銀行; type: Credit; source: Apple Pay'
WHERE NOT EXISTS (SELECT 1 FROM card_catalog WHERE country = 'TW' AND bank_name = '永豐銀行' AND card_name = 'Vogue聯名Mastercard卡');
UPDATE card_catalog SET image_url = CASE WHEN image_url IS NULL OR image_url LIKE '/images/cards/cardentify/%' THEN '/images/cards/cardentify/d5e7cfe33407-voguemastercard-09da964f.jpg' ELSE image_url END, network = COALESCE(network, 'Mastercard'), tags = COALESCE(tags, 'Cardentify,信用卡,来源:Apple Pay,BIN:524115'), notes = COALESCE(notes, 'Cardentify import; original bank: 永豐銀行; type: Credit; source: Apple Pay') WHERE country = 'TW' AND bank_name = '永豐銀行' AND card_name = 'Vogue聯名Mastercard卡';

INSERT INTO card_catalog (country, bank_name, card_name, card_tier, network, tags, image_url, variants, annual_fee_cny, notes)
SELECT 'US', 'Bank of America', 'Bank of America Visa Debit Card', 'Classic', 'VISA', 'Cardentify,借记卡,来源:Apple Pay,BIN:425628', '/images/cards/cardentify/bank-of-america-bank-of-america-visa-debit-card-fdcdfc3e.jpg', NULL, NULL, 'Cardentify import; original bank: Bank of America; type: Debit; source: Apple Pay'
WHERE NOT EXISTS (SELECT 1 FROM card_catalog WHERE country = 'US' AND bank_name = 'Bank of America' AND card_name = 'Bank of America Visa Debit Card');
UPDATE card_catalog SET image_url = CASE WHEN image_url IS NULL OR image_url LIKE '/images/cards/cardentify/%' THEN '/images/cards/cardentify/bank-of-america-bank-of-america-visa-debit-card-fdcdfc3e.jpg' ELSE image_url END, network = COALESCE(network, 'VISA'), tags = COALESCE(tags, 'Cardentify,借记卡,来源:Apple Pay,BIN:425628'), notes = COALESCE(notes, 'Cardentify import; original bank: Bank of America; type: Debit; source: Apple Pay') WHERE country = 'US' AND bank_name = 'Bank of America' AND card_name = 'Bank of America Visa Debit Card';

INSERT INTO card_catalog (country, bank_name, card_name, card_tier, network, tags, image_url, variants, annual_fee_cny, notes)
SELECT 'CN', '中国银行', '长城借记卡', '普卡', 'UnionPay', 'Cardentify,借记卡,来源:Apple Pay', '/images/cards/cardentify/73a77781b5e4-0a5d7f29e3ea-c45c6739.jpg', NULL, NULL, 'Cardentify import; original bank: 中国银行; type: Debit; source: Apple Pay'
WHERE NOT EXISTS (SELECT 1 FROM card_catalog WHERE country = 'CN' AND bank_name = '中国银行' AND card_name = '长城借记卡');
UPDATE card_catalog SET image_url = CASE WHEN image_url IS NULL OR image_url LIKE '/images/cards/cardentify/%' THEN '/images/cards/cardentify/73a77781b5e4-0a5d7f29e3ea-c45c6739.jpg' ELSE image_url END, network = COALESCE(network, 'UnionPay'), tags = COALESCE(tags, 'Cardentify,借记卡,来源:Apple Pay'), notes = COALESCE(notes, 'Cardentify import; original bank: 中国银行; type: Debit; source: Apple Pay') WHERE country = 'CN' AND bank_name = '中国银行' AND card_name = '长城借记卡';

INSERT INTO card_catalog (country, bank_name, card_name, card_tier, network, tags, image_url, variants, annual_fee_cny, notes)
SELECT 'CN', '中国银行', '长城洛天依联名借记卡', '普卡', 'UnionPay', 'Cardentify,借记卡,来源:Apple Pay,BIN:612790', '/images/cards/cardentify/73a77781b5e4-232240c7f240-01bdf85a.jpg', NULL, NULL, 'Cardentify import; original bank: 中国银行; type: Debit; source: Apple Pay'
WHERE NOT EXISTS (SELECT 1 FROM card_catalog WHERE country = 'CN' AND bank_name = '中国银行' AND card_name = '长城洛天依联名借记卡');
UPDATE card_catalog SET image_url = CASE WHEN image_url IS NULL OR image_url LIKE '/images/cards/cardentify/%' THEN '/images/cards/cardentify/73a77781b5e4-232240c7f240-01bdf85a.jpg' ELSE image_url END, network = COALESCE(network, 'UnionPay'), tags = COALESCE(tags, 'Cardentify,借记卡,来源:Apple Pay,BIN:612790'), notes = COALESCE(notes, 'Cardentify import; original bank: 中国银行; type: Debit; source: Apple Pay') WHERE country = 'CN' AND bank_name = '中国银行' AND card_name = '长城洛天依联名借记卡';

INSERT INTO card_catalog (country, bank_name, card_name, card_tier, network, tags, image_url, variants, annual_fee_cny, notes)
SELECT 'CN', '中国银行', '上海哔哩哔哩联名借记卡', '普卡', 'UnionPay', 'Cardentify,借记卡,来源:Apple Pay,BIN:612790', '/images/cards/cardentify/73a77781b5e4-312a61ee1d28-28a4fffa.jpg', NULL, NULL, 'Cardentify import; original bank: 中国银行; type: Debit; source: Apple Pay'
WHERE NOT EXISTS (SELECT 1 FROM card_catalog WHERE country = 'CN' AND bank_name = '中国银行' AND card_name = '上海哔哩哔哩联名借记卡');
UPDATE card_catalog SET image_url = CASE WHEN image_url IS NULL OR image_url LIKE '/images/cards/cardentify/%' THEN '/images/cards/cardentify/73a77781b5e4-312a61ee1d28-28a4fffa.jpg' ELSE image_url END, network = COALESCE(network, 'UnionPay'), tags = COALESCE(tags, 'Cardentify,借记卡,来源:Apple Pay,BIN:612790'), notes = COALESCE(notes, 'Cardentify import; original bank: 中国银行; type: Debit; source: Apple Pay') WHERE country = 'CN' AND bank_name = '中国银行' AND card_name = '上海哔哩哔哩联名借记卡';

INSERT INTO card_catalog (country, bank_name, card_name, card_tier, network, tags, image_url, variants, annual_fee_cny, notes)
SELECT 'CN', '中国银行', '中银无界数字白金卡', '白金卡', 'UnionPay', 'Cardentify,信用卡,来源:Apple Pay', '/images/cards/cardentify/73a77781b5e4-a4435ccc1e69-2ca6d800.jpg', NULL, NULL, 'Cardentify import; original bank: 中国银行; type: Credit; source: Apple Pay'
WHERE NOT EXISTS (SELECT 1 FROM card_catalog WHERE country = 'CN' AND bank_name = '中国银行' AND card_name = '中银无界数字白金卡');
UPDATE card_catalog SET image_url = CASE WHEN image_url IS NULL OR image_url LIKE '/images/cards/cardentify/%' THEN '/images/cards/cardentify/73a77781b5e4-a4435ccc1e69-2ca6d800.jpg' ELSE image_url END, network = COALESCE(network, 'UnionPay'), tags = COALESCE(tags, 'Cardentify,信用卡,来源:Apple Pay'), notes = COALESCE(notes, 'Cardentify import; original bank: 中国银行; type: Credit; source: Apple Pay') WHERE country = 'CN' AND bank_name = '中国银行' AND card_name = '中银无界数字白金卡';

INSERT INTO card_catalog (country, bank_name, card_name, card_tier, network, tags, image_url, variants, annual_fee_cny, notes)
SELECT 'CN', '中国银行', '长城工薪借记卡', '普卡', 'UnionPay', 'Cardentify,借记卡,来源:云闪付,BIN:621785', '/images/cards/cardentify/73a77781b5e4-d69f881d286c-a5750ba2.jpg', NULL, NULL, 'Cardentify import; original bank: 中国银行; type: Debit; source: 云闪付'
WHERE NOT EXISTS (SELECT 1 FROM card_catalog WHERE country = 'CN' AND bank_name = '中国银行' AND card_name = '长城工薪借记卡');
UPDATE card_catalog SET image_url = CASE WHEN image_url IS NULL OR image_url LIKE '/images/cards/cardentify/%' THEN '/images/cards/cardentify/73a77781b5e4-d69f881d286c-a5750ba2.jpg' ELSE image_url END, network = COALESCE(network, 'UnionPay'), tags = COALESCE(tags, 'Cardentify,借记卡,来源:云闪付,BIN:621785'), notes = COALESCE(notes, 'Cardentify import; original bank: 中国银行; type: Debit; source: 云闪付') WHERE country = 'CN' AND bank_name = '中国银行' AND card_name = '长城工薪借记卡';

INSERT INTO card_catalog (country, bank_name, card_name, card_tier, network, tags, image_url, variants, annual_fee_cny, notes)
SELECT 'CN', '中国银行', '长城薪享借记卡（金卡）', '金卡', 'UnionPay', 'Cardentify,借记卡,来源:Apple Pay,BIN:623573', '/images/cards/cardentify/73a77781b5e4-a57293d1b5d8-44ca4f3b.jpg', NULL, NULL, 'Cardentify import; original bank: 中国银行; type: Debit; source: Apple Pay'
WHERE NOT EXISTS (SELECT 1 FROM card_catalog WHERE country = 'CN' AND bank_name = '中国银行' AND card_name = '长城薪享借记卡（金卡）');
UPDATE card_catalog SET image_url = CASE WHEN image_url IS NULL OR image_url LIKE '/images/cards/cardentify/%' THEN '/images/cards/cardentify/73a77781b5e4-a57293d1b5d8-44ca4f3b.jpg' ELSE image_url END, network = COALESCE(network, 'UnionPay'), tags = COALESCE(tags, 'Cardentify,借记卡,来源:Apple Pay,BIN:623573'), notes = COALESCE(notes, 'Cardentify import; original bank: 中国银行; type: Debit; source: Apple Pay') WHERE country = 'CN' AND bank_name = '中国银行' AND card_name = '长城薪享借记卡（金卡）';

INSERT INTO card_catalog (country, bank_name, card_name, card_tier, network, tags, image_url, variants, annual_fee_cny, notes)
SELECT 'CN', '中国银行', '长城环球通信用卡（发卡30周年纪念）', '普卡', 'UnionPay', 'Cardentify,信用卡,来源:Apple Pay', '/images/cards/cardentify/73a77781b5e4-30-11a25809.jpg', NULL, NULL, 'Cardentify import; original bank: 中国银行; type: Credit; source: Apple Pay'
WHERE NOT EXISTS (SELECT 1 FROM card_catalog WHERE country = 'CN' AND bank_name = '中国银行' AND card_name = '长城环球通信用卡（发卡30周年纪念）');
UPDATE card_catalog SET image_url = CASE WHEN image_url IS NULL OR image_url LIKE '/images/cards/cardentify/%' THEN '/images/cards/cardentify/73a77781b5e4-30-11a25809.jpg' ELSE image_url END, network = COALESCE(network, 'UnionPay'), tags = COALESCE(tags, 'Cardentify,信用卡,来源:Apple Pay'), notes = COALESCE(notes, 'Cardentify import; original bank: 中国银行; type: Credit; source: Apple Pay') WHERE country = 'CN' AND bank_name = '中国银行' AND card_name = '长城环球通信用卡（发卡30周年纪念）';

INSERT INTO card_catalog (country, bank_name, card_name, card_tier, network, tags, image_url, variants, annual_fee_cny, notes)
SELECT 'CN', '中国银行', '长城冰雪借记卡', '白金卡', 'UnionPay', 'Cardentify,借记卡,来源:Apple Pay,BIN:621669', '/images/cards/cardentify/73a77781b5e4-82f50d907132-19235fca.jpg', NULL, NULL, 'Cardentify import; original bank: 中国银行; type: Debit; source: Apple Pay'
WHERE NOT EXISTS (SELECT 1 FROM card_catalog WHERE country = 'CN' AND bank_name = '中国银行' AND card_name = '长城冰雪借记卡');
UPDATE card_catalog SET image_url = CASE WHEN image_url IS NULL OR image_url LIKE '/images/cards/cardentify/%' THEN '/images/cards/cardentify/73a77781b5e4-82f50d907132-19235fca.jpg' ELSE image_url END, network = COALESCE(network, 'UnionPay'), tags = COALESCE(tags, 'Cardentify,借记卡,来源:Apple Pay,BIN:621669'), notes = COALESCE(notes, 'Cardentify import; original bank: 中国银行; type: Debit; source: Apple Pay') WHERE country = 'CN' AND bank_name = '中国银行' AND card_name = '长城冰雪借记卡';

INSERT INTO card_catalog (country, bank_name, card_name, card_tier, network, tags, image_url, variants, annual_fee_cny, notes)
SELECT 'CN', '中国银行', '茈凌2021', '普卡', 'UnionPay', 'Cardentify,借记卡,来源:Mi Pay', '/images/cards/cardentify/73a77781b5e4-2021-9d977d70.jpg', NULL, NULL, 'Cardentify import; original bank: 中国银行; type: Debit; source: Mi Pay'
WHERE NOT EXISTS (SELECT 1 FROM card_catalog WHERE country = 'CN' AND bank_name = '中国银行' AND card_name = '茈凌2021');
UPDATE card_catalog SET image_url = CASE WHEN image_url IS NULL OR image_url LIKE '/images/cards/cardentify/%' THEN '/images/cards/cardentify/73a77781b5e4-2021-9d977d70.jpg' ELSE image_url END, network = COALESCE(network, 'UnionPay'), tags = COALESCE(tags, 'Cardentify,借记卡,来源:Mi Pay'), notes = COALESCE(notes, 'Cardentify import; original bank: 中国银行; type: Debit; source: Mi Pay') WHERE country = 'CN' AND bank_name = '中国银行' AND card_name = '茈凌2021';

INSERT INTO card_catalog (country, bank_name, card_name, card_tier, network, tags, image_url, variants, annual_fee_cny, notes)
SELECT 'CN', '中国银行', '乡村振兴卡', '普卡', 'UnionPay', 'Cardentify,借记卡,来源:云闪付', '/images/cards/cardentify/73a77781b5e4-3eabb928cdb6-dba78efd.jpg', NULL, NULL, 'Cardentify import; original bank: 中国银行; type: Debit; source: 云闪付'
WHERE NOT EXISTS (SELECT 1 FROM card_catalog WHERE country = 'CN' AND bank_name = '中国银行' AND card_name = '乡村振兴卡');
UPDATE card_catalog SET image_url = CASE WHEN image_url IS NULL OR image_url LIKE '/images/cards/cardentify/%' THEN '/images/cards/cardentify/73a77781b5e4-3eabb928cdb6-dba78efd.jpg' ELSE image_url END, network = COALESCE(network, 'UnionPay'), tags = COALESCE(tags, 'Cardentify,借记卡,来源:云闪付'), notes = COALESCE(notes, 'Cardentify import; original bank: 中国银行; type: Debit; source: 云闪付') WHERE country = 'CN' AND bank_name = '中国银行' AND card_name = '乡村振兴卡';

INSERT INTO card_catalog (country, bank_name, card_name, card_tier, network, tags, image_url, variants, annual_fee_cny, notes)
SELECT 'CN', '中国银行', '牛年生肖卡', '普卡', 'UnionPay', 'Cardentify,借记卡,来源:云闪付', '/images/cards/cardentify/73a77781b5e4-16c15e02fdbb-40bad697.jpg', NULL, NULL, 'Cardentify import; original bank: 中国银行; type: Debit; source: 云闪付'
WHERE NOT EXISTS (SELECT 1 FROM card_catalog WHERE country = 'CN' AND bank_name = '中国银行' AND card_name = '牛年生肖卡');
UPDATE card_catalog SET image_url = CASE WHEN image_url IS NULL OR image_url LIKE '/images/cards/cardentify/%' THEN '/images/cards/cardentify/73a77781b5e4-16c15e02fdbb-40bad697.jpg' ELSE image_url END, network = COALESCE(network, 'UnionPay'), tags = COALESCE(tags, 'Cardentify,借记卡,来源:云闪付'), notes = COALESCE(notes, 'Cardentify import; original bank: 中国银行; type: Debit; source: 云闪付') WHERE country = 'CN' AND bank_name = '中国银行' AND card_name = '牛年生肖卡';

INSERT INTO card_catalog (country, bank_name, card_name, card_tier, network, tags, image_url, variants, annual_fee_cny, notes)
SELECT 'CN', '中国银行', '财富管理卡', '白金卡', 'UnionPay', 'Cardentify,借记卡,来源:云闪付', '/images/cards/cardentify/73a77781b5e4-1ccb32d6485e-79937081.jpg', NULL, NULL, 'Cardentify import; original bank: 中国银行; type: Debit; source: 云闪付'
WHERE NOT EXISTS (SELECT 1 FROM card_catalog WHERE country = 'CN' AND bank_name = '中国银行' AND card_name = '财富管理卡');
UPDATE card_catalog SET image_url = CASE WHEN image_url IS NULL OR image_url LIKE '/images/cards/cardentify/%' THEN '/images/cards/cardentify/73a77781b5e4-1ccb32d6485e-79937081.jpg' ELSE image_url END, network = COALESCE(network, 'UnionPay'), tags = COALESCE(tags, 'Cardentify,借记卡,来源:云闪付'), notes = COALESCE(notes, 'Cardentify import; original bank: 中国银行; type: Debit; source: 云闪付') WHERE country = 'CN' AND bank_name = '中国银行' AND card_name = '财富管理卡';

INSERT INTO card_catalog (country, bank_name, card_name, card_tier, network, tags, image_url, variants, annual_fee_cny, notes)
SELECT 'CN', '中国银行', '初音未来', '普卡', 'UnionPay', 'Cardentify,信用卡,来源:Mi Pay', '/images/cards/cardentify/73a77781b5e4-e6dcb7ed520b-5f27650c.jpg', NULL, NULL, 'Cardentify import; original bank: 中国银行; type: Credit; source: Mi Pay'
WHERE NOT EXISTS (SELECT 1 FROM card_catalog WHERE country = 'CN' AND bank_name = '中国银行' AND card_name = '初音未来');
UPDATE card_catalog SET image_url = CASE WHEN image_url IS NULL OR image_url LIKE '/images/cards/cardentify/%' THEN '/images/cards/cardentify/73a77781b5e4-e6dcb7ed520b-5f27650c.jpg' ELSE image_url END, network = COALESCE(network, 'UnionPay'), tags = COALESCE(tags, 'Cardentify,信用卡,来源:Mi Pay'), notes = COALESCE(notes, 'Cardentify import; original bank: 中国银行; type: Credit; source: Mi Pay') WHERE country = 'CN' AND bank_name = '中国银行' AND card_name = '初音未来';

INSERT INTO card_catalog (country, bank_name, card_name, card_tier, network, tags, image_url, variants, annual_fee_cny, notes)
SELECT 'CN', '中国银行', '长城无界青春卡校园版', '白金卡', 'UnionPay', 'Cardentify,信用卡,来源:中国银行', '/images/cards/cardentify/73a77781b5e4-3e97342dbb79-c92bd1bd.jpg', NULL, NULL, 'Cardentify import; original bank: 中国银行; type: Credit; source: 中国银行'
WHERE NOT EXISTS (SELECT 1 FROM card_catalog WHERE country = 'CN' AND bank_name = '中国银行' AND card_name = '长城无界青春卡校园版');
UPDATE card_catalog SET image_url = CASE WHEN image_url IS NULL OR image_url LIKE '/images/cards/cardentify/%' THEN '/images/cards/cardentify/73a77781b5e4-3e97342dbb79-c92bd1bd.jpg' ELSE image_url END, network = COALESCE(network, 'UnionPay'), tags = COALESCE(tags, 'Cardentify,信用卡,来源:中国银行'), notes = COALESCE(notes, 'Cardentify import; original bank: 中国银行; type: Credit; source: 中国银行') WHERE country = 'CN' AND bank_name = '中国银行' AND card_name = '长城无界青春卡校园版';

INSERT INTO card_catalog (country, bank_name, card_name, card_tier, network, tags, image_url, variants, annual_fee_cny, notes)
SELECT 'CN', '中国银行', '长城商贸通借记卡', '金卡', 'UnionPay', 'Cardentify,借记卡,来源:云闪付,BIN:621786', '/images/cards/cardentify/73a77781b5e4-1e72f85176dd-2bd3f2cc.jpg', NULL, NULL, 'Cardentify import; original bank: 中国银行; type: Debit; source: 云闪付'
WHERE NOT EXISTS (SELECT 1 FROM card_catalog WHERE country = 'CN' AND bank_name = '中国银行' AND card_name = '长城商贸通借记卡');
UPDATE card_catalog SET image_url = CASE WHEN image_url IS NULL OR image_url LIKE '/images/cards/cardentify/%' THEN '/images/cards/cardentify/73a77781b5e4-1e72f85176dd-2bd3f2cc.jpg' ELSE image_url END, network = COALESCE(network, 'UnionPay'), tags = COALESCE(tags, 'Cardentify,借记卡,来源:云闪付,BIN:621786'), notes = COALESCE(notes, 'Cardentify import; original bank: 中国银行; type: Debit; source: 云闪付') WHERE country = 'CN' AND bank_name = '中国银行' AND card_name = '长城商贸通借记卡';

INSERT INTO card_catalog (country, bank_name, card_name, card_tier, network, tags, image_url, variants, annual_fee_cny, notes)
SELECT 'CN', '中国银行', '银联白金信用卡', '白金卡', 'UnionPay', 'Cardentify,信用卡,来源:云闪付', '/images/cards/cardentify/73a77781b5e4-e54073a54597-ab31f886.jpg', NULL, NULL, 'Cardentify import; original bank: 中国银行; type: Credit; source: 云闪付'
WHERE NOT EXISTS (SELECT 1 FROM card_catalog WHERE country = 'CN' AND bank_name = '中国银行' AND card_name = '银联白金信用卡');
UPDATE card_catalog SET image_url = CASE WHEN image_url IS NULL OR image_url LIKE '/images/cards/cardentify/%' THEN '/images/cards/cardentify/73a77781b5e4-e54073a54597-ab31f886.jpg' ELSE image_url END, network = COALESCE(network, 'UnionPay'), tags = COALESCE(tags, 'Cardentify,信用卡,来源:云闪付'), notes = COALESCE(notes, 'Cardentify import; original bank: 中国银行; type: Credit; source: 云闪付') WHERE country = 'CN' AND bank_name = '中国银行' AND card_name = '银联白金信用卡';

INSERT INTO card_catalog (country, bank_name, card_name, card_tier, network, tags, image_url, variants, annual_fee_cny, notes)
SELECT 'HK', '中國銀行 (香港)', '中銀卡（舊）', '普卡', 'UnionPay', 'Cardentify,借记卡,来源:Samsung Pay,BIN:612741', '/images/cards/cardentify/499e585c5cd7-65b97b3e7344-65aef68c.jpg', NULL, NULL, 'Cardentify import; original bank: 中國銀行 (香港); type: Debit; source: Samsung Pay'
WHERE NOT EXISTS (SELECT 1 FROM card_catalog WHERE country = 'HK' AND bank_name = '中國銀行 (香港)' AND card_name = '中銀卡（舊）');
UPDATE card_catalog SET image_url = CASE WHEN image_url IS NULL OR image_url LIKE '/images/cards/cardentify/%' THEN '/images/cards/cardentify/499e585c5cd7-65b97b3e7344-65aef68c.jpg' ELSE image_url END, network = COALESCE(network, 'UnionPay'), tags = COALESCE(tags, 'Cardentify,借记卡,来源:Samsung Pay,BIN:612741'), notes = COALESCE(notes, 'Cardentify import; original bank: 中國銀行 (香港); type: Debit; source: Samsung Pay') WHERE country = 'HK' AND bank_name = '中國銀行 (香港)' AND card_name = '中銀卡（舊）';

INSERT INTO card_catalog (country, bank_name, card_name, card_tier, network, tags, image_url, variants, annual_fee_cny, notes)
SELECT 'HK', '中國銀行 (香港)', '中銀卡', '普卡', 'UnionPay', 'Cardentify,借记卡,来源:Apple Pay,BIN:612741', '/images/cards/cardentify/499e585c5cd7-2cdf0bdf931b-0927efe5.jpg', NULL, NULL, 'Cardentify import; original bank: 中國銀行 (香港); type: Debit; source: Apple Pay'
WHERE NOT EXISTS (SELECT 1 FROM card_catalog WHERE country = 'HK' AND bank_name = '中國銀行 (香港)' AND card_name = '中銀卡');
UPDATE card_catalog SET image_url = CASE WHEN image_url IS NULL OR image_url LIKE '/images/cards/cardentify/%' THEN '/images/cards/cardentify/499e585c5cd7-2cdf0bdf931b-0927efe5.jpg' ELSE image_url END, network = COALESCE(network, 'UnionPay'), tags = COALESCE(tags, 'Cardentify,借记卡,来源:Apple Pay,BIN:612741'), notes = COALESCE(notes, 'Cardentify import; original bank: 中國銀行 (香港); type: Debit; source: Apple Pay') WHERE country = 'HK' AND bank_name = '中國銀行 (香港)' AND card_name = '中銀卡';

INSERT INTO card_catalog (country, bank_name, card_name, card_tier, network, tags, image_url, variants, annual_fee_cny, notes)
SELECT 'HK', '中國銀行 (香港)', 'BOC Mastercard Debit Card', '白金卡', 'Mastercard', 'Cardentify,借记卡,来源:Apple Pay,BIN:535075', '/images/cards/cardentify/499e585c5cd7-boc-mastercard-debit-card-300458df.jpg', NULL, NULL, 'Cardentify import; original bank: 中國銀行 (香港); type: Debit; source: Apple Pay'
WHERE NOT EXISTS (SELECT 1 FROM card_catalog WHERE country = 'HK' AND bank_name = '中國銀行 (香港)' AND card_name = 'BOC Mastercard Debit Card');
UPDATE card_catalog SET image_url = CASE WHEN image_url IS NULL OR image_url LIKE '/images/cards/cardentify/%' THEN '/images/cards/cardentify/499e585c5cd7-boc-mastercard-debit-card-300458df.jpg' ELSE image_url END, network = COALESCE(network, 'Mastercard'), tags = COALESCE(tags, 'Cardentify,借记卡,来源:Apple Pay,BIN:535075'), notes = COALESCE(notes, 'Cardentify import; original bank: 中國銀行 (香港); type: Debit; source: Apple Pay') WHERE country = 'HK' AND bank_name = '中國銀行 (香港)' AND card_name = 'BOC Mastercard Debit Card';

INSERT INTO card_catalog (country, bank_name, card_name, card_tier, network, tags, image_url, variants, annual_fee_cny, notes)
SELECT 'CN', '交通银行', '沃德卡', '白金卡', 'UnionPay', 'Cardentify,借记卡,来源:Mi Pay', '/images/cards/cardentify/b9f4df3fbebf-8882ce0f70e4-091fa00a.jpg', NULL, NULL, 'Cardentify import; original bank: 交通银行; type: Debit; source: Mi Pay'
WHERE NOT EXISTS (SELECT 1 FROM card_catalog WHERE country = 'CN' AND bank_name = '交通银行' AND card_name = '沃德卡');
UPDATE card_catalog SET image_url = CASE WHEN image_url IS NULL OR image_url LIKE '/images/cards/cardentify/%' THEN '/images/cards/cardentify/b9f4df3fbebf-8882ce0f70e4-091fa00a.jpg' ELSE image_url END, network = COALESCE(network, 'UnionPay'), tags = COALESCE(tags, 'Cardentify,借记卡,来源:Mi Pay'), notes = COALESCE(notes, 'Cardentify import; original bank: 交通银行; type: Debit; source: Mi Pay') WHERE country = 'CN' AND bank_name = '交通银行' AND card_name = '沃德卡';

INSERT INTO card_catalog (country, bank_name, card_name, card_tier, network, tags, image_url, variants, annual_fee_cny, notes)
SELECT 'CN', '交通银行', '标准白金卡', '白金卡', 'UnionPay', 'Cardentify,信用卡,来源:Mi Pay', '/images/cards/cardentify/b9f4df3fbebf-ea64c53169b0-e6011a13.jpg', NULL, NULL, 'Cardentify import; original bank: 交通银行; type: Credit; source: Mi Pay'
WHERE NOT EXISTS (SELECT 1 FROM card_catalog WHERE country = 'CN' AND bank_name = '交通银行' AND card_name = '标准白金卡');
UPDATE card_catalog SET image_url = CASE WHEN image_url IS NULL OR image_url LIKE '/images/cards/cardentify/%' THEN '/images/cards/cardentify/b9f4df3fbebf-ea64c53169b0-e6011a13.jpg' ELSE image_url END, network = COALESCE(network, 'UnionPay'), tags = COALESCE(tags, 'Cardentify,信用卡,来源:Mi Pay'), notes = COALESCE(notes, 'Cardentify import; original bank: 交通银行; type: Credit; source: Mi Pay') WHERE country = 'CN' AND bank_name = '交通银行' AND card_name = '标准白金卡';

INSERT INTO card_catalog (country, bank_name, card_name, card_tier, network, tags, image_url, variants, annual_fee_cny, notes)
SELECT 'CN', '交通银行', '得利卡', '金卡', 'UnionPay', 'Cardentify,信用卡,来源:Mi Pay', '/images/cards/cardentify/b9f4df3fbebf-b009766173be-2bd25f3a.jpg', NULL, NULL, 'Cardentify import; original bank: 交通银行; type: Credit; source: Mi Pay'
WHERE NOT EXISTS (SELECT 1 FROM card_catalog WHERE country = 'CN' AND bank_name = '交通银行' AND card_name = '得利卡');
UPDATE card_catalog SET image_url = CASE WHEN image_url IS NULL OR image_url LIKE '/images/cards/cardentify/%' THEN '/images/cards/cardentify/b9f4df3fbebf-b009766173be-2bd25f3a.jpg' ELSE image_url END, network = COALESCE(network, 'UnionPay'), tags = COALESCE(tags, 'Cardentify,信用卡,来源:Mi Pay'), notes = COALESCE(notes, 'Cardentify import; original bank: 交通银行; type: Credit; source: Mi Pay') WHERE country = 'CN' AND bank_name = '交通银行' AND card_name = '得利卡';

INSERT INTO card_catalog (country, bank_name, card_name, card_tier, network, tags, image_url, variants, annual_fee_cny, notes)
SELECT 'CN', '交通银行', '高达独角兽', '普卡', 'UnionPay', 'Cardentify,信用卡,来源:Mi Pay', '/images/cards/cardentify/b9f4df3fbebf-5e803059a0b7-c3a70ebd.jpg', NULL, NULL, 'Cardentify import; original bank: 交通银行; type: Credit; source: Mi Pay'
WHERE NOT EXISTS (SELECT 1 FROM card_catalog WHERE country = 'CN' AND bank_name = '交通银行' AND card_name = '高达独角兽');
UPDATE card_catalog SET image_url = CASE WHEN image_url IS NULL OR image_url LIKE '/images/cards/cardentify/%' THEN '/images/cards/cardentify/b9f4df3fbebf-5e803059a0b7-c3a70ebd.jpg' ELSE image_url END, network = COALESCE(network, 'UnionPay'), tags = COALESCE(tags, 'Cardentify,信用卡,来源:Mi Pay'), notes = COALESCE(notes, 'Cardentify import; original bank: 交通银行; type: Credit; source: Mi Pay') WHERE country = 'CN' AND bank_name = '交通银行' AND card_name = '高达独角兽';

INSERT INTO card_catalog (country, bank_name, card_name, card_tier, network, tags, image_url, variants, annual_fee_cny, notes)
SELECT 'CN', '交通银行', '焕然白金', '白金卡', 'UnionPay', 'Cardentify,信用卡,来源:Mi Pay', '/images/cards/cardentify/b9f4df3fbebf-625fb8589472-b9961771.jpg', NULL, NULL, 'Cardentify import; original bank: 交通银行; type: Credit; source: Mi Pay'
WHERE NOT EXISTS (SELECT 1 FROM card_catalog WHERE country = 'CN' AND bank_name = '交通银行' AND card_name = '焕然白金');
UPDATE card_catalog SET image_url = CASE WHEN image_url IS NULL OR image_url LIKE '/images/cards/cardentify/%' THEN '/images/cards/cardentify/b9f4df3fbebf-625fb8589472-b9961771.jpg' ELSE image_url END, network = COALESCE(network, 'UnionPay'), tags = COALESCE(tags, 'Cardentify,信用卡,来源:Mi Pay'), notes = COALESCE(notes, 'Cardentify import; original bank: 交通银行; type: Credit; source: Mi Pay') WHERE country = 'CN' AND bank_name = '交通银行' AND card_name = '焕然白金';

INSERT INTO card_catalog (country, bank_name, card_name, card_tier, network, tags, image_url, variants, annual_fee_cny, notes)
SELECT 'CN', '交通银行', '洛天依藏族', '普卡', 'UnionPay', 'Cardentify,信用卡,来源:Mi Pay', '/images/cards/cardentify/b9f4df3fbebf-01c73b43cb88-b58641c7.jpg', NULL, NULL, 'Cardentify import; original bank: 交通银行; type: Credit; source: Mi Pay'
WHERE NOT EXISTS (SELECT 1 FROM card_catalog WHERE country = 'CN' AND bank_name = '交通银行' AND card_name = '洛天依藏族');
UPDATE card_catalog SET image_url = CASE WHEN image_url IS NULL OR image_url LIKE '/images/cards/cardentify/%' THEN '/images/cards/cardentify/b9f4df3fbebf-01c73b43cb88-b58641c7.jpg' ELSE image_url END, network = COALESCE(network, 'UnionPay'), tags = COALESCE(tags, 'Cardentify,信用卡,来源:Mi Pay'), notes = COALESCE(notes, 'Cardentify import; original bank: 交通银行; type: Credit; source: Mi Pay') WHERE country = 'CN' AND bank_name = '交通银行' AND card_name = '洛天依藏族';

INSERT INTO card_catalog (country, bank_name, card_name, card_tier, network, tags, image_url, variants, annual_fee_cny, notes)
SELECT 'CN', '交通银行', '洛天依虎虎生V', '普卡', 'UnionPay', 'Cardentify,信用卡,来源:Mi Pay', '/images/cards/cardentify/b9f4df3fbebf-v-386c4d83.jpg', NULL, NULL, 'Cardentify import; original bank: 交通银行; type: Credit; source: Mi Pay'
WHERE NOT EXISTS (SELECT 1 FROM card_catalog WHERE country = 'CN' AND bank_name = '交通银行' AND card_name = '洛天依虎虎生V');
UPDATE card_catalog SET image_url = CASE WHEN image_url IS NULL OR image_url LIKE '/images/cards/cardentify/%' THEN '/images/cards/cardentify/b9f4df3fbebf-v-386c4d83.jpg' ELSE image_url END, network = COALESCE(network, 'UnionPay'), tags = COALESCE(tags, 'Cardentify,信用卡,来源:Mi Pay'), notes = COALESCE(notes, 'Cardentify import; original bank: 交通银行; type: Credit; source: Mi Pay') WHERE country = 'CN' AND bank_name = '交通银行' AND card_name = '洛天依虎虎生V';

INSERT INTO card_catalog (country, bank_name, card_name, card_tier, network, tags, image_url, variants, annual_fee_cny, notes)
SELECT 'CN', '交通银行', '洛天依洛舞樱花', '普卡', 'UnionPay', 'Cardentify,信用卡,来源:Mi Pay', '/images/cards/cardentify/b9f4df3fbebf-5207169faa0f-25be6061.jpg', NULL, NULL, 'Cardentify import; original bank: 交通银行; type: Credit; source: Mi Pay'
WHERE NOT EXISTS (SELECT 1 FROM card_catalog WHERE country = 'CN' AND bank_name = '交通银行' AND card_name = '洛天依洛舞樱花');
UPDATE card_catalog SET image_url = CASE WHEN image_url IS NULL OR image_url LIKE '/images/cards/cardentify/%' THEN '/images/cards/cardentify/b9f4df3fbebf-5207169faa0f-25be6061.jpg' ELSE image_url END, network = COALESCE(network, 'UnionPay'), tags = COALESCE(tags, 'Cardentify,信用卡,来源:Mi Pay'), notes = COALESCE(notes, 'Cardentify import; original bank: 交通银行; type: Credit; source: Mi Pay') WHERE country = 'CN' AND bank_name = '交通银行' AND card_name = '洛天依洛舞樱花';

INSERT INTO card_catalog (country, bank_name, card_name, card_tier, network, tags, image_url, variants, annual_fee_cny, notes)
SELECT 'CN', '交通银行', '洛天依蒙古族', '普卡', 'UnionPay', 'Cardentify,信用卡,来源:Mi Pay', '/images/cards/cardentify/b9f4df3fbebf-671f52675d5e-a83404ca.jpg', NULL, NULL, 'Cardentify import; original bank: 交通银行; type: Credit; source: Mi Pay'
WHERE NOT EXISTS (SELECT 1 FROM card_catalog WHERE country = 'CN' AND bank_name = '交通银行' AND card_name = '洛天依蒙古族');
UPDATE card_catalog SET image_url = CASE WHEN image_url IS NULL OR image_url LIKE '/images/cards/cardentify/%' THEN '/images/cards/cardentify/b9f4df3fbebf-671f52675d5e-a83404ca.jpg' ELSE image_url END, network = COALESCE(network, 'UnionPay'), tags = COALESCE(tags, 'Cardentify,信用卡,来源:Mi Pay'), notes = COALESCE(notes, 'Cardentify import; original bank: 交通银行; type: Credit; source: Mi Pay') WHERE country = 'CN' AND bank_name = '交通银行' AND card_name = '洛天依蒙古族';

INSERT INTO card_catalog (country, bank_name, card_name, card_tier, network, tags, image_url, variants, annual_fee_cny, notes)
SELECT 'CN', '交通银行', '洛天依苗族', '普卡', 'UnionPay', 'Cardentify,信用卡,来源:Mi Pay', '/images/cards/cardentify/b9f4df3fbebf-efa73fc4100c-d4737ce6.jpg', NULL, NULL, 'Cardentify import; original bank: 交通银行; type: Credit; source: Mi Pay'
WHERE NOT EXISTS (SELECT 1 FROM card_catalog WHERE country = 'CN' AND bank_name = '交通银行' AND card_name = '洛天依苗族');
UPDATE card_catalog SET image_url = CASE WHEN image_url IS NULL OR image_url LIKE '/images/cards/cardentify/%' THEN '/images/cards/cardentify/b9f4df3fbebf-efa73fc4100c-d4737ce6.jpg' ELSE image_url END, network = COALESCE(network, 'UnionPay'), tags = COALESCE(tags, 'Cardentify,信用卡,来源:Mi Pay'), notes = COALESCE(notes, 'Cardentify import; original bank: 交通银行; type: Credit; source: Mi Pay') WHERE country = 'CN' AND bank_name = '交通银行' AND card_name = '洛天依苗族';

INSERT INTO card_catalog (country, bank_name, card_name, card_tier, network, tags, image_url, variants, annual_fee_cny, notes)
SELECT 'CN', '交通银行', '洛天依十周年', '普卡', 'UnionPay', 'Cardentify,信用卡,来源:Mi Pay', '/images/cards/cardentify/b9f4df3fbebf-564e7480c628-ec27af95.jpg', NULL, NULL, 'Cardentify import; original bank: 交通银行; type: Credit; source: Mi Pay'
WHERE NOT EXISTS (SELECT 1 FROM card_catalog WHERE country = 'CN' AND bank_name = '交通银行' AND card_name = '洛天依十周年');
UPDATE card_catalog SET image_url = CASE WHEN image_url IS NULL OR image_url LIKE '/images/cards/cardentify/%' THEN '/images/cards/cardentify/b9f4df3fbebf-564e7480c628-ec27af95.jpg' ELSE image_url END, network = COALESCE(network, 'UnionPay'), tags = COALESCE(tags, 'Cardentify,信用卡,来源:Mi Pay'), notes = COALESCE(notes, 'Cardentify import; original bank: 交通银行; type: Credit; source: Mi Pay') WHERE country = 'CN' AND bank_name = '交通银行' AND card_name = '洛天依十周年';

INSERT INTO card_catalog (country, bank_name, card_name, card_tier, network, tags, image_url, variants, annual_fee_cny, notes)
SELECT 'CN', '交通银行', '洛天依维吾尔族', '普卡', 'UnionPay', 'Cardentify,信用卡,来源:Mi Pay', '/images/cards/cardentify/b9f4df3fbebf-7fac03ba6f74-9cda7497.jpg', NULL, NULL, 'Cardentify import; original bank: 交通银行; type: Credit; source: Mi Pay'
WHERE NOT EXISTS (SELECT 1 FROM card_catalog WHERE country = 'CN' AND bank_name = '交通银行' AND card_name = '洛天依维吾尔族');
UPDATE card_catalog SET image_url = CASE WHEN image_url IS NULL OR image_url LIKE '/images/cards/cardentify/%' THEN '/images/cards/cardentify/b9f4df3fbebf-7fac03ba6f74-9cda7497.jpg' ELSE image_url END, network = COALESCE(network, 'UnionPay'), tags = COALESCE(tags, 'Cardentify,信用卡,来源:Mi Pay'), notes = COALESCE(notes, 'Cardentify import; original bank: 交通银行; type: Credit; source: Mi Pay') WHERE country = 'CN' AND bank_name = '交通银行' AND card_name = '洛天依维吾尔族';

INSERT INTO card_catalog (country, bank_name, card_name, card_tier, network, tags, image_url, variants, annual_fee_cny, notes)
SELECT 'CN', '交通银行', '洛天依新年', '普卡', 'UnionPay', 'Cardentify,信用卡,来源:Mi Pay', '/images/cards/cardentify/b9f4df3fbebf-ff99e404a9fb-6440227e.jpg', NULL, NULL, 'Cardentify import; original bank: 交通银行; type: Credit; source: Mi Pay'
WHERE NOT EXISTS (SELECT 1 FROM card_catalog WHERE country = 'CN' AND bank_name = '交通银行' AND card_name = '洛天依新年');
UPDATE card_catalog SET image_url = CASE WHEN image_url IS NULL OR image_url LIKE '/images/cards/cardentify/%' THEN '/images/cards/cardentify/b9f4df3fbebf-ff99e404a9fb-6440227e.jpg' ELSE image_url END, network = COALESCE(network, 'UnionPay'), tags = COALESCE(tags, 'Cardentify,信用卡,来源:Mi Pay'), notes = COALESCE(notes, 'Cardentify import; original bank: 交通银行; type: Credit; source: Mi Pay') WHERE country = 'CN' AND bank_name = '交通银行' AND card_name = '洛天依新年';

INSERT INTO card_catalog (country, bank_name, card_name, card_tier, network, tags, image_url, variants, annual_fee_cny, notes)
SELECT 'CN', '交通银行', '洛天依夜航星', '普卡', 'UnionPay', 'Cardentify,信用卡,来源:Mi Pay', '/images/cards/cardentify/b9f4df3fbebf-bf462de62980-6a1a8f1b.jpg', NULL, NULL, 'Cardentify import; original bank: 交通银行; type: Credit; source: Mi Pay'
WHERE NOT EXISTS (SELECT 1 FROM card_catalog WHERE country = 'CN' AND bank_name = '交通银行' AND card_name = '洛天依夜航星');
UPDATE card_catalog SET image_url = CASE WHEN image_url IS NULL OR image_url LIKE '/images/cards/cardentify/%' THEN '/images/cards/cardentify/b9f4df3fbebf-bf462de62980-6a1a8f1b.jpg' ELSE image_url END, network = COALESCE(network, 'UnionPay'), tags = COALESCE(tags, 'Cardentify,信用卡,来源:Mi Pay'), notes = COALESCE(notes, 'Cardentify import; original bank: 交通银行; type: Credit; source: Mi Pay') WHERE country = 'CN' AND bank_name = '交通银行' AND card_name = '洛天依夜航星';

INSERT INTO card_catalog (country, bank_name, card_name, card_tier, network, tags, image_url, variants, annual_fee_cny, notes)
SELECT 'CN', '交通银行', '洛天依一剑寒霜', '普卡', 'UnionPay', 'Cardentify,信用卡,来源:Mi Pay', '/images/cards/cardentify/b9f4df3fbebf-dc9891cfb673-db542904.jpg', NULL, NULL, 'Cardentify import; original bank: 交通银行; type: Credit; source: Mi Pay'
WHERE NOT EXISTS (SELECT 1 FROM card_catalog WHERE country = 'CN' AND bank_name = '交通银行' AND card_name = '洛天依一剑寒霜');
UPDATE card_catalog SET image_url = CASE WHEN image_url IS NULL OR image_url LIKE '/images/cards/cardentify/%' THEN '/images/cards/cardentify/b9f4df3fbebf-dc9891cfb673-db542904.jpg' ELSE image_url END, network = COALESCE(network, 'UnionPay'), tags = COALESCE(tags, 'Cardentify,信用卡,来源:Mi Pay'), notes = COALESCE(notes, 'Cardentify import; original bank: 交通银行; type: Credit; source: Mi Pay') WHERE country = 'CN' AND bank_name = '交通银行' AND card_name = '洛天依一剑寒霜';

INSERT INTO card_catalog (country, bank_name, card_name, card_tier, network, tags, image_url, variants, annual_fee_cny, notes)
SELECT 'CN', '交通银行', '洛天依依见倾心', '普卡', 'UnionPay', 'Cardentify,信用卡,来源:Mi Pay', '/images/cards/cardentify/b9f4df3fbebf-0d43df04fd1c-994510f6.jpg', NULL, NULL, 'Cardentify import; original bank: 交通银行; type: Credit; source: Mi Pay'
WHERE NOT EXISTS (SELECT 1 FROM card_catalog WHERE country = 'CN' AND bank_name = '交通银行' AND card_name = '洛天依依见倾心');
UPDATE card_catalog SET image_url = CASE WHEN image_url IS NULL OR image_url LIKE '/images/cards/cardentify/%' THEN '/images/cards/cardentify/b9f4df3fbebf-0d43df04fd1c-994510f6.jpg' ELSE image_url END, network = COALESCE(network, 'UnionPay'), tags = COALESCE(tags, 'Cardentify,信用卡,来源:Mi Pay'), notes = COALESCE(notes, 'Cardentify import; original bank: 交通银行; type: Credit; source: Mi Pay') WHERE country = 'CN' AND bank_name = '交通银行' AND card_name = '洛天依依见倾心';

INSERT INTO card_catalog (country, bank_name, card_name, card_tier, network, tags, image_url, variants, annual_fee_cny, notes)
SELECT 'CN', '交通银行', '洛天依知交逍遥', '普卡', 'UnionPay', 'Cardentify,信用卡,来源:Mi Pay', '/images/cards/cardentify/b9f4df3fbebf-604eee5d70fe-7d591de8.jpg', NULL, NULL, 'Cardentify import; original bank: 交通银行; type: Credit; source: Mi Pay'
WHERE NOT EXISTS (SELECT 1 FROM card_catalog WHERE country = 'CN' AND bank_name = '交通银行' AND card_name = '洛天依知交逍遥');
UPDATE card_catalog SET image_url = CASE WHEN image_url IS NULL OR image_url LIKE '/images/cards/cardentify/%' THEN '/images/cards/cardentify/b9f4df3fbebf-604eee5d70fe-7d591de8.jpg' ELSE image_url END, network = COALESCE(network, 'UnionPay'), tags = COALESCE(tags, 'Cardentify,信用卡,来源:Mi Pay'), notes = COALESCE(notes, 'Cardentify import; original bank: 交通银行; type: Credit; source: Mi Pay') WHERE country = 'CN' AND bank_name = '交通银行' AND card_name = '洛天依知交逍遥';

INSERT INTO card_catalog (country, bank_name, card_name, card_tier, network, tags, image_url, variants, annual_fee_cny, notes)
SELECT 'CN', '交通银行', '泡泡玛特atm', '白金卡', 'UnionPay', 'Cardentify,信用卡,来源:Mi Pay', '/images/cards/cardentify/b9f4df3fbebf-atm-b59eafe6.jpg', NULL, NULL, 'Cardentify import; original bank: 交通银行; type: Credit; source: Mi Pay'
WHERE NOT EXISTS (SELECT 1 FROM card_catalog WHERE country = 'CN' AND bank_name = '交通银行' AND card_name = '泡泡玛特atm');
UPDATE card_catalog SET image_url = CASE WHEN image_url IS NULL OR image_url LIKE '/images/cards/cardentify/%' THEN '/images/cards/cardentify/b9f4df3fbebf-atm-b59eafe6.jpg' ELSE image_url END, network = COALESCE(network, 'UnionPay'), tags = COALESCE(tags, 'Cardentify,信用卡,来源:Mi Pay'), notes = COALESCE(notes, 'Cardentify import; original bank: 交通银行; type: Credit; source: Mi Pay') WHERE country = 'CN' AND bank_name = '交通银行' AND card_name = '泡泡玛特atm';

INSERT INTO card_catalog (country, bank_name, card_name, card_tier, network, tags, image_url, variants, annual_fee_cny, notes)
SELECT 'CN', '交通银行', '青鸟', '普卡', 'UnionPay', 'Cardentify,信用卡,来源:Mi Pay', '/images/cards/cardentify/b9f4df3fbebf-db0abd6cdb8a-7054a93d.jpg', NULL, NULL, 'Cardentify import; original bank: 交通银行; type: Credit; source: Mi Pay'
WHERE NOT EXISTS (SELECT 1 FROM card_catalog WHERE country = 'CN' AND bank_name = '交通银行' AND card_name = '青鸟');
UPDATE card_catalog SET image_url = CASE WHEN image_url IS NULL OR image_url LIKE '/images/cards/cardentify/%' THEN '/images/cards/cardentify/b9f4df3fbebf-db0abd6cdb8a-7054a93d.jpg' ELSE image_url END, network = COALESCE(network, 'UnionPay'), tags = COALESCE(tags, 'Cardentify,信用卡,来源:Mi Pay'), notes = COALESCE(notes, 'Cardentify import; original bank: 交通银行; type: Credit; source: Mi Pay') WHERE country = 'CN' AND bank_name = '交通银行' AND card_name = '青鸟';

INSERT INTO card_catalog (country, bank_name, card_name, card_tier, network, tags, image_url, variants, annual_fee_cny, notes)
SELECT 'CN', '交通银行', '太平洋借记卡', '普卡', 'UnionPay', 'Cardentify,借记卡,来源:Apple Pay,BIN:622262', '/images/cards/cardentify/b9f4df3fbebf-f14c48c1b863-b7261264.jpg', NULL, NULL, 'Cardentify import; original bank: 交通银行; type: Debit; source: Apple Pay'
WHERE NOT EXISTS (SELECT 1 FROM card_catalog WHERE country = 'CN' AND bank_name = '交通银行' AND card_name = '太平洋借记卡');
UPDATE card_catalog SET image_url = CASE WHEN image_url IS NULL OR image_url LIKE '/images/cards/cardentify/%' THEN '/images/cards/cardentify/b9f4df3fbebf-f14c48c1b863-b7261264.jpg' ELSE image_url END, network = COALESCE(network, 'UnionPay'), tags = COALESCE(tags, 'Cardentify,借记卡,来源:Apple Pay,BIN:622262'), notes = COALESCE(notes, 'Cardentify import; original bank: 交通银行; type: Debit; source: Apple Pay') WHERE country = 'CN' AND bank_name = '交通银行' AND card_name = '太平洋借记卡';

INSERT INTO card_catalog (country, bank_name, card_name, card_tier, network, tags, image_url, variants, annual_fee_cny, notes)
SELECT 'CN', '交通银行', '乡村振兴系列 太平洋借记卡', '普卡', 'UnionPay', 'Cardentify,借记卡,来源:云闪付,BIN:622262', '/images/cards/cardentify/b9f4df3fbebf-f8c0851cf190-61a56971.jpg', NULL, NULL, 'Cardentify import; original bank: 交通银行; type: Debit; source: 云闪付'
WHERE NOT EXISTS (SELECT 1 FROM card_catalog WHERE country = 'CN' AND bank_name = '交通银行' AND card_name = '乡村振兴系列 太平洋借记卡');
UPDATE card_catalog SET image_url = CASE WHEN image_url IS NULL OR image_url LIKE '/images/cards/cardentify/%' THEN '/images/cards/cardentify/b9f4df3fbebf-f8c0851cf190-61a56971.jpg' ELSE image_url END, network = COALESCE(network, 'UnionPay'), tags = COALESCE(tags, 'Cardentify,借记卡,来源:云闪付,BIN:622262'), notes = COALESCE(notes, 'Cardentify import; original bank: 交通银行; type: Debit; source: 云闪付') WHERE country = 'CN' AND bank_name = '交通银行' AND card_name = '乡村振兴系列 太平洋借记卡';

INSERT INTO card_catalog (country, bank_name, card_name, card_tier, network, tags, image_url, variants, annual_fee_cny, notes)
SELECT 'CN', '杭州银行', '西湖卡', '普卡', 'UnionPay', 'Cardentify,借记卡,来源:云闪付', '/images/cards/cardentify/4b4f85d4179b-93a5241d53b2-6cd2d258.jpg', NULL, NULL, 'Cardentify import; original bank: 杭州银行; type: Debit; source: 云闪付'
WHERE NOT EXISTS (SELECT 1 FROM card_catalog WHERE country = 'CN' AND bank_name = '杭州银行' AND card_name = '西湖卡');
UPDATE card_catalog SET image_url = CASE WHEN image_url IS NULL OR image_url LIKE '/images/cards/cardentify/%' THEN '/images/cards/cardentify/4b4f85d4179b-93a5241d53b2-6cd2d258.jpg' ELSE image_url END, network = COALESCE(network, 'UnionPay'), tags = COALESCE(tags, 'Cardentify,借记卡,来源:云闪付'), notes = COALESCE(notes, 'Cardentify import; original bank: 杭州银行; type: Debit; source: 云闪付') WHERE country = 'CN' AND bank_name = '杭州银行' AND card_name = '西湖卡';

INSERT INTO card_catalog (country, bank_name, card_name, card_tier, network, tags, image_url, variants, annual_fee_cny, notes)
SELECT 'CN', '吉林银行', '长白山卡', '普卡', 'UnionPay', 'Cardentify,借记卡,来源:云闪付,BIN:623131', '/images/cards/cardentify/e66054298545-60a256c1b7cd-7ed0bff7.jpg', NULL, NULL, 'Cardentify import; original bank: 吉林银行; type: Debit; source: 云闪付'
WHERE NOT EXISTS (SELECT 1 FROM card_catalog WHERE country = 'CN' AND bank_name = '吉林银行' AND card_name = '长白山卡');
UPDATE card_catalog SET image_url = CASE WHEN image_url IS NULL OR image_url LIKE '/images/cards/cardentify/%' THEN '/images/cards/cardentify/e66054298545-60a256c1b7cd-7ed0bff7.jpg' ELSE image_url END, network = COALESCE(network, 'UnionPay'), tags = COALESCE(tags, 'Cardentify,借记卡,来源:云闪付,BIN:623131'), notes = COALESCE(notes, 'Cardentify import; original bank: 吉林银行; type: Debit; source: 云闪付') WHERE country = 'CN' AND bank_name = '吉林银行' AND card_name = '长白山卡';

INSERT INTO card_catalog (country, bank_name, card_name, card_tier, network, tags, image_url, variants, annual_fee_cny, notes)
SELECT 'CN', '宁波银行', '汇通卡', '普卡', 'UnionPay', 'Cardentify,借记卡,来源:Apple Pay,BIN:621418', '/images/cards/cardentify/959d56ee6796-e1ea714d4cba-546b4b34.jpg', NULL, NULL, 'Cardentify import; original bank: 宁波银行; type: Debit; source: Apple Pay'
WHERE NOT EXISTS (SELECT 1 FROM card_catalog WHERE country = 'CN' AND bank_name = '宁波银行' AND card_name = '汇通卡');
UPDATE card_catalog SET image_url = CASE WHEN image_url IS NULL OR image_url LIKE '/images/cards/cardentify/%' THEN '/images/cards/cardentify/959d56ee6796-e1ea714d4cba-546b4b34.jpg' ELSE image_url END, network = COALESCE(network, 'UnionPay'), tags = COALESCE(tags, 'Cardentify,借记卡,来源:Apple Pay,BIN:621418'), notes = COALESCE(notes, 'Cardentify import; original bank: 宁波银行; type: Debit; source: Apple Pay') WHERE country = 'CN' AND bank_name = '宁波银行' AND card_name = '汇通卡';

INSERT INTO card_catalog (country, bank_name, card_name, card_tier, network, tags, image_url, variants, annual_fee_cny, notes)
SELECT 'CN', '唐山银行', '盛唐卡', '普卡', 'UnionPay', 'Cardentify,借记卡,来源:云闪付', '/images/cards/cardentify/7ca769b43d9a-9b5af0edecd0-8bb7f331.jpg', NULL, NULL, 'Cardentify import; original bank: 唐山银行; type: Debit; source: 云闪付'
WHERE NOT EXISTS (SELECT 1 FROM card_catalog WHERE country = 'CN' AND bank_name = '唐山银行' AND card_name = '盛唐卡');
UPDATE card_catalog SET image_url = CASE WHEN image_url IS NULL OR image_url LIKE '/images/cards/cardentify/%' THEN '/images/cards/cardentify/7ca769b43d9a-9b5af0edecd0-8bb7f331.jpg' ELSE image_url END, network = COALESCE(network, 'UnionPay'), tags = COALESCE(tags, 'Cardentify,借记卡,来源:云闪付'), notes = COALESCE(notes, 'Cardentify import; original bank: 唐山银行; type: Debit; source: 云闪付') WHERE country = 'CN' AND bank_name = '唐山银行' AND card_name = '盛唐卡';

INSERT INTO card_catalog (country, bank_name, card_name, card_tier, network, tags, image_url, variants, annual_fee_cny, notes)
SELECT 'TW', '中國信託銀行', '中國信託紅利御璽卡', '御玺卡', 'VISA', 'Cardentify,信用卡,来源:Apple Pay,BIN:418230', '/images/cards/cardentify/8a760b1fcbe5-65e472ceafd2-1cf3aad3.jpg', NULL, NULL, 'Cardentify import; original bank: 中國信託銀行; type: Credit; source: Apple Pay'
WHERE NOT EXISTS (SELECT 1 FROM card_catalog WHERE country = 'TW' AND bank_name = '中國信託銀行' AND card_name = '中國信託紅利御璽卡');
UPDATE card_catalog SET image_url = CASE WHEN image_url IS NULL OR image_url LIKE '/images/cards/cardentify/%' THEN '/images/cards/cardentify/8a760b1fcbe5-65e472ceafd2-1cf3aad3.jpg' ELSE image_url END, network = COALESCE(network, 'VISA'), tags = COALESCE(tags, 'Cardentify,信用卡,来源:Apple Pay,BIN:418230'), notes = COALESCE(notes, 'Cardentify import; original bank: 中國信託銀行; type: Credit; source: Apple Pay') WHERE country = 'TW' AND bank_name = '中國信託銀行' AND card_name = '中國信託紅利御璽卡';

INSERT INTO card_catalog (country, bank_name, card_name, card_tier, network, tags, image_url, variants, annual_fee_cny, notes)
SELECT 'TW', '中國信託銀行', '中信漢神百貨御璽卡', '御玺卡', 'VISA', 'Cardentify,信用卡,来源:Apple Pay,BIN:418230', '/images/cards/cardentify/8a760b1fcbe5-9e72df21e892-14a9b5ce.jpg', NULL, NULL, 'Cardentify import; original bank: 中國信託銀行; type: Credit; source: Apple Pay'
WHERE NOT EXISTS (SELECT 1 FROM card_catalog WHERE country = 'TW' AND bank_name = '中國信託銀行' AND card_name = '中信漢神百貨御璽卡');
UPDATE card_catalog SET image_url = CASE WHEN image_url IS NULL OR image_url LIKE '/images/cards/cardentify/%' THEN '/images/cards/cardentify/8a760b1fcbe5-9e72df21e892-14a9b5ce.jpg' ELSE image_url END, network = COALESCE(network, 'VISA'), tags = COALESCE(tags, 'Cardentify,信用卡,来源:Apple Pay,BIN:418230'), notes = COALESCE(notes, 'Cardentify import; original bank: 中國信託銀行; type: Credit; source: Apple Pay') WHERE country = 'TW' AND bank_name = '中國信託銀行' AND card_name = '中信漢神百貨御璽卡';

INSERT INTO card_catalog (country, bank_name, card_name, card_tier, network, tags, image_url, variants, annual_fee_cny, notes)
SELECT 'TW', '中國信託銀行', '中國信託LINE Pay Debit卡', 'Classic', 'VISA', 'Cardentify,借记卡,来源:Apple Pay,BIN:447757', '/images/cards/cardentify/8a760b1fcbe5-line-pay-debit-344e25fa.jpg', NULL, NULL, 'Cardentify import; original bank: 中國信託銀行; type: Debit; source: Apple Pay'
WHERE NOT EXISTS (SELECT 1 FROM card_catalog WHERE country = 'TW' AND bank_name = '中國信託銀行' AND card_name = '中國信託LINE Pay Debit卡');
UPDATE card_catalog SET image_url = CASE WHEN image_url IS NULL OR image_url LIKE '/images/cards/cardentify/%' THEN '/images/cards/cardentify/8a760b1fcbe5-line-pay-debit-344e25fa.jpg' ELSE image_url END, network = COALESCE(network, 'VISA'), tags = COALESCE(tags, 'Cardentify,借记卡,来源:Apple Pay,BIN:447757'), notes = COALESCE(notes, 'Cardentify import; original bank: 中國信託銀行; type: Debit; source: Apple Pay') WHERE country = 'TW' AND bank_name = '中國信託銀行' AND card_name = '中國信託LINE Pay Debit卡';

INSERT INTO card_catalog (country, bank_name, card_name, card_tier, network, tags, image_url, variants, annual_fee_cny, notes)
SELECT 'TW', '中國信託銀行', '中國信託紅利普卡 (VISA)', 'Classic', 'VISA', 'Cardentify,信用卡,来源:Apple Pay,BIN:456301', '/images/cards/cardentify/8a760b1fcbe5-visa-c90bd5b9.jpg', NULL, NULL, 'Cardentify import; original bank: 中國信託銀行; type: Credit; source: Apple Pay'
WHERE NOT EXISTS (SELECT 1 FROM card_catalog WHERE country = 'TW' AND bank_name = '中國信託銀行' AND card_name = '中國信託紅利普卡 (VISA)');
UPDATE card_catalog SET image_url = CASE WHEN image_url IS NULL OR image_url LIKE '/images/cards/cardentify/%' THEN '/images/cards/cardentify/8a760b1fcbe5-visa-c90bd5b9.jpg' ELSE image_url END, network = COALESCE(network, 'VISA'), tags = COALESCE(tags, 'Cardentify,信用卡,来源:Apple Pay,BIN:456301'), notes = COALESCE(notes, 'Cardentify import; original bank: 中國信託銀行; type: Credit; source: Apple Pay') WHERE country = 'TW' AND bank_name = '中國信託銀行' AND card_name = '中國信託紅利普卡 (VISA)';

INSERT INTO card_catalog (country, bank_name, card_name, card_tier, network, tags, image_url, variants, annual_fee_cny, notes)
SELECT 'TW', '中國信託銀行', '中國信託商旅鈦金卡', '钛金卡', 'Mastercard', 'Cardentify,信用卡,来源:Apple Pay,BIN:524689', '/images/cards/cardentify/8a760b1fcbe5-2d797da5c43d-0d2a706b.jpg', NULL, NULL, 'Cardentify import; original bank: 中國信託銀行; type: Credit; source: Apple Pay'
WHERE NOT EXISTS (SELECT 1 FROM card_catalog WHERE country = 'TW' AND bank_name = '中國信託銀行' AND card_name = '中國信託商旅鈦金卡');
UPDATE card_catalog SET image_url = CASE WHEN image_url IS NULL OR image_url LIKE '/images/cards/cardentify/%' THEN '/images/cards/cardentify/8a760b1fcbe5-2d797da5c43d-0d2a706b.jpg' ELSE image_url END, network = COALESCE(network, 'Mastercard'), tags = COALESCE(tags, 'Cardentify,信用卡,来源:Apple Pay,BIN:524689'), notes = COALESCE(notes, 'Cardentify import; original bank: 中國信託銀行; type: Credit; source: Apple Pay') WHERE country = 'TW' AND bank_name = '中國信託銀行' AND card_name = '中國信託商旅鈦金卡';

INSERT INTO card_catalog (country, bank_name, card_name, card_tier, network, tags, image_url, variants, annual_fee_cny, notes)
SELECT 'TW', '中國信託銀行', '中國信託紅利白金卡 (Mastercard)', '白金卡', 'Mastercard', 'Cardentify,信用卡,来源:Apple Pay,BIN:552049', '/images/cards/cardentify/8a760b1fcbe5-mastercard-0e3e89e4.jpg', NULL, NULL, 'Cardentify import; original bank: 中國信託銀行; type: Credit; source: Apple Pay'
WHERE NOT EXISTS (SELECT 1 FROM card_catalog WHERE country = 'TW' AND bank_name = '中國信託銀行' AND card_name = '中國信託紅利白金卡 (Mastercard)');
UPDATE card_catalog SET image_url = CASE WHEN image_url IS NULL OR image_url LIKE '/images/cards/cardentify/%' THEN '/images/cards/cardentify/8a760b1fcbe5-mastercard-0e3e89e4.jpg' ELSE image_url END, network = COALESCE(network, 'Mastercard'), tags = COALESCE(tags, 'Cardentify,信用卡,来源:Apple Pay,BIN:552049'), notes = COALESCE(notes, 'Cardentify import; original bank: 中國信託銀行; type: Credit; source: Apple Pay') WHERE country = 'TW' AND bank_name = '中國信託銀行' AND card_name = '中國信託紅利白金卡 (Mastercard)';

INSERT INTO card_catalog (country, bank_name, card_name, card_tier, network, tags, image_url, variants, annual_fee_cny, notes)
SELECT 'TW', '中國信託銀行', '中國信託紅利白金卡 (VISA)', '白金卡', 'VISA', 'Cardentify,信用卡,来源:Apple Pay,BIN:431195', '/images/cards/cardentify/8a760b1fcbe5-visa-42bdfd71.jpg', NULL, NULL, 'Cardentify import; original bank: 中國信託銀行; type: Credit; source: Apple Pay'
WHERE NOT EXISTS (SELECT 1 FROM card_catalog WHERE country = 'TW' AND bank_name = '中國信託銀行' AND card_name = '中國信託紅利白金卡 (VISA)');
UPDATE card_catalog SET image_url = CASE WHEN image_url IS NULL OR image_url LIKE '/images/cards/cardentify/%' THEN '/images/cards/cardentify/8a760b1fcbe5-visa-42bdfd71.jpg' ELSE image_url END, network = COALESCE(network, 'VISA'), tags = COALESCE(tags, 'Cardentify,信用卡,来源:Apple Pay,BIN:431195'), notes = COALESCE(notes, 'Cardentify import; original bank: 中國信託銀行; type: Credit; source: Apple Pay') WHERE country = 'TW' AND bank_name = '中國信託銀行' AND card_name = '中國信託紅利白金卡 (VISA)';

INSERT INTO card_catalog (country, bank_name, card_name, card_tier, network, tags, image_url, variants, annual_fee_cny, notes)
SELECT 'TW', '中國信託銀行', '中國信託LINE Pay商務御璽卡', '御玺卡', 'VISA', 'Cardentify,信用卡,来源:Apple Pay,BIN:430451', '/images/cards/cardentify/8a760b1fcbe5-line-pay-9ab2314b.jpg', NULL, NULL, 'Cardentify import; original bank: 中國信託銀行; type: Credit; source: Apple Pay'
WHERE NOT EXISTS (SELECT 1 FROM card_catalog WHERE country = 'TW' AND bank_name = '中國信託銀行' AND card_name = '中國信託LINE Pay商務御璽卡');
UPDATE card_catalog SET image_url = CASE WHEN image_url IS NULL OR image_url LIKE '/images/cards/cardentify/%' THEN '/images/cards/cardentify/8a760b1fcbe5-line-pay-9ab2314b.jpg' ELSE image_url END, network = COALESCE(network, 'VISA'), tags = COALESCE(tags, 'Cardentify,信用卡,来源:Apple Pay,BIN:430451'), notes = COALESCE(notes, 'Cardentify import; original bank: 中國信託銀行; type: Credit; source: Apple Pay') WHERE country = 'TW' AND bank_name = '中國信託銀行' AND card_name = '中國信託LINE Pay商務御璽卡';

INSERT INTO card_catalog (country, bank_name, card_name, card_tier, network, tags, image_url, variants, annual_fee_cny, notes)
SELECT 'TW', '中國信託銀行', '中信無印良品白金卡', '白金卡', 'VISA', 'Cardentify,信用卡,来源:Apple Pay,BIN:431195', '/images/cards/cardentify/8a760b1fcbe5-8773079ce1e4-c2da6ffc.jpg', NULL, NULL, 'Cardentify import; original bank: 中國信託銀行; type: Credit; source: Apple Pay'
WHERE NOT EXISTS (SELECT 1 FROM card_catalog WHERE country = 'TW' AND bank_name = '中國信託銀行' AND card_name = '中信無印良品白金卡');
UPDATE card_catalog SET image_url = CASE WHEN image_url IS NULL OR image_url LIKE '/images/cards/cardentify/%' THEN '/images/cards/cardentify/8a760b1fcbe5-8773079ce1e4-c2da6ffc.jpg' ELSE image_url END, network = COALESCE(network, 'VISA'), tags = COALESCE(tags, 'Cardentify,信用卡,来源:Apple Pay,BIN:431195'), notes = COALESCE(notes, 'Cardentify import; original bank: 中國信託銀行; type: Credit; source: Apple Pay') WHERE country = 'TW' AND bank_name = '中國信託銀行' AND card_name = '中信無印良品白金卡';

INSERT INTO card_catalog (country, bank_name, card_name, card_tier, network, tags, image_url, variants, annual_fee_cny, notes)
SELECT 'TW', '中國信託銀行', '中國信託中華電信普卡', 'Classic', 'VISA', 'Cardentify,信用卡,来源:Apple Pay,BIN:456301', '/images/cards/cardentify/8a760b1fcbe5-81a93f06d931-ac1f876f.jpg', NULL, NULL, 'Cardentify import; original bank: 中國信託銀行; type: Credit; source: Apple Pay'
WHERE NOT EXISTS (SELECT 1 FROM card_catalog WHERE country = 'TW' AND bank_name = '中國信託銀行' AND card_name = '中國信託中華電信普卡');
UPDATE card_catalog SET image_url = CASE WHEN image_url IS NULL OR image_url LIKE '/images/cards/cardentify/%' THEN '/images/cards/cardentify/8a760b1fcbe5-81a93f06d931-ac1f876f.jpg' ELSE image_url END, network = COALESCE(network, 'VISA'), tags = COALESCE(tags, 'Cardentify,信用卡,来源:Apple Pay,BIN:456301'), notes = COALESCE(notes, 'Cardentify import; original bank: 中國信託銀行; type: Credit; source: Apple Pay') WHERE country = 'TW' AND bank_name = '中國信託銀行' AND card_name = '中國信託中華電信普卡';

INSERT INTO card_catalog (country, bank_name, card_name, card_tier, network, tags, image_url, variants, annual_fee_cny, notes)
SELECT 'TW', '國泰世華銀行', '國泰世華VISA白金CUBE卡', '白金卡', 'VISA', 'Cardentify,信用卡,来源:Apple Pay,BIN:402310', '/images/cards/cardentify/56f711b4e6ab-visacube-38d62edd.jpg', NULL, NULL, 'Cardentify import; original bank: 國泰世華銀行; type: Credit; source: Apple Pay'
WHERE NOT EXISTS (SELECT 1 FROM card_catalog WHERE country = 'TW' AND bank_name = '國泰世華銀行' AND card_name = '國泰世華VISA白金CUBE卡');
UPDATE card_catalog SET image_url = CASE WHEN image_url IS NULL OR image_url LIKE '/images/cards/cardentify/%' THEN '/images/cards/cardentify/56f711b4e6ab-visacube-38d62edd.jpg' ELSE image_url END, network = COALESCE(network, 'VISA'), tags = COALESCE(tags, 'Cardentify,信用卡,来源:Apple Pay,BIN:402310'), notes = COALESCE(notes, 'Cardentify import; original bank: 國泰世華銀行; type: Credit; source: Apple Pay') WHERE country = 'TW' AND bank_name = '國泰世華銀行' AND card_name = '國泰世華VISA白金CUBE卡';

INSERT INTO card_catalog (country, bank_name, card_name, card_tier, network, tags, image_url, variants, annual_fee_cny, notes)
SELECT 'TW', '國泰世華銀行', '國泰世華VISA御璽CUBE卡', '御玺卡', 'VISA', 'Cardentify,信用卡,来源:Apple Pay,BIN:428430', '/images/cards/cardentify/56f711b4e6ab-visacube-6212b7f1.jpg', NULL, NULL, 'Cardentify import; original bank: 國泰世華銀行; type: Credit; source: Apple Pay'
WHERE NOT EXISTS (SELECT 1 FROM card_catalog WHERE country = 'TW' AND bank_name = '國泰世華銀行' AND card_name = '國泰世華VISA御璽CUBE卡');
UPDATE card_catalog SET image_url = CASE WHEN image_url IS NULL OR image_url LIKE '/images/cards/cardentify/%' THEN '/images/cards/cardentify/56f711b4e6ab-visacube-6212b7f1.jpg' ELSE image_url END, network = COALESCE(network, 'VISA'), tags = COALESCE(tags, 'Cardentify,信用卡,来源:Apple Pay,BIN:428430'), notes = COALESCE(notes, 'Cardentify import; original bank: 國泰世華銀行; type: Credit; source: Apple Pay') WHERE country = 'TW' AND bank_name = '國泰世華銀行' AND card_name = '國泰世華VISA御璽CUBE卡';

INSERT INTO card_catalog (country, bank_name, card_name, card_tier, network, tags, image_url, variants, annual_fee_cny, notes)
SELECT 'TW', '國泰世華銀行', '國泰世華Mastercard白金CUBE卡', '白金卡', 'Mastercard', 'Cardentify,信用卡,来源:Apple Pay,BIN:514869', '/images/cards/cardentify/56f711b4e6ab-mastercardcube-58b191cc.jpg', NULL, NULL, 'Cardentify import; original bank: 國泰世華銀行; type: Credit; source: Apple Pay'
WHERE NOT EXISTS (SELECT 1 FROM card_catalog WHERE country = 'TW' AND bank_name = '國泰世華銀行' AND card_name = '國泰世華Mastercard白金CUBE卡');
UPDATE card_catalog SET image_url = CASE WHEN image_url IS NULL OR image_url LIKE '/images/cards/cardentify/%' THEN '/images/cards/cardentify/56f711b4e6ab-mastercardcube-58b191cc.jpg' ELSE image_url END, network = COALESCE(network, 'Mastercard'), tags = COALESCE(tags, 'Cardentify,信用卡,来源:Apple Pay,BIN:514869'), notes = COALESCE(notes, 'Cardentify import; original bank: 國泰世華銀行; type: Credit; source: Apple Pay') WHERE country = 'TW' AND bank_name = '國泰世華銀行' AND card_name = '國泰世華Mastercard白金CUBE卡';

INSERT INTO card_catalog (country, bank_name, card_name, card_tier, network, tags, image_url, variants, annual_fee_cny, notes)
SELECT 'TW', '國泰世華銀行', '國泰世華Mastercard鈦金CUBE卡', '钛金卡', 'Mastercard', 'Cardentify,信用卡,来源:Apple Pay,BIN:524106', '/images/cards/cardentify/56f711b4e6ab-mastercardcube-f53cb0d7.jpg', NULL, NULL, 'Cardentify import; original bank: 國泰世華銀行; type: Credit; source: Apple Pay'
WHERE NOT EXISTS (SELECT 1 FROM card_catalog WHERE country = 'TW' AND bank_name = '國泰世華銀行' AND card_name = '國泰世華Mastercard鈦金CUBE卡');
UPDATE card_catalog SET image_url = CASE WHEN image_url IS NULL OR image_url LIKE '/images/cards/cardentify/%' THEN '/images/cards/cardentify/56f711b4e6ab-mastercardcube-f53cb0d7.jpg' ELSE image_url END, network = COALESCE(network, 'Mastercard'), tags = COALESCE(tags, 'Cardentify,信用卡,来源:Apple Pay,BIN:524106'), notes = COALESCE(notes, 'Cardentify import; original bank: 國泰世華銀行; type: Credit; source: Apple Pay') WHERE country = 'TW' AND bank_name = '國泰世華銀行' AND card_name = '國泰世華Mastercard鈦金CUBE卡';

INSERT INTO card_catalog (country, bank_name, card_name, card_tier, network, tags, image_url, variants, annual_fee_cny, notes)
SELECT 'TW', '國泰世華銀行', '國泰世華Mastercard鈦商CUBE卡', '钛金卡', 'Mastercard', 'Cardentify,信用卡,来源:Apple Pay,BIN:524106', '/images/cards/cardentify/56f711b4e6ab-mastercardcube-1d2c074e.jpg', NULL, NULL, 'Cardentify import; original bank: 國泰世華銀行; type: Credit; source: Apple Pay'
WHERE NOT EXISTS (SELECT 1 FROM card_catalog WHERE country = 'TW' AND bank_name = '國泰世華銀行' AND card_name = '國泰世華Mastercard鈦商CUBE卡');
UPDATE card_catalog SET image_url = CASE WHEN image_url IS NULL OR image_url LIKE '/images/cards/cardentify/%' THEN '/images/cards/cardentify/56f711b4e6ab-mastercardcube-1d2c074e.jpg' ELSE image_url END, network = COALESCE(network, 'Mastercard'), tags = COALESCE(tags, 'Cardentify,信用卡,来源:Apple Pay,BIN:524106'), notes = COALESCE(notes, 'Cardentify import; original bank: 國泰世華銀行; type: Credit; source: Apple Pay') WHERE country = 'TW' AND bank_name = '國泰世華銀行' AND card_name = '國泰世華Mastercard鈦商CUBE卡';

INSERT INTO card_catalog (country, bank_name, card_name, card_tier, network, tags, image_url, variants, annual_fee_cny, notes)
SELECT 'US', 'Chase', 'Chase Freedom Flex', '世界之极卡', 'Mastercard', 'Cardentify,信用卡,来源:Apple Pay,BIN:521307', '/images/cards/cardentify/chase-chase-freedom-flex-5f33d5b3.jpg', NULL, NULL, 'Cardentify import; original bank: Chase; type: Credit; source: Apple Pay'
WHERE NOT EXISTS (SELECT 1 FROM card_catalog WHERE country = 'US' AND bank_name = 'Chase' AND card_name = 'Chase Freedom Flex');
UPDATE card_catalog SET image_url = CASE WHEN image_url IS NULL OR image_url LIKE '/images/cards/cardentify/%' THEN '/images/cards/cardentify/chase-chase-freedom-flex-5f33d5b3.jpg' ELSE image_url END, network = COALESCE(network, 'Mastercard'), tags = COALESCE(tags, 'Cardentify,信用卡,来源:Apple Pay,BIN:521307'), notes = COALESCE(notes, 'Cardentify import; original bank: Chase; type: Credit; source: Apple Pay') WHERE country = 'US' AND bank_name = 'Chase' AND card_name = 'Chase Freedom Flex';

INSERT INTO card_catalog (country, bank_name, card_name, card_tier, network, tags, image_url, variants, annual_fee_cny, notes)
SELECT 'JP', '千葉銀行', 'スーパーカード', '普卡', 'JCB', 'Cardentify,信用卡,来源:Apple Pay,BIN:354270', '/images/cards/cardentify/b1bf3da7d690-d79cc677dfd1-553b45e1.svg', NULL, NULL, 'Cardentify import; original bank: 千葉銀行; type: Credit; source: Apple Pay'
WHERE NOT EXISTS (SELECT 1 FROM card_catalog WHERE country = 'JP' AND bank_name = '千葉銀行' AND card_name = 'スーパーカード');
UPDATE card_catalog SET image_url = CASE WHEN image_url IS NULL OR image_url LIKE '/images/cards/cardentify/%' THEN '/images/cards/cardentify/b1bf3da7d690-d79cc677dfd1-553b45e1.svg' ELSE image_url END, network = COALESCE(network, 'JCB'), tags = COALESCE(tags, 'Cardentify,信用卡,来源:Apple Pay,BIN:354270'), notes = COALESCE(notes, 'Cardentify import; original bank: 千葉銀行; type: Credit; source: Apple Pay') WHERE country = 'JP' AND bank_name = '千葉銀行' AND card_name = 'スーパーカード';

INSERT INTO card_catalog (country, bank_name, card_name, card_tier, network, tags, image_url, variants, annual_fee_cny, notes)
SELECT 'US', 'Chime', 'Chime', NULL, 'VISA', 'Cardentify,借记卡,来源:Apple Pay,BIN:498503', '/images/cards/cardentify/chime-chime-e88b8c90.jpg', NULL, NULL, 'Cardentify import; original bank: Chime; type: Debit; source: Apple Pay'
WHERE NOT EXISTS (SELECT 1 FROM card_catalog WHERE country = 'US' AND bank_name = 'Chime' AND card_name = 'Chime');
UPDATE card_catalog SET image_url = CASE WHEN image_url IS NULL OR image_url LIKE '/images/cards/cardentify/%' THEN '/images/cards/cardentify/chime-chime-e88b8c90.jpg' ELSE image_url END, network = COALESCE(network, 'VISA'), tags = COALESCE(tags, 'Cardentify,借记卡,来源:Apple Pay,BIN:498503'), notes = COALESCE(notes, 'Cardentify import; original bank: Chime; type: Debit; source: Apple Pay') WHERE country = 'US' AND bank_name = 'Chime' AND card_name = 'Chime';

INSERT INTO card_catalog (country, bank_name, card_name, card_tier, network, tags, image_url, variants, annual_fee_cny, notes)
SELECT 'CN', '中信银行', '美国运通金卡借记卡', '金卡', 'AMEX', 'Cardentify,借记卡,来源:云闪付,BIN:377138', '/images/cards/cardentify/6cc73899f44f-dfba0f3b1246-f5fcb4dd.jpg', NULL, NULL, 'Cardentify import; original bank: 中信银行; type: Debit; source: 云闪付'
WHERE NOT EXISTS (SELECT 1 FROM card_catalog WHERE country = 'CN' AND bank_name = '中信银行' AND card_name = '美国运通金卡借记卡');
UPDATE card_catalog SET image_url = CASE WHEN image_url IS NULL OR image_url LIKE '/images/cards/cardentify/%' THEN '/images/cards/cardentify/6cc73899f44f-dfba0f3b1246-f5fcb4dd.jpg' ELSE image_url END, network = COALESCE(network, 'AMEX'), tags = COALESCE(tags, 'Cardentify,借记卡,来源:云闪付,BIN:377138'), notes = COALESCE(notes, 'Cardentify import; original bank: 中信银行; type: Debit; source: 云闪付') WHERE country = 'CN' AND bank_name = '中信银行' AND card_name = '美国运通金卡借记卡';

INSERT INTO card_catalog (country, bank_name, card_name, card_tier, network, tags, image_url, variants, annual_fee_cny, notes)
SELECT 'CN', '中信银行', '万豪旅享家银联联名卡精逸白金卡', '白金卡', 'UnionPay', 'Cardentify,信用卡,来源:Apple Pay,BIN:622688', '/images/cards/cardentify/6cc73899f44f-8b8c2a06c844-e494544f.jpg', NULL, NULL, 'Cardentify import; original bank: 中信银行; type: Credit; source: Apple Pay'
WHERE NOT EXISTS (SELECT 1 FROM card_catalog WHERE country = 'CN' AND bank_name = '中信银行' AND card_name = '万豪旅享家银联联名卡精逸白金卡');
UPDATE card_catalog SET image_url = CASE WHEN image_url IS NULL OR image_url LIKE '/images/cards/cardentify/%' THEN '/images/cards/cardentify/6cc73899f44f-8b8c2a06c844-e494544f.jpg' ELSE image_url END, network = COALESCE(network, 'UnionPay'), tags = COALESCE(tags, 'Cardentify,信用卡,来源:Apple Pay,BIN:622688'), notes = COALESCE(notes, 'Cardentify import; original bank: 中信银行; type: Credit; source: Apple Pay') WHERE country = 'CN' AND bank_name = '中信银行' AND card_name = '万豪旅享家银联联名卡精逸白金卡';

INSERT INTO card_catalog (country, bank_name, card_name, card_tier, network, tags, image_url, variants, annual_fee_cny, notes)
SELECT 'CN', '中信银行', '幸福财富白金卡', '白金卡', 'UnionPay', 'Cardentify,借记卡,来源:云闪付', '/images/cards/cardentify/6cc73899f44f-9b59745ffe7e-4e498dec.jpg', NULL, NULL, 'Cardentify import; original bank: 中信银行; type: Debit; source: 云闪付'
WHERE NOT EXISTS (SELECT 1 FROM card_catalog WHERE country = 'CN' AND bank_name = '中信银行' AND card_name = '幸福财富白金卡');
UPDATE card_catalog SET image_url = CASE WHEN image_url IS NULL OR image_url LIKE '/images/cards/cardentify/%' THEN '/images/cards/cardentify/6cc73899f44f-9b59745ffe7e-4e498dec.jpg' ELSE image_url END, network = COALESCE(network, 'UnionPay'), tags = COALESCE(tags, 'Cardentify,借记卡,来源:云闪付'), notes = COALESCE(notes, 'Cardentify import; original bank: 中信银行; type: Debit; source: 云闪付') WHERE country = 'CN' AND bank_name = '中信银行' AND card_name = '幸福财富白金卡';

INSERT INTO card_catalog (country, bank_name, card_name, card_tier, network, tags, image_url, variants, annual_fee_cny, notes)
SELECT 'CN', '中信银行', '菁英卡', '白金卡', 'UnionPay', 'Cardentify,借记卡,来源:云闪付', '/images/cards/cardentify/6cc73899f44f-bbd50211358b-6ba584cd.jpg', NULL, NULL, 'Cardentify import; original bank: 中信银行; type: Debit; source: 云闪付'
WHERE NOT EXISTS (SELECT 1 FROM card_catalog WHERE country = 'CN' AND bank_name = '中信银行' AND card_name = '菁英卡');
UPDATE card_catalog SET image_url = CASE WHEN image_url IS NULL OR image_url LIKE '/images/cards/cardentify/%' THEN '/images/cards/cardentify/6cc73899f44f-bbd50211358b-6ba584cd.jpg' ELSE image_url END, network = COALESCE(network, 'UnionPay'), tags = COALESCE(tags, 'Cardentify,借记卡,来源:云闪付'), notes = COALESCE(notes, 'Cardentify import; original bank: 中信银行; type: Debit; source: 云闪付') WHERE country = 'CN' AND bank_name = '中信银行' AND card_name = '菁英卡';

INSERT INTO card_catalog (country, bank_name, card_name, card_tier, network, tags, image_url, variants, annual_fee_cny, notes)
SELECT 'CN', '中信银行', '四叶草金卡', '金卡', 'UnionPay', 'Cardentify,借记卡,来源:云闪付', '/images/cards/cardentify/6cc73899f44f-2bdd79e7f386-dfa75057.jpg', NULL, NULL, 'Cardentify import; original bank: 中信银行; type: Debit; source: 云闪付'
WHERE NOT EXISTS (SELECT 1 FROM card_catalog WHERE country = 'CN' AND bank_name = '中信银行' AND card_name = '四叶草金卡');
UPDATE card_catalog SET image_url = CASE WHEN image_url IS NULL OR image_url LIKE '/images/cards/cardentify/%' THEN '/images/cards/cardentify/6cc73899f44f-2bdd79e7f386-dfa75057.jpg' ELSE image_url END, network = COALESCE(network, 'UnionPay'), tags = COALESCE(tags, 'Cardentify,借记卡,来源:云闪付'), notes = COALESCE(notes, 'Cardentify import; original bank: 中信银行; type: Debit; source: 云闪付') WHERE country = 'CN' AND bank_name = '中信银行' AND card_name = '四叶草金卡';

INSERT INTO card_catalog (country, bank_name, card_name, card_tier, network, tags, image_url, variants, annual_fee_cny, notes)
SELECT 'CN', '中信银行', '护航计划联名卡', '白金卡', 'UnionPay', 'Cardentify,借记卡,来源:云闪付', '/images/cards/cardentify/6cc73899f44f-0e74c7ce91d5-a21a0b3f.jpg', NULL, NULL, 'Cardentify import; original bank: 中信银行; type: Debit; source: 云闪付'
WHERE NOT EXISTS (SELECT 1 FROM card_catalog WHERE country = 'CN' AND bank_name = '中信银行' AND card_name = '护航计划联名卡');
UPDATE card_catalog SET image_url = CASE WHEN image_url IS NULL OR image_url LIKE '/images/cards/cardentify/%' THEN '/images/cards/cardentify/6cc73899f44f-0e74c7ce91d5-a21a0b3f.jpg' ELSE image_url END, network = COALESCE(network, 'UnionPay'), tags = COALESCE(tags, 'Cardentify,借记卡,来源:云闪付'), notes = COALESCE(notes, 'Cardentify import; original bank: 中信银行; type: Debit; source: 云闪付') WHERE country = 'CN' AND bank_name = '中信银行' AND card_name = '护航计划联名卡';

INSERT INTO card_catalog (country, bank_name, card_name, card_tier, network, tags, image_url, variants, annual_fee_cny, notes)
SELECT 'CN', '中信银行', '幸福年华卡', '普卡', 'UnionPay', 'Cardentify,借记卡,来源:云闪付,BIN:621773', '/images/cards/cardentify/6cc73899f44f-3e259c92681f-d90146e1.jpg', NULL, NULL, 'Cardentify import; original bank: 中信银行; type: Debit; source: 云闪付'
WHERE NOT EXISTS (SELECT 1 FROM card_catalog WHERE country = 'CN' AND bank_name = '中信银行' AND card_name = '幸福年华卡');
UPDATE card_catalog SET image_url = CASE WHEN image_url IS NULL OR image_url LIKE '/images/cards/cardentify/%' THEN '/images/cards/cardentify/6cc73899f44f-3e259c92681f-d90146e1.jpg' ELSE image_url END, network = COALESCE(network, 'UnionPay'), tags = COALESCE(tags, 'Cardentify,借记卡,来源:云闪付,BIN:621773'), notes = COALESCE(notes, 'Cardentify import; original bank: 中信银行; type: Debit; source: 云闪付') WHERE country = 'CN' AND bank_name = '中信银行' AND card_name = '幸福年华卡';

INSERT INTO card_catalog (country, bank_name, card_name, card_tier, network, tags, image_url, variants, annual_fee_cny, notes)
SELECT 'CN', '建设银行', '龙卡JOY信用卡', '白金卡', 'UnionPay', 'Cardentify,信用卡,来源:Apple Pay,BIN:622708', '/images/cards/cardentify/05a4cdb84e13-joy-03f1a308.jpg', NULL, NULL, 'Cardentify import; original bank: 中国建设银行; type: Credit; source: Apple Pay'
WHERE NOT EXISTS (SELECT 1 FROM card_catalog WHERE country = 'CN' AND bank_name = '建设银行' AND card_name = '龙卡JOY信用卡');
UPDATE card_catalog SET image_url = CASE WHEN image_url IS NULL OR image_url LIKE '/images/cards/cardentify/%' THEN '/images/cards/cardentify/05a4cdb84e13-joy-03f1a308.jpg' ELSE image_url END, network = COALESCE(network, 'UnionPay'), tags = COALESCE(tags, 'Cardentify,信用卡,来源:Apple Pay,BIN:622708'), notes = COALESCE(notes, 'Cardentify import; original bank: 中国建设银行; type: Credit; source: Apple Pay') WHERE country = 'CN' AND bank_name = '建设银行' AND card_name = '龙卡JOY信用卡';

INSERT INTO card_catalog (country, bank_name, card_name, card_tier, network, tags, image_url, variants, annual_fee_cny, notes)
SELECT 'CN', '建设银行', '银联储蓄卡', '普卡', 'UnionPay', 'Cardentify,借记卡,来源:Apple Pay,BIN:621700', '/images/cards/cardentify/05a4cdb84e13-8b4fe59f5ef0-c0ccd169.jpg', NULL, NULL, 'Cardentify import; original bank: 中国建设银行; type: Debit; source: Apple Pay'
WHERE NOT EXISTS (SELECT 1 FROM card_catalog WHERE country = 'CN' AND bank_name = '建设银行' AND card_name = '银联储蓄卡');
UPDATE card_catalog SET image_url = CASE WHEN image_url IS NULL OR image_url LIKE '/images/cards/cardentify/%' THEN '/images/cards/cardentify/05a4cdb84e13-8b4fe59f5ef0-c0ccd169.jpg' ELSE image_url END, network = COALESCE(network, 'UnionPay'), tags = COALESCE(tags, 'Cardentify,借记卡,来源:Apple Pay,BIN:621700'), notes = COALESCE(notes, 'Cardentify import; original bank: 中国建设银行; type: Debit; source: Apple Pay') WHERE country = 'CN' AND bank_name = '建设银行' AND card_name = '银联储蓄卡';

INSERT INTO card_catalog (country, bank_name, card_name, card_tier, network, tags, image_url, variants, annual_fee_cny, notes)
SELECT 'CN', '建设银行', '正青春', '白金卡', 'UnionPay', 'Cardentify,信用卡,来源:Mi Pay', '/images/cards/cardentify/05a4cdb84e13-6cee955e0364-5c0b301d.jpg', NULL, NULL, 'Cardentify import; original bank: 中国建设银行; type: Credit; source: Mi Pay'
WHERE NOT EXISTS (SELECT 1 FROM card_catalog WHERE country = 'CN' AND bank_name = '建设银行' AND card_name = '正青春');
UPDATE card_catalog SET image_url = CASE WHEN image_url IS NULL OR image_url LIKE '/images/cards/cardentify/%' THEN '/images/cards/cardentify/05a4cdb84e13-6cee955e0364-5c0b301d.jpg' ELSE image_url END, network = COALESCE(network, 'UnionPay'), tags = COALESCE(tags, 'Cardentify,信用卡,来源:Mi Pay'), notes = COALESCE(notes, 'Cardentify import; original bank: 中国建设银行; type: Credit; source: Mi Pay') WHERE country = 'CN' AND bank_name = '建设银行' AND card_name = '正青春';

INSERT INTO card_catalog (country, bank_name, card_name, card_tier, network, tags, image_url, variants, annual_fee_cny, notes)
SELECT 'CN', '建设银行', '2233', '白金卡', 'UnionPay', 'Cardentify,信用卡,来源:Mi Pay', '/images/cards/cardentify/05a4cdb84e13-2233-ad620445.jpg', NULL, NULL, 'Cardentify import; original bank: 中国建设银行; type: Credit; source: Mi Pay'
WHERE NOT EXISTS (SELECT 1 FROM card_catalog WHERE country = 'CN' AND bank_name = '建设银行' AND card_name = '2233');
UPDATE card_catalog SET image_url = CASE WHEN image_url IS NULL OR image_url LIKE '/images/cards/cardentify/%' THEN '/images/cards/cardentify/05a4cdb84e13-2233-ad620445.jpg' ELSE image_url END, network = COALESCE(network, 'UnionPay'), tags = COALESCE(tags, 'Cardentify,信用卡,来源:Mi Pay'), notes = COALESCE(notes, 'Cardentify import; original bank: 中国建设银行; type: Credit; source: Mi Pay') WHERE country = 'CN' AND bank_name = '建设银行' AND card_name = '2233';

INSERT INTO card_catalog (country, bank_name, card_name, card_tier, network, tags, image_url, variants, annual_fee_cny, notes)
SELECT 'CN', '建设银行', '哔哩哔哩2', '白金卡', 'UnionPay', 'Cardentify,信用卡,来源:Mi Pay', '/images/cards/cardentify/05a4cdb84e13-2-5eb9b256.jpg', NULL, NULL, 'Cardentify import; original bank: 中国建设银行; type: Credit; source: Mi Pay'
WHERE NOT EXISTS (SELECT 1 FROM card_catalog WHERE country = 'CN' AND bank_name = '建设银行' AND card_name = '哔哩哔哩2');
UPDATE card_catalog SET image_url = CASE WHEN image_url IS NULL OR image_url LIKE '/images/cards/cardentify/%' THEN '/images/cards/cardentify/05a4cdb84e13-2-5eb9b256.jpg' ELSE image_url END, network = COALESCE(network, 'UnionPay'), tags = COALESCE(tags, 'Cardentify,信用卡,来源:Mi Pay'), notes = COALESCE(notes, 'Cardentify import; original bank: 中国建设银行; type: Credit; source: Mi Pay') WHERE country = 'CN' AND bank_name = '建设银行' AND card_name = '哔哩哔哩2';

INSERT INTO card_catalog (country, bank_name, card_name, card_tier, network, tags, image_url, variants, annual_fee_cny, notes)
SELECT 'CN', '建设银行', '哔哩哔哩太空探索', '白金卡', 'UnionPay', 'Cardentify,信用卡,来源:Mi Pay', '/images/cards/cardentify/05a4cdb84e13-36d03137161e-e937af71.jpg', NULL, NULL, 'Cardentify import; original bank: 中国建设银行; type: Credit; source: Mi Pay'
WHERE NOT EXISTS (SELECT 1 FROM card_catalog WHERE country = 'CN' AND bank_name = '建设银行' AND card_name = '哔哩哔哩太空探索');
UPDATE card_catalog SET image_url = CASE WHEN image_url IS NULL OR image_url LIKE '/images/cards/cardentify/%' THEN '/images/cards/cardentify/05a4cdb84e13-36d03137161e-e937af71.jpg' ELSE image_url END, network = COALESCE(network, 'UnionPay'), tags = COALESCE(tags, 'Cardentify,信用卡,来源:Mi Pay'), notes = COALESCE(notes, 'Cardentify import; original bank: 中国建设银行; type: Credit; source: Mi Pay') WHERE country = 'CN' AND bank_name = '建设银行' AND card_name = '哔哩哔哩太空探索';

INSERT INTO card_catalog (country, bank_name, card_name, card_tier, network, tags, image_url, variants, annual_fee_cny, notes)
SELECT 'CN', '建设银行', '花开敦煌', '白金卡', 'UnionPay', 'Cardentify,信用卡,来源:Mi Pay', '/images/cards/cardentify/05a4cdb84e13-f3fd43e97a06-45ae51de.jpg', NULL, NULL, 'Cardentify import; original bank: 中国建设银行; type: Credit; source: Mi Pay'
WHERE NOT EXISTS (SELECT 1 FROM card_catalog WHERE country = 'CN' AND bank_name = '建设银行' AND card_name = '花开敦煌');
UPDATE card_catalog SET image_url = CASE WHEN image_url IS NULL OR image_url LIKE '/images/cards/cardentify/%' THEN '/images/cards/cardentify/05a4cdb84e13-f3fd43e97a06-45ae51de.jpg' ELSE image_url END, network = COALESCE(network, 'UnionPay'), tags = COALESCE(tags, 'Cardentify,信用卡,来源:Mi Pay'), notes = COALESCE(notes, 'Cardentify import; original bank: 中国建设银行; type: Credit; source: Mi Pay') WHERE country = 'CN' AND bank_name = '建设银行' AND card_name = '花开敦煌';

INSERT INTO card_catalog (country, bank_name, card_name, card_tier, network, tags, image_url, variants, annual_fee_cny, notes)
SELECT 'CN', '建设银行', '建行生活plus', '白金卡', 'UnionPay', 'Cardentify,信用卡,来源:Mi Pay', '/images/cards/cardentify/05a4cdb84e13-plus-13924d0d.jpg', NULL, NULL, 'Cardentify import; original bank: 中国建设银行; type: Credit; source: Mi Pay'
WHERE NOT EXISTS (SELECT 1 FROM card_catalog WHERE country = 'CN' AND bank_name = '建设银行' AND card_name = '建行生活plus');
UPDATE card_catalog SET image_url = CASE WHEN image_url IS NULL OR image_url LIKE '/images/cards/cardentify/%' THEN '/images/cards/cardentify/05a4cdb84e13-plus-13924d0d.jpg' ELSE image_url END, network = COALESCE(network, 'UnionPay'), tags = COALESCE(tags, 'Cardentify,信用卡,来源:Mi Pay'), notes = COALESCE(notes, 'Cardentify import; original bank: 中国建设银行; type: Credit; source: Mi Pay') WHERE country = 'CN' AND bank_name = '建设银行' AND card_name = '建行生活plus';

INSERT INTO card_catalog (country, bank_name, card_name, card_tier, network, tags, image_url, variants, annual_fee_cny, notes)
SELECT 'CN', '建设银行', '龙年贺岁', '普卡', 'UnionPay', 'Cardentify,借记卡,来源:Mi Pay', '/images/cards/cardentify/05a4cdb84e13-0b33b9242095-9c1e4620.jpg', NULL, NULL, 'Cardentify import; original bank: 中国建设银行; type: Debit; source: Mi Pay'
WHERE NOT EXISTS (SELECT 1 FROM card_catalog WHERE country = 'CN' AND bank_name = '建设银行' AND card_name = '龙年贺岁');
UPDATE card_catalog SET image_url = CASE WHEN image_url IS NULL OR image_url LIKE '/images/cards/cardentify/%' THEN '/images/cards/cardentify/05a4cdb84e13-0b33b9242095-9c1e4620.jpg' ELSE image_url END, network = COALESCE(network, 'UnionPay'), tags = COALESCE(tags, 'Cardentify,借记卡,来源:Mi Pay'), notes = COALESCE(notes, 'Cardentify import; original bank: 中国建设银行; type: Debit; source: Mi Pay') WHERE country = 'CN' AND bank_name = '建设银行' AND card_name = '龙年贺岁';

INSERT INTO card_catalog (country, bank_name, card_name, card_tier, network, tags, image_url, variants, annual_fee_cny, notes)
SELECT 'HK', '中國建設銀行(亞洲)', 'CCBA TRAVO World Mastercard', '世界卡', 'Mastercard', 'Cardentify,信用卡,来源:Apple Pay,BIN:55472427', '/images/cards/cardentify/f374f3f9f63f-ccba-travo-world-mastercard-60c0dcc6.jpg', NULL, NULL, 'Cardentify import; original bank: 中國建設銀行(亞洲); type: Credit; source: Apple Pay'
WHERE NOT EXISTS (SELECT 1 FROM card_catalog WHERE country = 'HK' AND bank_name = '中國建設銀行(亞洲)' AND card_name = 'CCBA TRAVO World Mastercard');
UPDATE card_catalog SET image_url = CASE WHEN image_url IS NULL OR image_url LIKE '/images/cards/cardentify/%' THEN '/images/cards/cardentify/f374f3f9f63f-ccba-travo-world-mastercard-60c0dcc6.jpg' ELSE image_url END, network = COALESCE(network, 'Mastercard'), tags = COALESCE(tags, 'Cardentify,信用卡,来源:Apple Pay,BIN:55472427'), notes = COALESCE(notes, 'Cardentify import; original bank: 中國建設銀行(亞洲); type: Credit; source: Apple Pay') WHERE country = 'HK' AND bank_name = '中國建設銀行(亞洲)' AND card_name = 'CCBA TRAVO World Mastercard';

INSERT INTO card_catalog (country, bank_name, card_name, card_tier, network, tags, image_url, variants, annual_fee_cny, notes)
SELECT 'HK', '中國建設銀行(亞洲)', 'eye Credit Card', '御玺卡', 'VISA', 'Cardentify,信用卡,来源:Apple Pay,BIN:43178420', '/images/cards/cardentify/f374f3f9f63f-eye-credit-card-d7a427ed.jpg', NULL, NULL, 'Cardentify import; original bank: 中國建設銀行(亞洲); type: Credit; source: Apple Pay'
WHERE NOT EXISTS (SELECT 1 FROM card_catalog WHERE country = 'HK' AND bank_name = '中國建設銀行(亞洲)' AND card_name = 'eye Credit Card');
UPDATE card_catalog SET image_url = CASE WHEN image_url IS NULL OR image_url LIKE '/images/cards/cardentify/%' THEN '/images/cards/cardentify/f374f3f9f63f-eye-credit-card-d7a427ed.jpg' ELSE image_url END, network = COALESCE(network, 'VISA'), tags = COALESCE(tags, 'Cardentify,信用卡,来源:Apple Pay,BIN:43178420'), notes = COALESCE(notes, 'Cardentify import; original bank: 中國建設銀行(亞洲); type: Credit; source: Apple Pay') WHERE country = 'HK' AND bank_name = '中國建設銀行(亞洲)' AND card_name = 'eye Credit Card';

INSERT INTO card_catalog (country, bank_name, card_name, card_tier, network, tags, image_url, variants, annual_fee_cny, notes)
SELECT 'CN', '广发银行', '广发银行美国运通Lucky借记卡', 'Member', 'AMEX', 'Cardentify,借记卡,来源:云闪付,BIN:370330', '/images/cards/cardentify/2d2c3284d460-lucky-2d8f66ec.jpg', NULL, NULL, 'Cardentify import; original bank: 广发银行; type: Debit; source: 云闪付'
WHERE NOT EXISTS (SELECT 1 FROM card_catalog WHERE country = 'CN' AND bank_name = '广发银行' AND card_name = '广发银行美国运通Lucky借记卡');
UPDATE card_catalog SET image_url = CASE WHEN image_url IS NULL OR image_url LIKE '/images/cards/cardentify/%' THEN '/images/cards/cardentify/2d2c3284d460-lucky-2d8f66ec.jpg' ELSE image_url END, network = COALESCE(network, 'AMEX'), tags = COALESCE(tags, 'Cardentify,借记卡,来源:云闪付,BIN:370330'), notes = COALESCE(notes, 'Cardentify import; original bank: 广发银行; type: Debit; source: 云闪付') WHERE country = 'CN' AND bank_name = '广发银行' AND card_name = '广发银行美国运通Lucky借记卡';

INSERT INTO card_catalog (country, bank_name, card_name, card_tier, network, tags, image_url, variants, annual_fee_cny, notes)
SELECT 'CN', '广发银行', '广发多利金卡', '金卡', 'UnionPay', 'Cardentify,信用卡,来源:云闪付', '/images/cards/cardentify/2d2c3284d460-c4f1fda55c92-79e1286d.jpg', NULL, NULL, 'Cardentify import; original bank: 广发银行; type: Credit; source: 云闪付'
WHERE NOT EXISTS (SELECT 1 FROM card_catalog WHERE country = 'CN' AND bank_name = '广发银行' AND card_name = '广发多利金卡');
UPDATE card_catalog SET image_url = CASE WHEN image_url IS NULL OR image_url LIKE '/images/cards/cardentify/%' THEN '/images/cards/cardentify/2d2c3284d460-c4f1fda55c92-79e1286d.jpg' ELSE image_url END, network = COALESCE(network, 'UnionPay'), tags = COALESCE(tags, 'Cardentify,信用卡,来源:云闪付'), notes = COALESCE(notes, 'Cardentify import; original bank: 广发银行; type: Credit; source: 云闪付') WHERE country = 'CN' AND bank_name = '广发银行' AND card_name = '广发多利金卡';

INSERT INTO card_catalog (country, bank_name, card_name, card_tier, network, tags, image_url, variants, annual_fee_cny, notes)
SELECT 'CN', '广发银行', '广发故宫文创白金卡', '白金卡', 'UnionPay', 'Cardentify,信用卡,来源:云闪付', '/images/cards/cardentify/2d2c3284d460-f5edd7a712b9-4e9e2495.jpg', NULL, NULL, 'Cardentify import; original bank: 广发银行; type: Credit; source: 云闪付'
WHERE NOT EXISTS (SELECT 1 FROM card_catalog WHERE country = 'CN' AND bank_name = '广发银行' AND card_name = '广发故宫文创白金卡');
UPDATE card_catalog SET image_url = CASE WHEN image_url IS NULL OR image_url LIKE '/images/cards/cardentify/%' THEN '/images/cards/cardentify/2d2c3284d460-f5edd7a712b9-4e9e2495.jpg' ELSE image_url END, network = COALESCE(network, 'UnionPay'), tags = COALESCE(tags, 'Cardentify,信用卡,来源:云闪付'), notes = COALESCE(notes, 'Cardentify import; original bank: 广发银行; type: Credit; source: 云闪付') WHERE country = 'CN' AND bank_name = '广发银行' AND card_name = '广发故宫文创白金卡';

INSERT INTO card_catalog (country, bank_name, card_name, card_tier, network, tags, image_url, variants, annual_fee_cny, notes)
SELECT 'CN', '广发银行', '京东联名卡金卡', '金卡', 'UnionPay', 'Cardentify,信用卡,来源:云闪付', '/images/cards/cardentify/2d2c3284d460-15202f8173c4-69040d2e.jpg', NULL, NULL, 'Cardentify import; original bank: 广发银行; type: Credit; source: 云闪付'
WHERE NOT EXISTS (SELECT 1 FROM card_catalog WHERE country = 'CN' AND bank_name = '广发银行' AND card_name = '京东联名卡金卡');
UPDATE card_catalog SET image_url = CASE WHEN image_url IS NULL OR image_url LIKE '/images/cards/cardentify/%' THEN '/images/cards/cardentify/2d2c3284d460-15202f8173c4-69040d2e.jpg' ELSE image_url END, network = COALESCE(network, 'UnionPay'), tags = COALESCE(tags, 'Cardentify,信用卡,来源:云闪付'), notes = COALESCE(notes, 'Cardentify import; original bank: 广发银行; type: Credit; source: 云闪付') WHERE country = 'CN' AND bank_name = '广发银行' AND card_name = '京东联名卡金卡';

INSERT INTO card_catalog (country, bank_name, card_name, card_tier, network, tags, image_url, variants, annual_fee_cny, notes)
SELECT 'CN', '广发银行', '广发银行理财通卡', '普卡', 'UnionPay', 'Cardentify,借记卡,来源:云闪付,BIN:622568', '/images/cards/cardentify/2d2c3284d460-30494c759be0-c7bb112c.jpg', NULL, NULL, 'Cardentify import; original bank: 广发银行; type: Debit; source: 云闪付'
WHERE NOT EXISTS (SELECT 1 FROM card_catalog WHERE country = 'CN' AND bank_name = '广发银行' AND card_name = '广发银行理财通卡');
UPDATE card_catalog SET image_url = CASE WHEN image_url IS NULL OR image_url LIKE '/images/cards/cardentify/%' THEN '/images/cards/cardentify/2d2c3284d460-30494c759be0-c7bb112c.jpg' ELSE image_url END, network = COALESCE(network, 'UnionPay'), tags = COALESCE(tags, 'Cardentify,借记卡,来源:云闪付,BIN:622568'), notes = COALESCE(notes, 'Cardentify import; original bank: 广发银行; type: Debit; source: 云闪付') WHERE country = 'CN' AND bank_name = '广发银行' AND card_name = '广发银行理财通卡';

INSERT INTO card_catalog (country, bank_name, card_name, card_tier, network, tags, image_url, variants, annual_fee_cny, notes)
SELECT 'CN', '广发银行', '广发BEBE联名借记卡', '普卡', 'UnionPay', 'Cardentify,借记卡,来源:云闪付', '/images/cards/cardentify/2d2c3284d460-bebe-66916dfb.jpg', NULL, NULL, 'Cardentify import; original bank: 广发银行; type: Debit; source: 云闪付'
WHERE NOT EXISTS (SELECT 1 FROM card_catalog WHERE country = 'CN' AND bank_name = '广发银行' AND card_name = '广发BEBE联名借记卡');
UPDATE card_catalog SET image_url = CASE WHEN image_url IS NULL OR image_url LIKE '/images/cards/cardentify/%' THEN '/images/cards/cardentify/2d2c3284d460-bebe-66916dfb.jpg' ELSE image_url END, network = COALESCE(network, 'UnionPay'), tags = COALESCE(tags, 'Cardentify,借记卡,来源:云闪付'), notes = COALESCE(notes, 'Cardentify import; original bank: 广发银行; type: Debit; source: 云闪付') WHERE country = 'CN' AND bank_name = '广发银行' AND card_name = '广发BEBE联名借记卡';

INSERT INTO card_catalog (country, bank_name, card_name, card_tier, network, tags, image_url, variants, annual_fee_cny, notes)
SELECT 'CN', '兴业银行', '兴业银行美国运通安愉借记卡', 'Select', 'AMEX', 'Cardentify,借记卡,来源:云闪付,BIN:370508', '/images/cards/cardentify/3382785b3a1f-f47c090accfd-e39309cc.jpg', NULL, NULL, 'Cardentify import; original bank: 兴业银行; type: Debit; source: 云闪付'
WHERE NOT EXISTS (SELECT 1 FROM card_catalog WHERE country = 'CN' AND bank_name = '兴业银行' AND card_name = '兴业银行美国运通安愉借记卡');
UPDATE card_catalog SET image_url = CASE WHEN image_url IS NULL OR image_url LIKE '/images/cards/cardentify/%' THEN '/images/cards/cardentify/3382785b3a1f-f47c090accfd-e39309cc.jpg' ELSE image_url END, network = COALESCE(network, 'AMEX'), tags = COALESCE(tags, 'Cardentify,借记卡,来源:云闪付,BIN:370508'), notes = COALESCE(notes, 'Cardentify import; original bank: 兴业银行; type: Debit; source: 云闪付') WHERE country = 'CN' AND bank_name = '兴业银行' AND card_name = '兴业银行美国运通安愉借记卡';

INSERT INTO card_catalog (country, bank_name, card_name, card_tier, network, tags, image_url, variants, annual_fee_cny, notes)
SELECT 'CN', '兴业银行', '寰宇人生', '普卡', 'UnionPay', 'Cardentify,借记卡,来源:Mi Pay', '/images/cards/cardentify/3382785b3a1f-02180e67b83d-a93ea6b7.jpg', NULL, NULL, 'Cardentify import; original bank: 兴业银行; type: Debit; source: Mi Pay'
WHERE NOT EXISTS (SELECT 1 FROM card_catalog WHERE country = 'CN' AND bank_name = '兴业银行' AND card_name = '寰宇人生');
UPDATE card_catalog SET image_url = CASE WHEN image_url IS NULL OR image_url LIKE '/images/cards/cardentify/%' THEN '/images/cards/cardentify/3382785b3a1f-02180e67b83d-a93ea6b7.jpg' ELSE image_url END, network = COALESCE(network, 'UnionPay'), tags = COALESCE(tags, 'Cardentify,借记卡,来源:Mi Pay'), notes = COALESCE(notes, 'Cardentify import; original bank: 兴业银行; type: Debit; source: Mi Pay') WHERE country = 'CN' AND bank_name = '兴业银行' AND card_name = '寰宇人生';

INSERT INTO card_catalog (country, bank_name, card_name, card_tier, network, tags, image_url, variants, annual_fee_cny, notes)
SELECT 'CN', '兴业银行', '熊猫1', '普卡', 'UnionPay', 'Cardentify,借记卡,来源:Mi Pay', '/images/cards/cardentify/3382785b3a1f-1-fa1e116b.jpg', NULL, NULL, 'Cardentify import; original bank: 兴业银行; type: Debit; source: Mi Pay'
WHERE NOT EXISTS (SELECT 1 FROM card_catalog WHERE country = 'CN' AND bank_name = '兴业银行' AND card_name = '熊猫1');
UPDATE card_catalog SET image_url = CASE WHEN image_url IS NULL OR image_url LIKE '/images/cards/cardentify/%' THEN '/images/cards/cardentify/3382785b3a1f-1-fa1e116b.jpg' ELSE image_url END, network = COALESCE(network, 'UnionPay'), tags = COALESCE(tags, 'Cardentify,借记卡,来源:Mi Pay'), notes = COALESCE(notes, 'Cardentify import; original bank: 兴业银行; type: Debit; source: Mi Pay') WHERE country = 'CN' AND bank_name = '兴业银行' AND card_name = '熊猫1';

INSERT INTO card_catalog (country, bank_name, card_name, card_tier, network, tags, image_url, variants, annual_fee_cny, notes)
SELECT 'CN', '兴业银行', '熊猫2', '普卡', 'UnionPay', 'Cardentify,借记卡,来源:Mi Pay', '/images/cards/cardentify/3382785b3a1f-2-6cc1db7f.jpg', NULL, NULL, 'Cardentify import; original bank: 兴业银行; type: Debit; source: Mi Pay'
WHERE NOT EXISTS (SELECT 1 FROM card_catalog WHERE country = 'CN' AND bank_name = '兴业银行' AND card_name = '熊猫2');
UPDATE card_catalog SET image_url = CASE WHEN image_url IS NULL OR image_url LIKE '/images/cards/cardentify/%' THEN '/images/cards/cardentify/3382785b3a1f-2-6cc1db7f.jpg' ELSE image_url END, network = COALESCE(network, 'UnionPay'), tags = COALESCE(tags, 'Cardentify,借记卡,来源:Mi Pay'), notes = COALESCE(notes, 'Cardentify import; original bank: 兴业银行; type: Debit; source: Mi Pay') WHERE country = 'CN' AND bank_name = '兴业银行' AND card_name = '熊猫2';

INSERT INTO card_catalog (country, bank_name, card_name, card_tier, network, tags, image_url, variants, annual_fee_cny, notes)
SELECT 'CN', '兴业银行', '无界借记卡', '普卡', 'UnionPay', 'Cardentify,借记卡,来源:云闪付', '/images/cards/cardentify/3382785b3a1f-f3c6c47e4c76-42ff128e.jpg', NULL, NULL, 'Cardentify import; original bank: 兴业银行; type: Debit; source: 云闪付'
WHERE NOT EXISTS (SELECT 1 FROM card_catalog WHERE country = 'CN' AND bank_name = '兴业银行' AND card_name = '无界借记卡');
UPDATE card_catalog SET image_url = CASE WHEN image_url IS NULL OR image_url LIKE '/images/cards/cardentify/%' THEN '/images/cards/cardentify/3382785b3a1f-f3c6c47e4c76-42ff128e.jpg' ELSE image_url END, network = COALESCE(network, 'UnionPay'), tags = COALESCE(tags, 'Cardentify,借记卡,来源:云闪付'), notes = COALESCE(notes, 'Cardentify import; original bank: 兴业银行; type: Debit; source: 云闪付') WHERE country = 'CN' AND bank_name = '兴业银行' AND card_name = '无界借记卡';

INSERT INTO card_catalog (country, bank_name, card_name, card_tier, network, tags, image_url, variants, annual_fee_cny, notes)
SELECT 'CN', '招商银行', '腾讯价值认同金葵花卡', '白金卡', 'UnionPay', 'Cardentify,借记卡,来源:云闪付,BIN:612483', '/images/cards/cardentify/bff0099b0b68-29d246ada6e3-50458ae2.jpg', NULL, NULL, 'Cardentify import; original bank: 招商银行; type: Debit; source: 云闪付'
WHERE NOT EXISTS (SELECT 1 FROM card_catalog WHERE country = 'CN' AND bank_name = '招商银行' AND card_name = '腾讯价值认同金葵花卡');
UPDATE card_catalog SET image_url = CASE WHEN image_url IS NULL OR image_url LIKE '/images/cards/cardentify/%' THEN '/images/cards/cardentify/bff0099b0b68-29d246ada6e3-50458ae2.jpg' ELSE image_url END, network = COALESCE(network, 'UnionPay'), tags = COALESCE(tags, 'Cardentify,借记卡,来源:云闪付,BIN:612483'), notes = COALESCE(notes, 'Cardentify import; original bank: 招商银行; type: Debit; source: 云闪付') WHERE country = 'CN' AND bank_name = '招商银行' AND card_name = '腾讯价值认同金葵花卡';

INSERT INTO card_catalog (country, bank_name, card_name, card_tier, network, tags, image_url, variants, annual_fee_cny, notes)
SELECT 'CN', '招商银行', '财富绽放金葵花卡', '白金卡', 'UnionPay', 'Cardentify,借记卡,来源:Apple Pay,BIN:612483', '/images/cards/cardentify/bff0099b0b68-6f2739b9e0f3-e4a2b186.jpg', NULL, NULL, 'Cardentify import; original bank: 招商银行; type: Debit; source: Apple Pay'
WHERE NOT EXISTS (SELECT 1 FROM card_catalog WHERE country = 'CN' AND bank_name = '招商银行' AND card_name = '财富绽放金葵花卡');
UPDATE card_catalog SET image_url = CASE WHEN image_url IS NULL OR image_url LIKE '/images/cards/cardentify/%' THEN '/images/cards/cardentify/bff0099b0b68-6f2739b9e0f3-e4a2b186.jpg' ELSE image_url END, network = COALESCE(network, 'UnionPay'), tags = COALESCE(tags, 'Cardentify,借记卡,来源:Apple Pay,BIN:612483'), notes = COALESCE(notes, 'Cardentify import; original bank: 招商银行; type: Debit; source: Apple Pay') WHERE country = 'CN' AND bank_name = '招商银行' AND card_name = '财富绽放金葵花卡';

INSERT INTO card_catalog (country, bank_name, card_name, card_tier, network, tags, image_url, variants, annual_fee_cny, notes)
SELECT 'CN', '招商银行', '梵高星夜金葵花卡', '白金卡', 'UnionPay', 'Cardentify,借记卡,来源:Apple Pay', '/images/cards/cardentify/bff0099b0b68-22c30c13c057-9fb7929e.jpg', NULL, NULL, 'Cardentify import; original bank: 招商银行; type: Debit; source: Apple Pay'
WHERE NOT EXISTS (SELECT 1 FROM card_catalog WHERE country = 'CN' AND bank_name = '招商银行' AND card_name = '梵高星夜金葵花卡');
UPDATE card_catalog SET image_url = CASE WHEN image_url IS NULL OR image_url LIKE '/images/cards/cardentify/%' THEN '/images/cards/cardentify/bff0099b0b68-22c30c13c057-9fb7929e.jpg' ELSE image_url END, network = COALESCE(network, 'UnionPay'), tags = COALESCE(tags, 'Cardentify,借记卡,来源:Apple Pay'), notes = COALESCE(notes, 'Cardentify import; original bank: 招商银行; type: Debit; source: Apple Pay') WHERE country = 'CN' AND bank_name = '招商银行' AND card_name = '梵高星夜金葵花卡';

INSERT INTO card_catalog (country, bank_name, card_name, card_tier, network, tags, image_url, variants, annual_fee_cny, notes)
SELECT 'CN', '招商银行', '一卡通 (私人银行卡)', '钻石卡', 'UnionPay', 'Cardentify,借记卡,来源:Apple Pay', '/images/cards/cardentify/bff0099b0b68-f7e1161ea231-09e68499.jpg', NULL, NULL, 'Cardentify import; original bank: 招商银行; type: Debit; source: Apple Pay'
WHERE NOT EXISTS (SELECT 1 FROM card_catalog WHERE country = 'CN' AND bank_name = '招商银行' AND card_name = '一卡通 (私人银行卡)');
UPDATE card_catalog SET image_url = CASE WHEN image_url IS NULL OR image_url LIKE '/images/cards/cardentify/%' THEN '/images/cards/cardentify/bff0099b0b68-f7e1161ea231-09e68499.jpg' ELSE image_url END, network = COALESCE(network, 'UnionPay'), tags = COALESCE(tags, 'Cardentify,借记卡,来源:Apple Pay'), notes = COALESCE(notes, 'Cardentify import; original bank: 招商银行; type: Debit; source: Apple Pay') WHERE country = 'CN' AND bank_name = '招商银行' AND card_name = '一卡通 (私人银行卡)';

INSERT INTO card_catalog (country, bank_name, card_name, card_tier, network, tags, image_url, variants, annual_fee_cny, notes)
SELECT 'CN', '招商银行', '一闪通账户', '普卡', 'UnionPay', 'Cardentify,借记卡,来源:云闪付,BIN:621483', '/images/cards/cardentify/bff0099b0b68-e07cbf3436c4-dcaf5453.jpg', NULL, NULL, 'Cardentify import; original bank: 招商银行; type: Debit; source: 云闪付'
WHERE NOT EXISTS (SELECT 1 FROM card_catalog WHERE country = 'CN' AND bank_name = '招商银行' AND card_name = '一闪通账户');
UPDATE card_catalog SET image_url = CASE WHEN image_url IS NULL OR image_url LIKE '/images/cards/cardentify/%' THEN '/images/cards/cardentify/bff0099b0b68-e07cbf3436c4-dcaf5453.jpg' ELSE image_url END, network = COALESCE(network, 'UnionPay'), tags = COALESCE(tags, 'Cardentify,借记卡,来源:云闪付,BIN:621483'), notes = COALESCE(notes, 'Cardentify import; original bank: 招商银行; type: Debit; source: 云闪付') WHERE country = 'CN' AND bank_name = '招商银行' AND card_name = '一闪通账户';

INSERT INTO card_catalog (country, bank_name, card_name, card_tier, network, tags, image_url, variants, annual_fee_cny, notes)
SELECT 'CN', '招商银行', 'HelloKitty联名金葵花卡', '白金卡', 'UnionPay', 'Cardentify,借记卡,来源:Apple Pay,BIN:621483', '/images/cards/cardentify/bff0099b0b68-hellokitty-6af32d5c.jpg', NULL, NULL, 'Cardentify import; original bank: 招商银行; type: Debit; source: Apple Pay'
WHERE NOT EXISTS (SELECT 1 FROM card_catalog WHERE country = 'CN' AND bank_name = '招商银行' AND card_name = 'HelloKitty联名金葵花卡');
UPDATE card_catalog SET image_url = CASE WHEN image_url IS NULL OR image_url LIKE '/images/cards/cardentify/%' THEN '/images/cards/cardentify/bff0099b0b68-hellokitty-6af32d5c.jpg' ELSE image_url END, network = COALESCE(network, 'UnionPay'), tags = COALESCE(tags, 'Cardentify,借记卡,来源:Apple Pay,BIN:621483'), notes = COALESCE(notes, 'Cardentify import; original bank: 招商银行; type: Debit; source: Apple Pay') WHERE country = 'CN' AND bank_name = '招商银行' AND card_name = 'HelloKitty联名金葵花卡';

INSERT INTO card_catalog (country, bank_name, card_name, card_tier, network, tags, image_url, variants, annual_fee_cny, notes)
SELECT 'CN', '招商银行', '哔哩哔哩联名借记卡', '普卡', 'UnionPay', 'Cardentify,借记卡,来源:云闪付,BIN:612483', '/images/cards/cardentify/bff0099b0b68-bd93a298f57f-19b695fa.jpg', NULL, NULL, 'Cardentify import; original bank: 招商银行; type: Debit; source: 云闪付'
WHERE NOT EXISTS (SELECT 1 FROM card_catalog WHERE country = 'CN' AND bank_name = '招商银行' AND card_name = '哔哩哔哩联名借记卡');
UPDATE card_catalog SET image_url = CASE WHEN image_url IS NULL OR image_url LIKE '/images/cards/cardentify/%' THEN '/images/cards/cardentify/bff0099b0b68-bd93a298f57f-19b695fa.jpg' ELSE image_url END, network = COALESCE(network, 'UnionPay'), tags = COALESCE(tags, 'Cardentify,借记卡,来源:云闪付,BIN:612483'), notes = COALESCE(notes, 'Cardentify import; original bank: 招商银行; type: Debit; source: 云闪付') WHERE country = 'CN' AND bank_name = '招商银行' AND card_name = '哔哩哔哩联名借记卡';

INSERT INTO card_catalog (country, bank_name, card_name, card_tier, network, tags, image_url, variants, annual_fee_cny, notes)
SELECT 'CN', '招商银行', '招商银行哔哩哔哩信用卡', '普卡', 'UnionPay', 'Cardentify,信用卡,来源:云闪付,BIN:622575', '/images/cards/cardentify/bff0099b0b68-48b72cf75f58-febc81f1.jpg', NULL, NULL, 'Cardentify import; original bank: 招商银行; type: Credit; source: 云闪付'
WHERE NOT EXISTS (SELECT 1 FROM card_catalog WHERE country = 'CN' AND bank_name = '招商银行' AND card_name = '招商银行哔哩哔哩信用卡');
UPDATE card_catalog SET image_url = CASE WHEN image_url IS NULL OR image_url LIKE '/images/cards/cardentify/%' THEN '/images/cards/cardentify/bff0099b0b68-48b72cf75f58-febc81f1.jpg' ELSE image_url END, network = COALESCE(network, 'UnionPay'), tags = COALESCE(tags, 'Cardentify,信用卡,来源:云闪付,BIN:622575'), notes = COALESCE(notes, 'Cardentify import; original bank: 招商银行; type: Credit; source: 云闪付') WHERE country = 'CN' AND bank_name = '招商银行' AND card_name = '招商银行哔哩哔哩信用卡';

INSERT INTO card_catalog (country, bank_name, card_name, card_tier, network, tags, image_url, variants, annual_fee_cny, notes)
SELECT 'CN', '招商银行', '招商银行招财卡', '普卡', 'UnionPay', 'Cardentify,借记卡,来源:云闪付', '/images/cards/cardentify/bff0099b0b68-d0ab2287219c-1f790db8.jpg', NULL, NULL, 'Cardentify import; original bank: 招商银行; type: Debit; source: 云闪付'
WHERE NOT EXISTS (SELECT 1 FROM card_catalog WHERE country = 'CN' AND bank_name = '招商银行' AND card_name = '招商银行招财卡');
UPDATE card_catalog SET image_url = CASE WHEN image_url IS NULL OR image_url LIKE '/images/cards/cardentify/%' THEN '/images/cards/cardentify/bff0099b0b68-d0ab2287219c-1f790db8.jpg' ELSE image_url END, network = COALESCE(network, 'UnionPay'), tags = COALESCE(tags, 'Cardentify,借记卡,来源:云闪付'), notes = COALESCE(notes, 'Cardentify import; original bank: 招商银行; type: Debit; source: 云闪付') WHERE country = 'CN' AND bank_name = '招商银行' AND card_name = '招商银行招财卡';

INSERT INTO card_catalog (country, bank_name, card_name, card_tier, network, tags, image_url, variants, annual_fee_cny, notes)
SELECT 'CN', '招商银行', '大卫贝肯IC联名卡-运动贝肯', '普卡', 'UnionPay', 'Cardentify,借记卡,来源:云闪付', '/images/cards/cardentify/bff0099b0b68-ic-e025d97f.jpg', NULL, NULL, 'Cardentify import; original bank: 招商银行; type: Debit; source: 云闪付'
WHERE NOT EXISTS (SELECT 1 FROM card_catalog WHERE country = 'CN' AND bank_name = '招商银行' AND card_name = '大卫贝肯IC联名卡-运动贝肯');
UPDATE card_catalog SET image_url = CASE WHEN image_url IS NULL OR image_url LIKE '/images/cards/cardentify/%' THEN '/images/cards/cardentify/bff0099b0b68-ic-e025d97f.jpg' ELSE image_url END, network = COALESCE(network, 'UnionPay'), tags = COALESCE(tags, 'Cardentify,借记卡,来源:云闪付'), notes = COALESCE(notes, 'Cardentify import; original bank: 招商银行; type: Debit; source: 云闪付') WHERE country = 'CN' AND bank_name = '招商银行' AND card_name = '大卫贝肯IC联名卡-运动贝肯';

INSERT INTO card_catalog (country, bank_name, card_name, card_tier, network, tags, image_url, variants, annual_fee_cny, notes)
SELECT 'CN', '招商银行', '大卫贝肯IC联名卡-嘻哈贝肯', '普卡', 'UnionPay', 'Cardentify,借记卡,来源:云闪付', '/images/cards/cardentify/bff0099b0b68-ic-f1fa6145.jpg', NULL, NULL, 'Cardentify import; original bank: 招商银行; type: Debit; source: 云闪付'
WHERE NOT EXISTS (SELECT 1 FROM card_catalog WHERE country = 'CN' AND bank_name = '招商银行' AND card_name = '大卫贝肯IC联名卡-嘻哈贝肯');
UPDATE card_catalog SET image_url = CASE WHEN image_url IS NULL OR image_url LIKE '/images/cards/cardentify/%' THEN '/images/cards/cardentify/bff0099b0b68-ic-f1fa6145.jpg' ELSE image_url END, network = COALESCE(network, 'UnionPay'), tags = COALESCE(tags, 'Cardentify,借记卡,来源:云闪付'), notes = COALESCE(notes, 'Cardentify import; original bank: 招商银行; type: Debit; source: 云闪付') WHERE country = 'CN' AND bank_name = '招商银行' AND card_name = '大卫贝肯IC联名卡-嘻哈贝肯';

INSERT INTO card_catalog (country, bank_name, card_name, card_tier, network, tags, image_url, variants, annual_fee_cny, notes)
SELECT 'CN', '招商银行', '大卫贝肯IC联名卡-文艺贝肯', '普卡', 'UnionPay', 'Cardentify,借记卡,来源:云闪付', '/images/cards/cardentify/bff0099b0b68-ic-ef31208d.jpg', NULL, NULL, 'Cardentify import; original bank: 招商银行; type: Debit; source: 云闪付'
WHERE NOT EXISTS (SELECT 1 FROM card_catalog WHERE country = 'CN' AND bank_name = '招商银行' AND card_name = '大卫贝肯IC联名卡-文艺贝肯');
UPDATE card_catalog SET image_url = CASE WHEN image_url IS NULL OR image_url LIKE '/images/cards/cardentify/%' THEN '/images/cards/cardentify/bff0099b0b68-ic-ef31208d.jpg' ELSE image_url END, network = COALESCE(network, 'UnionPay'), tags = COALESCE(tags, 'Cardentify,借记卡,来源:云闪付'), notes = COALESCE(notes, 'Cardentify import; original bank: 招商银行; type: Debit; source: 云闪付') WHERE country = 'CN' AND bank_name = '招商银行' AND card_name = '大卫贝肯IC联名卡-文艺贝肯';

INSERT INTO card_catalog (country, bank_name, card_name, card_tier, network, tags, image_url, variants, annual_fee_cny, notes)
SELECT 'CN', '招商银行', '大卫贝肯IC联名卡-呆萌贝肯', '普卡', 'UnionPay', 'Cardentify,借记卡,来源:云闪付', '/images/cards/cardentify/bff0099b0b68-ic-2ee500fb.jpg', NULL, NULL, 'Cardentify import; original bank: 招商银行; type: Debit; source: 云闪付'
WHERE NOT EXISTS (SELECT 1 FROM card_catalog WHERE country = 'CN' AND bank_name = '招商银行' AND card_name = '大卫贝肯IC联名卡-呆萌贝肯');
UPDATE card_catalog SET image_url = CASE WHEN image_url IS NULL OR image_url LIKE '/images/cards/cardentify/%' THEN '/images/cards/cardentify/bff0099b0b68-ic-2ee500fb.jpg' ELSE image_url END, network = COALESCE(network, 'UnionPay'), tags = COALESCE(tags, 'Cardentify,借记卡,来源:云闪付'), notes = COALESCE(notes, 'Cardentify import; original bank: 招商银行; type: Debit; source: 云闪付') WHERE country = 'CN' AND bank_name = '招商银行' AND card_name = '大卫贝肯IC联名卡-呆萌贝肯';

INSERT INTO card_catalog (country, bank_name, card_name, card_tier, network, tags, image_url, variants, annual_fee_cny, notes)
SELECT 'CN', '招商银行', '招行一卡通', '普卡', 'UnionPay', 'Cardentify,借记卡,来源:云闪付', '/images/cards/cardentify/bff0099b0b68-fd521230f955-6fb795aa.jpg', NULL, NULL, 'Cardentify import; original bank: 招商银行; type: Debit; source: 云闪付'
WHERE NOT EXISTS (SELECT 1 FROM card_catalog WHERE country = 'CN' AND bank_name = '招商银行' AND card_name = '招行一卡通');
UPDATE card_catalog SET image_url = CASE WHEN image_url IS NULL OR image_url LIKE '/images/cards/cardentify/%' THEN '/images/cards/cardentify/bff0099b0b68-fd521230f955-6fb795aa.jpg' ELSE image_url END, network = COALESCE(network, 'UnionPay'), tags = COALESCE(tags, 'Cardentify,借记卡,来源:云闪付'), notes = COALESCE(notes, 'Cardentify import; original bank: 招商银行; type: Debit; source: 云闪付') WHERE country = 'CN' AND bank_name = '招商银行' AND card_name = '招行一卡通';

INSERT INTO card_catalog (country, bank_name, card_name, card_tier, network, tags, image_url, variants, annual_fee_cny, notes)
SELECT 'CN', '招商银行', '招商银行普卡 (一卡通)', '普卡', 'UnionPay', 'Cardentify,借记卡,来源:云闪付', '/images/cards/cardentify/bff0099b0b68-a9c4e14252d5-4644de27.jpg', NULL, NULL, 'Cardentify import; original bank: 招商银行; type: Debit; source: 云闪付'
WHERE NOT EXISTS (SELECT 1 FROM card_catalog WHERE country = 'CN' AND bank_name = '招商银行' AND card_name = '招商银行普卡 (一卡通)');
UPDATE card_catalog SET image_url = CASE WHEN image_url IS NULL OR image_url LIKE '/images/cards/cardentify/%' THEN '/images/cards/cardentify/bff0099b0b68-a9c4e14252d5-4644de27.jpg' ELSE image_url END, network = COALESCE(network, 'UnionPay'), tags = COALESCE(tags, 'Cardentify,借记卡,来源:云闪付'), notes = COALESCE(notes, 'Cardentify import; original bank: 招商银行; type: Debit; source: 云闪付') WHERE country = 'CN' AND bank_name = '招商银行' AND card_name = '招商银行普卡 (一卡通)';

INSERT INTO card_catalog (country, bank_name, card_name, card_tier, network, tags, image_url, variants, annual_fee_cny, notes)
SELECT 'CN', '招商银行', '航海王联名卡 (草帽一伙团体卡)', '普卡', 'UnionPay', 'Cardentify,借记卡,来源:云闪付', '/images/cards/cardentify/bff0099b0b68-d098d8ed7fc9-e0db9706.jpg', NULL, NULL, 'Cardentify import; original bank: 招商银行; type: Debit; source: 云闪付'
WHERE NOT EXISTS (SELECT 1 FROM card_catalog WHERE country = 'CN' AND bank_name = '招商银行' AND card_name = '航海王联名卡 (草帽一伙团体卡)');
UPDATE card_catalog SET image_url = CASE WHEN image_url IS NULL OR image_url LIKE '/images/cards/cardentify/%' THEN '/images/cards/cardentify/bff0099b0b68-d098d8ed7fc9-e0db9706.jpg' ELSE image_url END, network = COALESCE(network, 'UnionPay'), tags = COALESCE(tags, 'Cardentify,借记卡,来源:云闪付'), notes = COALESCE(notes, 'Cardentify import; original bank: 招商银行; type: Debit; source: 云闪付') WHERE country = 'CN' AND bank_name = '招商银行' AND card_name = '航海王联名卡 (草帽一伙团体卡)';

INSERT INTO card_catalog (country, bank_name, card_name, card_tier, network, tags, image_url, variants, annual_fee_cny, notes)
SELECT 'CN', '招商银行', '航海王联名卡 (乔巴粉色)', '普卡', 'UnionPay', 'Cardentify,借记卡,来源:云闪付', '/images/cards/cardentify/bff0099b0b68-4c8e5e553d6b-9d669bea.jpg', NULL, NULL, 'Cardentify import; original bank: 招商银行; type: Debit; source: 云闪付'
WHERE NOT EXISTS (SELECT 1 FROM card_catalog WHERE country = 'CN' AND bank_name = '招商银行' AND card_name = '航海王联名卡 (乔巴粉色)');
UPDATE card_catalog SET image_url = CASE WHEN image_url IS NULL OR image_url LIKE '/images/cards/cardentify/%' THEN '/images/cards/cardentify/bff0099b0b68-4c8e5e553d6b-9d669bea.jpg' ELSE image_url END, network = COALESCE(network, 'UnionPay'), tags = COALESCE(tags, 'Cardentify,借记卡,来源:云闪付'), notes = COALESCE(notes, 'Cardentify import; original bank: 招商银行; type: Debit; source: 云闪付') WHERE country = 'CN' AND bank_name = '招商银行' AND card_name = '航海王联名卡 (乔巴粉色)';

INSERT INTO card_catalog (country, bank_name, card_name, card_tier, network, tags, image_url, variants, annual_fee_cny, notes)
SELECT 'CN', '招商银行', '航海王联名卡 (20周年)', '普卡', 'UnionPay', 'Cardentify,借记卡,来源:云闪付', '/images/cards/cardentify/bff0099b0b68-20-69667f09.jpg', NULL, NULL, 'Cardentify import; original bank: 招商银行; type: Debit; source: 云闪付'
WHERE NOT EXISTS (SELECT 1 FROM card_catalog WHERE country = 'CN' AND bank_name = '招商银行' AND card_name = '航海王联名卡 (20周年)');
UPDATE card_catalog SET image_url = CASE WHEN image_url IS NULL OR image_url LIKE '/images/cards/cardentify/%' THEN '/images/cards/cardentify/bff0099b0b68-20-69667f09.jpg' ELSE image_url END, network = COALESCE(network, 'UnionPay'), tags = COALESCE(tags, 'Cardentify,借记卡,来源:云闪付'), notes = COALESCE(notes, 'Cardentify import; original bank: 招商银行; type: Debit; source: 云闪付') WHERE country = 'CN' AND bank_name = '招商银行' AND card_name = '航海王联名卡 (20周年)';

INSERT INTO card_catalog (country, bank_name, card_name, card_tier, network, tags, image_url, variants, annual_fee_cny, notes)
SELECT 'CN', '招商银行', '招行拥军优抚一卡通', '普卡', 'UnionPay', 'Cardentify,借记卡,来源:云闪付', '/images/cards/cardentify/bff0099b0b68-e9a39fe7f227-00a1104a.jpg', NULL, NULL, 'Cardentify import; original bank: 招商银行; type: Debit; source: 云闪付'
WHERE NOT EXISTS (SELECT 1 FROM card_catalog WHERE country = 'CN' AND bank_name = '招商银行' AND card_name = '招行拥军优抚一卡通');
UPDATE card_catalog SET image_url = CASE WHEN image_url IS NULL OR image_url LIKE '/images/cards/cardentify/%' THEN '/images/cards/cardentify/bff0099b0b68-e9a39fe7f227-00a1104a.jpg' ELSE image_url END, network = COALESCE(network, 'UnionPay'), tags = COALESCE(tags, 'Cardentify,借记卡,来源:云闪付'), notes = COALESCE(notes, 'Cardentify import; original bank: 招商银行; type: Debit; source: 云闪付') WHERE country = 'CN' AND bank_name = '招商银行' AND card_name = '招行拥军优抚一卡通';

INSERT INTO card_catalog (country, bank_name, card_name, card_tier, network, tags, image_url, variants, annual_fee_cny, notes)
SELECT 'CN', '招商银行', '愤怒的小鸟萌萌哒系列联名卡 (红底白鸟)', '普卡', 'UnionPay', 'Cardentify,借记卡,来源:云闪付', '/images/cards/cardentify/bff0099b0b68-63d3ae2636a9-76681565.jpg', NULL, NULL, 'Cardentify import; original bank: 招商银行; type: Debit; source: 云闪付'
WHERE NOT EXISTS (SELECT 1 FROM card_catalog WHERE country = 'CN' AND bank_name = '招商银行' AND card_name = '愤怒的小鸟萌萌哒系列联名卡 (红底白鸟)');
UPDATE card_catalog SET image_url = CASE WHEN image_url IS NULL OR image_url LIKE '/images/cards/cardentify/%' THEN '/images/cards/cardentify/bff0099b0b68-63d3ae2636a9-76681565.jpg' ELSE image_url END, network = COALESCE(network, 'UnionPay'), tags = COALESCE(tags, 'Cardentify,借记卡,来源:云闪付'), notes = COALESCE(notes, 'Cardentify import; original bank: 招商银行; type: Debit; source: 云闪付') WHERE country = 'CN' AND bank_name = '招商银行' AND card_name = '愤怒的小鸟萌萌哒系列联名卡 (红底白鸟)';

INSERT INTO card_catalog (country, bank_name, card_name, card_tier, network, tags, image_url, variants, annual_fee_cny, notes)
SELECT 'CN', '招商银行', 'HelloKitty联名小金卡 (月光银)', '普卡', 'UnionPay', 'Cardentify,借记卡,来源:云闪付', '/images/cards/cardentify/bff0099b0b68-hellokitty-9cf648d5.jpg', NULL, NULL, 'Cardentify import; original bank: 招商银行; type: Debit; source: 云闪付'
WHERE NOT EXISTS (SELECT 1 FROM card_catalog WHERE country = 'CN' AND bank_name = '招商银行' AND card_name = 'HelloKitty联名小金卡 (月光银)');
UPDATE card_catalog SET image_url = CASE WHEN image_url IS NULL OR image_url LIKE '/images/cards/cardentify/%' THEN '/images/cards/cardentify/bff0099b0b68-hellokitty-9cf648d5.jpg' ELSE image_url END, network = COALESCE(network, 'UnionPay'), tags = COALESCE(tags, 'Cardentify,借记卡,来源:云闪付'), notes = COALESCE(notes, 'Cardentify import; original bank: 招商银行; type: Debit; source: 云闪付') WHERE country = 'CN' AND bank_name = '招商银行' AND card_name = 'HelloKitty联名小金卡 (月光银)';

INSERT INTO card_catalog (country, bank_name, card_name, card_tier, network, tags, image_url, variants, annual_fee_cny, notes)
SELECT 'CN', '招商银行', 'HelloKitty联名借记卡 (樱花好运系列-心愿达成款)', '普卡', 'UnionPay', 'Cardentify,借记卡,来源:云闪付', '/images/cards/cardentify/bff0099b0b68-hellokitty-eb93a34e.jpg', NULL, NULL, 'Cardentify import; original bank: 招商银行; type: Debit; source: 云闪付'
WHERE NOT EXISTS (SELECT 1 FROM card_catalog WHERE country = 'CN' AND bank_name = '招商银行' AND card_name = 'HelloKitty联名借记卡 (樱花好运系列-心愿达成款)');
UPDATE card_catalog SET image_url = CASE WHEN image_url IS NULL OR image_url LIKE '/images/cards/cardentify/%' THEN '/images/cards/cardentify/bff0099b0b68-hellokitty-eb93a34e.jpg' ELSE image_url END, network = COALESCE(network, 'UnionPay'), tags = COALESCE(tags, 'Cardentify,借记卡,来源:云闪付'), notes = COALESCE(notes, 'Cardentify import; original bank: 招商银行; type: Debit; source: 云闪付') WHERE country = 'CN' AND bank_name = '招商银行' AND card_name = 'HelloKitty联名借记卡 (樱花好运系列-心愿达成款)';

INSERT INTO card_catalog (country, bank_name, card_name, card_tier, network, tags, image_url, variants, annual_fee_cny, notes)
SELECT 'CN', '招商银行', 'HelloKitty联名借记卡 (樱花好运系列-招财纳福款)', '普卡', 'UnionPay', 'Cardentify,借记卡,来源:云闪付', '/images/cards/cardentify/bff0099b0b68-hellokitty-1eb36359.jpg', NULL, NULL, 'Cardentify import; original bank: 招商银行; type: Debit; source: 云闪付'
WHERE NOT EXISTS (SELECT 1 FROM card_catalog WHERE country = 'CN' AND bank_name = '招商银行' AND card_name = 'HelloKitty联名借记卡 (樱花好运系列-招财纳福款)');
UPDATE card_catalog SET image_url = CASE WHEN image_url IS NULL OR image_url LIKE '/images/cards/cardentify/%' THEN '/images/cards/cardentify/bff0099b0b68-hellokitty-1eb36359.jpg' ELSE image_url END, network = COALESCE(network, 'UnionPay'), tags = COALESCE(tags, 'Cardentify,借记卡,来源:云闪付'), notes = COALESCE(notes, 'Cardentify import; original bank: 招商银行; type: Debit; source: 云闪付') WHERE country = 'CN' AND bank_name = '招商银行' AND card_name = 'HelloKitty联名借记卡 (樱花好运系列-招财纳福款)';

INSERT INTO card_catalog (country, bank_name, card_name, card_tier, network, tags, image_url, variants, annual_fee_cny, notes)
SELECT 'CN', '招商银行', 'HelloKitty联名小金卡 (耀夜黑)', '普卡', 'UnionPay', 'Cardentify,借记卡,来源:云闪付', '/images/cards/cardentify/bff0099b0b68-hellokitty-66d8df3d.jpg', NULL, NULL, 'Cardentify import; original bank: 招商银行; type: Debit; source: 云闪付'
WHERE NOT EXISTS (SELECT 1 FROM card_catalog WHERE country = 'CN' AND bank_name = '招商银行' AND card_name = 'HelloKitty联名小金卡 (耀夜黑)');
UPDATE card_catalog SET image_url = CASE WHEN image_url IS NULL OR image_url LIKE '/images/cards/cardentify/%' THEN '/images/cards/cardentify/bff0099b0b68-hellokitty-66d8df3d.jpg' ELSE image_url END, network = COALESCE(network, 'UnionPay'), tags = COALESCE(tags, 'Cardentify,借记卡,来源:云闪付'), notes = COALESCE(notes, 'Cardentify import; original bank: 招商银行; type: Debit; source: 云闪付') WHERE country = 'CN' AND bank_name = '招商银行' AND card_name = 'HelloKitty联名小金卡 (耀夜黑)';

INSERT INTO card_catalog (country, bank_name, card_name, card_tier, network, tags, image_url, variants, annual_fee_cny, notes)
SELECT 'CN', '招商银行', '荔枝FM IC联名卡', '普卡', 'UnionPay', 'Cardentify,借记卡,来源:云闪付', '/images/cards/cardentify/bff0099b0b68-fm-ic-3c64d97c.jpg', NULL, NULL, 'Cardentify import; original bank: 招商银行; type: Debit; source: 云闪付'
WHERE NOT EXISTS (SELECT 1 FROM card_catalog WHERE country = 'CN' AND bank_name = '招商银行' AND card_name = '荔枝FM IC联名卡');
UPDATE card_catalog SET image_url = CASE WHEN image_url IS NULL OR image_url LIKE '/images/cards/cardentify/%' THEN '/images/cards/cardentify/bff0099b0b68-fm-ic-3c64d97c.jpg' ELSE image_url END, network = COALESCE(network, 'UnionPay'), tags = COALESCE(tags, 'Cardentify,借记卡,来源:云闪付'), notes = COALESCE(notes, 'Cardentify import; original bank: 招商银行; type: Debit; source: 云闪付') WHERE country = 'CN' AND bank_name = '招商银行' AND card_name = '荔枝FM IC联名卡';

INSERT INTO card_catalog (country, bank_name, card_name, card_tier, network, tags, image_url, variants, annual_fee_cny, notes)
SELECT 'CN', '招商银行', '王者荣耀联名卡LOGO版', '普卡', 'UnionPay', 'Cardentify,借记卡,来源:云闪付', '/images/cards/cardentify/bff0099b0b68-logo-d70f3315.jpg', NULL, NULL, 'Cardentify import; original bank: 招商银行; type: Debit; source: 云闪付'
WHERE NOT EXISTS (SELECT 1 FROM card_catalog WHERE country = 'CN' AND bank_name = '招商银行' AND card_name = '王者荣耀联名卡LOGO版');
UPDATE card_catalog SET image_url = CASE WHEN image_url IS NULL OR image_url LIKE '/images/cards/cardentify/%' THEN '/images/cards/cardentify/bff0099b0b68-logo-d70f3315.jpg' ELSE image_url END, network = COALESCE(network, 'UnionPay'), tags = COALESCE(tags, 'Cardentify,借记卡,来源:云闪付'), notes = COALESCE(notes, 'Cardentify import; original bank: 招商银行; type: Debit; source: 云闪付') WHERE country = 'CN' AND bank_name = '招商银行' AND card_name = '王者荣耀联名卡LOGO版';

INSERT INTO card_catalog (country, bank_name, card_name, card_tier, network, tags, image_url, variants, annual_fee_cny, notes)
SELECT 'CN', '招商银行', '必胜客联名借记卡 (黑银版)', '普卡', 'UnionPay', 'Cardentify,借记卡,来源:云闪付', '/images/cards/cardentify/bff0099b0b68-62fc397234a6-ead1dcef.jpg', NULL, NULL, 'Cardentify import; original bank: 招商银行; type: Debit; source: 云闪付'
WHERE NOT EXISTS (SELECT 1 FROM card_catalog WHERE country = 'CN' AND bank_name = '招商银行' AND card_name = '必胜客联名借记卡 (黑银版)');
UPDATE card_catalog SET image_url = CASE WHEN image_url IS NULL OR image_url LIKE '/images/cards/cardentify/%' THEN '/images/cards/cardentify/bff0099b0b68-62fc397234a6-ead1dcef.jpg' ELSE image_url END, network = COALESCE(network, 'UnionPay'), tags = COALESCE(tags, 'Cardentify,借记卡,来源:云闪付'), notes = COALESCE(notes, 'Cardentify import; original bank: 招商银行; type: Debit; source: 云闪付') WHERE country = 'CN' AND bank_name = '招商银行' AND card_name = '必胜客联名借记卡 (黑银版)';

INSERT INTO card_catalog (country, bank_name, card_name, card_tier, network, tags, image_url, variants, annual_fee_cny, notes)
SELECT 'CN', '招商银行', '必胜客联名借记卡 (星球版)', '普卡', 'UnionPay', 'Cardentify,借记卡,来源:云闪付', '/images/cards/cardentify/bff0099b0b68-3bbbdc909b6e-0c870649.jpg', NULL, NULL, 'Cardentify import; original bank: 招商银行; type: Debit; source: 云闪付'
WHERE NOT EXISTS (SELECT 1 FROM card_catalog WHERE country = 'CN' AND bank_name = '招商银行' AND card_name = '必胜客联名借记卡 (星球版)');
UPDATE card_catalog SET image_url = CASE WHEN image_url IS NULL OR image_url LIKE '/images/cards/cardentify/%' THEN '/images/cards/cardentify/bff0099b0b68-3bbbdc909b6e-0c870649.jpg' ELSE image_url END, network = COALESCE(network, 'UnionPay'), tags = COALESCE(tags, 'Cardentify,借记卡,来源:云闪付'), notes = COALESCE(notes, 'Cardentify import; original bank: 招商银行; type: Debit; source: 云闪付') WHERE country = 'CN' AND bank_name = '招商银行' AND card_name = '必胜客联名借记卡 (星球版)';

INSERT INTO card_catalog (country, bank_name, card_name, card_tier, network, tags, image_url, variants, annual_fee_cny, notes)
SELECT 'CN', '招商银行', '超级飞侠IC联名卡-乐迪', '普卡', 'UnionPay', 'Cardentify,借记卡,来源:云闪付', '/images/cards/cardentify/bff0099b0b68-ic-7e252839.jpg', NULL, NULL, 'Cardentify import; original bank: 招商银行; type: Debit; source: 云闪付'
WHERE NOT EXISTS (SELECT 1 FROM card_catalog WHERE country = 'CN' AND bank_name = '招商银行' AND card_name = '超级飞侠IC联名卡-乐迪');
UPDATE card_catalog SET image_url = CASE WHEN image_url IS NULL OR image_url LIKE '/images/cards/cardentify/%' THEN '/images/cards/cardentify/bff0099b0b68-ic-7e252839.jpg' ELSE image_url END, network = COALESCE(network, 'UnionPay'), tags = COALESCE(tags, 'Cardentify,借记卡,来源:云闪付'), notes = COALESCE(notes, 'Cardentify import; original bank: 招商银行; type: Debit; source: 云闪付') WHERE country = 'CN' AND bank_name = '招商银行' AND card_name = '超级飞侠IC联名卡-乐迪';

INSERT INTO card_catalog (country, bank_name, card_name, card_tier, network, tags, image_url, variants, annual_fee_cny, notes)
SELECT 'CN', '招商银行', '超级飞侠IC联名卡-小爱', '普卡', 'UnionPay', 'Cardentify,借记卡,来源:云闪付', '/images/cards/cardentify/bff0099b0b68-ic-20b8eda8.jpg', NULL, NULL, 'Cardentify import; original bank: 招商银行; type: Debit; source: 云闪付'
WHERE NOT EXISTS (SELECT 1 FROM card_catalog WHERE country = 'CN' AND bank_name = '招商银行' AND card_name = '超级飞侠IC联名卡-小爱');
UPDATE card_catalog SET image_url = CASE WHEN image_url IS NULL OR image_url LIKE '/images/cards/cardentify/%' THEN '/images/cards/cardentify/bff0099b0b68-ic-20b8eda8.jpg' ELSE image_url END, network = COALESCE(network, 'UnionPay'), tags = COALESCE(tags, 'Cardentify,借记卡,来源:云闪付'), notes = COALESCE(notes, 'Cardentify import; original bank: 招商银行; type: Debit; source: 云闪付') WHERE country = 'CN' AND bank_name = '招商银行' AND card_name = '超级飞侠IC联名卡-小爱';

INSERT INTO card_catalog (country, bank_name, card_name, card_tier, network, tags, image_url, variants, annual_fee_cny, notes)
SELECT 'CN', '招商银行', '招商银行房贷主题卡普卡 (窗户蓝色版)', '普卡', 'UnionPay', 'Cardentify,借记卡,来源:云闪付', '/images/cards/cardentify/bff0099b0b68-802999fafa8c-8581edfa.jpg', NULL, NULL, 'Cardentify import; original bank: 招商银行; type: Debit; source: 云闪付'
WHERE NOT EXISTS (SELECT 1 FROM card_catalog WHERE country = 'CN' AND bank_name = '招商银行' AND card_name = '招商银行房贷主题卡普卡 (窗户蓝色版)');
UPDATE card_catalog SET image_url = CASE WHEN image_url IS NULL OR image_url LIKE '/images/cards/cardentify/%' THEN '/images/cards/cardentify/bff0099b0b68-802999fafa8c-8581edfa.jpg' ELSE image_url END, network = COALESCE(network, 'UnionPay'), tags = COALESCE(tags, 'Cardentify,借记卡,来源:云闪付'), notes = COALESCE(notes, 'Cardentify import; original bank: 招商银行; type: Debit; source: 云闪付') WHERE country = 'CN' AND bank_name = '招商银行' AND card_name = '招商银行房贷主题卡普卡 (窗户蓝色版)';

INSERT INTO card_catalog (country, bank_name, card_name, card_tier, network, tags, image_url, variants, annual_fee_cny, notes)
SELECT 'CN', '招商银行', '北京航空航天大学联名卡', '普卡', 'UnionPay', 'Cardentify,借记卡,来源:云闪付', '/images/cards/cardentify/bff0099b0b68-b047dbfa37df-e6c6ae9f.jpg', NULL, NULL, 'Cardentify import; original bank: 招商银行; type: Debit; source: 云闪付'
WHERE NOT EXISTS (SELECT 1 FROM card_catalog WHERE country = 'CN' AND bank_name = '招商银行' AND card_name = '北京航空航天大学联名卡');
UPDATE card_catalog SET image_url = CASE WHEN image_url IS NULL OR image_url LIKE '/images/cards/cardentify/%' THEN '/images/cards/cardentify/bff0099b0b68-b047dbfa37df-e6c6ae9f.jpg' ELSE image_url END, network = COALESCE(network, 'UnionPay'), tags = COALESCE(tags, 'Cardentify,借记卡,来源:云闪付'), notes = COALESCE(notes, 'Cardentify import; original bank: 招商银行; type: Debit; source: 云闪付') WHERE country = 'CN' AND bank_name = '招商银行' AND card_name = '北京航空航天大学联名卡';

INSERT INTO card_catalog (country, bank_name, card_name, card_tier, network, tags, image_url, variants, annual_fee_cny, notes)
SELECT 'CN', '招商银行', '江南百景图联名普卡 (严大人)', '普卡', 'UnionPay', 'Cardentify,借记卡,来源:云闪付', '/images/cards/cardentify/bff0099b0b68-765f9a3c6d77-d370ab6e.jpg', NULL, NULL, 'Cardentify import; original bank: 招商银行; type: Debit; source: 云闪付'
WHERE NOT EXISTS (SELECT 1 FROM card_catalog WHERE country = 'CN' AND bank_name = '招商银行' AND card_name = '江南百景图联名普卡 (严大人)');
UPDATE card_catalog SET image_url = CASE WHEN image_url IS NULL OR image_url LIKE '/images/cards/cardentify/%' THEN '/images/cards/cardentify/bff0099b0b68-765f9a3c6d77-d370ab6e.jpg' ELSE image_url END, network = COALESCE(network, 'UnionPay'), tags = COALESCE(tags, 'Cardentify,借记卡,来源:云闪付'), notes = COALESCE(notes, 'Cardentify import; original bank: 招商银行; type: Debit; source: 云闪付') WHERE country = 'CN' AND bank_name = '招商银行' AND card_name = '江南百景图联名普卡 (严大人)';

INSERT INTO card_catalog (country, bank_name, card_name, card_tier, network, tags, image_url, variants, annual_fee_cny, notes)
SELECT 'CN', '招商银行', '奇虎360联名借记卡', '普卡', 'UnionPay', 'Cardentify,借记卡,来源:云闪付', '/images/cards/cardentify/bff0099b0b68-360-8ec2abd1.jpg', NULL, NULL, 'Cardentify import; original bank: 招商银行; type: Debit; source: 云闪付'
WHERE NOT EXISTS (SELECT 1 FROM card_catalog WHERE country = 'CN' AND bank_name = '招商银行' AND card_name = '奇虎360联名借记卡');
UPDATE card_catalog SET image_url = CASE WHEN image_url IS NULL OR image_url LIKE '/images/cards/cardentify/%' THEN '/images/cards/cardentify/bff0099b0b68-360-8ec2abd1.jpg' ELSE image_url END, network = COALESCE(network, 'UnionPay'), tags = COALESCE(tags, 'Cardentify,借记卡,来源:云闪付'), notes = COALESCE(notes, 'Cardentify import; original bank: 招商银行; type: Debit; source: 云闪付') WHERE country = 'CN' AND bank_name = '招商银行' AND card_name = '奇虎360联名借记卡';

INSERT INTO card_catalog (country, bank_name, card_name, card_tier, network, tags, image_url, variants, annual_fee_cny, notes)
SELECT 'CN', '招商银行', '滴滴联名借记卡', '普卡', 'UnionPay', 'Cardentify,借记卡,来源:云闪付', '/images/cards/cardentify/bff0099b0b68-22ab2ba34148-b83227d1.jpg', NULL, NULL, 'Cardentify import; original bank: 招商银行; type: Debit; source: 云闪付'
WHERE NOT EXISTS (SELECT 1 FROM card_catalog WHERE country = 'CN' AND bank_name = '招商银行' AND card_name = '滴滴联名借记卡');
UPDATE card_catalog SET image_url = CASE WHEN image_url IS NULL OR image_url LIKE '/images/cards/cardentify/%' THEN '/images/cards/cardentify/bff0099b0b68-22ab2ba34148-b83227d1.jpg' ELSE image_url END, network = COALESCE(network, 'UnionPay'), tags = COALESCE(tags, 'Cardentify,借记卡,来源:云闪付'), notes = COALESCE(notes, 'Cardentify import; original bank: 招商银行; type: Debit; source: 云闪付') WHERE country = 'CN' AND bank_name = '招商银行' AND card_name = '滴滴联名借记卡';

INSERT INTO card_catalog (country, bank_name, card_name, card_tier, network, tags, image_url, variants, annual_fee_cny, notes)
SELECT 'CN', '招商银行', '招行香港一卡通', '普卡', 'UnionPay', 'Cardentify,借记卡,来源:云闪付', '/images/cards/cardentify/bff0099b0b68-c72242f13a3f-51254bbf.jpg', NULL, NULL, 'Cardentify import; original bank: 招商银行; type: Debit; source: 云闪付'
WHERE NOT EXISTS (SELECT 1 FROM card_catalog WHERE country = 'CN' AND bank_name = '招商银行' AND card_name = '招行香港一卡通');
UPDATE card_catalog SET image_url = CASE WHEN image_url IS NULL OR image_url LIKE '/images/cards/cardentify/%' THEN '/images/cards/cardentify/bff0099b0b68-c72242f13a3f-51254bbf.jpg' ELSE image_url END, network = COALESCE(network, 'UnionPay'), tags = COALESCE(tags, 'Cardentify,借记卡,来源:云闪付'), notes = COALESCE(notes, 'Cardentify import; original bank: 招商银行; type: Debit; source: 云闪付') WHERE country = 'CN' AND bank_name = '招商银行' AND card_name = '招行香港一卡通';

INSERT INTO card_catalog (country, bank_name, card_name, card_tier, network, tags, image_url, variants, annual_fee_cny, notes)
SELECT 'CN', '招商银行', '腾讯视频联名借记卡', '普卡', 'UnionPay', 'Cardentify,借记卡,来源:云闪付', '/images/cards/cardentify/bff0099b0b68-98ca6c25a4b9-f722f288.jpg', NULL, NULL, 'Cardentify import; original bank: 招商银行; type: Debit; source: 云闪付'
WHERE NOT EXISTS (SELECT 1 FROM card_catalog WHERE country = 'CN' AND bank_name = '招商银行' AND card_name = '腾讯视频联名借记卡');
UPDATE card_catalog SET image_url = CASE WHEN image_url IS NULL OR image_url LIKE '/images/cards/cardentify/%' THEN '/images/cards/cardentify/bff0099b0b68-98ca6c25a4b9-f722f288.jpg' ELSE image_url END, network = COALESCE(network, 'UnionPay'), tags = COALESCE(tags, 'Cardentify,借记卡,来源:云闪付'), notes = COALESCE(notes, 'Cardentify import; original bank: 招商银行; type: Debit; source: 云闪付') WHERE country = 'CN' AND bank_name = '招商银行' AND card_name = '腾讯视频联名借记卡';

INSERT INTO card_catalog (country, bank_name, card_name, card_tier, network, tags, image_url, variants, annual_fee_cny, notes)
SELECT 'CN', '招商银行', '工作细胞联名借记卡 (红细胞卡)', '普卡', 'UnionPay', 'Cardentify,借记卡,来源:云闪付', '/images/cards/cardentify/bff0099b0b68-e84382927080-442953ab.jpg', NULL, NULL, 'Cardentify import; original bank: 招商银行; type: Debit; source: 云闪付'
WHERE NOT EXISTS (SELECT 1 FROM card_catalog WHERE country = 'CN' AND bank_name = '招商银行' AND card_name = '工作细胞联名借记卡 (红细胞卡)');
UPDATE card_catalog SET image_url = CASE WHEN image_url IS NULL OR image_url LIKE '/images/cards/cardentify/%' THEN '/images/cards/cardentify/bff0099b0b68-e84382927080-442953ab.jpg' ELSE image_url END, network = COALESCE(network, 'UnionPay'), tags = COALESCE(tags, 'Cardentify,借记卡,来源:云闪付'), notes = COALESCE(notes, 'Cardentify import; original bank: 招商银行; type: Debit; source: 云闪付') WHERE country = 'CN' AND bank_name = '招商银行' AND card_name = '工作细胞联名借记卡 (红细胞卡)';

INSERT INTO card_catalog (country, bank_name, card_name, card_tier, network, tags, image_url, variants, annual_fee_cny, notes)
SELECT 'CN', '招商银行', '工作细胞联名借记卡 (手绘Q版卡)', '普卡', 'UnionPay', 'Cardentify,借记卡,来源:云闪付', '/images/cards/cardentify/bff0099b0b68-q-1ad75bb8.jpg', NULL, NULL, 'Cardentify import; original bank: 招商银行; type: Debit; source: 云闪付'
WHERE NOT EXISTS (SELECT 1 FROM card_catalog WHERE country = 'CN' AND bank_name = '招商银行' AND card_name = '工作细胞联名借记卡 (手绘Q版卡)');
UPDATE card_catalog SET image_url = CASE WHEN image_url IS NULL OR image_url LIKE '/images/cards/cardentify/%' THEN '/images/cards/cardentify/bff0099b0b68-q-1ad75bb8.jpg' ELSE image_url END, network = COALESCE(network, 'UnionPay'), tags = COALESCE(tags, 'Cardentify,借记卡,来源:云闪付'), notes = COALESCE(notes, 'Cardentify import; original bank: 招商银行; type: Debit; source: 云闪付') WHERE country = 'CN' AND bank_name = '招商银行' AND card_name = '工作细胞联名借记卡 (手绘Q版卡)';

INSERT INTO card_catalog (country, bank_name, card_name, card_tier, network, tags, image_url, variants, annual_fee_cny, notes)
SELECT 'CN', '招商银行', '明日方舟联名储蓄卡 (白色报童阿米娅)', '普卡', 'UnionPay', 'Cardentify,借记卡,来源:云闪付', '/images/cards/cardentify/bff0099b0b68-f9d81ea7eb83-0f86f829.jpg', NULL, NULL, 'Cardentify import; original bank: 招商银行; type: Debit; source: 云闪付'
WHERE NOT EXISTS (SELECT 1 FROM card_catalog WHERE country = 'CN' AND bank_name = '招商银行' AND card_name = '明日方舟联名储蓄卡 (白色报童阿米娅)');
UPDATE card_catalog SET image_url = CASE WHEN image_url IS NULL OR image_url LIKE '/images/cards/cardentify/%' THEN '/images/cards/cardentify/bff0099b0b68-f9d81ea7eb83-0f86f829.jpg' ELSE image_url END, network = COALESCE(network, 'UnionPay'), tags = COALESCE(tags, 'Cardentify,借记卡,来源:云闪付'), notes = COALESCE(notes, 'Cardentify import; original bank: 招商银行; type: Debit; source: 云闪付') WHERE country = 'CN' AND bank_name = '招商银行' AND card_name = '明日方舟联名储蓄卡 (白色报童阿米娅)';

INSERT INTO card_catalog (country, bank_name, card_name, card_tier, network, tags, image_url, variants, annual_fee_cny, notes)
SELECT 'CN', '招商银行', '明日方舟联名储蓄卡 (黑色罗德岛)', '普卡', 'UnionPay', 'Cardentify,借记卡,来源:云闪付', '/images/cards/cardentify/bff0099b0b68-40653d92a751-7a3b055d.jpg', NULL, NULL, 'Cardentify import; original bank: 招商银行; type: Debit; source: 云闪付'
WHERE NOT EXISTS (SELECT 1 FROM card_catalog WHERE country = 'CN' AND bank_name = '招商银行' AND card_name = '明日方舟联名储蓄卡 (黑色罗德岛)');
UPDATE card_catalog SET image_url = CASE WHEN image_url IS NULL OR image_url LIKE '/images/cards/cardentify/%' THEN '/images/cards/cardentify/bff0099b0b68-40653d92a751-7a3b055d.jpg' ELSE image_url END, network = COALESCE(network, 'UnionPay'), tags = COALESCE(tags, 'Cardentify,借记卡,来源:云闪付'), notes = COALESCE(notes, 'Cardentify import; original bank: 招商银行; type: Debit; source: 云闪付') WHERE country = 'CN' AND bank_name = '招商银行' AND card_name = '明日方舟联名储蓄卡 (黑色罗德岛)';

INSERT INTO card_catalog (country, bank_name, card_name, card_tier, network, tags, image_url, variants, annual_fee_cny, notes)
SELECT 'CN', '招商银行', '宝可梦联名借记卡 (皮卡丘)', '普卡', 'UnionPay', 'Cardentify,借记卡,来源:云闪付', '/images/cards/cardentify/bff0099b0b68-8b2c92c4e202-f1ee695a.jpg', NULL, NULL, 'Cardentify import; original bank: 招商银行; type: Debit; source: 云闪付'
WHERE NOT EXISTS (SELECT 1 FROM card_catalog WHERE country = 'CN' AND bank_name = '招商银行' AND card_name = '宝可梦联名借记卡 (皮卡丘)');
UPDATE card_catalog SET image_url = CASE WHEN image_url IS NULL OR image_url LIKE '/images/cards/cardentify/%' THEN '/images/cards/cardentify/bff0099b0b68-8b2c92c4e202-f1ee695a.jpg' ELSE image_url END, network = COALESCE(network, 'UnionPay'), tags = COALESCE(tags, 'Cardentify,借记卡,来源:云闪付'), notes = COALESCE(notes, 'Cardentify import; original bank: 招商银行; type: Debit; source: 云闪付') WHERE country = 'CN' AND bank_name = '招商银行' AND card_name = '宝可梦联名借记卡 (皮卡丘)';

INSERT INTO card_catalog (country, bank_name, card_name, card_tier, network, tags, image_url, variants, annual_fee_cny, notes)
SELECT 'CN', '招商银行', '宝可梦联名借记卡(妙蛙种子)', '普卡', 'UnionPay', 'Cardentify,借记卡,来源:云闪付', '/images/cards/cardentify/bff0099b0b68-da3e2f1a9663-14b058b1.jpg', NULL, NULL, 'Cardentify import; original bank: 招商银行; type: Debit; source: 云闪付'
WHERE NOT EXISTS (SELECT 1 FROM card_catalog WHERE country = 'CN' AND bank_name = '招商银行' AND card_name = '宝可梦联名借记卡(妙蛙种子)');
UPDATE card_catalog SET image_url = CASE WHEN image_url IS NULL OR image_url LIKE '/images/cards/cardentify/%' THEN '/images/cards/cardentify/bff0099b0b68-da3e2f1a9663-14b058b1.jpg' ELSE image_url END, network = COALESCE(network, 'UnionPay'), tags = COALESCE(tags, 'Cardentify,借记卡,来源:云闪付'), notes = COALESCE(notes, 'Cardentify import; original bank: 招商银行; type: Debit; source: 云闪付') WHERE country = 'CN' AND bank_name = '招商银行' AND card_name = '宝可梦联名借记卡(妙蛙种子)';

INSERT INTO card_catalog (country, bank_name, card_name, card_tier, network, tags, image_url, variants, annual_fee_cny, notes)
SELECT 'CN', '招商银行', '宝可梦联名借记卡(杰尼龟)', '普卡', 'UnionPay', 'Cardentify,借记卡,来源:云闪付', '/images/cards/cardentify/bff0099b0b68-a79e323f5028-a962cbd2.jpg', NULL, NULL, 'Cardentify import; original bank: 招商银行; type: Debit; source: 云闪付'
WHERE NOT EXISTS (SELECT 1 FROM card_catalog WHERE country = 'CN' AND bank_name = '招商银行' AND card_name = '宝可梦联名借记卡(杰尼龟)');
UPDATE card_catalog SET image_url = CASE WHEN image_url IS NULL OR image_url LIKE '/images/cards/cardentify/%' THEN '/images/cards/cardentify/bff0099b0b68-a79e323f5028-a962cbd2.jpg' ELSE image_url END, network = COALESCE(network, 'UnionPay'), tags = COALESCE(tags, 'Cardentify,借记卡,来源:云闪付'), notes = COALESCE(notes, 'Cardentify import; original bank: 招商银行; type: Debit; source: 云闪付') WHERE country = 'CN' AND bank_name = '招商银行' AND card_name = '宝可梦联名借记卡(杰尼龟)';

INSERT INTO card_catalog (country, bank_name, card_name, card_tier, network, tags, image_url, variants, annual_fee_cny, notes)
SELECT 'CN', '招商银行', '宝可梦联名借记卡(喷火龙)', '普卡', 'UnionPay', 'Cardentify,借记卡,来源:云闪付', '/images/cards/cardentify/bff0099b0b68-1acf7deea76b-45132d3e.jpg', NULL, NULL, 'Cardentify import; original bank: 招商银行; type: Debit; source: 云闪付'
WHERE NOT EXISTS (SELECT 1 FROM card_catalog WHERE country = 'CN' AND bank_name = '招商银行' AND card_name = '宝可梦联名借记卡(喷火龙)');
UPDATE card_catalog SET image_url = CASE WHEN image_url IS NULL OR image_url LIKE '/images/cards/cardentify/%' THEN '/images/cards/cardentify/bff0099b0b68-1acf7deea76b-45132d3e.jpg' ELSE image_url END, network = COALESCE(network, 'UnionPay'), tags = COALESCE(tags, 'Cardentify,借记卡,来源:云闪付'), notes = COALESCE(notes, 'Cardentify import; original bank: 招商银行; type: Debit; source: 云闪付') WHERE country = 'CN' AND bank_name = '招商银行' AND card_name = '宝可梦联名借记卡(喷火龙)';

INSERT INTO card_catalog (country, bank_name, card_name, card_tier, network, tags, image_url, variants, annual_fee_cny, notes)
SELECT 'CN', '招商银行', '宝可梦联名借记卡(可达鸭)', '普卡', 'UnionPay', 'Cardentify,借记卡,来源:云闪付', '/images/cards/cardentify/bff0099b0b68-0b15a586b361-f7a58414.jpg', NULL, NULL, 'Cardentify import; original bank: 招商银行; type: Debit; source: 云闪付'
WHERE NOT EXISTS (SELECT 1 FROM card_catalog WHERE country = 'CN' AND bank_name = '招商银行' AND card_name = '宝可梦联名借记卡(可达鸭)');
UPDATE card_catalog SET image_url = CASE WHEN image_url IS NULL OR image_url LIKE '/images/cards/cardentify/%' THEN '/images/cards/cardentify/bff0099b0b68-0b15a586b361-f7a58414.jpg' ELSE image_url END, network = COALESCE(network, 'UnionPay'), tags = COALESCE(tags, 'Cardentify,借记卡,来源:云闪付'), notes = COALESCE(notes, 'Cardentify import; original bank: 招商银行; type: Debit; source: 云闪付') WHERE country = 'CN' AND bank_name = '招商银行' AND card_name = '宝可梦联名借记卡(可达鸭)';

INSERT INTO card_catalog (country, bank_name, card_name, card_tier, network, tags, image_url, variants, annual_fee_cny, notes)
SELECT 'CN', '招商银行', '宝可梦联名借记卡(鲤鱼王)', '普卡', 'UnionPay', 'Cardentify,借记卡,来源:云闪付', '/images/cards/cardentify/bff0099b0b68-006ff9228aa1-d5598806.jpg', NULL, NULL, 'Cardentify import; original bank: 招商银行; type: Debit; source: 云闪付'
WHERE NOT EXISTS (SELECT 1 FROM card_catalog WHERE country = 'CN' AND bank_name = '招商银行' AND card_name = '宝可梦联名借记卡(鲤鱼王)');
UPDATE card_catalog SET image_url = CASE WHEN image_url IS NULL OR image_url LIKE '/images/cards/cardentify/%' THEN '/images/cards/cardentify/bff0099b0b68-006ff9228aa1-d5598806.jpg' ELSE image_url END, network = COALESCE(network, 'UnionPay'), tags = COALESCE(tags, 'Cardentify,借记卡,来源:云闪付'), notes = COALESCE(notes, 'Cardentify import; original bank: 招商银行; type: Debit; source: 云闪付') WHERE country = 'CN' AND bank_name = '招商银行' AND card_name = '宝可梦联名借记卡(鲤鱼王)';

INSERT INTO card_catalog (country, bank_name, card_name, card_tier, network, tags, image_url, variants, annual_fee_cny, notes)
SELECT 'CN', '招商银行', 'QQ钱包联名卡', '普卡', 'UnionPay', 'Cardentify,信用卡,来源:云闪付', '/images/cards/cardentify/bff0099b0b68-qq-9a786f7d.jpg', NULL, NULL, 'Cardentify import; original bank: 招商银行; type: Credit; source: 云闪付'
WHERE NOT EXISTS (SELECT 1 FROM card_catalog WHERE country = 'CN' AND bank_name = '招商银行' AND card_name = 'QQ钱包联名卡');
UPDATE card_catalog SET image_url = CASE WHEN image_url IS NULL OR image_url LIKE '/images/cards/cardentify/%' THEN '/images/cards/cardentify/bff0099b0b68-qq-9a786f7d.jpg' ELSE image_url END, network = COALESCE(network, 'UnionPay'), tags = COALESCE(tags, 'Cardentify,信用卡,来源:云闪付'), notes = COALESCE(notes, 'Cardentify import; original bank: 招商银行; type: Credit; source: 云闪付') WHERE country = 'CN' AND bank_name = '招商银行' AND card_name = 'QQ钱包联名卡';

INSERT INTO card_catalog (country, bank_name, card_name, card_tier, network, tags, image_url, variants, annual_fee_cny, notes)
SELECT 'CN', '招商银行', '招商银行京东联名信用卡', '普卡', 'UnionPay', 'Cardentify,信用卡,来源:云闪付', '/images/cards/cardentify/bff0099b0b68-957240900c66-d6e1f9b5.jpg', NULL, NULL, 'Cardentify import; original bank: 招商银行; type: Credit; source: 云闪付'
WHERE NOT EXISTS (SELECT 1 FROM card_catalog WHERE country = 'CN' AND bank_name = '招商银行' AND card_name = '招商银行京东联名信用卡');
UPDATE card_catalog SET image_url = CASE WHEN image_url IS NULL OR image_url LIKE '/images/cards/cardentify/%' THEN '/images/cards/cardentify/bff0099b0b68-957240900c66-d6e1f9b5.jpg' ELSE image_url END, network = COALESCE(network, 'UnionPay'), tags = COALESCE(tags, 'Cardentify,信用卡,来源:云闪付'), notes = COALESCE(notes, 'Cardentify import; original bank: 招商银行; type: Credit; source: 云闪付') WHERE country = 'CN' AND bank_name = '招商银行' AND card_name = '招商银行京东联名信用卡';

INSERT INTO card_catalog (country, bank_name, card_name, card_tier, network, tags, image_url, variants, annual_fee_cny, notes)
SELECT 'CN', '招商银行', '原神联名卡LOGO款', '普卡', 'UnionPay', 'Cardentify,信用卡,来源:云闪付', '/images/cards/cardentify/bff0099b0b68-logo-0a193ec1.jpg', NULL, NULL, 'Cardentify import; original bank: 招商银行; type: Credit; source: 云闪付'
WHERE NOT EXISTS (SELECT 1 FROM card_catalog WHERE country = 'CN' AND bank_name = '招商银行' AND card_name = '原神联名卡LOGO款');
UPDATE card_catalog SET image_url = CASE WHEN image_url IS NULL OR image_url LIKE '/images/cards/cardentify/%' THEN '/images/cards/cardentify/bff0099b0b68-logo-0a193ec1.jpg' ELSE image_url END, network = COALESCE(network, 'UnionPay'), tags = COALESCE(tags, 'Cardentify,信用卡,来源:云闪付'), notes = COALESCE(notes, 'Cardentify import; original bank: 招商银行; type: Credit; source: 云闪付') WHERE country = 'CN' AND bank_name = '招商银行' AND card_name = '原神联名卡LOGO款';

INSERT INTO card_catalog (country, bank_name, card_name, card_tier, network, tags, image_url, variants, annual_fee_cny, notes)
SELECT 'CN', '招商银行', '原神联名卡甘雨款', '普卡', 'UnionPay', 'Cardentify,信用卡,来源:云闪付', '/images/cards/cardentify/bff0099b0b68-40222ab11865-2497f5fd.jpg', NULL, NULL, 'Cardentify import; original bank: 招商银行; type: Credit; source: 云闪付'
WHERE NOT EXISTS (SELECT 1 FROM card_catalog WHERE country = 'CN' AND bank_name = '招商银行' AND card_name = '原神联名卡甘雨款');
UPDATE card_catalog SET image_url = CASE WHEN image_url IS NULL OR image_url LIKE '/images/cards/cardentify/%' THEN '/images/cards/cardentify/bff0099b0b68-40222ab11865-2497f5fd.jpg' ELSE image_url END, network = COALESCE(network, 'UnionPay'), tags = COALESCE(tags, 'Cardentify,信用卡,来源:云闪付'), notes = COALESCE(notes, 'Cardentify import; original bank: 招商银行; type: Credit; source: 云闪付') WHERE country = 'CN' AND bank_name = '招商银行' AND card_name = '原神联名卡甘雨款';

INSERT INTO card_catalog (country, bank_name, card_name, card_tier, network, tags, image_url, variants, annual_fee_cny, notes)
SELECT 'CN', '招商银行', 'Young卡(青年版)炫酷黑', '金卡', 'UnionPay', 'Cardentify,信用卡,来源:Apple Pay,BIN:622576', '/images/cards/cardentify/bff0099b0b68-young-7fab7bb8.jpg', NULL, NULL, 'Cardentify import; original bank: 招商银行; type: Credit; source: Apple Pay'
WHERE NOT EXISTS (SELECT 1 FROM card_catalog WHERE country = 'CN' AND bank_name = '招商银行' AND card_name = 'Young卡(青年版)炫酷黑');
UPDATE card_catalog SET image_url = CASE WHEN image_url IS NULL OR image_url LIKE '/images/cards/cardentify/%' THEN '/images/cards/cardentify/bff0099b0b68-young-7fab7bb8.jpg' ELSE image_url END, network = COALESCE(network, 'UnionPay'), tags = COALESCE(tags, 'Cardentify,信用卡,来源:Apple Pay,BIN:622576'), notes = COALESCE(notes, 'Cardentify import; original bank: 招商银行; type: Credit; source: Apple Pay') WHERE country = 'CN' AND bank_name = '招商银行' AND card_name = 'Young卡(青年版)炫酷黑';

INSERT INTO card_catalog (country, bank_name, card_name, card_tier, network, tags, image_url, variants, annual_fee_cny, notes)
SELECT 'CN', '招商银行', '招商银行一卡通（金卡IC卡）', '金卡', 'UnionPay', 'Cardentify,借记卡,来源:Apple Pay,BIN:621485', '/images/cards/cardentify/bff0099b0b68-ic-af4d9e87.jpg', NULL, NULL, 'Cardentify import; original bank: 招商银行; type: Debit; source: Apple Pay'
WHERE NOT EXISTS (SELECT 1 FROM card_catalog WHERE country = 'CN' AND bank_name = '招商银行' AND card_name = '招商银行一卡通（金卡IC卡）');
UPDATE card_catalog SET image_url = CASE WHEN image_url IS NULL OR image_url LIKE '/images/cards/cardentify/%' THEN '/images/cards/cardentify/bff0099b0b68-ic-af4d9e87.jpg' ELSE image_url END, network = COALESCE(network, 'UnionPay'), tags = COALESCE(tags, 'Cardentify,借记卡,来源:Apple Pay,BIN:621485'), notes = COALESCE(notes, 'Cardentify import; original bank: 招商银行; type: Debit; source: Apple Pay') WHERE country = 'CN' AND bank_name = '招商银行' AND card_name = '招商银行一卡通（金卡IC卡）';

INSERT INTO card_catalog (country, bank_name, card_name, card_tier, network, tags, image_url, variants, annual_fee_cny, notes)
SELECT 'CN', '招商银行', 'hellokitty粉', '普卡', 'UnionPay', 'Cardentify,信用卡,来源:Mi Pay', '/images/cards/cardentify/bff0099b0b68-hellokitty-bf41e5a3.jpg', NULL, NULL, 'Cardentify import; original bank: 招商银行; type: Credit; source: Mi Pay'
WHERE NOT EXISTS (SELECT 1 FROM card_catalog WHERE country = 'CN' AND bank_name = '招商银行' AND card_name = 'hellokitty粉');
UPDATE card_catalog SET image_url = CASE WHEN image_url IS NULL OR image_url LIKE '/images/cards/cardentify/%' THEN '/images/cards/cardentify/bff0099b0b68-hellokitty-bf41e5a3.jpg' ELSE image_url END, network = COALESCE(network, 'UnionPay'), tags = COALESCE(tags, 'Cardentify,信用卡,来源:Mi Pay'), notes = COALESCE(notes, 'Cardentify import; original bank: 招商银行; type: Credit; source: Mi Pay') WHERE country = 'CN' AND bank_name = '招商银行' AND card_name = 'hellokitty粉';

INSERT INTO card_catalog (country, bank_name, card_name, card_tier, network, tags, image_url, variants, annual_fee_cny, notes)
SELECT 'CN', '招商银行', 'HELLOKITTY珍珠白', '普卡', 'UnionPay', 'Cardentify,借记卡,来源:Mi Pay', '/images/cards/cardentify/bff0099b0b68-hellokitty-830f40e7.jpg', NULL, NULL, 'Cardentify import; original bank: 招商银行; type: Debit; source: Mi Pay'
WHERE NOT EXISTS (SELECT 1 FROM card_catalog WHERE country = 'CN' AND bank_name = '招商银行' AND card_name = 'HELLOKITTY珍珠白');
UPDATE card_catalog SET image_url = CASE WHEN image_url IS NULL OR image_url LIKE '/images/cards/cardentify/%' THEN '/images/cards/cardentify/bff0099b0b68-hellokitty-830f40e7.jpg' ELSE image_url END, network = COALESCE(network, 'UnionPay'), tags = COALESCE(tags, 'Cardentify,借记卡,来源:Mi Pay'), notes = COALESCE(notes, 'Cardentify import; original bank: 招商银行; type: Debit; source: Mi Pay') WHERE country = 'CN' AND bank_name = '招商银行' AND card_name = 'HELLOKITTY珍珠白';

INSERT INTO card_catalog (country, bank_name, card_name, card_tier, network, tags, image_url, variants, annual_fee_cny, notes)
SELECT 'CN', '招商银行', 'kitty金卡', '金卡', 'UnionPay', 'Cardentify,借记卡,来源:Mi Pay', '/images/cards/cardentify/bff0099b0b68-kitty-cd366c98.jpg', NULL, NULL, 'Cardentify import; original bank: 招商银行; type: Debit; source: Mi Pay'
WHERE NOT EXISTS (SELECT 1 FROM card_catalog WHERE country = 'CN' AND bank_name = '招商银行' AND card_name = 'kitty金卡');
UPDATE card_catalog SET image_url = CASE WHEN image_url IS NULL OR image_url LIKE '/images/cards/cardentify/%' THEN '/images/cards/cardentify/bff0099b0b68-kitty-cd366c98.jpg' ELSE image_url END, network = COALESCE(network, 'UnionPay'), tags = COALESCE(tags, 'Cardentify,借记卡,来源:Mi Pay'), notes = COALESCE(notes, 'Cardentify import; original bank: 招商银行; type: Debit; source: Mi Pay') WHERE country = 'CN' AND bank_name = '招商银行' AND card_name = 'kitty金卡';

INSERT INTO card_catalog (country, bank_name, card_name, card_tier, network, tags, image_url, variants, annual_fee_cny, notes)
SELECT 'CN', '招商银行', 'kitty涂鸦', '普卡', 'UnionPay', 'Cardentify,信用卡,来源:Mi Pay', '/images/cards/cardentify/bff0099b0b68-kitty-f968580e.jpg', NULL, NULL, 'Cardentify import; original bank: 招商银行; type: Credit; source: Mi Pay'
WHERE NOT EXISTS (SELECT 1 FROM card_catalog WHERE country = 'CN' AND bank_name = '招商银行' AND card_name = 'kitty涂鸦');
UPDATE card_catalog SET image_url = CASE WHEN image_url IS NULL OR image_url LIKE '/images/cards/cardentify/%' THEN '/images/cards/cardentify/bff0099b0b68-kitty-f968580e.jpg' ELSE image_url END, network = COALESCE(network, 'UnionPay'), tags = COALESCE(tags, 'Cardentify,信用卡,来源:Mi Pay'), notes = COALESCE(notes, 'Cardentify import; original bank: 招商银行; type: Credit; source: Mi Pay') WHERE country = 'CN' AND bank_name = '招商银行' AND card_name = 'kitty涂鸦';

INSERT INTO card_catalog (country, bank_name, card_name, card_tier, network, tags, image_url, variants, annual_fee_cny, notes)
SELECT 'CN', '招商银行', 'VISA双币金卡', '金卡', 'UnionPay', 'Cardentify,信用卡,来源:Mi Pay', '/images/cards/cardentify/bff0099b0b68-visa-edb3bfc5.jpg', NULL, NULL, 'Cardentify import; original bank: 招商银行; type: Credit; source: Mi Pay'
WHERE NOT EXISTS (SELECT 1 FROM card_catalog WHERE country = 'CN' AND bank_name = '招商银行' AND card_name = 'VISA双币金卡');
UPDATE card_catalog SET image_url = CASE WHEN image_url IS NULL OR image_url LIKE '/images/cards/cardentify/%' THEN '/images/cards/cardentify/bff0099b0b68-visa-edb3bfc5.jpg' ELSE image_url END, network = COALESCE(network, 'UnionPay'), tags = COALESCE(tags, 'Cardentify,信用卡,来源:Mi Pay'), notes = COALESCE(notes, 'Cardentify import; original bank: 招商银行; type: Credit; source: Mi Pay') WHERE country = 'CN' AND bank_name = '招商银行' AND card_name = 'VISA双币金卡';

INSERT INTO card_catalog (country, bank_name, card_name, card_tier, network, tags, image_url, variants, annual_fee_cny, notes)
SELECT 'CN', '招商银行', 'VISA双币普卡', '普卡', 'UnionPay', 'Cardentify,信用卡,来源:Mi Pay', '/images/cards/cardentify/bff0099b0b68-visa-5a154110.jpg', NULL, NULL, 'Cardentify import; original bank: 招商银行; type: Credit; source: Mi Pay'
WHERE NOT EXISTS (SELECT 1 FROM card_catalog WHERE country = 'CN' AND bank_name = '招商银行' AND card_name = 'VISA双币普卡');
UPDATE card_catalog SET image_url = CASE WHEN image_url IS NULL OR image_url LIKE '/images/cards/cardentify/%' THEN '/images/cards/cardentify/bff0099b0b68-visa-5a154110.jpg' ELSE image_url END, network = COALESCE(network, 'UnionPay'), tags = COALESCE(tags, 'Cardentify,信用卡,来源:Mi Pay'), notes = COALESCE(notes, 'Cardentify import; original bank: 招商银行; type: Credit; source: Mi Pay') WHERE country = 'CN' AND bank_name = '招商银行' AND card_name = 'VISA双币普卡';

INSERT INTO card_catalog (country, bank_name, card_name, card_tier, network, tags, image_url, variants, annual_fee_cny, notes)
SELECT 'CN', '招商银行', '八重樱', '普卡', 'UnionPay', 'Cardentify,信用卡,来源:Mi Pay', '/images/cards/cardentify/bff0099b0b68-a1fb8af44180-6563609b.jpg', NULL, NULL, 'Cardentify import; original bank: 招商银行; type: Credit; source: Mi Pay'
WHERE NOT EXISTS (SELECT 1 FROM card_catalog WHERE country = 'CN' AND bank_name = '招商银行' AND card_name = '八重樱');
UPDATE card_catalog SET image_url = CASE WHEN image_url IS NULL OR image_url LIKE '/images/cards/cardentify/%' THEN '/images/cards/cardentify/bff0099b0b68-a1fb8af44180-6563609b.jpg' ELSE image_url END, network = COALESCE(network, 'UnionPay'), tags = COALESCE(tags, 'Cardentify,信用卡,来源:Mi Pay'), notes = COALESCE(notes, 'Cardentify import; original bank: 招商银行; type: Credit; source: Mi Pay') WHERE country = 'CN' AND bank_name = '招商银行' AND card_name = '八重樱';

INSERT INTO card_catalog (country, bank_name, card_name, card_tier, network, tags, image_url, variants, annual_fee_cny, notes)
SELECT 'CN', '招商银行', '崩3草履虫', '普卡', 'UnionPay', 'Cardentify,信用卡,来源:Mi Pay', '/images/cards/cardentify/bff0099b0b68-3-effa3612.jpg', NULL, NULL, 'Cardentify import; original bank: 招商银行; type: Credit; source: Mi Pay'
WHERE NOT EXISTS (SELECT 1 FROM card_catalog WHERE country = 'CN' AND bank_name = '招商银行' AND card_name = '崩3草履虫');
UPDATE card_catalog SET image_url = CASE WHEN image_url IS NULL OR image_url LIKE '/images/cards/cardentify/%' THEN '/images/cards/cardentify/bff0099b0b68-3-effa3612.jpg' ELSE image_url END, network = COALESCE(network, 'UnionPay'), tags = COALESCE(tags, 'Cardentify,信用卡,来源:Mi Pay'), notes = COALESCE(notes, 'Cardentify import; original bank: 招商银行; type: Credit; source: Mi Pay') WHERE country = 'CN' AND bank_name = '招商银行' AND card_name = '崩3草履虫';

INSERT INTO card_catalog (country, bank_name, card_name, card_tier, network, tags, image_url, variants, annual_fee_cny, notes)
SELECT 'CN', '招商银行', '哔哩哔哩干杯', '普卡', 'UnionPay', 'Cardentify,信用卡,来源:Mi Pay', '/images/cards/cardentify/bff0099b0b68-727deb00771f-844f8839.jpg', NULL, NULL, 'Cardentify import; original bank: 招商银行; type: Credit; source: Mi Pay'
WHERE NOT EXISTS (SELECT 1 FROM card_catalog WHERE country = 'CN' AND bank_name = '招商银行' AND card_name = '哔哩哔哩干杯');
UPDATE card_catalog SET image_url = CASE WHEN image_url IS NULL OR image_url LIKE '/images/cards/cardentify/%' THEN '/images/cards/cardentify/bff0099b0b68-727deb00771f-844f8839.jpg' ELSE image_url END, network = COALESCE(network, 'UnionPay'), tags = COALESCE(tags, 'Cardentify,信用卡,来源:Mi Pay'), notes = COALESCE(notes, 'Cardentify import; original bank: 招商银行; type: Credit; source: Mi Pay') WHERE country = 'CN' AND bank_name = '招商银行' AND card_name = '哔哩哔哩干杯';

INSERT INTO card_catalog (country, bank_name, card_name, card_tier, network, tags, image_url, variants, annual_fee_cny, notes)
SELECT 'CN', '招商银行', '标准金卡', '金卡', 'UnionPay', 'Cardentify,借记卡,来源:Mi Pay', '/images/cards/cardentify/bff0099b0b68-226385b32dcf-aee81468.jpg', NULL, NULL, 'Cardentify import; original bank: 招商银行; type: Debit; source: Mi Pay'
WHERE NOT EXISTS (SELECT 1 FROM card_catalog WHERE country = 'CN' AND bank_name = '招商银行' AND card_name = '标准金卡');
UPDATE card_catalog SET image_url = CASE WHEN image_url IS NULL OR image_url LIKE '/images/cards/cardentify/%' THEN '/images/cards/cardentify/bff0099b0b68-226385b32dcf-aee81468.jpg' ELSE image_url END, network = COALESCE(network, 'UnionPay'), tags = COALESCE(tags, 'Cardentify,借记卡,来源:Mi Pay'), notes = COALESCE(notes, 'Cardentify import; original bank: 招商银行; type: Debit; source: Mi Pay') WHERE country = 'CN' AND bank_name = '招商银行' AND card_name = '标准金卡';

INSERT INTO card_catalog (country, bank_name, card_name, card_tier, network, tags, image_url, variants, annual_fee_cny, notes)
SELECT 'CN', '招商银行', '标准普卡', '普卡', 'UnionPay', 'Cardentify,信用卡,来源:Mi Pay', '/images/cards/cardentify/bff0099b0b68-f48c7bf0fccc-7393ee48.jpg', NULL, NULL, 'Cardentify import; original bank: 招商银行; type: Credit; source: Mi Pay'
WHERE NOT EXISTS (SELECT 1 FROM card_catalog WHERE country = 'CN' AND bank_name = '招商银行' AND card_name = '标准普卡');
UPDATE card_catalog SET image_url = CASE WHEN image_url IS NULL OR image_url LIKE '/images/cards/cardentify/%' THEN '/images/cards/cardentify/bff0099b0b68-f48c7bf0fccc-7393ee48.jpg' ELSE image_url END, network = COALESCE(network, 'UnionPay'), tags = COALESCE(tags, 'Cardentify,信用卡,来源:Mi Pay'), notes = COALESCE(notes, 'Cardentify import; original bank: 招商银行; type: Credit; source: Mi Pay') WHERE country = 'CN' AND bank_name = '招商银行' AND card_name = '标准普卡';

INSERT INTO card_catalog (country, bank_name, card_name, card_tier, network, tags, image_url, variants, annual_fee_cny, notes)
SELECT 'CN', '招商银行', '初音未来', '普卡', 'UnionPay', 'Cardentify,信用卡,来源:Mi Pay', '/images/cards/cardentify/bff0099b0b68-e6dcb7ed520b-954ad1af.jpg', NULL, NULL, 'Cardentify import; original bank: 招商银行; type: Credit; source: Mi Pay'
WHERE NOT EXISTS (SELECT 1 FROM card_catalog WHERE country = 'CN' AND bank_name = '招商银行' AND card_name = '初音未来');
UPDATE card_catalog SET image_url = CASE WHEN image_url IS NULL OR image_url LIKE '/images/cards/cardentify/%' THEN '/images/cards/cardentify/bff0099b0b68-e6dcb7ed520b-954ad1af.jpg' ELSE image_url END, network = COALESCE(network, 'UnionPay'), tags = COALESCE(tags, 'Cardentify,信用卡,来源:Mi Pay'), notes = COALESCE(notes, 'Cardentify import; original bank: 招商银行; type: Credit; source: Mi Pay') WHERE country = 'CN' AND bank_name = '招商银行' AND card_name = '初音未来';

INSERT INTO card_catalog (country, bank_name, card_name, card_tier, network, tags, image_url, variants, annual_fee_cny, notes)
SELECT 'CN', '招商银行', '初音未来境遇', '普卡', 'UnionPay', 'Cardentify,信用卡,来源:Mi Pay', '/images/cards/cardentify/bff0099b0b68-d0c6b21a7699-bfa1b4d6.jpg', NULL, NULL, 'Cardentify import; original bank: 招商银行; type: Credit; source: Mi Pay'
WHERE NOT EXISTS (SELECT 1 FROM card_catalog WHERE country = 'CN' AND bank_name = '招商银行' AND card_name = '初音未来境遇');
UPDATE card_catalog SET image_url = CASE WHEN image_url IS NULL OR image_url LIKE '/images/cards/cardentify/%' THEN '/images/cards/cardentify/bff0099b0b68-d0c6b21a7699-bfa1b4d6.jpg' ELSE image_url END, network = COALESCE(network, 'UnionPay'), tags = COALESCE(tags, 'Cardentify,信用卡,来源:Mi Pay'), notes = COALESCE(notes, 'Cardentify import; original bank: 招商银行; type: Credit; source: Mi Pay') WHERE country = 'CN' AND bank_name = '招商银行' AND card_name = '初音未来境遇';

INSERT INTO card_catalog (country, bank_name, card_name, card_tier, network, tags, image_url, variants, annual_fee_cny, notes)
SELECT 'CN', '招商银行', '低碳卡', '普卡', 'UnionPay', 'Cardentify,信用卡,来源:Mi Pay', '/images/cards/cardentify/bff0099b0b68-7499af6e419b-4ca88259.jpg', NULL, NULL, 'Cardentify import; original bank: 招商银行; type: Credit; source: Mi Pay'
WHERE NOT EXISTS (SELECT 1 FROM card_catalog WHERE country = 'CN' AND bank_name = '招商银行' AND card_name = '低碳卡');
UPDATE card_catalog SET image_url = CASE WHEN image_url IS NULL OR image_url LIKE '/images/cards/cardentify/%' THEN '/images/cards/cardentify/bff0099b0b68-7499af6e419b-4ca88259.jpg' ELSE image_url END, network = COALESCE(network, 'UnionPay'), tags = COALESCE(tags, 'Cardentify,信用卡,来源:Mi Pay'), notes = COALESCE(notes, 'Cardentify import; original bank: 招商银行; type: Credit; source: Mi Pay') WHERE country = 'CN' AND bank_name = '招商银行' AND card_name = '低碳卡';

INSERT INTO card_catalog (country, bank_name, card_name, card_tier, network, tags, image_url, variants, annual_fee_cny, notes)
SELECT 'CN', '招商银行', '海绵宝宝联名哈哈卡', '普卡', 'UnionPay', 'Cardentify,借记卡,来源:Mi Pay', '/images/cards/cardentify/bff0099b0b68-a6608fb1526a-d2b74c8f.jpg', NULL, NULL, 'Cardentify import; original bank: 招商银行; type: Debit; source: Mi Pay'
WHERE NOT EXISTS (SELECT 1 FROM card_catalog WHERE country = 'CN' AND bank_name = '招商银行' AND card_name = '海绵宝宝联名哈哈卡');
UPDATE card_catalog SET image_url = CASE WHEN image_url IS NULL OR image_url LIKE '/images/cards/cardentify/%' THEN '/images/cards/cardentify/bff0099b0b68-a6608fb1526a-d2b74c8f.jpg' ELSE image_url END, network = COALESCE(network, 'UnionPay'), tags = COALESCE(tags, 'Cardentify,借记卡,来源:Mi Pay'), notes = COALESCE(notes, 'Cardentify import; original bank: 招商银行; type: Debit; source: Mi Pay') WHERE country = 'CN' AND bank_name = '招商银行' AND card_name = '海绵宝宝联名哈哈卡';

INSERT INTO card_catalog (country, bank_name, card_name, card_tier, network, tags, image_url, variants, annual_fee_cny, notes)
SELECT 'CN', '招商银行', '葵花绽放', '白金卡', 'UnionPay', 'Cardentify,借记卡,来源:Mi Pay', '/images/cards/cardentify/bff0099b0b68-011296254e06-830e75a4.jpg', NULL, NULL, 'Cardentify import; original bank: 招商银行; type: Debit; source: Mi Pay'
WHERE NOT EXISTS (SELECT 1 FROM card_catalog WHERE country = 'CN' AND bank_name = '招商银行' AND card_name = '葵花绽放');
UPDATE card_catalog SET image_url = CASE WHEN image_url IS NULL OR image_url LIKE '/images/cards/cardentify/%' THEN '/images/cards/cardentify/bff0099b0b68-011296254e06-830e75a4.jpg' ELSE image_url END, network = COALESCE(network, 'UnionPay'), tags = COALESCE(tags, 'Cardentify,借记卡,来源:Mi Pay'), notes = COALESCE(notes, 'Cardentify import; original bank: 招商银行; type: Debit; source: Mi Pay') WHERE country = 'CN' AND bank_name = '招商银行' AND card_name = '葵花绽放';

INSERT INTO card_catalog (country, bank_name, card_name, card_tier, network, tags, image_url, variants, annual_fee_cny, notes)
SELECT 'CN', '招商银行', '美少女战士', '普卡', 'UnionPay', 'Cardentify,信用卡,来源:Mi Pay', '/images/cards/cardentify/bff0099b0b68-f9bfb875fcc4-dcb60db5.jpg', NULL, NULL, 'Cardentify import; original bank: 招商银行; type: Credit; source: Mi Pay'
WHERE NOT EXISTS (SELECT 1 FROM card_catalog WHERE country = 'CN' AND bank_name = '招商银行' AND card_name = '美少女战士');
UPDATE card_catalog SET image_url = CASE WHEN image_url IS NULL OR image_url LIKE '/images/cards/cardentify/%' THEN '/images/cards/cardentify/bff0099b0b68-f9bfb875fcc4-dcb60db5.jpg' ELSE image_url END, network = COALESCE(network, 'UnionPay'), tags = COALESCE(tags, 'Cardentify,信用卡,来源:Mi Pay'), notes = COALESCE(notes, 'Cardentify import; original bank: 招商银行; type: Credit; source: Mi Pay') WHERE country = 'CN' AND bank_name = '招商银行' AND card_name = '美少女战士';

INSERT INTO card_catalog (country, bank_name, card_name, card_tier, network, tags, image_url, variants, annual_fee_cny, notes)
SELECT 'CN', '招商银行', '美少女战士变身', '普卡', 'UnionPay', 'Cardentify,信用卡,来源:Mi Pay', '/images/cards/cardentify/bff0099b0b68-d67b287c2497-949eecb4.jpg', NULL, NULL, 'Cardentify import; original bank: 招商银行; type: Credit; source: Mi Pay'
WHERE NOT EXISTS (SELECT 1 FROM card_catalog WHERE country = 'CN' AND bank_name = '招商银行' AND card_name = '美少女战士变身');
UPDATE card_catalog SET image_url = CASE WHEN image_url IS NULL OR image_url LIKE '/images/cards/cardentify/%' THEN '/images/cards/cardentify/bff0099b0b68-d67b287c2497-949eecb4.jpg' ELSE image_url END, network = COALESCE(network, 'UnionPay'), tags = COALESCE(tags, 'Cardentify,信用卡,来源:Mi Pay'), notes = COALESCE(notes, 'Cardentify import; original bank: 招商银行; type: Credit; source: Mi Pay') WHERE country = 'CN' AND bank_name = '招商银行' AND card_name = '美少女战士变身';

INSERT INTO card_catalog (country, bank_name, card_name, card_tier, network, tags, image_url, variants, annual_fee_cny, notes)
SELECT 'CN', '招商银行', '萌气卡1', '普卡', 'UnionPay', 'Cardentify,借记卡,来源:Mi Pay', '/images/cards/cardentify/bff0099b0b68-1-de07c1dd.jpg', NULL, NULL, 'Cardentify import; original bank: 招商银行; type: Debit; source: Mi Pay'
WHERE NOT EXISTS (SELECT 1 FROM card_catalog WHERE country = 'CN' AND bank_name = '招商银行' AND card_name = '萌气卡1');
UPDATE card_catalog SET image_url = CASE WHEN image_url IS NULL OR image_url LIKE '/images/cards/cardentify/%' THEN '/images/cards/cardentify/bff0099b0b68-1-de07c1dd.jpg' ELSE image_url END, network = COALESCE(network, 'UnionPay'), tags = COALESCE(tags, 'Cardentify,借记卡,来源:Mi Pay'), notes = COALESCE(notes, 'Cardentify import; original bank: 招商银行; type: Debit; source: Mi Pay') WHERE country = 'CN' AND bank_name = '招商银行' AND card_name = '萌气卡1';

INSERT INTO card_catalog (country, bank_name, card_name, card_tier, network, tags, image_url, variants, annual_fee_cny, notes)
SELECT 'CN', '招商银行', '萌气卡2', '普卡', 'UnionPay', 'Cardentify,借记卡,来源:Mi Pay', '/images/cards/cardentify/bff0099b0b68-2-6d3ed377.jpg', NULL, NULL, 'Cardentify import; original bank: 招商银行; type: Debit; source: Mi Pay'
WHERE NOT EXISTS (SELECT 1 FROM card_catalog WHERE country = 'CN' AND bank_name = '招商银行' AND card_name = '萌气卡2');
UPDATE card_catalog SET image_url = CASE WHEN image_url IS NULL OR image_url LIKE '/images/cards/cardentify/%' THEN '/images/cards/cardentify/bff0099b0b68-2-6d3ed377.jpg' ELSE image_url END, network = COALESCE(network, 'UnionPay'), tags = COALESCE(tags, 'Cardentify,借记卡,来源:Mi Pay'), notes = COALESCE(notes, 'Cardentify import; original bank: 招商银行; type: Debit; source: Mi Pay') WHERE country = 'CN' AND bank_name = '招商银行' AND card_name = '萌气卡2';

INSERT INTO card_catalog (country, bank_name, card_name, card_tier, network, tags, image_url, variants, annual_fee_cny, notes)
SELECT 'CN', '招商银行', '宝可梦粉丝卡皮卡丘版', '普卡', 'UnionPay', 'Cardentify,信用卡,来源:Mi Pay', '/images/cards/cardentify/bff0099b0b68-02b8afd077f9-fce5bf33.jpg', NULL, NULL, 'Cardentify import; original bank: 招商银行; type: Credit; source: Mi Pay'
WHERE NOT EXISTS (SELECT 1 FROM card_catalog WHERE country = 'CN' AND bank_name = '招商银行' AND card_name = '宝可梦粉丝卡皮卡丘版');
UPDATE card_catalog SET image_url = CASE WHEN image_url IS NULL OR image_url LIKE '/images/cards/cardentify/%' THEN '/images/cards/cardentify/bff0099b0b68-02b8afd077f9-fce5bf33.jpg' ELSE image_url END, network = COALESCE(network, 'UnionPay'), tags = COALESCE(tags, 'Cardentify,信用卡,来源:Mi Pay'), notes = COALESCE(notes, 'Cardentify import; original bank: 招商银行; type: Credit; source: Mi Pay') WHERE country = 'CN' AND bank_name = '招商银行' AND card_name = '宝可梦粉丝卡皮卡丘版';

INSERT INTO card_catalog (country, bank_name, card_name, card_tier, network, tags, image_url, variants, annual_fee_cny, notes)
SELECT 'CN', '招商银行', '闪耀暖暖', '普卡', 'UnionPay', 'Cardentify,借记卡,来源:Mi Pay', '/images/cards/cardentify/bff0099b0b68-7554d881702c-a15b4be6.jpg', NULL, NULL, 'Cardentify import; original bank: 招商银行; type: Debit; source: Mi Pay'
WHERE NOT EXISTS (SELECT 1 FROM card_catalog WHERE country = 'CN' AND bank_name = '招商银行' AND card_name = '闪耀暖暖');
UPDATE card_catalog SET image_url = CASE WHEN image_url IS NULL OR image_url LIKE '/images/cards/cardentify/%' THEN '/images/cards/cardentify/bff0099b0b68-7554d881702c-a15b4be6.jpg' ELSE image_url END, network = COALESCE(network, 'UnionPay'), tags = COALESCE(tags, 'Cardentify,借记卡,来源:Mi Pay'), notes = COALESCE(notes, 'Cardentify import; original bank: 招商银行; type: Debit; source: Mi Pay') WHERE country = 'CN' AND bank_name = '招商银行' AND card_name = '闪耀暖暖';

INSERT INTO card_catalog (country, bank_name, card_name, card_tier, network, tags, image_url, variants, annual_fee_cny, notes)
SELECT 'CN', '招商银行', '闪耀暖暖2', '普卡', 'UnionPay', 'Cardentify,借记卡,来源:Mi Pay', '/images/cards/cardentify/bff0099b0b68-2-c7ee1d69.jpg', NULL, NULL, 'Cardentify import; original bank: 招商银行; type: Debit; source: Mi Pay'
WHERE NOT EXISTS (SELECT 1 FROM card_catalog WHERE country = 'CN' AND bank_name = '招商银行' AND card_name = '闪耀暖暖2');
UPDATE card_catalog SET image_url = CASE WHEN image_url IS NULL OR image_url LIKE '/images/cards/cardentify/%' THEN '/images/cards/cardentify/bff0099b0b68-2-c7ee1d69.jpg' ELSE image_url END, network = COALESCE(network, 'UnionPay'), tags = COALESCE(tags, 'Cardentify,借记卡,来源:Mi Pay'), notes = COALESCE(notes, 'Cardentify import; original bank: 招商银行; type: Debit; source: Mi Pay') WHERE country = 'CN' AND bank_name = '招商银行' AND card_name = '闪耀暖暖2';

INSERT INTO card_catalog (country, bank_name, card_name, card_tier, network, tags, image_url, variants, annual_fee_cny, notes)
SELECT 'CN', '招商银行', '星巴克', '普卡', 'UnionPay', 'Cardentify,信用卡,来源:Mi Pay', '/images/cards/cardentify/bff0099b0b68-661fa3834727-6f4db7a3.jpg', NULL, NULL, 'Cardentify import; original bank: 招商银行; type: Credit; source: Mi Pay'
WHERE NOT EXISTS (SELECT 1 FROM card_catalog WHERE country = 'CN' AND bank_name = '招商银行' AND card_name = '星巴克');
UPDATE card_catalog SET image_url = CASE WHEN image_url IS NULL OR image_url LIKE '/images/cards/cardentify/%' THEN '/images/cards/cardentify/bff0099b0b68-661fa3834727-6f4db7a3.jpg' ELSE image_url END, network = COALESCE(network, 'UnionPay'), tags = COALESCE(tags, 'Cardentify,信用卡,来源:Mi Pay'), notes = COALESCE(notes, 'Cardentify import; original bank: 招商银行; type: Credit; source: Mi Pay') WHERE country = 'CN' AND bank_name = '招商银行' AND card_name = '星巴克';

INSERT INTO card_catalog (country, bank_name, card_name, card_tier, network, tags, image_url, variants, annual_fee_cny, notes)
SELECT 'CN', '招商银行', '自由人生白金卡', '白金卡', 'UnionPay', 'Cardentify,信用卡,来源:Mi Pay', '/images/cards/cardentify/bff0099b0b68-8ca1425a5fb6-356c92da.jpg', NULL, NULL, 'Cardentify import; original bank: 招商银行; type: Credit; source: Mi Pay'
WHERE NOT EXISTS (SELECT 1 FROM card_catalog WHERE country = 'CN' AND bank_name = '招商银行' AND card_name = '自由人生白金卡');
UPDATE card_catalog SET image_url = CASE WHEN image_url IS NULL OR image_url LIKE '/images/cards/cardentify/%' THEN '/images/cards/cardentify/bff0099b0b68-8ca1425a5fb6-356c92da.jpg' ELSE image_url END, network = COALESCE(network, 'UnionPay'), tags = COALESCE(tags, 'Cardentify,信用卡,来源:Mi Pay'), notes = COALESCE(notes, 'Cardentify import; original bank: 招商银行; type: Credit; source: Mi Pay') WHERE country = 'CN' AND bank_name = '招商银行' AND card_name = '自由人生白金卡';

INSERT INTO card_catalog (country, bank_name, card_name, card_tier, network, tags, image_url, variants, annual_fee_cny, notes)
SELECT 'CN', '招商银行', '自由人生白金卡粉色', '白金卡', 'UnionPay', 'Cardentify,信用卡,来源:Mi Pay', '/images/cards/cardentify/bff0099b0b68-2ad190e645eb-673b09f8.jpg', NULL, NULL, 'Cardentify import; original bank: 招商银行; type: Credit; source: Mi Pay'
WHERE NOT EXISTS (SELECT 1 FROM card_catalog WHERE country = 'CN' AND bank_name = '招商银行' AND card_name = '自由人生白金卡粉色');
UPDATE card_catalog SET image_url = CASE WHEN image_url IS NULL OR image_url LIKE '/images/cards/cardentify/%' THEN '/images/cards/cardentify/bff0099b0b68-2ad190e645eb-673b09f8.jpg' ELSE image_url END, network = COALESCE(network, 'UnionPay'), tags = COALESCE(tags, 'Cardentify,信用卡,来源:Mi Pay'), notes = COALESCE(notes, 'Cardentify import; original bank: 招商银行; type: Credit; source: Mi Pay') WHERE country = 'CN' AND bank_name = '招商银行' AND card_name = '自由人生白金卡粉色';

INSERT INTO card_catalog (country, bank_name, card_name, card_tier, network, tags, image_url, variants, annual_fee_cny, notes)
SELECT 'CN', '招商银行', 'YOUNG卡青年版-校园版', '普卡', 'UnionPay', 'Cardentify,信用卡,来源:招商银行', '/images/cards/cardentify/bff0099b0b68-young-081267ef.jpg', NULL, NULL, 'Cardentify import; original bank: 招商银行; type: Credit; source: 招商银行'
WHERE NOT EXISTS (SELECT 1 FROM card_catalog WHERE country = 'CN' AND bank_name = '招商银行' AND card_name = 'YOUNG卡青年版-校园版');
UPDATE card_catalog SET image_url = CASE WHEN image_url IS NULL OR image_url LIKE '/images/cards/cardentify/%' THEN '/images/cards/cardentify/bff0099b0b68-young-081267ef.jpg' ELSE image_url END, network = COALESCE(network, 'UnionPay'), tags = COALESCE(tags, 'Cardentify,信用卡,来源:招商银行'), notes = COALESCE(notes, 'Cardentify import; original bank: 招商银行; type: Credit; source: 招商银行') WHERE country = 'CN' AND bank_name = '招商银行' AND card_name = 'YOUNG卡青年版-校园版';

INSERT INTO card_catalog (country, bank_name, card_name, card_tier, network, tags, image_url, variants, annual_fee_cny, notes)
SELECT 'CN', '招商银行', '一网通账户', '普卡', 'UnionPay', 'Cardentify,借记卡,来源:云闪付,BIN:612476', '/images/cards/cardentify/bff0099b0b68-553e30d2aae1-884e458b.jpg', NULL, NULL, 'Cardentify import; original bank: 招商银行; type: Debit; source: 云闪付'
WHERE NOT EXISTS (SELECT 1 FROM card_catalog WHERE country = 'CN' AND bank_name = '招商银行' AND card_name = '一网通账户');
UPDATE card_catalog SET image_url = CASE WHEN image_url IS NULL OR image_url LIKE '/images/cards/cardentify/%' THEN '/images/cards/cardentify/bff0099b0b68-553e30d2aae1-884e458b.jpg' ELSE image_url END, network = COALESCE(network, 'UnionPay'), tags = COALESCE(tags, 'Cardentify,借记卡,来源:云闪付,BIN:612476'), notes = COALESCE(notes, 'Cardentify import; original bank: 招商银行; type: Debit; source: 云闪付') WHERE country = 'CN' AND bank_name = '招商银行' AND card_name = '一网通账户';

INSERT INTO card_catalog (country, bank_name, card_name, card_tier, network, tags, image_url, variants, annual_fee_cny, notes)
SELECT 'CN', '招商银行', '愤怒的小鸟联名储蓄卡（高能baby）', '普卡', 'UnionPay', 'Cardentify,借记卡,来源:云闪付', '/images/cards/cardentify/bff0099b0b68-baby-f6279414.jpg', NULL, NULL, 'Cardentify import; original bank: 招商银行; type: Debit; source: 云闪付'
WHERE NOT EXISTS (SELECT 1 FROM card_catalog WHERE country = 'CN' AND bank_name = '招商银行' AND card_name = '愤怒的小鸟联名储蓄卡（高能baby）');
UPDATE card_catalog SET image_url = CASE WHEN image_url IS NULL OR image_url LIKE '/images/cards/cardentify/%' THEN '/images/cards/cardentify/bff0099b0b68-baby-f6279414.jpg' ELSE image_url END, network = COALESCE(network, 'UnionPay'), tags = COALESCE(tags, 'Cardentify,借记卡,来源:云闪付'), notes = COALESCE(notes, 'Cardentify import; original bank: 招商银行; type: Debit; source: 云闪付') WHERE country = 'CN' AND bank_name = '招商银行' AND card_name = '愤怒的小鸟联名储蓄卡（高能baby）';

INSERT INTO card_catalog (country, bank_name, card_name, card_tier, network, tags, image_url, variants, annual_fee_cny, notes)
SELECT 'CN', '招商银行', '万事达人民币IC借记卡（普卡）', '普卡', 'MasterCard', 'Cardentify,借记卡,来源:招商银行,BIN:534293', '/images/cards/cardentify/bff0099b0b68-ic-51677db2.jpg', NULL, NULL, 'Cardentify import; original bank: 招商银行; type: Debit; source: 招商银行'
WHERE NOT EXISTS (SELECT 1 FROM card_catalog WHERE country = 'CN' AND bank_name = '招商银行' AND card_name = '万事达人民币IC借记卡（普卡）');
UPDATE card_catalog SET image_url = CASE WHEN image_url IS NULL OR image_url LIKE '/images/cards/cardentify/%' THEN '/images/cards/cardentify/bff0099b0b68-ic-51677db2.jpg' ELSE image_url END, network = COALESCE(network, 'MasterCard'), tags = COALESCE(tags, 'Cardentify,借记卡,来源:招商银行,BIN:534293'), notes = COALESCE(notes, 'Cardentify import; original bank: 招商银行; type: Debit; source: 招商银行') WHERE country = 'CN' AND bank_name = '招商银行' AND card_name = '万事达人民币IC借记卡（普卡）';

INSERT INTO card_catalog (country, bank_name, card_name, card_tier, network, tags, image_url, variants, annual_fee_cny, notes)
SELECT 'CN', '招商银行', '福建理工大学·一卡通', '普卡', 'UnionPay', 'Cardentify,借记卡,来源:招商银行,BIN:621483', '/images/cards/cardentify/bff0099b0b68-a0fc82921648-079c9aa2.jpg', NULL, NULL, 'Cardentify import; original bank: 招商银行; type: Debit; source: 招商银行'
WHERE NOT EXISTS (SELECT 1 FROM card_catalog WHERE country = 'CN' AND bank_name = '招商银行' AND card_name = '福建理工大学·一卡通');
UPDATE card_catalog SET image_url = CASE WHEN image_url IS NULL OR image_url LIKE '/images/cards/cardentify/%' THEN '/images/cards/cardentify/bff0099b0b68-a0fc82921648-079c9aa2.jpg' ELSE image_url END, network = COALESCE(network, 'UnionPay'), tags = COALESCE(tags, 'Cardentify,借记卡,来源:招商银行,BIN:621483'), notes = COALESCE(notes, 'Cardentify import; original bank: 招商银行; type: Debit; source: 招商银行') WHERE country = 'CN' AND bank_name = '招商银行' AND card_name = '福建理工大学·一卡通';

INSERT INTO card_catalog (country, bank_name, card_name, card_tier, network, tags, image_url, variants, annual_fee_cny, notes)
SELECT 'CN', '民生银行', '普通IC卡', '普卡', 'UnionPay', 'Cardentify,借记卡,来源:云闪付', '/images/cards/cardentify/ab4445d3e6af-ic-f2078718.jpg', NULL, NULL, 'Cardentify import; original bank: 中国民生银行; type: Debit; source: 云闪付'
WHERE NOT EXISTS (SELECT 1 FROM card_catalog WHERE country = 'CN' AND bank_name = '民生银行' AND card_name = '普通IC卡');
UPDATE card_catalog SET image_url = CASE WHEN image_url IS NULL OR image_url LIKE '/images/cards/cardentify/%' THEN '/images/cards/cardentify/ab4445d3e6af-ic-f2078718.jpg' ELSE image_url END, network = COALESCE(network, 'UnionPay'), tags = COALESCE(tags, 'Cardentify,借记卡,来源:云闪付'), notes = COALESCE(notes, 'Cardentify import; original bank: 中国民生银行; type: Debit; source: 云闪付') WHERE country = 'CN' AND bank_name = '民生银行' AND card_name = '普通IC卡';

INSERT INTO card_catalog (country, bank_name, card_name, card_tier, network, tags, image_url, variants, annual_fee_cny, notes)
SELECT 'CN', '浙商银行', '商卡', '普卡', 'UnionPay', 'Cardentify,借记卡,来源:云闪付', '/images/cards/cardentify/3306f64bf348-6bae4a7c614e-ed3ff33b.jpg', NULL, NULL, 'Cardentify import; original bank: 浙商银行; type: Debit; source: 云闪付'
WHERE NOT EXISTS (SELECT 1 FROM card_catalog WHERE country = 'CN' AND bank_name = '浙商银行' AND card_name = '商卡');
UPDATE card_catalog SET image_url = CASE WHEN image_url IS NULL OR image_url LIKE '/images/cards/cardentify/%' THEN '/images/cards/cardentify/3306f64bf348-6bae4a7c614e-ed3ff33b.jpg' ELSE image_url END, network = COALESCE(network, 'UnionPay'), tags = COALESCE(tags, 'Cardentify,借记卡,来源:云闪付'), notes = COALESCE(notes, 'Cardentify import; original bank: 浙商银行; type: Debit; source: 云闪付') WHERE country = 'CN' AND bank_name = '浙商银行' AND card_name = '商卡';

INSERT INTO card_catalog (country, bank_name, card_name, card_tier, network, tags, image_url, variants, annual_fee_cny, notes)
SELECT 'CN', '花旗银行 (中国)', '花旗银行轻享卡', '白金卡', 'UnionPay', 'Cardentify,信用卡,来源:云闪付', '/images/cards/cardentify/79e8dc5d6407-ea526ca6a520-73d2191f.jpg', NULL, NULL, 'Cardentify import; original bank: 花旗银行 (中国); type: Credit; source: 云闪付'
WHERE NOT EXISTS (SELECT 1 FROM card_catalog WHERE country = 'CN' AND bank_name = '花旗银行 (中国)' AND card_name = '花旗银行轻享卡');
UPDATE card_catalog SET image_url = CASE WHEN image_url IS NULL OR image_url LIKE '/images/cards/cardentify/%' THEN '/images/cards/cardentify/79e8dc5d6407-ea526ca6a520-73d2191f.jpg' ELSE image_url END, network = COALESCE(network, 'UnionPay'), tags = COALESCE(tags, 'Cardentify,信用卡,来源:云闪付'), notes = COALESCE(notes, 'Cardentify import; original bank: 花旗银行 (中国); type: Credit; source: 云闪付') WHERE country = 'CN' AND bank_name = '花旗银行 (中国)' AND card_name = '花旗银行轻享卡';

INSERT INTO card_catalog (country, bank_name, card_name, card_tier, network, tags, image_url, variants, annual_fee_cny, notes)
SELECT 'CN', '花旗银行 (中国)', '花旗银行礼享卡', '白金卡', 'UnionPay', 'Cardentify,信用卡,来源:云闪付', '/images/cards/cardentify/79e8dc5d6407-4624066a77b1-1ea9661b.jpg', NULL, NULL, 'Cardentify import; original bank: 花旗银行 (中国); type: Credit; source: 云闪付'
WHERE NOT EXISTS (SELECT 1 FROM card_catalog WHERE country = 'CN' AND bank_name = '花旗银行 (中国)' AND card_name = '花旗银行礼享卡');
UPDATE card_catalog SET image_url = CASE WHEN image_url IS NULL OR image_url LIKE '/images/cards/cardentify/%' THEN '/images/cards/cardentify/79e8dc5d6407-4624066a77b1-1ea9661b.jpg' ELSE image_url END, network = COALESCE(network, 'UnionPay'), tags = COALESCE(tags, 'Cardentify,信用卡,来源:云闪付'), notes = COALESCE(notes, 'Cardentify import; original bank: 花旗银行 (中国); type: Credit; source: 云闪付') WHERE country = 'CN' AND bank_name = '花旗银行 (中国)' AND card_name = '花旗银行礼享卡';

INSERT INTO card_catalog (country, bank_name, card_name, card_tier, network, tags, image_url, variants, annual_fee_cny, notes)
SELECT 'CN', '花旗银行 (中国)', '花旗银行礼程卡', '白金卡', 'UnionPay', 'Cardentify,信用卡,来源:云闪付', '/images/cards/cardentify/79e8dc5d6407-3f34766aa551-d1a1f968.jpg', NULL, NULL, 'Cardentify import; original bank: 花旗银行 (中国); type: Credit; source: 云闪付'
WHERE NOT EXISTS (SELECT 1 FROM card_catalog WHERE country = 'CN' AND bank_name = '花旗银行 (中国)' AND card_name = '花旗银行礼程卡');
UPDATE card_catalog SET image_url = CASE WHEN image_url IS NULL OR image_url LIKE '/images/cards/cardentify/%' THEN '/images/cards/cardentify/79e8dc5d6407-3f34766aa551-d1a1f968.jpg' ELSE image_url END, network = COALESCE(network, 'UnionPay'), tags = COALESCE(tags, 'Cardentify,信用卡,来源:云闪付'), notes = COALESCE(notes, 'Cardentify import; original bank: 花旗银行 (中国); type: Credit; source: 云闪付') WHERE country = 'CN' AND bank_name = '花旗银行 (中国)' AND card_name = '花旗银行礼程卡';

INSERT INTO card_catalog (country, bank_name, card_name, card_tier, network, tags, image_url, variants, annual_fee_cny, notes)
SELECT 'CN', '花旗银行 (中国)', '花旗银行至享卡', '钻石卡', 'UnionPay', 'Cardentify,信用卡,来源:云闪付', '/images/cards/cardentify/79e8dc5d6407-f12dae25c37d-8daa2d16.jpg', NULL, NULL, 'Cardentify import; original bank: 花旗银行 (中国); type: Credit; source: 云闪付'
WHERE NOT EXISTS (SELECT 1 FROM card_catalog WHERE country = 'CN' AND bank_name = '花旗银行 (中国)' AND card_name = '花旗银行至享卡');
UPDATE card_catalog SET image_url = CASE WHEN image_url IS NULL OR image_url LIKE '/images/cards/cardentify/%' THEN '/images/cards/cardentify/79e8dc5d6407-f12dae25c37d-8daa2d16.jpg' ELSE image_url END, network = COALESCE(network, 'UnionPay'), tags = COALESCE(tags, 'Cardentify,信用卡,来源:云闪付'), notes = COALESCE(notes, 'Cardentify import; original bank: 花旗银行 (中国); type: Credit; source: 云闪付') WHERE country = 'CN' AND bank_name = '花旗银行 (中国)' AND card_name = '花旗银行至享卡';

INSERT INTO card_catalog (country, bank_name, card_name, card_tier, network, tags, image_url, variants, annual_fee_cny, notes)
SELECT 'TW', '花旗銀行 (台灣)', '原花旗現金回饋卡', '无限卡', 'VISA', 'Cardentify,信用卡,来源:Apple Pay,BIN:431178', '/images/cards/cardentify/494d23d9dab6-9d30c6371335-d19848cb.jpg', NULL, NULL, 'Cardentify import; original bank: 花旗銀行 (台灣); type: Credit; source: Apple Pay'
WHERE NOT EXISTS (SELECT 1 FROM card_catalog WHERE country = 'TW' AND bank_name = '花旗銀行 (台灣)' AND card_name = '原花旗現金回饋卡');
UPDATE card_catalog SET image_url = CASE WHEN image_url IS NULL OR image_url LIKE '/images/cards/cardentify/%' THEN '/images/cards/cardentify/494d23d9dab6-9d30c6371335-d19848cb.jpg' ELSE image_url END, network = COALESCE(network, 'VISA'), tags = COALESCE(tags, 'Cardentify,信用卡,来源:Apple Pay,BIN:431178'), notes = COALESCE(notes, 'Cardentify import; original bank: 花旗銀行 (台灣); type: Credit; source: Apple Pay') WHERE country = 'TW' AND bank_name = '花旗銀行 (台灣)' AND card_name = '原花旗現金回饋卡';

INSERT INTO card_catalog (country, bank_name, card_name, card_tier, network, tags, image_url, variants, annual_fee_cny, notes)
SELECT 'TW', '花旗銀行 (台灣)', '原花旗超級紅利回饋鈦金卡', '钛金卡', 'Mastercard', 'Cardentify,信用卡,来源:Apple Pay,BIN:540805', '/images/cards/cardentify/494d23d9dab6-7e0282dd0d0b-e59c9845.jpg', NULL, NULL, 'Cardentify import; original bank: 花旗銀行 (台灣); type: Credit; source: Apple Pay'
WHERE NOT EXISTS (SELECT 1 FROM card_catalog WHERE country = 'TW' AND bank_name = '花旗銀行 (台灣)' AND card_name = '原花旗超級紅利回饋鈦金卡');
UPDATE card_catalog SET image_url = CASE WHEN image_url IS NULL OR image_url LIKE '/images/cards/cardentify/%' THEN '/images/cards/cardentify/494d23d9dab6-7e0282dd0d0b-e59c9845.jpg' ELSE image_url END, network = COALESCE(network, 'Mastercard'), tags = COALESCE(tags, 'Cardentify,信用卡,来源:Apple Pay,BIN:540805'), notes = COALESCE(notes, 'Cardentify import; original bank: 花旗銀行 (台灣); type: Credit; source: Apple Pay') WHERE country = 'TW' AND bank_name = '花旗銀行 (台灣)' AND card_name = '原花旗超級紅利回饋鈦金卡';

INSERT INTO card_catalog (country, bank_name, card_name, card_tier, network, tags, image_url, variants, annual_fee_cny, notes)
SELECT 'CN', '星展银行 (中国)', '星展卡', '普卡', 'UnionPay', 'Cardentify,借记卡,来源:云闪付,BIN:623187', '/images/cards/cardentify/1b78741981ff-d400483e8f36-a53848e7.jpg', NULL, NULL, 'Cardentify import; original bank: 星展银行 (中国); type: Debit; source: 云闪付'
WHERE NOT EXISTS (SELECT 1 FROM card_catalog WHERE country = 'CN' AND bank_name = '星展银行 (中国)' AND card_name = '星展卡');
UPDATE card_catalog SET image_url = CASE WHEN image_url IS NULL OR image_url LIKE '/images/cards/cardentify/%' THEN '/images/cards/cardentify/1b78741981ff-d400483e8f36-a53848e7.jpg' ELSE image_url END, network = COALESCE(network, 'UnionPay'), tags = COALESCE(tags, 'Cardentify,借记卡,来源:云闪付,BIN:623187'), notes = COALESCE(notes, 'Cardentify import; original bank: 星展银行 (中国); type: Debit; source: 云闪付') WHERE country = 'CN' AND bank_name = '星展银行 (中国)' AND card_name = '星展卡';

INSERT INTO card_catalog (country, bank_name, card_name, card_tier, network, tags, image_url, variants, annual_fee_cny, notes)
SELECT 'CN', '星展银行 (中国)', '星展丰盛理财白金借记卡', '白金卡', 'UnionPay', 'Cardentify,借记卡,来源:云闪付,BIN:623187', '/images/cards/cardentify/1b78741981ff-791b80dd8fd0-105fbaf3.jpg', NULL, NULL, 'Cardentify import; original bank: 星展银行 (中国); type: Debit; source: 云闪付'
WHERE NOT EXISTS (SELECT 1 FROM card_catalog WHERE country = 'CN' AND bank_name = '星展银行 (中国)' AND card_name = '星展丰盛理财白金借记卡');
UPDATE card_catalog SET image_url = CASE WHEN image_url IS NULL OR image_url LIKE '/images/cards/cardentify/%' THEN '/images/cards/cardentify/1b78741981ff-791b80dd8fd0-105fbaf3.jpg' ELSE image_url END, network = COALESCE(network, 'UnionPay'), tags = COALESCE(tags, 'Cardentify,借记卡,来源:云闪付,BIN:623187'), notes = COALESCE(notes, 'Cardentify import; original bank: 星展银行 (中国); type: Debit; source: 云闪付') WHERE country = 'CN' AND bank_name = '星展银行 (中国)' AND card_name = '星展丰盛理财白金借记卡';

INSERT INTO card_catalog (country, bank_name, card_name, card_tier, network, tags, image_url, variants, annual_fee_cny, notes)
SELECT 'HK', '星展銀行(香港)', 'DBS Diamond Debit Card', '钻石卡', 'UnionPay', 'Cardentify,借记卡,来源:Apple Pay,BIN:626310', '/images/cards/cardentify/5d4dc9df1be2-dbs-diamond-debit-card-88cde776.jpg', NULL, NULL, 'Cardentify import; original bank: 星展銀行(香港); type: Debit; source: Apple Pay'
WHERE NOT EXISTS (SELECT 1 FROM card_catalog WHERE country = 'HK' AND bank_name = '星展銀行(香港)' AND card_name = 'DBS Diamond Debit Card');
UPDATE card_catalog SET image_url = CASE WHEN image_url IS NULL OR image_url LIKE '/images/cards/cardentify/%' THEN '/images/cards/cardentify/5d4dc9df1be2-dbs-diamond-debit-card-88cde776.jpg' ELSE image_url END, network = COALESCE(network, 'UnionPay'), tags = COALESCE(tags, 'Cardentify,借记卡,来源:Apple Pay,BIN:626310'), notes = COALESCE(notes, 'Cardentify import; original bank: 星展銀行(香港); type: Debit; source: Apple Pay') WHERE country = 'HK' AND bank_name = '星展銀行(香港)' AND card_name = 'DBS Diamond Debit Card';

INSERT INTO card_catalog (country, bank_name, card_name, card_tier, network, tags, image_url, variants, annual_fee_cny, notes)
SELECT 'TW', '星展銀行 (台灣)', '星展饗樂生活白金悠遊卡', '白金卡', 'VISA', 'Cardentify,信用卡,来源:Apple Pay,BIN:463670', '/images/cards/cardentify/db363c13dd83-3c1bd08ac88d-e92d4d71.jpg', NULL, NULL, 'Cardentify import; original bank: 星展銀行 (台灣); type: Credit; source: Apple Pay'
WHERE NOT EXISTS (SELECT 1 FROM card_catalog WHERE country = 'TW' AND bank_name = '星展銀行 (台灣)' AND card_name = '星展饗樂生活白金悠遊卡');
UPDATE card_catalog SET image_url = CASE WHEN image_url IS NULL OR image_url LIKE '/images/cards/cardentify/%' THEN '/images/cards/cardentify/db363c13dd83-3c1bd08ac88d-e92d4d71.jpg' ELSE image_url END, network = COALESCE(network, 'VISA'), tags = COALESCE(tags, 'Cardentify,信用卡,来源:Apple Pay,BIN:463670'), notes = COALESCE(notes, 'Cardentify import; original bank: 星展銀行 (台灣); type: Credit; source: Apple Pay') WHERE country = 'TW' AND bank_name = '星展銀行 (台灣)' AND card_name = '星展饗樂生活白金悠遊卡';

INSERT INTO card_catalog (country, bank_name, card_name, card_tier, network, tags, image_url, variants, annual_fee_cny, notes)
SELECT 'TW', '星展銀行 (台灣)', '星展飛行鈦金卡', '钛金卡', 'Mastercard', 'Cardentify,信用卡,来源:Samsung Pay,BIN:545278', '/images/cards/cardentify/db363c13dd83-9eb24e0a2c24-a565940b.jpg', NULL, NULL, 'Cardentify import; original bank: 星展銀行 (台灣); type: Credit; source: Samsung Pay'
WHERE NOT EXISTS (SELECT 1 FROM card_catalog WHERE country = 'TW' AND bank_name = '星展銀行 (台灣)' AND card_name = '星展飛行鈦金卡');
UPDATE card_catalog SET image_url = CASE WHEN image_url IS NULL OR image_url LIKE '/images/cards/cardentify/%' THEN '/images/cards/cardentify/db363c13dd83-9eb24e0a2c24-a565940b.jpg' ELSE image_url END, network = COALESCE(network, 'Mastercard'), tags = COALESCE(tags, 'Cardentify,信用卡,来源:Samsung Pay,BIN:545278'), notes = COALESCE(notes, 'Cardentify import; original bank: 星展銀行 (台灣); type: Credit; source: Samsung Pay') WHERE country = 'TW' AND bank_name = '星展銀行 (台灣)' AND card_name = '星展飛行鈦金卡';

INSERT INTO card_catalog (country, bank_name, card_name, card_tier, network, tags, image_url, variants, annual_fee_cny, notes)
SELECT 'US', 'DasherDirect', 'DasherDirect Prepaid Card', 'Prepaid', 'VISA', 'Cardentify,借记卡,来源:Apple Pay,BIN:444607', '/images/cards/cardentify/dasherdirect-dasherdirect-prepaid-card-cafbcb2f.jpg', NULL, NULL, 'Cardentify import; original bank: DasherDirect; type: Debit; source: Apple Pay'
WHERE NOT EXISTS (SELECT 1 FROM card_catalog WHERE country = 'US' AND bank_name = 'DasherDirect' AND card_name = 'DasherDirect Prepaid Card');
UPDATE card_catalog SET image_url = CASE WHEN image_url IS NULL OR image_url LIKE '/images/cards/cardentify/%' THEN '/images/cards/cardentify/dasherdirect-dasherdirect-prepaid-card-cafbcb2f.jpg' ELSE image_url END, network = COALESCE(network, 'VISA'), tags = COALESCE(tags, 'Cardentify,借记卡,来源:Apple Pay,BIN:444607'), notes = COALESCE(notes, 'Cardentify import; original bank: DasherDirect; type: Debit; source: Apple Pay') WHERE country = 'US' AND bank_name = 'DasherDirect' AND card_name = 'DasherDirect Prepaid Card';

INSERT INTO card_catalog (country, bank_name, card_name, card_tier, network, tags, image_url, variants, annual_fee_cny, notes)
SELECT 'US', 'Deep Blue', 'Deep Blue Debit', NULL, 'Mastercard', 'Cardentify,借记卡,来源:Apple Pay,BIN:524708', '/images/cards/cardentify/deep-blue-deep-blue-debit-af7602b6.jpg', NULL, NULL, 'Cardentify import; original bank: Deep Blue; type: Debit; source: Apple Pay'
WHERE NOT EXISTS (SELECT 1 FROM card_catalog WHERE country = 'US' AND bank_name = 'Deep Blue' AND card_name = 'Deep Blue Debit');
UPDATE card_catalog SET image_url = CASE WHEN image_url IS NULL OR image_url LIKE '/images/cards/cardentify/%' THEN '/images/cards/cardentify/deep-blue-deep-blue-debit-af7602b6.jpg' ELSE image_url END, network = COALESCE(network, 'Mastercard'), tags = COALESCE(tags, 'Cardentify,借记卡,来源:Apple Pay,BIN:524708'), notes = COALESCE(notes, 'Cardentify import; original bank: Deep Blue; type: Debit; source: Apple Pay') WHERE country = 'US' AND bank_name = 'Deep Blue' AND card_name = 'Deep Blue Debit';

INSERT INTO card_catalog (country, bank_name, card_name, card_tier, network, tags, image_url, variants, annual_fee_cny, notes)
SELECT 'TW', '玉山銀行', 'ETC悠遊聯名卡', 'Precious', 'JCB', 'Cardentify,信用卡,来源:Apple Pay,BIN:356618', '/images/cards/cardentify/6a1c7fd32aab-etc-944d58fd.svg', NULL, NULL, 'Cardentify import; original bank: 玉山銀行; type: Credit; source: Apple Pay'
WHERE NOT EXISTS (SELECT 1 FROM card_catalog WHERE country = 'TW' AND bank_name = '玉山銀行' AND card_name = 'ETC悠遊聯名卡');
UPDATE card_catalog SET image_url = CASE WHEN image_url IS NULL OR image_url LIKE '/images/cards/cardentify/%' THEN '/images/cards/cardentify/6a1c7fd32aab-etc-944d58fd.svg' ELSE image_url END, network = COALESCE(network, 'JCB'), tags = COALESCE(tags, 'Cardentify,信用卡,来源:Apple Pay,BIN:356618'), notes = COALESCE(notes, 'Cardentify import; original bank: 玉山銀行; type: Credit; source: Apple Pay') WHERE country = 'TW' AND bank_name = '玉山銀行' AND card_name = 'ETC悠遊聯名卡';

INSERT INTO card_catalog (country, bank_name, card_name, card_tier, network, tags, image_url, variants, annual_fee_cny, notes)
SELECT 'TW', '玉山銀行', '玉山悠遊聯名卡', '白金卡', 'JCB', 'Cardentify,信用卡,来源:Apple Pay,BIN:356568', '/images/cards/cardentify/6a1c7fd32aab-9ef453f52d11-d7664c8e.svg', NULL, NULL, 'Cardentify import; original bank: 玉山銀行; type: Credit; source: Apple Pay'
WHERE NOT EXISTS (SELECT 1 FROM card_catalog WHERE country = 'TW' AND bank_name = '玉山銀行' AND card_name = '玉山悠遊聯名卡');
UPDATE card_catalog SET image_url = CASE WHEN image_url IS NULL OR image_url LIKE '/images/cards/cardentify/%' THEN '/images/cards/cardentify/6a1c7fd32aab-9ef453f52d11-d7664c8e.svg' ELSE image_url END, network = COALESCE(network, 'JCB'), tags = COALESCE(tags, 'Cardentify,信用卡,来源:Apple Pay,BIN:356568'), notes = COALESCE(notes, 'Cardentify import; original bank: 玉山銀行; type: Credit; source: Apple Pay') WHERE country = 'TW' AND bank_name = '玉山銀行' AND card_name = '玉山悠遊聯名卡';

INSERT INTO card_catalog (country, bank_name, card_name, card_tier, network, tags, image_url, variants, annual_fee_cny, notes)
SELECT 'TW', '玉山銀行', '玉山JCB晶緻卡', 'Precious', 'JCB', 'Cardentify,信用卡,来源:Apple Pay,BIN:356618', '/images/cards/cardentify/6a1c7fd32aab-jcb-fbc51d73.svg', NULL, NULL, 'Cardentify import; original bank: 玉山銀行; type: Credit; source: Apple Pay'
WHERE NOT EXISTS (SELECT 1 FROM card_catalog WHERE country = 'TW' AND bank_name = '玉山銀行' AND card_name = '玉山JCB晶緻卡');
UPDATE card_catalog SET image_url = CASE WHEN image_url IS NULL OR image_url LIKE '/images/cards/cardentify/%' THEN '/images/cards/cardentify/6a1c7fd32aab-jcb-fbc51d73.svg' ELSE image_url END, network = COALESCE(network, 'JCB'), tags = COALESCE(tags, 'Cardentify,信用卡,来源:Apple Pay,BIN:356618'), notes = COALESCE(notes, 'Cardentify import; original bank: 玉山銀行; type: Credit; source: Apple Pay') WHERE country = 'TW' AND bank_name = '玉山銀行' AND card_name = '玉山JCB晶緻卡';

INSERT INTO card_catalog (country, bank_name, card_name, card_tier, network, tags, image_url, variants, annual_fee_cny, notes)
SELECT 'TW', '玉山銀行', '玉山熊本熊卡-熊熊友好', 'Precious', 'JCB', 'Cardentify,信用卡,来源:Apple Pay,BIN:356772', '/images/cards/cardentify/6a1c7fd32aab-41826804b741-fd0b57f6.svg', NULL, NULL, 'Cardentify import; original bank: 玉山銀行; type: Credit; source: Apple Pay'
WHERE NOT EXISTS (SELECT 1 FROM card_catalog WHERE country = 'TW' AND bank_name = '玉山銀行' AND card_name = '玉山熊本熊卡-熊熊友好');
UPDATE card_catalog SET image_url = CASE WHEN image_url IS NULL OR image_url LIKE '/images/cards/cardentify/%' THEN '/images/cards/cardentify/6a1c7fd32aab-41826804b741-fd0b57f6.svg' ELSE image_url END, network = COALESCE(network, 'JCB'), tags = COALESCE(tags, 'Cardentify,信用卡,来源:Apple Pay,BIN:356772'), notes = COALESCE(notes, 'Cardentify import; original bank: 玉山銀行; type: Credit; source: Apple Pay') WHERE country = 'TW' AND bank_name = '玉山銀行' AND card_name = '玉山熊本熊卡-熊熊友好';

INSERT INTO card_catalog (country, bank_name, card_name, card_tier, network, tags, image_url, variants, annual_fee_cny, notes)
SELECT 'TW', '玉山銀行', '玉山星宇航空世界卡', '世界卡', 'Mastercard', 'Cardentify,信用卡,来源:Apple Pay,BIN:519480', '/images/cards/cardentify/6a1c7fd32aab-f44a0ecd177e-e5dd7708.jpg', NULL, NULL, 'Cardentify import; original bank: 玉山銀行; type: Credit; source: Apple Pay'
WHERE NOT EXISTS (SELECT 1 FROM card_catalog WHERE country = 'TW' AND bank_name = '玉山銀行' AND card_name = '玉山星宇航空世界卡');
UPDATE card_catalog SET image_url = CASE WHEN image_url IS NULL OR image_url LIKE '/images/cards/cardentify/%' THEN '/images/cards/cardentify/6a1c7fd32aab-f44a0ecd177e-e5dd7708.jpg' ELSE image_url END, network = COALESCE(network, 'Mastercard'), tags = COALESCE(tags, 'Cardentify,信用卡,来源:Apple Pay,BIN:519480'), notes = COALESCE(notes, 'Cardentify import; original bank: 玉山銀行; type: Credit; source: Apple Pay') WHERE country = 'TW' AND bank_name = '玉山銀行' AND card_name = '玉山星宇航空世界卡';

INSERT INTO card_catalog (country, bank_name, card_name, card_tier, network, tags, image_url, variants, annual_fee_cny, notes)
SELECT 'TW', '玉山銀行', '公務人員國民旅遊卡', '钛金卡', 'Mastercard', 'Cardentify,信用卡,来源:Apple Pay,BIN:523976', '/images/cards/cardentify/6a1c7fd32aab-0620556616dc-85689a59.jpg', NULL, NULL, 'Cardentify import; original bank: 玉山銀行; type: Credit; source: Apple Pay'
WHERE NOT EXISTS (SELECT 1 FROM card_catalog WHERE country = 'TW' AND bank_name = '玉山銀行' AND card_name = '公務人員國民旅遊卡');
UPDATE card_catalog SET image_url = CASE WHEN image_url IS NULL OR image_url LIKE '/images/cards/cardentify/%' THEN '/images/cards/cardentify/6a1c7fd32aab-0620556616dc-85689a59.jpg' ELSE image_url END, network = COALESCE(network, 'Mastercard'), tags = COALESCE(tags, 'Cardentify,信用卡,来源:Apple Pay,BIN:523976'), notes = COALESCE(notes, 'Cardentify import; original bank: 玉山銀行; type: Credit; source: Apple Pay') WHERE country = 'TW' AND bank_name = '玉山銀行' AND card_name = '公務人員國民旅遊卡';

INSERT INTO card_catalog (country, bank_name, card_name, card_tier, network, tags, image_url, variants, annual_fee_cny, notes)
SELECT 'TW', '玉山銀行', 'Pi拍錢包信用卡 (烏漆嘛黑)', '钛金卡', 'Mastercard', 'Cardentify,信用卡,来源:Apple Pay,BIN:524255', '/images/cards/cardentify/6a1c7fd32aab-pi-a4a249d4.jpg', NULL, NULL, 'Cardentify import; original bank: 玉山銀行; type: Credit; source: Apple Pay'
WHERE NOT EXISTS (SELECT 1 FROM card_catalog WHERE country = 'TW' AND bank_name = '玉山銀行' AND card_name = 'Pi拍錢包信用卡 (烏漆嘛黑)');
UPDATE card_catalog SET image_url = CASE WHEN image_url IS NULL OR image_url LIKE '/images/cards/cardentify/%' THEN '/images/cards/cardentify/6a1c7fd32aab-pi-a4a249d4.jpg' ELSE image_url END, network = COALESCE(network, 'Mastercard'), tags = COALESCE(tags, 'Cardentify,信用卡,来源:Apple Pay,BIN:524255'), notes = COALESCE(notes, 'Cardentify import; original bank: 玉山銀行; type: Credit; source: Apple Pay') WHERE country = 'TW' AND bank_name = '玉山銀行' AND card_name = 'Pi拍錢包信用卡 (烏漆嘛黑)';

INSERT INTO card_catalog (country, bank_name, card_name, card_tier, network, tags, image_url, variants, annual_fee_cny, notes)
SELECT 'TW', '玉山銀行', 'Pi拍錢包信用卡 (少女粉粉)', '钛金卡', 'Mastercard', 'Cardentify,信用卡,来源:Apple Pay,BIN:524255', '/images/cards/cardentify/6a1c7fd32aab-pi-67825106.jpg', NULL, NULL, 'Cardentify import; original bank: 玉山銀行; type: Credit; source: Apple Pay'
WHERE NOT EXISTS (SELECT 1 FROM card_catalog WHERE country = 'TW' AND bank_name = '玉山銀行' AND card_name = 'Pi拍錢包信用卡 (少女粉粉)');
UPDATE card_catalog SET image_url = CASE WHEN image_url IS NULL OR image_url LIKE '/images/cards/cardentify/%' THEN '/images/cards/cardentify/6a1c7fd32aab-pi-67825106.jpg' ELSE image_url END, network = COALESCE(network, 'Mastercard'), tags = COALESCE(tags, 'Cardentify,信用卡,来源:Apple Pay,BIN:524255'), notes = COALESCE(notes, 'Cardentify import; original bank: 玉山銀行; type: Credit; source: Apple Pay') WHERE country = 'TW' AND bank_name = '玉山銀行' AND card_name = 'Pi拍錢包信用卡 (少女粉粉)';

INSERT INTO card_catalog (country, bank_name, card_name, card_tier, network, tags, image_url, variants, annual_fee_cny, notes)
SELECT 'TW', '玉山銀行', '家樂福ETC悠遊聯名卡', '钛金卡', 'Mastercard', 'Cardentify,信用卡,来源:Apple Pay,BIN:524255', '/images/cards/cardentify/6a1c7fd32aab-etc-2fa711e0.jpg', NULL, NULL, 'Cardentify import; original bank: 玉山銀行; type: Credit; source: Apple Pay'
WHERE NOT EXISTS (SELECT 1 FROM card_catalog WHERE country = 'TW' AND bank_name = '玉山銀行' AND card_name = '家樂福ETC悠遊聯名卡');
UPDATE card_catalog SET image_url = CASE WHEN image_url IS NULL OR image_url LIKE '/images/cards/cardentify/%' THEN '/images/cards/cardentify/6a1c7fd32aab-etc-2fa711e0.jpg' ELSE image_url END, network = COALESCE(network, 'Mastercard'), tags = COALESCE(tags, 'Cardentify,信用卡,来源:Apple Pay,BIN:524255'), notes = COALESCE(notes, 'Cardentify import; original bank: 玉山銀行; type: Credit; source: Apple Pay') WHERE country = 'TW' AND bank_name = '玉山銀行' AND card_name = '家樂福ETC悠遊聯名卡';

INSERT INTO card_catalog (country, bank_name, card_name, card_tier, network, tags, image_url, variants, annual_fee_cny, notes)
SELECT 'TW', '玉山銀行', '玉山Ubear信用卡（黑）', '钛金卡', 'Mastercard', 'Cardentify,信用卡,来源:Apple Pay,BIN:558936', '/images/cards/cardentify/6a1c7fd32aab-ubear-2acefd00.jpg', NULL, NULL, 'Cardentify import; original bank: 玉山銀行; type: Credit; source: Apple Pay'
WHERE NOT EXISTS (SELECT 1 FROM card_catalog WHERE country = 'TW' AND bank_name = '玉山銀行' AND card_name = '玉山Ubear信用卡（黑）');
UPDATE card_catalog SET image_url = CASE WHEN image_url IS NULL OR image_url LIKE '/images/cards/cardentify/%' THEN '/images/cards/cardentify/6a1c7fd32aab-ubear-2acefd00.jpg' ELSE image_url END, network = COALESCE(network, 'Mastercard'), tags = COALESCE(tags, 'Cardentify,信用卡,来源:Apple Pay,BIN:558936'), notes = COALESCE(notes, 'Cardentify import; original bank: 玉山銀行; type: Credit; source: Apple Pay') WHERE country = 'TW' AND bank_name = '玉山銀行' AND card_name = '玉山Ubear信用卡（黑）';

INSERT INTO card_catalog (country, bank_name, card_name, card_tier, network, tags, image_url, variants, annual_fee_cny, notes)
SELECT 'TW', '玉山銀行', '玉山Ubear信用卡（黄）', '钛金卡', 'Mastercard', 'Cardentify,信用卡,来源:Apple Pay,BIN:558936', '/images/cards/cardentify/6a1c7fd32aab-ubear-c52e3df4.jpg', NULL, NULL, 'Cardentify import; original bank: 玉山銀行; type: Credit; source: Apple Pay'
WHERE NOT EXISTS (SELECT 1 FROM card_catalog WHERE country = 'TW' AND bank_name = '玉山銀行' AND card_name = '玉山Ubear信用卡（黄）');
UPDATE card_catalog SET image_url = CASE WHEN image_url IS NULL OR image_url LIKE '/images/cards/cardentify/%' THEN '/images/cards/cardentify/6a1c7fd32aab-ubear-c52e3df4.jpg' ELSE image_url END, network = COALESCE(network, 'Mastercard'), tags = COALESCE(tags, 'Cardentify,信用卡,来源:Apple Pay,BIN:558936'), notes = COALESCE(notes, 'Cardentify import; original bank: 玉山銀行; type: Credit; source: Apple Pay') WHERE country = 'TW' AND bank_name = '玉山銀行' AND card_name = '玉山Ubear信用卡（黄）';

INSERT INTO card_catalog (country, bank_name, card_name, card_tier, network, tags, image_url, variants, annual_fee_cny, notes)
SELECT 'JP', 'ENEOS カード', 'ENEOSカードS', '普卡', 'JCB', 'Cardentify,信用卡,来源:Apple Pay,BIN:358746', '/images/cards/cardentify/eneos-eneoss-25678110.svg', NULL, NULL, 'Cardentify import; original bank: ENEOS カード; type: Credit; source: Apple Pay'
WHERE NOT EXISTS (SELECT 1 FROM card_catalog WHERE country = 'JP' AND bank_name = 'ENEOS カード' AND card_name = 'ENEOSカードS');
UPDATE card_catalog SET image_url = CASE WHEN image_url IS NULL OR image_url LIKE '/images/cards/cardentify/%' THEN '/images/cards/cardentify/eneos-eneoss-25678110.svg' ELSE image_url END, network = COALESCE(network, 'JCB'), tags = COALESCE(tags, 'Cardentify,信用卡,来源:Apple Pay,BIN:358746'), notes = COALESCE(notes, 'Cardentify import; original bank: ENEOS カード; type: Credit; source: Apple Pay') WHERE country = 'JP' AND bank_name = 'ENEOS カード' AND card_name = 'ENEOSカードS';

INSERT INTO card_catalog (country, bank_name, card_name, card_tier, network, tags, image_url, variants, annual_fee_cny, notes)
SELECT 'TW', '第一銀行', 'VISA金融卡', 'Classic', 'VISA', 'Cardentify,借记卡,来源:Apple Pay,BIN:469521', '/images/cards/cardentify/4396fc63cebb-visa-f4be4c21.jpg', NULL, NULL, 'Cardentify import; original bank: 第一銀行; type: Debit; source: Apple Pay'
WHERE NOT EXISTS (SELECT 1 FROM card_catalog WHERE country = 'TW' AND bank_name = '第一銀行' AND card_name = 'VISA金融卡');
UPDATE card_catalog SET image_url = CASE WHEN image_url IS NULL OR image_url LIKE '/images/cards/cardentify/%' THEN '/images/cards/cardentify/4396fc63cebb-visa-f4be4c21.jpg' ELSE image_url END, network = COALESCE(network, 'VISA'), tags = COALESCE(tags, 'Cardentify,借记卡,来源:Apple Pay,BIN:469521'), notes = COALESCE(notes, 'Cardentify import; original bank: 第一銀行; type: Debit; source: Apple Pay') WHERE country = 'TW' AND bank_name = '第一銀行' AND card_name = 'VISA金融卡';

INSERT INTO card_catalog (country, bank_name, card_name, card_tier, network, tags, image_url, variants, annual_fee_cny, notes)
SELECT 'TW', '第一銀行', '第一銀行悠遊聯名白金卡', '白金卡', 'VISA', 'Cardentify,信用卡,来源:Apple Pay,BIN:468828', '/images/cards/cardentify/4396fc63cebb-525b1717549c-f04c8bae.jpg', NULL, NULL, 'Cardentify import; original bank: 第一銀行; type: Credit; source: Apple Pay'
WHERE NOT EXISTS (SELECT 1 FROM card_catalog WHERE country = 'TW' AND bank_name = '第一銀行' AND card_name = '第一銀行悠遊聯名白金卡');
UPDATE card_catalog SET image_url = CASE WHEN image_url IS NULL OR image_url LIKE '/images/cards/cardentify/%' THEN '/images/cards/cardentify/4396fc63cebb-525b1717549c-f04c8bae.jpg' ELSE image_url END, network = COALESCE(network, 'VISA'), tags = COALESCE(tags, 'Cardentify,信用卡,来源:Apple Pay,BIN:468828'), notes = COALESCE(notes, 'Cardentify import; original bank: 第一銀行; type: Credit; source: Apple Pay') WHERE country = 'TW' AND bank_name = '第一銀行' AND card_name = '第一銀行悠遊聯名白金卡';

INSERT INTO card_catalog (country, bank_name, card_name, card_tier, network, tags, image_url, variants, annual_fee_cny, notes)
SELECT 'CN', '富邦华一银行', '富邦标准借记卡金卡', '金卡', 'UnionPay', 'Cardentify,借记卡,来源:Apple Pay,BIN:623565', '/images/cards/cardentify/e82f1300ce17-f7a22123f0d1-ac4be3e0.jpg', NULL, NULL, 'Cardentify import; original bank: 富邦华一银行; type: Debit; source: Apple Pay'
WHERE NOT EXISTS (SELECT 1 FROM card_catalog WHERE country = 'CN' AND bank_name = '富邦华一银行' AND card_name = '富邦标准借记卡金卡');
UPDATE card_catalog SET image_url = CASE WHEN image_url IS NULL OR image_url LIKE '/images/cards/cardentify/%' THEN '/images/cards/cardentify/e82f1300ce17-f7a22123f0d1-ac4be3e0.jpg' ELSE image_url END, network = COALESCE(network, 'UnionPay'), tags = COALESCE(tags, 'Cardentify,借记卡,来源:Apple Pay,BIN:623565'), notes = COALESCE(notes, 'Cardentify import; original bank: 富邦华一银行; type: Debit; source: Apple Pay') WHERE country = 'CN' AND bank_name = '富邦华一银行' AND card_name = '富邦标准借记卡金卡';

INSERT INTO card_catalog (country, bank_name, card_name, card_tier, network, tags, image_url, variants, annual_fee_cny, notes)
SELECT 'CN', '富邦华一银行', '富邦标准借记卡白金卡', '白金卡', 'UnionPay', 'Cardentify,借记卡,来源:Apple Pay,BIN:623565', '/images/cards/cardentify/e82f1300ce17-e02cd41d2cb9-64f59608.jpg', NULL, NULL, 'Cardentify import; original bank: 富邦华一银行; type: Debit; source: Apple Pay'
WHERE NOT EXISTS (SELECT 1 FROM card_catalog WHERE country = 'CN' AND bank_name = '富邦华一银行' AND card_name = '富邦标准借记卡白金卡');
UPDATE card_catalog SET image_url = CASE WHEN image_url IS NULL OR image_url LIKE '/images/cards/cardentify/%' THEN '/images/cards/cardentify/e82f1300ce17-e02cd41d2cb9-64f59608.jpg' ELSE image_url END, network = COALESCE(network, 'UnionPay'), tags = COALESCE(tags, 'Cardentify,借记卡,来源:Apple Pay,BIN:623565'), notes = COALESCE(notes, 'Cardentify import; original bank: 富邦华一银行; type: Debit; source: Apple Pay') WHERE country = 'CN' AND bank_name = '富邦华一银行' AND card_name = '富邦标准借记卡白金卡';

INSERT INTO card_catalog (country, bank_name, card_name, card_tier, network, tags, image_url, variants, annual_fee_cny, notes)
SELECT 'CN', '富邦华一银行', '富邦标准借记卡钻石卡', '钻石卡', 'UnionPay', 'Cardentify,借记卡,来源:Apple Pay,BIN:623565', '/images/cards/cardentify/e82f1300ce17-920c7e2f2042-786fb9d4.jpg', NULL, NULL, 'Cardentify import; original bank: 富邦华一银行; type: Debit; source: Apple Pay'
WHERE NOT EXISTS (SELECT 1 FROM card_catalog WHERE country = 'CN' AND bank_name = '富邦华一银行' AND card_name = '富邦标准借记卡钻石卡');
UPDATE card_catalog SET image_url = CASE WHEN image_url IS NULL OR image_url LIKE '/images/cards/cardentify/%' THEN '/images/cards/cardentify/e82f1300ce17-920c7e2f2042-786fb9d4.jpg' ELSE image_url END, network = COALESCE(network, 'UnionPay'), tags = COALESCE(tags, 'Cardentify,借记卡,来源:Apple Pay,BIN:623565'), notes = COALESCE(notes, 'Cardentify import; original bank: 富邦华一银行; type: Debit; source: Apple Pay') WHERE country = 'CN' AND bank_name = '富邦华一银行' AND card_name = '富邦标准借记卡钻石卡';

INSERT INTO card_catalog (country, bank_name, card_name, card_tier, network, tags, image_url, variants, annual_fee_cny, notes)
SELECT 'CN', '富邦华一银行', '富邦数位卡绿卡', '金卡', 'UnionPay', 'Cardentify,借记卡,来源:云闪付,BIN:623565', '/images/cards/cardentify/e82f1300ce17-18e1545bd41d-1324ebaf.jpg', NULL, NULL, 'Cardentify import; original bank: 富邦华一银行; type: Debit; source: 云闪付'
WHERE NOT EXISTS (SELECT 1 FROM card_catalog WHERE country = 'CN' AND bank_name = '富邦华一银行' AND card_name = '富邦数位卡绿卡');
UPDATE card_catalog SET image_url = CASE WHEN image_url IS NULL OR image_url LIKE '/images/cards/cardentify/%' THEN '/images/cards/cardentify/e82f1300ce17-18e1545bd41d-1324ebaf.jpg' ELSE image_url END, network = COALESCE(network, 'UnionPay'), tags = COALESCE(tags, 'Cardentify,借记卡,来源:云闪付,BIN:623565'), notes = COALESCE(notes, 'Cardentify import; original bank: 富邦华一银行; type: Debit; source: 云闪付') WHERE country = 'CN' AND bank_name = '富邦华一银行' AND card_name = '富邦数位卡绿卡';

INSERT INTO card_catalog (country, bank_name, card_name, card_tier, network, tags, image_url, variants, annual_fee_cny, notes)
SELECT 'CN', '富邦华一银行', '富邦数位卡粉卡', '金卡', 'UnionPay', 'Cardentify,借记卡,来源:云闪付,BIN:623565', '/images/cards/cardentify/e82f1300ce17-948eae1e4c8e-fb8533f3.jpg', NULL, NULL, 'Cardentify import; original bank: 富邦华一银行; type: Debit; source: 云闪付'
WHERE NOT EXISTS (SELECT 1 FROM card_catalog WHERE country = 'CN' AND bank_name = '富邦华一银行' AND card_name = '富邦数位卡粉卡');
UPDATE card_catalog SET image_url = CASE WHEN image_url IS NULL OR image_url LIKE '/images/cards/cardentify/%' THEN '/images/cards/cardentify/e82f1300ce17-948eae1e4c8e-fb8533f3.jpg' ELSE image_url END, network = COALESCE(network, 'UnionPay'), tags = COALESCE(tags, 'Cardentify,借记卡,来源:云闪付,BIN:623565'), notes = COALESCE(notes, 'Cardentify import; original bank: 富邦华一银行; type: Debit; source: 云闪付') WHERE country = 'CN' AND bank_name = '富邦华一银行' AND card_name = '富邦数位卡粉卡';

INSERT INTO card_catalog (country, bank_name, card_name, card_tier, network, tags, image_url, variants, annual_fee_cny, notes)
SELECT 'CN', '富邦华一银行', '富邦小微企业卡', '白金卡', 'UnionPay', 'Cardentify,借记卡,来源:云闪付,BIN:623565', '/images/cards/cardentify/e82f1300ce17-28f0ca671e5c-2a19dfcf.jpg', NULL, NULL, 'Cardentify import; original bank: 富邦华一银行; type: Debit; source: 云闪付'
WHERE NOT EXISTS (SELECT 1 FROM card_catalog WHERE country = 'CN' AND bank_name = '富邦华一银行' AND card_name = '富邦小微企业卡');
UPDATE card_catalog SET image_url = CASE WHEN image_url IS NULL OR image_url LIKE '/images/cards/cardentify/%' THEN '/images/cards/cardentify/e82f1300ce17-28f0ca671e5c-2a19dfcf.jpg' ELSE image_url END, network = COALESCE(network, 'UnionPay'), tags = COALESCE(tags, 'Cardentify,借记卡,来源:云闪付,BIN:623565'), notes = COALESCE(notes, 'Cardentify import; original bank: 富邦华一银行; type: Debit; source: 云闪付') WHERE country = 'CN' AND bank_name = '富邦华一银行' AND card_name = '富邦小微企业卡';

INSERT INTO card_catalog (country, bank_name, card_name, card_tier, network, tags, image_url, variants, annual_fee_cny, notes)
SELECT 'CN', '富邦华一银行', '富邦邦邦留学生借记卡', '白金卡', 'UnionPay', 'Cardentify,借记卡,来源:云闪付,BIN:623565', '/images/cards/cardentify/e82f1300ce17-93bbc7126c09-3ffc62e3.jpg', NULL, NULL, 'Cardentify import; original bank: 富邦华一银行; type: Debit; source: 云闪付'
WHERE NOT EXISTS (SELECT 1 FROM card_catalog WHERE country = 'CN' AND bank_name = '富邦华一银行' AND card_name = '富邦邦邦留学生借记卡');
UPDATE card_catalog SET image_url = CASE WHEN image_url IS NULL OR image_url LIKE '/images/cards/cardentify/%' THEN '/images/cards/cardentify/e82f1300ce17-93bbc7126c09-3ffc62e3.jpg' ELSE image_url END, network = COALESCE(network, 'UnionPay'), tags = COALESCE(tags, 'Cardentify,借记卡,来源:云闪付,BIN:623565'), notes = COALESCE(notes, 'Cardentify import; original bank: 富邦华一银行; type: Debit; source: 云闪付') WHERE country = 'CN' AND bank_name = '富邦华一银行' AND card_name = '富邦邦邦留学生借记卡';

INSERT INTO card_catalog (country, bank_name, card_name, card_tier, network, tags, image_url, variants, annual_fee_cny, notes)
SELECT 'CN', '富邦华一银行', '富邦菁英留学生借记卡', '白金卡', 'UnionPay', 'Cardentify,借记卡,来源:云闪付,BIN:623565', '/images/cards/cardentify/e82f1300ce17-53e294785503-4dc38229.jpg', NULL, NULL, 'Cardentify import; original bank: 富邦华一银行; type: Debit; source: 云闪付'
WHERE NOT EXISTS (SELECT 1 FROM card_catalog WHERE country = 'CN' AND bank_name = '富邦华一银行' AND card_name = '富邦菁英留学生借记卡');
UPDATE card_catalog SET image_url = CASE WHEN image_url IS NULL OR image_url LIKE '/images/cards/cardentify/%' THEN '/images/cards/cardentify/e82f1300ce17-53e294785503-4dc38229.jpg' ELSE image_url END, network = COALESCE(network, 'UnionPay'), tags = COALESCE(tags, 'Cardentify,借记卡,来源:云闪付,BIN:623565'), notes = COALESCE(notes, 'Cardentify import; original bank: 富邦华一银行; type: Debit; source: 云闪付') WHERE country = 'CN' AND bank_name = '富邦华一银行' AND card_name = '富邦菁英留学生借记卡';

INSERT INTO card_catalog (country, bank_name, card_name, card_tier, network, tags, image_url, variants, annual_fee_cny, notes)
SELECT 'CN', '汇丰银行 (中国)', '汇丰银行（中国）卓越理财借记卡', '普卡', 'UnionPay', 'Cardentify,借记卡,来源:Apple Pay,BIN:622946', '/images/cards/cardentify/b368ed8d4d27-d9e8458cb01c-2b5dc697.jpg', NULL, NULL, 'Cardentify import; original bank: 汇丰银行 (中国); type: Debit; source: Apple Pay'
WHERE NOT EXISTS (SELECT 1 FROM card_catalog WHERE country = 'CN' AND bank_name = '汇丰银行 (中国)' AND card_name = '汇丰银行（中国）卓越理财借记卡');
UPDATE card_catalog SET image_url = CASE WHEN image_url IS NULL OR image_url LIKE '/images/cards/cardentify/%' THEN '/images/cards/cardentify/b368ed8d4d27-d9e8458cb01c-2b5dc697.jpg' ELSE image_url END, network = COALESCE(network, 'UnionPay'), tags = COALESCE(tags, 'Cardentify,借记卡,来源:Apple Pay,BIN:622946'), notes = COALESCE(notes, 'Cardentify import; original bank: 汇丰银行 (中国); type: Debit; source: Apple Pay') WHERE country = 'CN' AND bank_name = '汇丰银行 (中国)' AND card_name = '汇丰银行（中国）卓越理财借记卡';

INSERT INTO card_catalog (country, bank_name, card_name, card_tier, network, tags, image_url, variants, annual_fee_cny, notes)
SELECT 'CN', '汇丰银行 (中国)', '汇丰银行（中国）环球私人银行借记卡', '普卡', 'UnionPay', 'Cardentify,借记卡,来源:云闪付', '/images/cards/cardentify/b368ed8d4d27-93b76eb563b2-8de8e5ae.jpg', NULL, NULL, 'Cardentify import; original bank: 汇丰银行 (中国); type: Debit; source: 云闪付'
WHERE NOT EXISTS (SELECT 1 FROM card_catalog WHERE country = 'CN' AND bank_name = '汇丰银行 (中国)' AND card_name = '汇丰银行（中国）环球私人银行借记卡');
UPDATE card_catalog SET image_url = CASE WHEN image_url IS NULL OR image_url LIKE '/images/cards/cardentify/%' THEN '/images/cards/cardentify/b368ed8d4d27-93b76eb563b2-8de8e5ae.jpg' ELSE image_url END, network = COALESCE(network, 'UnionPay'), tags = COALESCE(tags, 'Cardentify,借记卡,来源:云闪付'), notes = COALESCE(notes, 'Cardentify import; original bank: 汇丰银行 (中国); type: Debit; source: 云闪付') WHERE country = 'CN' AND bank_name = '汇丰银行 (中国)' AND card_name = '汇丰银行（中国）环球私人银行借记卡';

INSERT INTO card_catalog (country, bank_name, card_name, card_tier, network, tags, image_url, variants, annual_fee_cny, notes)
SELECT 'US', 'HSBC Bank (USA)', 'HSBC Premier MasterCard Debit', '世界卡', 'Mastercard', 'Cardentify,借记卡,来源:Apple Pay', '/images/cards/cardentify/hsbc-bank-usa-hsbc-premier-mastercard-debit-23a9b382.jpg', NULL, NULL, 'Cardentify import; original bank: HSBC Bank (USA); type: Debit; source: Apple Pay'
WHERE NOT EXISTS (SELECT 1 FROM card_catalog WHERE country = 'US' AND bank_name = 'HSBC Bank (USA)' AND card_name = 'HSBC Premier MasterCard Debit');
UPDATE card_catalog SET image_url = CASE WHEN image_url IS NULL OR image_url LIKE '/images/cards/cardentify/%' THEN '/images/cards/cardentify/hsbc-bank-usa-hsbc-premier-mastercard-debit-23a9b382.jpg' ELSE image_url END, network = COALESCE(network, 'Mastercard'), tags = COALESCE(tags, 'Cardentify,借记卡,来源:Apple Pay'), notes = COALESCE(notes, 'Cardentify import; original bank: HSBC Bank (USA); type: Debit; source: Apple Pay') WHERE country = 'US' AND bank_name = 'HSBC Bank (USA)' AND card_name = 'HSBC Premier MasterCard Debit';

INSERT INTO card_catalog (country, bank_name, card_name, card_tier, network, tags, image_url, variants, annual_fee_cny, notes)
SELECT 'US', 'HSBC Bank (USA)', 'HSBC Premier MasterCard', '世界卡', 'Mastercard', 'Cardentify,信用卡,来源:Apple Pay', '/images/cards/cardentify/hsbc-bank-usa-hsbc-premier-mastercard-d7cedb62.jpg', NULL, NULL, 'Cardentify import; original bank: HSBC Bank (USA); type: Credit; source: Apple Pay'
WHERE NOT EXISTS (SELECT 1 FROM card_catalog WHERE country = 'US' AND bank_name = 'HSBC Bank (USA)' AND card_name = 'HSBC Premier MasterCard');
UPDATE card_catalog SET image_url = CASE WHEN image_url IS NULL OR image_url LIKE '/images/cards/cardentify/%' THEN '/images/cards/cardentify/hsbc-bank-usa-hsbc-premier-mastercard-d7cedb62.jpg' ELSE image_url END, network = COALESCE(network, 'Mastercard'), tags = COALESCE(tags, 'Cardentify,信用卡,来源:Apple Pay'), notes = COALESCE(notes, 'Cardentify import; original bank: HSBC Bank (USA); type: Credit; source: Apple Pay') WHERE country = 'US' AND bank_name = 'HSBC Bank (USA)' AND card_name = 'HSBC Premier MasterCard';

INSERT INTO card_catalog (country, bank_name, card_name, card_tier, network, tags, image_url, variants, annual_fee_cny, notes)
SELECT 'HK', '恒生銀行', 'Prestige Banking ATM Card', '普卡', 'UnionPay', 'Cardentify,借记卡,来源:Apple Pay,BIN:623107', '/images/cards/cardentify/1a6866f726ce-prestige-banking-atm-card-5ba29dca.jpg', NULL, NULL, 'Cardentify import; original bank: 恒生銀行; type: Debit; source: Apple Pay'
WHERE NOT EXISTS (SELECT 1 FROM card_catalog WHERE country = 'HK' AND bank_name = '恒生銀行' AND card_name = 'Prestige Banking ATM Card');
UPDATE card_catalog SET image_url = CASE WHEN image_url IS NULL OR image_url LIKE '/images/cards/cardentify/%' THEN '/images/cards/cardentify/1a6866f726ce-prestige-banking-atm-card-5ba29dca.jpg' ELSE image_url END, network = COALESCE(network, 'UnionPay'), tags = COALESCE(tags, 'Cardentify,借记卡,来源:Apple Pay,BIN:623107'), notes = COALESCE(notes, 'Cardentify import; original bank: 恒生銀行; type: Debit; source: Apple Pay') WHERE country = 'HK' AND bank_name = '恒生銀行' AND card_name = 'Prestige Banking ATM Card';

INSERT INTO card_catalog (country, bank_name, card_name, card_tier, network, tags, image_url, variants, annual_fee_cny, notes)
SELECT 'CN', '华夏银行', '华夏卡', '普卡', 'UnionPay', 'Cardentify,借记卡,来源:云闪付', '/images/cards/cardentify/9ead388c1b87-69f9efe3f2a6-d2552012.jpg', NULL, NULL, 'Cardentify import; original bank: 华夏银行; type: Debit; source: 云闪付'
WHERE NOT EXISTS (SELECT 1 FROM card_catalog WHERE country = 'CN' AND bank_name = '华夏银行' AND card_name = '华夏卡');
UPDATE card_catalog SET image_url = CASE WHEN image_url IS NULL OR image_url LIKE '/images/cards/cardentify/%' THEN '/images/cards/cardentify/9ead388c1b87-69f9efe3f2a6-d2552012.jpg' ELSE image_url END, network = COALESCE(network, 'UnionPay'), tags = COALESCE(tags, 'Cardentify,借记卡,来源:云闪付'), notes = COALESCE(notes, 'Cardentify import; original bank: 华夏银行; type: Debit; source: 云闪付') WHERE country = 'CN' AND bank_name = '华夏银行' AND card_name = '华夏卡';

INSERT INTO card_catalog (country, bank_name, card_name, card_tier, network, tags, image_url, variants, annual_fee_cny, notes)
SELECT 'CN', '工商银行', '工银灵通卡', '普卡', 'UnionPay', 'Cardentify,借记卡,来源:Apple Pay,BIN:622203/622202/621225/621226', '/images/cards/cardentify/7f01bcf3af8d-c151fc44d2ce-d8cab43c.jpg', NULL, NULL, 'Cardentify import; original bank: 中国工商银行; type: Debit; source: Apple Pay'
WHERE NOT EXISTS (SELECT 1 FROM card_catalog WHERE country = 'CN' AND bank_name = '工商银行' AND card_name = '工银灵通卡');
UPDATE card_catalog SET image_url = CASE WHEN image_url IS NULL OR image_url LIKE '/images/cards/cardentify/%' THEN '/images/cards/cardentify/7f01bcf3af8d-c151fc44d2ce-d8cab43c.jpg' ELSE image_url END, network = COALESCE(network, 'UnionPay'), tags = COALESCE(tags, 'Cardentify,借记卡,来源:Apple Pay,BIN:622203/622202/621225/621226'), notes = COALESCE(notes, 'Cardentify import; original bank: 中国工商银行; type: Debit; source: Apple Pay') WHERE country = 'CN' AND bank_name = '工商银行' AND card_name = '工银灵通卡';

INSERT INTO card_catalog (country, bank_name, card_name, card_tier, network, tags, image_url, variants, annual_fee_cny, notes)
SELECT 'CN', '工商银行', '宇宙星座卡普卡校园版·双鱼座', '普卡', 'UnionPay', 'Cardentify,信用卡,来源:Apple Pay,BIN:625249', '/images/cards/cardentify/7f01bcf3af8d-e25743c4c8e2-4089df03.jpg', NULL, NULL, 'Cardentify import; original bank: 中国工商银行; type: Credit; source: Apple Pay'
WHERE NOT EXISTS (SELECT 1 FROM card_catalog WHERE country = 'CN' AND bank_name = '工商银行' AND card_name = '宇宙星座卡普卡校园版·双鱼座');
UPDATE card_catalog SET image_url = CASE WHEN image_url IS NULL OR image_url LIKE '/images/cards/cardentify/%' THEN '/images/cards/cardentify/7f01bcf3af8d-e25743c4c8e2-4089df03.jpg' ELSE image_url END, network = COALESCE(network, 'UnionPay'), tags = COALESCE(tags, 'Cardentify,信用卡,来源:Apple Pay,BIN:625249'), notes = COALESCE(notes, 'Cardentify import; original bank: 中国工商银行; type: Credit; source: Apple Pay') WHERE country = 'CN' AND bank_name = '工商银行' AND card_name = '宇宙星座卡普卡校园版·双鱼座';

INSERT INTO card_catalog (country, bank_name, card_name, card_tier, network, tags, image_url, variants, annual_fee_cny, notes)
SELECT 'CN', '工商银行', '工银理财金账户卡(黑卡)', '白金卡', 'UnionPay', 'Cardentify,借记卡,来源:云闪付,BIN:621288', '/images/cards/cardentify/7f01bcf3af8d-d4d00df13a3b-f3efd51d.jpg', NULL, NULL, 'Cardentify import; original bank: 中国工商银行; type: Debit; source: 云闪付'
WHERE NOT EXISTS (SELECT 1 FROM card_catalog WHERE country = 'CN' AND bank_name = '工商银行' AND card_name = '工银理财金账户卡(黑卡)');
UPDATE card_catalog SET image_url = CASE WHEN image_url IS NULL OR image_url LIKE '/images/cards/cardentify/%' THEN '/images/cards/cardentify/7f01bcf3af8d-d4d00df13a3b-f3efd51d.jpg' ELSE image_url END, network = COALESCE(network, 'UnionPay'), tags = COALESCE(tags, 'Cardentify,借记卡,来源:云闪付,BIN:621288'), notes = COALESCE(notes, 'Cardentify import; original bank: 中国工商银行; type: Debit; source: 云闪付') WHERE country = 'CN' AND bank_name = '工商银行' AND card_name = '工银理财金账户卡(黑卡)';

INSERT INTO card_catalog (country, bank_name, card_name, card_tier, network, tags, image_url, variants, annual_fee_cny, notes)
SELECT 'CN', '工商银行', '华南师范大学建校90周年联名卡', '普卡', 'UnionPay', 'Cardentify,借记卡,来源:云闪付', '/images/cards/cardentify/7f01bcf3af8d-90-82de74b4.jpg', NULL, NULL, 'Cardentify import; original bank: 中国工商银行; type: Debit; source: 云闪付'
WHERE NOT EXISTS (SELECT 1 FROM card_catalog WHERE country = 'CN' AND bank_name = '工商银行' AND card_name = '华南师范大学建校90周年联名卡');
UPDATE card_catalog SET image_url = CASE WHEN image_url IS NULL OR image_url LIKE '/images/cards/cardentify/%' THEN '/images/cards/cardentify/7f01bcf3af8d-90-82de74b4.jpg' ELSE image_url END, network = COALESCE(network, 'UnionPay'), tags = COALESCE(tags, 'Cardentify,借记卡,来源:云闪付'), notes = COALESCE(notes, 'Cardentify import; original bank: 中国工商银行; type: Debit; source: 云闪付') WHERE country = 'CN' AND bank_name = '工商银行' AND card_name = '华南师范大学建校90周年联名卡';

INSERT INTO card_catalog (country, bank_name, card_name, card_tier, network, tags, image_url, variants, annual_fee_cny, notes)
SELECT 'CN', '工商银行', '北京航空航天大学联名借记卡', '普卡', 'UnionPay', 'Cardentify,借记卡,来源:云闪付', '/images/cards/cardentify/7f01bcf3af8d-625489b118e2-cf550e3f.jpg', NULL, NULL, 'Cardentify import; original bank: 中国工商银行; type: Debit; source: 云闪付'
WHERE NOT EXISTS (SELECT 1 FROM card_catalog WHERE country = 'CN' AND bank_name = '工商银行' AND card_name = '北京航空航天大学联名借记卡');
UPDATE card_catalog SET image_url = CASE WHEN image_url IS NULL OR image_url LIKE '/images/cards/cardentify/%' THEN '/images/cards/cardentify/7f01bcf3af8d-625489b118e2-cf550e3f.jpg' ELSE image_url END, network = COALESCE(network, 'UnionPay'), tags = COALESCE(tags, 'Cardentify,借记卡,来源:云闪付'), notes = COALESCE(notes, 'Cardentify import; original bank: 中国工商银行; type: Debit; source: 云闪付') WHERE country = 'CN' AND bank_name = '工商银行' AND card_name = '北京航空航天大学联名借记卡';

INSERT INTO card_catalog (country, bank_name, card_name, card_tier, network, tags, image_url, variants, annual_fee_cny, notes)
SELECT 'CN', '工商银行', '工银香港科技大学（广州）', '普卡', 'UnionPay', 'Cardentify,借记卡,来源:云闪付', '/images/cards/cardentify/7f01bcf3af8d-cc70cfd08c0f-be87ea39.jpg', NULL, NULL, 'Cardentify import; original bank: 中国工商银行; type: Debit; source: 云闪付'
WHERE NOT EXISTS (SELECT 1 FROM card_catalog WHERE country = 'CN' AND bank_name = '工商银行' AND card_name = '工银香港科技大学（广州）');
UPDATE card_catalog SET image_url = CASE WHEN image_url IS NULL OR image_url LIKE '/images/cards/cardentify/%' THEN '/images/cards/cardentify/7f01bcf3af8d-cc70cfd08c0f-be87ea39.jpg' ELSE image_url END, network = COALESCE(network, 'UnionPay'), tags = COALESCE(tags, 'Cardentify,借记卡,来源:云闪付'), notes = COALESCE(notes, 'Cardentify import; original bank: 中国工商银行; type: Debit; source: 云闪付') WHERE country = 'CN' AND bank_name = '工商银行' AND card_name = '工银香港科技大学（广州）';

INSERT INTO card_catalog (country, bank_name, card_name, card_tier, network, tags, image_url, variants, annual_fee_cny, notes)
SELECT 'CN', '工商银行', '灵通账户', '普卡', 'UnionPay', 'Cardentify,借记卡,来源:云闪付', '/images/cards/cardentify/7f01bcf3af8d-237e6bcc087e-8dee2331.jpg', NULL, NULL, 'Cardentify import; original bank: 中国工商银行; type: Debit; source: 云闪付'
WHERE NOT EXISTS (SELECT 1 FROM card_catalog WHERE country = 'CN' AND bank_name = '工商银行' AND card_name = '灵通账户');
UPDATE card_catalog SET image_url = CASE WHEN image_url IS NULL OR image_url LIKE '/images/cards/cardentify/%' THEN '/images/cards/cardentify/7f01bcf3af8d-237e6bcc087e-8dee2331.jpg' ELSE image_url END, network = COALESCE(network, 'UnionPay'), tags = COALESCE(tags, 'Cardentify,借记卡,来源:云闪付'), notes = COALESCE(notes, 'Cardentify import; original bank: 中国工商银行; type: Debit; source: 云闪付') WHERE country = 'CN' AND bank_name = '工商银行' AND card_name = '灵通账户';

INSERT INTO card_catalog (country, bank_name, card_name, card_tier, network, tags, image_url, variants, annual_fee_cny, notes)
SELECT 'CN', '工商银行', '四川熊猫借记卡b', '普卡', 'UnionPay', 'Cardentify,借记卡,来源:云闪付', '/images/cards/cardentify/7f01bcf3af8d-b-e6a2f519.jpg', NULL, NULL, 'Cardentify import; original bank: 中国工商银行; type: Debit; source: 云闪付'
WHERE NOT EXISTS (SELECT 1 FROM card_catalog WHERE country = 'CN' AND bank_name = '工商银行' AND card_name = '四川熊猫借记卡b');
UPDATE card_catalog SET image_url = CASE WHEN image_url IS NULL OR image_url LIKE '/images/cards/cardentify/%' THEN '/images/cards/cardentify/7f01bcf3af8d-b-e6a2f519.jpg' ELSE image_url END, network = COALESCE(network, 'UnionPay'), tags = COALESCE(tags, 'Cardentify,借记卡,来源:云闪付'), notes = COALESCE(notes, 'Cardentify import; original bank: 中国工商银行; type: Debit; source: 云闪付') WHERE country = 'CN' AND bank_name = '工商银行' AND card_name = '四川熊猫借记卡b';

INSERT INTO card_catalog (country, bank_name, card_name, card_tier, network, tags, image_url, variants, annual_fee_cny, notes)
SELECT 'CN', '工商银行', '故宫联名追梦借记卡', '普卡', 'UnionPay', 'Cardentify,借记卡,来源:云闪付', '/images/cards/cardentify/7f01bcf3af8d-397a3c99c1cf-d97d53e2.jpg', NULL, NULL, 'Cardentify import; original bank: 中国工商银行; type: Debit; source: 云闪付'
WHERE NOT EXISTS (SELECT 1 FROM card_catalog WHERE country = 'CN' AND bank_name = '工商银行' AND card_name = '故宫联名追梦借记卡');
UPDATE card_catalog SET image_url = CASE WHEN image_url IS NULL OR image_url LIKE '/images/cards/cardentify/%' THEN '/images/cards/cardentify/7f01bcf3af8d-397a3c99c1cf-d97d53e2.jpg' ELSE image_url END, network = COALESCE(network, 'UnionPay'), tags = COALESCE(tags, 'Cardentify,借记卡,来源:云闪付'), notes = COALESCE(notes, 'Cardentify import; original bank: 中国工商银行; type: Debit; source: 云闪付') WHERE country = 'CN' AND bank_name = '工商银行' AND card_name = '故宫联名追梦借记卡';

INSERT INTO card_catalog (country, bank_name, card_name, card_tier, network, tags, image_url, variants, annual_fee_cny, notes)
SELECT 'CN', '工商银行', '故宫600年联名星耀八方卡', '普卡', 'UnionPay', 'Cardentify,借记卡,来源:云闪付', '/images/cards/cardentify/7f01bcf3af8d-600-77760d22.jpg', NULL, NULL, 'Cardentify import; original bank: 中国工商银行; type: Debit; source: 云闪付'
WHERE NOT EXISTS (SELECT 1 FROM card_catalog WHERE country = 'CN' AND bank_name = '工商银行' AND card_name = '故宫600年联名星耀八方卡');
UPDATE card_catalog SET image_url = CASE WHEN image_url IS NULL OR image_url LIKE '/images/cards/cardentify/%' THEN '/images/cards/cardentify/7f01bcf3af8d-600-77760d22.jpg' ELSE image_url END, network = COALESCE(network, 'UnionPay'), tags = COALESCE(tags, 'Cardentify,借记卡,来源:云闪付'), notes = COALESCE(notes, 'Cardentify import; original bank: 中国工商银行; type: Debit; source: 云闪付') WHERE country = 'CN' AND bank_name = '工商银行' AND card_name = '故宫600年联名星耀八方卡';

INSERT INTO card_catalog (country, bank_name, card_name, card_tier, network, tags, image_url, variants, annual_fee_cny, notes)
SELECT 'CN', '工商银行', '新市民主题卡', '普卡', 'UnionPay', 'Cardentify,借记卡,来源:云闪付', '/images/cards/cardentify/7f01bcf3af8d-adefa08390a8-9842f502.jpg', NULL, NULL, 'Cardentify import; original bank: 中国工商银行; type: Debit; source: 云闪付'
WHERE NOT EXISTS (SELECT 1 FROM card_catalog WHERE country = 'CN' AND bank_name = '工商银行' AND card_name = '新市民主题卡');
UPDATE card_catalog SET image_url = CASE WHEN image_url IS NULL OR image_url LIKE '/images/cards/cardentify/%' THEN '/images/cards/cardentify/7f01bcf3af8d-adefa08390a8-9842f502.jpg' ELSE image_url END, network = COALESCE(network, 'UnionPay'), tags = COALESCE(tags, 'Cardentify,借记卡,来源:云闪付'), notes = COALESCE(notes, 'Cardentify import; original bank: 中国工商银行; type: Debit; source: 云闪付') WHERE country = 'CN' AND bank_name = '工商银行' AND card_name = '新市民主题卡';

INSERT INTO card_catalog (country, bank_name, card_name, card_tier, network, tags, image_url, variants, annual_fee_cny, notes)
SELECT 'CN', '工商银行', '新锐主题借记卡', '普卡', 'UnionPay', 'Cardentify,借记卡,来源:云闪付', '/images/cards/cardentify/7f01bcf3af8d-a4a605e38973-cae5eaf7.jpg', NULL, NULL, 'Cardentify import; original bank: 中国工商银行; type: Debit; source: 云闪付'
WHERE NOT EXISTS (SELECT 1 FROM card_catalog WHERE country = 'CN' AND bank_name = '工商银行' AND card_name = '新锐主题借记卡');
UPDATE card_catalog SET image_url = CASE WHEN image_url IS NULL OR image_url LIKE '/images/cards/cardentify/%' THEN '/images/cards/cardentify/7f01bcf3af8d-a4a605e38973-cae5eaf7.jpg' ELSE image_url END, network = COALESCE(network, 'UnionPay'), tags = COALESCE(tags, 'Cardentify,借记卡,来源:云闪付'), notes = COALESCE(notes, 'Cardentify import; original bank: 中国工商银行; type: Debit; source: 云闪付') WHERE country = 'CN' AND bank_name = '工商银行' AND card_name = '新锐主题借记卡';

INSERT INTO card_catalog (country, bank_name, card_name, card_tier, network, tags, image_url, variants, annual_fee_cny, notes)
SELECT 'CN', '工商银行', '理财金卡', '金卡', 'UnionPay', 'Cardentify,借记卡,来源:云闪付', '/images/cards/cardentify/7f01bcf3af8d-4075fc79c12c-f8a5732f.jpg', NULL, NULL, 'Cardentify import; original bank: 中国工商银行; type: Debit; source: 云闪付'
WHERE NOT EXISTS (SELECT 1 FROM card_catalog WHERE country = 'CN' AND bank_name = '工商银行' AND card_name = '理财金卡');
UPDATE card_catalog SET image_url = CASE WHEN image_url IS NULL OR image_url LIKE '/images/cards/cardentify/%' THEN '/images/cards/cardentify/7f01bcf3af8d-4075fc79c12c-f8a5732f.jpg' ELSE image_url END, network = COALESCE(network, 'UnionPay'), tags = COALESCE(tags, 'Cardentify,借记卡,来源:云闪付'), notes = COALESCE(notes, 'Cardentify import; original bank: 中国工商银行; type: Debit; source: 云闪付') WHERE country = 'CN' AND bank_name = '工商银行' AND card_name = '理财金卡';

INSERT INTO card_catalog (country, bank_name, card_name, card_tier, network, tags, image_url, variants, annual_fee_cny, notes)
SELECT 'CN', '工商银行', '旅游卡', '普卡', 'UnionPay', 'Cardentify,借记卡,来源:云闪付', '/images/cards/cardentify/7f01bcf3af8d-943239483aa1-500e6667.jpg', NULL, NULL, 'Cardentify import; original bank: 中国工商银行; type: Debit; source: 云闪付'
WHERE NOT EXISTS (SELECT 1 FROM card_catalog WHERE country = 'CN' AND bank_name = '工商银行' AND card_name = '旅游卡');
UPDATE card_catalog SET image_url = CASE WHEN image_url IS NULL OR image_url LIKE '/images/cards/cardentify/%' THEN '/images/cards/cardentify/7f01bcf3af8d-943239483aa1-500e6667.jpg' ELSE image_url END, network = COALESCE(network, 'UnionPay'), tags = COALESCE(tags, 'Cardentify,借记卡,来源:云闪付'), notes = COALESCE(notes, 'Cardentify import; original bank: 中国工商银行; type: Debit; source: 云闪付') WHERE country = 'CN' AND bank_name = '工商银行' AND card_name = '旅游卡';

INSERT INTO card_catalog (country, bank_name, card_name, card_tier, network, tags, image_url, variants, annual_fee_cny, notes)
SELECT 'CN', '工商银行', '如意卡', '普卡', 'UnionPay', 'Cardentify,借记卡,来源:云闪付', '/images/cards/cardentify/7f01bcf3af8d-8dbe60687739-72a6093b.jpg', NULL, NULL, 'Cardentify import; original bank: 中国工商银行; type: Debit; source: 云闪付'
WHERE NOT EXISTS (SELECT 1 FROM card_catalog WHERE country = 'CN' AND bank_name = '工商银行' AND card_name = '如意卡');
UPDATE card_catalog SET image_url = CASE WHEN image_url IS NULL OR image_url LIKE '/images/cards/cardentify/%' THEN '/images/cards/cardentify/7f01bcf3af8d-8dbe60687739-72a6093b.jpg' ELSE image_url END, network = COALESCE(network, 'UnionPay'), tags = COALESCE(tags, 'Cardentify,借记卡,来源:云闪付'), notes = COALESCE(notes, 'Cardentify import; original bank: 中国工商银行; type: Debit; source: 云闪付') WHERE country = 'CN' AND bank_name = '工商银行' AND card_name = '如意卡';

INSERT INTO card_catalog (country, bank_name, card_name, card_tier, network, tags, image_url, variants, annual_fee_cny, notes)
SELECT 'CN', '工商银行', '上海华东师范大学联名卡', '普卡', 'UnionPay', 'Cardentify,借记卡,来源:云闪付', '/images/cards/cardentify/7f01bcf3af8d-909067214079-31724f1c.jpg', NULL, NULL, 'Cardentify import; original bank: 中国工商银行; type: Debit; source: 云闪付'
WHERE NOT EXISTS (SELECT 1 FROM card_catalog WHERE country = 'CN' AND bank_name = '工商银行' AND card_name = '上海华东师范大学联名卡');
UPDATE card_catalog SET image_url = CASE WHEN image_url IS NULL OR image_url LIKE '/images/cards/cardentify/%' THEN '/images/cards/cardentify/7f01bcf3af8d-909067214079-31724f1c.jpg' ELSE image_url END, network = COALESCE(network, 'UnionPay'), tags = COALESCE(tags, 'Cardentify,借记卡,来源:云闪付'), notes = COALESCE(notes, 'Cardentify import; original bank: 中国工商银行; type: Debit; source: 云闪付') WHERE country = 'CN' AND bank_name = '工商银行' AND card_name = '上海华东师范大学联名卡';

INSERT INTO card_catalog (country, bank_name, card_name, card_tier, network, tags, image_url, variants, annual_fee_cny, notes)
SELECT 'CN', '工商银行', '龙年生肖卡（飞龙在天）', '普卡', 'UnionPay', 'Cardentify,借记卡,来源:云闪付', '/images/cards/cardentify/7f01bcf3af8d-b3f2315fb9c0-2863fd23.jpg', NULL, NULL, 'Cardentify import; original bank: 中国工商银行; type: Debit; source: 云闪付'
WHERE NOT EXISTS (SELECT 1 FROM card_catalog WHERE country = 'CN' AND bank_name = '工商银行' AND card_name = '龙年生肖卡（飞龙在天）');
UPDATE card_catalog SET image_url = CASE WHEN image_url IS NULL OR image_url LIKE '/images/cards/cardentify/%' THEN '/images/cards/cardentify/7f01bcf3af8d-b3f2315fb9c0-2863fd23.jpg' ELSE image_url END, network = COALESCE(network, 'UnionPay'), tags = COALESCE(tags, 'Cardentify,借记卡,来源:云闪付'), notes = COALESCE(notes, 'Cardentify import; original bank: 中国工商银行; type: Debit; source: 云闪付') WHERE country = 'CN' AND bank_name = '工商银行' AND card_name = '龙年生肖卡（飞龙在天）';

INSERT INTO card_catalog (country, bank_name, card_name, card_tier, network, tags, image_url, variants, annual_fee_cny, notes)
SELECT 'CN', '工商银行', 'i小宇主题借记卡低碳版', '普卡', 'UnionPay', 'Cardentify,借记卡,来源:云闪付', '/images/cards/cardentify/7f01bcf3af8d-i-43352230.jpg', NULL, NULL, 'Cardentify import; original bank: 中国工商银行; type: Debit; source: 云闪付'
WHERE NOT EXISTS (SELECT 1 FROM card_catalog WHERE country = 'CN' AND bank_name = '工商银行' AND card_name = 'i小宇主题借记卡低碳版');
UPDATE card_catalog SET image_url = CASE WHEN image_url IS NULL OR image_url LIKE '/images/cards/cardentify/%' THEN '/images/cards/cardentify/7f01bcf3af8d-i-43352230.jpg' ELSE image_url END, network = COALESCE(network, 'UnionPay'), tags = COALESCE(tags, 'Cardentify,借记卡,来源:云闪付'), notes = COALESCE(notes, 'Cardentify import; original bank: 中国工商银行; type: Debit; source: 云闪付') WHERE country = 'CN' AND bank_name = '工商银行' AND card_name = 'i小宇主题借记卡低碳版';

INSERT INTO card_catalog (country, bank_name, card_name, card_tier, network, tags, image_url, variants, annual_fee_cny, notes)
SELECT 'CN', '工商银行', 'i小宇主题借记卡未来版', '普卡', 'UnionPay', 'Cardentify,借记卡,来源:云闪付', '/images/cards/cardentify/7f01bcf3af8d-i-f1a6e24f.jpg', NULL, NULL, 'Cardentify import; original bank: 中国工商银行; type: Debit; source: 云闪付'
WHERE NOT EXISTS (SELECT 1 FROM card_catalog WHERE country = 'CN' AND bank_name = '工商银行' AND card_name = 'i小宇主题借记卡未来版');
UPDATE card_catalog SET image_url = CASE WHEN image_url IS NULL OR image_url LIKE '/images/cards/cardentify/%' THEN '/images/cards/cardentify/7f01bcf3af8d-i-f1a6e24f.jpg' ELSE image_url END, network = COALESCE(network, 'UnionPay'), tags = COALESCE(tags, 'Cardentify,借记卡,来源:云闪付'), notes = COALESCE(notes, 'Cardentify import; original bank: 中国工商银行; type: Debit; source: 云闪付') WHERE country = 'CN' AND bank_name = '工商银行' AND card_name = 'i小宇主题借记卡未来版';

INSERT INTO card_catalog (country, bank_name, card_name, card_tier, network, tags, image_url, variants, annual_fee_cny, notes)
SELECT 'CN', '工商银行', '工银商友卡', '普卡', 'UnionPay', 'Cardentify,借记卡,来源:云闪付', '/images/cards/cardentify/7f01bcf3af8d-4a1c3e1f76d4-48409245.jpg', NULL, NULL, 'Cardentify import; original bank: 中国工商银行; type: Debit; source: 云闪付'
WHERE NOT EXISTS (SELECT 1 FROM card_catalog WHERE country = 'CN' AND bank_name = '工商银行' AND card_name = '工银商友卡');
UPDATE card_catalog SET image_url = CASE WHEN image_url IS NULL OR image_url LIKE '/images/cards/cardentify/%' THEN '/images/cards/cardentify/7f01bcf3af8d-4a1c3e1f76d4-48409245.jpg' ELSE image_url END, network = COALESCE(network, 'UnionPay'), tags = COALESCE(tags, 'Cardentify,借记卡,来源:云闪付'), notes = COALESCE(notes, 'Cardentify import; original bank: 中国工商银行; type: Debit; source: 云闪付') WHERE country = 'CN' AND bank_name = '工商银行' AND card_name = '工银商友卡';

INSERT INTO card_catalog (country, bank_name, card_name, card_tier, network, tags, image_url, variants, annual_fee_cny, notes)
SELECT 'CN', '工商银行', '吉祥凤凰借记卡', '普卡', 'UnionPay', 'Cardentify,借记卡,来源:云闪付', '/images/cards/cardentify/7f01bcf3af8d-663f15393e31-4e484fba.jpg', NULL, NULL, 'Cardentify import; original bank: 中国工商银行; type: Debit; source: 云闪付'
WHERE NOT EXISTS (SELECT 1 FROM card_catalog WHERE country = 'CN' AND bank_name = '工商银行' AND card_name = '吉祥凤凰借记卡');
UPDATE card_catalog SET image_url = CASE WHEN image_url IS NULL OR image_url LIKE '/images/cards/cardentify/%' THEN '/images/cards/cardentify/7f01bcf3af8d-663f15393e31-4e484fba.jpg' ELSE image_url END, network = COALESCE(network, 'UnionPay'), tags = COALESCE(tags, 'Cardentify,借记卡,来源:云闪付'), notes = COALESCE(notes, 'Cardentify import; original bank: 中国工商银行; type: Debit; source: 云闪付') WHERE country = 'CN' AND bank_name = '工商银行' AND card_name = '吉祥凤凰借记卡';

INSERT INTO card_catalog (country, bank_name, card_name, card_tier, network, tags, image_url, variants, annual_fee_cny, notes)
SELECT 'CN', '工商银行', '虎年生肖借记卡', '普卡', 'UnionPay', 'Cardentify,借记卡,来源:云闪付', '/images/cards/cardentify/7f01bcf3af8d-a41cf28ea4eb-2c1dbeee.jpg', NULL, NULL, 'Cardentify import; original bank: 中国工商银行; type: Debit; source: 云闪付'
WHERE NOT EXISTS (SELECT 1 FROM card_catalog WHERE country = 'CN' AND bank_name = '工商银行' AND card_name = '虎年生肖借记卡');
UPDATE card_catalog SET image_url = CASE WHEN image_url IS NULL OR image_url LIKE '/images/cards/cardentify/%' THEN '/images/cards/cardentify/7f01bcf3af8d-a41cf28ea4eb-2c1dbeee.jpg' ELSE image_url END, network = COALESCE(network, 'UnionPay'), tags = COALESCE(tags, 'Cardentify,借记卡,来源:云闪付'), notes = COALESCE(notes, 'Cardentify import; original bank: 中国工商银行; type: Debit; source: 云闪付') WHERE country = 'CN' AND bank_name = '工商银行' AND card_name = '虎年生肖借记卡';

INSERT INTO card_catalog (country, bank_name, card_name, card_tier, network, tags, image_url, variants, annual_fee_cny, notes)
SELECT 'CN', '工商银行', '龙年生肖卡（玉龙戏珠）', '普卡', 'UnionPay', 'Cardentify,借记卡,来源:云闪付', '/images/cards/cardentify/7f01bcf3af8d-d8b219d4759a-7f869bc2.jpg', NULL, NULL, 'Cardentify import; original bank: 中国工商银行; type: Debit; source: 云闪付'
WHERE NOT EXISTS (SELECT 1 FROM card_catalog WHERE country = 'CN' AND bank_name = '工商银行' AND card_name = '龙年生肖卡（玉龙戏珠）');
UPDATE card_catalog SET image_url = CASE WHEN image_url IS NULL OR image_url LIKE '/images/cards/cardentify/%' THEN '/images/cards/cardentify/7f01bcf3af8d-d8b219d4759a-7f869bc2.jpg' ELSE image_url END, network = COALESCE(network, 'UnionPay'), tags = COALESCE(tags, 'Cardentify,借记卡,来源:云闪付'), notes = COALESCE(notes, 'Cardentify import; original bank: 中国工商银行; type: Debit; source: 云闪付') WHERE country = 'CN' AND bank_name = '工商银行' AND card_name = '龙年生肖卡（玉龙戏珠）';

INSERT INTO card_catalog (country, bank_name, card_name, card_tier, network, tags, image_url, variants, annual_fee_cny, notes)
SELECT 'CN', '工商银行', '兔年生肖主题借记卡', '普卡', 'UnionPay', 'Cardentify,借记卡,来源:云闪付', '/images/cards/cardentify/7f01bcf3af8d-0b4730fbf0c4-d1b97134.jpg', NULL, NULL, 'Cardentify import; original bank: 中国工商银行; type: Debit; source: 云闪付'
WHERE NOT EXISTS (SELECT 1 FROM card_catalog WHERE country = 'CN' AND bank_name = '工商银行' AND card_name = '兔年生肖主题借记卡');
UPDATE card_catalog SET image_url = CASE WHEN image_url IS NULL OR image_url LIKE '/images/cards/cardentify/%' THEN '/images/cards/cardentify/7f01bcf3af8d-0b4730fbf0c4-d1b97134.jpg' ELSE image_url END, network = COALESCE(network, 'UnionPay'), tags = COALESCE(tags, 'Cardentify,借记卡,来源:云闪付'), notes = COALESCE(notes, 'Cardentify import; original bank: 中国工商银行; type: Debit; source: 云闪付') WHERE country = 'CN' AND bank_name = '工商银行' AND card_name = '兔年生肖主题借记卡';

INSERT INTO card_catalog (country, bank_name, card_name, card_tier, network, tags, image_url, variants, annual_fee_cny, notes)
SELECT 'CN', '工商银行', '北京环球度假区联名卡1', '普卡', 'UnionPay', 'Cardentify,借记卡,来源:云闪付', '/images/cards/cardentify/7f01bcf3af8d-1-05230fd0.jpg', NULL, NULL, 'Cardentify import; original bank: 中国工商银行; type: Debit; source: 云闪付'
WHERE NOT EXISTS (SELECT 1 FROM card_catalog WHERE country = 'CN' AND bank_name = '工商银行' AND card_name = '北京环球度假区联名卡1');
UPDATE card_catalog SET image_url = CASE WHEN image_url IS NULL OR image_url LIKE '/images/cards/cardentify/%' THEN '/images/cards/cardentify/7f01bcf3af8d-1-05230fd0.jpg' ELSE image_url END, network = COALESCE(network, 'UnionPay'), tags = COALESCE(tags, 'Cardentify,借记卡,来源:云闪付'), notes = COALESCE(notes, 'Cardentify import; original bank: 中国工商银行; type: Debit; source: 云闪付') WHERE country = 'CN' AND bank_name = '工商银行' AND card_name = '北京环球度假区联名卡1';

INSERT INTO card_catalog (country, bank_name, card_name, card_tier, network, tags, image_url, variants, annual_fee_cny, notes)
SELECT 'CN', '工商银行', '北京环球度假区联名卡2', '普卡', 'UnionPay', 'Cardentify,借记卡,来源:云闪付', '/images/cards/cardentify/7f01bcf3af8d-2-9b1fe3c1.jpg', NULL, NULL, 'Cardentify import; original bank: 中国工商银行; type: Debit; source: 云闪付'
WHERE NOT EXISTS (SELECT 1 FROM card_catalog WHERE country = 'CN' AND bank_name = '工商银行' AND card_name = '北京环球度假区联名卡2');
UPDATE card_catalog SET image_url = CASE WHEN image_url IS NULL OR image_url LIKE '/images/cards/cardentify/%' THEN '/images/cards/cardentify/7f01bcf3af8d-2-9b1fe3c1.jpg' ELSE image_url END, network = COALESCE(network, 'UnionPay'), tags = COALESCE(tags, 'Cardentify,借记卡,来源:云闪付'), notes = COALESCE(notes, 'Cardentify import; original bank: 中国工商银行; type: Debit; source: 云闪付') WHERE country = 'CN' AND bank_name = '工商银行' AND card_name = '北京环球度假区联名卡2';

INSERT INTO card_catalog (country, bank_name, card_name, card_tier, network, tags, image_url, variants, annual_fee_cny, notes)
SELECT 'CN', '工商银行', '聚财卡尊享版', '普卡', 'UnionPay', 'Cardentify,借记卡,来源:云闪付', '/images/cards/cardentify/7f01bcf3af8d-b3b17bde3275-c524e7c1.jpg', NULL, NULL, 'Cardentify import; original bank: 中国工商银行; type: Debit; source: 云闪付'
WHERE NOT EXISTS (SELECT 1 FROM card_catalog WHERE country = 'CN' AND bank_name = '工商银行' AND card_name = '聚财卡尊享版');
UPDATE card_catalog SET image_url = CASE WHEN image_url IS NULL OR image_url LIKE '/images/cards/cardentify/%' THEN '/images/cards/cardentify/7f01bcf3af8d-b3b17bde3275-c524e7c1.jpg' ELSE image_url END, network = COALESCE(network, 'UnionPay'), tags = COALESCE(tags, 'Cardentify,借记卡,来源:云闪付'), notes = COALESCE(notes, 'Cardentify import; original bank: 中国工商银行; type: Debit; source: 云闪付') WHERE country = 'CN' AND bank_name = '工商银行' AND card_name = '聚财卡尊享版';

INSERT INTO card_catalog (country, bank_name, card_name, card_tier, network, tags, image_url, variants, annual_fee_cny, notes)
SELECT 'CN', '工商银行', '工银薪金卡', '普卡', 'UnionPay', 'Cardentify,借记卡,来源:云闪付', '/images/cards/cardentify/7f01bcf3af8d-c7776fc1b372-66f7d5f4.jpg', NULL, NULL, 'Cardentify import; original bank: 中国工商银行; type: Debit; source: 云闪付'
WHERE NOT EXISTS (SELECT 1 FROM card_catalog WHERE country = 'CN' AND bank_name = '工商银行' AND card_name = '工银薪金卡');
UPDATE card_catalog SET image_url = CASE WHEN image_url IS NULL OR image_url LIKE '/images/cards/cardentify/%' THEN '/images/cards/cardentify/7f01bcf3af8d-c7776fc1b372-66f7d5f4.jpg' ELSE image_url END, network = COALESCE(network, 'UnionPay'), tags = COALESCE(tags, 'Cardentify,借记卡,来源:云闪付'), notes = COALESCE(notes, 'Cardentify import; original bank: 中国工商银行; type: Debit; source: 云闪付') WHERE country = 'CN' AND bank_name = '工商银行' AND card_name = '工银薪金卡';

INSERT INTO card_catalog (country, bank_name, card_name, card_tier, network, tags, image_url, variants, annual_fee_cny, notes)
SELECT 'CN', '工商银行', '工银财富卡', '白金卡', 'UnionPay', 'Cardentify,借记卡,来源:云闪付', '/images/cards/cardentify/7f01bcf3af8d-0f0e824cebad-3b5d05f0.jpg', NULL, NULL, 'Cardentify import; original bank: 中国工商银行; type: Debit; source: 云闪付'
WHERE NOT EXISTS (SELECT 1 FROM card_catalog WHERE country = 'CN' AND bank_name = '工商银行' AND card_name = '工银财富卡');
UPDATE card_catalog SET image_url = CASE WHEN image_url IS NULL OR image_url LIKE '/images/cards/cardentify/%' THEN '/images/cards/cardentify/7f01bcf3af8d-0f0e824cebad-3b5d05f0.jpg' ELSE image_url END, network = COALESCE(network, 'UnionPay'), tags = COALESCE(tags, 'Cardentify,借记卡,来源:云闪付'), notes = COALESCE(notes, 'Cardentify import; original bank: 中国工商银行; type: Debit; source: 云闪付') WHERE country = 'CN' AND bank_name = '工商银行' AND card_name = '工银财富卡';

INSERT INTO card_catalog (country, bank_name, card_name, card_tier, network, tags, image_url, variants, annual_fee_cny, notes)
SELECT 'HK', '中國工商銀行（亞洲）', 'ICBC SUP UnionPay Dual Currency Diamond Card', '钻石卡', 'UnionPay', 'Cardentify,信用卡,来源:Apple Pay,BIN:625801', '/images/cards/cardentify/882d35ec4bec-icbc-sup-unionpay-dual-currency-diamond-card-9a153c11.jpg', NULL, NULL, 'Cardentify import; original bank: 中國工商銀行（亞洲）; type: Credit; source: Apple Pay'
WHERE NOT EXISTS (SELECT 1 FROM card_catalog WHERE country = 'HK' AND bank_name = '中國工商銀行（亞洲）' AND card_name = 'ICBC SUP UnionPay Dual Currency Diamond Card');
UPDATE card_catalog SET image_url = CASE WHEN image_url IS NULL OR image_url LIKE '/images/cards/cardentify/%' THEN '/images/cards/cardentify/882d35ec4bec-icbc-sup-unionpay-dual-currency-diamond-card-9a153c11.jpg' ELSE image_url END, network = COALESCE(network, 'UnionPay'), tags = COALESCE(tags, 'Cardentify,信用卡,来源:Apple Pay,BIN:625801'), notes = COALESCE(notes, 'Cardentify import; original bank: 中國工商銀行（亞洲）; type: Credit; source: Apple Pay') WHERE country = 'HK' AND bank_name = '中國工商銀行（亞洲）' AND card_name = 'ICBC SUP UnionPay Dual Currency Diamond Card';

INSERT INTO card_catalog (country, bank_name, card_name, card_tier, network, tags, image_url, variants, annual_fee_cny, notes)
SELECT 'HK', '中國工商銀行（亞洲）', 'ICBC Horoscope Visa Signature Card', '御玺卡', 'VISA', 'Cardentify,信用卡,来源:Apple Pay,BIN:454327', '/images/cards/cardentify/882d35ec4bec-icbc-horoscope-visa-signature-card-8fc49392.jpg', NULL, NULL, 'Cardentify import; original bank: 中國工商銀行（亞洲）; type: Credit; source: Apple Pay'
WHERE NOT EXISTS (SELECT 1 FROM card_catalog WHERE country = 'HK' AND bank_name = '中國工商銀行（亞洲）' AND card_name = 'ICBC Horoscope Visa Signature Card');
UPDATE card_catalog SET image_url = CASE WHEN image_url IS NULL OR image_url LIKE '/images/cards/cardentify/%' THEN '/images/cards/cardentify/882d35ec4bec-icbc-horoscope-visa-signature-card-8fc49392.jpg' ELSE image_url END, network = COALESCE(network, 'VISA'), tags = COALESCE(tags, 'Cardentify,信用卡,来源:Apple Pay,BIN:454327'), notes = COALESCE(notes, 'Cardentify import; original bank: 中國工商銀行（亞洲）; type: Credit; source: Apple Pay') WHERE country = 'HK' AND bank_name = '中國工商銀行（亞洲）' AND card_name = 'ICBC Horoscope Visa Signature Card';

INSERT INTO card_catalog (country, bank_name, card_name, card_tier, network, tags, image_url, variants, annual_fee_cny, notes)
SELECT 'JP', 'JCBクレジットカード', 'シナジーJCBカード', '普卡', 'JCB', 'Cardentify,信用卡,来源:Apple Pay,BIN:354078', '/images/cards/cardentify/jcb-jcb-1ec1c180.svg', NULL, NULL, 'Cardentify import; original bank: JCBクレジットカード; type: Credit; source: Apple Pay'
WHERE NOT EXISTS (SELECT 1 FROM card_catalog WHERE country = 'JP' AND bank_name = 'JCBクレジットカード' AND card_name = 'シナジーJCBカード');
UPDATE card_catalog SET image_url = CASE WHEN image_url IS NULL OR image_url LIKE '/images/cards/cardentify/%' THEN '/images/cards/cardentify/jcb-jcb-1ec1c180.svg' ELSE image_url END, network = COALESCE(network, 'JCB'), tags = COALESCE(tags, 'Cardentify,信用卡,来源:Apple Pay,BIN:354078'), notes = COALESCE(notes, 'Cardentify import; original bank: JCBクレジットカード; type: Credit; source: Apple Pay') WHERE country = 'JP' AND bank_name = 'JCBクレジットカード' AND card_name = 'シナジーJCBカード';

INSERT INTO card_catalog (country, bank_name, card_name, card_tier, network, tags, image_url, variants, annual_fee_cny, notes)
SELECT 'JP', 'JCBクレジットカード', 'JCBカード W plus L (ORIGINAL SERIES)', '普卡', 'JCB', 'Cardentify,信用卡,来源:Apple Pay,BIN:358746', '/images/cards/cardentify/jcb-jcb-w-plus-l-original-series-d883dd58.svg', NULL, NULL, 'Cardentify import; original bank: JCBクレジットカード; type: Credit; source: Apple Pay'
WHERE NOT EXISTS (SELECT 1 FROM card_catalog WHERE country = 'JP' AND bank_name = 'JCBクレジットカード' AND card_name = 'JCBカード W plus L (ORIGINAL SERIES)');
UPDATE card_catalog SET image_url = CASE WHEN image_url IS NULL OR image_url LIKE '/images/cards/cardentify/%' THEN '/images/cards/cardentify/jcb-jcb-w-plus-l-original-series-d883dd58.svg' ELSE image_url END, network = COALESCE(network, 'JCB'), tags = COALESCE(tags, 'Cardentify,信用卡,来源:Apple Pay,BIN:358746'), notes = COALESCE(notes, 'Cardentify import; original bank: JCBクレジットカード; type: Credit; source: Apple Pay') WHERE country = 'JP' AND bank_name = 'JCBクレジットカード' AND card_name = 'JCBカード W plus L (ORIGINAL SERIES)';

INSERT INTO card_catalog (country, bank_name, card_name, card_tier, network, tags, image_url, variants, annual_fee_cny, notes)
SELECT 'JP', 'JCBクレジットカード', 'JCB GOLD (ORIGINAL SERIES)', '金卡', 'JCB', 'Cardentify,信用卡,来源:Apple Pay,BIN:354103', '/images/cards/cardentify/jcb-jcb-gold-original-series-78a88ab5.svg', NULL, NULL, 'Cardentify import; original bank: JCBクレジットカード; type: Credit; source: Apple Pay'
WHERE NOT EXISTS (SELECT 1 FROM card_catalog WHERE country = 'JP' AND bank_name = 'JCBクレジットカード' AND card_name = 'JCB GOLD (ORIGINAL SERIES)');
UPDATE card_catalog SET image_url = CASE WHEN image_url IS NULL OR image_url LIKE '/images/cards/cardentify/%' THEN '/images/cards/cardentify/jcb-jcb-gold-original-series-78a88ab5.svg' ELSE image_url END, network = COALESCE(network, 'JCB'), tags = COALESCE(tags, 'Cardentify,信用卡,来源:Apple Pay,BIN:354103'), notes = COALESCE(notes, 'Cardentify import; original bank: JCBクレジットカード; type: Credit; source: Apple Pay') WHERE country = 'JP' AND bank_name = 'JCBクレジットカード' AND card_name = 'JCB GOLD (ORIGINAL SERIES)';

INSERT INTO card_catalog (country, bank_name, card_name, card_tier, network, tags, image_url, variants, annual_fee_cny, notes)
SELECT 'CN', '京东金融', '京东闪付', '普卡', 'UnionPay', 'Cardentify,借记卡,来源:Apple Pay', '/images/cards/cardentify/3165bd480377-c54353593641-e8b7a45b.jpg', NULL, NULL, 'Cardentify import; original bank: 京东金融; type: Debit; source: Apple Pay'
WHERE NOT EXISTS (SELECT 1 FROM card_catalog WHERE country = 'CN' AND bank_name = '京东金融' AND card_name = '京东闪付');
UPDATE card_catalog SET image_url = CASE WHEN image_url IS NULL OR image_url LIKE '/images/cards/cardentify/%' THEN '/images/cards/cardentify/3165bd480377-c54353593641-e8b7a45b.jpg' ELSE image_url END, network = COALESCE(network, 'UnionPay'), tags = COALESCE(tags, 'Cardentify,借记卡,来源:Apple Pay'), notes = COALESCE(notes, 'Cardentify import; original bank: 京东金融; type: Debit; source: Apple Pay') WHERE country = 'CN' AND bank_name = '京东金融' AND card_name = '京东闪付';

INSERT INTO card_catalog (country, bank_name, card_name, card_tier, network, tags, image_url, variants, annual_fee_cny, notes)
SELECT 'TW', '兆豐銀行', '宇宙明星BT21信用卡', '御玺卡', 'VISA', 'Cardentify,信用卡,来源:Apple Pay,BIN:412698', '/images/cards/cardentify/4db0e8f9c5bf-bt21-bc328583.jpg', NULL, NULL, 'Cardentify import; original bank: 兆豐銀行; type: Credit; source: Apple Pay'
WHERE NOT EXISTS (SELECT 1 FROM card_catalog WHERE country = 'TW' AND bank_name = '兆豐銀行' AND card_name = '宇宙明星BT21信用卡');
UPDATE card_catalog SET image_url = CASE WHEN image_url IS NULL OR image_url LIKE '/images/cards/cardentify/%' THEN '/images/cards/cardentify/4db0e8f9c5bf-bt21-bc328583.jpg' ELSE image_url END, network = COALESCE(network, 'VISA'), tags = COALESCE(tags, 'Cardentify,信用卡,来源:Apple Pay,BIN:412698'), notes = COALESCE(notes, 'Cardentify import; original bank: 兆豐銀行; type: Credit; source: Apple Pay') WHERE country = 'TW' AND bank_name = '兆豐銀行' AND card_name = '宇宙明星BT21信用卡';

INSERT INTO card_catalog (country, bank_name, card_name, card_tier, network, tags, image_url, variants, annual_fee_cny, notes)
SELECT 'JP', 'みずほ銀行', 'みずほマイレージクラブ MasterCard', '普卡', 'Mastercard', 'Cardentify,信用卡,来源:Apple Pay,BIN:525036', '/images/cards/cardentify/6cb6ce54704c-mastercard-27669c2d.jpg', NULL, NULL, 'Cardentify import; original bank: みずほ銀行; type: Credit; source: Apple Pay'
WHERE NOT EXISTS (SELECT 1 FROM card_catalog WHERE country = 'JP' AND bank_name = 'みずほ銀行' AND card_name = 'みずほマイレージクラブ MasterCard');
UPDATE card_catalog SET image_url = CASE WHEN image_url IS NULL OR image_url LIKE '/images/cards/cardentify/%' THEN '/images/cards/cardentify/6cb6ce54704c-mastercard-27669c2d.jpg' ELSE image_url END, network = COALESCE(network, 'Mastercard'), tags = COALESCE(tags, 'Cardentify,信用卡,来源:Apple Pay,BIN:525036'), notes = COALESCE(notes, 'Cardentify import; original bank: みずほ銀行; type: Credit; source: Apple Pay') WHERE country = 'JP' AND bank_name = 'みずほ銀行' AND card_name = 'みずほマイレージクラブ MasterCard';

INSERT INTO card_catalog (country, bank_name, card_name, card_tier, network, tags, image_url, variants, annual_fee_cny, notes)
SELECT 'US', 'Morgan Stanley', 'Morgan Stanley CashPlus Debit Card', '世界卡', 'Mastercard', 'Cardentify,借记卡,来源:Apple Pay,BIN:552492', '/images/cards/cardentify/morgan-stanley-morgan-stanley-cashplus-debit-card-fb9e2674.jpg', NULL, NULL, 'Cardentify import; original bank: Morgan Stanley; type: Debit; source: Apple Pay'
WHERE NOT EXISTS (SELECT 1 FROM card_catalog WHERE country = 'US' AND bank_name = 'Morgan Stanley' AND card_name = 'Morgan Stanley CashPlus Debit Card');
UPDATE card_catalog SET image_url = CASE WHEN image_url IS NULL OR image_url LIKE '/images/cards/cardentify/%' THEN '/images/cards/cardentify/morgan-stanley-morgan-stanley-cashplus-debit-card-fb9e2674.jpg' ELSE image_url END, network = COALESCE(network, 'Mastercard'), tags = COALESCE(tags, 'Cardentify,借记卡,来源:Apple Pay,BIN:552492'), notes = COALESCE(notes, 'Cardentify import; original bank: Morgan Stanley; type: Debit; source: Apple Pay') WHERE country = 'US' AND bank_name = 'Morgan Stanley' AND card_name = 'Morgan Stanley CashPlus Debit Card';

INSERT INTO card_catalog (country, bank_name, card_name, card_tier, network, tags, image_url, variants, annual_fee_cny, notes)
SELECT 'US', 'Netspend', 'Netspend Prepaid Card', 'Prepaid', 'Mastercard', 'Cardentify,借记卡,来源:Apple Pay,BIN:529062', '/images/cards/cardentify/netspend-netspend-prepaid-card-d97b902d.jpg', NULL, NULL, 'Cardentify import; original bank: Netspend; type: Debit; source: Apple Pay'
WHERE NOT EXISTS (SELECT 1 FROM card_catalog WHERE country = 'US' AND bank_name = 'Netspend' AND card_name = 'Netspend Prepaid Card');
UPDATE card_catalog SET image_url = CASE WHEN image_url IS NULL OR image_url LIKE '/images/cards/cardentify/%' THEN '/images/cards/cardentify/netspend-netspend-prepaid-card-d97b902d.jpg' ELSE image_url END, network = COALESCE(network, 'Mastercard'), tags = COALESCE(tags, 'Cardentify,借记卡,来源:Apple Pay,BIN:529062'), notes = COALESCE(notes, 'Cardentify import; original bank: Netspend; type: Debit; source: Apple Pay') WHERE country = 'US' AND bank_name = 'Netspend' AND card_name = 'Netspend Prepaid Card';

INSERT INTO card_catalog (country, bank_name, card_name, card_tier, network, tags, image_url, variants, annual_fee_cny, notes)
SELECT 'HK', '八達通卡', 'Octopus Mastercard', 'Prepaid Platinum', 'Mastercard', 'Cardentify,借记卡,来源:Apple Pay,BIN:529006', '/images/cards/cardentify/32f3965647e0-octopus-mastercard-f8cf1ca2.jpg', NULL, NULL, 'Cardentify import; original bank: 八達通卡; type: Debit; source: Apple Pay'
WHERE NOT EXISTS (SELECT 1 FROM card_catalog WHERE country = 'HK' AND bank_name = '八達通卡' AND card_name = 'Octopus Mastercard');
UPDATE card_catalog SET image_url = CASE WHEN image_url IS NULL OR image_url LIKE '/images/cards/cardentify/%' THEN '/images/cards/cardentify/32f3965647e0-octopus-mastercard-f8cf1ca2.jpg' ELSE image_url END, network = COALESCE(network, 'Mastercard'), tags = COALESCE(tags, 'Cardentify,借记卡,来源:Apple Pay,BIN:529006'), notes = COALESCE(notes, 'Cardentify import; original bank: 八達通卡; type: Debit; source: Apple Pay') WHERE country = 'HK' AND bank_name = '八達通卡' AND card_name = 'Octopus Mastercard';

INSERT INTO card_catalog (country, bank_name, card_name, card_tier, network, tags, image_url, variants, annual_fee_cny, notes)
SELECT 'JP', 'オリコ', 'エディオンカード', '普卡', 'JCB', 'Cardentify,信用卡,来源:Apple Pay,BIN:354078', '/images/cards/cardentify/5cd5f9763513-ecabcddbbff3-f46d55b3.svg', NULL, NULL, 'Cardentify import; original bank: オリコ; type: Credit; source: Apple Pay'
WHERE NOT EXISTS (SELECT 1 FROM card_catalog WHERE country = 'JP' AND bank_name = 'オリコ' AND card_name = 'エディオンカード');
UPDATE card_catalog SET image_url = CASE WHEN image_url IS NULL OR image_url LIKE '/images/cards/cardentify/%' THEN '/images/cards/cardentify/5cd5f9763513-ecabcddbbff3-f46d55b3.svg' ELSE image_url END, network = COALESCE(network, 'JCB'), tags = COALESCE(tags, 'Cardentify,信用卡,来源:Apple Pay,BIN:354078'), notes = COALESCE(notes, 'Cardentify import; original bank: オリコ; type: Credit; source: Apple Pay') WHERE country = 'JP' AND bank_name = 'オリコ' AND card_name = 'エディオンカード';

INSERT INTO card_catalog (country, bank_name, card_name, card_tier, network, tags, image_url, variants, annual_fee_cny, notes)
SELECT 'JP', 'オリコ', 'JR TOWER SQUARE CARD', '普卡', 'JCB', 'Cardentify,信用卡,来源:Apple Pay,BIN:358305', '/images/cards/cardentify/5cd5f9763513-jr-tower-square-card-5d3088d9.svg', NULL, NULL, 'Cardentify import; original bank: オリコ; type: Credit; source: Apple Pay'
WHERE NOT EXISTS (SELECT 1 FROM card_catalog WHERE country = 'JP' AND bank_name = 'オリコ' AND card_name = 'JR TOWER SQUARE CARD');
UPDATE card_catalog SET image_url = CASE WHEN image_url IS NULL OR image_url LIKE '/images/cards/cardentify/%' THEN '/images/cards/cardentify/5cd5f9763513-jr-tower-square-card-5d3088d9.svg' ELSE image_url END, network = COALESCE(network, 'JCB'), tags = COALESCE(tags, 'Cardentify,信用卡,来源:Apple Pay,BIN:358305'), notes = COALESCE(notes, 'Cardentify import; original bank: オリコ; type: Credit; source: Apple Pay') WHERE country = 'JP' AND bank_name = 'オリコ' AND card_name = 'JR TOWER SQUARE CARD';

INSERT INTO card_catalog (country, bank_name, card_name, card_tier, network, tags, image_url, variants, annual_fee_cny, notes)
SELECT 'JP', 'オリコ', 'オリコカード', '金卡', 'Mastercard', 'Cardentify,信用卡,来源:Apple Pay,BIN:524805', '/images/cards/cardentify/5cd5f9763513-09b51fa5efe9-92a8b416.jpg', NULL, NULL, 'Cardentify import; original bank: オリコ; type: Credit; source: Apple Pay'
WHERE NOT EXISTS (SELECT 1 FROM card_catalog WHERE country = 'JP' AND bank_name = 'オリコ' AND card_name = 'オリコカード');
UPDATE card_catalog SET image_url = CASE WHEN image_url IS NULL OR image_url LIKE '/images/cards/cardentify/%' THEN '/images/cards/cardentify/5cd5f9763513-09b51fa5efe9-92a8b416.jpg' ELSE image_url END, network = COALESCE(network, 'Mastercard'), tags = COALESCE(tags, 'Cardentify,信用卡,来源:Apple Pay,BIN:524805'), notes = COALESCE(notes, 'Cardentify import; original bank: オリコ; type: Credit; source: Apple Pay') WHERE country = 'JP' AND bank_name = 'オリコ' AND card_name = 'オリコカード';

INSERT INTO card_catalog (country, bank_name, card_name, card_tier, network, tags, image_url, variants, annual_fee_cny, notes)
SELECT 'JP', 'オリコ', 'Costco Global Card', '普卡', 'Mastercard', 'Cardentify,信用卡,来源:Apple Pay,BIN:524804', '/images/cards/cardentify/5cd5f9763513-costco-global-card-ef477d47.jpg', NULL, NULL, 'Cardentify import; original bank: オリコ; type: Credit; source: Apple Pay'
WHERE NOT EXISTS (SELECT 1 FROM card_catalog WHERE country = 'JP' AND bank_name = 'オリコ' AND card_name = 'Costco Global Card');
UPDATE card_catalog SET image_url = CASE WHEN image_url IS NULL OR image_url LIKE '/images/cards/cardentify/%' THEN '/images/cards/cardentify/5cd5f9763513-costco-global-card-ef477d47.jpg' ELSE image_url END, network = COALESCE(network, 'Mastercard'), tags = COALESCE(tags, 'Cardentify,信用卡,来源:Apple Pay,BIN:524804'), notes = COALESCE(notes, 'Cardentify import; original bank: オリコ; type: Credit; source: Apple Pay') WHERE country = 'JP' AND bank_name = 'オリコ' AND card_name = 'Costco Global Card';

INSERT INTO card_catalog (country, bank_name, card_name, card_tier, network, tags, image_url, variants, annual_fee_cny, notes)
SELECT 'JP', 'オリコ', 'マツモトキヨシメンバースカード', '金卡', 'Mastercard', 'Cardentify,信用卡,来源:Apple Pay,BIN:524805', '/images/cards/cardentify/5cd5f9763513-eee274e5b33e-082a8ad4.jpg', NULL, NULL, 'Cardentify import; original bank: オリコ; type: Credit; source: Apple Pay'
WHERE NOT EXISTS (SELECT 1 FROM card_catalog WHERE country = 'JP' AND bank_name = 'オリコ' AND card_name = 'マツモトキヨシメンバースカード');
UPDATE card_catalog SET image_url = CASE WHEN image_url IS NULL OR image_url LIKE '/images/cards/cardentify/%' THEN '/images/cards/cardentify/5cd5f9763513-eee274e5b33e-082a8ad4.jpg' ELSE image_url END, network = COALESCE(network, 'Mastercard'), tags = COALESCE(tags, 'Cardentify,信用卡,来源:Apple Pay,BIN:524805'), notes = COALESCE(notes, 'Cardentify import; original bank: オリコ; type: Credit; source: Apple Pay') WHERE country = 'JP' AND bank_name = 'オリコ' AND card_name = 'マツモトキヨシメンバースカード';

INSERT INTO card_catalog (country, bank_name, card_name, card_tier, network, tags, image_url, variants, annual_fee_cny, notes)
SELECT 'US', 'PayPal', 'PayPal Debit Mastercard', '普卡', 'Mastercard', 'Cardentify,借记卡,来源:Apple Pay,BIN:514377', '/images/cards/cardentify/paypal-paypal-debit-mastercard-d3aa4223.jpg', NULL, NULL, 'Cardentify import; original bank: PayPal; type: Debit; source: Apple Pay'
WHERE NOT EXISTS (SELECT 1 FROM card_catalog WHERE country = 'US' AND bank_name = 'PayPal' AND card_name = 'PayPal Debit Mastercard');
UPDATE card_catalog SET image_url = CASE WHEN image_url IS NULL OR image_url LIKE '/images/cards/cardentify/%' THEN '/images/cards/cardentify/paypal-paypal-debit-mastercard-d3aa4223.jpg' ELSE image_url END, network = COALESCE(network, 'Mastercard'), tags = COALESCE(tags, 'Cardentify,借记卡,来源:Apple Pay,BIN:514377'), notes = COALESCE(notes, 'Cardentify import; original bank: PayPal; type: Debit; source: Apple Pay') WHERE country = 'US' AND bank_name = 'PayPal' AND card_name = 'PayPal Debit Mastercard';

INSERT INTO card_catalog (country, bank_name, card_name, card_tier, network, tags, image_url, variants, annual_fee_cny, notes)
SELECT 'CN', '平安银行', '平安银行IC借记卡普卡', '普卡', 'UnionPay', 'Cardentify,借记卡,来源:Apple Pay,BIN:623058', '/images/cards/cardentify/a898cfd9a672-ic-b27dfe56.jpg', NULL, NULL, 'Cardentify import; original bank: 平安银行; type: Debit; source: Apple Pay'
WHERE NOT EXISTS (SELECT 1 FROM card_catalog WHERE country = 'CN' AND bank_name = '平安银行' AND card_name = '平安银行IC借记卡普卡');
UPDATE card_catalog SET image_url = CASE WHEN image_url IS NULL OR image_url LIKE '/images/cards/cardentify/%' THEN '/images/cards/cardentify/a898cfd9a672-ic-b27dfe56.jpg' ELSE image_url END, network = COALESCE(network, 'UnionPay'), tags = COALESCE(tags, 'Cardentify,借记卡,来源:Apple Pay,BIN:623058'), notes = COALESCE(notes, 'Cardentify import; original bank: 平安银行; type: Debit; source: Apple Pay') WHERE country = 'CN' AND bank_name = '平安银行' AND card_name = '平安银行IC借记卡普卡';

INSERT INTO card_catalog (country, bank_name, card_name, card_tier, network, tags, image_url, variants, annual_fee_cny, notes)
SELECT 'CN', '平安银行', '哔哩哔哩', '普卡', 'UnionPay', 'Cardentify,借记卡,来源:Mi Pay', '/images/cards/cardentify/a898cfd9a672-da1fd957dc66-09543c15.jpg', NULL, NULL, 'Cardentify import; original bank: 平安银行; type: Debit; source: Mi Pay'
WHERE NOT EXISTS (SELECT 1 FROM card_catalog WHERE country = 'CN' AND bank_name = '平安银行' AND card_name = '哔哩哔哩');
UPDATE card_catalog SET image_url = CASE WHEN image_url IS NULL OR image_url LIKE '/images/cards/cardentify/%' THEN '/images/cards/cardentify/a898cfd9a672-da1fd957dc66-09543c15.jpg' ELSE image_url END, network = COALESCE(network, 'UnionPay'), tags = COALESCE(tags, 'Cardentify,借记卡,来源:Mi Pay'), notes = COALESCE(notes, 'Cardentify import; original bank: 平安银行; type: Debit; source: Mi Pay') WHERE country = 'CN' AND bank_name = '平安银行' AND card_name = '哔哩哔哩';

INSERT INTO card_catalog (country, bank_name, card_name, card_tier, network, tags, image_url, variants, annual_fee_cny, notes)
SELECT 'CN', '平安银行', '平安银行-BLG', '普卡', 'UnionPay', 'Cardentify,借记卡,来源:Mi Pay', '/images/cards/cardentify/a898cfd9a672-blg-8b6c115f.jpg', NULL, NULL, 'Cardentify import; original bank: 平安银行; type: Debit; source: Mi Pay'
WHERE NOT EXISTS (SELECT 1 FROM card_catalog WHERE country = 'CN' AND bank_name = '平安银行' AND card_name = '平安银行-BLG');
UPDATE card_catalog SET image_url = CASE WHEN image_url IS NULL OR image_url LIKE '/images/cards/cardentify/%' THEN '/images/cards/cardentify/a898cfd9a672-blg-8b6c115f.jpg' ELSE image_url END, network = COALESCE(network, 'UnionPay'), tags = COALESCE(tags, 'Cardentify,借记卡,来源:Mi Pay'), notes = COALESCE(notes, 'Cardentify import; original bank: 平安银行; type: Debit; source: Mi Pay') WHERE country = 'CN' AND bank_name = '平安银行' AND card_name = '平安银行-BLG';

INSERT INTO card_catalog (country, bank_name, card_name, card_tier, network, tags, image_url, variants, annual_fee_cny, notes)
SELECT 'CN', '平安银行', '厦航', '钻石卡', 'UnionPay', 'Cardentify,借记卡,来源:Mi Pay', '/images/cards/cardentify/a898cfd9a672-f375d9e48043-c1e1c861.jpg', NULL, NULL, 'Cardentify import; original bank: 平安银行; type: Debit; source: Mi Pay'
WHERE NOT EXISTS (SELECT 1 FROM card_catalog WHERE country = 'CN' AND bank_name = '平安银行' AND card_name = '厦航');
UPDATE card_catalog SET image_url = CASE WHEN image_url IS NULL OR image_url LIKE '/images/cards/cardentify/%' THEN '/images/cards/cardentify/a898cfd9a672-f375d9e48043-c1e1c861.jpg' ELSE image_url END, network = COALESCE(network, 'UnionPay'), tags = COALESCE(tags, 'Cardentify,借记卡,来源:Mi Pay'), notes = COALESCE(notes, 'Cardentify import; original bank: 平安银行; type: Debit; source: Mi Pay') WHERE country = 'CN' AND bank_name = '平安银行' AND card_name = '厦航';

INSERT INTO card_catalog (country, bank_name, card_name, card_tier, network, tags, image_url, variants, annual_fee_cny, notes)
SELECT 'CN', '平安银行', '厦航白金卡', '白金卡', 'UnionPay', 'Cardentify,借记卡,来源:Mi Pay', '/images/cards/cardentify/a898cfd9a672-9088594ece3f-c5e0e2d2.jpg', NULL, NULL, 'Cardentify import; original bank: 平安银行; type: Debit; source: Mi Pay'
WHERE NOT EXISTS (SELECT 1 FROM card_catalog WHERE country = 'CN' AND bank_name = '平安银行' AND card_name = '厦航白金卡');
UPDATE card_catalog SET image_url = CASE WHEN image_url IS NULL OR image_url LIKE '/images/cards/cardentify/%' THEN '/images/cards/cardentify/a898cfd9a672-9088594ece3f-c5e0e2d2.jpg' ELSE image_url END, network = COALESCE(network, 'UnionPay'), tags = COALESCE(tags, 'Cardentify,借记卡,来源:Mi Pay'), notes = COALESCE(notes, 'Cardentify import; original bank: 平安银行; type: Debit; source: Mi Pay') WHERE country = 'CN' AND bank_name = '平安银行' AND card_name = '厦航白金卡';

INSERT INTO card_catalog (country, bank_name, card_name, card_tier, network, tags, image_url, variants, annual_fee_cny, notes)
SELECT 'CN', '平安银行', '小财娘1', '普卡', 'UnionPay', 'Cardentify,借记卡,来源:Mi Pay', '/images/cards/cardentify/a898cfd9a672-1-ae9898b0.jpg', NULL, NULL, 'Cardentify import; original bank: 平安银行; type: Debit; source: Mi Pay'
WHERE NOT EXISTS (SELECT 1 FROM card_catalog WHERE country = 'CN' AND bank_name = '平安银行' AND card_name = '小财娘1');
UPDATE card_catalog SET image_url = CASE WHEN image_url IS NULL OR image_url LIKE '/images/cards/cardentify/%' THEN '/images/cards/cardentify/a898cfd9a672-1-ae9898b0.jpg' ELSE image_url END, network = COALESCE(network, 'UnionPay'), tags = COALESCE(tags, 'Cardentify,借记卡,来源:Mi Pay'), notes = COALESCE(notes, 'Cardentify import; original bank: 平安银行; type: Debit; source: Mi Pay') WHERE country = 'CN' AND bank_name = '平安银行' AND card_name = '小财娘1';

INSERT INTO card_catalog (country, bank_name, card_name, card_tier, network, tags, image_url, variants, annual_fee_cny, notes)
SELECT 'CN', '平安银行', '小财娘2', '普卡', 'UnionPay', 'Cardentify,借记卡,来源:Mi Pay', '/images/cards/cardentify/a898cfd9a672-2-4ac82d05.jpg', NULL, NULL, 'Cardentify import; original bank: 平安银行; type: Debit; source: Mi Pay'
WHERE NOT EXISTS (SELECT 1 FROM card_catalog WHERE country = 'CN' AND bank_name = '平安银行' AND card_name = '小财娘2');
UPDATE card_catalog SET image_url = CASE WHEN image_url IS NULL OR image_url LIKE '/images/cards/cardentify/%' THEN '/images/cards/cardentify/a898cfd9a672-2-4ac82d05.jpg' ELSE image_url END, network = COALESCE(network, 'UnionPay'), tags = COALESCE(tags, 'Cardentify,借记卡,来源:Mi Pay'), notes = COALESCE(notes, 'Cardentify import; original bank: 平安银行; type: Debit; source: Mi Pay') WHERE country = 'CN' AND bank_name = '平安银行' AND card_name = '小财娘2';

INSERT INTO card_catalog (country, bank_name, card_name, card_tier, network, tags, image_url, variants, annual_fee_cny, notes)
SELECT 'CN', '平安银行', '小财娘3', '普卡', 'UnionPay', 'Cardentify,借记卡,来源:Mi Pay', '/images/cards/cardentify/a898cfd9a672-3-da82e52f.jpg', NULL, NULL, 'Cardentify import; original bank: 平安银行; type: Debit; source: Mi Pay'
WHERE NOT EXISTS (SELECT 1 FROM card_catalog WHERE country = 'CN' AND bank_name = '平安银行' AND card_name = '小财娘3');
UPDATE card_catalog SET image_url = CASE WHEN image_url IS NULL OR image_url LIKE '/images/cards/cardentify/%' THEN '/images/cards/cardentify/a898cfd9a672-3-da82e52f.jpg' ELSE image_url END, network = COALESCE(network, 'UnionPay'), tags = COALESCE(tags, 'Cardentify,借记卡,来源:Mi Pay'), notes = COALESCE(notes, 'Cardentify import; original bank: 平安银行; type: Debit; source: Mi Pay') WHERE country = 'CN' AND bank_name = '平安银行' AND card_name = '小财娘3';

INSERT INTO card_catalog (country, bank_name, card_name, card_tier, network, tags, image_url, variants, annual_fee_cny, notes)
SELECT 'CN', '平安银行', '小财娘4', '普卡', 'UnionPay', 'Cardentify,借记卡,来源:Mi Pay', '/images/cards/cardentify/a898cfd9a672-4-f0619e27.jpg', NULL, NULL, 'Cardentify import; original bank: 平安银行; type: Debit; source: Mi Pay'
WHERE NOT EXISTS (SELECT 1 FROM card_catalog WHERE country = 'CN' AND bank_name = '平安银行' AND card_name = '小财娘4');
UPDATE card_catalog SET image_url = CASE WHEN image_url IS NULL OR image_url LIKE '/images/cards/cardentify/%' THEN '/images/cards/cardentify/a898cfd9a672-4-f0619e27.jpg' ELSE image_url END, network = COALESCE(network, 'UnionPay'), tags = COALESCE(tags, 'Cardentify,借记卡,来源:Mi Pay'), notes = COALESCE(notes, 'Cardentify import; original bank: 平安银行; type: Debit; source: Mi Pay') WHERE country = 'CN' AND bank_name = '平安银行' AND card_name = '小财娘4';

INSERT INTO card_catalog (country, bank_name, card_name, card_tier, network, tags, image_url, variants, annual_fee_cny, notes)
SELECT 'CN', '平安银行', '小财娘6', '普卡', 'UnionPay', 'Cardentify,借记卡,来源:Mi Pay', '/images/cards/cardentify/a898cfd9a672-6-a753413d.jpg', NULL, NULL, 'Cardentify import; original bank: 平安银行; type: Debit; source: Mi Pay'
WHERE NOT EXISTS (SELECT 1 FROM card_catalog WHERE country = 'CN' AND bank_name = '平安银行' AND card_name = '小财娘6');
UPDATE card_catalog SET image_url = CASE WHEN image_url IS NULL OR image_url LIKE '/images/cards/cardentify/%' THEN '/images/cards/cardentify/a898cfd9a672-6-a753413d.jpg' ELSE image_url END, network = COALESCE(network, 'UnionPay'), tags = COALESCE(tags, 'Cardentify,借记卡,来源:Mi Pay'), notes = COALESCE(notes, 'Cardentify import; original bank: 平安银行; type: Debit; source: Mi Pay') WHERE country = 'CN' AND bank_name = '平安银行' AND card_name = '小财娘6';

INSERT INTO card_catalog (country, bank_name, card_name, card_tier, network, tags, image_url, variants, annual_fee_cny, notes)
SELECT 'CN', '平安银行', '小财娘数字人', '普卡', 'UnionPay', 'Cardentify,借记卡,来源:Mi Pay', '/images/cards/cardentify/a898cfd9a672-cf89c5ab7975-77814316.jpg', NULL, NULL, 'Cardentify import; original bank: 平安银行; type: Debit; source: Mi Pay'
WHERE NOT EXISTS (SELECT 1 FROM card_catalog WHERE country = 'CN' AND bank_name = '平安银行' AND card_name = '小财娘数字人');
UPDATE card_catalog SET image_url = CASE WHEN image_url IS NULL OR image_url LIKE '/images/cards/cardentify/%' THEN '/images/cards/cardentify/a898cfd9a672-cf89c5ab7975-77814316.jpg' ELSE image_url END, network = COALESCE(network, 'UnionPay'), tags = COALESCE(tags, 'Cardentify,借记卡,来源:Mi Pay'), notes = COALESCE(notes, 'Cardentify import; original bank: 平安银行; type: Debit; source: Mi Pay') WHERE country = 'CN' AND bank_name = '平安银行' AND card_name = '小财娘数字人';

INSERT INTO card_catalog (country, bank_name, card_name, card_tier, network, tags, image_url, variants, annual_fee_cny, notes)
SELECT 'CN', '平安银行', '星空', '普卡', 'UnionPay', 'Cardentify,借记卡,来源:Mi Pay', '/images/cards/cardentify/a898cfd9a672-7bcfac491d95-9f28fc8b.jpg', NULL, NULL, 'Cardentify import; original bank: 平安银行; type: Debit; source: Mi Pay'
WHERE NOT EXISTS (SELECT 1 FROM card_catalog WHERE country = 'CN' AND bank_name = '平安银行' AND card_name = '星空');
UPDATE card_catalog SET image_url = CASE WHEN image_url IS NULL OR image_url LIKE '/images/cards/cardentify/%' THEN '/images/cards/cardentify/a898cfd9a672-7bcfac491d95-9f28fc8b.jpg' ELSE image_url END, network = COALESCE(network, 'UnionPay'), tags = COALESCE(tags, 'Cardentify,借记卡,来源:Mi Pay'), notes = COALESCE(notes, 'Cardentify import; original bank: 平安银行; type: Debit; source: Mi Pay') WHERE country = 'CN' AND bank_name = '平安银行' AND card_name = '星空';

INSERT INTO card_catalog (country, bank_name, card_name, card_tier, network, tags, image_url, variants, annual_fee_cny, notes)
SELECT 'CN', '平安银行', '悦享白金卡', '白金卡', 'UnionPay', 'Cardentify,信用卡,来源:云闪付', '/images/cards/cardentify/a898cfd9a672-1f0f751b8ffd-34d1d9a7.jpg', NULL, NULL, 'Cardentify import; original bank: 平安银行; type: Credit; source: 云闪付'
WHERE NOT EXISTS (SELECT 1 FROM card_catalog WHERE country = 'CN' AND bank_name = '平安银行' AND card_name = '悦享白金卡');
UPDATE card_catalog SET image_url = CASE WHEN image_url IS NULL OR image_url LIKE '/images/cards/cardentify/%' THEN '/images/cards/cardentify/a898cfd9a672-1f0f751b8ffd-34d1d9a7.jpg' ELSE image_url END, network = COALESCE(network, 'UnionPay'), tags = COALESCE(tags, 'Cardentify,信用卡,来源:云闪付'), notes = COALESCE(notes, 'Cardentify import; original bank: 平安银行; type: Credit; source: 云闪付') WHERE country = 'CN' AND bank_name = '平安银行' AND card_name = '悦享白金卡';

INSERT INTO card_catalog (country, bank_name, card_name, card_tier, network, tags, image_url, variants, annual_fee_cny, notes)
SELECT 'CN', '邮储银行', 'U+卡', '普卡', 'UnionPay', 'Cardentify,借记卡,来源:Apple Pay,BIN:623677', '/images/cards/cardentify/e8ed4b2f3763-u-8417f70b.jpg', NULL, NULL, 'Cardentify import; original bank: 中国邮政储蓄银行; type: Debit; source: Apple Pay'
WHERE NOT EXISTS (SELECT 1 FROM card_catalog WHERE country = 'CN' AND bank_name = '邮储银行' AND card_name = 'U+卡');
UPDATE card_catalog SET image_url = CASE WHEN image_url IS NULL OR image_url LIKE '/images/cards/cardentify/%' THEN '/images/cards/cardentify/e8ed4b2f3763-u-8417f70b.jpg' ELSE image_url END, network = COALESCE(network, 'UnionPay'), tags = COALESCE(tags, 'Cardentify,借记卡,来源:Apple Pay,BIN:623677'), notes = COALESCE(notes, 'Cardentify import; original bank: 中国邮政储蓄银行; type: Debit; source: Apple Pay') WHERE country = 'CN' AND bank_name = '邮储银行' AND card_name = 'U+卡';

INSERT INTO card_catalog (country, bank_name, card_name, card_tier, network, tags, image_url, variants, annual_fee_cny, notes)
SELECT 'CN', '邮储银行', '闪光卡', '普卡', 'UnionPay', 'Cardentify,借记卡,来源:Mi Pay', '/images/cards/cardentify/e8ed4b2f3763-04b8684dcd8c-5dc32179.jpg', NULL, NULL, 'Cardentify import; original bank: 中国邮政储蓄银行; type: Debit; source: Mi Pay'
WHERE NOT EXISTS (SELECT 1 FROM card_catalog WHERE country = 'CN' AND bank_name = '邮储银行' AND card_name = '闪光卡');
UPDATE card_catalog SET image_url = CASE WHEN image_url IS NULL OR image_url LIKE '/images/cards/cardentify/%' THEN '/images/cards/cardentify/e8ed4b2f3763-04b8684dcd8c-5dc32179.jpg' ELSE image_url END, network = COALESCE(network, 'UnionPay'), tags = COALESCE(tags, 'Cardentify,借记卡,来源:Mi Pay'), notes = COALESCE(notes, 'Cardentify import; original bank: 中国邮政储蓄银行; type: Debit; source: Mi Pay') WHERE country = 'CN' AND bank_name = '邮储银行' AND card_name = '闪光卡';

INSERT INTO card_catalog (country, bank_name, card_name, card_tier, network, tags, image_url, variants, annual_fee_cny, notes)
SELECT 'CN', '邮储银行', '绿卡通金卡贵宾卡', '金卡', 'UnionPay', 'Cardentify,借记卡,来源:云闪付', '/images/cards/cardentify/e8ed4b2f3763-fea66fee69db-752a40f9.jpg', NULL, NULL, 'Cardentify import; original bank: 中国邮政储蓄银行; type: Debit; source: 云闪付'
WHERE NOT EXISTS (SELECT 1 FROM card_catalog WHERE country = 'CN' AND bank_name = '邮储银行' AND card_name = '绿卡通金卡贵宾卡');
UPDATE card_catalog SET image_url = CASE WHEN image_url IS NULL OR image_url LIKE '/images/cards/cardentify/%' THEN '/images/cards/cardentify/e8ed4b2f3763-fea66fee69db-752a40f9.jpg' ELSE image_url END, network = COALESCE(network, 'UnionPay'), tags = COALESCE(tags, 'Cardentify,借记卡,来源:云闪付'), notes = COALESCE(notes, 'Cardentify import; original bank: 中国邮政储蓄银行; type: Debit; source: 云闪付') WHERE country = 'CN' AND bank_name = '邮储银行' AND card_name = '绿卡通金卡贵宾卡';

INSERT INTO card_catalog (country, bank_name, card_name, card_tier, network, tags, image_url, variants, annual_fee_cny, notes)
SELECT 'CN', '邮储银行', '绿卡通（无界文旅卡）', '普卡', 'UnionPay', 'Cardentify,借记卡,来源:云闪付', '/images/cards/cardentify/e8ed4b2f3763-3ff449559acf-b152e7cc.jpg', NULL, NULL, 'Cardentify import; original bank: 中国邮政储蓄银行; type: Debit; source: 云闪付'
WHERE NOT EXISTS (SELECT 1 FROM card_catalog WHERE country = 'CN' AND bank_name = '邮储银行' AND card_name = '绿卡通（无界文旅卡）');
UPDATE card_catalog SET image_url = CASE WHEN image_url IS NULL OR image_url LIKE '/images/cards/cardentify/%' THEN '/images/cards/cardentify/e8ed4b2f3763-3ff449559acf-b152e7cc.jpg' ELSE image_url END, network = COALESCE(network, 'UnionPay'), tags = COALESCE(tags, 'Cardentify,借记卡,来源:云闪付'), notes = COALESCE(notes, 'Cardentify import; original bank: 中国邮政储蓄银行; type: Debit; source: 云闪付') WHERE country = 'CN' AND bank_name = '邮储银行' AND card_name = '绿卡通（无界文旅卡）';

INSERT INTO card_catalog (country, bank_name, card_name, card_tier, network, tags, image_url, variants, annual_fee_cny, notes)
SELECT 'CN', '邮储银行', '胖虎卡', '普卡', 'UnionPay', 'Cardentify,借记卡,来源:云闪付', '/images/cards/cardentify/e8ed4b2f3763-dd8544ee7987-ac0809d9.jpg', NULL, NULL, 'Cardentify import; original bank: 中国邮政储蓄银行; type: Debit; source: 云闪付'
WHERE NOT EXISTS (SELECT 1 FROM card_catalog WHERE country = 'CN' AND bank_name = '邮储银行' AND card_name = '胖虎卡');
UPDATE card_catalog SET image_url = CASE WHEN image_url IS NULL OR image_url LIKE '/images/cards/cardentify/%' THEN '/images/cards/cardentify/e8ed4b2f3763-dd8544ee7987-ac0809d9.jpg' ELSE image_url END, network = COALESCE(network, 'UnionPay'), tags = COALESCE(tags, 'Cardentify,借记卡,来源:云闪付'), notes = COALESCE(notes, 'Cardentify import; original bank: 中国邮政储蓄银行; type: Debit; source: 云闪付') WHERE country = 'CN' AND bank_name = '邮储银行' AND card_name = '胖虎卡';

INSERT INTO card_catalog (country, bank_name, card_name, card_tier, network, tags, image_url, variants, annual_fee_cny, notes)
SELECT 'CN', '邮储银行', '胖虎卡（生龙活虎）', '普卡', 'UnionPay', 'Cardentify,借记卡,来源:云闪付', '/images/cards/cardentify/e8ed4b2f3763-5c47744c2f81-a1086f37.jpg', NULL, NULL, 'Cardentify import; original bank: 中国邮政储蓄银行; type: Debit; source: 云闪付'
WHERE NOT EXISTS (SELECT 1 FROM card_catalog WHERE country = 'CN' AND bank_name = '邮储银行' AND card_name = '胖虎卡（生龙活虎）');
UPDATE card_catalog SET image_url = CASE WHEN image_url IS NULL OR image_url LIKE '/images/cards/cardentify/%' THEN '/images/cards/cardentify/e8ed4b2f3763-5c47744c2f81-a1086f37.jpg' ELSE image_url END, network = COALESCE(network, 'UnionPay'), tags = COALESCE(tags, 'Cardentify,借记卡,来源:云闪付'), notes = COALESCE(notes, 'Cardentify import; original bank: 中国邮政储蓄银行; type: Debit; source: 云闪付') WHERE country = 'CN' AND bank_name = '邮储银行' AND card_name = '胖虎卡（生龙活虎）';

INSERT INTO card_catalog (country, bank_name, card_name, card_tier, network, tags, image_url, variants, annual_fee_cny, notes)
SELECT 'CN', '邮储银行', '绿卡通（磁条卡）', '普卡', 'UnionPay', 'Cardentify,借记卡,来源:云闪付', '/images/cards/cardentify/e8ed4b2f3763-a03dd00103b6-0b1d86ac.jpg', NULL, NULL, 'Cardentify import; original bank: 中国邮政储蓄银行; type: Debit; source: 云闪付'
WHERE NOT EXISTS (SELECT 1 FROM card_catalog WHERE country = 'CN' AND bank_name = '邮储银行' AND card_name = '绿卡通（磁条卡）');
UPDATE card_catalog SET image_url = CASE WHEN image_url IS NULL OR image_url LIKE '/images/cards/cardentify/%' THEN '/images/cards/cardentify/e8ed4b2f3763-a03dd00103b6-0b1d86ac.jpg' ELSE image_url END, network = COALESCE(network, 'UnionPay'), tags = COALESCE(tags, 'Cardentify,借记卡,来源:云闪付'), notes = COALESCE(notes, 'Cardentify import; original bank: 中国邮政储蓄银行; type: Debit; source: 云闪付') WHERE country = 'CN' AND bank_name = '邮储银行' AND card_name = '绿卡通（磁条卡）';

INSERT INTO card_catalog (country, bank_name, card_name, card_tier, network, tags, image_url, variants, annual_fee_cny, notes)
SELECT 'CN', '邮储银行', '乡村振兴卡', '普卡', 'UnionPay', 'Cardentify,借记卡,来源:云闪付', '/images/cards/cardentify/e8ed4b2f3763-3eabb928cdb6-84ab954e.jpg', NULL, NULL, 'Cardentify import; original bank: 中国邮政储蓄银行; type: Debit; source: 云闪付'
WHERE NOT EXISTS (SELECT 1 FROM card_catalog WHERE country = 'CN' AND bank_name = '邮储银行' AND card_name = '乡村振兴卡');
UPDATE card_catalog SET image_url = CASE WHEN image_url IS NULL OR image_url LIKE '/images/cards/cardentify/%' THEN '/images/cards/cardentify/e8ed4b2f3763-3eabb928cdb6-84ab954e.jpg' ELSE image_url END, network = COALESCE(network, 'UnionPay'), tags = COALESCE(tags, 'Cardentify,借记卡,来源:云闪付'), notes = COALESCE(notes, 'Cardentify import; original bank: 中国邮政储蓄银行; type: Debit; source: 云闪付') WHERE country = 'CN' AND bank_name = '邮储银行' AND card_name = '乡村振兴卡';

INSERT INTO card_catalog (country, bank_name, card_name, card_tier, network, tags, image_url, variants, annual_fee_cny, notes)
SELECT 'CN', '邮储银行', '标准普卡绿卡通', '普卡', 'UnionPay', 'Cardentify,借记卡,来源:云闪付,BIN:621797', '/images/cards/cardentify/e8ed4b2f3763-e9221f6d9910-19fbf6c8.jpg', NULL, NULL, 'Cardentify import; original bank: 中国邮政储蓄银行; type: Debit; source: 云闪付'
WHERE NOT EXISTS (SELECT 1 FROM card_catalog WHERE country = 'CN' AND bank_name = '邮储银行' AND card_name = '标准普卡绿卡通');
UPDATE card_catalog SET image_url = CASE WHEN image_url IS NULL OR image_url LIKE '/images/cards/cardentify/%' THEN '/images/cards/cardentify/e8ed4b2f3763-e9221f6d9910-19fbf6c8.jpg' ELSE image_url END, network = COALESCE(network, 'UnionPay'), tags = COALESCE(tags, 'Cardentify,借记卡,来源:云闪付,BIN:621797'), notes = COALESCE(notes, 'Cardentify import; original bank: 中国邮政储蓄银行; type: Debit; source: 云闪付') WHERE country = 'CN' AND bank_name = '邮储银行' AND card_name = '标准普卡绿卡通';

INSERT INTO card_catalog (country, bank_name, card_name, card_tier, network, tags, image_url, variants, annual_fee_cny, notes)
SELECT 'JP', '楽天カード', '楽天ゴールドカード JCB', '金卡', 'JCB', 'Cardentify,信用卡,来源:Apple Pay,BIN:358403', '/images/cards/cardentify/e76c4e8659a6-jcb-f7a77737.jpg', NULL, NULL, 'Cardentify import; original bank: 楽天カード; type: Credit; source: Apple Pay'
WHERE NOT EXISTS (SELECT 1 FROM card_catalog WHERE country = 'JP' AND bank_name = '楽天カード' AND card_name = '楽天ゴールドカード JCB');
UPDATE card_catalog SET image_url = CASE WHEN image_url IS NULL OR image_url LIKE '/images/cards/cardentify/%' THEN '/images/cards/cardentify/e76c4e8659a6-jcb-f7a77737.jpg' ELSE image_url END, network = COALESCE(network, 'JCB'), tags = COALESCE(tags, 'Cardentify,信用卡,来源:Apple Pay,BIN:358403'), notes = COALESCE(notes, 'Cardentify import; original bank: 楽天カード; type: Credit; source: Apple Pay') WHERE country = 'JP' AND bank_name = '楽天カード' AND card_name = '楽天ゴールドカード JCB';

INSERT INTO card_catalog (country, bank_name, card_name, card_tier, network, tags, image_url, variants, annual_fee_cny, notes)
SELECT 'CN', '浦发银行', '浦发bilibili主题信用卡', '白金卡', 'UnionPay', 'Cardentify,信用卡,来源:云闪付,BIN:622228', '/images/cards/cardentify/7f83e1af697b-bilibili-3c642554.jpg', NULL, NULL, 'Cardentify import; original bank: 浦发银行; type: Credit; source: 云闪付'
WHERE NOT EXISTS (SELECT 1 FROM card_catalog WHERE country = 'CN' AND bank_name = '浦发银行' AND card_name = '浦发bilibili主题信用卡');
UPDATE card_catalog SET image_url = CASE WHEN image_url IS NULL OR image_url LIKE '/images/cards/cardentify/%' THEN '/images/cards/cardentify/7f83e1af697b-bilibili-3c642554.jpg' ELSE image_url END, network = COALESCE(network, 'UnionPay'), tags = COALESCE(tags, 'Cardentify,信用卡,来源:云闪付,BIN:622228'), notes = COALESCE(notes, 'Cardentify import; original bank: 浦发银行; type: Credit; source: 云闪付') WHERE country = 'CN' AND bank_name = '浦发银行' AND card_name = '浦发bilibili主题信用卡';

INSERT INTO card_catalog (country, bank_name, card_name, card_tier, network, tags, image_url, variants, annual_fee_cny, notes)
SELECT 'CN', '浦发银行', '浦发运通白金梦卡', 'Member', 'AMEX', 'Cardentify,信用卡,来源:云闪付,BIN:378331', '/images/cards/cardentify/7f83e1af697b-5594f6c78c92-95972da6.jpg', NULL, NULL, 'Cardentify import; original bank: 浦发银行; type: Credit; source: 云闪付'
WHERE NOT EXISTS (SELECT 1 FROM card_catalog WHERE country = 'CN' AND bank_name = '浦发银行' AND card_name = '浦发运通白金梦卡');
UPDATE card_catalog SET image_url = CASE WHEN image_url IS NULL OR image_url LIKE '/images/cards/cardentify/%' THEN '/images/cards/cardentify/7f83e1af697b-5594f6c78c92-95972da6.jpg' ELSE image_url END, network = COALESCE(network, 'AMEX'), tags = COALESCE(tags, 'Cardentify,信用卡,来源:云闪付,BIN:378331'), notes = COALESCE(notes, 'Cardentify import; original bank: 浦发银行; type: Credit; source: 云闪付') WHERE country = 'CN' AND bank_name = '浦发银行' AND card_name = '浦发运通白金梦卡';

INSERT INTO card_catalog (country, bank_name, card_name, card_tier, network, tags, image_url, variants, annual_fee_cny, notes)
SELECT 'CN', '浦发银行', '浦发运通白金卡', 'Max', 'AMEX', 'Cardentify,信用卡,来源:云闪付', '/images/cards/cardentify/7f83e1af697b-3df22c77667e-2c2394f4.jpg', NULL, NULL, 'Cardentify import; original bank: 浦发银行; type: Credit; source: 云闪付'
WHERE NOT EXISTS (SELECT 1 FROM card_catalog WHERE country = 'CN' AND bank_name = '浦发银行' AND card_name = '浦发运通白金卡');
UPDATE card_catalog SET image_url = CASE WHEN image_url IS NULL OR image_url LIKE '/images/cards/cardentify/%' THEN '/images/cards/cardentify/7f83e1af697b-3df22c77667e-2c2394f4.jpg' ELSE image_url END, network = COALESCE(network, 'AMEX'), tags = COALESCE(tags, 'Cardentify,信用卡,来源:云闪付'), notes = COALESCE(notes, 'Cardentify import; original bank: 浦发银行; type: Credit; source: 云闪付') WHERE country = 'CN' AND bank_name = '浦发银行' AND card_name = '浦发运通白金卡';

INSERT INTO card_catalog (country, bank_name, card_name, card_tier, network, tags, image_url, variants, annual_fee_cny, notes)
SELECT 'CN', '浦发银行', '浦发运通萌主卡', 'MAX', 'AMEX', 'Cardentify,信用卡,来源:云闪付', '/images/cards/cardentify/7f83e1af697b-91263d8153c5-cd836717.jpg', NULL, NULL, 'Cardentify import; original bank: 浦发银行; type: Credit; source: 云闪付'
WHERE NOT EXISTS (SELECT 1 FROM card_catalog WHERE country = 'CN' AND bank_name = '浦发银行' AND card_name = '浦发运通萌主卡');
UPDATE card_catalog SET image_url = CASE WHEN image_url IS NULL OR image_url LIKE '/images/cards/cardentify/%' THEN '/images/cards/cardentify/7f83e1af697b-91263d8153c5-cd836717.jpg' ELSE image_url END, network = COALESCE(network, 'AMEX'), tags = COALESCE(tags, 'Cardentify,信用卡,来源:云闪付'), notes = COALESCE(notes, 'Cardentify import; original bank: 浦发银行; type: Credit; source: 云闪付') WHERE country = 'CN' AND bank_name = '浦发银行' AND card_name = '浦发运通萌主卡';

INSERT INTO card_catalog (country, bank_name, card_name, card_tier, network, tags, image_url, variants, annual_fee_cny, notes)
SELECT 'CN', '浦发银行', '浦发运通耀红卡', 'Scarlet', 'AMEX', 'Cardentify,信用卡,来源:云闪付', '/images/cards/cardentify/7f83e1af697b-20ab1796fd4c-d939529c.jpg', NULL, NULL, 'Cardentify import; original bank: 浦发银行; type: Credit; source: 云闪付'
WHERE NOT EXISTS (SELECT 1 FROM card_catalog WHERE country = 'CN' AND bank_name = '浦发银行' AND card_name = '浦发运通耀红卡');
UPDATE card_catalog SET image_url = CASE WHEN image_url IS NULL OR image_url LIKE '/images/cards/cardentify/%' THEN '/images/cards/cardentify/7f83e1af697b-20ab1796fd4c-d939529c.jpg' ELSE image_url END, network = COALESCE(network, 'AMEX'), tags = COALESCE(tags, 'Cardentify,信用卡,来源:云闪付'), notes = COALESCE(notes, 'Cardentify import; original bank: 浦发银行; type: Credit; source: 云闪付') WHERE country = 'CN' AND bank_name = '浦发银行' AND card_name = '浦发运通耀红卡';

INSERT INTO card_catalog (country, bank_name, card_name, card_tier, network, tags, image_url, variants, annual_fee_cny, notes)
SELECT 'CN', '浦发银行', '浦发运通车主卡', 'Select', 'AMEX', 'Cardentify,信用卡,来源:云闪付', '/images/cards/cardentify/7f83e1af697b-d4eee2bcf1e9-7e1941d5.jpg', NULL, NULL, 'Cardentify import; original bank: 浦发银行; type: Credit; source: 云闪付'
WHERE NOT EXISTS (SELECT 1 FROM card_catalog WHERE country = 'CN' AND bank_name = '浦发银行' AND card_name = '浦发运通车主卡');
UPDATE card_catalog SET image_url = CASE WHEN image_url IS NULL OR image_url LIKE '/images/cards/cardentify/%' THEN '/images/cards/cardentify/7f83e1af697b-d4eee2bcf1e9-7e1941d5.jpg' ELSE image_url END, network = COALESCE(network, 'AMEX'), tags = COALESCE(tags, 'Cardentify,信用卡,来源:云闪付'), notes = COALESCE(notes, 'Cardentify import; original bank: 浦发银行; type: Credit; source: 云闪付') WHERE country = 'CN' AND bank_name = '浦发银行' AND card_name = '浦发运通车主卡';

INSERT INTO card_catalog (country, bank_name, card_name, card_tier, network, tags, image_url, variants, annual_fee_cny, notes)
SELECT 'CN', '浦发银行', '浦发运通经典白金卡', 'Select', 'AMEX', 'Cardentify,信用卡,来源:云闪付', '/images/cards/cardentify/7f83e1af697b-2e9950f76b7d-ec108d92.jpg', NULL, NULL, 'Cardentify import; original bank: 浦发银行; type: Credit; source: 云闪付'
WHERE NOT EXISTS (SELECT 1 FROM card_catalog WHERE country = 'CN' AND bank_name = '浦发银行' AND card_name = '浦发运通经典白金卡');
UPDATE card_catalog SET image_url = CASE WHEN image_url IS NULL OR image_url LIKE '/images/cards/cardentify/%' THEN '/images/cards/cardentify/7f83e1af697b-2e9950f76b7d-ec108d92.jpg' ELSE image_url END, network = COALESCE(network, 'AMEX'), tags = COALESCE(tags, 'Cardentify,信用卡,来源:云闪付'), notes = COALESCE(notes, 'Cardentify import; original bank: 浦发银行; type: Credit; source: 云闪付') WHERE country = 'CN' AND bank_name = '浦发银行' AND card_name = '浦发运通经典白金卡';

INSERT INTO card_catalog (country, bank_name, card_name, card_tier, network, tags, image_url, variants, annual_fee_cny, notes)
SELECT 'CN', '浦发银行', '浦发运通新贵卡', '白金卡', 'AMEX', 'Cardentify,信用卡,来源:云闪付', '/images/cards/cardentify/7f83e1af697b-cd0c50a3b4ff-5c44c1a1.jpg', NULL, NULL, 'Cardentify import; original bank: 浦发银行; type: Credit; source: 云闪付'
WHERE NOT EXISTS (SELECT 1 FROM card_catalog WHERE country = 'CN' AND bank_name = '浦发银行' AND card_name = '浦发运通新贵卡');
UPDATE card_catalog SET image_url = CASE WHEN image_url IS NULL OR image_url LIKE '/images/cards/cardentify/%' THEN '/images/cards/cardentify/7f83e1af697b-cd0c50a3b4ff-5c44c1a1.jpg' ELSE image_url END, network = COALESCE(network, 'AMEX'), tags = COALESCE(tags, 'Cardentify,信用卡,来源:云闪付'), notes = COALESCE(notes, 'Cardentify import; original bank: 浦发银行; type: Credit; source: 云闪付') WHERE country = 'CN' AND bank_name = '浦发银行' AND card_name = '浦发运通新贵卡';

INSERT INTO card_catalog (country, bank_name, card_name, card_tier, network, tags, image_url, variants, annual_fee_cny, notes)
SELECT 'CN', '浦发银行', '长三角星耀', '普卡', 'UnionPay', 'Cardentify,借记卡,来源:Mi Pay', '/images/cards/cardentify/7f83e1af697b-151b1450f240-ec6f89bf.jpg', NULL, NULL, 'Cardentify import; original bank: 浦发银行; type: Debit; source: Mi Pay'
WHERE NOT EXISTS (SELECT 1 FROM card_catalog WHERE country = 'CN' AND bank_name = '浦发银行' AND card_name = '长三角星耀');
UPDATE card_catalog SET image_url = CASE WHEN image_url IS NULL OR image_url LIKE '/images/cards/cardentify/%' THEN '/images/cards/cardentify/7f83e1af697b-151b1450f240-ec6f89bf.jpg' ELSE image_url END, network = COALESCE(network, 'UnionPay'), tags = COALESCE(tags, 'Cardentify,借记卡,来源:Mi Pay'), notes = COALESCE(notes, 'Cardentify import; original bank: 浦发银行; type: Debit; source: Mi Pay') WHERE country = 'CN' AND bank_name = '浦发银行' AND card_name = '长三角星耀';

INSERT INTO card_catalog (country, bank_name, card_name, card_tier, network, tags, image_url, variants, annual_fee_cny, notes)
SELECT 'CN', '浦发银行', '浦浦发发星空版', '普卡', 'UnionPay', 'Cardentify,借记卡,来源:云闪付', '/images/cards/cardentify/7f83e1af697b-3d74c89246f1-e2b39e07.jpg', NULL, NULL, 'Cardentify import; original bank: 浦发银行; type: Debit; source: 云闪付'
WHERE NOT EXISTS (SELECT 1 FROM card_catalog WHERE country = 'CN' AND bank_name = '浦发银行' AND card_name = '浦浦发发星空版');
UPDATE card_catalog SET image_url = CASE WHEN image_url IS NULL OR image_url LIKE '/images/cards/cardentify/%' THEN '/images/cards/cardentify/7f83e1af697b-3d74c89246f1-e2b39e07.jpg' ELSE image_url END, network = COALESCE(network, 'UnionPay'), tags = COALESCE(tags, 'Cardentify,借记卡,来源:云闪付'), notes = COALESCE(notes, 'Cardentify import; original bank: 浦发银行; type: Debit; source: 云闪付') WHERE country = 'CN' AND bank_name = '浦发银行' AND card_name = '浦浦发发星空版';

INSERT INTO card_catalog (country, bank_name, card_name, card_tier, network, tags, image_url, variants, annual_fee_cny, notes)
SELECT 'CN', '浦发银行', '世界高度', '普卡', 'UnionPay', 'Cardentify,借记卡,来源:Mi Pay', '/images/cards/cardentify/7f83e1af697b-221e3fe1ddb9-21fd9c73.jpg', NULL, NULL, 'Cardentify import; original bank: 浦发银行; type: Debit; source: Mi Pay'
WHERE NOT EXISTS (SELECT 1 FROM card_catalog WHERE country = 'CN' AND bank_name = '浦发银行' AND card_name = '世界高度');
UPDATE card_catalog SET image_url = CASE WHEN image_url IS NULL OR image_url LIKE '/images/cards/cardentify/%' THEN '/images/cards/cardentify/7f83e1af697b-221e3fe1ddb9-21fd9c73.jpg' ELSE image_url END, network = COALESCE(network, 'UnionPay'), tags = COALESCE(tags, 'Cardentify,借记卡,来源:Mi Pay'), notes = COALESCE(notes, 'Cardentify import; original bank: 浦发银行; type: Debit; source: Mi Pay') WHERE country = 'CN' AND bank_name = '浦发银行' AND card_name = '世界高度';

INSERT INTO card_catalog (country, bank_name, card_name, card_tier, network, tags, image_url, variants, annual_fee_cny, notes)
SELECT 'CN', '浦发银行', '龙年生肖卡-龙仔贺岁', '普卡', 'UnionPay', 'Cardentify,借记卡,来源:云闪付', '/images/cards/cardentify/7f83e1af697b-6a485dc3483d-8fe9838d.jpg', NULL, NULL, 'Cardentify import; original bank: 浦发银行; type: Debit; source: 云闪付'
WHERE NOT EXISTS (SELECT 1 FROM card_catalog WHERE country = 'CN' AND bank_name = '浦发银行' AND card_name = '龙年生肖卡-龙仔贺岁');
UPDATE card_catalog SET image_url = CASE WHEN image_url IS NULL OR image_url LIKE '/images/cards/cardentify/%' THEN '/images/cards/cardentify/7f83e1af697b-6a485dc3483d-8fe9838d.jpg' ELSE image_url END, network = COALESCE(network, 'UnionPay'), tags = COALESCE(tags, 'Cardentify,借记卡,来源:云闪付'), notes = COALESCE(notes, 'Cardentify import; original bank: 浦发银行; type: Debit; source: 云闪付') WHERE country = 'CN' AND bank_name = '浦发银行' AND card_name = '龙年生肖卡-龙仔贺岁';

INSERT INTO card_catalog (country, bank_name, card_name, card_tier, network, tags, image_url, variants, annual_fee_cny, notes)
SELECT 'CN', '浦发银行', '无界卡', '普卡', 'UnionPay', 'Cardentify,借记卡,来源:Mi Pay', '/images/cards/cardentify/7f83e1af697b-b92e861ffa52-f1eacbb4.jpg', NULL, NULL, 'Cardentify import; original bank: 浦发银行; type: Debit; source: Mi Pay'
WHERE NOT EXISTS (SELECT 1 FROM card_catalog WHERE country = 'CN' AND bank_name = '浦发银行' AND card_name = '无界卡');
UPDATE card_catalog SET image_url = CASE WHEN image_url IS NULL OR image_url LIKE '/images/cards/cardentify/%' THEN '/images/cards/cardentify/7f83e1af697b-b92e861ffa52-f1eacbb4.jpg' ELSE image_url END, network = COALESCE(network, 'UnionPay'), tags = COALESCE(tags, 'Cardentify,借记卡,来源:Mi Pay'), notes = COALESCE(notes, 'Cardentify import; original bank: 浦发银行; type: Debit; source: Mi Pay') WHERE country = 'CN' AND bank_name = '浦发银行' AND card_name = '无界卡';

INSERT INTO card_catalog (country, bank_name, card_name, card_tier, network, tags, image_url, variants, annual_fee_cny, notes)
SELECT 'CN', '浦发银行', '蛇年贺岁 生肖系列借记卡', '普卡', 'UnionPay', 'Cardentify,借记卡,来源:云闪付,BIN:621792', '/images/cards/cardentify/7f83e1af697b-ad03e90fb16d-a92dee10.jpg', NULL, NULL, 'Cardentify import; original bank: 浦发银行; type: Debit; source: 云闪付'
WHERE NOT EXISTS (SELECT 1 FROM card_catalog WHERE country = 'CN' AND bank_name = '浦发银行' AND card_name = '蛇年贺岁 生肖系列借记卡');
UPDATE card_catalog SET image_url = CASE WHEN image_url IS NULL OR image_url LIKE '/images/cards/cardentify/%' THEN '/images/cards/cardentify/7f83e1af697b-ad03e90fb16d-a92dee10.jpg' ELSE image_url END, network = COALESCE(network, 'UnionPay'), tags = COALESCE(tags, 'Cardentify,借记卡,来源:云闪付,BIN:621792'), notes = COALESCE(notes, 'Cardentify import; original bank: 浦发银行; type: Debit; source: 云闪付') WHERE country = 'CN' AND bank_name = '浦发银行' AND card_name = '蛇年贺岁 生肖系列借记卡';

INSERT INTO card_catalog (country, bank_name, card_name, card_tier, network, tags, image_url, variants, annual_fee_cny, notes)
SELECT 'CN', '渣打银行 (中国)', '智通借记卡', '普卡', 'UnionPay', 'Cardentify,借记卡,来源:云闪付,BIN:622942/622994', '/images/cards/cardentify/e59e3fea5fc2-1cb27fe66090-69378d89.jpg', NULL, NULL, 'Cardentify import; original bank: 渣打银行 (中国); type: Debit; source: 云闪付'
WHERE NOT EXISTS (SELECT 1 FROM card_catalog WHERE country = 'CN' AND bank_name = '渣打银行 (中国)' AND card_name = '智通借记卡');
UPDATE card_catalog SET image_url = CASE WHEN image_url IS NULL OR image_url LIKE '/images/cards/cardentify/%' THEN '/images/cards/cardentify/e59e3fea5fc2-1cb27fe66090-69378d89.jpg' ELSE image_url END, network = COALESCE(network, 'UnionPay'), tags = COALESCE(tags, 'Cardentify,借记卡,来源:云闪付,BIN:622942/622994'), notes = COALESCE(notes, 'Cardentify import; original bank: 渣打银行 (中国); type: Debit; source: 云闪付') WHERE country = 'CN' AND bank_name = '渣打银行 (中国)' AND card_name = '智通借记卡';

INSERT INTO card_catalog (country, bank_name, card_name, card_tier, network, tags, image_url, variants, annual_fee_cny, notes)
SELECT 'CN', '渣打银行 (中国)', '优逸理财借记卡', '普卡', 'UnionPay', 'Cardentify,借记卡,来源:云闪付,BIN:622994', '/images/cards/cardentify/e59e3fea5fc2-5532b62f3af3-01229d07.jpg', NULL, NULL, 'Cardentify import; original bank: 渣打银行 (中国); type: Debit; source: 云闪付'
WHERE NOT EXISTS (SELECT 1 FROM card_catalog WHERE country = 'CN' AND bank_name = '渣打银行 (中国)' AND card_name = '优逸理财借记卡');
UPDATE card_catalog SET image_url = CASE WHEN image_url IS NULL OR image_url LIKE '/images/cards/cardentify/%' THEN '/images/cards/cardentify/e59e3fea5fc2-5532b62f3af3-01229d07.jpg' ELSE image_url END, network = COALESCE(network, 'UnionPay'), tags = COALESCE(tags, 'Cardentify,借记卡,来源:云闪付,BIN:622994'), notes = COALESCE(notes, 'Cardentify import; original bank: 渣打银行 (中国); type: Debit; source: 云闪付') WHERE country = 'CN' AND bank_name = '渣打银行 (中国)' AND card_name = '优逸理财借记卡';

INSERT INTO card_catalog (country, bank_name, card_name, card_tier, network, tags, image_url, variants, annual_fee_cny, notes)
SELECT 'CN', '渣打银行 (中国)', '优先理财白金借记卡', '白金卡', 'UnionPay', 'Cardentify,借记卡,来源:云闪付,BIN:622994', '/images/cards/cardentify/e59e3fea5fc2-460553e9a14a-eab56cf9.jpg', NULL, NULL, 'Cardentify import; original bank: 渣打银行 (中国); type: Debit; source: 云闪付'
WHERE NOT EXISTS (SELECT 1 FROM card_catalog WHERE country = 'CN' AND bank_name = '渣打银行 (中国)' AND card_name = '优先理财白金借记卡');
UPDATE card_catalog SET image_url = CASE WHEN image_url IS NULL OR image_url LIKE '/images/cards/cardentify/%' THEN '/images/cards/cardentify/e59e3fea5fc2-460553e9a14a-eab56cf9.jpg' ELSE image_url END, network = COALESCE(network, 'UnionPay'), tags = COALESCE(tags, 'Cardentify,借记卡,来源:云闪付,BIN:622994'), notes = COALESCE(notes, 'Cardentify import; original bank: 渣打银行 (中国); type: Debit; source: 云闪付') WHERE country = 'CN' AND bank_name = '渣打银行 (中国)' AND card_name = '优先理财白金借记卡';

INSERT INTO card_catalog (country, bank_name, card_name, card_tier, network, tags, image_url, variants, annual_fee_cny, notes)
SELECT 'CN', '渣打银行 (中国)', '优先私人理财钻石借记卡', '钻石卡', 'UnionPay', 'Cardentify,借记卡,来源:云闪付,BIN:622994', '/images/cards/cardentify/e59e3fea5fc2-3e1744361705-75109af8.jpg', NULL, NULL, 'Cardentify import; original bank: 渣打银行 (中国); type: Debit; source: 云闪付'
WHERE NOT EXISTS (SELECT 1 FROM card_catalog WHERE country = 'CN' AND bank_name = '渣打银行 (中国)' AND card_name = '优先私人理财钻石借记卡');
UPDATE card_catalog SET image_url = CASE WHEN image_url IS NULL OR image_url LIKE '/images/cards/cardentify/%' THEN '/images/cards/cardentify/e59e3fea5fc2-3e1744361705-75109af8.jpg' ELSE image_url END, network = COALESCE(network, 'UnionPay'), tags = COALESCE(tags, 'Cardentify,借记卡,来源:云闪付,BIN:622994'), notes = COALESCE(notes, 'Cardentify import; original bank: 渣打银行 (中国); type: Debit; source: 云闪付') WHERE country = 'CN' AND bank_name = '渣打银行 (中国)' AND card_name = '优先私人理财钻石借记卡';

INSERT INTO card_catalog (country, bank_name, card_name, card_tier, network, tags, image_url, variants, annual_fee_cny, notes)
SELECT 'CN', '渣打银行 (中国)', '携程优逸理财借记卡', '普卡', 'UnionPay', 'Cardentify,借记卡,来源:云闪付,BIN:622994', '/images/cards/cardentify/e59e3fea5fc2-a07f3f8920c0-63a9c97d.jpg', NULL, NULL, 'Cardentify import; original bank: 渣打银行 (中国); type: Debit; source: 云闪付'
WHERE NOT EXISTS (SELECT 1 FROM card_catalog WHERE country = 'CN' AND bank_name = '渣打银行 (中国)' AND card_name = '携程优逸理财借记卡');
UPDATE card_catalog SET image_url = CASE WHEN image_url IS NULL OR image_url LIKE '/images/cards/cardentify/%' THEN '/images/cards/cardentify/e59e3fea5fc2-a07f3f8920c0-63a9c97d.jpg' ELSE image_url END, network = COALESCE(network, 'UnionPay'), tags = COALESCE(tags, 'Cardentify,借记卡,来源:云闪付,BIN:622994'), notes = COALESCE(notes, 'Cardentify import; original bank: 渣打银行 (中国); type: Debit; source: 云闪付') WHERE country = 'CN' AND bank_name = '渣打银行 (中国)' AND card_name = '携程优逸理财借记卡';

INSERT INTO card_catalog (country, bank_name, card_name, card_tier, network, tags, image_url, variants, annual_fee_cny, notes)
SELECT 'CN', '渣打银行 (中国)', '携程优先理财白金借记卡', '白金卡', 'UnionPay', 'Cardentify,借记卡,来源:云闪付,BIN:622994', '/images/cards/cardentify/e59e3fea5fc2-2f6d704d3d69-93cb9ff7.jpg', NULL, NULL, 'Cardentify import; original bank: 渣打银行 (中国); type: Debit; source: 云闪付'
WHERE NOT EXISTS (SELECT 1 FROM card_catalog WHERE country = 'CN' AND bank_name = '渣打银行 (中国)' AND card_name = '携程优先理财白金借记卡');
UPDATE card_catalog SET image_url = CASE WHEN image_url IS NULL OR image_url LIKE '/images/cards/cardentify/%' THEN '/images/cards/cardentify/e59e3fea5fc2-2f6d704d3d69-93cb9ff7.jpg' ELSE image_url END, network = COALESCE(network, 'UnionPay'), tags = COALESCE(tags, 'Cardentify,借记卡,来源:云闪付,BIN:622994'), notes = COALESCE(notes, 'Cardentify import; original bank: 渣打银行 (中国); type: Debit; source: 云闪付') WHERE country = 'CN' AND bank_name = '渣打银行 (中国)' AND card_name = '携程优先理财白金借记卡';

INSERT INTO card_catalog (country, bank_name, card_name, card_tier, network, tags, image_url, variants, annual_fee_cny, notes)
SELECT 'TW', '台北富邦銀行', '富邦悍將Debit卡', '普卡', 'Mastercard', 'Cardentify,借记卡,来源:Apple Pay,BIN:550915', '/images/cards/cardentify/17d2682de937-debit-7ebaf9e4.jpg', NULL, NULL, 'Cardentify import; original bank: 台北富邦銀行; type: Debit; source: Apple Pay'
WHERE NOT EXISTS (SELECT 1 FROM card_catalog WHERE country = 'TW' AND bank_name = '台北富邦銀行' AND card_name = '富邦悍將Debit卡');
UPDATE card_catalog SET image_url = CASE WHEN image_url IS NULL OR image_url LIKE '/images/cards/cardentify/%' THEN '/images/cards/cardentify/17d2682de937-debit-7ebaf9e4.jpg' ELSE image_url END, network = COALESCE(network, 'Mastercard'), tags = COALESCE(tags, 'Cardentify,借记卡,来源:Apple Pay,BIN:550915'), notes = COALESCE(notes, 'Cardentify import; original bank: 台北富邦銀行; type: Debit; source: Apple Pay') WHERE country = 'TW' AND bank_name = '台北富邦銀行' AND card_name = '富邦悍將Debit卡';

INSERT INTO card_catalog (country, bank_name, card_name, card_tier, network, tags, image_url, variants, annual_fee_cny, notes)
SELECT 'TW', '台北富邦銀行', 'Costco聯名卡', '钛金卡', 'Mastercard', 'Cardentify,信用卡,来源:Apple Pay,BIN:524108', '/images/cards/cardentify/17d2682de937-costco-ae752440.jpg', NULL, NULL, 'Cardentify import; original bank: 台北富邦銀行; type: Credit; source: Apple Pay'
WHERE NOT EXISTS (SELECT 1 FROM card_catalog WHERE country = 'TW' AND bank_name = '台北富邦銀行' AND card_name = 'Costco聯名卡');
UPDATE card_catalog SET image_url = CASE WHEN image_url IS NULL OR image_url LIKE '/images/cards/cardentify/%' THEN '/images/cards/cardentify/17d2682de937-costco-ae752440.jpg' ELSE image_url END, network = COALESCE(network, 'Mastercard'), tags = COALESCE(tags, 'Cardentify,信用卡,来源:Apple Pay,BIN:524108'), notes = COALESCE(notes, 'Cardentify import; original bank: 台北富邦銀行; type: Credit; source: Apple Pay') WHERE country = 'TW' AND bank_name = '台北富邦銀行' AND card_name = 'Costco聯名卡';

INSERT INTO card_catalog (country, bank_name, card_name, card_tier, network, tags, image_url, variants, annual_fee_cny, notes)
SELECT 'TW', '台新銀行', '台新太陽御璽卡', '御玺卡', 'VISA', 'Cardentify,信用卡,来源:Apple Pay,BIN:414763', '/images/cards/cardentify/2d1cd2b189c5-02348797cd44-9f3f5d1b.jpg', NULL, NULL, 'Cardentify import; original bank: 台新銀行; type: Credit; source: Apple Pay'
WHERE NOT EXISTS (SELECT 1 FROM card_catalog WHERE country = 'TW' AND bank_name = '台新銀行' AND card_name = '台新太陽御璽卡');
UPDATE card_catalog SET image_url = CASE WHEN image_url IS NULL OR image_url LIKE '/images/cards/cardentify/%' THEN '/images/cards/cardentify/2d1cd2b189c5-02348797cd44-9f3f5d1b.jpg' ELSE image_url END, network = COALESCE(network, 'VISA'), tags = COALESCE(tags, 'Cardentify,信用卡,来源:Apple Pay,BIN:414763'), notes = COALESCE(notes, 'Cardentify import; original bank: 台新銀行; type: Credit; source: Apple Pay') WHERE country = 'TW' AND bank_name = '台新銀行' AND card_name = '台新太陽御璽卡';

INSERT INTO card_catalog (country, bank_name, card_name, card_tier, network, tags, image_url, variants, annual_fee_cny, notes)
SELECT 'TW', '台新銀行', '玫瑰Giving悠遊商務御璽卡', '御玺卡', 'VISA', 'Cardentify,信用卡,来源:Apple Pay,BIN:416205', '/images/cards/cardentify/2d1cd2b189c5-giving-d3515c55.jpg', NULL, NULL, 'Cardentify import; original bank: 台新銀行; type: Credit; source: Apple Pay'
WHERE NOT EXISTS (SELECT 1 FROM card_catalog WHERE country = 'TW' AND bank_name = '台新銀行' AND card_name = '玫瑰Giving悠遊商務御璽卡');
UPDATE card_catalog SET image_url = CASE WHEN image_url IS NULL OR image_url LIKE '/images/cards/cardentify/%' THEN '/images/cards/cardentify/2d1cd2b189c5-giving-d3515c55.jpg' ELSE image_url END, network = COALESCE(network, 'VISA'), tags = COALESCE(tags, 'Cardentify,信用卡,来源:Apple Pay,BIN:416205'), notes = COALESCE(notes, 'Cardentify import; original bank: 台新銀行; type: Credit; source: Apple Pay') WHERE country = 'TW' AND bank_name = '台新銀行' AND card_name = '玫瑰Giving悠遊商務御璽卡';

INSERT INTO card_catalog (country, bank_name, card_name, card_tier, network, tags, image_url, variants, annual_fee_cny, notes)
SELECT 'TW', '台新銀行', 'Gogoro Rewards商務御璽卡', '御玺卡', 'VISA', 'Cardentify,信用卡,来源:Apple Pay,BIN:416205', '/images/cards/cardentify/2d1cd2b189c5-gogoro-rewards-2a9ae788.jpg', NULL, NULL, 'Cardentify import; original bank: 台新銀行; type: Credit; source: Apple Pay'
WHERE NOT EXISTS (SELECT 1 FROM card_catalog WHERE country = 'TW' AND bank_name = '台新銀行' AND card_name = 'Gogoro Rewards商務御璽卡');
UPDATE card_catalog SET image_url = CASE WHEN image_url IS NULL OR image_url LIKE '/images/cards/cardentify/%' THEN '/images/cards/cardentify/2d1cd2b189c5-gogoro-rewards-2a9ae788.jpg' ELSE image_url END, network = COALESCE(network, 'VISA'), tags = COALESCE(tags, 'Cardentify,信用卡,来源:Apple Pay,BIN:416205'), notes = COALESCE(notes, 'Cardentify import; original bank: 台新銀行; type: Credit; source: Apple Pay') WHERE country = 'TW' AND bank_name = '台新銀行' AND card_name = 'Gogoro Rewards商務御璽卡';

INSERT INTO card_catalog (country, bank_name, card_name, card_tier, network, tags, image_url, variants, annual_fee_cny, notes)
SELECT 'TW', '台新銀行', '台新Flygo卡', '钛金卡', 'Mastercard', 'Cardentify,信用卡,来源:Apple Pay,BIN:414763', '/images/cards/cardentify/2d1cd2b189c5-flygo-0854f714.jpg', NULL, NULL, 'Cardentify import; original bank: 台新銀行; type: Credit; source: Apple Pay'
WHERE NOT EXISTS (SELECT 1 FROM card_catalog WHERE country = 'TW' AND bank_name = '台新銀行' AND card_name = '台新Flygo卡');
UPDATE card_catalog SET image_url = CASE WHEN image_url IS NULL OR image_url LIKE '/images/cards/cardentify/%' THEN '/images/cards/cardentify/2d1cd2b189c5-flygo-0854f714.jpg' ELSE image_url END, network = COALESCE(network, 'Mastercard'), tags = COALESCE(tags, 'Cardentify,信用卡,来源:Apple Pay,BIN:414763'), notes = COALESCE(notes, 'Cardentify import; original bank: 台新銀行; type: Credit; source: Apple Pay') WHERE country = 'TW' AND bank_name = '台新銀行' AND card_name = '台新Flygo卡';

INSERT INTO card_catalog (country, bank_name, card_name, card_tier, network, tags, image_url, variants, annual_fee_cny, notes)
SELECT 'TW', '台新銀行', '台新新光三越鈦金卡', '钛金卡', 'Mastercard', 'Cardentify,信用卡,来源:Apple Pay,BIN:552003', '/images/cards/cardentify/2d1cd2b189c5-84e0c6481935-2f89555d.jpg', NULL, NULL, 'Cardentify import; original bank: 台新銀行; type: Credit; source: Apple Pay'
WHERE NOT EXISTS (SELECT 1 FROM card_catalog WHERE country = 'TW' AND bank_name = '台新銀行' AND card_name = '台新新光三越鈦金卡');
UPDATE card_catalog SET image_url = CASE WHEN image_url IS NULL OR image_url LIKE '/images/cards/cardentify/%' THEN '/images/cards/cardentify/2d1cd2b189c5-84e0c6481935-2f89555d.jpg' ELSE image_url END, network = COALESCE(network, 'Mastercard'), tags = COALESCE(tags, 'Cardentify,信用卡,来源:Apple Pay,BIN:552003'), notes = COALESCE(notes, 'Cardentify import; original bank: 台新銀行; type: Credit; source: Apple Pay') WHERE country = 'TW' AND bank_name = '台新銀行' AND card_name = '台新新光三越鈦金卡';

INSERT INTO card_catalog (country, bank_name, card_name, card_tier, network, tags, image_url, variants, annual_fee_cny, notes)
SELECT 'TW', '台新銀行', '台新新光三越白金卡', '白金卡', 'Mastercard', 'Cardentify,信用卡,来源:Apple Pay,BIN:552003', '/images/cards/cardentify/2d1cd2b189c5-8b6339eb3980-eb727ec2.jpg', NULL, NULL, 'Cardentify import; original bank: 台新銀行; type: Credit; source: Apple Pay'
WHERE NOT EXISTS (SELECT 1 FROM card_catalog WHERE country = 'TW' AND bank_name = '台新銀行' AND card_name = '台新新光三越白金卡');
UPDATE card_catalog SET image_url = CASE WHEN image_url IS NULL OR image_url LIKE '/images/cards/cardentify/%' THEN '/images/cards/cardentify/2d1cd2b189c5-8b6339eb3980-eb727ec2.jpg' ELSE image_url END, network = COALESCE(network, 'Mastercard'), tags = COALESCE(tags, 'Cardentify,信用卡,来源:Apple Pay,BIN:552003'), notes = COALESCE(notes, 'Cardentify import; original bank: 台新銀行; type: Credit; source: Apple Pay') WHERE country = 'TW' AND bank_name = '台新銀行' AND card_name = '台新新光三越白金卡';

INSERT INTO card_catalog (country, bank_name, card_name, card_tier, network, tags, image_url, variants, annual_fee_cny, notes)
SELECT 'HK', '拍住賞', 'Tap N Go Card (Mastercard)', 'Prepaid', 'Mastercard', 'Cardentify,借记卡,来源:Apple Pay,BIN:559911', '/images/cards/cardentify/e882ef3132ed-tap-n-go-card-mastercard-0b7a5db3.jpg', NULL, NULL, 'Cardentify import; original bank: 拍住賞; type: Debit; source: Apple Pay'
WHERE NOT EXISTS (SELECT 1 FROM card_catalog WHERE country = 'HK' AND bank_name = '拍住賞' AND card_name = 'Tap N Go Card (Mastercard)');
UPDATE card_catalog SET image_url = CASE WHEN image_url IS NULL OR image_url LIKE '/images/cards/cardentify/%' THEN '/images/cards/cardentify/e882ef3132ed-tap-n-go-card-mastercard-0b7a5db3.jpg' ELSE image_url END, network = COALESCE(network, 'Mastercard'), tags = COALESCE(tags, 'Cardentify,借记卡,来源:Apple Pay,BIN:559911'), notes = COALESCE(notes, 'Cardentify import; original bank: 拍住賞; type: Debit; source: Apple Pay') WHERE country = 'HK' AND bank_name = '拍住賞' AND card_name = 'Tap N Go Card (Mastercard)';

INSERT INTO card_catalog (country, bank_name, card_name, card_tier, network, tags, image_url, variants, annual_fee_cny, notes)
SELECT 'HK', '拍住賞', 'Tap N Go Card (UnionPay)', 'Prepaid', 'UnionPay', 'Cardentify,借记卡,来源:Apple Pay,BIN:624468', '/images/cards/cardentify/e882ef3132ed-tap-n-go-card-unionpay-6986ffee.jpg', NULL, NULL, 'Cardentify import; original bank: 拍住賞; type: Debit; source: Apple Pay'
WHERE NOT EXISTS (SELECT 1 FROM card_catalog WHERE country = 'HK' AND bank_name = '拍住賞' AND card_name = 'Tap N Go Card (UnionPay)');
UPDATE card_catalog SET image_url = CASE WHEN image_url IS NULL OR image_url LIKE '/images/cards/cardentify/%' THEN '/images/cards/cardentify/e882ef3132ed-tap-n-go-card-unionpay-6986ffee.jpg' ELSE image_url END, network = COALESCE(network, 'UnionPay'), tags = COALESCE(tags, 'Cardentify,借记卡,来源:Apple Pay,BIN:624468'), notes = COALESCE(notes, 'Cardentify import; original bank: 拍住賞; type: Debit; source: Apple Pay') WHERE country = 'HK' AND bank_name = '拍住賞' AND card_name = 'Tap N Go Card (UnionPay)';

INSERT INTO card_catalog (country, bank_name, card_name, card_tier, network, tags, image_url, variants, annual_fee_cny, notes)
SELECT 'HK', '拍住賞', 'Tap N Go Card (Consumption Voucher)', 'Prepaid', 'UnionPay', 'Cardentify,借记卡,来源:Apple Pay,BIN:624468', '/images/cards/cardentify/e882ef3132ed-tap-n-go-card-consumption-voucher-5db8fbb9.jpg', NULL, NULL, 'Cardentify import; original bank: 拍住賞; type: Debit; source: Apple Pay'
WHERE NOT EXISTS (SELECT 1 FROM card_catalog WHERE country = 'HK' AND bank_name = '拍住賞' AND card_name = 'Tap N Go Card (Consumption Voucher)');
UPDATE card_catalog SET image_url = CASE WHEN image_url IS NULL OR image_url LIKE '/images/cards/cardentify/%' THEN '/images/cards/cardentify/e882ef3132ed-tap-n-go-card-consumption-voucher-5db8fbb9.jpg' ELSE image_url END, network = COALESCE(network, 'UnionPay'), tags = COALESCE(tags, 'Cardentify,借记卡,来源:Apple Pay,BIN:624468'), notes = COALESCE(notes, 'Cardentify import; original bank: 拍住賞; type: Debit; source: Apple Pay') WHERE country = 'HK' AND bank_name = '拍住賞' AND card_name = 'Tap N Go Card (Consumption Voucher)';

INSERT INTO card_catalog (country, bank_name, card_name, card_tier, network, tags, image_url, variants, annual_fee_cny, notes)
SELECT 'CN', '东亚银行 (中国)', '东亚银行两地通借记卡', '金卡', 'UnionPay', 'Cardentify,借记卡,来源:Apple Pay,BIN:622938', '/images/cards/cardentify/d40a3c5503ce-63071f3dcdd5-177deb22.jpg', NULL, NULL, 'Cardentify import; original bank: 东亚银行 (中国); type: Debit; source: Apple Pay'
WHERE NOT EXISTS (SELECT 1 FROM card_catalog WHERE country = 'CN' AND bank_name = '东亚银行 (中国)' AND card_name = '东亚银行两地通借记卡');
UPDATE card_catalog SET image_url = CASE WHEN image_url IS NULL OR image_url LIKE '/images/cards/cardentify/%' THEN '/images/cards/cardentify/d40a3c5503ce-63071f3dcdd5-177deb22.jpg' ELSE image_url END, network = COALESCE(network, 'UnionPay'), tags = COALESCE(tags, 'Cardentify,借记卡,来源:Apple Pay,BIN:622938'), notes = COALESCE(notes, 'Cardentify import; original bank: 东亚银行 (中国); type: Debit; source: Apple Pay') WHERE country = 'CN' AND bank_name = '东亚银行 (中国)' AND card_name = '东亚银行两地通借记卡';

INSERT INTO card_catalog (country, bank_name, card_name, card_tier, network, tags, image_url, variants, annual_fee_cny, notes)
SELECT 'HK', '香港上海滙豐銀行', 'HSBC Mastercard Debit 滙豐萬事達卡扣賬卡', '世界卡', 'Mastercard', 'Cardentify,借记卡,来源:Apple Pay,BIN:541375', '/images/cards/cardentify/e40fb17e9e38-hsbc-mastercard-debit-e31de373.jpg', NULL, NULL, 'Cardentify import; original bank: 香港上海滙豐銀行; type: Debit; source: Apple Pay'
WHERE NOT EXISTS (SELECT 1 FROM card_catalog WHERE country = 'HK' AND bank_name = '香港上海滙豐銀行' AND card_name = 'HSBC Mastercard Debit 滙豐萬事達卡扣賬卡');
UPDATE card_catalog SET image_url = CASE WHEN image_url IS NULL OR image_url LIKE '/images/cards/cardentify/%' THEN '/images/cards/cardentify/e40fb17e9e38-hsbc-mastercard-debit-e31de373.jpg' ELSE image_url END, network = COALESCE(network, 'Mastercard'), tags = COALESCE(tags, 'Cardentify,借记卡,来源:Apple Pay,BIN:541375'), notes = COALESCE(notes, 'Cardentify import; original bank: 香港上海滙豐銀行; type: Debit; source: Apple Pay') WHERE country = 'HK' AND bank_name = '香港上海滙豐銀行' AND card_name = 'HSBC Mastercard Debit 滙豐萬事達卡扣賬卡';

INSERT INTO card_catalog (country, bank_name, card_name, card_tier, network, tags, image_url, variants, annual_fee_cny, notes)
SELECT 'HK', '香港上海滙豐銀行', 'HSBC Mastercard Debit 滙豐萬事達卡扣賬卡 (新)', '世界卡', 'Mastercard', 'Cardentify,借记卡,来源:Apple Pay,BIN:541375', '/images/cards/cardentify/e40fb17e9e38-hsbc-mastercard-debit-3148febe.jpg', NULL, NULL, 'Cardentify import; original bank: 香港上海滙豐銀行; type: Debit; source: Apple Pay'
WHERE NOT EXISTS (SELECT 1 FROM card_catalog WHERE country = 'HK' AND bank_name = '香港上海滙豐銀行' AND card_name = 'HSBC Mastercard Debit 滙豐萬事達卡扣賬卡 (新)');
UPDATE card_catalog SET image_url = CASE WHEN image_url IS NULL OR image_url LIKE '/images/cards/cardentify/%' THEN '/images/cards/cardentify/e40fb17e9e38-hsbc-mastercard-debit-3148febe.jpg' ELSE image_url END, network = COALESCE(network, 'Mastercard'), tags = COALESCE(tags, 'Cardentify,借记卡,来源:Apple Pay,BIN:541375'), notes = COALESCE(notes, 'Cardentify import; original bank: 香港上海滙豐銀行; type: Debit; source: Apple Pay') WHERE country = 'HK' AND bank_name = '香港上海滙豐銀行' AND card_name = 'HSBC Mastercard Debit 滙豐萬事達卡扣賬卡 (新)';

INSERT INTO card_catalog (country, bank_name, card_name, card_tier, network, tags, image_url, variants, annual_fee_cny, notes)
SELECT 'HK', '香港上海滙豐銀行', 'HSBC Mastercard Debit 滙豐萬事達卡扣賬卡附屬卡', '世界卡', 'Mastercard', 'Cardentify,借记卡,来源:Samsung Pay,BIN:541375', '/images/cards/cardentify/e40fb17e9e38-hsbc-mastercard-debit-f5211c23.jpg', NULL, NULL, 'Cardentify import; original bank: 香港上海滙豐銀行; type: Debit; source: Samsung Pay'
WHERE NOT EXISTS (SELECT 1 FROM card_catalog WHERE country = 'HK' AND bank_name = '香港上海滙豐銀行' AND card_name = 'HSBC Mastercard Debit 滙豐萬事達卡扣賬卡附屬卡');
UPDATE card_catalog SET image_url = CASE WHEN image_url IS NULL OR image_url LIKE '/images/cards/cardentify/%' THEN '/images/cards/cardentify/e40fb17e9e38-hsbc-mastercard-debit-f5211c23.jpg' ELSE image_url END, network = COALESCE(network, 'Mastercard'), tags = COALESCE(tags, 'Cardentify,借记卡,来源:Samsung Pay,BIN:541375'), notes = COALESCE(notes, 'Cardentify import; original bank: 香港上海滙豐銀行; type: Debit; source: Samsung Pay') WHERE country = 'HK' AND bank_name = '香港上海滙豐銀行' AND card_name = 'HSBC Mastercard Debit 滙豐萬事達卡扣賬卡附屬卡';

INSERT INTO card_catalog (country, bank_name, card_name, card_tier, network, tags, image_url, variants, annual_fee_cny, notes)
SELECT 'HK', '香港上海滙豐銀行', 'HSBC One ATM Card 滙豐One自動櫃員機卡', '普卡', 'UnionPay', 'Cardentify,借记卡,来源:Apple Pay,BIN:621443', '/images/cards/cardentify/e40fb17e9e38-hsbc-one-atm-card-one-cdef0084.jpg', NULL, NULL, 'Cardentify import; original bank: 香港上海滙豐銀行; type: Debit; source: Apple Pay'
WHERE NOT EXISTS (SELECT 1 FROM card_catalog WHERE country = 'HK' AND bank_name = '香港上海滙豐銀行' AND card_name = 'HSBC One ATM Card 滙豐One自動櫃員機卡');
UPDATE card_catalog SET image_url = CASE WHEN image_url IS NULL OR image_url LIKE '/images/cards/cardentify/%' THEN '/images/cards/cardentify/e40fb17e9e38-hsbc-one-atm-card-one-cdef0084.jpg' ELSE image_url END, network = COALESCE(network, 'UnionPay'), tags = COALESCE(tags, 'Cardentify,借记卡,来源:Apple Pay,BIN:621443'), notes = COALESCE(notes, 'Cardentify import; original bank: 香港上海滙豐銀行; type: Debit; source: Apple Pay') WHERE country = 'HK' AND bank_name = '香港上海滙豐銀行' AND card_name = 'HSBC One ATM Card 滙豐One自動櫃員機卡';

INSERT INTO card_catalog (country, bank_name, card_name, card_tier, network, tags, image_url, variants, annual_fee_cny, notes)
SELECT 'HK', '香港上海滙豐銀行', 'HSBC Premier ATM Card 滙豐卓越理財自動櫃員機卡', '普卡', 'UnionPay', 'Cardentify,借记卡,来源:Apple Pay,BIN:621443', '/images/cards/cardentify/e40fb17e9e38-hsbc-premier-atm-card-2e0c4142.jpg', NULL, NULL, 'Cardentify import; original bank: 香港上海滙豐銀行; type: Debit; source: Apple Pay'
WHERE NOT EXISTS (SELECT 1 FROM card_catalog WHERE country = 'HK' AND bank_name = '香港上海滙豐銀行' AND card_name = 'HSBC Premier ATM Card 滙豐卓越理財自動櫃員機卡');
UPDATE card_catalog SET image_url = CASE WHEN image_url IS NULL OR image_url LIKE '/images/cards/cardentify/%' THEN '/images/cards/cardentify/e40fb17e9e38-hsbc-premier-atm-card-2e0c4142.jpg' ELSE image_url END, network = COALESCE(network, 'UnionPay'), tags = COALESCE(tags, 'Cardentify,借记卡,来源:Apple Pay,BIN:621443'), notes = COALESCE(notes, 'Cardentify import; original bank: 香港上海滙豐銀行; type: Debit; source: Apple Pay') WHERE country = 'HK' AND bank_name = '香港上海滙豐銀行' AND card_name = 'HSBC Premier ATM Card 滙豐卓越理財自動櫃員機卡';

INSERT INTO card_catalog (country, bank_name, card_name, card_tier, network, tags, image_url, variants, annual_fee_cny, notes)
SELECT 'HK', '香港上海滙豐銀行', 'HSBC Premier MasterCard 滙豐卓越理財信用卡', '世界卡', 'Mastercard', 'Cardentify,信用卡,来源:Apple Pay,BIN:518542', '/images/cards/cardentify/e40fb17e9e38-hsbc-premier-mastercard-c4ccf18a.jpg', NULL, NULL, 'Cardentify import; original bank: 香港上海滙豐銀行; type: Credit; source: Apple Pay'
WHERE NOT EXISTS (SELECT 1 FROM card_catalog WHERE country = 'HK' AND bank_name = '香港上海滙豐銀行' AND card_name = 'HSBC Premier MasterCard 滙豐卓越理財信用卡');
UPDATE card_catalog SET image_url = CASE WHEN image_url IS NULL OR image_url LIKE '/images/cards/cardentify/%' THEN '/images/cards/cardentify/e40fb17e9e38-hsbc-premier-mastercard-c4ccf18a.jpg' ELSE image_url END, network = COALESCE(network, 'Mastercard'), tags = COALESCE(tags, 'Cardentify,信用卡,来源:Apple Pay,BIN:518542'), notes = COALESCE(notes, 'Cardentify import; original bank: 香港上海滙豐銀行; type: Credit; source: Apple Pay') WHERE country = 'HK' AND bank_name = '香港上海滙豐銀行' AND card_name = 'HSBC Premier MasterCard 滙豐卓越理財信用卡';

INSERT INTO card_catalog (country, bank_name, card_name, card_tier, network, tags, image_url, variants, annual_fee_cny, notes)
SELECT 'HK', '香港上海滙豐銀行', 'HSBC Premier MasterCard 滙豐卓越理財信用卡 (Old)', '世界卡', 'Mastercard', 'Cardentify,信用卡,来源:Apple Pay,BIN:518542', '/images/cards/cardentify/e40fb17e9e38-hsbc-premier-mastercard-old-9f53e81c.jpg', NULL, NULL, 'Cardentify import; original bank: 香港上海滙豐銀行; type: Credit; source: Apple Pay'
WHERE NOT EXISTS (SELECT 1 FROM card_catalog WHERE country = 'HK' AND bank_name = '香港上海滙豐銀行' AND card_name = 'HSBC Premier MasterCard 滙豐卓越理財信用卡 (Old)');
UPDATE card_catalog SET image_url = CASE WHEN image_url IS NULL OR image_url LIKE '/images/cards/cardentify/%' THEN '/images/cards/cardentify/e40fb17e9e38-hsbc-premier-mastercard-old-9f53e81c.jpg' ELSE image_url END, network = COALESCE(network, 'Mastercard'), tags = COALESCE(tags, 'Cardentify,信用卡,来源:Apple Pay,BIN:518542'), notes = COALESCE(notes, 'Cardentify import; original bank: 香港上海滙豐銀行; type: Credit; source: Apple Pay') WHERE country = 'HK' AND bank_name = '香港上海滙豐銀行' AND card_name = 'HSBC Premier MasterCard 滙豐卓越理財信用卡 (Old)';

INSERT INTO card_catalog (country, bank_name, card_name, card_tier, network, tags, image_url, variants, annual_fee_cny, notes)
SELECT 'HK', '香港上海滙豐銀行', 'HSBC Red Credit Card 滙豐Red信用卡', '世界卡', 'Mastercard', 'Cardentify,信用卡,来源:Apple Pay,BIN:528946', '/images/cards/cardentify/e40fb17e9e38-hsbc-red-credit-card-red-3a911b6f.jpg', NULL, NULL, 'Cardentify import; original bank: 香港上海滙豐銀行; type: Credit; source: Apple Pay'
WHERE NOT EXISTS (SELECT 1 FROM card_catalog WHERE country = 'HK' AND bank_name = '香港上海滙豐銀行' AND card_name = 'HSBC Red Credit Card 滙豐Red信用卡');
UPDATE card_catalog SET image_url = CASE WHEN image_url IS NULL OR image_url LIKE '/images/cards/cardentify/%' THEN '/images/cards/cardentify/e40fb17e9e38-hsbc-red-credit-card-red-3a911b6f.jpg' ELSE image_url END, network = COALESCE(network, 'Mastercard'), tags = COALESCE(tags, 'Cardentify,信用卡,来源:Apple Pay,BIN:528946'), notes = COALESCE(notes, 'Cardentify import; original bank: 香港上海滙豐銀行; type: Credit; source: Apple Pay') WHERE country = 'HK' AND bank_name = '香港上海滙豐銀行' AND card_name = 'HSBC Red Credit Card 滙豐Red信用卡';

INSERT INTO card_catalog (country, bank_name, card_name, card_tier, network, tags, image_url, variants, annual_fee_cny, notes)
SELECT 'HK', '香港上海滙豐銀行', 'HSBC Dual Currency Diamond Credit Card', '钻石卡', 'UnionPay', 'Cardentify,信用卡,来源:Apple Pay,BIN:621067', '/images/cards/cardentify/e40fb17e9e38-hsbc-dual-currency-diamond-credit-card-056d0254.jpg', NULL, NULL, 'Cardentify import; original bank: 香港上海滙豐銀行; type: Credit; source: Apple Pay'
WHERE NOT EXISTS (SELECT 1 FROM card_catalog WHERE country = 'HK' AND bank_name = '香港上海滙豐銀行' AND card_name = 'HSBC Dual Currency Diamond Credit Card');
UPDATE card_catalog SET image_url = CASE WHEN image_url IS NULL OR image_url LIKE '/images/cards/cardentify/%' THEN '/images/cards/cardentify/e40fb17e9e38-hsbc-dual-currency-diamond-credit-card-056d0254.jpg' ELSE image_url END, network = COALESCE(network, 'UnionPay'), tags = COALESCE(tags, 'Cardentify,信用卡,来源:Apple Pay,BIN:621067'), notes = COALESCE(notes, 'Cardentify import; original bank: 香港上海滙豐銀行; type: Credit; source: Apple Pay') WHERE country = 'HK' AND bank_name = '香港上海滙豐銀行' AND card_name = 'HSBC Dual Currency Diamond Credit Card';

INSERT INTO card_catalog (country, bank_name, card_name, card_tier, network, tags, image_url, variants, annual_fee_cny, notes)
SELECT 'HK', '香港上海滙豐銀行', 'HSBC EveryMile Credit Card 滙豐EveryMile信用卡', '御玺卡', 'VISA', 'Cardentify,信用卡,来源:Apple Pay,BIN:436605', '/images/cards/cardentify/e40fb17e9e38-hsbc-everymile-credit-card-everymile-c4ea56cc.jpg', NULL, NULL, 'Cardentify import; original bank: 香港上海滙豐銀行; type: Credit; source: Apple Pay'
WHERE NOT EXISTS (SELECT 1 FROM card_catalog WHERE country = 'HK' AND bank_name = '香港上海滙豐銀行' AND card_name = 'HSBC EveryMile Credit Card 滙豐EveryMile信用卡');
UPDATE card_catalog SET image_url = CASE WHEN image_url IS NULL OR image_url LIKE '/images/cards/cardentify/%' THEN '/images/cards/cardentify/e40fb17e9e38-hsbc-everymile-credit-card-everymile-c4ea56cc.jpg' ELSE image_url END, network = COALESCE(network, 'VISA'), tags = COALESCE(tags, 'Cardentify,信用卡,来源:Apple Pay,BIN:436605'), notes = COALESCE(notes, 'Cardentify import; original bank: 香港上海滙豐銀行; type: Credit; source: Apple Pay') WHERE country = 'HK' AND bank_name = '香港上海滙豐銀行' AND card_name = 'HSBC EveryMile Credit Card 滙豐EveryMile信用卡';

INSERT INTO card_catalog (country, bank_name, card_name, card_tier, network, tags, image_url, variants, annual_fee_cny, notes)
SELECT 'HK', '香港上海滙豐銀行', 'HSBC Visa Signature Card 滙豐 Visa Signature 卡', '御玺卡', 'VISA', 'Cardentify,信用卡,来源:Apple Pay,BIN:496604', '/images/cards/cardentify/e40fb17e9e38-hsbc-visa-signature-card-visa-signature-01666065.jpg', NULL, NULL, 'Cardentify import; original bank: 香港上海滙豐銀行; type: Credit; source: Apple Pay'
WHERE NOT EXISTS (SELECT 1 FROM card_catalog WHERE country = 'HK' AND bank_name = '香港上海滙豐銀行' AND card_name = 'HSBC Visa Signature Card 滙豐 Visa Signature 卡');
UPDATE card_catalog SET image_url = CASE WHEN image_url IS NULL OR image_url LIKE '/images/cards/cardentify/%' THEN '/images/cards/cardentify/e40fb17e9e38-hsbc-visa-signature-card-visa-signature-01666065.jpg' ELSE image_url END, network = COALESCE(network, 'VISA'), tags = COALESCE(tags, 'Cardentify,信用卡,来源:Apple Pay,BIN:496604'), notes = COALESCE(notes, 'Cardentify import; original bank: 香港上海滙豐銀行; type: Credit; source: Apple Pay') WHERE country = 'HK' AND bank_name = '香港上海滙豐銀行' AND card_name = 'HSBC Visa Signature Card 滙豐 Visa Signature 卡';

INSERT INTO card_catalog (country, bank_name, card_name, card_tier, network, tags, image_url, variants, annual_fee_cny, notes)
SELECT 'JP', 'トヨタファイナンス', 'TS3カードレギュラー (JCB)', '普卡', 'JCB', 'Cardentify,信用卡,来源:Apple Pay,BIN:358746', '/images/cards/cardentify/79d584609d4e-ts3-jcb-956aba93.svg', NULL, NULL, 'Cardentify import; original bank: トヨタファイナンス; type: Credit; source: Apple Pay'
WHERE NOT EXISTS (SELECT 1 FROM card_catalog WHERE country = 'JP' AND bank_name = 'トヨタファイナンス' AND card_name = 'TS3カードレギュラー (JCB)');
UPDATE card_catalog SET image_url = CASE WHEN image_url IS NULL OR image_url LIKE '/images/cards/cardentify/%' THEN '/images/cards/cardentify/79d584609d4e-ts3-jcb-956aba93.svg' ELSE image_url END, network = COALESCE(network, 'JCB'), tags = COALESCE(tags, 'Cardentify,信用卡,来源:Apple Pay,BIN:358746'), notes = COALESCE(notes, 'Cardentify import; original bank: トヨタファイナンス; type: Credit; source: Apple Pay') WHERE country = 'JP' AND bank_name = 'トヨタファイナンス' AND card_name = 'TS3カードレギュラー (JCB)';

INSERT INTO card_catalog (country, bank_name, card_name, card_tier, network, tags, image_url, variants, annual_fee_cny, notes)
SELECT 'JP', 'トヨタファイナンス', 'TS3カードレギュラー (Mastercard)', '普卡', 'Mastercard', 'Cardentify,信用卡,来源:Apple Pay,BIN:557850', '/images/cards/cardentify/79d584609d4e-ts3-mastercard-d18cfd53.svg', NULL, NULL, 'Cardentify import; original bank: トヨタファイナンス; type: Credit; source: Apple Pay'
WHERE NOT EXISTS (SELECT 1 FROM card_catalog WHERE country = 'JP' AND bank_name = 'トヨタファイナンス' AND card_name = 'TS3カードレギュラー (Mastercard)');
UPDATE card_catalog SET image_url = CASE WHEN image_url IS NULL OR image_url LIKE '/images/cards/cardentify/%' THEN '/images/cards/cardentify/79d584609d4e-ts3-mastercard-d18cfd53.svg' ELSE image_url END, network = COALESCE(network, 'Mastercard'), tags = COALESCE(tags, 'Cardentify,信用卡,来源:Apple Pay,BIN:557850'), notes = COALESCE(notes, 'Cardentify import; original bank: トヨタファイナンス; type: Credit; source: Apple Pay') WHERE country = 'JP' AND bank_name = 'トヨタファイナンス' AND card_name = 'TS3カードレギュラー (Mastercard)';

INSERT INTO card_catalog (country, bank_name, card_name, card_tier, network, tags, image_url, variants, annual_fee_cny, notes)
SELECT 'JP', 'UCSカード', 'UCSカード', '普卡', 'Mastercard', 'Cardentify,信用卡,来源:Apple Pay,BIN:520856', '/images/cards/cardentify/ucs-ucs-0f04c303.svg', NULL, NULL, 'Cardentify import; original bank: UCSカード; type: Credit; source: Apple Pay'
WHERE NOT EXISTS (SELECT 1 FROM card_catalog WHERE country = 'JP' AND bank_name = 'UCSカード' AND card_name = 'UCSカード');
UPDATE card_catalog SET image_url = CASE WHEN image_url IS NULL OR image_url LIKE '/images/cards/cardentify/%' THEN '/images/cards/cardentify/ucs-ucs-0f04c303.svg' ELSE image_url END, network = COALESCE(network, 'Mastercard'), tags = COALESCE(tags, 'Cardentify,信用卡,来源:Apple Pay,BIN:520856'), notes = COALESCE(notes, 'Cardentify import; original bank: UCSカード; type: Credit; source: Apple Pay') WHERE country = 'JP' AND bank_name = 'UCSカード' AND card_name = 'UCSカード';

INSERT INTO card_catalog (country, bank_name, card_name, card_tier, network, tags, image_url, variants, annual_fee_cny, notes)
SELECT 'TW', '聯邦銀行', '聯邦賴點商務御璽卡', '御玺卡', 'VISA', 'Cardentify,信用卡,来源:Apple Pay,BIN:410523', '/images/cards/cardentify/132ece780ba0-0711c87e02df-1155c2bd.jpg', NULL, NULL, 'Cardentify import; original bank: 聯邦銀行; type: Credit; source: Apple Pay'
WHERE NOT EXISTS (SELECT 1 FROM card_catalog WHERE country = 'TW' AND bank_name = '聯邦銀行' AND card_name = '聯邦賴點商務御璽卡');
UPDATE card_catalog SET image_url = CASE WHEN image_url IS NULL OR image_url LIKE '/images/cards/cardentify/%' THEN '/images/cards/cardentify/132ece780ba0-0711c87e02df-1155c2bd.jpg' ELSE image_url END, network = COALESCE(network, 'VISA'), tags = COALESCE(tags, 'Cardentify,信用卡,来源:Apple Pay,BIN:410523'), notes = COALESCE(notes, 'Cardentify import; original bank: 聯邦銀行; type: Credit; source: Apple Pay') WHERE country = 'TW' AND bank_name = '聯邦銀行' AND card_name = '聯邦賴點商務御璽卡';

INSERT INTO card_catalog (country, bank_name, card_name, card_tier, network, tags, image_url, variants, annual_fee_cny, notes)
SELECT 'TW', '聯邦銀行', '聯邦幸福M悠遊鈦商卡', '钛金卡', 'Mastercard', 'Cardentify,信用卡,来源:Apple Pay,BIN:515709', '/images/cards/cardentify/132ece780ba0-m-8edfa34a.jpg', NULL, NULL, 'Cardentify import; original bank: 聯邦銀行; type: Credit; source: Apple Pay'
WHERE NOT EXISTS (SELECT 1 FROM card_catalog WHERE country = 'TW' AND bank_name = '聯邦銀行' AND card_name = '聯邦幸福M悠遊鈦商卡');
UPDATE card_catalog SET image_url = CASE WHEN image_url IS NULL OR image_url LIKE '/images/cards/cardentify/%' THEN '/images/cards/cardentify/132ece780ba0-m-8edfa34a.jpg' ELSE image_url END, network = COALESCE(network, 'Mastercard'), tags = COALESCE(tags, 'Cardentify,信用卡,来源:Apple Pay,BIN:515709'), notes = COALESCE(notes, 'Cardentify import; original bank: 聯邦銀行; type: Credit; source: Apple Pay') WHERE country = 'TW' AND bank_name = '聯邦銀行' AND card_name = '聯邦幸福M悠遊鈦商卡';

INSERT INTO card_catalog (country, bank_name, card_name, card_tier, network, tags, image_url, variants, annual_fee_cny, notes)
SELECT 'TW', '聯邦銀行', '聯邦全國一卡通御璽卡', '御玺卡', 'VISA', 'Cardentify,信用卡,来源:Apple Pay,BIN:463781', '/images/cards/cardentify/132ece780ba0-d8d9db76193a-dcd40ebd.jpg', NULL, NULL, 'Cardentify import; original bank: 聯邦銀行; type: Credit; source: Apple Pay'
WHERE NOT EXISTS (SELECT 1 FROM card_catalog WHERE country = 'TW' AND bank_name = '聯邦銀行' AND card_name = '聯邦全國一卡通御璽卡');
UPDATE card_catalog SET image_url = CASE WHEN image_url IS NULL OR image_url LIKE '/images/cards/cardentify/%' THEN '/images/cards/cardentify/132ece780ba0-d8d9db76193a-dcd40ebd.jpg' ELSE image_url END, network = COALESCE(network, 'VISA'), tags = COALESCE(tags, 'Cardentify,信用卡,来源:Apple Pay,BIN:463781'), notes = COALESCE(notes, 'Cardentify import; original bank: 聯邦銀行; type: Credit; source: Apple Pay') WHERE country = 'TW' AND bank_name = '聯邦銀行' AND card_name = '聯邦全國一卡通御璽卡';

INSERT INTO card_catalog (country, bank_name, card_name, card_tier, network, tags, image_url, variants, annual_fee_cny, notes)
SELECT 'CN', '微众银行', '微众卡', '普卡', 'UnionPay', 'Cardentify,借记卡,来源:云闪付', '/images/cards/cardentify/1ea09d3677ee-b49cf4c0b1c1-e25ef385.jpg', NULL, NULL, 'Cardentify import; original bank: 微众银行; type: Debit; source: 云闪付'
WHERE NOT EXISTS (SELECT 1 FROM card_catalog WHERE country = 'CN' AND bank_name = '微众银行' AND card_name = '微众卡');
UPDATE card_catalog SET image_url = CASE WHEN image_url IS NULL OR image_url LIKE '/images/cards/cardentify/%' THEN '/images/cards/cardentify/1ea09d3677ee-b49cf4c0b1c1-e25ef385.jpg' ELSE image_url END, network = COALESCE(network, 'UnionPay'), tags = COALESCE(tags, 'Cardentify,借记卡,来源:云闪付'), notes = COALESCE(notes, 'Cardentify import; original bank: 微众银行; type: Debit; source: 云闪付') WHERE country = 'CN' AND bank_name = '微众银行' AND card_name = '微众卡';

INSERT INTO card_catalog (country, bank_name, card_name, card_tier, network, tags, image_url, variants, annual_fee_cny, notes)
SELECT 'HK', '匯立銀行', 'WeLab Debit Card', '白金卡', 'Mastercard', 'Cardentify,借记卡,来源:Apple Pay,BIN:547974', '/images/cards/cardentify/4110d327678e-welab-debit-card-e0711549.jpg', NULL, NULL, 'Cardentify import; original bank: 匯立銀行; type: Debit; source: Apple Pay'
WHERE NOT EXISTS (SELECT 1 FROM card_catalog WHERE country = 'HK' AND bank_name = '匯立銀行' AND card_name = 'WeLab Debit Card');
UPDATE card_catalog SET image_url = CASE WHEN image_url IS NULL OR image_url LIKE '/images/cards/cardentify/%' THEN '/images/cards/cardentify/4110d327678e-welab-debit-card-e0711549.jpg' ELSE image_url END, network = COALESCE(network, 'Mastercard'), tags = COALESCE(tags, 'Cardentify,借记卡,来源:Apple Pay,BIN:547974'), notes = COALESCE(notes, 'Cardentify import; original bank: 匯立銀行; type: Debit; source: Apple Pay') WHERE country = 'HK' AND bank_name = '匯立銀行' AND card_name = 'WeLab Debit Card';

INSERT INTO card_catalog (country, bank_name, card_name, card_tier, network, tags, image_url, variants, annual_fee_cny, notes)
SELECT 'HK', '眾安銀行', 'ZA Card', '白金卡', 'VISA', 'Cardentify,借记卡,来源:Apple Pay,BIN:448060', '/images/cards/cardentify/d096408bc652-za-card-2d142e28.jpg', NULL, NULL, 'Cardentify import; original bank: 眾安銀行; type: Debit; source: Apple Pay'
WHERE NOT EXISTS (SELECT 1 FROM card_catalog WHERE country = 'HK' AND bank_name = '眾安銀行' AND card_name = 'ZA Card');
UPDATE card_catalog SET image_url = CASE WHEN image_url IS NULL OR image_url LIKE '/images/cards/cardentify/%' THEN '/images/cards/cardentify/d096408bc652-za-card-2d142e28.jpg' ELSE image_url END, network = COALESCE(network, 'VISA'), tags = COALESCE(tags, 'Cardentify,借记卡,来源:Apple Pay,BIN:448060'), notes = COALESCE(notes, 'Cardentify import; original bank: 眾安銀行; type: Debit; source: Apple Pay') WHERE country = 'HK' AND bank_name = '眾安銀行' AND card_name = 'ZA Card';

INSERT INTO card_catalog (country, bank_name, card_name, card_tier, network, tags, image_url, variants, annual_fee_cny, notes)
SELECT 'HK', '理慧銀行', 'livi Debit Mastercard', '普卡', 'Mastercard', 'Cardentify,借记卡,来源:PayPal,BIN:519018', '/images/cards/cardentify/016a66105317-livi-debit-mastercard-7b76a480.jpg', NULL, NULL, 'Cardentify import; original bank: 理慧銀行; type: Debit; source: PayPal'
WHERE NOT EXISTS (SELECT 1 FROM card_catalog WHERE country = 'HK' AND bank_name = '理慧銀行' AND card_name = 'livi Debit Mastercard');
UPDATE card_catalog SET image_url = CASE WHEN image_url IS NULL OR image_url LIKE '/images/cards/cardentify/%' THEN '/images/cards/cardentify/016a66105317-livi-debit-mastercard-7b76a480.jpg' ELSE image_url END, network = COALESCE(network, 'Mastercard'), tags = COALESCE(tags, 'Cardentify,借记卡,来源:PayPal,BIN:519018'), notes = COALESCE(notes, 'Cardentify import; original bank: 理慧銀行; type: Debit; source: PayPal') WHERE country = 'HK' AND bank_name = '理慧銀行' AND card_name = 'livi Debit Mastercard';

