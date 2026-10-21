import { describe, expect, it } from "vitest";
import sitemap, { generateSitemaps } from "./sitemap";

describe("public sitemap", () => {
  it("advertises the public X-15 hub and lists public result sheets", async () => {
    const ids = await generateSitemaps();
    expect(ids.map((item) => item.id)).toEqual(["hubs", "sailors", "results"]);
    const lists = await Promise.all(
      ids.map((item) => sitemap({ id: Promise.resolve(String(item.id)) }))
    );
    const urls = lists.flat().map((entry) => entry.url);
    expect(urls).toContain("https://sailorpath.com/");
    expect(urls).toContain("https://sailorpath.com/optimist/asian-index");
    expect(urls).toContain("https://sailorpath.com/optimist/asian-index/methodology");
    expect(urls).not.toContain("https://sailorpath.com/sg/optimist/asian-index");
    expect(urls).toContain("https://sailorpath.com/regattas/snsc-2025/results/optimist-gold");
    expect(urls).toContain(
      "https://sailorpath.com/regattas/youth-thailand-national-sailing-championship-2026/results/optimist"
    );
    expect(urls).toContain("https://sailorpath.com/classes");
    expect(urls).toContain("https://sailorpath.com/classes/x15");
    expect(urls).toContain("https://sailorpath.com/classes/optimist");
    expect(urls).not.toContain("https://sailorpath.com/classes/x-15");
    expect(urls.some((url) => url.includes("/log-"))).toBe(false);
    expect(urls.some((url) => url.startsWith("https://sailorpath.com/admin"))).toBe(false);
  });
});
