import { resultCoverageLabel, resultSourceStatus } from "@/lib/resultCardStatus";
import type { Metadata } from "next";
import Link from "next/link";
import { DbOffline } from "@/components/DbOffline";
import { getCachedPublicRegattas } from "@/lib/queries";
import { findEventSliceForRegattaSlug } from "@/lib/regattaEvents";
import { groupedHubForSlug, savedEventHubForSlug } from "@/lib/regattaEventGroups";
import { geographySelectOptions, normalizeGeography } from "@/lib/countries";
import { canonicalBoatClass, resolveSailingClass } from "@/lib/classRegistry";
import { matchesRegattaClass } from "@/lib/calendar/publicRegattas";

export const metadata: Metadata = { title: "Published results | SailorPath", description: "Browse completed, published sailing scorecards by event, country, class and year." };
export const revalidate = 3600;

type Props = { searchParams: Promise<{ class?: string; country?: string; region?: string; year?: string; q?: string }> };

function hrefFor(row: Awaited<ReturnType<typeof getCachedPublicRegattas>>[number], all: Awaited<ReturnType<typeof getCachedPublicRegattas>>) {
  const explicit = savedEventHubForSlug(row.slug, all);
  if (explicit?.fleetKey) return `/regattas/${explicit.event.slug}/results/${explicit.fleetKey}`;
  const registered = findEventSliceForRegattaSlug(row.slug);
  if (registered) return `/regattas/${registered.event.slug}/results/${registered.slice.key}`;
  const saved = groupedHubForSlug(row.slug, all);
  if (saved?.fleetKey) return `/regattas/${saved.event.slug}/results/${saved.fleetKey}`;
  return `/regattas/${encodeURIComponent(row.slug)}`;
}

