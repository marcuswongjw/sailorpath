import { describe, expect, it } from "vitest";
import { GET } from "./route";

describe("sitemap index", () => {
  it("points robots at the public hub, sailor, and result-sheet sitemaps", async () => {
    const response = GET();
    const xml = await response.text();
    expect(response.headers.get("content-type")).toContain("application/xml");
    expect(xml).toContain("<sitemapindex");
    expect(xml).toContain("https://sailorpath.com/sitemap/hubs.xml");
    expect(xml).toContain("https://sailorpath.com/sitemap/sailors.xml");
    expect(xml).toContain("https://sailorpath.com/sitemap/results.xml");
  });
});
