type AdminNotificationEnv = {
	ADMIN_TELEGRAM_BOT_TOKEN?: string;
	ADMIN_TELEGRAM_CHAT_ID?: string;
	APP_URL?: string;
};

type CardRequestNotification = {
	userEmail: string;
	bankName: string;
	cardName: string;
	cardTier: string;
	notes: string;
};

function escapeHtml(value: string) {
	return value
		.replaceAll('&', '&amp;')
		.replaceAll('<', '&lt;')
		.replaceAll('>', '&gt;');
}

export async function notifyAdminCardRequest(
	env: AdminNotificationEnv,
	request: CardRequestNotification
) {
	const botToken = env.ADMIN_TELEGRAM_BOT_TOKEN?.trim();
	const chatId = env.ADMIN_TELEGRAM_CHAT_ID?.trim();
	if (!botToken || !chatId) return;

	const lines = [
		'<b>贝利卡管家：新的卡片入库申请</b>',
		`用户：${escapeHtml(request.userEmail)}`,
		`银行：${escapeHtml(request.bankName)}`,
		`卡名：${escapeHtml(request.cardName)}`,
		request.cardTier ? `等级：${escapeHtml(request.cardTier)}` : '',
		request.notes ? `说明：${escapeHtml(request.notes)}` : '',
		env.APP_URL ? `站点：${escapeHtml(env.APP_URL)}` : ''
	].filter(Boolean);

	const response = await fetch(`https://api.telegram.org/bot${botToken}/sendMessage`, {
		method: 'POST',
		headers: { 'content-type': 'application/json' },
		body: JSON.stringify({
			chat_id: chatId,
			text: lines.join('\n'),
			parse_mode: 'HTML',
			disable_web_page_preview: true
		})
	});

	if (!response.ok) {
		throw new Error('Admin Telegram notification failed');
	}
}
