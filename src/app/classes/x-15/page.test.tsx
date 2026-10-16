import { readFileSync } from "node:fs";
import { describe, expect, it } from "vitest";
import { metadata } from "./page";

const source = readFileSync(new URL("./page.tsx", import.meta.url), "utf8");

describe("X-15 class hub", () => {
  it("is available by direct URL but excluded from search indexing during review", () => {
    expect(metadata.title).toBe("X-15 class hub | SailorPath");
    expect(metadata.robots).toEqual({
      index: false,
      follow: false,
    });
  });

  it("shows reviewed official sources without claiming a ranked SailorPath result", () => {
    expect(source).toContain("https://x-15class.org/events/x-15-world-championships-2026/");
    expect(source).toContain("https://x-15class.org/events/");
    expect(source).toContain("4–8 November 2026");
    expect(source).toContain("Amara Watersports Club, Thailand");
    expect(source).not.toContain("Pattaya, Thailand");
    expect(source).toContain("No numbered ranking is published at this stage.");
  });
});
