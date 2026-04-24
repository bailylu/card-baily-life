ALTER TABLE card_catalog ADD COLUMN network TEXT;
ALTER TABLE card_catalog ADD COLUMN tags TEXT;

INSERT INTO card_catalog (country, bank_name, card_name, card_tier, network, tags, notes)
SELECT 'CN', '民生银行', '百夫长', '白金', '运通', '权益卡', '无限 PP 卡、高额延误险、1800 积点、赠送副卡 900 点、积分可兑换权益和万豪积分。'
WHERE NOT EXISTS (SELECT 1 FROM card_catalog WHERE bank_name = '民生银行' AND card_name = '百夫长');

INSERT INTO card_catalog (country, bank_name, card_name, card_tier, network, tags, notes)
SELECT 'CN', '工商银行', '环球白（上海）', '白金', 'Master Card / 银联', '权益卡', '无限机场/高铁自营贵宾厅，按 M 会员等级获得龙腾、快速安检、接送机等权益。'
WHERE NOT EXISTS (SELECT 1 FROM card_catalog WHERE bank_name = '工商银行' AND card_name = '环球白（上海）');

INSERT INTO card_catalog (country, bank_name, card_name, card_tier, network, tags, notes)
SELECT 'CN', '招商银行', '经典白金卡', '白金', 'VISA / 银联', '权益卡,返利卡', '300 酒店、机场贵宾厅、体检、洗牙、高尔夫、积分兑换亚万。'
WHERE NOT EXISTS (SELECT 1 FROM card_catalog WHERE bank_name = '招商银行' AND card_name = '经典白金卡');

INSERT INTO card_catalog (country, bank_name, card_name, card_tier, network, tags, notes)
SELECT 'CN', '建设银行', '尊享白金（大山白）', '白金', 'VISA / 银联', '权益卡', '贵宾厅、体检、龙腾、酒店、接送机、代驾、延误险等权益。'
WHERE NOT EXISTS (SELECT 1 FROM card_catalog WHERE bank_name = '建设银行' AND card_name = '尊享白金（大山白）');

INSERT INTO card_catalog (country, bank_name, card_name, card_tier, network, tags, notes)
SELECT 'CN', '农业银行', '东航银联（大白）', '白金', '银联', '权益卡,联名卡', '东航积分兑换，农行大白贵宾厅/贵宾楼权益。'
WHERE NOT EXISTS (SELECT 1 FROM card_catalog WHERE bank_name = '农业银行' AND card_name = '东航银联（大白）');

INSERT INTO card_catalog (country, bank_name, card_name, card_tier, network, tags, notes)
SELECT 'CN', '农业银行', '东航 VISA（小白）', '白金', 'VISA', '联名卡', '东航积分兑换，适合境外消费，已绝版。'
WHERE NOT EXISTS (SELECT 1 FROM card_catalog WHERE bank_name = '农业银行' AND card_name = '东航 VISA（小白）');

INSERT INTO card_catalog (country, bank_name, card_name, card_tier, network, tags, notes)
SELECT 'CN', '农业银行', '车尊白', '白金', '银联', '权益卡,返利卡', '代驾、洗车、道路救援等车主权益。'
WHERE NOT EXISTS (SELECT 1 FROM card_catalog WHERE bank_name = '农业银行' AND card_name = '车尊白');

INSERT INTO card_catalog (country, bank_name, card_name, card_tier, network, tags, notes)
SELECT 'CN', '浙商银行', '长龙航空联名白金', '白金', '银联', '联名卡', '长龙航空积分兑换、机票折扣、赠送银卡。'
WHERE NOT EXISTS (SELECT 1 FROM card_catalog WHERE bank_name = '浙商银行' AND card_name = '长龙航空联名白金');

INSERT INTO card_catalog (country, bank_name, card_name, card_tier, network, tags, notes)
SELECT 'CN', '民生银行', 'ANA 民生', '联名卡', 'JCB / 银联', '联名卡', 'ANA 积分兑换、优先值机、免税店优惠、IHG 酒店相关权益。'
WHERE NOT EXISTS (SELECT 1 FROM card_catalog WHERE bank_name = '民生银行' AND card_name = 'ANA 民生');

