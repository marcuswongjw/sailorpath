import type { Metadata } from "next";
import Link from "next/link";
import { formatNewsDate, listPublishedNews } from "@/lib/news";

export const metadata: Metadata = {
  title: "SailorPath updates | SailorPath",
  description: "Release notes, result coverage and public-data updates from SailorPath.",
};

export default async function NewsPage() {
  const updates = await listPublishedNews();

  return (
    <main className="mx-auto max-w-4xl space-y-8 px-4 py-10 sm:px-6 sm:py-14">
      <header className="max-w-2xl space-y-3">
        <p className="text-xs font-bold uppercase tracking-[0.16em] text-harbour">
          SailorPath updates
        </p>
        <h1 className="text-3xl font-black tracking-tight text-harbour-shadow sm:text-4xl">
          What&apos;s new
        </h1>
        <p className="text-base leading-7 text-slate-soft">
          Product releases, result coverage and information about how SailorPath maintains public competition records.
        </p>
      </header>

      {updates.length ? (
        <section aria-label="Updates" className="space-y-4">
          {updates.map((update) => (
            <article
              key={update.slug}
              className="rounded-2xl border border-cool-veil bg-warm-white p-5 shadow-xs sm:p-6"
            >
              <div className="flex flex-wrap items-center gap-2 text-xs font-semibold text-harbour">
                <time dateTime={update.publishedAt}>{formatNewsDate(update.publishedAt)}</time>
                <span aria-hidden="true">·</span>
                <span className="capitalize">{update.kind.replace(/_/g, " ")}</span>
              </div>
              <h2 className="mt-2 text-xl font-bold text-harbour-shadow">
                <Link href={`/news/${update.slug}`} className="hover:underline">
                  {update.title}
                </Link>
              </h2>
              <p className="mt-3 text-sm leading-6 text-charcoal">{update.summary}</p>
              <Link
                href={`/news/${update.slug}`}
                className="mt-4 inline-flex text-sm font-bold text-harbour hover:underline"
              >
                Read update →
              </Link>
            </article>
          ))}
        </section>
      ) : (
        <section className="rounded-2xl border border-cool-veil bg-warm-white p-6 text-sm leading-6 text-slate-soft">
          Published SailorPath updates will appear here.
        </section>
      )}

      <p className="text-sm text-slate-soft">
        Browse{" "}
        <Link href="/results" className="font-semibold text-harbour hover:underline">
          published scorecards
        </Link>{" "}
        or visit the{" "}
        <Link href="/calendar" className="font-semibold text-harbour hover:underline">
          regatta calendar
        </Link>
        .
      </p>
    </main>
  );
}
