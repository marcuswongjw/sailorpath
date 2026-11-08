import { sailingClassAliasRows } from "@/lib/classRegistry";
/**
 * Lean admin Stats aggregates — COUNT / DISTINCT only (no full result scans).
 * Account details are fetched only for the superadmin-gated Stats endpoint.
 * No auth details are copied into usage_events.
 *
 * Uses a small number of SQL round-trips (avoids saturating postgres.js max:5
 * and Supabase transaction-pooler concurrency).
 */

import { pgSql } from "@/db";

export type PlatformDemographics = {
  sailorsTotal: number;
  sailorsWithResults: number;
  nationalitiesCount: number;
  resultsTotal: number;
  classesCount: number;
  topNationalities: Array<{ country: string; count: number }>;
  boatClasses: Array<{
    className: string;
    regattaCount: number;
    resultCount: number;
    sailorCount: number;
  }>;
  genderBreakdown?: {
    male: number;
    female: number;
    unspecified: number;
  };
  birthYearCohorts?: Array<{
    cohort: string;
    count: number;
  }>;
  topClubs?: Array<{
    club: string;
    count: number;
  }>;
  multiClassSailors?: number;
  activeSeriesGold?: number;
  activeSeriesSilver?: number;
};

export type TrafficBreakdown = {
  sessions30d: number;
  pageViews7d: number;
  pageViews30d: number;
  rankingViews30d: number;
  profileViews30d: number;
  searches30d: number;
  sampleViews30d: number;
  uniqueVisitors7d: number;
  returningVisitors7d: number;
  ownProfileViews7d: number;
  otherProfileViews7d: number;
  rankingToProfileSessions30d: number;
  rankingSessions30d: number;
  demoToClaimSessions30d: number;
  demoSessions30d: number;
  devices7d: {
    mobile: number;
    desktop: number;
    unknown: number;
  };
  topSources7d: Array<{
    source: string;
    sessions: number;
    events: number;
  }>;
  topPaths7d: Array<{
    path: string;
    views: number;
    sessions: number;
  }>;
};

export type FeatureAdoption = {
  claims: {
    approved: number;
    rejected: number;
    pending: number;
    approvalRatePct: number | null;
    byRelation: {
      parent: number;
      sailor: number;
      other: number;
    };
  };
  publicProfileOptIns: {
    photo: number;
    equipment: number;
    school: number;
    milestones: number;
    social: number;
  };
  community: {
    followedSailorLinks: number;
    uniqueSailorsFollowed: number;
    activeFollowers: number;
  };
  coaching: {
    coachAccounts: number;
    coachSquads: number;
    squadSailors: number;
    watchlistEntries: number;
    developmentRecords: number;
    sharedRecords: number;
    coachNotes: number;
  };
  logbookAndGear: {
    raceObservations: number;
    sailorsWithRaceNotes: number;
    parentNotes: number;
    equipmentItems: number;
    sailorsWithEquipment: number;
    equipmentSessionsTotal: number;
    equipmentSessions30d: number;
  };
};

