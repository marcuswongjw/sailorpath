import type { Metadata } from "next";
import Link from "next/link";
import { JsonLd } from "@/components/JsonLd";
import { organizationWebsiteJsonLd } from "@/lib/publicSeo";
import { getLandingTotals } from "@/lib/landingStats";
import { getCachedPublicRegattas } from "@/lib/queries";
import { findEventSliceForRegattaSlug } from "@/lib/regattaEvents";
import { groupedHubForSlug, savedEventHubForSlug } from "@/lib/regattaEventGroups";
import { todayYmdSg } from "@/lib/datesSg";
import type { RegattaRecord } from "@/lib/ranking";
import {
  ArrowRight,
  ChartNoAxesColumnIncreasing,
  Check,
  Search,
  Trophy,
  UserRound,
  UsersRound,
} from "lucide-react";

const homeTitle = "Singapore Sailing Standings & Athlete Records | SailorPath";
const homeDescription =
  "Browse published sailing scorecards, Singapore class standings, sailor records, upcoming regattas, and the independent Asian & Oceania Optimist Index.";

export const metadata: Metadata = {
  title: homeTitle,
  description: homeDescription,
  alternates: { canonical: "https://sailorpath.com/" },
  openGraph: {
    type: "website",
    url: "https://sailorpath.com/",
    title: homeTitle,
    description: homeDescription,
    siteName: "SailorPath",
  },
};

export const revalidate = 3600;

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

function resultHref(row: RegattaRecord, rows: RegattaRecord[]): string {
  const explicit = savedEventHubForSlug(row.slug, rows);
  if (explicit?.fleetKey) {
    return `/regattas/${explicit.event.slug}/results/${explicit.fleetKey}`;
  }
  const registered = findEventSliceForRegattaSlug(row.slug);
  if (registered) {
    return `/regattas/${registered.event.slug}/results/${registered.slice.key}`;
  }
  const grouped = groupedHubForSlug(row.slug, rows);
  if (grouped?.fleetKey) {
    return `/regattas/${grouped.event.slug}/results/${grouped.fleetKey}`;
  }
  return `/regattas/${encodeURIComponent(row.slug)}`;
}

