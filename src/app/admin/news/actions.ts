"use server";

import { eq } from "drizzle-orm";
import { redirect } from "next/navigation";
import { db } from "@/db";
import { newsArticles } from "@/db/schema";
import { logAdminChange } from "@/lib/adminChangeLog";
import { requireSuperadmin } from "@/lib/auth";
import {
  parseEditorialAction,
  parseEditorialFields,
  transitionEditorialStatus,
  type EditorialStatus,
} from "@/lib/editorialWorkflow";
import { revalidatePublicNews } from "@/lib/revalidatePublic";

function valuesFromForm(formData: FormData) {
  return {
    slug: formData.get("slug"),
    kind: formData.get("kind"),
    title: formData.get("title"),
    summary: formData.get("summary"),
    body: formData.get("body"),
    authorDisplayName: formData.get("authorDisplayName"),
    relatedClass: formData.get("relatedClass"),
    relatedRegion: formData.get("relatedRegion"),
    sourceUrl: formData.get("sourceUrl"),
    sourceLabel: formData.get("sourceLabel"),
    tags: formData.get("tags"),
  };
}

function routeForArticle(id: string) {
  return `/admin/news?article=${encodeURIComponent(id)}`;
}

export async function createEditorialDraft(formData: FormData) {
  const auth = await requireSuperadmin();
  const fields = parseEditorialFields(valuesFromForm(formData));
  const now = new Date();
  const [article] = await db
    .insert(newsArticles)
    .values({ ...fields, status: "draft", updatedAt: now })
    .returning({ id: newsArticles.id, slug: newsArticles.slug, title: newsArticles.title });
  if (!article) throw new Error("failed to create editorial draft");

  void logAdminChange({
    actorUserId: auth.userId,
    actorEmail: auth.email,
    action: "editorial_draft_create",
    entityType: "news_article",
    entityId: article.id,
    entityLabel: article.slug,
    summary: `Created editorial draft ${article.title}`,
    source: "/admin/news",
  });
  redirect(routeForArticle(article.id));
}

export async function updateEditorialArticle(formData: FormData) {
  const auth = await requireSuperadmin();
  const id = String(formData.get("id") ?? "").trim();
  if (!id) throw new Error("article id is required");
  const action = parseEditorialAction(formData.get("action"));
  const fields = parseEditorialFields(valuesFromForm(formData));

  const [existing] = await db
    .select()
    .from(newsArticles)
    .where(eq(newsArticles.id, id))
    .limit(1);
  if (!existing) throw new Error("editorial article not found");
  const current = existing.status as EditorialStatus;
  const status = transitionEditorialStatus(current, action);
  const now = new Date();
  const lifecycle =
    action === "publish"
      ? { status, reviewedBy: auth.userId, reviewedAt: now, publishedAt: existing.publishedAt ?? now }
      : action === "archive"
        ? { status }
        : { status, reviewedBy: null, reviewedAt: null, publishedAt: null };

  const [article] = await db
    .update(newsArticles)
    .set({ ...fields, ...lifecycle, updatedAt: now })
    .where(eq(newsArticles.id, id))
    .returning({ id: newsArticles.id, slug: newsArticles.slug, title: newsArticles.title, status: newsArticles.status });
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
    details: { before: { slug: existing.slug, status: existing.status }, after: { slug: article.slug, status: article.status } },
    source: "/admin/news",
  });
  redirect(routeForArticle(article.id));
}
