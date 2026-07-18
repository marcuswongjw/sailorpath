import { db, DbUnavailableError, formatDbError } from "@/db";
import {
  sailors,
  regattas,
  regattaResults,
  profiles,
} from "@/db/schema";
import {
  calculateRankings,
  type Period,
  type SailorRecord,
  type RegattaRecord,
  type RegattaResultRecord,
} from "@/lib/ranking";
import { asc, desc, eq, ilike, or, sql } from "drizzle-orm";

function mapSailor(row: typeof sailors.$inferSelect): SailorRecord {
  return {
    id: row.id,
    name: row.name,
    handle: row.handle,
    sailNumber: row.sailNumber,
    club: row.club,
    school: row.school,
    nationality: row.nationality,
    avatarUrl: row.avatarUrl,
    parentId: row.parentId,
    goldEntryDate: row.goldEntryDate,
    silverEntryDate: row.silverEntryDate,
    dropDate: row.dropDate,
    currentFleet: row.currentFleet,
    manuallyDropped: row.manuallyDropped,
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
  };
}

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

    const fleet = (f.fleet || "all").toLowerCase();
    if (fleet === "gold") {
      rows = rows.filter(
        (s) =>
          String(s.currentFleet || "").toLowerCase() === "gold" ||
          Boolean(s.goldEntryDate)
      );
    } else if (fleet === "silver") {
      rows = rows.filter((s) => {
        const cf = String(s.currentFleet || "").toLowerCase();
        return (
          cf === "silver" ||
          (Boolean(s.silverEntryDate) &&
            cf !== "gold" &&
            !s.goldEntryDate)
        );
      });
    } else if (fleet === "guest") {
      rows = rows.filter(
        (s) =>
          !s.currentFleet &&
          !s.goldEntryDate &&
          !s.silverEntryDate
      );
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
    const [row] = await db
      .select()
      .from(sailors)
      .where(eq(sailors.handle, handle))
      .limit(1);
    return row ? mapSailor(row) : null;
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
        gender: sailors.gender,
        dob: sailors.dob,
      })
      .from(regattaResults)
      .innerJoin(sailors, eq(regattaResults.sailorId, sailors.id))
      .where(eq(regattaResults.regattaId, regattaId))
      .orderBy(asc(regattaResults.rank));
    return rows;
  });
}

export async function getResultsForSailor(sailorId: string) {
  return withDb(async () => {
    return db
      .select({
        rank: regattaResults.rank,
        nettScore: regattaResults.nettScore,
        totalScore: regattaResults.totalScore,
        isDns: regattaResults.isDns,
        isOverseasCommitment: regattaResults.isOverseasCommitment,
        regattaName: regattas.name,
        regattaSlug: regattas.slug,
        regattaDate: regattas.date,
        division: regattas.division,
        fleetSize: regattas.totalFleetSize,
      })
      .from(regattaResults)
      .innerJoin(regattas, eq(regattaResults.regattaId, regattas.id))
      .where(eq(regattaResults.sailorId, sailorId))
      .orderBy(desc(regattas.date));
  });
}

export async function computeFleetRankings(
  fleet: "Gold" | "Silver",
  period: Period
) {
  return withDb(async () => {
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
