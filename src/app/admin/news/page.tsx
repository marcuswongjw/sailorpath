import { desc } from "drizzle-orm";
import { headers } from "next/headers";
import { notFound, redirect } from "next/navigation";
import { AdminNewsWorkflow } from "@/components/admin/AdminNewsWorkflow";
import { AdminSignInGate } from "@/components/admin/AdminSignInGate";
import { db, withDatabaseRetry } from "@/db";
import { newsArticles } from "@/db/schema";
import { getAuthContext } from "@/lib/auth";
import { adminLoginOrigin, adminReturnUrl, isAdminHost } from "@/lib/adminHost";

export const dynamic = "force-dynamic";

export default async function AdminNewsPage({
  searchParams,
}: {
  searchParams: Promise<{ article?: string }>;
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

  const articles = await withDatabaseRetry(
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
  const { article: selectedId } = await searchParams;
  return <AdminNewsWorkflow articles={articles} selected={articles.find((article) => article.id === selectedId) ?? null} />;
}
