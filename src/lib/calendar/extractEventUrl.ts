import { parse, type DefaultTreeAdapterMap } from "parse5";

import { emptyEventUrlDraft } from "./eventUrlDraft";
type Node = DefaultTreeAdapterMap["node"];
type RecordValue = Record<string, unknown>;
const children = (node: Node): Node[] => "childNodes" in node ? node.childNodes : [];
function nodes(node: Node, tag: string): Node[] {
  return children(node).flatMap((child) => [...("tagName" in child && child.tagName === tag ? [child] : []), ...nodes(child, tag)]);
}
const attr = (node: Node, key: string) => "attrs" in node ? node.attrs.find((a) => a.name === key)?.value : undefined;
function content(node: Node, includeScript = false): string {
  if ("value" in node) return node.value;
  if ("tagName" in node && ["style", "nav", "header", "footer", ...(includeScript ? [] : ["script"])].includes(node.tagName)) return "";
  return children(node).map((n) => content(n, includeScript)).join(" ").replace(/\s+/g, " ").trim();
}
const string = (value: unknown): string => typeof value === "string" ? value.trim() : "";
const object = (value: unknown): RecordValue => value != null && typeof value === "object" && !Array.isArray(value) ? value as RecordValue : {};
function plain(value: unknown): string { const raw = string(value); return raw ? content(parse(raw)) : ""; }
function httpsLink(value: unknown, base: string): string {
  try { const u = new URL(string(value), base); return string(value) && u.protocol === "https:" && !u.username && !u.password && (!u.port || u.port === "443") ? u.href : ""; } catch { return ""; }
}
function date(value: unknown): string {
  const match = string(value).match(/^(\d{4}-\d{2}-\d{2})(?:$|T)/);
  if (!match) return "";
  const d = new Date(`${match[1]}T00:00:00Z`);
  return !Number.isNaN(d.getTime()) && d.toISOString().slice(0, 10) === match[1] ? match[1] : "";
}
const months = ["january", "february", "march", "april", "may", "june", "july", "august", "september", "october", "november", "december"];
function visibleDates(text: string): [string, string] {
  const ymd = (day: string, month: string, year: string) => date(`${year}-${String(months.findIndex((m) => m.startsWith(month.toLowerCase())) + 1).padStart(2, "0")}-${day.padStart(2, "0")}`);
  const explicit = [...text.matchAll(/\b(?:From\s+)?(\d{1,2})\s+([A-Za-z]+)\s+(20\d{2})\s*(?:to|[-–—])\s*(\d{1,2})\s+([A-Za-z]+)\s+(20\d{2})\b/gi)];
  if (explicit.length > 1) return ["", ""];
  if (explicit.length === 1) return [ymd(explicit[0][1], explicit[0][2], explicit[0][3]), ymd(explicit[0][4], explicit[0][5], explicit[0][6])];
  const crossMonth = [...text.matchAll(/\b(\d{1,2})\s+([A-Za-z]+)\s*(?:to|[-–—])\s*(\d{1,2})\s+([A-Za-z]+)\s+(20\d{2})\b/gi)];
  if (crossMonth.length > 1) return ["", ""];
  if (crossMonth.length === 1) {
    const m = crossMonth[0];
    const startMonth = months.findIndex((month) => month.startsWith(m[2].toLowerCase()));
    const endMonth = months.findIndex((month) => month.startsWith(m[4].toLowerCase()));
    return [ymd(m[1], m[2], String(Number(m[5]) - (startMonth > endMonth ? 1 : 0))), ymd(m[3], m[4], m[5])];
  }
  text = text.replace(/\b([A-Za-z]+)\s+(\d{1,2})(?:st|nd|rd|th)?\s*[-–—]\s*(\d{1,2})(?:st|nd|rd|th)?\s*,?\s*(20\d{2})\b/g, "$2–$3 $1 $4");
  const matches = [...text.matchAll(/\b(\d{1,2})(?:st|nd|rd|th)?\s*(?:[-–—]\s*(\d{1,2})(?:st|nd|rd|th)?)?\s+(Jan(?:uary)?|Feb(?:ruary)?|Mar(?:ch)?|Apr(?:il)?|May|Jun(?:e)?|Jul(?:y)?|Aug(?:ust)?|Sep(?:tember)?|Oct(?:ober)?|Nov(?:ember)?|Dec(?:ember)?)\s*,?\s*(20\d{2})\b/gi)];
  const ranges = [...new Set(matches.map((m) => {
    const month = String(months.findIndex((name) => name.startsWith(m[3].toLowerCase())) + 1).padStart(2, "0");
    return `${m[4]}-${month}-${m[1].padStart(2, "0")}|${m[4]}-${month}-${(m[2] || m[1]).padStart(2, "0")}`;
  }))];
  if (ranges.length !== 1) return ["", ""];
  const [start, end] = ranges[0].split("|");
  return [date(start), date(end)];
}
function eventRecords(value: unknown): RecordValue[] {
  if (Array.isArray(value)) return value.flatMap(eventRecords);
  const item = object(value);
  const types = Array.isArray(item["@type"]) ? item["@type"] : [item["@type"]];
  return [...(types.some((t) => /^(SportsEvent|Event)$/i.test(string(t))) ? [item] : []), ...(item["@graph"] ? eventRecords(item["@graph"]) : [])];
}

