import { renderToStaticMarkup } from "react-dom/server";
import { describe, expect, it } from "vitest";
import RankingsHubPage from "./page";

describe("rankings hub", () => {
  it("links Optimist to its class hub and leaves the standing cards in place", () => {
    const html = renderToStaticMarkup(<RankingsHubPage />);

    expect(html).toContain('href="/classes/optimist"');
    expect(html).toContain('href="/sg/optimist/gold"');
    expect(html).toContain('href="/sg/optimist/silver"');
    expect(html).toContain("Singapore Optimist Gold Fleet ranking");
    expect(html).toContain("Singapore Optimist Silver Fleet ranking");
    expect(html).toContain("Singapore ILCA 4 national ranking");
    expect(html).toContain("Singapore ILCA 6 national ranking");
    for (const path of ["/sg/ilca7", "/sg/wingfoil", "/sg/techno293", "/sg/iqfoil"]) expect(html).not.toContain(`href="${path}"`);
    expect(html).not.toContain("Windsurfing &amp; Foiling");
    expect(html).not.toContain("/classes/x15");
    expect(html).not.toContain("X-15");
  });
});