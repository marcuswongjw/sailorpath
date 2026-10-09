import type { Metadata } from "next";
import Link from "next/link";
import { getLandingTotals } from "@/lib/landingStats";
import {
  ArrowRight,
  CalendarDays,
  ChartNoAxesColumnIncreasing,
  Check,
  Search,
  ShieldCheck,
  Trophy,
  UserRound,
  UsersRound,
} from "lucide-react";

export const metadata: Metadata = {
  title: "Singapore Sailing Standings & Athlete Records | SailorPath",
  description:
    "Browse sailing results, Singapore class standings, upcoming and past regattas, selection trials, and sailor profiles across Optimist, ILCA, WingFoil and Techno 293.",
};

export const revalidate = 300;

const classHubs = [
  {
    name: "Optimist",
    href: "/sg/optimist/gold",
    tagline: "Gold and Silver fleet rankings",
    note: "Standings from published, reviewed class results.",
  },
  {
    name: "ILCA 4",
    href: "/sg/ilca4",
    tagline: "Youth national ranking",
    note: "Singapore ranking and race-by-race results.",
  },
  {
    name: "ILCA 6",
    href: "/sg/ilca6",
    tagline: "National high points ranking",
    note: "Best 3 of 5 events in the current series.",
  },
  {
    name: "ILCA 7",
    href: "/sg/ilca7",
    tagline: "Class standings and results",
    note: "Follow fleet finishes and individual race scores.",
  },
  {
    name: "WingFoil",
    href: "/sg/wingfoil",
    tagline: "Sprint slalom standings",
    note: "Heat finishes and discards across the series.",
  },
  {
    name: "Techno 293",
    href: "/sg/techno293",
    tagline: "One Design series standings",
    note: "Southwest Monsoon series and race scorecards.",
  },
  {
    name: "iQFOiL",
    href: "/sg/iqfoil",
    tagline: "Published regatta results",
    note: "Normalized class sheets, sailor results, and race scores.",
  },
] as const;

