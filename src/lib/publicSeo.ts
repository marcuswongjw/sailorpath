import type { Metadata, MetadataRoute } from "next";
import { classResultsHref } from "@/lib/calendar/calendarResultLinks";
import { COUNTRIES } from "@/lib/countries";
import { normalizeHandle, validateHandle } from "@/lib/handles";
import { ordinal } from "@/lib/profileAnalytics";
import type { RegattaRecord } from "@/lib/ranking";
import { hubHrefForClassSlug } from "@/lib/regattaEventGroups";
import {
  REGATTA_EVENTS,
  type RegattaEventDef,
  type RegattaEventSliceDef,
} from "@/lib/regattaEvents";

export const PUBLIC_SITE_ORIGIN = "https://sailorpath.com";

/** Static hubs. Same list the sitemap used before sailor and result URLs were added. */
export const HUB_SITEMAP_PATHS = [
  "/",
  "/results",
  "/rankings",
  "/calendar",
  "/sailors",
  "/news",
  "/classes",
  "/classes/optimist",
  "/classes/x15",
  "/sg/optimist/gold",
  "/sg/optimist/silver",
  "/sg/optimist/selection",
  "/sg/ilca4",
  "/sg/ilca6",
  "/sg/ilca7",
  "/sg/wingfoil",
  "/sg/techno293",
  "/sg/iqfoil",
  "/optimist/asian-index",
  "/optimist/asian-index/methodology",
] as const;

const SAILING_COUNTRY_NAMES: Record<string, string> = {
  SGP: "Singapore",
  SIN: "Singapore",
  SG: "Singapore",
  MAS: "Malaysia",
  INA: "Indonesia",
  THA: "Thailand",
  PHI: "Philippines",
  VIE: "Vietnam",
  HKG: "Hong Kong",
  CHN: "China",
  JPN: "Japan",
  KOR: "South Korea",
  TPE: "Chinese Taipei",
  AUS: "Australia",
  NZL: "New Zealand",
  USA: "United States",
  GBR: "United Kingdom",
};

const MONTH_INDEX: Record<string, number> = {
  jan: 1,
  feb: 2,
  mar: 3,
  apr: 4,
  may: 5,
  jun: 6,
  jul: 7,
  aug: 8,
  sep: 9,
  oct: 10,
  nov: 11,
  dec: 12,
};

const MONTH_NAMES = [
  "January",
  "February",
  "March",
  "April",
  "May",
  "June",
  "July",
  "August",
  "September",
  "October",
  "November",
  "December",
];

export type ShareResultRow = {
  regattaName?: string | null;
  regattaDate?: string | null;
  boatClass?: string | null;
  rank?: number | null;
  isDns?: boolean | null;
};

export type SailorShareModel = {
  name: string;
  handle: string;
  country: string | null;
  club: string | null;
  boatClass: string | null;
  regattaCount: number;
  bestResult: string | null;
  summary: string;
  title: string;
  path: string;
};

export type PodiumFinish = {
  rank: number;
  name: string;
  handle: string | null;
};

export type ResultSheetShare = {
  title: string;
  description: string;
  canonicalPath: string;
  regattaName: string;
  classLabel: string;
  datesText: string | null;
  venue: string | null;
  organizer: string | null;
  startDate?: string;
  endDate?: string;
  top3: PodiumFinish[];
  jsonLdName: string;
};

export function canonicalUrl(path: string): string {
  if (path.startsWith("https://") || path.startsWith("http://")) return path;
  const normalized = path.startsWith("/") ? path : `/${path}`;
  return `${PUBLIC_SITE_ORIGIN}${normalized}`;
}

export function yearFromText(value: string | null | undefined): number | null {
  const match = String(value || "").match(/\b(20\d{2})\b/);
  return match ? Number(match[1]) : null;
}

export function publicCountryName(value: string | null | undefined): string | null {
  const raw = String(value || "").trim();
  if (!raw) return null;
  const token = raw.toUpperCase();
  if (SAILING_COUNTRY_NAMES[token]) return SAILING_COUNTRY_NAMES[token];
  const byCode = COUNTRIES.find((country) => country.code.toUpperCase() === token);
  if (byCode) return byCode.name;
  const byName = COUNTRIES.find((country) => country.name.toLowerCase() === raw.toLowerCase());
  return byName ? byName.name : raw;
}

export function sailorProfileTitle(
  name: string,
  boatClass: string | null,
  country: string | null
): string {
  const detail = [boatClass, country].filter((part): part is string => Boolean(part));
  const middle = detail.length ? ` – ${detail.join(", ")}` : "";
  return `${name}${middle} | SailorPath`;
}

