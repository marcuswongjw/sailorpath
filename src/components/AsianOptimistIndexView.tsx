import Link from "next/link";
import { BookOpen, ExternalLink, Medal, Trophy } from "lucide-react";
import {
  ASIAN_OPTIMIST_INDEX_EVENT,
  ASIAN_OPTIMIST_INDEX_SOURCE_PDF_URL,
  ASIAN_OPTIMIST_INDEX_SOURCE_URL,
  type AsianOptimistIndexEntry,
} from "@/lib/asianOptimistIndex";
import {
  formatAsianIndexDateRange,
  type AsianOptimistIndexQualifierSource,
} from "@/lib/asianOptimistIndexQualifiers";

function genderLabel(gender: AsianOptimistIndexEntry["gender"]): string {
  return gender === "W" ? "Girl" : "Boy";
}

function rankClass(rank: number): string {
  if (rank === 1) return "bg-racing-orange text-white";
  if (rank === 2) return "bg-harbour-mid text-white";
  if (rank === 3) return "bg-reef-line text-harbour-shadow";
  return "bg-sailcloth text-harbour";
}

export function AsianOptimistIndexView({
  entries,
  qualifiers,
}: {
  entries: AsianOptimistIndexEntry[];
  qualifiers: AsianOptimistIndexQualifierSource[];
}) {
  const leaders = entries.slice(0, 3);

  return (
    <main className="min-h-screen bg-sailcloth pb-16">
      <section className="border-b border-harbour-shadow bg-harbour text-white">
        <div className="mx-auto max-w-7xl px-4 py-10 sm:px-6 lg:px-8 lg:py-14">
          <p className="text-xs font-extrabold uppercase tracking-[0.18em] text-soft-aqua">
            Optimist · regional standings
          </p>
          <div className="mt-3 flex flex-col gap-5 lg:flex-row lg:items-end lg:justify-between">
            <div className="max-w-3xl">
              <h1 className="font-display text-3xl font-extrabold tracking-tight sm:text-5xl">
                Asian Optimist Index
              </h1>
              <p className="mt-4 max-w-2xl text-base leading-7 text-sailcloth sm:text-lg">
                The first release is a source-backed baseline from the final overall
                standings at the 2025 Optimist Asian &amp; Oceanian Championship.
                Verified 2026 regional results are recorded below, ready for the
                next season calculation after the Colombo championship anchor.
              </p>
            </div>
            <a
              href={ASIAN_OPTIMIST_INDEX_SOURCE_URL}
              target="_blank"
              rel="noreferrer"
              className="inline-flex shrink-0 items-center justify-center gap-2 rounded-lg border border-soft-aqua/50 px-4 py-2.5 text-sm font-bold text-white transition-colors hover:bg-harbour-mid"
            >
              Official results
              <ExternalLink className="h-4 w-4" aria-hidden="true" />
            </a>
          </div>
        </div>
      </section>

      <section className="mx-auto max-w-7xl px-4 py-6 sm:px-6 lg:px-8">
        <div className="grid gap-3 sm:grid-cols-3">
          <div className="rounded-xl border border-cool-veil bg-warm-white p-4 shadow-sm">
            <p className="text-xs font-bold uppercase tracking-wide text-slate-soft">Asian sailors</p>
            <p className="mt-1 text-3xl font-extrabold text-harbour">{entries.length}</p>
            <p className="mt-1 text-xs text-slate-soft">Across {ASIAN_OPTIMIST_INDEX_EVENT.countries} represented countries</p>
          </div>
          <div className="rounded-xl border border-cool-veil bg-warm-white p-4 shadow-sm">
            <p className="text-xs font-bold uppercase tracking-wide text-slate-soft">Founding result</p>
            <p className="mt-1 text-lg font-extrabold text-harbour">2025 Asian &amp; Oceanian</p>
            <p className="mt-1 text-xs text-slate-soft">{ASIAN_OPTIMIST_INDEX_EVENT.venue} · {ASIAN_OPTIMIST_INDEX_EVENT.dates}</p>
          </div>
          <div className="rounded-xl border border-cool-veil bg-warm-white p-4 shadow-sm">
            <p className="text-xs font-bold uppercase tracking-wide text-slate-soft">Race record</p>
            <p className="mt-1 text-lg font-extrabold text-harbour">{ASIAN_OPTIMIST_INDEX_EVENT.raceCount} races · 1 discard</p>
            <p className="mt-1 text-xs text-slate-soft">Official field: {ASIAN_OPTIMIST_INDEX_EVENT.totalFleetSize} sailors</p>
          </div>
        </div>
      </section>

      <section className="mx-auto max-w-7xl px-4 pb-7 sm:px-6 lg:px-8">
        <div className="rounded-2xl border border-cool-veil bg-warm-white p-5 shadow-sm sm:p-6">
          <div className="flex items-start gap-3">
            <div className="rounded-lg bg-racing-mist p-2 text-racing-deep">
              <Trophy className="h-5 w-5" aria-hidden="true" />
            </div>
            <div>
              <h2 className="text-lg font-extrabold text-harbour">2025 championship baseline</h2>
              <p className="mt-1 max-w-3xl text-sm leading-6 text-slate-soft">
                This is not yet a live 2026 performance score. The index starts by
                ordering Asian sailors by their official overall finish in the 170-sailor
                championship fleet. It preserves the official finishing position and net
                points rather than inventing a retrospective score.
              </p>
            </div>
          </div>

          <div className="mt-5 grid gap-3 md:grid-cols-3">
            {leaders.map((sailor) => (
              <article key={sailor.sailNumber} className="rounded-xl border border-cool-veil bg-sailcloth p-4">
                <div className="flex items-center justify-between gap-3">
                  <span className={`inline-flex h-8 min-w-8 items-center justify-center rounded-full px-2 text-sm font-extrabold ${rankClass(sailor.baselineRank)}`}>
                    #{sailor.baselineRank}
                  </span>
                  <span className="text-xs font-bold text-slate-soft">{sailor.nationality}</span>
                </div>
                <p className="mt-4 text-lg font-extrabold text-harbour">
                  {sailor.profileHref ? (
                    <Link href={sailor.profileHref} className="hover:text-racing-deep hover:underline">
                      {sailor.name}
                    </Link>
                  ) : sailor.name}
                </p>
                <p className="mt-1 text-sm text-slate-soft">{sailor.country} · {sailor.sailNumber}</p>
                <p className="mt-4 text-sm font-semibold text-charcoal">
                  Official finish <span className="font-extrabold text-harbour">{sailor.overallPlace}/{ASIAN_OPTIMIST_INDEX_EVENT.totalFleetSize}</span>
                  <span className="px-1.5 text-cool-mist">·</span>
                  Net <span className="font-extrabold text-harbour">{sailor.netPoints}</span>
                </p>
              </article>
            ))}
          </div>
        </div>
      </section>

      <section className="mx-auto max-w-7xl px-4 sm:px-6 lg:px-8">
        <div className="overflow-hidden rounded-2xl border border-cool-veil bg-warm-white shadow-sm">
          <div className="flex flex-col gap-2 border-b border-cool-veil px-5 py-5 sm:flex-row sm:items-end sm:justify-between sm:px-6">
            <div>
              <h2 className="text-xl font-extrabold text-harbour">Baseline standings</h2>
              <p className="mt-1 text-sm text-slate-soft">Asian sailors only, ordered by official overall finish.</p>
            </div>
            <p className="text-xs font-semibold text-slate-soft">Birth year is shown only from a matching public SailorPath profile.</p>
          </div>
          <div className="overflow-x-auto">
            <table className="w-full min-w-[760px] border-collapse text-left text-sm">
              <thead className="bg-sailcloth text-xs uppercase tracking-wide text-slate-soft">
                <tr>
                  <th scope="col" className="px-4 py-3 font-extrabold">Index</th>
                  <th scope="col" className="px-4 py-3 font-extrabold">Sailor</th>
                  <th scope="col" className="px-4 py-3 font-extrabold">Country</th>
                  <th scope="col" className="px-4 py-3 font-extrabold">Sail no.</th>
                  <th scope="col" className="px-4 py-3 text-center font-extrabold">Birth</th>
                  <th scope="col" className="px-4 py-3 text-center font-extrabold">Official finish</th>
                  <th scope="col" className="px-4 py-3 text-right font-extrabold">Net points</th>
                </tr>
              </thead>
              <tbody className="divide-y divide-cool-veil">
                {entries.map((sailor) => (
                  <tr key={sailor.sailNumber} className="transition-colors hover:bg-sailcloth/70">
                    <td className="px-4 py-3">
                      <span className={`inline-flex h-7 min-w-7 items-center justify-center rounded-full px-1.5 text-xs font-extrabold ${rankClass(sailor.baselineRank)}`}>
                        {sailor.baselineRank}
                      </span>
                    </td>
                    <td className="px-4 py-3">
                      <div className="font-bold text-harbour">
                        {sailor.profileHref ? (
                          <Link href={sailor.profileHref} className="hover:text-racing-deep hover:underline">
                            {sailor.name}
                          </Link>
                        ) : sailor.name}
                      </div>
                      <div className="mt-0.5 text-xs text-slate-soft">{genderLabel(sailor.gender)}</div>
                    </td>
                    <td className="px-4 py-3 text-charcoal">
                      <span className="font-bold">{sailor.nationality}</span>
                      <span className="ml-1.5 text-xs text-slate-soft">{sailor.country}</span>
                    </td>
                    <td className="px-4 py-3 font-mono text-xs font-semibold text-charcoal">{sailor.sailNumber}</td>
                    <td className="px-4 py-3 text-center font-semibold text-charcoal" title={sailor.birthYear ? undefined : "Not published in the official event source or a matching public SailorPath profile"}>
                      {sailor.birthYear ?? "—"}
                    </td>
                    <td className="px-4 py-3 text-center font-bold text-harbour">{sailor.overallPlace}/{ASIAN_OPTIMIST_INDEX_EVENT.totalFleetSize}</td>
                    <td className="px-4 py-3 text-right font-extrabold text-harbour">{sailor.netPoints}</td>
                  </tr>
                ))}
              </tbody>
            </table>
          </div>
        </div>
      </section>

      <section className="mx-auto max-w-7xl px-4 pt-7 sm:px-6 lg:px-8">
        <div className="overflow-hidden rounded-2xl border border-cool-veil bg-warm-white shadow-sm">
          <div className="flex flex-col gap-3 border-b border-cool-veil px-5 py-5 sm:flex-row sm:items-end sm:justify-between sm:px-6">
            <div>
              <h2 className="text-xl font-extrabold text-harbour">2026 regional qualifier ledger</h2>
              <p className="mt-1 max-w-3xl text-sm leading-6 text-slate-soft">
                These final classifications are retained with their source. They do not
                retroactively change the 2025 baseline; they are the verified regional
                inputs prepared for the 2026 Index once Colombo is complete.
              </p>
            </div>
            <p className="text-xs font-semibold text-slate-soft">
              {qualifiers.reduce((total, qualifier) => total + (qualifier.resultCount ?? 0), 0)} source rows tracked
            </p>
          </div>
          <div className="divide-y divide-cool-veil">
            {qualifiers.map((qualifier) => (
              <article key={qualifier.id} className="grid gap-4 px-5 py-5 sm:grid-cols-[minmax(0,1fr)_auto] sm:items-center sm:px-6">
                <div>
                  <div className="flex flex-wrap items-center gap-2">
                    <h3 className="font-extrabold text-harbour">{qualifier.name}</h3>
                    <span className="rounded-full bg-aqua-mist px-2.5 py-1 text-[11px] font-extrabold uppercase tracking-wide text-harbour">
                      {qualifier.usesSailorPathResults ? "SailorPath result" : "Imported official result"}
                    </span>
                  </div>
                  <p className="mt-1 text-sm text-slate-soft">
                    {qualifier.hostCountry} · {formatAsianIndexDateRange(qualifier.startDate, qualifier.endDate)}
                  </p>
                  <p className="mt-2 text-xs leading-5 text-slate-soft">
                    {qualifier.officialResultsSourceName}
                  </p>
                </div>
                <div className="flex items-center gap-4 sm:justify-end">
                  <div className="text-right">
                    <p className="text-lg font-extrabold text-harbour">{qualifier.resultCount ?? "—"}</p>
                    <p className="text-xs font-semibold text-slate-soft">final rows</p>
                  </div>
                  <a
                    href={qualifier.officialResultsUrl}
                    target="_blank"
                    rel="noreferrer"
                    className="inline-flex items-center gap-1.5 rounded-lg border border-cool-veil px-3 py-2 text-sm font-bold text-harbour transition-colors hover:border-aqua hover:bg-sailcloth"
                  >
                    Source
                    <ExternalLink className="h-3.5 w-3.5" aria-hidden="true" />
                  </a>
                </div>
              </article>
            ))}
          </div>
        </div>
      </section>

      <section className="mx-auto max-w-7xl px-4 pt-7 sm:px-6 lg:px-8">
        <div className="grid gap-5 lg:grid-cols-[1.25fr_0.75fr]">
          <article className="rounded-2xl border border-cool-veil bg-warm-white p-5 shadow-sm sm:p-6">
            <div className="flex items-center gap-3">
              <div className="rounded-lg bg-aqua-mist p-2 text-harbour">
                <BookOpen className="h-5 w-5" aria-hidden="true" />
              </div>
              <h2 className="text-xl font-extrabold text-harbour">How to read this index</h2>
            </div>
            <div className="mt-4 space-y-4 text-sm leading-6 text-charcoal">
              <p><strong>Index rank</strong> is the Asian-only ordering of sailors in the official 2025 final overall result. <strong>Official finish</strong> keeps the sailor’s actual place in the complete 170-sailor championship field.</p>
              <p><strong>Net points</strong> are the organiser’s final low-point total after one discard. Lower is better. Girls, boys, fleet prizes and other subcategories do not create duplicate entries.</p>
              <p><strong>Birth year</strong> is not published in the official IODA result or entry list. It appears here only when SailorPath can match the sailor to a profile whose birth date is marked public; otherwise it remains blank.</p>
              <p><strong>2026 qualifier ledger:</strong> final regional classifications are preserved now, but do not revise the legacy baseline. Colombo will become the championship anchor; only then will the published 2026 formula combine it with the eligible qualifier results. Each counted result will link back to its official source.</p>
            </div>
          </article>
          <aside className="rounded-2xl bg-harbour p-5 text-white shadow-sm sm:p-6">
            <Medal className="h-6 w-6 text-soft-aqua" aria-hidden="true" />
            <h2 className="mt-3 text-xl font-extrabold">Source and scope</h2>
            <p className="mt-3 text-sm leading-6 text-sailcloth">Only sailors representing Asian national authorities in the official final classification are included. Australia and New Zealand remain part of the official Asian &amp; Oceanian event but are not in this Asian-only baseline.</p>
            <a href={ASIAN_OPTIMIST_INDEX_SOURCE_PDF_URL} target="_blank" rel="noreferrer" className="mt-5 inline-flex items-center gap-2 text-sm font-bold text-soft-aqua hover:text-white hover:underline">
              Download official final-result PDF
              <ExternalLink className="h-4 w-4" aria-hidden="true" />
            </a>
          </aside>
        </div>
      </section>
    </main>
  );
}
