import Link from "next/link";
import { ExternalLink } from "lucide-react";
import {
  AsianOptimistIndexStandings,
  type AsianOptimistIndexFilterState,
} from "@/components/AsianOptimistIndexStandings";
import { AsianOptimistIndexBetaSummary } from "@/components/AsianOptimistIndexBetaSummary";
import { ASIAN_INDEX_METHODOLOGY_PATH } from "@/lib/asianOptimistIndexBeta";
import { ASIAN_OPTIMIST_INDEX_EVENT } from "@/lib/asianOptimistIndex";
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

  return (
    <main className="min-h-screen bg-sailcloth pb-14">
      <section className="border-b border-harbour-shadow bg-harbour text-white">
        <div className="mx-auto max-w-7xl px-4 py-6 sm:px-6 sm:py-10 lg:px-8">
          <h1 className="font-display text-2xl font-extrabold tracking-tight sm:text-4xl">
            Asian and Oceania Optimist Index
          </h1>
          <p className="mt-2 max-w-2xl text-sm leading-6 text-sailcloth sm:text-base">
            An independent index of verified Optimist results for sailors representing Asian and Oceanian national authorities.
          </p>
          <div className="mt-3 flex flex-wrap items-center gap-x-4 gap-y-1.5 text-xs font-semibold text-soft-aqua">
            <span>{entries.length} sailors · Updated {ASIAN_OPTIMIST_INDEX_PROVISIONAL_RELEASE.asOf}</span>
            <Link
              href={ASIAN_INDEX_METHODOLOGY_PATH}
              className="underline underline-offset-4 hover:text-white"
            >
              Methodology →
            </Link>
            <span className="text-sailcloth/80">Not an official IODA or national ranking.</span>
          </div>
        </div>
      </section>

      <section aria-label="Top 3 leaders" className="mx-auto max-w-7xl px-4 py-5 sm:px-6 lg:px-8">
        <div className="grid gap-2.5 sm:grid-cols-3">
          {leaders.map((sailor) => (
            <article
              key={sailor.sailNumber}
              className="flex items-center gap-3 rounded-xl border border-cool-veil bg-warm-white px-4 py-3 shadow-xs"
            >
              <span
                className={`inline-flex h-8 min-w-8 shrink-0 items-center justify-center rounded-full px-2 text-sm font-extrabold ${rankClass(sailor.provisionalRank)}`}
              >
                #{sailor.provisionalRank}
              </span>
              <div className="min-w-0 flex-1">
                <p className="truncate font-extrabold text-harbour">
                  {sailor.profileHref ? (
                    <Link href={sailor.profileHref} className="hover:text-racing-deep hover:underline">
                      {sailor.displayName}
                    </Link>
                  ) : (
                    sailor.displayName
                  )}
                </p>
                <p className="text-xs text-slate-soft">
                  {sailor.nationality} · {sailor.sailNumber}
                </p>
              </div>
              <p className="shrink-0 text-base font-black tabular-nums text-harbour">
                {sailor.provisionalScore.toFixed(2)}
              </p>
            </article>
          ))}
        </div>
      </section>

      <section id="standings" aria-label="Index standings" className="mx-auto max-w-7xl px-4 sm:px-6 lg:px-8">
        <AsianOptimistIndexStandings
          entries={entries}
          qualifierColumns={INDEX_QUALIFIER_COLUMNS}
          asOf={ASIAN_OPTIMIST_INDEX_PROVISIONAL_RELEASE.asOf}
          totalFleetSize={ASIAN_OPTIMIST_INDEX_EVENT.totalFleetSize}
          filters={filters}
        />
      </section>

      <section id="qualifiers" aria-label="2026 qualifying events" className="mx-auto max-w-7xl px-4 pt-5 sm:px-6 lg:px-8">
        <div className="overflow-hidden rounded-2xl border border-cool-veil bg-warm-white shadow-sm">
          <div className="border-b border-cool-veil px-4 py-4 sm:px-6">
            <h2 className="text-lg font-extrabold text-harbour">2026 qualifying events</h2>
          </div>
          <div className="divide-y divide-cool-veil">
            {qualifiers.map((qualifier) => (
              <article
                key={qualifier.id}
                className="flex flex-col gap-3 px-4 py-3.5 sm:flex-row sm:items-center sm:justify-between sm:px-6"
              >
                <div className="min-w-0">
                  <div className="flex flex-wrap items-center gap-2">
                    <h3 className="font-bold text-harbour">{qualifier.name}</h3>
                    {qualifier.resultStatus === "scheduled" ? (
                      <span className="rounded-full bg-sailcloth px-2 py-0.5 text-[11px] font-bold text-slate-soft">
                        Scheduled
                      </span>
                    ) : null}
                  </div>
                  <p className="mt-0.5 text-xs text-slate-soft">
                    {qualifier.hostCountry} · {formatAsianIndexDateRange(qualifier.startDate, qualifier.endDate)}
                    {qualifier.resultCount ? ` · ${qualifier.resultCount} entries` : ""}
                  </p>
                </div>
                <div className="flex shrink-0 items-center gap-2">
                  <a
                    href={qualifier.officialResultsUrl}
                    target="_blank"
                    rel="noreferrer"
                    className="inline-flex min-h-9 items-center gap-1 rounded-lg border border-cool-veil px-3 py-1.5 text-xs font-bold text-harbour transition-colors hover:border-aqua hover:bg-sailcloth"
                  >
                    {qualifier.resultStatus === "scheduled" ? "Notice" : "Source"}
                    <ExternalLink className="h-3.5 w-3.5" aria-hidden="true" />
                  </a>
                  {qualifier.sailorPathRegattaSlug ? (
                    <Link
                      href={`/sg/optimist/regattas/${qualifier.sailorPathRegattaSlug}`}
                      className="inline-flex min-h-9 items-center rounded-lg bg-harbour px-3 py-1.5 text-xs font-bold text-white transition-colors hover:bg-harbour-mid"
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
    </main>
  );
}
