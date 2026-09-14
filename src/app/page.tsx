import Link from "next/link";
import {
  Search,
  Trophy,
  Anchor,
  Users,
  UserRound,
  Lock,
  ArrowRight,
  Wind,
  CheckCircle2,
  Sparkles,
  Shield,
  Calendar,
} from "lucide-react";
import { WaitlistForm } from "@/components/WaitlistForm";
import { HomeLivePreview } from "@/components/home/HomeLivePreview";
import type { Metadata } from "next";

export const metadata: Metadata = {
  title: "Singapore Sailing Standings, Selection Trials, Calendar & Records | SailorPath",
  description:
    "Follow current Singapore Optimist, ILCA 4, and WingFoil standings, track 2026 Selection Trials, view the upcoming 2026 Racing Calendar, and manage dedicated parent and coach workspaces.",
};

/**
 * Static marketing homepage — revalidated periodically so logo → home is instant.
 */
export const revalidate = 300;

export default function HomePage() {
  return (
    <div className="relative min-h-screen bg-[#090a0f] flex flex-col justify-between overflow-x-hidden">
      {/* Background Ambient Glows */}
      <div className="absolute top-0 left-0 right-0 h-[480px] sm:left-1/4 sm:right-auto sm:w-[600px] sm:h-[600px] bg-orange-600/10 rounded-full blur-[120px] pointer-events-none -z-10" />
      <div className="absolute top-48 right-0 w-[400px] h-[400px] bg-sky-600/10 rounded-full blur-[120px] pointer-events-none -z-10 hidden sm:block" />

      {/* ── 1. Hero Section ── */}
      <section className="w-full max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 pt-8 pb-12 sm:pt-16 sm:pb-16 text-center lg:pt-20">
        {/* Eyebrow Pill */}
        <div className="inline-flex items-center gap-2 rounded-full border border-orange-500/30 bg-orange-500/10 px-4 py-1.5 text-xs font-bold text-orange-300 shadow-sm shadow-orange-500/10 mb-6">
          <span className="text-sm">🇸🇬</span>
          <span>Official Singapore Sailing Standings &amp; Athlete Records</span>
        </div>

        {/* Main Headline */}
        <h1 className="mx-auto max-w-4xl text-[1.85rem] leading-tight sm:text-5xl lg:text-6xl font-black tracking-tight text-white sm:leading-[1.15]">
          {"See the standings. Own the whole "}
          <span className="bg-gradient-to-r from-orange-400 via-amber-300 to-sky-400 bg-clip-text text-transparent">
            sailing journey.
          </span>
        </h1>

        {/* Subtitle with all classes & Selection */}
        <p className="mx-auto mt-4 sm:mt-6 max-w-2xl sm:max-w-3xl text-[13px] sm:text-base md:text-lg text-slate-400 font-medium sm:font-semibold leading-relaxed">
          Follow live standings across <strong className="text-slate-200">Optimist</strong>,{" "}
          <strong className="text-slate-200">ILCA 4</strong>, and{" "}
          <strong className="text-slate-200">WingFoil</strong>. Track official selection trials, explore the{" "}
          <strong className="text-slate-200">2026 Racing Calendar</strong>, and keep one continuous athlete record with Hero Athlete Cards and segmented tabs (Overview, Regattas, Milestones). Coaches and parents get dedicated private workspaces.
        </p>

        {/* Primary CTA Buttons */}
        <div className="mt-7 sm:mt-9 flex flex-col sm:flex-row items-center justify-center gap-3 w-full max-w-md mx-auto sm:max-w-none">
          <Link
            href="/rankings"
            className="w-full sm:w-auto rounded-full bg-orange-600 hover:bg-orange-500 active:scale-[0.98] transition-all text-xs font-black uppercase tracking-wider text-white px-7 py-3.5 shadow-lg shadow-orange-950/40 border border-orange-500/30 inline-flex items-center justify-center gap-2 min-h-[46px]"
          >
            <Trophy className="h-4 w-4 shrink-0" />
            <span>Explore Standings</span>
          </Link>
          <Link
            href="/calendar"
            className="w-full sm:w-auto rounded-full bg-white/5 hover:bg-white/10 active:scale-[0.98] transition-all text-xs font-bold text-slate-200 px-6 py-3.5 border border-white/10 inline-flex items-center justify-center gap-2 min-h-[46px]"
          >
            <Calendar className="h-3.5 w-3.5 text-sky-400" />
            <span>2026 Racing Calendar</span>
          </Link>
          <Link
            href="/sg/optimist/selection"
            className="w-full sm:w-auto rounded-full bg-white/5 hover:bg-white/10 active:scale-[0.98] transition-all text-xs font-bold text-slate-200 px-6 py-3.5 border border-white/10 inline-flex items-center justify-center gap-2 min-h-[46px]"
          >
            <Lock className="h-3.5 w-3.5 text-orange-400" />
            <span>Selection Trials</span>
            <span className="text-[10px] bg-orange-500/20 text-orange-300 px-1.5 py-0.5 rounded font-bold">
              Members
            </span>
          </Link>
        </div>

        {/* Sailor Claim prompt */}
        <p className="mt-4 text-xs sm:text-sm text-slate-400">
          Sailor or parent?{" "}
          <Link
            href="/search"
            className="font-bold text-orange-400 hover:text-orange-300 underline-offset-4 hover:underline"
          >
            Find and claim your athlete profile →
          </Link>
        </p>

        {/* Global Search Bar */}
        <div className="mx-auto mt-7 sm:mt-10 max-w-lg w-full">
          <form action="/search" className="relative">
            <input
              type="search"
              name="query"
              enterKeyHint="search"
              placeholder="Search sailor name, sail number, or club…"
              className="w-full rounded-2xl sm:rounded-full border border-white/10 bg-white/5 px-5 py-3.5 pr-12 text-white placeholder-slate-500 focus:border-orange-500 focus:outline-none focus:ring-2 focus:ring-orange-500/20 text-sm min-h-[50px] shadow-lg shadow-black/20"
            />
            <button
              type="submit"
              className="absolute right-1.5 top-1/2 -translate-y-1/2 rounded-xl sm:rounded-full bg-orange-600 hover:bg-orange-500 p-2.5 text-white min-h-[42px] min-w-[42px] inline-flex items-center justify-center transition-colors"
              aria-label="Search"
            >
              <Search className="h-4 w-4" />
            </button>
          </form>

          {/* Quick Jump Fast-Paths */}
          <div className="mt-3.5 flex flex-wrap items-center justify-center gap-1.5 sm:gap-2 text-[11px] sm:text-xs">
            <span className="text-slate-500 font-bold uppercase tracking-wider text-[10px] mr-1">
              Quick Jump:
            </span>
            <Link
              href="/calendar"
              className="px-2.5 py-1 rounded-lg bg-sky-500/10 border border-sky-500/20 text-sky-300 hover:border-sky-500/50 hover:text-sky-200 transition-colors font-semibold"
            >
              📅 2026 Calendar
            </Link>
            <Link
              href="/sg/optimist/gold"
              className="px-2.5 py-1 rounded-lg bg-white/5 border border-white/5 text-slate-300 hover:border-orange-500/40 hover:text-white transition-colors"
            >
              🏆 Opti Gold
            </Link>
            <Link
              href="/sg/optimist/silver"
              className="px-2.5 py-1 rounded-lg bg-white/5 border border-white/5 text-slate-300 hover:border-orange-500/40 hover:text-white transition-colors"
            >
              🥈 Opti Silver
            </Link>
            <Link
              href="/sg/ilca4"
              className="px-2.5 py-1 rounded-lg bg-white/5 border border-white/5 text-slate-300 hover:border-orange-500/40 hover:text-white transition-colors"
            >
              ⛵ ILCA 4
            </Link>
            <Link
              href="/sg/wingfoil"
              className="px-2.5 py-1 rounded-lg bg-white/5 border border-white/5 text-slate-300 hover:border-orange-500/40 hover:text-white transition-colors"
            >
              🏄‍♂️ WingFoil
            </Link>
            <Link
              href="/sg/optimist/selection"
              className="px-2.5 py-1 rounded-lg bg-orange-500/10 border border-orange-500/20 text-orange-300 hover:border-orange-500/50 hover:text-orange-200 transition-colors font-semibold"
            >
              🎯 Trials
            </Link>
          </div>
        </div>

        {/* Platform Proof Metrics Strip */}
        <div className="mt-12 sm:mt-16 pt-8 border-t border-white/5 grid grid-cols-2 md:grid-cols-4 gap-4 max-w-4xl mx-auto text-left">
          <div className="rounded-2xl border border-white/5 bg-white/[0.02] p-4">
            <p className="text-2xl sm:text-3xl font-black text-white font-mono">3</p>
            <p className="text-xs font-bold text-orange-400 mt-0.5">National Classes</p>
            <p className="text-[11px] text-slate-400 mt-0.5">Optimist, ILCA 4 &amp; WingFoil</p>
          </div>
          <div className="rounded-2xl border border-white/5 bg-white/[0.02] p-4">
            <p className="text-2xl sm:text-3xl font-black text-white font-mono">150+</p>
            <p className="text-xs font-bold text-sky-400 mt-0.5">Singapore Athletes</p>
            <p className="text-[11px] text-slate-400 mt-0.5">Verified profiles with sail #</p>
          </div>
          <div className="rounded-2xl border border-white/5 bg-white/[0.02] p-4">
            <p className="text-2xl sm:text-3xl font-black text-white font-mono">40+</p>
            <p className="text-xs font-bold text-amber-400 mt-0.5">Regattas Scored</p>
            <p className="text-[11px] text-slate-400 mt-0.5">Official low &amp; high points</p>
          </div>
          <div className="rounded-2xl border border-white/5 bg-white/[0.02] p-4">
            <p className="text-2xl sm:text-3xl font-black text-white font-mono">2026</p>
            <p className="text-xs font-bold text-emerald-400 mt-0.5">Race Calendar Live</p>
            <p className="text-[11px] text-slate-400 mt-0.5">NOR downloads &amp; entry links</p>
          </div>
        </div>
      </section>

      {/* ── 2. Interactive Live Preview Bento ── */}
      <section className="border-t border-white/5 bg-[#090a0f] py-10 sm:py-16">
        <div className="mx-auto max-w-7xl px-4 sm:px-6 lg:px-8 space-y-6 text-center">
          <div className="max-w-2xl mx-auto space-y-2">
            <div className="inline-flex items-center gap-1.5 text-xs font-bold uppercase tracking-wider text-orange-400">
              <Sparkles className="h-3.5 w-3.5" />
              <span>Interactive Platform Tour</span>
            </div>
            <h2 className="text-2xl sm:text-3xl font-extrabold text-white tracking-tight">
              Real-time standings, verified records, private squads
            </h2>
            <p className="text-xs sm:text-sm text-slate-400 leading-relaxed">
              Explore how podium medal badges look across classes, preview an athlete&apos;s multi-year progression,
              and see how coaches monitor squad momentum.
            </p>
          </div>

          <HomeLivePreview />
        </div>
      </section>

      {/* ── 3. Official Singapore Class Hubs Grid ── */}
      <section className="border-t border-white/5 bg-[#0b0c13] py-14 sm:py-20">
        <div className="mx-auto max-w-7xl px-4 sm:px-6 lg:px-8 space-y-10">
          <div className="text-center max-w-2xl mx-auto space-y-2">
            <h2 className="text-2xl sm:text-3xl font-extrabold text-white tracking-tight">
              Official Singapore Class Hubs
            </h2>
            <p className="text-xs sm:text-sm text-slate-400 leading-relaxed">
              Every class operates under its official Singapore federation rules and scoring conventions.
            </p>
          </div>

          <div className="grid grid-cols-1 md:grid-cols-3 gap-5 sm:gap-6">
            {/* Optimist Card */}
            <article className="glass-card rounded-2xl p-6 border border-orange-500/25 bg-gradient-to-b from-orange-500/[0.05] to-transparent flex flex-col justify-between space-y-4">
              <div className="space-y-3">
                <div className="flex items-center justify-between">
                  <span className="flex h-10 w-10 items-center justify-center rounded-xl bg-orange-500/15 text-orange-400">
                    <Trophy className="h-5 w-5" />
                  </span>
                </div>
                <div>
                  <h3 className="text-lg font-bold text-white">Optimist Class</h3>
                  <p className="text-xs font-semibold text-orange-300/90 mt-0.5">
                    Gold &amp; Silver Fleet Series Rankings
                  </p>
                </div>
                <p className="text-xs text-slate-400 leading-relaxed">
                  Live national ranking based on 5-regatta national series every half-yearly. Gold/Silver fleet intake and drops applied twice a year (1 Jan / 1 Jul).
                </p>
                <ul className="space-y-1.5 text-[11px] text-slate-400 border-t border-white/5 pt-3">
                  <li className="flex items-center gap-1.5">
                    <CheckCircle2 className="h-3.5 w-3.5 text-orange-400 shrink-0" />
                    <span>Gold &amp; Silver fleet segregation</span>
                  </li>
                  <li className="flex items-center gap-1.5">
                    <CheckCircle2 className="h-3.5 w-3.5 text-orange-400 shrink-0" />
                    <span>Carry-forward scores on fleet promotions</span>
                  </li>
                  <li className="flex items-center gap-1.5">
                    <CheckCircle2 className="h-3.5 w-3.5 text-orange-400 shrink-0" />
                    <span>Top-3 Gold, Silver, and Bronze badges</span>
                  </li>
                </ul>
              </div>

              <div className="flex flex-wrap items-center gap-2 pt-2 border-t border-white/5">
                <Link
                  href="/sg/optimist/gold"
                  className="rounded-lg bg-orange-600 hover:bg-orange-500 px-3 py-1.5 text-xs font-bold text-white transition-colors"
                >
                  Gold Standings →
                </Link>
                <Link
                  href="/sg/optimist/silver"
                  className="rounded-lg bg-white/5 hover:bg-white/10 px-3 py-1.5 text-xs font-semibold text-slate-300 hover:text-white transition-colors border border-white/5"
                >
                  Silver Standings
                </Link>
              </div>
            </article>

            {/* ILCA 4 Card */}
            <article className="glass-card rounded-2xl p-6 border border-sky-500/25 bg-gradient-to-b from-sky-500/[0.05] to-transparent flex flex-col justify-between space-y-4">
              <div className="space-y-3">
                <div className="flex items-center justify-between">
                  <span className="flex h-10 w-10 items-center justify-center rounded-xl bg-sky-500/15 text-sky-400">
                    <Anchor className="h-5 w-5" />
                  </span>
                </div>
                <div>
                  <h3 className="text-lg font-bold text-white">ILCA 4 Class</h3>
                  <p className="text-xs font-semibold text-sky-300/90 mt-0.5">
                    National High Points Ranking &amp; Progression
                  </p>
                </div>
                <p className="text-xs text-slate-400 leading-relaxed">
                  Track performance as youth athletes transition from Optimist into single-handed dinghies.
                  Uses High Ranking Points with position trend charts and dual-class profile linking.
                </p>
                <ul className="space-y-1.5 text-[11px] text-slate-400 border-t border-white/5 pt-3">
                  <li className="flex items-center gap-1.5">
                    <CheckCircle2 className="h-3.5 w-3.5 text-sky-400 shrink-0" />
                    <span>Best 3 of last 5 regattas</span>
                  </li>
                  <li className="flex items-center gap-1.5">
                    <CheckCircle2 className="h-3.5 w-3.5 text-sky-400 shrink-0" />
                    <span>Dual sail numbers on a single athlete record</span>
                  </li>
                  <li className="flex items-center gap-1.5">
                    <CheckCircle2 className="h-3.5 w-3.5 text-sky-400 shrink-0" />
                    <span>Transition intake year &amp; progress timeline</span>
                  </li>
                </ul>
              </div>

              <div className="flex items-center gap-2 pt-2 border-t border-white/5">
                <Link
                  href="/sg/ilca4"
                  className="rounded-lg bg-sky-600 hover:bg-sky-500 px-3 py-1.5 text-xs font-bold text-white transition-colors"
                >
                  ILCA 4 Standings →
                </Link>
                <Link
                  href="/sg/ilca4/regattas"
                  className="rounded-lg bg-white/5 hover:bg-white/10 px-3 py-1.5 text-xs font-semibold text-slate-300 hover:text-white transition-colors border border-white/5"
                >
                  Regattas
                </Link>
              </div>
            </article>

            {/* WingFoil Card */}
            <article className="glass-card rounded-2xl p-6 border border-purple-500/25 bg-gradient-to-b from-purple-500/[0.05] to-transparent flex flex-col justify-between space-y-4">
              <div className="space-y-3">
                <div className="flex items-center justify-between">
                  <span className="flex h-10 w-10 items-center justify-center rounded-xl bg-purple-500/15 text-purple-400">
                    <Wind className="h-5 w-5" />
                  </span>
                </div>
                <div>
                  <h3 className="text-lg font-bold text-white">WingFoil Class</h3>
                  <p className="text-xs font-semibold text-purple-300/90 mt-0.5">
                    Sprint Slalom Event Standings
                  </p>
                </div>
                <p className="text-xs text-slate-400 leading-relaxed">
                  Competitive WingFoil racing in Singapore. Track event standings, individual heat finishes (R1–R9), discard scoring, and equipment setups.
                </p>
                <ul className="space-y-1.5 text-[11px] text-slate-400 border-t border-white/5 pt-3">
                  <li className="flex items-center gap-1.5">
                    <CheckCircle2 className="h-3.5 w-3.5 text-purple-400 shrink-0" />
                    <span>Heat breakdowns and race-by-race finishes</span>
                  </li>
                  <li className="flex items-center gap-1.5">
                    <CheckCircle2 className="h-3.5 w-3.5 text-purple-400 shrink-0" />
                    <span>Automatic 1-discard after 4+ completed races</span>
                  </li>
                  <li className="flex items-center gap-1.5">
                    <CheckCircle2 className="h-3.5 w-3.5 text-purple-400 shrink-0" />
                    <span>Foil, mast, and wing equipment records</span>
                  </li>
                </ul>
              </div>

              <div className="flex items-center gap-2 pt-2 border-t border-white/5">
                <Link
                  href="/sg/wingfoil"
                  className="rounded-lg bg-purple-600 hover:bg-purple-500 px-3 py-1.5 text-xs font-bold text-white transition-colors"
                >
                  Open WingFoil Hub →
                </Link>
              </div>
            </article>
          </div>
        </div>
      </section>

      {/* ── 4. Spotlight Feature: 2026 Selection Trials ── */}
      <section className="border-t border-white/5 bg-[#090a0f] py-14 sm:py-20">
        <div className="mx-auto max-w-7xl px-4 sm:px-6 lg:px-8">
          <div className="relative rounded-3xl border border-orange-500/30 bg-gradient-to-r from-orange-500/[0.08] via-amber-500/[0.05] to-transparent p-6 sm:p-10 lg:p-12 overflow-hidden shadow-2xl">
            <div className="absolute -right-16 -top-16 h-64 w-64 rounded-full bg-orange-500/10 blur-3xl pointer-events-none" />

            <div className="relative max-w-3xl space-y-4">
              <div className="inline-flex items-center gap-2 rounded-full border border-orange-500/30 bg-orange-500/15 px-3.5 py-1 text-xs font-bold text-orange-300">
                <Lock className="h-3.5 w-3.5 text-orange-400" />
                <span>Member-Gated Feature · Free SailorPath Account Required</span>
              </div>

              <h2 className="text-2xl sm:text-4xl font-black text-white tracking-tight">
                2026 Optimist Selection Trials Hub
              </h2>

              <p className="text-sm sm:text-base text-slate-300 leading-relaxed">
                Track the multi-event combined low-point series for the{" "}
                <strong className="text-white">2026 Asian &amp; Oceania Championship</strong> and the{" "}
                <strong className="text-white">Perth Training Camp</strong>. See provisional Top 10 rosters,
                gender quotas (min 3 per gender), birth year allocations (2013, 2014, 2015), and real-time
                cutoff cushion buffers.
              </p>

              <div className="flex flex-col sm:flex-row items-stretch sm:items-center gap-3 pt-2">
                <Link
                  href="/sg/optimist/selection"
                  className="rounded-full bg-orange-600 hover:bg-orange-500 px-6 py-3 text-xs font-bold text-white transition-all shadow-lg shadow-orange-950/30 text-center inline-flex items-center justify-center gap-2"
                >
                  <Trophy className="h-4 w-4" />
                  <span>View Selection Standings (Sign In Required)</span>
                </Link>
                <Link
                  href="/search"
                  className="rounded-full bg-white/5 hover:bg-white/10 px-5 py-3 text-xs font-semibold text-slate-300 hover:text-white transition-colors border border-white/10 text-center"
                >
                  Claim Athlete Profile First
                </Link>
              </div>
            </div>
          </div>
        </div>
      </section>

      {/* ── 5. Tailored Workspaces Bento (Sailors, Parents, Coaches) ── */}
      <section className="border-t border-white/5 bg-[#0b0c13] py-14 sm:py-20">
        <div className="mx-auto max-w-7xl px-4 sm:px-6 lg:px-8 space-y-10">
          <div className="text-center max-w-2xl mx-auto space-y-2">
            <h2 className="text-2xl sm:text-3xl font-extrabold text-white tracking-tight">
              Workspaces built for Singapore Sailing
            </h2>
            <p className="text-xs sm:text-sm text-slate-400 leading-relaxed">
              Tailored tools for every stakeholder in competitive sailing.
            </p>
          </div>

          <div className="grid grid-cols-1 md:grid-cols-3 gap-5">
            {/* For Sailors */}
            <article className="glass-card rounded-2xl p-6 border border-orange-500/25 flex flex-col justify-between">
              <div className="space-y-3">
                <span className="flex h-10 w-10 items-center justify-center rounded-xl bg-orange-500/15 text-orange-400">
                  <UserRound className="h-5 w-5" />
                </span>
                <h3 className="text-lg font-bold text-white">For Sailors</h3>
                <p className="text-xs font-semibold text-white">Own your sailing journey.</p>
                <p className="text-xs sm:text-sm text-slate-400 leading-relaxed">
                  Follow your results, ranking momentum, and career progression from Optimist to ILCA with our{" "}
                  <strong className="text-orange-300">Hero Athlete Card</strong> and segmented tabs (Overview, Regattas, Milestones, Equipment). Track boat locker gear with 3-tier condition audits (Race Ready, Practice Only, Needs Repair), private race reflections, and milestone archives.
                </p>
              </div>
              <Link
                href="/search"
                className="mt-5 text-xs font-bold text-orange-400 hover:text-orange-300 inline-flex items-center gap-1"
              >
                <span>Find and claim your profile</span>
                <ArrowRight className="h-3.5 w-3.5" />
              </Link>
            </article>

            {/* For Parents */}
            <article className="glass-card rounded-2xl p-6 border border-emerald-500/25 flex flex-col justify-between">
              <div className="space-y-3">
                <span className="flex h-10 w-10 items-center justify-center rounded-xl bg-emerald-500/15 text-emerald-400">
                  <Users className="h-5 w-5" />
                </span>
                <h3 className="text-lg font-bold text-white">For Parents</h3>
                <p className="text-xs font-semibold text-white">Keep their progress in one clear view.</p>
                <p className="text-xs sm:text-sm text-slate-400 leading-relaxed">
                  Link your parent account to your child&apos;s profile and open the{" "}
                  <strong className="text-emerald-300">Parent Dashboard</strong>. Track simplified 3-column standings ((1) Selection Trial qualification, (2) National Ranking, (3) Recent Regatta Results). Switch seamlessly between multiple children, track Asian Games &amp; Perth Camp cutoffs, monitor boat locker gear alerts, review shared coach technical debriefs, and manage custom pre-race morning checklists.
                </p>
              </div>
              <Link
                href="/parent"
                className="mt-5 text-xs font-bold text-emerald-400 hover:text-emerald-300 inline-flex items-center gap-1"
              >
                <span>Open Parent Dashboard</span>
                <ArrowRight className="h-3.5 w-3.5" />
              </Link>
            </article>

            {/* For Coaches */}
            <article className="glass-card rounded-2xl p-6 border border-sky-500/25 flex flex-col justify-between">
              <div className="space-y-3">
                <span className="flex h-10 w-10 items-center justify-center rounded-xl bg-sky-500/15 text-sky-400">
                  <Shield className="h-5 w-5" />
                </span>
                <h3 className="text-lg font-bold text-white">For Coaches</h3>
                <p className="text-xs font-semibold text-white">Keep your squad in one live view.</p>
                <p className="text-xs sm:text-sm text-slate-400 leading-relaxed">
                  Build private squad rosters and monitor your fleet with{" "}
                  <strong className="text-sky-300">Squad Pulse Cards</strong> (fleet segregation, gear health alerts, selection tags). Log structured observations across 6 categories (Technical, Tactical, Physical, Mental, Equipment, Communication) with sentiment tracking and selective debrief sharing (<code className="text-sky-300">coach_only</code> vs shared with family), plus head-to-head comparisons.
                </p>
              </div>
              <div className="mt-5 space-y-1">
                <Link
                  href="/coach-tools"
                  className="text-xs font-bold text-sky-400 hover:text-sky-300 inline-flex items-center gap-1"
                >
                  <span>Open Coach Dashboard</span>
                  <ArrowRight className="h-3.5 w-3.5" />
                </Link>
                <p className="text-[10px] text-slate-500">Coach access is reviewed before activation.</p>
              </div>
            </article>
          </div>
        </div>
      </section>

      {/* ── 6. How SailorPath Works ── */}
      <section className="border-t border-white/5 bg-[#090a0f] py-14 sm:py-16">
        <div className="mx-auto max-w-7xl px-4 sm:px-6 lg:px-8 space-y-10">
          <div className="text-center max-w-2xl mx-auto space-y-2">
            <h2 className="text-2xl sm:text-3xl font-extrabold text-white tracking-tight">
              How SailorPath Works
            </h2>
            <p className="text-xs sm:text-sm text-slate-400 leading-relaxed">
              Automated scoring pipelines and verified athlete records from official results.
            </p>
          </div>

          <div className="grid grid-cols-1 md:grid-cols-3 gap-6 max-w-5xl mx-auto">
            {(
              [
                {
                  step: "1",
                  title: "Results are Imported & Verified",
                  body: "Published regatta results are imported from official PDF or Excel sheets and reviewed before standings are published.",
                },
                {
                  step: "2",
                  title: "Series Standings Auto-Calculate",
                  body: "Rolling Best-3-of-5, High Points, and Sprint Slalom discard formulas apply automatically under official class rules.",
                },
                {
                  step: "3",
                  title: "Athletes, Parents & Coaches Engage",
                  body: "Claim profiles to record career milestones, monitor selection trials cutoffs, or run private squad tracking.",
                },
              ] as const
            ).map((item) => (
              <div
                key={item.step}
                className="relative rounded-2xl border border-white/10 bg-white/[0.03] p-6 text-center md:text-left"
              >
                <span className="inline-flex h-9 w-9 items-center justify-center rounded-full bg-orange-500/15 text-orange-400 text-sm font-black border border-orange-500/25 mb-3">
                  {item.step}
                </span>
                <h3 className="text-base sm:text-lg font-bold text-white">{item.title}</h3>
                <p className="mt-2 text-xs sm:text-sm text-slate-400 leading-relaxed">{item.body}</p>
              </div>
            ))}
          </div>

          <p className="text-center pt-2">
            <Link
              href="/how-rankings-work"
              className="text-xs sm:text-sm font-semibold text-orange-400 hover:text-orange-300 inline-flex items-center gap-1"
            >
              <span>Read the complete ranking methodology &amp; series rules</span>
              <ArrowRight className="h-3.5 w-3.5" />
            </Link>
          </p>
        </div>
      </section>

      {/* ── 7. Roadmap & Family Waitlist ── */}
      <section id="roadmap" className="border-t border-white/5 bg-[#0b0c13] py-14 sm:py-16">
        <div className="mx-auto max-w-7xl px-4 sm:px-6 lg:px-8">
          <div className="text-center max-w-2xl mx-auto mb-10 space-y-2">
            <h2 className="text-2xl sm:text-3xl font-extrabold text-white tracking-tight">
              Available now &amp; next
            </h2>
            <p className="text-slate-400 text-xs sm:text-sm leading-relaxed">
              Rankings, claimed profiles, the{" "}
              <Link href="/parent" className="text-emerald-300 font-semibold hover:text-emerald-200">
                Parent Dashboard
              </Link>
              , the{" "}
              <Link href="/calendar" className="text-orange-300 font-semibold hover:text-orange-200">
                2026 Racing Calendar
              </Link>
              , and the{" "}
              <Link href="/coach-tools" className="text-sky-300 font-semibold hover:text-sky-200">
                Coach Dashboard
              </Link>{" "}
              are live today.
            </p>
          </div>

          <ol className="mx-auto max-w-2xl space-y-0 relative">
            <li id="roadmap-parent" className="relative flex gap-4 pb-10">
              <span className="absolute left-[11px] top-7 bottom-0 w-px bg-white/10" aria-hidden />
              <span className="relative z-10 mt-1 h-6 w-6 shrink-0 rounded-full border border-emerald-500/40 bg-emerald-500/15" />
              <div className="min-w-0 flex-1">
                <p className="text-[11px] font-black uppercase tracking-widest text-emerald-400">
                  Available now
                </p>
                <h3 className="text-base font-bold text-white mt-1">Parent Dashboard &amp; Racing Calendar</h3>
                <p className="text-xs sm:text-sm text-slate-400 mt-1.5 leading-relaxed">
                  Link your children, then open{" "}
                  <Link href="/parent" className="text-emerald-300 font-semibold hover:text-emerald-200">
                    /parent
                  </Link>{" "}
                  for multi-athlete tracking, live 2026 Selection Trials qualification buffers, boat locker maintenance logs, coach debriefs, and interactive morning checklists. View the complete 2026 schedule on the{" "}
                  <Link href="/calendar" className="text-emerald-300 font-semibold hover:text-emerald-200">
                    Racing Calendar
                  </Link>.
                </p>
                <div className="mt-3 flex flex-wrap gap-3 items-center">
                  <Link
                    href="/parent"
                    className="text-xs font-bold text-emerald-400 hover:text-emerald-300"
                  >
                    Open Parent Dashboard →
                  </Link>
                  <Link
                    href="/calendar"
                    className="text-xs font-semibold text-slate-300 hover:text-white"
                  >
                    2026 Racing Calendar →
                  </Link>
                  <Link
                    href="/claim-profile"
                    className="text-xs font-semibold text-slate-400 hover:text-white"
                  >
                    Link a child first
                  </Link>
                </div>
                <p className="mt-4 text-[11px] font-bold uppercase tracking-wider text-slate-500">
                  Waitlist for next family features
                </p>
                <WaitlistForm presetRole="Parent" submitLabel="Join parent waitlist" compact />
              </div>
            </li>

            <li id="roadmap-coach" className="relative flex gap-4 pb-10">
              <span className="absolute left-[11px] top-7 bottom-0 w-px bg-white/10" aria-hidden />
              <span className="relative z-10 mt-1 h-6 w-6 shrink-0 rounded-full border border-sky-500/40 bg-sky-500/15" />
              <div className="min-w-0 flex-1">
                <p className="text-[11px] font-black uppercase tracking-widest text-sky-400">
                  Available now
                </p>
                <h3 className="text-base font-bold text-white mt-1">Coach Squad Pulse &amp; Development Log</h3>
                <p className="text-xs sm:text-sm text-slate-400 mt-1.5 leading-relaxed">
                  Build a private roster with live rankings, Squad Pulse status indicators, and 6-category Athlete Development Logs. Compare two sailors side-by-side, manage action items, and selectively share technical debriefs with sailors and parents.
                </p>
                <div className="mt-3 flex flex-wrap gap-3 items-center">
                  <Link
                    href="/coach-tools"
                    className="text-xs font-bold text-sky-400 hover:text-sky-300"
                  >
                    Open Coach Dashboard →
                  </Link>
                  <Link
                    href="/register?role=coach&next=%2Fcoach-tools"
                    className="text-xs font-semibold text-slate-400 hover:text-white"
                  >
                    Create coach account
                  </Link>
                </div>
              </div>
            </li>

            <li className="relative flex gap-4 pb-0">
              <span className="relative z-10 mt-1 h-6 w-6 shrink-0 rounded-full border border-white/20 bg-white/5" />
              <div className="min-w-0 flex-1">
                <p className="text-[11px] font-black uppercase tracking-widest text-slate-500">
                  2027
                </p>
                <h3 className="text-base font-bold text-white mt-1">Club &amp; Event Tools</h3>
                <p className="text-xs sm:text-sm text-slate-400 mt-1.5 leading-relaxed">
                  Start-list sync, campaign planning, and automated alerts for rank changes and selection windows.
                </p>
              </div>
            </li>
          </ol>
        </div>
      </section>
    </div>
  );
}
