import Link from "next/link";
import { BookOpen, ExternalLink, Medal, Trophy } from "lucide-react";
import {
  AsianOptimistIndexStandings,
  type AsianOptimistIndexFilterState,
} from "@/components/AsianOptimistIndexStandings";
import { AsianOptimistIndexBetaSummary } from "@/components/AsianOptimistIndexBetaSummary";
import { ASIAN_INDEX_METHODOLOGY_PATH } from "@/lib/asianOptimistIndexBeta";
import {
  ASIAN_OPTIMIST_INDEX_EVENT,
  ASIAN_OPTIMIST_INDEX_SOURCE_PDF_URL,
  ASIAN_OPTIMIST_INDEX_SOURCE_URL,
} from "@/lib/asianOptimistIndex";
import {
  ASIAN_OPTIMIST_INDEX_DISPLAY_COLUMNS,
  ASIAN_OPTIMIST_INDEX_PROVISIONAL_RELEASE,
  type AsianOptimistIndexProvisionalEntry,
} from "@/lib/asianOptimistIndexScoring";
import {
  formatAsianIndexDateRange,
  type AsianOptimistIndexQualifierSource,
} from "@/lib/asianOptimistIndexQualifiers";

function rankClass(rank: number): string {
  if (rank === 1) return "bg-racing-orange text-white";
  if (rank === 2) return "bg-harbour-mid text-white";
  if (rank === 3) return "bg-reef-line text-harbour-shadow";
  return "bg-sailcloth text-harbour";
}

const INDEX_QUALIFIER_COLUMNS = ASIAN_OPTIMIST_INDEX_DISPLAY_COLUMNS;

