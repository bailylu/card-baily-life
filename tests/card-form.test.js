// @ts-nocheck
import test from 'node:test';
import assert from 'node:assert/strict';
import { parseCardForm } from '../src/lib/cards/form.ts';

function form(values) {
	const formData = new FormData();
	for (const [key, value] of Object.entries(values)) {
		formData.set(key, value);
	}
	return formData;
}

test('parseCardForm accepts a catalog card with annual fee date', () => {
	const result = parseCardForm(
		form({
			catalog_id: '12',
			custom_name: '',
			last_four: '0318',
			statement_day: '5',
			due_day: '23',
			annual_fee_month: '3',
			annual_fee_day: '18',
			lead_days: '3'
		})
	);

	assert.deepEqual(result.values, {
		catalogId: 12,
		customName: null,
		lastFour: '0318',
		statementDay: 5,
		dueDay: 23,
		annualFeeMonth: 3,
		annualFeeDay: 18,
		leadDays: 3
	});
});

test('parseCardForm accepts a custom card without annual fee date', () => {
	const result = parseCardForm(
		form({
			catalog_id: '',
			custom_name: '测试卡',
			last_four: '8888',
			statement_day: '12',
			due_day: '30',
			annual_fee_month: '',
			annual_fee_day: '',
			lead_days: '5'
		})
	);

	assert.equal(result.values?.customName, '测试卡');
	assert.equal(result.values?.annualFeeMonth, null);
	assert.equal(result.values?.annualFeeDay, null);
});

test('parseCardForm rejects invalid card tail number', () => {
	const result = parseCardForm(
		form({
			catalog_id: '1',
			last_four: '88',
			statement_day: '12',
			due_day: '30',
			lead_days: '3'
		})
	);

	assert.equal(result.error, '卡片尾号需要填写 4 位数字');
});

test('parseCardForm requires annual fee month and day together', () => {
	const result = parseCardForm(
		form({
			catalog_id: '1',
			last_four: '8888',
			statement_day: '12',
			due_day: '30',
			annual_fee_month: '8',
			annual_fee_day: '',
			lead_days: '3'
		})
	);

	assert.equal(result.error, '年费月份和日期需要同时填写，或同时留空');
});
