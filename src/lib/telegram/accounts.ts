import { and, eq, ilike } from "drizzle-orm";
import { db, formatDbError } from "@/db";
import { profiles, telegramIdentities } from "@/db/schema";
import { ensureProfileForUser } from "@/lib/queries";
import { decideTelegramAccount } from "@/lib/telegram/decision";
import { telegramPlaceholderEmail } from "@/lib/telegram/email";
import type { TelegramIdTokenClaims } from "@/lib/telegram/oidc";
import { createTelegramAdmin, establishSupabaseSession, TelegramFlowError } from "@/lib/telegram/session";

export type TelegramLinkRow = {
  telegramSub: string;
  userId: string;
  username: string | null;
};

export async function completeTelegramSignIn(input: {
  mode: "login" | "link";
  sessionUserId: string | null;
  claims: TelegramIdTokenClaims;
}): Promise<{ status: "signed-in" | "linked"; userId: string }> {
  const linked = await findBySub(input.claims.sub);
  const sessionLink = input.sessionUserId ? await findByUser(input.sessionUserId) : null;
  const decision = decideTelegramAccount({
    mode: input.mode,
    sessionUserId: input.sessionUserId,
    linkedUserId: linked?.userId ?? null,
    sessionLinkedSub: sessionLink?.telegramSub ?? null,
    sub: input.claims.sub,
  });

  if (decision.action === "conflict") throw new TelegramFlowError("conflict");
  if (decision.action === "already") throw new TelegramFlowError("already");
  if (decision.action === "signed-out") throw new TelegramFlowError("signed-out");

  if (decision.action === "link") {
    await linkTelegram(decision.userId, input.claims);
    return { status: "linked", userId: decision.userId };
  }

  const userId =
    decision.action === "sign-in" ? decision.userId : await createTelegramAccount(input.claims);
  if (decision.action === "sign-in") await touchTelegram(input.claims);
  await ensureProfileForUser({
    id: userId,
    email: "",
    user_metadata: { full_name: input.claims.name || "Sailor" },
  });
  await clearPlaceholderProfileEmail(userId);
  await establishSupabaseSession(userId);
  return { status: "signed-in", userId };
}

export async function unlinkTelegram(userId: string): Promise<void> {
  await db.delete(telegramIdentities).where(eq(telegramIdentities.userId, userId));
  const admin = createTelegramAdmin();
  if (!admin) return;
  const { data } = await admin.auth.admin.getUserById(userId);
  const current = data.user?.app_metadata ?? {};
  const next = { ...current, telegram_sub: null };
  await admin.auth.admin.updateUserById(userId, { app_metadata: next });
}

export async function findTelegramForUser(userId: string): Promise<TelegramLinkRow | null> {
  return findByUser(userId);
}

export function isMissingTelegramIdentitiesError(error: unknown): boolean {
  const text = formatDbError(error);
  return /telegram_identities/i.test(text) && /does not exist|42P01/i.test(text);
}

async function createTelegramAccount(claims: TelegramIdTokenClaims): Promise<string> {
  const admin = createTelegramAdmin();
  if (!admin) throw new TelegramFlowError("session");
  const email = telegramPlaceholderEmail();
  const name = claims.name || "Sailor";
  const created = await admin.auth.admin.createUser({
    email,
    email_confirm: true,
    user_metadata: { full_name: name },
    app_metadata: { telegram_sub: claims.sub },
  });
  const userId = created.data.user?.id;
  if (created.error || !userId) throw new TelegramFlowError("session");

  try {
    await ensureProfileForUser({
      id: userId,
      email: "",
      user_metadata: { full_name: name },
    });
    await clearPlaceholderProfileEmail(userId);
    await db.insert(telegramIdentities).values({
      telegramSub: claims.sub,
      userId,
      telegramUserId: claims.telegramUserId,
      username: claims.username,
      displayName: claims.name,
      photoUrl: claims.picture,
    });
  } catch (error) {
    const winner = await findBySub(claims.sub).catch(() => null);
    await admin.auth.admin.deleteUser(userId).catch(() => undefined);
    if (winner && winner.userId !== userId) return winner.userId;
    if (isMissingTelegramIdentitiesError(error)) throw new TelegramFlowError("unavailable");
    throw new TelegramFlowError("session");
  }
  return userId;
}

async function linkTelegram(userId: string, claims: TelegramIdTokenClaims): Promise<void> {
  const existing = await findBySub(claims.sub);
  if (existing?.userId === userId) {
    await touchTelegram(claims);
    return;
  }
  if (existing) throw new TelegramFlowError("conflict");
  try {
    await db.insert(telegramIdentities).values({
      telegramSub: claims.sub,
      userId,
      telegramUserId: claims.telegramUserId,
      username: claims.username,
      displayName: claims.name,
      photoUrl: claims.picture,
    });
  } catch (error) {
    if (pgCode(error) === "23505") {
      const again = await findBySub(claims.sub);
      if (again?.userId === userId) return;
      throw new TelegramFlowError("conflict");
    }
    if (isMissingTelegramIdentitiesError(error)) throw new TelegramFlowError("unavailable");
    throw error;
  }
  await rememberSub(userId, claims.sub);
}

async function touchTelegram(claims: TelegramIdTokenClaims): Promise<void> {
  await db
    .update(telegramIdentities)
    .set({
      telegramUserId: claims.telegramUserId,
      username: claims.username,
      displayName: claims.name,
      photoUrl: claims.picture,
      updatedAt: new Date(),
    })
    .where(eq(telegramIdentities.telegramSub, claims.sub));
}

async function rememberSub(userId: string, sub: string): Promise<void> {
  const admin = createTelegramAdmin();
  if (!admin) return;
  const { data } = await admin.auth.admin.getUserById(userId);
  const current = data.user?.app_metadata ?? {};
  await admin.auth.admin.updateUserById(userId, {
    app_metadata: { ...current, telegram_sub: sub },
  });
}

async function clearPlaceholderProfileEmail(userId: string): Promise<void> {
  await db
    .update(profiles)
    .set({ email: "", updatedAt: new Date() })
    .where(and(eq(profiles.id, userId), ilike(profiles.email, "%@telegram.sailorpath.invalid")));
}

async function findBySub(sub: string): Promise<TelegramLinkRow | null> {
  const rows = await db
    .select({
      telegramSub: telegramIdentities.telegramSub,
      userId: telegramIdentities.userId,
      username: telegramIdentities.username,
    })
    .from(telegramIdentities)
    .where(eq(telegramIdentities.telegramSub, sub))
    .limit(1);
  return rows[0] ?? null;
}

async function findByUser(userId: string): Promise<TelegramLinkRow | null> {
  const rows = await db
    .select({
      telegramSub: telegramIdentities.telegramSub,
      userId: telegramIdentities.userId,
      username: telegramIdentities.username,
    })
    .from(telegramIdentities)
    .where(eq(telegramIdentities.userId, userId))
    .limit(1);
  return rows[0] ?? null;
}

function pgCode(error: unknown): string | null {
  const seen = new Set<unknown>();
  let current: unknown = error;
  while (current && typeof current === "object" && !seen.has(current)) {
    seen.add(current);
    if ("code" in current && typeof (current as { code: unknown }).code === "string") {
      return (current as { code: string }).code;
    }
    current = "cause" in current ? (current as { cause: unknown }).cause : null;
  }
  return null;
}
