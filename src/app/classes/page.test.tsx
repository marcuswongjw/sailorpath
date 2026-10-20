import { renderToStaticMarkup } from "react-dom/server";
import { describe, expect, it } from "vitest";
import ClassesIndexPage, { metadata } from "./page";

describe("class hub index", () => {
  it("lists only the X-15 and Optimist hubs", () => {
    expect(metadata.title).toBe("Class hubs | SailorPath");
    expect(metadata.alternates).toEqual({ canonical: "/classes" });

    const html = renderToStaticMarkup(<ClassesIndexPage />);
    expect(html).toContain('href="/classes/x15"');
    expect(html).toContain('href="/classes/optimist"');
    expect(html).toContain("X-15");
    expect(html).toContain("Optimist");
    expect(html).not.toContain("/classes/ilca");
    expect(html).not.toContain("/sg/wingfoil");
  });
});
