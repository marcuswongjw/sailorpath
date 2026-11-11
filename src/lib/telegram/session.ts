import { createClient, type SupabaseClient } from "@supabase/supabase-js";
import { telegramServiceRoleKey } from "@/lib/telegram/config";
import { createServerSupabase } from "@/lib/supabase/server";

export class TelegramFlowError extends Error {
  readonly code: "conflict" | "already" | "session" | "unavailable" | "signed-out";

  constructor(code: "conflict" | "already" | "session" | "unavailable" | "signed-out") {
    super(code);
    this.name = "TelegramFlowError";
    this.code = code;
  }
}

/**
 * Telegram's ID token is not a Supabase session. Custom OIDC in Supabase
 * expects a `role` claim and a UUID `sub`, and it does not create the
 * auth.users row or cookie session the rest of SailorPath already uses.
 * Telegram cannot add those claims.
 *
 * After the ID token is verified, we reuse or create an auth.users row and
 * exchange a one-time magic-link hash (never emailed) for a normal session.
 * GoTrue requires an email. Telegram does not provide one, so a new account
 * gets a random `.invalid` address that is not shown and is not used to
 * match people.
 */
export function createTelegramAdmin(): SupabaseClient | null {
  const url = process.env.NEXT_PUBLIC_SUPABASE_URL || process.env.SUPABASE_URL || "";
  const key = telegramServiceRoleKey();
  if (!url || !key || url.includes("placeholder")) return null;
  return createClient(url, key, {
    auth: { autoRefreshToken: false, persistSession: false },
  });
}

export async function establishSupabaseSession(userId: string): Promise<void> {
  const admin = createTelegramAdmin();
  if (!admin) throw new TelegramFlowError("session");
  const { data: userData, error: userError } = await admin.auth.admin.getUserById(userId);
  const email = userData.user?.email;
  if (userError || !email) throw new TelegramFlowError("session");

  const { data: link, error: linkError } = await admin.auth.admin.generateLink({
    type: "magiclink",
    email,
  });
  if (linkError || !link?.properties?.hashed_token) throw new TelegramFlowError("session");

  const supabase = await createServerSupabase();
  const { data, error } = await supabase.auth.verifyOtp({
    token_hash: link.properties.hashed_token,
    type: otpType(link.properties.verification_type),
  });
  if (error || !data.session) throw new TelegramFlowError("session");
}

function otpType(
  verificationType: string | undefined
): "signup" | "invite" | "magiclink" | "recovery" | "email" | "email_change" {
  if (
    verificationType === "signup" ||
    verificationType === "invite" ||
    verificationType === "magiclink" ||
    verificationType === "recovery" ||
    verificationType === "email"
  ) {
    return verificationType;
  }
  if (verificationType === "email_change_current" || verificationType === "email_change_new") {
    return "email_change";
  }
  return "magiclink";
}
