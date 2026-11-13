import type { Metadata } from "next";
import Image from "next/image";
import Link from "next/link";
import { Fragment } from "react";
import { notFound } from "next/navigation";
import { formatNewsDate, getPublishedNewsArticle } from "@/lib/news";
import { parseNewsBody } from "@/lib/newsBody";

type NewsArticlePageProps = {
  params: Promise<{ slug: string }>;
};

const ARTICLE_SCREENSHOTS: Record<string, { heading: string; src: string; alt: string; caption: string }> = {
  "parent-workspace-gear-coach-notes": {
    heading: "Start with the overview",
    src: "/news/ui-parent-workspace-desktop.jpg",
    alt: "Desktop parent workspace demo showing a sample sailor and the workspace tabs.",
    caption: "The parent workspace demo uses sample data.",
  },
  "connected-records-for-helm-and-crew": {
    heading: "See the sailors behind an entry",
    src: "/news/ui-crew-results-desktop.jpg",
    alt: "Desktop Hong Kong Race Week 29er results showing both sailors in each boat.",
    caption: "SailorPath’s Hong Kong Race Week 2026 29er results show sailors together.",
  },
};

function labelForKind(kind: string): string {
  return kind.replace(/_/g, " ");
}

export async function generateMetadata({
  params,
}: NewsArticlePageProps): Promise<Metadata> {
  const { slug } = await params;
  const article = await getPublishedNewsArticle(slug);

  if (!article) {
    return {
      title: "Update not found | SailorPath",
      robots: { index: false, follow: false },
    };
  }

  return {
    title: `${article.title} | SailorPath`,
    description: article.summary,
    alternates: { canonical: `/news/${article.slug}` },
    openGraph: {
      type: "article",
      title: article.title,
      description: article.summary,
      publishedTime: article.publishedAt,
      modifiedTime: article.updatedAt,
      ...(article.imageUrl ? { images: [{ url: article.imageUrl, alt: article.imageAlt || article.title }] } : {}),
    },
  };
}

export default async function NewsArticlePage({
  params,
}: NewsArticlePageProps) {
  const { slug } = await params;
  const article = await getPublishedNewsArticle(slug);
  if (!article) notFound();

  const publishedLabel = formatNewsDate(article.publishedAt);
  const updatedLabel = formatNewsDate(article.updatedAt);
  const blocks = parseNewsBody(article.body);

  return (
    <main className="mx-auto max-w-3xl px-4 py-10 sm:px-6 sm:py-14">
      <Link href="/news" className="text-sm font-semibold text-harbour hover:underline">
        ← SailorPath updates
      </Link>

      <article className="mt-7 rounded-3xl border border-cool-veil bg-warm-white p-6 shadow-xs sm:p-10">
        <div className="flex flex-wrap items-center gap-2 text-xs font-bold uppercase tracking-[0.14em] text-harbour">
          <span>{labelForKind(article.kind)}</span>
          <span aria-hidden="true">·</span>
          <time dateTime={article.publishedAt}>{publishedLabel}</time>
        </div>
        <h1 className="mt-4 text-3xl font-black tracking-tight text-harbour-shadow sm:text-5xl">
          {article.title}
        </h1>
        <p className="mt-5 text-lg leading-8 text-slate-soft">{article.summary}</p>

        {article.imageUrl ? (
          <figure className="mt-7 overflow-hidden rounded-2xl border border-cool-veil bg-sailcloth">
            <Image
              src={article.imageUrl}
              alt={article.imageAlt || article.title}
              width={800}
              height={534}
              unoptimized
              className={`w-full ${article.imageUrl.startsWith("/news/ui-") ? "max-h-[640px] object-contain" : "aspect-video object-cover"}`}
            />
            {article.imageCaption || article.imageCredit ? (
              <figcaption className="border-t border-cool-veil bg-warm-white px-4 py-3 text-xs leading-5 text-slate-soft">
                {article.imageCaption ? <span>{article.imageCaption} </span> : null}
                {article.imageCredit ? (
                  article.imageCreditUrl ? (
                    <a
                      href={article.imageCreditUrl}
                      target="_blank"
                      rel="noreferrer"
                      className="font-semibold text-harbour hover:underline"
                    >
                      {article.imageCredit}
                    </a>
                  ) : (
                    <span className="font-medium">{article.imageCredit}</span>
                  )
                ) : null}
              </figcaption>
            ) : null}
          </figure>
        ) : null}

        <div className="mt-8 space-y-5 text-base leading-8 text-charcoal">
          {blocks.map((block, index) =>
            block.type === "heading" ? (
              block.level === 2 ? (
                <Fragment key={index}>
                  <h2 className="pt-3 text-2xl font-extrabold tracking-tight text-harbour-shadow">
                    {block.text}
                  </h2>
                  {ARTICLE_SCREENSHOTS[article.slug]?.heading === block.text ? (
                    <figure className="overflow-hidden rounded-2xl border border-cool-veil bg-sailcloth">
                      <Image
                        src={ARTICLE_SCREENSHOTS[article.slug].src}
                        alt={ARTICLE_SCREENSHOTS[article.slug].alt}
                        width={1272}
                        height={716}
                        unoptimized
                        className="h-auto w-full"
                      />
                      <figcaption className="border-t border-cool-veil bg-warm-white px-4 py-3 text-xs leading-5 text-slate-soft">
                        {ARTICLE_SCREENSHOTS[article.slug].caption} Screenshot: SailorPath.
                      </figcaption>
                    </figure>
                  ) : null}
                </Fragment>
              ) : (
                <h3 key={index} className="pt-2 text-xl font-extrabold text-harbour-shadow">
                  {block.text}
                </h3>
              )
            ) : block.type === "list" ? (
              <ul key={index} className="list-disc space-y-2 pl-6">
                {block.items.map((item) => (
                  <li key={item}>{item}</li>
                ))}
              </ul>
            ) : (
              <p key={index}>{block.text}</p>
            ),
          )}
        </div>

        {article.relatedClass === "X-15" ? (
          <p className="mt-8">
            <Link href="/classes/x15" className="font-semibold text-harbour hover:underline">
              Open the X-15 class hub →
            </Link>
          </p>
        ) : null}

        <footer className="mt-9 border-t border-cool-veil pt-5 text-sm text-slate-soft">
          <p>Published by {article.authorDisplayName}.</p>
          {article.updatedAt !== article.publishedAt ? (
            <p className="mt-1">Last updated {updatedLabel}.</p>
          ) : null}
          {article.sourceUrl ? (
            <p className="mt-3">
              <a
                href={article.sourceUrl}
                target="_blank"
                rel="noreferrer"
                className="font-semibold text-harbour hover:underline"
              >
                {article.sourceLabel || "Open source"} →
              </a>
            </p>
          ) : null}
        </footer>
      </article>
    </main>
  );
}
