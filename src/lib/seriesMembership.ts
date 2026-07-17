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

/**
 * Validate Gold promotion: sailor must have Silver history (or already be Gold).
 * Returns error message or null if OK.
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
      ? input.currentFleet
      : existing?.currentFleet || ""
  )
    .trim()
    .toLowerCase();
  const nextGold =
    input.goldEntryDate !== undefined
      ? input.goldEntryDate
      : existing?.goldEntryDate || null;
  const nextSilver =
    input.silverEntryDate !== undefined
      ? input.silverEntryDate
      : existing?.silverEntryDate || null;

  const wantsGold =
    nextFleet === "gold" || Boolean(nextGold && String(nextGold).trim());

  if (!wantsGold) return null;

  // Already Gold in DB — allow edits (keep historical Gold)
  if (existing?.goldEntryDate || String(existing?.currentFleet || "").toLowerCase() === "gold") {
    return null;
  }

  const silverOk =
    Boolean(nextSilver && String(nextSilver).trim()) ||
    nextFleet === "silver" || // odd edge: shouldn't set both
    Boolean(existing?.silverEntryDate) ||
    String(existing?.currentFleet || "").toLowerCase() === "silver";

  if (!silverOk) {
    return "Gold fleet requires Silver history first. Admit the sailor as Silver (set Silver entry date or Fleet = Silver), then promote to Gold.";
  }
  return null;
}