export function AsianOptimistIndexView({
  entries,
  qualifiers,
  filters,
}: {
  entries: AsianOptimistIndexProvisionalEntry[];
  qualifiers: AsianOptimistIndexQualifierSource[];
  filters?: AsianOptimistIndexFilterState;
}) {
  const leaders = entries.slice(0, 3);
  const sailorsWithQualifiers = entries.filter((entry) => entry.eligibleStarts > 0).length;
  const totalStarts = entries.reduce((total, entry) => total + entry.eligibleStarts, 0);

  return (
    <main className="min-h-screen bg-sailcloth pb-16">
      <section className="border-b border-harbour-shadow bg-harbour text-white">
        <div className="mx-auto max-w-7xl px-4 py-10 sm:px-6 lg:px-8 lg:py-14">
          <p className="text-xs font-extrabold uppercase tracking-[0.18em] text-soft-aqua">
            Optimist · V1 (Beta) methodology
          </p>
          <div className="mt-3 flex flex-col gap-5 lg:flex-row lg:items-end lg:justify-between">
            <div className="max-w-3xl">
              <h1 className="font-display text-3xl font-extrabold tracking-tight sm:text-5xl">
                SailorPath Asian and Oceania Optimist Index
              </h1>
              <p className="mt-4 max-w-2xl text-base leading-7 text-sailcloth sm:text-lg">
                An independent analytical index of verified Optimist results for sailors representing Asian and Oceanian national
                authorities. Standings are calculated under the V1 (Beta) rolling 12-month methodology
                for the {entries.length} Asian and Oceanian competitors from verified international championships (World Championship, Asian &amp; Oceanian Championship, European Championship) and designated regional regattas.
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

      <section aria-label="Beta methodology notice" className="mx-auto max-w-7xl px-4 pt-6 sm:px-6 lg:px-8">
        <div className="rounded-xl border border-amber-300 bg-amber-50 p-4 text-sm leading-6 text-amber-950">
          <p>
            <strong>V1 (Beta) methodology is live.</strong> Standings are calculated using the V1 (Beta) points formula
            (<code className="font-bold">E × (N − P + 1) ÷ N</code>) with event-grade and host-country caps across eligible Asian and Oceanian regattas.
            This is an independent analytical index published by SailorPath, not an official IODA or national federation ranking.
          </p>
          <nav aria-label="On this page" className="mt-2 flex flex-wrap gap-x-4 gap-y-1 font-bold">
            <a href="#beta-summary" className="underline underline-offset-2 hover:text-racing-deep">
              Index in one page
            </a>
            <a href="#register" className="underline underline-offset-2 hover:text-racing-deep">
              Event register
            </a>
            <a href="#nominate" className="underline underline-offset-2 hover:text-racing-deep">
              Nominate an event
            </a>
            <Link href={ASIAN_INDEX_METHODOLOGY_PATH} className="underline underline-offset-2 hover:text-racing-deep">
              Full methodology
            </Link>
          </nav>
        </div>
      </section>

      <section className="mx-auto max-w-7xl px-4 py-6 sm:px-6 lg:px-8">
        <div className="grid gap-3 sm:grid-cols-3">
          <div className="rounded-xl border border-cool-veil bg-warm-white p-4 shadow-sm">
            <p className="text-xs font-bold uppercase tracking-wide text-slate-soft">Fixed cohort</p>
            <p className="mt-1 text-3xl font-extrabold text-harbour">{entries.length}</p>
            <p className="mt-1 text-xs text-slate-soft">Asian &amp; Oceanian sailors across verified championships</p>
          </div>
          <div className="rounded-xl border border-cool-veil bg-warm-white p-4 shadow-sm">
            <p className="text-xs font-bold uppercase tracking-wide text-slate-soft">Score formula</p>
            <p className="mt-1 text-lg font-extrabold text-harbour">V1 (Beta) Points</p>
            <p className="mt-1 text-xs text-slate-soft">Best up to 5 events · Grade 150 / 75 / 40 tiers</p>
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
                  Index points <span className="font-extrabold text-harbour">{sailor.provisionalScore.toFixed(2)}</span>
                  <span className="px-1.5 text-cool-mist">·</span>
                  2025 finish <span className="font-extrabold text-harbour">{sailor.overallPlace != null ? `${sailor.overallPlace}/${ASIAN_OPTIMIST_INDEX_EVENT.totalFleetSize}` : "—"}</span>
                </p>
              </article>
            ))}
          </div>
        </div>
      </section>

      <section className="mx-auto max-w-7xl px-4 sm:px-6 lg:px-8">
        <AsianOptimistIndexStandings
          entries={entries}
          qualifierColumns={INDEX_QUALIFIER_COLUMNS}
          asOf={ASIAN_OPTIMIST_INDEX_PROVISIONAL_RELEASE.asOf}
          totalFleetSize={ASIAN_OPTIMIST_INDEX_EVENT.totalFleetSize}
          filters={filters}
        />
      </section>

      <section className="mx-auto max-w-7xl px-4 pt-7 sm:px-6 lg:px-8">
        <div className="overflow-hidden rounded-2xl border border-cool-veil bg-warm-white shadow-sm">
          <div className="flex flex-col gap-3 border-b border-cool-veil px-5 py-5 sm:flex-row sm:items-end sm:justify-between sm:px-6">
              <div>
                <h2 className="text-xl font-extrabold text-harbour">2026 qualifying events</h2>
                <p className="mt-1 max-w-3xl text-sm leading-6 text-slate-soft">
                  Verified final classifications are published on SailorPath and are the active form inputs. Each regatta is designated under the V1 (Beta) tiers: Grade 150 (Championships), Grade 75 (International Opens), or Grade 40 (National Championships). Selection limits apply across host jurisdictions and grades.
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
                      {qualifier.resultStatus === "scheduled"
                        ? "Scheduled candidate"
                        : qualifier.usesSailorPathResults
                          ? "SailorPath result"
                          : "Imported official result"}
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
                    <p className="text-xs font-semibold text-slate-soft">
                      {qualifier.resultStatus === "scheduled" ? "results pending" : "final rows"}
                    </p>
                  </div>
                  <a
                    href={qualifier.officialResultsUrl}
                    target="_blank"
                    rel="noreferrer"
                    className="inline-flex items-center gap-1.5 rounded-lg border border-cool-veil px-3 py-2 text-sm font-bold text-harbour transition-colors hover:border-aqua hover:bg-sailcloth"
                  >
                    {qualifier.resultStatus === "scheduled" ? "Notice" : "Source"}
                    <ExternalLink className="h-3.5 w-3.5" aria-hidden="true" />
                  </a>
                  {qualifier.sailorPathRegattaSlug ? (
                    <Link
                      href={`/sg/optimist/regattas/${qualifier.sailorPathRegattaSlug}`}
                      className="inline-flex items-center gap-1.5 rounded-lg bg-harbour px-3 py-2 text-sm font-bold text-white transition-colors hover:bg-harbour-mid"
                    >
                      Results
                    </Link>
                  ) : null}
                </div>
              </article>
            ))}
          </div>
        </div>
      </section>

      <AsianOptimistIndexBetaSummary />

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
              <p><strong>Who is ranked:</strong> verified Asian and Oceanian Optimist sailors representing eligible MNAs with at least one verified scoring result in the 12-month window. The cohort includes competitors from the 2025 Asian &amp; Oceanian Championship, 2026 World Championship, and 2026 European Championship.</p>
              <p><strong>Points formula:</strong> each eligible result earns points based on event grade (E), valid starters (N), and finishing position (P): <code>Points = E × (N − P + 1) ÷ N</code>. First place earns E, and last place earns E ÷ N.</p>
              <p><strong>Event tiers:</strong> Grade 150 for IODA Worlds and continental fleet-racing championships; Grade 75 for designated international opens meeting the 50-starter / 4-MNA gates; Grade 40 for recognized national championships.</p>
              <p><strong>Selection limits:</strong> each sailor’s Index is the sum of their best combination of results subject to six selection limits: at most 5 results overall; at most 2 Grade 150 results; at most 1 World Championship; at most 4 upper-grade results (Grade 150 + 75); at most 1 Grade 75 result per host MNA; and at most 1 Grade 40 result per host MNA per calendar year.</p>
              <p><strong>Profile links:</strong> sailor names link to their verified SailorPath profile. Results expire on their 12-month anniversary.</p>
            </div>
          </article>
          <aside className="rounded-2xl bg-harbour p-5 text-white shadow-sm sm:p-6">
            <Medal className="h-6 w-6 text-soft-aqua" aria-hidden="true" />
            <h2 className="mt-3 text-xl font-extrabold">Source and scope</h2>
            <p className="mt-3 text-sm leading-6 text-sailcloth">Sailors representing eligible World Sailing Member National Authorities across Asia and Oceania are included in the Index. Standings are calculated from verified official results and updated with each designated regatta.</p>
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
