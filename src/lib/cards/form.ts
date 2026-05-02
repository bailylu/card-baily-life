export type CardFormValues = {
	catalogId: number | null;
	customName: string | null;
	lastFour: string;
	statementDay: number;
	dueDay: number;
	annualFeeMonth: number | null;
	annualFeeDay: number | null;
	leadDays: number;
	remindStatement: boolean;
	remindDue: boolean;
	remindAnnualFee: boolean;
	selectedImageUrl: string | null;
};

export function parseCardForm(formData: FormData): { values?: CardFormValues; error?: string } {
	const catalogValue = `${formData.get('catalog_id') ?? ''}`;
	const customName = `${formData.get('custom_name') ?? ''}`.trim();
	const selectedImageUrl = `${formData.get('selected_image_url') ?? ''}`.trim() || null;
	const lastFour = `${formData.get('last_four') ?? ''}`.trim();
	const statementDay = Number(formData.get('statement_day'));
	const dueDay = Number(formData.get('due_day'));
	const annualFeeMonthValue = `${formData.get('annual_fee_month') ?? ''}`;
	const annualFeeDayValue = `${formData.get('annual_fee_day') ?? ''}`;
	const leadDays = Number(formData.get('lead_days') ?? 3);
	const remindStatement = formData.get('remind_statement') === '1';
	const remindDue = formData.get('remind_due') === '1';
	const remindAnnualFee = formData.get('remind_annual_fee') === '1';

	const catalogId = catalogValue ? Number(catalogValue) : null;
	const annualFeeMonth = annualFeeMonthValue ? Number(annualFeeMonthValue) : null;
	const annualFeeDay = annualFeeDayValue ? Number(annualFeeDayValue) : null;

	if (!catalogId) return { error: '请选择一张卡片' };
	if (!/^\d{4}$/.test(lastFour)) return { error: '卡片尾号需要填写 4 位数字' };
	if (!Number.isInteger(statementDay) || statementDay < 1 || statementDay > 31) {
		return { error: '账单日需要是 1-31 的数字' };
	}
	if (!Number.isInteger(dueDay) || dueDay < 1 || dueDay > 31) {
		return { error: '还款日需要是 1-31 的数字' };
	}
	if (
		annualFeeMonth !== null &&
		(!Number.isInteger(annualFeeMonth) || annualFeeMonth < 1 || annualFeeMonth > 12)
	) {
		return { error: '年费月份需要是 1-12 的数字' };
	}
	if (
		annualFeeDay !== null &&
		(!Number.isInteger(annualFeeDay) || annualFeeDay < 1 || annualFeeDay > 31)
	) {
		return { error: '年费日期需要是 1-31 的数字' };
	}
	if ((annualFeeMonth === null) !== (annualFeeDay === null)) {
		return { error: '年费月份和日期需要同时填写，或同时留空' };
	}
	if (!Number.isInteger(leadDays) || leadDays < 0 || leadDays > 30) {
		return { error: '提前提醒天数需要是 0-30 的数字' };
	}

	return {
		values: {
			catalogId,
			customName: customName || null,
			lastFour,
			statementDay,
			dueDay,
			annualFeeMonth,
			annualFeeDay,
			leadDays,
			remindStatement,
			remindDue,
			remindAnnualFee,
			selectedImageUrl
		}
	};
}
