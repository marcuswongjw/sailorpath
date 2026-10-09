import { count } from "drizzle-orm";
import { db } from "@/db";
import { regattas, sailors } from "@/db/schema";

/** Shown when the database is unavailable. Public sailor total, floored to the hundred. */
const FALLBACK_ATHLETES = "800+";
const FALLBACK_REGATTAS = "130";

/**
 * Public sailor total. Counts of 100 or more floor to the nearest hundred
 * (890 → "800+") so the landing stat stays a round label as the roster grows.
 * Smaller finite counts still floor to the nearest ten.
 */
export function formatAthleteCount(countValue: number): string {
  if (!Number.isFinite(countValue) || countValue < 10) return FALLBACK_ATHLETES;
  if (countValue < 100) return `${Math.floor(countValue / 10) * 10}+`;
  return `${Math.floor(countValue / 100) * 100}+`;
}

export function formatRegattaCount(countValue: number): string {
  if (!Number.isFinite(countValue) || countValue < 1) return FALLBACK_REGATTAS;
  return String(Math.floor(countValue));
}

export async function getLandingTotals(): Promise<{
  athletes: string;
  regattas: string;
}> {
  try {
    const [sailorRow, regattaRow] = await Promise.all([
      db.select({ value: count() }).from(sailors).then((rows) => rows[0]),
      db.select({ value: count() }).from(regattas).then((rows) => rows[0]),
    ]);
    return {
      athletes: formatAthleteCount(Number(sailorRow?.value)),
      regattas: formatRegattaCount(Number(regattaRow?.value)),
    };
  } catch {
    return { athletes: FALLBACK_ATHLETES, regattas: FALLBACK_REGATTAS };
  }
}
