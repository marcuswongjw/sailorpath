import type { Metadata } from "next";
import Link from "next/link";
import { SearchFilters } from "@/components/search/SearchFilters";
import { unifiedSearch, type RegattaSearchResult, type SailorSearchResult } from "@/lib/search";
import { formatSailNumber } from "@/lib/countries";

type SearchParams = {
  q?: string;
  query?: string;
  fleet?: string;
  club?: string;
  nationality?: string;
};

function one(value: string | undefined): string {
  return (value || "").trim();
}

function queryFrom(params: SearchParams) {
  return {
    q: one(params.q) || one(params.query),
    fleet: one(params.fleet) || "all",
    club: one(params.club),
    nationality: one(params.nationality),
  };
}

function searchPageTitle(q: string): string {
  const query = q.trim();
  return query ? `Search “${query.slice(0, 80)}” | SailorPath` : "Search sailors and regattas | SailorPath";
}

export async function generateMetadata({
  searchParams,
}: {
  searchParams: Promise<SearchParams>;
}): Promise<Metadata> {
  const { q } = queryFrom(await searchParams);
  return {
    title: searchPageTitle(q),
    description: "Search public sailor records and published regattas by name, sail number, club or nationality.",
  };
}

export default async function SearchPage({
  searchParams,
}: {
  searchParams: Promise<SearchParams>;
}) {
  const query = queryFrom(await searchParams);
  let sailors: SailorSearchResult[] = [];
  let regattas: RegattaSearchResult[] = [];
  try {
    const result = await unifiedSearch(query.q, {
      fleet: query.fleet,
      club: query.club,
      nationality: query.nationality,
      limit: 60,
    });
    sailors = result.sailors;
    regattas = result.regattas;
  } catch {
    sailors = [];
    regattas = [];
  }

  return (
    <div className="mx-auto w-full max-w-6xl space-y-7 px-4 py-10 sm:px-6 sm:py-14">
      <header className="max-w-2xl">
        <p className="text-xs font-bold uppercase tracking-[0.16em] text-harbour">Search</p>
        <h1 className="mt-2 text-3xl font-black tracking-tight text-harbour-shadow sm:text-4xl">
          {query.q ? `Results for “${query.q}”` : "Search sailors and regattas"}
        </h1>
        <p className="mt-3 text-base leading-7 text-slate-soft">
          Public sailor records and published events. Filters run on the server, so the list is in the page itself.
        </p>
      </header>
      <SearchFilters q={query.q} fleet={query.fleet} club={query.club} nationality={query.nationality} />
      <section aria-label="Sailors" className="space-y-3">
        <h2 className="text-xs font-bold uppercase tracking-[0.16em] text-slate-soft">Sailors ({sailors.length})</h2>
        {sailors.length ? sailors.map((sailor) => (
          <Link key={sailor.id} href={`/sailors/${encodeURIComponent(sailor.handle)}`} className="block rounded-2xl border border-cool-veil bg-warm-white p-5 transition hover:border-harbour/50">
            <h3 className="text-lg font-bold text-harbour-shadow">{sailor.name}</h3>
            <p className="mt-1 text-sm text-slate-soft">
              {[formatSailNumber(sailor.sailNumber, sailor.nationality), sailor.club, sailor.nationality, sailor.activeFleet].filter(Boolean).join(" · ")}
            </p>
          </Link>
        )) : (
          <p className="rounded-2xl border border-dashed border-cool-veil p-6 text-sm text-slate-soft">No sailors match this search.</p>
        )}
      </section>
      <section aria-label="Regattas" className="space-y-3">
        <h2 className="text-xs font-bold uppercase tracking-[0.16em] text-slate-soft">Regattas ({regattas.length})</h2>
        {regattas.length ? regattas.map((regatta) => (
          <Link key={regatta.id} href={regatta.href} className="block rounded-2xl border border-cool-veil bg-warm-white p-5 transition hover:border-harbour/50">
            <h3 className="text-lg font-bold text-harbour-shadow">{regatta.name}</h3>
            <p className="mt-1 text-sm text-slate-soft">
              {[regatta.date, regatta.venue, regatta.boatClass].filter(Boolean).join(" · ")}
            </p>
          </Link>
        )) : (
          <p className="rounded-2xl border border-dashed border-cool-veil p-6 text-sm text-slate-soft">No regattas match this search.</p>
        )}
      </section>
    </div>
  );
}
