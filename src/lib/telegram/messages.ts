export const TELEGRAM_LOGIN_ERRORS: Record<string, string> = {
  telegram_denied: "Telegram sign-in was cancelled.",
  telegram_state: "Telegram sign-in expired. Please try again.",
  telegram_token: "We couldn’t verify the Telegram sign-in. Please try again.",
  telegram_unavailable: "Telegram sign-in is unavailable right now.",
  telegram_conflict:
    "That Telegram account is already connected to another SailorPath account.",
  telegram_already: "This account already has a different Telegram login.",
  telegram_session: "We couldn’t start your SailorPath session. Please try again.",
};

export function telegramLoginError(code: string | null): string | null {
  if (!code) return null;
  return (
    TELEGRAM_LOGIN_ERRORS[code] ??
    "We couldn’t complete authentication. Please try again."
  );
}

export const TELEGRAM_ACCOUNT_NOTICES: Record<string, string> = {
  connected: "Telegram is connected. You can use it to sign in from now on.",
  conflict:
    "That Telegram account is already connected to another SailorPath account. Accounts are not combined automatically.",
  already: "This account already has a different Telegram login.",
  denied: "Telegram connection was cancelled.",
  state: "That connection attempt expired. Try connecting again.",
  unavailable: "Telegram sign-in is not available right now.",
  session: "We couldn’t finish connecting Telegram. Please try again.",
  token: "We couldn’t verify the Telegram connection. Please try again.",
};
