import Link from "next/link";
import type { Metadata } from "next";
import {
  CONSISTENCY_CONSISTENT_MIN,
  CONSISTENCY_MIN_FLEET,
  CONSISTENCY_MIN_RACES,
  CONSISTENCY_MIN_REGATTAS,
  CONSISTENCY_VERY_MIN,
} from "@/lib/consistencyScore";

export const metadata: Metadata = {
  title: "How the rankings work | SailorPath",
  description:
    "Understand SailorPath scoring for Singapore Optimist and ILCA rankings, and how the profile consistency score is calculated.",
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
          Technical notes on Singapore Optimist series scoring, ILCA national
          ranking, and the profile consistency score. For sailors and parents,
          the public boards show the same results — this page is for those who
          want the rules in detail.
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
            <strong className="text-[var(--sp-harbour-shadow)]">Tied places</strong> — sailors
            share a rank only when Best 3 of 5 and every individual event score
            match (name does not split a tie). A better discarded event still
            takes the next place, then the next distinct score skips ahead
            (97, 98, 98, 98, 101).
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
        <h2 className="text-lg font-bold text-[var(--sp-harbour-shadow)]">ILCA national series &amp; rankings (ILCA 4, ILCA 6, ILCA 7)</h2>
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

      <section
        id="consistency"
        className="space-y-3 rounded-2xl border border-[var(--sp-cool-veil)] bg-[var(--sp-warm-white)] p-5 sm:p-6 shadow-xs scroll-mt-24"
      >
        <h2 className="text-lg font-bold text-[var(--sp-harbour-shadow)]">
          Consistency score
        </h2>
        <p className="text-sm text-[var(--sp-charcoal-slate)] leading-relaxed">
          The number on a sailor profile describes how tightly their finishes
          cluster, not how fast they are. A sailor who always finishes near the
          same place in the fleet scores high. A sailor who wins one race and
          is deep in the fleet the next scores lower. Someone who always
          finishes last can still be very consistent.
        </p>
        <ul className="space-y-2 text-sm text-[var(--sp-charcoal-slate)] leading-relaxed list-disc pl-5">
          <li>
            <strong className="text-[var(--sp-harbour-shadow)]">One class, one half</strong> —
            Optimist, ILCA 4, ILCA 6, ILCA 7, and board classes are scored
            separately, for the same half the rankings use (Jan–Jun or Jul–Dec).
            Switching class does not mix the two histories together. Gold and
            Silver stay in the Optimist score; fleet size carries the difference.
          </li>
          <li>
            <strong className="text-[var(--sp-harbour-shadow)]">Scaled by fleet size</strong> —
            each finish becomes a place from 0 (first) to 1 (last): (finish − 1)
            ÷ (fleet size − 1). Fifth of 20 and twentieth of 80 land in the same
            spot. The regatta&apos;s published fleet size is used for every race
            in that event.
          </li>
          <li>
            <strong className="text-[var(--sp-harbour-shadow)]">The number</strong> —
            100 × (1 − 2 × the standard deviation of those places), rounded to a
            whole number. The deviation divides by the number of finishes, so a
            perfect split between first and last scores 0, and identical places
            score 100.
          </li>
          <li>
            <strong className="text-[var(--sp-harbour-shadow)]">Labels</strong> —
            {CONSISTENCY_VERY_MIN} or above is Very consistent,{" "}
            {CONSISTENCY_CONSISTENT_MIN} to {CONSISTENCY_VERY_MIN - 1} is
            Consistent, and below {CONSISTENCY_CONSISTENT_MIN} is Variable.
          </li>
          <li>
            <strong className="text-[var(--sp-harbour-shadow)]">Races first</strong> —
            the score uses race places when there are at least{" "}
            {CONSISTENCY_MIN_RACES}. One regatta is enough if it has that many
            races. With fewer race scores, it uses overall regatta places once
            there are at least {CONSISTENCY_MIN_REGATTAS}. Otherwise the profile
            says &quot;not enough races yet&quot;.
          </li>
          <li>
            <strong className="text-[var(--sp-harbour-shadow)]">Discards count</strong> —
            a discarded race still happened. Leaving it out would hide the swing
            the discard removed from the series score.
          </li>
          <li>
            <strong className="text-[var(--sp-harbour-shadow)]">Letter scores</strong> —
            DNS and DNC are absences, so they are left out. DNF, RET, DSQ, OCS,
            BFD, UFD, NSC, DNE, and TLE count as the back of the fleet, in a
            small fleet or a large one. Redress and percentage penalties (RDG,
            ZFP, SCP, DPI) keep their numeric place. Tied boats share the
            published place, including a half place such as 3.5. Fleets under{" "}
            {CONSISTENCY_MIN_FLEET} boats are left out, because one place is too
            large a share of the fleet to compare.
          </li>
        </ul>
        <p className="text-sm text-[var(--sp-charcoal-slate)] leading-relaxed">
          This is not a ranking and it does not change series points. It is
          calculated from the results already shown on the profile.
        </p>
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
