import "server-only";

import { and, asc, count, eq, inArray } from "drizzle-orm";
import { db } from "@/db";
import {
  asianOptimistIndexEvents,
  asianOptimistIndexResults,
  regattaResults,
  regattas,
  sailors,
} from "@/db/schema";
import {
  createAsianOptimistIndexBaseline,
  type AsianOptimistIndexEntry,
} from "@/lib/asianOptimistIndex";
import {
  ASIAN_OPTIMIST_INDEX_2026_QUALIFIERS,
  type AsianOptimistIndexQualifierSource,
} from "@/lib/asianOptimistIndexQualifiers";

const NOC_BY_NATIONALITY: Record<string, string> = {
  azerbaijan: "AZE",
  aze: "AZE",
  china: "CHN",
  chn: "CHN",
  "hong kong": "HKG",
  hkg: "HKG",
  india: "IND",
  ind: "IND",
  japan: "JPN",
  jpn: "JPN",
  "south korea": "KOR",
  korea: "KOR",
  kor: "KOR",
  "saudi arabia": "KSA",
  ksa: "KSA",
  kuwait: "KUW",
  kuw: "KUW",
  macau: "MAC",
  mac: "MAC",
  malaysia: "MAS",
  mas: "MAS",
  myanmar: "MYA",
  mya: "MYA",
  oman: "OMA",
  oma: "OMA",
  qatar: "QAT",
  qat: "QAT",
  singapore: "SGP",
  sgp: "SGP",
  "sri lanka": "SRI",
  sri: "SRI",
  thailand: "THA",
  tha: "THA",
  "united arab emirates": "UAE",
  uae: "UAE",
};

function normalizeName(value: string): string {
  return value.toLowerCase().replace(/[^a-z0-9]/g, "");
}

function toNoc(value: string | null): string | null {
  if (!value) return null;
  const normalized = value.trim().toLowerCase().replace(/\s+/g, " ");
  return NOC_BY_NATIONALITY[normalized] ?? null;
}

function publicBirthYear(dob: string | null): number | null {
  if (!dob) return null;
  const match = /^(\d{4})-/.exec(dob);
  return match ? Number(match[1]) : null;
}

/**
 * Merges only public, high-confidence SailorPath matches into the official
 * result baseline. The IODA result and entry pages do not publish birth dates.
 */
export async function getAsianOptimistIndexEntries(): Promise<
  AsianOptimistIndexEntry[]
> {
  const baseline = createAsianOptimistIndexBaseline();

  try {
    const profiles = await db
      .select({
        name: sailors.name,
        handle: sailors.handle,
        sailNumber: sailors.sailNumber,
        nationality: sailors.nationality,
        dob: sailors.dob,
        isPublicDob: sailors.isPublicDob,
      })
      .from(sailors);

    return baseline.map((entry) => {
      const entryName = normalizeName(entry.name);
      const match = profiles.find((profile) => {
        const profileNoc = toNoc(profile.nationality);
        if (profileNoc !== entry.nationality) return false;
        // Sail numbers can be reissued or transcribed inconsistently across
        // countries and seasons. Never link a public profile on sail number
        // alone; a precise normalized-name match is the safe minimum.
        return normalizeName(profile.name) === entryName;
      });

      if (!match) return entry;

      return {
        ...entry,
        profileHref: `/${match.handle}`,
        birthYear: match.isPublicDob ? publicBirthYear(match.dob) : null,
      };
    });
  } catch {
    // The official baseline remains useful during static builds or DB outages.
    return baseline;
  }
}

/**
 * Loads the 2026 qualifier ledger from the Index tables. Singapore sources are
 * counted from SailorPath's original verified regatta result rows, so no second
 * copy of their scores is created just for the Index.
 */
export async function getAsianOptimistIndexQualifierSources(): Promise<
  AsianOptimistIndexQualifierSource[]