export function resultSheetTitle(
  regattaName: string,
  year: number | null,
  classLabel: string
): string {
  const namedYear = yearFromText(regattaName);
  const yearBit = year != null && namedYear !== year ? ` ${year}` : "";
  return `${regattaName}${yearBit} – ${classLabel} results | SailorPath`;
}

export function eventHubTitle(name: string, year: number | null): string {
  const namedYear = yearFromText(name);
  const yearBit = year != null && namedYear !== year ? ` ${year}` : "";
  return `${name}${yearBit} – results | SailorPath`;
}

export function resultSheetDescription(
  classLabel: string,
  regattaName: string,
  datesText: string | null | undefined
): string {
  const dates = String(datesText || "").trim();
  return dates
    ? `Published ${classLabel} results for ${regattaName}, ${dates}.`
    : `Published ${classLabel} results for ${regattaName}.`;
}

function isoFromParts(year: number, month: number, day: number): string | null {
  if (month < 1 || month > 12 || day < 1 || day > 31 || year < 2000 || year > 2099) return null;
  return `${year}-${String(month).padStart(2, "0")}-${String(day).padStart(2, "0")}`;
}

export function isoDateOnly(value: string | null | undefined): string | null {
  const match = String(value || "").trim().match(/^(20\d{2})-(\d{2})-(\d{2})/);
  if (!match) return null;
  return isoFromParts(Number(match[1]), Number(match[2]), Number(match[3]));
}

function formatIsoDate(iso: string): string {
  const [year, month, day] = iso.split("-").map(Number);
  return `${day} ${MONTH_NAMES[month - 1]} ${year}`;
}

export function formatIsoDateRange(start: string | null, end: string | null): string | null {
  if (!start) return null;
  if (!end || end === start) return formatIsoDate(start);
  const [startYear, startMonth, startDay] = start.split("-").map(Number);
  const [endYear, endMonth, endDay] = end.split("-").map(Number);
  if (startYear === endYear && startMonth === endMonth) {
    return `${startDay}–${endDay} ${MONTH_NAMES[startMonth - 1]} ${startYear}`;
  }
  if (startYear === endYear) {
    return `${startDay} ${MONTH_NAMES[startMonth - 1]} – ${endDay} ${MONTH_NAMES[endMonth - 1]} ${startYear}`;
  }
  return `${formatIsoDate(start)} – ${formatIsoDate(end)}`;
}

function monthOf(name: string): number | null {
  return MONTH_INDEX[name.toLowerCase().slice(0, 3)] ?? null;
}

/**
 * Accept only a clean ISO date or a fully parsed calendar phrase.
 * Anything looser is left out of JSON-LD. The prose can still go in the description.
 */
export function eventDatesFromText(value: string | null | undefined): {
  startDate?: string;
  endDate?: string;
} {
  const text = String(value || "").trim().replace(/\s+/g, " ");
  if (!text) return {};
  const iso = isoDateOnly(text);
  if (iso && text.startsWith(iso)) return { startDate: iso, endDate: iso };
  const dash = "[\\u2010-\\u2015-]";
  const cross = text.match(
    new RegExp(`^(\\d{1,2})\\s+([A-Za-z]+)\\s*${dash}\\s*(\\d{1,2})\\s+([A-Za-z]+)\\s+(20\\d{2})$`)
  );
  if (cross) {
    const year = Number(cross[5]);
    const startDate = isoFromParts(year, monthOf(cross[2]) ?? 0, Number(cross[1]));
    const endDate = isoFromParts(year, monthOf(cross[4]) ?? 0, Number(cross[3]));
    if (startDate && endDate && endDate >= startDate) return { startDate, endDate };
    return {};
  }
  const sameMonth = text.match(
    new RegExp(`^(\\d{1,2})\\s*${dash}\\s*(\\d{1,2})\\s+([A-Za-z]+)\\s+(20\\d{2})$`)
  );
  if (sameMonth) {
    const month = monthOf(sameMonth[3]) ?? 0;
    const year = Number(sameMonth[4]);
    const startDate = isoFromParts(year, month, Number(sameMonth[1]));
    const endDate = isoFromParts(year, month, Number(sameMonth[2]));
    if (startDate && endDate && endDate >= startDate) return { startDate, endDate };
    return {};
  }
  const single = text.match(/^(\d{1,2})\s+([A-Za-z]+)\s+(20\d{2})$/);
  if (single) {
    const startDate = isoFromParts(Number(single[3]), monthOf(single[2]) ?? 0, Number(single[1]));
    return startDate ? { startDate, endDate: startDate } : {};
  }
  return {};
}

