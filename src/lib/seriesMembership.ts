/**
 * SG Optimist series membership helpers.
 *
 * Series membership (near-term) = has Gold/Silver fleet tags (currentFleet and/or entry dates).
 * Guests (import-only / untagged) appear in regatta results but not on rankings.
 * Gold may only be set when the sailor has Silver history (or is already Gold).
 */

export type SeriesFleetStatus =
  | "gold"
  | "silver"
  | "guest"
  | "dropped";

/** Common nationality / NOC aliases → short display code */
const NOC_MAP: Record<string, string> = {
  singapore: "SGP",
  sgp: "SGP",
  sin: "SGP",
  "singapore (sgp)": "SGP",
  malaysia: "MAS",
  mas: "MAS",
  mal: "MAS",
  indonesia: "INA",
  ina: "INA",
  idn: "INA",
  thailand: "THA",
  tha: "THA",
  philippines: "PHI",
  phi: "PHI",
  phl: "PHI",
  vietnam: "VIE",
  vie: "VIE",
  vnm: "VIE",
  china: "CHN",
  chn: "CHN",
  "hong kong": "HKG",
  hkg: "HKG",
  japan: "JPN",
  jpn: "JPN",
  korea: "KOR",
  "south korea": "KOR",
  kor: "KOR",
  australia: "AUS",
  aus: "AUS",
  "new zealand": "NZL",
  nzl: "NZL",
  "united states": "USA",
  usa: "USA",
  "great britain": "GBR",
  gbr: "GBR",
  uk: "GBR",
};

export function normalizeNationality(v: unknown): string | null {
  if (v == null || v === "") return null;
  const raw = String(v).trim().replace(/\s+/g, " ");
  if (!raw || /^n\/?a$/i.test(raw) || raw === "-" || raw === "—") return null;
  const key = raw.toLowerCase();
  if (NOC_MAP[key]) return NOC_MAP[key];
  // Already a 3-letter code
  if (/^[A-Za-z]{3}$/.test(raw)) return raw.toUpperCase();
  return raw;
}

export function hasSilverHistory(s: {
  silverEntryDate?: string | null;
  goldEntryDate?: string | null;
  currentFleet?: string | null;
}): boolean {
  if (s.silverEntryDate) return true;
  // Already Gold implies they came through (or were seeded historically)
  if (s.goldEntryDate) return true;
  const cf = String(s.currentFleet || "")
    .trim()
    .toLowerCase();
  return cf === "silver" || cf === "gold";
}

export function isSeriesMember(s: {
  silverEntryDate?: string | null;
  goldEntryDate?: string | null;
  currentFleet?: string | null;
  manuallyDropped?: boolean | null;
}): boolean {
  if (s.manuallyDropped) return false;
  const cf = String(s.currentFleet || "")
    .trim()
    .toLowerCase();
  if (cf === "gold" || cf === "silver") return true;
  return Boolean(s.goldEntryDate || s.silverEntryDate);
}

export function seriesFleetStatus(s: {
  silverEntryDate?: string | null;
  goldEntryDate?: string | null;
  currentFleet?: string | null;
  manuallyDropped?: boolean | null;
}): SeriesFleetStatus {
  if (s.manuallyDropped) return "dropped";
  const cf = String(s.currentFleet || "")
    .trim()
    .toLowerCase();
  if (cf === "gold") return "gold";
  if (cf === "silver") return "silver";
  if (s.goldEntryDate) return "gold";
  if (s.silverEntryDate) return "silver";
  return "guest";
}

export function seriesStatusBadge(status: SeriesFleetStatus): {
  label: string;
  className: string;
} {
  switch (status) {
    case "gold":
      return {
        label: "Gold Fleet",
        className:
          "bg-yellow-500/10 text-yellow-400 border border-yellow-500/25",
      };
    case "silver":
      return {
        label: "Silver Fleet",
        className: "bg-slate-400/10 text-slate-300 border border-slate-400/20",
      };
    case "dropped":
      return {
        label: "Manually dropped",
        className: "bg-amber-500/10 text-amber-300 border border-amber-500/20",
      };
    default:
      return {
        label: "Guest (not in series)",
        className: "bg-white/5 text-slate-400 border border-white/10",
      };
  }
}

