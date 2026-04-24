const ITERATIONS = 120_000;
const KEY_LENGTH_BITS = 256;

function bytesToBase64(bytes: Uint8Array) {
	let binary = '';
	for (const byte of bytes) binary += String.fromCharCode(byte);
	return btoa(binary);
}

function base64ToBytes(base64: string) {
	const binary = atob(base64);
	const bytes = new Uint8Array(binary.length);
	for (let index = 0; index < binary.length; index += 1) {
		bytes[index] = binary.charCodeAt(index);
	}
	return bytes;
}

async function derive(password: string, salt: Uint8Array, iterations: number) {
	const saltBuffer = new Uint8Array(salt).buffer;
	const key = await crypto.subtle.importKey(
		'raw',
		new TextEncoder().encode(password),
		'PBKDF2',
		false,
		['deriveBits']
	);
	const bits = await crypto.subtle.deriveBits(
		{
			name: 'PBKDF2',
			hash: 'SHA-256',
			salt: saltBuffer,
			iterations
		},
		key,
		KEY_LENGTH_BITS
	);
	return new Uint8Array(bits);
}

export async function hashPassword(password: string) {
	const salt = crypto.getRandomValues(new Uint8Array(16));
	const hash = await derive(password, salt, ITERATIONS);
	return `pbkdf2-sha256$${ITERATIONS}$${bytesToBase64(salt)}$${bytesToBase64(hash)}`;
}

export async function verifyPassword(password: string, storedHash: string) {
	const [algorithm, iterationsValue, saltValue, hashValue] = storedHash.split('$');
	if (algorithm !== 'pbkdf2-sha256' || !iterationsValue || !saltValue || !hashValue) return false;

	const iterations = Number(iterationsValue);
	if (!Number.isInteger(iterations) || iterations <= 0) return false;

	const expected = base64ToBytes(hashValue);
	const actual = await derive(password, base64ToBytes(saltValue), iterations);
	if (actual.length !== expected.length) return false;

	let difference = 0;
	for (let index = 0; index < actual.length; index += 1) {
		difference |= actual[index] ^ expected[index];
	}
	return difference === 0;
}
