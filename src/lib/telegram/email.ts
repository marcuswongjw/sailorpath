/** Non-routable mailbox for Telegram-only accounts. RFC 2606 reserves `.invalid`. */
export const TELEGRAM_PLACEHOLDER_EMAIL_SUFFIX = "@telegram.sailorpath.invalid";

export function telegramPlaceholderEmail(id = crypto.randomUUID()): string {
  return `${id}${TELEGRAM_PLACEHOLDER_EMAIL_SUFFIX}`;
}

export function isTelegramPlaceholderEmail(email: string | null | undefined): boolean {
  const value = email?.trim().toLowerCase() ?? "";
  return (
    value.length > TELEGRAM_PLACEHOLDER_EMAIL_SUFFIX.length &&
    value.endsWith(TELEGRAM_PLACEHOLDER_EMAIL_SUFFIX)
  );
}

/**
 * Address we may show or mail. Telegram does not provide one, and the
 * placeholder used to satisfy GoTrue is not a contact address.
 */
export function contactEmail(
  profileEmail: string | null | undefined,
  authEmail: string | null | undefined
): string {
  const profile = profileEmail?.trim() ?? "";
  if (profile && !isTelegramPlaceholderEmail(profile)) return profile;
  const auth = authEmail?.trim() ?? "";
  if (auth && !isTelegramPlaceholderEmail(auth)) return auth;
  return "";
}

/** Disconnecting Telegram is safe only when another real sign-in email exists. */
export function canDisconnectTelegram(authEmail: string | null | undefined): boolean {
  return contactEmail(null, authEmail).length > 0;
}
