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
  imageUrl?: string | null;
  imageAlt?: string | null;
  imageCaption?: string | null;
  imageCredit?: string | null;
  imageCreditUrl?: string | null;
};

const ARTICLE_MEDIA_BY_SLUG: Record<
  string,
  {
    imageUrl: string;
    imageAlt: string;
    imageCaption: string;
    imageCredit: string;
    imageCreditUrl: string;
  }
> = {
  "18th-eastern-seaboard-regatta-2026-results-published": {
    imageUrl: "/news/eastern-seaboard-pattaya.jpg",
    imageAlt:
      "Optimist dinghies racing off Pattaya at the 2026 18th Eastern Seaboard Regatta hosted by Royal Varuna Yacht Club.",
    imageCaption:
      "Optimist fleet racing off Pattaya at the 2026 18th Eastern Seaboard Regatta hosted by Royal Varuna Yacht Club.",
    imageCredit: "Photo © Chainarong Phrammanee / Royal Varuna Yacht Club (via Sail-World)",
    imageCreditUrl: "https://www.sail-world.com/news/301250/Eastern-Seaboard-Regatta-2026",
  },
  "australian-2026-ilca-optimist-and-zhik-youth-sail-results": {
    imageUrl: "/news/australia-youth-championships.jpg",
    imageAlt:
      "ILCA fleet racing on the River Derwent in Hobart at the 2026 ILCA Oceania & Australian Open & Youth Championships.",
    imageCaption:
      "ILCA fleet racing on the River Derwent in Hobart during the 2026 ILCA Oceania & Australian Open & Youth Championships at the Royal Yacht Club of Tasmania.",
    imageCredit: "Photo © Jane Austin / 2026 ILCA Oceania & Australian Championships (via Sail-World)",
    imageCreditUrl:
      "https://www.sail-world.com/news/292765/ILCA-Oceania-and-AUS-Open-and-Youth-Championship-day-3",
  },
  "2026-asian-games-and-youth-worlds-coverage": {
    imageUrl: "/news/asian-games-gamagori.jpg",
    imageAlt:
      "ILCA racing at Kaiyoh Yacht Harbor in Gamagori, Japan during the 20th Asian Games Aichi-Nagoya 2026.",
    imageCaption:
      "ILCA racing at Kaiyoh Yacht Harbor in Gamagori, Japan during the 20th Asian Games Aichi-Nagoya 2026.",
    imageCredit: "Photo © Junichi Hirai / World Sailing (via Sail-World)",
    imageCreditUrl: "https://www.sail-world.com/news/300410/First-Olympic-spots-for-LA28-decided",
  },
};

function withArticleMedia(article: PublishedNewsArticle): PublishedNewsArticle {
  const media = ARTICLE_MEDIA_BY_SLUG[article.slug];
  if (!media) return article;
  return {
    ...article,
    imageUrl: article.imageUrl ?? media.imageUrl,
    imageAlt: article.imageAlt ?? media.imageAlt,
    imageCaption: article.imageCaption ?? media.imageCaption,
    imageCredit: article.imageCredit ?? media.imageCredit,
    imageCreditUrl: article.imageCreditUrl ?? media.imageCreditUrl,
  };
}

/**
 * Keeps the release-updates surface useful before the editorial migration has
 * been applied, or during a temporary database outage. The migration seeds the
 * same records; a successful database read always takes precedence.
 */
