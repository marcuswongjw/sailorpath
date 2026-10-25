export type CalendarDownloadEvent = {
  slug: string;
  name: string;
  startDate: string;
  endDate?: string | null;
  venue?: string | null;
};

function dateValue(value: string): string | null {
  if (!/^\d{4}-\d{2}-\d{2}$/.test(value)) return null;
  const date = new Date(`${value}T00:00:00Z`);
  return Number.isFinite(date.getTime()) && date.toISOString().slice(0, 10) === value ? value : null;
}

export function eventIcs(event: CalendarDownloadEvent, now = new Date()): string | null {
  const start = dateValue(event.startDate);
  const end = dateValue(event.endDate || event.startDate);
  if (!start || !end || end < start) return null;
  const exclusiveEnd = new Date(`${end}T00:00:00Z`);
  exclusiveEnd.setUTCDate(exclusiveEnd.getUTCDate() + 1);
  const escape = (value: string) => value.replace(/\\/g, "\\\\").replace(/\r?\n/g, "\\n").replace(/;/g, "\\;").replace(/,/g, "\\,");
  const lines = [
    "BEGIN:VCALENDAR", "VERSION:2.0", "PRODID:-//SailorPath//Regatta Calendar//EN", "CALSCALE:GREGORIAN",
    "BEGIN:VEVENT", `UID:${escape(event.slug)}@sailorpath.com`,
    `DTSTAMP:${now.toISOString().replace(/[-:]/g, "").slice(0, 15)}Z`,
    `DTSTART;VALUE=DATE:${start.replace(/-/g, "")}`,
    `DTEND;VALUE=DATE:${exclusiveEnd.toISOString().slice(0, 10).replace(/-/g, "")}`,
    `SUMMARY:${escape(event.name)}`, `LOCATION:${escape(event.venue || "")}`,
    `URL:https://sailorpath.com/regattas/${encodeURIComponent(event.slug)}`, "END:VEVENT", "END:VCALENDAR",
  ];
  // RFC 5545 limits content lines to 75 octets, with continuation whitespace.
  return lines.map((line) => {
    const parts: string[] = [];
    let part = "";
    let bytes = 0;
    for (const char of line) {
      const length = new TextEncoder().encode(char).length;
      if (bytes + length > 75) { parts.push(part); part = " "; bytes = 1; }
      part += char;
      bytes += length;
    }
    parts.push(part);
    return parts.join("\r\n");
  }).join("\r\n") + "\r\n";
}
