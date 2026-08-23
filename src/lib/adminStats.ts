/**
 * Lean admin Stats aggregates — COUNT / DISTINCT only (no full result scans).
 * Account details are fetched only for the superadmin-gated Stats endpoint.
 * No auth details are copied into usage_events.
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
  accounts: {
    registered: number;
    confirmed: number;
    signedInLast7d: number;
    authSessions: number;
    recent: Array<{
      id: string;
      email: string;
      fullName: string | null;
      role: string;
      createdAt: string;
      lastSignInAt: string | null;
      lastSessionRefreshAt: string | null;
      authSessionCount: number;
    }>;
  };
  /** true when usage_events table was readable */
  usageEventsOk: boolean;
  /** true when the server connection could read Supabase's auth schema */
  authAccountsOk: boolean;
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
  let authAccountsOk = true;
  let registered = 0;
  let confirmed = 0;
  let signedInLast7d = 0;
  let authSessions = 0;
  let recentAccounts: AdminStatsPayload["accounts"]["recent"] = [];

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

  try {
    const accountRows = await pgSql`
      with session_totals as (
        select
          user_id,
          count(*) filter (where not_after is null or not_after > now())::int as session_count,
          max(refreshed_at) as last_session_refresh_at
        from auth.sessions
        group by user_id
      ), account_summary as (
        select
          count(*)::int as registered,
          count(*) filter (where u.confirmed_at is not null)::int as confirmed,
          count(*) filter (where u.last_sign_in_at >= now() - interval '7 days')::int as signed_in_last_7d,
          coalesce(sum(st.session_count), 0)::int as auth_sessions
        from auth.users u
        left join session_totals st on st.user_id = u.id
        where u.deleted_at is null
          and coalesce(u.is_anonymous, false) = false
      ), recent_accounts as (
        select
          u.id,
          coalesce(u.email, '') as email,
          p.full_name,
          coalesce(p.role, 'user') as profile_role,
          u.created_at,
          u.last_sign_in_at,
          st.last_session_refresh_at,
          coalesce(st.session_count, 0)::int as session_count
        from auth.users u
        left join public.profiles p on p.id = u.id
        left join session_totals st on st.user_id = u.id
        where u.deleted_at is null
          and coalesce(u.is_anonymous, false) = false
        order by u.last_sign_in_at desc nulls last, u.created_at desc
        limit 20
      )
      select
        s.registered,
        s.confirmed,
        s.signed_in_last_7d,
        s.auth_sessions,
        coalesce(
          json_agg(
            json_build_object(
              'id', r.id,
              'email', r.email,
              'fullName', r.full_name,
              'role', r.profile_role,
              'createdAt', r.created_at,
              'lastSignInAt', r.last_sign_in_at,
              'lastSessionRefreshAt', r.last_session_refresh_at,
              'authSessionCount', r.session_count
            ) order by r.last_sign_in_at desc nulls last, r.created_at desc
          ) filter (where r.id is not null),
          '[]'::json
        ) as recent
      from account_summary s
      left join recent_accounts r on true
      group by s.registered, s.confirmed, s.signed_in_last_7d, s.auth_sessions
    `;
    const accounts = accountRows[0] ?? {};
    registered = num(accounts.registered);
    confirmed = num(accounts.confirmed);
    signedInLast7d = num(accounts.signed_in_last_7d);
    authSessions = num(accounts.auth_sessions);
    const recent = Array.isArray(accounts.recent) ? accounts.recent : [];
    recentAccounts = recent.map((account) => {
      const row = account as Record<string, unknown>;
      const iso = (value: unknown): string | null => {
        if (!value) return null;
        const date = value instanceof Date ? value : new Date(String(value));
        return Number.isNaN(date.getTime()) ? null : date.toISOString();
      };
      return {
        id: String(row.id || ""),
        email: String(row.email || ""),
        fullName: row.fullName ? String(row.fullName) : null,
        role: String(row.role || "user"),
        createdAt: iso(row.createdAt) || now.toISOString(),
        lastSignInAt: iso(row.lastSignInAt),
        lastSessionRefreshAt: iso(row.lastSessionRefreshAt),
        authSessionCount: num(row.authSessionCount),
      };
    });
  } catch {
    authAccountsOk = false;
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
    accounts: {
      registered,
      confirmed,
      signedInLast7d,
      authSessions,
      recent: recentAccounts,
    },
    usageEventsOk,
    authAccountsOk,
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
