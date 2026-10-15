import { unstable_cache } from "next/cache";
import { sql, ilike, or, and, eq, ne, desc, asc, type SQL } from "drizzle-orm";
import { db } from "@/db";
import {
  CACHE_TAG_FLEET_RANKINGS,
  PUBLIC_DATA_REVALIDATE_SECONDS,
} from "@/lib/cacheTags";
import { sailors, regattas } from "@/db/schema";
import { currentPeriodFromSgToday } from "@/lib/datesSg";
import { resolveSailorFleet, type SailorRecord, type RegattaRecord } from "@/lib/ranking";
import { isInSgSeries } from "@/lib/seriesMembership";
import { classResultsHref } from "@/lib/calendar/calendarResultLinks";
import { ILCA6_STATIC_REGATTAS } from "@/lib/ilca6ResultsData";

/**
 * Common Singapore sailing club abbreviations to official club names.
 */
export const CLUB_ABBREVIATIONS: Record<string, string[]> = {
  csc: ["Changi Sailing Club", "CSC"],
  saf: ["SAF Yacht Club", "SAFYC", "SAF"],
  safyc: ["SAF Yacht Club", "SAFYC"],
  nsc: ["National Sailing Centre", "Singapore Sailing", "NSC"],
  ssf: ["Singapore Sailing Federation", "National Sailing Centre", "SSF"],
  cw: ["Constant Wind", "CW"],
  rsyc: ["Republic of Singapore Yacht Club", "RSYC"],
  assc: ["ASSC"],
  was: ["WAS"],
  rm: ["Raffles Marina"],
  tbsa: ["Tracey Boating Sailing Association", "TBSA"],
};

export type ParsedSearchQuery = {
  raw: string;
  cleaned: string;
  tokens: string[];
  /** Numeric sail number extracted if present, e.g. '4652' or '224245' */
  extractedSailNumber: string | null;
  /** Country code prefix if present, e.g. 'SGP', 'SIN', 'HKG' */
  countryPrefix: string | null;
  /** Synonyms or expansions for public club fields only. */
  clubExpansions: string[];
};

/**
 * Parses user search query to detect sail numbers, country codes and club abbreviations.
 */
export function parseSearchQuery(query: string): ParsedSearchQuery {
  const raw = String(query || "").trim();
  const cleaned = raw.replace(/[^\w\s-]/g, " ").replace(/\s+/g, " ").trim();
  const tokens = cleaned.split(/\s+/).filter(Boolean);

  let extractedSailNumber: string | null = null;
  let countryPrefix: string | null = null;
  const clubExpansions: string[] = [];

  // Check combined patterns like "SGP4652" or "SGP 4652" or "SIN-3133"
  const combinedMatch = raw.match(/(SGP|SIN|HKG|MAS|THA|AUS|USA|GBR|CAN|NZL|JPN|IND|MYA)[-_\s]*([0-9]{1,7})/i);
  if (combinedMatch) {
    countryPrefix = combinedMatch[1].toUpperCase();
    extractedSailNumber = combinedMatch[2];
  }
  // Check individual tokens as well so a combined sail number does not hide
  // other terms such as a club abbreviation.
  for (const token of tokens) {
    const lower = token.toLowerCase();
    if (!combinedMatch) {
      // Pure digit sail number (1 to 7 digits)
      if (/^[0-9]{1,7}$/.test(token)) {
        extractedSailNumber = token;
      }
      // Country prefix token
      if (/^(SGP|SIN|HKG|MAS|THA|AUS|USA|GBR|CAN|NZL|JPN|IND|MYA)$/i.test(token)) {
        countryPrefix = token.toUpperCase();
      }
    }
    // Club abbreviation
    if (CLUB_ABBREVIATIONS[lower]) {
      clubExpansions.push(...CLUB_ABBREVIATIONS[lower]);
    }
  }

  return {
    raw,
    cleaned,
    tokens,
    extractedSailNumber,
    countryPrefix,
    clubExpansions: Array.from(new Set(clubExpansions)),
  };
}

