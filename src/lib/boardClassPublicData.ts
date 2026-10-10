import "server-only";

import { eq, or, sql } from "drizzle-orm";
import { db, ensureCoreSchema } from "@/db";
import { techno293Regattas, wingfoilRegattas } from "@/db/schema";
import {
  BOARD_CLASS_KEYS,
  boardClassSourceCounts,
  mergeBoardClassResultRows,
  type BoardClassKey,
} from "@/lib/boardClassHub";
import {
  getClassRegattas,
  getNormalizedClassRegattas,
  getPublishedScorecardRegattas,
  type PublicClassRegattaRow,
} from "@/lib/publicDataLoader";
import { getCachedPublicRegattas } from "@/lib/queries";
import {
  SINGAPORE_TECHNO293_REGATTAS,
  parseTechno293RegattaDate,
  sortTechno293Regattas,
  type Techno293Regatta,
} from "@/lib/techno293";
import {
  SINGAPORE_WINGFOIL_REGATTAS,
  parseWingfoilRegattaDate,
  sortWingfoilRegattas,
  type WingfoilRegatta,
} from "@/lib/wingfoil";

type SpecialistBoardRegatta = WingfoilRegatta | Techno293Regatta;

export type BoardClassSpecialistRegattas = {
  wingfoil: WingfoilRegatta[];
  techno293: Techno293Regatta[];
  iqfoil: [];
};

function mergeWithSeed<T extends SpecialistBoardRegatta>(
  seed: readonly T[],
  rows: readonly T[],
  sort: (records: T[]) => T[]
): T[] {
  const byId = new Map(rows.map((row) => [row.id, row]));
  const merged: T[] = [];
  const visited = new Set<string>();

  for (const record of seed) {
    merged.push(byId.get(record.id) || record);
    visited.add(record.id);
  }
  for (const record of rows) {
    if (!visited.has(record.id)) merged.push(record);
  }
  return sort(merged);
}

async function loadPublishedSpecialistScorecards(
  key: Extract<BoardClassKey, "wingfoil" | "techno293">
): Promise<SpecialistBoardRegatta[]> {
  try {
    if (typeof ensureCoreSchema === "function") await ensureCoreSchema();

    if (key === "wingfoil") {
      const rows = await db
        .select()
        .from(wingfoilRegattas)
        .where(
          or(
            eq(wingfoilRegattas.status, "published"),
            sql`${wingfoilRegattas.status} IS NULL`
          )
        );
      return mergeWithSeed(
        SINGAPORE_WINGFOIL_REGATTAS,
        rows.map((row) => row.data as WingfoilRegatta),
        sortWingfoilRegattas
      );
    }

    const rows = await db
      .select()
      .from(techno293Regattas)
      .where(
        or(
          eq(techno293Regattas.status, "published"),
          sql`${techno293Regattas.status} IS NULL`
        )
      );
    return mergeWithSeed(
      SINGAPORE_TECHNO293_REGATTAS,
      rows.map((row) => row.data as Techno293Regatta),
      sortTechno293Regattas
    );
  } catch (error) {
    console.warn(
      `[boardClassPublicData] Unable to load ${key} specialist scorecards; using verified bundled records.`,
      error
    );
    return key === "wingfoil"
      ? sortWingfoilRegattas(SINGAPORE_WINGFOIL_REGATTAS)
      : sortTechno293Regattas(SINGAPORE_TECHNO293_REGATTAS);
  }
}

export type PublicBoardClassData<K extends BoardClassKey = BoardClassKey> = {
  key: K;
  publishedRows: PublicClassRegattaRow[];
  calendarRows: PublicClassRegattaRow[];
  sourceCounts: ReturnType<typeof boardClassSourceCounts>;
  specialistRegattas: BoardClassSpecialistRegattas[K];
};

/**
 * Public projection for all board/foil class pages.
 *
 * Normalized class sheets are the canonical path. WingFoil and Techno 293 also
 * retain historical specialist scorecards until an explicit reconciliation has
 * linked them to canonical sheets. Both sources are shown with provenance.
 */
export async function loadPublicBoardClassData<K extends BoardClassKey>(
  key: K
): Promise<PublicBoardClassData<K>> {
  if (!BOARD_CLASS_KEYS.includes(key)) {
    throw new Error(`Unsupported board class: ${key}`);
  }

  let canonicalRows: PublicClassRegattaRow[] = [];
  try {
    const regattas = await getCachedPublicRegattas();
    canonicalRows = getNormalizedClassRegattas(key, regattas);
  } catch (error) {
    console.warn(
      `[boardClassPublicData] Unable to load canonical ${key} class sheets.`,
      error
    );
  }

  const specialistRegattas: SpecialistBoardRegatta[] =
    key === "iqfoil" ? [] : await loadPublishedSpecialistScorecards(key);
  const specialistRows =
    key === "iqfoil"
      ? []
      : getPublishedScorecardRegattas(
          key,
          specialistRegattas,
          key === "wingfoil"
            ? { parseDate: parseWingfoilRegattaDate }
            : { parseDate: parseTechno293RegattaDate }
        );
  const publishedRows = mergeBoardClassResultRows(canonicalRows, specialistRows);

  return {
    key,
    publishedRows,
    calendarRows: getClassRegattas(key),
    sourceCounts: boardClassSourceCounts(publishedRows),
    specialistRegattas: specialistRegattas as BoardClassSpecialistRegattas[K],
  };
}
