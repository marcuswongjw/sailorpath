import type { Metadata } from "next";
import Link from "next/link";
import { DbOffline } from "@/components/DbOffline";
import { getCachedPublicRegattas } from "@/lib/queries";
import { findEventSliceForRegattaSlug } from "@/lib/regattaEvents";
import { groupedHubForSlug, savedEventHubForSlug } from "@/lib/regattaEventGroups";

export const metadata: Metadata = { title: "Published results | SailorPath", description: "Browse completed, published sailing scorecards by event, class, region and year." };
export const revalidate = 3600;

type Props = { searchParams: Promise<{ class?: string; region?: string; year?: string; q?: string }> };

function hrefFor(row: Awaited<ReturnType<typeof getCachedPublicRegattas>>[number], all: Awaited<ReturnType<typeof getCachedPublicRegattas>>) {
  const registered = findEventSliceForRegattaSlug(row.slug);
  if (registered) return `/regattas/${registered.event.slug}/results/${registered.slice.key}`;
  const saved = savedEventHubForSlug(row.slug, all) || groupedHubForSlug(row.slug, all);
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
  const q = (filters.q || "").toLowerCase().trim();
  const visible = rows.filter((row) => {
    if (String(row.endDate || row.date).slice(0, 10) >= today) return false;
    if (filters.year && !String(row.date).startsWith(filters.year)) return false;
    if (filters.region && filters.region !== "all" && String(row.region || "Singapore").toLowerCase() !== filters.region.toLowerCase()) return false;
    if (filters.class && filters.class !== "all" && !`${row.boatClass || ""} ${row.division || ""}`.toLowerCase().includes(filters.class.toLowerCase())) return false;
    return !q || `${row.name} ${row.boatClass || ""} ${row.venue || ""}`.toLowerCase().includes(q);
  }).sort((a,b) => String(b.date).localeCompare(String(a.date)));
  return <main className="mx-auto max-w-6xl space-y-7 px-4 py-10 sm:px-6 sm:py-14"><header className="max-w-2xl"><p className="text-xs font-bold uppercase tracking-[0.16em] text-harbour">Results</p><h1 className="mt-2 text-3xl font-black tracking-tight text-harbour-shadow sm:text-4xl">Published scorecards</h1><p className="mt-3 text-base leading-7 text-slate-soft">Completed event scorecards. Every row keeps its event, fleet and source context together.</p></header><form className="grid gap-3 rounded-2xl border border-cool-veil bg-warm-white p-4 sm:grid-cols-4"><input name="q" defaultValue={filters.q} placeholder="Event or venue" className="rounded-xl border border-cool-veil px-3 py-2 text-sm"/><input name="class" defaultValue={filters.class} placeholder="Class or fleet" className="rounded-xl border border-cool-veil px-3 py-2 text-sm"/><input name="year" defaultValue={filters.year} placeholder="Year" className="rounded-xl border border-cool-veil px-3 py-2 text-sm"/><button className="sp-primary rounded-xl px-4 py-2 text-sm font-bold text-white">Filter results</button></form><section aria-label="Published scorecards" className="space-y-3">{visible.length ? visible.map((row) => <Link key={row.id} href={hrefFor(row, rows)} className="block rounded-2xl border border-cool-veil bg-warm-white p-5 transition hover:border-harbour/50 hover:shadow-sm"><div className="flex flex-wrap items-start justify-between gap-2"><div><h2 className="text-lg font-bold text-harbour-shadow">{row.name}</h2><p className="mt-1 text-sm text-slate-soft">{String(row.date).slice(0,10)} · {row.venue || "Venue pending"}</p></div><span className="rounded-full bg-aqua-mist px-2.5 py-1 text-xs font-bold text-harbour">{row.boatClass || row.division || "Scorecard"}</span></div><p className="mt-3 text-sm text-charcoal">{row.totalFleetSize || 0} sailors · {row.raceCount || 0} races · Published result</p></Link>) : <div className="rounded-2xl border border-dashed border-cool-veil p-8 text-center text-sm text-slate-soft">No published scorecards match these filters.</div>}</section></main>;
}
