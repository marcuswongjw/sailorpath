import { unstable_cache } from "next/cache";
import { and, eq, inArray } from "drizzle-orm";
import { db, withDatabaseRetry } from "@/db";
import {
  asianOptimistIndexEvents,
  regattaResults,
  regattas,
  sailors,
} from "@/db/schema";
import { CACHE_TAG_PUBLIC_REGATTAS } from "@/lib/cacheTags";
import {
  isOptimistAgeEligible,
  type AsianOptimistIndexEntry,
} from "@/lib/asianOptimistIndex";
import {
  ASIAN_INDEX_MNA_REGIONS,
  asianIndexPoints,
  type AsianIndexGrade,
} from "@/lib/asianOptimistIndexBeta";
import {
  ASIAN_OPTIMIST_INDEX_2026_QUALIFIERS,
  type AsianOptimistIndexQualifierSource,
} from "@/lib/asianOptimistIndexQualifiers";
import {
  ASIAN_OPTIMIST_INDEX_DISPLAY_COLUMNS,
  ASIAN_OPTIMIST_INDEX_PROVISIONAL_RELEASE,
  createAsianOptimistIndexProvisionalEntries,
  roundScore,
  selectOptimalResults,
  type AsianOptimistIndexProvisionalEntry,
  type AsianOptimistIndexQualifierScore,
  type AsianOptimistIndexQualifierTier,
  type CandidateScoredResult,
} from "@/lib/asianOptimistIndexScoring";
import type { QualifierColumn } from "@/components/AsianOptimistIndexStandings";

const ASIAN_OCEANIA_MNAS = new Set<string>(
  ASIAN_INDEX_MNA_REGIONS.flatMap((r) => r.codes)
);

export type LiveAsianOptimistIndexData = {
  entries: AsianOptimistIndexProvisionalEntry[];
  qualifiers: AsianOptimistIndexQualifierSource[];
  qualifierColumns: QualifierColumn[];
  asOf: string;
  totalFleetSize: number;
};

function normalizeMna(code: string | null | undefined): string {
  return (code ?? "").trim().toUpperCase();
}

function normalizeGender(g: string | null | undefined): "M" | "W" {
  const v = (g ?? "").trim().toUpperCase();
  if (v === "F" || v === "W" || v === "FEMALE" || v === "GIRL" || v === "GIRLS") {
    return "W";
  }
  return "M";
}

function tierForGrade(grade: AsianIndexGrade): AsianOptimistIndexQualifierTier {
  if (grade === 150) return "championship";
  if (grade === 75) return "international";
  return "national";
}

function birthYearFromSailor(
  dob: string | null | undefined,
  resultBirthYear: number | null | undefined
): number | null {
  if (resultBirthYear != null && Number.isFinite(resultBirthYear)) {
    return resultBirthYear;
  }
  if (dob && /^\d{4}/.test(dob)) {
    const yr = Number(dob.slice(0, 4));
    return Number.isFinite(yr) ? yr : null;
  }
  return null;
}

function isWithinRolling12Months(endDateStr: string, refDate: Date): boolean {
  const end = new Date(`${endDateStr}T00:00:00Z`);
  if (Number.isNaN(end.getTime())) return false;
  const cutoff = new Date(refDate);
  cutoff.setUTCFullYear(cutoff.getUTCFullYear() - 1);
  return end >= cutoff;
}

function formatAsOfDate(date: Date): string {
  return new Intl.DateTimeFormat("en-GB", {
    day: "numeric",
    month: "long",
    year: "numeric",
    timeZone: "UTC",
  }).format(date);
}

