/**
 * Parse regatta Excel file / sheet titles into import meta fields.
 *
 * Examples:
 *   "20230429 SAFYC Gold"     → date 2023-04-29, name "SAFYC Gold (Apr 23)", Gold
 *   "2023-04-29_CSC_Silver"  → date 2023-04-29, name "CSC Silver (Apr 23)", Silver
 *   "SAFYC Gold 20230429"    → same (date can trail the name)
 */

const MONTHS = [
  "Jan",
  "Feb",
  "Mar",
  "Apr",
  "May",
  "Jun",
  "Jul",
  "Aug",
  "Sep",
  "Oct",
  "Nov",
  "Dec",
] as const;

export type ParsedRegattaTitle = {
  /** YYYY-MM-DD when parsed */
  date: string | null;
  /** Display name e.g. "SAFYC Gold (Apr 23)" */
  name: string | null;
  /** Gold | Silver | Open when detected */
  division: string | null;
  /** ILCA 4 / Optimist when detected in title */
  boatClass: string | null;
  /** Raw stem after stripping extension */
  stem: string;
};

function stripExtension(filename: string): string {
  return String(filename || "")
    .trim()
    .replace(/\.[^.\\/]+$/i, "")
    .replace(/[_]+/g, " ")
    .replace(/\s+/g, " ")
    .trim();
}

/** Prefer compact YYYYMMDD; also accept YYYY-MM-DD / YYYY_MM_DD / YYYY.MM.DD */
function extractYmd(stem: string): { ymd: string; rest: string } | null {
  // Leading: 20230429 SAFYC Gold
  let m = stem.match(
    /^(\d{4})[-_./]?(\d{2})[-_./]?(\d{2})(?:\s+|[_-]+)(.+)$/i
  );
  if (m) {
    const ymd = `${m[1]}-${m[2]}-${m[3]}`;
    if (isValidYmd(ymd)) return { ymd, rest: m[4].trim() };
  }
  // Trailing: SAFYC Gold 20230429
  m = stem.match(
    /^(.+?)(?:\s+|[_-]+)(\d{4})[-_./]?(\d{2})[-_./]?(\d{2})$/i
  );
  if (m) {
    const ymd = `${m[2]}-${m[3]}-${m[4]}`;
    if (isValidYmd(ymd)) return { ymd, rest: m[1].trim() };
  }
  // Compact only
  m = stem.match(/^(\d{8})$/);
  if (m) {
    const y = m[1].slice(0, 4);
    const mo = m[1].slice(4, 6);
    const d = m[1].slice(6, 8);
    const ymd = `${y}-${mo}-${d}`;
    if (isValidYmd(ymd)) return { ymd, rest: "" };
  }
  return null;
}

function isValidYmd(ymd: string): boolean {
  if (!/^\d{4}-\d{2}-\d{2}$/.test(ymd)) return false;
  const [y, m, d] = ymd.split("-").map(Number);
  if (y < 1990 || y > 2040) return false;
  if (m < 1 || m > 12) return false;
  if (d < 1 || d > 31) return false;
  const dt = new Date(Date.UTC(y, m - 1, d));
  return (
    dt.getUTCFullYear() === y &&
    dt.getUTCMonth() === m - 1 &&
    dt.getUTCDate() === d
  );
}

function monthLabel(ymd: string): string {
  const m = Number(ymd.slice(5, 7));
  const y = ymd.slice(2, 4);
  const mon = MONTHS[m - 1] || ymd.slice(5, 7);
  return `${mon} ${y}`;
}

function detectDivision(text: string): string | null {
  if (/\bsilver\b/i.test(text)) return "Silver";
  if (/\bgold\b/i.test(text)) return "Gold";
  if (/\bopen\b/i.test(text) || /\bfleet\b/i.test(text)) return "Open";
  return null;
}

function detectBoatClass(text: string): string | null {
  if (/\bilca\s*4\b|\bilca4\b|\blaser\s*4\.?7\b/i.test(text)) return "ILCA 4";
  if (/\bilca\s*6\b|\bilca6\b|\bradial\b/i.test(text)) return "ILCA 6";
  if (/\boptimist\b|\bopti\b/i.test(text)) return "Optimist";
  return null;
}

/**
 * Clean remaining title text into a short event name (no date suffix yet).
 */
function cleanEventName(rest: string): string {
  let s = rest
    .replace(/[_]+/g, " ")
    .replace(/\s+/g, " ")
    .trim();
  // Drop redundant leading date fragments if any remain
  s = s.replace(/^\d{4}[-_./]?\d{2}[-_./]?\d{2}\s*/i, "").trim();
  return s;
}

/**
 * Parse a filename or sheet title into regatta import fields.
 */
export function parseRegattaTitle(filenameOrTitle: string): ParsedRegattaTitle {
  const stem = stripExtension(filenameOrTitle);
  if (!stem) {
    return {
      date: null,
      name: null,
      division: null,
      boatClass: null,
      stem: "",
    };
  }

  const extracted = extractYmd(stem);
  const date = extracted?.ymd ?? null;
  const rest = extracted ? extracted.rest : stem;
  const eventCore = cleanEventName(rest);
  const division = detectDivision(stem) || detectDivision(eventCore);
  const boatClass = detectBoatClass(stem) || detectBoatClass(eventCore);

  let name: string | null = null;
  if (eventCore && date) {
    // Avoid double suffix if already present
    if (/\([A-Za-z]{3}\s+\d{2}\)\s*$/.test(eventCore)) {
      name = eventCore;
    } else {
      name = `${eventCore} (${monthLabel(date)})`;
    }
  } else if (eventCore) {
    name = eventCore;
  } else if (date) {
    name = `Regatta (${monthLabel(date)})`;
  }

  return {
    date,
    name,
    division,
    boatClass,
    stem,
  };
}
