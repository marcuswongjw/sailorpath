import { sql, ilike, or, and, eq, ne, desc, asc, type SQL } from "drizzle-orm";
import { db } from "@/db";
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

/**
 * Common Singapore school abbreviations to full school names.
 */
export const SCHOOL_ABBREVIATIONS: Record<string, string[]> = {
  ri: ["Raffles Institution", "RI"],
  rgs: ["Raffles Girls' School", "RGS", "Raffles Girls"],
  rgps: ["Raffles Girls' Primary School", "RGPS"],
  acs: ["Anglo-Chinese", "ACS"],
  acsi: ["Anglo-Chinese School (Independent)", "ACS(I)", "ACSI", "Anglo-Chinese"],
  acsp: ["Anglo-Chinese School (Primary)", "ACS(P)", "ACSP"],
  acsj: ["Anglo-Chinese School (Junior)", "ACS(J)", "ACSJ"],
  sji: ["St. Joseph's Institution", "St Joseph's Institution", "SJI", "St. Joseph"],
  sjij: ["St. Joseph's Institution Junior", "SJIJ", "SJI Junior"],
  tkgs: ["Tanjong Katong Girls' School", "TKGS"],
  tkps: ["Tanjong Katong Primary School", "TKPS"],
  ssp: ["Singapore Sports School", "Sports School", "SSP"],
  sst: ["School of Science and Technology", "SST"],
  nygh: ["Nanyang Girls' High School", "NYGH", "Nanyang Girls"],
  nyps: ["Nanyang Primary School", "NYPS"],
  mgs: ["Methodist Girls' School", "MGS"],
  scgs: ["Singapore Chinese Girls' School", "SCGS"],
  vs: ["Victoria School", "VS"],
  vjc: ["Victoria Junior College", "VJC"],
  dhs: ["Dunman High School", "Dunman High", "DHS"],
  hci: ["Hwa Chong Institution", "Hwa Chong", "HCI"],
  tns: ["Tao Nan School", "Tao Nan", "TNS"],
  chs: ["Catholic High School", "Catholic High", "CHS"],
  hihs: ["Holy Innocents' High School", "HIHS"],
  bgps: ["Bedok Green Primary School", "BGPS"],
  bgss: ["Bedok Green Secondary School", "BGSS"],
  uwc: ["United World College", "UWC", "UWCSEA"],
  uwcsea: ["United World College", "UWCSEA"],
  tts: ["Tanglin Trust School", "Tanglin Trust", "TTS"],
  sajs: ["St. Andrew's Junior School", "SAJS"],
  sass: ["St. Andrew's Secondary School", "SASS"],
};

export type ParsedSearchQuery = {
  raw: string;
  cleaned: string;
  tokens: string[];
  /** Numeric sail number extracted if present, e.g. '4652' or '224245' */
  extractedSailNumber: string | null;
  /** Country code prefix if present, e.g. 'SGP', 'SIN', 'HKG' */
  countryPrefix: string | null;
  /** Synonyms or expansions for clubs/schools */
  clubExpansions: string[];
  schoolExpansions: string[];
};

/**
 * Parses user search query to detect sail numbers, country codes, and club/school abbreviations.
 */
export function parseSearchQuery(query: string): ParsedSearchQuery {
  const raw = String(query || "").trim();
  const cleaned = raw.replace(/[^\w\s-]/g, " ").replace(/\s+/g, " ").trim();
  const tokens = cleaned.split(/\s+/).filter(Boolean);

  let extractedSailNumber: string | null = null;
  let countryPrefix: string | null = null;
  const clubExpansions: string[] = [];
  const schoolExpansions: string[] = [];

  // Check combined patterns like "SGP4652" or "SGP 4652" or "SIN-3133"
  const combinedMatch = raw.match(/^(?:(SGP|SIN|HKG|MAS|THA|AUS|USA|GBR|CAN|NZL|JPN|IND|MYA))[-_\s]*([0-9]{1,7})$/i);
  if (combinedMatch) {
    countryPrefix = combinedMatch[1].toUpperCase();
    extractedSailNumber = combinedMatch[2];
  } else {
    // Check individual tokens
    for (const token of tokens) {
      const lower = token.toLowerCase();
      // Pure digit sail number (1 to 7 digits)
      if (/^[0-9]{1,7}$/.test(token)) {
        extractedSailNumber = token;
      }
      // Country prefix token
      if (/^(SGP|SIN|HKG|MAS|THA|AUS|USA|GBR|CAN|NZL|JPN|IND|MYA)$/i.test(token)) {
        countryPrefix = token.toUpperCase();
      }
      // Club abbreviation
      if (CLUB_ABBREVIATIONS[lower]) {
        clubExpansions.push(...CLUB_ABBREVIATIONS[lower]);
      }
      // School abbreviation
      if (SCHOOL_ABBREVIATIONS[lower]) {
        schoolExpansions.push(...SCHOOL_ABBREVIATIONS[lower]);
      }
    }
  }

  return {
    raw,
    cleaned,
    tokens,
    extractedSailNumber,
    countryPrefix,
    clubExpansions: Array.from(new Set(clubExpansions)),
    schoolExpansions: Array.from(new Set(schoolExpansions)),
  };
}