async function computeLiveAsianOptimistIndexData(): Promise<LiveAsianOptimistIndexData> {
  const now = new Date();
  const rankingYear = now.getUTCFullYear();

  const events = await withDatabaseRetry(() =>
    db
      .select()
      .from(asianOptimistIndexEvents)
      .where(eq(asianOptimistIndexEvents.isEligible, true))
  );

  if (events.length === 0) {
    return {
      entries: createAsianOptimistIndexProvisionalEntries(),
      qualifiers: [...ASIAN_OPTIMIST_INDEX_2026_QUALIFIERS],
      qualifierColumns: [...ASIAN_OPTIMIST_INDEX_DISPLAY_COLUMNS],
      asOf: ASIAN_OPTIMIST_INDEX_PROVISIONAL_RELEASE.asOf,
      totalFleetSize: 170,
    };
  }

  const hasVerifiedNewAnchor = events.some(
    (e) =>
      e.id !== "2025-asian-oceanian" &&
      e.grade === 150 &&
      e.shortName?.includes("Asians") &&
      e.resultStatus === "verified"
  );

  const activeEvents = events.filter((e) => {
    if (e.resultStatus === "scheduled") return true;
    if (e.grade == null) return false;
    if (e.indexRole === "championship_anchor" && !hasVerifiedNewAnchor) return true;
    return isWithinRolling12Months(e.endDate, now);
  });

  const scoredEvents = activeEvents.filter(
    (e) => e.resultStatus === "verified" && e.grade != null && e.regattaSlugs.length > 0
  );

  const allSlugs = [...new Set(scoredEvents.flatMap((e) => e.regattaSlugs))];

  const designatedRegattaRows =
    allSlugs.length > 0
      ? await withDatabaseRetry(() =>
          db
            .select({
              id: regattas.id,
              slug: regattas.slug,
              name: regattas.name,
              totalFleetSize: regattas.totalFleetSize,
              endDate: regattas.endDate,
              date: regattas.date,
            })
            .from(regattas)
            .where(
              and(
                inArray(regattas.slug, allSlugs),
                eq(regattas.status, "published")
              )
            )
        )
      : [];

  // Also fetch Singapore national ranking Optimist regattas (counts_for_ranking = true)
  // within the rolling 12-month window to calibrate Elo Power Rating & 90-day Momentum (K = 16).
  const cutoff12Date = new Date(now);
  cutoff12Date.setUTCFullYear(cutoff12Date.getUTCFullYear() - 1);
  const cutoff12Str = cutoff12Date.toISOString().slice(0, 10);

  const sgpRankingRows = await withDatabaseRetry(() =>
    db
      .select({
        id: regattas.id,
        eventId: regattas.eventId,
        slug: regattas.slug,
        name: regattas.name,
        division: regattas.division,
        totalFleetSize: regattas.totalFleetSize,
        endDate: regattas.endDate,
        date: regattas.date,
      })
      .from(regattas)
      .where(
        and(
          eq(regattas.boatClass, "Optimist"),
          eq(regattas.countsForRanking, true),
          eq(regattas.status, "published")
        )
      )
  );

  const designatedSlugSet = new Set(allSlugs);
  const extraSgpRegattas = sgpRankingRows.filter(
    (r) => !designatedSlugSet.has(r.slug) && (r.endDate ?? r.date) >= cutoff12Str
  );

  const regattaRows = [
    ...designatedRegattaRows.map((r) => ({ ...r, eventId: null as string | null, division: null as string | null })),
    ...extraSgpRegattas,
  ];
  const regattaBySlug = new Map(regattaRows.map((r) => [r.slug, r]));
  const regattaIds = regattaRows.map((r) => r.id);

  const resultRows =
    regattaIds.length > 0
      ? await withDatabaseRetry(() =>
          db
            .select({
              regattaId: regattaResults.regattaId,
              sailorId: regattaResults.sailorId,
              rank: regattaResults.rank,
              entrySailNumber: regattaResults.entrySailNumber,
              entryLabel: regattaResults.entryLabel,
              resultNationality: regattaResults.nationality,
              resultGender: regattaResults.gender,
              resultBirthYear: regattaResults.birthYear,
              totalScore: regattaResults.totalScore,
              nettScore: regattaResults.nettScore,
              sailorName: sailors.name,
              sailorHandle: sailors.handle,
              sailorNationality: sailors.nationality,
              sailorGender: sailors.gender,
              sailorDob: sailors.dob,
              sailorSailNumber: sailors.sailNumber,
            })
            .from(regattaResults)
            .innerJoin(sailors, eq(sailors.id, regattaResults.sailorId))
            .where(inArray(regattaResults.regattaId, regattaIds))
        )
      : [];

  const resultsByRegattaId = new Map<string, typeof resultRows>();
  for (const row of resultRows) {
    const list = resultsByRegattaId.get(row.regattaId);
    if (list) list.push(row);
    else resultsByRegattaId.set(row.regattaId, [row]);
  }

  type SailorAccumulator = {
    sailorId: string;
    name: string;
    handle: string | null;
    nationality: string;
    gender: "M" | "W";
    birthYear: number | null;
    sailNumber: string;
    anchorPlace: number | null;
    anchorTotalPoints: number | null;
    anchorNetPoints: number | null;
    candidates: CandidateScoredResult[];
  };

  const sailorMap = new Map<string, SailorAccumulator>();
  const activeColumns: QualifierColumn[] = [];
  let latestEventDate = "";
  let anchorFleetSize = 170;

  const sortedScoredEvents = [...scoredEvents].sort(
    (a, b) =>
      (b.grade ?? 0) - (a.grade ?? 0) ||
      a.startDate.localeCompare(b.startDate)
  );

  // Chronological Elo Power Rating + 90-day Momentum pass across all designated events
  // plus Singapore ranking regattas (pairing Gold + Silver into one field so Silver sailors
  // are ranked below Gold rather than in an isolated Silver Elo bubble).
  type EloEvent = {
    id: string;
    startDate: string;
    endDate: string;
    kFactor: number;
    regattaSlugs: string[];
  };

  // Group Singapore ranking regattas (Gold + Silver) by eventId (or rsyc-2026)
  const sgpByGroup = new Map<string, typeof sgpRankingRows>();
  for (const r of sgpRankingRows) {
    if ((r.endDate ?? r.date) < cutoff12Str) continue;
    const gKey = r.slug.startsWith("rsyc-2026-") ? "rsyc-2026" : (r.eventId ?? r.slug);
    const list = sgpByGroup.get(gKey);
    if (list) list.push(r);
    else sgpByGroup.set(gKey, [r]);
  }

  const sgpEloEvents: EloEvent[] = [];
  const syscSnscHandled = new Set<string>();
  for (const [gKey, grp] of sgpByGroup.entries()) {
    // Order Gold before Silver
    const ordered = [...grp].sort((a, b) => {
      const aSil = /silver/i.test(a.slug) || /silver/i.test(a.division ?? "") ? 1 : 0;
      const bSil = /silver/i.test(b.slug) || /silver/i.test(b.division ?? "") ? 1 : 0;
      return aSil - bSil || a.date.localeCompare(b.date);
    });
    const slugs = ordered.map((r) => r.slug);
    const hasSysc = slugs.includes("sysc-2026-gold");
    const hasSnsc = slugs.includes("singapore-national-sailing-championships-2026-gold");
    if (hasSysc) syscSnscHandled.add("sysc-2026-gold");
    if (hasSnsc) syscSnscHandled.add("snsc-gold-sep-26-2026-09-11");
    const kFactor = hasSysc ? 32 : hasSnsc ? 24 : 16;
    const maxEnd = ordered.reduce((m, r) => ((r.endDate ?? r.date) > m ? (r.endDate ?? r.date) : m), "");
    const minStart = ordered.reduce((m, r) => (r.date < m ? r.date : m), ordered[0].date);
    sgpEloEvents.push({
      id: `sgp-grp:${gKey}`,
      startDate: minStart,
      endDate: maxEnd,
      kFactor,
      regattaSlugs: slugs,
    });
  }

  const chronoEvents: EloEvent[] = [
    ...scoredEvents
      .filter((e) => !syscSnscHandled.has(e.id))
      .map((e) => {
        const g = (e.grade ?? 75) as AsianIndexGrade;
        return {
          id: e.id,
          startDate: e.startDate,
          endDate: e.endDate,
          kFactor: g === 200 ? 48 : g === 150 ? 40 : g === 75 ? 32 : 24,
          regattaSlugs: e.regattaSlugs,
        };
      }),
    ...sgpEloEvents,
  ].sort(
    (a, b) => a.endDate.localeCompare(b.endDate) || a.startDate.localeCompare(b.startDate) || a.id.localeCompare(b.id)
  );
  const cutoff90Days = new Date(now);
  cutoff90Days.setUTCDate(cutoff90Days.getUTCDate() - 90);
  const cutoff90Str = cutoff90Days.toISOString().slice(0, 10);

  const eloRatings = new Map<string, number>();
  const eloBefore90 = new Map<string, number>();

  for (const ev of chronoEvents) {
    const linkedRegattas = ev.regattaSlugs
      .map((slug) => regattaBySlug.get(slug))
      .filter((r): r is NonNullable<typeof r> => Boolean(r));
    if (linkedRegattas.length === 0) continue;

    const kFactor = ev.kFactor;

    // Combine split fleets of the same event (e.g. Gold + Silver) into one field,
    // offsetting Silver ranks if the source sheet restarted numbering at 1.
    const participants: { sailorId: string; rank: number }[] = [];
    const seenInEvent = new Set<string>();
    let eloFleetOffset = 0;
    for (const reg of linkedRegattas) {
      const regRows = resultsByRegattaId.get(reg.id) ?? [];
      const minRank = regRows.reduce(
        (m, r) => (r.rank != null && r.rank >= 1 && r.rank < m ? r.rank : m),
        Infinity
      );
      const needsOffset = eloFleetOffset > 0 && minRank <= eloFleetOffset;
      for (const row of regRows) {
        if (row.rank == null || row.rank < 1 || seenInEvent.has(row.sailorId)) continue;
        seenInEvent.add(row.sailorId);
        participants.push({
          sailorId: row.sailorId,
          rank: needsOffset ? eloFleetOffset + row.rank : row.rank,
        });
      }
      eloFleetOffset += Math.max(reg.totalFleetSize ?? 0, regRows.length);
    }
    const n = participants.length;
    if (n < 2) continue;

    // Snapshot ratings before this event
    const snap = new Map<string, number>();
    for (const p of participants) {
      const cur = eloRatings.get(p.sailorId) ?? 1500;
      snap.set(p.sailorId, cur);
      if (ev.endDate >= cutoff90Str && !eloBefore90.has(p.sailorId)) {
        eloBefore90.set(p.sailorId, cur);
      }
    }

    for (let i = 0; i < n; i++) {
      const pi = participants[i];
      const ri = snap.get(pi.sailorId)!;
      let deltaSum = 0;
      for (let j = 0; j < n; j++) {
        if (i === j) continue;
        const pj = participants[j];
        const rj = snap.get(pj.sailorId)!;
        const expected = 1 / (1 + Math.pow(10, (rj - ri) / 400));
        const actual = pi.rank < pj.rank ? 1 : pi.rank === pj.rank ? 0.5 : 0;
        deltaSum += actual - expected;
      }
      const nextRating = ri + kFactor * (deltaSum / (n - 1));
      eloRatings.set(pi.sailorId, nextRating);
      if (ev.endDate < cutoff90Str) {
        eloBefore90.set(pi.sailorId, nextRating);
      }
    }
  }

  for (const ev of sortedScoredEvents) {
    const linkedRegattas = ev.regattaSlugs
      .map((slug) => regattaBySlug.get(slug))
      .filter((r): r is NonNullable<typeof r> => Boolean(r));

    if (linkedRegattas.length === 0) continue;

    if (ev.endDate > latestEventDate) latestEventDate = ev.endDate;

    const grade = ev.grade as AsianIndexGrade;
    const hostMna = normalizeMna(ev.hostNoc) || "UNK";
    const year = Number(ev.endDate.slice(0, 4)) || rankingYear;
    const shortName = ev.shortName ?? ev.name;

    const eventStarters = Math.max(
      ev.fleetSize ?? 0,
      linkedRegattas.reduce((sum, r) => sum + (r.totalFleetSize ?? 0), 0)
    );
    if (eventStarters < 1) continue;

    if (ev.indexRole === "championship_anchor") {
      anchorFleetSize = eventStarters;
    } else {
      activeColumns.push({
        id: ev.id,
        shortName,
        grade,
        regattaSlug: ev.regattaSlugs[0] ?? ev.sailorpathRegattaSlug ?? null,
      });
    }

    let fleetOffset = 0;
    for (const reg of linkedRegattas) {
      const regResults = resultsByRegattaId.get(reg.id) ?? [];
      const starters = Math.max(eventStarters, regResults.length);
      if (starters < 1) continue;

      const minRank = regResults.reduce(
        (m, r) => (r.rank != null && r.rank >= 1 && r.rank < m ? r.rank : m),
        Infinity
      );
      const needsOffset = fleetOffset > 0 && minRank <= fleetOffset;

      for (const row of regResults) {
        if (row.rank == null || row.rank < 1) continue;
        const effectiveRank = needsOffset ? fleetOffset + row.rank : row.rank;
        if (effectiveRank > starters) continue;
        const mna = normalizeMna(row.resultNationality ?? row.sailorNationality);
        if (!ASIAN_OCEANIA_MNAS.has(mna)) continue;

        const birthYear = birthYearFromSailor(row.sailorDob, row.resultBirthYear);
        if (!isOptimistAgeEligible(birthYear, rankingYear)) continue;

        const points = asianIndexPoints(grade, starters, effectiveRank);
        const gender = normalizeGender(row.resultGender ?? row.sailorGender);
        const sailNumber =
          (row.entrySailNumber ?? row.sailorSailNumber ?? "").trim() || mna;

        let acc = sailorMap.get(row.sailorId);
        if (!acc) {
          acc = {
            sailorId: row.sailorId,
            name: row.sailorName,
            handle: row.sailorHandle,
            nationality: mna,
            gender,
            birthYear,
            sailNumber,
            anchorPlace: null,
            anchorTotalPoints: null,
            anchorNetPoints: null,
            candidates: [],
          };
          sailorMap.set(row.sailorId, acc);
        }

        if (ev.indexRole === "championship_anchor") {
          acc.anchorPlace = effectiveRank;
          acc.anchorTotalPoints = row.totalScore;
          acc.anchorNetPoints = row.nettScore;
        }

        const qualifierScore: AsianOptimistIndexQualifierScore | undefined =
          ev.indexRole === "championship_anchor"
            ? undefined
            : {
                qualifier: {
                  id: ev.id,
                  shortName,
                  hostCountry: ev.hostCountry,
                  hostMna,
                  fleetSize: starters,
                  grade,
                  year,
                  tier: tierForGrade(grade),
                  isWorlds: ev.isWorlds,
                  scoreCap: grade,
                },
                rank: effectiveRank,
                points,
                rawScore: points,
                cappedScore: points,
                counted: false,
                pointsContribution: 0,
              };

        acc.candidates.push({
          id: ev.id,
          name: acc.name,
          shortName,
          grade,
          starters,
          rank: effectiveRank,
          points,
          hostMna,
          hostCountry: ev.hostCountry,
          year,
          isWorlds: ev.isWorlds,
          qualifierScore,
        });
      }
      fleetOffset += Math.max(reg.totalFleetSize ?? 0, regResults.length);
    }
  }

  const scoredEntries = [...sailorMap.values()].map((acc) => {
    const optimalSubset = selectOptimalResults(acc.candidates);
    const optimalIds = new Set(optimalSubset.map((r) => r.id));

    const qualifierResults: AsianOptimistIndexQualifierScore[] = acc.candidates
      .map((c) => c.qualifierScore)
      .filter((q): q is AsianOptimistIndexQualifierScore => Boolean(q))
      .map((q) => {
        const isCounted = optimalIds.has(q.qualifier.id);
        return {
          ...q,
          counted: isCounted,
          pointsContribution: isCounted ? q.points : 0,
          dropReason: isCounted
            ? undefined
            : "Dropped by V1 (Beta) selection limits (host cap or 5-result cap)",
        };
      })
      .sort((a, b) => a.qualifier.id.localeCompare(b.qualifier.id) || a.rank - b.rank);

    const championshipPoints = optimalSubset
      .filter((r) => r.grade === 200 || r.grade === 150)
      .reduce((sum, r) => sum + r.points, 0);
    const qualifierPoints = optimalSubset
      .filter((r) => r.grade !== 200 && r.grade !== 150)
      .reduce((sum, r) => sum + r.points, 0);
    const preciseScore = optimalSubset.reduce((sum, r) => sum + r.points, 0);
    const hostCountryCount = new Set(optimalSubset.map((r) => r.hostCountry)).size;

    const baseEntry: AsianOptimistIndexEntry = {
      overallPlace: acc.anchorPlace,
      sailNumber: acc.sailNumber,
      name: acc.name,
      sourceName: acc.name,
      nationality: acc.nationality,
      country: acc.nationality,
      gender: acc.gender,
      totalPoints: acc.anchorTotalPoints,
      netPoints: acc.anchorNetPoints,
      identityKey: acc.sailorId,
      baselineRank: acc.anchorPlace ?? 999,
      displayName: acc.name,
      birthYear: acc.birthYear,
      profileHref: acc.handle ? `/${acc.handle}` : null,
      profileReview: null,
    };

    const powerRating = Math.round(eloRatings.get(acc.sailorId) ?? 1500);
    const prevElo = eloBefore90.get(acc.sailorId);
    const momentumDelta = prevElo != null ? Math.round((eloRatings.get(acc.sailorId) ?? 1500) - prevElo) : 0;

    return {
      ...baseEntry,
      provisionalRank: 0,
      provisionalScore: roundScore(preciseScore),
      championshipScore: roundScore(championshipPoints),
      championshipPoints: roundScore(championshipPoints),
      qualifierPoints: roundScore(qualifierPoints),
      eligibleStarts: acc.candidates.length,
      countedResultsCount: optimalSubset.length,
      hostCountryCount,
      qualifierResults,
      scoredQualifiers: qualifierResults.filter((q) => q.counted),
      powerRating,
      powerRank: 0,
      momentumDelta,
      preciseScore,
    };
  });

  // Assign powerRank by Elo descending
  const byPower = [...scoredEntries].sort(
    (a, b) =>
      (b.powerRating ?? 1500) - (a.powerRating ?? 1500) ||
      b.preciseScore - a.preciseScore ||
      a.name.localeCompare(b.name)
  );
  const powerRankById = new Map<string, number>();
  byPower.forEach((e, idx) => powerRankById.set(e.identityKey, idx + 1));

  scoredEntries.sort(
    (a, b) =>
      b.preciseScore - a.preciseScore ||
      b.championshipPoints - a.championshipPoints ||
      (a.overallPlace ?? 999) - (b.overallPlace ?? 999) ||
      a.name.localeCompare(b.name)
  );

  const entries: AsianOptimistIndexProvisionalEntry[] = scoredEntries.map(
    (entry, idx) => {
      const { preciseScore, ...rest } = entry;
      void preciseScore;
      return {
        ...rest,
        provisionalRank: idx + 1,
        powerRank: powerRankById.get(entry.identityKey) ?? idx + 1,
      };
    }
  );

  const qualifiers: AsianOptimistIndexQualifierSource[] = [...activeEvents]
    .sort((a, b) => (b.grade ?? 0) - (a.grade ?? 0) || a.startDate.localeCompare(b.startDate))
    .map((ev) => ({
      id: ev.id,
      name: ev.name,
      hostCountry: ev.hostCountry,
      startDate: ev.startDate,
      endDate: ev.endDate,
      officialResultsUrl: ev.officialResultsUrl,
      officialResultsSourceName: ev.officialResultsSourceName,
      sailorPathRegattaSlug: ev.regattaSlugs[0] ?? ev.sailorpathRegattaSlug ?? null,
      usesSailorPathResults: ev.regattaSlugs.some((slug) => regattaBySlug.has(slug)),
      resultCount: ev.fleetSize,
      resultStatus: ev.resultStatus as "verified" | "awaiting_final" | "scheduled",
      grade: ev.grade ?? undefined,
    }));

  const asOf = latestEventDate
    ? formatAsOfDate(new Date(`${latestEventDate}T00:00:00Z`))
    : formatAsOfDate(now);

  return {
    entries,
    qualifiers,
    qualifierColumns: activeColumns,
    asOf,
    totalFleetSize: anchorFleetSize,
  };
}

const getCachedLiveAsianOptimistIndexData = unstable_cache(
  computeLiveAsianOptimistIndexData,
  ["asian-optimist-index-live-v1"],
  {
    revalidate: 300,
    tags: [CACHE_TAG_PUBLIC_REGATTAS],
  }
);

export async function getLiveAsianOptimistIndexData(): Promise<LiveAsianOptimistIndexData> {
  try {
    return await getCachedLiveAsianOptimistIndexData();
  } catch {
    return {
      entries: createAsianOptimistIndexProvisionalEntries(),
      qualifiers: [...ASIAN_OPTIMIST_INDEX_2026_QUALIFIERS],
      qualifierColumns: [...ASIAN_OPTIMIST_INDEX_DISPLAY_COLUMNS],
      asOf: ASIAN_OPTIMIST_INDEX_PROVISIONAL_RELEASE.asOf,
      totalFleetSize: 170,
    };
  }
}
