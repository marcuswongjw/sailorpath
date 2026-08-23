import { excelDateToIso } from "@/lib/normalize";
import type { OfficialRaceResultInput } from "@/types/raceResult";

/** Competitor row from a regatta results spreadsheet. */
export type RegattaImportRow = {
  name: string;
  rank: number | null;
  nett: number | null;
  total: number | null;
  club: string | null;
  school: string | null;
  nationality: string | null;
  gender: string | null;
  sailNumber: string | null;
  dob: string | null;
  birthYear: number | null;
  /** Suggested/imported DNS status; admin can override before saving. */
  isDns: boolean;
  races: OfficialRaceResultInput[];
};

function emptyRow(): RegattaImportRow {
  return {
    name: "",
    rank: null,
    nett: null,
    total: null,
    club: null,
    school: null,
    nationality: null,
    gender: null,
    sailNumber: null,
    dob: null,
    birthYear: null,
    isDns: false,
    races: [],
  };
}

const NON_START_CODES = new Set(["DNS", "DNC"]);

/**
 * Suggest DNS without treating all tied ranks as non-starters.
 * Strong evidence: every published race is DNS/DNC. Otherwise, only a tied
 * worst rank is suggested, and the admin review remains authoritative.
 */
export function inferLikelyDnsRows(
  rows: readonly RegattaImportRow[]
): RegattaImportRow[] {
  const ranks = rows
    .map((row) => row.rank)
    .filter((rank): rank is number => rank != null && Number.isFinite(rank));
  const worstRank = ranks.length ? Math.max(...ranks) : null;
  const worstRankCount =
    worstRank == null ? 0 : ranks.filter((rank) => rank === worstRank).length;

  return rows.map((row) => {
    const allRacesAreNonStarts =
      row.races.length > 0 &&
      row.races.every((race) =>
        NON_START_CODES.has(String(race.scoringCode || "").toUpperCase())
      );
    const tiedWorstRank =
      worstRankCount > 1 && row.rank != null && row.rank === worstRank;
    return {
      ...row,
      isDns: row.isDns || allRacesAreNonStarts || tiedWorstRank,
    };
  });
}

export {
  normalizeGender,
  normalizeImportGender,
} from "@/lib/gender";
import { normalizeImportGender } from "@/lib/gender";