const FALLBACK_ARTICLES: PublishedNewsArticle[] = [
  {
    slug: "18th-eastern-seaboard-regatta-2026-results-published",
    title:
      "18th Eastern Seaboard Regatta 2026: Optimist Gold, Silver, ILCA 4 & ILCA 6 Scorecards Published",
    summary:
      "Complete race-by-race scorecards for all 209 competitors (1,672 race scores) at the 2026 18th Eastern Seaboard Regatta at Royal Varuna Yacht Club in Pattaya, Thailand, visually verified against the official notice-board PDFs.",
    body: `Complete race-by-race scorecards from the 2026 18th Eastern Seaboard Regatta, hosted by Royal Varuna Yacht Club in Pattaya, Thailand (28 October – 1 November 2026), are now live on SailorPath.

## Four Fleets, 209 Competitors, 1,672 Race Scores

All 13 pages of the official result PDFs posted on Racing Rules of Sailing Event Notice Board 15166 were visually inspected and reconciled row-by-row before publication:

• Optimist Gold Fleet — 68 competitors, 8 races (Q1–Q5 and F1–F3), 2 discards (544 race scores)
• Optimist Silver Fleet — 67 competitors, 8 races (Q1–Q5 and F1–F3), 2 discards (536 race scores)
• ILCA 4 — 63 competitors, 8 races, 1 discard (504 race scores)
• ILCA 6 Youth U19 — 11 competitors, 8 races, 1 discard (88 race scores)

Across the four sheets, 176 entries matched existing verified sailor profiles and 33 new sailor profiles were created, with zero arithmetic or scoring reconciliation discrepancies between the official PDFs and the published tables.

## Source Transparency & Identity Notes

In keeping with SailorPath's data-integrity rules, several nuances from the official notice board documents are preserved directly in the scorecard metadata:

• Final vs. Provisional status: Although the official notice board titles and filenames label both documents as Final (Result Optimist Final and Result ILCA4 & ILCA6 Final, dated 1 November 2026), the document headers inside the PDFs still read Provisional. SailorPath displays the status as Provisional until the organiser issues a header-updated revision, while recording the full PDF reconciliation in each entry's evidence trail.
• Official Silver Fleet penalty points: Optimist Silver has 67 entries but applies 69-point scoring penalties in the official table; those exact published numeric values are preserved without synthetic recalculation.
• Cross-border identity protection: Where two distinct sailors share a sail number across seasons or fleets (such as Yong Ai Chuang and Yong Ray Chuang on sail 323), verified birth-year and gender records keep their career profiles strictly separate.

Explore all four fleet scorecards at /regattas/eastern-seaboard-regatta-2026.`,
    kind: "result_report",
    authorDisplayName: "SailorPath",
    publishedAt: "2026-11-02T09:00:00.000+08:00",
    updatedAt: "2026-11-02T09:00:00.000+08:00",
    relatedClass: "Optimist",
    relatedRegion: "Asia",
    sourceUrl: "https://sailorpath.com/regattas/eastern-seaboard-regatta-2026",
    sourceLabel: "Open 18th Eastern Seaboard Regatta 2026 scorecards",
    tags: [
      "thailand",
      "eastern-seaboard",
      "optimist",
      "ilca-4",
      "ilca-6",
      "results",
      "pdf-verified",
    ],
  },
  {
    slug: "australian-2026-ilca-optimist-and-zhik-youth-sail-results",
    title:
      "Australian 2026 Championship Coverage: ILCA Oceania & Australian Championships, Optimist States, and Zhik Youth Sail",
    summary:
      "SailorPath publishes 50 verified Australian championship fleet sheets across the 2026 ILCA Oceania & Australian Championships in Hobart, Musto Australian and State Optimist Championships, and the nationwide Zhik Youth Sail series.",
    body: `To support cross-border benchmarking across Asia and Oceania, SailorPath has completed a major expansion of 2026 Australian youth and open championship records across 50 fleet sheets and more than 5,000 individual race scores.

## 2026 ILCA Oceania & Australian Championships (Hobart, Tasmania)

All five championship fleets raced on the River Derwent in Hobart are now published with full race-by-race scores and discards:

• ILCA 4 Gold and Silver fleets (12 races, 2 discards)
• ILCA 6 Gold and Silver fleets
• ILCA 7 Open fleet

Source and verification note: All five ILCA Oceania & Australian Championship sheets have been visually verified and reconciled against both the official SailingResults.net portal and the 8-page organiser-hosted final results PDF.

## 2026 Australian National & State Optimist Championships

Nine completed Open and Intermediate fleet scorecards (260 entries, 1,470 race scores) are now live from the 2026 Australian domestic calendar:

• 2026 Musto Australian Optimist Championship (Intermediate Fleet, Royal Yacht Club of Tasmania)
• 2026 VIODA International Optimist Victorian & Open Championship (Open and Intermediate fleets)
• 2026 NSW, ACT, and Tasmanian Optimist State Championships (Open and Intermediate fleets)

## 2026 Zhik Youth Sail State Championships (36 Fleet Sheets)

We have also imported 36 completed class sheets (478 entries, 3,554 race scores) across seven 2026 Zhik Youth Sail state championships—Tasmania, Northern Territory, Queensland, South Australia, Western Australia, New South Wales, and the ACT:

• Optimist (Open and Intermediate fleets across TAS, QLD, SA, WA, and NSW; 213 entries)
• ILCA 4, ILCA 6, and ILCA 7
• 29er and 420 double-handed youth fleets
• iQFOiL and Techno 293 windsurfing fleets

Source and verification note: Where official organiser PDFs were not published for the Australian Optimist state championships and Zhik Youth Sail portals, scorecards were verified directly against the official digital scoring systems (SailingResults.net, Sailwave, TopYacht, Sportspage, and SailSys) and are transparently marked as digital-source verified rather than PDF-verified. Zhik Youth Sail Victoria 2026 is recorded as un-sailed (0 races completed due to severe weather).`,
    kind: "result_report",
    authorDisplayName: "SailorPath",
    publishedAt: "2026-10-30T11:00:00.000+08:00",
    updatedAt: "2026-10-30T11:00:00.000+08:00",
    relatedClass: "Optimist",
    relatedRegion: "Oceania",
    sourceUrl: "https://sailorpath.com/results",
    sourceLabel: "Explore published Australian regatta scorecards",
    tags: [
      "australia",
      "oceania",
      "optimist",
      "ilca-4",
      "ilca-6",
      "ilca-7",
      "29er",
      "420",
      "results",
    ],
  },
  {
    slug: "privacy-first-profiles-guardian-consent-and-evidence-protections",
    title:
      "Strengthening Youth Sailor Privacy: Consent-Gated Photos, Private Evidence, and Claim Protections",
    summary:
      "How SailorPath protects youth athletes by keeping public profiles strictly focused on verified competition records while gating photos, personal notes, and uploaded evidence behind approved claims and guardian consent.",
    body: `Because youth sailing records involve minor athletes, SailorPath is built around a strict separation between the public competition record and private athlete or family data. Over the past week, we shipped a series of security and privacy upgrades across public profiles, file storage, and claim workflows.

## Verified Results by Default, Optional Sharing by Choice

Unclaimed sailor profiles on SailorPath display only verified competition history—regatta finishes, sail numbers used at each event, class standings, and official championship awards.

• Profile photos and avatars are stored in private buckets and are never publicly served unless an authorised profile owner or verified parent/guardian has explicitly enabled public sharing.
• Date-of-birth records used to verify age-group eligibility and youth index cutoffs remain protected and are never exposed on public profile pages.
• Personal race notes, equipment locker items, and coach debriefs live exclusively inside authenticated Sailor, Parent, and Coach workspaces.

## Hardened Evidence Storage and Claim Quotas

When sailors or parents submit supporting documentation or result evidence, those uploads are now governed by stricter storage policies:

• Supporting evidence files are restricted to accounts with an approved sailor or guardian claim and are served only through short-lived, authorised access checks.
• Per-user upload quotas and file validation checks protect the platform against automated abuse while keeping legitimate result verification fast.

## International Championship Awards on Public Profiles

We also refined how official division awards—such as Girls' overall podiums, U16/U12 prizes, and double-handed 29er helm and crew medals—are displayed on public profiles. Every award badge links back to the specific division scorecard where it was won.`,
    kind: "product_update",
    authorDisplayName: "SailorPath",
    publishedAt: "2026-10-27T10:00:00.000+08:00",
    updatedAt: "2026-10-27T10:00:00.000+08:00",
    relatedClass: null,
    relatedRegion: "International",
    sourceUrl: "https://sailorpath.com/privacy",
    sourceLabel: "SailorPath Privacy Policy",
    tags: ["privacy", "profiles", "guardian-consent", "security", "product"],
  },
  {
    slug: "2026-asian-games-and-youth-worlds-coverage",
    title:
      "20th Asian Games 2026 Sailing Standings and Youth World Championship Results Added",
    summary:
      "SailorPath adds verified overall standings from the 20th Asian Games in Gamagori across five classes, alongside race-by-race scorecards from the 2026 ILCA 4 Youth World Championships and regional Asian Cup regattas.",
    body: `SailorPath has expanded its international championship archive with official standings from the 20th Asian Games 2026 in Gamagori, Japan, alongside full race-by-race scorecards from recent youth world and regional championships.

## 20th Asian Games 2026 (Kaiyoh Yacht Harbor, Japan)

Overall standings, final ranks, net scores, and medal outcomes from racing at Kaiyoh Yacht Harbor (26 September – 3 October 2026) are now live across five classes:

• ILCA 4 (Men's and Women's divisions)
• ILCA 6
• ILCA 7
• 29er (including full helm and crew participant attribution)
• iQFOiL

Source and verification note: Overall standings, final ranks, and net totals have been corroborated across official Asian Games Organising Committee (AINAGOC), Asian Sailing Federation (ASAF), World Sailing, and national federation releases. Individual race-by-race scores for the Asian Games sheets remain deferred pending release of the consolidated official final race-by-race PDF and are not marked as PDF-verified.

## 2026 ILCA 4 Youth Worlds and Regional ILCA Coverage

Alongside the Asian Games standings, we have published complete race-by-race scorecards and updated demographic records across key international and regional youth fleets:

• 2026 ILCA 4 Youth World Championships
• 2026 ILCA Asian Cup (Penghu)
• East and West Japan Optimist Championships and JODA National Team Final Selection Trials

Each imported scorecard links directly to its source attribution and updates the career histories and international prize records of participating sailors.`,
    kind: "result_report",
    authorDisplayName: "SailorPath",
    publishedAt: "2026-10-22T09:00:00.000+08:00",
    updatedAt: "2026-10-22T09:00:00.000+08:00",
    relatedClass: "ILCA 4",
    relatedRegion: "Asia",
    sourceUrl: "https://sailorpath.com/results",
    sourceLabel: "Browse published championship scorecards",
    tags: [
      "asian-games",
      "ilca-4",
      "ilca-6",
      "ilca-7",
      "29er",
      "iqfoil",
      "results",
    ],
  },
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

  return withArticleMedia({
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
  });
}

