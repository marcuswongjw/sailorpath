/**
 * wingfoilExcel.ts
 *
 * Browser-safe parser for Sailwave Excel / CSV exports of WingFoil results.
 * Accepts .xlsx, .xls, and .csv files.
 *
 * Sailwave's typical export layout:
 *   Row 1-N:  Header metadata  (Event name, Date, Sailed, Discards, …)
 *   Row H:    Column headers   (Pos | HelmName | SailNo | Club | Division | R1 … Rn | Total | Nett)
 *   Row H+1…: Competitor rows  (one per sailor)
 *
 * Penalty codes appear as plain text: DNF, DNS, DSQ, DNC, RDG
 * Discarded scores are wrapped in parentheses: (3), (DNF)
 * The Gross/Nett columns at the right end are treated as ground truth totals.
 */

import type { ParsedWingfoilScreenshot } from "./wingfoilScreenshot";
import {
  recalculateScoreboard,
  type WingfoilSailorResult,
  type WingfoilRaceScore,
} from "./wingfoil";
import { KNOWN_SINGAPORE_WINGFOILERS } from "./wingfoilScreenshot";

// ── helpers ──────────────────────────────────────────────────────────────────

const PENALTY_CODES = ["DNF", "DNS", "DSQ", "DNC", "RDG"] as const;
type PenaltyCode = (typeof PENALTY_CODES)[number];

// Codes that exist in results but map to DNF for scoring
const DNF_ALIASES = ["OCS", "BFD", "UFD", "OCS", "RET"];

function isPenaltyCode(s: string): boolean {
  const up = s.trim().toUpperCase();
  return (PENALTY_CODES as readonly string[]).includes(up) || DNF_ALIASES.includes(up);
}

function toPenaltyCode(s: string): PenaltyCode {
  const up = s.trim().toUpperCase() as PenaltyCode;
  if ((PENALTY_CODES as readonly string[]).includes(up)) return up;
  return "DNF"; // alias OCS / BFD / UFD → DNF
}

/** Parse a single cell value like "3", "(5)", "DNF", "(DNF)", "5 DNF" */
function parseScoreCell(raw: unknown): WingfoilRaceScore | null {
  if (raw === null || raw === undefined || raw === "") return null;
  const cell = String(raw).trim();
  if (!cell) return null;

  const isDiscarded = cell.startsWith("(") && cell.endsWith(")");
  const inner = isDiscarded ? cell.slice(1, -1).trim() : cell;

  // Pure penalty code e.g. "DNF" or "(DNF)"
  if (isPenaltyCode(inner)) {
    return {
      score: 0, // will be recalculated by recalculateScoreboard
      isDiscarded,
      code: toPenaltyCode(inner),
    };
  }

  // "5 DNF" or "5 (DNF)" — sometimes Sailwave exports score + code together
  const mixed = inner.match(/^(\d+(?:\.\d+)?)\s+(DNF|DNS|DSQ|DNC|RDG|OCS|BFD|UFD)$/i);
  if (mixed) {
    return {
      score: Math.round(parseFloat(mixed[1])),
      isDiscarded,
      code: toPenaltyCode(mixed[2]),
    };
  }

  // Plain number
  const num = parseFloat(inner);
  if (!isNaN(num)) {
    return { score: Math.round(num), isDiscarded };
  }

  return null;
}

/** Try to extract a date string from a cell value */
function extractDate(val: unknown): string | null {
  if (!val) return null;
  // If xlsx returns a JS Date object
  if (val instanceof Date) {
    return val.toISOString().split("T")[0];
  }
  const s = String(val).trim();
  // ISO format
  if (/^\d{4}-\d{2}-\d{2}$/.test(s)) return s;
  // "7 September 2026" / "September 7, 2026"
  const months: Record<string, string> = {
    jan: "01", feb: "02", mar: "03", apr: "04", may: "05", jun: "06",
    jul: "07", aug: "08", sep: "09", oct: "10", nov: "11", dec: "12",
  };
  const m1 = s.match(/(\d{1,2})\s+([A-Za-z]+)\s+(\d{4})/);
  if (m1) {
    const mo = months[m1[2].slice(0, 3).toLowerCase()];
    if (mo) return `${m1[3]}-${mo}-${m1[1].padStart(2, "0")}`;
  }
  const m2 = s.match(/([A-Za-z]+)\s+(\d{1,2}),?\s+(\d{4})/);
  if (m2) {
    const mo = months[m2[1].slice(0, 3).toLowerCase()];
    if (mo) return `${m2[3]}-${mo}-${m2[2].padStart(2, "0")}`;
  }
  return null;
}

