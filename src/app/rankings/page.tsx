import Link from "next/link";
import { Trophy, Sailboat, Medal, Wind, Waves } from "lucide-react";
import type { Metadata } from "next";

export const metadata: Metadata = {
  title: "Current sailing rankings & race results | SailorPath",
  description:
    "View current Singapore Optimist Gold, Optimist Silver, ILCA 4, WingFoil, and Techno 293 standings.",
};

export const revalidate = 300;

export default function RankingsHubPage() {
  return (
    <div className="mx-auto max-w-3xl px-4 py-12 sm:py-16 space-y-8">
      <div className="text-center space-y-3">
        <h1 className="text-2xl sm:text-3xl font-black text-[var(--sp-harbour-shadow)] tracking-tight">
          Current rankings
        </h1>
        <p className="text-sm text-[var(--sp-slate-soft)] max-w-lg mx-auto leading-relaxed">
          Singapore youth dinghy and windsurfing series — pick a class to view current standings.
        </p>
      </div>

      <div className="grid grid-cols-1 sm:grid-cols-2 gap-4">
        <Link
          href="/sg/optimist/gold"
          className="group rounded-2xl border border-[var(--sp-cool-veil)] bg-[var(--sp-warm-white)] p-5 shadow-xs hover:border-[var(--sp-racing-orange)] hover:shadow-md transition-all"
        >
          <div className="flex h-10 w-10 items-center justify-center rounded-xl bg-[var(--sp-racing-mist)]/30 mb-3">
            <Trophy className="h-5 w-5 text-[var(--sp-racing-orange)]" />
          </div>
          <h2 className="text-base font-bold text-[var(--sp-harbour-shadow)] group-hover:text-[var(--sp-racing-orange)] transition-colors">
            Optimist Gold
          </h2>
          <p className="text-xs text-[var(--sp-slate-soft)] mt-1.5 leading-relaxed">
            Best 3 of 5 series standings for Gold fleet.
          </p>
        </Link>

        <Link
          href="/sg/optimist/silver"
          className="group rounded-2xl border border-[var(--sp-cool-veil)] bg-[var(--sp-warm-white)] p-5 shadow-xs hover:border-[var(--sp-harbour-teal)] hover:shadow-md transition-all"
        >
          <div className="flex h-10 w-10 items-center justify-center rounded-xl bg-[var(--sp-aqua-mist)] mb-3">
            <Medal className="h-5 w-5 text-[var(--sp-harbour-teal)]" />
          </div>
          <h2 className="text-base font-bold text-[var(--sp-harbour-shadow)] group-hover:text-[var(--sp-harbour-teal)] transition-colors">
            Optimist Silver
          </h2>
          <p className="text-xs text-[var(--sp-slate-soft)] mt-1.5 leading-relaxed">
            Best 3 of 5 series standings for Silver fleet.
          </p>
        </Link>

        <Link
          href="/sg/ilca4"
          className="group rounded-2xl border border-[var(--sp-cool-veil)] bg-[var(--sp-warm-white)] p-5 shadow-xs hover:border-[var(--sp-harbour-teal)] hover:shadow-md transition-all"
        >
          <div className="flex h-10 w-10 items-center justify-center rounded-xl bg-[var(--sp-aqua-mist)] mb-3">
            <Sailboat className="h-5 w-5 text-[var(--sp-harbour-teal)]" />
          </div>
          <h2 className="text-base font-bold text-[var(--sp-harbour-shadow)] group-hover:text-[var(--sp-harbour-teal)] transition-colors">
            ILCA 4
          </h2>
          <p className="text-xs text-[var(--sp-slate-soft)] mt-1.5 leading-relaxed">
            High Ranking Points · Best 3 of last 5 ranking regattas.
          </p>
        </Link>

        <Link
          href="/sg/wingfoil"
          className="group rounded-2xl border border-[var(--sp-cool-veil)] bg-[var(--sp-warm-white)] p-5 shadow-xs hover:border-[var(--sp-harbour-teal)] hover:shadow-md transition-all"
        >
          <div className="flex h-10 w-10 items-center justify-center rounded-xl bg-[var(--sp-aqua-mist)] mb-3">
            <Wind className="h-5 w-5 text-[var(--sp-harbour-teal)]" />
          </div>
          <div>
            <h2 className="text-base font-bold text-[var(--sp-harbour-shadow)] group-hover:text-[var(--sp-harbour-teal)] transition-colors">
              WingFoil
            </h2>
          </div>
          <p className="text-xs text-[var(--sp-slate-soft)] mt-1.5 leading-relaxed">
            Event standings, heat finishes &amp; specifications.
          </p>
        </Link>

        <Link
          href="/sg/techno293"
          className="group rounded-2xl border border-[var(--sp-cool-veil)] bg-[var(--sp-warm-white)] p-5 shadow-xs hover:border-[var(--sp-harbour-teal)] hover:shadow-md transition-all sm:col-span-2"
        >
          <div className="flex h-10 w-10 items-center justify-center rounded-xl bg-[var(--sp-aqua-mist)] mb-3">
            <Waves className="h-5 w-5 text-[var(--sp-harbour-teal)]" />
          </div>
          <div>
            <h2 className="text-base font-bold text-[var(--sp-harbour-shadow)] group-hover:text-[var(--sp-harbour-teal)] transition-colors">
              Techno 293
            </h2>
          </div>
          <p className="text-xs text-[var(--sp-slate-soft)] mt-1.5 leading-relaxed">
            Southwest Monsoon Grand Prix series, race results &amp; class specifications.
          </p>
        </Link>
      </div>

      <p className="text-center text-xs text-[var(--sp-slate-soft)]">
        <Link href="/" className="font-medium hover:text-[var(--sp-harbour-shadow)] transition-colors">
          ← Back to home
        </Link>
      </p>
    </div>
  );
}
