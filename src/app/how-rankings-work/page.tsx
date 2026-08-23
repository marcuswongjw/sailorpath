import Link from "next/link";
import type { Metadata } from "next";

export const metadata: Metadata = {
  title: "How the rankings work | SailorPath",
  description: "Understand SailorPath scoring for Singapore Optimist and ILCA 4 ranking series.",
};

/** Pure static content — no request-time data. */
export const revalidate = false;

export default function HowRankingsWorkPage() {
  return (
    <div className="mx-auto max-w-3xl px-4 py-12 sm:py-16 space-y-10">
      <div className="space-y-3">
        <Link
          href="/"
          className="text-[12px] font-semibold text-slate-500 hover:text-white"
        >
          ← Home
        </Link>
        <h1 className="text-2xl sm:text-3xl font-black text-white tracking-tight">
          How rankings work
        </h1>
        <p className="text-sm text-slate-400 leading-relaxed">
          Technical notes on Singapore Optimist series scoring and ILCA 4
          national ranking used in SailorPath. For sailors and parents, the
          public boards show the same results — this page is for those who want
          the rules in detail.
        </p>
      </div>

      <section className="space-y-3 rounded-2xl border border-orange-500/20 bg-orange-500/5 p-5 sm:p-6">
        <h2 className="text-lg font-bold text-white">
          Optimist Gold / Silver series
        </h2>
        <ul className="space-y-2 text-sm text-slate-400 leading-relaxed list-disc pl-5">
          <li>
            <strong className="text-slate-200">Best 3 of 5</strong> — series
            score is the sum of the best three place scores from the last five
            ranking regattas in the half (lower is better).
          </li>
          <li>
            <strong className="text-slate-200">DNS padding</strong> — missing
            ranking events for active series sailors are scored as fleet size +
            1 so the board stays comparable.
          </li>
          <li>
            <strong className="text-slate-200">Overseas commitment</strong> —
            SSF-supported absences can use a standing-based score instead of a
            full DNS.
          </li>
          <li>
            <strong className="text-slate-200">SGP auto-include</strong> —
            Singapore nationals with Optimist ranking results join the series
            unless marked Guest.
          </li>
          <li>
            <strong className="text-slate-200">Gold entry &amp; drop</strong> —
            half-year boundaries only (1 Jan / 1 Jul). Participation rule:
            sailors who do not complete enough ranking Gold events in a finished
            half may be flagged for auto-drop.
          </li>
          <li>
            <strong className="text-slate-200">Nat A/B previews</strong> — admin
            tools estimate national squad shortlists from Gold standings and age
            buckets for selection planning.
          </li>
        </ul>
        <p className="text-xs pt-1">
          <Link
            href="/sg/optimist/gold"
            className="text-orange-400 font-semibold hover:text-orange-300"
          >
            View Gold standings →
          </Link>
        </p>
      </section>

      <section className="space-y-3 rounded-2xl border border-sky-500/20 bg-sky-500/5 p-5 sm:p-6">
        <h2 className="text-lg font-bold text-white">ILCA 4 national ranking</h2>
        <ul className="space-y-2 text-sm text-slate-400 leading-relaxed list-disc pl-5">
          <li>
            <strong className="text-slate-200">High Ranking Points</strong> —
            1st earns fleet size points, 2nd earns N−1, and so on.
          </li>
          <li>
            <strong className="text-slate-200">Best 3 of last 5</strong> ranking
            regattas (higher points better). Events with fewer than 3 completed
            races are non-ranking for series.
          </li>
          <li>
            <strong className="text-slate-200">National list</strong> — squad
            selection draws from the official ILCA 4 national list roster.
          </li>
          <li>
            <strong className="text-slate-200">Dual sail numbers</strong> —
            Optimist and ILCA 4 numbers can live on one profile for under-15
            dual-class sailors.
          </li>
        </ul>
        <p className="text-xs pt-1">
          <Link
            href="/sg/ilca4"
            className="text-sky-400 font-semibold hover:text-sky-300"
          >
            View ILCA 4 standings →
          </Link>
        </p>
      </section>

      <p className="text-center text-[12px] text-slate-600">
        <Link href="/rankings" className="text-slate-500 hover:text-white">
          Current rankings
        </Link>
        {" · "}
        <Link href="/support" className="text-slate-500 hover:text-white">
          Questions? Contact us
        </Link>
      </p>
    </div>
  );
}