function regattaCountOf(rows: ShareResultRow[]): number {
  return new Set(
    rows.map((row) => String(row.regattaName || "").trim()).filter(Boolean)
  ).size;
}

export function primaryClassLabel(rows: ShareResultRow[]): string | null {
  const counts = new Map<string, { count: number; latest: string }>();
  for (const row of rows) {
    const label = String(row.boatClass || "").trim();
    if (!label) continue;
    const previous = counts.get(label) || { count: 0, latest: "" };
    const date = String(row.regattaDate || "");
    counts.set(label, {
      count: previous.count + 1,
      latest: date > previous.latest ? date : previous.latest,
    });
  }
  let best: { label: string; count: number; latest: string } | null = null;
  for (const [label, stat] of counts) {
    if (
      !best ||
      stat.count > best.count ||
      (stat.count === best.count && stat.latest > best.latest)
    ) {
      best = { label, count: stat.count, latest: stat.latest };
    }
  }
  return best?.label ?? null;
}

function bestFinish(rows: ShareResultRow[]): {
  rank: number;
  boatClass: string;
  regattaName: string;
} | null {
  const finished = rows.filter(
    (row) =>
      !row.isDns &&
      typeof row.rank === "number" &&
      row.rank > 0 &&
      String(row.regattaName || "").trim()
  );
  finished.sort((a, b) => {
    const byRank = (a.rank ?? 0) - (b.rank ?? 0);
    if (byRank !== 0) return byRank;
    return String(b.regattaDate || "").localeCompare(String(a.regattaDate || ""));
  });
  const best = finished[0];
  if (!best || best.rank == null) return null;
  return {
    rank: best.rank,
    boatClass: String(best.boatClass || "").trim() || "the fleet",
    regattaName: String(best.regattaName).trim(),
  };
}

function regattaCountLabel(count: number): string {
  return count === 1 ? "1 regatta on record" : `${count} regattas on record`;
}

/**
 * Public share copy for a sailor. School, photo, weight, the date of birth,
 * and the birth year stay off titles, descriptions, and preview images.
 * The profile page itself still shows the birth year.
 */
export function sailorShareModel(input: {
  name: string;
  handle: string;
  nationality?: string | null;
  club?: string | null;
  results?: ShareResultRow[] | null;
  path?: string;
}): SailorShareModel {
  const name = String(input.name || "").trim() || "Sailor";
  const handle = normalizeHandle(input.handle);
  const results = input.results || [];
  const country = publicCountryName(input.nationality);
  const club = String(input.club || "").trim() || null;
  const boatClass = primaryClassLabel(results);
  const regattaCount = regattaCountOf(results);
  const best = bestFinish(results);
  const bestResult = best
    ? `${ordinal(best.rank)} in ${best.boatClass} at ${best.regattaName}`
    : null;
  const summary = bestResult
    ? `${bestResult}. ${regattaCountLabel(regattaCount)}.`
    : regattaCount
      ? `${regattaCountLabel(regattaCount)}.`
      : `Sailing results for ${name} on SailorPath.`;
  return {
    name,
    handle,
    country,
    club,
    boatClass,
    regattaCount,
    bestResult,
    summary,
    title: sailorProfileTitle(name, boatClass, country),
    path: input.path || `/sailors/${encodeURIComponent(handle)}`,
  };
}

export function classLabelForRegatta(regatta: {
  boatClass?: string | null;
  division?: string | null;
}): string {
  const boat = String(regatta.boatClass || "").trim() || "Fleet";
  const division = String(regatta.division || "").trim();
  if (!division || /^open$/i.test(division)) return boat;
  if (boat.toLowerCase().includes(division.toLowerCase())) return boat;
  return `${boat} ${division}`;
}

export function topFinishers(
  results: Array<{
    rank?: number | null;
    sailorName?: string | null;
    handle?: string | null;
    isDns?: boolean | null;
  }>
): PodiumFinish[] {
  return results
    .filter(
      (row) =>
        !row.isDns &&
        typeof row.rank === "number" &&
        row.rank > 0 &&
        String(row.sailorName || "").trim()
    )
    .sort(
      (a, b) =>
        (a.rank ?? 0) - (b.rank ?? 0) ||
        String(a.sailorName).localeCompare(String(b.sailorName))
    )
    .slice(0, 3)
    .map((row) => ({
      rank: row.rank as number,
      name: String(row.sailorName).trim(),
      handle: row.handle ? String(row.handle) : null,
    }));
}

