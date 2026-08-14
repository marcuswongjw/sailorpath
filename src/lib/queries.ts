import { db, DbUnavailableError, formatDbError } from "@/db";
import {
  sailors,
  regattas,
  regattaResults,
  profiles,
  raceObservations,
  equipmentLogs,
  sailorAliases,
} from "@/db/schema";
import {
  calculateRankings,
  periodLabel,
  resolveSailorFleet,
  scoringRegattasForFleet,
  type Period,
  type SailorRecord,
  type RegattaRecord,
  type RegattaResultRecord,
  type RegattaScoreSlot,
} from "@/lib/ranking";
import { currentPeriodFromSgToday, todayYmdSg } from "@/lib/datesSg";
import {
  isInSgSeries,
  normalizeSgSeriesMembership,
} from "@/lib/seriesMembership";
import {
  computeIlcaRankings,
  ilcaRankingRegattas,
  isIlcaSeriesClass,
  type IlcaBoatClass,
} from "@/lib/ilcaRanking";
import {
  asc,
  desc,
  eq,
  inArray,
  or,
  and,
  sql,
} from "drizzle-orm";

export type SailorMapped = SailorRecord & {
  isPublicWeight?: boolean;
  isPublicDob?: boolean;
  isPublicEquipment?: boolean;
  sailingJourney?: string | null;
  ilca4NationalList?: boolean | null;
  hullBrand?: string | null;
  sailMake?: string | null;
  foilBrand?: string | null;
  mast?: string | null;
  equipmentNotes?: string | null;
  hullBrandIlca4?: string | null;
  sailMakeIlca4?: string | null;
  foilBrandIlca4?: string | null;
  mastIlca4?: string | null;
  equipmentNotesIlca4?: string | null;
  nationalityFromSail?: boolean | null;
};

function mapSailor(row: typeof sailors.$inferSelect): SailorMapped {
  return {
    id: row.id,
    name: row.name,
    handle: row.handle,
    sailNumber: row.sailNumber,
    sailNumberIlca4: row.sailNumberIlca4,
    ilca4NationalList: row.ilca4NationalList,
    club: row.club,
    school: row.school,
    nationality: row.nationality,
    nationalityFromSail: row.nationalityFromSail,
    avatarUrl: row.avatarUrl,
    parentId: row.parentId,
    goldEntryDate: row.goldEntryDate,
    silverEntryDate: row.silverEntryDate,
    dropDate: row.dropDate,
    // Normalize legacy Gold/Silver tags to Series for ranking + UI
    currentFleet: (() => {
      const n = normalizeSgSeriesMembership(row.currentFleet);
      if (n) return n;
      if (row.currentFleet == null || row.currentFleet === "") return row.currentFleet;
      return row.currentFleet;
    })(),

    dob: row.dob,
    weight: row.weight,
    bio: row.bio,
    gender: row.gender,
    nationalSquadStatus: row.nationalSquadStatus,
    instagram: row.instagram,
    facebook: row.facebook,
    natSquadStatusJan25: row.natSquadStatusJan25,
    natSquadStatusJul25: row.natSquadStatusJul25,
    natSquadStatusJan26: row.natSquadStatusJan26,
    natSquadStatusJul26: row.natSquadStatusJul26,
    histRankingJun24: row.histRankingJun24,
    histRankingDec24: row.histRankingDec24,
    histRankingJun25: row.histRankingJun25,
    histRankingDec25: row.histRankingDec25,
    histRankingJun26: row.histRankingJun26,
    worlds: row.worlds,
    european: row.european,
    asian: row.asian,
    seaGames: row.seaGames,
    isPublicWeight: row.isPublicWeight,
    isPublicDob: row.isPublicDob,
    isPublicEquipment: row.isPublicEquipment,
    sailingJourney: (row as { sailingJourney?: string | null }).sailingJourney,
    hullBrand: row.hullBrand,
    sailMake: row.sailMake,
    foilBrand: row.foilBrand,
    mast: row.mast,
    equipmentNotes: row.equipmentNotes,
    hullBrandIlca4: row.hullBrandIlca4,
    sailMakeIlca4: row.sailMakeIlca4,
    foilBrandIlca4: row.foilBrandIlca4,
    mastIlca4: row.mastIlca4,
    equipmentNotesIlca4: row.equipmentNotesIlca4,
  };
}