> {
  try {
    const ledger = await db
      .select({
        id: asianOptimistIndexEvents.id,
        name: asianOptimistIndexEvents.name,
        hostCountry: asianOptimistIndexEvents.hostCountry,
        startDate: asianOptimistIndexEvents.startDate,
        endDate: asianOptimistIndexEvents.endDate,
        officialResultsUrl: asianOptimistIndexEvents.officialResultsUrl,
        officialResultsSourceName:
          asianOptimistIndexEvents.officialResultsSourceName,
        sourceKind: asianOptimistIndexEvents.sourceKind,
        sailorpathRegattaSlug: asianOptimistIndexEvents.sailorpathRegattaSlug,
        resultStatus: asianOptimistIndexEvents.resultStatus,
      })
      .from(asianOptimistIndexEvents)
      .where(eq(asianOptimistIndexEvents.indexRole, "regional_qualifier"))
      .orderBy(asc(asianOptimistIndexEvents.startDate));

    const importedRows = await db
      .select({
        eventId: asianOptimistIndexResults.eventId,
        resultCount: count(),
      })
      .from(asianOptimistIndexResults)
      .groupBy(asianOptimistIndexResults.eventId);
    const importedCounts = new Map(
      importedRows.map((row) => [row.eventId, Number(row.resultCount)])
    );

    const directSlugs = ledger.flatMap((entry) =>
      entry.sourceKind === "sailorpath_regatta" && entry.sailorpathRegattaSlug
        ? [entry.sailorpathRegattaSlug]
        : []
    );
    const directRegattas = directSlugs.length
      ? await db
          .select({ id: regattas.id, slug: regattas.slug })
          .from(regattas)
          .where(inArray(regattas.slug, directSlugs))
      : [];
    const directCounts = directRegattas.length
      ? await db
          .select({
            regattaId: regattaResults.regattaId,
            resultCount: count(),
          })
          .from(regattaResults)
          .where(
            and(
              inArray(
                regattaResults.regattaId,
                directRegattas.map((regatta) => regatta.id)
              ),
              eq(regattaResults.verificationStatus, "verified")
            )
          )
          .groupBy(regattaResults.regattaId)
      : [];
    const directCountBySlug = new Map(
      directRegattas.map((regatta) => {
        const countRow = directCounts.find(
          (row) => row.regattaId === regatta.id
        );
        return [regatta.slug, Number(countRow?.resultCount ?? 0)];
      })
    );

    return ledger.map((entry) => ({
      id: entry.id,
      name: entry.name,
      hostCountry: entry.hostCountry,
      startDate: entry.startDate,
      endDate: entry.endDate,
      officialResultsUrl: entry.officialResultsUrl,
      officialResultsSourceName: entry.officialResultsSourceName,
      sailorPathRegattaSlug:
        entry.sailorpathRegattaSlug ??
        ASIAN_OPTIMIST_INDEX_2026_QUALIFIERS.find(
          (qualifier) => qualifier.id === entry.id
        )?.sailorPathRegattaSlug ??
        entry.id,
      usesSailorPathResults: entry.sourceKind === "sailorpath_regatta",
      resultCount:
        entry.sourceKind === "sailorpath_regatta"
          ? directCountBySlug.get(entry.sailorpathRegattaSlug ?? "") ?? 0
          : importedCounts.get(entry.id) ?? 0,
      resultStatus: entry.resultStatus,
    }));
  } catch {
    // The page continues to explain source scope during static builds and
    // before a database migration has been applied.
    return [...ASIAN_OPTIMIST_INDEX_2026_QUALIFIERS];
  }
}

export async function getAsianOptimistIndexSnapshot(): Promise<{
  entries: AsianOptimistIndexEntry[];
  qualifiers: AsianOptimistIndexQualifierSource[];
}> {
  const [entries, qualifiers] = await Promise.all([
    getAsianOptimistIndexEntries(),
    getAsianOptimistIndexQualifierSources(),
  ]);

  return { entries, qualifiers };
}
