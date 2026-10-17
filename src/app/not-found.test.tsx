import { renderToStaticMarkup } from "react-dom/server";
import { describe, expect, it } from "vitest";
import NotFound from "./not-found";

describe("not found", () => {
  it("offers rankings, results, and search", () => {
    const html = renderToStaticMarkup(<NotFound />);
    expect(html).toContain("Page not found");
    expect(html).toContain('href="/rankings"');
    expect(html).toContain(">Rankings<");
    expect(html).toContain('href="/results"');
    expect(html).toContain(">Results<");
    expect(html).toContain('href="/search"');
    expect(html).toContain(">Search<");
    expect(html).not.toContain("Sailor profile");
  });
});