export type SeriesStanding = {
  period: Period;
  periodLabel: string;
  fleet: "Gold" | "Silver";
  overallRank: number;
  fleetSize: number;
  best3of5: number;
  rScores: RegattaScoreSlot[];
  trendNote: string;
};

/** ILCA 4 (or 6) Best 3 of 5 high-points strip for a profile */
export type IlcaSeriesStanding = {
  periodLabel: string;
  fleet: "Open";
  overallRank: number;
  fleetSize: number;
  best3of5: number;
  rScores: RegattaScoreSlot[];
  trendNote: string;
  boatClass: IlcaBoatClass;
  /** True when ranking used unrestricted board (not national list only) */
  unrestricted?: boolean;
};

async function withDb<T>(fn: () => Promise<T>): Promise<T> {
  try {
    return await fn();
  } catch (e) {
    throw new DbUnavailableError(formatDbError(e));
  }
}

export async function listSailors() {
  return withDb(async () => {
    const rows = await db.select().from(sailors).orderBy(asc(sailors.name));
    return rows.map(mapSailor);
  });
}

export type SailorSearchFilters = {
  query?: string;
  fleet?: string; // gold | silver | guest | all
  squad?: string;
  nationality?: string;
  club?: string;
  school?: string;
  birthYearFrom?: number;
  birthYearTo?: number;
};

export async function searchSailors(
  queryOrFilters: string | SailorSearchFilters
) {
  return withDb(async () => {
    const f: SailorSearchFilters =
      typeof queryOrFilters === "string"
        ? { query: queryOrFilters }
        : queryOrFilters || {};

    let rows = await db.select().from(sailors).orderBy(asc(sailors.name));

    const q = (f.query || "").trim().toLowerCase();
    if (q) {
      rows = rows.filter((s) => {
        const hay = `${s.name} ${s.sailNumber || ""} ${s.club || ""} ${s.handle || ""} ${s.school || ""} ${s.nationality || ""}`.toLowerCase();
        return hay.includes(q);
      });
    }

    // Fleet filter = active ranking tier for current SG half (not just entry history)
    const fleet = (f.fleet || "all").toLowerCase();
    if (fleet === "gold" || fleet === "silver" || fleet === "guest") {
      const period = currentPeriodFromSgToday();
      const mapped = rows.map(mapSailor);
      rows = rows.filter((_, i) => {
        const s = mapped[i];
        if (fleet === "guest") {
          return (
            !isInSgSeries(s) ||
            resolveSailorFleet(s, period) == null
          );
        }
        const r = resolveSailorFleet(s, period);
        if (!r?.active) return false;
        return fleet === "gold" ? r.fleet === "Gold" : r.fleet === "Silver";
      });
    }

    if (f.squad && f.squad !== "all") {
      rows = rows.filter(
        (s) => String(s.nationalSquadStatus || "") === f.squad
      );
    }
    if (f.nationality?.trim()) {
      const n = f.nationality.trim().toLowerCase();
      rows = rows.filter((s) =>
        String(s.nationality || "")
          .toLowerCase()
          .includes(n)
      );
    }
    if (f.club?.trim()) {
      const c = f.club.trim().toLowerCase();
      rows = rows.filter((s) =>
        String(s.club || "")
          .toLowerCase()
          .includes(c)
      );
    }
    if (f.school?.trim()) {
      const sc = f.school.trim().toLowerCase();
      rows = rows.filter((s) =>
        String(s.school || "")
          .toLowerCase()
          .includes(sc)
      );
    }
    if (f.birthYearFrom || f.birthYearTo) {
      rows = rows.filter((s) => {
        if (!s.dob) return false;
        const y = new Date(s.dob).getFullYear();
        if (!Number.isFinite(y)) return false;
        if (f.birthYearFrom && y < f.birthYearFrom) return false;
        if (f.birthYearTo && y > f.birthYearTo) return false;
        return true;
      });
    }

    return rows.slice(0, 80).map(mapSailor);
  });
}

export async function getSailorByHandle(handle: string) {
  return withDb(async () => {
    const h = String(handle || "").trim().toLowerCase();
    if (!h) return null;

    const [row] = await db
      .select()
      .from(sailors)
      .where(eq(sailors.handle, h))
      .limit(1);
    if (row) return mapSailor(row);

    // Previous handles kept as aliases after a rename
    const [alias] = await db
      .select({ sailorId: sailorAliases.sailorId })
      .from(sailorAliases)
      .where(eq(sailorAliases.aliasName, h))
      .limit(1);
    if (!alias) return null;

    const [viaAlias] = await db
      .select()
      .from(sailors)
      .where(eq(sailors.id, alias.sailorId))
      .limit(1);
    return viaAlias ? mapSailor(viaAlias) : null;
  });
}

