/**
 * Privacy-light product usage tracking.
 * Prefer DB (usage_events). Never store emails, names, or full query strings.
 */

import { db } from "@/db";
import { usageEvents } from "@/db/schema";
import { and, desc, gte, isNull, sql } from "drizzle-orm";

export const USAGE_EVENT_TYPES = [
  "page_view",
  "ranking_view",
  "profile_view",
  "search",
  "sample_view",
  "claim_submit",
  "claim_approved",
  "claim_rejected",
  "import",
  "support_submit",
  "waitlist_submit",
  "login",
  "register",
  "admin_open",
  "demo_role_switch",
  "ranking_period_change",
  "nav_perf",
] as const;

export type UsageEventType = (typeof USAGE_EVENT_TYPES)[number] | string;

export type TrackUsageInput = {
  eventType: UsageEventType;
  path?: string | null;
  role?: string | null;
  sessionId?: string | null;
  meta?: Record<string, string | number | boolean | null> | undefined | null;
};

/** Strip query/hash; cap length; only allow path-like strings. */
export function sanitizePath(raw: unknown): string | null {
  if (raw == null || raw === "") return null;
  let s = String(raw).trim();
  s = s.split("?")[0].split("#")[0];
  if (!s.startsWith("/")) s = `/${s}`;
  if (s.length > 200) s = s.slice(0, 200);
  if (/[\x00-\x1f]/.test(s)) return null;
  return s;
}

export async function trackUsage(
  input: TrackUsageInput
): Promise<{ ok: boolean; skipped?: string }> {
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
    const msg = e instanceof Error ? e.message : String(e);
    if (/usage_events|does not exist|relation/i.test(msg)) {
      return {
        ok: false,
        skipped: "usage_events table missing — run migration 016",
      };
    }
    console.error("[usage] track failed", msg.slice(0, 200));
    return { ok: false, skipped: "db error" };
  }
}

type ParsedMeta = Record<string, unknown>;

function parseMeta(raw: string | null | undefined): ParsedMeta {
  if (!raw) return {};
  try {
    const o = JSON.parse(raw);
    return o && typeof o === "object" ? (o as ParsedMeta) : {};
  } catch {
    return {};
  }
}

function countBy(map: Map<string, number>, key: string, n = 1) {
  if (!key) return;
  map.set(key, (map.get(key) || 0) + n);
}

function sortedEntries(map: Map<string, number>, limit = 15) {
  return Array.from(map.entries())
    .map(([key, count]) => ({ key, count }))
    .sort((a, b) => b.count - a.count)
    .slice(0, limit);
}

export type FunnelStep = {
  key: string;
  label: string;
  sessions: number;
  /** % of sessions that reached prior step (or of total for first) */
  ratePct: number | null;
};

export type UsageSummary = {
  sinceDays: number;
  totalEvents: number;
  uniqueSessions: number;
  uniqueVisitors: number;
  returningVisitors: number;
  returningVisitorPct: number | null;
  byType: { eventType: string; count: number }[];
  topPaths: { path: string; count: number }[];
  /** 1. Funnel */
  funnel: {
    rankingToProfile: FunnelStep[];
    demoToClaim: FunnelStep[];
    registerToClaim: FunnelStep[];
    claimOutcomes: {
      submitted: number;
      approved: number;
      rejected: number;
      approveRatePct: number | null;
    };
    waitlistByRole: { role: string; count: number }[];
  };
  /** 2. Engagement */
  engagement: {
    avgProfileViewsPerSession: number | null;
    sessionsWithProfile: number;
    ownProfileViews: number;
    otherProfileViews: number;
    rankingPeriodChanges: number;
    optimistRankingViews: number;
    ilcaRankingViews: number;
    demoRoleSwitches: number;
    avgNavMs: number | null;
    navSamples: number;
  };
  /** 4. Acquisition */
  acquisition: {
    bySource: { source: string; count: number }[];
    byDevice: { device: string; count: number }[];
    mobilePct: number | null;
  };
  migrationHint?: string;
};