/** Normalise common Sailwave column header names */
const COL_ALIASES: Record<string, string> = {
  pos: "rank", place: "rank", position: "rank",
  helm: "name", helmname: "name", sailor: "name", sailorname: "name", firstname: "fname",
  lastname: "lname",
  sailno: "sailno", "sail no": "sailno", "sail#": "sailno", "sail number": "sailno",
  sailnumber: "sailno", rig: "sailno",
  club: "club", organisation: "club", org: "club",
  division: "division", fleet: "division", class: "division", category: "division",
  gender: "gender", sex: "gender",
  total: "gross", gross: "gross", pts: "gross", points: "gross",
  nett: "nett", net: "nett", netpts: "nett",
};

function normaliseHeader(h: string): string {
  const clean = h.toLowerCase().replace(/[^a-z0-9]/g, "");
  return COL_ALIASES[clean] ?? (clean.match(/^r(\d+)$/) ? `r${clean.slice(1)}` : clean);
}

// ── main export ───────────────────────────────────────────────────────────────

/**
 * Parse a Sailwave Excel (.xlsx/.xls) or CSV file into a ParsedWingfoilScreenshot.
 * Runs entirely in the browser — no server round-trip.
 *
 * @param file  The File object from an <input type="file"> element
 * @param onProgress  Optional progress callback (0.0 → 1.0)
 */
