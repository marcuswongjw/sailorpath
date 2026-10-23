import type { Metadata } from "next";
import Form from "next/form";
import Link from "next/link";
import { ArrowLeft, ArrowRight, Search } from "lucide-react";
import { searchSailorsEnhanced } from "@/lib/search";
import { formatSailNumber } from "@/lib/countries";
import { directoryFilters, directoryHref, directoryPage, type SailorDirectoryParams } from "@/lib/sailorDirectory";

export const metadata: Metadata = {
  title: "Sailor directory | SailorPath",
  description: "Browse public competition records by sailor name, sail number, club, nationality and class context.",
};
export const dynamic = "force-dynamic";

const controlClass = "min-h-11 w-full min-w-0 rounded-xl border border-cool-veil bg-white px-3 py-2 text-base text-charcoal focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-harbour";

export default async function SailorsPage({ searchParams }: { searchParams: Promise<SailorDirectoryParams> }) {
  const params = await searchParams;
  const filters = directoryFilters(params);
  let sailors: Awaited<ReturnType<typeof searchSailorsEnhanced>> = [];
  let unavailable = false;
  try {
    sailors = await searchSailorsEnhanced(filters);
  } catch {
    unavailable = true;
  }
  const results = directoryPage(sailors, params.page);
  const filtered = Boolean(filters.query || filters.fleet !== "all" || filters.club || filters.nationality);
  return (
    <div className="mx-auto w-full max-w-4xl space-y-6 px-4 py-8 sm:px-6 sm:py-12">
      <header>
        <p className="text-xs font-bold uppercase tracking-[0.16em] text-harbour">Sailors</p>
        <h1 className="mt-2 text-3xl font-bold tracking-tight text-harbour-shadow">Find a sailor</h1>
        <p className="mt-2 text-sm leading-6 text-slate-soft">Search public sailing records by name, sail number or club. Open a profile to explore race results.</p>
      </header>

      <Form key={directoryHref(filters, results.page)} action="/sailors" role="search" className="space-y-4 rounded-2xl border border-cool-veil bg-warm-white p-4 sm:p-5">
        <div className="grid items-end gap-3 sm:grid-cols-[1fr_10rem_auto]">
          <label className="min-w-0 space-y-1.5 text-sm font-semibold text-charcoal">
            <span>Sailor name, sail number or club</span>
            <input name="q" type="search" defaultValue={filters.query} placeholder="e.g. Mikaela, 3029 or SAFYC" enterKeyHint="search" className={controlClass} />
          </label>
          <label className="space-y-1.5 text-sm font-semibold text-charcoal">
            <span>Fleet</span>
            <select name="fleet" defaultValue={filters.fleet} className={controlClass}>
              <option value="all">All fleets</option>
              <option value="gold">Optimist Gold</option>
              <option value="silver">Optimist Silver</option>
              <option value="ilca">ILCA</option>
              <option value="guest">Outside Singapore fleets</option>
            </select>
          </label>
          <button type="submit" className="sp-primary inline-flex min-h-11 items-center justify-center gap-2 px-5 text-sm font-semibold"><Search className="h-4 w-4" aria-hidden />Search sailors</button>
        </div>
        <details open={Boolean(filters.club || filters.nationality)} className="border-t border-cool-veil pt-3">
          <summary className="w-fit cursor-pointer rounded py-1 text-sm font-semibold text-harbour focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-harbour">More filters{filters.club || filters.nationality ? " · active" : ""}</summary>
          <div className="mt-3 grid gap-3 sm:grid-cols-2">
            <label className="space-y-1.5 text-sm font-semibold text-charcoal"><span>Club</span><input name="club" defaultValue={filters.club} placeholder="e.g. CSC or SAFYC" className={controlClass} /></label>
            <label className="space-y-1.5 text-sm font-semibold text-charcoal"><span>Nationality</span><input name="nationality" defaultValue={filters.nationality} placeholder="e.g. Singapore or SGP" className={controlClass} /></label>
          </div>
        </details>
      </Form>

      {unavailable ? (
        <section role="alert" className="rounded-2xl border border-cool-veil bg-warm-white p-6">
          <h2 className="text-lg font-semibold text-harbour-shadow">Sailor records are temporarily unavailable</h2>
          <p className="mt-2 text-sm leading-6 text-slate-soft">We couldn’t load the directory. Your search and filters are preserved; please try again.</p>
          <a href={directoryHref(filters, Number(params.page))} className="sp-secondary mt-4 inline-flex min-h-11 items-center px-4 text-sm font-semibold">Try again</a>
        </section>
      ) : (
        <section aria-labelledby="sailor-results-heading" className="space-y-4">
          <div className="flex flex-wrap items-center justify-between gap-3">
            <h2 id="sailor-results-heading" className="text-sm font-semibold text-charcoal">{results.total ? `Showing ${results.start}–${results.end} of ${results.total.toLocaleString("en-SG")} ${filtered ? "matching " : ""}sailors` : "No matching sailors"}</h2>
            {filtered && <Link href="/sailors" className="inline-flex min-h-11 items-center text-sm font-semibold text-harbour underline underline-offset-4">Clear search and filters</Link>}
          </div>
          {results.total ? (
            <>
              <ul className="grid gap-3">
                {results.rows.map((sailor) => {
                  const numbers = [formatSailNumber(sailor.sailNumber, sailor.nationality), sailor.sailNumberIlca4 && sailor.sailNumberIlca4 !== sailor.sailNumber ? `ILCA: ${sailor.sailNumberIlca4}` : null, sailor.boardNumber && sailor.boardNumber !== "0" ? `Board: ${sailor.boardNumber}` : null].filter(Boolean);
                  return <li key={sailor.id}><Link href={`/sailors/${encodeURIComponent(sailor.handle)}`} prefetch={false} className="group flex min-w-0 items-center justify-between gap-4 rounded-2xl border border-cool-veil bg-warm-white p-4 transition-colors hover:border-reef-line hover:bg-aqua-mist focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-harbour sm:p-5">
                    <div className="min-w-0">
                      <h3 className="break-words text-base font-semibold text-harbour-shadow">{sailor.name}</h3>
                      {numbers.length > 0 && <p className="mt-1 break-words text-sm font-medium text-harbour">{numbers.join(" · ")}</p>}
                      <p className="mt-1 break-words text-sm text-slate-soft">{[sailor.club, sailor.nationality, sailor.activeFleet ? `Optimist ${sailor.activeFleet}` : null].filter(Boolean).join(" · ")}</p>
                    </div>
                    <ArrowRight className="h-4 w-4 shrink-0 text-harbour" aria-hidden />
                  </Link></li>;
                })}
              </ul>
              {results.pageCount > 1 && <nav aria-label="Sailor directory pages" className="flex flex-wrap items-center justify-between gap-3 border-t border-cool-veil pt-5">
                {results.page > 1 ? <Link href={directoryHref(filters, results.page - 1)} className="sp-secondary inline-flex min-h-11 items-center gap-2 px-4 text-sm font-semibold" rel="prev"><ArrowLeft className="h-4 w-4" aria-hidden />Previous</Link> : <span />}
                <p className="text-sm text-slate-soft">Page {results.page} of {results.pageCount}</p>
                {results.page < results.pageCount ? <Link href={directoryHref(filters, results.page + 1)} className="sp-secondary inline-flex min-h-11 items-center gap-2 px-4 text-sm font-semibold" rel="next">Next<ArrowRight className="h-4 w-4" aria-hidden /></Link> : <span />}
              </nav>}
            </>
          ) : <div className="rounded-2xl border border-dashed border-cool-veil p-6 sm:p-8"><p className="text-sm leading-6 text-slate-soft">{filtered ? "Try part of a name, just the digits of a sail number, or remove a filter to broaden your search." : "No public sailor records are available yet. Please check back soon."}</p><p className="mt-3 text-sm leading-6 text-slate-soft">Missing a result or found a mistake? <Link href="/support" className="font-semibold text-harbour underline underline-offset-4">Contact support</Link>.</p></div>}
        </section>
      )}
      <p className="text-xs leading-5 text-slate-soft">These profiles bring together published competition records. You can request access to your own or your child’s profile after opening it.</p>
    </div>
  );
}
