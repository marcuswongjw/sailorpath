/**
 * Extended admin dashboard metrics still shown in Stats UI:
 * equipment engagement, ranking health, ILCA transition.
 */

import { eq, gte, isNotNull } from "drizzle-orm";
import { db } from "@/db";
import {
  equipmentItems,
  equipmentUsages,
  regattaResults,
  regattas,
  sailors,
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

function pct(n: number, d: number): number | null {
  if (!d) return null;
  return Math.round((n / d) * 1000) / 10;
}

function bucketCategory(cat: string): string {
  const c = String(cat || "").toLowerCase();
  if (c === "hull") return "hull";
  if (c === "sail") return "sail";
  if (c === "mast" || c === "boom" || c === "sprit") return "mast_set";
  if (c === "daggerboard" || c === "rudder") return "foil_set";
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
  const resultsCutoff = new Date();
  resultsCutoff.setFullYear(resultsCutoff.getFullYear() - 4);
  const resultsCutoffYmd = resultsCutoff.toISOString().slice(0, 10);

  const [equipRows, equipSess, fleetSailors, regattaRows, resultClassRows, claimedCountRow] =
    await Promise.all([
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
          parentId: sailors.parentId,
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
        .select({ id: sailors.id })
        .from(sailors)
        .where(isNotNull(sailors.parentId))
        .catch(() => [] as { id: string }[]),
    ]);

  // ── Equipment ────────────────────────────────────────────────────
  const equipSessionsInWindow = equipSess.length;
  const equipLogsByPart = new Map<string, number>();
  const itemCat = new Map(
    equipRows.map((r) => [r.id, bucketCategory(String(r.category))])
  );
  for (const s of equipSess) {
    const part = itemCat.get(s.equipmentItemId) || "other";
    equipLogsByPart.set(part, (equipLogsByPart.get(part) || 0) + 1);
  }

  const sailorsWithGear = new Set(equipRows.map((r) => r.sailorId));
  const claimedIds = new Set(claimedCountRow.map((s) => s.id));
  const nClaimed = claimedIds.size;
  const claimedWithGear = [...sailorsWithGear].filter((id) =>
    claimedIds.has(id)
  ).length;
  const totalItems = equipRows.length;
  const avgItemsPerSailorWithGear =
    sailorsWithGear.size > 0
      ? Math.round((totalItems / sailorsWithGear.size) * 10) / 10
      : null;
  const avgItemsPerClaimed =
    nClaimed > 0
      ? Math.round(
          (equipRows.filter((r) => claimedIds.has(r.sailorId)).length /
            nClaimed) *
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

  // Class sets for ILCA transition
  const optimistSailors = new Set<string>();
  const ilcaSailors = new Set<string>();
  for (const r of resultClassRows) {
    const g = profileBoatClassGroup(r.boatClass);
    if (g === "ilca4") ilcaSailors.add(r.sailorId);
    else if (g === "optimist") optimistSailors.add(r.sailorId);
  }

  // ── Ranking health ───────────────────────────────────────────────
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
  const recentCutoff = String(
    new Date(Date.now() - 400 * 86400000).toISOString()
  ).slice(0, 10);
  for (const r of resultClassRows) {
    if (r.countsForRanking === false) continue;
    const d = String(r.regattaDate || "").slice(0, 10);
    if (d && d < recentCutoff) continue;
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

  // ── ILCA transition ──────────────────────────────────────────────
  const both = [...optimistSailors].filter((id) => ilcaSailors.has(id));
  const ilcaOnly = [...ilcaSailors].filter((id) => !optimistSailors.has(id));
  const optiOnly = [...optimistSailors].filter((id) => !ilcaSailors.has(id));

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
