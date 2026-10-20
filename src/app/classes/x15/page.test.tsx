import { readFileSync } from "node:fs";
import { renderToStaticMarkup } from "react-dom/server";
import { describe, expect, it } from "vitest";
import X15ClassHub, { metadata } from "./page";

const source = readFileSync(new URL("./page.tsx", import.meta.url), "utf8");
const redirectSource = readFileSync(
  new URL("../../../../next.config.ts", import.meta.url),
  "utf8",
);

describe("X-15 class hub", () => {
  it("is a public class page at /classes/x15", () => {
    expect(metadata.title).toBe("X-15 class hub | SailorPath");
    expect(metadata.robots).toEqual({ index: true, follow: true });
    expect(metadata.alternates).toEqual({ canonical: "/classes/x15" });
    const html = renderToStaticMarkup(<X15ClassHub />);
    expect(html).toContain("16–17 December training");
    expect(html).toContain("Amara Watersports Club, Jomtien, Thailand");
    expect(html).toContain("Port Nàutic Ibiza, Spain");
    expect(html).not.toContain("Emerging Nations");
    expect(html).not.toContain("15–17 December");
    expect(html).toContain("No numbered ranking is published at this stage.");
  });

  it("shows reviewed sources without a SailorPath ranking", () => {
    expect(source).toContain("https://x-15class.org/events/x-15-world-championships-2026/");
    expect(source).toContain(
      "https://x-15class.org/blog/entries-open-for-the-first-x-15-world-championships/",
    );
    expect(source).toContain("4–8 November 2026");
    expect(source).toContain("Port Nàutic Ibiza, Spain");
    expect(source).toContain("16–17 December training · 18–20 December racing");
    expect(source).toContain("Amara Watersports Club, Jomtien, Thailand");
    expect(source).toContain("https://www.instagram.com/p/DcIit1VP9_d/");
    expect(source).toContain("No numbered ranking is published at this stage.");
    expect(source).not.toContain("15–17 December");
    expect(source).not.toContain("Emerging Nations");
    expect(source).not.toContain("confirmed on class calendar");
    expect(source).not.toContain("<table");
  });

  it("keeps Pattaya in the 2024 history item and out of the Asian championship", () => {
    const asian = source.slice(
      source.indexOf("X-15 Asian Championships 2026"),
      source.indexOf("foundationHistory"),
    );
    expect(asian).toContain("Amara Watersports Club, Jomtien, Thailand");
    expect(asian).not.toContain("Pattaya");
    expect(source).toContain("Pattaya");
    expect(source).toContain("Ryo En Hua Bateman SGP");
    expect(source).toContain("Kate En Rui Bateman SGP");
    expect(source).toContain("SailorPath does not turn that list into a ranking.");
  });

  it("redirects the old hyphenated path", () => {
    expect(redirectSource).toContain('source: "/classes/x-15"');
    expect(redirectSource).toContain('destination: "/classes/x15"');
    expect(redirectSource).toContain("permanent: true");
  });
});