export async function readWingfoilExcel(
  file: File,
  onProgress?: (p: { status: string; progress: number }) => void
): Promise<ParsedWingfoilScreenshot> {
  onProgress?.({ status: "Reading file…", progress: 0.05 });

  // Dynamically import xlsx (SheetJS) — keeps it out of the initial bundle
  const XLSX = await import("xlsx");

  onProgress?.({ status: "Parsing spreadsheet…", progress: 0.2 });

  const buffer = await file.arrayBuffer();
  const workbook = XLSX.read(buffer, { type: "array", cellDates: true });

  // Use the first sheet
  const sheetName = workbook.SheetNames[0];
  if (!sheetName) throw new Error("No sheets found in the uploaded file.");

  const sheet = workbook.Sheets[sheetName];

  // Convert to row-of-arrays (raw, preserving dates as Date objects)
  const rows: unknown[][] = XLSX.utils.sheet_to_json(sheet, {
    header: 1,
    defval: "",
    raw: false,   // keep text as text (codes stay as "DNF" not numbers)
    dateNF: "yyyy-mm-dd",
  });

  onProgress?.({ status: "Scanning header rows…", progress: 0.35 });

  // ── 1. Scan for metadata in the first ~20 rows ────────────────────────────
  let regattaName = "";
  let startDate = "";
  let sailedCount = 0;
  let discardsCount = 1;

  for (let i = 0; i < Math.min(20, rows.length); i++) {
    const rowText = rows[i].map((c) => String(c ?? "").trim()).join(" ");

    if (!regattaName && /wingfoil|sprint|slalom|grand prix|monsoon|snsc/i.test(rowText)) {
      // Take the most descriptive cell in this row
      const best = rows[i]
        .map((c) => String(c ?? "").trim())
        .filter((c) => c.length > 5)
        .sort((a, b) => b.length - a.length)[0];
      if (best) regattaName = best;
    }

    const sailedM = rowText.match(/sailed[:\s]+(\d+)/i);
    if (sailedM) sailedCount = parseInt(sailedM[1], 10);

    const discardsM = rowText.match(/discards?[:\s]+(\d+)/i);
    if (discardsM) discardsCount = parseInt(discardsM[1], 10);

    if (!startDate) {
      for (const cell of rows[i]) {
        const d = extractDate(cell);
        if (d) { startDate = d; break; }
      }
    }
  }

  if (!regattaName) regattaName = file.name.replace(/\.[^.]+$/, "").replace(/[-_]/g, " ");
  if (!startDate) startDate = new Date().toISOString().split("T")[0];

  // ── 2. Find the header row (contains "Pos" or "HelmName" or "R1") ──────────
  onProgress?.({ status: "Finding column headers…", progress: 0.45 });

  let headerRowIdx = -1;
  let headers: string[] = [];

  for (let i = 0; i < Math.min(30, rows.length); i++) {
    const row = rows[i].map((c) => String(c ?? "").trim());
    const normalised = row.map(normaliseHeader);
    const hasRank = normalised.some((h) => h === "rank");
    const hasRace = normalised.some((h) => /^r\d+$/.test(h));
    const hasName = normalised.some((h) => h === "name" || h === "fname");
    if ((hasRank || hasRace) && hasName) {
      headerRowIdx = i;
      headers = normalised;
      break;
    }
  }

  if (headerRowIdx === -1) {
    throw new Error(
      "Could not find the results table header row. " +
      "Ensure the spreadsheet is a standard Sailwave export with columns like Pos, HelmName, SailNo, R1, R2… Total, Nett."
    );
  }

  // ── 3. Identify column indices ────────────────────────────────────────────
  const col = (key: string) => headers.indexOf(key);
  const rankCol   = col("rank");
  const nameCol   = col("name");
  const fnameCol  = col("fname");
  const lnameCol  = col("lname");
  const sailCol   = col("sailno");
  const clubCol   = col("club");
  const divCol    = col("division");
  const genderCol = col("gender");
  const grossCol  = col("gross");
  const nettCol   = col("nett");

  // Race columns: any header matching /^r\d+$/
  const raceCols = headers
    .map((h, i) => (/^r\d+$/.test(h) ? i : -1))
    .filter((i) => i >= 0);

  if (raceCols.length === 0) {
    throw new Error(
      "No race columns (R1, R2…) found. Check that the file uses standard Sailwave export format."
    );
  }

  if (sailedCount === 0) sailedCount = raceCols.length;

  // ── 4. Parse competitor rows ──────────────────────────────────────────────
  onProgress?.({ status: `Parsing ${rows.length - headerRowIdx - 1} competitor rows…`, progress: 0.6 });

  const results: WingfoilSailorResult[] = [];

  for (let i = headerRowIdx + 1; i < rows.length; i++) {
    const row = rows[i];
    if (!row || row.every((c) => !String(c ?? "").trim())) continue; // blank row

    // Rank — skip rows that don't look like competitor rows
    const rawRank = rankCol >= 0 ? String(row[rankCol] ?? "").trim() : "";
    const rank = parseInt(rawRank, 10);
    if (isNaN(rank) && !rawRank.match(/^\d/)) continue;

    // Name
    let name = "";
    if (nameCol >= 0) {
      name = String(row[nameCol] ?? "").trim();
    } else if (fnameCol >= 0 || lnameCol >= 0) {
      const f = fnameCol >= 0 ? String(row[fnameCol] ?? "").trim() : "";
      const l = lnameCol >= 0 ? String(row[lnameCol] ?? "").trim() : "";
      name = [f, l].filter(Boolean).join(" ");
    }
    if (!name) name = `Sailor ${i - headerRowIdx}`;

    // Sail number
    const sailNumber = sailCol >= 0 ? String(row[sailCol] ?? "").trim() : "";

    // Club
    const club = clubCol >= 0 ? String(row[clubCol] ?? "").trim() || "—" : "—";

    // Division / age category
    const divRaw = divCol >= 0 ? String(row[divCol] ?? "").trim() : "";
    const ageCategory = divRaw || "Open";

    // Gender — try column, then infer from known sailors or name
    let gender: "M" | "F" = "M";
    if (genderCol >= 0) {
      const g = String(row[genderCol] ?? "").trim().toUpperCase();
      if (g === "F" || g === "FEMALE") gender = "F";
    } else {
      const known = KNOWN_SINGAPORE_WINGFOILERS[sailNumber];
      if (known) {
        gender = known.gender;
        if (!name || name.startsWith("Sailor")) name = known.name;
      } else if (/^(kate|victoria|pandora|ange|sarah|emma|chloe)/i.test(name)) {
        gender = "F";
      }
    }

    // Override name from known sailors if sail number matches
    const known = KNOWN_SINGAPORE_WINGFOILERS[sailNumber];
    if (known && (!name || name === `Sailor ${i - headerRowIdx}`)) {
      name = known.name;
      gender = known.gender;
    }

    // Race scores
    const races: WingfoilRaceScore[] = raceCols.map((c) => {
      const parsed = parseScoreCell(row[c]);
      return parsed ?? { score: sailedCount > 10 ? 22 : 8, code: "DNF" };
    });

    // Gross / Nett totals
    const grossScore = grossCol >= 0 ? parseFloat(String(row[grossCol] ?? "0")) || 0 : 0;
    const nettScore  = nettCol  >= 0 ? parseFloat(String(row[nettCol]  ?? "0")) || 0 : 0;

    results.push({
      rank: isNaN(rank) ? results.length + 1 : rank,
      name,
      sailNumber,
      gender,
      ageCategory,
      schoolName: "—",
      club,
      races,
      grossScore,
      nettScore,
    });
  }

  if (results.length === 0) {
    throw new Error(
      "No competitor rows could be parsed. " +
      "Check that the spreadsheet follows the Sailwave export format."
    );
  }

  onProgress?.({ status: "Recalculating scoreboard…", progress: 0.85 });

  const recalculated = recalculateScoreboard(results, discardsCount);

  onProgress?.({ status: "Complete", progress: 1.0 });

  return {
    regattaName,
    startDate,
    sailedCount,
    discardsCount,
    scoringSystem: "World Sailing RRS Appendix A",
    results: recalculated,
    rawText: `[Parsed from Excel: ${file.name}]`,
  };
}
