import { renderToStaticMarkup } from "react-dom/server";
import { beforeEach, describe, expect, it, vi } from "vitest";

const mocks = vi.hoisted(() => ({ getArticle: vi.fn() }));

vi.mock("@/lib/news", () => ({
  formatNewsDate: () => "15 October 2026",
  getPublishedNewsArticle: mocks.getArticle,
}));
vi.mock("next/navigation", () => ({
  notFound: () => {
    throw new Error("NOT_FOUND");
  },
}));

import NewsArticlePage, { generateMetadata } from "./page";

const article = {
  slug: "x-15-pilot-opens-ahead-of-worlds",
  title: "X-15 pilot opens ahead of Worlds",
  summary: "A source-led class update.",
  body: "The pilot is live.\n\nNo numbered ranking is published.",
  kind: "class_announcement" as const,
  authorDisplayName: "SailorPath",
  publishedAt: "2026-10-15T00:00:00.000+08:00",
  updatedAt: "2026-10-15T00:00:00.000+08:00",
  relatedClass: "X-15",
  relatedRegion: "International",
  sourceUrl: "https://example.com/source",
  sourceLabel: "Organiser source",
  tags: ["x-15"],
};

describe("published news article route", () => {
  beforeEach(() => vi.clearAllMocks());

  it("renders a published article and its source link", async () => {
    mocks.getArticle.mockResolvedValue(article);
    const element = await NewsArticlePage({
      params: Promise.resolve({ slug: article.slug }),
    });
    const html = renderToStaticMarkup(element);

    expect(html).toContain(article.title);
    expect(html).toContain("No numbered ranking is published.");
    expect(html).toContain("Organiser source");
    expect(html).toContain("https://example.com/source");
  });

  it("returns a real not-found boundary for an unknown or unpublished article", async () => {
    mocks.getArticle.mockResolvedValue(null);

    await expect(
      NewsArticlePage({ params: Promise.resolve({ slug: "not-published" }) })
    ).rejects.toThrow("NOT_FOUND");
  });

  it("creates canonical metadata only for published articles", async () => {
    mocks.getArticle.mockResolvedValue(article);

    await expect(
      generateMetadata({ params: Promise.resolve({ slug: article.slug }) })
    ).resolves.toMatchObject({
      title: `${article.title} | SailorPath`,
      alternates: { canonical: `/news/${article.slug}` },
    });
  });
});
