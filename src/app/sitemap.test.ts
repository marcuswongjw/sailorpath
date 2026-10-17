import { describe, expect, it } from "vitest";
import sitemap, { generateSitemaps } from "./sitemap";

describe("public sitemap", () => {
  it("does not advertise the X-15 review route and does list public result sheets", async () => {
    const ids = await generateSitemaps();
    expect(ids.map((item) => item.id)).toEqual(["hubs", "sailors", "results"]);
    const lists = await Promise.all(
      ids.map((item) => sitemap({ id: Promise.resolve(String(item.id)) }))
    );
    const urls = lists.flat().map((entry) => entry.url);
    expect(urls).toContain("https://sailorpath.com/");
    expect(urls).toContain("https://sailorpath.com/regattas/snsc-2025/results/optimist-gold");
    expect(urls).not.toContain("https://sailorpath.com/classes/x-15");
    expect(urls.some((url) => url.includes("/log-"))).toBe(false);
    expect(urls.some((url) => url.startsWith("https://sailorpath.com/admin"))).toBe(false);
  });
});
