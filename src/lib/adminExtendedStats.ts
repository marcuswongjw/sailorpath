/**
 * Extended admin dashboard metrics (equipment, claims, adoption, retention,
 * ranking health, ILCA transition, support). Privacy-light for traffic;
 * entity names only appear in superadmin data-quality style lists.
 */

import { desc, eq, gte, isNotNull, sql } from "drizzle-orm";
import { db } from "@/db";
import {
  equipmentItems,
  equipmentUsages,
  parentNotes,
  raceObservations,
  regattaResults,
  regattas,
  sailors,
  sailorClaims,
  supportMessages,
  usageEvents,
} from "@/db/schema";
import { birthYear } from "@/lib/age";
import { currentPeriodFromSgToday, todayYmdSg, toYmd } from "@/lib/datesSg";
import { evaluateEquipmentBadge } from "@/lib/equipment";
import {
  resolveSailorFleet,
  scoringRegattasForFleet,
  type RegattaRecord,
  type SailorRecord,
} from "@/lib/ranking";
import { normalizeSgSeriesMembership } from "@/lib/seriesMembership";
import { profileBoatClassGroup } from "@/lib/profileAnalytics";

function parseMeta(raw: string | null | undefined): Record<string, unknown> {
  if (!raw) return {};
  try {
    const o = JSON.parse(raw);
    return o && typeof o === "object" ? (o as Record<string, unknown>) : {};
  } catch {
    return {};
  }
}

function pct(n: number, d: number): number | null {
  if (!d) return null;
  return Math.round((n / d) * 1000) / 10;
}

function isoWeekKey(d: Date): string {
  // ISO week: YYYY-Www
  const t = new Date(Date.UTC(d.getFullYear(), d.getMonth(), d.getDate()));
  const day = t.getUTCDay() || 7;
  t.setUTCDate(t.getUTCDate() + 4 - day);
  const yearStart = new Date(Date.UTC(t.getUTCFullYear(), 0, 1));
  const week = Math.ceil(
    ((t.getTime() - yearStart.getTime()) / 86400000 + 1) / 7
  );
  return `${t.getUTCFullYear()}-W${String(week).padStart(2, "0")}`;
}

function weeksBetweenKeys(a: string, b: string): number | null {
  // Approximate: parse year and week
  const ma = /^(\d{4})-W(\d{2})$/.exec(a);
  const mb = /^(\d{4})-W(\d{2})$/.exec(b);
  if (!ma || !mb) return null;
  const ya = Number(ma[1]);
  const yb = Number(mb[1]);
  const wa = Number(ma[2]);
  const wb = Number(mb[2]);
  return (yb - ya) * 52 + (wb - wa);
}

function bucketCategory(cat: string): string {
  const c = String(cat || "").toLowerCase();
  if (c === "hull") return "hull";
  if (c === "sail") return "sail";
  if (c === "mast" || c === "boom" || c === "sprit") return "mast_set";
  if (c === "daggerboard" || c === "rudder") return "foil_set";
  return "other";
}

