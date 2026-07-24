/**
 * SG Optimist series membership helpers.
 *
 * SG Series Fleet (stored in current_fleet):
 *   - "Guest"  — not on Gold/Silver rankings
 *   - "Series" — In SG Fleet (Gold/Silver derived from entry dates)
 *
 * Legacy values "Gold" / "Silver" on current_fleet are treated as Series.
 * Ranking fleet (Gold vs Silver) comes only from goldEntryDate + dropDate
 * (see resolveSailorFleet) — not from selecting Gold/Silver manually.
 */

export type SeriesFleetStatus =
  | "gold"
  | "silver"
  | "guest"
  | "series"
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
  if (/^[A-Za-z]{3}$/.test(raw)) return raw.toUpperCase();
  return raw;
}

/**
 * Normalize admin/import values to Guest | Series (canonical storage).
 * Legacy Gold/Silver → Series.
 */
export function normalizeSgSeriesMembership(
  v: unknown
): "Guest" | "Series" | null {
  if (v == null || v === "") return null;
  const s = String(v).trim().toLowerCase();
  if (!s || s === "guest" || s === "n/a" || s === "none") return "Guest";
  if (
    s === "series" ||
    s === "in sg fleet" ||
    s === "in_sg_fleet" ||
    s === "member" ||
    s === "sg" ||
    s === "gold" ||
    s === "silver"
  ) {
    return "Series";
  }
  return null;
}

/** True when sailor is marked In SG Fleet (eligible for Gold/Silver ranking by dates). */
export function isInSgSeries(s: {
  currentFleet?: string | null;
  goldEntryDate?: string | null;
  silverEntryDate?: string | null;
}): boolean {
  const cf = String(s.currentFleet || "")
    .trim()
    .toLowerCase();
  if (cf === "guest") return false;
  if (
    cf === "series" ||
    cf === "gold" ||
    cf === "silver" ||
    cf === "in sg fleet" ||
    cf === "member"
  ) {
    return true;
  }
  // Legacy rows: no flag but has entry dates → treat as series
  if (!cf && (s.goldEntryDate || s.silverEntryDate)) return true;
  return false;
}

export function hasSilverHistory(s: {
  silverEntryDate?: string | null;
  goldEntryDate?: string | null;
  currentFleet?: string | null;
}): boolean {
  if (s.silverEntryDate) return true;
  if (s.goldEntryDate) return true;
  // Legacy Gold/Silver fleet tag
  const cf = String(s.currentFleet || "")
    .trim()
    .toLowerCase();
  return cf === "silver" || cf === "gold" || cf === "series";
}

export function isSeriesMember(s: {
  silverEntryDate?: string | null;
  goldEntryDate?: string | null;
  currentFleet?: string | null;
  dropDate?: string | null;
}): boolean {
  // Past drop date → no longer an active series member for “now”
  if (s.dropDate) {
    const ymd = String(s.dropDate).slice(0, 10);
    const today = new Date().toLocaleDateString("en-CA", {
      timeZone: "Asia/Singapore",
    });
    if (/^\d{4}-\d{2}-\d{2}$/.test(ymd) && ymd <= today) return false;
  }
  return isInSgSeries(s);
}

/**
 * Display status for admin/profile badges.
 * Ranking fleet still uses resolveSailorFleet (period-aware).
 */
export function seriesFleetStatus(s: {
  silverEntryDate?: string | null;
  goldEntryDate?: string | null;
  currentFleet?: string | null;
  dropDate?: string | null;
}): SeriesFleetStatus {
  if (s.dropDate) {
    const ymd = String(s.dropDate).slice(0, 10);
    const today = new Date().toLocaleDateString("en-CA", {
      timeZone: "Asia/Singapore",
    });
    if (/^\d{4}-\d{2}-\d{2}$/.test(ymd) && ymd <= today) return "dropped";
  }
  if (!isInSgSeries(s)) return "guest";
  // Ranking tier hint from gold entry date (not from currentFleet Gold/Silver)
  if (s.goldEntryDate) return "gold";
  return "series";
}

/** Short admin / search label for SG Series membership. */
export function seriesMembershipLabel(s: {
  silverEntryDate?: string | null;
  goldEntryDate?: string | null;
  currentFleet?: string | null;
  dropDate?: string | null;
}): string {
  switch (seriesFleetStatus(s)) {
    case "dropped":
      return "Dropped";
    case "guest":
      return "Guest";
    case "gold":
      return "Series · Gold entry";
    case "silver":
      return "Series · Silver";
    case "series":
    default:
      return s.goldEntryDate ? "Series · Gold entry" : "Series · Silver";
  }
}

export function seriesStatusBadge(status: SeriesFleetStatus): {
  label: string;
  className: string;
} {
  switch (status) {
    case "gold":
      return {
        label: "In SG Fleet (Gold entry)",
        className:
          "bg-yellow-500/10 text-yellow-400 border border-yellow-500/25",
      };
    case "silver":
      return {
        label: "In SG Fleet (Silver)",
        className: "bg-slate-400/10 text-slate-300 border border-slate-400/20",
      };
    case "series":
      return {
        label: "In SG Fleet",
        className: "bg-sky-500/10 text-sky-300 border border-sky-500/25",
      };
    case "dropped":
      return {
        label: "Dropped (drop date)",
        className: "bg-amber-500/10 text-amber-300 border border-amber-500/20",
      };
    default:
      return {
        label: "Guest",
        className: "bg-white/5 text-slate-400 border border-white/10",
      };
  }
}

