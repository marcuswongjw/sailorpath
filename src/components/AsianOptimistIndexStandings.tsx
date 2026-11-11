import Link from "next/link";
import { ChevronRight } from "lucide-react";
import { Pagination, pageNumber } from "./Pagination";
import type { AsianOptimistIndexProvisionalEntry } from "@/lib/asianOptimistIndexScoring";

export type AsianOptimistIndexFilterState = {
  page?: string;
  country?: string;
  gender?: string;
  birthYear?: string;
};

export type QualifierColumn = {
  readonly id: string;
  readonly shortName: string;
  readonly grade?: number;
};

function genderCode(gender: AsianOptimistIndexProvisionalEntry["gender"]): "M" | "F" {
  return gender === "W" ? "F" : "M";
}

function rankClass(rank: number): string {
  if (rank === 1) return "bg-racing-orange text-white";
  if (rank === 2) return "bg-harbour-mid text-white";
  if (rank === 3) return "bg-reef-line text-harbour-shadow";
  return "bg-sailcloth text-harbour";
}

export function filterAsianOptimistIndexEntries(
  entries: AsianOptimistIndexProvisionalEntry[],
  country: string,
  gender: string,
  birthYear: string
): AsianOptimistIndexProvisionalEntry[] {
  return entries.filter((entry) => {
    const countryMatches = country === "all" || entry.nationality === country;
    const genderMatches = gender === "all" || genderCode(entry.gender) === gender;
    const birthYearMatches =
      birthYear === "all" || String(entry.birthYear ?? "unknown") === birthYear;

    return countryMatches && genderMatches && birthYearMatches;
  });
}