export default async function HomePage() {
  const totals = await getLandingTotals();
  const stats = [
    { value: "7", label: "Class standings available" },
    { value: totals.athletes, label: "Athletes tracked" },
    { value: totals.regattas, label: "Regatta results on record" },
    { value: "Reviewed", label: "Imported race results" },
  ] as const;
  return (
    <div className="bg-sailcloth text-charcoal">

      {/* ── Hero ────────────────────────────────────────────────────────── */}
      <section className="border-b border-cool-veil">
        <div className="mx-auto max-w-3xl px-4 py-14 text-center sm:px-6 sm:py-20 lg:py-24">
          <div className="mx-auto mb-6 inline-block max-w-full rounded-full border border-cool-veil bg-warm-white px-3.5 py-1.5 text-xs font-medium text-balance text-harbour-shadow shadow-xs">
            Sailing results, class standings &amp; sailor profiles
          </div>

          <h1 className="text-[2rem] sm:text-4xl md:text-5xl lg:text-[3.75rem] font-bold leading-[1.12] text-harbour-shadow tracking-tight">
            Singapore sailing,{" "}
            <span className="sm:whitespace-nowrap inline-block">
              tracked{" "}
              <span className="text-racing-orange">race by race.</span>
            </span>
          </h1>

          <p className="mx-auto mt-5 max-w-xl text-[15px] sm:text-lg leading-relaxed text-slate-soft">
            Follow class results and Singapore standings, plan your next
            regatta, and keep your sailing record in one place.
          </p>

          <div className="mt-8 flex flex-col items-center justify-center gap-3 sm:flex-row">
            <Link
              href="/search"
              className="sp-primary inline-flex min-h-12 w-full sm:w-auto items-center justify-center gap-2 px-8 text-[15px] font-semibold"
            >
              Find your profile
            </Link>
            <Link href="/calendar" className="sp-secondary inline-flex min-h-12 w-full sm:w-auto items-center justify-center gap-2 px-6 text-[15px] font-semibold">
              <CalendarDays className="h-4 w-4" aria-hidden />
              Browse regattas
            </Link>
          </div>

          <div className="mt-5 flex flex-wrap justify-center gap-x-5 gap-y-2 text-[13px] sm:text-sm text-slate-soft">
            {["Free to use", "No credit card", "Results from published race records"].map(
              (item) => (
                <span key={item} className="inline-flex items-center gap-1.5">
                  <Check className="h-4 w-4 text-harbour shrink-0" aria-hidden />
                  {item}
                </span>
              )
            )}
          </div>

          <form action="/search" className="relative mx-auto mt-6 max-w-lg w-full">
            <input
              type="search"
              name="query"
              enterKeyHint="search"
              aria-label="Search sailors and regattas"
              placeholder="Name, sail number, club, or regatta"
              className="w-full min-w-0 rounded-full border border-cool-veil bg-warm-white py-3 sm:py-3.5 pl-4 sm:pl-6 pr-14 text-sm sm:text-base text-charcoal shadow-sm placeholder:text-slate-soft focus:border-harbour focus:outline-none"
            />
            <button
              type="submit"
              aria-label="Search"
              className="absolute right-1.5 sm:right-2 top-1/2 flex h-9 w-9 sm:h-10 sm:w-10 -translate-y-1/2 items-center justify-center rounded-full bg-racing-orange text-white transition-colors hover:bg-racing-deep cursor-pointer"
            >
              <Search className="h-4 w-4" aria-hidden />
            </button>
          </form>
        </div>
      </section>


      {/* ── Stats ───────────────────────────────────────────────────────── */}
      <section className="bg-sailcloth py-8 sm:py-10">
        <div className="mx-auto max-w-7xl px-4 sm:px-6 lg:px-8">
          <dl className="grid grid-cols-2 gap-3 sm:gap-4 lg:grid-cols-4">
            {stats.map(({ value, label }) => (
              <div key={label} className="sp-card px-4 py-5 sm:px-6 sm:py-6 lg:px-8">
                <dt className="text-2xl font-bold tabular-nums text-harbour-shadow sm:text-3xl lg:text-4xl">
                  {value}
                </dt>
                <dd className="mt-1.5 text-xs sm:text-sm text-slate-soft leading-snug">{label}</dd>
              </div>
            ))}
          </dl>
        </div>
      </section>


      {/* ── Class hubs ──────────────────────────────────────────────────── */}
      <section className="bg-warm-white py-12 sm:py-16">
        <div className="mx-auto max-w-7xl px-4 sm:px-6 lg:px-8">
          <div className="max-w-2xl">
            <p className="text-xs font-medium uppercase tracking-[0.04em] text-harbour">
              Jump to your class
            </p>
            <h2 className="mt-3 text-2xl font-semibold leading-8 text-charcoal">
              Class standings
            </h2>
            <p className="mt-3 text-base leading-6 text-slate-soft">
              Optimist through ILCA 7, WingFoil, and Techno 293. Each class keeps its own scoring.
            </p>
          </div>
          <div className="mt-8 grid gap-4 sm:grid-cols-2 lg:grid-cols-3">
            {classHubs.map((item) => (
              <Link
                key={item.name}
                href={item.href}
                className="group rounded-xl border border-cool-veil bg-sailcloth p-5 transition-colors hover:border-reef-line hover:bg-aqua-mist"
              >
                <Trophy className="h-5 w-5 text-harbour" aria-hidden />
                <h3 className="mt-4 text-base font-semibold text-charcoal">
                  {item.name}
                </h3>
                <p className="mt-1 text-sm font-medium text-harbour">{item.tagline}</p>
                <p className="mt-2 text-sm leading-5 text-slate-soft">{item.note}</p>
                <ArrowRight
                  className="mt-4 h-4 w-4 text-harbour transition-transform group-hover:translate-x-1"
                  aria-hidden
                />
              </Link>
            ))}
          </div>
        </div>
      </section>

      <section className="bg-sailcloth px-4 py-10 sm:px-6">
        <div className="mx-auto max-w-3xl rounded-xl border border-cool-veil bg-warm-white p-6 sm:p-8">
          <h2 className="text-xl font-semibold text-harbour-shadow">One weekend. Every class result.</h2>
          <p className="mt-3 text-sm leading-6 text-slate-soft">
            Browse upcoming and past regattas together, filter by class, region or year,
            and open the results for the fleet you follow. Singapore national ranking
            eligibility is shown on Optimist, ILCA 4 and ILCA 6 class results.
          </p>
          <p className="mt-3 text-sm leading-6 text-slate-soft">
            Results are added after review. Check the organiser&apos;s official notices
            for entries, eligibility and final decisions.
          </p>
          <Link href="/about" className="mt-4 inline-flex items-center gap-2 text-sm font-semibold text-harbour hover:underline">
            About SailorPath <ArrowRight className="h-4 w-4" aria-hidden />
          </Link>
        </div>
      </section>

      {/* ── Role segmentation ───────────────────────────────────────────── */}
      <section className="border-y border-cool-veil bg-sailcloth py-12 sm:py-16">
        <div className="mx-auto max-w-7xl px-4 sm:px-6 lg:px-8">
          <div className="mb-10 max-w-2xl">
            <h2 className="text-2xl font-semibold leading-8 text-charcoal">
              Whether you race, parent, or coach
            </h2>
            <p className="mt-3 text-base leading-6 text-slate-soft">
              Find the results and tools that matter to your sailing journey.
            </p>
          </div>

          <div className="grid gap-5 sm:grid-cols-3">

            {/* For sailors */}
            <article className="sp-card flex flex-col p-6">
              <span className="inline-flex h-9 w-9 items-center justify-center rounded-lg bg-aqua-mist text-harbour">
                <UserRound className="h-5 w-5" aria-hidden />
              </span>
              <h3 className="mt-5 text-base font-semibold text-charcoal">For sailors</h3>
              <p className="mt-1 text-sm font-medium text-harbour">
                Own your sailing journey
              </p>
              <p className="mt-2 flex-1 text-sm leading-6 text-slate-soft">
                Bring your published results, ranking history and sailing
                milestones together on your profile.
              </p>
              <Link
                href="/search"
                className="sp-primary mt-5 inline-flex min-h-10 w-full items-center justify-center gap-2 px-4 text-sm font-semibold"
              >
                Find and claim your profile
              </Link>
            </article>

            {/* For parents */}
            <article className="sp-card flex flex-col p-6">
              <span className="inline-flex h-9 w-9 items-center justify-center rounded-lg bg-aqua-mist text-harbour">
                <UsersRound className="h-5 w-5" aria-hidden />
              </span>
              <h3 className="mt-5 text-base font-semibold text-charcoal">For parents</h3>
              <p className="mt-1 text-sm font-medium text-harbour">
                Keep progress in one view
              </p>
              <p className="mt-2 flex-1 text-sm leading-6 text-slate-soft">
                Selection trials, national ranking, upcoming races and coach
                debriefs.
              </p>
              <Link
                href="/parent"
                className="sp-secondary mt-5 inline-flex min-h-10 w-full items-center justify-center gap-2 px-4 text-sm font-semibold"
              >
                Open parent dashboard
                <ArrowRight className="h-4 w-4" aria-hidden />
              </Link>
            </article>

            {/* For coaches */}
            <article className="sp-card flex flex-col p-6">
              <span className="inline-flex h-9 w-9 items-center justify-center rounded-lg bg-aqua-mist text-harbour">
                <ChartNoAxesColumnIncreasing className="h-5 w-5" aria-hidden />
              </span>
              <h3 className="mt-5 text-base font-semibold text-charcoal">For coaches</h3>
              <p className="mt-1 text-sm font-medium text-harbour">
                Keep your squad in one view
              </p>
              <p className="mt-2 flex-1 text-sm leading-6 text-slate-soft">
                Private roster, pulse indicators and side-by-side sailor
                comparisons.
              </p>
              <Link
                href="/coach-tools"
                className="sp-secondary mt-5 inline-flex min-h-10 w-full items-center justify-center gap-2 px-4 text-sm font-semibold"
              >
                Open coach dashboard
                <ArrowRight className="h-4 w-4" aria-hidden />
              </Link>
            </article>

          </div>
        </div>
      </section>

      {/* ── Search ──────────────────────────────────────────────────────── */}
      <section className="bg-warm-white py-14 sm:py-20">
        <div className="mx-auto grid max-w-7xl gap-8 px-4 sm:px-6 lg:grid-cols-[0.8fr_1.2fr] lg:px-8">
          <div>
            <p className="text-xs font-medium uppercase tracking-[0.04em] text-harbour">
              Start with what you need
            </p>
            <h2 className="mt-3 text-2xl font-semibold leading-8">
              Find a sailor or regatta
            </h2>
            <p className="mt-3 max-w-md text-base leading-6 text-slate-soft">
              Search by name, sail number or club. Claiming a profile adds private
              tools while public results remain easy to follow.
            </p>
          </div>
          <div className="sp-card p-5 sm:p-7">
            <form action="/search" className="relative">
              <Search
                className="pointer-events-none absolute left-4 top-1/2 h-5 w-5 -translate-y-1/2 text-harbour"
                aria-hidden
              />
              <input
                type="search"
                name="query"
                enterKeyHint="search"
                aria-label="Search sailors and regattas"
                placeholder="Name, sail number, or club"
                className="min-h-12 w-full min-w-0 rounded-lg border border-cool-mist bg-warm-white py-3 pl-12 pr-28 text-base text-charcoal placeholder:text-slate-soft focus:border-harbour focus:outline-none"
              />
              <button
                type="submit"
                className="absolute right-1.5 top-1.5 min-h-9 rounded-md bg-harbour px-4 text-sm font-semibold text-sailcloth hover:bg-harbour-shadow"
              >
                Search
              </button>
            </form>
            <div className="mt-5 grid gap-3 border-t border-cool-veil pt-5 sm:grid-cols-3">
              <Link
                href="/calendar"
                className="sp-secondary inline-flex items-center justify-center gap-2 px-4 py-2.5 text-sm font-semibold"
              >
                <CalendarDays className="h-4 w-4" aria-hidden />
                Regattas &amp; results
              </Link>
              <Link
                href="/sg/optimist/selection"
                className="sp-secondary inline-flex items-center justify-center gap-2 px-4 py-2.5 text-sm font-semibold"
              >
                <ShieldCheck className="h-4 w-4" aria-hidden />
                Selection trials
              </Link>
              <Link
                href="/sample"
                className="sp-secondary inline-flex items-center justify-center gap-2 px-4 py-2.5 text-sm font-semibold"
              >
                <UserRound className="h-4 w-4" aria-hidden />
                View a sample profile
              </Link>
            </div>
          </div>
        </div>
      </section>

    </div>
  );
}
