"use server";

import { eq } from "drizzle-orm";
import { redirect } from "next/navigation";
import { db, withDatabaseRetry } from "@/db";
import { newsArticles, profiles } from "@/db/schema";
import { logAdminChange } from "@/lib/adminChangeLog";
import { requireSuperadmin } from "@/lib/auth";
import {
  parseEditorialAction,
  parseEditorialFields,
  SEEDED_EDITORIAL_DRAFTS,
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

function routeForArticle(id: string | null, params?: { saved?: string; error?: string }) {
  const query = new URLSearchParams();
  if (id) query.set("article", id);
  if (params?.saved) query.set("saved", params.saved);
  if (params?.error) query.set("error", params.error);
  const qs = query.toString();
  return qs ? `/admin/news?${qs}` : "/admin/news";
}

async function resolveReviewerProfileId(userId: string): Promise<string | null> {
  try {
    const [row] = await db
      .select({ id: profiles.id })
      .from(profiles)
      .where(eq(profiles.id, userId))
      .limit(1);
    return row?.id ?? null;
  } catch {
    return null;
  }
}

export async function createEditorialDraft(formData: FormData) {
  const auth = await requireSuperadmin();
  let targetUrl: string;

  try {
    const rawAction = formData.get("action");
    const action = rawAction ? parseEditorialAction(rawAction) : "save_draft";
    const status: EditorialStatus = action === "publish" ? "published" : "draft";
    const fields = parseEditorialFields(valuesFromForm(formData));
    const now = new Date();
    const reviewerId = status === "published" ? await resolveReviewerProfileId(auth.userId) : null;

    const [article] = await withDatabaseRetry(
      () =>
        db
          .insert(newsArticles)
          .values({
            ...fields,
            status,
            reviewedBy: reviewerId,
            reviewedAt: status === "published" ? now : null,
            publishedAt: status === "published" ? now : null,
            updatedAt: now,
          })
          .returning({
            id: newsArticles.id,
            slug: newsArticles.slug,
            title: newsArticles.title,
            status: newsArticles.status,
          }),
      { label: "admin.news.create" }
    );
    if (!article) throw new Error("failed to create editorial article");

    if (status === "published") {
      revalidatePublicNews(article.slug);
    }

    void logAdminChange({
      actorUserId: auth.userId,
      actorEmail: auth.email,
      action: status === "published" ? "editorial_publish" : "editorial_draft_create",
      entityType: "news_article",
      entityId: article.id,
      entityLabel: article.slug,
      summary: `${status === "published" ? "Published" : "Created editorial draft"} ${article.title}`,
      source: "/admin/news",
    });

    targetUrl = routeForArticle(article.id, {
      saved: status === "published" ? "Article published to /news." : "Draft saved.",
    });
  } catch (error) {
    const message = error instanceof Error ? error.message : "Unable to save editorial article";
    targetUrl = routeForArticle("new", { error: message });
  }

  redirect(targetUrl);
}

export async function updateEditorialArticle(formData: FormData) {
  const auth = await requireSuperadmin();
  const id = String(formData.get("id") ?? "").trim();
  if (!id) {
    redirect(routeForArticle("new", { error: "Article ID is required." }));
  }

  let targetUrl: string;
  try {
    const action = parseEditorialAction(formData.get("action"));
    const fields = parseEditorialFields(valuesFromForm(formData));

    let [existing] = await withDatabaseRetry(
      () =>
        db
          .select()
          .from(newsArticles)
          .where(eq(newsArticles.id, id))
          .limit(1),
      { label: "admin.news.lookup" }
    );
    if (!existing) {
      const seeded = SEEDED_EDITORIAL_DRAFTS.find((item) => item.id === id);
      if (seeded) {
        const [inserted] = await withDatabaseRetry(
          () =>
            db
              .insert(newsArticles)
              .values({
                id: seeded.id,
                slug: seeded.slug,
                status: seeded.status,
                kind: seeded.kind,
                title: seeded.title,
                summary: seeded.summary,
                body: seeded.body,
                authorDisplayName: seeded.authorDisplayName,
                relatedClass: seeded.relatedClass,
                relatedRegion: seeded.relatedRegion,
                sourceUrl: seeded.sourceUrl,
                sourceLabel: seeded.sourceLabel,
                tags: seeded.tags,
                updatedAt: seeded.createdAt,
              })
              .onConflictDoNothing()
              .returning(),
          { label: "admin.news.seed" }
        );
        existing = inserted;
      }
    }
    if (!existing) throw new Error("editorial article not found");
    const current = existing.status as EditorialStatus;
    const status = transitionEditorialStatus(current, action);
    const now = new Date();
    const reviewerId = action === "publish" ? await resolveReviewerProfileId(auth.userId) : null;
    const lifecycle =
      action === "publish"
        ? {
            status,
            reviewedBy: reviewerId,
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

    const [article] = await withDatabaseRetry(
      () =>
        db
          .update(newsArticles)
          .set({ ...fields, ...lifecycle, updatedAt: now })
          .where(eq(newsArticles.id, id))
          .returning({
            id: newsArticles.id,
            slug: newsArticles.slug,
            title: newsArticles.title,
            status: newsArticles.status,
          }),
      { label: "admin.news.update" }
    );
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
        after: { slug: article.slug, status: article.status },
      },
      source: "/admin/news",
    });

    const savedLabel =
      action === "publish"
        ? "Article published to /news."
        : action === "save_draft"
          ? "Saved as draft."
          : action === "submit_review"
            ? "Submitted for review."
            : "Article archived.";
    targetUrl = routeForArticle(article.id, { saved: savedLabel });
  } catch (error) {
    const message = error instanceof Error ? error.message : "Unable to update editorial article";
    targetUrl = routeForArticle(id, { error: message });
  }

  redirect(targetUrl);
}
