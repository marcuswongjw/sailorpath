import { describe, expect, it, vi } from "vitest";
import { extractResultsHtml } from "./html";
import { isPublicResultsAddress, resultsUrl } from "./fetchSource";
import { scanEventResults } from "./scan";

const html = `<title>Harbour Cup 2026</title><h1>Final results</h1>
<table><caption>Optimist Gold</caption><tr><th>Rank</th><th>Name</th><th>Sail No</th><th>R1</th><th>R2</th><th>Total</th><th>Nett</th></tr>
<tr><td>1</td><td>Alice &amp; Co</td><td>SGP 123</td><td>1</td><td>(3 DNC)</td><td>4</td><td>1</td></tr>
<tr><td>2</td><td>Bob Example</td><td>SGP 456</td><td>2</td><td>(3)</td><td>5</td><td>2</td></tr></table>`;

describe("official results extraction", () => {
  it("preserves names, race codes, numeric penalties and explicit discards", () => {
    const parsed = extractResultsHtml(html, "https://club.example/event");
    expect(parsed.finalLabelSeen).toBe(true);
    expect(parsed.tables[0].issues).toEqual([]);
    expect(parsed.tables[0].rows[0]).toMatchObject({ name: "Alice & Co", sailNumber: "SGP 123", total: 4, nett: 1, races: [{ score: 1, discarded: false }, { score: 3, discarded: true, scoringCode: "DNC" }] });
  });
  it("blocks lost discards and missing competitor cells", () => {
    expect(extractResultsHtml(html.replace("(3 DNC)", "3 DNC"), "https://club.example").tables[0].issues.join()).toContain("net total does not reconcile");
    expect(extractResultsHtml(html.replace("<td>Bob Example</td>", ""), "https://club.example").tables[0].issues.join()).toContain("missing columns");
  });
  it("does not label provisional results as final", () => {
    expect(extractResultsHtml(html + "<p>Provisional</p>", "https://club.example").finalLabelSeen).toBe(false);
  });
  it("ignores scripts and resolves relative evidence links", () => {
    const parsed = extractResultsHtml(`<script>Final results</script><a href="../final.pdf">Results PDF</a>`, "https://club.example/event/info");
    expect(parsed.finalLabelSeen).toBe(false);
    expect(parsed.links).toEqual(["https://club.example/final.pdf"]);
  });
  it("does not retain executable, insecure or credential-bearing result links", () => {
    const parsed = extractResultsHtml('<a href="javascript:alert(1)">Results</a><a href="http://club.example/results">Results</a><a href="https://user:pass@club.example/final">Results</a><a href="https://club.example:8443/results">Results</a>', "https://club.example");
    expect(parsed.links).toEqual([]);
  });
});

describe("source discovery", () => {
  it("retains extraction evidence, finds PDF links, and requires visual review", async () => {
    const fetcher = vi.fn(async (url: string) => ({ url, kind: (url.endsWith(".pdf") ? "pdf" : "html") as "html" | "pdf", body: html + '<a href="final.pdf">Final results PDF</a>' }));
    const report = await scanEventResults("https://club.example/", fetcher);
    expect(report.status).toBe("needs_review");
    expect(report.pdfCorroboration).toBe("visual_review_required");
    expect(report.sources[0].sha256).toMatch(/^[a-f0-9]{64}$/);
    expect(fetcher).toHaveBeenCalledTimes(2);
  });
  it("records source failures and unavailable PDF corroboration", async () => {
    const report = await scanEventResults("https://club.example/", async () => { throw new Error("Unavailable"); });
    expect(report.status).toBe("error");
    expect(report.errors[0]).toContain("Unavailable");
    expect(report.pdfCorroboration).toBe("not_found_in_checked_pages");
  });
  it("bounds link traversal, including pages without readable tables", async () => {
    const report = await scanEventResults("https://club.example/", async (url) => ({ url, kind: "html", body: Array.from({ length: 50 }, (_, i) => `<a href="/results/${i}">Results</a>`).join("") }));
    expect(report.searchedUrls).toHaveLength(6);
    expect(report.status).toBe("waiting");
  });
});

describe("crawler network boundary", () => {
  it.each(["127.0.0.1", "10.0.0.1", "169.254.169.254", "172.16.0.1", "192.168.1.1", "100.64.0.1", "0.0.0.0", "::1", "::ffff:127.0.0.1", "224.0.0.1"])("blocks private/reserved address %s", (ip) => {
    expect(isPublicResultsAddress(ip)).toBe(false);
  });
  it("allows public HTTPS destinations without custom ports or credentials", () => {
    expect(isPublicResultsAddress("8.8.8.8")).toBe(true);
    expect(() => resultsUrl("http://club.example")).toThrow();
    expect(() => resultsUrl("https://user:pass@club.example")).toThrow();
    expect(() => resultsUrl("https://club.example:8080")).toThrow();
  });
});
