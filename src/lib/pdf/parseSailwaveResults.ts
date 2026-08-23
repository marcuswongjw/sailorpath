import {
  normalizeImportGender,
  parseOfficialRaceValue,
  type RegattaImportRow,
} from "@/lib/excel/parseRegattaResultsSheet";

export type PdfTextItem = { str: string; x: number; y: number };
export type PdfTextPage = {
  pageNumber: number;
  items: PdfTextItem[];
  text: string;
};

export type ParsedSailwavePdf = {
  rows: RegattaImportRow[];
  raceCount: number;
  entries: number | null;
  discards: number | null;
};

type Column = { key: string; x: number; raceNumber?: number };

const LINE_Y_TOLERANCE = 2;
const CONTINUATION_Y_GAP = 18;

function rowsByY(items: PdfTextItem[]) {
  const lines: PdfTextItem[][] = [];
  for (const item of [...items].sort((a, b) => b.y - a.y || a.x - b.x)) {
    if (!item.str.trim()) continue;
    const line = lines.find(
      (candidate) => Math.abs(candidate[0].y - item.y) <= LINE_Y_TOLERANCE
    );
    if (line) line.push(item);
    else lines.push([item]);
  }
  return lines.map((line) => line.sort((a, b) => a.x - b.x));
}

function headerColumns(line: PdfTextItem[]): Column[] | null {
  const columns: Column[] = [];
  for (const item of line) {
    const label = item.str.trim().replace(/\s+/g, " ");
    if (/^rank$/i.test(label)) columns.push({ key: "rank", x: item.x });
    else if (/^sail\s*(num\.?|no\.?|number)?$/i.test(label))
      columns.push({ key: "sailNumber", x: item.x });
    else if (/^name$/i.test(label)) columns.push({ key: "name", x: item.x });
    else if (/^age(?:\s*cat(?:egory)?)?$/i.test(label))
      columns.push({ key: "ageCategory", x: item.x });
    else if (/^(gender|sex)$/i.test(label))
      columns.push({ key: "gender", x: item.x });
    else if (/^sch(?:ool)?\s*cat(?:egory)?$/i.test(label) || /^sch$/i.test(label))
      columns.push({ key: "schoolCategory", x: item.x });
    else if (/^(sch(?:ool)?\s*name|school)$/i.test(label))
      columns.push({ key: "school", x: item.x });
    else if (/^(club|team)$/i.test(label))
      columns.push({ key: "club", x: item.x });
    else if (/^total$/i.test(label)) columns.push({ key: "total", x: item.x });
    else if (/^nett$/i.test(label)) columns.push({ key: "nett", x: item.x });
    else {
      const race = label.match(/^R(\d+)$/i);
      if (race)
        columns.push({ key: `race-${race[1]}`, raceNumber: Number(race[1]), x: item.x });
    }
  }
  // Some Sailwave PDFs paint the header twice with a sub-pixel vertical offset.
  // rowsByY deliberately groups those objects, so collapse identical columns here.
  const uniqueColumns = Array.from(
    new Map(columns.map((column) => [`${column.key}|${column.x.toFixed(2)}`, column])).values()
  );
  const keys = new Set(uniqueColumns.map((column) => column.key));
  return keys.has("rank") && keys.has("name") && keys.has("nett")
    ? uniqueColumns.sort((a, b) => a.x - b.x)
    : null;
}

function valueForColumn(line: PdfTextItem[], columns: Column[], index: number) {
  const left = index === 0 ? -Infinity : (columns[index - 1].x + columns[index].x) / 2;
  const right =
    index === columns.length - 1
      ? Infinity
      : (columns[index].x + columns[index + 1].x) / 2;
  return line
    .filter((item) => item.x >= left && item.x < right)
    .map((item) => item.str.trim())
    .filter(Boolean)
    .join(" ")
    .trim();
}

function optionalValue(value: string | undefined) {
  const cleaned = String(value || "").trim();
  return cleaned && !/^(?:n\/?a|none|-|—)$/i.test(cleaned) ? cleaned : null;
}