export async function listRegattas() {
  return withDb(async () => {
    const rows = await db
      .select()
      .from(regattas)
      .orderBy(desc(regattas.date));
    return rows.map(
      (r): RegattaRecord => ({
        id: r.id,
        name: r.name,
        slug: r.slug,
        date: r.date,
        totalFleetSize: r.totalFleetSize,
        division: r.division,
        raceCount: r.raceCount,
        geography: r.geography ?? "SG",
        boatClass: r.boatClass ?? "Optimist",
        countsForRanking: r.countsForRanking !== false,
      })
    );
  });
}

export async function getRegattaBySlug(slug: string) {
  return withDb(async () => {
    const [row] = await db
      .select()
      .from(regattas)
      .where(eq(regattas.slug, slug))
      .limit(1);
    if (!row) return null;
    return {
      id: row.id,
      name: row.name,
      slug: row.slug,
      date: row.date,
      totalFleetSize: row.totalFleetSize,
      division: row.division,
      geography: row.geography ?? "SG",
      boatClass: row.boatClass ?? "Optimist",
      raceCount: row.raceCount,
    } satisfies RegattaRecord;
  });
}

export async function listResults() {
  return withDb(async () => {
    const rows = await db.select().from(regattaResults);
    // Include id for admin delete/edit (extends ranking type)
    return rows.map((r) => ({
      id: r.id,
      sailorId: r.sailorId,
      regattaId: r.regattaId,
      rank: r.rank,
      nettScore: r.nettScore,
      totalScore: r.totalScore,
      isDns: r.isDns,
      isDNS: r.isDns, // alias for admin UI
      isOverseasCommitment: r.isOverseasCommitment,
    }));
  });
}

export async function listRegattasFull() {
  return withDb(async () => {
    return db.select().from(regattas).orderBy(desc(regattas.date));
  });
}

export async function listSailorsFull() {
  return withDb(async () => {
    return db.select().from(sailors).orderBy(asc(sailors.name));
  });
}

export async function getResultsForRegatta(regattaId: string) {
  return withDb(async () => {
    const rows = await db
      .select({
        sailorId: regattaResults.sailorId,
        regattaId: regattaResults.regattaId,
        rank: regattaResults.rank,
        nettScore: regattaResults.nettScore,
        totalScore: regattaResults.totalScore,
        isDns: regattaResults.isDns,
        isOverseasCommitment: regattaResults.isOverseasCommitment,
        sailorName: sailors.name,
        sailNumber: sailors.sailNumber,
        handle: sailors.handle,
        gender: regattaResults.gender,
        sailorGender: sailors.gender,
        birthYear: regattaResults.birthYear,
        dob: sailors.dob,
        nationality: regattaResults.nationality,
        sailorNationality: sailors.nationality,
      })
      .from(regattaResults)
      .innerJoin(sailors, eq(regattaResults.sailorId, sailors.id))
      .where(eq(regattaResults.regattaId, regattaId))
      .orderBy(asc(regattaResults.rank));
    return rows.map((r) => ({
      ...r,
      gender: r.gender || r.sailorGender || null,
      nationality: r.nationality || r.sailorNationality || null,
    }));
  });
}

export async function getResultsForSailor(sailorId: string) {
  return withDb(async () => {
    return db
      .select({
        resultId: regattaResults.id,
        rank: regattaResults.rank,
        nettScore: regattaResults.nettScore,
        totalScore: regattaResults.totalScore,
        isDns: regattaResults.isDns,
        isOverseasCommitment: regattaResults.isOverseasCommitment,
        regattaId: regattas.id,
        regattaName: regattas.name,
        regattaSlug: regattas.slug,
        regattaDate: regattas.date,
        division: regattas.division,
        fleetSize: regattas.totalFleetSize,
        raceCount: regattas.raceCount,
        geography: regattas.geography,
        countsForRanking: regattas.countsForRanking,
        boatClass: regattas.boatClass,
      })
      .from(regattaResults)
      .innerJoin(regattas, eq(regattaResults.regattaId, regattas.id))
      .where(eq(regattaResults.sailorId, sailorId))
      .orderBy(desc(regattas.date));
  });
}

