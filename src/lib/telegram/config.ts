export function isTelegramLoginConfigured(): boolean {
  return Boolean(
    process.env.TELEGRAM_CLIENT_ID?.trim() && process.env.TELEGRAM_CLIENT_SECRET?.trim()
  );
}

export function readTelegramConfig(): { clientId: string; clientSecret: string } {
  const clientId = process.env.TELEGRAM_CLIENT_ID?.trim() ?? "";
  const clientSecret = process.env.TELEGRAM_CLIENT_SECRET?.trim() ?? "";
  if (!clientId || !clientSecret) {
    throw new Error("Telegram login is not configured");
  }
  return { clientId, clientSecret };
}

export function telegramServiceRoleKey(): string | null {
  const key =
    process.env.SUPABASE_SERVICE_ROLE_KEY?.trim() ||
    process.env.SUPABASE_SECRET_KEY?.trim() ||
    "";
  return key || null;
}
