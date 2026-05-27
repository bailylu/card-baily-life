// @ts-nocheck
import assert from 'node:assert/strict';
import test from 'node:test';

import { filterReminderPreviewsBySettings } from '../src/lib/notifications/reminder-dispatch.ts';

const baseSettings = {
	barkKey: 'bark-key',
	telegramBotToken: '',
	telegramChatId: '',
	pushPlusToken: '',
	statementEnabled: true,
	dueEnabled: true,
	annualFeeEnabled: true,
	benefitActivityEnabled: false
};

const previews = [
	{ type: 'statement', cardName: '账单卡' },
	{ type: 'due', cardName: '还款卡' },
	{ type: 'annual_fee', cardName: '年费卡' }
];

test('filterReminderPreviewsBySettings keeps enabled reminder categories', () => {
	const result = filterReminderPreviewsBySettings(previews, {
		...baseSettings,
		statementEnabled: false,
		annualFeeEnabled: false
	});

	assert.deepEqual(
		result.map((preview) => preview.type),
		['due']
	);
});

test('filterReminderPreviewsBySettings removes all disabled reminder categories', () => {
	const result = filterReminderPreviewsBySettings(previews, {
		...baseSettings,
		statementEnabled: false,
		dueEnabled: false,
		annualFeeEnabled: false
	});

	assert.deepEqual(result, []);
});
