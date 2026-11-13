import { existsSync, readFileSync } from "node:fs";
import { resolve } from "node:path";
import { beforeEach, expect, it, vi } from "vitest";

const rows = vi.hoisted(() => ({ published: [] as Record<string, unknown>[] }));
vi.mock("next/cache", () => ({ unstable_cache: (fn: unknown) => fn }));
vi.mock("@/db", () => ({ db: { select: () => ({ from: () => ({ where: () => ({ orderBy: async () => rows.published }) }) }) } }));
import { listPublishedNews } from "./news";
beforeEach(() => { rows.published = []; });

it("gives every published release update a relevant local image, description and credit", async () => {
  const articles = await listPublishedNews();
  expect(articles).toHaveLength(10);
  for (const article of articles) {
    expect(article.imageUrl).toMatch(/^\/news\//);
    expect(article.imageAlt?.length).toBeGreaterThan(20);
    expect(article.imageCaption).toBeTruthy();
    expect(article.imageCredit).toBeTruthy();
    const path = resolve("public", article.imageUrl!.slice(1));
    expect(existsSync(path)).toBe(true);
    if (path.endsWith(".svg")) expect(readFileSync(path, "utf8")).not.toMatch(/<script|<foreignObject|href=/i);
  }
});

it("attaches the same media when an article comes from the published database", async () => {
  rows.published = [{ slug: "a-clearer-public-sailing-record", title: "Saved title", summary: "Saved summary", body: "Saved copy", kind: "product_update", authorDisplayName: "SailorPath", publishedAt: new Date("2026-10-15T00:00:00+08:00"), updatedAt: new Date("2026-11-03T00:00:00+08:00"), tags: [] }];
  const articles = await listPublishedNews();
  const article = articles.find((item) => item.slug === "a-clearer-public-sailing-record");
  expect(article).toMatchObject({ title: "Saved title", summary: "Saved summary", body: "Saved copy", imageUrl: "/news/ui-public-records.jpg" });
  expect(articles.filter((item) => item.slug === article!.slug)).toHaveLength(1);
});
