import { desc } from "drizzle-orm";
import { headers } from "next/headers";
import { notFound, redirect } from "next/navigation";
import { AdminNewsWorkflow, type AdminNewsWorkflowArticle } from "@/components/admin/AdminNewsWorkflow";
import { AdminSignInGate } from "@/components/admin/AdminSignInGate";
import { db, withDatabaseRetry } from "@/db";
import { newsArticles } from "@/db/schema";
import { getAuthContext } from "@/lib/auth";
import { adminLoginOrigin, adminReturnUrl, isAdminHost } from "@/lib/adminHost";
import { SEEDED_EDITORIAL_DRAFTS } from "@/lib/editorialWorkflow";

export const dynamic = "force-dynamic";

async function ensureSeededDraftsInDatabase() {
  try {
    for (const draft of SEEDED_EDITORIAL_DRAFTS) {
      await db
        .insert(newsArticles)
        .values({
          id: draft.id,
          slug: draft.slug,
          status: draft.status,
          kind: draft.kind,
          title: draft.title,
          summary: draft.summary,
          body: draft.body,
          authorDisplayName: draft.authorDisplayName,
          relatedClass: draft.relatedClass,
          relatedRegion: draft.relatedRegion,
          sourceUrl: draft.sourceUrl,
          sourceLabel: draft.sourceLabel,
          tags: draft.tags,
          updatedAt: draft.createdAt,
        })
        .onConflictDoNothing();
    }
  } catch (error) {
    console.warn("[admin/news] Skipping automatic draft seed:", error);
  }
}

function mergeSeededFallback(rows: AdminNewsWorkflowArticle[]): AdminNewsWorkflowArticle[] {
  const existingIds = new Set(rows.map((row) => row.id));
  const existingSlugs = new Set(rows.map((row) => row.slug));
  const missingSeeds: AdminNewsWorkflowArticle[] = SEEDED_EDITORIAL_DRAFTS.filter(
    (seed) => !existingIds.has(seed.id) && !existingSlugs.has(seed.slug)
  ).map((seed) => ({
    id: seed.id,
    slug: seed.slug,
    status: seed.status,
    kind: seed.kind,
    title: seed.title,
    summary: seed.summary,
    body: seed.body,
    authorDisplayName: seed.authorDisplayName,
    relatedClass: seed.relatedClass,
    relatedRegion: seed.relatedRegion,
    sourceUrl: seed.sourceUrl,
    sourceLabel: seed.sourceLabel,
    tags: [...seed.tags],
    updatedAt: seed.createdAt,
    publishedAt: null,
  }));
  return [...missingSeeds, ...rows];
}

export default async function AdminNewsPage({
  searchParams,
}: {
  searchParams: Promise<{ article?: string; error?: string; saved?: string }>;
}) {
  const host = (await headers()).get("host") || "";
  if (host.includes("sailorpath.com") && !host.includes("admin.sailorpath.com")) redirect("https://admin.sailorpath.com/admin/news");
  if (!isAdminHost(host)) notFound();
  let auth: Awaited<ReturnType<typeof getAuthContext>>;
  try {
    auth = await getAuthContext();
  } catch (error) {
    console.error("[admin/news] Temporary error verifying admin session", error);
    return <AdminSignInGate reason="unavailable" nextUrl={adminReturnUrl(host, "/admin/news")} siteOrigin={adminLoginOrigin(host)} />;
  }
  if (!auth) return <AdminSignInGate reason="unsigned" nextUrl={adminReturnUrl(host, "/admin/news")} siteOrigin={adminLoginOrigin(host)} />;
  if (auth.role !== "superadmin") return <AdminSignInGate reason="forbidden" nextUrl={adminReturnUrl(host, "/admin/news")} siteOrigin={adminLoginOrigin(host)} />;

  const { article: selectedId, error: queryError, saved: querySaved } = await searchParams;

  let articles: AdminNewsWorkflowArticle[] = [];
  let loadError: string | null = null;
  try {
    await ensureSeededDraftsInDatabase();
    const rows = await withDatabaseRetry(
      () =>
        db
          .select({
            id: newsArticles.id,
            slug: newsArticles.slug,
            status: newsArticles.status,
            kind: newsArticles.kind,
            title: newsArticles.title,
            summary: newsArticles.summary,
            body: newsArticles.body,
            authorDisplayName: newsArticles.authorDisplayName,
            relatedClass: newsArticles.relatedClass,
            relatedRegion: newsArticles.relatedRegion,
            sourceUrl: newsArticles.sourceUrl,
            sourceLabel: newsArticles.sourceLabel,
            tags: newsArticles.tags,
            updatedAt: newsArticles.updatedAt,
            publishedAt: newsArticles.publishedAt,
          })
          .from(newsArticles)
          .orderBy(desc(newsArticles.updatedAt))
          .limit(100),
      { label: "admin.news.page" }
    );
    articles = mergeSeededFallback(
      rows.map((row) => ({
        ...row,
        tags: Array.isArray(row.tags) ? row.tags.filter((tag): tag is string => typeof tag === "string") : [],
      }))
    );
  } catch (error) {
    console.error("[admin/news] Failed to load editorial articles from database", error);
    articles = mergeSeededFallback([]);
    loadError = "Database connection was temporarily unavailable; showing seeded editorial drafts.";
  }

  const selected =
    selectedId === "new"
      ? null
      : selectedId
        ? (articles.find((article) => article.id === selectedId) ?? null)
        : (articles.find((article) => article.status === "draft") ?? null);

  return (
    <AdminNewsWorkflow
      articles={articles}
      selected={selected}
      errorMessage={queryError ?? loadError}
      savedMessage={querySaved ?? null}
    />
  );
}