export function resultSheetFromEventSlice(
  event: RegattaEventDef,
  slice: RegattaEventSliceDef,
  top3: PodiumFinish[] = []
): ResultSheetShare {
  const dates = eventDatesFromText(event.datesText);
  const year = yearFromText(event.name) ?? yearFromText(event.datesText);
  return {
    title: resultSheetTitle(event.name, year, slice.label),
    description: resultSheetDescription(slice.label, event.name, event.datesText),
    canonicalPath: `/regattas/${event.slug}/results/${slice.key}`,
    regattaName: event.name,
    classLabel: slice.label,
    datesText: String(event.datesText || "").trim() || null,
    venue: event.venue || null,
    organizer: event.organizer || null,
    startDate: dates.startDate,
    endDate: dates.endDate,
    top3,
    jsonLdName: `${event.name} – ${slice.label}`,
  };
}

export function eventHubShare(event: RegattaEventDef): ResultSheetShare {
  const dates = eventDatesFromText(event.datesText);
  const year = yearFromText(event.name) ?? yearFromText(event.datesText);
  const classes = event.slices.map((slice) => slice.label).filter(Boolean);
  const description = classes.length
    ? `Published results for ${event.name}. Classes: ${classes.join(", ")}.`
    : `Published results for ${event.name}.`;
  return {
    title: eventHubTitle(event.name, year),
    description,
    canonicalPath: `/regattas/${event.slug}`,
    regattaName: event.name,
    classLabel: classes.slice(0, 3).join(", ") || "Results",
    datesText: String(event.datesText || "").trim() || null,
    venue: event.venue || null,
    organizer: event.organizer || null,
    startDate: dates.startDate,
    endDate: dates.endDate,
    top3: [],
    jsonLdName: event.name,
  };
}

export function resultSheetFromRegatta(input: {
  name: string;
  boatClass?: string | null;
  division?: string | null;
  date?: string | null;
  endDate?: string | null;
  venue?: string | null;
  organizer?: string | null;
  canonicalPath: string;
  top3?: PodiumFinish[];
}): ResultSheetShare {
  const classLabel = classLabelForRegatta(input);
  const startDate = isoDateOnly(input.date) ?? undefined;
  const endDate = isoDateOnly(input.endDate) ?? undefined;
  const year = yearFromText(input.name) ?? (startDate ? Number(startDate.slice(0, 4)) : null);
  const datesText = formatIsoDateRange(startDate ?? null, endDate ?? null);
  return {
    title: resultSheetTitle(input.name, year, classLabel),
    description: resultSheetDescription(classLabel, input.name, datesText),
    canonicalPath: input.canonicalPath,
    regattaName: input.name,
    classLabel,
    datesText,
    venue: input.venue || null,
    organizer: input.organizer || null,
    startDate,
    endDate,
    top3: input.top3 || [],
    jsonLdName: `${input.name} – ${classLabel}`,
  };
}

export function shareMetadata(input: {
  title: string;
  description: string;
  canonicalPath: string;
  index?: boolean;
}): Metadata {
  const url = canonicalUrl(input.canonicalPath);
  const metadata: Metadata = {
    title: input.title,
    description: input.description,
    alternates: { canonical: url },
    openGraph: {
      type: "website",
      url,
      title: input.title,
      description: input.description,
      siteName: "SailorPath",
    },
    twitter: {
      card: "summary_large_image",
      title: input.title,
      description: input.description,
    },
  };
  if (input.index === false) metadata.robots = { index: false, follow: true };
  return metadata;
}

export function serializeJsonLd(data: unknown): string {
  return JSON.stringify(data).replace(/</g, "\\u003c");
}

export function organizationWebsiteJsonLd() {
  return {
    "@context": "https://schema.org",
    "@graph": [
      {
        "@type": "Organization",
        name: "SailorPath",
        url: PUBLIC_SITE_ORIGIN,
        logo: `${PUBLIC_SITE_ORIGIN}/brand/sailorpath-icon.png`,
      },
      {
        "@type": "WebSite",
        name: "SailorPath",
        url: PUBLIC_SITE_ORIGIN,
        potentialAction: {
          "@type": "SearchAction",
          target: {
            "@type": "EntryPoint",
            urlTemplate: `${PUBLIC_SITE_ORIGIN}/search?q={search_term_string}`,
          },
          "query-input": "required name=search_term_string",
        },
      },
    ],
  };
}

