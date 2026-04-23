import type { users } from '$lib/db/schema';
import type { InferSelectModel } from 'drizzle-orm';

declare global {
	namespace App {
		interface Platform {
			env: {
				DB: D1Database;
				APP_URL: string;
			};
		}
		interface Locals {
			user: InferSelectModel<typeof users> | null;
		}
	}
}

export {};
