/**
 * Privacy-light product usage tracking.
 * Prefer DB (usage_events). Never store emails, names, or full query strings.
 */

import { db } from "@/db";
import { usageEvents } from "@/db/schema";
import { and, desc, eq, gte, isNull, sql } from "drizzle-orm";

export const USAGE_EVENT_TYPES = [
  "page_view",
  "ranking_view",
  "profile_view",
  "search",
  "sample_view",
  "claim_submit",
  "import",
  "support_submit",
  "login",
  "admin_open",
] as const;

export type UsageEventType = (typeof USAGE_EVENT_TYPES)[number] | string;

export type TrackUsageInput = {
  eventType: UsageEventType;
  path?: string | null;
  role?: string | null;
  sessionId?: string | null;
  meta?: Record<string, string | number | boolean | null> | null;
};

/** Strip query/hash; cap length; only allow path-like strings. */
export function sanitizePath(raw: unknown): string | null {
  if (raw == null || raw === "") return null;
  let s = String(raw).trim();
  // Drop query/hash (may carry tokens)
  s = s.split("?")[0].split("#")[0];
  if (!s.startsWith("/")) s = `/${s}`;
  // Block obvious junk
  if (s.length > 200) s = s.slice(0, 200);
  if (/[\x00-\x1f]/.test(s)) return null;
  return s;
}

export async function trackUsage(input: TrackUsageInput): Promise<{ ok: boolean; skipped?: string }> {
  const eventType = String(input.eventType || "").trim().slice(0, 64);
  if (!eventType) return { ok: false, skipped: "missing eventType" };

  const path = sanitizePath(input.path);
  const role =
    input.role != null && String(input.role).trim()
      ? String(input.role).trim().slice(0, 32)
      : null;
  const sessionId =
    input.sessionId != null && String(input.sessionId).trim()
      ? String(input.sessionId).trim().slice(0, 64)
      : null;
  let meta: string | null = null;
  if (input.meta && typeof input.meta === "object") {
    try {
      meta = JSON.stringify(input.meta).slice(0, 500);
    } catch {
      meta = null;
    }
  }

  try {
    await db.insert(usageEvents).values({
      eventType,
      path,
      role,
      sessionId,
      meta,
    });
    return { ok: true };
  } catch (e) {
    // Table may not exist yet — fail soft so product never breaks
    const msg = e instanceof Error ? e.message : String(e);
    if (/usage_events|does not exist|relation/i.test(msg)) {
      return { ok: false, skipped: "usage_events table missing — run migration 016" };
    }
    console.error("[usage] track failed", msg.slice(0, 200));
    return { ok: false, skipped: "db error" };
  }
}

export type UsageSummary = {
  sinceDays: number;
  totalEvents: number;
  uniqueSessions: number;
  byType: { eventType: string; count: number }[];
  topPaths: { path: string; count: number }[];
  migrationHint?: string;
};

export async function getUsageSummary(days = 7): Promise<UsageSummary> {
  const since = new Date();
  since.setDate(since.getDate() - Math.max(1, Math.min(days, 90)));

  try {
    const rows = await db
      .select({
        eventType: usageEvents.eventType,
        path: usageEvents.path,
        sessionId: usageEvents.sessionId,
      })
      .from(usageEvents)
      .where(gte(usageEvents.createdAt, since))
      .orderBy(desc(usageEvents.createdAt))
      .limit(5000);

    const byTypeMap = new Map<string, number>();
    const pathMap = new Map<string, number>();
    const sessions = new Set<string>();

    for (const r of rows) {
      byTypeMap.set(r.eventType, (byTypeMap.get(r.eventType) || 0) + 1);
      if (r.path) pathMap.set(r.path, (pathMap.get(r.path) || 0) + 1);
      if (r.sessionId) sessions.add(r.sessionId);
    }

    const byType = Array.from(byTypeMap.entries())
      .map(([eventType, count]) => ({ eventType, count }))
      .sort((a, b) => b.count - a.count);

    const topPaths = Array.from(pathMap.entries())
      .map(([path, count]) => ({ path, count }))
      .sort((a, b) => b.count - a.count)
      .slice(0, 15);

    return {
      sinceDays: days,
      totalEvents: rows.length,
      uniqueSessions: sessions.size,
      byType,
      topPaths,
    };
  } catch (e) {
    const msg = e instanceof Error ? e.message : String(e);
    return {
      sinceDays: days,
      totalEvents: 0,
      uniqueSessions: 0,
      byType: [],
      topPaths: [],
      migrationHint: /does not exist|relation/i.test(msg)
        ? "Run SQL migration 016_usage_events.sql in Supabase"
        : msg.slice(0, 160),
    };
  }
}

/** Coarse product inventory (not page analytics). */
export async function getProductInventory() {
  const {
    sailors,
    regattas,
    regattaResults,
    sailorClaims,
    supportMessages,
    profiles,
  } = await import("@/db/schema");
  const { count, eq, isNotNull } = await import("drizzle-orm");

  const [sailorCount] = await db.select({ n: count() }).from(sailors);
  const [regattaCount] = await db.select({ n: count() }).from(regattas);
  const [resultCount] = await db.select({ n: count() }).from(regattaResults);
  const [claimPending] = await db
    .select({ n: count() })
    .from(sailorClaims)
    .where(eq(sailorClaims.status, "pending"));
  const [supportNew] = await db
    .select({ n: count() })
    .from(supportMessages)
    .where(eq(supportMessages.status, "new"));
  const [profileCount] = await db.select({ n: count() }).from(profiles);

  const fleetRows = await db
    .select({
      fleet: sailors.currentFleet,
      n: count(),
    })
    .from(sailors)
    .groupBy(sailors.currentFleet);

  const fleet: Record<string, number> = {};
  for (const r of fleetRows) {
    const k = String(r.fleet || "unassigned").toLowerCase() || "unassigned";
    fleet[k] = Number(r.n) || 0;
  }

  const [claimed] = await db
    .select({ n: count() })
    .from(sailors)
    .where(isNotNull(sailors.parentId));

  const [unclaimed] = await db
    .select({ n: count() })
    .from(sailors)
    .where(sql`${sailors.parentId} is null`);

  // Guests: no series fleet / entry dates
  const [guests] = await db
    .select({ n: count() })
    .from(sailors)
    .where(
      sql`${sailors.goldEntryDate} is null and ${sailors.silverEntryDate} is null and (${sailors.currentFleet} is null or ${sailors.currentFleet} = '')`
    );

  let personalRegattas = 0;
  let personalUnreviewed = 0;
  try {
    const [pr] = await db
      .select({ n: count() })
      .from(regattas)
      .where(eq(regattas.countsForRanking, false));
    personalRegattas = Number(pr?.n || 0);
  } catch {
    /* column may not exist until migration 017 */
  }
  try {
    const [ur] = await db
      .select({ n: count() })
      .from(regattas)
      .where(
        and(eq(regattas.countsForRanking, false), isNull(regattas.reviewedAt))
      );
    personalUnreviewed = Number(ur?.n || 0);
  } catch {
    /* migration 018 */
  }

  return {
    sailors: Number(sailorCount?.n || 0),
    regattas: Number(regattaCount?.n || 0),
    results: Number(resultCount?.n || 0),
    profiles: Number(profileCount?.n || 0),
    claimsPending: Number(claimPending?.n || 0),
    supportNew: Number(supportNew?.n || 0),
    sailorsClaimed: Number(claimed?.n || 0),
    sailorsUnclaimed: Number(unclaimed?.n || 0),
    guests: Number(guests?.n || 0),
    personalRegattas,
    personalUnreviewed,
    fleet,
  };
}
