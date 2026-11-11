import { randomBytes } from "node:crypto";
import { and, desc, eq, inArray, isNull } from "drizzle-orm";
import { db } from "@/db";
import {
  profiles,
  regattaResults,
  regattas,
  sailorClaims,
  sailors,
  telegramBroadcastDeliveries,
  telegramBroadcasts,
  telegramIdentities,
  telegramLinkTokens,
  telegramSubscriptions,
} from "@/db/schema";
import { contactEmail } from "@/lib/telegram/email";
import {
  audienceMatches,
  type TelegramAudience,
} from "@/lib/telegram/bot/audience";
import { hashLinkToken } from "@/lib/telegram/bot/message";
import type { BroadcastDraft } from "@/lib/telegram/bot/message";

const TOKEN_TTL_MS = 30 * 60 * 1000;

export type TelegramAccountView = {
  userId: string;
  fullName: string;
  email: string;
  telegramName: string | null;
  username: string | null;
  optedIn: boolean;
};

export async function listTelegramAccounts(): Promise<TelegramAccountView[]> {
  const [people, identities, subscriptions] = await Promise.all([
    db
      .select({
        id: profiles.id,
        fullName: profiles.fullName,
        email: profiles.email,
        createdAt: profiles.createdAt,
      })
      .from(profiles)
      .orderBy(desc(profiles.createdAt))
      .limit(200),
    db
      .select({
        userId: telegramIdentities.userId,
        displayName: telegramIdentities.displayName,
        username: telegramIdentities.username,
      })
      .from(telegramIdentities),
    db
      .select({
        userId: telegramSubscriptions.userId,
        displayName: telegramSubscriptions.displayName,
        username: telegramSubscriptions.username,
        optedIn: telegramSubscriptions.optedIn,
        blockedAt: telegramSubscriptions.blockedAt,
      })
      .from(telegramSubscriptions),
  ]);
  const identityByUser = new Map(identities.map((row) => [row.userId, row]));
  const subscriptionByUser = new Map(subscriptions.map((row) => [row.userId, row]));
  const ids = new Set<string>([
    ...people.map((person) => person.id),
    ...identities.map((row) => row.userId),
    ...subscriptions.map((row) => row.userId),
  ]);
  const known = new Map(people.map((person) => [person.id, person]));
  const missing = [...ids].filter((id) => !known.has(id));
  if (missing.length > 0) {
    const extra = await db
      .select({ id: profiles.id, fullName: profiles.fullName, email: profiles.email })
      .from(profiles)
      .where(inArray(profiles.id, missing));
    for (const person of extra) known.set(person.id, { ...person, createdAt: new Date(0) });
  }
  return [...ids]
    .map((userId) => {
      const person = known.get(userId);
      if (!person) return null;
      const identity = identityByUser.get(userId);
      const subscription = subscriptionByUser.get(userId);
      return {
        userId,
        fullName: person.fullName,
        email: contactEmail(person.email, null),
        telegramName: subscription?.displayName || identity?.displayName || null,
        username: subscription?.username || identity?.username || null,
        optedIn: Boolean(subscription?.optedIn && !subscription.blockedAt),
      };
    })
    .filter((row): row is TelegramAccountView => row !== null)
    .sort((a, b) => Number(b.optedIn) - Number(a.optedIn) || a.fullName.localeCompare(b.fullName));
}

export async function optInFromLogin(input: {
  userId: string;
  telegramUserId: string | null;
  username: string | null;
  displayName: string | null;
}): Promise<void> {
  const now = new Date();
  await db
    .insert(telegramSubscriptions)
    .values({
      userId: input.userId,
      telegramUserId: input.telegramUserId,
      chatId: input.telegramUserId,
      username: input.username,
      displayName: input.displayName,
      optedIn: true,
      optedInAt: now,
      optedOutAt: null,
      blockedAt: null,
      source: "login",
      updatedAt: now,
    })
    .onConflictDoUpdate({
      target: telegramSubscriptions.userId,
      set: {
        telegramUserId: input.telegramUserId,
        chatId: input.telegramUserId,
        username: input.username,
        displayName: input.displayName,
        optedIn: true,
        optedInAt: now,
        optedOutAt: null,
        blockedAt: null,
        source: "login",
        updatedAt: now,
      },
    });
}

