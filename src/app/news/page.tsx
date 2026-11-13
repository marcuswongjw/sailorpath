import type { Metadata } from "next";
import Image from "next/image";
import Link from "next/link";
import { formatNewsDate, listPublishedNews, type PublishedNewsArticle } from "@/lib/news";

export const metadata: Metadata = {
  title: "SailorPath updates | SailorPath",
  description: "Release notes, result coverage and public-data updates from SailorPath.",
};

const kindLabels: Record<PublishedNewsArticle["kind"], string> = {
  result_report: "Results",
  correction: "Correction",
  class_announcement: "Class news",
  product_update: "SailorPath news",
  partner_update: "Partners",
};

function UpdateCard({ update, featured = false }: { update: PublishedNewsArticle; featured?: boolean }) {
  return (
    <article className={`overflow-hidden rounded-2xl border border-cool-veil bg-warm-white shadow-xs ${featured && update.imageUrl ? "sm:grid sm:grid-cols-2" : "flex h-full flex-col"}`}>
      {update.imageUrl ? (
        <figure className={`min-w-0 bg-sailcloth ${featured ? "sm:flex sm:flex-col" : ""}`}>
          <Link href={`/news/${update.slug}`} aria-label={`Read ${update.title}`} className={`block overflow-hidden ${featured ? "sm:flex-1" : ""}`}>
            <Image
              src={update.imageUrl}
              alt={update.imageAlt || update.title}
              width={800}
              height={534}
              unoptimized
              className={`aspect-[16/9] w-full ${update.imageUrl.startsWith("/news/ui-") ? "object-contain" : "object-cover"} ${featured ? "sm:h-full sm:min-h-64" : ""}`}
            />
          </Link>
          {update.imageCredit ? (
            <figcaption className="border-t border-cool-veil px-4 py-2 text-[11px] leading-4 text-slate-soft">
              {update.imageCreditUrl ? <a href={update.imageCreditUrl} target="_blank" rel="noreferrer" className="hover:text-harbour hover:underline">{update.imageCredit}</a> : update.imageCredit}
            </figcaption>
          ) : null}
        </figure>
      ) : null}
      <div className={`flex min-w-0 flex-1 flex-col p-5 ${featured ? "sm:justify-center sm:p-8" : "sm:p-6"}`}>
        <div className="flex flex-wrap items-center gap-x-2 gap-y-1 text-xs font-semibold text-slate-soft">
          {featured && <span className="rounded-full bg-aqua-mist px-2.5 py-1 font-bold text-harbour">Latest update</span>}
          <time dateTime={update.publishedAt}>{formatNewsDate(update.publishedAt)}</time>
          <span aria-hidden="true">·</span>
          <span>{kindLabels[update.kind]}</span>
          {update.relatedRegion ? <><span aria-hidden="true">·</span><span>{update.relatedRegion}</span></> : null}
          {update.relatedClass ? <><span aria-hidden="true">·</span><span>{update.relatedClass}</span></> : null}
        </div>
        <h2 className={`mt-3 font-bold tracking-tight text-harbour-shadow ${featured ? "text-2xl sm:text-3xl" : "text-xl"}`}>
          <Link href={`/news/${update.slug}`} className="hover:text-harbour hover:underline focus-visible:outline-2 focus-visible:outline-harbour">{update.title}</Link>
        </h2>
        <p className="mt-3 text-sm leading-6 text-charcoal">{update.summary}</p>
        <Link href={`/news/${update.slug}`} aria-label={`Read ${update.title}`} className="mt-4 inline-flex self-start text-sm font-bold text-harbour hover:underline focus-visible:outline-2 focus-visible:outline-harbour">Read update <span aria-hidden="true" className="ml-1">→</span></Link>
      </div>
    </article>
  );
}

export default async function NewsPage() {
  const updates = await listPublishedNews();
  const [latest, ...earlier] = updates;

  return (
    <main className="mx-auto max-w-6xl space-y-8 px-4 py-10 sm:px-6 sm:py-14">
      <header className="max-w-2xl space-y-3">
        <p className="text-xs font-bold uppercase tracking-[0.16em] text-harbour">SailorPath updates</p>
        <h1 className="text-3xl font-black tracking-tight text-harbour-shadow sm:text-4xl">What&apos;s new</h1>
        <p className="text-base leading-7 text-slate-soft">The latest sailing results, class news and updates from SailorPath.</p>
      </header>

      {latest ? (
        <section aria-label="Updates" className="space-y-8">
          <UpdateCard update={latest} featured />
          {earlier.length > 0 && <div className="space-y-4">
            <h2 className="text-xl font-bold text-harbour-shadow">More updates</h2>
            <div className="grid gap-4 sm:grid-cols-2">
              {earlier.map((update) => <UpdateCard key={update.slug} update={update} />)}
            </div>
          </div>}
        </section>
      ) : (
        <section className="rounded-2xl border border-cool-veil bg-warm-white p-6 text-sm leading-6 text-slate-soft">Published SailorPath updates will appear here.</section>
      )}

      <p className="border-t border-cool-veil pt-6 text-sm text-slate-soft">
        Browse <Link href="/results" className="font-semibold text-harbour hover:underline">published scorecards</Link> or visit the <Link href="/calendar" className="font-semibold text-harbour hover:underline">regatta calendar</Link>.
      </p>
    </main>
  );
}
