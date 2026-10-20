import { renderToStaticMarkup } from "react-dom/server";
import { describe, expect, it } from "vitest";
import RankingsHubPage from "./page";

describe("rankings hub", () => {
  it("links Optimist to its class hub and leaves the standing cards in place", () => {
    const html = renderToStaticMarkup(<RankingsHubPage />);

    expect(html).toContain('href="/classes/optimist"');
    expect(html).toContain('href="/sg/optimist/gold"');
    expect(html).toContain('href="/sg/optimist/silver"');
    expect(html).toContain('href="/sg/wingfoil"');
    expect(html).not.toContain("/classes/x15");
    expect(html).not.toContain("X-15");
  });
});