export type SearchFilters = {
  query?: string;
  fleet?: "all" | "gold" | "silver" | "ilca" | "ilca4" | "guest" | string;
  nationality?: string;
  club?: string;
  type?: "all" | "sailors" | "regattas";
  limit?: number;
};

export type SailorSearchResult = {
  id: string;
  name: string;
  handle: string;
  sailNumber: string;
  sailNumberIlca4: string | null;
  boardNumber: string | null;
  club: string;
  nationality: string | null;
  activeFleet: "Gold" | "Silver" | null;
  score: number;
};

export type RegattaSearchResult = {
  id: string;
  name: string;
  slug: string;
  date: string;
  endDate?: string | null;
  venue?: string | null;
  boatClass: string;
  division?: string | null;
  raceCount?: number | null;
  totalFleetSize?: number | null;
  href: string;
  score: number;
};

export type UnifiedSearchResult = {
  sailors: SailorSearchResult[];
  regattas: RegattaSearchResult[];
  total: number;
};

/** Columns the search scorer reads. Omits journey, equipment, and history text. */
const searchSailorColumns = {
  id: sailors.id,
  name: sailors.name,
  handle: sailors.handle,
  sailNumber: sailors.sailNumber,
  sailNumberIlca4: sailors.sailNumberIlca4,
  boardNumber: sailors.boardNumber,
  ilca4NationalList: sailors.ilca4NationalList,
  club: sailors.club,
  nationality: sailors.nationality,
  goldEntryDate: sailors.goldEntryDate,
  silverEntryDate: sailors.silverEntryDate,
  dropDate: sailors.dropDate,
  currentFleet: sailors.currentFleet,
};

/**
 * Unfiltered directory (the /search page and empty /api/search). Filtered
 * queries stay in SQL so they do not pull the whole roster.
 */
const getCachedSearchSailorDirectory = unstable_cache(
  async () =>
    db.select(searchSailorColumns).from(sailors).orderBy(asc(sailors.name)),
  ["public-sailor-search-directory-v1"],
  {
    revalidate: PUBLIC_DATA_REVALIDATE_SECONDS,
    tags: [CACHE_TAG_FLEET_RANKINGS],
  }
);

/**
 * Searches sailors with token parsing, synonym expansions, and relevance scoring.
 */
