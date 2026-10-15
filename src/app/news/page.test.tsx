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
  });
});
