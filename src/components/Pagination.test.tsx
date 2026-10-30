import { describe, expect, it } from "vitest";
import { renderToStaticMarkup } from "react-dom/server";
import { Pagination, pageNumber } from "./Pagination";

describe("directory pagination", () => {
  it("bounds invalid and oversized page requests", () => {
    expect(pageNumber("-1", 65)).toBe(1);
    expect(pageNumber("2.5", 65)).toBe(1);
    expect(pageNumber("999", 65)).toBe(3);
    expect(pageNumber("2", 0)).toBe(1);
  });
  it("preserves filters and replaces the current page in both directions", () => {
    const html = renderToStaticMarkup(<Pagination path="/results" filters={{q:"NSW & VIC", country:"AUS",page:"2"}} page={2} total={65} />);
    expect(html).toContain("page=1");
    expect(html).toContain("page=3");
    expect(html).toContain("country=AUS");
    expect(html).toContain("q=NSW+%26+VIC");
    expect(html).toContain("Page 2 of 3");
  });
});