function classifyRejectionReason(note: string | null | undefined): string {
  const n = String(note || "")
    .trim()
    .toLowerCase();
  if (!n) return "no_reason_given";
  if (/sail\s*#|sail\s*number|wrong\s*sail/.test(n)) return "wrong_sail_number";
  if (/duplicate|already\s*claim|claimed/.test(n)) return "duplicate_claim";
  if (/not\s*(the\s*)?parent|relation|identity|verify/.test(n))
    return "identity_unverified";
  if (/incomplete|missing|insufficient|more\s*info/.test(n))
    return "incomplete_info";
  if (/spam|abuse|fake/.test(n)) return "spam_or_abuse";
  return "other";
}

export type ExtendedAdminStats = {
  equipment: {
    sailorsWithEquipment: number;
    claimedSailors: number;
    adoptionPct: number | null;
    totalItems: number;
    avgItemsPerSailorWithGear: number | null;
    avgItemsPerClaimedSailor: number | null;
    sessionsInWindow: number;
    sessionsPerWeek: number | null;
    logsByPart: { part: string; count: number }[];
    primaryCount: number;
    backupCount: number;
    primaryBackupRatio: number | null;
    alertsTriggered: number;
    alertByBadge: { badge: string; count: number }[];
  };
  claimBySource: {
    bySource: {
      source: string;
      claims: number;
      sessions: number;
      claimRatePct: number | null;
    }[];
    byDevice: {
      device: string;
      claims: number;
      sessions: number;
      claimRatePct: number | null;
    }[];
    avgHoursProfileToClaim: number | null;
    medianHoursProfileToClaim: number | null;
    samplesWithTiming: number;
    unknownSourceClaims: number;
  };
  featureAdoption: {
    claimedSailors: number;
    withMilestones: number;
    withMilestonesPct: number | null;
    withEquipment: number;
    withEquipmentPct: number | null;
    withNotes: number;
    withNotesPct: number | null;
    withPrivacyChanged: number;
    withPrivacyChangedPct: number | null;
    withDualClass: number;
    withDualClassPct: number | null;
  };
  retention: {
    visitorCohorts: {
      cohortWeek: string;
      size: number;
      week1Pct: number | null;
      week4Pct: number | null;
      week12Pct: number | null;
    }[];
    claimedReengagement: {
      avgDaysSinceUpdate: number | null;
      activeLast7d: number;
      activeLast30d: number;
      inactive30dPlus: number;
      byRelation: { relation: string; count: number; avgDays: number | null }[];
    };
  };
  revenueSupport: {
    waitlistSubmits: number;
    foundingWaitlist: number;
    supportNew: number;
    supportRead: number;
    supportResolved: number;
    supportInWindow: number;
    avgResolutionHours: number | null;
    claimRejectionReasons: { reason: string; count: number }[];
    paymentInstrumented: false;
    note: string;
  };
  rankingHealth: {
    silverCoveragePct: number | null;
    silverWith3Plus: number;
    silverActive: number;
    ilcaCoveragePct: number | null;
    ilcaWith3Plus: number;
    ilcaListed: number;
    topRegattas: {
      regattaId: string;
      name: string;
      date: string;
      fleetSize: number;
      participants: number;
      participationPct: number | null;
      dnsCount: number;
      dnsRatePct: number | null;
    }[];
  };
  ilcaTransition: {
    sailorsWithBothClasses: number;
    sailorsWithIlcaOnly: number;
    sailorsWithOptimistOnly: number;
    avgAgeAtFirstIlca: number | null;
    avgMonthsOptiBeforeIlca: number | null;
    samplesAge: number;
    samplesMonths: number;
    goldNeverIlca: number;
    goldNeverIlcaDropped: number;
  };
};

export async function getExtendedAdminStats(
  days = 30
): Promise<ExtendedAdminStats> {
  const windowDays = Math.max(1, Math.min(days, 90));
  const since = new Date();
  since.setDate(since.getDate() - windowDays);
  const today = todayYmdSg();
  const sinceYmd = toYmd(since) || "1970-01-01";
  // Results older than this rarely change ranking-health aggregates
  const resultsCutoff = new Date();
  resultsCutoff.setFullYear(resultsCutoff.getFullYear() - 4);
  const resultsCutoffYmd = resultsCutoff.toISOString().slice(0, 10);
  const usageLimit = windowDays <= 7 ? 2000 : windowDays <= 30 ? 3500 : 5000;

  // ── One parallel batch (no sequential follow-up queries) ───────────
  const [
    equipRows,
    usageRows,
    claimedSailorRows,
    supportRows,
    claimRows,
    resultClassRows,
    equipSess,
    fleetSailors,
    regattaRows,
  ] = await Promise.all([
    db
      .select({
        id: equipmentItems.id,
        sailorId: equipmentItems.sailorId,
        category: equipmentItems.category,
        status: equipmentItems.status,
        condition: equipmentItems.condition,
        isPrimary: equipmentItems.isPrimary,
        useCount: equipmentItems.useCount,
        acquiredOn: equipmentItems.acquiredOn,
      })
      .from(equipmentItems)
      .limit(4000)
      .catch(() => [] as never[]),
    // Only events needed for claim-by-source / retention (not full traffic dump)
    db
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
      .limit(usageLimit)
      .catch(() => [] as never[]),
    db
      .select({
        id: sailors.id,
        parentId: sailors.parentId,
        ownerRelation: sailors.ownerRelation,
        // Avoid shipping multi-KB journey JSON per row — flag only
        hasJourney: sql<boolean>`coalesce(nullif(trim(${sailors.sailingJourney}), ''), '[]') not in ('[]', 'null')`,
        isPublicWeight: sailors.isPublicWeight,
        isPublicDob: sailors.isPublicDob,
        isPublicEquipment: sailors.isPublicEquipment,
        sailNumberIlca4: sailors.sailNumberIlca4,
        ilca4NationalList: sailors.ilca4NationalList,
        hullBrandIlca4: sailors.hullBrandIlca4,
        goldEntryDate: sailors.goldEntryDate,
        dropDate: sailors.dropDate,
        dob: sailors.dob,
        updatedAt: sailors.updatedAt,
      })
      .from(sailors)
      .where(isNotNull(sailors.parentId))
      .catch(() => [] as never[]),
    db
      .select({
        status: supportMessages.status,
        topic: supportMessages.topic,
        createdAt: supportMessages.createdAt,
        updatedAt: supportMessages.updatedAt,
      })
      .from(supportMessages)
      .limit(1000)
      .catch(() => [] as never[]),
    db
      .select({
        id: sailorClaims.id,
        status: sailorClaims.status,
        note: sailorClaims.note,
        createdAt: sailorClaims.createdAt,
        updatedAt: sailorClaims.updatedAt,
      })
      .from(sailorClaims)
      .limit(1000)
      .catch(() => [] as never[]),
    db
      .select({
        sailorId: regattaResults.sailorId,
        regattaId: regattaResults.regattaId,
        isDns: regattaResults.isDns,
        boatClass: regattas.boatClass,
        regattaDate: regattas.date,
        regattaName: regattas.name,
        totalFleetSize: regattas.totalFleetSize,
        countsForRanking: regattas.countsForRanking,
      })
      .from(regattaResults)
      .innerJoin(regattas, eq(regattaResults.regattaId, regattas.id))
      .where(gte(regattas.date, resultsCutoffYmd))
      .limit(12000)
      .catch(() => [] as never[]),
    db
      .select({
        equipmentItemId: equipmentUsages.equipmentItemId,
        usedOn: equipmentUsages.usedOn,
      })
      .from(equipmentUsages)
      .where(gte(equipmentUsages.usedOn, sinceYmd))
      .limit(4000)
      .catch(() => [] as never[]),
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
        ilca4NationalList: sailors.ilca4NationalList,
      })
      .from(sailors)
      .catch(() => [] as never[]),
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
      .catch(() => [] as never[]),
  ]);

  const equipSessionsInWindow = equipSess.length;
  const equipLogsByPart = new Map<string, number>();
  const itemCat = new Map(
    equipRows.map((r) => [r.id, bucketCategory(String(r.category))])
  );
  for (const s of equipSess) {
    const part = itemCat.get(s.equipmentItemId) || "other";
    equipLogsByPart.set(part, (equipLogsByPart.get(part) || 0) + 1);
  }

  // ── 1. Equipment engagement ────────────────────────────────────────
  const sailorsWithGear = new Set(equipRows.map((r) => r.sailorId));
  const claimedIds = new Set(claimedSailorRows.map((s) => s.id));
  const claimedWithGear = [...sailorsWithGear].filter((id) =>
    claimedIds.has(id)
  ).length;
  const totalItems = equipRows.length;
  const avgItemsPerSailorWithGear =
    sailorsWithGear.size > 0
      ? Math.round((totalItems / sailorsWithGear.size) * 10) / 10
      : null;
  const avgItemsPerClaimed =
    claimedIds.size > 0
      ? Math.round(
          (equipRows.filter((r) => claimedIds.has(r.sailorId)).length /
            claimedIds.size) *
            10
        ) / 10
      : null;

  let primaryCount = 0;
  let backupCount = 0;
  let alertsTriggered = 0;
  const alertByBadge = new Map<string, number>();
  for (const r of equipRows) {
    if (r.isPrimary) primaryCount += 1;
    if (r.status === "backup" || (!r.isPrimary && r.status === "active"))
      backupCount += 1;
    const b = evaluateEquipmentBadge({
      status: String(r.status),
      condition: String(r.condition),
      useCount: Number(r.useCount || 0),
      acquiredOn: r.acquiredOn ? String(r.acquiredOn).slice(0, 10) : null,
    });
    if (b.needsAttention) {
      alertsTriggered += 1;
      alertByBadge.set(b.badge, (alertByBadge.get(b.badge) || 0) + 1);
    }
  }

  const weeksInWindow = Math.max(1, windowDays / 7);
  const sessionsPerWeek =
    Math.round((equipSessionsInWindow / weeksInWindow) * 10) / 10;

  // ── 2. Claim funnel by source ──────────────────────────────────────
  // Session-level source/device from first event meta; claims = claim_submit
  type SessMeta = {
    source: string;
    device: string;
    claim: boolean;
    firstProfileAt: number | null;
    claimAt: number | null;
  };
  const sessMap = new Map<string, SessMeta>();
  let unknownSourceClaims = 0;

  for (const r of usageRows) {
    const sid = r.sessionId || "";
    const meta = parseMeta(r.meta);
    const source = String(meta.source || "unknown").slice(0, 40) || "unknown";
    const device = String(meta.device || "unknown").slice(0, 16) || "unknown";
    if (sid) {
      let s = sessMap.get(sid);
      if (!s) {
        s = {
          source: source !== "unknown" ? source : "unknown",
          device: device !== "unknown" ? device : "unknown",
          claim: false,
          firstProfileAt: null,
          claimAt: null,
        };
        sessMap.set(sid, s);
      }
      if (s.source === "unknown" && source !== "unknown") s.source = source;
      if (s.device === "unknown" && device !== "unknown") s.device = device;
      const t = r.createdAt ? new Date(r.createdAt).getTime() : null;
      if (r.eventType === "profile_view" && t != null) {
        if (s.firstProfileAt == null || t < s.firstProfileAt)
          s.firstProfileAt = t;
      }
      if (r.eventType === "claim_submit") {
        s.claim = true;
        if (t != null) s.claimAt = t;
        if (s.source === "unknown") unknownSourceClaims += 1;
      }
    } else if (r.eventType === "claim_submit") {
      unknownSourceClaims += 1;
    }
  }

  const bySource = new Map<string, { sessions: number; claims: number }>();
  const byDevice = new Map<string, { sessions: number; claims: number }>();
  const claimDeltas: number[] = [];

  for (const s of sessMap.values()) {
    const src = s.source || "unknown";
    const dev = s.device || "unknown";
    const srcB = bySource.get(src) || { sessions: 0, claims: 0 };
    srcB.sessions += 1;
    if (s.claim) srcB.claims += 1;
    bySource.set(src, srcB);
    const devB = byDevice.get(dev) || { sessions: 0, claims: 0 };
    devB.sessions += 1;
    if (s.claim) devB.claims += 1;
    byDevice.set(dev, devB);
    if (
      s.claim &&
      s.firstProfileAt != null &&
      s.claimAt != null &&
      s.claimAt >= s.firstProfileAt
    ) {
      claimDeltas.push((s.claimAt - s.firstProfileAt) / 3600000);
    }
  }

  claimDeltas.sort((a, b) => a - b);
  const avgHoursProfileToClaim =
    claimDeltas.length > 0
      ? Math.round(
          (claimDeltas.reduce((a, b) => a + b, 0) / claimDeltas.length) * 10
        ) / 10
      : null;
  const medianHoursProfileToClaim =
    claimDeltas.length > 0
      ? Math.round(claimDeltas[Math.floor(claimDeltas.length / 2)] * 10) / 10
      : null;

  // ── 3. Feature adoption (claimed) ──────────────────────────────────
  const equipBySailor = new Set(equipRows.map((r) => r.sailorId));
  // Distinct note authors — keep small; optional tables
  const notesSailors = new Set<string>();
  try {
    const [pn, obs] = await Promise.all([
      db
        .selectDistinct({ sailorId: parentNotes.sailorId })
        .from(parentNotes)
        .limit(3000)
        .catch(() => [] as { sailorId: string }[]),
      db
        .selectDistinct({ sailorId: raceObservations.sailorId })
        .from(raceObservations)
        .limit(5000)
        .catch(() => [] as { sailorId: string }[]),
    ]);
    for (const p of pn) notesSailors.add(p.sailorId);
    for (const o of obs) notesSailors.add(o.sailorId);
  } catch {
    /* optional */
  }

  // Dual-class from results
  const optimistSailors = new Set<string>();
  const ilcaSailors = new Set<string>();
  for (const r of resultClassRows) {
    const g = profileBoatClassGroup(r.boatClass);
    if (g === "ilca4") ilcaSailors.add(r.sailorId);
    else if (g === "optimist") optimistSailors.add(r.sailorId);
  }

  let withMilestones = 0;
  let withEquipment = 0;
  let withNotes = 0;
  let withPrivacy = 0;
  let withDual = 0;
  for (const s of claimedSailorRows) {
    if (s.hasJourney) withMilestones += 1;
    if (equipBySailor.has(s.id)) withEquipment += 1;
    if (notesSailors.has(s.id)) withNotes += 1;
    if (s.isPublicWeight || s.isPublicDob || s.isPublicEquipment)
      withPrivacy += 1;
    const dual =
      Boolean(s.sailNumberIlca4) ||
      Boolean(s.ilca4NationalList) ||
      Boolean(s.hullBrandIlca4) ||
      (optimistSailors.has(s.id) && ilcaSailors.has(s.id));
    if (dual) withDual += 1;
  }
  const nClaimed = claimedSailorRows.length;

  // ── 4. Retention ───────────────────────────────────────────────────
  // Visitor first week → return at +1 / +4 / +12 weeks
  const visitorWeeks = new Map<string, Set<string>>();
  for (const r of usageRows) {
    const meta = parseMeta(r.meta);
    const vid =
      meta.vid != null && String(meta.vid).trim()
        ? String(meta.vid).trim().slice(0, 64)
        : "";
    if (!vid || !r.createdAt) continue;
    const wk = isoWeekKey(new Date(r.createdAt));
    if (!visitorWeeks.has(vid)) visitorWeeks.set(vid, new Set());
    visitorWeeks.get(vid)!.add(wk);
  }
  const cohortMap = new Map<
    string,
    { size: number; w1: number; w4: number; w12: number }
  >();
  for (const weeks of visitorWeeks.values()) {
    const sorted = [...weeks].sort();
    if (!sorted.length) continue;
    const first = sorted[0];
    const c = cohortMap.get(first) || { size: 0, w1: 0, w4: 0, w12: 0 };
    c.size += 1;
    for (const w of sorted) {
      const delta = weeksBetweenKeys(first, w);
      if (delta === 1) c.w1 += 1;
      if (delta === 4) c.w4 += 1;
      if (delta === 12) c.w12 += 1;
    }
    cohortMap.set(first, c);
  }
  const visitorCohorts = [...cohortMap.entries()]
    .map(([cohortWeek, c]) => ({
      cohortWeek,
      size: c.size,
      week1Pct: pct(c.w1, c.size),
      week4Pct: pct(c.w4, c.size),
      week12Pct: pct(c.w12, c.size),
    }))
    .sort((a, b) => b.cohortWeek.localeCompare(a.cohortWeek))
    .slice(0, 16);

  // Claimed re-engagement via sailor.updatedAt
  const now = Date.now();
  let sumDays = 0;
  let active7 = 0;
  let active30 = 0;
  let inactive30 = 0;
  const byRel = new Map<string, { count: number; sumDays: number }>();
  for (const s of claimedSailorRows) {
    const u = s.updatedAt ? new Date(s.updatedAt).getTime() : null;
    const daysSince =
      u != null && Number.isFinite(u)
        ? Math.max(0, Math.round((now - u) / 86400000))
        : null;
    if (daysSince != null) {
      sumDays += daysSince;
      if (daysSince <= 7) active7 += 1;
      else if (daysSince <= 30) active30 += 1;
      else inactive30 += 1;
    } else {
      inactive30 += 1;
    }
    const rel = String(s.ownerRelation || "unknown");
    const br = byRel.get(rel) || { count: 0, sumDays: 0 };
    br.count += 1;
    if (daysSince != null) br.sumDays += daysSince;
    byRel.set(rel, br);
  }

  // ── 5. Revenue & support ───────────────────────────────────────────
  let waitlistSubmits = 0;
  let foundingWaitlist = 0;
  for (const r of usageRows) {
    if (r.eventType === "waitlist_submit") {
      waitlistSubmits += 1;
      const meta = parseMeta(r.meta);
      const role = String(meta.role || meta.waitlistRole || "").toLowerCase();
      if (role.includes("found") || role.includes("supporter"))
        foundingWaitlist += 1;
    }
  }
  let supportNew = 0;
  let supportRead = 0;
  let supportResolved = 0;
  let supportInWindow = 0;
  const resHours: number[] = [];
  for (const s of supportRows) {
    const st = String(s.status);
    if (st === "new") supportNew += 1;
    else if (st === "read") supportRead += 1;
    else if (st === "resolved") supportResolved += 1;
    if (s.createdAt && new Date(s.createdAt) >= since) supportInWindow += 1;
    if (st === "resolved" && s.createdAt && s.updatedAt) {
      const h =
        (new Date(s.updatedAt).getTime() - new Date(s.createdAt).getTime()) /
        3600000;
      if (Number.isFinite(h) && h >= 0 && h < 24 * 365) resHours.push(h);
    }
  }
  const rejectReasons = new Map<string, number>();
  for (const c of claimRows) {
    if (c.status !== "rejected") continue;
    const reason = classifyRejectionReason(c.note);
    rejectReasons.set(reason, (rejectReasons.get(reason) || 0) + 1);
  }

  // ── 6. Ranking health (uses fleetSailors + regattaRows from batch) ─
  let silverActive = 0;
  let silverWith3 = 0;
  let ilcaListed = 0;
  let ilcaWith3 = 0;
  try {
    const period = currentPeriodFromSgToday();
    const mapped = fleetSailors.map((row) => {
      const n = normalizeSgSeriesMembership(row.currentFleet);
      return { ...row, currentFleet: n || row.currentFleet };
    });

    const silverIdSet = new Set<string>();
    for (const s of mapped) {
      const r = resolveSailorFleet(s as SailorRecord, period);
      if (r?.active && r.fleet === "Silver") silverIdSet.add(s.id);
    }
    silverActive = silverIdSet.size;

    const rMapped: RegattaRecord[] = regattaRows.map((row) => ({
      id: row.id,
      name: row.name,
      slug: row.slug,
      date: row.date,
      totalFleetSize: row.totalFleetSize,
      division: row.division ?? undefined,
      raceCount: row.raceCount,
      geography: row.geography ?? "SG",
      boatClass: row.boatClass ?? "Optimist",
      countsForRanking: row.countsForRanking !== false,
    }));

    const silverSlots = scoringRegattasForFleet("Silver", period, rMapped);
    const silverScoring = new Set(silverSlots.map((x) => x.regatta.id));
    if (silverScoring.size && silverIdSet.size) {
      const bySailor = new Map<string, Set<string>>();
      for (const row of resultClassRows) {
        if (!silverScoring.has(row.regattaId)) continue;
        if (!silverIdSet.has(row.sailorId)) continue;
        if (!bySailor.has(row.sailorId)) bySailor.set(row.sailorId, new Set());
        bySailor.get(row.sailorId)!.add(row.regattaId);
      }
      for (const id of silverIdSet) {
        if ((bySailor.get(id)?.size || 0) >= 3) silverWith3 += 1;
      }
    }

    const ilcaListedIds = mapped
      .filter((s) => Boolean(s.ilca4NationalList))
      .map((s) => s.id);
    const ilcaListedSet = new Set(ilcaListedIds);
    ilcaListed = ilcaListedIds.length;
    if (ilcaListedSet.size) {
      const bySailor = new Map<string, number>();
      for (const row of resultClassRows) {
        if (profileBoatClassGroup(row.boatClass) !== "ilca4") continue;
        if (!ilcaListedSet.has(row.sailorId)) continue;
        bySailor.set(row.sailorId, (bySailor.get(row.sailorId) || 0) + 1);
      }
      for (const id of ilcaListedIds) {
        if ((bySailor.get(id) || 0) >= 3) ilcaWith3 += 1;
      }
    }
  } catch (e) {
    console.warn("extended ranking health", e);
  }

  // Top regattas participation + DNS (recent ranking events)
  const regattaAgg = new Map<
    string,
    {
      name: string;
      date: string;
      fleetSize: number;
      participants: Set<string>;
      dns: number;
      total: number;
    }
  >();
  for (const r of resultClassRows) {
    if (r.countsForRanking === false) continue;
    const d = String(r.regattaDate || "").slice(0, 10);
    // focus recent ~1 year for table size
    if (d && d < String(new Date(Date.now() - 400 * 86400000).toISOString()).slice(0, 10))
      continue;
    let a = regattaAgg.get(r.regattaId);
    if (!a) {
      a = {
        name: String(r.regattaName || "Regatta"),
        date: d,
        fleetSize: Number(r.totalFleetSize || 0),
        participants: new Set(),
        dns: 0,
        total: 0,
      };
      regattaAgg.set(r.regattaId, a);
    }
    a.participants.add(r.sailorId);
    a.total += 1;
    if (r.isDns) a.dns += 1;
  }
  const topRegattas = [...regattaAgg.entries()]
    .map(([regattaId, a]) => {
      const participants = a.participants.size;
      const fleetSize = a.fleetSize || participants;
      return {
        regattaId,
        name: a.name,
        date: a.date,
        fleetSize,
        participants,
        participationPct: pct(participants, fleetSize),
        dnsCount: a.dns,
        dnsRatePct: pct(a.dns, a.total),
      };
    })
    .sort((a, b) => b.date.localeCompare(a.date))
    .slice(0, 12);

  // ── 7. ILCA transition ─────────────────────────────────────────────
  const both = [...optimistSailors].filter((id) => ilcaSailors.has(id));
  const ilcaOnly = [...ilcaSailors].filter((id) => !optimistSailors.has(id));
  const optiOnly = [...optimistSailors].filter((id) => !ilcaSailors.has(id));

  // First dates per sailor per class
  const firstOpti = new Map<string, string>();
  const firstIlca = new Map<string, string>();
  for (const r of resultClassRows) {
    const d = String(r.regattaDate || "").slice(0, 10);
    if (!/^\d{4}-\d{2}-\d{2}$/.test(d)) continue;
    const g = profileBoatClassGroup(r.boatClass);
    if (g === "ilca4") {
      const cur = firstIlca.get(r.sailorId);
      if (!cur || d < cur) firstIlca.set(r.sailorId, d);
    } else if (g === "optimist") {
      const cur = firstOpti.get(r.sailorId);
      if (!cur || d < cur) firstOpti.set(r.sailorId, d);
    }
  }

  // DOB from fleet batch (no extra round-trips)
  const dobById = new Map<string, string | null>();
  for (const s of fleetSailors) dobById.set(s.id, s.dob ?? null);

  const ages: number[] = [];
  const months: number[] = [];
  for (const [sid, ilcaDate] of firstIlca) {
    const dob = dobById.get(sid);
    const by = birthYear(dob);
    if (by != null) {
      const y = Number(ilcaDate.slice(0, 4));
      const age = y - by;
      if (age >= 8 && age <= 20) ages.push(age);
    }
    const od = firstOpti.get(sid);
    if (od && od < ilcaDate) {
      const a = new Date(`${od}T00:00:00Z`).getTime();
      const b = new Date(`${ilcaDate}T00:00:00Z`).getTime();
      const m = Math.round((b - a) / (30.44 * 86400000));
      if (m >= 0 && m < 200) months.push(m);
    }
  }

  // Gold never ILCA — from fleet batch
  let goldNeverIlca = 0;
  let goldNeverIlcaDropped = 0;
  for (const s of fleetSailors) {
    if (!s.goldEntryDate) continue;
    if (ilcaSailors.has(s.id)) continue;
    goldNeverIlca += 1;
    const drop = toYmd(s.dropDate);
    if (drop && drop <= today) goldNeverIlcaDropped += 1;
  }

  return {
    equipment: {
      sailorsWithEquipment: sailorsWithGear.size,
      claimedSailors: nClaimed,
      adoptionPct: pct(claimedWithGear, nClaimed),
      totalItems,
      avgItemsPerSailorWithGear,
      avgItemsPerClaimedSailor: avgItemsPerClaimed,
      sessionsInWindow: equipSessionsInWindow,
      sessionsPerWeek,
      logsByPart: [...equipLogsByPart.entries()]
        .map(([part, count]) => ({ part, count }))
        .sort((a, b) => b.count - a.count),
      primaryCount,
      backupCount,
      primaryBackupRatio:
        backupCount > 0
          ? Math.round((primaryCount / backupCount) * 100) / 100
          : primaryCount > 0
            ? primaryCount
            : null,
      alertsTriggered,
      alertByBadge: [...alertByBadge.entries()]
        .map(([badge, count]) => ({ badge, count }))
        .sort((a, b) => b.count - a.count),
    },
    claimBySource: {
      bySource: [...bySource.entries()]
        .map(([source, v]) => ({
          source,
          claims: v.claims,
          sessions: v.sessions,
          claimRatePct: pct(v.claims, v.sessions),
        }))
        .sort((a, b) => b.claims - a.claims || b.sessions - a.sessions)
        .slice(0, 12),
      byDevice: [...byDevice.entries()]
        .map(([device, v]) => ({
          device,
          claims: v.claims,
          sessions: v.sessions,
          claimRatePct: pct(v.claims, v.sessions),
        }))
        .sort((a, b) => b.sessions - a.sessions),
      avgHoursProfileToClaim,
      medianHoursProfileToClaim,
      samplesWithTiming: claimDeltas.length,
      unknownSourceClaims,
    },
    featureAdoption: {
      claimedSailors: nClaimed,
      withMilestones,
      withMilestonesPct: pct(withMilestones, nClaimed),
      withEquipment,
      withEquipmentPct: pct(withEquipment, nClaimed),
      withNotes,
      withNotesPct: pct(withNotes, nClaimed),
      withPrivacyChanged: withPrivacy,
      withPrivacyChangedPct: pct(withPrivacy, nClaimed),
      withDualClass: withDual,
      withDualClassPct: pct(withDual, nClaimed),
    },
    retention: {
      visitorCohorts,
      claimedReengagement: {
        avgDaysSinceUpdate:
          nClaimed > 0 ? Math.round((sumDays / nClaimed) * 10) / 10 : null,
        activeLast7d: active7,
        activeLast30d: active30,
        inactive30dPlus: inactive30,
        byRelation: [...byRel.entries()].map(([relation, v]) => ({
          relation,
          count: v.count,
          avgDays:
            v.count > 0 ? Math.round((v.sumDays / v.count) * 10) / 10 : null,
        })),
      },
    },
    revenueSupport: {
      waitlistSubmits,
      foundingWaitlist,
      supportNew,
      supportRead,
      supportResolved,
      supportInWindow,
      avgResolutionHours:
        resHours.length > 0
          ? Math.round(
              (resHours.reduce((a, b) => a + b, 0) / resHours.length) * 10
            ) / 10
          : null,
      claimRejectionReasons: [...rejectReasons.entries()]
        .map(([reason, count]) => ({ reason, count }))
        .sort((a, b) => b.count - a.count),
      paymentInstrumented: false,
      note: "Stripe / payment funnel not instrumented yet — waitlist + support only.",
    },
    rankingHealth: {
      silverCoveragePct: pct(silverWith3, silverActive),
      silverWith3Plus: silverWith3,
      silverActive,
      ilcaCoveragePct: pct(ilcaWith3, ilcaListed),
      ilcaWith3Plus: ilcaWith3,
      ilcaListed,
      topRegattas,
    },
    ilcaTransition: {
      sailorsWithBothClasses: both.length,
      sailorsWithIlcaOnly: ilcaOnly.length,
      sailorsWithOptimistOnly: optiOnly.length,
      avgAgeAtFirstIlca:
        ages.length > 0
          ? Math.round((ages.reduce((a, b) => a + b, 0) / ages.length) * 10) /
            10
          : null,
      avgMonthsOptiBeforeIlca:
        months.length > 0
          ? Math.round(
              (months.reduce((a, b) => a + b, 0) / months.length) * 10
            ) / 10
          : null,
      samplesAge: ages.length,
      samplesMonths: months.length,
      goldNeverIlca,
      goldNeverIlcaDropped,
    },
  };
}
