import { sailingClassDisplayLabel } from "@/lib/classPresentation";
import { PUBLIC_CLASS_HUBS as classHubs } from "@/lib/publicClassHubs";
import { publishedResultClasses } from "@/lib/classRegistry";
import type { Metadata } from "next";
import Link from "next/link";
import { JsonLd } from "@/components/JsonLd";
import { organizationWebsiteJsonLd } from "@/lib/publicSeo";
import { getLandingTotals, getLandingResultCounts } from "@/lib/landingStats";
import { getCachedPublicRegattas } from "@/lib/queries";
import { findEventSliceForRegattaSlug } from "@/lib/regattaEvents";
import { groupedHubForSlug, savedEventHubForSlug } from "@/lib/regattaEventGroups";
import { todayYmdSg } from "@/lib/datesSg";
import { getPublicCalendarData } from "@/lib/calendar/publicCalendar";
import { recentLandingResults, upcomingLandingEvents, landingResultStatus, landingCountry, formatLandingDate } from "@/lib/landingContent";
import { SAMPLE_SAILOR } from "@/lib/sampleProfile";
import type { RegattaRecord } from "@/lib/ranking";
import {
  ArrowRight,
  ChartNoAxesColumnIncreasing,
  CalendarDays,
  Search,
  Trophy,
  UserRound,
  UsersRound,
} from "lucide-react";

