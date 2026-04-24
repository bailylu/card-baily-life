// @ts-nocheck
import test from 'node:test';
import assert from 'node:assert/strict';
import { getReminderPreview } from '../src/lib/cards/reminders.ts';

test('getReminderPreview clamps dates to the end of short months', () => {
	const previews = getReminderPreview(
		[
			{
				id: 'card-1',
				displayName: '测试卡',
				last_four: '0318',
				statement_day: 31,
				due_day: 30,
				annual_fee_month: null,
				annual_fee_day: null,
				lead_days: 3
			}
		],
		new Date(2027, 1, 1),
		30
	);

	assert.equal(previews[0].targetDate, '2027-02-28');
	assert.equal(previews[0].remindDate, '2027-02-25');
});

test('getReminderPreview returns annual fee reminders inside the window', () => {
	const previews = getReminderPreview(
		[
			{
				id: 'card-1',
				displayName: '测试卡',
				last_four: '0318',
				statement_day: 1,
				due_day: 2,
				annual_fee_month: 3,
				annual_fee_day: 18,
				lead_days: 7
			}
		],
		new Date(2027, 2, 1),
		30
	);

	assert.ok(previews.some((preview) => preview.type === 'annual_fee'));
	assert.ok(previews.some((preview) => preview.targetDate === '2027-03-18'));
});

test('getReminderPreview sorts by the nearest reminder date first', () => {
	const previews = getReminderPreview(
		[
			{
				id: 'card-late-target-early-remind',
				displayName: '提前提醒卡',
				last_four: '1111',
				statement_day: 15,
				due_day: 20,
				annual_fee_month: null,
				annual_fee_day: null,
				lead_days: 10
			},
			{
				id: 'card-early-target-late-remind',
				displayName: '当天提醒卡',
				last_four: '2222',
				statement_day: 10,
				due_day: 21,
				annual_fee_month: null,
				annual_fee_day: null,
				lead_days: 0
			}
		],
		new Date(2027, 2, 1),
		30
	);

	assert.equal(previews[0].cardId, 'card-late-target-early-remind');
	assert.equal(previews[0].remindDate, '2027-03-05');
});
