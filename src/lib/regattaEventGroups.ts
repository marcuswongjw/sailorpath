import { isIlcaSeriesClass } from "@/lib/ilcaRanking";
import type { RegattaRecord } from "@/lib/ranking";
import {
  eventHubHref,
  findEventSliceForRegattaSlug,
  getRegattaEvent,
  type RegattaEventDef,
  type RegattaEventSliceDef,
} from "@/lib/regattaEvents";
import { sailingClassKeyOf } from "@/lib/classRegistry";

const MONTHS = "jan|feb|mar|apr|may|jun|jul|aug|sep|sept|oct|nov|dec";

/** Same physical regatta: cleaned name plus the calendar month of the results. */
export function regattaGroupKey(
  row: Pick<RegattaRecord, "name" | "date">
): string {
  const ym = String(row.date || "").slice(0, 7);
  const name = String(row.name || "")
    .toLowerCase()
    .replace(/\(.*?\)/g, " ")
    .replace(/\b(gold|silver|ilca\s*4|ilca4|ilca|laser|fleet|open|regatta)\b/g, " ")
    .replace(new RegExp(`\\b(?:${MONTHS})\\b`, "g"), " ")
    .replace(/\b20\d{2}\b/g, " ")
    .replace(/[^a-z0-9]+/g, " ")
    .replace(/\s+/g, " ")
    .trim();
  return `${name}|${ym}`;
}

export function groupSlug(key: string): string {
  return key.replace("|", "-").replace(/\s+/g, "-");
}

type Fleet =
  | "gold"
  | "silver"
  | "open"
  | "ilca4"
  | "ilca6"
  | "ilca7"
  | "wingfoil"
  | "techno293"
  | "iqfoil"
  | "windsurfing";

function compactClass(value: string): string {
  return value.toLowerCase().replace(/[\s._-]+/g, "");
}

function classBlob(row: Pick<RegattaRecord, "boatClass" | "name" | "slug">): string {
  return `${row.boatClass || ""} ${row.name || ""} ${row.slug || ""}`;
}

/**
 * WingFoil / Wing Foil / Wing.
 * Windsurfing is a different class. "wing" is not a substring of
 * "windsurfing", and a WingFoil check must not claim it.
 */
export function isWingfoilBoatClass(boatClass: string | null | undefined): boolean {
  const compact = compactClass(String(boatClass || ""));
  if (!compact || compact.includes("windsurf")) return false;
  return compact.includes("wingfoil") || compact.includes("wing");
}

function mentionsTechno(row: Pick<RegattaRecord, "boatClass" | "name" | "slug">): boolean {
  return compactClass(classBlob(row)).includes("techno");
}

function mentionsWindsurfing(
  row: Pick<RegattaRecord, "boatClass" | "name" | "slug">
): boolean {
  if (!compactClass(classBlob(row)).includes("windsurf")) return false;
  // WingFoil stays on its own boards. A windsurfing mention in the
  // event title must not reclassify that sheet.
  if (isWingfoilBoatClass(row.boatClass)) return false;
  return true;
}

function publicFleet(row: RegattaRecord): Fleet | null {
  const boat = String(row.boatClass || "");
  const classKey = sailingClassKeyOf(boat);
  if (isIlcaSeriesClass(boat, "ILCA 4")) return "ilca4";
  if (isIlcaSeriesClass(boat, "ILCA 6")) return "ilca6";
  if (isIlcaSeriesClass(boat, "ILCA 7")) return "ilca7";
  if (classKey === "wingfoil") return "wingfoil";
  // Techno 293 contains "29". Classify it before the 29er exclusion.
  if (classKey === "techno293" || mentionsTechno(row)) return "techno293";
  if (classKey === "iqfoil") return "iqfoil";
  if (classKey === "windsurfing" || mentionsWindsurfing(row)) return "windsurfing";
  const lower = boat.toLowerCase();
  if (
    lower.includes("ilca") ||
    lower.includes("laser") ||
    isWingfoilBoatClass(boat) ||
    lower.includes("29")
  ) {
    return null;
  }
  const blob = `${row.division || ""} ${row.name} ${row.slug}`.toLowerCase();
  if (blob.includes("silver")) return "silver";
  if (blob.includes("gold")) return "gold";
  return "open";
}

