import { birthYear } from "@/lib/age";
import type { PrizeCategory, PrizeWinner, RegattaPrizeFleet } from "@/lib/regattaPrizes";
import { prizeNameKey } from "@/lib/regattaPrizes";

export type PrizeResultRow = {
  sailorName: string;
  sailNumber?: string | null;
  gender?: string | null;
  birthYear?: number | null;
  dob?: string | Date | null;
  school?: string | null;
  rank: number;
  nettScore?: number | null;
  isDns?: boolean | null;
  isOverseasCommitment?: boolean | null;
};

type Eligible = (row: PrizeResultRow, eventYear: number) => boolean;

export function prizePlaceCount(prizesAwarded: string): number {
  const range = String(prizesAwarded || "").match(/(\d+)\s*(?:st|nd|rd|th)?\s*(?:to|-)\s*(\d+)/i);
  if (range) return Number(range[2]);
  const single = String(prizesAwarded || "").match(/(\d+)/);
  return single ? Number(single[1]) : 1;
}

export function schoolLevel(school: string | null | undefined): "primary" | "secondary" | null {
  const value = String(school || "").trim().toLowerCase();
  if (!value) return null;
  if (/primary|\(junior\)|junior school|institution junior/.test(value)) return "primary";
  if (/secondary|high school|institution|college|polytechnic|\(independent\)|girls' school|girls school/.test(value)) {
    return "secondary";
  }
  return null;
}

function sailorYear(row: PrizeResultRow): number | null {
  const recorded = Number(row.birthYear);
  if (Number.isFinite(recorded) && recorded >= 1900 && recorded <= 2100) return recorded;
  return birthYear(row.dob);
}

function isFemale(gender: string | null | undefined): boolean {
  const value = String(gender || "").trim().toLowerCase();
  return value === "f" || value === "female";
}

/**
 * Rules we can apply from published results. Novice is omitted: the results
 * do not say who is sailing a ranking regatta for the first time.
 */
export function eligibilityForCategory(categoryName: string): Eligible | null {
  const name = categoryName.toLowerCase();
  if (/novice/.test(name)) return null;
  if (/all classes/.test(name)) return null;

  const between = name.match(/born between (\d{4}) and (\d{4})/);
  if (between) {
    const from = Number(between[1]);
    const to = Number(between[2]);
    return (row) => {
      const year = sailorYear(row);
      return year != null && year >= from && year <= to;
    };
  }

  const later = name.match(/born(?: in)? (\d{4}) or later/);
  if (later) {
    const from = Number(later[1]);
    return (row) => {
      const year = sailorYear(row);
      return year != null && year >= from;
    };
  }

  if (/female/.test(name)) return (row) => isFemale(row.gender);
  if (/primary school/.test(name)) return (row) => schoolLevel(row.school) === "primary";
  if (/secondary school/.test(name)) return (row) => schoolLevel(row.school) === "secondary";

  const ageRange = name.match(/(\d+)\s*-\s*(\d+)\s*yo/);
  if (ageRange) {
    const younger = Number(ageRange[1]);
    const older = Number(ageRange[2]);
    return (row, eventYear) => {
      const year = sailorYear(row);
      if (year == null || !eventYear) return false;
      return year >= eventYear - older && year <= eventYear - younger;
    };
  }

  const under = name.match(/(\d+)\s*(?:&u|years?\s+and\s+under|years?\s*&\s*under)\b/);
  if (under) {
    const age = Number(under[1]);
    return (row, eventYear) => {
      const year = sailorYear(row);
      return year != null && Boolean(eventYear) && year >= eventYear - age;
    };
  }

  if (/\bopen\b/.test(name)) return () => true;
  return null;
}

function placeTitle(place: number): string {
  const mod100 = place % 100;
  const mod10 = place % 10;
  const suffix =
    mod100 >= 11 && mod100 <= 13
      ? "th"
      : mod10 === 1
        ? "st"
        : mod10 === 2
          ? "nd"
          : mod10 === 3
            ? "rd"
            : "th";
  return `${place}${suffix}`;
}

function finisher(row: PrizeResultRow): boolean {
  return !row.isDns && !row.isOverseasCommitment && Number.isFinite(row.rank) && row.rank > 0;
}

function fillCategory(
  category: PrizeCategory,
  finishers: PrizeResultRow[],
  eventYear: number
): PrizeCategory {
  const wanted = prizePlaceCount(category.prizesAwarded);
  if (category.winners.length >= wanted) return category;
  const rule = eligibilityForCategory(category.categoryName);
  if (!rule) return category;
  if (category.winners.length > 0) return category;

  const winners: PrizeWinner[] = finishers
    .filter((row) => rule(row, eventYear))
    .slice(0, wanted)
    .map((row, index) => {
      const place = index + 1;
      const year = sailorYear(row);
      const nett = row.nettScore;
      return {
        rank: place,
        prizeTitle: placeTitle(place),
        sailorName: row.sailorName,
        sailNumber: row.sailNumber ? String(row.sailNumber) : undefined,
        gender: isFemale(row.gender) ? "F" : String(row.gender || "").toUpperCase() === "M" ? "M" : undefined,
        birthYear: year ?? undefined,
        schoolName: row.school ? String(row.school) : undefined,
        notes: nett != null && Number.isFinite(Number(nett)) ? `Nett ${nett}.` : undefined,
      };
    });

  if (winners.length === 0) return category;
  return {
    ...category,
    eligibilityNotes: category.eligibilityNotes || "Calculated from the published results.",
    winners,
  };
}

/** Fill prize categories that have no names from the published finishing order. */
export function fillUnlistedPrizeWinners(
  fleets: RegattaPrizeFleet[],
  results: readonly PrizeResultRow[],
  eventYear: number
): RegattaPrizeFleet[] {
  const finishers = results
    .filter(finisher)
    .slice()
    .sort((a, b) => a.rank - b.rank || Number(a.nettScore ?? 1e9) - Number(b.nettScore ?? 1e9) || prizeNameKey(a.sailorName).localeCompare(prizeNameKey(b.sailorName)));

  return fleets
    .map((fleet) => ({
      ...fleet,
      categories: fleet.categories
        .map((category) => fillCategory(category, finishers, eventYear))
        .filter((category) => category.winners.length > 0),
    }))
    .filter((fleet) => fleet.categories.length > 0);
}