export function AsianOptimistIndexStandings({
  entries,
  qualifierColumns,
  asOf,
  totalFleetSize,
  filters = {},
}: {
  entries: AsianOptimistIndexProvisionalEntry[];
  qualifierColumns: readonly QualifierColumn[];
  asOf: string;
  totalFleetSize: number;
  filters?: AsianOptimistIndexFilterState;
}) {
  const countries = [...new Set(entries.map((entry) => entry.nationality))].sort((a, b) =>
    a.localeCompare(b)
  );
  const birthYears = [
    ...new Set(entries.map((entry) => entry.birthYear).filter((year): year is number => year != null)),
  ].sort((a, b) => b - a);

  const country = countries.includes(filters.country ?? "") ? filters.country! : "all";
  const gender = filters.gender === "M" || filters.gender === "F" ? filters.gender : "all";
  const birthYear =
    filters.birthYear === "unknown" || birthYears.includes(Number(filters.birthYear))
      ? filters.birthYear!
      : "all";
  const filteredEntries = filterAsianOptimistIndexEntries(entries, country, gender, birthYear);
  const page = pageNumber(filters.page, filteredEntries.length);
  const pageEntries = filteredEntries.slice((page - 1) * 30, page * 30);
  const filtersActive = country !== "all" || gender !== "all" || birthYear !== "all";

  const g150Cols = qualifierColumns.filter((col) => col.grade === 150);
  const g75Cols = qualifierColumns.filter((col) => col.grade === 75);
  const g40Cols = qualifierColumns.filter((col) => col.grade === 40);

  return (
    <div className="overflow-hidden rounded-2xl border border-cool-veil bg-warm-white shadow-sm">
      <div className="flex flex-col gap-3 border-b border-cool-veil px-4 py-4 sm:px-6 sm:py-5">
        <div className="flex flex-wrap items-baseline justify-between gap-2">
          <h2 className="text-lg font-extrabold text-harbour sm:text-xl">Standings</h2>
          <p className="text-xs font-semibold text-slate-soft">
            {filteredEntries.length} {filteredEntries.length === 1 ? "sailor" : "sailors"} · {asOf}
          </p>
        </div>

        <form
          action="/optimist/asian-index"
          method="get"
          className="grid grid-cols-2 gap-2.5 sm:grid-cols-4 sm:items-end"
          aria-label="Filter standings"
        >
          <label className="grid gap-1 text-[11px] font-bold uppercase tracking-wide text-slate-soft">
            Country
            <select
              name="country"
              defaultValue={country}
              className="min-h-11 rounded-lg border border-cool-veil bg-white px-2.5 text-sm font-semibold text-harbour outline-none transition focus:border-aqua focus:ring-2 focus:ring-aqua/25"
            >
              <option value="all">All</option>
              {countries.map((code) => (
                <option key={code} value={code}>{code}</option>
              ))}
            </select>
          </label>
          <label className="grid gap-1 text-[11px] font-bold uppercase tracking-wide text-slate-soft">
            Gender
            <select
              name="gender"
              defaultValue={gender}
              className="min-h-11 rounded-lg border border-cool-veil bg-white px-2.5 text-sm font-semibold text-harbour outline-none transition focus:border-aqua focus:ring-2 focus:ring-aqua/25"
            >
              <option value="all">All</option>
              <option value="M">Boys (M)</option>
              <option value="F">Girls (F)</option>
            </select>
          </label>
          <label className="grid gap-1 text-[11px] font-bold uppercase tracking-wide text-slate-soft">
            Birth year
            <select
              name="birthYear"
              defaultValue={birthYear}
              className="min-h-11 rounded-lg border border-cool-veil bg-white px-2.5 text-sm font-semibold text-harbour outline-none transition focus:border-aqua focus:ring-2 focus:ring-aqua/25"
            >
              <option value="all">All</option>
              {birthYears.map((year) => (
                <option key={year} value={year}>{year}</option>
              ))}
              <option value="unknown">Not recorded</option>
            </select>
          </label>
          <div className="flex items-center gap-2 self-end">
            <button
              type="submit"
              className="min-h-11 flex-1 rounded-lg bg-harbour px-3.5 text-sm font-extrabold text-white transition-colors hover:bg-harbour-mid cursor-pointer"
            >
              Filter
            </button>
            {filtersActive ? (
              <Link
                href="/optimist/asian-index"
                className="inline-flex min-h-11 items-center rounded-lg border border-cool-veil bg-white px-3 text-xs font-bold text-harbour hover:bg-sailcloth"
              >
                Reset
              </Link>
            ) : null}
          </div>
        </form>
      </div>

      {/* Mobile card list: readable without horizontal spreadsheet scrolling */}
      <div className="divide-y divide-cool-veil md:hidden">
        {pageEntries.length === 0 ? (
          <p className="px-4 py-8 text-center text-sm font-semibold text-slate-soft">
            No sailors match the selected filters.
          </p>
        ) : (
          pageEntries.map((sailor) => {
            const eventFinishes = [
              ...(sailor.overallPlace != null
                ? [
                    {
                      key: "asians-2025",
                      name: "2025 Asians",
                      finish: `${sailor.overallPlace}/${totalFleetSize}`,
                      counted: sailor.countedResultsCount > sailor.scoredQualifiers.length,
                    },
                  ]
                : []),
              ...sailor.qualifierResults.map((res) => ({
                key: res.qualifier.id,
                name: res.qualifier.shortName,
                finish: `${res.rank}/${res.qualifier.fleetSize}`,
                counted: Boolean(res.counted),
              })),
            ];

            return (
              <article key={sailor.sailNumber} className="px-4 py-3.5">
                <div className="flex items-start gap-3">
                  <span
                    className={`mt-0.5 inline-flex h-7 min-w-7 shrink-0 items-center justify-center rounded-full px-1.5 text-xs font-extrabold ${rankClass(sailor.provisionalRank)}`}
                  >
                    {sailor.provisionalRank}
                  </span>
                  <div className="min-w-0 flex-1">
                    <div className="flex items-baseline justify-between gap-2">
                      <p className="min-w-0 truncate font-bold text-harbour">
                        {sailor.profileHref ? (
                          <Link prefetch={false} href={sailor.profileHref} className="hover:text-racing-deep hover:underline">
                            {sailor.displayName}
                          </Link>
                        ) : (
                          sailor.displayName
                        )}
                      </p>
                      <p className="shrink-0 text-base font-black tabular-nums text-harbour">
                        {sailor.provisionalScore.toFixed(2)}
                      </p>
                    </div>
                    <div className="mt-0.5 flex flex-wrap items-center justify-between gap-2 text-xs text-slate-soft">
                      <span>
                        {sailor.nationality} · {sailor.sailNumber} · {genderCode(sailor.gender)}
                        {sailor.birthYear ? ` · ${sailor.birthYear}` : ""}
                      </span>
                      <span className="font-medium">
                        {sailor.countedResultsCount} counted
                      </span>
                    </div>
                    {sailor.profileReview ? (
                      <span className="mt-1 inline-flex rounded-full bg-amber-100 px-2 py-0.5 text-[10px] font-bold uppercase tracking-wide text-amber-900">
                        Profile review
                      </span>
                    ) : null}
                  </div>
                </div>

                {eventFinishes.length > 0 ? (
                  <details className="sp-accordion group mt-2 pl-10">
                    <summary className="inline-flex list-none [&::-webkit-details-marker]:hidden items-center gap-1 text-xs font-bold text-harbour cursor-pointer select-none py-1">
                      <ChevronRight className="h-3.5 w-3.5 shrink-0 transition-transform group-open:rotate-90" aria-hidden="true" />
                      Results ({eventFinishes.length})
                    </summary>
                    <div className="mt-2 grid grid-cols-2 gap-1.5">
                      {eventFinishes.map((item) => (
                        <div
                          key={item.key}
                          className={`rounded-lg border px-2.5 py-1.5 text-xs ${
                            item.counted
                              ? "border-harbour/25 bg-aqua-mist/40 text-harbour"
                              : "border-cool-veil bg-sailcloth/60 text-slate-soft"
                          }`}
                        >
                          <p className="truncate font-semibold">{item.name}</p>
                          <p className="font-extrabold tabular-nums">
                            {item.finish}
                            {item.counted ? " ✓" : ""}
                          </p>
                        </div>
                      ))}
                    </div>
                  </details>
                ) : null}
              </article>
            );
          })
        )}
      </div>

      {/* Desktop semantic sticky matrix */}
      <div
        role="region"
        aria-label="Asian and Oceania Optimist Index standings"
        tabIndex={0}
        className="relative hidden max-h-[80vh] overflow-auto border-t border-cool-veil md:block"
      >
        <table className="w-full min-w-[1400px] border-separate border-spacing-0 text-left text-sm">
          <thead className="sticky top-0 z-20 text-xs uppercase tracking-wide text-slate-soft shadow-[0_2px_4px_rgba(0,0,0,0.06)]">
            <tr className="h-[34px] text-[11px] font-extrabold">
              <th colSpan={2} className="sticky left-0 top-0 z-30 border-b border-r border-cool-veil bg-warm-white px-4 py-2 text-left text-slate-soft">
                Sailor
              </th>
              <th colSpan={3} className="sticky top-0 z-20 border-b border-r border-cool-veil bg-warm-white px-4 py-2 text-left text-slate-soft">
                Details
              </th>
              <th className="sticky top-0 z-20 border-b border-r border-cool-veil bg-warm-white px-4 py-2 text-right text-harbour">
                Score
              </th>
              <th colSpan={1 + g150Cols.length} className="sticky top-0 z-20 border-b border-r border-cool-veil bg-[#edf2f4] px-4 py-2 text-center text-harbour">
                Grade 150 · Championships <span className="normal-case font-medium text-slate-soft">(max 2)</span>
              </th>
              <th colSpan={g75Cols.length} className="sticky top-0 z-20 border-b border-r border-cool-veil bg-[#e6f3f4] px-4 py-2 text-center text-harbour">
                Grade 75 · Opens <span className="normal-case font-medium text-slate-soft">(max 1/host)</span>
              </th>
              <th colSpan={Math.max(g40Cols.length, 1)} className="sticky top-0 z-20 border-b border-cool-veil bg-[#faf3e6] px-4 py-2 text-center text-harbour">
                Grade 40 · Nationals <span className="normal-case font-medium text-slate-soft">(max 1/country/yr)</span>
              </th>
            </tr>
            <tr className="font-bold">
              <th scope="col" className="sticky left-0 top-[34px] z-30 w-14 min-w-14 max-w-14 border-b-2 border-cool-veil bg-sailcloth px-3 py-2.5 font-extrabold text-harbour">#</th>
              <th scope="col" className="sticky left-14 top-[34px] z-30 min-w-48 border-b-2 border-r border-cool-veil bg-sailcloth px-4 py-2.5 font-extrabold text-harbour">Sailor</th>
              <th scope="col" className="sticky top-[34px] z-20 border-b-2 border-cool-veil bg-sailcloth px-3 py-2.5 font-extrabold text-harbour">MNA</th>
              <th scope="col" className="sticky top-[34px] z-20 border-b-2 border-cool-veil bg-sailcloth px-3 py-2.5 font-extrabold text-harbour">Sex</th>
              <th scope="col" className="sticky top-[34px] z-20 border-b-2 border-cool-veil bg-sailcloth px-3 py-2.5 text-center font-extrabold text-harbour">YOB</th>
              <th scope="col" className="sticky top-[34px] z-20 border-b-2 border-r border-cool-veil bg-sailcloth px-4 py-2.5 text-right font-extrabold text-harbour">Points</th>
              <th scope="col" className="sticky top-[34px] z-20 border-b-2 border-cool-veil bg-[#f0f4f4] px-4 py-2.5 text-center font-extrabold text-harbour">
                <div>2025 Asians</div>
                <div className="mt-0.5">
                  <span className="inline-block rounded bg-harbour/20 px-1.5 py-0.5 text-[10px] font-black text-harbour">G150</span>
                </div>
              </th>
              {qualifierColumns.map((qualifier) => {
                const isG150 = qualifier.grade === 150;
                const isG75 = qualifier.grade === 75;
                const bg = isG150 ? "bg-[#f0f4f4]" : isG75 ? "bg-[#ebf5f6]" : "bg-[#faf5eb]";
                const badgeBg = isG150
                  ? "bg-harbour/20 text-harbour"
                  : isG75
                    ? "bg-aqua/20 text-harbour"
                    : "bg-amber-500/20 text-amber-900";
                const gradeLabel = qualifier.grade ? `G${qualifier.grade}` : "";

                return (
                  <th key={qualifier.id} scope="col" className={`sticky top-[34px] z-20 border-b-2 border-cool-veil ${bg} px-4 py-2.5 text-center font-extrabold text-harbour`}>
                    <div>{qualifier.shortName}</div>
                    {gradeLabel ? (
                      <div className="mt-0.5">
                        <span className={`inline-block rounded ${badgeBg} px-1.5 py-0.5 text-[10px] font-black`}>
                          {gradeLabel}
                        </span>
                      </div>
                    ) : null}
                  </th>
                );
              })}
            </tr>
          </thead>
          <tbody>
            {pageEntries.map((sailor) => (
              <tr key={sailor.sailNumber} className="group transition-colors hover:bg-sailcloth/70">
                <td className="sticky left-0 z-10 w-14 min-w-14 max-w-14 border-b border-cool-veil bg-warm-white px-3 py-3 group-hover:bg-sailcloth">
                  <span className={`inline-flex h-7 min-w-7 items-center justify-center rounded-full px-1.5 text-xs font-extrabold ${rankClass(sailor.provisionalRank)}`}>
                    {sailor.provisionalRank}
                  </span>
                </td>
                <th scope="row" className="sticky left-14 z-10 min-w-48 border-b border-r border-cool-veil bg-warm-white px-4 py-3 text-left font-normal group-hover:bg-sailcloth">
                  <div className="font-bold text-harbour">
                    {sailor.profileHref ? (
                      <Link prefetch={false} href={sailor.profileHref} className="hover:text-racing-deep hover:underline">
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
                </th>
                <td className="border-b border-cool-veil px-3 py-3 text-xs font-semibold text-charcoal">{sailor.nationality}</td>
                <td className="border-b border-cool-veil px-3 py-3 text-xs font-semibold text-charcoal">{genderCode(sailor.gender)}</td>
                <td className="border-b border-cool-veil px-3 py-3 text-center text-xs font-semibold text-charcoal">{sailor.birthYear ?? "—"}</td>
                <td className="border-b border-r border-cool-veil px-4 py-3 text-right">
                  <div className="text-base font-extrabold tabular-nums text-harbour">{sailor.provisionalScore.toFixed(2)}</div>
                  <div className="text-[11px] font-medium text-slate-soft">
                    {sailor.countedResultsCount} counted · {sailor.eligibleStarts} {sailor.eligibleStarts === 1 ? "start" : "starts"}
                  </div>
                </td>
                <td
                  title={sailor.overallPlace != null ? `${sailor.displayName} · 2025 Asians: ${sailor.overallPlace} of ${totalFleetSize} (${sailor.championshipPoints?.toFixed(2) ?? "—"} pts)` : "No finish recorded"}
                  className="border-b border-cool-veil bg-harbour/[0.02] px-4 py-3 text-center font-bold tabular-nums text-harbour"
                >
                  {sailor.overallPlace != null ? `${sailor.overallPlace}/${totalFleetSize}` : "—"}
                </td>
                {qualifierColumns.map((qualifier) => {
                  const isG150 = qualifier.grade === 150;
                  const isG75 = qualifier.grade === 75;
                  const bg = isG150 ? "bg-harbour/[0.02]" : isG75 ? "bg-aqua/[0.02]" : "bg-amber-500/[0.02]";
                  const res = sailor.qualifierResults.find(
                    (q) => q.qualifier.id === qualifier.id || q.qualifier.id.startsWith(qualifier.id)
                  );
                  const tooltip = res
                    ? `${sailor.displayName} · ${qualifier.shortName}: ${res.rank} of ${res.qualifier.fleetSize} starters (${res.points.toFixed(2)} pts)${res.counted ? " · Counted" : res.dropReason ? ` · Capped (${res.dropReason})` : " · Capped by selection limits"}`
                    : undefined;

                  return (
                    <td
                      key={qualifier.id}
                      title={tooltip}
                      className={`border-b border-cool-veil ${bg} px-4 py-3 text-center text-xs font-semibold tabular-nums text-charcoal`}
                    >
                      {res ? (
                        <span className={res.counted ? "font-bold text-harbour" : "font-medium text-slate-soft/70"}>
                          {res.rank}/{res.qualifier.fleetSize}
                        </span>
                      ) : (
                        <span className="text-slate-soft/50">—</span>
                      )}
                    </td>
                  );
                })}
              </tr>
            ))}
            {filteredEntries.length === 0 ? (
              <tr>
                <td colSpan={7 + qualifierColumns.length} className="border-b border-cool-veil px-4 py-10 text-center text-sm font-semibold text-slate-soft">
                  No sailors match the selected filters.
                </td>
              </tr>
            ) : null}
          </tbody>
        </table>
      </div>

      <div className="border-t border-cool-veil px-4 sm:px-6">
        <Pagination path="/optimist/asian-index" filters={filters} page={page} total={filteredEntries.length} />
      </div>
    </div>
  );
}
