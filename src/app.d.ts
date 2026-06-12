import type { users } from '$lib/db/schema';
import type { InferSelectModel } from 'drizzle-orm';

declare global {
	namespace App {
		interface Platform {
			env: {
				DB: D1Database;
				APP_URL: string;
				ADMIN_EMAIL?: string;
				ADMIN_TELEGRAM_BOT_TOKEN?: string;
				ADMIN_TELEGRAM_CHAT_ID?: string;
				CRM_API_BASE?: string;
				CRM_API_KEY?: string;
				PUBLIC_CLERK_ACCOUNT_PORTAL_URL?: string;
				PUBLIC_CLERK_SIGN_IN_URL?: string;
			};
		}
		interface Locals {
			user: InferSelectModel<typeof users> | null;
		}
	}
}

export {};
