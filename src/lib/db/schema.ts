import { sqliteTable, text, integer } from 'drizzle-orm/sqlite-core';

export const allowlist = sqliteTable('allowlist', {
	email: text('email').primaryKey(),
	note: text('note'),
	added_at: integer('added_at').notNull()
});

export const users = sqliteTable('users', {
	id: text('id').primaryKey(),
	email: text('email').unique().notNull(),
	password_hash: text('password_hash'),
	created_at: integer('created_at').notNull(),
	last_login_at: integer('last_login_at')
});

export const magic_links = sqliteTable('magic_links', {
	token: text('token').primaryKey(),
	email: text('email').notNull(),
	expires_at: integer('expires_at').notNull(),
	used_at: integer('used_at')
});

export const sessions = sqliteTable('sessions', {
	id: text('id').primaryKey(),
	user_id: text('user_id').notNull().references(() => users.id),
	expires_at: integer('expires_at').notNull(),
	created_at: integer('created_at').notNull()
});

export const card_catalog = sqliteTable('card_catalog', {
	id: integer('id').primaryKey({ autoIncrement: true }),
	country: text('country').notNull(),
	bank_name: text('bank_name').notNull(),
	card_name: text('card_name').notNull(),
	card_tier: text('card_tier'),
	network: text('network'),
	tags: text('tags'),
	image_url: text('image_url'),
	variants: text('variants'),
	annual_fee_cny: integer('annual_fee_cny'),
	notes: text('notes')
});

export const user_cards = sqliteTable('user_cards', {
	id: text('id').primaryKey(),
	user_id: text('user_id').notNull().references(() => users.id),
	catalog_id: integer('catalog_id').references(() => card_catalog.id),
	custom_name: text('custom_name'),
	last_four: text('last_four').notNull(),
	statement_day: integer('statement_day').notNull(),
	due_day: integer('due_day').notNull(),
	annual_fee_month: integer('annual_fee_month'),
	annual_fee_day: integer('annual_fee_day'),
	lead_days: integer('lead_days').notNull().default(3),
	remind_statement: integer('remind_statement').notNull().default(1),
	remind_due: integer('remind_due').notNull().default(1),
	remind_annual_fee: integer('remind_annual_fee').notNull().default(1),
	selected_image_url: text('selected_image_url'),
	created_at: integer('created_at').notNull()
});

export const card_requests = sqliteTable('card_requests', {
	id: text('id').primaryKey(),
	user_id: text('user_id').notNull().references(() => users.id),
	bank_name: text('bank_name').notNull(),
	card_name: text('card_name').notNull(),
	card_tier: text('card_tier'),
	notes: text('notes'),
	status: text('status').notNull().default('pending'),
	created_at: integer('created_at').notNull()
});

export const notification_channels = sqliteTable('notification_channels', {
	id: text('id').primaryKey(),
	user_id: text('user_id').notNull().references(() => users.id),
	type: text('type').notNull(),
	config: text('config').notNull(),
	enabled: integer('enabled').notNull().default(1),
	created_at: integer('created_at').notNull()
});

export const reminder_sent = sqliteTable('reminder_sent', {
	id: integer('id').primaryKey({ autoIncrement: true }),
	user_card_id: text('user_card_id').notNull(),
	reminder_type: text('reminder_type').notNull(),
	target_date: text('target_date').notNull(),
	channel: text('channel').notNull(),
	sent_at: integer('sent_at').notNull()
});
