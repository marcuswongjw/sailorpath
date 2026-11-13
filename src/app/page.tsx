import { publishedResultClasses } from "@/lib/classRegistry";
import type { Metadata } from "next";
import Image from "next/image";
import Link from "next/link";
import { JsonLd } from "@/components/JsonLd";
import { organizationWebsiteJsonLd } from "@/lib/publicSeo";
import { getLandingTotals, getLandingResultCounts } from "@/lib/landingStats";
import { getCachedPublicRegattas } from "@/lib/queries";
import { findEventSliceForRegattaSlug } from "@/lib/regattaEvents";
import { groupedHubForSlug, savedEventHubForSlug } from "@/lib/regattaEventGroups";
import { todayYmdSg } from "@/lib/datesSg";
import {
  recentLandingResults,
  distinctRecentLandingResults,
  landingAdditionalFleetCount,
  landingRegattaName,
  landingResultStatus,
  landingCountry,
  formatLandingDate,
} from "@/lib/landingContent";
import { formatNewsDate, listPublishedNews, type PublishedNewsArticle } from "@/lib/news";
import { SAMPLE_SAILOR } from "@/lib/sampleProfile";
import type { RegattaRecord } from "@/lib/ranking";
import {
  ArrowRight,
  ChartNoAxesColumnIncreasing,
  Newspaper,
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
  let latestUpdates: PublishedNewsArticle[] = [];
  const [countResult, newsResult] = await Promise.allSettled([
    getLandingResultCounts(candidates.map((row) => row.id)),
    listPublishedNews(),
  ]);
  if (countResult.status === "fulfilled") counts = countResult.value;
  if (newsResult.status === "fulfilled") latestUpdates = newsResult.value.slice(0, 3);
  const scoredResults = recentLandingResults(publicRegattas, today, counts);
  const latestResults = distinctRecentLandingResults(publicRegattas, today, counts, 3);
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
        <div className="mx-auto max-w-5xl px-4 py-7 text-center sm:px-6 sm:py-14 lg:py-16">
          <div className="mx-auto mb-4 inline-block max-w-full rounded-full border border-cool-veil bg-warm-white px-3.5 py-1.5 text-xs font-medium text-balance text-harbour-shadow shadow-xs">
            Sailing results, class standings &amp; sailor profiles
          </div>

          <h1 className="mx-auto max-w-3xl text-[2rem] sm:text-4xl md:text-5xl lg:text-[3.75rem] font-bold leading-[1.12] text-harbour-shadow tracking-tight">
            Sailing results and rankings,{" "}
            <span className="sm:whitespace-nowrap inline-block">
              <span className="text-racing-orange">race by race.</span>
            </span>
          </h1>

          <p className="mx-auto mt-3 max-w-xl text-[15px] sm:text-lg leading-relaxed text-slate-soft">
            International race results, Singapore standings and your sailing
            record in one place. Find your next regatta and follow every finish.
          </p>

          <search className="mx-auto mt-5 max-w-xl rounded-2xl border border-cool-veil bg-warm-white p-4 text-left shadow-xs sm:p-5">
            <form action="/sailors" method="GET">
              <label htmlFor="home-sailor-search" className="block text-sm font-semibold text-harbour-shadow">Find a sailor profile</label>
              <p id="home-sailor-search-hint" className="mt-1 mb-2.5 text-xs leading-5 text-slate-soft">Browse results and public profiles for free. No account needed.</p>
              <div className="flex flex-col gap-2.5 sm:flex-row">
                <input
                  id="home-sailor-search"
                  type="search"
                  name="q"
                  enterKeyHint="search"
                  autoCorrect="off"
                  autoCapitalize="off"
                  spellCheck={false}
                  aria-label="Search sailors"
                  aria-describedby="home-sailor-search-hint"
                  placeholder="Sailor name, sail number, or club"
                  className="min-h-12 w-full min-w-0 rounded-xl border border-cool-mist bg-sailcloth/50 px-4 py-3 text-base text-charcoal shadow-2xs transition-colors placeholder:text-slate-soft hover:border-harbour/50 focus:bg-warm-white focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-harbour"
                />
                <button type="submit" className="sp-primary inline-flex min-h-12 shrink-0 items-center justify-center gap-2 px-5 text-sm font-semibold">
                  <Search className="h-4 w-4" aria-hidden="true" />Find a sailor
                </button>
              </div>
            </form>
          </search>

          <div className="mt-4 flex flex-wrap items-center justify-center gap-x-6 gap-y-0 text-sm font-semibold text-harbour">
            <Link href="/results" className="inline-flex min-h-11 items-center gap-2 hover:underline"><Trophy className="h-4 w-4" aria-hidden="true" />Browse published results<ArrowRight className="h-4 w-4" aria-hidden="true" /></Link>
            <Link href="/rankings" className="inline-flex min-h-11 items-center gap-2 hover:underline">View rankings<ArrowRight className="h-4 w-4" aria-hidden="true" /></Link>
          </div>

          <dl className="mt-6 grid grid-cols-2 gap-2 text-left sm:mt-10 sm:gap-4 lg:grid-cols-4">
            {stats.map(({ value, label }) => (
              <div key={label} className="sp-card px-3 py-2 sm:px-5 sm:py-5">
                <dt className="text-2xl font-bold tabular-nums text-harbour-shadow sm:text-3xl">
                  {value}
                </dt>
                <dd className="mt-1 text-xs sm:text-sm text-slate-soft leading-snug">{label}</dd>
              </div>
            ))}
          </dl>
        </div>
      </section>


      <section className="border-b border-cool-veil bg-warm-white py-12 sm:py-16" aria-labelledby="latest-results-heading">
        <div className="mx-auto max-w-7xl px-4 sm:px-6 lg:px-8">
          <div className="flex flex-wrap items-end justify-between gap-4">
            <div>
              <p className="text-xs font-bold uppercase tracking-[0.16em] text-harbour">Across the fleets</p>
              <h2 id="latest-results-heading" className="mt-2 text-2xl font-semibold text-harbour-shadow">Recent regatta results</h2>
              <p className="mt-2 text-sm leading-6 text-slate-soft">Published scorecards from recent events. Source status is shown on each card.</p>
            </div>
            <Link href="/results" className="inline-flex min-h-10 items-center gap-2 text-sm font-semibold text-harbour hover:underline">
              All results <ArrowRight className="h-4 w-4" aria-hidden="true" />
            </Link>
          </div>
          {latestResults.length ? (
            <div className="mt-6 grid gap-4 md:grid-cols-3">
              {latestResults.map((row) => {
                const extraFleets = landingAdditionalFleetCount(row, scoredResults, publicRegattas);
                return (
                  <Link
                    key={row.id}
                    href={resultHref(row, publicRegattas)}
                    className="group flex h-full flex-col justify-between rounded-xl border border-cool-veil bg-sailcloth p-5 transition-all hover:border-reef-line hover:bg-aqua-mist hover:shadow-xs"
                  >
                    <div>
                      <p className="text-xs font-bold uppercase tracking-wide text-harbour">{formatLandingDate(row.endDate || row.date)}</p>
                      <div className="mt-3 flex flex-wrap gap-2 text-xs font-semibold">
                        <span className="rounded-full bg-aqua-mist px-2.5 py-1 text-harbour">{landingResultStatus(row)}</span>
                        {counts && (counts[row.id] || 0) < row.totalFleetSize && <span className="rounded-full bg-orange-50 px-2.5 py-1 text-orange-900">Partial import</span>}
                        {landingCountry(row) && <span className="rounded-full border border-cool-veil bg-warm-white/70 px-2.5 py-1 text-harbour">{landingCountry(row)}</span>}
                        {extraFleets > 0 && (
                          <span className="rounded-full border border-cool-veil bg-warm-white px-2.5 py-1 text-harbour">
                            +{extraFleets} more {extraFleets === 1 ? "fleet" : "fleets"}
                          </span>
                        )}
                      </div>
                      <h3 className="mt-3 text-base font-semibold leading-snug text-charcoal group-hover:text-harbour">{landingRegattaName(row)}</h3>
                      <p className="mt-1.5 text-sm leading-5 text-slate-soft">{row.venue || "Venue details"}</p>
                    </div>
                    <div className="mt-5 border-t border-cool-veil/80 pt-3.5">
                      <p className="text-sm font-medium text-charcoal">{counts && counts[row.id] < row.totalFleetSize ? `${counts[row.id]} of ${row.totalFleetSize} entries imported` : `${row.totalFleetSize} entries`} · {row.raceCount} races</p>
                      <span className="mt-2.5 inline-flex items-center gap-2 text-sm font-semibold text-harbour">
                        Open scorecard <ArrowRight className="h-4 w-4 transition-transform group-hover:translate-x-1" aria-hidden="true" />
                      </span>
                    </div>
                  </Link>
                );
              })}
            </div>
          ) : (
            <p className="mt-6 rounded-xl border border-dashed border-cool-veil bg-sailcloth p-6 text-sm text-slate-soft">
              No recent published scorecards to feature right now. Browse all published results to explore the archive.
            </p>
          )}
        </div>
      </section>


      {/* ── Built for the fleet: Sailors, Parents, Coaches ──────────────── */}
      <section className="border-b border-cool-veil bg-sailcloth py-12 sm:py-16" aria-labelledby="role-segmentation-heading">
        <div className="mx-auto max-w-7xl px-4 sm:px-6 lg:px-8">
          <div className="mb-10 max-w-2xl">
            <p className="text-xs font-bold uppercase tracking-[0.16em] text-harbour">Built for the fleet</p>
            <h2 id="role-segmentation-heading" className="mt-2 text-2xl font-semibold leading-8 text-harbour-shadow">
              Whether you race, parent, or coach
            </h2>
            <p className="mt-2 text-sm leading-6 text-slate-soft">
              Find the results, profiles, and private tools that matter to your sailing journey.
            </p>
          </div>

          <div className="grid gap-6 lg:grid-cols-3">

            {/* For sailors (integrated with sample profile preview) */}
            <article className="sp-card flex flex-col justify-between p-6">
              <div>
                <span className="inline-flex h-10 w-10 items-center justify-center rounded-xl bg-aqua-mist text-harbour">
                  <UserRound className="h-5 w-5" aria-hidden="true" />
                </span>
                <h3 className="mt-5 text-base font-semibold text-charcoal">For sailors</h3>
                <span className="mt-2 inline-block w-fit rounded-full bg-sailcloth px-2.5 py-1 text-[11px] font-bold text-harbour">Public profile · optional claim</span>
                <p className="mt-2 text-sm font-medium text-harbour">
                  Own your sailing journey
                </p>
                <p className="mt-2 text-sm leading-6 text-slate-soft">
                  Bring your published results, ranking history, and milestones together on your profile.
                </p>

                {/* Integrated sample card snippet */}
                <div className="mt-4 rounded-xl border border-cool-veil bg-sailcloth/60 p-3.5">
                  <div className="flex items-center gap-3">
                    <div className="flex h-10 w-10 shrink-0 items-center justify-center rounded-full bg-aqua-mist text-sm font-bold text-harbour" aria-hidden="true">KT</div>
                    <div>
                      <p className="text-xs font-bold text-harbour-shadow">{SAMPLE_SAILOR.name}</p>
                      <p className="text-[11px] text-slate-soft">{SAMPLE_SAILOR.sailNumber} · Sample profile · demonstration data</p>
                    </div>
                  </div>
                  <p className="mt-2.5 text-[11px] leading-relaxed text-slate-soft">
                    Includes race-by-race finishes, discards, scoring codes, and private notes.
                  </p>
                </div>
              </div>

              <div className="mt-6 border-t border-cool-veil/80 pt-4">
                <Link
                  href="/sailors"
                  className="sp-primary inline-flex min-h-10 w-full items-center justify-center gap-2 px-4 text-sm font-semibold"
                >
                  Find and claim your profile
                </Link>
                <Link
                  href="/sample"
                  className="mt-2.5 inline-flex min-h-8 w-full items-center justify-center gap-1.5 text-xs font-semibold text-harbour hover:underline"
                >
                  Explore sample profile <ArrowRight className="h-3.5 w-3.5" aria-hidden="true" />
                </Link>
              </div>
            </article>

            {/* For parents */}
            <article className="sp-card flex flex-col justify-between p-6">
              <div>
                <span className="inline-flex h-10 w-10 items-center justify-center rounded-xl bg-aqua-mist text-harbour">
                  <UsersRound className="h-5 w-5" aria-hidden="true" />
                </span>
                <h3 className="mt-5 text-base font-semibold text-charcoal">For parents</h3>
                <span className="mt-2 inline-block w-fit rounded-full bg-aqua-mist px-2.5 py-1 text-[11px] font-bold text-harbour">Private workspace · sign-in required</span>
                <p className="mt-2 text-sm font-medium text-harbour">
                  Keep progress in one view
                </p>
                <p className="mt-2 text-sm leading-6 text-slate-soft">
                  Selection trials, national ranking, upcoming races, equipment logs, and coach debriefs in one place.
                </p>

                <div className="mt-4 rounded-xl border border-cool-veil bg-sailcloth/60 p-3.5 text-xs">
                  <p className="font-semibold text-harbour">Child profile connection</p>
                  <p className="mt-1 text-[11px] leading-relaxed text-slate-soft">
                    Request access to your sailor&apos;s profile. We verify family connections before approving private logbook tools.
                  </p>
                </div>
              </div>

              <div className="mt-6 border-t border-cool-veil/80 pt-4">
                <Link
                  href="/parent"
                  className="sp-secondary inline-flex min-h-10 w-full items-center justify-center gap-2 px-4 text-sm font-semibold"
                >
                  Explore parent tools
                  <ArrowRight className="h-4 w-4" aria-hidden="true" />
                </Link>
                <Link
                  href="/demo/parent"
                  className="mt-2.5 inline-flex min-h-8 w-full items-center justify-center gap-1.5 text-xs font-semibold text-harbour hover:underline"
                >
                  Try interactive parent demo <ArrowRight className="h-3.5 w-3.5" aria-hidden="true" />
                </Link>
              </div>
            </article>

            {/* For coaches */}
            <article className="sp-card flex flex-col justify-between p-6">
              <div>
                <span className="inline-flex h-10 w-10 items-center justify-center rounded-xl bg-aqua-mist text-harbour">
                  <ChartNoAxesColumnIncreasing className="h-5 w-5" aria-hidden="true" />
                </span>
                <h3 className="mt-5 text-base font-semibold text-charcoal">For coaches</h3>
                <span className="mt-2 inline-block w-fit rounded-full bg-aqua-mist px-2.5 py-1 text-[11px] font-bold text-harbour">Private workspace · sign-in required</span>
                <p className="mt-2 text-sm font-medium text-harbour">
                  Keep your squad in one view
                </p>
                <p className="mt-2 text-sm leading-6 text-slate-soft">
                  Private squad roster, pulse trend indicators, fleet scoring distributions, and head-to-head comparisons.
                </p>

                <div className="mt-4 rounded-xl border border-cool-veil bg-sailcloth/60 p-3.5 text-xs">
                  <p className="font-semibold text-harbour">Squad performance overview</p>
                  <p className="mt-1 text-[11px] leading-relaxed text-slate-soft">
                    Review your squad across all regattas with synchronized finish positions and debrief notes.
                  </p>
                </div>
              </div>

              <div className="mt-6 border-t border-cool-veil/80 pt-4">
                <Link
                  href="/coach-tools"
                  className="sp-secondary inline-flex min-h-10 w-full items-center justify-center gap-2 px-4 text-sm font-semibold"
                >
                  Explore coach tools
                  <ArrowRight className="h-4 w-4" aria-hidden="true" />
                </Link>
                <Link
                  href="/demo/coach"
                  className="mt-2.5 inline-flex min-h-8 w-full items-center justify-center gap-1.5 text-xs font-semibold text-harbour hover:underline"
                >
                  Try interactive coach demo <ArrowRight className="h-3.5 w-3.5" aria-hidden="true" />
                </Link>
              </div>
            </article>

          </div>
        </div>
      </section>


      {/* ── Asian & Oceania Optimist Index ──────────────────────────────── */}
      <section className="border-b border-cool-veil bg-warm-white px-4 py-12 sm:px-6 sm:py-16 lg:px-8" aria-labelledby="asian-index-heading">
        <div className="mx-auto grid max-w-7xl gap-6 rounded-2xl border border-cool-veil bg-sailcloth p-6 shadow-xs sm:p-8 lg:grid-cols-[1.2fr_1fr] lg:items-center">
          <div>
            <p className="text-xs font-bold uppercase tracking-[0.16em] text-harbour">Independent index · V1 beta</p>
            <h2 id="asian-index-heading" className="mt-2 text-2xl font-semibold text-harbour-shadow">Asian &amp; Oceania Optimist Index</h2>
            <p className="mt-3 text-sm leading-6 text-slate-soft">
              Explore an independent analytical index built from verified results, with live beta standings and a published methodology. It is not an official IODA or national-federation ranking.
            </p>
            <div className="mt-5 flex flex-wrap items-center gap-x-5 gap-y-2">
              <Link href="/optimist/asian-index" className="sp-primary inline-flex min-h-10 items-center gap-2 px-4 text-sm font-semibold">
                Explore the index <ArrowRight className="h-4 w-4" aria-hidden="true" />
              </Link>
              <Link href="/optimist/asian-index/methodology" className="inline-flex min-h-10 items-center text-sm font-semibold text-harbour hover:underline">
                Read the methodology
              </Link>
            </div>
          </div>
          <div className="grid gap-2.5 rounded-xl border border-cool-veil bg-warm-white p-4 text-xs sm:grid-cols-3 lg:grid-cols-1">
            <div className="flex flex-col justify-between gap-1.5 rounded-lg border border-cool-veil/60 bg-sailcloth/50 px-3.5 py-3 sm:flex-col lg:flex-row lg:items-center">
              <span className="inline-flex w-fit items-center rounded-md bg-aqua-mist px-2 py-0.5 font-bold text-harbour">Grade 150</span>
              <span className="text-slate-soft">IODA World &amp; Continental Championships</span>
            </div>
            <div className="flex flex-col justify-between gap-1.5 rounded-lg border border-cool-veil/60 bg-sailcloth/50 px-3.5 py-3 sm:flex-col lg:flex-row lg:items-center">
              <span className="inline-flex w-fit items-center rounded-md bg-aqua-mist px-2 py-0.5 font-bold text-harbour">Grade 75</span>
              <span className="text-slate-soft">Designated Major International Opens</span>
            </div>
            <div className="flex flex-col justify-between gap-1.5 rounded-lg border border-cool-veil/60 bg-sailcloth/50 px-3.5 py-3 sm:flex-col lg:flex-row lg:items-center">
              <span className="inline-flex w-fit items-center rounded-md bg-aqua-mist px-2 py-0.5 font-bold text-harbour">Grade 40</span>
              <span className="text-slate-soft">Designated National Championships</span>
            </div>
          </div>
        </div>
      </section>

      {/* ── Latest updates (/news) ──────────────────────────────────────── */}
      {latestUpdates.length > 0 && (
        <section className="bg-sailcloth py-12 sm:py-16" aria-labelledby="latest-updates-heading">
          <div className="mx-auto max-w-7xl px-4 sm:px-6 lg:px-8">
            <div className="flex flex-wrap items-end justify-between gap-4">
              <div>
                <p className="text-xs font-bold uppercase tracking-[0.16em] text-harbour">SailorPath updates</p>
                <h2 id="latest-updates-heading" className="mt-2 text-2xl font-semibold text-harbour-shadow">Latest coverage &amp; release notes</h2>
                <p className="mt-2 text-sm leading-6 text-slate-soft">New championship scorecards, methodology notes and privacy updates.</p>
              </div>
              <Link href="/news" className="inline-flex min-h-10 items-center gap-2 text-sm font-semibold text-harbour hover:underline">
                All updates <ArrowRight className="h-4 w-4" aria-hidden="true" />
              </Link>
            </div>
            <div className="mt-6 grid gap-4 md:grid-cols-3">
              {latestUpdates.map((update) => (
                <article
                  key={update.slug}
                  className="group flex flex-col overflow-hidden rounded-xl border border-cool-veil bg-warm-white transition-all hover:border-reef-line hover:shadow-xs"
                >
                  {update.imageUrl ? (
                    <figure className="border-b border-cool-veil bg-sailcloth">
                      <Link
                        href={`/news/${update.slug}`}
                        tabIndex={-1}
                        aria-hidden="true"
                        className="block overflow-hidden"
                      >
                        <Image
                          src={update.imageUrl}
                          alt={update.imageAlt || update.title}
                          width={800}
                          height={534}
                          loading="lazy"
                          decoding="async"
                          unoptimized
                          className="aspect-video w-full object-cover transition-transform duration-300 group-hover:scale-[1.02]"
                        />
                      </Link>
                      {update.imageCredit ? (
                        <figcaption className="border-t border-cool-veil bg-sailcloth/60 px-4 py-1.5 text-[11px] leading-4 text-slate-soft">
                          {update.imageCredit}
                        </figcaption>
                      ) : null}
                    </figure>
                  ) : null}
                  <div className="flex flex-1 flex-col p-5">
                    <div className="flex flex-wrap items-center gap-2 text-xs font-semibold text-harbour">
                      <Newspaper className="h-3.5 w-3.5 shrink-0" aria-hidden="true" />
                      <time dateTime={update.publishedAt}>{formatNewsDate(update.publishedAt)}</time>
                      <span aria-hidden="true">·</span>
                      <span className="capitalize">{update.kind.replace(/_/g, " ")}</span>
                    </div>
                    <h3 className="mt-3 text-base font-semibold leading-snug text-charcoal">
                      <Link href={`/news/${update.slug}`} className="hover:text-harbour hover:underline">
                        {update.title}
                      </Link>
                    </h3>
                    <p className="mt-2 flex-1 text-sm leading-6 text-slate-soft line-clamp-3">
                      {update.summary}
                    </p>
                    <div className="mt-4 border-t border-cool-veil/80 pt-3.5">
                      <Link
                        href={`/news/${update.slug}`}
                        className="inline-flex items-center gap-1.5 text-sm font-semibold text-harbour hover:underline"
                      >
                        Read update <ArrowRight className="h-4 w-4 transition-transform group-hover:translate-x-1" aria-hidden="true" />
                      </Link>
                    </div>
                  </div>
                </article>
              ))}
            </div>
          </div>
        </section>
      )}

    </div>
    </>
  );
}
