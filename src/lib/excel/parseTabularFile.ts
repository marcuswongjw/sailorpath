const UNSAFE_HEADER_NAMES = new Set([
  "__proto__",
  "constructor",
  "prototype",
]);

function isBlankRow(row: readonly unknown[]): boolean {
  return row.every(
    (cell) => cell == null || String(cell).trim().length === 0
  );
}

/**
 * Convert a header row plus data rows into records without invoking setters on
 * Object.prototype. Blank and duplicate headers are ignored, as are the
 * prototype-pollution keys that are unsafe if a record is later copied.
 */
export function tableRowsToRecords(
  rows: readonly (readonly unknown[])[]
): Record<string, unknown>[] {
  const headerIndex = rows.findIndex((row) => !isBlankRow(row));
  if (headerIndex < 0) return [];

  const seenHeaders = new Set<string>();
  const headers = rows[headerIndex].map((cell) => {
    const header = cell == null ? "" : String(cell).trim();
    const normalized = header.toLowerCase();
    if (
      !header ||
      UNSAFE_HEADER_NAMES.has(normalized) ||
      seenHeaders.has(header)
    ) {
      return null;
    }
    seenHeaders.add(header);
    return header;
  });

  if (!headers.some(Boolean)) return [];

  return rows.slice(headerIndex + 1).flatMap((row) => {
    if (isBlankRow(row)) return [];

    const record = Object.create(null) as Record<string, unknown>;
    headers.forEach((header, columnIndex) => {
      if (header) record[header] = row[columnIndex] ?? "";
    });
    return [record];
  });
}

/** Parse comma-separated text using RFC4180 quoting and CRLF rules. */
export function parseCsv(text: string): string[][] {
  const input = text.charCodeAt(0) === 0xfeff ? text.slice(1) : text;
  if (!input) return [];

  const rows: string[][] = [];
  let row: string[] = [];
  let field = "";
  let inQuotes = false;
  let closedQuote = false;

  const finishRow = () => {
    row.push(field);
    rows.push(row);
    row = [];
    field = "";
    closedQuote = false;
  };

  for (let index = 0; index < input.length; index += 1) {
    const character = input[index];

    if (inQuotes) {
      if (character === '"') {
        if (input[index + 1] === '"') {
          field += '"';
          index += 1;
        } else {
          inQuotes = false;
          closedQuote = true;
        }
      } else {
        field += character;
      }
      continue;
    }

    if (closedQuote) {
      if (character === ",") {
        row.push(field);
        field = "";
        closedQuote = false;
        continue;
      }
      if (character === "\r" || character === "\n") {
        finishRow();
        if (character === "\r" && input[index + 1] === "\n") index += 1;
        continue;
      }
      throw new Error(
        `Invalid CSV: unexpected character after a closing quote at position ${index + 1}.`
      );
    }

    if (character === '"') {
      if (field.length > 0) {
        throw new Error(
          `Invalid CSV: unexpected quote at position ${index + 1}.`
        );
      }
      inQuotes = true;
      continue;
    }
    if (character === ",") {
      row.push(field);
      field = "";
      continue;
    }
    if (character === "\r" || character === "\n") {
      finishRow();
      if (character === "\r" && input[index + 1] === "\n") index += 1;
      continue;
    }
    field += character;
  }

  if (inQuotes) throw new Error("Invalid CSV: unterminated quoted field.");

  const endedWithLineBreak = /[\r\n]$/.test(input);
  if (!endedWithLineBreak || row.length > 0 || field.length > 0) {
    row.push(field);
    rows.push(row);
  }

  return rows;
}
