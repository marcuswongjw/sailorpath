import { excelDateToIso } from "@/lib/normalize";

/** Competitor row from a regatta results spreadsheet. */
export type RegattaImportRow = {
  name: string;
  rank: number | null;
  nett: number | null;
  total: number | null;
  club: string | null;
  nationality: string | null;
  sailNumber: string | null;
  dob: string | null;
  birthYear: number | null;
};

function emptyRow(): RegattaImportRow {
  return {
    name: "",
    rank: null,
    nett: null,
    total: null,
    club: null,
    nationality: null,
    sailNumber: null,
    dob: null,
    birthYear: null,
  };
}

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
      const natRaw =
        nationalityKey != null && r[nationalityKey] != null
          ? String(r[nationalityKey]).trim()
          : "";
      const nationality =
        natRaw && !/^n\/?a$/i.test(natRaw) ? natRaw : null;
      const sailRaw =
        sailKey != null && r[sailKey] != null
          ? String(r[sailKey]).trim()
          : "";
      const sailNumber =
        sailRaw && !/^n\/?a$/i.test(sailRaw) ? sailRaw : null;

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
        nationality,
        sailNumber,
        dob,
        birthYear,
      };
    })
    .filter((r) => r.name);
}

export function summarizeRegattaImport(rows: RegattaImportRow[]): string {
  const withSail = rows.filter((r) => r.sailNumber).length;
  const withDob = rows.filter((r) => r.dob || r.birthYear).length;
  const withClub = rows.filter((r) => r.club).length;
  const withNat = rows.filter((r) => r.nationality).length;
  const profileBits = [
    withSail && `${withSail} sail #`,
    withDob && `${withDob} birth year/DOB`,
    withClub && `${withClub} club`,
    withNat && `${withNat} nationality`,
  ].filter(Boolean);
  return profileBits.length
    ? ` (${profileBits.join(", ")} — will update sailor profiles on import)`
    : ` (optional profile columns absent — results still import fine)`;
}