function hasDateValue(v: unknown): boolean {
  if (v == null || v === "") return false;
  if (v instanceof Date) return !Number.isNaN(v.getTime());
  return String(v).trim().length > 0;
}

/** Date-only for admin writes — prefer SG calendar via datesSg.toYmd. */
export function toDateOnly(v: unknown): string | null {
  // Lazy import avoided: keep slice path for pure YYYY-MM-DD (most form values)
  if (v == null || v === "") return null;
  if (v instanceof Date && !Number.isNaN(v.getTime())) {
    try {
      // Asia/Singapore calendar day
      return new Intl.DateTimeFormat("en-CA", {
        timeZone: "Asia/Singapore",
        year: "numeric",
        month: "2-digit",
        day: "2-digit",
      }).format(v);
    } catch {
      return v.toISOString().slice(0, 10);
    }
  }
  const s = String(v).trim();
  if (!s) return null;
  if (/^\d{4}-\d{2}-\d{2}/.test(s)) return s.slice(0, 10);
  const t = Date.parse(s);
  if (!Number.isNaN(t)) {
    try {
      return new Intl.DateTimeFormat("en-CA", {
        timeZone: "Asia/Singapore",
        year: "numeric",
        month: "2-digit",
        day: "2-digit",
      }).format(new Date(t));
    } catch {
      return new Date(t).toISOString().slice(0, 10);
    }
  }
  return null;
}

/**
 * Gold requires Silver history first (or already Gold).
 * Historical Gold sailors (gold entry / already Gold) may always edit gold dates.
 */
export function validateGoldPromotion(input: {
  currentFleet?: string | null;
  goldEntryDate?: string | null;
  silverEntryDate?: string | null;
  existing?: {
    currentFleet?: string | null;
    goldEntryDate?: string | null;
    silverEntryDate?: string | null;
  } | null;
}): string | null {
  const existing = input.existing || null;
  const nextGold =
    input.goldEntryDate !== undefined
      ? input.goldEntryDate
      : existing?.goldEntryDate ?? null;
  const nextSilver =
    input.silverEntryDate !== undefined
      ? input.silverEntryDate
      : existing?.silverEntryDate ?? null;

  const wantsGold = hasDateValue(nextGold);
  if (!wantsGold) return null;

  const alreadyGold = hasDateValue(existing?.goldEntryDate);
  if (alreadyGold) return null;

  const silverOk =
    hasDateValue(nextSilver) ||
    hasDateValue(existing?.silverEntryDate) ||
    isInSgSeries({
      currentFleet: input.currentFleet ?? existing?.currentFleet,
      goldEntryDate: existing?.goldEntryDate,
      silverEntryDate: existing?.silverEntryDate,
    });

  // Prefer explicit silver date for first gold promotion
  if (!hasDateValue(nextSilver) && !hasDateValue(existing?.silverEntryDate)) {
    return "Gold fleet requires Silver history first. Admit the sailor as Silver (set Silver entry date), then set Gold entry.";
  }
  if (!silverOk) {
    return "Gold fleet requires Silver history first. Admit the sailor as Silver (set Silver entry date), then set Gold entry.";
  }
  return null;
}

/**
 * Normalize multi-year overseas representation input.
 * Accepts "2023", "2023, 2025", "2023/2025", or a single number.
 * Returns sorted unique years as "2023, 2025" or null.
 */
export function normalizeYearsList(v: unknown): string | null {
  if (v == null || v === "") return null;
  if (typeof v === "number" && Number.isFinite(v)) {
    const y = Math.round(v);
    if (y >= 1990 && y <= 2100) return String(y);
    return null;
  }
  const years = String(v).match(/\b(19|20)\d{2}\b/g);
  if (!years?.length) return null;
  const unique = Array.from(new Set(years.map((y) => Number(y))))
    .filter((y) => y >= 1990 && y <= 2100)
    .sort((a, b) => a - b);
  return unique.length ? unique.join(", ") : null;
}

export function formatYearsDisplay(v: unknown): string {
  const n = normalizeYearsList(v);
  return n || "—";
}

/** Map common Postgres / schema errors to actionable admin messages */
export function sailorDbErrorHint(err: unknown): string | null {
  const msg = err instanceof Error ? err.message : String(err ?? "");
  if (/nationality/i.test(msg) && /column|does not exist/i.test(msg)) {
    return "Database missing nationality column. In Supabase SQL Editor run: ALTER TABLE public.sailors ADD COLUMN IF NOT EXISTS nationality text;";
  }
  if (
    /(school|current_fleet)/i.test(msg) &&
    /column|does not exist/i.test(msg)
  ) {
    return "Database missing school/fleet columns. Run migration 002_sailor_school_fleet.sql in Supabase.";
  }
  if (/manually_dropped/i.test(msg) && /column|does not exist/i.test(msg)) {
    return "manually_dropped was removed. Run migration 020_drop_manually_dropped.sql in Supabase.";
  }
  if (/nett_score/i.test(msg) && /integer|type|numeric/i.test(msg)) {
    return "Run migration 003: ALTER TABLE regatta_results ALTER COLUMN nett_score TYPE real;";
  }
  if (
    /(worlds|european|asian|sea_games).*integer|invalid input syntax for type integer/i.test(
      msg
    )
  ) {
    return "Overseas years need text columns. Run migration 006_overseas_years_text.sql in Supabase.";
  }
  return null;
}
