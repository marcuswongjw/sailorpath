import { renderToStaticMarkup } from "react-dom/server";
import { describe, expect, it } from "vitest";
import OptimistClassHub, { metadata } from "./page";

describe("Optimist class hub", () => {
  it("describes the class and links to the existing standings", () => {
    expect(metadata.title).toBe("Optimist class hub | SailorPath");
    expect(metadata.alternates).toEqual({ canonical: "/classes/optimist" });

    const html = renderToStaticMarkup(<OptimistClassHub />);
    expect(html).toContain("Clark Mills");
    expect(html).toContain("Clearwater, Florida");
    expect(html).toContain("1947");
    expect(html).toContain("Axel Damgaard");
    expect(html).toContain("1958");
    expect(html).toContain("Denmark");
    expect(html).toContain("31 December of the year");
    expect(html).toContain("IODA championship rule");
    expect(html).toContain("https://www.optiworld.org/");
    expect(html).toContain(
      "https://www.optiworld.org/default/news/new/text/clark-mills-the-designer-of-the-optimist-inducted-into-us-hall-of-fame",
    );
    expect(html).toContain('href="/sg/optimist/gold"');
    expect(html).toContain('href="/sg/optimist/silver"');
    expect(html).toContain('href="/sg/optimist/selection"');
    expect(html).toContain('href="/optimist/asian-index"');
    expect(html).toContain('href="/optimist/asian-index/methodology"');
    expect(html).toContain("not an official IODA or national federation ranking");
    expect(html).toContain("V1 (Beta)");
    expect(html).not.toContain('href="/sg/optimist/asian-index"');
    expect(html).not.toContain('href="/classes/optimist/sg/gold"');
    expect(html).not.toContain("<table");
    expect(html).not.toContain("Three Optimist products");
  });
});