export async function createTelegramStartToken(userId: string): Promise<string> {
  const token = randomBytes(24).toString("base64url");
  const now = new Date();
  await db
    .delete(telegramLinkTokens)
    .where(and(eq(telegramLinkTokens.userId, userId), isNull(telegramLinkTokens.usedAt)));
  await db.insert(telegramLinkTokens).values({
    tokenHash: hashLinkToken(token),
    userId,
    expiresAt: new Date(now.getTime() + TOKEN_TTL_MS),
  });
  return token;
}

export async function consumeTelegramStartToken(token: string): Promise<string | null> {
  const now = new Date();
  const [row] = await db
    .select({
      userId: telegramLinkTokens.userId,
      expiresAt: telegramLinkTokens.expiresAt,
      usedAt: telegramLinkTokens.usedAt,
    })
    .from(telegramLinkTokens)
    .where(eq(telegramLinkTokens.tokenHash, hashLinkToken(token)))
    .limit(1);
  if (!row || row.usedAt || row.expiresAt.getTime() < now.getTime()) return null;
  await db
    .update(telegramLinkTokens)
    .set({ usedAt: now })
    .where(eq(telegramLinkTokens.tokenHash, hashLinkToken(token)));
  return row.userId;
}

export async function subscribeChat(input: {
  userId: string;
  chatId: string;
  telegramUserId: string;
  username: string | null;
  displayName: string | null;
}): Promise<"subscribed" | "taken"> {
  const [taken] = await db
    .select({ userId: telegramSubscriptions.userId })
    .from(telegramSubscriptions)
    .where(eq(telegramSubscriptions.chatId, input.chatId))
    .limit(1);
  if (taken && taken.userId !== input.userId) return "taken";
  const now = new Date();
  try {
    await db
      .insert(telegramSubscriptions)
      .values({
        userId: input.userId,
        telegramUserId: input.telegramUserId,
        chatId: input.chatId,
        username: input.username,
        displayName: input.displayName,
        optedIn: true,
        optedInAt: now,
        optedOutAt: null,
        blockedAt: null,
        source: "deeplink",
        updatedAt: now,
      })
      .onConflictDoUpdate({
        target: telegramSubscriptions.userId,
        set: {
          telegramUserId: input.telegramUserId,
          chatId: input.chatId,
          username: input.username,
          displayName: input.displayName,
          optedIn: true,
          optedInAt: now,
          optedOutAt: null,
          blockedAt: null,
          source: "deeplink",
          updatedAt: now,
        },
      });
  } catch (error) {
    const code =
      error && typeof error === "object" && "code" in error ? String(error.code) : "";
    if (code === "23505") return "taken";
    throw error;
  }
  return "subscribed";
}

export async function unsubscribeChat(chatId: string, blocked: boolean): Promise<void> {
  const now = new Date();
  await db
    .update(telegramSubscriptions)
    .set({
      optedIn: false,
      optedOutAt: now,
      blockedAt: blocked ? now : null,
      updatedAt: now,
    })
    .where(eq(telegramSubscriptions.chatId, chatId));
}

export async function unsubscribeUser(userId: string): Promise<void> {
  const now = new Date();
  await db
    .update(telegramSubscriptions)
    .set({ optedIn: false, optedOutAt: now, updatedAt: now })
    .where(eq(telegramSubscriptions.userId, userId));
}

export async function getTelegramUpdateStatus(userId: string): Promise<{
  optedIn: boolean;
  username: string | null;
}> {
  const [row] = await db
    .select({
      optedIn: telegramSubscriptions.optedIn,
      blockedAt: telegramSubscriptions.blockedAt,
      username: telegramSubscriptions.username,
    })
    .from(telegramSubscriptions)
    .where(eq(telegramSubscriptions.userId, userId))
    .limit(1);
  return {
    optedIn: Boolean(row?.optedIn && !row.blockedAt),
    username: row?.username ?? null,
  };
}

