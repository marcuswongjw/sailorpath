import { renderToStaticMarkup } from "react-dom/server";
import { describe, expect, it, vi } from "vitest";

vi.mock("@/lib/news", () => ({
  formatNewsDate: () => "15 October 2026",
  listPublishedNews: vi.fn().mockResolvedValue([
    {
      slug: "x-15-pilot-opens-ahead-of-worlds",
      title: "X-15 pilot opens ahead of Worlds",
      summary: "A source-led class update.",
      body: "A source-led class update.",
      kind: "class_announcement",
      authorDisplayName: "SailorPath",
      publishedAt: "2026-10-15T00:00:00.000+08:00",
      updatedAt: "2026-10-15T00:00:00.000+08:00",
      relatedClass: "X-15",
      relatedRegion: "International",
      sourceUrl: null,
      sourceLabel: null,
      tags: ["x-15"],
      imageUrl: "/news/x15-class-guide.png",
      imageAlt: "Wingfoil racing",
      imageCredit: "Photo credit",
      imageCreditUrl: "https://example.com/photo",
    },
    {
      slug: "no-image", title: "A second update", summary: "More sailing news.", body: "More sailing news.", kind: "result_report",
      authorDisplayName: "SailorPath", publishedAt: "2026-10-14T00:00:00.000Z", updatedAt: "2026-10-14T00:00:00.000Z",
      relatedClass: null, relatedRegion: null, sourceUrl: null, sourceLabel: null, tags: [],
    },
  ]),
}));

import NewsPage from "./page";

describe("news index", () => {
  it("renders a real release-updates page with canonical article links", async () => {
    const html = renderToStaticMarkup(await NewsPage());

    expect(html).toContain("What&#x27;s new");
    expect(html).toContain("X-15 pilot opens");
    expect(html).toContain("/news/x-15-pilot-opens-ahead-of-worlds");
    expect(html).toContain("Latest update");
    expect(html).toContain("More updates");
    expect(html).toContain("A second update");
    expect(html).toContain("Photo credit");
    expect(html).toContain("https://example.com/photo");
  });
});
