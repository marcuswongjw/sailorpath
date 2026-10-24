import type { Metadata } from "next";
import Link from "next/link";
import { RegattaDirectoryLink } from "@/components/regattas/RegattaDirectoryLink";
import { RegattaDirectoryFilters } from "@/components/regattas/RegattaDirectoryFilters";
import { SINGAPORE_REGATTAS_2026 } from "@/lib/calendar/singaporeRegattas2026";
import { getCachedPublicRegattas } from "@/lib/queries";
import {
  directoryFromCalendar,
  directoryFromPublished,
  filterRegattaDirectory,
  mergeRegattaDirectory,
  regattaDirectoryTitle,
  type DirectoryRegatta,
} from "@/lib/regattaDirectory";

type SearchParams = {
  q?: string;
  class?: string;
  year?: string;
  when?: string;
  results?: string;
};

function one(value: string | undefined): string {
  return (value || "").trim();
}

function queryFrom(params: SearchParams) {
  return {
    q: one(params.q),
    boatClass: one(params.class) || "all",
    year: one(params.year) || "all",
    when: one(params.when) || "all",
    results: one(params.results) === "published" ? "published" : "all",
  };
}

export async function generateMetadata({
  searchParams,
}: {
  searchParams: Promise<SearchParams>;
}): Promise<Metadata> {
  const query = queryFrom(await searchParams);
  return {
    title: regattaDirectoryTitle(query),
    description: "Browse upcoming and past sailing regattas, with class, year and venue filters.",
  };
}

export default async function RegattasPage({
  searchParams,
}: {
  searchParams: Promise<SearchParams>;
}) {
  const query = queryFrom(await searchParams);
  let published: DirectoryRegatta[] = [];
  let resultsUnavailable = false;
  try {
    published = directoryFromPublished(await getCachedPublicRegattas());
  } catch {
    resultsUnavailable = true;
  }
  const directory = mergeRegattaDirectory(published, directoryFromCalendar(SINGAPORE_REGATTAS_2026));
  const visible = filterRegattaDirectory(directory, query);
  const retryHref = `/regattas?${new URLSearchParams({ q: query.q, class: query.boatClass, year: query.year, when: query.when, results: query.results })}`;
  const classes = [...new Set(directory.map((row) => row.boatClass).filter((value): value is string => Boolean(value)))].sort((a, b) => a.localeCompare(b));
  const years = [...new Set(directory.map((row) => row.date.slice(0, 4)).filter((year) => /^\d{4}$/.test(year)))].sort((a, b) => b.localeCompare(a));

  return (
    <div className="mx-auto w-full max-w-6xl space-y-7 px-4 py-10 sm:px-6 sm:py-14">
      <header className="max-w-2xl">
        <p className="text-xs font-bold uppercase tracking-[0.16em] text-harbour">Regattas</p>
        <h1 className="mt-2 text-3xl font-black tracking-tight text-harbour-shadow sm:text-4xl">Regatta directory</h1>
        <p className="mt-3 text-base leading-7 text-slate-soft">
          Upcoming and past sailing events. Open an event for its classes and published scorecards.
        </p>
      </header>
      <RegattaDirectoryFilters
        key={JSON.stringify(query)}
        q={query.q}
        boatClass={query.boatClass}
        year={query.year}
        when={query.when}
        results={query.results}
        classes={classes}
        years={years}
      />
      {resultsUnavailable && (
        <div role="status" className="rounded-2xl border border-amber-300 bg-amber-50 p-4 text-sm text-amber-950">
          <p>Published results could not be loaded. Only calendar events are available; this list may be incomplete.</p>
          <a href={retryHref} className="mt-2 inline-flex min-h-11 items-center font-bold underline">Try again</a>
        </div>
      )}
      <div className="flex flex-wrap items-center justify-between gap-3 text-sm">
        <p role="status" className="font-semibold text-charcoal">{visible.length} {visible.length === 1 ? "event" : "events"} shown · {query.when === "upcoming" ? "Soonest first" : "Newest first"}</p>
        <Link href="/regattas" className="inline-flex min-h-11 items-center font-bold text-harbour underline">Clear filters</Link>
      </div>
      <section aria-label="Regattas" className="space-y-3">
        {visible.length ? visible.map((row) => (
          <RegattaDirectoryLink key={row.slug} href={`/regattas/${encodeURIComponent(row.slug)}`} className="block rounded-2xl border border-cool-veil bg-warm-white p-5 transition hover:border-harbour/50 hover:shadow-sm focus-visible:outline-2 focus-visible:outline-harbour">
            <div className="flex flex-wrap items-start justify-between gap-2">
              <div>
                <h2 className="text-lg font-bold text-harbour-shadow">{row.name}</h2>
                <p className="mt-1 text-sm text-slate-soft">
                  {row.date}{row.endDate && row.endDate !== row.date ? ` – ${row.endDate}` : ""} · {row.venue || "Venue pending"}
                </p>
              </div>
              <span className="rounded-full bg-aqua-mist px-2.5 py-1 text-xs font-bold text-harbour">{row.boatClass || "Regatta"}</span>
            </div>
            {row.region && <p className="mt-3 text-sm text-charcoal">{row.region}</p>}
            <p className="mt-3 text-sm font-bold text-harbour">{row.hasPublishedResults ? "Published results →" : "Event details →"}</p>
          </RegattaDirectoryLink>
        )) : (
          <div className="rounded-2xl border border-dashed border-cool-veil p-8 text-center text-sm text-slate-soft">
            No regattas match these filters.
          </div>
        )}
      </section>
    </div>
  );
}
