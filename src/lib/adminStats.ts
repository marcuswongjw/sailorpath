/**
 * Lean admin Stats aggregates — COUNT / DISTINCT only (no full result scans).
 * Privacy: numbers only, no PII.
 *
 * Uses a small number of SQL round-trips (avoids saturating postgres.js max:5
 * and Supabase transaction-pooler concurrency).
 */

import { pgSql } from "@/db";

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

function num(v: unknown): number {
  const n = Number(v);
  return Number.isFinite(n) ? n : 0;
}

function daysBetween(from: Date, to: Date): number {
  return Math.max(0, Math.floor((to.getTime() - from.getTime()) / 86_400_000));
}

/**
 * Compute live admin stats. Prefer this over many parallel Drizzle selects —
 * one inventory CTE + one usage pass stays well under the pool limit.
 */
export async function getAdminStats(): Promise<AdminStatsPayload> {
  const now = new Date();

  const inventory = await pgSql`
    select
      (select count(*)::int from public.sailors) as sailors_total,
      (select count(*)::int from public.sailors where parent_id is not null) as claimed,
      (select count(*)::int from public.sailors
        where (
          lower(trim(coalesce(current_fleet, ''))) in (
            'series', 'gold', 'silver', 'in sg fleet', 'member'
          )
          or silver_entry_date is not null
          or gold_entry_date is not null
        )
        and (
          drop_date is null
          or drop_date::text > to_char((now() at time zone 'Asia/Singapore'), 'YYYY-MM-DD')
        )
      ) as series_sailors,
      (select count(*)::int from public.sailor_claims where status = 'pending') as claims_pending,
      (select count(*)::int from public.support_messages where status = 'new') as support_new,
      (select count(*)::int from public.regattas where counts_for_ranking = true) as ranking_regattas,
      (select count(*)::int from public.sailors where dob is null) as missing_dob,
      (select count(*)::int from public.sailors
        where sail_number is null
           or trim(coalesce(sail_number, '')) = ''
           or sail_number ~* '^SGP[[:space:]]*0+$'
      ) as missing_sail
  `;

  const row = inventory[0] ?? {};
  const claimedSailors = num(row.claimed);
  const seriesSailors = num(row.series_sailors);

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
    const [sessions, traffic, lastImport] = await Promise.all([
      pgSql`
        select count(distinct session_id)::int as n
        from public.usage_events
        where created_at >= now() - interval '7 days'
          and session_id is not null
          and session_id <> ''
      `,
      pgSql`
        select event_type, count(*)::int as n
        from public.usage_events
        where created_at >= now() - interval '7 days'
        group by event_type
      `,
      pgSql`
        select created_at
        from public.usage_events
        where event_type = 'import'
        order by created_at desc
        limit 1
      `,
    ]);

    weeklyActiveSessions = num(sessions[0]?.n);
    for (const t of traffic) {
      const n = num(t.n);
      switch (String(t.event_type)) {
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

    const importAt = lastImport[0]?.created_at;
    if (importAt) {
      const d =
        importAt instanceof Date ? importAt : new Date(String(importAt));
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
      claimsPending: num(row.claims_pending),
    },
    ops: {
      supportNew: num(row.support_new),
      daysSinceLastImport,
      lastImportAt,
      rankingRegattas: num(row.ranking_regattas),
    },
    traffic7d: {
      rankingViews,
      profileViews,
      searches,
      sampleViews,
      adminOpens,
    },
    dataTrust: {
      sailorsTotal: num(row.sailors_total),
      missingDob: num(row.missing_dob),
      missingOrPlaceholderSail: num(row.missing_sail),
    },
    usageEventsOk,
  };
}

/** @deprecated use getAdminStats — kept for older imports */
export async function getCachedAdminStats(): Promise<AdminStatsPayload> {
  return getAdminStats();
}

/** Test helper — format roster % without DB. */
export function formatRosterClaimedPct(
  claimed: number,
  series: number
): number | null {
  return pct(claimed, series);
}
