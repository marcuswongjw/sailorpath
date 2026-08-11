import Link from "next/link";
import {
  Search,
  Trophy,
  Zap,
  Shield,
  Compass,
  Sparkles,
  Anchor,
  Medal,
  BookOpen,
} from "lucide-react";
import { listSailors } from "@/lib/queries";

export const dynamic = "force-dynamic";

export default async function HomePage() {
  let sailors: Awaited<ReturnType<typeof listSailors>> = [];
  let dbLive = true;

  try {
    sailors = await listSailors();
  } catch (e) {
    dbLive = false;
    void e;
  }

  const featuredSailors = sailors.slice(0, 3);

  return (
    <div className="relative min-h-screen bg-[#090a0f] flex flex-col justify-between overflow-x-hidden">
      <div className="absolute top-0 left-0 right-0 h-[420px] sm:left-1/4 sm:right-auto sm:w-[500px] sm:h-[500px] bg-orange-600/10 rounded-full blur-[100px] pointer-events-none -z-10" />
      <div className="absolute top-40 right-0 w-[320px] h-[320px] bg-sky-600/10 rounded-full blur-[100px] pointer-events-none -z-10 hidden sm:block" />

      {/* Hero */}
      <section className="w-full max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 pt-8 pb-10 sm:pt-16 sm:pb-20 text-center lg:pt-24">
        <h1 className="mx-auto max-w-4xl text-[1.65rem] leading-snug sm:text-5xl lg:text-6xl font-black tracking-tight text-white sm:leading-tight">
          The performance tracker for{" "}
          <span className="bg-gradient-to-r from-orange-500 via-orange-600 to-sky-500 bg-clip-text text-transparent">
            Singapore&apos;s youth sailors
          </span>
        </h1>

        <p className="mx-auto mt-4 sm:mt-6 max-w-xl sm:max-w-2xl text-[13px] sm:text-base md:text-lg text-slate-400 font-medium sm:font-semibold leading-relaxed">
          See your national ranking, track your sailing journey from Optimist to
          ILCA, and claim your athlete profile — all in one place.
        </p>

        <div className="mt-6 sm:mt-8 flex flex-col sm:flex-row gap-2.5 w-full max-w-md mx-auto sm:max-w-none sm:justify-center sm:gap-3">
          <Link
            href="/rankings"
            className="w-full sm:w-auto rounded-full bg-orange-600 hover:bg-orange-500 active:scale-[0.98] transition-all text-xs font-black uppercase tracking-wider text-white px-6 py-3.5 shadow-lg shadow-orange-950/20 border border-orange-500/30 inline-flex items-center justify-center gap-2 min-h-[44px]"
          >
            <Trophy className="h-4 w-4 shrink-0" />
            View Live Rankings
          </Link>
          <Link
            href="/claim-profile"
            className="w-full sm:w-auto rounded-full border border-white/15 bg-white/5 px-6 py-3.5 text-xs font-bold text-white hover:border-orange-500/40 hover:bg-white/10 transition-all text-center min-h-[44px] inline-flex items-center justify-center"
          >
            Claim My Profile
          </Link>
        </div>

        <p className="mx-auto mt-4 max-w-2xl text-[11px] sm:text-[12px] text-slate-500 leading-relaxed">
          Official ranking data for Singapore Sailing&apos;s Optimist Gold/Silver
          Series and ILCA 4 National Ranking
        </p>

        <div className="mx-auto mt-6 sm:mt-12 max-w-md w-full">
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
            {featuredSailors.length > 0 ? (
              <>
                <span className="text-slate-600 self-center w-full sm:w-auto mb-0.5 sm:mb-0">
                  Try:
                </span>
                {featuredSailors.map((sailor) => (
                  <Link
                    key={sailor.id}
                    href={`/${sailor.handle}`}
                    className="px-2.5 py-1.5 rounded-lg bg-white/5 border border-white/5 text-slate-300 hover:border-orange-500 hover:text-white transition-all max-w-[11rem] truncate"
                  >
                    {sailor.name}
                  </Link>
                ))}
              </>
            ) : (
              <Link
                href="/sample"
                className="px-2.5 py-1.5 rounded-lg bg-amber-500/10 border border-amber-500/20 text-amber-100"
              >
                Open demo profile
              </Link>
            )}
          </div>
          {!dbLive && (
            <p className="mt-2 text-[11px] text-slate-600">
              Live database offline — sample still works.
            </p>
          )}
        </div>
      </section>

      {/* Live product */}
      <section className="border-t border-white/5 bg-[#0b0c13] py-12 sm:py-16">
        <div className="mx-auto max-w-7xl px-4 sm:px-6 lg:px-8">
          <div className="text-center max-w-2xl mx-auto mb-8 sm:mb-12">
            <h2 className="text-2xl sm:text-3xl font-extrabold text-white tracking-tight">
              Live on SailorPath
            </h2>
            <p className="mt-3 text-slate-400 text-sm md:text-base leading-relaxed">
              What you can use today — rankings, profiles, and admin tools for
              Optimist and ILCA 4.
            </p>
          </div>

          <div className="grid grid-cols-1 md:grid-cols-3 gap-4 sm:gap-5">
            <article className="glass-card rounded-2xl p-5 sm:p-6 border border-orange-500/25 flex flex-col">
              <div className="flex h-10 w-10 items-center justify-center rounded-xl bg-orange-500/15 mb-3">
                <Medal className="h-5 w-5 text-orange-400" />
              </div>
              <h3 className="text-lg font-bold text-white">Optimist series</h3>
              <p className="text-xs text-slate-400 mt-2 leading-relaxed flex-1">
                Gold &amp; Silver boards with Best 3 of 5, DNS padding, overseas
                commitment, Nat A/B previews, and gold participation auto-drop
                (minimum ranking regattas per half).
              </p>
              <ul className="mt-4 space-y-1.5 text-[11px] text-slate-400 border-t border-white/5 pt-3">
                <li>
                  <strong className="text-white">SGP auto-include</strong> —
                  Singapore Optimist sailors with ranking results join the series
                  (unless marked Guest)
                </li>
                <li>
                  <strong className="text-white">Half-year fleets</strong> —
                  gold entry &amp; drop on 1 Jan / 1 Jul
                </li>
              </ul>
              <div className="mt-4 flex flex-wrap gap-2">
                <Link
                  href="/sg/optimist/gold"
                  className="text-[11px] font-bold text-orange-400 hover:text-orange-300"
                >
                  Gold →
                </Link>
                <Link
                  href="/sg/optimist/silver"
                  className="text-[11px] font-bold text-slate-400 hover:text-white"
                >
                  Silver →
                </Link>
              </div>
            </article>

            <article className="glass-card rounded-2xl p-5 sm:p-6 border border-sky-500/25 flex flex-col">
              <div className="flex h-10 w-10 items-center justify-center rounded-xl bg-sky-500/15 mb-3">
                <Anchor className="h-5 w-5 text-sky-400" />
              </div>
              <h3 className="text-lg font-bold text-white">ILCA 4 ranking</h3>
              <p className="text-xs text-slate-400 mt-2 leading-relaxed flex-1">
                High Ranking Points (1st = fleet size), Best 3 of last 5, national
                list roster, dual Optimist + ILCA sail numbers, and ILCA-first
                profiles when sailors leave Optimist.
              </p>
              <ul className="mt-4 space-y-1.5 text-[11px] text-slate-400 border-t border-white/5 pt-3">
                <li>
                  <strong className="text-white">Position trend</strong> — ILCA
                  finish chart on sailor profiles
                </li>
                <li>
                  <strong className="text-white">Left Optimist year</strong> —
                  drop or age-out on the journey timeline
                </li>
              </ul>
              <div className="mt-4">
                <Link
                  href="/sg/ilca4"
                  className="text-[11px] font-bold text-sky-400 hover:text-sky-300"
                >
                  ILCA 4 standings →
                </Link>
              </div>
            </article>

            <article className="glass-card rounded-2xl p-5 sm:p-6 border border-white/10 flex flex-col">
              <div className="flex h-10 w-10 items-center justify-center rounded-xl bg-white/10 mb-3">
                <BookOpen className="h-5 w-5 text-amber-300" />
              </div>
              <h3 className="text-lg font-bold text-white">Athlete logbook</h3>
              <p className="text-xs text-slate-400 mt-2 leading-relaxed flex-1">
                Claimed profiles with class-labeled key stats, medal tally, sailing
                journey milestones, race notes, equipment, and privacy controls.
              </p>
              <ul className="mt-4 space-y-1.5 text-[11px] text-slate-400 border-t border-white/5 pt-3">
                <li>
                  <strong className="text-white">Dual-class tabs</strong> —
                  Optimist and ILCA 4 results on one profile
                </li>
                <li>
                  <strong className="text-white">Admin quality flags</strong> —
                  gold entry mismatches, over-age Optimist, empty Series
                </li>
              </ul>
              <div className="mt-4 flex flex-wrap gap-2">
                <Link
                  href="/sample"
                  className="text-[11px] font-bold text-amber-300 hover:text-amber-200"
                >
                  Demo profile →
                </Link>
                <Link
                  href="/register"
                  className="text-[11px] font-bold text-slate-400 hover:text-white"
                >
                  Claim yours →
                </Link>
              </div>
            </article>
          </div>
        </div>
      </section>

      {/* Pathway — shorter, next horizon */}
      <section
        id="development-pathway"
        className="border-t border-white/5 bg-[#090a0f] py-12 sm:py-16"
      >
        <div className="mx-auto max-w-7xl px-4 sm:px-6 lg:px-8">
          <div className="text-center max-w-2xl mx-auto mb-8">
            <h2 className="text-2xl sm:text-3xl font-extrabold text-white tracking-tight">
              What&apos;s next
            </h2>
            <p className="mt-3 text-slate-400 text-sm leading-relaxed">
              Rankings and logbooks are live. Family, coach, and association tools
              are on the roadmap.
            </p>
          </div>
          <div className="grid grid-cols-1 sm:grid-cols-2 gap-4 max-w-3xl mx-auto">
            <article className="rounded-2xl border border-emerald-500/20 bg-emerald-500/5 p-5">
              <span className="text-[10px] font-black uppercase tracking-widest text-emerald-400">
                Next
              </span>
              <h3 className="text-base font-bold text-white mt-1">
                Family &amp; coach
              </h3>
              <p className="text-xs text-slate-400 mt-2 leading-relaxed">
                Parent linking, coach squads, and role-based access beyond the
                athlete.{" "}
                <Link
                  href="/sample?view=parent"
                  className="text-amber-300/90 underline-offset-2 hover:underline"
                >
                  Preview in demo
                </Link>
                .
              </p>
            </article>
            <article className="rounded-2xl border border-blue-500/20 bg-blue-500/5 p-5">
              <span className="text-[10px] font-black uppercase tracking-widest text-blue-400">
                Horizon
              </span>
              <h3 className="text-base font-bold text-white mt-1">
                Associations &amp; events
              </h3>
              <p className="text-xs text-slate-400 mt-2 leading-relaxed">
                Start-list sync, campaign planning, and notifications for rank
                moves and selection windows.
              </p>
            </article>
          </div>
          <p className="mt-8 text-center text-[11px] text-slate-500">
            <Link
              href="/support"
              className="text-slate-400 hover:text-white underline-offset-2 hover:underline"
            >
              Send feedback
            </Link>
            {" · "}
            <a
              href="#founding-membership"
              className="text-orange-400/90 font-semibold hover:text-orange-300"
            >
              Support the build
            </a>
          </p>
        </div>
      </section>

      {/* Founding Membership */}
      <section
        id="founding-membership"
        className="py-12 sm:py-20 bg-[#090a0f] border-t border-white/5"
      >
        <div className="mx-auto max-w-7xl px-4 sm:px-6 lg:px-8">
          <div className="mx-auto max-w-3xl text-center mb-8 sm:mb-16">
            <h2 className="text-2xl sm:text-3xl font-extrabold text-white sm:text-4xl tracking-tight">
              Back the build. Anchor your legacy.
            </h2>
            <p className="mt-4 text-slate-400 max-w-2xl mx-auto leading-relaxed text-sm md:text-base">
              Become a founding supporter of SailorPath. Your one-time
              contribution helps build the definitive performance tracker for
              Singapore&apos;s youth sailors, unlocking permanent profile
              recognition and insider access.
            </p>
          </div>

          <div className="mx-auto max-w-md w-full rounded-3xl border border-orange-500/20 bg-gradient-to-b from-[#131520] to-[#0d0f17] p-6 sm:p-8 md:p-10 shadow-2xl relative overflow-hidden group hover:border-orange-500/40 transition-all duration-300">
            <div className="absolute top-0 right-0 w-32 h-32 bg-orange-600/10 rounded-full blur-2xl group-hover:bg-orange-600/20 transition-all" />

            <div className="flex justify-between items-center mb-6">
              <div>
                <h3 className="text-xl font-bold text-white">
                  Founding Supporter
                </h3>
                <p className="text-xs text-orange-400 font-semibold mt-1">
                  First 100 Members Only
                </p>
              </div>
              <span className="inline-flex items-center rounded-full bg-orange-500/10 px-3 py-1 text-xs font-bold text-orange-400 border border-orange-500/20">
                Limited
              </span>
            </div>

            <p className="text-4xl font-extrabold text-white tracking-tight flex items-baseline gap-1.5">
              $49
              <span className="text-xs font-bold text-slate-500">
                {" "}
                (One-time contribution)
              </span>
            </p>

            <ul className="mt-8 space-y-4 text-xs font-medium text-slate-300">
              <li className="flex items-start gap-3">
                <Trophy className="h-4 w-4 text-orange-500 flex-shrink-0 mt-0.5" />
                <span>
                  <strong className="text-white">Exclusive badge</strong>: A
                  permanent &apos;Founding Supporter&apos; crest on your public
                  profile.
                </span>
              </li>
              <li className="flex items-start gap-3">
                <Compass className="h-4 w-4 text-orange-500 flex-shrink-0 mt-0.5" />
                <span>
                  <strong className="text-white">Beta access</strong>: First
                  access to upcoming parent dashboards and advanced fleet
                  analytics.
                </span>
              </li>
              <li className="flex items-start gap-3">
                <Zap className="h-4 w-4 text-orange-500 flex-shrink-0 mt-0.5" />
                <span>
                  <strong className="text-white">Shape the fleet</strong>:
                  Priority voting rights on our feature development roadmap.
                </span>
              </li>
              <li className="flex items-start gap-3">
                <Shield className="h-4 w-4 text-orange-500 flex-shrink-0 mt-0.5" />
                <span>
                  <strong className="text-white">Premium themes</strong>:
                  Exclusive colour palettes to customize your digital trophy
                  cabinet.
                </span>
              </li>
            </ul>

            <div className="mt-8">
              <a
                href="https://buy.stripe.com/mock_founding_membership"
                target="_blank"
                rel="noreferrer"
                className="flex w-full justify-center rounded-full bg-orange-600 py-3 text-center text-sm font-bold text-white hover:bg-orange-500 transition-all hover:scale-[1.02] shadow-lg shadow-orange-950/20 border border-orange-500/30"
              >
                Back the Build
              </a>
              <p className="mt-3 text-center text-[10px] text-slate-600">
                Payment link is a placeholder until Stripe is connected.
              </p>
            </div>
          </div>
        </div>
      </section>
    </div>
  );
}
