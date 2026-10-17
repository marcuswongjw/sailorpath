import { ordinal } from "@/lib/profileAnalytics";

export type ResultsBioRow = {
  regattaName?: string | null;
  regattaDate?: string | null;
  boatClass?: string | null;
  rank?: number | null;
  isDns?: boolean | null;
  fleetSize?: number | null;
};

type NamedResult = {
  name: string;
  date: string;
  boatClass: string;
  rank: number;
  dns: boolean;
  fleetSize: number;
};

type Finish = {
  rank: number;
  event: string;
  date: string;
  boatClass: string;
  fleetSize: number;
};

function ymd(value: string | null | undefined): string {
  const text = String(value || "").slice(0, 10);
  return /^\d{4}-\d{2}-\d{2}$/.test(text) ? text : "";
}

function formatDate(value: string): string {
  const months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"];
  const [year, month, day] = value.split("-").map(Number);
  const label = months[month - 1];
  if (!label || !day || !year) return value;
  return `${day} ${label} ${year}`;
}

function joinAnd(items: string[]): string {
  if (items.length <= 1) return items[0] || "";
  if (items.length === 2) return `${items[0]} and ${items[1]}`;
  return `${items.slice(0, -1).join(", ")}, and ${items[items.length - 1]}`;
}

function namedResults(rows: readonly ResultsBioRow[]): NamedResult[] {
  return rows
    .map((row) => ({
      name: String(row.regattaName || "").trim(),
      date: ymd(row.regattaDate),
      boatClass: String(row.boatClass || "").trim().replace(/\s+/g, " "),
      rank: Number(row.rank),
      dns: Boolean(row.isDns),
      fleetSize: Number(row.fleetSize),
    }))
    .filter((row) => row.name);
}

function betterFinish(candidate: Finish, current: Finish): boolean {
  if (candidate.rank !== current.rank) return candidate.rank < current.rank;
  if (candidate.date && !current.date) return true;
  if (candidate.date && current.date) return candidate.date < current.date;
  return false;
}

function placeText(finish: Finish, withClass: boolean): string {
  const ofFleet = finish.fleetSize >= finish.rank ? ` of ${finish.fleetSize}` : "";
  const inClass = withClass && finish.boatClass ? ` in ${finish.boatClass}` : "";
  return `${ordinal(finish.rank)}${ofFleet}${inClass} at ${finish.event}`;
}

/** One public paragraph from a sailor's own results. Returns null when there is nothing to say. */
export function buildSailorResultsBio(
  name: string,
  rows: readonly ResultsBioRow[]
): string | null {
  const results = namedResults(rows);
  if (!results.length) return null;

  const chronological = [...results].sort(
    (a, b) => a.date.localeCompare(b.date) || a.name.localeCompare(b.name)
  );
  const first = chronological.find((row) => row.date) || chronological[0];

  const classes: string[] = [];
  const seenClass = new Set<string>();
  for (const row of chronological) {
    const key = row.boatClass.toLowerCase();
    if (!key || seenClass.has(key)) continue;
    seenClass.add(key);
    classes.push(row.boatClass);
  }

  const bestByClass = new Map<string, Finish>();
  for (const row of results) {
    if (row.dns || !Number.isFinite(row.rank) || row.rank < 1) continue;
    const key = row.boatClass.toLowerCase() || "class";
    const candidate: Finish = {
      rank: Math.floor(row.rank),
      event: row.name,
      date: row.date,
      boatClass: row.boatClass,
      fleetSize: Number.isFinite(row.fleetSize) ? Math.floor(row.fleetSize) : 0,
    };
    const current = bestByClass.get(key);
    if (!current || betterFinish(candidate, current)) bestByClass.set(key, candidate);
  }
  const finishes = [...bestByClass.values()].sort(
    (a, b) => a.rank - b.rank || a.date.localeCompare(b.date) || a.boatClass.localeCompare(b.boatClass)
  );

  const sailor = name.trim() || "This sailor";
  const firstDate = first.date ? ` on ${formatDate(first.date)}` : "";
  const sentences = [`${sailor} first raced at ${first.name}${firstDate}.`];
  if (classes.length === 1) sentences.push(`Class sailed: ${classes[0]}.`);
  else if (classes.length > 1) sentences.push(`Classes sailed: ${joinAnd(classes)}.`);

  if (finishes.length === 1) {
    sentences.push(`Best finish: ${placeText(finishes[0], classes.length > 1)}.`);
  } else if (finishes.length > 1) {
    sentences.push(`Best finishes: ${joinAnd(finishes.slice(0, 3).map((finish) => placeText(finish, true)))}.`);
  }

  return sentences.join(" ");
}
