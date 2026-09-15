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
    "Follow Singapore Optimist, ILCA 4, WingFoil and Techno 293 standings, regattas and athlete records.",
};

export const revalidate = 300;

const classes = [
  { name: "Optimist Gold", href: "/sg/optimist/gold", note: "National standings" },
  { name: "Optimist Silver", href: "/sg/optimist/silver", note: "Fleet standings" },
  { name: "ILCA 4", href: "/sg/ilca4", note: "Class standings" },
  { name: "WingFoil", href: "/sg/wingfoil", note: "Series results" },
  { name: "Techno 293", href: "/sg/techno293", note: "Race records" },
] as const;

const benefits = [
  {
    icon: Trophy,
    title: "Standings you can follow",
    copy: "See rankings, race scores and regatta results in one consistent view.",
  },
  {
    icon: ChartNoAxesColumnIncreasing,
    title: "Progress with context",
    copy: "Track results over time without losing the details behind each score.",
  },
  {
    icon: UsersRound,
    title: "Built for the whole team",
    copy: "Give sailors, parents and coaches the view that helps them prepare.",
  },
] as const;

export default function HomePage() {
  return (
    <div className="bg-sailcloth text-charcoal">
      <section className="border-b border-cool-veil">
        <div className="mx-auto grid max-w-7xl gap-10 px-4 py-14 sm:px-6 sm:py-20 lg:grid-cols-[1.05fr_0.95fr] lg:items-center lg:gap-16 lg:px-8 lg:py-24">
          <div>
            <p className="mb-5 text-xs font-medium uppercase tracking-[0.04em] text-harbour">
              Singapore competitive sailing
            </p>
            <h1 className="max-w-3xl text-[2.25rem] font-bold leading-[1.08] text-harbour-shadow sm:text-5xl lg:text-[3.5rem]">
              A clear path through competitive sailing.
            </h1>
            <p className="mt-6 max-w-xl text-base leading-6 text-slate-soft sm:text-lg sm:leading-7">
              Follow standings, understand race results and keep every sailor&apos;s
              progress in one dependable place.
            </p>
            <div className="mt-8 flex flex-col gap-3 sm:flex-row">
              <Link
                href="/search"
                className="sp-primary inline-flex min-h-12 items-center justify-center gap-2 px-6 text-[15px] font-semibold"
              >
                <UserRound className="h-5 w-5" aria-hidden />
                Find a sailor profile
              </Link>
              <Link
                href="/rankings"
                className="sp-secondary inline-flex min-h-12 items-center justify-center gap-2 px-6 text-[15px] font-semibold"
              >
                Explore standings
                <ArrowRight className="h-4 w-4" aria-hidden />
              </Link>
            </div>
            <div className="mt-6 flex flex-wrap gap-x-5 gap-y-2 text-sm text-slate-soft">
              {["Free to use", "No credit card", "Privacy controlled"].map((item) => (
                <span key={item} className="inline-flex items-center gap-1.5">
                  <Check className="h-4 w-4 text-harbour" aria-hidden />
                  {item}
                </span>
              ))}
            </div>
          </div>

          <div className="sp-card overflow-hidden">
            <div className="flex items-center justify-between border-b border-cool-veil bg-harbour px-5 py-4 text-sailcloth">
              <div>
                <p className="text-xs font-medium uppercase tracking-[0.04em] text-soft-aqua">Standings preview</p>
                <h2 className="mt-1 text-lg font-semibold">Optimist Gold Fleet</h2>
              </div>
              <span className="rounded bg-racing-mist px-2 py-1 text-xs font-semibold text-racing-deep">2026</span>
            </div>
            <div className="overflow-x-auto">
              <table className="w-full min-w-[420px] text-left text-sm">
                <thead className="border-b border-cool-veil bg-sailcloth text-xs font-medium uppercase tracking-[0.04em] text-slate-soft">
                  <tr><th className="px-5 py-3">Rank</th><th className="px-3 py-3">Sailor</th><th className="px-3 py-3">Club</th><th className="px-5 py-3 text-right">Points</th></tr>
                </thead>
                <tbody className="divide-y divide-cool-veil bg-warm-white">
                  {[
                    ["1", "Sailor profile", "Singapore", "18"],
                    ["2", "Sailor profile", "Singapore", "24"],
                    ["3", "Sailor profile", "Singapore", "31"],
                    ["4", "Sailor profile", "Singapore", "37"],
                  ].map((row, index) => (
                    <tr key={row[0]} className={index === 0 ? "bg-aqua-mist" : ""}>
                      <td className="px-5 py-3 font-semibold text-harbour">{row[0]}</td>
                      <td className="px-3 py-3 font-medium">{row[1]}</td>
                      <td className="px-3 py-3 text-slate-soft">{row[2]}</td>
                      <td className="px-5 py-3 text-right font-semibold tabular-nums">{row[3]}</td>
                    </tr>
                  ))}
                </tbody>
              </table>
            </div>
            <div className="border-t border-cool-veil bg-warm-white px-5 py-3">
              <Link href="/sg/optimist/gold" className="inline-flex items-center gap-1.5 text-sm font-semibold text-harbour hover:text-harbour-shadow">
                View full standings <ArrowRight className="h-4 w-4" aria-hidden />
              </Link>
            </div>
          </div>
        </div>
      </section>

      <section className="bg-warm-white py-12 sm:py-16">
        <div className="mx-auto max-w-7xl px-4 sm:px-6 lg:px-8">
          <div className="mx-auto max-w-2xl text-center">
            <p className="text-xs font-medium uppercase tracking-[0.04em] text-harbour">Find your fleet</p>
            <h2 className="mt-3 text-2xl font-semibold leading-8 text-charcoal">Current classes and results</h2>
            <p className="mt-3 text-base leading-6 text-slate-soft">Move directly to the standings, series or race records you need.</p>
          </div>
          <div className="mt-8 grid gap-3 sm:grid-cols-2 lg:grid-cols-5">
            {classes.map((item) => (
              <Link key={item.name} href={item.href} className="group rounded-xl border border-cool-veil bg-sailcloth p-5 transition-colors hover:border-reef-line hover:bg-aqua-mist">
                <Trophy className="h-5 w-5 text-harbour" aria-hidden />
                <h3 className="mt-5 text-base font-semibold text-charcoal">{item.name}</h3>
                <p className="mt-1 text-sm text-slate-soft">{item.note}</p>
                <ArrowRight className="mt-4 h-4 w-4 text-harbour transition-transform group-hover:translate-x-1" aria-hidden />
              </Link>
            ))}
          </div>
        </div>
      </section>

      <section className="border-y border-cool-veil bg-aqua-mist py-12 sm:py-16">
        <div className="mx-auto max-w-7xl px-4 sm:px-6 lg:px-8">
          <div className="grid gap-6 md:grid-cols-3">
            {benefits.map(({ icon: Icon, title, copy }) => (
              <article key={title} className="rounded-xl border border-reef-line/40 bg-warm-white p-6">
                <span className="inline-flex h-10 w-10 items-center justify-center rounded-lg bg-aqua-mist text-harbour"><Icon className="h-5 w-5" aria-hidden /></span>
                <h2 className="mt-5 text-lg font-semibold leading-6">{title}</h2>
                <p className="mt-2 text-sm leading-6 text-slate-soft">{copy}</p>
              </article>
            ))}
          </div>
        </div>
      </section>

      <section className="bg-warm-white py-14 sm:py-20">
        <div className="mx-auto grid max-w-7xl gap-8 px-4 sm:px-6 lg:grid-cols-[0.8fr_1.2fr] lg:px-8">
          <div>
            <p className="text-xs font-medium uppercase tracking-[0.04em] text-harbour">Start with what you need</p>
            <h2 className="mt-3 text-2xl font-semibold leading-8">Search every sailor and result</h2>
            <p className="mt-3 max-w-md text-base leading-6 text-slate-soft">Search by sailor name, sail number or club. Claiming a profile adds private tools while public results remain easy to follow.</p>
          </div>
          <div className="sp-card p-5 sm:p-7">
            <form action="/search" className="relative">
              <Search className="pointer-events-none absolute left-4 top-1/2 h-5 w-5 -translate-y-1/2 text-harbour" aria-hidden />
              <input type="search" name="query" enterKeyHint="search" aria-label="Search sailors" placeholder="Name, sail number or club" className="min-h-12 w-full rounded-lg border border-cool-mist bg-warm-white py-3 pl-12 pr-28 text-base text-charcoal placeholder:text-slate-soft focus:border-harbour focus:outline-none" />
              <button type="submit" className="absolute right-1.5 top-1.5 min-h-9 rounded-md bg-harbour px-4 text-sm font-semibold text-sailcloth hover:bg-harbour-shadow">Search</button>
            </form>
            <div className="mt-5 grid gap-3 border-t border-cool-veil pt-5 sm:grid-cols-3">
              <Link href="/calendar" className="sp-secondary inline-flex items-center justify-center gap-2 px-4 py-2.5 text-sm font-semibold"><CalendarDays className="h-4 w-4" aria-hidden />Race calendar</Link>
              <Link href="/sg/optimist/selection" className="sp-secondary inline-flex items-center justify-center gap-2 px-4 py-2.5 text-sm font-semibold"><ShieldCheck className="h-4 w-4" aria-hidden />Selection trials</Link>
              <Link href="/sample" className="sp-secondary inline-flex items-center justify-center gap-2 px-4 py-2.5 text-sm font-semibold"><UserRound className="h-4 w-4" aria-hidden />Explore demo</Link>
            </div>
          </div>
        </div>
      </section>
    </div>
  );
}
