import { and, desc, eq } from "drizzle-orm";
import { unstable_cache } from "next/cache";
import { db } from "@/db";
import { newsArticles } from "@/db/schema";
import {
  CACHE_TAG_NEWS_ARTICLES,
  PUBLIC_DATA_REVALIDATE_SECONDS,
} from "@/lib/cacheTags";

export type PublishedNewsArticle = {
  slug: string;
  title: string;
  summary: string;
  body: string;
  kind:
    | "result_report"
    | "correction"
    | "class_announcement"
    | "product_update"
    | "partner_update";
  authorDisplayName: string;
  publishedAt: string;
  updatedAt: string;
  relatedClass: string | null;
  relatedRegion: string | null;
  sourceUrl: string | null;
  sourceLabel: string | null;
  tags: string[];
};

/**
 * Keeps the release-updates surface useful before the editorial migration has
 * been applied, or during a temporary database outage. The migration seeds the
 * same records; a successful database read always takes precedence.
 */
const FALLBACK_ARTICLES: PublishedNewsArticle[] = [
  {
    slug: "a-clearer-public-sailing-record",
    title: "A clearer public sailing record",
    summary:
      "SailorPath now separates public results discovery from private account, parent and coach workspaces.",
    body:
      "SailorPath now separates public results discovery from private account, parent and coach workspaces. Public profiles use a verified-results-first default and optional profile sharing is off until an authorised owner chooses it.",
    kind: "product_update",
    authorDisplayName: "SailorPath",
    publishedAt: "2026-10-15T00:00:00.000+08:00",
    updatedAt: "2026-10-15T00:00:00.000+08:00",
    relatedClass: null,
    relatedRegion: "Singapore",
    sourceUrl: null,
    sourceLabel: null,
    tags: ["product", "public-records", "privacy"],
  },
  {
    slug: "x-15-pilot-opens-ahead-of-worlds",
    title: "X-15 pilot opens ahead of Worlds",
    summary:
      "The X-15 hub brings together reviewed Ibiza and Thailand event context without publishing an unsupported ranking.",
    body:
      "The X-15 class hub brings together reviewed Ibiza and Thailand event context with a transparent beta methodology. It does not publish a numbered ranking before official final results are available and source-linked. Open the X-15 class hub for that context.",
    kind: "class_announcement",
    authorDisplayName: "SailorPath",
    publishedAt: "2026-10-15T00:00:00.000+08:00",
    updatedAt: "2026-10-15T00:00:00.000+08:00",
    relatedClass: "X-15",
    relatedRegion: "International",
    sourceUrl: null,
    sourceLabel: null,
    tags: ["x-15", "class-hub", "methodology"],
  },
];

function isSafeNewsSlug(value: string): boolean {
  return /^[a-z0-9]+(?:-[a-z0-9]+)*$/.test(value);
}

const PUBLIC_NEWS_COLUMNS = {
  slug: newsArticles.slug,
  title: newsArticles.title,
  summary: newsArticles.summary,
  body: newsArticles.body,
  kind: newsArticles.kind,
  authorDisplayName: newsArticles.authorDisplayName,
  publishedAt: newsArticles.publishedAt,
  updatedAt: newsArticles.updatedAt,
  relatedClass: newsArticles.relatedClass,
  relatedRegion: newsArticles.relatedRegion,
  sourceUrl: newsArticles.sourceUrl,
  sourceLabel: newsArticles.sourceLabel,
  tags: newsArticles.tags,
} as const;

type PublicNewsRow = Pick<
  typeof newsArticles.$inferSelect,
  keyof typeof PUBLIC_NEWS_COLUMNS
>;

function toPublishedArticle(row: PublicNewsRow): PublishedNewsArticle {
  if (!row.publishedAt) {
    throw new Error(`Published news article ${row.slug} is missing published_at`);
  }

  return {
    slug: row.slug,
    title: row.title,
    summary: row.summary,
    body: row.body,
    kind: row.kind,
    authorDisplayName: row.authorDisplayName,
    publishedAt: row.publishedAt.toISOString(),
    updatedAt: row.updatedAt.toISOString(),
    relatedClass: row.relatedClass,
    relatedRegion: row.relatedRegion,
    sourceUrl: row.sourceUrl,
    sourceLabel: row.sourceLabel,
    tags: Array.isArray(row.tags) ? row.tags.filter((tag): tag is string => typeof tag === "string") : [],
  };
}

async function readPublishedNews(): Promise<PublishedNewsArticle[]> {
  const rows = await db
    .select(PUBLIC_NEWS_COLUMNS)
    .from(newsArticles)
    .where(eq(newsArticles.status, "published"))
    .orderBy(desc(newsArticles.publishedAt));

  return rows.map(toPublishedArticle);
}

async function readPublishedNewsArticle(
  slug: string
): Promise<PublishedNewsArticle | null> {
  const [row] = await db
    .select(PUBLIC_NEWS_COLUMNS)
    .from(newsArticles)
    .where(
      and(
        eq(newsArticles.slug, slug),
        eq(newsArticles.status, "published")
      )
    )
    .limit(1);

  return row ? toPublishedArticle(row) : null;
}

const getCachedPublishedNews = unstable_cache(
  readPublishedNews,
  ["published-news-v1"],
  {
    revalidate: PUBLIC_DATA_REVALIDATE_SECONDS,
    tags: [CACHE_TAG_NEWS_ARTICLES],
  }
);

function cachedArticleLookup(slug: string) {
  return unstable_cache(
    () => readPublishedNewsArticle(slug),
    ["published-news-article-v1", slug],
    {
      revalidate: PUBLIC_DATA_REVALIDATE_SECONDS,
      tags: [CACHE_TAG_NEWS_ARTICLES],
    }
  );
}

/** Published rows only; editorial drafts and review metadata never cross this boundary. */
export async function listPublishedNews(): Promise<PublishedNewsArticle[]> {
  try {
    return await getCachedPublishedNews();
  } catch (error) {
    console.warn("[news] published article query failed; serving release-update fallback", error);
    return FALLBACK_ARTICLES;
  }
}

/** A missing or non-published article is intentionally indistinguishable from a missing route. */
export async function getPublishedNewsArticle(
  slug: string
): Promise<PublishedNewsArticle | null> {
  const normalized = slug.trim().toLowerCase();
  if (!isSafeNewsSlug(normalized)) return null;

  try {
    return await cachedArticleLookup(normalized)();
  } catch (error) {
    console.warn("[news] article query failed; serving release-update fallback", error);
    return FALLBACK_ARTICLES.find((article) => article.slug === normalized) ?? null;
  }
}

export function formatNewsDate(isoTimestamp: string): string {
  return new Intl.DateTimeFormat("en-GB", {
    day: "numeric",
    month: "long",
    year: "numeric",
    timeZone: "Asia/Singapore",
  }).format(new Date(isoTimestamp));
}
