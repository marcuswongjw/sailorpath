import { parse, type DefaultTreeAdapterMap } from "parse5";
import { parseRegattaResultRows } from "@/lib/excel/parseRegattaResultsSheet";
import type { ExtractedResultTable } from "./types";
import { resultRowIssues } from "./validation";

type Node = DefaultTreeAdapterMap["node"];
const children = (node: Node): Node[] => "childNodes" in node ? node.childNodes : [];
function descendants(node: Node, tag: string): Node[] {
  return children(node).flatMap((child) => [
    ...("tagName" in child && child.tagName === tag ? [child] : []),
    ...descendants(child, tag),
  ]);
}
function text(node: Node): string {
  if ("value" in node) return node.value;
  if ("tagName" in node && ["script", "style", "template"].includes(node.tagName)) return "";
  return children(node).map(text).join(" ").replace(/\s+/g, " ").trim();
}
const attr = (node: Node, name: string) => "attrs" in node ? node.attrs.find((a) => a.name === name)?.value : undefined;

/** Conservative adapter for ordinary/Sailwave HTML tables; never guesses merged columns. */
export function extractResultsHtml(html: string, url: string) {
  const doc = parse(html);
  const title = text(descendants(doc, "title")[0] || doc).slice(0, 240);
  const visible = text(doc);
  const tables: ExtractedResultTable[] = [];
  for (const table of descendants(doc, "table")) {
    const trs = descendants(table, "tr");
    const cells = (tr: Node) => children(tr).filter((n) => "tagName" in n && ["td", "th"].includes(n.tagName));
    const headerIndex = trs.findIndex((tr) => {
      const labels = cells(tr).map(text);
      return labels.some((s) => /^(rank|pos|position)$/i.test(s)) && labels.some((s) => /^(name|helm name|competitor|sailor name)$/i.test(s));
    });
    if (headerIndex < 0) continue;
    const header = cells(trs[headerIndex]).map(text);
    const raceCount = header.filter((s) => /^R(?:ace\s*)?\d+$/i.test(s)).length;
    const issues: string[] = [];
    if (new Set(header).size !== header.length) issues.push("Duplicate column headings need review.");
    const records: Record<string, string>[] = [];
    for (const tr of trs.slice(headerIndex + 1)) {
      const tds = cells(tr);
      if (!tds.length) continue;
      if (tds.length !== header.length || tds.some((td) => Number(attr(td, "colspan") || 1) !== 1 || Number(attr(td, "rowspan") || 1) !== 1)) {
        issues.push("A table row has merged or missing columns.");
        continue;
      }
      records.push(Object.fromEntries(header.map((key, i) => [key, text(tds[i])])));
    }
    if (records.length > 2000) issues.push("Table exceeds 2000 competitors.");
    const rows = parseRegattaResultRows(records.slice(0, 2000));
    if (rows.length !== records.length) issues.push("Some table rows could not be read; fleet size needs review.");
    issues.push(...resultRowIssues(rows, raceCount));
    tables.push({ title: text(descendants(table, "caption")[0] || trs[0] || table).slice(0, 240), rows, raceCount, issues });
    if (tables.length >= 8) break;
  }
  const links = descendants(doc, "a").flatMap((a) => {
    const href = attr(a, "href");
    if (!href || !/result|final|sailwave|notice.?board|\.pdf(?:$|[?#])/i.test(`${text(a)} ${href}`)) return [];
    try {
      const link = new URL(href, url);
      if (link.protocol !== "https:" || link.username || link.password || (link.port && link.port !== "443")) return [];
      return [link.href.split("#")[0]];
    } catch { return []; }
  });
  return { title, tables, links: [...new Set(links)], finalLabelSeen: /\bfinal\s+(?:overall\s+)?results?\b/i.test(visible) && !/\b(provisional|preliminary)\b/i.test(visible) };
}