export function extractEventUrl(html: string, sourceUrl: string) {
  const doc = parse(html);
  const draft = emptyEventUrlDraft();
  draft.sourceUrl = sourceUrl;
  const warnings: string[] = [];
  const meta = (key: string) => nodes(doc, "meta").find((n) => attr(n, "property") === key || attr(n, "name") === key);
  const main = nodes(doc, "main")[0] || nodes(doc, "article")[0] || nodes(doc, "body")[0] || doc;
  const text = content(main);
  const records = nodes(doc, "script").filter((n) => attr(n, "type") === "application/ld+json").flatMap((n) => {
    try { return eventRecords(JSON.parse(content(n, true))); } catch { return []; }
  });
  const matching = records.filter((e) => httpsLink(e.url || e["@id"], sourceUrl).split("#")[0] === sourceUrl.split("#")[0]);
  const event = matching.length === 1 ? matching[0] : records.length === 1 ? records[0] : {};
  if (records.length > 1 && !Object.keys(event).length) warnings.push("This page lists several events. Review the name and dates; no event was selected automatically.");
  draft.name = (plain(event.name) || content(nodes(main, "h1")[0] || parse("")) || attr(meta("og:title") || doc, "content") || content(nodes(doc, "title")[0] || parse(""))).slice(0, 180);
  const subheading = content(nodes(main, "h2")[0] || parse(""));
  if (draft.name.replace(/^Events?\s+/i, "").toLowerCase() === subheading.toLowerCase()) draft.name = subheading;
  draft.startDate = date(event.startDate);
  draft.endDate = date(event.endDate);
  if (!draft.startDate && records.length <= 1) {
    const times = nodes(main, "time");
    draft.startDate = date(attr(times.find((n) => attr(n, "itemprop") === "startDate") || doc, "datetime"));
    draft.endDate = date(attr(times.find((n) => attr(n, "itemprop") === "endDate") || doc, "datetime"));
    if (!draft.startDate) [draft.startDate, draft.endDate] = visibleDates(text);
  }
  if (draft.endDate && draft.startDate && draft.endDate < draft.startDate) { draft.startDate = ""; draft.endDate = ""; warnings.push("The page has inconsistent event dates. Enter the dates manually."); }
  const location = object(Array.isArray(event.location) ? event.location[0] : event.location);
  draft.venue = (plain(location.name) || string(event.location) || string(location.address)).slice(0, 300);
  const organizer = Array.isArray(event.organizer) ? event.organizer[0] : event.organizer;
  draft.organizer = (plain(object(organizer).name) || string(organizer)).slice(0, 300);
  const lines = ["p", "li", "tr"].flatMap((tag) => nodes(main, tag).map((node) => content(node)));
  const labeled = (labels: string) => lines.map((line) => line.match(new RegExp(`^(?:${labels})\\s*:\\s*(.{1,300})$`, "i"))?.[1]?.trim()).find(Boolean) || text.match(new RegExp(`(?:${labels})\\s*:\\s*(.{1,180}?)(?=\\s+(?:Dates?|Venue|Location|Organi[sz]er|Classes|Registration|Entries|Notice)\\s*:|$)`, "i"))?.[1]?.trim() || "";
  draft.venue ||= labeled("Venue|Location");
  if (new URL(sourceUrl).hostname.endsWith(".optiworld.org")) draft.venue ||= content(nodes(main, "div").find((n) => attr(n, "class")?.split(/\s+/).includes("club-name")) || parse("")).replace(/,\s*$/, "");
  draft.organizer ||= labeled("Organi[sz]er|Organising authority");
  const classText = `${draft.name} ${plain(event.description)} ${labeled("Classes|Boat classes|Sailing classes")} ${lines.filter((line) => /\b(classes|fleets)\b/i.test(line)).join(" ").slice(0, 1500)}`;
  const classes: [RegExp, string][] = [[/\boptimist\b/i, "Optimist"], [/\bILCA\s*4\b|\bLaser\s*4\.7\b/i, "ILCA 4"], [/\bILCA\s*6\b|\bLaser\s*Radial\b/i, "ILCA 6"], [/\bILCA\s*7\b|\bLaser\s*Standard\b/i, "ILCA 7"], [/\b29er\b/i, "29er"], [/\b420\b/, "420"], [/\bTechno\s*293\b/i, "Techno 293"], [/\biQFOiL\b/i, "iQFOiL"], [/\bWing\s*Foil\b/i, "WingFoil"], [/\bRS\s*Feva\b/i, "RS Feva"]];
  draft.classes = classes.filter(([pattern]) => pattern.test(classText)).map(([, label]) => label).join(", ");
  draft.scheduleSummary = (plain(event.description) || plain(attr(meta("description") || meta("og:description") || doc, "content"))).slice(0, 2000);
  for (const link of nodes(main, "a")) {
    const href = httpsLink(attr(link, "href"), sourceUrl);
    const label = content(link);
    if (!href) continue;
    if (!draft.norUrl && /notice\s+of\s+race|official\s+notice\s*board|notice\s*board|^NOR$/i.test(label)) draft.norUrl = href;
    if (!draft.registrationUrl && /^(?:register(?:\s+now)?|registration|enter(?:\s+now)?|entry\s+form|online\s+entry)$/i.test(label)) draft.registrationUrl = href;
  }
  draft.norUrl ||= sourceUrl;
  if (!draft.startDate) warnings.push("A reliable start date was not found. Enter it before saving.");
  if (!draft.classes) warnings.push("Sailing classes were not confirmed on this page.");
  return { draft, warnings, sourceUrl };
}
