import { desc, eq } from "drizzle-orm";
import { NextResponse } from "next/server";
import { db, withDatabaseRetry } from "@/db";
import { newsArticles } from "@/db/schema";
import { logAdminChange } from "@/lib/adminChangeLog";
import { requireSuperadmin, jsonError } from "@/lib/auth";
import {
  parseEditorialAction,
  parseEditorialFields,
  transitionEditorialStatus,
  type EditorialStatus,
} from "@/lib/editorialWorkflow";
import { revalidatePublicNews } from "@/lib/revalidatePublic";

export const dynamic = "force-dynamic";

const ADMIN_NEWS_COLUMNS = {
  id: newsArticles.id,
  slug: newsArticles.slug,
  status: newsArticles.status,
  kind: newsArticles.kind,
  title: newsArticles.title,
  summary: newsArticles.summary,
  body: newsArticles.body,
  authorDisplayName: newsArticles.authorDisplayName,
  reviewedBy: newsArticles.reviewedBy,
  reviewedAt: newsArticles.reviewedAt,
  publishedAt: newsArticles.publishedAt,
  updatedAt: newsArticles.updatedAt,
  relatedClass: newsArticles.relatedClass,
  relatedRegion: newsArticles.relatedRegion,
  sourceUrl: newsArticles.sourceUrl,
  sourceLabel: newsArticles.sourceLabel,
  tags: newsArticles.tags,
} as const;

type ArticleStatus = EditorialStatus;
type AdminNewsRow = Pick<
  typeof newsArticles.$inferSelect,
  keyof typeof ADMIN_NEWS_COLUMNS
>;

function serializeArticle(row: AdminNewsRow) {
  return {
    id: row.id,
    slug: row.slug,
    status: row.status,
    kind: row.kind,
    title: row.title,
    summary: row.summary,
    body: row.body,
    authorDisplayName: row.authorDisplayName,
    reviewedBy: row.reviewedBy,
    reviewedAt: row.reviewedAt?.toISOString() ?? null,
    publishedAt: row.publishedAt?.toISOString() ?? null,
    updatedAt: row.updatedAt.toISOString(),
    relatedClass: row.relatedClass,
    relatedRegion: row.relatedRegion,
    sourceUrl: row.sourceUrl,
    sourceLabel: row.sourceLabel,
    tags: Array.isArray(row.tags) ? row.tags.filter((tag): tag is string => typeof tag === "string") : [],
  };
}

function isArticleStatus(value: string): value is ArticleStatus {
  return ["draft", "in_review", "published", "archived"].includes(value);
}

export async function GET() {
  try {
    await requireSuperadmin();
    const rows = await withDatabaseRetry(
      () =>
        db
          .select(ADMIN_NEWS_COLUMNS)
          .from(newsArticles)
          .orderBy(desc(newsArticles.updatedAt))
          .limit(100),
      { label: "admin.news.get" }
    );
    return NextResponse.json({ ok: true, articles: rows.map(serializeArticle) });
  } catch (error) {
    return jsonError(error);
  }
}

export async function POST(request: Request) {
  try {
    const auth = await requireSuperadmin();
    const fields = parseEditorialFields(await request.json());
    const now = new Date();
    const [article] = await db
      .insert(newsArticles)
      .values({
        ...fields,
        status: "draft",
        updatedAt: now,
      })
      .returning();

    if (!article) throw new Error("failed to create editorial draft");

    void logAdminChange({
      actorUserId: auth.userId,
      actorEmail: auth.email,
      action: "editorial_draft_create",
      entityType: "news_article",
      entityId: article.id,
      entityLabel: article.slug,
      summary: `Created editorial draft ${article.title}`,
      details: { status: article.status, kind: article.kind },
      source: "/api/admin/news",
    });

    return NextResponse.json({ ok: true, article: serializeArticle(article) }, { status: 201 });
  } catch (error) {
    return jsonError(error);
  }
}

export async function PATCH(request: Request) {
  try {
    const auth = await requireSuperadmin();
    const input = await request.json() as Record<string, unknown>;
    const id = String(input.id ?? "").trim();
    if (!id) return NextResponse.json({ error: "article id is required" }, { status: 400 });

    const action = parseEditorialAction(input.action);
    const fields = parseEditorialFields(input);
    const [existing] = await db
      .select()
      .from(newsArticles)
      .where(eq(newsArticles.id, id))
      .limit(1);
    if (!existing) return NextResponse.json({ error: "editorial article not found" }, { status: 404 });
    if (!isArticleStatus(existing.status)) throw new Error("unsupported stored editorial status");

    const status = transitionEditorialStatus(existing.status, action);
    const now = new Date();
    const lifecycle =
      action === "publish"
        ? {
            status,
            reviewedBy: auth.userId,
            reviewedAt: now,
            publishedAt: existing.publishedAt ?? now,
          }
        : action === "archive"
          ? { status }
          : {
              status,
              reviewedBy: null,
              reviewedAt: null,
              publishedAt: null,
            };

    const [article] = await db
      .update(newsArticles)
      .set({
        ...fields,
        ...lifecycle,
        updatedAt: now,
      })
      .where(eq(newsArticles.id, id))
      .returning();
    if (!article) throw new Error("failed to update editorial article");

    revalidatePublicNews(existing.slug);
    if (article.slug !== existing.slug) revalidatePublicNews(article.slug);

    void logAdminChange({
      actorUserId: auth.userId,
      actorEmail: auth.email,
      action: `editorial_${action}`,
      entityType: "news_article",
      entityId: article.id,
      entityLabel: article.slug,
      summary: `${action.replace(/_/g, " ")} editorial article ${article.title}`,
      details: {
        before: { slug: existing.slug, status: existing.status },
        after: { slug: article.slug, status: article.status, kind: article.kind },
      },
      source: "/api/admin/news",
    });

    return NextResponse.json({ ok: true, article: serializeArticle(article) });
  } catch (error) {
    return jsonError(error);
  }
}
