import Link from "next/link";
import { BookOpen, ExternalLink, Medal, Trophy } from "lucide-react";
import {
  ASIAN_OPTIMIST_INDEX_EVENT,
  ASIAN_OPTIMIST_INDEX_SOURCE_PDF_URL,
  ASIAN_OPTIMIST_INDEX_SOURCE_URL,
} from "@/lib/asianOptimistIndex";
import {
  ASIAN_OPTIMIST_INDEX_SCORED_QUALIFIERS,
  ASIAN_OPTIMIST_INDEX_PROVISIONAL_RELEASE,
  type AsianOptimistIndexProvisionalEntry,
} from "@/lib/asianOptimistIndexScoring";
import {
  formatAsianIndexDateRange,
  type AsianOptimistIndexQualifierSource,
} from "@/lib/asianOptimistIndexQualifiers";

function genderCode(gender: AsianOptimistIndexProvisionalEntry["gender"]): string {
  return gender === "W" ? "F" : "M";
}

function rankClass(rank: number): string {
  if (rank === 1) return "bg-racing-orange text-white";
  if (rank === 2) return "bg-harbour-mid text-white";
  if (rank === 3) return "bg-reef-line text-harbour-shadow";
  return "bg-sailcloth text-harbour";
}

const INDEX_QUALIFIER_COLUMNS = Object.values(
  ASIAN_OPTIMIST_INDEX_SCORED_QUALIFIERS
);

function qualifierRank(
  entry: AsianOptimistIndexProvisionalEntry,
  qualifierId: string
): string {
  const result = entry.qualifierResults.find(
    (qualifier) => qualifier.qualifier.id === qualifierId
  );
  return result ? `${result.rank}/${result.qualifier.fleetSize}` : "—";
}