function fuller(current: RegattaRecord, next: RegattaRecord): RegattaRecord {
  const races = (next.raceCount ?? 0) - (current.raceCount ?? 0);
  if (races !== 0) return races > 0 ? next : current;
  const fleet = (next.totalFleetSize ?? 0) - (current.totalFleetSize ?? 0);
  if (fleet !== 0) return fleet > 0 ? next : current;
  return current.slug.length <= next.slug.length ? current : next;
}

/** Same fleet imported twice: keep the sheet named for this weekend. */
function preferLinkedSheet(
  current: RegattaRecord,
  next: RegattaRecord,
  eventSlug: string
): RegattaRecord {
  const fullerSheet = fuller(current, next);
  const racesTied = (next.raceCount ?? 0) === (current.raceCount ?? 0);
  const fleetTied = (next.totalFleetSize ?? 0) === (current.totalFleetSize ?? 0);
  if (!racesTied || !fleetTied) return fullerSheet;
  const named = (row: RegattaRecord) => row.slug.toLowerCase().startsWith(eventSlug);
  if (named(current) !== named(next)) return named(next) ? next : current;
  return fullerSheet;
}

function formatDay(ymd: string): string {
  const months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"];
  const [year, month, day] = ymd.slice(0, 10).split("-");
  const name = months[Number(month) - 1];
  if (!name || !day) return ymd;
  return `${Number(day)} ${name} ${year}`;
}

function sliceFor(fleet: Fleet, row: RegattaRecord): RegattaEventSliceDef {
  if (fleet === "ilca4") {
    return {
      key: "ilca-4",
      label: "ILCA 4",
      series: "ilca4",
      slugIncludes: [row.slug.toLowerCase()],
      prizeFleetName: "ILCA 4",
    };
  }
  if (fleet === "ilca6") {
    return {
      key: "ilca-6",
      label: "ILCA 6",
      series: "ilca6",
      slugIncludes: [row.slug.toLowerCase()],
      prizeFleetName: "ILCA 6",
    };
  }
  if (fleet === "ilca7") {
    return {
      key: "ilca-7",
      label: "ILCA 7",
      series: "ilca7",
      slugIncludes: [row.slug.toLowerCase()],
      prizeFleetName: "ILCA 7",
    };
  }
  if (fleet === "silver") {
    return {
      key: "optimist-silver",
      label: "Optimist Silver",
      series: "optimist",
      slugIncludes: [row.slug.toLowerCase()],
      prizeFleetName: "Optimist Silver Fleet",
    };
  }
  if (fleet === "gold") {
    return {
      key: "optimist-gold",
      label: "Optimist Gold",
      series: "optimist",
      slugIncludes: [row.slug.toLowerCase()],
      prizeFleetName: "Optimist Gold Fleet",
    };
  }
  if (fleet === "techno293") {
    return {
      key: "techno-293",
      label: "Techno 293",
      series: "techno293",
      slugIncludes: [row.slug.toLowerCase()],
      prizeFleetName: "Techno 293",
    };
  }
  if (fleet === "wingfoil") {
    return {
      key: "wingfoil",
      label: "WingFoil",
      series: "wingfoil",
      slugIncludes: [row.slug.toLowerCase()],
      prizeFleetName: "WingFoil",
    };
  }
  if (fleet === "iqfoil") {
    return {
      key: "iqfoil",
      label: "iQFOiL",
      series: "iqfoil",
      slugIncludes: [row.slug.toLowerCase()],
      prizeFleetName: "iQFOiL",
    };
  }
  if (fleet === "windsurfing") {
    const blob = classBlob(row).toLowerCase();
    const compact = compactClass(blob);
    const isLt =
      /\blt\b/.test(blob) ||
      compact.includes("windsurfinglt") ||
      compact.includes("windsurflt");
    return {
      key: isLt ? "windsurfing-lt" : "windsurfing",
      label: isLt ? "Windsurfing LT" : "Windsurfing",
      series: "windsurfing",
      slugIncludes: [row.slug.toLowerCase()],
      prizeFleetName: isLt ? "Windsurfing LT" : "Windsurfing",
    };
  }
  return {
    key: "optimist",
    label: "Optimist",
    series: "optimist",
    slugIncludes: [row.slug.toLowerCase()],
    prizeFleetName: "Optimist Gold Fleet",
  };
}

const FLEET_ORDER: Fleet[] = [
  "gold",
  "silver",
  "open",
  "ilca4",
  "ilca6",
  "ilca7",
  "wingfoil",
  "techno293",
  "iqfoil",
  "windsurfing",
];

