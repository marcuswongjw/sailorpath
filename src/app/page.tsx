import Link from "next/link";
import Image from "next/image";
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
  CheckCheck,
  Quote,
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
          Singapore sailing,{" "}
          <span className="bg-gradient-to-r from-orange-400 via-amber-300 to-sky-400 bg-clip-text text-transparent">
            tracked race by race.
          </span>
        </h1>

        {/* Subtitle */}
        <p className="mx-auto mt-4 sm:mt-6 max-w-xl text-sm sm:text-base md:text-lg text-slate-400 font-medium leading-relaxed">
          If your child races in Singapore — their standings, selection trial
          status, and race calendar are already here.
        </p>

        {/* ── Primary CTA: Profile Claim ── */}
        <div className="mt-8 sm:mt-10 flex flex-col items-center gap-3">
          <Link
            href="/search"
            className="w-full sm:w-auto rounded-full bg-orange-600 hover:bg-orange-500 active:scale-[0.98] transition-all text-sm font-black uppercase tracking-wider text-white px-10 py-4 shadow-lg shadow-orange-950/40 border border-orange-500/30 inline-flex items-center justify-center gap-2.5 min-h-[52px]"
          >
            <UserRound className="h-4 w-4 shrink-0" />
            <span>Find Your Child&apos;s Profile</span>
          </Link>

          {/* Trust line — Fix #4 */}
          <div className="flex flex-wrap items-center justify-center gap-x-4 gap-y-1.5 text-[11px] sm:text-xs text-slate-500">
            <span className="inline-flex items-center gap-1">
              <CheckCheck className="h-3 w-3 text-emerald-500" />
              Free to use
            </span>
            <span className="inline-flex items-center gap-1">
              <CheckCheck className="h-3 w-3 text-emerald-500" />
              No credit card
            </span>
            <span className="inline-flex items-center gap-1">
              <CheckCheck className="h-3 w-3 text-emerald-500" />
              Data from official SSF results
            </span>
          </div>
        </div>

        {/* ── Secondary CTAs ── */}
        <div className="mt-5 flex flex-wrap items-center justify-center gap-2.5">
          <Link
            href="/rankings"
            className="rounded-full bg-white/5 hover:bg-white/10 active:scale-[0.98] transition-all text-xs font-bold text-slate-200 px-5 py-2.5 border border-white/10 inline-flex items-center justify-center gap-1.5 min-h-[38px]"
          >
            <Trophy className="h-3.5 w-3.5 text-amber-400 shrink-0" />
            <span>Explore Standings</span>
          </Link>
          <Link
            href="/calendar"
            className="rounded-full bg-white/5 hover:bg-white/10 active:scale-[0.98] transition-all text-xs font-bold text-slate-200 px-5 py-2.5 border border-white/10 inline-flex items-center justify-center gap-1.5 min-h-[38px]"
          >
            <Calendar className="h-3.5 w-3.5 text-sky-400 shrink-0" />
            <span>2026 Calendar</span>
          </Link>
          <Link
            href="/sg/optimist/selection"
            className="rounded-full bg-white/5 hover:bg-white/10 active:scale-[0.98] transition-all text-xs font-bold text-slate-200 px-5 py-2.5 border border-white/10 inline-flex items-center justify-center gap-1.5 min-h-[38px]"
          >
            <Lock className="h-3.5 w-3.5 text-orange-400 shrink-0" />
            <span>Selection Trials</span>
          </Link>
        </div>

        {/* Global Search Bar */}
        <div className="mx-auto mt-8 sm:mt-10 max-w-lg w-full">
          <form action="/search" className="relative">
            <input
              type="search"
              name="query"
              enterKeyHint="search"
              placeholder="Search by name, sail number, or club…"
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
              href="/sg/techno293"
              className="px-2.5 py-1 rounded-lg bg-cyan-500/10 border border-cyan-500/20 text-cyan-300 hover:border-cyan-500/50 hover:text-cyan-200 transition-colors font-semibold"
            >
              🧭 Techno 293
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
            <p className="text-[11px] text-slate-400 mt-0.5">Optimist · ILCA 4 · WingFoil</p>
          </div>
          <div className="rounded-2xl border border-white/5 bg-white/[0.02] p-4">
            <p className="text-2xl sm:text-3xl font-black text-white font-mono">150+</p>
            <p className="text-xs font-bold text-sky-400 mt-0.5">Registered Athletes</p>
            <p className="text-[11px] text-slate-400 mt-0.5">Verified with sail numbers</p>
          </div>
          <div className="rounded-2xl border border-white/5 bg-white/[0.02] p-4">
            <p className="text-2xl sm:text-3xl font-black text-white font-mono">40+</p>
            <p className="text-xs font-bold text-amber-400 mt-0.5">Regattas Scored</p>
            <p className="text-[11px] text-slate-400 mt-0.5">Official low &amp; high points</p>
          </div>
          <div className="rounded-2xl border border-white/5 bg-white/[0.02] p-4">
            <p className="text-2xl sm:text-3xl font-black text-white font-mono flex items-center gap-2">
              Live
              <span className="h-2.5 w-2.5 rounded-full bg-emerald-400 shadow-[0_0_8px_2px_rgba(52,211,153,0.4)] animate-pulse inline-block" />
            </p>
            <p className="text-xs font-bold text-emerald-400 mt-0.5">2026 Calendar</p>
            <p className="text-[11px] text-slate-400 mt-0.5">NOR downloads &amp; entry links</p>
          </div>
        </div>
      </section>

      {/* ── 2. Social Proof Strip ── */}
      <section className="border-t border-white/5 bg-[#0b0c13] py-10 sm:py-14">
        <div className="mx-auto max-w-7xl px-4 sm:px-6 lg:px-8">
          {/* Club & Partner Logos */}
          <p className="text-center text-[11px] font-bold uppercase tracking-widest text-slate-500 mb-6">
            Athletes from across the Singapore sailing community
          </p>
          <div className="flex flex-wrap items-center justify-center gap-4 sm:gap-6 md:gap-8">
            {[
              {
                name: "Singapore Sailing",
                src: "/logos/singapore-sailing.jpg",
                width: 140,
                height: 48,
              },
              {
                name: "Changi Sailing Club",
                src: "/logos/changi-sailing-club.png",
                width: 70,
                height: 48,
              },
              {
                name: "SAF Yacht Club",
                src: "/logos/saf-yacht-club.png",
                width: 130,
                height: 48,
              },
              {
                name: "Constant Wind",
                src: "/logos/constant-wind.jpg",
                width: 140,
                height: 48,
              },
              {
                name: "ONE°15 Marina",
                src: "/logos/one15-marina.jpg",
                width: 75,
                height: 48,
              },
              {
                name: "PAssion Wave",
                src: "/logos/passion-wave.jpg",
                width: 110,
                height: 48,
              },
            ].map((club) => (
              <div
                key={club.name}
                className="flex items-center justify-center h-14 sm:h-16 px-4 py-2 rounded-2xl bg-white/[0.04] border border-white/10 hover:border-white/20 transition-all shadow-sm"
                title={club.name}
              >
                <Image
                  src={club.src}
                  alt={club.name}
                  width={club.width}
                  height={club.height}
                  className="max-h-9 sm:max-h-10 w-auto object-contain brightness-95 contrast-105 rounded"
                />
              </div>
            ))}
          </div>

          {/* Parent Quote */}
          <div className="mt-8 sm:mt-10 max-w-2xl mx-auto rounded-2xl border border-white/8 bg-white/[0.025] p-5 sm:p-7 relative shadow-lg">
            <Quote className="absolute top-4 left-4 sm:left-5 h-5 w-5 text-orange-500/30" />
            <blockquote className="text-xs sm:text-sm md:text-base text-slate-300 leading-relaxed italic pl-5 sm:pl-6">
              &ldquo;I used to have to manually calculate my child&apos;s ranking after every regatta just to find out where he stands. Now I open SailorPath and I know exactly where he stands and what he needs to qualify.&rdquo;
            </blockquote>
            <p className="mt-3.5 text-xs font-bold text-slate-400 pl-5 sm:pl-6">
              — Parent, Optimist Gold Fleet
            </p>
          </div>
        </div>
      </section>

      {/* ── 3. Interactive Live Preview Bento ── */}
      <section className="border-t border-white/5 bg-[#090a0f] py-10 sm:py-16">
        <div className="mx-auto max-w-7xl px-4 sm:px-6 lg:px-8 space-y-6 text-center">
          <div className="max-w-2xl mx-auto space-y-2.5">
            <div className="inline-flex items-center gap-1.5 text-xs font-bold uppercase tracking-wider text-orange-400">
              <Sparkles className="h-3.5 w-3.5" />
              <span>Interactive Platform Tour</span>
            </div>
            <h2 className="text-2xl sm:text-3xl lg:text-4xl font-extrabold text-white tracking-tight">
              Your sailing community, in one place.
            </h2>
            <p className="text-xs sm:text-sm text-slate-400 leading-relaxed max-w-xl mx-auto">
              Real-time standings, verified records, and private squad tracking — tested in live Singapore regattas. Click below to experience each view.
            </p>
          </div>

          <HomeLivePreview />
        </div>
      </section>

      {/* ── 4. Official Singapore Class Hubs Grid ── */}
      <section className="border-t border-white/5 bg-[#0b0c13] py-14 sm:py-20">
        <div className="mx-auto max-w-7xl px-4 sm:px-6 lg:px-8 space-y-10">
          <div className="text-center max-w-2xl mx-auto space-y-2">
            <h2 className="text-2xl sm:text-3xl font-extrabold text-white tracking-tight">
              Official Singapore Class Hubs
            </h2>
            <p className="text-xs sm:text-sm text-slate-400 leading-relaxed">
              Every class runs under its official Singapore federation rules and scoring system.
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
                  National ranking updated after every scored regatta. Separate
                  Gold and Silver fleets, with automatic promotion and
                  carry-forward scoring twice a year.
                </p>
                <ul className="space-y-1.5 text-[11px] text-slate-400 border-t border-white/5 pt-3">
                  <li className="flex items-center gap-1.5">
                    <CheckCircle2 className="h-3.5 w-3.5 text-orange-400 shrink-0" />
                    <span>Gold &amp; Silver fleet tables</span>
                  </li>
                  <li className="flex items-center gap-1.5">
                    <CheckCircle2 className="h-3.5 w-3.5 text-orange-400 shrink-0" />
                    <span>Scores carry forward on fleet promotion</span>
                  </li>
                  <li className="flex items-center gap-1.5">
                    <CheckCircle2 className="h-3.5 w-3.5 text-orange-400 shrink-0" />
                    <span>Gold, Silver &amp; Bronze medal badges</span>
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
                  The next step after Optimist. Track performance as sailors
                  transition into single-handed dinghies, with dual sail numbers
                  and year-on-year progression charts.
                </p>
                <ul className="space-y-1.5 text-[11px] text-slate-400 border-t border-white/5 pt-3">
                  <li className="flex items-center gap-1.5">
                    <CheckCircle2 className="h-3.5 w-3.5 text-sky-400 shrink-0" />
                    <span>Rolling Best 3 of 5 regatta scoring</span>
                  </li>
                  <li className="flex items-center gap-1.5">
                    <CheckCircle2 className="h-3.5 w-3.5 text-sky-400 shrink-0" />
                    <span>Dual sail numbers on one athlete record</span>
                  </li>
                  <li className="flex items-center gap-1.5">
                    <CheckCircle2 className="h-3.5 w-3.5 text-sky-400 shrink-0" />
                    <span>Transition timeline with intake year</span>
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
                  Singapore&apos;s sprint slalom racing circuit. See every heat
                  finish, discarded races, and equipment setups across the
                  Grand Prix series.
                </p>
                <ul className="space-y-1.5 text-[11px] text-slate-400 border-t border-white/5 pt-3">
                  <li className="flex items-center gap-1.5">
                    <CheckCircle2 className="h-3.5 w-3.5 text-purple-400 shrink-0" />
                    <span>Race-by-race heat breakdowns</span>
                  </li>
                  <li className="flex items-center gap-1.5">
                    <CheckCircle2 className="h-3.5 w-3.5 text-purple-400 shrink-0" />
                    <span>Automatic discard after 4+ completed races</span>
                  </li>
                  <li className="flex items-center gap-1.5">
                    <CheckCircle2 className="h-3.5 w-3.5 text-purple-400 shrink-0" />
                    <span>Foil, mast &amp; wing equipment logs</span>
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

      {/* ── 5. Spotlight Feature: 2026 Selection Trials ── */}
      <section className="border-t border-white/5 bg-[#090a0f] py-14 sm:py-20">
        <div className="mx-auto max-w-7xl px-4 sm:px-6 lg:px-8">
          <div className="relative rounded-3xl border border-orange-500/30 bg-gradient-to-r from-orange-500/[0.08] via-amber-500/[0.05] to-transparent p-6 sm:p-10 lg:p-12 overflow-hidden shadow-2xl">
            <div className="absolute -right-16 -top-16 h-64 w-64 rounded-full bg-orange-500/10 blur-3xl pointer-events-none" />

            <div className="relative max-w-3xl space-y-4">
              <div className="inline-flex items-center gap-2 rounded-full border border-orange-500/30 bg-orange-500/15 px-3.5 py-1 text-xs font-bold text-orange-300">
                <Lock className="h-3.5 w-3.5 text-orange-400" />
                <span>Members-only · Free SailorPath account required</span>
              </div>

              <h2 className="text-2xl sm:text-4xl font-black text-white tracking-tight">
                2026 Optimist Selection Trials Hub
              </h2>

              <p className="text-sm sm:text-base text-slate-300 leading-relaxed">
                Track the multi-event combined series for the{" "}
                <strong className="text-white">2026 Asian &amp; Oceania Championship</strong> and the{" "}
                <strong className="text-white">Perth Training Camp</strong>. See provisional Top 10
                rosters, gender quotas, birth year allocations (2013 – 2015), and live
                cutoff cushion indicators.
              </p>

              <div className="flex flex-col sm:flex-row items-stretch sm:items-start gap-3 pt-2">
                <div className="flex flex-col items-start gap-1.5">
                  <Link
                    href="/sg/optimist/selection"
                    className="rounded-full bg-orange-600 hover:bg-orange-500 px-6 py-3 text-xs font-bold text-white transition-all shadow-lg shadow-orange-950/30 inline-flex items-center justify-center gap-2"
                  >
                    <Trophy className="h-4 w-4" />
                    <span>View Selection Trials</span>
                  </Link>
                  <p className="text-[11px] text-slate-500 pl-1">
                    Sign in or create a free account to access
                  </p>
                </div>
                <Link
                  href="/search"
                  className="rounded-full bg-white/5 hover:bg-white/10 px-5 py-3 text-xs font-semibold text-slate-300 hover:text-white transition-colors border border-white/10 text-center inline-flex items-center justify-center gap-1.5"
                >
                  <UserRound className="h-3.5 w-3.5" />
                  Find your athlete profile
                </Link>
              </div>
            </div>
          </div>
        </div>
      </section>

      {/* ── 6. Workspaces — renamed per Fix #3 ── */}
      <section className="border-t border-white/5 bg-[#0b0c13] py-14 sm:py-20">
        <div className="mx-auto max-w-7xl px-4 sm:px-6 lg:px-8 space-y-10">
          <div className="text-center max-w-2xl mx-auto space-y-2">
            <h2 className="text-2xl sm:text-3xl font-extrabold text-white tracking-tight">
              Whether you race, parent, or coach —
            </h2>
            <p className="text-xs sm:text-sm text-slate-400 leading-relaxed">
              There&apos;s a view built for you.
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
                  One continuous record across your entire sailing career. See
                  your ranking momentum, regatta history, equipment logs, and
                  personal milestones — all in one place.
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
                  Link your account to your child&apos;s profile and see everything
                  in one dashboard: selection trial standings, national ranking,
                  upcoming races, gear condition alerts, and shared coach debriefs.
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
                  Build a private squad roster and track every athlete with
                  pulse indicators, development logs across 6 categories, and
                  side-by-side sailor comparisons. Share debriefs selectively
                  with sailors and families.
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

      {/* ── 7. Closing CTA — Fix #5 ── */}
      <section className="border-t border-white/5 bg-[#090a0f] py-16 sm:py-24">
        <div className="mx-auto max-w-2xl px-4 sm:px-6 text-center space-y-6">
          <h2 className="text-2xl sm:text-4xl font-black text-white tracking-tight leading-tight">
            Your child&apos;s sailing career<br className="hidden sm:block" /> is already recorded here.
          </h2>
          <p className="text-sm sm:text-base text-slate-400">
            All that&apos;s missing is you.
          </p>
          <div className="flex flex-col items-center gap-3">
            <Link
              href="/search"
              className="rounded-full bg-orange-600 hover:bg-orange-500 active:scale-[0.98] transition-all text-sm font-black uppercase tracking-wider text-white px-10 py-4 shadow-lg shadow-orange-950/40 border border-orange-500/30 inline-flex items-center justify-center gap-2.5 min-h-[52px]"
            >
              <UserRound className="h-4 w-4 shrink-0" />
              Find Your Child&apos;s Profile
            </Link>
            <p className="text-xs text-slate-500">Free to join · Takes 2 minutes</p>
          </div>

          {/* Quiet waitlist as secondary option */}
          <div className="pt-8 border-t border-white/5 space-y-3">
            <p className="text-xs text-slate-500">
              Want updates when new features ship? Drop your email.
            </p>
            <div className="flex justify-center">
              <WaitlistForm presetRole="Parent" submitLabel="Stay in the loop" compact />
            </div>
          </div>
        </div>
      </section>
    </div>
  );
}
