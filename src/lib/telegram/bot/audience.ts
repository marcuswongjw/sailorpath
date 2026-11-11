export type TelegramAudience = "all" | "class" | "country";

export function normalizeAudience(value: string | null | undefined): TelegramAudience {
  if (value === "class" || value === "country") return value;
  return "all";
}

/** A user matches a filtered audience through a sailor they manage or have claimed. */
export function audienceMatches(input: {
  audience: TelegramAudience;
  value: string;
  nationalities: readonly string[];
  classes: readonly string[];
}): boolean {
  if (input.audience === "all") return true;
  const wanted = input.value.trim().toLowerCase();
  if (!wanted) return false;
  const haystack = input.audience === "country" ? input.nationalities : input.classes;
  return haystack.some((item) => item.trim().toLowerCase() === wanted);
}

export function shouldSendTelegramAlert(subscription: {
  optedIn: boolean;
  blockedAt: Date | string | null;
  chatId: string | null;
} | null): boolean {
  return Boolean(
    subscription?.optedIn && subscription.chatId && !subscription.blockedAt
  );
}