/**
 * Live Best 3 of 5 strip for a single sailor.
 *
 * Optimised vs full-board compute:
 * 1) Load subject sailor first — bail if guest / dropped
 * 2) Rank only same-fleet peers for the period (not guests / other fleet)
 * 3) Results limited to scoring-window regatta IDs
 *
 * Default period = current half-year in Asia/Singapore.
 */
export async function getSailorSeriesStanding(
  sailorId: string,
  period: Period = currentPeriodFromSgToday()
): Promise<SeriesStanding | null> {
  return withDb(async () => {
    // Lean column set — full sailor select was slow on every profile open
    const sailorRows = await db
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
        natSquadStatusJan25: sailors.natSquadStatusJan25,
        natSquadStatusJul25: sailors.natSquadStatusJul25,
        natSquadStatusJan26: sailors.natSquadStatusJan26,
        natSquadStatusJul26: sailors.natSquadStatusJul26,
        nationalSquadStatus: sailors.nationalSquadStatus,
      })
      .from(sailors);

    const allMapped = sailorRows.map((row) => ({
      ...row,
      currentFleet: (() => {
        const n = normalizeSgSeriesMembership(row.currentFleet);
        if (n) return n;
        return row.currentFleet;
      })(),
    })) as SailorRecord[];

    const meRow = allMapped.find((x) => x.id === sailorId);
    if (!meRow) return null;

    const fleetInfo = resolveSailorFleet(meRow, period);
    if (!fleetInfo?.active) return null;

    const peers = allMapped.filter((s) => {
      const r = resolveSailorFleet(s, period);
      return Boolean(r?.active && r.fleet === fleetInfo.fleet);
    });

    // Optimist ranking regattas only (skip ILCA bulk)
    const regattaRows = await db
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
      .where(
        or(
          eq(regattas.boatClass, "Optimist"),
          sql`lower(coalesce(${regattas.boatClass}, 'optimist')) not like '%ilca%'`
        )
      );

    const r: RegattaRecord[] = regattaRows.map((row) => ({
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

    const slots = scoringRegattasForFleet(fleetInfo.fleet, period, r);
    const scoringIds = slots.map((x) => x.regatta.id);
    if (!scoringIds.length) return null;

    const resultRows = await db
      .select({
        sailorId: regattaResults.sailorId,
        regattaId: regattaResults.regattaId,
        rank: regattaResults.rank,
        nettScore: regattaResults.nettScore,
        totalScore: regattaResults.totalScore,
        isDns: regattaResults.isDns,
        isOverseasCommitment: regattaResults.isOverseasCommitment,
      })
      .from(regattaResults)
      .where(inArray(regattaResults.regattaId, scoringIds));

    const res: RegattaResultRecord[] = resultRows.map((row) => ({
      sailorId: row.sailorId,
      regattaId: row.regattaId,
      rank: row.rank,
      nettScore: row.nettScore,
      totalScore: row.totalScore,
      isDns: row.isDns,
      isOverseasCommitment: row.isOverseasCommitment,
    }));

    const all = calculateRankings(period, peers, r, res).filter(
      (x) => x.fleet === fleetInfo.fleet
    );
    const me = all.find((x) => x.id === sailorId);
    if (!me) return null;
    const overallRank = all.findIndex((x) => x.id === sailorId) + 1;
    const carry = me.regattaScores.filter((rs) => rs.isCarryForward).length;
    return {
      period,
      periodLabel: periodLabel(period),
      fleet: me.fleet,
      overallRank,
      fleetSize: all.length,
      best3of5: me.overallScore,
      rScores: me.regattaScores,
      trendNote:
        carry > 0
          ? `Includes ${carry} carry-forward score${carry === 1 ? "" : "s"} from previous half`
          : `Best 3 of ${Math.min(5, me.regattaScores.length)} scoring events`,
    };
  });
}

/**
 * Live ILCA Best 3 of last 5 high-points standing for one sailor.
 * Prefers national-list board; falls back to all ILCA racers if the sailor
 * has results but is not on the official list.
 */
export async function getSailorIlcaStanding(
  sailorId: string,
  boatClass: IlcaBoatClass = "ILCA 4"
): Promise<IlcaSeriesStanding | null> {
  return withDb(async () => {
    const asOf = todayYmdSg();

    // Cheap subject check first — most Optimist-only profiles skip the board re-rank
    const [meRow] = await db
      .select({
        id: sailors.id,
        name: sailors.name,
        gender: sailors.gender,
        dob: sailors.dob,
        nationality: sailors.nationality,
        sailNumber: sailors.sailNumber,
        sailNumberIlca4: sailors.sailNumberIlca4,
        ilca4NationalList: sailors.ilca4NationalList,
        club: sailors.club,
        handle: sailors.handle,
      })
      .from(sailors)
      .where(eq(sailors.id, sailorId))
      .limit(1);
    if (!meRow) return null;

    const [anyIlcaResult] = await db
      .select({ id: regattaResults.id })
      .from(regattaResults)
      .innerJoin(regattas, eq(regattaResults.regattaId, regattas.id))
      .where(
        and(
          eq(regattaResults.sailorId, sailorId),
          or(
            eq(regattas.boatClass, "ILCA 4"),
            eq(regattas.boatClass, "ILCA4"),
            sql`lower(coalesce(${regattas.boatClass}, '')) like '%ilca%4%'`
          )
        )
      )
      .limit(1);

    const onNationalList = Boolean(meRow.ilca4NationalList);
    if (!anyIlcaResult && !onNationalList && !meRow.sailNumberIlca4) {
      return null;
    }

    // Lean ILCA-relevant sailors only (national list and/or ILCA sail #)
    const sailorRows = await db
      .select({
        id: sailors.id,
        name: sailors.name,
        gender: sailors.gender,
        dob: sailors.dob,
        nationality: sailors.nationality,
        sailNumber: sailors.sailNumber,
        sailNumberIlca4: sailors.sailNumberIlca4,
        ilca4NationalList: sailors.ilca4NationalList,
        club: sailors.club,
        handle: sailors.handle,
      })
      .from(sailors)
      .where(
        or(
          eq(sailors.ilca4NationalList, true),
          sql`${sailors.sailNumberIlca4} is not null and ${sailors.sailNumberIlca4} <> ''`,
          eq(sailors.id, sailorId)
        )
      );

    // ILCA regattas only
    const regattaRows = await db
      .select({
        id: regattas.id,
        name: regattas.name,
        date: regattas.date,
        totalFleetSize: regattas.totalFleetSize,
        boatClass: regattas.boatClass,
        countsForRanking: regattas.countsForRanking,
        raceCount: regattas.raceCount,
        division: regattas.division,
      })
      .from(regattas)
      .where(
        or(
          eq(regattas.boatClass, "ILCA 4"),
          eq(regattas.boatClass, "ILCA4"),
          sql`lower(coalesce(${regattas.boatClass}, '')) like '%ilca%'`
        )
      );

    const ilcaSailors = sailorRows.map((s) => ({
      id: s.id,
      name: s.name,
      gender: s.gender,
      dob: s.dob,
      nationality: s.nationality,
      sailNumber: s.sailNumber,
      sailNumberIlca4: s.sailNumberIlca4,
      ilca4NationalList: s.ilca4NationalList,
      club: s.club,
      handle: s.handle,
    }));

    const ilcaRegattas = regattaRows
      .filter((r) => isIlcaSeriesClass(r.boatClass, boatClass))
      .map((r) => ({
        id: r.id,
        name: r.name,
        date: r.date,
        totalFleetSize: r.totalFleetSize ?? 50,
        boatClass: r.boatClass,
        countsForRanking: r.countsForRanking,
        raceCount: r.raceCount,
        division: r.division,
      }));

    const window = ilcaRankingRegattas(ilcaRegattas, boatClass, asOf);
    if (!window.length) return null;

    const scoringIds = window.map((r) => r.id);
    const resultRows = await db
      .select({
        sailorId: regattaResults.sailorId,
        regattaId: regattaResults.regattaId,
        rank: regattaResults.rank,
        isDns: regattaResults.isDns,
        isOverseasCommitment: regattaResults.isOverseasCommitment,
      })
      .from(regattaResults)
      .where(inArray(regattaResults.regattaId, scoringIds));

    const hasAnyResult = resultRows.some((r) => r.sailorId === sailorId);
    if (!hasAnyResult && !onNationalList) return null;

    const ilcaResults = resultRows.map((row) => ({
      sailorId: row.sailorId,
      regattaId: row.regattaId,
      rank: row.rank,
      isDns: row.isDns,
      isOverseasCommitment: row.isOverseasCommitment,
    }));

    const build = (restrictToNationalList: boolean) =>
      computeIlcaRankings(
        boatClass,
        asOf,
        ilcaSailors,
        ilcaRegattas,
        ilcaResults,
        { restrictToNationalList }
      );

    let ranked = build(true);
    let unrestricted = false;
    let me = ranked.find((x) => x.sailorId === sailorId);
    if (!me) {
      ranked = build(false);
      unrestricted = true;
      me = ranked.find((x) => x.sailorId === sailorId);
    }
    if (!me) return null;

    const rScores: RegattaScoreSlot[] = me.eventScores.map((e) => ({
      regattaId: e.regattaId,
      regattaName: e.regattaName,
      score: e.points,
      isDNS: e.isDns,
      isOverseasCommitment: false,
      finishPlace: e.place > 0 ? e.place : null,
    }));

    // Pad to 5 slots for the profile strip
    while (rScores.length < 5) {
      rScores.push({
        regattaId: `empty-${rScores.length}`,
        regattaName: "—",
        score: 0,
        isDNS: true,
      });
    }

    return {
      periodLabel: `${boatClass} · ranking as of ${asOf}`,
      fleet: "Open",
      overallRank: me.rank,
      fleetSize: ranked.length,
      best3of5: me.totalPoints,
      rScores,
      trendNote: unrestricted
        ? `Best 3 of 5 high points · not on national list (open board #${me.rank})`
        : `Best 3 of 5 high points · #${me.rank} of ${ranked.length} nationally`,
      boatClass,
      unrestricted,
    };
  });
}

export async function getRaceObservationsForSailor(
  sailorId: string,
  opts?: { includePrivate?: boolean }
) {
  return withDb(async () => {
    const rows = await db
      .select({
        id: raceObservations.id,
        sailorId: raceObservations.sailorId,
        regattaId: raceObservations.regattaId,
        raceNumber: raceObservations.raceNumber,
        position: raceObservations.position,
        wind: raceObservations.wind,
        note: raceObservations.note,
        isPrivate: raceObservations.isPrivate,
        regattaName: regattas.name,
        regattaSlug: regattas.slug,
        regattaDate: regattas.date,
      })
      .from(raceObservations)
      .innerJoin(regattas, eq(raceObservations.regattaId, regattas.id))
      .where(eq(raceObservations.sailorId, sailorId))
      .orderBy(desc(regattas.date), asc(raceObservations.raceNumber));

    if (opts?.includePrivate) return rows;
    return rows.filter((r) => !r.isPrivate);
  });
}

export async function getEquipmentLogsForSailor(sailorId: string) {
  return withDb(async () => {
    return db
      .select()
      .from(equipmentLogs)
      .where(eq(equipmentLogs.sailorId, sailorId))
      .orderBy(desc(equipmentLogs.effectiveDate));
  });
}

export async function computeFleetRankings(
  fleet: "Gold" | "Silver",
  period: Period
) {
  return withDb(async () => {
    // Read-only rankings — DNS flag healing is admin-only (healFalseDns)
    const [s, r, res] = await Promise.all([
      listSailors(),
      listRegattas(),
      listResults(),
    ]);
    return calculateRankings(period, s, r, res).filter((x) => x.fleet === fleet);
  });
}

export async function ensureProfileForUser(user: {
  id: string;
  email?: string | null;
  user_metadata?: Record<string, unknown>;
}) {
  return withDb(async () => {
    const existing = await db
      .select({ id: profiles.id, role: profiles.role })
      .from(profiles)
      .where(eq(profiles.id, user.id))
      .limit(1);
    if (existing[0]) return { profile: existing[0], created: false };

    const fullName =
      (user.user_metadata?.full_name as string) ||
      (user.user_metadata?.handle as string) ||
      user.email?.split("@")[0] ||
      "Sailor";

    let role: "sailor" | "superadmin" = "sailor";
    if (
      process.env.SUPERADMIN_EMAIL &&
      user.email &&
      user.email.toLowerCase() === process.env.SUPERADMIN_EMAIL.toLowerCase()
    ) {
      role = "superadmin";
    }

    const [row] = await db
      .insert(profiles)
      .values({
        id: user.id,
        email: user.email || "",
        fullName,
        role,
      })
      .onConflictDoUpdate({
        target: profiles.id,
        set: { email: user.email || "", updatedAt: new Date() },
      })
      .returning({ id: profiles.id, role: profiles.role });

    return { profile: row, created: true };
  });
}

export async function dbPing() {
  return withDb(async () => {
    await db.execute(sql`select 1 as ok`);
    return true;
  });
}
