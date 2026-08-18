/**
 * Lean admin Stats aggregates — COUNT / DISTINCT only (no full result scans).
 * Privacy: numbers only, no PII.
 */

import { unstable_cache } from "next/cache";
import {
  and,
  count,
  countDistinct,
  desc,
  eq,
  gte,
  isNotNull,
  isNull,
  or,
  sql,
} from "drizzle-orm";
import { db } from "@/db";
import {
  regattas,
  sailorClaims,
  sailors,
  supportMessages,
  usageEvents,
} from "@/db/schema";
import { CACHE_TAG_ADMIN_STATS } from "@/lib/cacheTags";

export type AdminStatsPayload = {
  generatedAt: string;
  cacheSeconds: number;
  northStars: {
    weeklyActiveSessions: number | null;
    claimedSailors: number;
    seriesSailors: number;
    rosterClaimedPct: number | null;
    claimsPending: number;
  };
  ops: {
    supportNew: number;
    daysSinceLastImport: number | null;
    lastImportAt: string | null;
    rankingRegattas: number;
  };
  traffic7d: {
    rankingViews: number;
    profileViews: number;
    searches: number;
    sampleViews: number;
    adminOpens: number;
  };
  dataTrust: {
    sailorsTotal: number;
    missingDob: number;
    missingOrPlaceholderSail: number;
  };
  /** true when usage_events table was readable */
  usageEventsOk: boolean;
};

const CACHE_SECONDS = 60;

function pct(n: number, d: number): number | null {
  if (d <= 0) return null;
  return Math.round((n / d) * 1000) / 10;
}

function daysBetween(from: Date, to: Date): number {
  return Math.max(0, Math.floor((to.getTime() - from.getTime()) / 86_400_000));
}

async function computeAdminStats(): Promise<AdminStatsPayload> {
  const now = new Date();
  const weekAgo = new Date(now.getTime() - 7 * 86_400_000);

  const [
    claimedRow,
    seriesRow,
    claimsPendingRow,
    supportNewRow,
    rankingRegattaRow,
    sailorsTotalRow,
    missingDobRow,
    missingSailRow,
  ] = await Promise.all([
    db
      .select({ n: count() })
      .from(sailors)
      .where(isNotNull(sailors.parentId)),
    db
      .select({ n: count() })
      .from(sailors)
      .where(
        and(
          or(
            sql`lower(trim(coalesce(${sailors.currentFleet}, ''))) in ('series', 'gold', 'silver', 'in sg fleet', 'member')`,
            isNotNull(sailors.silverEntryDate),
            isNotNull(sailors.goldEntryDate)
          ),
          or(
            isNull(sailors.dropDate),
            sql`${sailors.dropDate}::text > to_char((now() at time zone 'Asia/Singapore'), 'YYYY-MM-DD')`
          )
        )
      ),
    db
      .select({ n: count() })
      .from(sailorClaims)
      .where(eq(sailorClaims.status, "pending")),
    db
      .select({ n: count() })
      .from(supportMessages)
      .where(eq(supportMessages.status, "new")),
    db
      .select({ n: count() })
      .from(regattas)
      .where(eq(regattas.countsForRanking, true)),
    db.select({ n: count() }).from(sailors),
    db
      .select({ n: count() })
      .from(sailors)
      .where(isNull(sailors.dob)),
    db
      .select({ n: count() })
      .from(sailors)
      .where(
        or(
          isNull(sailors.sailNumber),
          sql`trim(coalesce(${sailors.sailNumber}, '')) = ''`,
          sql`${sailors.sailNumber} ~* '^SGP[[:space:]]*0+$'`
        )
      ),
  ]);

  const claimedSailors = Number(claimedRow[0]?.n ?? 0);
  const seriesSailors = Number(seriesRow[0]?.n ?? 0);

  let usageEventsOk = true;
  let weeklyActiveSessions: number | null = null;
  let rankingViews = 0;
  let profileViews = 0;
  let searches = 0;
  let sampleViews = 0;
  let adminOpens = 0;
  let lastImportAt: string | null = null;
  let daysSinceLastImport: number | null = null;

  try {
    const [sessionsRow, trafficRows, lastImportRow] = await Promise.all([
      db
        .select({ n: countDistinct(usageEvents.sessionId) })
        .from(usageEvents)
        .where(
          and(
            gte(usageEvents.createdAt, weekAgo),
            isNotNull(usageEvents.sessionId)
          )
        ),
      db
        .select({
          eventType: usageEvents.eventType,
          n: count(),
        })
        .from(usageEvents)
        .where(gte(usageEvents.createdAt, weekAgo))
        .groupBy(usageEvents.eventType),
      db
        .select({
          createdAt: usageEvents.createdAt,
        })
        .from(usageEvents)
        .where(eq(usageEvents.eventType, "import"))
        .orderBy(desc(usageEvents.createdAt))
        .limit(1),
    ]);

    weeklyActiveSessions = Number(sessionsRow[0]?.n ?? 0);
    for (const row of trafficRows) {
      const n = Number(row.n ?? 0);
      switch (row.eventType) {
        case "ranking_view":
          rankingViews = n;
          break;
        case "profile_view":
          profileViews = n;
          break;
        case "search":
          searches = n;
          break;
        case "sample_view":
          sampleViews = n;
          break;
        case "admin_open":
          adminOpens = n;
          break;
        default:
          break;
      }
    }

    const importAt = lastImportRow[0]?.createdAt;
    if (importAt) {
      const d = importAt instanceof Date ? importAt : new Date(String(importAt));
      if (!Number.isNaN(d.getTime())) {
        lastImportAt = d.toISOString();
        daysSinceLastImport = daysBetween(d, now);
      }
    }
  } catch {
    usageEventsOk = false;
  }

  return {
    generatedAt: now.toISOString(),
    cacheSeconds: CACHE_SECONDS,
    northStars: {
      weeklyActiveSessions,
      claimedSailors,
      seriesSailors,
      rosterClaimedPct: pct(claimedSailors, seriesSailors),
      claimsPending: Number(claimsPendingRow[0]?.n ?? 0),
    },
    ops: {
      supportNew: Number(supportNewRow[0]?.n ?? 0),
      daysSinceLastImport,
      lastImportAt,
      rankingRegattas: Number(rankingRegattaRow[0]?.n ?? 0),
    },
    traffic7d: {
      rankingViews,
      profileViews,
      searches,
      sampleViews,
      adminOpens,
    },
    dataTrust: {
      sailorsTotal: Number(sailorsTotalRow[0]?.n ?? 0),
      missingDob: Number(missingDobRow[0]?.n ?? 0),
      missingOrPlaceholderSail: Number(missingSailRow[0]?.n ?? 0),
    },
    usageEventsOk,
  };
}

export const getCachedAdminStats = unstable_cache(
  async () => computeAdminStats(),
  ["admin-stats-v1"],
  { revalidate: CACHE_SECONDS, tags: [CACHE_TAG_ADMIN_STATS] }
);

/** Test helper — format roster % without DB. */
export function formatRosterClaimedPct(
  claimed: number,
  series: number
): number | null {
  return pct(claimed, series);
}
