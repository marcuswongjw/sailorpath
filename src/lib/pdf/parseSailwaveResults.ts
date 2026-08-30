import {
  normalizeImportGender,
  inferLikelyDnsRows,
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
  /** Published result rows with no competitor name; retained in fleet size only. */
  unnamedEntries: number;
};

type Column = { key: string; x: number; raceNumber?: number };

const LINE_Y_TOLERANCE = 2;
const CONTINUATION_Y_GAP = 22;

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
    const label = item.str.trim().replace(/^\|+|\|+$/g, "").replace(/\s+/g, " ");
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
      // OCR commonly reads the digit 5 as S in a compact R5 heading.
      const race = label.match(/^R(\d+|S)$/i);
      if (race)
        columns.push({
          key: `race-${race[1]}`,
          raceNumber: /^s$/i.test(race[1]) ? 5 : Number(race[1]),
          x: item.x,
        });
    }
  }
  // Some Sailwave PDFs paint the header twice with a sub-pixel vertical offset.
  // rowsByY deliberately groups those objects, so collapse identical columns here.
  let uniqueColumns = Array.from(
    new Map(columns.map((column) => [`${column.key}|${column.x.toFixed(2)}`, column])).values()
  ).sort((a, b) => a.x - b.x);
  const raceColumns = uniqueColumns.filter((column) => column.raceNumber != null);
  if (
    raceColumns.length >= 2 &&
    raceColumns.some((column, index) => column.raceNumber !== index + 1)
  ) {
    // Repeated/misread OCR headings (for example R11 → R1) are unambiguous by
    // their left-to-right position in a Sailwave table.
    const inferred = new Map(
      raceColumns.map((column, index) => [column, index + 1])
    );
    uniqueColumns = uniqueColumns.map((column) => {
      const raceNumber = inferred.get(column);
      return raceNumber == null
        ? column
        : { ...column, key: `race-${raceNumber}`, raceNumber };
    });
  }
  const keys = new Set(uniqueColumns.map((column) => column.key));
  return keys.has("rank") && keys.has("name") && keys.has("nett")
    ? uniqueColumns
    : null;
}

function isRankValue(value: string | undefined) {
  return /^\s*\d+(?:st|nd|rd|th)?(?:\s*[|.:])?\s*$/i.test(value || "");
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

function reconcileOcrDecimalScores(
  races: RegattaImportRow["races"],
  total: number | null
) {
  if (total == null) return races;
  const options = races.map((race) => {
    const raw = race.rawValue.trim();
    const digits = raw.match(/^\D*(\d+0)\D*$/)?.[1];
    return digits && !raw.includes(".") && race.score >= 10
      ? [race.score / 10, race.score]
      : [race.score];
  });
  let resolved: number[] | null = null;

  const visit = (index: number, scores: number[], sum: number) => {
    if (resolved || sum > total + 0.01) return;
    if (index === races.length) {
      if (Math.abs(sum - total) <= 0.01) {
        resolved = scores;
      }
      return;
    }
    for (const score of options[index]) {
      visit(index + 1, [...scores, score], sum + score);
    }
  };
  visit(0, [], 0);
  return resolved
    ? races.map((race, index) => ({ ...race, score: resolved![index] }))
    : races;
}

function reconcilePublishedDiscards(
  row: RegattaImportRow,
  discardCount: number | null
): RegattaImportRow {
  if (discardCount == null || row.total == null || row.nett == null) return row;
  const target = row.total - row.nett;
  let selected: number[] | null = null;
  let bestExistingMatches = -1;

  const visit = (start: number, indices: number[], sum: number) => {
    if (indices.length === discardCount) {
      if (Math.abs(sum - target) > 0.01) return;
      const existingMatches = indices.filter(
        (index) => row.races[index].discarded
      ).length;
      if (existingMatches > bestExistingMatches) {
        selected = indices;
        bestExistingMatches = existingMatches;
      }
      return;
    }
    for (let index = start; index < row.races.length; index++) {
      visit(index + 1, [...indices, index], sum + row.races[index].score);
    }
  };
  visit(0, [], 0);
  if (!selected) return row;
  const selectedSet = new Set<number>(selected);
  return {
    ...row,
    races: row.races.map((race, index) => ({
      ...race,
      discarded: selectedSet.has(index),
    })),
  };
}

function validateParsedRows(
  rows: RegattaImportRow[],
  raceCount: number,
  entries: number | null,
  discards: number | null,
  unnamedEntries: number
) {
  if (entries != null && rows.length + unnamedEntries !== entries) {
    throw new Error(
      `PDF says there are ${entries} entries, but ${rows.length + unnamedEntries} result rows were extracted.`
    );
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
  let unnamedEntries = 0;

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
      if (!isRankValue(values.rank)) return;
      if (!values.name) {
        // Sailwave may publish a registered boat with no sailor name. It still
        // counts toward fleet size and DNS scoring, but must not create a fake profile.
        unnamedEntries += 1;
        return;
      }
      const numeric = (key: string) => {
        const match = String(values[key] || "").match(/-?\d+(?:\.\d+)?/);
        return match ? Number(match[0]) : null;
      };
      const parsedRaces = columns
        .filter((column) => column.raceNumber)
        .map((column) =>
          parseOfficialRaceValue(
            // OCR often turns a table border into a leading [ or |. Sailwave
            // marks real discards with parentheses, which must be preserved.
            String(values[column.key] || "").replace(/^\s*[|[]+\s*/, ""),
            column.raceNumber!
          )
        )
        .filter((race): race is NonNullable<typeof race> => race != null);
      const total = numeric("total");
      const nett = numeric("nett");
      const races = reconcileOcrDecimalScores(parsedRaces, total);
      rows.push({
        name: values.name.replace(/^\s*[|]+\s*/, "").trim(),
        rank: numeric("rank"),
        nett,
        total,
        club: optionalValue(values.club),
        school: optionalValue(values.school),
        nationality: null,
        gender: normalizeImportGender(values.gender),
        sailNumber: optionalValue(String(values.sailNumber || "").replace(/\|/g, " ")),
        dob: null,
        birthYear: null,
        isDns: false,
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
      if (isRankValue(rankValue)) {
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
  const discards = metadataNumber("Discards");
  const result = {
    rows: inferLikelyDnsRows(
      deduped.map((row) => reconcilePublishedDiscards(row, discards))
    ),
    raceCount: metadataNumber("Sailed") || maxRace,
    entries: metadataNumber("Entries"),
    discards,
    unnamedEntries,
  };
  validateParsedRows(
    result.rows,
    result.raceCount,
    result.entries,
    result.discards,
    result.unnamedEntries
  );
  return result;
}
