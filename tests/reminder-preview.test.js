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
