import { createHash } from "node:crypto";
import { fetchResultsSource, resultsUrl } from "./fetchSource";
import { extractResultsHtml } from "./html";
import type { ResultsScan } from "./types";

export async function scanEventResults(url: string, fetchSource = (url: string) => fetchResultsSource(url, 0, true)): Promise<ResultsScan> {
  const scan: ResultsScan = { checkedAt: new Date().toISOString(), status: "waiting", sources: [], searchedUrls: [], errors: [], pdfCorroboration: "not_found_in_checked_pages" };
  try { resultsUrl(url); } catch {
    return { ...scan, status: "error", errors: ["Invalid event URL. Save a public HTTPS event/results URL before retrying."] };
  }
  const pending = [url];
  const deadline = Date.now() + 50_000;
  while (pending.length && scan.searchedUrls.length < 6 && Date.now() < deadline) {
    const next = pending.shift()!;
    if (scan.searchedUrls.includes(next)) continue;
    scan.searchedUrls.push(next);
    try {
      const source = await fetchSource(next);
      if (source.kind === "pdf") {
        scan.sources.push({ url: source.url, kind: "pdf", title: source.url.split("/").pop() || "PDF", sha256: source.body ? createHash("sha256").update(Buffer.from(source.body, "base64")).digest("hex") : null, tables: [], finalLabelSeen: false });
        scan.pdfCorroboration = "visual_review_required";
        continue;
      }
      const parsed = extractResultsHtml(source.body, source.url);
      scan.sources.push({ url: source.url, kind: "html", title: parsed.title, sha256: createHash("sha256").update(source.body).digest("hex"), tables: parsed.tables, finalLabelSeen: parsed.finalLabelSeen });
      // Prefer PDFs for corroboration; retain result and notice-board links as evidence.
      pending.push(...parsed.links.sort((a, b) => Number(/\.pdf/i.test(b)) - Number(/\.pdf/i.test(a))).filter((link) => !scan.searchedUrls.includes(link)).slice(0, 20));
    } catch (error) { scan.errors.push(`${next}: ${error instanceof Error ? error.message : "Scan failed"}`); }
  }
  scan.status = scan.sources.some((s) => s.kind === "pdf" || s.tables.length) ? "needs_review" : scan.sources.length ? "waiting" : "error";
  // Keep each saved report and serverless response below the platform body cap.
  if (Buffer.byteLength(JSON.stringify(scan), "utf8") > 2_000_000) {
    scan.sources = scan.sources.map((source) => ({ ...source, tables: [] }));
    scan.errors.push("Extracted tables exceeded the report size limit. Use the official source and the file importer.");
    scan.status = "needs_review";
  }
  return scan;
}
