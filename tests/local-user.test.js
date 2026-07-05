// @ts-nocheck

import test from 'node:test';
import assert from 'node:assert/strict';

import { getPrimaryEmailFromClerkUser, resolveLocalUserFromEmail } from '../src/lib/auth/local-user.ts';

function createStore(users = []) {
	const rows = users.map((user) => ({ ...user }));
	const calls = [];
	return {
		calls,
		async findByEmail(email) {
			calls.push(['findByEmail', email]);
			return rows.find((user) => user.email === email) ?? null;
		},
		async createUser(email, now) {
			calls.push(['createUser', email, now]);
			const user = {
				id: `BL-NEW-${rows.length + 1}`,
				email,
				password_hash: null,
				created_at: now,
				last_login_at: now
			};
			rows.push(user);
			return user;
		},
		async updateLastLogin(userId, now) {
			calls.push(['updateLastLogin', userId, now]);
			const user = rows.find((row) => row.id === userId);
			if (user) user.last_login_at = now;
		}
	};
}

test('getPrimaryEmailFromClerkUser returns the primary Clerk email in lowercase', () => {
	const email = getPrimaryEmailFromClerkUser({
		primaryEmailAddressId: 'email_2',
		emailAddresses: [
			{ id: 'email_1', emailAddress: 'first@example.com' },
			{ id: 'email_2', emailAddress: 'BailyTalk0318@GMAIL.COM' }
		]
	});

	assert.equal(email, 'bailytalk0318@gmail.com');
});

test('getPrimaryEmailFromClerkUser returns null when Clerk has no usable email', () => {
	assert.equal(getPrimaryEmailFromClerkUser({ emailAddresses: [] }), null);
	assert.equal(getPrimaryEmailFromClerkUser(null), null);
});

test('resolveLocalUserFromEmail reuses an existing D1 user for a matching email', async () => {
	const now = 1_777_000_000;
	const existing = {
		id: 'BL-EXISTING',
		email: 'bailytalk0318@gmail.com',
		password_hash: 'legacy-password',
		created_at: 1,
		last_login_at: 2
	};
	const store = createStore([existing]);

	const user = await resolveLocalUserFromEmail(store, ' BailyTalk0318@GMAIL.COM ', now);

	assert.equal(user.id, 'BL-EXISTING');
	assert.equal(user.email, 'bailytalk0318@gmail.com');
	assert.deepEqual(store.calls, [
		['findByEmail', 'bailytalk0318@gmail.com'],
		['updateLastLogin', 'BL-EXISTING', now]
	]);
});

test('resolveLocalUserFromEmail creates a D1 user for a new Clerk email', async () => {
	const now = 1_777_000_010;
	const store = createStore();

	const user = await resolveLocalUserFromEmail(store, 'new-user@example.com', now);

	assert.equal(user.id, 'BL-NEW-1');
	assert.equal(user.email, 'new-user@example.com');
	assert.equal(user.created_at, now);
	assert.deepEqual(store.calls, [
		['findByEmail', 'new-user@example.com'],
		['createUser', 'new-user@example.com', now]
	]);
});

test('resolveLocalUserFromEmail returns null for missing email', async () => {
	const store = createStore();

	const user = await resolveLocalUserFromEmail(store, '', 1_777_000_020);

	assert.equal(user, null);
	assert.deepEqual(store.calls, []);
});
