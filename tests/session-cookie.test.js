// @ts-nocheck

import test from 'node:test';
import assert from 'node:assert/strict';

import { clearSessionCookie, setSessionCookie } from '../src/lib/auth/session-cookie.ts';

test('setSessionCookie defaults to a secure session cookie', () => {
	const calls = [];
	const cookies = {
		set(name, value, options) {
			calls.push({ name, value, options });
		}
	};

	setSessionCookie(cookies, 'session-token');

	assert.equal(calls.length, 1);
	assert.deepEqual(calls[0], {
		name: 'session',
		value: 'session-token',
		options: {
			path: '/',
			httpOnly: true,
			secure: true,
			sameSite: 'lax',
			maxAge: 60 * 60 * 24 * 30
		}
	});
});

test('setSessionCookie can disable secure cookies for local http development', () => {
	const calls = [];
	const cookies = {
		set(name, value, options) {
			calls.push({ name, value, options });
		}
	};

	setSessionCookie(cookies, 'session-token', false);

	assert.equal(calls.length, 1);
	assert.equal(calls[0]?.options.secure, false);
});

test('clearSessionCookie mirrors the secure flag when expiring the cookie', () => {
	const calls = [];
	const cookies = {
		delete(name, options) {
			calls.push({ name, options });
		}
	};

	clearSessionCookie(cookies, false);

	assert.equal(calls.length, 1);
	assert.deepEqual(calls[0], {
		name: 'session',
		options: {
			path: '/',
			httpOnly: true,
			secure: false,
			sameSite: 'lax'
		}
	});
});
