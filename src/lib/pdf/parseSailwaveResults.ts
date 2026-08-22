import {
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

function rowsByY(items: PdfTextItem[]) {
  const lines: PdfTextItem[][] = [];
  for (const item of [...items].sort((a, b) => b.y - a.y || a.x - b.x)) {
    if (!item.str.trim()) continue;
    const line = lines.find((candidate) => Math.abs(candidate[0].y - item.y) <= 2);
    if (line) line.push(item);
    else lines.push([item]);
  }
  return lines.map((line) => line.sort((a, b) => a.x - b.x));
}

function headerColumns(line: PdfTextItem[]): Column[] | null {
  const columns: Column[] = [];
  for (const item of line) {
    const label = item.str.trim();
    if (/^rank$/i.test(label)) columns.push({ key: "rank", x: item.x });
    else if (/^sail\s*(num|no|number)?$/i.test(label))
      columns.push({ key: "sailNumber", x: item.x });
    else if (/^name$/i.test(label)) columns.push({ key: "name", x: item.x });
    else if (/^total$/i.test(label)) columns.push({ key: "total", x: item.x });
    else if (/^nett$/i.test(label)) columns.push({ key: "nett", x: item.x });
    else {
      const race = label.match(/^R(\d+)$/i);
      if (race)
        columns.push({ key: `race-${race[1]}`, raceNumber: Number(race[1]), x: item.x });
    }
  }
  const keys = new Set(columns.map((column) => column.key));
  return keys.has("rank") && keys.has("name") && keys.has("nett")
    ? columns.sort((a, b) => a.x - b.x)
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

/** Parse text coordinates from a Sailwave-style published results PDF. */
export function parseSailwaveResults(pages: PdfTextPage[]): ParsedSailwavePdf {
  const rows: RegattaImportRow[] = [];
  let maxRace = 0;

  for (const page of pages) {
    const lines = rowsByY(page.items);
    let columns: Column[] | null = null;
    for (const line of lines) {
      const nextHeader = headerColumns(line);
      if (nextHeader) {
        columns = nextHeader;
        for (const col of columns) maxRace = Math.max(maxRace, col.raceNumber || 0);
        continue;
      }
      if (!columns) continue;
      const values = Object.fromEntries(
        columns.map((column, index) => [column.key, valueForColumn(line, columns!, index)])
      );
      if (!/^\d+(?:st|nd|rd|th)?$/i.test(values.rank || "") || !values.name) continue;
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
        club: null,
        school: null,
        nationality: null,
        gender: null,
        sailNumber: values.sailNumber?.trim() || null,
        dob: null,
        birthYear: null,
        races,
      });
    }
  }

  const allText = pages.map((page) => page.text).join("\n");
  const metadataNumber = (label: string) => {
    const match = allText.match(new RegExp(`${label}\\s*:\\s*(\\d+)`, "i"));
    return match ? Number(match[1]) : null;
  };
  const deduped = Array.from(
    new Map(rows.map((row) => [`${row.rank}|${row.sailNumber}|${row.name}`, row])).values()
  );
  return {
    rows: deduped,
    raceCount: metadataNumber("Sailed") || maxRace,
    entries: metadataNumber("Entries"),
    discards: metadataNumber("Discards"),
  };
}