export function AsianOptimistIndexView({
  entries,
  qualifiers,
}: {
  entries: AsianOptimistIndexProvisionalEntry[];
  qualifiers: AsianOptimistIndexQualifierSource[];
}) {
  const leaders = entries.slice(0, 3);
  const sailorsWithQualifiers = entries.filter((entry) => entry.eligibleStarts > 0).length;
  const totalStarts = entries.reduce((total, entry) => total + entry.eligibleStarts, 0);

  return (
    <main className="min-h-screen bg-sailcloth pb-16">
      <section className="border-b border-harbour-shadow bg-harbour text-white">
        <div className="mx-auto max-w-7xl px-4 py-10 sm:px-6 lg:px-8 lg:py-14">
          <p className="text-xs font-extrabold uppercase tracking-[0.18em] text-soft-aqua">
            Optimist · provisional regional index
          </p>
          <div className="mt-3 flex flex-col gap-5 lg:flex-row lg:items-end lg:justify-between">
            <div className="max-w-3xl">
              <h1 className="font-display text-3xl font-extrabold tracking-tight sm:text-5xl">
                Asian Optimist Index
              </h1>
              <p className="mt-4 max-w-2xl text-base leading-7 text-sailcloth sm:text-lg">
                A transparent provisional score for the 122 Asian sailors in the
                official 2025 Asian &amp; Oceanian Championship. It combines that
                championship finish with verified 2026 regional form available today.
              </p>
            </div>
            <a
              href={ASIAN_OPTIMIST_INDEX_SOURCE_URL}
              target="_blank"
              rel="noreferrer"
              className="inline-flex shrink-0 items-center justify-center gap-2 rounded-lg border border-soft-aqua/50 px-4 py-2.5 text-sm font-bold text-white transition-colors hover:bg-harbour-mid"
            >
              2025 official results
              <ExternalLink className="h-4 w-4" aria-hidden="true" />
            </a>
          </div>
        </div>
      </section>

      <section className="mx-auto max-w-7xl px-4 py-6 sm:px-6 lg:px-8">
        <div className="grid gap-3 sm:grid-cols-3">
          <div className="rounded-xl border border-cool-veil bg-warm-white p-4 shadow-sm">
            <p className="text-xs font-bold uppercase tracking-wide text-slate-soft">Fixed cohort</p>
            <p className="mt-1 text-3xl font-extrabold text-harbour">{entries.length}</p>
            <p className="mt-1 text-xs text-slate-soft">Asian sailors from the 2025 official final</p>
          </div>
          <div className="rounded-xl border border-cool-veil bg-warm-white p-4 shadow-sm">
            <p className="text-xs font-bold uppercase tracking-wide text-slate-soft">Score formula</p>
            <p className="mt-1 text-lg font-extrabold text-harbour">60% championship · 40% form</p>
            <p className="mt-1 text-xs text-slate-soft">Up to five events · best three host-country results</p>
          </div>
          <div className="rounded-xl border border-cool-veil bg-warm-white p-4 shadow-sm">
            <p className="text-xs font-bold uppercase tracking-wide text-slate-soft">Verified 2026 form</p>
            <p className="mt-1 text-lg font-extrabold text-harbour">{sailorsWithQualifiers} sailors · {totalStarts} starts</p>
            <p className="mt-1 text-xs text-slate-soft">Across {INDEX_QUALIFIER_COLUMNS.length} verified qualifying events today</p>
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
              <div className="flex flex-wrap items-center gap-2">
                <h2 className="text-lg font-extrabold text-harbour">{ASIAN_OPTIMIST_INDEX_PROVISIONAL_RELEASE.name}</h2>
                <span className="rounded-full bg-racing-mist px-2.5 py-1 text-[11px] font-extrabold uppercase tracking-wide text-racing-deep">
                  {ASIAN_OPTIMIST_INDEX_PROVISIONAL_RELEASE.version}
                </span>
              </div>
              <p className="mt-1 max-w-3xl text-sm leading-6 text-slate-soft">
                This is a live score and rank, but not an official IODA ranking. The 2025
                championship is the temporary common anchor until the 2026 Asian &amp;
                Oceanian Championship final classification is published and reviewed.
              </p>
            </div>
          </div>

          <div className="mt-5 grid gap-3 md:grid-cols-3">
            {leaders.map((sailor) => (
              <article key={sailor.sailNumber} className="rounded-xl border border-cool-veil bg-sailcloth p-4">
                <div className="flex items-center justify-between gap-3">
                  <span className={`inline-flex h-8 min-w-8 items-center justify-center rounded-full px-2 text-sm font-extrabold ${rankClass(sailor.provisionalRank)}`}>
                    #{sailor.provisionalRank}
                  </span>
                  <span className="text-xs font-bold text-slate-soft">{sailor.nationality}</span>
                </div>
                <p className="mt-4 text-lg font-extrabold text-harbour">
                  {sailor.profileHref ? (
                    <Link href={sailor.profileHref} className="hover:text-racing-deep hover:underline">
                      {sailor.displayName}
                    </Link>
                  ) : sailor.displayName}
                </p>
                {sailor.profileReview ? (
                  <p className="mt-1 text-[11px] font-bold uppercase tracking-wide text-amber-800">
                    Profile review
                  </p>
                ) : null}
                <p className="mt-1 text-sm text-slate-soft">{sailor.nationality} · {sailor.sailNumber}</p>
                <p className="mt-4 text-sm font-semibold text-charcoal">
                  Index score <span className="font-extrabold text-harbour">{sailor.provisionalScore.toFixed(1)}</span>
                  <span className="px-1.5 text-cool-mist">·</span>
                  2025 finish <span className="font-extrabold text-harbour">{sailor.overallPlace}/{ASIAN_OPTIMIST_INDEX_EVENT.totalFleetSize}</span>
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
              <h2 className="text-xl font-extrabold text-harbour">Provisional standings</h2>
              <p className="mt-1 text-sm text-slate-soft">
                Ordered by the calculated 0–100 Index score. Regatta cells show final rank / fleet; a dash means no verified finish is available for that sailor.
              </p>
            </div>
            <p className="text-xs font-semibold text-slate-soft">Calculated through {ASIAN_OPTIMIST_INDEX_PROVISIONAL_RELEASE.asOf}</p>
          </div>
          <div className="overflow-x-auto">
            <table className="w-full min-w-[1320px] border-collapse text-left text-sm">
              <thead className="bg-sailcloth text-xs uppercase tracking-wide text-slate-soft">
                <tr>
                  <th scope="col" className="px-4 py-3 font-extrabold">Index</th>
                  <th scope="col" className="px-4 py-3 font-extrabold">Sailor</th>
                  <th scope="col" className="px-4 py-3 font-extrabold">Country</th>
                  <th scope="col" className="px-4 py-3 font-extrabold">Gender</th>
                  <th scope="col" className="px-4 py-3 text-center font-extrabold">Birth year</th>
                  <th scope="col" className="px-4 py-3 text-right font-extrabold">Score</th>
                  <th scope="col" className="px-4 py-3 text-center font-extrabold">2025 Asians</th>
                  {INDEX_QUALIFIER_COLUMNS.map((qualifier) => (
                    <th
                      key={qualifier.id}
                      scope="col"
                      className="px-4 py-3 text-center font-extrabold"
                    >
                      {qualifier.shortName}
                    </th>
                  ))}
                </tr>
              </thead>
              <tbody className="divide-y divide-cool-veil">
                {entries.map((sailor) => (
                  <tr key={sailor.sailNumber} className="transition-colors hover:bg-sailcloth/70">
                    <td className="px-4 py-3">
                      <span className={`inline-flex h-7 min-w-7 items-center justify-center rounded-full px-1.5 text-xs font-extrabold ${rankClass(sailor.provisionalRank)}`}>
                        {sailor.provisionalRank}
                      </span>
                    </td>
                    <td className="px-4 py-3">
                      <div className="font-bold text-harbour">
                        {sailor.profileHref ? (
                          <Link href={sailor.profileHref} className="hover:text-racing-deep hover:underline">
                            {sailor.displayName}
                          </Link>
                        ) : sailor.displayName}
                      </div>
                      <div className="mt-0.5 text-xs text-slate-soft">
                        {sailor.nationality} · {sailor.sailNumber}
                      </div>
                      {sailor.profileReview ? (
                        <span
                          title={sailor.profileReview.reason}
                          className="mt-1 inline-flex rounded-full bg-amber-100 px-2 py-0.5 text-[10px] font-extrabold uppercase tracking-wide text-amber-900"
                        >
                          Profile review
                        </span>
                      ) : null}
                    </td>
                    <td className="px-4 py-3 text-xs font-semibold text-charcoal">
                      {sailor.nationality}
                    </td>
                    <td className="px-4 py-3 text-xs font-semibold text-charcoal">
                      {genderCode(sailor.gender)}
                    </td>
                    <td className="px-4 py-3 text-center text-xs font-semibold text-charcoal">
                      {sailor.birthYear ?? "—"}
                    </td>
                    <td className="px-4 py-3 text-right text-base font-extrabold text-harbour">{sailor.provisionalScore.toFixed(1)}</td>
                    <td className="px-4 py-3 text-center font-bold text-harbour">{sailor.overallPlace}/{ASIAN_OPTIMIST_INDEX_EVENT.totalFleetSize}</td>
                    {INDEX_QUALIFIER_COLUMNS.map((qualifier) => (
                      <td
                        key={qualifier.id}
                        className="px-4 py-3 text-center text-xs font-semibold text-charcoal"
                      >
                        {qualifierRank(sailor, qualifier.id)}
                      </td>
                    ))}
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
              <h2 className="text-xl font-extrabold text-harbour">2026 qualifying events</h2>
              <p className="mt-1 max-w-3xl text-sm leading-6 text-slate-soft">
                These final classifications are published on SailorPath and are the verified form inputs. The provisional slate can include up to five events; a sailor can use only their strongest result from each host country, and Singapore national-event scores are capped at 70 out of 100.
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
                  <Link
                    href={`/sg/optimist/regattas/${qualifier.sailorPathRegattaSlug}`}
                    className="inline-flex items-center gap-1.5 rounded-lg bg-harbour px-3 py-2 text-sm font-bold text-white transition-colors hover:bg-harbour-mid"
                  >
                    Results
                  </Link>
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
              <h2 className="text-xl font-extrabold text-harbour">How this provisional score works</h2>
            </div>
            <div className="mt-4 space-y-4 text-sm leading-6 text-charcoal">
              <p><strong>Who is ranked:</strong> the fixed 122-sailor Asian cohort from the official 2025 Asian &amp; Oceanian final classification. A new qualifier participant is not added to this provisional table until the 2026 championship refresh.</p>
              <p><strong>2025 championship points (60):</strong> the official overall finish is fleet-normalised: <code>100 × (170 − finish) ÷ 169</code>, then multiplied by 60%. First in the 170-sailor fleet earns 60 points; last earns 0.</p>
              <p><strong>2026 form points (40):</strong> the season can nominate up to five verified regional events. Each final qualifier finish is fleet-normalised the same way; the strongest result from one host country contributes up to 28 points, a second country up to 8, and a third up to 4. A fifth event can replace a weaker result but never creates an attendance bonus. Missing country slots are zero.</p>
              <p><strong>National-event safeguard:</strong> Singapore national-event result scores are capped at 70 out of 100 before the 28% / 8% / 4% weights are applied. This prevents domestic-only form from outweighing the common championship anchor.</p>
              <p><strong>Profile links:</strong> sailor names link to the consolidated SailorPath record. The founding-cohort profile audit was resolved by an administrator on 14 October 2026; the original verified result identities remain intact.</p>
              <p><strong>Refresh at Colombo:</strong> after the official 2026 Asian &amp; Oceanian Championship final is checked, SailorPath will refresh the cohort, replace the temporary 2025 anchor, add eligible sailors from the new championship, and recalculate the index.</p>
            </div>
          </article>
          <aside className="rounded-2xl bg-harbour p-5 text-white shadow-sm sm:p-6">
            <Medal className="h-6 w-6 text-soft-aqua" aria-hidden="true" />
            <h2 className="mt-3 text-xl font-extrabold">Source and scope</h2>
            <p className="mt-3 text-sm leading-6 text-sailcloth">Only sailors representing Asian national authorities in the 2025 official final classification are eligible for this provisional release. Australia and New Zealand were part of the official Asian &amp; Oceanian event but are not in this Asian-only cohort.</p>
            <a href={ASIAN_OPTIMIST_INDEX_SOURCE_PDF_URL} target="_blank" rel="noreferrer" className="mt-5 inline-flex items-center gap-2 text-sm font-bold text-soft-aqua hover:text-white hover:underline">
              Download 2025 final-result PDF
              <ExternalLink className="h-4 w-4" aria-hidden="true" />
            </a>
          </aside>
        </div>
      </section>
    </main>
  );
}
