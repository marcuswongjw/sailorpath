/**
 * Sailor gender codes: store and compare as M | F only.
 */

/** Normalize any import/UI/DB value to M | F | null. */
export function normalizeGender(v: unknown): "M" | "F" | null {
  if (v == null || v === "") return null;
  const s = String(v).trim().toLowerCase();
  if (!s || /^n\/?a$/i.test(s) || s === "-" || s === "—" || s === "?") {
    return null;
  }
  // Exact tokens only — do not use startsWith("m") (matches "mixed", "miss", …)
  if (
    s === "m" ||
    s === "male" ||
    s === "boy" ||
    s === "man" ||
    s === "♂"
  ) {
    return "M";
  }
  if (
    s === "f" ||
    s === "female" ||
    s === "girl" ||
    s === "woman" ||
    s === "♀"
  ) {
    return "F";
  }
  return null;
}

/** @deprecated Prefer normalizeGender — kept for import call sites. */
export const normalizeImportGender = normalizeGender;

/** Short label for rankings / lists. */
export function formatGenderLabel(v: unknown): string {
  const g = normalizeGender(v);
  if (g === "M") return "M";
  if (g === "F") return "F";
  return "—";
}

/** Long label when space allows. */
export function formatGenderLong(v: unknown): string {
  const g = normalizeGender(v);
  if (g === "M") return "Male";
  if (g === "F") return "Female";
  return "—";
}

/**
 * Conservative given-name hints for admin gender audit only.
 * Never auto-applied — review before setting.
 */
const FEMININE_NAME_TOKENS = new Set(
  [
    "adele",
    "alice",
    "allison",
    "althea",
    "amelie",
    "amy",
    "anna",
    "anne",
    "ashley",
    "bella",
    "cadee",
    "catherine",
    "charlotte",
    "chloe",
    "cheryl",
    "claire",
    "deborah",
    "delia",
    "elena",
    "eliza",
    "elizabeth",
    "ella",
    "emily",
    "emma",
    "eva",
    "evelyn",
    "febe",
    "gabriella",
    "grace",
    "gwen",
    "gwenyth",
    "gwyneth",
    "hayley",
    "helena",
    "hillary",
    "iris",
    "isabelle",
    "jade",
    "janelle",
    "jemima",
    "jessica",
    "julia",
    "kate",
    "katelynn",
    "katherine",
    "katie",
    "kayler",
    "lauren",
    "lily",
    "lucy",
    "macy",
    "maia",
    "maria",
    "martha",
    "maya",
    "melina",
    "merelle",
    "mikaela",
    "mikayla",
    "mildred",
    "nadia",
    "nadyne",
    "nicholette",
    "nicole",
    "olivia",
    "rachel",
    "sakura",
    "sarah",
    "seraphina",
    "shernice",
    "sophia",
    "sophie",
    "sumire",
    "tiffany",
    "victoria",
  ].map((s) => s.toLowerCase())
);

const MASCULINE_NAME_TOKENS = new Set(
  [
    "aaron",
    "adam",
    "aidan",
    "alex",
    "andrew",
    "benjamin",
    "brandon",
    "bryan",
    "caleb",
    "christopher",
    "damien",
    "daniel",
    "dylan",
    "edward",
    "ethan",
    "evan",
    "gabriel",
    "george",
    "harry",
    "hayden",
    "henry",
    "ian",
    "isaac",
    "jacob",
    "james",
    "jason",
    "jayden",
    "jonathan",
    "joseph",
    "joshua",
    "julian",
    "kevin",
    "leo",
    "liam",
    "lucas",
    "marcus",
    "matthew",
    "max",
    "michael",
    "mitchell",
    "nathan",
    "nicholas",
    "noah",
    "oliver",
    "owen",
    "raphael",
    "ryan",
    "samuel",
    "scott",
    "sebastian",
    "thomas",
    "timothy",
    "toby",
    "tyler",
    "william",
    "zachary",
  ].map((s) => s.toLowerCase())
);

/** Suggest M/F from given-name tokens in a full name (admin hint only). */
export function suggestGenderFromName(name: string): "M" | "F" | null {
  const tokens = String(name || "")
    .toLowerCase()
    .split(/[^a-z]+/)
    .filter(Boolean);
  let f = false;
  let m = false;
  for (const t of tokens) {
    if (FEMININE_NAME_TOKENS.has(t)) f = true;
    if (MASCULINE_NAME_TOKENS.has(t)) m = true;
  }
  if (f && !m) return "F";
  if (m && !f) return "M";
  return null;
}

export type GenderAuditRow = {
  id: string;
  name: string;
  handle: string | null;
  club: string | null;
  sailNumber: string | null;
  gender: "M" | "F" | null;
  suggested: "M" | "F" | null;
  /** True when stored gender disagrees with name hint */
  conflict: boolean;
};

export function buildGenderAuditRows(
  sailors: {
    id: string;
    name: string;
    handle?: string | null;
    club?: string | null;
    sailNumber?: string | null;
    gender?: string | null;
  }[]
): GenderAuditRow[] {
  return sailors
    .map((s) => {
      const gender = normalizeGender(s.gender);
      const suggested = suggestGenderFromName(s.name);
      return {
        id: s.id,
        name: s.name,
        handle: s.handle ?? null,
        club: s.club ?? null,
        sailNumber: s.sailNumber ?? null,
        gender,
        suggested,
        conflict: Boolean(suggested && gender && suggested !== gender),
      };
    })
    .sort((a, b) => {
      // Conflicts first, then unknown, then name
      const score = (r: GenderAuditRow) =>
        r.conflict ? 0 : r.gender == null ? 1 : 2;
      const d = score(a) - score(b);
      if (d !== 0) return d;
      return a.name.localeCompare(b.name);
    });
}