/**
 * Tabs for a results row that is not already part of a registered event.
 * One class stays on its own page. Two or more classes share one hub.
 */
export function groupedHubForSlug(
  slug: string,
  regattas: RegattaRecord[]
): { event: RegattaEventDef; fleetKey: string | null } | null {
  const buckets = new Map<string, RegattaRecord[]>();
  for (const row of regattas) {
    if (findEventSliceForRegattaSlug(row.slug)) continue;
    if (!publicFleet(row)) continue;
    const key = regattaGroupKey(row);
    if (!key.split("|")[0] || key.startsWith("|")) continue;
    const list = buckets.get(key) || [];
    list.push(row);
    buckets.set(key, list);
  }

  const wanted = slug.toLowerCase();
  let matchKey = "";
  let bucket: RegattaRecord[] | undefined;
  for (const [key, list] of buckets) {
    if (groupSlug(key) === wanted || list.some((row) => row.slug.toLowerCase() === wanted)) {
      matchKey = key;
      bucket = list;
      break;
    }
  }
  if (!bucket || !matchKey) return null;

  const chosen = new Map<Fleet, RegattaRecord>();
  for (const row of bucket) {
    const fleet = publicFleet(row);
    if (!fleet) continue;
    const current = chosen.get(fleet);
    chosen.set(fleet, current ? fuller(current, row) : row);
  }
  const slices = FLEET_ORDER.filter((fleet) => chosen.has(fleet)).map((fleet) =>
    sliceFor(fleet, chosen.get(fleet)!)
  );
  if (slices.length < 2) return null;

  const named = [...chosen.values()][0];
  const dates = [...chosen.values()]
    .map((row) => String(row.date || "").slice(0, 10))
    .filter(Boolean)
    .sort();
  const event: RegattaEventDef = {
    slug: groupSlug(matchKey),
    name: named.name.replace(/\((gold|silver|ilca\s*4|ilca4|ilca)\)/gi, "").replace(/\s+/g, " ").trim(),
    shortName: named.name.replace(/\s+/g, " ").trim(),
    datesText: dates.length ? `${formatDay(dates[0])}${dates.at(-1) !== dates[0] ? ` – ${formatDay(dates.at(-1)!)}` : ""}` : "",
    venue: named.venue || "Singapore",
    organizer: named.organizer || "",
    noticeOfRaceUrl: named.norUrl || undefined,
    officialNoticeBoardUrl: named.norUrl || undefined,
    slices,
  };
  const focus = slices.find((slice) => slice.slugIncludes?.[0] === wanted);
  return { event, fleetKey: focus?.key ?? null };
}

function eventDatesText(rows: RegattaRecord[]): string {
  const starts = rows
    .map((row) => String(row.date || "").slice(0, 10))
    .filter(Boolean)
    .sort();
  const ends = rows
    .map((row) => String(row.endDate || row.date || "").slice(0, 10))
    .filter(Boolean)
    .sort();
  if (!starts.length) return "";
  const start = formatDay(starts[0]);
  const end = formatDay(ends.at(-1) || starts.at(-1)!);
  return start === end ? start : `${start} – ${end}`;
}

/**
 * A saved weekend and its class sheets share one public page.
 * The page slug is the weekend slug, not a separate name-and-month slug.
 */
export function savedEventHubForSlug(
  slug: string,
  regattas: RegattaRecord[]
): { event: RegattaEventDef; fleetKey: string | null } | null {
  const wanted = slug.toLowerCase();
  const self = regattas.find((row) => row.slug.toLowerCase() === wanted);
  const eventSlug = (
    regattas.find((row) => row.eventSlug?.toLowerCase() === wanted)?.eventSlug ||
    self?.eventSlug ||
    ""
  ).toLowerCase();
  if (!eventSlug || getRegattaEvent(eventSlug)) return null;

  const linked = regattas.filter(
    (row) =>
      row.eventSlug?.toLowerCase() === eventSlug &&
      publicFleet(row) &&
      !findEventSliceForRegattaSlug(row.slug)
  );
  if (!linked.length) return null;

  const chosen = new Map<Fleet, RegattaRecord>();
  for (const row of linked) {
    const fleet = publicFleet(row);
    if (!fleet) continue;
    const current = chosen.get(fleet);
    chosen.set(fleet, current ? preferLinkedSheet(current, row, eventSlug) : row);
  }
  const slices = FLEET_ORDER.filter((fleet) => chosen.has(fleet)).map((fleet) =>
    sliceFor(fleet, chosen.get(fleet)!)
  );
  if (!slices.length) return null;

  const sample = [...chosen.values()][0];
  const name =
    sample.eventName?.trim() ||
    sample.name.replace(/\(.*?\)/g, " ").replace(/\s+/g, " ").trim();
  const event: RegattaEventDef = {
    slug: eventSlug,
    name,
    shortName: name,
    datesText: eventDatesText([...chosen.values()]),
    venue: sample.venue || "Singapore",
    organizer: sample.organizer || "",
    noticeOfRaceUrl: sample.norUrl || undefined,
    officialNoticeBoardUrl: sample.norUrl || undefined,
    slices,
  };
  const exact = slices.find((slice) => slice.slugIncludes?.[0] === wanted);
  const requestedFleet =
    self?.eventSlug?.toLowerCase() === eventSlug ? publicFleet(self) : null;
  const focus =
    exact ||
    (requestedFleet
      ? slices.find((slice) => slice.key === sliceFor(requestedFleet, self!).key)
      : undefined);
  return { event, fleetKey: focus?.key ?? null };
}