export async function createBroadcast(input: {
  actorUserId: string;
  draft: BroadcastDraft;
  audience: TelegramAudience;
  audienceValue: string;
}): Promise<{ id: string; targeted: number }> {
  const recipients = await optedInRecipients(input.audience, input.audienceValue);
  const [broadcast] = await db
    .insert(telegramBroadcasts)
    .values({
      actorUserId: input.actorUserId,
      body: input.draft.text,
      buttonLabel: input.draft.buttonLabel,
      buttonUrl: input.draft.buttonUrl,
      audience: input.audience,
      audienceValue: input.audienceValue || null,
      status: "sending",
      targetedCount: recipients.length,
    })
    .returning({ id: telegramBroadcasts.id });
  if (recipients.length > 0) {
    await db.insert(telegramBroadcastDeliveries).values(
      recipients.map((recipient) => ({
        broadcastId: broadcast.id,
        userId: recipient.userId,
        chatId: recipient.chatId,
        status: "pending" as const,
      }))
    );
  } else {
    await db
      .update(telegramBroadcasts)
      .set({ status: "sent", finishedAt: new Date() })
      .where(eq(telegramBroadcasts.id, broadcast.id));
  }
  return { id: broadcast.id, targeted: recipients.length };
}

export async function countAudience(
  audience: TelegramAudience,
  audienceValue: string
): Promise<number> {
  return (await optedInRecipients(audience, audienceValue)).length;
}

export async function nextBroadcastBatch(broadcastId: string, limit: number) {
  const [broadcast] = await db
    .select({
      id: telegramBroadcasts.id,
      body: telegramBroadcasts.body,
      buttonLabel: telegramBroadcasts.buttonLabel,
      buttonUrl: telegramBroadcasts.buttonUrl,
      deliveredCount: telegramBroadcasts.deliveredCount,
      failedCount: telegramBroadcasts.failedCount,
      targetedCount: telegramBroadcasts.targetedCount,
    })
    .from(telegramBroadcasts)
    .where(eq(telegramBroadcasts.id, broadcastId))
    .limit(1);
  if (!broadcast) return null;
  const pending = await db
    .select({
      id: telegramBroadcastDeliveries.id,
      userId: telegramBroadcastDeliveries.userId,
      chatId: telegramBroadcastDeliveries.chatId,
    })
    .from(telegramBroadcastDeliveries)
    .where(
      and(
        eq(telegramBroadcastDeliveries.broadcastId, broadcastId),
        eq(telegramBroadcastDeliveries.status, "pending")
      )
    )
    .limit(limit);
  return { broadcast, pending };
}

export async function markDelivery(input: {
  deliveryId: string;
  broadcastId: string;
  userId: string;
  status: "sent" | "failed" | "blocked";
  error?: string;
}): Promise<void> {
  const now = new Date();
  await db
    .update(telegramBroadcastDeliveries)
    .set({ status: input.status, error: input.error ?? null, sentAt: now })
    .where(eq(telegramBroadcastDeliveries.id, input.deliveryId));
  if (input.status === "blocked") await unsubscribeUser(input.userId);
  const [counts] = await db
    .select({
      delivered: telegramBroadcasts.deliveredCount,
      failed: telegramBroadcasts.failedCount,
    })
    .from(telegramBroadcasts)
    .where(eq(telegramBroadcasts.id, input.broadcastId))
    .limit(1);
  await db
    .update(telegramBroadcasts)
    .set({
      deliveredCount: (counts?.delivered ?? 0) + (input.status === "sent" ? 1 : 0),
      failedCount: (counts?.failed ?? 0) + (input.status === "sent" ? 0 : 1),
    })
    .where(eq(telegramBroadcasts.id, input.broadcastId));
}