function hasDateValue(v: unknown): boolean {
  if (v == null || v === "") return false;
  // Date objects from drivers, or ISO / YYYY-MM-DD strings
  if (v instanceof Date) return !Number.isNaN(v.getTime());
  return String(v).trim().length > 0;
}

/** Normalize to YYYY-MM-DD for postgres date columns (avoids invalid ISO dump failures). */
export function toDateOnly(v: unknown): string | null {
  if (v == null || v === "") return null;
  if (v instanceof Date && !Number.isNaN(v.getTime())) {
    return v.toISOString().slice(0, 10);
  }
  const s = String(v).trim();
  if (!s) return null;
  if (/^\d{4}-\d{2}-\d{2}/.test(s)) return s.slice(0, 10);
  const t = Date.parse(s);
  if (!Number.isNaN(t)) return new Date(t).toISOString().slice(0, 10);
  return null;
}

/**
 * Validate Gold promotion: sailor must have Silver history (or already be Gold).
 * Returns error message or null if OK.
 *
 * Historical Gold sailors (gold entry / fleet already set, often without silver
 * dates in the roster) may always edit gold dates.
 */
export function validateGoldPromotion(input: {
  currentFleet?: string | null;
  goldEntryDate?: string | null;
  silverEntryDate?: string | null;
  /** Existing DB row when patching */
  existing?: {
    currentFleet?: string | null;
    goldEntryDate?: string | null;
    silverEntryDate?: string | null;
  } | null;
}): string | null {
  const existing = input.existing || null;
  const nextFleet = String(
    input.currentFleet !== undefined
      ? input.currentFleet ?? ""
      : existing?.currentFleet || ""
  )
    .trim()
    .toLowerCase();
  const nextGold =
    input.goldEntryDate !== undefined
      ? input.goldEntryDate
      : existing?.goldEntryDate ?? null;
  const nextSilver =
    input.silverEntryDate !== undefined
      ? input.silverEntryDate
      : existing?.silverEntryDate ?? null;

  const wantsGold =
    nextFleet === "gold" || hasDateValue(nextGold);

  if (!wantsGold) return null;

  // Already Gold in DB — allow edits (including changing gold entry date)
  const alreadyGold =
    hasDateValue(existing?.goldEntryDate) ||
    String(existing?.currentFleet || "")
      .trim()
      .toLowerCase() === "gold";
  if (alreadyGold) return null;

  const silverOk =
    hasDateValue(nextSilver) ||
    nextFleet === "silver" ||
    hasDateValue(existing?.silverEntryDate) ||
    String(existing?.currentFleet || "")
      .trim()
      .toLowerCase() === "silver";

  if (!silverOk) {
    return "Gold fleet requires Silver history first. Admit the sailor as Silver (set Silver entry date or Fleet = Silver), then promote to Gold.";
  }
  return null;
}

/** Map common Postgres / schema errors to actionable admin messages */
export function sailorDbErrorHint(err: unknown): string | null {
  const msg = err instanceof Error ? err.message : String(err ?? "");
  if (/nationality/i.test(msg) && /column|does not exist/i.test(msg)) {
    return "Database missing nationality column. In Supabase SQL Editor run: ALTER TABLE public.sailors ADD COLUMN IF NOT EXISTS nationality text;";
  }
  if (
    /(school|current_fleet|manually_dropped)/i.test(msg) &&
    /column|does not exist/i.test(msg)
  ) {
    return "Database missing school/fleet columns. Run migration 002_sailor_school_fleet.sql in Supabase.";
  }
  if (/nett_score/i.test(msg) && /integer|type|numeric/i.test(msg)) {
    return "Run migration 003: ALTER TABLE regatta_results ALTER COLUMN nett_score TYPE real;";
  }
  return null;
}