function classFamiliesInSlug(slug: string): string[] {
  const families: string[] = [];
  if (/ilca-?4/.test(slug)) families.push("ilca-4");
  else if (/ilca-?6/.test(slug)) families.push("ilca-6");
  else if (/ilca-?7/.test(slug)) families.push("ilca-7");
  else if (slug.includes("ilca")) families.push("ilca");
  if (slug.includes("29er")) families.push("29er");
  if (slug.includes("wingfoil") || slug.includes("wing-foil")) families.push("wingfoil");
  if (slug.includes("techno")) families.push("techno");
  if (slug.includes("iqfoil")) families.push("iqfoil");
  if (slug.includes("gold")) families.push("gold");
  if (slug.includes("silver")) families.push("silver");
  if (slug.includes("optimist") && !families.includes("gold") && !families.includes("silver")) {
    families.push("optimist");
  }
  return families;
}

function preferredSliceKeys(family: string): string[] {
  switch (family) {
    case "ilca-4":
      return ["ilca-4"];
    case "ilca-6":
      return ["ilca-6"];
    case "ilca-7":
      return ["ilca-7"];
    case "gold":
      return ["optimist-gold", "gold"];
    case "silver":
      return ["optimist-silver", "silver"];
    case "29er":
      return ["29er"];
    case "wingfoil":
      return ["wingfoil"];
    case "techno":
      return ["techno-293"];
    case "iqfoil":
      return ["iqfoil"];
    default:
      return [];
  }
}

/**
 * A class alias such as `…-ilca4` keeps its fleet tab.
 * The event slug itself, and aliases that name more than one class, stay on the bare hub.
 */
function fleetKeyForAliasedClassSlug(slug: string, event: RegattaEventDef): string | null {
  const families = classFamiliesInSlug(slug);
  if (families.length !== 1) return null;
  const preferred = preferredSliceKeys(families[0]);
  if (!preferred.length) return null;

  const slice = findEventSliceForRegattaSlug(slug);
  if (slice && slice.event.slug === event.slug && preferred.includes(slice.slice.key)) {
    return slice.slice.key;
  }
  return event.slices.find((candidate) => preferred.includes(candidate.key))?.key ?? null;
}

/** Class result URLs for a multi-class regatta open the shared tabbed page. */
export function hubHrefForClassSlug(
  slug: string,
  regattas: RegattaRecord[]
): string | null {
  const requested = slug.toLowerCase();
  const direct = getRegattaEvent(slug);
  if (direct) {
    if (direct.slug !== requested) {
      const fleetKey = fleetKeyForAliasedClassSlug(requested, direct);
      if (fleetKey) return eventHubHref(direct.slug, fleetKey);
    }
    return `/regattas/${direct.slug}`;
  }
  const slice = findEventSliceForRegattaSlug(slug);
  if (slice) return eventHubHref(slice.event.slug, slice.slice.key);
  const saved = savedEventHubForSlug(slug, regattas);
  if (saved) {
    return eventHubHref(
      saved.event.slug,
      saved.fleetKey || saved.event.slices[0]?.key || "optimist"
    );
  }
  const grouped = groupedHubForSlug(slug, regattas);
  if (!grouped) return null;
  return eventHubHref(
    grouped.event.slug,
    grouped.fleetKey || grouped.event.slices[0]?.key || "optimist"
  );
}
