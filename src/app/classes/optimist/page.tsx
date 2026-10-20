import type { Metadata } from "next";
import Link from "next/link";

export const metadata: Metadata = {
  title: "Optimist class hub | SailorPath",
  description:
    "Gateway to Singapore Optimist Gold and Silver standings, selection trials, and the SailorPath Asian and Oceania Optimist Index.",
  alternates: { canonical: "/classes/optimist" },
};

const products = [
  {
    href: "/sg/optimist/gold",
    title: "Singapore Optimist Gold",
    detail: "Best 3 of 5 series standings for the Gold fleet.",
  },
  {
    href: "/sg/optimist/silver",
    title: "Singapore Optimist Silver",
    detail: "Best 3 of 5 series standings for the Silver fleet.",
  },
  {
    href: "/optimist/asian-index",
    title: "Asian and Oceania Optimist Index",
    detail: "V1 (Beta). Open the live index for the current calculation.",
  },
] as const;

const moreLinks = [
  ["/sg/optimist/selection", "Singapore Optimist selection trials"],
  ["/optimist/asian-index/methodology", "Index methodology"],
  ["/how-rankings-work", "How the rankings work"],
  ["/results", "Results"],
  ["/calendar", "Calendar"],
  ["/sailors", "Sailors"],
] as const;

export default function OptimistClassHub() {
  return (
    <main className="mx-auto max-w-6xl space-y-10 px-4 py-10 sm:px-6 sm:py-14">
      <header className="rounded-3xl border border-harbour/15 bg-harbour-shadow px-6 py-8 text-sailcloth shadow-sm sm:px-10 sm:py-12">
        <p className="text-xs font-bold uppercase tracking-[0.16em] text-soft-aqua">
          Class hub
        </p>
        <h1 className="mt-3 text-3xl font-black tracking-tight sm:text-5xl">
          Optimist on SailorPath
        </h1>
        <p className="mt-4 max-w-2xl text-base leading-7 text-soft-aqua sm:text-lg">
          A gateway to Optimist pages that already exist. This page does not
          copy a standings table and it does not calculate a new rank.
        </p>
        <div className="mt-6">
          <Link
            href="/classes"
            className="inline-flex items-center gap-2 rounded-xl border border-soft-aqua/40 px-4 py-2.5 text-sm font-bold text-sailcloth hover:bg-white/10"
          >
            All classes
          </Link>
        </div>
      </header>

      <section className="grid gap-4 md:grid-cols-3" aria-label="Optimist hub status">
        <article className="rounded-2xl border border-cool-veil bg-warm-white p-5">
          <p className="text-xs font-bold uppercase tracking-wider text-harbour">What this page is</p>
          <p className="mt-2 text-lg font-black text-harbour-shadow">A gateway</p>
          <p className="mt-2 text-sm leading-6 text-slate-soft">
            Rankings and results stay on their own pages. This hub only links to them.
          </p>
        </article>
        <article className="rounded-2xl border border-cool-veil bg-warm-white p-5">
          <p className="text-xs font-bold uppercase tracking-wider text-harbour">Singapore series</p>
          <p className="mt-2 text-lg font-black text-harbour-shadow">Gold and Silver</p>
          <p className="mt-2 text-sm leading-6 text-slate-soft">
            Each fleet uses Best 3 of 5. They are separate from the Asian and Oceania Index.
          </p>
        </article>
        <article className="rounded-2xl border border-cool-veil bg-warm-white p-5">
          <p className="text-xs font-bold uppercase tracking-wider text-harbour">Index</p>
          <p className="mt-2 text-lg font-black text-harbour-shadow">V1 (Beta)</p>
          <p className="mt-2 text-sm leading-6 text-slate-soft">
            An independent SailorPath index, not an official IODA or national federation ranking.
          </p>
        </article>
      </section>

      <section className="space-y-4" aria-labelledby="optimist-products-heading">
        <div>
          <p className="text-xs font-bold uppercase tracking-[0.16em] text-harbour">Open a record</p>
          <h2 id="optimist-products-heading" className="mt-2 text-2xl font-black text-harbour-shadow">
            Three Optimist products
          </h2>
        </div>
        <div className="grid gap-4 md:grid-cols-3">
          {products.map((product) => (
            <Link
              key={product.href}
              href={product.href}
              className="rounded-2xl border border-cool-veil bg-warm-white p-5 shadow-xs hover:border-harbour"
            >
              <h3 className="text-lg font-bold text-harbour-shadow">{product.title}</h3>
              <p className="mt-2 text-sm leading-6 text-slate-soft">{product.detail}</p>
            </Link>
          ))}
        </div>
        <aside className="rounded-2xl border border-harbour/20 bg-aqua-mist p-5 sm:p-6">
          <h2 className="text-lg font-black text-harbour-shadow">About the index</h2>
          <p className="mt-2 text-sm leading-6 text-charcoal">
            The SailorPath Asian and Oceania Optimist Index is an independent analytical index.
            It is not an official IODA or national federation ranking. The live index shows who is included
            and when it was last calculated.
          </p>
          <Link
            href="/optimist/asian-index/methodology"
            className="mt-4 inline-flex text-sm font-bold text-harbour hover:underline"
          >
            Read the V1 (Beta) methodology →
          </Link>
        </aside>
      </section>

      <section aria-labelledby="optimist-more-heading">
        <h2 id="optimist-more-heading" className="text-xs font-bold uppercase tracking-[0.16em] text-harbour">
          Also on SailorPath
        </h2>
        <ul className="mt-4 flex flex-wrap gap-3">
          {moreLinks.map(([href, label]) => (
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