/** Map raw sheet objects to regatta result import rows. */
export function parseRegattaResultRows(
  json: Record<string, unknown>[]
): RegattaImportRow[] {
  return json
    .map((r) => {
      const keys = Object.keys(r);
      const nameKey =
        keys.find((k) => /^name$/i.test(k.trim())) ||
        keys.find((k) =>
          /^(sailor|sailor name|competitor)$/i.test(k.trim())
        ) ||
        keys.find(
          (k) => /name|sailor/i.test(k) && !/club|team|boat|sail/i.test(k)
        ) ||
        keys.find((k) => /sailor/i.test(k));
      const rankKey =
        keys.find((k) => /^rank$/i.test(k.trim())) ||
        keys.find((k) => /rank|pos|place|position/i.test(k));
      const nettKey =
        keys.find((k) => /^nett$/i.test(k.trim())) ||
        keys.find((k) => /nett/i.test(k));
      const totalKey =
        keys.find((k) => /^total score$/i.test(k.trim())) ||
        keys.find((k) => /^total$/i.test(k.trim())) ||
        keys.find((k) => /total score|gross/i.test(k));
      const clubKey =
        keys.find((k) => /^club$/i.test(k.trim())) ||
        keys.find(
          (k) =>
            /^(club|team|yacht club|sailing club)$/i.test(k.trim()) ||
            (/club|team/i.test(k) && !/squad|national/i.test(k))
        );
      const schoolKey =
        keys.find((k) => /^school$/i.test(k.trim())) ||
        keys.find((k) => /school|college|institution/i.test(k));
      const nationalityKey =
        keys.find((k) =>
          /^(nationality|nation|country|noc|country of origin)$/i.test(
            k.trim()
          )
        ) ||
        keys.find(
          (k) =>
            /nationality|country of origin|\bnoc\b/i.test(k) &&
            !/squad|nat\s*[ab]|national squad/i.test(k)
        );
      const genderKey =
        keys.find((k) => /^(gender|sex|gendre)$/i.test(k.trim())) ||
        keys.find((k) => /^gender|^\s*sex\s*$/i.test(k));
      const dnsKey =
        keys.find((k) => /^(dns|did not start|non-starter)$/i.test(k.trim())) ||
        keys.find((k) => /^(status|result status)$/i.test(k.trim()));
      const sailKey =
        keys.find((k) =>
          /^(sail\s*(number|no\.?|#|num)?|sailnumber|boat\s*(number|no\.?)?)$/i.test(
            k.trim()
          )
        ) ||
        keys.find(
          (k) =>
            /sail\s*(number|no|#)|sailnumber|boat\s*no/i.test(k) &&
            !/sailor/i.test(k)
        );
      const birthYearKey =
        keys.find((k) =>
          /^(birth\s*year|birthyear|year\s*of\s*birth|yob|born\s*year)$/i.test(
            k.trim()
          )
        ) || keys.find((k) => /birth\s*year|yob|year of birth/i.test(k));
      const dobKey =
        keys.find((k) =>
          /^(dob|date\s*of\s*birth|birth\s*date|born|birthday)$/i.test(
            k.trim()
          )
        ) ||
        keys.find(
          (k) =>
            /date of birth|birth\s*date|birthday|\bdob\b/i.test(k) &&
            !/year/i.test(k)
        );

      const raceKeys = keys
        .map((key) => {
          const match = key.trim().match(/^R(?:ace\s*)?(\d+)$/i);
          return match ? { key, raceNumber: Number(match[1]) } : null;
        })
        .filter(
          (value): value is { key: string; raceNumber: number } =>
            value != null && value.raceNumber > 0
        )
        .sort((a, b) => a.raceNumber - b.raceNumber);

      if (!nameKey) return emptyRow();
      const name = String(r[nameKey] ?? "").trim();
      if (!name || /^name$/i.test(name)) return emptyRow();

      const rankRaw = rankKey != null ? r[rankKey] : null;
      const nettRaw = nettKey != null ? r[nettKey] : null;
      const totalRaw = totalKey != null ? r[totalKey] : null;
      const rank =
        rankRaw !== "" && rankRaw != null ? Number(rankRaw) : null;
      const nett =
        nettRaw !== "" && nettRaw != null ? Number(nettRaw) : null;
      const total =
        totalRaw !== "" && totalRaw != null ? Number(totalRaw) : null;
      const clubRaw =
        clubKey != null && r[clubKey] != null
          ? String(r[clubKey]).trim()
          : "";
      const club = clubRaw && !/^n\/?a$/i.test(clubRaw) ? clubRaw : null;
      const schoolRaw =
        schoolKey != null && r[schoolKey] != null
          ? String(r[schoolKey]).trim()
          : "";
      const school =
        schoolRaw && !/^n\/?a$/i.test(schoolRaw) ? schoolRaw : null;
      const natRaw =
        nationalityKey != null && r[nationalityKey] != null
          ? String(r[nationalityKey]).trim()
          : "";
      const nationality =
        natRaw && !/^n\/?a$/i.test(natRaw) ? natRaw : null;
      const gender =
        genderKey != null && r[genderKey] != null
          ? normalizeImportGender(r[genderKey])
          : null;
      const dnsRaw = dnsKey != null ? String(r[dnsKey] ?? "").trim() : "";
      const isDns = /^(?:1|true|yes|y|dns|dnc|did not start|non-starter)$/i.test(
        dnsRaw
      );
      const sailRaw =
        sailKey != null && r[sailKey] != null
          ? String(r[sailKey]).trim()
          : "";
      const sailNumber =
        sailRaw && !/^n\/?a$/i.test(sailRaw) ? sailRaw : null;
      const races = raceKeys
        .map(({ key, raceNumber }) =>
          parseOfficialRaceValue(r[key], raceNumber)
        )
        .filter((race): race is OfficialRaceResultInput => race != null);

      let birthYear: number | null = null;
      let dob: string | null = null;
      if (
        birthYearKey != null &&
        r[birthYearKey] != null &&
        r[birthYearKey] !== ""
      ) {
        const by = Number(String(r[birthYearKey]).trim());
        if (Number.isFinite(by) && by >= 1990 && by <= 2035) {
          birthYear = Math.round(by);
        }
      }
      if (dobKey != null && r[dobKey] != null && r[dobKey] !== "") {
        const raw = r[dobKey];
        if (
          (typeof raw === "number" &&
            raw >= 1990 &&
            raw <= 2035 &&
            Number.isInteger(raw)) ||
          (typeof raw === "string" && /^\d{4}$/.test(raw.trim()))
        ) {
          if (birthYear == null) birthYear = Math.round(Number(raw));
        } else {
          dob = excelDateToIso(raw);
          if (dob && !/^\d{4}-\d{2}-\d{2}/.test(dob)) dob = null;
        }
      }

      return {
        name,
        rank: Number.isFinite(rank as number) ? rank : null,
        nett: Number.isFinite(nett as number) ? nett : null,
        total: Number.isFinite(total as number) ? total : null,
        club,
        school,
        nationality,
        gender,
        sailNumber,
        dob,
        birthYear,
        isDns,
        races,
      };
    })
    .filter((r) => r.name);
}

/** Parse Sailwave-style cells such as `4.0`, `(12.0)`, or `52.0 DSQ`. */
export function parseOfficialRaceValue(
  value: unknown,
  raceNumber: number
): OfficialRaceResultInput | null {
  const rawValue = String(value ?? "").trim();
  if (!rawValue) return null;
  const scoreMatch = rawValue.match(/-?\d+(?:\.\d+)?/);
  const score = scoreMatch ? Number(scoreMatch[0]) : Number.NaN;
  if (!Number.isFinite(score)) return null;
  const codeMatch = rawValue.match(/\b[A-Z]{2,5}\b/i);
  return {
    raceNumber,
    score,
    scoringCode: codeMatch ? codeMatch[0].toUpperCase() : null,
    discarded: /^\s*[([]/.test(rawValue),
    rawValue,
  };
}

export function summarizeRegattaImport(rows: RegattaImportRow[]): string {
  const withSail = rows.filter((r) => r.sailNumber).length;
  const withDob = rows.filter((r) => r.dob || r.birthYear).length;
  const withClub = rows.filter((r) => r.club).length;
  const withNat = rows.filter((r) => r.nationality).length;
  const withGender = rows.filter((r) => r.gender).length;
  const profileBits = [
    withSail && `${withSail} sail #`,
    withDob && `${withDob} birth year/DOB`,
    withClub && `${withClub} club`,
    withNat && `${withNat} nationality`,
    withGender && `${withGender} gender`,
  ].filter(Boolean);
  return profileBits.length
    ? ` (${profileBits.join(", ")} — will update sailor profiles on import)`
    : ` (optional profile columns absent — results still import fine)`;
}
