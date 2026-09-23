import { isIlcaSeriesClass } from "@/lib/ilcaRanking";
import type { RegattaRecord } from "@/lib/ranking";
import {
  eventHubHref,
  findEventSliceForRegattaSlug,
  getRegattaEvent,
  type RegattaEventDef,
  type RegattaEventSliceDef,
} from "@/lib/regattaEvents";

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

type Fleet = "gold" | "silver" | "open" | "ilca4";

function publicFleet(row: RegattaRecord): Fleet | null {
  const boat = String(row.boatClass || "");
  if (isIlcaSeriesClass(boat, "ILCA 4")) return "ilca4";
  const lower = boat.toLowerCase();
  if (
    lower.includes("ilca") ||
    lower.includes("laser") ||
    lower.includes("wing") ||
    lower.includes("techno") ||
    lower.includes("29") ||
    lower.includes("iqfoil")
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
  return {
    key: "optimist",
    label: "Optimist",
    series: "optimist",
    slugIncludes: [row.slug.toLowerCase()],
    prizeFleetName: "Optimist Gold Fleet",
  };
}

const FLEET_ORDER: Fleet[] = ["gold", "silver", "open", "ilca4"];

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

/** Class result URLs for a multi-class regatta open the shared tabbed page. */
export function hubHrefForClassSlug(
  slug: string,
  regattas: RegattaRecord[]
): string | null {
  const direct = getRegattaEvent(slug);
  if (direct) return `/regattas/${direct.slug}`;
  const slice = findEventSliceForRegattaSlug(slug);
  if (slice) return eventHubHref(slice.event.slug, slice.slice.key);
  const grouped = groupedHubForSlug(slug, regattas);
  if (!grouped) return null;
  return eventHubHref(
    grouped.event.slug,
    grouped.fleetKey || grouped.event.slices[0]?.key || "optimist"
  );
}