async function readPublishedNews(): Promise<PublishedNewsArticle[]> {
  const rows = await db
    .select(PUBLIC_NEWS_COLUMNS)
    .from(newsArticles)
    .where(eq(newsArticles.status, "published"))
    .orderBy(desc(newsArticles.publishedAt));

  const publishedRows = rows.map(toPublishedArticle);
  const existingSlugs = new Set(publishedRows.map((row) => row.slug));
  const missingFallbacks = FALLBACK_ARTICLES.filter(
    (article) => !existingSlugs.has(article.slug)
  ).map(withArticleMedia);

  return [...publishedRows, ...missingFallbacks].sort((a, b) =>
    b.publishedAt.localeCompare(a.publishedAt)
  );
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

  if (row) return toPublishedArticle(row);
  const fallback = FALLBACK_ARTICLES.find((article) => article.slug === slug);
  return fallback ? withArticleMedia(fallback) : null;
}

const getCachedPublishedNews = unstable_cache(
  readPublishedNews,
  ["published-news-v4"],
  {
    revalidate: PUBLIC_DATA_REVALIDATE_SECONDS,
    tags: [CACHE_TAG_NEWS_ARTICLES],
  }
);

function cachedArticleLookup(slug: string) {
  return unstable_cache(
    () => readPublishedNewsArticle(slug),
    ["published-news-article-v4", slug],
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
    return FALLBACK_ARTICLES.map(withArticleMedia);
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
    const fallback = FALLBACK_ARTICLES.find((article) => article.slug === normalized);
    return fallback ? withArticleMedia(fallback) : null;
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
