// 按卡号前缀（IIN）在本地判断卡组织。
// 这段规则是公开且稳定的行业标准，不需要联网，也不消耗 binlist 额度，
// 所以即使外部接口限流或宕机，BIN 查询页仍然能给出卡组织和长度校验。

export type CardNetwork = {
	id: string;
	name: string;
	nameEn: string;
	/** 该卡组织常见的完整卡号长度 */
	lengths: number[];
};

type Rule = CardNetwork & {
	/** 直接前缀匹配 */
	prefixes?: string[];
	/** 数值区间匹配：[起, 止, 取前几位] */
	ranges?: Array<[number, number, number]>;
};

// 顺序有意义：银联放最前面，因为 622126-622925 是银联与 Discover 的共用段，
// 面向国内用户时判成银联更准。
const RULES: Rule[] = [
	{
		id: 'unionpay',
		name: '银联',
		nameEn: 'UnionPay',
		lengths: [16, 17, 18, 19],
		ranges: [
			[62, 62, 2],
			[81, 81, 2]
		]
	},
	{
		id: 'visa',
		name: 'Visa',
		nameEn: 'Visa',
		lengths: [13, 16, 19],
		prefixes: ['4']
	},
	{
		id: 'mastercard',
		name: '万事达',
		nameEn: 'Mastercard',
		lengths: [16],
		ranges: [
			[51, 55, 2],
			[2221, 2720, 4]
		]
	},
	{
		id: 'amex',
		name: '美国运通',
		nameEn: 'American Express',
		lengths: [15],
		prefixes: ['34', '37']
	},
	{
		id: 'jcb',
		name: 'JCB',
		nameEn: 'JCB',
		lengths: [16, 17, 18, 19],
		ranges: [[3528, 3589, 4]]
	},
	{
		id: 'diners',
		name: '大来卡',
		nameEn: 'Diners Club',
		lengths: [14, 16, 19],
		prefixes: ['36', '38'],
		ranges: [
			[300, 305, 3],
			[3095, 3095, 4]
		]
	},
	{
		id: 'maestro',
		name: 'Maestro',
		nameEn: 'Maestro',
		lengths: [12, 13, 14, 15, 16, 17, 18, 19],
		prefixes: ['5018', '5020', '5038', '5893', '6304', '6759', '6761', '6762', '6763']
	},
	{
		id: 'discover',
		name: 'Discover',
		nameEn: 'Discover',
		lengths: [16, 19],
		prefixes: ['6011', '65'],
		ranges: [[644, 649, 3]]
	}
];

function matches(rule: Rule, digits: string) {
	for (const prefix of rule.prefixes ?? []) {
		if (digits.length >= prefix.length && digits.startsWith(prefix)) return true;
	}
	for (const [start, end, len] of rule.ranges ?? []) {
		if (digits.length < len) continue;
		const value = Number(digits.slice(0, len));
		if (value >= start && value <= end) return true;
	}
	return false;
}

/** 只看前缀判断卡组织，输入不足时返回 null。 */
export function detectNetwork(digits: string): CardNetwork | null {
	const clean = digits.replace(/\D/g, '');
	if (!clean) return null;

	for (const rule of RULES) {
		if (matches(rule, clean)) {
			const { prefixes: _p, ranges: _r, ...network } = rule;
			return network;
		}
	}
	return null;
}

/** 把用户输入清洗成最多 8 位数字。完整卡号绝不会离开输入框。 */
export function normalizeBinInput(raw: string): string {
	return raw.replace(/\D/g, '').slice(0, 8);
}

export const BIN_MIN_LENGTH = 6;
export const BIN_MAX_LENGTH = 8;

export function isValidBin(digits: string): boolean {
	return new RegExp(`^\\d{${BIN_MIN_LENGTH},${BIN_MAX_LENGTH}}$`).test(digits);
}
