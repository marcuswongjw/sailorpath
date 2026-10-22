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
  | "class-a"
  | "class-b"
  | "29er"
  | "windfoil"
  | "windsurfing-lt"
  | "silver"
  | "main"
  | "intermediate"
  | "green"
  | "newborn"
  | "boys"
  | "girls"
  | "alpha"
  | "bravo"
  | "charlie"
  | "open"
  | "ilca4"
  | "ilca6"
  | "ilca7"
  | "wingfoil"
  | "techno293"
  | "iqfoil"
  | "windsurfing"
  | "420";

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
  if (classKey === "420") return "420";
  if (classKey === "29er") return "29er";
  // Techno 293 contains "29". Classify it before the 29er exclusion.
  if (classKey === "techno293" || mentionsTechno(row)) return "techno293";
  if (classKey === "iqfoil") return "iqfoil";
  if (["windsurfing", "windsurfing-lt", "windfoil"].includes(classKey || "") || mentionsWindsurfing(row)) {
    const compact = compactClass(boat);
    if (compact.startsWith("windfoil")) return "windfoil";
    if (/\blt\b/i.test(boat) || compact.endsWith("lt")) return "windsurfing-lt";
    return "windsurfing";
  }
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
  if (classKey === "optimist") {
    const division = String(row.division || "").trim().toLowerCase();
    const classFleet = division.match(/^(?:optimist\s*)?class[\s_-]*([ab])$/)
      || blob.match(/\bclass[\s_-]*([ab])\b/);
    if (classFleet) return classFleet[1] === "a" ? "class-a" : "class-b";
    if (
      division === "main" || division === "intermediate" || division === "green" || division === "newborn" ||
      division === "boys" || division === "girls" ||
      division === "alpha" || division === "bravo" || division === "charlie"
    ) {
      return division;
    }
  }
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
  if (fleet === "class-a" || fleet === "class-b") {
    const label = `Optimist Class ${fleet.slice(-1).toUpperCase()}`;
    return { key: `optimist-${fleet}`, label, series: "optimist",
      slugIncludes: [row.slug.toLowerCase()], prizeFleetName: label };
  }
  if (fleet === "29er") {
    return { key: "29er", label: "29er", series: "29er",
      slugIncludes: [row.slug.toLowerCase()], prizeFleetName: "29er" };
  }
  if (fleet === "windfoil") {
    return { key: "windfoil", label: "Windfoil", series: "windsurfing",
      slugIncludes: [row.slug.toLowerCase()], prizeFleetName: "Windfoil" };
  }
  if (fleet === "420") {
    return {
      key: "420",
      label: "420",
      series: "420",
      slugIncludes: [row.slug.toLowerCase()],
      prizeFleetName: "420",
    };
  }
  if (
    fleet === "main" || fleet === "intermediate" || fleet === "green" || fleet === "newborn" ||
    fleet === "boys" || fleet === "girls" ||
    fleet === "alpha" || fleet === "bravo" || fleet === "charlie"
  ) {
    const label = `Optimist ${fleet[0].toUpperCase()}${fleet.slice(1)}`;
    return {
      key: `optimist-${fleet}`,
      label,
      series: "optimist",
      slugIncludes: [row.slug.toLowerCase()],
      prizeFleetName: `${label} Fleet`,
    };
  }
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
  if (fleet === "windsurfing" || fleet === "windsurfing-lt") {
    const blob = classBlob(row).toLowerCase();
    const compact = compactClass(blob);
    const isLt = fleet === "windsurfing-lt" ||
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
  "class-a",
  "class-b",
  "main",
  "intermediate",
  "green",
  "boys",
  "girls",
  "alpha",
  "bravo",
  "charlie",
  "open",
  "newborn",
  "ilca4",
  "ilca6",
  "ilca7",
  "420",
  "29er",
  "wingfoil",
  "techno293",
  "iqfoil",
  "windfoil",
  "windsurfing-lt",
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
    if (findEventSliceForRegattaSlug(row.slug) || (row.eventSlug && getRegattaEvent(row.eventSlug))) continue;
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

/** Preserve registered event copy while exposing every saved published class. */
export function withPublishedEventSlices(event: RegattaEventDef, regattas: RegattaRecord[]): RegattaEventDef {
  const linked = regattas.filter((row) => row.eventSlug &&
    (getRegattaEvent(row.eventSlug)?.slug || row.eventSlug).toLowerCase() === event.slug.toLowerCase());
  const additions = new Map<Fleet, RegattaRecord>();
  for (const row of linked) {
    const fleet = publicFleet(row);
    if (!fleet || event.slices.some((slice) => slice.key === sliceFor(fleet, row).key)) continue;
    const previous = additions.get(fleet);
    additions.set(fleet, previous ? preferLinkedSheet(previous, row, event.slug) : row);
  }
  const slices = event.slices.map((slice) => {
    if (!slice.staticId) return slice;
    const canonical = linked.filter((row) => {
      const fleet = publicFleet(row);
      return fleet && sliceFor(fleet, row).key === slice.key && (row.raceCount || 0) > 0 && row.totalFleetSize > 0;
    });
    return canonical.length ? { ...slice, alternateSlugIncludes: [
      ...(slice.alternateSlugIncludes || []), ...canonical.map((row) => [row.slug.toLowerCase()]),
    ] } : slice;
  });
  if (!additions.size && slices.every((slice, index) => slice === event.slices[index])) return event;
  return { ...event, slices: [...slices, ...FLEET_ORDER.filter((fleet) => additions.has(fleet))
    .map((fleet) => sliceFor(fleet, additions.get(fleet)!))] };
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
  if (!eventSlug) return null;
  const registered = getRegattaEvent(eventSlug);
  if (registered) {
    const event = withPublishedEventSlices(registered, regattas);
    const fleet = self && publicFleet(self);
    return { event, fleetKey: fleet ? sliceFor(fleet, self!).key : null };
  }

  const linked = regattas.filter(
    (row) =>
      row.eventSlug?.toLowerCase() === eventSlug && publicFleet(row)
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
  const saved = savedEventHubForSlug(slug, regattas);
  if (saved) {
    return eventHubHref(
      saved.event.slug,
      saved.fleetKey || saved.event.slices[0]?.key || "optimist"
    );
  }
  const slice = findEventSliceForRegattaSlug(slug);
  if (slice) return eventHubHref(slice.event.slug, slice.slice.key);
  const grouped = groupedHubForSlug(slug, regattas);
  if (!grouped) return null;
  return eventHubHref(
    grouped.event.slug,
    grouped.fleetKey || grouped.event.slices[0]?.key || "optimist"
  );
}
