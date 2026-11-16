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

  const regattaRows =
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
      });
    }

    for (const reg of linkedRegattas) {
      const regResults = resultsByRegattaId.get(reg.id) ?? [];
      const starters = Math.max(eventStarters, regResults.length);
      if (starters < 1) continue;

      for (const row of regResults) {
        if (row.rank == null || row.rank < 1 || row.rank > starters) continue;
        const mna = normalizeMna(row.resultNationality ?? row.sailorNationality);
        if (!ASIAN_OCEANIA_MNAS.has(mna)) continue;

        const birthYear = birthYearFromSailor(row.sailorDob, row.resultBirthYear);
        if (!isOptimistAgeEligible(birthYear, rankingYear)) continue;

        const points = asianIndexPoints(grade, starters, row.rank);
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
          acc.anchorPlace = row.rank;
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
                rank: row.rank,
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
          rank: row.rank,
          points,
          hostMna,
          hostCountry: ev.hostCountry,
          year,
          isWorlds: ev.isWorlds,
          qualifierScore,
        });
      }
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
      preciseScore,
    };
  });

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
      return { ...rest, provisionalRank: idx + 1 };
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
