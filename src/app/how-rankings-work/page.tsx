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
          className="text-xs font-semibold text-[var(--sp-slate-soft)] hover:text-[var(--sp-harbour-shadow)] transition-colors"
        >
          ← Home
        </Link>
        <h1 className="text-2xl sm:text-3xl font-black text-[var(--sp-harbour-shadow)] tracking-tight">
          How rankings work
        </h1>
        <p className="text-sm text-[var(--sp-charcoal-slate)] leading-relaxed">
          Technical notes on Singapore Optimist series scoring and ILCA 4
          national ranking used in SailorPath. For sailors and parents, the
          public boards show the same results — this page is for those who want
          the rules in detail.
        </p>
      </div>

      <section className="space-y-3 rounded-2xl border border-[var(--sp-cool-veil)] bg-[var(--sp-warm-white)] p-5 sm:p-6 shadow-xs">
        <h2 className="text-lg font-bold text-[var(--sp-harbour-shadow)]">
          Optimist Gold / Silver series
        </h2>
        <ul className="space-y-2 text-sm text-[var(--sp-charcoal-slate)] leading-relaxed list-disc pl-5">
          <li>
            <strong className="text-[var(--sp-harbour-shadow)]">Best 3 of 5</strong> — series
            score is the sum of the best three place scores from the last five
            ranking regattas in the half (lower is better).
          </li>
          <li>
            <strong className="text-[var(--sp-harbour-shadow)]">DNS padding</strong> — missing
            ranking events for active series sailors are scored as fleet size +
            1 so the board stays comparable.
          </li>
          <li>
            <strong className="text-[var(--sp-harbour-shadow)]">Overseas commitment</strong> —
            SSF-supported absences can use a standing-based score instead of a
            full DNS.
          </li>
          <li>
            <strong className="text-[var(--sp-harbour-shadow)]">SGP auto-include</strong> —
            Singapore nationals with Optimist ranking results join the series
            unless marked Guest.
          </li>
          <li>
            <strong className="text-[var(--sp-harbour-shadow)]">Gold entry &amp; drop</strong> —
            half-year boundaries only (1 Jan / 1 Jul). Participation rule:
            sailors who do not complete enough ranking Gold events in a finished
            half may be flagged for auto-drop.
          </li>
          <li>
            <strong className="text-[var(--sp-harbour-shadow)]">Nat A/B previews</strong> — admin
            tools estimate national squad shortlists from Gold standings and age
            buckets for selection planning.
          </li>
        </ul>
        <p className="text-xs pt-2">
          <Link
            href="/sg/optimist/gold"
            className="text-[var(--sp-racing-orange)] font-semibold hover:underline"
          >
            View Gold standings →
          </Link>
        </p>
      </section>

      <section className="space-y-3 rounded-2xl border border-[var(--sp-cool-veil)] bg-[var(--sp-warm-white)] p-5 sm:p-6 shadow-xs">
        <h2 className="text-lg font-bold text-[var(--sp-harbour-shadow)]">ILCA 4 national ranking</h2>
        <ul className="space-y-2 text-sm text-[var(--sp-charcoal-slate)] leading-relaxed list-disc pl-5">
          <li>
            <strong className="text-[var(--sp-harbour-shadow)]">High Ranking Points</strong> —
            1st earns fleet size points, 2nd earns N−1, and so on.
          </li>
          <li>
            <strong className="text-[var(--sp-harbour-shadow)]">Best 3 of last 5</strong> ranking
            regattas (higher points better). Events with fewer than 3 completed
            races are non-ranking for series.
          </li>
          <li>
            <strong className="text-[var(--sp-harbour-shadow)]">National list</strong> — ILCA 4 and ILCA 6
            display sailors verified on the official national list rosters. ILCA 7 standings
            are computed from open regatta performance.
          </li>
          <li>
            <strong className="text-[var(--sp-harbour-shadow)]">Dual sail numbers</strong> —
            Optimist and ILCA 4 numbers can live on one profile for under-15
            dual-class sailors.
          </li>
        </ul>
        <div className="flex flex-wrap gap-4 text-xs pt-2">
          <Link
            href="/sg/ilca4"
            className="text-[var(--sp-harbour-teal)] font-semibold hover:underline"
          >
            ILCA 4 standings →
          </Link>
          <Link
            href="/sg/ilca6"
            className="text-[var(--sp-harbour-teal)] font-semibold hover:underline"
          >
            ILCA 6 standings →
          </Link>
          <Link
            href="/sg/ilca7"
            className="text-[var(--sp-harbour-teal)] font-semibold hover:underline"
          >
            ILCA 7 standings →
          </Link>
        </div>
      </section>

      <p className="text-center text-xs text-[var(--sp-slate-soft)]">
        <Link href="/rankings" className="font-medium hover:text-[var(--sp-harbour-shadow)] transition-colors">
          Current rankings
        </Link>
        {" · "}
        <Link href="/support" className="font-medium hover:text-[var(--sp-harbour-shadow)] transition-colors">
          Questions? Contact us
        </Link>
      </p>
    </div>
  );
}
