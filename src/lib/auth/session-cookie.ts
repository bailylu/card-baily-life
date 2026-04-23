const SESSION_COOKIE = 'session';
const SESSION_TTL = 60 * 60 * 24 * 30; // 30 days

type CookieOptions = {
	path: string;
	httpOnly: boolean;
	secure: boolean;
	sameSite: 'lax';
	maxAge?: number;
};

type CookieSetter = {
	set(name: string, value: string, options: CookieOptions): void;
};

type CookieDeleter = {
	delete(name: string, options: Omit<CookieOptions, 'maxAge'>): void;
};

export function getSessionCookieName() {
	return SESSION_COOKIE;
}

export function getSessionTtl() {
	return SESSION_TTL;
}

export function setSessionCookie(
	cookies: CookieSetter,
	sessionId: string,
	secure = true
) {
	cookies.set(SESSION_COOKIE, sessionId, {
		path: '/',
		httpOnly: true,
		secure,
		sameSite: 'lax',
		maxAge: SESSION_TTL
	});
}

export function clearSessionCookie(cookies: CookieDeleter, secure = true) {
	cookies.delete(SESSION_COOKIE, {
		path: '/',
		httpOnly: true,
		secure,
		sameSite: 'lax'
	});
}
