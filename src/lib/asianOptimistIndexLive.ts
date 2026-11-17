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
import { selectPowerPool } from "@/lib/asianOptimistIndexPool";
import { annualSeriesKey, meetsRecordedIndexGates, selectActiveIndexEvents } from "@/lib/asianOptimistIndexRollover";

const ASIAN_OCEANIA_MNAS = new Set<string>(
  ASIAN_INDEX_MNA_REGIONS.flatMap((r) => r.codes)
);
const FALLBACK_EXCLUDED_THAILAND = "youth-thailand-national-sailing-championship-2026-optimist";
const fallbackQualifiers = ASIAN_OPTIMIST_INDEX_2026_QUALIFIERS.filter((event) => event.id !== FALLBACK_EXCLUDED_THAILAND);
const fallbackColumns = ASIAN_OPTIMIST_INDEX_DISPLAY_COLUMNS.filter((event) => event.id !== FALLBACK_EXCLUDED_THAILAND);

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

  const eventRegister = await withDatabaseRetry(() =>
    db
      .select()
      .from(asianOptimistIndexEvents)
  );
  const events = eventRegister.filter((event) => event.isEligible);
  const excludedSlugs = new Set(
    eventRegister.filter((event) => !event.isEligible).flatMap((event) => event.regattaSlugs)
  );

  if (events.length === 0) {
    return {
      entries: createAsianOptimistIndexProvisionalEntries(),
      qualifiers: [...fallbackQualifiers],
      qualifierColumns: [...fallbackColumns],
      asOf: ASIAN_OPTIMIST_INDEX_PROVISIONAL_RELEASE.asOf,
      totalFleetSize: 170,
    };
  }

  // A successor must actually have its linked published scorecards before it
  // can replace an older edition, even if its register status says verified.
  const registeredSlugs = [...new Set(events.flatMap((event) => event.regattaSlugs))];
  const publishedSlugs = registeredSlugs.length ? await withDatabaseRetry(() =>
    db.select({ id: regattas.id, slug: regattas.slug }).from(regattas).where(and(
      inArray(regattas.slug, registeredSlugs), eq(regattas.status, "published")
    ))
  ) : [];
  const populatedSheets = publishedSlugs.length ? await withDatabaseRetry(() =>
    db.selectDistinct({ id: regattaResults.regattaId }).from(regattaResults)
      .where(inArray(regattaResults.regattaId, publishedSlugs.map((row) => row.id)))
  ) : [];
  const populatedIds = new Set(populatedSheets.map((row) => row.id));
  const publishedSlugSet = new Set(publishedSlugs.filter((row) => populatedIds.has(row.id)).map((row) => row.slug));
  const availableEvents = events.filter((event) => event.resultStatus === "scheduled" ||
    (event.regattaSlugs.length > 0 && event.regattaSlugs.every((slug) => publishedSlugSet.has(slug))));
  const activeEvents = selectActiveIndexEvents(availableEvents, now);

  const scoredEvents = activeEvents.filter(
    (e) => e.resultStatus === "verified" && e.grade != null && e.regattaSlugs.length > 0 && meetsRecordedIndexGates(e)
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

  // Fetch all published Optimist regattas within the rolling 12-month window
  // so Elo Power Rating & 90-day Momentum treat every country symmetrically (K = 16 for domestic/club regattas).
  const cutoff12Date = new Date(now);
  cutoff12Date.setUTCFullYear(cutoff12Date.getUTCFullYear() - 1);
  const cutoff12Str = cutoff12Date.toISOString().slice(0, 10);

  const allOptiRows = await withDatabaseRetry(() =>
    db
      .select({
        id: regattas.id,
        eventId: regattas.eventId,
        slug: regattas.slug,
        name: regattas.name,
        division: regattas.division,
        raceCount: regattas.raceCount,
        totalFleetSize: regattas.totalFleetSize,
        endDate: regattas.endDate,
        date: regattas.date,
      })
      .from(regattas)
      .where(
        and(
          eq(regattas.boatClass, "Optimist"),
          eq(regattas.status, "published")
        )
      )
  );

  const designatedSlugSet = new Set(allSlugs);
  const recentAllOpti = selectPowerPool(allOptiRows, excludedSlugs, cutoff12Str);
  const extraDomesticRegattas = recentAllOpti.filter((r) => !designatedSlugSet.has(r.slug));

  const regattaRows = [
    ...designatedRegattaRows.map((r) => ({
      ...r,
      eventId: null as string | null,
      division: null as string | null,
      raceCount: null as number | null,
    })),
    ...extraDomesticRegattas,
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
  // plus all published Optimist regattas across all countries symmetrically (K = 16 for non-designated).
  // Split fleets (Gold+Silver+Bronze, Open+Intermediate+Green, Class A+B+C) are paired into one field
  // per eventId, while separate Boys/Girls divisions remain independent fields.
  type EloEvent = {
    id: string;
    startDate: string;
    endDate: string;
    kFactor: number;
    regattaSlugs: string[];
  };

  function divisionTierOrder(slug: string, division: string | null): number {
    const s = `${slug} ${division ?? ""}`.toLowerCase();
    if (/\b(gold|open|main|class[- ]?a|optimist-a)\b/.test(s)) return 0;
    if (/\b(silver|intermediate|class[- ]?b|optimist-b)\b/.test(s)) return 1;
    if (/\b(bronze|green|novice|class[- ]?c|optimist-c)\b/.test(s)) return 2;
    return 0;
  }

  function isSexSplit(slug: string, division: string | null): "boys" | "girls" | null {
    const s = `${slug} ${division ?? ""}`.toLowerCase();
    if (/\b(boys|men)\b|-b-/.test(s)) return "boys";
    if (/\b(girls|women)\b|-g-/.test(s)) return "girls";
    return null;
  }

  const domesticByGroup = new Map<string, typeof recentAllOpti>();
  for (const r of recentAllOpti) {
    // Skip regattas already covered by a designated event (unless part of a Gold+Silver split with a designated Gold)
    const sex = isSexSplit(r.slug, r.division);
    const baseKey = r.slug.startsWith("rsyc-2026-") ? "rsyc-2026" : (r.eventId ?? r.slug);
    const gKey = sex ? `${baseKey}:${sex}` : baseKey;
    const list = domesticByGroup.get(gKey);
    if (list) list.push(r);
    else domesticByGroup.set(gKey, [r]);
  }

  // Map designated slugs to their event metadata so we preserve designated K-factors
  const designatedEventBySlug = new Map<string, (typeof scoredEvents)[number]>();
  for (const e of scoredEvents) {
    for (const sl of e.regattaSlugs) designatedEventBySlug.set(sl, e);
  }

  const domesticEloEvents: EloEvent[] = [];
  const handledDesignatedIds = new Set<string>();

  for (const [gKey, grp] of domesticByGroup.entries()) {
    // If an event has an Overall sheet alongside Gold/Silver (e.g. Thailand Series 3), prefer Overall only
    const overallOnly = grp.filter((r) => /\boverall\b/i.test(r.slug) || /\boverall\b/i.test(r.division ?? ""));
    const activeGrp = overallOnly.length > 0 && grp.length > overallOnly.length ? overallOnly : grp;

    const ordered = [...activeGrp].sort(
      (a, b) => divisionTierOrder(a.slug, a.division) - divisionTierOrder(b.slug, b.division) || a.date.localeCompare(b.date)
    );
    const slugs = ordered.map((r) => r.slug);

    // Check if any slug in this group belongs to a designated event
    let kFactor = 16;
    for (const sl of slugs) {
      const des = designatedEventBySlug.get(sl);
      if (des) {
        handledDesignatedIds.add(des.id);
        const g = (des.grade ?? 75) as AsianIndexGrade;
        const desK = g === 200 ? 48 : g === 150 ? 40 : g === 75 ? 32 : 24;
        if (desK > kFactor) kFactor = desK;
      }
    }

    const maxEnd = ordered.reduce((m, r) => ((r.endDate ?? r.date) > m ? (r.endDate ?? r.date) : m), "");
    const minStart = ordered.reduce((m, r) => (r.date < m ? r.date : m), ordered[0].date);
    domesticEloEvents.push({
      id: `grp:${gKey}`,
      startDate: minStart,
      endDate: maxEnd,
      kFactor,
      regattaSlugs: slugs,
    });
  }

  const chronoEvents: EloEvent[] = [
    ...scoredEvents
      .filter((e) => !handledDesignatedIds.has(e.id))
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
    ...domesticEloEvents,
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

    const isAnchor = annualSeriesKey(ev) === "asian-oceanian:overall";
    if (isAnchor) {
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

        if (isAnchor) {
          acc.anchorPlace = effectiveRank;
          acc.anchorTotalPoints = row.totalScore;
          acc.anchorNetPoints = row.nettScore;
        }

        const qualifierScore: AsianOptimistIndexQualifierScore | undefined =
          isAnchor
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
                regattaSlug: reg.slug,
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
            : "Dropped by V1.1 (Beta) selection limits (host cap or 5-result cap)",
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

  const qualifiers: AsianOptimistIndexQualifierSource[] = activeEvents
    .filter((event) => event.resultStatus === "scheduled" || scoredEvents.includes(event))
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
      qualifiers: [...fallbackQualifiers],
      qualifierColumns: [...fallbackColumns],
      asOf: ASIAN_OPTIMIST_INDEX_PROVISIONAL_RELEASE.asOf,
      totalFleetSize: 170,
    };
  }
}
