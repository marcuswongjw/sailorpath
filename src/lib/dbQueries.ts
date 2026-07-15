import { db } from "../db";
import { sailors, regattas, regattaResults, equipmentLogs, profiles } from "../db/schema";
import { getMockData } from "./mockData";
import { calculateRankings, Period, RankedSailor } from "./ranking";
import { eq, desc } from "drizzle-orm";

export interface QueryResponse<T> {
  data: T;
  isDemo: boolean;
}

export async function getSailors(): Promise<QueryResponse<any[]>> {
  try {
    const data = await db.select().from(sailors);
    return { data, isDemo: false };
  } catch (error) {
    console.warn("DB Connection failed, falling back to mock data.", error);
    return { data: getMockData().sailors, isDemo: true };
  }
}

export async function getRegattas(): Promise<QueryResponse<any[]>> {
  try {
    const data = await db.select().from(regattas).orderBy(desc(regattas.date));
    return { data, isDemo: false };
  } catch (error) {
    return { data: getMockData().regattas, isDemo: true };
  }
}

export async function getRegattaResults(): Promise<QueryResponse<any[]>> {
  try {
    const data = await db.select().from(regattaResults);
    return { data, isDemo: false };
  } catch (error) {
    return { data: getMockData().results, isDemo: true };
  }
}

export async function getSailorProfile(handle: string): Promise<QueryResponse<{
  sailor: any;
  results: any[];
  equipment: any | null;
} | null>> {
  try {
    // 1. Fetch Sailor
    const sailorList = await db.select().from(sailors).where(eq(sailors.handle, handle)).limit(1);
    if (sailorList.length === 0) return { data: null, isDemo: false };
    const sailor = sailorList[0];

    // 2. Fetch Results
    const sailorResults = await db
      .select({
        id: regattaResults.id,
        rank: regattaResults.rank,
        nettScore: regattaResults.nettScore,
        regattaName: regattas.name,
        regattaDate: regattas.date,
        totalFleetSize: regattas.totalFleetSize,
      })
      .from(regattaResults)
      .innerJoin(regattas, eq(regattaResults.regattaId, regattas.id))
      .where(eq(regattaResults.sailorId, sailor.id))
      .orderBy(desc(regattas.date));

    // 3. Fetch Equipment
    const eqList = await db.select().from(equipmentLogs).where(eq(equipmentLogs.sailorId, sailor.id)).limit(1);
    const equipment = eqList.length > 0 ? eqList[0] : null;

    return {
      data: { sailor, results: sailorResults, equipment },
      isDemo: false,
    };
  } catch (error) {
    console.warn("DB error for profile, falling back to mock data.", error);
    // Find in mock data
    const mData = getMockData();
    const sailor = mData.sailors.find((s) => s.handle === handle);
    if (!sailor) return { data: null, isDemo: true };

    const results = mData.results
      .filter((r) => r.sailorId === sailor.id)
      .map((r) => {
        const reg = mData.regattas.find((reg) => reg.id === r.regattaId);
        return {
          id: `${r.sailorId}-${r.regattaId}`,
          rank: r.rank,
          nettScore: r.nettScore,
          regattaName: reg?.name || "Unknown Regatta",
          regattaDate: reg?.date || "2026-01-01",
          totalFleetSize: reg?.totalFleetSize || 50,
        };
      });

    const eqLog = mData.equipmentLogs.find((e) => e.sailorId === sailor.id) || null;

    return {
      data: { sailor, results, equipment: eqLog },
      isDemo: true,
    };
  }
}

export async function getRegattaWithResults(slug: string): Promise<QueryResponse<{
  regatta: any;
  results: any[];
} | null>> {
  try {
    const regList = await db.select().from(regattas).where(eq(regattas.slug, slug)).limit(1);
    if (regList.length === 0) return { data: null, isDemo: false };
    const regatta = regList[0];

    const resultsList = await db
      .select({
        rank: regattaResults.rank,
        nettScore: regattaResults.nettScore,
        sailorName: sailors.name,
        sailorHandle: sailors.handle,
        sailNumber: sailors.sailNumber,
        club: sailors.club,
      })
      .from(regattaResults)
      .innerJoin(sailors, eq(regattaResults.sailorId, sailors.id))
      .where(eq(regattaResults.regattaId, regatta.id))
      .orderBy(regattaResults.rank);

    return {
      data: { regatta, results: resultsList },
      isDemo: false,
    };
  } catch (error) {
    const mData = getMockData();
    const regatta = mData.regattas.find((r) => r.slug === slug);
    if (!regatta) return { data: null, isDemo: true };

    const resultsList = mData.results
      .filter((r) => r.regattaId === regatta.id)
      .map((r) => {
        const s = mData.sailors.find((sailor) => sailor.id === r.sailorId);
        return {
          rank: r.rank,
          nettScore: r.nettScore,
          sailorName: s?.name || "Unknown Sailor",
          sailorHandle: s?.handle || "#",
          sailNumber: s?.sailNumber || "SGP 000",
          club: s?.club || "N/A",
        };
      })
      .sort((a, b) => a.rank - b.rank);

    return {
      data: { regatta, results: resultsList },
      isDemo: true,
    };
  }
}

export async function getFleetRankings(
  fleet: "Gold" | "Silver",
  period: Period
): Promise<QueryResponse<{
  rankings: RankedSailor[];
  regattasUsed: any[];
}>> {
  try {
    const sailorsList = await db.select().from(sailors);
    const regattasList = await db.select().from(regattas);
    const resultsList = await db.select().from(regattaResults);

    const allRankings = calculateRankings(period, sailorsList as any, regattasList as any, resultsList as any);
    const filteredRankings = allRankings.filter((r) => r.fleet === fleet);

    // Get the 5 regattas used for this period
    const pEndStr = period.half === "Jan-Jun" ? `${period.year}-06-30` : `${period.year}-12-31`;
    const pEnd = new Date(pEndStr).getTime();
    const periodRegattas = regattasList
      .filter((r) => new Date(r.date).getTime() <= pEnd)
      .sort((a, b) => new Date(b.date).getTime() - new Date(a.date).getTime())
      .slice(0, 5);

    return {
      data: {
        rankings: filteredRankings,
        regattasUsed: periodRegattas,
      },
      isDemo: false,
    };
  } catch (error) {
    const mData = getMockData();
    const allRankings = calculateRankings(period, mData.sailors, mData.regattas, mData.results);
    const filteredRankings = allRankings.filter((r) => r.fleet === fleet);

    const pEndStr = period.half === "Jan-Jun" ? `${period.year}-06-30` : `${period.year}-12-31`;
    const pEnd = new Date(pEndStr).getTime();
    const periodRegattas = mData.regattas
      .filter((r) => new Date(r.date).getTime() <= pEnd)
      .sort((a, b) => new Date(b.date).getTime() - new Date(a.date).getTime())
      .slice(0, 5);

    return {
      data: {
        rankings: filteredRankings,
        regattasUsed: periodRegattas,
      },
      isDemo: true,
    };
  }
}
