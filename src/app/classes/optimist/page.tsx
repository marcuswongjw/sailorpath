import type { Metadata } from "next";
import Link from "next/link";
import { ExternalLink } from "lucide-react";

export const metadata: Metadata = {
  title: "Optimist class hub | SailorPath",
  description:
    "The Optimist is a single-handed one-design pram for young sailors. Class history from the International Optimist Dinghy Association, plus SailorPath links.",
  alternates: { canonical: "/classes/optimist" },
};

const iodaHistoryHref =
  "https://www.optiworld.org/default/news/new/text/clark-mills-the-designer-of-the-optimist-inducted-into-us-hall-of-fame";

const history = [
  {
    year: "1947",
    title: "Clearwater, Florida",
    body: "Clark Mills designed the pram for the Optimist Club after Clifford McKay asked for a cheap boat children could build and sail. Mills gave the design away and took no royalties.",
  },
  {
    year: "1958",
    title: "Denmark",
    body: "Axel Damgaard took a boat home to Denmark. The rig was modified, and that boat became the International Optimist.",
  },
] as const;

const sailorPathLinks = [
  ["/sg/optimist/gold", "Singapore Optimist Gold, Best 3 of 5"],
  ["/sg/optimist/silver", "Singapore Optimist Silver, Best 3 of 5"],
  ["/sg/optimist/selection", "2026 Singapore Optimist selection trials"],
  ["/optimist/asian-index", "Asian and Oceania Optimist Index, V1 (Beta)"],
  ["/optimist/asian-index/methodology", "Index methodology"],
] as const;

export default function OptimistClassHub() {
  return (
    <main className="mx-auto max-w-6xl space-y-10 px-4 py-10 sm:px-6 sm:py-14">
      <header className="rounded-3xl border border-harbour/15 bg-harbour-shadow px-6 py-8 text-sailcloth shadow-sm sm:px-10 sm:py-12">
        <p className="text-xs font-bold uppercase tracking-[0.16em] text-soft-aqua">
          Class hub
        </p>
        <h1 className="mt-3 text-3xl font-black tracking-tight sm:text-5xl">
          The Optimist
        </h1>
        <p className="mt-4 max-w-2xl text-base leading-7 text-soft-aqua sm:text-lg">
          A single-handed one-design pram for young sailors, with a sprit sail.
          The International Optimist Dinghy Association administers the class.
        </p>
        <div className="mt-6 flex flex-wrap gap-3">
          <a
            href="https://www.optiworld.org/"
            target="_blank"
            rel="noreferrer"
            className="sp-primary inline-flex items-center gap-2 px-4 py-2.5 text-sm font-bold"
          >
            <ExternalLink className="h-4 w-4" />
            IODA
          </a>
          <Link
            href="/classes"
            className="inline-flex items-center gap-2 rounded-xl border border-soft-aqua/40 px-4 py-2.5 text-sm font-bold text-sailcloth hover:bg-white/10"
          >
            All classes
          </Link>
        </div>
      </header>

      <section className="grid gap-4 md:grid-cols-2" aria-label="Optimist class description">
        <article className="rounded-2xl border border-cool-veil bg-warm-white p-5">
          <p className="text-xs font-bold uppercase tracking-wider text-harbour">The boat</p>
          <p className="mt-2 text-lg font-black text-harbour-shadow">Closed one-design</p>
          <p className="mt-2 text-sm leading-6 text-slate-soft">
            IODA class rules say that, except where a variation is allowed, Optimists are alike
            in hull, construction, weight, spars, and sail plan.
          </p>
        </article>
        <article className="rounded-2xl border border-cool-veil bg-warm-white p-5">
          <p className="text-xs font-bold uppercase tracking-wider text-harbour">Who races it</p>
          <p className="mt-2 text-lg font-black text-harbour-shadow">Through the year they turn 15</p>
          <p className="mt-2 text-sm leading-6 text-slate-soft">
            IODA championship eligibility allows a sailor to enter until 31 December of the year
            in which they turn 15. That is the IODA championship rule.
          </p>
        </article>
      </section>

      <section className="rounded-2xl border border-cool-veil bg-warm-white p-5 sm:p-6" aria-labelledby="optimist-history-heading">
        <p className="text-xs font-bold uppercase tracking-[0.16em] text-harbour">Class history</p>
        <h2 id="optimist-history-heading" className="mt-2 text-2xl font-black text-harbour-shadow">
          From a Florida pram to the International Optimist
        </h2>
        <ol className="mt-5 space-y-4 border-l border-cool-veil pl-5">
          {history.map((item) => (
            <li key={item.year} className="relative">
              <span className="absolute -left-[1.84rem] top-1.5 h-2.5 w-2.5 rounded-full bg-harbour" />
              <p className="text-sm font-black text-harbour">{item.year}</p>
              <h3 className="mt-0.5 text-sm font-bold text-charcoal">{item.title}</h3>
              <p className="mt-1 text-sm leading-6 text-slate-soft">{item.body}</p>
              <a
                href={iodaHistoryHref}
                target="_blank"
                rel="noreferrer"
                className="mt-1 inline-flex items-center gap-1 text-xs font-semibold text-harbour hover:underline"
              >
                <ExternalLink className="h-3.5 w-3.5" />
                IODA account
              </a>
            </li>
          ))}
        </ol>
      </section>

      <section aria-labelledby="optimist-sailorpath-heading">
        <h2 id="optimist-sailorpath-heading" className="text-xs font-bold uppercase tracking-[0.16em] text-harbour">
          On SailorPath
        </h2>
        <p className="mt-3 max-w-2xl text-sm leading-6 text-slate-soft">
          Singapore Gold and Silver Fleet Ranking. The SailorPath Asian and Oceania Optimist Index
          is an independent SailorPath initiative, not an official index. It is currently in beta version.
        </p>
        <ul className="mt-4 flex flex-wrap gap-3">
          {sailorPathLinks.map(([href, label]) => (
            <li key={href}>
              <Link
                href={href}
                className="inline-flex rounded-xl border border-cool-veil bg-warm-white px-4 py-2.5 text-sm font-bold text-harbour hover:border-harbour"
              >
                {label}
              </Link>
            </li>
          ))}
        </ul>
      </section>
    </main>
  );
}
