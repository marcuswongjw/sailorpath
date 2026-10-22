import { unstable_cache } from "next/cache";
import { count, eq, inArray } from "drizzle-orm";
import { db, withSequentialDatabaseReads } from "@/db";
import { regattas, sailors, regattaResults } from "@/db/schema";
import {
  CACHE_TAG_FLEET_RANKINGS,
  CACHE_TAG_PUBLIC_REGATTAS,
  PUBLIC_DATA_REVALIDATE_SECONDS,
} from "@/lib/cacheTags";

/** Avoid invented totals when the database is unavailable. */
const FALLBACK_ATHLETES = "—";
const FALLBACK_REGATTAS = "—";

/**
 * Public sailor total. Counts of 100 or more floor to the nearest hundred
 * (890 → "800+") so the landing stat stays a round label as the roster grows.
 * Smaller finite counts still floor to the nearest ten.
 */
export function formatAthleteCount(countValue: number): string {
  if (!Number.isFinite(countValue) || countValue < 0) return FALLBACK_ATHLETES;
  if (countValue < 10) return String(Math.floor(countValue));
  if (countValue < 100) return `${Math.floor(countValue / 10) * 10}+`;
  return `${Math.floor(countValue / 100) * 100}+`;
}

export function formatRegattaCount(countValue: number): string {
  if (!Number.isFinite(countValue) || countValue < 0) return FALLBACK_REGATTAS;
  return String(Math.floor(countValue));
}

async function queryLandingTotals(): Promise<{
  athletes: string;
  regattas: string;
}> {
  const [sailorRow, regattaRow] = await withSequentialDatabaseReads([
    () => db.select({ value: count() }).from(sailors).then((rows) => rows[0]),
    () => db.select({ value: count() }).from(regattas).where(eq(regattas.status, "published")).then((rows) => rows[0]),
  ], { label: "landing.totals" });
  return {
    athletes: formatAthleteCount(Number(sailorRow?.value)),
    regattas: formatRegattaCount(Number(regattaRow?.value)),
  };
}

const getCachedLandingTotals = unstable_cache(
  queryLandingTotals,
  ["landing-totals-v2-published"],
  {
    revalidate: PUBLIC_DATA_REVALIDATE_SECONDS,
    tags: [CACHE_TAG_FLEET_RANKINGS, CACHE_TAG_PUBLIC_REGATTAS],
  }
);

export async function getLandingTotals(): Promise<{
  athletes: string;
  regattas: string;
}> {
  try {
    return await getCachedLandingTotals();
  } catch {
    return { athletes: FALLBACK_ATHLETES, regattas: FALLBACK_REGATTAS };
  }
}

/** Small aggregate for the displayed scorecards; official fleet size is not imported count. */
export const getLandingResultCounts = unstable_cache(
  async (ids: string[]): Promise<Record<string, number>> => {
    if (!ids.length) return {};
    const rows = await db.select({ id: regattaResults.regattaId, value: count() })
      .from(regattaResults).where(inArray(regattaResults.regattaId, ids)).groupBy(regattaResults.regattaId);
    return Object.fromEntries(rows.map((row) => [row.id, Number(row.value)]));
  },
  ["landing-result-counts-v1"],
  { revalidate: PUBLIC_DATA_REVALIDATE_SECONDS, tags: [CACHE_TAG_PUBLIC_REGATTAS] }
);