export async function getUsageSummary(days = 7): Promise<UsageSummary> {
  const windowDays = Math.max(1, Math.min(days, 90));
  const since = new Date();
  since.setDate(since.getDate() - windowDays);
  // Bound JS aggregation cost by window size
  const rowLimit =
    windowDays <= 7 ? 3000 : windowDays <= 30 ? 5000 : 7000;

  const emptyFunnel = {
    rankingToProfile: [] as FunnelStep[],
    demoToClaim: [] as FunnelStep[],
    registerToClaim: [] as FunnelStep[],
    claimOutcomes: {
      submitted: 0,
      approved: 0,
      rejected: 0,
      approveRatePct: null as number | null,
    },
    waitlistByRole: [] as { role: string; count: number }[],
  };

  const emptyEngagement = {
    avgProfileViewsPerSession: null as number | null,
    sessionsWithProfile: 0,
    ownProfileViews: 0,
    otherProfileViews: 0,
    rankingPeriodChanges: 0,
    optimistRankingViews: 0,
    ilcaRankingViews: 0,
    demoRoleSwitches: 0,
    avgNavMs: null as number | null,
    navSamples: 0,
  };

  const emptyAcq = {
    bySource: [] as { source: string; count: number }[],
    byDevice: [] as { device: string; count: number }[],
    mobilePct: null as number | null,
  };

  try {
    const rows = await db
      .select({
        eventType: usageEvents.eventType,
        path: usageEvents.path,
        sessionId: usageEvents.sessionId,
        meta: usageEvents.meta,
        createdAt: usageEvents.createdAt,
      })
      .from(usageEvents)
      .where(gte(usageEvents.createdAt, since))
      .orderBy(desc(usageEvents.createdAt))
      .limit(rowLimit);

    const byTypeMap = new Map<string, number>();
    const pathMap = new Map<string, number>();
    const sessions = new Set<string>();

    // visitorId -> set of YYYY-MM-DD
    const visitorDays = new Map<string, Set<string>>();
    const sourceBySession = new Map<string, string>();
    const deviceBySession = new Map<string, string>();

    type SessFlags = {
      ranking: boolean;
      profile: boolean;
      sample: boolean;
      claim: boolean;
      register: boolean;
      login: boolean;
      waitlist: boolean;
      profileViews: number;
    };
    const sessFlags = new Map<string, SessFlags>();

    let claimSubmitted = 0;
    let claimApproved = 0;
    let claimRejected = 0;
    const waitlistRoles = new Map<string, number>();
    let ownProfileViews = 0;
    let otherProfileViews = 0;
    let rankingPeriodChanges = 0;
    let optimistRankingViews = 0;
    let ilcaRankingViews = 0;
    let demoRoleSwitches = 0;
    let navMsSum = 0;
    let navSamples = 0;

    const ensureSess = (sid: string): SessFlags => {
      let f = sessFlags.get(sid);
      if (!f) {
        f = {
          ranking: false,
          profile: false,
          sample: false,
          claim: false,
          register: false,
          login: false,
          waitlist: false,
          profileViews: 0,
        };
        sessFlags.set(sid, f);
      }
      return f;
    };

    for (const r of rows) {
      byTypeMap.set(r.eventType, (byTypeMap.get(r.eventType) || 0) + 1);
      if (r.path) pathMap.set(r.path, (pathMap.get(r.path) || 0) + 1);
      const sid = r.sessionId || "";
      if (sid) sessions.add(sid);

      const meta = parseMeta(r.meta);
      const vid =
        meta.vid != null && String(meta.vid).trim()
          ? String(meta.vid).trim().slice(0, 64)
          : "";
      if (vid && r.createdAt) {
        const day = new Date(r.createdAt).toISOString().slice(0, 10);
        if (!visitorDays.has(vid)) visitorDays.set(vid, new Set());
        visitorDays.get(vid)!.add(day);
      }

      if (sid) {
        if (meta.source && !sourceBySession.has(sid)) {
          sourceBySession.set(sid, String(meta.source).slice(0, 40));
        }
        if (meta.device && !deviceBySession.has(sid)) {
          deviceBySession.set(sid, String(meta.device).slice(0, 16));
        }
      }

      const et = r.eventType;
      const path = r.path || "";

      if (sid) {
        const f = ensureSess(sid);
        if (et === "ranking_view") f.ranking = true;
        if (et === "profile_view") {
          f.profile = true;
          f.profileViews += 1;
        }
        if (et === "sample_view") f.sample = true;
        if (et === "claim_submit") f.claim = true;
        if (et === "register") f.register = true;
        if (et === "login") f.login = true;
        if (et === "waitlist_submit") f.waitlist = true;
      }

      if (et === "claim_submit") claimSubmitted += 1;
      if (et === "claim_approved") claimApproved += 1;
      if (et === "claim_rejected") claimRejected += 1;

      if (et === "waitlist_submit") {
        const role = String(meta.role || meta.waitlistRole || "unspecified")
          .toLowerCase()
          .slice(0, 40);
        countBy(waitlistRoles, role || "unspecified");
      }

      if (et === "profile_view") {
        if (meta.own === true || meta.own === "true") ownProfileViews += 1;
        else otherProfileViews += 1;
      }

      if (et === "ranking_period_change") rankingPeriodChanges += 1;
      if (et === "demo_role_switch") demoRoleSwitches += 1;

      if (et === "ranking_view") {
        if (path.includes("/ilca")) ilcaRankingViews += 1;
        else optimistRankingViews += 1;
      }

      if (et === "nav_perf") {
        const ms = Number(meta.ms);
        if (Number.isFinite(ms) && ms > 0 && ms < 120_000) {
          navMsSum += ms;
          navSamples += 1;
        }
      }
    }

    const byType = Array.from(byTypeMap.entries())
      .map(([eventType, count]) => ({ eventType, count }))
      .sort((a, b) => b.count - a.count);

    const topPaths = Array.from(pathMap.entries())
      .map(([path, count]) => ({ path, count }))
      .sort((a, b) => b.count - a.count)
      .slice(0, 15);

    const uniqueVisitors = visitorDays.size;
    let returningVisitors = 0;
    for (const daysSet of visitorDays.values()) {
      if (daysSet.size >= 2) returningVisitors += 1;
    }

    const sessionList = Array.from(sessFlags.values());
    const nSess = sessions.size || 1;

    const countFlag = (pred: (f: SessFlags) => boolean) =>
      sessionList.filter(pred).length;

    const rankingSess = countFlag((f) => f.ranking);
    const rankingThenProfile = countFlag((f) => f.ranking && f.profile);
    const sampleSess = countFlag((f) => f.sample);
    const sampleThenClaim = countFlag((f) => f.sample && f.claim);
    const registerSess = countFlag((f) => f.register);
    const registerThenClaim = countFlag((f) => f.register && f.claim);

    const step = (
      key: string,
      label: string,
      sessionsN: number,
      denom: number | null
    ): FunnelStep => ({
      key,
      label,
      sessions: sessionsN,
      ratePct:
        denom != null && denom > 0
          ? Math.round((sessionsN / denom) * 1000) / 10
          : null,
    });

    const rankingToProfile: FunnelStep[] = [
      step("ranking", "Viewed rankings", rankingSess, nSess),
      step(
        "ranking_profile",
        "Rankings → profile (same session)",
        rankingThenProfile,
        rankingSess
      ),
    ];

    const demoToClaim: FunnelStep[] = [
      step("demo", "Viewed demo profile", sampleSess, nSess),
      step(
        "demo_claim",
        "Demo → claim submit (same session)",
        sampleThenClaim,
        sampleSess
      ),
    ];

    const registerToClaim: FunnelStep[] = [
      step("register", "Registered", registerSess, nSess),
      step(
        "register_claim",
        "Register → claim (same session)",
        registerThenClaim,
        registerSess
      ),
    ];

    const decided = claimApproved + claimRejected;
    const approveRatePct =
      decided > 0
        ? Math.round((claimApproved / decided) * 1000) / 10
        : null;

    let profileViewSum = 0;
    let sessionsWithProfile = 0;
    for (const f of sessionList) {
      if (f.profileViews > 0) {
        sessionsWithProfile += 1;
        profileViewSum += f.profileViews;
      }
    }

    const sourceCounts = new Map<string, number>();
    for (const s of sourceBySession.values()) countBy(sourceCounts, s);
    // Also count events without session-first-touch if we only have meta
    if (sourceCounts.size === 0) {
      for (const r of rows) {
        const m = parseMeta(r.meta);
        if (m.source) countBy(sourceCounts, String(m.source).slice(0, 40));
      }
    }

    const deviceCounts = new Map<string, number>();
    for (const d of deviceBySession.values()) countBy(deviceCounts, d);
    if (deviceCounts.size === 0) {
      for (const r of rows) {
        const m = parseMeta(r.meta);
        if (m.device) countBy(deviceCounts, String(m.device).slice(0, 16));
      }
    }

    const mobileN = deviceCounts.get("mobile") || 0;
    const desktopN = deviceCounts.get("desktop") || 0;
    const deviceTotal = mobileN + desktopN;

    return {
      sinceDays: days,
      totalEvents: rows.length,
      uniqueSessions: sessions.size,
      uniqueVisitors,
      returningVisitors,
      returningVisitorPct:
        uniqueVisitors > 0
          ? Math.round((returningVisitors / uniqueVisitors) * 1000) / 10
          : null,
      byType,
      topPaths,
      funnel: {
        rankingToProfile,
        demoToClaim,
        registerToClaim,
        claimOutcomes: {
          submitted: claimSubmitted,
          approved: claimApproved,
          rejected: claimRejected,
          approveRatePct,
        },
        waitlistByRole: sortedEntries(waitlistRoles).map((x) => ({
          role: x.key,
          count: x.count,
        })),
      },
      engagement: {
        avgProfileViewsPerSession:
          sessionsWithProfile > 0
            ? Math.round((profileViewSum / sessionsWithProfile) * 10) / 10
            : null,
        sessionsWithProfile,
        ownProfileViews,
        otherProfileViews,
        rankingPeriodChanges,
        optimistRankingViews,
        ilcaRankingViews,
        demoRoleSwitches,
        avgNavMs:
          navSamples > 0 ? Math.round(navMsSum / navSamples) : null,
        navSamples,
      },
      acquisition: {
        bySource: sortedEntries(sourceCounts).map((x) => ({
          source: x.key,
          count: x.count,
        })),
        byDevice: sortedEntries(deviceCounts).map((x) => ({
          device: x.key,
          count: x.count,
        })),
        mobilePct:
          deviceTotal > 0
            ? Math.round((mobileN / deviceTotal) * 1000) / 10
            : null,
      },
    };
  } catch (e) {
    const msg = e instanceof Error ? e.message : String(e);
    return {
      sinceDays: days,
      totalEvents: 0,
      uniqueSessions: 0,
      uniqueVisitors: 0,
      returningVisitors: 0,
      returningVisitorPct: null,
      byType: [],
      topPaths: [],
      funnel: emptyFunnel,
      engagement: emptyEngagement,
      acquisition: emptyAcq,
      migrationHint: /does not exist|relation/i.test(msg)
        ? "Run SQL migration 016_usage_events.sql in Supabase"
        : msg.slice(0, 160),
    };
  }
}