export async function searchSailorsEnhanced(
  filters: string | SearchFilters
): Promise<SailorSearchResult[]> {
  const f: SearchFilters =
    typeof filters === "string" ? { query: filters } : filters || {};
  const q = (f.query || "").trim();
  const parsed = parseSearchQuery(q);
  const period = currentPeriodFromSgToday();
  const pEndStr = period.half === "Jan-Jun" ? `${period.year}-06-30` : `${period.year}-12-31`;

  const conditions: SQL[] = [];

  if (parsed.tokens.length > 0) {
    for (const token of parsed.tokens) {
      const lower = token.toLowerCase();
      const tokenPattern = `%${token}%`;
      const alphanumeric = token.replace(/[^a-zA-Z0-9]/g, "");
      const cleanPattern = alphanumeric ? `%${alphanumeric}%` : null;

      const tokenOrs: SQL[] = [
        ilike(sailors.name, tokenPattern),
        ilike(sailors.sailNumber, tokenPattern),
        ilike(sailors.club, tokenPattern),
        ilike(sailors.handle, tokenPattern),
        ilike(sailors.nationality, tokenPattern),
      ];

      tokenOrs.push(ilike(sailors.sailNumberIlca4, tokenPattern));
      tokenOrs.push(ilike(sailors.boardNumber, tokenPattern));

      if (cleanPattern && cleanPattern !== tokenPattern) {
        tokenOrs.push(
          sql`replace(replace(${sailors.sailNumber}, ' ', ''), '-', '') ILIKE ${cleanPattern}`,
          sql`replace(replace(coalesce(${sailors.sailNumberIlca4}, ''), ' ', ''), '-', '') ILIKE ${cleanPattern}`,
          sql`replace(replace(coalesce(${sailors.boardNumber}, ''), ' ', ''), '-', '') ILIKE ${cleanPattern}`
        );
      }

      if (/^(SGP|SIN)$/i.test(token)) {
        tokenOrs.push(
          sql`${sailors.nationality} IS NULL`,
          ilike(sailors.nationality, "%Singapore%"),
          ilike(sailors.nationality, "%SGP%")
        );
      }

      if (CLUB_ABBREVIATIONS[lower]) {
        for (const clubName of CLUB_ABBREVIATIONS[lower]) {
          tokenOrs.push(ilike(sailors.club, `%${clubName}%`));
        }
      }

      conditions.push(or(...tokenOrs)!);
    }

    if (parsed.extractedSailNumber) {
      const numPattern = `%${parsed.extractedSailNumber}%`;
      conditions.push(
        or(
          ilike(sailors.sailNumber, numPattern),
          ilike(sailors.sailNumberIlca4, numPattern),
          ilike(sailors.boardNumber, numPattern),
          sql`replace(replace(${sailors.sailNumber}, ' ', ''), '-', '') ILIKE ${numPattern}`,
          sql`replace(replace(coalesce(${sailors.sailNumberIlca4}, ''), ' ', ''), '-', '') ILIKE ${numPattern}`,
          sql`replace(replace(coalesce(${sailors.boardNumber}, ''), ' ', ''), '-', '') ILIKE ${numPattern}`,
          ilike(sailors.name, numPattern)
        )!
      );
    }
  }

  // Public directory filters; schools, squads, DOB and other private fields
  // intentionally have no query path here.
  if (f.nationality?.trim()) {
    conditions.push(ilike(sailors.nationality, `%${f.nationality.trim()}%`));
  }
  if (f.club?.trim()) {
    const clubLower = f.club.trim().toLowerCase();
    const clubExp = CLUB_ABBREVIATIONS[clubLower] || [f.club.trim()];
    conditions.push(or(...clubExp.map((c) => ilike(sailors.club, `%${c}%`)))!);
  }

  // Fleet filtering in SQL
  const fleetFilter = (f.fleet || "all").toLowerCase();
  if (fleetFilter !== "all") {
    if (fleetFilter === "gold") {
      conditions.push(
        and(
          ne(sailors.currentFleet, "Guest"),
          sql`${sailors.goldEntryDate} <= ${pEndStr}`,
          or(sql`${sailors.dropDate} IS NULL`, sql`${sailors.dropDate} > ${pEndStr}`)
        )!
      );
    } else if (fleetFilter === "silver") {
      conditions.push(
        and(
          ne(sailors.currentFleet, "Guest"),
          or(sql`${sailors.goldEntryDate} IS NULL`, sql`${sailors.goldEntryDate} > ${pEndStr}`),
          or(sql`${sailors.silverEntryDate} <= ${pEndStr}`, sql`${sailors.goldEntryDate} <= ${pEndStr}`),
          or(sql`${sailors.dropDate} IS NULL`, sql`${sailors.dropDate} > ${pEndStr}`)
        )!
      );
    } else if (fleetFilter === "ilca" || fleetFilter === "ilca4") {
      conditions.push(
        or(
          eq(sailors.ilca4NationalList, true),
          sql`${sailors.sailNumberIlca4} is not null and ${sailors.sailNumberIlca4} <> ''`
        )!
      );
    } else if (fleetFilter === "guest") {
      conditions.push(
        or(
          eq(sailors.currentFleet, "Guest"),
          and(
            ne(sailors.currentFleet, "Guest"),
            // Not eligible for Gold or Silver
            or(
              sql`${sailors.goldEntryDate} IS NULL and ${sailors.silverEntryDate} IS NULL`,
              sql`${sailors.dropDate} <= ${pEndStr}`
            )
          )!
        )!
      );
    }
  }

  const dbLimit = f.limit ? Math.max(f.limit * 2, 500) : 1500;
  const rows =
    conditions.length > 0
      ? await db
          .select(searchSailorColumns)
          .from(sailors)
          .where(and(...conditions))
          .limit(dbLimit)
      : (await getCachedSearchSailorDirectory()).slice(0, dbLimit);

  // Map and score
  const scored: SailorSearchResult[] = [];
  const qLower = q.toLowerCase();
  const rawNum = parsed.extractedSailNumber;

  for (const row of rows) {
    const s: SailorRecord = {
      id: row.id,
      name: row.name,
      handle: row.handle,
      sailNumber: row.sailNumber,
      sailNumberIlca4: row.sailNumberIlca4,
      boardNumber: row.boardNumber,
      ilca4NationalList: row.ilca4NationalList,
      club: row.club,
      school: null,
      nationality: row.nationality,
      avatarUrl: null,
      parentId: null,
      goldEntryDate: row.goldEntryDate,
      silverEntryDate: row.silverEntryDate,
      dropDate: row.dropDate,
      currentFleet: row.currentFleet,
      dob: null,
      weight: null,
      bio: null,
      gender: null,
      nationalSquadStatus: null,
    };

    const resolved = resolveSailorFleet(s, period);
    const activeFleet: "Gold" | "Silver" | null = resolved?.active
      ? (resolved.fleet as "Gold" | "Silver")
      : null;

    // Re-verify fleet filter in JS for absolute correctness (now it's just a safety check)
    const fleetFilterCheck = (f.fleet || "all").toLowerCase();
    if (fleetFilterCheck === "gold" && activeFleet !== "Gold") continue;
    if (fleetFilterCheck === "silver" && activeFleet !== "Silver") continue;
    if ((fleetFilterCheck === "ilca" || fleetFilterCheck === "ilca4") && !row.ilca4NationalList && !row.sailNumberIlca4) {
      continue;
    }
    if (fleetFilterCheck === "guest" && (isInSgSeries(s) && activeFleet != null)) continue;

    // Calculate Relevance Score
    let score = 0;
    const nameLower = row.name.toLowerCase();
    const sailClean = row.sailNumber.replace(/[^0-9]/g, "");
    const ilcaClean = (row.sailNumberIlca4 || "").replace(/[^0-9]/g, "");
    const boardClean = (row.boardNumber || "").replace(/[^0-9]/g, "");

    if (q) {
      if (rawNum && (sailClean === rawNum || ilcaClean === rawNum || boardClean === rawNum)) {
        score += 1000;
      } else if (
        rawNum &&
        (sailClean.endsWith(rawNum) ||
          ilcaClean.endsWith(rawNum) ||
          boardClean.endsWith(rawNum))
      ) {
        score += 400;
      }

      if (nameLower === qLower) {
        score += 800;
      } else if (nameLower.startsWith(qLower)) {
        score += 500;
      } else if (nameLower.includes(qLower)) {
        score += 300;
      } else {
        let allTokensInName = true;
        for (const t of parsed.tokens) {
          if (nameLower.includes(t.toLowerCase())) {
            score += 80;
          } else {
            allTokensInName = false;
          }
        }
        if (allTokensInName && parsed.tokens.length > 1) {
          score += 200;
        }
      }

      const clubLower = (row.club || "").toLowerCase();

      for (const t of parsed.tokens) {
        const tLow = t.toLowerCase();
        if (clubLower.includes(tLow)) score += 60;
      }

      for (const exp of parsed.clubExpansions) {
        if (clubLower.includes(exp.toLowerCase())) score += 120;
      }
    } else {
      score = 10;
    }

    if (activeFleet === "Gold") score += 50;
    else if (activeFleet === "Silver") score += 30;
    if (row.ilca4NationalList) score += 40;

    scored.push({
      id: row.id,
      name: row.name,
      handle: row.handle,
      sailNumber: row.sailNumber,
      sailNumberIlca4: row.sailNumberIlca4,
      boardNumber: row.boardNumber,
      club: row.club,
      nationality: row.nationality,
      activeFleet,
      score,
    });
  }

  scored.sort((a, b) => b.score - a.score || a.name.localeCompare(b.name));

  const maxResults = f.limit ?? 500;
  return scored.slice(0, maxResults);
}