export type SearchFilters = {
  query?: string;
  fleet?: "all" | "gold" | "silver" | "ilca" | "ilca4" | "guest" | string;
  squad?: "all" | "Nat A" | "Nat B" | "DS" | string;
  nationality?: string;
  club?: string;
  school?: string;
  birthYearFrom?: number;
  birthYearTo?: number;
  type?: "all" | "sailors" | "regattas";
  limit?: number;
};

export type SailorSearchResult = {
  id: string;
  name: string;
  handle: string;
  sailNumber: string;
  sailNumberIlca4: string | null;
  club: string;
  school: string | null;
  nationality: string | null;
  avatarUrl: string | null;
  gender: string | null;
  nationalSquadStatus: string | null;
  currentFleet: string | null;
  activeFleet: "Gold" | "Silver" | null;
  ilca4NationalList: boolean;
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
        ilike(sailors.school, tokenPattern),
        ilike(sailors.nationality, tokenPattern),
      ];

      // Also search ILCA 4 sail number column
      tokenOrs.push(ilike(sailors.sailNumberIlca4, tokenPattern));

      // Digit-only or clean pattern matching (strips spaces/hyphens in DB)
      if (cleanPattern && cleanPattern !== tokenPattern) {
        tokenOrs.push(
          sql`replace(replace(${sailors.sailNumber}, ' ', ''), '-', '') ILIKE ${cleanPattern}`,
          sql`replace(replace(coalesce(${sailors.sailNumberIlca4}, ''), ' ', ''), '-', '') ILIKE ${cleanPattern}`
        );
      }

      // If token is a country prefix like "SGP" or "SIN", don't reject Singapore sailors
      if (/^(SGP|SIN)$/i.test(token)) {
        tokenOrs.push(
          sql`${sailors.nationality} IS NULL`,
          ilike(sailors.nationality, "%Singapore%"),
          ilike(sailors.nationality, "%SGP%")
        );
      }

      // Expand club abbreviations (e.g. "CSC" matches "Changi Sailing Club")
      if (CLUB_ABBREVIATIONS[lower]) {
        for (const clubName of CLUB_ABBREVIATIONS[lower]) {
          tokenOrs.push(ilike(sailors.club, `%${clubName}%`));
        }
      }

      // Expand school abbreviations (e.g. "ACSI" matches "Anglo-Chinese School (Independent)")
      if (SCHOOL_ABBREVIATIONS[lower]) {
        for (const schoolName of SCHOOL_ABBREVIATIONS[lower]) {
          tokenOrs.push(ilike(sailors.school, `%${schoolName}%`));
        }
      }

      conditions.push(or(...tokenOrs)!);
    }

    // If an explicit sail number was extracted (e.g. "4652" from "SGP 4652"),
    // ensure candidates with that sail number are matched directly
    if (parsed.extractedSailNumber) {
      const numPattern = `%${parsed.extractedSailNumber}%`;
      conditions.push(
        or(
          ilike(sailors.sailNumber, numPattern),
          ilike(sailors.sailNumberIlca4, numPattern),
          sql`replace(replace(${sailors.sailNumber}, ' ', ''), '-', '') ILIKE ${numPattern}`,
          sql`replace(replace(coalesce(${sailors.sailNumberIlca4}, ''), ' ', ''), '-', '') ILIKE ${numPattern}`,
          // Also allow name match if someone has digits in handle or search
          ilike(sailors.name, numPattern)
        )!
      );
    }
  }

  // Explicit filter options
  if (f.squad && f.squad !== "all") {
    conditions.push(eq(sailors.nationalSquadStatus, f.squad));
  }
  if (f.nationality?.trim()) {
    conditions.push(ilike(sailors.nationality, `%${f.nationality.trim()}%`));
  }
  if (f.club?.trim()) {
    const clubLower = f.club.trim().toLowerCase();
    const clubExp = CLUB_ABBREVIATIONS[clubLower] || [f.club.trim()];
    conditions.push(or(...clubExp.map((c) => ilike(sailors.club, `%${c}%`)))!);
  }
  if (f.school?.trim()) {
    const schoolLower = f.school.trim().toLowerCase();
    const schoolExp = SCHOOL_ABBREVIATIONS[schoolLower] || [f.school.trim()];
    conditions.push(or(...schoolExp.map((s) => ilike(sailors.school, `%${s}%`)))!);
  }

  const queryBuilder = db.select().from(sailors);
  const rows = conditions.length > 0
    ? await queryBuilder.where(and(...conditions)).limit(150)
    : await queryBuilder.orderBy(asc(sailors.name)).limit(150);

  const period = currentPeriodFromSgToday();

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
      ilca4NationalList: row.ilca4NationalList,
      club: row.club,
      school: row.school,
      nationality: row.nationality,
      avatarUrl: row.avatarUrl,
      parentId: row.parentId,
      goldEntryDate: row.goldEntryDate,
      silverEntryDate: row.silverEntryDate,
      dropDate: row.dropDate,
      currentFleet: row.currentFleet,
      dob: row.dob,
      weight: row.weight,
      bio: row.bio,
      gender: row.gender,
      nationalSquadStatus: row.nationalSquadStatus,
    };

    const resolved = resolveSailorFleet(s, period);
    const activeFleet: "Gold" | "Silver" | null = resolved?.active
      ? (resolved.fleet as "Gold" | "Silver")
      : null;

    // Apply fleet filter
    const fleetFilter = (f.fleet || "all").toLowerCase();
    if (fleetFilter === "gold" && activeFleet !== "Gold") continue;
    if (fleetFilter === "silver" && activeFleet !== "Silver") continue;
    if ((fleetFilter === "ilca" || fleetFilter === "ilca4") && !row.ilca4NationalList && !row.sailNumberIlca4) {
      continue;
    }
    if (fleetFilter === "guest" && (isInSgSeries(s) && activeFleet != null)) continue;

    // Apply birth year filter
    if (f.birthYearFrom || f.birthYearTo) {
      if (!row.dob) continue;
      const y = new Date(row.dob).getFullYear();
      if (!Number.isFinite(y)) continue;
      if (f.birthYearFrom && y < f.birthYearFrom) continue;
      if (f.birthYearTo && y > f.birthYearTo) continue;
    }

    // Calculate Relevance Score
    let score = 0;
    const nameLower = row.name.toLowerCase();
    const sailClean = row.sailNumber.replace(/[^0-9]/g, "");
    const ilcaClean = (row.sailNumberIlca4 || "").replace(/[^0-9]/g, "");

    if (q) {
      // 1. Exact sail number match (very high priority)
      if (rawNum && (sailClean === rawNum || ilcaClean === rawNum)) {
        score += 1000;
      } else if (rawNum && (sailClean.endsWith(rawNum) || ilcaClean.endsWith(rawNum))) {
        score += 400;
      }

      // 2. Name matches
      if (nameLower === qLower) {
        score += 800;
      } else if (nameLower.startsWith(qLower)) {
        score += 500;
      } else if (nameLower.includes(qLower)) {
        score += 300;
      } else {
        // Individual tokens
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

      // 3. Club & School matches
      const clubLower = (row.club || "").toLowerCase();
      const schoolLower = (row.school || "").toLowerCase();

      for (const t of parsed.tokens) {
        const tLow = t.toLowerCase();
        if (clubLower.includes(tLow)) score += 60;
        if (schoolLower.includes(tLow)) score += 60;
      }

      for (const exp of parsed.clubExpansions) {
        if (clubLower.includes(exp.toLowerCase())) score += 120;
      }
      for (const exp of parsed.schoolExpansions) {
        if (schoolLower.includes(exp.toLowerCase())) score += 120;
      }
    } else {
      // Default score when browsing without query
      score = 10;
    }

    // Boost active sailors slightly so active competitors rank above inactive/guests
    if (activeFleet === "Gold") score += 50;
    else if (activeFleet === "Silver") score += 30;
    if (row.ilca4NationalList) score += 40;
    if (row.nationalSquadStatus) score += 25;

    scored.push({
      id: row.id,
      name: row.name,
      handle: row.handle,
      sailNumber: row.sailNumber,
      sailNumberIlca4: row.sailNumberIlca4,
      club: row.club,
      school: row.school,
      nationality: row.nationality,
      avatarUrl: row.avatarUrl,
      gender: row.gender,
      nationalSquadStatus: row.nationalSquadStatus,
      currentFleet: row.currentFleet,
      activeFleet,
      ilca4NationalList: row.ilca4NationalList,
      score,
    });
  }

  // Sort by score descending, then name ascending
  scored.sort((a, b) => b.score - a.score || a.name.localeCompare(b.name));

  const maxResults = f.limit || 60;
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
