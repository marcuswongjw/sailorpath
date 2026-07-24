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