/**
 * Searches regattas and events by title, venue, boatClass, division, organizer.
 */
export async function searchRegattasEnhanced(query: string, limit = 15): Promise<RegattaSearchResult[]> {
  const q = String(query || "").trim().toLowerCase();
  if (!q) return [];

  const tokens = q.split(/\s+/).filter(Boolean);

  const base = db.select().from(regattas);
  const rows = await base
    .where(or(ne(regattas.status, "archived"), sql`${regattas.status} IS NULL`))
    .orderBy(desc(regattas.date))
    .limit(100);

  const candidates: RegattaRecord[] = rows.map((r): RegattaRecord => ({
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
    venue: r.venue,
    endDate: r.endDate,
    norUrl: r.norUrl,
    registrationUrl: r.registrationUrl,
    isSelectionTrial: r.isSelectionTrial ?? false,
    organizer: r.organizer,
    scheduleNotes: r.scheduleNotes,
  }));

  for (const staticReg of ILCA6_STATIC_REGATTAS) {
    if (!candidates.some((m) => m.slug.toLowerCase() === staticReg.slug.toLowerCase())) {
      candidates.push(staticReg);
    }
  }

  const results: RegattaSearchResult[] = [];

  for (const reg of candidates) {
    const nameLower = (reg.name || "").toLowerCase();
    const venueLower = (reg.venue || "").toLowerCase();
    const boatLower = (reg.boatClass || "").toLowerCase();
    const divLower = (reg.division || "").toLowerCase();
    const slugLower = (reg.slug || "").toLowerCase();

    let score = 0;

    // Exact or phrase match
    if (nameLower.includes(q)) score += 300;
    if (slugLower.includes(q)) score += 200;
    if (venueLower.includes(q)) score += 150;
    if (boatLower.includes(q)) score += 100;
    if (divLower.includes(q)) score += 80;

    // Token matches
    let tokenMatches = 0;
    for (const t of tokens) {
      if (
        nameLower.includes(t) ||
        venueLower.includes(t) ||
        boatLower.includes(t) ||
        divLower.includes(t) ||
        slugLower.includes(t)
      ) {
        score += 50;
        tokenMatches++;
      }
    }

    if (score > 0 || tokenMatches === tokens.length) {
      results.push({
        id: reg.id,
        name: reg.name,
        slug: reg.slug,
        date: reg.date,
        endDate: reg.endDate,
        venue: reg.venue,
        boatClass: reg.boatClass ?? "Optimist",
        division: reg.division,
        raceCount: reg.raceCount,
        totalFleetSize: reg.totalFleetSize,
        href: classResultsHref(reg),
        score,
      });
    }
  }

  results.sort((a, b) => b.score - a.score || b.date.localeCompare(a.date));
  return results.slice(0, limit);
}

/**
 * Unified search combining sailors and regattas.
 */
export async function unifiedSearch(
  query: string,
  filters: Omit<SearchFilters, "query"> = {}
): Promise<UnifiedSearchResult> {
  const [sailorsRes, regattasRes] = await Promise.all([
    filters.type !== "regattas"
      ? searchSailorsEnhanced({ ...filters, query })
      : Promise.resolve([]),
    filters.type !== "sailors" && query.trim()
      ? searchRegattasEnhanced(query)
      : Promise.resolve([]),
  ]);

  return {
    sailors: sailorsRes,
    regattas: regattasRes,
    total: sailorsRes.length + regattasRes.length,
  };
}