function validateParsedRows(
  rows: RegattaImportRow[],
  raceCount: number,
  entries: number | null,
  discards: number | null
) {
  if (entries != null && rows.length !== entries) {
    throw new Error(
      `PDF says there are ${entries} entries, but ${rows.length} result rows were extracted.`
    );
  }

  const ranks = rows.map((row) => row.rank).filter((rank): rank is number => rank != null);
  if (new Set(ranks).size !== ranks.length) {
    throw new Error("Duplicate competitor ranks were found in the PDF results table.");
  }

  for (const row of rows) {
    const label = row.name || `rank ${row.rank ?? "unknown"}`;
    const raceNumbers = row.races.map((race) => race.raceNumber);
    const uniqueRaceNumbers = new Set(raceNumbers);
    if (
      raceCount > 0 &&
      (uniqueRaceNumbers.size !== raceCount || raceNumbers.length !== raceCount)
    ) {
      throw new Error(
        `${label} has ${raceNumbers.length} extracted race scores; expected ${raceCount}.`
      );
    }
    if (raceCount > 0) {
      for (let raceNumber = 1; raceNumber <= raceCount; raceNumber++) {
        if (!uniqueRaceNumbers.has(raceNumber)) {
          throw new Error(`${label} is missing R${raceNumber}.`);
        }
      }
    }
    if (
      discards != null &&
      row.races.filter((race) => race.discarded).length !== discards
    ) {
      throw new Error(`${label} does not contain the expected ${discards} discard(s).`);
    }

    const scoreTotal = row.races.reduce((sum, race) => sum + race.score, 0);
    const discardedTotal = row.races.reduce(
      (sum, race) => sum + (race.discarded ? race.score : 0),
      0
    );
    if (row.total != null && Math.abs(row.total - scoreTotal) > 0.01) {
      throw new Error(`${label}'s race scores do not match the published total.`);
    }
    if (row.nett != null && Math.abs(row.nett - (scoreTotal - discardedTotal)) > 0.01) {
      throw new Error(`${label}'s race scores do not match the published nett score.`);
    }
  }
}

/** Parse text coordinates from a Sailwave-style published results PDF. */
export function parseSailwaveResults(pages: PdfTextPage[]): ParsedSailwavePdf {
  const rows: RegattaImportRow[] = [];
  let maxRace = 0;

  for (const page of pages) {
    const lines = rowsByY(page.items);
    let columns: Column[] | null = null;
    let currentRow: PdfTextItem[][] = [];
    let previousY: number | null = null;

    const flushRow = () => {
      if (!columns || currentRow.length === 0) return;
      const items = currentRow.flat();
      const values = Object.fromEntries(
        columns.map((column, index) => [column.key, valueForColumn(items, columns!, index)])
      );
      currentRow = [];
      previousY = null;
      if (!/^\d+(?:st|nd|rd|th)?$/i.test(values.rank || "") || !values.name) return;
      const numeric = (key: string) => {
        const match = String(values[key] || "").match(/-?\d+(?:\.\d+)?/);
        return match ? Number(match[0]) : null;
      };
      const races = columns
        .filter((column) => column.raceNumber)
        .map((column) => parseOfficialRaceValue(values[column.key], column.raceNumber!))
        .filter((race): race is NonNullable<typeof race> => race != null);
      rows.push({
        name: values.name.trim(),
        rank: numeric("rank"),
        nett: numeric("nett"),
        total: numeric("total"),
        club: optionalValue(values.club),
        school: optionalValue(values.school),
        nationality: null,
        gender: normalizeImportGender(values.gender),
        sailNumber: optionalValue(values.sailNumber),
        dob: null,
        birthYear: null,
        races,
      });
    };

    for (const line of lines) {
      const nextHeader = headerColumns(line);
      if (nextHeader) {
        flushRow();
        columns = nextHeader;
        for (const col of columns) maxRace = Math.max(maxRace, col.raceNumber || 0);
        continue;
      }
      if (!columns) continue;
      const lineText = line.map((item) => item.str.trim()).filter(Boolean).join(" ");
      if (/^(?:prizes|scoring codes?|created by sailwave)\b/i.test(lineText)) {
        flushRow();
        columns = null;
        continue;
      }

      const rankIndex = columns.findIndex((column) => column.key === "rank");
      const rankValue = valueForColumn(line, columns, rankIndex);
      if (/^\d+(?:st|nd|rd|th)?$/i.test(rankValue)) {
        flushRow();
        currentRow = [line];
        previousY = line[0].y;
      } else if (
        currentRow.length > 0 &&
        previousY != null &&
        previousY - line[0].y <= CONTINUATION_Y_GAP
      ) {
        currentRow.push(line);
        previousY = line[0].y;
      } else {
        flushRow();
      }
    }
    flushRow();
  }

  const allText = pages.map((page) => page.text).join("\n");
  const metadataNumber = (label: string) => {
    const match = allText.match(new RegExp(`${label}\\s*:\\s*(\\d+)`, "i"));
    return match ? Number(match[1]) : null;
  };
  const deduped = Array.from(
    new Map(rows.map((row) => [`${row.rank}|${row.sailNumber}|${row.name}`, row])).values()
  );
  const result = {
    rows: deduped,
    raceCount: metadataNumber("Sailed") || maxRace,
    entries: metadataNumber("Entries"),
    discards: metadataNumber("Discards"),
  };
  validateParsedRows(result.rows, result.raceCount, result.entries, result.discards);
  return result;
}
