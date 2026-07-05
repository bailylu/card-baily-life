import type { users } from '$lib/db/schema';
import type { AuthObject } from '@clerk/backend';
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
				MINIMAX_API_KEY?: string;
				MINIMAX_API_BASE_URL?: string;
				MINIMAX_MODEL?: string;
				PUBLIC_CLERK_PUBLISHABLE_KEY?: string;
				PUBLIC_CLERK_SIGN_UP_URL?: string;
				PUBLIC_CLERK_SIGN_IN_FALLBACK_REDIRECT_URL?: string;
				PUBLIC_CLERK_SIGN_UP_FALLBACK_REDIRECT_URL?: string;
				PUBLIC_CLERK_ACCOUNT_PORTAL_URL?: string;
				PUBLIC_CLERK_SIGN_IN_URL?: string;
				CLERK_SECRET_KEY?: string;
			};
		}
		interface Locals {
			auth: (options?: Record<string, unknown>) => AuthObject;
			user: InferSelectModel<typeof users> | null;
		}
	}
}

export {};
