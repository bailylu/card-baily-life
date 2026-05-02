export type ReminderType = 'statement' | 'due' | 'annual_fee';

export type ReminderCard = {
	id: string;
	displayName: string;
	catalogName: string | null;
	bank_name: string | null;
	last_four: string;
	statement_day: number;
	due_day: number;
	annual_fee_month: number | null;
	annual_fee_day: number | null;
	lead_days: number;
	remind_statement: boolean;
	remind_due: boolean;
	remind_annual_fee: boolean;
};

// 这些银行所有卡共用同一账单日/还款日，同日期只发一条通知
const UNIFIED_BILLING_BANKS = [
	'建设银行', '交通银行', '广发银行', '中信银行', '光大银行', '渣打银行', '花旗银行'
];

function isUnifiedBillingBank(bankName: string | null): boolean {
	if (!bankName) return false;
	return UNIFIED_BILLING_BANKS.some((key) => bankName.includes(key));
}

export type ReminderPreview = {
	cardId: string;
	cardName: string;
	catalogName: string | null;
	lastFour: string;
	type: ReminderType;
	typeLabel: string;
	targetDate: string;
	remindDate: string;
	daysUntilTarget: number;
	daysUntilRemind: number;
};

const TYPE_LABELS: Record<ReminderType, string> = {
	statement: '账单日',
	due: '还款日',
	annual_fee: '年费日'
};

function daysInMonth(year: number, month: number) {
	return new Date(year, month, 0).getDate();
}

function formatDate(date: Date) {
	const year = date.getFullYear();
	const month = `${date.getMonth() + 1}`.padStart(2, '0');
	const day = `${date.getDate()}`.padStart(2, '0');
	return `${year}-${month}-${day}`;
}

function clampDay(year: number, month: number, day: number) {
	return Math.min(day, daysInMonth(year, month));
}

function dateFromParts(year: number, month: number, day: number) {
	return new Date(year, month - 1, clampDay(year, month, day));
}

function addDays(date: Date, days: number) {
	const next = new Date(date);
	next.setDate(next.getDate() + days);
	return next;
}

function diffDays(from: Date, to: Date) {
	const start = new Date(from.getFullYear(), from.getMonth(), from.getDate()).getTime();
	const end = new Date(to.getFullYear(), to.getMonth(), to.getDate()).getTime();
	return Math.round((end - start) / 86_400_000);
}

function pushMonthlyTargets(
	targets: Array<{ type: ReminderType; date: Date }>,
	type: ReminderType,
	day: number,
	today: Date
) {
	for (let offset = 0; offset < 3; offset += 1) {
		const monthDate = new Date(today.getFullYear(), today.getMonth() + offset, 1);
		targets.push({
			type,
			date: dateFromParts(monthDate.getFullYear(), monthDate.getMonth() + 1, day)
		});
	}
}

export function getReminderPreview(cards: ReminderCard[], today = new Date(), windowDays = 30) {
	const previews: ReminderPreview[] = [];

	for (const card of cards) {
		const targets: Array<{ type: ReminderType; date: Date }> = [];
		if (card.remind_statement) pushMonthlyTargets(targets, 'statement', card.statement_day, today);
		if (card.remind_due) pushMonthlyTargets(targets, 'due', card.due_day, today);

		if (card.remind_annual_fee && card.annual_fee_month && card.annual_fee_day) {
			for (let offset = 0; offset < 2; offset += 1) {
				targets.push({
					type: 'annual_fee',
					date: dateFromParts(today.getFullYear() + offset, card.annual_fee_month, card.annual_fee_day)
				});
			}
		}

		for (const target of targets) {
			const daysUntilTarget = diffDays(today, target.date);
			const remindDate = addDays(target.date, -card.lead_days);
			const daysUntilRemind = diffDays(today, remindDate);
			if (daysUntilTarget < 0 || daysUntilRemind < 0 || daysUntilRemind > windowDays) continue;

				previews.push({
					cardId: card.id,
					cardName: card.displayName,
					catalogName: card.catalogName,
					lastFour: card.last_four,
					type: target.type,
				typeLabel: TYPE_LABELS[target.type],
				targetDate: formatDate(target.date),
				remindDate: formatDate(remindDate),
				daysUntilTarget,
				daysUntilRemind
			});
		}
	}

	// 合并统一账单银行：同银行、同类型、同目标日期 → 只保留一条，卡名改为「XX银行（N张合并）」
	const merged: ReminderPreview[] = [];
	const seen = new Map<string, { index: number; count: number }>();
	for (const preview of previews) {
		const bankName = cards.find((c) => c.id === preview.cardId)?.bank_name ?? null;
		if (isUnifiedBillingBank(bankName) && (preview.type === 'statement' || preview.type === 'due')) {
			const key = `${bankName}|${preview.type}|${preview.targetDate}`;
			const existing = seen.get(key);
			if (existing) {
				if (existing.count === 1) {
					merged[existing.index].cardName = `${bankName}合并账单`;
					merged[existing.index].catalogName = null;
					merged[existing.index].lastFour = '';
				}
				existing.count += 1;
			} else {
				seen.set(key, { index: merged.length, count: 1 });
				merged.push({ ...preview });
			}
		} else {
			merged.push(preview);
		}
	}

	return merged.sort(
		(left, right) =>
			left.daysUntilRemind - right.daysUntilRemind ||
			left.daysUntilTarget - right.daysUntilTarget ||
			left.cardName.localeCompare(right.cardName, 'zh-CN')
	);
}