const homeTitle = "International Sailing Results & Singapore Standings | SailorPath";
const homeDescription =
  "Explore international sailing results, Singapore class standings, sailor profiles and upcoming regattas, plus the independent Asian & Oceania Optimist Index.";

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
  const candidates = recentLandingResults(publicRegattas, today);
  let counts: Record<string, number> | undefined;
  let upcoming: RegattaRecord[] = [];
  let calendarAvailable = true;
  const [countResult, calendarResult] = await Promise.allSettled([
    getLandingResultCounts(candidates.map((row) => row.id)),
    getPublicCalendarData(),
  ]);
  if (countResult.status === "fulfilled") counts = countResult.value;
  if (calendarResult.status === "fulfilled") upcoming = upcomingLandingEvents(calendarResult.value.allRegattas, today);
  else calendarAvailable = false;
  const latestResults = recentLandingResults(publicRegattas, today, counts).slice(0, 3);
  const countryCount = new Set(publicRegattas.map(landingCountry).filter(Boolean)).size;
  const stats = [
    { value: publicRegattas.length ? String(publishedResultClasses(publicRegattas).length) : "—", label: "classes with results" },
    { value: totals.athletes, label: "sailors" },
    { value: totals.regattas, label: "published result tables" },
    { value: countryCount ? String(countryCount) : "—", label: "countries with results" },
  ] as const;
  return (
    <>
    <JsonLd data={organizationWebsiteJsonLd()} />
    <div className="bg-sailcloth text-charcoal">

      {/* ── Hero ────────────────────────────────────────────────────────── */}
      <section className="border-b border-cool-veil">
        <div className="mx-auto max-w-3xl px-4 py-10 text-center sm:px-6 sm:py-14 lg:py-16">
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
            International race results, Singapore standings and your sailing
            record in one place. Find your next regatta and follow every finish.
          </p>

          <form action="/sailors" role="search" className="mx-auto mt-7 max-w-xl text-left">
            <label htmlFor="home-sailor-search" className="mb-2 block text-sm font-semibold text-harbour-shadow">Find a sailor profile</label>
            <div className="flex flex-col gap-2 sm:flex-row">
              <input
                id="home-sailor-search"
                type="search"
                name="q"
                enterKeyHint="search"
                aria-label="Search sailors"
                placeholder="Sailor name, sail number, or club"
                className="min-h-12 w-full min-w-0 rounded-xl border border-cool-veil bg-warm-white px-4 py-3 text-base text-charcoal shadow-sm placeholder:text-slate-soft focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-harbour"
              />
              <button type="submit" className="sp-primary inline-flex min-h-12 shrink-0 items-center justify-center gap-2 px-5 text-sm font-semibold">
                <Search className="h-4 w-4" aria-hidden />Find a sailor
              </button>
            </div>
            <p className="mt-2 text-xs leading-5 text-slate-soft">Browse results and public profiles for free. No account needed.</p>
          </form>
          <div className="mt-6 flex flex-wrap items-center justify-center gap-x-6 gap-y-3 text-sm font-semibold text-harbour">
            <Link href="/results" className="inline-flex min-h-11 items-center gap-2 hover:underline"><Trophy className="h-4 w-4" aria-hidden />Browse published results<ArrowRight className="h-4 w-4" aria-hidden /></Link>
            <Link href="/rankings" className="inline-flex min-h-11 items-center gap-2 hover:underline">View rankings<ArrowRight className="h-4 w-4" aria-hidden /></Link>
          </div>
        </div>
      </section>


      <section className="bg-warm-white py-12 sm:py-16" aria-labelledby="latest-results-heading">
        <div className="mx-auto max-w-7xl px-4 sm:px-6 lg:px-8">
          <div className="flex flex-wrap items-end justify-between gap-4">
            <div>
              <p className="text-xs font-bold uppercase tracking-[0.16em] text-harbour">Across the fleets</p>
              <h2 id="latest-results-heading" className="mt-2 text-2xl font-semibold text-harbour-shadow">Recent regatta results</h2>
              <p className="mt-2 text-sm leading-6 text-slate-soft">Published scorecards from recent events. Source status is shown on each card.</p>
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
                  <p className="text-xs font-bold uppercase tracking-wide text-harbour">{sailingClassDisplayLabel(row.boatClass) || row.division || "Sailing"} · {formatLandingDate(row.endDate || row.date)}</p>
                  <div className="mt-3 flex flex-wrap gap-2 text-xs font-semibold">
                    <span className="rounded-full bg-aqua-mist px-2.5 py-1 text-harbour">{landingResultStatus(row)}</span>
                    {counts && (counts[row.id] || 0) < row.totalFleetSize && <span className="rounded-full bg-orange-50 px-2.5 py-1 text-orange-900">Partial import</span>}
                    {landingCountry(row) && <span className="rounded-full border border-cool-veil px-2.5 py-1 text-harbour">{landingCountry(row)}</span>}
                  </div>
                  <h3 className="mt-2 text-base font-semibold text-charcoal group-hover:text-harbour">{row.name}</h3>
                  <p className="mt-2 text-sm text-slate-soft">{row.venue || "Venue details"}</p>
                  <p className="mt-3 text-sm font-medium text-charcoal">{counts && counts[row.id] < row.totalFleetSize ? `${counts[row.id]} of ${row.totalFleetSize} entries imported` : `${row.totalFleetSize} entries`} · {row.raceCount} races</p>
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


      <section className="border-y border-cool-veil bg-warm-white px-4 py-12 sm:px-6 sm:py-16" aria-labelledby="upcoming-regattas-heading">
        <div className="mx-auto max-w-7xl">
          <div className="flex flex-wrap items-end justify-between gap-4">
            <div>
              <p className="text-xs font-bold uppercase tracking-[0.16em] text-harbour">Plan your next start</p>
              <h2 id="upcoming-regattas-heading" className="mt-2 text-2xl font-semibold text-harbour-shadow">Upcoming regattas</h2>
              <p className="mt-2 text-sm text-slate-soft">Dates and classes from the calendar. Check the organiser’s latest notice before entering.</p>
            </div>
            <Link href="/calendar" className="inline-flex items-center gap-2 text-sm font-semibold text-harbour hover:underline">View calendar <ArrowRight className="h-4 w-4" aria-hidden /></Link>
          </div>
          {upcoming.length ? <div className="mt-6 grid gap-4 md:grid-cols-3">
            {upcoming.map((event) => <Link key={event.slug} href={`/calendar?q=${encodeURIComponent(event.name)}`} className="rounded-xl border border-cool-veil bg-sailcloth p-5 hover:border-reef-line hover:bg-aqua-mist">
              <p className="flex items-center gap-2 text-sm font-semibold text-harbour"><CalendarDays className="h-4 w-4 shrink-0" aria-hidden />{formatLandingDate(event.date)}{event.endDate && event.endDate !== event.date ? ` – ${formatLandingDate(event.endDate)}` : ""}</p>
              <h3 className="mt-3 text-base font-semibold text-charcoal">{event.name}</h3>
              <p className="mt-2 text-sm text-slate-soft">{event.venue || "Venue to be confirmed"}</p>
              <p className="mt-3 text-sm font-medium text-harbour">{(event.classes?.length ? event.classes : [event.boatClass]).filter(Boolean).join(" · ")}</p>
              <span className="mt-4 inline-flex items-center gap-2 text-sm font-semibold text-harbour">View event in calendar <ArrowRight className="h-4 w-4" aria-hidden /></span>
            </Link>)}
          </div> : <p className="mt-6 rounded-xl border border-dashed border-cool-veil p-5 text-sm text-slate-soft">{calendarAvailable ? "No upcoming events are listed right now. Check the calendar for the full schedule." : "Upcoming events are temporarily unavailable. Please check the calendar again shortly."}</p>}
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

      <section className="bg-warm-white px-4 py-12 sm:px-6 sm:py-16" aria-labelledby="claim-profile-heading">
        <div className="mx-auto grid max-w-6xl items-center gap-8 md:grid-cols-2 md:gap-12">
          <div>
            <p className="text-xs font-bold uppercase tracking-[0.16em] text-harbour">Your record, your next chapter</p>
            <h2 id="claim-profile-heading" className="mt-2 text-2xl font-semibold text-harbour-shadow">From public results to your own sailing logbook</h2>
            <ol className="mt-6 space-y-5">
              {[ ["Find your profile", "Search your name, sail number or club to see your published results."], ["Request access", "Claim as the sailor or request parent access. We review the connection before approving it."], ["Unlock your private tools", "After approval, add race notes, equipment and milestones alongside your results."] ].map(([title, detail], i) => <li key={title} className="flex gap-3"><span className="flex h-7 w-7 shrink-0 items-center justify-center rounded-full bg-aqua-mist text-sm font-bold text-harbour">{i + 1}</span><div><h3 className="text-sm font-semibold text-charcoal">{title}</h3><p className="mt-1 text-sm leading-6 text-slate-soft">{detail}</p></div></li>)}
            </ol>
            <Link href="/sailors" className="sp-primary mt-6 inline-flex min-h-11 items-center gap-2 px-5 text-sm font-semibold">Find and claim your profile <ArrowRight className="h-4 w-4" aria-hidden /></Link>
          </div>
          <div className="rounded-2xl border border-cool-veil bg-sailcloth p-6 sm:p-8">
            <p className="text-xs font-bold uppercase tracking-[0.16em] text-harbour">Sample profile · demonstration data</p>
            <div className="mt-5 flex items-center gap-4"><div className="flex h-14 w-14 shrink-0 items-center justify-center rounded-full bg-aqua-mist text-xl font-bold text-harbour" aria-hidden>KT</div><div><h3 className="text-xl font-semibold text-harbour-shadow">{SAMPLE_SAILOR.name}</h3><p className="mt-1 text-sm text-slate-soft">{SAMPLE_SAILOR.sailNumber} · Optimist / ILCA 4</p></div></div>
            <div className="mt-6 divide-y divide-cool-veil rounded-xl border border-cool-veil bg-warm-white px-4">
              {[ ["Race-by-race results", "Finishes, penalties and discarded scores"], ["Sailing milestones", "Your achievements over time"], ["Private logbook after approval", "Race notes and equipment in one place"] ].map(([label, detail]) => <div key={label} className="py-4"><p className="text-sm font-semibold text-harbour">{label}</p><p className="mt-1 text-xs leading-5 text-slate-soft">{detail}</p></div>)}
            </div>
            <Link href="/sample" className="mt-5 inline-flex items-center gap-2 text-sm font-semibold text-harbour hover:underline">Explore the sample profile <ArrowRight className="h-4 w-4" aria-hidden /></Link>
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