export async function finishBroadcastIfDone(broadcastId: string): Promise<{
  remaining: number;
  delivered: number;
  failed: number;
  targeted: number;
}> {
  const pending = await db
    .select({ id: telegramBroadcastDeliveries.id })
    .from(telegramBroadcastDeliveries)
    .where(
      and(
        eq(telegramBroadcastDeliveries.broadcastId, broadcastId),
        eq(telegramBroadcastDeliveries.status, "pending")
      )
    )
    .limit(1);
  if (pending.length === 0) {
    await db
      .update(telegramBroadcasts)
      .set({ status: "sent", finishedAt: new Date() })
      .where(eq(telegramBroadcasts.id, broadcastId));
  }
  const [broadcast] = await db
    .select({
      targeted: telegramBroadcasts.targetedCount,
      delivered: telegramBroadcasts.deliveredCount,
      failed: telegramBroadcasts.failedCount,
    })
    .from(telegramBroadcasts)
    .where(eq(telegramBroadcasts.id, broadcastId))
    .limit(1);
  const targeted = broadcast?.targeted ?? 0;
  const delivered = broadcast?.delivered ?? 0;
  const failed = broadcast?.failed ?? 0;
  return {
    targeted,
    delivered,
    failed,
    remaining: Math.max(0, targeted - delivered - failed),
  };
}

async function optedInRecipients(audience: TelegramAudience, audienceValue: string) {
  const subscriptions = await db
    .select({
      userId: telegramSubscriptions.userId,
      chatId: telegramSubscriptions.chatId,
    })
    .from(telegramSubscriptions)
    .where(
      and(eq(telegramSubscriptions.optedIn, true), isNull(telegramSubscriptions.blockedAt))
    );
  const withChat = subscriptions.filter(
    (row): row is { userId: string; chatId: string } => Boolean(row.chatId)
  );
  if (audience === "all") return withChat;
  const facts = await sailorFacts(withChat.map((row) => row.userId));
  return withChat.filter((row) =>
    audienceMatches({
      audience,
      value: audienceValue,
      nationalities: facts.get(row.userId)?.nationalities ?? [],
      classes: facts.get(row.userId)?.classes ?? [],
    })
  );
}

async function sailorFacts(userIds: string[]) {
  const facts = new Map<string, { nationalities: string[]; classes: string[] }>();
  const ensure = (userId: string | null) => {
    if (!userId) return null;
    const current = facts.get(userId) ?? { nationalities: [], classes: [] };
    facts.set(userId, current);
    return current;
  };
  if (userIds.length === 0) return facts;
  const owned = await db
    .select({ userId: sailors.parentId, nationality: sailors.nationality })
    .from(sailors)
    .where(inArray(sailors.parentId, userIds));
  for (const row of owned) {
    const fact = ensure(row.userId);
    if (fact && row.nationality) fact.nationalities.push(row.nationality);
  }
  const claimed = await db
    .select({ userId: sailorClaims.requesterId, nationality: sailors.nationality })
    .from(sailorClaims)
    .innerJoin(sailors, eq(sailorClaims.sailorId, sailors.id))
    .where(and(eq(sailorClaims.status, "approved"), inArray(sailorClaims.requesterId, userIds)));
  for (const row of claimed) {
    const fact = ensure(row.userId);
    if (fact && row.nationality) fact.nationalities.push(row.nationality);
  }
  const ownedClasses = await db
    .select({ userId: sailors.parentId, boatClass: regattas.boatClass })
    .from(regattaResults)
    .innerJoin(sailors, eq(regattaResults.sailorId, sailors.id))
    .innerJoin(regattas, eq(regattaResults.regattaId, regattas.id))
    .where(inArray(sailors.parentId, userIds));
  for (const row of ownedClasses) {
    const fact = ensure(row.userId);
    if (fact && row.boatClass) fact.classes.push(row.boatClass);
  }
  const claimedClasses = await db
    .select({ userId: sailorClaims.requesterId, boatClass: regattas.boatClass })
    .from(sailorClaims)
    .innerJoin(regattaResults, eq(regattaResults.sailorId, sailorClaims.sailorId))
    .innerJoin(regattas, eq(regattaResults.regattaId, regattas.id))
    .where(and(eq(sailorClaims.status, "approved"), inArray(sailorClaims.requesterId, userIds)));
  for (const row of claimedClasses) {
    const fact = ensure(row.userId);
    if (fact && row.boatClass) fact.classes.push(row.boatClass);
  }
  return facts;
}
