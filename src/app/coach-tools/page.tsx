import Link from "next/link";
import { Users, BarChart3, FileText } from "lucide-react";
import type { Metadata } from "next";

export const metadata: Metadata = {
  title: "Coach tools | SailorPath",
  description: "See current SailorPath tools and the roadmap for sailing coaches and squad managers.",
};

/** Pure static content — no request-time data. */
export const revalidate = false;

export default function CoachToolsPage() {
  return (
    <div className="mx-auto max-w-2xl px-4 py-12 sm:py-16 space-y-8">
      <div className="space-y-3 text-center">
        <h1 className="text-2xl sm:text-3xl font-black text-white tracking-tight">
          Coach tools
        </h1>
        <p className="text-sm text-slate-400 leading-relaxed max-w-lg mx-auto">
          Squad management, athlete comparison, and selection reports are on the
          roadmap for <strong className="text-slate-300">Q4 2026</strong>.
          Today you can already use public rankings and claimed athlete
          profiles.
        </p>
      </div>

      <div className="grid gap-3">
        <div className="rounded-2xl border border-white/10 bg-white/[0.03] p-4 flex gap-3">
          <Users className="h-5 w-5 text-orange-400 shrink-0 mt-0.5" />
          <div>
            <p className="text-sm font-bold text-white">Coming: Coach squads</p>
            <p className="text-xs text-slate-500 mt-1 leading-relaxed">
              Manage multiple sailors from one account with role-based access.
            </p>
          </div>
        </div>
        <div className="rounded-2xl border border-white/10 bg-white/[0.03] p-4 flex gap-3">
          <BarChart3 className="h-5 w-5 text-sky-400 shrink-0 mt-0.5" />
          <div>
            <p className="text-sm font-bold text-white">Available now</p>
            <p className="text-xs text-slate-500 mt-1 leading-relaxed">
              Current Optimist Gold/Silver and ILCA 4 standings, plus public profiles
              for progression checks.
            </p>
          </div>
        </div>
        <div className="rounded-2xl border border-white/10 bg-white/[0.03] p-4 flex gap-3">
          <FileText className="h-5 w-5 text-amber-300 shrink-0 mt-0.5" />
          <div>
            <p className="text-sm font-bold text-white">Selection shortlists</p>
            <p className="text-xs text-slate-500 mt-1 leading-relaxed">
              Admin previews for Nat A/B and campaign events are used internally
              today; coach-facing exports are planned.
            </p>
          </div>
        </div>
      </div>

      <div className="flex flex-col sm:flex-row gap-2 justify-center">
        <Link
          href="/rankings"
          className="rounded-full bg-orange-600 hover:bg-orange-500 px-5 py-2.5 text-center text-xs font-bold text-white"
        >
          View current rankings
        </Link>
        <Link
          href="/#roadmap"
          className="rounded-full border border-white/15 bg-white/5 px-5 py-2.5 text-center text-xs font-bold text-white hover:border-orange-500/40"
        >
          Join the waitlist
        </Link>
      </div>

      <p className="text-center text-[12px] text-slate-600">
        <Link href="/" className="text-slate-500 hover:text-white">
          ← Home
        </Link>
      </p>
    </div>
  );
}