INSERT INTO card_catalog (country, bank_name, card_name, card_tier, network, tags, notes)
SELECT 'CN', '建设银行', '东航睿我万事达', '联名卡', 'Master Card', '联名卡', '东航积分兑换，境外线下刷卡有效。'
WHERE NOT EXISTS (SELECT 1 FROM card_catalog WHERE bank_name = '建设银行' AND card_name = '东航睿我万事达');

INSERT INTO card_catalog (country, bank_name, card_name, card_tier, network, tags, notes)
SELECT 'CN', '建设银行', 'muse', '返现卡', 'VISA', '抽屉卡', '境外消费返现，全球支付无货币兑换手续费。'
WHERE NOT EXISTS (SELECT 1 FROM card_catalog WHERE bank_name = '建设银行' AND card_name = 'muse');

INSERT INTO card_catalog (country, bank_name, card_name, card_tier, network, tags, notes)
SELECT 'CN', '中信银行', '运通 Safari', '白金', '运通', '权益卡', '消费达标获得积分，可兑换权益。'
WHERE NOT EXISTS (SELECT 1 FROM card_catalog WHERE bank_name = '中信银行' AND card_name = '运通 Safari');

INSERT INTO card_catalog (country, bank_name, card_name, card_tier, network, tags, notes)
SELECT 'CN', '中信银行', '万事达 i 白金', '白金', 'Master Card / 银联', '返利卡', '周/月返利活动，日常消费买菜卡。'
WHERE NOT EXISTS (SELECT 1 FROM card_catalog WHERE bank_name = '中信银行' AND card_name = '万事达 i 白金');

INSERT INTO card_catalog (country, bank_name, card_name, card_tier, network, tags, notes)
SELECT 'CN', '浙商银行', '红利卡', '返利卡', '银联', '返利卡', '消费达标返利。'
WHERE NOT EXISTS (SELECT 1 FROM card_catalog WHERE bank_name = '浙商银行' AND card_name = '红利卡');

INSERT INTO card_catalog (country, bank_name, card_name, card_tier, network, tags, notes)
SELECT 'CN', '广发银行', '有鱼卡', '返利卡', '银联', '返利卡', '美团、抖音、得物等消费返利。'
WHERE NOT EXISTS (SELECT 1 FROM card_catalog WHERE bank_name = '广发银行' AND card_name = '有鱼卡');

INSERT INTO card_catalog (country, bank_name, card_name, card_tier, network, tags, notes)
SELECT 'CN', '广发银行', '华为车', '返利卡', '银联', '返利卡', '返利活动，需要在 App 内报名。'
WHERE NOT EXISTS (SELECT 1 FROM card_catalog WHERE bank_name = '广发银行' AND card_name = '华为车');

INSERT INTO card_catalog (country, bank_name, card_name, card_tier, network, tags, notes)
SELECT 'CN', '广发银行', '车主白', '白金', '银联', '返利卡', '加油、抵用券、返利相关车主权益。'
WHERE NOT EXISTS (SELECT 1 FROM card_catalog WHERE bank_name = '广发银行' AND card_name = '车主白');

INSERT INTO card_catalog (country, bank_name, card_name, card_tier, network, tags, notes)
SELECT 'CN', '广发银行', '奕驾白', '白金', '银联', '返利卡,权益卡', '返利、高铁机场贵宾厅、高铁餐食、龙腾机场贵宾等权益。'
WHERE NOT EXISTS (SELECT 1 FROM card_catalog WHERE bank_name = '广发银行' AND card_name = '奕驾白');

INSERT INTO card_catalog (country, bank_name, card_name, card_tier, network, tags, notes)
SELECT 'CN', '民生银行', 'MORE 世界卡', '世界卡', 'Master Card', '抽屉卡', '消费返现，携程钻石会员等权益。'
WHERE NOT EXISTS (SELECT 1 FROM card_catalog WHERE bank_name = '民生银行' AND card_name = 'MORE 世界卡');

INSERT INTO card_catalog (country, bank_name, card_name, card_tier, network, tags, notes)
SELECT 'CN', '浦发银行', '东航金', '金卡', '银联', '联名卡', '东航积分累计，已注销/活动申请卡。'
WHERE NOT EXISTS (SELECT 1 FROM card_catalog WHERE bank_name = '浦发银行' AND card_name = '东航金');

INSERT INTO card_catalog (country, bank_name, card_name, card_tier, network, tags, notes)
SELECT 'CN', '工商银行', '东航联名金', '金卡', 'Master Card / 银联', '联名卡', '东航积分累计，境外有分。'
WHERE NOT EXISTS (SELECT 1 FROM card_catalog WHERE bank_name = '工商银行' AND card_name = '东航联名金');

