import { eventMatchesQuery } from "@/lib/eventSearch";
import { resultCoverageLabel, resultSourceStatus } from "@/lib/resultCardStatus";
import { unstable_cache } from "next/cache";
import { asc } from "drizzle-orm";
import { db, withDatabaseRetry } from "@/db";
import {
  CACHE_TAG_FLEET_RANKINGS,
  PUBLIC_DATA_REVALIDATE_SECONDS,
} from "@/lib/cacheTags";
import { sailors } from "@/db/schema";
import { getCachedPublicRegattas } from "@/lib/queries";
import { currentPeriodFromSgToday } from "@/lib/datesSg";
import { resolveSailorFleet, type SailorRecord } from "@/lib/ranking";
import { isInSgSeries } from "@/lib/seriesMembership";
import { classResultsHref } from "@/lib/calendar/calendarResultLinks";

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
  coverageLabel?: string | null;
  sourceStatus?: string | null;
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
 * The cached payload is the complete anonymous directory allow-list. It is
 * intentionally limited to discovery fields—never consent flags, school,
 * date of birth, measurements, squad status, equipment, or relationship data.
 */
export type PublicSearchDirectoryRow = {
  id: string;
  name: string;
  handle: string;
  sailNumber: string;
  sailNumberIlca4: string | null;
  boardNumber: string | null;
  ilca4NationalList: boolean | null;
  club: string;
  nationality: string | null;
  goldEntryDate: string | null;
  silverEntryDate: string | null;
  dropDate: string | null;
  currentFleet: string | null;
};

/**
 * One minimal roster read per revalidation window. Public filters run against
 * the same privacy-safe cache rather than issuing an additional database query
 * on each search request.
 */
const getCachedSearchSailorDirectory = unstable_cache(
  async (): Promise<PublicSearchDirectoryRow[]> =>
    withDatabaseRetry(() =>
      db.select(searchSailorColumns).from(sailors).orderBy(asc(sailors.name))
    ),
  ["public-sailor-search-directory-v2"],
  {
    revalidate: PUBLIC_DATA_REVALIDATE_SECONDS,
    tags: [CACHE_TAG_FLEET_RANKINGS],
  }
);

function includesFolded(value: string | null | undefined, query: string): boolean {
  return Boolean(value && query && value.toLowerCase().includes(query.toLowerCase()));
}

function compactSailNumber(value: string | null | undefined): string {
  return (value || "").replace(/[\s-]/g, "").toLowerCase();
}

function tokenMatchesPublicSearch(row: PublicSearchDirectoryRow, token: string): boolean {
  if (
    includesFolded(row.name, token) ||
    includesFolded(row.handle, token) ||
    includesFolded(row.sailNumber, token) ||
    includesFolded(row.sailNumberIlca4, token) ||
    includesFolded(row.boardNumber, token) ||
    includesFolded(row.club, token) ||
    includesFolded(row.nationality, token)
  ) {
    return true;
  }

  const compactToken = token.replace(/[^a-zA-Z0-9]/g, "").toLowerCase();
  if (
    compactToken &&
    (compactSailNumber(row.sailNumber).includes(compactToken) ||
      compactSailNumber(row.sailNumberIlca4).includes(compactToken) ||
      compactSailNumber(row.boardNumber).includes(compactToken))
  ) {
    return true;
  }

  if (/^(sgp|sin)$/i.test(token)) {
    return (
      !row.nationality ||
      includesFolded(row.nationality, "singapore") ||
      includesFolded(row.nationality, "sgp")
    );
  }

  const clubNames = CLUB_ABBREVIATIONS[token.toLowerCase()];
  return Boolean(clubNames?.some((club) => includesFolded(row.club, club)));
}

function matchesSailNumber(row: PublicSearchDirectoryRow, sailNumber: string): boolean {
  const normalized = sailNumber.toLowerCase();
  return (
    includesFolded(row.sailNumber, normalized) ||
    includesFolded(row.sailNumberIlca4, normalized) ||
    includesFolded(row.boardNumber, normalized) ||
    includesFolded(row.name, normalized) ||
    compactSailNumber(row.sailNumber).includes(normalized) ||
    compactSailNumber(row.sailNumberIlca4).includes(normalized) ||
    compactSailNumber(row.boardNumber).includes(normalized)
  );
}

/** Applies only the public directory filters to the cached allow-list. */
export function sailorMatchesPublicSearch(
  row: PublicSearchDirectoryRow,
  filters: SearchFilters,
  parsed: ParsedSearchQuery
): boolean {
  if (parsed.tokens.some((token) => !tokenMatchesPublicSearch(row, token))) {
    return false;
  }
  if (parsed.extractedSailNumber && !matchesSailNumber(row, parsed.extractedSailNumber)) {
    return false;
  }
  if (filters.nationality?.trim() && !includesFolded(row.nationality, filters.nationality.trim())) {
    return false;
  }
  if (filters.club?.trim()) {
    const value = filters.club.trim();
    const alternatives = CLUB_ABBREVIATIONS[value.toLowerCase()] || [value];
    if (!alternatives.some((club) => includesFolded(row.club, club))) return false;
  }
  return true;
}

/** Searches sailors with token parsing, synonym expansions, and relevance scoring. */
export async function searchSailorsEnhanced(
  filters: string | SearchFilters
): Promise<SailorSearchResult[]> {
  const f: SearchFilters =
    typeof filters === "string" ? { query: filters } : filters || {};
  const q = (f.query || "").trim();
  const parsed = parseSearchQuery(q);
  const period = currentPeriodFromSgToday();
  const rows = await getCachedSearchSailorDirectory();

  // Map and score
  const scored: SailorSearchResult[] = [];
  const qLower = q.toLowerCase();
  const rawNum = parsed.extractedSailNumber;

  for (const row of rows) {
    if (!sailorMatchesPublicSearch(row, f, parsed)) continue;

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

  return limitSearchResults(scored, f.limit);
}

/**
 * An omitted limit returns the full public roster. Callers that want a short
 * list, such as quick search, pass an explicit limit. The directory must not
 * default to a cap: the homepage sailor figure counts this same roster.
 */
export function limitSearchResults<T>(rows: readonly T[], limit?: number): T[] {
  if (limit == null || !Number.isFinite(limit)) return [...rows];
  return rows.slice(0, Math.max(0, Math.floor(limit)));
}

/**
 * Searches regattas and events by title, venue, boatClass, division, organizer.
 */
export async function searchRegattasEnhanced(query: string, limit = 15): Promise<RegattaSearchResult[]> {
  const q = String(query || "").trim().toLowerCase();
  if (!q) return [];

  const tokens = q.split(/\s+/).filter(Boolean);

  // Reuse the published-only cache. Draft and in-review sheets never enter
  // the public search candidate set, and static ILCA sheets are merged by the
  // shared loader.
  const candidates = await getCachedPublicRegattas();

  const results: RegattaSearchResult[] = [];

  for (const reg of candidates) {
    if (!eventMatchesQuery(reg, q)) continue;
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
    for (const t of tokens) {
      if (
        nameLower.includes(t) ||
        venueLower.includes(t) ||
        boatLower.includes(t) ||
        divLower.includes(t) ||
        slugLower.includes(t)
      ) {
        score += 50;
      }
    }

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
      coverageLabel: reg.importedEntryCount ? resultCoverageLabel(reg) : null,
      sourceStatus: reg.importedEntryCount ? resultSourceStatus(reg) : null,
      href: classResultsHref(reg),
      score,
    });
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
