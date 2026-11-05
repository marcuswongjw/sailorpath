import Link from "next/link";
import { Trophy, Sailboat, Medal, Globe } from "lucide-react";
import type { Metadata } from "next";

export const metadata: Metadata = {
  title: "Current sailing rankings & race results | SailorPath",
  description:
    "View Singapore Optimist Gold and Silver, ILCA 4 and ILCA 6 rankings, and the Asian & Oceania Optimist Index.",
};

export const revalidate = 3600;

export default function RankingsHubPage() {
  return (
    <div className="mx-auto max-w-3xl px-4 py-12 sm:py-16 space-y-10">
      <div className="text-center space-y-3">
        <h1 className="text-2xl sm:text-3xl font-black text-[var(--sp-harbour-shadow)] tracking-tight">
          Current rankings
        </h1>
        <p className="text-sm text-[var(--sp-slate-soft)] max-w-lg mx-auto leading-relaxed">
          Explore Singapore Optimist and ILCA rankings and the regional Asian &amp; Oceania Optimist Index.
        </p>
      </div>

      {/* Optimist Series */}
      <div className="space-y-3">
        <div className="flex items-center gap-2 border-b border-[var(--sp-cool-veil)] pb-2">
          <Trophy className="h-4 w-4 text-[var(--sp-racing-orange)]" />
          <h2 className="text-xs font-bold uppercase tracking-wider text-[var(--sp-slate-soft)]">
            Optimist
          </h2>
          <Link
            href="/classes/optimist"
            className="ml-auto text-xs font-semibold text-[var(--sp-harbour-teal)] hover:underline"
          >
            Class hub
          </Link>
        </div>
        <div className="grid grid-cols-1 sm:grid-cols-3 gap-4">
          <Link
            href="/sg/optimist/gold"
            className="group rounded-2xl border border-[var(--sp-cool-veil)] bg-[var(--sp-warm-white)] p-5 shadow-xs hover:border-[var(--sp-racing-orange)] hover:shadow-md transition-all"
          >
            <div className="flex h-10 w-10 items-center justify-center rounded-xl bg-[var(--sp-racing-mist)]/30 mb-3">
              <Trophy className="h-5 w-5 text-[var(--sp-racing-orange)]" />
            </div>
            <h3 className="text-base font-bold text-[var(--sp-harbour-shadow)] group-hover:text-[var(--sp-racing-orange)] transition-colors">
              Optimist Gold
            </h3>
            <p className="text-xs text-[var(--sp-slate-soft)] mt-1.5 leading-relaxed">
              Singapore Optimist Gold Fleet ranking
            </p>
          </Link>

          <Link
            href="/sg/optimist/silver"
            className="group rounded-2xl border border-[var(--sp-cool-veil)] bg-[var(--sp-warm-white)] p-5 shadow-xs hover:border-[var(--sp-harbour-teal)] hover:shadow-md transition-all"
          >
            <div className="flex h-10 w-10 items-center justify-center rounded-xl bg-[var(--sp-aqua-mist)] mb-3">
              <Medal className="h-5 w-5 text-[var(--sp-harbour-teal)]" />
            </div>
            <h3 className="text-base font-bold text-[var(--sp-harbour-shadow)] group-hover:text-[var(--sp-harbour-teal)] transition-colors">
              Optimist Silver
            </h3>
            <p className="text-xs text-[var(--sp-slate-soft)] mt-1.5 leading-relaxed">
              Singapore Optimist Silver Fleet ranking
            </p>
          </Link>

          <Link
            href="/optimist/asian-index"
            className="group rounded-2xl border border-[var(--sp-cool-veil)] bg-[var(--sp-warm-white)] p-5 shadow-xs hover:border-[var(--sp-harbour-teal)] hover:shadow-md transition-all"
          >
            <div className="flex h-10 w-10 items-center justify-center rounded-xl bg-[var(--sp-aqua-mist)] mb-3">
              <Globe className="h-5 w-5 text-[var(--sp-harbour-teal)]" />
            </div>
            <h3 className="text-base font-bold text-[var(--sp-harbour-shadow)] group-hover:text-[var(--sp-harbour-teal)] transition-colors">
              Asian &amp; Oceania Index
            </h3>
            <p className="text-xs text-[var(--sp-slate-soft)] mt-1.5 leading-relaxed">
              Rolling 12-month regional Optimist benchmark (Beta).
            </p>
          </Link>
        </div>
      </div>

      {/* ILCA Series */}
      <div className="space-y-3">
        <div className="flex items-center gap-2 border-b border-[var(--sp-cool-veil)] pb-2">
          <Sailboat className="h-4 w-4 text-[var(--sp-harbour-teal)]" />
          <h2 className="text-xs font-bold uppercase tracking-wider text-[var(--sp-slate-soft)]">
            ILCA
          </h2>
        </div>
        <div className="grid grid-cols-1 sm:grid-cols-2 gap-4">
          <Link
            href="/sg/ilca4"
            className="group rounded-2xl border border-[var(--sp-cool-veil)] bg-[var(--sp-warm-white)] p-5 shadow-xs hover:border-[var(--sp-harbour-teal)] hover:shadow-md transition-all"
          >
            <div className="flex h-10 w-10 items-center justify-center rounded-xl bg-[var(--sp-aqua-mist)] mb-3">
              <Sailboat className="h-5 w-5 text-[var(--sp-harbour-teal)]" />
            </div>
            <h3 className="text-base font-bold text-[var(--sp-harbour-shadow)] group-hover:text-[var(--sp-harbour-teal)] transition-colors">
              ILCA 4
            </h3>
            <p className="text-xs text-[var(--sp-slate-soft)] mt-1.5 leading-relaxed">
              Singapore ILCA 4 national ranking
            </p>
          </Link>

          <Link
            href="/sg/ilca6"
            className="group rounded-2xl border border-[var(--sp-cool-veil)] bg-[var(--sp-warm-white)] p-5 shadow-xs hover:border-[var(--sp-harbour-teal)] hover:shadow-md transition-all"
          >
            <div className="flex h-10 w-10 items-center justify-center rounded-xl bg-[var(--sp-aqua-mist)] mb-3">
              <Sailboat className="h-5 w-5 text-[var(--sp-harbour-teal)]" />
            </div>
            <h3 className="text-base font-bold text-[var(--sp-harbour-shadow)] group-hover:text-[var(--sp-harbour-teal)] transition-colors">
              ILCA 6
            </h3>
            <p className="text-xs text-[var(--sp-slate-soft)] mt-1.5 leading-relaxed">
              Singapore ILCA 6 national ranking
            </p>
          </Link>

        </div>
      </div>

      <p className="text-center text-xs text-[var(--sp-slate-soft)] pt-4">
        <Link href="/" className="font-medium hover:text-[var(--sp-harbour-shadow)] transition-colors">
          ← Back to home
        </Link>
      </p>
    </div>
  );
}
