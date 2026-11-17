import Link from "next/link";
import { Pagination, pageNumber } from "./Pagination";
import type { AsianOptimistIndexProvisionalEntry } from "@/lib/asianOptimistIndexScoring";
import { asianIndexUnder13BirthYear } from "@/lib/asianOptimistIndexBeta";
import type { AsianOptimistIndexQualifierSource } from "@/lib/asianOptimistIndexQualifiers";

export type AsianOptimistIndexViewMode = "points" | "power" | "u13";

export type AsianOptimistIndexFilterState = {
  page?: string;
  country?: string;
  gender?: string;
  birthYear?: string;
  view?: string;
};

export type QualifierColumn = {
  readonly id: string;
  readonly shortName: string;
  readonly grade?: number;
  readonly regattaSlug?: string | null;
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

function ScoreBreakdown({ sailor, qualifiers, totalFleetSize, anchorName, anchorSlug }: {
  sailor: AsianOptimistIndexProvisionalEntry;
  qualifiers: readonly AsianOptimistIndexQualifierSource[];
  totalFleetSize: number;
  anchorName: string;
  anchorSlug: string;
}) {
  const anchor = qualifiers.find((source) => source.sailorPathRegattaSlug === anchorSlug);
  const results = [
    ...(sailor.overallPlace != null && totalFleetSize > 0 ? [{
      id: "anchor", name: anchorName, grade: 150, rank: sailor.overallPlace,
      fleet: totalFleetSize, points: 150 * (totalFleetSize - sailor.overallPlace + 1) / totalFleetSize,
      counted: sailor.countedResultsCount > sailor.scoredQualifiers.length,
      slug: anchorSlug, officialUrl: anchor?.officialResultsUrl,
    }] : []),
    ...sailor.qualifierResults.map((result) => {
      const source = qualifiers.find((item) => item.id === result.qualifier.id);
      return {
        id: result.qualifier.id, name: source?.name ?? result.qualifier.shortName,
        grade: result.qualifier.grade, rank: result.rank, fleet: result.qualifier.fleetSize,
        points: result.points, counted: result.counted,
        slug: result.regattaSlug ?? source?.sailorPathRegattaSlug, officialUrl: source?.officialResultsUrl,
      };
    }),
  ];
  if (!results.length) return null;
  return (
    <details className="mt-2 text-left text-xs font-normal text-charcoal">
      <summary className="cursor-pointer font-bold text-harbour">Score breakdown ({results.length})</summary>
      <p className="mt-2 text-slate-soft">Points = grade × (fleet − place + 1) ÷ fleet. The total uses unrounded points.</p>
      <ul className="mt-2 space-y-2">
        {results.map((result) => (
          <li key={result.id} className="rounded-lg border border-cool-veil bg-white p-2">
            <p className="font-bold text-harbour">{result.name}</p>
            <p>Grade {result.grade} · Index place {result.rank} of {result.fleet} · {result.points.toFixed(2)} points · {result.counted ? "Counted" : "Not counted (selection limits)"}</p>
            <p className="mt-1 flex flex-wrap gap-x-3">
              {result.slug ? <Link prefetch={false} href={`/sg/optimist/regattas/${result.slug}`} className="font-bold underline">SailorPath results</Link> : null}
              {result.officialUrl ? <a href={result.officialUrl} target="_blank" rel="noreferrer" className="font-bold underline">Source</a> : null}
            </p>
          </li>
        ))}
      </ul>
      <p className="mt-2 font-bold">Season Points: {sailor.provisionalScore.toFixed(2)}</p>
    </details>
  );
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
  qualifiers = [],
  filters = {},
}: {
  entries: AsianOptimistIndexProvisionalEntry[];
  qualifierColumns: readonly QualifierColumn[];
  asOf: string;
  totalFleetSize: number;
  qualifiers?: readonly AsianOptimistIndexQualifierSource[];
  filters?: AsianOptimistIndexFilterState;
}) {
  const anchorSource = qualifiers.find((event) =>
    event.resultStatus === "verified" && /asian\s*(?:&|and)\s*oceanian championship/i.test(event.name)
  );
  const hasAnchor = entries.some((entry) => entry.overallPlace != null);
  const anchorName = anchorSource?.name ?? "2025 Asians";
  const anchorSlug = anchorSource?.sailorPathRegattaSlug ?? "2025-optimist-asian-oceanian-championship-overall";
  const viewMode: AsianOptimistIndexViewMode =
    filters.view === "power" || filters.view === "u13" ? filters.view : "points";
  const u13BirthYear = asianIndexUnder13BirthYear(new Date().getUTCFullYear());

  const baseEntries =
    viewMode === "u13"
      ? entries
          .filter((e) => e.birthYear != null && e.birthYear >= u13BirthYear)
          .sort(
            (a, b) =>
              (b.powerRating ?? 1500) - (a.powerRating ?? 1500) ||
              b.provisionalScore - a.provisionalScore ||
              a.name.localeCompare(b.name)
          )
      : viewMode === "power"
        ? [...entries].sort(
            (a, b) =>
              (b.powerRating ?? 1500) - (a.powerRating ?? 1500) ||
              b.provisionalScore - a.provisionalScore ||
              a.name.localeCompare(b.name)
          )
        : entries;

  const countries = [...new Set(baseEntries.map((entry) => entry.nationality))].sort((a, b) =>
    a.localeCompare(b)
  );
  const birthYears = [
    ...new Set(baseEntries.map((entry) => entry.birthYear).filter((year): year is number => year != null)),
  ].sort((a, b) => b - a);

  const country = countries.includes(filters.country ?? "") ? filters.country! : "all";
  const gender = filters.gender === "M" || filters.gender === "F" ? filters.gender : "all";
  const birthYear =
    filters.birthYear === "unknown" || birthYears.includes(Number(filters.birthYear))
      ? filters.birthYear!
      : "all";
  const filteredEntries = filterAsianOptimistIndexEntries(baseEntries, country, gender, birthYear);
  const page = pageNumber(filters.page, filteredEntries.length);
  const pageEntries = filteredEntries.slice((page - 1) * 30, page * 30);
  const filtersActive = country !== "all" || gender !== "all" || birthYear !== "all";

  function viewHref(nextView: AsianOptimistIndexViewMode): string {
    const params = new URLSearchParams();
    if (nextView !== "points") params.set("view", nextView);
    if (country !== "all") params.set("country", country);
    if (gender !== "all") params.set("gender", gender);
    if (birthYear !== "all") params.set("birthYear", birthYear);
    const qs = params.toString();
    return qs ? `/optimist/asian-index?${qs}#standings` : "/optimist/asian-index#standings";
  }

  function displayRank(sailor: AsianOptimistIndexProvisionalEntry, idxInPage: number): number {
    if (viewMode === "power") return sailor.powerRank ?? (page - 1) * 30 + idxInPage + 1;
    if (viewMode === "u13") {
      // Rank within U13 cohort (before country/gender filters)
      const u13Idx = baseEntries.findIndex((e) => e.identityKey === sailor.identityKey);
      return u13Idx >= 0 ? u13Idx + 1 : (page - 1) * 30 + idxInPage + 1;
    }
    return sailor.provisionalRank;
  }

  function momentumPill(delta: number | undefined) {
    if (delta == null) return <span className="text-slate-soft/50">—</span>;
    if (delta >= 5) {
      return (
        <span
          title={`Elo +${delta} over last 90 days`}
          className="inline-flex items-center rounded-full bg-emerald-50 px-2 py-0.5 text-[11px] font-extrabold tabular-nums text-emerald-700 ring-1 ring-emerald-200"
        >
          ▲ +{delta}
        </span>
      );
    }
    if (delta <= -5) {
      return (
        <span
          title={`Elo ${delta} over last 90 days`}
          className="inline-flex items-center rounded-full bg-rose-50 px-2 py-0.5 text-[11px] font-bold tabular-nums text-rose-700 ring-1 ring-rose-200"
        >
          ▼ {delta}
        </span>
      );
    }
    return (
      <span
        title="Steady form over last 90 days"
        className="inline-flex items-center rounded-full bg-sailcloth px-2 py-0.5 text-[11px] font-semibold tabular-nums text-slate-soft"
      >
        • {delta > 0 ? `+${delta}` : delta}
      </span>
    );
  }

  const g200Cols = qualifierColumns.filter((col) => col.grade === 200);
  const g150Cols = qualifierColumns.filter((col) => col.grade === 150);
  const g75Cols = qualifierColumns.filter((col) => col.grade === 75);
  const g40Cols = qualifierColumns.filter((col) => col.grade === 40);
  const nonG200Cols = qualifierColumns.filter((col) => col.grade !== 200);

  return (
    <div className="overflow-hidden rounded-2xl border border-cool-veil bg-warm-white shadow-sm">
      <div className="flex flex-col gap-3 border-b border-cool-veil px-4 py-4 sm:px-6 sm:py-5">
        <div className="flex flex-wrap items-baseline justify-between gap-2">
          <h2 className="text-lg font-extrabold text-harbour sm:text-xl">Standings</h2>
          <p className="text-xs font-semibold text-slate-soft">
            {filteredEntries.length} {filteredEntries.length === 1 ? "sailor" : "sailors"} · {asOf}
          </p>
        </div>

        <nav aria-label="Index ranking view" className="flex flex-wrap gap-1.5">
          <Link
            href={viewHref("points")}
            className={`inline-flex min-h-9 items-center rounded-lg px-3 py-1.5 text-xs font-extrabold transition-colors ${
              viewMode === "points"
                ? "bg-harbour text-white shadow-xs"
                : "border border-cool-veil bg-white text-harbour hover:bg-sailcloth"
            }`}
          >
            Season Points
          </Link>
          <Link
            href={viewHref("power")}
            className={`inline-flex min-h-9 items-center gap-1.5 rounded-lg px-3 py-1.5 text-xs font-extrabold transition-colors ${
              viewMode === "power"
                ? "bg-harbour text-white shadow-xs"
                : "border border-cool-veil bg-white text-harbour hover:bg-sailcloth"
            }`}
          >
            Power Rating (Elo)
            <span className={`rounded px-1 py-0.2 text-[10px] font-black uppercase ${viewMode === "power" ? "bg-white/20 text-white" : "bg-aqua-mist text-harbour"}`}>
              Beta
            </span>
          </Link>
          <Link
            href={viewHref("u13")}
            className={`inline-flex min-h-9 items-center gap-1.5 rounded-lg px-3 py-1.5 text-xs font-extrabold transition-colors ${
              viewMode === "u13"
                ? "bg-harbour text-white shadow-xs"
                : "border border-cool-veil bg-white text-harbour hover:bg-sailcloth"
            }`}
          >
            U13 / Next-Gen ({u13BirthYear}+)
          </Link>
        </nav>

        <form
          action="/optimist/asian-index"
          method="get"
          className="grid grid-cols-2 gap-2.5 sm:grid-cols-4 sm:items-end"
          aria-label="Filter standings"
        >
          {viewMode !== "points" ? <input type="hidden" name="view" value={viewMode} /> : null}
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
          pageEntries.map((sailor, idxInPage) => {
            const shownRank = displayRank(sailor, idxInPage);


            return (
              <article key={sailor.identityKey} className="px-4 py-3.5">
                <div className="flex items-start gap-3">
                  <span
                    className={`mt-0.5 inline-flex h-7 min-w-7 shrink-0 items-center justify-center rounded-full px-1.5 text-xs font-extrabold ${rankClass(shownRank)}`}
                  >
                    {shownRank}
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
                        {viewMode === "points"
                          ? sailor.provisionalScore.toFixed(2)
                          : `${sailor.powerRating ?? 1500}`}
                      </p>
                    </div>
                    <div className="mt-0.5 flex flex-wrap items-center justify-between gap-2 text-xs text-slate-soft">
                      <span>
                        {sailor.nationality} · {sailor.sailNumber} · {genderCode(sailor.gender)}
                        {sailor.birthYear ? ` · ${sailor.birthYear}` : ""}
                      </span>
                      <span className="flex items-center gap-1.5 font-medium">
                        {sailor.powerRating != null && viewMode === "points" ? (
                          <span>Elo {sailor.powerRating}</span>
                        ) : null}
                        {viewMode !== "points" ? (
                          <span>{sailor.provisionalScore.toFixed(1)} pts</span>
                        ) : null}
                        {momentumPill(sailor.momentumDelta)}
                      </span>
                    </div>
                    {sailor.profileReview ? (
                      <span className="mt-1 inline-flex rounded-full bg-amber-100 px-2 py-0.5 text-[10px] font-bold uppercase tracking-wide text-amber-900">
                        Profile review
                      </span>
                    ) : null}
                  </div>
                </div>

                <div className="pl-10"><ScoreBreakdown sailor={sailor} qualifiers={qualifiers} totalFleetSize={totalFleetSize} anchorName={anchorName} anchorSlug={anchorSlug} /></div>
              </article>
            );
          })
        )}
      </div>

      {/* Desktop semantic sticky matrix */}
      <div className="hidden items-center justify-between border-t border-cool-veil bg-sailcloth/40 px-4 py-1.5 text-[11px] font-medium text-slate-soft md:flex">
        <span>Highlighted pills indicate counted top-5 results.</span>
        <span>Scroll table horizontally for all events →</span>
      </div>
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
              <th colSpan={3} className="sticky top-0 z-20 border-b border-r border-cool-veil bg-warm-white px-4 py-2 text-right text-harbour">
                Rating &amp; Form
              </th>
              {g200Cols.length > 0 ? (
                <th colSpan={g200Cols.length} className="sticky top-0 z-20 whitespace-nowrap border-b border-r border-cool-veil bg-[#e3eaf0] px-3 py-2 text-center text-harbour">
                  Grade 200 · Worlds <span className="normal-case font-medium text-slate-soft">(max 1)</span>
                </th>
              ) : null}
              {hasAnchor || g150Cols.length > 0 ? <th colSpan={(hasAnchor ? 1 : 0) + g150Cols.length} className="sticky top-0 z-20 whitespace-nowrap border-b border-r border-cool-veil bg-[#edf2f4] px-4 py-2 text-center text-harbour">
                Grade 150 · Championships <span className="normal-case font-medium text-slate-soft">(max 2)</span>
              </th> : null}
              {g75Cols.length > 0 ? <th colSpan={g75Cols.length} className="sticky top-0 z-20 whitespace-nowrap border-b border-r border-cool-veil bg-[#e6f3f4] px-4 py-2 text-center text-harbour">
                Grade 75 · Opens <span className="normal-case font-medium text-slate-soft">(max 1/host)</span>
              </th> : null}
              {g40Cols.length > 0 ? <th colSpan={g40Cols.length} className="sticky top-0 z-20 whitespace-nowrap border-b border-cool-veil bg-[#faf3e6] px-4 py-2 text-center text-harbour">
                Grade 40 · Nationals <span className="normal-case font-medium text-slate-soft">(max 1/country/yr)</span>
              </th> : null}
            </tr>
            <tr className="font-bold">
              <th scope="col" className="sticky left-0 top-[34px] z-30 w-14 min-w-14 max-w-14 border-b-2 border-cool-veil bg-sailcloth px-3 py-2.5 font-extrabold text-harbour">#</th>
              <th scope="col" className="sticky left-14 top-[34px] z-30 min-w-48 border-b-2 border-r border-cool-veil bg-sailcloth px-4 py-2.5 font-extrabold text-harbour shadow-[4px_0_8px_-4px_rgba(11,37,69,0.12)]">Sailor</th>
              <th scope="col" className="sticky top-[34px] z-20 border-b-2 border-cool-veil bg-sailcloth px-3 py-2.5 font-extrabold text-harbour">MNA</th>
              <th scope="col" className="sticky top-[34px] z-20 border-b-2 border-cool-veil bg-sailcloth px-3 py-2.5 font-extrabold text-harbour">Sex</th>
              <th scope="col" className="sticky top-[34px] z-20 border-b-2 border-cool-veil bg-sailcloth px-3 py-2.5 text-center font-extrabold text-harbour">YOB</th>
              {viewMode === "points" ? (
                <>
                  <th scope="col" className="sticky top-[34px] z-20 border-b-2 border-cool-veil bg-sailcloth px-3 py-2.5 text-right font-extrabold text-harbour">Points ↓</th>
                  <th scope="col" className="sticky top-[34px] z-20 border-b-2 border-cool-veil bg-sailcloth px-3 py-2.5 text-right font-extrabold text-harbour" title="Head-to-head multi-player Elo rating (starts at 1500)">Elo</th>
                </>
              ) : (
                <>
                  <th scope="col" className="sticky top-[34px] z-20 border-b-2 border-cool-veil bg-sailcloth px-3 py-2.5 text-right font-extrabold text-harbour" title="Head-to-head multi-player Elo rating (starts at 1500)">Elo ↓</th>
                  <th scope="col" className="sticky top-[34px] z-20 border-b-2 border-cool-veil bg-sailcloth px-3 py-2.5 text-right font-extrabold text-harbour">Points</th>
                </>
              )}
              <th scope="col" className="sticky top-[34px] z-20 border-b-2 border-r border-cool-veil bg-sailcloth px-3 py-2.5 text-center font-extrabold text-harbour" title="90-day Elo momentum">Form</th>
              {g200Cols.map((qualifier) => (
                <th key={qualifier.id} scope="col" className="sticky top-[34px] z-20 min-w-[82px] whitespace-nowrap border-b-2 border-cool-veil bg-[#e7eef3] px-2.5 py-2.5 text-center font-extrabold text-harbour">
                  {qualifier.regattaSlug ? (
                    <Link href={`/sg/optimist/regattas/${qualifier.regattaSlug}`} className="hover:text-racing-deep hover:underline">
                      {qualifier.shortName}
                    </Link>
                  ) : (
                    <div>{qualifier.shortName}</div>
                  )}
                </th>
              ))}
              {hasAnchor ? (
                <th scope="col" className="sticky top-[34px] z-20 min-w-[82px] whitespace-nowrap border-b-2 border-cool-veil bg-[#f0f4f4] px-2.5 py-2.5 text-center font-extrabold text-harbour">
                  <Link href={`/sg/optimist/regattas/${anchorSlug}`} className="hover:text-racing-deep hover:underline">{anchorName}</Link>
                </th>
              ) : null}
              {nonG200Cols.map((qualifier) => {
                const isG150 = qualifier.grade === 150;
                const isG75 = qualifier.grade === 75;
                const bg = isG150 ? "bg-[#f0f4f4]" : isG75 ? "bg-[#ebf5f6]" : "bg-[#faf5eb]";

                return (
                  <th key={qualifier.id} scope="col" className={`sticky top-[34px] z-20 min-w-[82px] whitespace-nowrap border-b-2 border-cool-veil ${bg} px-2.5 py-2.5 text-center font-extrabold text-harbour`}>
                    {qualifier.regattaSlug ? (
                      <Link href={`/sg/optimist/regattas/${qualifier.regattaSlug}`} className="hover:text-racing-deep hover:underline">
                        {qualifier.shortName}
                      </Link>
                    ) : (
                      <div>{qualifier.shortName}</div>
                    )}
                  </th>
                );
              })}
            </tr>
          </thead>
          <tbody>
            {pageEntries.map((sailor, idxInPage) => {
              const shownRank = displayRank(sailor, idxInPage);
              const anchorCounted = sailor.overallPlace != null && sailor.countedResultsCount > sailor.scoredQualifiers.length;
              return (
              <tr key={sailor.identityKey} className="group transition-colors hover:bg-sailcloth/70">
                <td className="sticky left-0 z-10 w-14 min-w-14 max-w-14 border-b border-cool-veil bg-warm-white px-3 py-3 group-hover:bg-sailcloth">
                  <span className={`inline-flex h-7 min-w-7 items-center justify-center rounded-full px-1.5 text-xs font-extrabold ${rankClass(shownRank)}`}>
                    {shownRank}
                  </span>
                </td>
                <th scope="row" className="sticky left-14 z-10 min-w-48 border-b border-r border-cool-veil bg-warm-white px-4 py-3 text-left font-normal shadow-[4px_0_8px_-4px_rgba(11,37,69,0.12)] group-hover:bg-sailcloth">
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
                  <ScoreBreakdown sailor={sailor} qualifiers={qualifiers} totalFleetSize={totalFleetSize} anchorName={anchorName} anchorSlug={anchorSlug} />
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
                {viewMode === "points" ? (
                  <>
                    <td className="border-b border-cool-veil px-3 py-3 text-right">
                      <div className="text-base font-extrabold tabular-nums text-harbour">{sailor.provisionalScore.toFixed(2)}</div>
                      <div className="text-[11px] font-medium text-slate-soft">
                        {sailor.countedResultsCount} counted · {sailor.eligibleStarts} {sailor.eligibleStarts === 1 ? "start" : "starts"}
                      </div>
                    </td>
                    <td className="border-b border-cool-veil px-3 py-3 text-right">
                      <div className="text-sm font-extrabold tabular-nums text-harbour">{sailor.powerRating ?? "—"}</div>
                      {sailor.powerRank ? (
                        <div className="text-[11px] font-medium text-slate-soft">#{sailor.powerRank}</div>
                      ) : null}
                    </td>
                  </>
                ) : (
                  <>
                    <td className="border-b border-cool-veil px-3 py-3 text-right">
                      <div className="text-base font-extrabold tabular-nums text-harbour">{sailor.powerRating ?? "—"}</div>
                      {sailor.powerRank ? (
                        <div className="text-[11px] font-medium text-slate-soft">Overall #{sailor.powerRank}</div>
                      ) : null}
                    </td>
                    <td className="border-b border-cool-veil px-3 py-3 text-right">
                      <div className="text-sm font-bold tabular-nums text-harbour">{sailor.provisionalScore.toFixed(2)}</div>
                      <div className="text-[11px] font-medium text-slate-soft">
                        {sailor.countedResultsCount} counted
                      </div>
                    </td>
                  </>
                )}
                <td className="border-b border-r border-cool-veil px-3 py-3 text-center">
                  {momentumPill(sailor.momentumDelta)}
                </td>
                {g200Cols.map((qualifier) => {
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
                      className="border-b border-cool-veil bg-harbour/[0.03] px-2.5 py-3 text-center text-xs tabular-nums"
                    >
                      {res ? (
                        <span className={res.counted ? "inline-flex items-center rounded-md bg-aqua-mist/60 px-1.5 py-0.5 font-extrabold text-harbour ring-1 ring-harbour/15" : "font-medium text-slate-soft/70"}>
                          {res.rank}/{res.qualifier.fleetSize}
                        </span>
                      ) : (
                        <span className="text-slate-soft/50">—</span>
                      )}
                    </td>
                  );
                })}
                {hasAnchor ? (
                <td
                  title={sailor.overallPlace != null ? `${sailor.displayName} · ${anchorName}: ${sailor.overallPlace} of ${totalFleetSize}${anchorCounted ? " · Counted" : ""}` : "No finish recorded"}
                  className="border-b border-cool-veil bg-harbour/[0.02] px-2.5 py-3 text-center text-xs tabular-nums"
                >
                  {sailor.overallPlace != null ? (
                    <span className={anchorCounted ? "inline-flex items-center rounded-md bg-aqua-mist/60 px-1.5 py-0.5 font-extrabold text-harbour ring-1 ring-harbour/15" : "font-medium text-slate-soft/70"}>
                      {sailor.overallPlace}/{totalFleetSize}
                    </span>
                  ) : (
                    <span className="text-slate-soft/50">—</span>
                  )}
                </td>
                ) : null}
                {nonG200Cols.map((qualifier) => {
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
                      className={`border-b border-cool-veil ${bg} px-2.5 py-3 text-center text-xs tabular-nums`}
                    >
                      {res ? (
                        <span className={res.counted ? "inline-flex items-center rounded-md bg-aqua-mist/60 px-1.5 py-0.5 font-extrabold text-harbour ring-1 ring-harbour/15" : "font-medium text-slate-soft/70"}>
                          {res.rank}/{res.qualifier.fleetSize}
                        </span>
                      ) : (
                        <span className="text-slate-soft/50">—</span>
                      )}
                    </td>
                  );
                })}
              </tr>
              );
            })}
            {filteredEntries.length === 0 ? (
              <tr>
                <td colSpan={8 + qualifierColumns.length + (hasAnchor ? 1 : 0)} className="border-b border-cool-veil px-4 py-10 text-center text-sm font-semibold text-slate-soft">
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
