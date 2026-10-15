import type { Metadata } from "next";
import Link from "next/link";
import { notFound } from "next/navigation";
import { formatNewsDate, getPublishedNewsArticle } from "@/lib/news";

type NewsArticlePageProps = {
  params: Promise<{ slug: string }>;
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
  const paragraphs = article.body
    .split(/\n{2,}/)
    .map((paragraph) => paragraph.trim())
    .filter(Boolean);

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

        <div className="mt-8 space-y-5 text-base leading-8 text-charcoal">
          {paragraphs.map((paragraph) => (
            <p key={paragraph}>{paragraph}</p>
          ))}
        </div>

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
