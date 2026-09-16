import type { Metadata } from "next";
import Link from "next/link";
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
  title: "Singapore Sailing Standings, Calendar & Athlete Records | SailorPath",
  description:
    "Official Singapore Optimist, ILCA 4, WingFoil and Techno 293 standings, selection trials and athlete records — updated from SSF results after every scored race.",
};

export const revalidate = 300;

const classHubs = [
  {
    name: "Optimist Class",
    href: "/sg/optimist/gold",
    tagline: "Gold & Silver fleet series rankings",
    note: "National ranking updated after every scored regatta.",
  },
  {
    name: "ILCA 4 Class",
    href: "/sg/ilca4",
    tagline: "National high points ranking",
    note: "Dual sail numbers and year-on-year progression in one record.",
  },
  {
    name: "WingFoil Class",
    href: "/sg/wingfoil",
    tagline: "Sprint slalom event standings",
    note: "Heat-by-heat finishes and discards across the Grand Prix series.",
  },
  {
    name: "Techno 293 Class",
    href: "/sg/techno293",
    tagline: "One Design windsurfing",
    note: "Southwest Monsoon Grand Prix standings and race scorecards.",
  },
] as const;

const stats = [
  { value: "3", label: "National classes live" },
  { value: "150+", label: "Athletes tracked" },
  { value: "40+", label: "Regattas on the calendar" },
  { value: "Live", label: "Standings after each scored race" },
] as const;

export default function HomePage() {
  return (
    <div className="bg-sailcloth text-charcoal">

      {/* ── Hero ────────────────────────────────────────────────────────── */}
      <section className="border-b border-cool-veil">
        <div className="mx-auto max-w-3xl px-4 py-14 text-center sm:px-6 sm:py-20 lg:py-24">
          <div className="mb-6 inline-flex items-center rounded-full border border-cool-veil bg-warm-white px-3.5 py-1.5 text-xs font-medium text-harbour-shadow shadow-xs">
            Official Singapore Sailing standings &amp; athlete records
          </div>

          <h1 className="text-[2.5rem] font-bold leading-[1.08] text-harbour-shadow sm:text-5xl lg:text-[3.75rem]">
            Singapore sailing,{" "}
            <span className="whitespace-nowrap">
              tracked{" "}
              <span className="text-racing-orange">race by race.</span>
            </span>
          </h1>

          <p className="mx-auto mt-6 max-w-xl text-base leading-6 text-slate-soft sm:text-lg sm:leading-7">
            If you or your child sails in Singapore &mdash; get the latest
            results, standings, selection trial status, and relevant tools here.
          </p>

          <div className="mt-8">
            <Link
              href="/search"
              className="sp-primary inline-flex min-h-12 items-center justify-center gap-2 px-8 text-[15px] font-semibold"
            >
              Find your profile
            </Link>
          </div>

          <div className="mt-4 flex flex-wrap justify-center gap-x-5 gap-y-2 text-sm text-slate-soft">
            {["Free to use", "No credit card", "Data from official SSF results"].map(
              (item) => (
                <span key={item} className="inline-flex items-center gap-1.5">
                  <Check className="h-4 w-4 text-harbour" aria-hidden />
                  {item}
                </span>
              )
            )}
          </div>

          <form action="/search" className="relative mx-auto mt-6 max-w-lg">
            <input
              type="search"
              name="query"
              enterKeyHint="search"
              aria-label="Search sailors"
              placeholder="Search by name, sail number, or club..."
              className="w-full rounded-full border border-cool-veil bg-warm-white py-3.5 pl-6 pr-14 text-base text-charcoal shadow-sm placeholder:text-slate-soft focus:border-harbour focus:outline-none"
            />
            <button
              type="submit"
              aria-label="Search"
              className="absolute right-2 top-1/2 flex h-10 w-10 -translate-y-1/2 items-center justify-center rounded-full bg-racing-orange text-white transition-colors hover:bg-racing-deep"
            >
              <Search className="h-4 w-4" aria-hidden />
            </button>
          </form>
        </div>
      </section>


      {/* ── Stats ───────────────────────────────────────────────────────── */}
      <section className="bg-sailcloth py-8 sm:py-10">
        <div className="mx-auto max-w-7xl px-4 sm:px-6 lg:px-8">
          <dl className="grid grid-cols-2 gap-4 lg:grid-cols-4">
            {stats.map(({ value, label }) => (
              <div key={label} className="sp-card px-6 py-6 sm:px-8">
                <dt className="text-3xl font-bold tabular-nums text-harbour-shadow sm:text-4xl">
                  {value}
                </dt>
                <dd className="mt-2 text-sm text-slate-soft">{label}</dd>
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
              Official sailing class
            </h2>
            <p className="mt-3 text-base leading-6 text-slate-soft">
              Every class follows its rules and scoring system.
            </p>
          </div>
          <div className="mt-8 grid gap-4 sm:grid-cols-2 lg:grid-cols-4">
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
                <ArrowRight
                  className="mt-4 h-4 w-4 text-harbour transition-transform group-hover:translate-x-1"
                  aria-hidden
                />
              </Link>
            ))}
          </div>
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
              There&apos;s a view built for you. One orange action per view.
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
                One continuous record across your career &mdash; ranking, history
                and milestones.
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
                Keep your squad in one live view
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
              Find any sailor in Singapore
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
                aria-label="Search sailors"
                placeholder="Name, sail number or club"
                className="min-h-12 w-full rounded-lg border border-cool-mist bg-warm-white py-3 pl-12 pr-28 text-base text-charcoal placeholder:text-slate-soft focus:border-harbour focus:outline-none"
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
                Race calendar
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