export type OpsHealth = {
  lastSeriesRegattaDate: string | null;
  daysSinceLastSeriesRegatta: number | null;
  lastImportAt: string | null;
  daysSinceLastImport: number | null;
  importsInWindow: number;
  goldActiveSailors: number;
  goldWith3PlusResults: number;
  goldCoveragePct: number | null;
  claimsPending: number;
  claimsApprovedAll: number;
  claimsRejectedAll: number;
  /** Average hours from claim create → approve (approved claims only) */
  avgClaimApproveHours: number | null;
  missingDob: number;
  missingSailNumber: number;
  missingNationality: number;
};

/** 3. Product / ops health (trust of rankings + claim ops). */
export async function getOpsHealth(days = 30): Promise<OpsHealth> {
  const {
    sailors,
    regattas,
    regattaResults,
    sailorClaims,
  } = await import("@/db/schema");
  const { count, eq, desc: ddesc } = await import("drizzle-orm");
  const { currentPeriodFromSgToday, todayYmdSg } = await import(
    "@/lib/datesSg"
  );
  const { resolveSailorFleet, scoringRegattasForFleet } = await import(
    "@/lib/ranking"
  );
  const { normalizeSgSeriesMembership } = await import(
    "@/lib/seriesMembership"
  );

  const since = new Date();
  since.setDate(since.getDate() - Math.max(1, Math.min(days, 90)));

  let lastSeriesRegattaDate: string | null = null;
  try {
    const [row] = await db
      .select({ date: regattas.date })
      .from(regattas)
      .where(eq(regattas.countsForRanking, true))
      .orderBy(ddesc(regattas.date))
      .limit(1);
    lastSeriesRegattaDate = row?.date || null;
  } catch {
    /* ignore */
  }

  const today = todayYmdSg();
  let daysSinceLastSeriesRegatta: number | null = null;
  if (lastSeriesRegattaDate) {
    const a = new Date(`${lastSeriesRegattaDate}T00:00:00Z`).getTime();
    const b = new Date(`${today}T00:00:00Z`).getTime();
    if (Number.isFinite(a) && Number.isFinite(b)) {
      daysSinceLastSeriesRegatta = Math.max(
        0,
        Math.round((b - a) / (24 * 3600 * 1000))
      );
    }
  }

  let lastImportAt: string | null = null;
  let importsInWindow = 0;
  try {
    const importRows = await db
      .select({
        createdAt: usageEvents.createdAt,
      })
      .from(usageEvents)
      .where(
        and(
          eq(usageEvents.eventType, "import"),
          gte(usageEvents.createdAt, since)
        )
      )
      .orderBy(desc(usageEvents.createdAt))
      .limit(200);
    importsInWindow = importRows.length;
    if (importRows[0]?.createdAt) {
      lastImportAt = new Date(importRows[0].createdAt).toISOString();
    } else {
      // Fall back to any last import ever
      const [any] = await db
        .select({ createdAt: usageEvents.createdAt })
        .from(usageEvents)
        .where(eq(usageEvents.eventType, "import"))
        .orderBy(desc(usageEvents.createdAt))
        .limit(1);
      if (any?.createdAt) {
        lastImportAt = new Date(any.createdAt).toISOString();
      }
    }
  } catch {
    /* ignore */
  }

  let daysSinceLastImport: number | null = null;
  if (lastImportAt) {
    const a = new Date(lastImportAt).getTime();
    const b = Date.now();
    if (Number.isFinite(a)) {
      daysSinceLastImport = Math.max(
        0,
        Math.round((b - a) / (24 * 3600 * 1000))
      );
    }
  }

  // Gold coverage: active gold sailors with ≥3 scoring results this half
  let goldActiveSailors = 0;
  let goldWith3PlusResults = 0;
  try {
    const period = currentPeriodFromSgToday();
    const [sailorRows, regattaRows] = await Promise.all([
      db
        .select({
          id: sailors.id,
          name: sailors.name,
          handle: sailors.handle,
          sailNumber: sailors.sailNumber,
          club: sailors.club,
          school: sailors.school,
          nationality: sailors.nationality,
          gender: sailors.gender,
          dob: sailors.dob,
          goldEntryDate: sailors.goldEntryDate,
          silverEntryDate: sailors.silverEntryDate,
          dropDate: sailors.dropDate,
          currentFleet: sailors.currentFleet,
          nationalSquadStatus: sailors.nationalSquadStatus,
        })
        .from(sailors),
      db
        .select({
          id: regattas.id,
          name: regattas.name,
          slug: regattas.slug,
          date: regattas.date,
          totalFleetSize: regattas.totalFleetSize,
          division: regattas.division,
          raceCount: regattas.raceCount,
          geography: regattas.geography,
          boatClass: regattas.boatClass,
          countsForRanking: regattas.countsForRanking,
        })
        .from(regattas)
        .where(eq(regattas.countsForRanking, true)),
    ]);

    const mapped = sailorRows.map((row) => {
      const n = normalizeSgSeriesMembership(row.currentFleet);
      return { ...row, currentFleet: n || row.currentFleet };
    });

    const goldIds: string[] = [];
    for (const s of mapped) {
      const r = resolveSailorFleet(s as never, period);
      if (r?.active && r.fleet === "Gold") {
        goldIds.push(s.id);
      }
    }
    goldActiveSailors = goldIds.length;

    const rMapped = regattaRows.map((row) => ({
      id: row.id,
      name: row.name,
      slug: row.slug,
      date: row.date,
      totalFleetSize: row.totalFleetSize,
      division: row.division,
      raceCount: row.raceCount,
      geography: row.geography ?? "SG",
      boatClass: row.boatClass ?? "Optimist",
      countsForRanking: row.countsForRanking !== false,
    }));

    const slots = scoringRegattasForFleet("Gold", period, rMapped as never);
    const scoringIdList = slots.map((x) => x.regatta.id);
    const scoringIds = new Set(scoringIdList);

    if (scoringIdList.length > 0 && goldIds.length > 0) {
      const { inArray, and: andOp } = await import("drizzle-orm");
      // Filter by scoring regattas (usually ≤5) instead of all gold sailors' history
      const resRows = await db
        .select({
          sailorId: regattaResults.sailorId,
          regattaId: regattaResults.regattaId,
        })
        .from(regattaResults)
        .where(
          andOp(
            inArray(regattaResults.regattaId, scoringIdList),
            inArray(regattaResults.sailorId, goldIds)
          )
        );

      const bySailor = new Map<string, Set<string>>();
      for (const row of resRows) {
        if (!scoringIds.has(row.regattaId)) continue;
        if (!bySailor.has(row.sailorId)) bySailor.set(row.sailorId, new Set());
        bySailor.get(row.sailorId)!.add(row.regattaId);
      }
      for (const id of goldIds) {
        const n = bySailor.get(id)?.size || 0;
        if (n >= 3) goldWith3PlusResults += 1;
      }
    }
  } catch (e) {
    console.warn("opsHealth gold coverage", e);
  }

  let claimsPending = 0;
  let claimsApprovedAll = 0;
  let claimsRejectedAll = 0;
  let avgClaimApproveHours: number | null = null;
  try {
    const [p] = await db
      .select({ n: count() })
      .from(sailorClaims)
      .where(eq(sailorClaims.status, "pending"));
    const [a] = await db
      .select({ n: count() })
      .from(sailorClaims)
      .where(eq(sailorClaims.status, "approved"));
    const [r] = await db
      .select({ n: count() })
      .from(sailorClaims)
      .where(eq(sailorClaims.status, "rejected"));
    claimsPending = Number(p?.n || 0);
    claimsApprovedAll = Number(a?.n || 0);
    claimsRejectedAll = Number(r?.n || 0);

    const approved = await db
      .select({
        createdAt: sailorClaims.createdAt,
        updatedAt: sailorClaims.updatedAt,
      })
      .from(sailorClaims)
      .where(eq(sailorClaims.status, "approved"))
      .limit(200);
    let sumH = 0;
    let nH = 0;
    for (const c of approved) {
      if (!c.createdAt || !c.updatedAt) continue;
      const h =
        (new Date(c.updatedAt).getTime() - new Date(c.createdAt).getTime()) /
        (3600 * 1000);
      if (Number.isFinite(h) && h >= 0 && h < 24 * 365) {
        sumH += h;
        nH += 1;
      }
    }
    if (nH > 0) avgClaimApproveHours = Math.round((sumH / nH) * 10) / 10;
  } catch {
    /* ignore */
  }

  let missingDob = 0;
  let missingSailNumber = 0;
  let missingNationality = 0;
  try {
    const [d] = await db
      .select({ n: count() })
      .from(sailors)
      .where(sql`${sailors.dob} is null`);
    const [s] = await db
      .select({ n: count() })
      .from(sailors)
      .where(
        sql`(${sailors.sailNumber} is null or ${sailors.sailNumber} = '')`
      );
    const [n] = await db
      .select({ n: count() })
      .from(sailors)
      .where(
        sql`(${sailors.nationality} is null or ${sailors.nationality} = '')`
      );
    missingDob = Number(d?.n || 0);
    missingSailNumber = Number(s?.n || 0);
    missingNationality = Number(n?.n || 0);
  } catch {
    /* ignore */
  }

  const goldCoveragePct =
    goldActiveSailors > 0
      ? Math.round((goldWith3PlusResults / goldActiveSailors) * 1000) / 10
      : null;

  return {
    lastSeriesRegattaDate,
    daysSinceLastSeriesRegatta,
    lastImportAt,
    daysSinceLastImport,
    importsInWindow,
    goldActiveSailors,
    goldWith3PlusResults,
    goldCoveragePct,
    claimsPending,
    claimsApprovedAll,
    claimsRejectedAll,
    avgClaimApproveHours,
    missingDob,
    missingSailNumber,
    missingNationality,
  };
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

  const [
    sailorCountRows,
    regattaCountRows,
    resultCountRows,
    claimPendingRows,
    supportNewRows,
    profileCountRows,
    fleetRows,
    claimedRows,
    unclaimedRows,
    guestRows,
    personalRows,
    unreviewedRows,
  ] = await Promise.all([
    db.select({ n: count() }).from(sailors),
    db.select({ n: count() }).from(regattas),
    db.select({ n: count() }).from(regattaResults),
    db
      .select({ n: count() })
      .from(sailorClaims)
      .where(eq(sailorClaims.status, "pending")),
    db
      .select({ n: count() })
      .from(supportMessages)
      .where(eq(supportMessages.status, "new")),
    db.select({ n: count() }).from(profiles),
    db
      .select({
        fleet: sailors.currentFleet,
        n: count(),
      })
      .from(sailors)
      .groupBy(sailors.currentFleet),
    db
      .select({ n: count() })
      .from(sailors)
      .where(isNotNull(sailors.parentId)),
    db
      .select({ n: count() })
      .from(sailors)
      .where(sql`${sailors.parentId} is null`),
    db
      .select({ n: count() })
      .from(sailors)
      .where(
        sql`${sailors.goldEntryDate} is null and ${sailors.silverEntryDate} is null and (${sailors.currentFleet} is null or ${sailors.currentFleet} = '')`
      ),
    db
      .select({ n: count() })
      .from(regattas)
      .where(eq(regattas.countsForRanking, false))
      .catch(() => [{ n: 0 }]),
    db
      .select({ n: count() })
      .from(regattas)
      .where(
        and(eq(regattas.countsForRanking, false), isNull(regattas.reviewedAt))
      )
      .catch(() => [{ n: 0 }]),
  ]);

  const fleet: Record<string, number> = {};
  for (const r of fleetRows) {
    const k = String(r.fleet || "unassigned").toLowerCase() || "unassigned";
    fleet[k] = Number(r.n) || 0;
  }

  return {
    sailors: Number(sailorCountRows[0]?.n || 0),
    regattas: Number(regattaCountRows[0]?.n || 0),
    results: Number(resultCountRows[0]?.n || 0),
    profiles: Number(profileCountRows[0]?.n || 0),
    claimsPending: Number(claimPendingRows[0]?.n || 0),
    supportNew: Number(supportNewRows[0]?.n || 0),
    sailorsClaimed: Number(claimedRows[0]?.n || 0),
    sailorsUnclaimed: Number(unclaimedRows[0]?.n || 0),
    guests: Number(guestRows[0]?.n || 0),
    personalRegattas: Number(personalRows[0]?.n || 0),
    personalUnreviewed: Number(unreviewedRows[0]?.n || 0),
    fleet,
  };
}
