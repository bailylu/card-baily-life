export type ReminderType = 'statement' | 'due' | 'annual_fee';

export type ReminderCard = {
	id: string;
	displayName: string;
	last_four: string;
	statement_day: number;
	due_day: number;
	annual_fee_month: number | null;
	annual_fee_day: number | null;
	lead_days: number;
};

export type ReminderPreview = {
	cardId: string;
	cardName: string;
	lastFour: string;
	type: ReminderType;
	typeLabel: string;
	targetDate: string;
	remindDate: string;
	daysUntilTarget: number;
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
		pushMonthlyTargets(targets, 'statement', card.statement_day, today);
		pushMonthlyTargets(targets, 'due', card.due_day, today);

		if (card.annual_fee_month && card.annual_fee_day) {
			for (let offset = 0; offset < 2; offset += 1) {
				targets.push({
					type: 'annual_fee',
					date: dateFromParts(today.getFullYear() + offset, card.annual_fee_month, card.annual_fee_day)
				});
			}
		}

		for (const target of targets) {
			const daysUntilTarget = diffDays(today, target.date);
			if (daysUntilTarget < 0 || daysUntilTarget > windowDays) continue;

			previews.push({
				cardId: card.id,
				cardName: card.displayName,
				lastFour: card.last_four,
				type: target.type,
				typeLabel: TYPE_LABELS[target.type],
				targetDate: formatDate(target.date),
				remindDate: formatDate(addDays(target.date, -card.lead_days)),
				daysUntilTarget
			});
		}
	}

	return previews.sort((left, right) => left.daysUntilTarget - right.daysUntilTarget);
}
