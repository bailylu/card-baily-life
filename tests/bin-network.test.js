// @ts-nocheck
import test from 'node:test';
import assert from 'node:assert/strict';
import { detectNetwork, normalizeBinInput, isValidBin } from '../src/lib/bin/network.ts';

test('detectNetwork 识别主流卡组织', () => {
	assert.equal(detectNetwork('453242').id, 'visa');
	assert.equal(detectNetwork('552853').id, 'mastercard');
	assert.equal(detectNetwork('222100').id, 'mastercard');
	assert.equal(detectNetwork('378282').id, 'amex');
	assert.equal(detectNetwork('352800').id, 'jcb');
	assert.equal(detectNetwork('601100').id, 'discover');
	assert.equal(detectNetwork('300000').id, 'diners');
});

test('detectNetwork 把 62 段判成银联而不是 Discover', () => {
	assert.equal(detectNetwork('622202').id, 'unionpay');
	// 622126-622925 是银联与 Discover 的共用段，面向国内用户优先判银联
	assert.equal(detectNetwork('622126').id, 'unionpay');
	assert.equal(detectNetwork('621700').id, 'unionpay');
});

test('detectNetwork 对无法识别的前缀返回 null', () => {
	assert.equal(detectNetwork('999999'), null);
	assert.equal(detectNetwork(''), null);
});

test('normalizeBinInput 剥离非数字并截断到 8 位', () => {
	assert.equal(normalizeBinInput('5323 9214 0000 0077'), '53239214');
	assert.equal(normalizeBinInput('4532-4242'), '45324242');
	assert.equal(normalizeBinInput('abc622202xyz'), '622202');
});

test('normalizeBinInput 保证完整卡号无法被提交', () => {
	const full = '5323921400000077';
	const normalized = normalizeBinInput(full);
	assert.equal(normalized.length, 8);
	assert.ok(!normalized.includes('0077'));
});

test('isValidBin 只接受 6-8 位数字', () => {
	assert.equal(isValidBin('622202'), true);
	assert.equal(isValidBin('62220212'), true);
	assert.equal(isValidBin('62220'), false);
	assert.equal(isValidBin('622202123'), false);
	assert.equal(isValidBin('62220a'), false);
});
