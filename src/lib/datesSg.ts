/**
 * Singapore (UTC+8) date helpers for ranking and admin.
 * Prefer YYYY-MM-DD string compare for date-only DB fields (no TZ shift).
 */

export const SG_TIMEZONE = "Asia/Singapore";

/** Extract YYYY-MM-DD from Date/string; null if invalid. */
export function toYmd(v: unknown): string | null {
  if (v == null || v === "") return null;
  if (v instanceof Date && !Number.isNaN(v.getTime())) {
    // Format in Singapore calendar
    return formatYmdInSg(v);
  }
  const s = String(v).trim();
  if (/^\d{4}-\d{2}-\d{2}/.test(s)) return s.slice(0, 10);
  const t = Date.parse(s);
  if (!Number.isNaN(t)) return formatYmdInSg(new Date(t));
  return null;
}

/** Calendar date in Asia/Singapore as YYYY-MM-DD. */
export function formatYmdInSg(d: Date): string {
  try {
    const parts = new Intl.DateTimeFormat("en-CA", {
      timeZone: SG_TIMEZONE,
      year: "numeric",
      month: "2-digit",
      day: "2-digit",
    }).formatToParts(d);
    const y = parts.find((p) => p.type === "year")?.value;
    const m = parts.find((p) => p.type === "month")?.value;
    const day = parts.find((p) => p.type === "day")?.value;
    if (y && m && day) return `${y}-${m}-${day}`;
  } catch {
    /* fall through */
  }
  return d.toISOString().slice(0, 10);
}

/** Today in Singapore as YYYY-MM-DD. */
export function todayYmdSg(): string {
  return formatYmdInSg(new Date());
}

/**
 * Compare two date-only strings (YYYY-MM-DD).
 * Returns negative if a < b, 0 if equal, positive if a > b.
 */
export function compareYmd(a: string, b: string): number {
  return a.localeCompare(b);
}

export function ymdInRange(
  date: string | null | undefined,
  start: string,
  end: string
): boolean {
  const d = toYmd(date);
  if (!d) return false;
  return d >= start && d <= end;
}

/** Infer ranking half from a regatta/event date (Singapore calendar). */
export function periodHalfFromYmd(date: string | null | undefined): {
  year: number;
  half: "Jan-Jun" | "Jul-Dec";
} | null {
  const d = toYmd(date);
  if (!d) return null;
  const year = Number(d.slice(0, 4));
  const month = Number(d.slice(5, 7));
  if (!Number.isFinite(year) || !Number.isFinite(month)) return null;
  return {
    year,
    half: month <= 6 ? "Jan-Jun" : "Jul-Dec",
  };
}

/** Gold entry / drop dates are only offered from this year onward. */
export const HALF_BOUNDARY_MIN_YEAR = 2022;

/**
 * Gold entry and optimist drop dates must be half-year boundaries only:
 * 1 Jan or 1 Jul. That keeps period-level fleet resolve correct
 * (no mid-half gold promotion or mid-half drop ambiguity).
 */
export function isHalfBoundaryYmd(date: string | null | undefined): boolean {
  const d = toYmd(date);
  if (!d || !/^\d{4}-\d{2}-\d{2}$/.test(d)) return false;
  if (!(d.endsWith("-01-01") || d.endsWith("-07-01"))) return false;
  const y = Number(d.slice(0, 4));
  return Number.isFinite(y) && y >= HALF_BOUNDARY_MIN_YEAR;
}

/**
 * Validate gold entry / drop date. Empty/null is allowed (cleared).
 * Returns error message or null if OK.
 */
export function validateHalfBoundaryDate(
  date: string | null | undefined,
  fieldLabel = "Date"
): string | null {
  if (date == null || date === "") return null;
  const d = toYmd(date);
  if (!d) return `${fieldLabel} is invalid.`;
  if (!(d.endsWith("-01-01") || d.endsWith("-07-01"))) {
    return `${fieldLabel} must be 1 Jan or 1 Jul (half-year boundary), e.g. 2026-01-01 or 2026-07-01.`;
  }
  const y = Number(d.slice(0, 4));
  if (!Number.isFinite(y) || y < HALF_BOUNDARY_MIN_YEAR) {
    return `${fieldLabel} must be ${HALF_BOUNDARY_MIN_YEAR} or later (1 Jan / 1 Jul).`;
  }
  return null;
}

/** Select options: 1 Jan & 1 Jul for years [fromYear, toYear] inclusive, newest first. */
export function halfBoundaryOptions(
  fromYear = HALF_BOUNDARY_MIN_YEAR,
  toYear?: number
): { value: string; label: string }[] {
  const end =
    toYear ??
    Number(todayYmdSg().slice(0, 4)) + 2;
  const start = Math.max(fromYear, HALF_BOUNDARY_MIN_YEAR);
  const out: { value: string; label: string }[] = [];
  for (let y = end; y >= start; y--) {
    out.push({
      value: `${y}-07-01`,
      label: `1 Jul ${y} (start Jul–Dec)`,
    });
    out.push({
      value: `${y}-01-01`,
      label: `1 Jan ${y} (start Jan–Jun)`,
    });
  }
  return out;
}

/** Current ranking half from Singapore today. */
export function currentPeriodFromSgToday(): {
  year: number;
  half: "Jan-Jun" | "Jul-Dec";
} {
  const half = periodHalfFromYmd(todayYmdSg());
  if (half) return half;
  const y = new Date().getFullYear();
  return { year: y, half: "Jan-Jun" };
}

export type RankingPeriodOption = {
  period: { year: number; half: "Jan-Jun" | "Jul-Dec" };
  label: string;
  isCurrent: boolean;
};

/**
 * Recent half-years for period pickers, newest first.
 * Marks the half that contains Singapore today as "(Current)".
 */
export function rankingPeriodOptions(
  halfCount = 6
): RankingPeriodOption[] {
  const current = currentPeriodFromSgToday();
  const out: RankingPeriodOption[] = [];
  let year = current.year;
  let half: "Jan-Jun" | "Jul-Dec" = current.half;
  for (let i = 0; i < halfCount; i++) {
    const isCurrent = i === 0;
    const base =
      half === "Jan-Jun"
        ? `Jan – Jun ${year}`
        : `Jul – Dec ${year}`;
    out.push({
      period: { year, half },
      label: isCurrent ? `${base} (Current)` : base,
      isCurrent,
    });
    if (half === "Jul-Dec") {
      half = "Jan-Jun";
    } else {
      half = "Jul-Dec";
      year -= 1;
    }
  }
  return out;
}