export default async function ResultsPage({ searchParams }: Props) {
  const filters = await searchParams;
  const today = new Date().toISOString().slice(0, 10);
  let rows: Awaited<ReturnType<typeof getCachedPublicRegattas>> = [];
  try {
    rows = await getCachedPublicRegattas();
  } catch {
    return <DbOffline />;
  }
  const completed = rows.filter(
    (row) => String(row.endDate || row.date).slice(0, 10) < today
  );
  const selectedClass = filters.class && filters.class !== "all"
    ? filters.class.toLowerCase() === "ilca" ? "ilca" : canonicalBoatClass(filters.class)
    : "all";
  const selectedYear = filters.year && filters.year !== "all" ? filters.year : "all";
  const selectedCountry = filters.country && filters.country !== "all"
    ? normalizeGeography(filters.country) || "all"
    : "all";
  const classes = [...new Set([
    ...completed.map((row) => canonicalBoatClass(row.boatClass)).filter(Boolean),
    ...(selectedClass === "all" ? [] : [selectedClass]),
  ])].sort((a, b) => a.localeCompare(b));
  const years = [...new Set([
    ...completed.map((row) => String(row.date).slice(0, 4)).filter((year) => /^\d{4}$/.test(year)),
    ...(selectedYear === "all" ? [] : [selectedYear]),
  ])].sort((a, b) => b.localeCompare(a));
  const countryNames = new Map(geographySelectOptions().map((country) => [country.code, country.name]));
  const countries = [...new Set([
    ...completed.map((row) => normalizeGeography(row.geography)).filter((code): code is string => Boolean(code)),
    ...(selectedCountry === "all" ? [] : [selectedCountry]),
  ])].map((code) => ({ code, name: countryNames.get(code) || code }))
    .sort((a, b) => a.name.localeCompare(b.name));
  const q = (filters.q || "").toLowerCase().trim();
  const visible = completed.filter((row) => {
    if (selectedYear !== "all" && !String(row.date).startsWith(selectedYear)) return false;
    if (selectedCountry !== "all" && normalizeGeography(row.geography) !== selectedCountry) return false;
    if (filters.region && filters.region !== "all" && String(row.region || "Singapore").toLowerCase() !== filters.region.toLowerCase()) return false;
    if (selectedClass !== "all") {
      const matchesClass = selectedClass === "ilca"
        ? matchesRegattaClass(row.boatClass, "ilca")
        : canonicalBoatClass(row.boatClass).toLowerCase() === selectedClass.toLowerCase();
      // Preserve older links that used a fleet or partial class search.
      if (!matchesClass && (resolveSailingClass(selectedClass) || !`${row.boatClass || ""} ${row.division || ""}`.toLowerCase().includes(selectedClass.toLowerCase()))) return false;
    }
    return !q || `${row.name} ${row.boatClass || ""} ${row.venue || ""}`.toLowerCase().includes(q);
  }).sort((a, b) => String(b.date).localeCompare(String(a.date)));

  const controlClassName = "w-full rounded-xl border border-cool-veil bg-white px-3 py-2 text-sm text-charcoal focus-visible:outline-2 focus-visible:outline-harbour";

  return (
    <main className="mx-auto max-w-6xl space-y-7 px-4 py-10 sm:px-6 sm:py-14">
      <header className="max-w-2xl">
        <p className="text-xs font-bold uppercase tracking-[0.16em] text-harbour">Results</p>
        <h1 className="mt-2 text-3xl font-black tracking-tight text-harbour-shadow sm:text-4xl">Published scorecards</h1>
        <p className="mt-3 text-base leading-7 text-slate-soft">Completed event scorecards. Every row keeps its event, fleet and source context together.</p>
      </header>
      <form action="/results" method="get" className="grid items-end gap-3 rounded-2xl border border-cool-veil bg-warm-white p-4 sm:grid-cols-2 lg:grid-cols-5">
        <label className="space-y-1 text-sm font-semibold text-charcoal">
          <span>Search</span>
          <input type="search" name="q" defaultValue={filters.q} placeholder="Event or venue" className={controlClassName} />
        </label>
        <label className="space-y-1 text-sm font-semibold text-charcoal">
          <span>Country</span>
          <select name="country" defaultValue={selectedCountry} className={controlClassName}>
            <option value="all">All countries</option>
            {countries.map((country) => <option key={country.code} value={country.code}>{country.name}</option>)}
          </select>
        </label>
        <label className="space-y-1 text-sm font-semibold text-charcoal">
          <span>Class</span>
          <select name="class" defaultValue={selectedClass} className={controlClassName}>
            <option value="all">All classes</option>
            {classes.map((boatClass) => <option key={boatClass} value={boatClass}>{boatClass === "ilca" ? "ILCA (all)" : boatClass}</option>)}
          </select>
        </label>
        <label className="space-y-1 text-sm font-semibold text-charcoal">
          <span>Year</span>
          <select name="year" defaultValue={selectedYear} className={controlClassName}>
            <option value="all">All years</option>
            {years.map((year) => <option key={year} value={year}>{year}</option>)}
          </select>
        </label>
        {filters.region && filters.region !== "all" && <input type="hidden" name="region" value={filters.region} />}
        <button type="submit" className="sp-primary rounded-xl px-4 py-2 text-sm font-bold text-white">Filter results</button>
      </form>
      <section aria-label="Published scorecards" className="space-y-3">
        {visible.length ? visible.map((row) => (
          <Link key={row.id} href={hrefFor(row, rows)} className="block rounded-2xl border border-cool-veil bg-warm-white p-5 transition hover:border-harbour/50 hover:shadow-sm">
            <div className="flex flex-wrap items-start justify-between gap-2">
              <div>
                <h2 className="text-lg font-bold text-harbour-shadow">{row.name}</h2>
                <p className="mt-1 text-sm text-slate-soft">{String(row.date).slice(0, 10)} · {row.venue || "Venue pending"}</p>
              </div>
              <span className="rounded-full bg-aqua-mist px-2.5 py-1 text-xs font-bold text-harbour">{row.boatClass || row.division || "Scorecard"}</span>
            </div>
            <p className="mt-2 text-xs font-semibold text-harbour">{resultSourceStatus(row)}</p>
            {resultCoverageLabel(row) && <p className="mt-2 text-sm text-charcoal">{resultCoverageLabel(row)}</p>}
            <p className="mt-3 text-sm text-charcoal">{row.totalFleetSize || 0} sailors in source fleet · {row.raceCount || 0} races</p>
          </Link>
        )) : (
          <div className="rounded-2xl border border-dashed border-cool-veil p-8 text-center text-sm text-slate-soft">No published scorecards match these filters.</div>
        )}
      </section>
    </main>
  );
}