export default async function HomePage() {
  const totals = await getLandingTotals();
  let publicRegattas: RegattaRecord[] = [];
  try {
    publicRegattas = await getCachedPublicRegattas();
  } catch {
    // Keep the public landing page useful if a transient database read fails.
  }
  const today = todayYmdSg();
  const latestResults = publicRegattas
    .filter((row) => {
      const endDate = String(row.endDate || row.date || "").slice(0, 10);
      return endDate < today && Number(row.totalFleetSize || 0) > 0 && Number(row.raceCount || 0) > 0;
    })
    .sort((a, b) =>
      String(b.endDate || b.date || "").localeCompare(String(a.endDate || a.date || ""))
    )
    .slice(0, 3);
  const stats = [
    { value: String(classHubs.length), label: "classes represented" },
    { value: totals.athletes, label: "sailors" },
    { value: totals.regattas, label: "Regatta results on record" },
    { value: "Reviewed", label: "Imported race results" },
  ] as const;
  return (
    <>
    <JsonLd data={organizationWebsiteJsonLd()} />
    <div className="bg-sailcloth text-charcoal">

      {/* ── Hero ────────────────────────────────────────────────────────── */}
      <section className="border-b border-cool-veil">
        <div className="mx-auto max-w-3xl px-4 py-14 text-center sm:px-6 sm:py-20 lg:py-24">
          <div className="mx-auto mb-6 inline-block max-w-full rounded-full border border-cool-veil bg-warm-white px-3.5 py-1.5 text-xs font-medium text-balance text-harbour-shadow shadow-xs">
            Sailing results, class standings &amp; sailor profiles
          </div>

          <h1 className="text-[2rem] sm:text-4xl md:text-5xl lg:text-[3.75rem] font-bold leading-[1.12] text-harbour-shadow tracking-tight">
            Sailing results and rankings,{" "}
            <span className="sm:whitespace-nowrap inline-block">
              <span className="text-racing-orange">race by race.</span>
            </span>
          </h1>

          <p className="mx-auto mt-5 max-w-xl text-[15px] sm:text-lg leading-relaxed text-slate-soft">
            Follow class results and Singapore standings, plan your next
            regatta, and keep your sailing record in one place.
          </p>

          <div className="mt-8 flex flex-col items-center justify-center gap-3 sm:flex-row">
            <Link
              href="/sailors"
              className="sp-primary inline-flex min-h-12 w-full sm:w-auto items-center justify-center gap-2 px-8 text-[15px] font-semibold"
            >
              Find a sailor profile
            </Link>
            <Link href="/results" className="sp-secondary inline-flex min-h-12 w-full sm:w-auto items-center justify-center gap-2 px-6 text-[15px] font-semibold">
              <Trophy className="h-4 w-4" aria-hidden />
              Browse published results
            </Link>
            <Link href="/rankings" className="text-sm font-semibold text-harbour hover:underline sm:ml-1">
              View rankings
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

          <form action="/sailors" className="relative mx-auto mt-6 max-w-lg w-full">
            <input
              type="search"
              name="query"
              enterKeyHint="search"
              aria-label="Search sailors"
              placeholder="Sailor name, sail number, or club"
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


      <section className="bg-warm-white py-12 sm:py-16" aria-labelledby="latest-results-heading">
        <div className="mx-auto max-w-7xl px-4 sm:px-6 lg:px-8">
          <div className="flex flex-wrap items-end justify-between gap-4">
            <div>
              <p className="text-xs font-bold uppercase tracking-[0.16em] text-harbour">Fresh from the finish line</p>
              <h2 id="latest-results-heading" className="mt-2 text-2xl font-semibold text-harbour-shadow">Latest published results</h2>
              <p className="mt-2 text-sm leading-6 text-slate-soft">Recently completed scorecards, shown after publication and review.</p>
            </div>
            <Link href="/results" className="inline-flex items-center gap-2 text-sm font-semibold text-harbour hover:underline">
              All results <ArrowRight className="h-4 w-4" aria-hidden />
            </Link>
          </div>
          {latestResults.length ? (
            <div className="mt-6 grid gap-4 md:grid-cols-3">
              {latestResults.map((row) => (
                <Link
                  key={row.id}
                  href={resultHref(row, publicRegattas)}
                  className="group rounded-xl border border-cool-veil bg-sailcloth p-5 transition-colors hover:border-reef-line hover:bg-aqua-mist"
                >
                  <p className="text-xs font-bold uppercase tracking-wide text-harbour">{row.boatClass || row.division || "Sailing"} · {String(row.endDate || row.date).slice(0, 10)}</p>
                  <h3 className="mt-2 text-base font-semibold text-charcoal group-hover:text-harbour">{row.name}</h3>
                  <p className="mt-2 text-sm text-slate-soft">{row.venue || "Venue details"}</p>
                  <p className="mt-3 text-sm font-medium text-charcoal">{row.totalFleetSize} sailors · {row.raceCount} races</p>
                  <span className="mt-4 inline-flex items-center gap-2 text-sm font-semibold text-harbour">
                    Open scorecard <ArrowRight className="h-4 w-4 transition-transform group-hover:translate-x-1" aria-hidden />
                  </span>
                </Link>
              ))}
            </div>
          ) : (
            <p className="mt-6 rounded-xl border border-dashed border-cool-veil bg-sailcloth p-6 text-sm text-slate-soft">
              No recent published scorecards to feature right now. Browse all published results to explore the archive.
            </p>
          )}
        </div>
      </section>


      {/* ── Singapore class records ──────────────────────────────────────── */}
      <section className="bg-warm-white py-12 sm:py-16">
        <div className="mx-auto max-w-7xl px-4 sm:px-6 lg:px-8">
          <div className="max-w-2xl">
            <p className="text-xs font-medium uppercase tracking-[0.04em] text-harbour">
              Explore sailing classes
            </p>
            <h2 className="mt-3 text-2xl font-semibold leading-8 text-charcoal">
              Standings &amp; published results
            </h2>
            <p className="mt-3 text-base leading-6 text-slate-soft">
              Browse Singapore class standings and published records, plus the international X-15 class hub.
            </p>
            <Link
              href="/classes"
              className="mt-4 inline-flex items-center gap-2 text-sm font-semibold text-harbour hover:underline"
            >
              Browse all class hubs <ArrowRight className="h-4 w-4" aria-hidden />
            </Link>
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
            <Link
              href="/classes/x-15"
              className="group rounded-xl border border-cool-veil bg-sailcloth p-5 transition-colors hover:border-reef-line hover:bg-aqua-mist"
            >
              <Trophy className="h-5 w-5 text-harbour" aria-hidden />
              <h3 className="mt-4 text-base font-semibold text-charcoal">X-15</h3>
              <p className="mt-1 text-sm font-medium text-harbour">International class hub</p>
              <p className="mt-2 text-sm leading-5 text-slate-soft">
                Follow the event calendar and source-linked class context.
              </p>
              <ArrowRight
                className="mt-4 h-4 w-4 text-harbour transition-transform group-hover:translate-x-1"
                aria-hidden
              />
            </Link>
          </div>
        </div>
      </section>

      <section className="bg-sailcloth px-4 py-10 sm:px-6">
        <div className="mx-auto max-w-3xl rounded-xl border border-cool-veil bg-warm-white p-6 sm:p-8">
          <p className="text-xs font-bold uppercase tracking-[0.16em] text-harbour">Independent index · V1 beta</p>
          <h2 className="mt-2 text-xl font-semibold text-harbour-shadow">Asian &amp; Oceania Optimist Index</h2>
          <p className="mt-3 text-sm leading-6 text-slate-soft">
            Explore an independent analytical index built from verified results, with live beta standings and a published methodology. It is not an official IODA or national-federation ranking.
          </p>
          <div className="mt-4 flex flex-wrap gap-x-5 gap-y-2">
            <Link href="/optimist/asian-index" className="inline-flex items-center gap-2 text-sm font-semibold text-harbour hover:underline">
              Explore the index <ArrowRight className="h-4 w-4" aria-hidden />
            </Link>
            <Link href="/optimist/asian-index/methodology" className="text-sm font-semibold text-harbour hover:underline">
              Read the methodology
            </Link>
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
                href="/sailors"
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
              <span className="mt-2 w-fit rounded-full bg-aqua-mist px-2.5 py-1 text-[11px] font-bold text-harbour">Private workspace · sign-in required</span>
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
                Explore parent tools
                <ArrowRight className="h-4 w-4" aria-hidden />
              </Link>
            </article>

            {/* For coaches */}
            <article className="sp-card flex flex-col p-6">
              <span className="inline-flex h-9 w-9 items-center justify-center rounded-lg bg-aqua-mist text-harbour">
                <ChartNoAxesColumnIncreasing className="h-5 w-5" aria-hidden />
              </span>
              <h3 className="mt-5 text-base font-semibold text-charcoal">For coaches</h3>
              <span className="mt-2 w-fit rounded-full bg-aqua-mist px-2.5 py-1 text-[11px] font-bold text-harbour">Private workspace · sign-in required</span>
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
                Explore coach tools
                <ArrowRight className="h-4 w-4" aria-hidden />
              </Link>
            </article>

          </div>
        </div>
      </section>

    </div>
    </>
  );
}