INSERT INTO card_catalog (country, bank_name, card_name, card_tier, network, tags, notes)
SELECT 'CN', '招商银行', 'young 卡（羊毛卡）', '金卡', '银联', '火种卡', '生日月消费活动，30 岁以下办理。'
WHERE NOT EXISTS (SELECT 1 FROM card_catalog WHERE bank_name = '招商银行' AND card_name = 'young 卡（羊毛卡）');

INSERT INTO card_catalog (country, bank_name, card_name, card_tier, network, tags, notes)
SELECT 'CN', '招商银行', 'JCB 全币种', '全币种', 'JCB', '火种卡', '日本 JCB 贵宾厅，东南亚和日本可用。'
WHERE NOT EXISTS (SELECT 1 FROM card_catalog WHERE bank_name = '招商银行' AND card_name = 'JCB 全币种');

INSERT INTO card_catalog (country, bank_name, card_name, card_tier, network, tags, notes)
SELECT 'CN', '中信银行', '万豪联名（龙年）', '联名卡', '银联', '联名卡,返利卡', '万豪房晚、积分累计、酒店消费积分、订房优惠，已绝版。'
WHERE NOT EXISTS (SELECT 1 FROM card_catalog WHERE bank_name = '中信银行' AND card_name = '万豪联名（龙年）');

INSERT INTO card_catalog (country, bank_name, card_name, card_tier, network, tags, notes)
SELECT 'CN', '中信银行', '东航 VISA 卡', '联名卡', 'VISA', '联名卡', '东航积分兑换，每月积分上限。'
WHERE NOT EXISTS (SELECT 1 FROM card_catalog WHERE bank_name = '中信银行' AND card_name = '东航 VISA 卡');

INSERT INTO card_catalog (country, bank_name, card_name, card_tier, network, tags, notes)
SELECT 'CN', '中信银行', '国泰航空', '联名卡', 'Master Card', '联名卡', '国泰里程兑换，月里程上限。'
WHERE NOT EXISTS (SELECT 1 FROM card_catalog WHERE bank_name = '中信银行' AND card_name = '国泰航空');

INSERT INTO card_catalog (country, bank_name, card_name, card_tier, network, tags, notes)
SELECT 'CN', '中信银行', '悦卡（金）', '金卡', '银联', '抽屉卡', '积分倍率，存款达标可作为主力卡。'
WHERE NOT EXISTS (SELECT 1 FROM card_catalog WHERE bank_name = '中信银行' AND card_name = '悦卡（金）');

INSERT INTO card_catalog (country, bank_name, card_name, card_tier, network, tags, notes)
SELECT 'CN', '浙商银行', '车主卡', '车主卡', '银联', '返利卡', '洗车、停车优惠等车主权益。'
WHERE NOT EXISTS (SELECT 1 FROM card_catalog WHERE bank_name = '浙商银行' AND card_name = '车主卡');

INSERT INTO card_catalog (country, bank_name, card_name, card_tier, network, tags, notes)
SELECT 'CN', '广发银行', 'Visa 鼎极无限卡 2024 巴黎奥运版', '无限卡', 'VISA', '抽屉卡', 'VISA 鼎极 infinite 级别。'
WHERE NOT EXISTS (SELECT 1 FROM card_catalog WHERE bank_name = '广发银行' AND card_name = 'Visa 鼎极无限卡 2024 巴黎奥运版');

INSERT INTO card_catalog (country, bank_name, card_name, card_tier, network, tags, notes)
SELECT 'CN', '广发银行', '东航 IHG 三方联名卡', '联名卡', '银联', '联名卡', '东航/IHG/广发积分累计，无限次高铁贵宾厅。'
WHERE NOT EXISTS (SELECT 1 FROM card_catalog WHERE bank_name = '广发银行' AND card_name = '东航 IHG 三方联名卡');

INSERT INTO card_catalog (country, bank_name, card_name, card_tier, network, tags, notes)
SELECT 'CN', '上海银行', '东航白金', '白金', '银联', '联名卡', '东航积分兑换，月里程上限。'
WHERE NOT EXISTS (SELECT 1 FROM card_catalog WHERE bank_name = '上海银行' AND card_name = '东航白金');
