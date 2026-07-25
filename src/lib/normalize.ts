import { toYmd } from "./datesSg";

/** Parse numeric cells that may use comma separators. */
export function toNumber(v: unknown): number | null {
  if (v == null || v === "") return null;
  const n = typeof v === "number" ? v : Number(String(v).replace(/,/g, ""));
  return Number.isFinite(n) ? n : null;
}

/** Normalize sail number; empty / N/A → null. */
export function normalizeSailNumber(v: unknown): string | null {
  if (v == null || v === "") return null;
  const s = String(v).trim().replace(/\s+/g, " ");
  if (!s || /^n\/?a$/i.test(s) || s === "-" || s === "—") return null;
  return s;
}

/** Optional text fields (club, etc.). */
export function normalizeOptionalText(v: unknown): string | null {
  if (v == null || v === "") return null;
  const s = String(v).trim().replace(/\s+/g, " ");
  if (!s || /^n\/?a$/i.test(s) || s === "-" || s === "—") return null;
  return s;
}

/**
 * Accept full DOB (YYYY-MM-DD / Excel serial) or birth year only (2013).
 * Year-only becomes YYYY-01-01. Empty → null.
 */
export function normalizeDob(v: unknown): string | null {
  if (v == null || v === "") return null;
  if (typeof v === "number" && Number.isFinite(v)) {
    if (v >= 1990 && v <= 2035 && Number.isInteger(v)) {
      return `${v}-01-01`;
    }
    const epoch = Date.UTC(1899, 11, 30);
    const d = new Date(epoch + v * 86400000);
    if (!Number.isNaN(d.getTime())) return toYmd(d);
    return null;
  }
  const s = String(v).trim();
  if (!s) return null;
  if (/^\d{4}$/.test(s)) {
    const y = Number(s);
    if (y >= 1990 && y <= 2035) return `${y}-01-01`;
    return null;
  }
  if (/^\d{4}-\d{2}-\d{2}/.test(s)) return s.slice(0, 10);
  const m = s.match(/^(\d{1,2})[\/\-.](\d{1,2})[\/\-.](\d{4})$/);
  if (m) {
    const [, day, month, year] = m;
    return `${year}-${month.padStart(2, "0")}-${day.padStart(2, "0")}`;
  }
  return toYmd(s);
}

/**
 * Excel serial or ISO-ish date → YYYY-MM-DD (lenient for roster import).
 * Returns original string if unparseable (legacy AdminDashboard behavior).
 */
export function excelDateToIso(v: unknown): string | null {
  if (v == null || v === "") return null;
  if (typeof v === "number" && Number.isFinite(v)) {
    const epoch = new Date(Date.UTC(1899, 11, 30));
    const d = new Date(epoch.getTime() + v * 86400000);
    return toYmd(d);
  }
  const s = String(v).trim();
  if (!s) return null;
  if (/^\d{4}-\d{2}-\d{2}/.test(s)) return s.slice(0, 10);
  const m = s.match(/^(\d{1,2})[\/\-.](\d{1,2})[\/\-.](\d{4})$/);
  if (m) {
    const [, day, month, year] = m;
    return `${year}-${month.padStart(2, "0")}-${day.padStart(2, "0")}`;
  }
  return toYmd(s) || s;
}