export type AdminStatsPayload = {
  generatedAt: string;
  cacheSeconds: number;
  northStars: {
    claimedSeriesSailors: number;
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
  trafficBreakdown?: TrafficBreakdown;
  dataTrust: {
    sailorsTotal: number;
    missingDob: number;
    missingOrPlaceholderSail: number;
  };
  demographics: PlatformDemographics;
  featureAdoption?: FeatureAdoption;
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

/** Bound both database execution and pool waits; cancel queries after the deadline. */
export class StatsTimeoutError extends Error {
  constructor() {
    super("Stats took too long to load. Please try Refresh.");
    this.name = "StatsTimeoutError";
  }
}

export async function withStatsQueryTimeout<T>(
  query: PromiseLike<T> & { cancel?: () => void },
  timeoutMs = 4_000
): Promise<T> {
  let timer: ReturnType<typeof setTimeout> | undefined;
  try {
    return await Promise.race([
      Promise.resolve(query),
      new Promise<never>((_, reject) => {
        timer = setTimeout(() => {
          reject(new StatsTimeoutError());
          query.cancel?.();
        }, timeoutMs);
      }),
    ]);
  } finally {
    if (timer) clearTimeout(timer);
  }
}

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

export async function getPlatformDemographics(): Promise<PlatformDemographics> {
  try {
    const aliasJson = JSON.stringify(sailingClassAliasRows());
    const [countsRow, nationalityRows, classRows] = await Promise.all([
      withStatsQueryTimeout(pgSql`
        select
          (select count(*)::int from public.sailors) as sailors_total,
          (select count(distinct nationality)::int from public.sailors) as nationalities_total,
          (select count(*)::int from public.regatta_results) as results_total,
          (select count(distinct sailor_id)::int from public.regatta_results) as sailors_with_results
      `),
      withStatsQueryTimeout(pgSql`
        select coalesce(nationality, 'Unknown') as country, count(*)::int as count
        from public.sailors
        group by coalesce(nationality, 'Unknown')
        order by count(*) desc
        limit 10
      `),
      withStatsQueryTimeout(pgSql`
        with aliases as (
          select * from jsonb_to_recordset(${aliasJson}::jsonb)
            as alias(token text, label text)
        ), classified as (
          select r.id, coalesce(a.label, nullif(trim(r.boat_class), ''), 'Unassigned') as class_name
          from public.regattas r
          left join aliases a on a.token = regexp_replace(lower(coalesce(r.boat_class, '')), '[^a-z0-9]', '', 'g')
        )
        select
          r.class_name,
          count(distinct r.id)::int as regattas,
          count(rr.id)::int as results,
          count(distinct rr.sailor_id)::int as sailors
        from classified r
        join public.regatta_results rr on rr.regatta_id = r.id
        group by r.class_name
        order by count(rr.id) desc
      `),
    ]);

    const cr = countsRow[0] ?? {};
    const sailorsTotal = num(cr.sailors_total);
    const nationalitiesTotal = num(cr.nationalities_total);
    const resultsTotal = num(cr.results_total);
    const sailorsWithResults = num(cr.sailors_with_results);

    const topNationalities = (nationalityRows ?? []).map((r) => ({
      country: String(r.country || "Unknown"),
      count: num(r.count),
    }));

    const boatClasses = (classRows ?? []).map((r) => ({
      className: String(r.class_name || "Unassigned"),
      regattaCount: num(r.regattas),
      resultCount: num(r.results),
      sailorCount: num(r.sailors),
    }));

    let multiClassSailors = 0;
    let genderBreakdown = { male: 0, female: 0, unspecified: sailorsTotal };
    let birthYearCohorts: Array<{ cohort: string; count: number }> = [];
    let topClubs: Array<{ club: string; count: number }> = [];
    let activeSeriesGold = 0;
    let activeSeriesSilver = 0;

    try {
      const multiRows = await withStatsQueryTimeout(pgSql`
        with aliases as (
          select * from jsonb_to_recordset(${aliasJson}::jsonb)
            as alias(token text, label text)
        ), classified as (
          select r.id, coalesce(a.label, nullif(trim(r.boat_class), ''), 'Unassigned') as class_name
          from public.regattas r
          left join aliases a on a.token = regexp_replace(lower(coalesce(r.boat_class, '')), '[^a-z0-9]', '', 'g')
        ), multi as (
          select rr.sailor_id
          from classified r
          join public.regatta_results rr on rr.regatta_id = r.id
          group by rr.sailor_id
          having count(distinct r.class_name) >= 2
        )
        select count(*)::int as multi_class_sailors from multi
      `);
      multiClassSailors = num(multiRows[0]?.multi_class_sailors);
    } catch {
      /* optional in minimal test schemas */
    }

    try {
      const extRows = await withStatsQueryTimeout(pgSql`
        with cohorts as (
          select
            case
              when dob is null then 'DOB not recorded'
              when extract(year from dob)::int >= 2015 then '2015+ (U12 Junior)'
              when extract(year from dob)::int between 2011 and 2014 then '2011–2014 (U16 Youth)'
              when extract(year from dob)::int between 2008 and 2010 then '2008–2010 (U19 Youth)'
              else '2007 & earlier (Open / Senior)'
            end as cohort,
            case
              when dob is null then 5
              when extract(year from dob)::int >= 2015 then 1
              when extract(year from dob)::int between 2011 and 2014 then 2
              when extract(year from dob)::int between 2008 and 2010 then 3
              else 4
            end as sort_order
          from public.sailors
        ),
        cohort_counts as (
          select cohort, count(*)::int as count
          from cohorts
          group by cohort, sort_order
          order by sort_order asc
        ),
        club_counts as (
          select trim(club) as club, count(*)::int as count
          from public.sailors
          where club is not null
            and trim(club) <> ''
            and lower(trim(club)) not in ('unknown', 'tbc', 'n/a', '-', 'none')
          group by trim(club)
          order by count(*) desc, trim(club) asc
          limit 10
        ),
        series_active as (
          select
            gold_entry_date,
            silver_entry_date,
            current_fleet
          from public.sailors
          where lower(trim(coalesce(current_fleet, ''))) <> 'guest'
            and (
              lower(trim(coalesce(current_fleet, ''))) in (
                'series', 'gold', 'silver', 'in sg fleet', 'member'
              )
              or silver_entry_date is not null
              or gold_entry_date is not null
            )
            and (drop_date is null or drop_date > (now() at time zone 'Asia/Singapore')::date)
        )
        select
          (select count(*) filter (where upper(trim(coalesce(gender, ''))) in ('M', 'MALE', 'BOY', 'BOYS'))::int from public.sailors) as gender_male,
          (select count(*) filter (where upper(trim(coalesce(gender, ''))) in ('F', 'FEMALE', 'GIRL', 'GIRLS'))::int from public.sailors) as gender_female,
          (select count(*) filter (where upper(trim(coalesce(gender, ''))) not in ('M', 'MALE', 'BOY', 'BOYS', 'F', 'FEMALE', 'GIRL', 'GIRLS'))::int from public.sailors) as gender_unspecified,
          (select count(*) filter (where gold_entry_date is not null or lower(trim(coalesce(current_fleet, ''))) = 'gold')::int from series_active) as active_series_gold,
          (select count(*) filter (where gold_entry_date is null and lower(trim(coalesce(current_fleet, ''))) <> 'gold')::int from series_active) as active_series_silver,
          coalesce((select json_agg(row_to_json(cohort_counts)) from cohort_counts), '[]'::json) as birth_year_cohorts,
          coalesce((select json_agg(row_to_json(club_counts)) from club_counts), '[]'::json) as top_clubs
      `);
      const ext = extRows[0] ?? {};
      genderBreakdown = {
        male: num(ext.gender_male),
        female: num(ext.gender_female),
        unspecified: num(ext.gender_unspecified),
      };
      activeSeriesGold = num(ext.active_series_gold);
      activeSeriesSilver = num(ext.active_series_silver);
      const rawCohorts = Array.isArray(ext.birth_year_cohorts)
        ? ext.birth_year_cohorts
        : [];
      birthYearCohorts = rawCohorts.map((row: Record<string, unknown>) => ({
        cohort: String(row.cohort || "Unknown"),
        count: num(row.count),
      }));
      const rawClubs = Array.isArray(ext.top_clubs) ? ext.top_clubs : [];
      topClubs = rawClubs.map((row: Record<string, unknown>) => ({
        club: String(row.club || "Unknown"),
        count: num(row.count),
      }));
    } catch {
      /* optional in minimal test schemas */
    }

    return {
      sailorsTotal,
      sailorsWithResults,
      nationalitiesCount: nationalitiesTotal,
      resultsTotal,
      classesCount: boatClasses.length,
      topNationalities,
      boatClasses,
      genderBreakdown,
      birthYearCohorts,
      topClubs,
      multiClassSailors,
      activeSeriesGold,
      activeSeriesSilver,
    };
  } catch (error) {
    console.warn("[admin/stats] Demographics metrics unavailable", error);
    return {
      sailorsTotal: 0,
      sailorsWithResults: 0,
      nationalitiesCount: 0,
      resultsTotal: 0,
      classesCount: 0,
      topNationalities: [],
      boatClasses: [],
    };
  }
}

/**
 * Compute live admin stats. Prefer this over many parallel Drizzle selects —
 * one inventory CTE + one usage pass stays well under the pool limit.
 */
export async function getAdminStats(): Promise<AdminStatsPayload> {
  const now = new Date();

  const inventory = await withStatsQueryTimeout(pgSql`
    with series_roster as (
      select parent_id from public.sailors
      where lower(trim(coalesce(current_fleet, ''))) <> 'guest'
        and (
          lower(trim(coalesce(current_fleet, ''))) in (
            'series', 'gold', 'silver', 'in sg fleet', 'member'
          )
          or silver_entry_date is not null
          or gold_entry_date is not null
        )
        and (drop_date is null or drop_date > (now() at time zone 'Asia/Singapore')::date)
    )
    select
      (select count(*)::int from public.sailors) as sailors_total,
      (select count(*)::int from public.sailors where parent_id is not null) as claimed,
      (select count(*)::int from series_roster) as series_sailors,
      (select count(*)::int from series_roster where parent_id is not null) as claimed_series,
      (select count(*)::int from public.sailor_claims where status = 'pending') as claims_pending,
      (select count(*)::int from public.support_messages where status = 'new') as support_new,
      (select count(*)::int from public.regattas where counts_for_ranking = true) as ranking_regattas,
      (select count(*)::int from public.sailors where dob is null) as missing_dob,
      (select count(*)::int from public.sailors
        where sail_number is null
           or trim(coalesce(sail_number, '')) = ''
           or trim(sail_number) ~* '^(SGP[[:space:]]*)?0+$'
      ) as missing_sail
  `);

  const row = inventory[0] ?? {};
  const claimedSailors = num(row.claimed);
  const seriesSailors = num(row.series_sailors);
  const claimedSeriesSailors = num(row.claimed_series);

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
      withStatsQueryTimeout(pgSql`
        select count(distinct session_id)::int as n
        from public.usage_events
        where created_at >= now() - interval '7 days'
          and session_id is not null
          and session_id <> ''
      `),
      withStatsQueryTimeout(pgSql`
        select event_type, count(*)::int as n
        from public.usage_events
        where created_at >= now() - interval '7 days'
        group by event_type
      `),
      withStatsQueryTimeout(pgSql`
        select created_at
        from public.usage_events
        where event_type = 'import'
        order by created_at desc
        limit 1
      `),
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
  } catch (error) {
    console.warn("[admin/stats] Usage metrics unavailable", error);
    usageEventsOk = false;
  }

  try {
    const accountRows = await withStatsQueryTimeout(pgSql`
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
    `);
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
  } catch (error) {
    console.warn("[admin/stats] Account metrics unavailable", error);
    authAccountsOk = false;
  }

  let trafficBreakdown: TrafficBreakdown = {
    sessions30d: weeklyActiveSessions ?? 0,
    pageViews7d: 0,
    pageViews30d: 0,
    rankingViews30d: rankingViews,
    profileViews30d: profileViews,
    searches30d: searches,
    sampleViews30d: sampleViews,
    uniqueVisitors7d: 0,
    returningVisitors7d: 0,
    ownProfileViews7d: 0,
    otherProfileViews7d: profileViews,
    rankingToProfileSessions30d: 0,
    rankingSessions30d: 0,
    demoToClaimSessions30d: 0,
    demoSessions30d: 0,
    devices7d: { mobile: 0, desktop: 0, unknown: weeklyActiveSessions ?? 0 },
    topSources7d: [],
    topPaths7d: [],
  };

  if (usageEventsOk) {
    try {
      const tbRows = await withStatsQueryTimeout(pgSql`
        with recent as (
          select
            event_type,
            path,
            session_id,
            created_at,
            (created_at >= now() - interval '7 days') as is_7d,
            case
              when meta is not null and left(trim(meta), 1) = '{' and right(trim(meta), 1) = '}'
              then meta::jsonb
              else null
            end as m
          from public.usage_events
          where created_at >= now() - interval '30 days'
        ),
        visitor_days_7d as (
          select
            m->>'vid' as vid,
            count(distinct (created_at at time zone 'Asia/Singapore')::date)::int as active_days
          from recent
          where is_7d and m->>'vid' is not null and m->>'vid' <> ''
          group by m->>'vid'
        ),
        session_funnels_30d as (
          select
            session_id,
            bool_or(event_type = 'ranking_view') as has_ranking,
            bool_or(event_type = 'profile_view') as has_profile,
            bool_or(event_type = 'sample_view') as has_sample,
            bool_or(event_type = 'claim_submit') as has_claim
          from recent
          where session_id is not null and session_id <> ''
          group by session_id
        ),
        session_devices_7d as (
          select
            session_id,
            coalesce(max(m->>'device'), 'unknown') as device
          from recent
          where is_7d and session_id is not null and session_id <> ''
          group by session_id
        ),
        top_sources_7d as (
          select
            coalesce(nullif(trim(m->>'source'), ''), 'direct') as source,
            count(distinct session_id)::int as sessions,
            count(*)::int as events
          from recent
          where is_7d
          group by coalesce(nullif(trim(m->>'source'), ''), 'direct')
          order by count(distinct session_id) desc, count(*) desc
          limit 8
        ),
        top_paths_7d as (
          select
            path,
            count(*)::int as views,
            count(distinct session_id)::int as sessions
          from recent
          where is_7d
            and path is not null
            and path <> ''
            and event_type in ('page_view', 'ranking_view', 'profile_view')
          group by path
          order by count(*) desc
          limit 8
        )
        select
          (select count(distinct session_id)::int from recent where session_id is not null and session_id <> '') as sessions_30d,
          (select count(*)::int from recent where is_7d and event_type = 'page_view') as page_views_7d,
          (select count(*)::int from recent where event_type = 'page_view') as page_views_30d,
          (select count(*)::int from recent where event_type = 'ranking_view') as ranking_views_30d,
          (select count(*)::int from recent where event_type = 'profile_view') as profile_views_30d,
          (select count(*)::int from recent where event_type = 'search') as searches_30d,
          (select count(*)::int from recent where event_type = 'sample_view') as sample_views_30d,
          (select count(*)::int from visitor_days_7d) as unique_visitors_7d,
          (select count(*)::int from visitor_days_7d where active_days >= 2) as returning_visitors_7d,
          (select count(*)::int from recent where is_7d and event_type = 'profile_view' and m->>'own' = 'true') as own_profile_views_7d,
          (select count(*)::int from recent where is_7d and event_type = 'profile_view' and coalesce(m->>'own', 'false') <> 'true') as other_profile_views_7d,
          (select count(*)::int from session_funnels_30d where has_ranking) as ranking_sessions_30d,
          (select count(*)::int from session_funnels_30d where has_ranking and has_profile) as ranking_to_profile_30d,
          (select count(*)::int from session_funnels_30d where has_sample) as demo_sessions_30d,
          (select count(*)::int from session_funnels_30d where has_sample and has_claim) as demo_to_claim_30d,
          (select count(*)::int from session_devices_7d where device = 'mobile') as mobile_sessions_7d,
          (select count(*)::int from session_devices_7d where device = 'desktop') as desktop_sessions_7d,
          (select count(*)::int from session_devices_7d where device not in ('mobile', 'desktop')) as unknown_device_sessions_7d,
          coalesce((select json_agg(row_to_json(top_sources_7d)) from top_sources_7d), '[]'::json) as top_sources_7d,
          coalesce((select json_agg(row_to_json(top_paths_7d)) from top_paths_7d), '[]'::json) as top_paths_7d
      `);
      const tb = tbRows[0] ?? {};
      const rawSources = Array.isArray(tb.top_sources_7d)
        ? tb.top_sources_7d
        : [];
      const rawPaths = Array.isArray(tb.top_paths_7d) ? tb.top_paths_7d : [];
      trafficBreakdown = {
        sessions30d: num(tb.sessions_30d),
        pageViews7d: num(tb.page_views_7d),
        pageViews30d: num(tb.page_views_30d),
        rankingViews30d: num(tb.ranking_views_30d),
        profileViews30d: num(tb.profile_views_30d),
        searches30d: num(tb.searches_30d),
        sampleViews30d: num(tb.sample_views_30d),
        uniqueVisitors7d: num(tb.unique_visitors_7d),
        returningVisitors7d: num(tb.returning_visitors_7d),
        ownProfileViews7d: num(tb.own_profile_views_7d),
        otherProfileViews7d: num(tb.other_profile_views_7d),
        rankingToProfileSessions30d: num(tb.ranking_to_profile_30d),
        rankingSessions30d: num(tb.ranking_sessions_30d),
        demoToClaimSessions30d: num(tb.demo_to_claim_30d),
        demoSessions30d: num(tb.demo_sessions_30d),
        devices7d: {
          mobile: num(tb.mobile_sessions_7d),
          desktop: num(tb.desktop_sessions_7d),
          unknown: num(tb.unknown_device_sessions_7d),
        },
        topSources7d: rawSources.map((s: Record<string, unknown>) => ({
          source: String(s.source || "direct"),
          sessions: num(s.sessions),
          events: num(s.events),
        })),
        topPaths7d: rawPaths.map((p: Record<string, unknown>) => ({
          path: String(p.path || "/"),
          views: num(p.views),
          sessions: num(p.sessions),
        })),
      };
    } catch {
      /* optional in minimal test schemas */
    }
  }

  let featureAdoption: FeatureAdoption = {
    claims: {
      approved: 0,
      rejected: 0,
      pending: num(row.claims_pending),
      approvalRatePct: null,
      byRelation: { parent: 0, sailor: 0, other: 0 },
    },
    publicProfileOptIns: {
      photo: 0,
      equipment: 0,
      school: 0,
      milestones: 0,
      social: 0,
    },
    community: {
      followedSailorLinks: 0,
      uniqueSailorsFollowed: 0,
      activeFollowers: 0,
    },
    coaching: {
      coachAccounts: 0,
      coachSquads: 0,
      squadSailors: 0,
      watchlistEntries: 0,
      developmentRecords: 0,
      sharedRecords: 0,
      coachNotes: 0,
    },
    logbookAndGear: {
      raceObservations: 0,
      sailorsWithRaceNotes: 0,
      parentNotes: 0,
      equipmentItems: 0,
      sailorsWithEquipment: 0,
      equipmentSessionsTotal: 0,
      equipmentSessions30d: 0,
    },
  };

  try {
    const faRows = await withStatsQueryTimeout(pgSql`
      select
        (select count(*)::int from public.sailor_claims where status = 'approved') as claims_approved,
        (select count(*)::int from public.sailor_claims where status = 'rejected') as claims_rejected,
        (select count(*)::int from public.sailor_claims where status = 'pending') as claims_pending,
        (select count(*)::int from public.sailors where parent_id is not null and owner_relation = 'parent') as rel_parent,
        (select count(*)::int from public.sailors where parent_id is not null and owner_relation = 'sailor') as rel_sailor,
        (select count(*)::int from public.sailors where parent_id is not null and coalesce(owner_relation, 'other') not in ('parent', 'sailor')) as rel_other,
        (select count(*)::int from public.sailors where parent_id is not null and show_profile_photo_on_public_profile = true) as opt_photo,
        (select count(*)::int from public.sailors where parent_id is not null and (show_equipment_on_public_profile = true or is_public_equipment = true)) as opt_equipment,
        (select count(*)::int from public.sailors where parent_id is not null and show_school_on_public_profile = true) as opt_school,
        (select count(*)::int from public.sailors where parent_id is not null and show_sailing_milestones_on_public_profile = true) as opt_milestones,
        (select count(*)::int from public.sailors where parent_id is not null and show_social_links_on_public_profile = true) as opt_social,
        (select count(*)::int from public.followed_sailors) as followed_links,
        (select count(distinct sailor_id)::int from (
          select sailor_id from public.followed_sailors
          union
          select sailor_id from public.coach_followed_sailors
        ) fs) as unique_sailors_followed,
        (select count(distinct follower_profile_id)::int from public.followed_sailors) as active_followers,
        (select count(*)::int from public.profiles where role = 'coach') as coach_accounts,
        (select count(*)::int from public.coach_squads) as coach_squads,
        (select count(distinct sailor_id)::int from public.coach_squad_members) as squad_sailors,
        (select count(*)::int from public.coach_followed_sailors) as watchlist_entries,
        (select count(*)::int from public.coach_development_records) as dev_records,
        (select count(*)::int from public.coach_development_records where visibility = 'shared') as shared_records,
        (select count(*)::int from public.coach_sailor_notes) as coach_notes,
        (select count(*)::int from public.race_observations) as race_observations,
        (select count(distinct sailor_id)::int from public.race_observations) as sailors_with_race_notes,
        (select count(*)::int from public.parent_notes) as parent_notes,
        (select count(*)::int from public.equipment_items) as equipment_items,
        (select count(distinct sailor_id)::int from public.equipment_items) as sailors_with_equipment,
        (select count(*)::int from public.equipment_usages) as equipment_sessions_total,
        (select count(*)::int from public.equipment_usages where created_at >= now() - interval '30 days') as equipment_sessions_30d
    `);
    const fa = faRows[0] ?? {};
    const approved = num(fa.claims_approved);
    const rejected = num(fa.claims_rejected);
    const pending = num(fa.claims_pending);
    featureAdoption = {
      claims: {
        approved,
        rejected,
        pending,
        approvalRatePct: pct(approved, approved + rejected),
        byRelation: {
          parent: num(fa.rel_parent),
          sailor: num(fa.rel_sailor),
          other: num(fa.rel_other),
        },
      },
      publicProfileOptIns: {
        photo: num(fa.opt_photo),
        equipment: num(fa.opt_equipment),
        school: num(fa.opt_school),
        milestones: num(fa.opt_milestones),
        social: num(fa.opt_social),
      },
      community: {
        followedSailorLinks: num(fa.followed_links),
        uniqueSailorsFollowed: num(fa.unique_sailors_followed),
        activeFollowers: num(fa.active_followers),
      },
      coaching: {
        coachAccounts: num(fa.coach_accounts),
        coachSquads: num(fa.coach_squads),
        squadSailors: num(fa.squad_sailors),
        watchlistEntries: num(fa.watchlist_entries),
        developmentRecords: num(fa.dev_records),
        sharedRecords: num(fa.shared_records),
        coachNotes: num(fa.coach_notes),
      },
      logbookAndGear: {
        raceObservations: num(fa.race_observations),
        sailorsWithRaceNotes: num(fa.sailors_with_race_notes),
        parentNotes: num(fa.parent_notes),
        equipmentItems: num(fa.equipment_items),
        sailorsWithEquipment: num(fa.sailors_with_equipment),
        equipmentSessionsTotal: num(fa.equipment_sessions_total),
        equipmentSessions30d: num(fa.equipment_sessions_30d),
      },
    };
  } catch {
    /* optional in minimal test schemas */
  }

  const demographics = await getPlatformDemographics();

  return {
    generatedAt: now.toISOString(),
    cacheSeconds: CACHE_SECONDS,
    northStars: {
      weeklyActiveSessions,
      claimedSailors,
      claimedSeriesSailors,
      seriesSailors,
      rosterClaimedPct: pct(claimedSeriesSailors, seriesSailors),
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
    trafficBreakdown,
    dataTrust: {
      sailorsTotal: num(row.sailors_total),
      missingDob: num(row.missing_dob),
      missingOrPlaceholderSail: num(row.missing_sail),
    },
    demographics,
    featureAdoption,
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
