export function shortUid(uid: string) {
	if (uid.startsWith('BL-')) return uid;
	return `BL-${uid.replace(/-/g, '').slice(0, 8).toUpperCase()}`;
}
