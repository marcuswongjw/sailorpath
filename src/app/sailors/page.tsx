import type { Metadata } from "next";
import { SearchClient } from "@/components/search/SearchClient";
import { formatAthleteCount } from "@/lib/landingStats";
import { searchSailorsEnhanced } from "@/lib/search";

export const metadata: Metadata = { title: "Sailor directory | SailorPath", description: "Browse public competition records by sailor name, sail number, club, nationality and class context." };
export const dynamic = "force-dynamic";

type Props = { searchParams: Promise<{ q?: string; query?: string; fleet?: string; club?: string; nationality?: string }> };
export default async function SailorsPage({ searchParams }: Props) {
  const sp = await searchParams;
  const query = (sp.q || sp.query || "").trim();
  const filters = { query, fleet: sp.fleet || "all", club: (sp.club || "").trim(), nationality: (sp.nationality || "").trim(), type: "sailors" as const };
  let sailors = [] as Awaited<ReturnType<typeof searchSailorsEnhanced>>;
  try { sailors = await searchSailorsEnhanced(filters); } catch { sailors = []; }
  const showingAll = !query && filters.fleet === "all" && !filters.club && !filters.nationality && sailors.length >= 10;
  const rosterLabel = showingAll ? `${formatAthleteCount(sailors.length)} sailors. ` : "";
  return <div className="mx-auto w-full max-w-4xl space-y-2 px-3 py-8 sm:px-6 sm:py-12"><header className="mb-6"><p className="text-xs font-bold uppercase tracking-[0.16em] text-harbour">Sailors</p><h1 className="mt-2 text-3xl font-black tracking-tight text-harbour-shadow">Browse sailor records</h1><p className="mt-2 text-sm leading-6 text-slate-soft">{rosterLabel}Search by name, sail number or club to find a sailor and explore their results.</p></header><SearchClient sailorsOnly initialQuery={query} initialFleet={filters.fleet} initialClub={filters.club} initialNationality={filters.nationality} initialSailors={sailors} initialRegattas={[]} /></div>;
}
