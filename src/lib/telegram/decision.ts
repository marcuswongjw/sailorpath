export type TelegramAccountAction =
  | { action: "create" }
  | { action: "sign-in"; userId: string }
  | { action: "link"; userId: string }
  | { action: "conflict" }
  | { action: "already" }
  | { action: "signed-out" };

/**
 * Link accounts only by the Telegram `sub`. Display name is intentionally
 * not an input: two sailors can share a name and must stay separate.
 * A login never attaches to whoever happens to be signed in.
 */
export function decideTelegramAccount(input: {
  mode: "login" | "link";
  sessionUserId: string | null;
  linkedUserId: string | null;
  sessionLinkedSub: string | null;
  sub: string;
}): TelegramAccountAction {
  if (input.mode === "link") {
    if (!input.sessionUserId) return { action: "signed-out" };
    if (input.linkedUserId && input.linkedUserId !== input.sessionUserId) {
      return { action: "conflict" };
    }
    if (input.sessionLinkedSub && input.sessionLinkedSub !== input.sub) {
      return { action: "already" };
    }
    return { action: "link", userId: input.sessionUserId };
  }
  if (input.linkedUserId) return { action: "sign-in", userId: input.linkedUserId };
  return { action: "create" };
}
