import "server-only";

import { db } from "@/db";
import { sailors } from "@/db/schema";
import {
  createAsianOptimistIndexBaseline,
  type AsianOptimistIndexEntry,
} from "@/lib/asianOptimistIndex";

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

function sailDigits(value: string): string {
  return (value.match(/\d+/g) ?? []).join("");
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
      const entrySailDigits = sailDigits(entry.sailNumber);
      const entryName = normalizeName(entry.name);
      const match = profiles.find((profile) => {
        const profileNoc = toNoc(profile.nationality);
        if (profileNoc !== entry.nationality) return false;
        return (
          sailDigits(profile.sailNumber) === entrySailDigits ||
          normalizeName(profile.name) === entryName
        );
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
