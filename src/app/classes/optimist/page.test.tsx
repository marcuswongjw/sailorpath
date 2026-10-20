import { renderToStaticMarkup } from "react-dom/server";
import { describe, expect, it } from "vitest";
import OptimistClassHub, { metadata } from "./page";

describe("Optimist class hub", () => {
  it("links out to existing Optimist records and repeats the index disclaimer", () => {
    expect(metadata.title).toBe("Optimist class hub | SailorPath");
    expect(metadata.alternates).toEqual({ canonical: "/classes/optimist" });

    const html = renderToStaticMarkup(<OptimistClassHub />);
    expect(html).toContain('href="/sg/optimist/gold"');
    expect(html).toContain('href="/sg/optimist/silver"');
    expect(html).toContain('href="/sg/optimist/selection"');
    expect(html).toContain('href="/optimist/asian-index"');
    expect(html).toContain('href="/optimist/asian-index/methodology"');
    expect(html).toContain('href="/how-rankings-work"');
    expect(html).toContain('href="/results"');
    expect(html).toContain('href="/calendar"');
    expect(html).toContain('href="/sailors"');
    expect(html).toContain("Best 3 of 5");
    expect(html).toContain("V1 (Beta)");
    expect(html).toContain("not an official IODA or national federation ranking");
    expect(html).not.toContain('href="/sg/optimist/asian-index"');
    expect(html).not.toContain("<table");
  });
});