export function profilePageJsonLd(share: SailorShareModel) {
  const person: Record<string, unknown> = {
    "@type": "Person",
    name: share.name,
    url: canonicalUrl(share.path),
  };
  if (share.country) person.nationality = { "@type": "Country", name: share.country };
  if (share.club) person.memberOf = { "@type": "SportsOrganization", name: share.club };
  if (share.summary) person.description = share.summary;
  return {
    "@context": "https://schema.org",
    "@type": "ProfilePage",
    url: canonicalUrl(share.path),
    mainEntity: person,
  };
}

export function sportsEventJsonLd(sheet: ResultSheetShare) {
  const event: Record<string, unknown> = {
    "@context": "https://schema.org",
    "@type": "SportsEvent",
    name: sheet.jsonLdName,
    sport: "Sailing",
    url: canonicalUrl(sheet.canonicalPath),
  };
  if (sheet.startDate) event.startDate = sheet.startDate;
  if (sheet.endDate) event.endDate = sheet.endDate;
  if (sheet.venue) event.location = { "@type": "Place", name: sheet.venue };
  if (sheet.organizer) event.organizer = { "@type": "Organization", name: sheet.organizer };
  if (sheet.top3.length) {
    event.competitor = sheet.top3.map((row) => {
      const person: Record<string, unknown> = { "@type": "Person", name: row.name };
      if (row.handle && isIndexablePublicSailor({ handle: row.handle })) {
        person.url = canonicalUrl(`/sailors/${encodeURIComponent(normalizeHandle(row.handle))}`);
      }
      return person;
    });
  }
  return event;
}

/**
 * Public profile URLs are already linked from search, rankings, and result sheets.
 * There is no hide-profile flag today. A future hiddenFromSearch column must stay out.
 * Reserved handles and handles that are not valid public URLs stay out too.
 */
export function isIndexablePublicSailor(sailor: {
  handle?: string | null;
  hiddenFromSearch?: boolean | null;
}): boolean {
  if (sailor.hiddenFromSearch === true) return false;
  const stored = String(sailor.handle || "").trim();
  const valid = validateHandle(stored);
  if (!valid.ok) return false;
  return valid.handle === stored.toLowerCase();
}

export function isPersonalLogSlug(slug: string | null | undefined): boolean {
  return String(slug || "").trim().toLowerCase().startsWith("log-");
}

export function canonicalPathFromHubHref(href: string): string | null {
  try {
    const url = new URL(href, PUBLIC_SITE_ORIGIN);
    const match = url.pathname.match(/^\/regattas\/([^/]+)$/);
    if (!match) return null;
    const slug = decodeURIComponent(match[1]);
    const fleet = url.searchParams.get("fleet");
    if (fleet) return `/regattas/${slug}/results/${decodeURIComponent(fleet)}`;
    return `/regattas/${slug}`;
  } catch {
    return null;
  }
}

export function publicResultSheetPaths(
  regattas: Array<Pick<RegattaRecord, "slug" | "boatClass">> = []
): string[] {
  const paths = new Set<string>();
  for (const event of REGATTA_EVENTS) {
    for (const slice of event.slices) {
      paths.add(`/regattas/${event.slug}/results/${slice.key}`);
    }
  }
  for (const regatta of regattas) {
    const slug = String(regatta.slug || "").trim();
    if (!slug || isPersonalLogSlug(slug)) continue;
    const hub = hubHrefForClassSlug(slug, regattas as RegattaRecord[]);
    const canonical = hub ? canonicalPathFromHubHref(hub) : null;
    if (canonical?.includes("/results/")) {
      paths.add(canonical);
      continue;
    }
    if (canonical?.startsWith("/regattas/")) continue;
    const href = classResultsHref(regatta);
    if (
      href.startsWith("/sg/optimist/regattas/") ||
      href.startsWith("/sg/ilca/regattas/")
    ) {
      paths.add(href);
    }
  }
  return [...paths].sort();
}

function dailyEntries(paths: readonly string[]): MetadataRoute.Sitemap {
  return paths.map((path) => ({
    url: canonicalUrl(path),
    changeFrequency: "daily" as const,
  }));
}

export function hubSitemapEntries(): MetadataRoute.Sitemap {
  return dailyEntries(HUB_SITEMAP_PATHS);
}

export function sailorSitemapEntries(
  sailors: Array<{ handle?: string | null; hiddenFromSearch?: boolean | null }>
): MetadataRoute.Sitemap {
  const paths = sailors
    .filter((sailor) => isIndexablePublicSailor(sailor))
    .map((sailor) => `/sailors/${encodeURIComponent(normalizeHandle(String(sailor.handle)))}`)
    .sort();
  return dailyEntries(paths);
}

export function resultSitemapEntries(paths: readonly string[]): MetadataRoute.Sitemap {
  return dailyEntries([...paths].sort());
}
