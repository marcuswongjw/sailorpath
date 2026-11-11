export function isTelegramBotConfigured(): boolean {
  return Boolean(
    process.env.TELEGRAM_BOT_TOKEN?.trim() &&
      process.env.TELEGRAM_BOT_USERNAME?.trim() &&
      process.env.TELEGRAM_WEBHOOK_SECRET?.trim()
  );
}

export function readTelegramBotConfig(): {
  token: string;
  username: string;
  webhookSecret: string;
} {
  const token = process.env.TELEGRAM_BOT_TOKEN?.trim() ?? "";
  const username = process.env.TELEGRAM_BOT_USERNAME?.trim().replace(/^@/, "") ?? "";
  const webhookSecret = process.env.TELEGRAM_WEBHOOK_SECRET?.trim() ?? "";
  if (!token || !username || !webhookSecret) {
    throw new Error("Telegram bot is not configured");
  }
  return { token, username, webhookSecret };
}

export function telegramBotLink(username: string, token: string): string {
  const handle = username.trim().replace(/^@/, "");
  return `https://t.me/${encodeURIComponent(handle)}?start=${encodeURIComponent(token)}`;
}
