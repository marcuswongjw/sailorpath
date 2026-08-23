import Link from "next/link";
import {
  Search,
  Trophy,
  Anchor,
  Medal,
  BookOpen,
  Users,
  UserRound,
} from "lucide-react";
import { WaitlistForm } from "@/components/WaitlistForm";
import type { Metadata } from "next";

export const metadata: Metadata = {
  title: "Singapore sailing rankings and sailor records | SailorPath",
  description:
    "Follow current Optimist and ILCA 4 standings, explore regatta results, and keep one sailing record across classes.",
};

/**
 * Static marketing homepage — no DB round-trip so logo → home is instant
 * (demo profile stays the fast path for product tour).
 *
 * Conversion spine: Hero → How it works → Demo → audiences →
 * rankings explainers → roadmap.
 */
export const revalidate = 300;

export default function HomePage() {
  return (
    <div className="relative min-h-screen bg-[#090a0f] flex flex-col justify-between overflow-x-hidden">
      <div className="absolute top-0 left-0 right-0 h-[420px] sm:left-1/4 sm:right-auto sm:w-[500px] sm:h-[500px] bg-orange-600/10 rounded-full blur-[100px] pointer-events-none -z-10" />
      <div className="absolute top-40 right-0 w-[320px] h-[320px] bg-sky-600/10 rounded-full blur-[100px] pointer-events-none -z-10 hidden sm:block" />

      {/* Hero */}
      <section className="w-full max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 pt-8 pb-8 sm:pt-16 sm:pb-12 text-center lg:pt-24">
        <h1 className="mx-auto max-w-4xl text-[1.65rem] leading-snug sm:text-5xl lg:text-6xl font-black tracking-tight text-white sm:leading-tight">
          {"See the standings. Keep the whole "}
          <span className="bg-gradient-to-r from-orange-500 via-orange-600 to-sky-500 bg-clip-text text-transparent">
            sailing journey.
          </span>
        </h1>

        <p className="mx-auto mt-4 sm:mt-6 max-w-xl sm:max-w-2xl text-[13px] sm:text-base md:text-lg text-slate-400 font-medium sm:font-semibold leading-relaxed">
          Follow current Optimist and ILCA 4 rankings, explore regatta results,
          and keep one personal sailing record as you move between classes.
        </p>

        <div className="mt-6 sm:mt-8 flex flex-col items-center gap-3 w-full max-w-md mx-auto sm:max-w-none">
          <Link
            href="/rankings"
            className="w-full sm:w-auto rounded-full bg-orange-600 hover:bg-orange-500 active:scale-[0.98] transition-all text-xs font-black uppercase tracking-wider text-white px-6 py-3.5 shadow-lg shadow-orange-950/20 border border-orange-500/30 inline-flex items-center justify-center gap-2 min-h-[44px]"
          >
            <Trophy className="h-4 w-4 shrink-0" />
            View current rankings
          </Link>
          <p className="text-[12px] sm:text-[13px] text-slate-400">
            Sailor or parent?{" "}
            <Link
              href="/search"
              className="font-bold text-orange-400 hover:text-orange-300 underline-offset-2 hover:underline"
            >
              Find and claim a profile
            </Link>
          </p>
        </div>

        <p className="mx-auto mt-4 max-w-2xl text-[11px] sm:text-[12px] text-slate-500 leading-relaxed">
          Rankings calculated from published regatta results using the
          applicable Singapore series rules.
        </p>

        <div className="mx-auto mt-6 sm:mt-10 max-w-md w-full">
          <form action="/search" className="relative">
            <input
              type="search"
              name="query"
              enterKeyHint="search"
              placeholder="Search name or sail #"
              className="w-full rounded-2xl sm:rounded-full border border-white/10 bg-white/5 px-4 py-3 pr-12 text-white placeholder-slate-500 focus:border-orange-500 focus:outline-none focus:ring-2 focus:ring-orange-500/20 text-sm min-h-[48px]"
            />
            <button
              type="submit"
              className="absolute right-1.5 top-1/2 -translate-y-1/2 rounded-xl sm:rounded-full bg-orange-600 p-2.5 text-white min-h-[40px] min-w-[40px] inline-flex items-center justify-center"
              aria-label="Search"
            >
              <Search className="h-5 w-5" />
            </button>
          </form>

          <div className="mt-3 flex flex-wrap justify-center gap-1.5 sm:gap-2 text-[11px] sm:text-xs">
            <Link
              href="/sample"
              className="px-2.5 py-1.5 rounded-lg bg-amber-500/10 border border-amber-500/20 text-amber-100 hover:border-amber-400/40"
            >
              Open demo profile
            </Link>
            <Link
              href="/sg/optimist/gold"
              className="px-2.5 py-1.5 rounded-lg bg-white/5 border border-white/5 text-slate-300 hover:border-orange-500 hover:text-white"
            >
              Gold standings
            </Link>
          </div>
        </div>
      </section>

      {/* How it works */}
      <section className="border-t border-white/5 bg-[#090a0f] py-12 sm:py-14">
        <div className="mx-auto max-w-7xl px-4 sm:px-6 lg:px-8">
          <h2 className="text-center text-2xl sm:text-3xl font-extrabold text-white tracking-tight mb-8 sm:mb-10">
            How SailorPath works
          </h2>
          <div className="grid grid-cols-1 md:grid-cols-3 gap-6 sm:gap-8 max-w-5xl mx-auto">
            {(
              [
                {
                  step: "1",
                  title: "Results are added",
                  body: "Published regatta results are imported and reviewed before standings are updated.",
                },
                {
                  step: "2",
                  title: "Your sailing record grows",
                  body: "Results, ranking points, and fleet positions build a record across regattas and classes.",
                },
                {
                  step: "3",
                  title: "You take ownership",
                  body: "Claim your profile to add private notes, equipment, milestones, and sharing preferences.",
                },
              ] as const
            ).map((item) => (
              <div
                key={item.step}
                className="relative rounded-2xl border border-white/10 bg-white/[0.03] p-5 sm:p-6 text-center md:text-left"
              >
                <span className="inline-flex h-9 w-9 items-center justify-center rounded-full bg-orange-500/15 text-orange-400 text-sm font-black border border-orange-500/25 mb-3">
                  {item.step}
                </span>
                <h3 className="text-base sm:text-lg font-bold text-white">
                  {item.title}
                </h3>
                <p className="mt-2 text-xs sm:text-sm text-slate-400 leading-relaxed">
                  {item.body}
                </p>
              </div>
            ))}
          </div>
        </div>
      </section>

      {/* Live demo profile */}
      <section className="border-t border-white/5 bg-[#090a0f] py-12 sm:py-14">
        <div className="mx-auto max-w-7xl px-4 sm:px-6 lg:px-8">
          <div className="mx-auto max-w-2xl text-center rounded-2xl border border-orange-500/20 bg-gradient-to-b from-orange-500/[0.08] to-transparent px-6 py-10 sm:py-12">
            <h2 className="text-2xl sm:text-3xl font-extrabold text-white tracking-tight">
              See what your profile looks like
            </h2>
            <p className="mt-3 text-sm text-slate-400 leading-relaxed max-w-md mx-auto">
              Explore a dual-class sample with Optimist Gold standings, ILCA 4
              results, and previews for sailors, parents, and coaches.
            </p>
            <Link
              href="/sample"
              className="mt-6 inline-flex items-center justify-center rounded-full bg-orange-600 hover:bg-orange-500 px-6 py-3 text-sm font-bold text-white shadow-lg shadow-orange-950/20 border border-orange-500/30 min-h-[44px]"
            >
              Open demo profile →
            </Link>
          </div>
        </div>
      </section>

      {/* Audience features */}
      <section className="border-t border-white/5 bg-[#0b0c13] py-12 sm:py-14">
        <div className="mx-auto max-w-7xl px-4 sm:px-6 lg:px-8">
          <div className="grid grid-cols-1 md:grid-cols-3 gap-4 sm:gap-5">
            <article className="glass-card rounded-2xl p-5 sm:p-6 border border-orange-500/25 flex flex-col">
              <div className="flex h-10 w-10 items-center justify-center rounded-xl bg-orange-500/15 mb-3">
                <UserRound className="h-5 w-5 text-orange-400" />
              </div>
              <h2 className="text-lg font-bold text-white">For sailors</h2>
              <p className="text-sm font-semibold text-white mt-1.5">
                Own your sailing journey.
              </p>
              <p className="text-xs sm:text-sm text-slate-400 mt-2 leading-relaxed flex-1">
                Follow regatta results, ranking movement, and personal progress
                from Optimist to ILCA. Add milestones, equipment notes, and race
                reflections — share what you want and keep the rest private.
              </p>
              <Link
                href="/search"
                className="mt-4 text-[12px] font-bold text-orange-400 hover:text-orange-300"
              >
                Find and claim your profile →
              </Link>
            </article>

            <article className="glass-card rounded-2xl p-5 sm:p-6 border border-white/10 flex flex-col">
              <div className="flex h-10 w-10 items-center justify-center rounded-xl bg-white/10 mb-3">
                <Users className="h-5 w-5 text-slate-200" />
              </div>
              <h2 className="text-lg font-bold text-white">For parents</h2>
              <p className="text-sm font-semibold text-white mt-1.5">
                Keep their sailing progress in one place.
              </p>
              <p className="text-xs sm:text-sm text-slate-400 mt-2 leading-relaxed flex-1">
                Link your account to your child&apos;s profile and open the{" "}
                <strong className="text-slate-300">Parent Dashboard</strong>{" "}
                today — rankings, results, and milestones in one private place.
                More family tools are on the roadmap.
              </p>
              <Link
                href="/search"
                className="mt-4 text-[12px] font-bold text-slate-300 hover:text-white"
              >
                Link to your child&apos;s profile →
              </Link>
            </article>

            <article className="glass-card rounded-2xl p-5 sm:p-6 border border-sky-500/25 flex flex-col">
              <div className="flex h-10 w-10 items-center justify-center rounded-xl bg-sky-500/15 mb-3">
                <Trophy className="h-5 w-5 text-sky-400" />
              </div>
              <h2 className="text-lg font-bold text-white">For coaches</h2>
              <p className="text-sm font-semibold text-white mt-1.5">
                See every sailor in context.
              </p>
              <p className="text-xs sm:text-sm text-slate-400 mt-2 leading-relaxed flex-1">
                Use current public standings and sailor profiles today. Squad
                comparisons, selection reports, and management tools are planned
                — join the waitlist for updates.
              </p>
              <a
                href="#roadmap-coach"
                className="mt-4 text-[12px] font-bold text-sky-400 hover:text-sky-300"
              >
                Join coach waitlist →
              </a>
            </article>
          </div>
        </div>
      </section>

      {/* Ranking features */}
      <section className="border-t border-white/5 bg-[#090a0f] py-12 sm:py-14">
        <div className="mx-auto max-w-7xl px-4 sm:px-6 lg:px-8">
          <div className="text-center max-w-2xl mx-auto mb-8 sm:mb-12">
            <h2 className="text-2xl sm:text-3xl font-extrabold text-white tracking-tight">
              Rankings &amp; logbook
            </h2>
          </div>

          <div className="grid grid-cols-1 md:grid-cols-3 gap-4 sm:gap-5">
            <article className="glass-card rounded-2xl p-5 sm:p-6 border border-orange-500/25 flex flex-col">
              <div className="flex h-10 w-10 items-center justify-center rounded-xl bg-orange-500/15 mb-3">
                <Medal className="h-5 w-5 text-orange-400" />
              </div>
              <h3 className="text-lg font-bold text-white">
                Optimist Gold/Silver Series Rankings
              </h3>
              <p className="text-sm font-semibold text-orange-200/90 mt-1.5">
                Know exactly where you stand after every regatta.
              </p>
              <p className="text-xs sm:text-sm text-slate-400 mt-2 leading-relaxed flex-1">
                Calculated from published results using the applicable series
                rules. Best 3 of 5 results, with handling for DNS, overseas
                commitments, and fleet movements.
              </p>
              <ul className="mt-4 space-y-1.5 text-[11px] text-slate-400 border-t border-white/5 pt-3">
                <li>SGP sailors auto-included when they race</li>
                <li>Gold fleet entry and drop on 1 Jan / 1 Jul</li>
                <li>Smart data checks for accuracy</li>
              </ul>
            </article>

            <article className="glass-card rounded-2xl p-5 sm:p-6 border border-sky-500/25 flex flex-col">
              <div className="flex h-10 w-10 items-center justify-center rounded-xl bg-sky-500/15 mb-3">
                <Anchor className="h-5 w-5 text-sky-400" />
              </div>
              <h3 className="text-lg font-bold text-white">
                ILCA 4 National Ranking
              </h3>
              <p className="text-sm font-semibold text-sky-200/90 mt-1.5">
                Track your transition from Optimist with clarity.
              </p>
              <p className="text-xs sm:text-sm text-slate-400 mt-2 leading-relaxed flex-1">
                Track your position as you transition from Optimist. High Ranking
                Points system with position trend charts and journey timelines.
              </p>
              <ul className="mt-4 space-y-1.5 text-[11px] text-slate-400 border-t border-white/5 pt-3">
                <li>Dual Optimist + ILCA sail numbers on one profile</li>
                <li>Best 3 of last 5 results</li>
                <li>Visual timeline showing your class transition</li>
              </ul>
            </article>

            <article className="glass-card rounded-2xl p-5 sm:p-6 border border-white/10 flex flex-col">
              <div className="flex h-10 w-10 items-center justify-center rounded-xl bg-white/10 mb-3">
                <BookOpen className="h-5 w-5 text-amber-300" />
              </div>
              <h3 className="text-lg font-bold text-white">Athlete Logbook</h3>
              <p className="text-sm font-semibold text-amber-100/90 mt-1.5">
                Keep your sailing history together and under your control.
              </p>
              <p className="text-xs sm:text-sm text-slate-400 mt-2 leading-relaxed flex-1">
                Add notes, equipment, and milestones with sharing controls — from
                your first Optimist race through ILCA.
              </p>
              <ul className="mt-4 space-y-1.5 text-[11px] text-slate-400 border-t border-white/5 pt-3">
                <li>Dual-class tabs: Optimist and ILCA results together</li>
                <li>Medal tally and key stats</li>
                <li>Privacy controls for sensitive data</li>
              </ul>
            </article>
          </div>

          <p className="mt-8 text-center">
            <Link
              href="/how-rankings-work"
              className="text-[13px] font-semibold text-orange-400 hover:text-orange-300"
            >
              Read our full ranking methodology →
            </Link>
          </p>
        </div>
      </section>

      {/* Roadmap */}
      <section
        id="roadmap"
        className="border-t border-white/5 bg-[#0b0c13] py-12 sm:py-14"
      >
        <div className="mx-auto max-w-7xl px-4 sm:px-6 lg:px-8">
          <div className="text-center max-w-2xl mx-auto mb-10">
            <h2 className="text-2xl sm:text-3xl font-extrabold text-white tracking-tight">
              Roadmap
            </h2>
            <p className="mt-3 text-slate-400 text-sm leading-relaxed">
              Rankings, claimed profiles, and the{" "}
              <Link
                href="/parent"
                className="text-emerald-300 font-semibold hover:text-emerald-200"
              >
                Parent Dashboard
              </Link>{" "}
              are available today. Coach squads and club tools are next.
            </p>
          </div>

          <ol className="mx-auto max-w-2xl space-y-0 relative">
            <li id="roadmap-parent" className="relative flex gap-4 pb-10">
              <span
                className="absolute left-[11px] top-7 bottom-0 w-px bg-white/10"
                aria-hidden
              />
              <span className="relative z-10 mt-1 h-6 w-6 shrink-0 rounded-full border border-emerald-500/40 bg-emerald-500/15" />
              <div className="min-w-0 flex-1">
                <p className="text-[11px] font-black uppercase tracking-widest text-emerald-400">
                  Available now
                </p>
                <h3 className="text-base font-bold text-white mt-1">
                  Parent Dashboard
                </h3>
                <p className="text-xs sm:text-sm text-slate-400 mt-1.5 leading-relaxed">
                  Already shipping: link a child, then open{" "}
                  <Link
                    href="/parent"
                    className="text-emerald-300 font-semibold hover:text-emerald-200"
                  >
                    /parent
                  </Link>{" "}
                  for rankings, results, and private notes. Coming later:
                  multi-child alerts and calendars.
                </p>
                <div className="mt-3 flex flex-wrap gap-3 items-center">
                  <Link
                    href="/parent"
                    className="inline-block text-[12px] font-bold text-emerald-400 hover:text-emerald-300"
                  >
                    Open Parent Dashboard →
                  </Link>
                  <Link
                    href="/claim-profile"
                    className="inline-block text-[12px] font-semibold text-slate-400 hover:text-white"
                  >
                    Link a child first
                  </Link>
                </div>
                <p className="mt-4 text-[11px] font-bold uppercase tracking-wider text-slate-500">
                  Waitlist for next family features
                </p>
                <WaitlistForm
                  presetRole="Parent"
                  submitLabel="Join parent waitlist"
                  compact
                />
              </div>
            </li>
            <li id="roadmap-coach" className="relative flex gap-4 pb-10">
              <span
                className="absolute left-[11px] top-7 bottom-0 w-px bg-white/10"
                aria-hidden
              />
              <span className="relative z-10 mt-1 h-6 w-6 shrink-0 rounded-full border border-sky-500/40 bg-sky-500/15" />
              <div className="min-w-0 flex-1">
                <p className="text-[11px] font-black uppercase tracking-widest text-sky-400">
                  Q4 2026
                </p>
                <h3 className="text-base font-bold text-white mt-1">
                  Coach Squads
                </h3>
                <p className="text-xs sm:text-sm text-slate-400 mt-1.5 leading-relaxed">
                  Manage multiple sailors from one account. Compare athletes,
                  track trends, and prepare selection reports.
                </p>
                <p className="mt-3 text-[12px] font-bold text-sky-400">
                  Join the coach waitlist →
                </p>
                <WaitlistForm
                  presetRole="Coach"
                  submitLabel="Join coach waitlist"
                  compact
                />
              </div>
            </li>
            <li className="relative flex gap-4 pb-0">
              <span className="relative z-10 mt-1 h-6 w-6 shrink-0 rounded-full border border-white/20 bg-white/5" />
              <div className="min-w-0 flex-1">
                <p className="text-[11px] font-black uppercase tracking-widest text-slate-500">
                  2027
                </p>
                <h3 className="text-base font-bold text-white mt-1">
                  Club &amp; Event Tools
                </h3>
                <p className="text-xs sm:text-sm text-slate-400 mt-1.5 leading-relaxed">
                  Start-list sync, campaign planning, and automated alerts for
                  rank changes and selection windows.
                </p>
              </div>
            </li>
          </ol>
        </div>
      </section>

    </div>
  );
}
