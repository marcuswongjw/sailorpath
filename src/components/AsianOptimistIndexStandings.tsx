import Link from "next/link";
import type { AsianOptimistIndexProvisionalEntry } from "@/lib/asianOptimistIndexScoring";

export type AsianOptimistIndexFilterState = {
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

function qualifierRank(
  entry: AsianOptimistIndexProvisionalEntry,
  qualifierId: string
): string {
  const result = entry.qualifierResults.find(
    (qualifier) =>
      qualifier.qualifier.id === qualifierId ||
      qualifier.qualifier.id.startsWith(qualifierId)
  );
  return result ? `${result.rank}/${result.qualifier.fleetSize}` : "—";
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
  const filtersActive = country !== "all" || gender !== "all" || birthYear !== "all";

  const g150Cols = qualifierColumns.filter((col) => col.grade === 150);
  const g75Cols = qualifierColumns.filter((col) => col.grade === 75);
  const g40Cols = qualifierColumns.filter((col) => col.grade === 40);

  return (
    <div className="overflow-hidden rounded-2xl border border-cool-veil bg-warm-white shadow-sm">
      <div className="flex flex-col gap-4 border-b border-cool-veil px-5 py-5 sm:px-6">
        <div className="flex flex-col gap-2 sm:flex-row sm:items-end sm:justify-between">
          <div>
            <h2 className="text-xl font-extrabold text-harbour">Standings · V1 (Beta)</h2>
            <p className="mt-1 text-sm text-slate-soft">
              Ordered by total Index points calculated under the V1 (Beta) methodology. Cells show finish / fleet size in designated premier competitions; a dash indicates no verified finish.
            </p>
          </div>
          <p className="text-xs font-semibold text-slate-soft">Calculated through {asOf}</p>
        </div>

        <form
          action="/optimist/asian-index"
          method="get"
          className="grid gap-3 sm:grid-cols-3"
          aria-label="Filter standings"
        >
          <label className="grid gap-1.5 text-xs font-bold uppercase tracking-wide text-slate-soft">
            Country
            <select
              name="country"
              defaultValue={country}
              className="min-h-10 rounded-lg border border-cool-veil bg-white px-3 text-sm font-semibold normal-case tracking-normal text-harbour outline-none transition focus:border-aqua focus:ring-2 focus:ring-aqua/25"
            >
              <option value="all">All countries</option>
              {countries.map((code) => (
                <option key={code} value={code}>{code}</option>
              ))}
            </select>
          </label>
          <label className="grid gap-1.5 text-xs font-bold uppercase tracking-wide text-slate-soft">
            Gender
            <select
              name="gender"
              defaultValue={gender}
              className="min-h-10 rounded-lg border border-cool-veil bg-white px-3 text-sm font-semibold normal-case tracking-normal text-harbour outline-none transition focus:border-aqua focus:ring-2 focus:ring-aqua/25"
            >
              <option value="all">All genders</option>
              <option value="M">M</option>
              <option value="F">F</option>
            </select>
          </label>
          <label className="grid gap-1.5 text-xs font-bold uppercase tracking-wide text-slate-soft">
            Birth year
            <select
              name="birthYear"
              defaultValue={birthYear}
              className="min-h-10 rounded-lg border border-cool-veil bg-white px-3 text-sm font-semibold normal-case tracking-normal text-harbour outline-none transition focus:border-aqua focus:ring-2 focus:ring-aqua/25"
            >
              <option value="all">All birth years</option>
              {birthYears.map((year) => (
                <option key={year} value={year}>{year}</option>
              ))}
              <option value="unknown">Not recorded</option>
            </select>
          </label>
          <div className="flex flex-wrap items-center gap-3 sm:col-span-3">
            <button
              type="submit"
              className="rounded-lg bg-harbour px-4 py-2.5 text-sm font-extrabold text-white transition-colors hover:bg-harbour-mid"
            >
              Apply filters
            </button>
            {filtersActive ? (
              <Link href="/optimist/asian-index" className="text-sm font-bold text-harbour underline underline-offset-4 hover:text-racing-deep">
                Clear filters
              </Link>
            ) : null}
          </div>
        </form>

        <p className="text-sm font-semibold text-slate-soft">
          Showing <span className="font-extrabold text-harbour">{filteredEntries.length}</span> of {entries.length} sailors
        </p>
      </div>

      <div className="overflow-x-auto">
        <table className="w-full min-w-[1380px] border-collapse text-left text-sm">
          <thead className="text-xs uppercase tracking-wide text-slate-soft">
            <tr className="border-b border-cool-veil bg-warm-white text-[11px] font-extrabold">
              <th colSpan={5} className="border-r border-cool-veil px-4 py-2 text-left text-slate-soft">
                Competitor details
              </th>
              <th className="border-r border-cool-veil px-4 py-2 text-right text-harbour">
                Score
              </th>
              <th colSpan={1 + g150Cols.length} className="border-r border-cool-veil bg-harbour/10 px-4 py-2 text-center text-harbour">
                Grade 150 · Championships <span className="normal-case font-medium text-slate-soft">(max 2)</span>
              </th>
              <th colSpan={g75Cols.length} className="border-r border-cool-veil bg-aqua/10 px-4 py-2 text-center text-harbour">
                Grade 75 · International Opens <span className="normal-case font-medium text-slate-soft">(max 1/host)</span>
              </th>
              <th colSpan={Math.max(g40Cols.length, 1)} className="bg-amber-500/10 px-4 py-2 text-center text-harbour">
                Grade 40 · Nationals <span className="normal-case font-medium text-slate-soft">(max 1/country/yr)</span>
              </th>
            </tr>
            <tr className="border-b border-cool-veil bg-sailcloth font-bold">
              <th scope="col" className="px-4 py-2.5 font-extrabold text-harbour">Index</th>
              <th scope="col" className="px-4 py-2.5 font-extrabold text-harbour">Sailor</th>
              <th scope="col" className="px-4 py-2.5 font-extrabold text-harbour">Country</th>
              <th scope="col" className="px-4 py-2.5 font-extrabold text-harbour">Gender</th>
              <th scope="col" className="px-4 py-2.5 text-center font-extrabold text-harbour">Birth year</th>
              <th scope="col" className="border-r border-cool-veil px-4 py-2.5 text-right font-extrabold text-harbour">Points</th>
              <th scope="col" className="bg-harbour/5 px-4 py-2.5 text-center font-extrabold text-harbour">
                <div>2025 Asians</div>
                <div className="mt-0.5">
                  <span className="inline-block rounded bg-harbour/20 px-1.5 py-0.5 text-[10px] font-black text-harbour">G150 · 170</span>
                </div>
              </th>
              {qualifierColumns.map((qualifier) => {
                const isG150 = qualifier.grade === 150;
                const isG75 = qualifier.grade === 75;
                const bg = isG150 ? "bg-harbour/5" : isG75 ? "bg-aqua/5" : "bg-amber-500/5";
                const badgeBg = isG150
                  ? "bg-harbour/20 text-harbour"
                  : isG75
                    ? "bg-aqua/20 text-harbour"
                    : "bg-amber-500/20 text-amber-900";
                const gradeLabel = qualifier.grade ? `G${qualifier.grade}` : "";

                return (
                  <th key={qualifier.id} scope="col" className={`${bg} px-4 py-2.5 text-center font-extrabold text-harbour`}>
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
          <tbody className="divide-y divide-cool-veil">
            {filteredEntries.map((sailor) => (
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
                <td className="px-4 py-3 text-xs font-semibold text-charcoal">{sailor.nationality}</td>
                <td className="px-4 py-3 text-xs font-semibold text-charcoal">{genderCode(sailor.gender)}</td>
                <td className="px-4 py-3 text-center text-xs font-semibold text-charcoal">{sailor.birthYear ?? "—"}</td>
                <td className="border-r border-cool-veil px-4 py-3 text-right text-base font-extrabold text-harbour">{sailor.provisionalScore.toFixed(2)}</td>
                <td className="bg-harbour/[0.02] px-4 py-3 text-center font-bold text-harbour">
                  {sailor.overallPlace != null ? `${sailor.overallPlace}/${totalFleetSize}` : "—"}
                </td>
                {qualifierColumns.map((qualifier) => {
                  const isG150 = qualifier.grade === 150;
                  const isG75 = qualifier.grade === 75;
                  const bg = isG150 ? "bg-harbour/[0.02]" : isG75 ? "bg-aqua/[0.02]" : "bg-amber-500/[0.02]";
                  return (
                    <td key={qualifier.id} className={`${bg} px-4 py-3 text-center text-xs font-semibold text-charcoal`}>
                      {qualifierRank(sailor, qualifier.id)}
                    </td>
                  );
                })}
              </tr>
            ))}
            {filteredEntries.length === 0 ? (
              <tr>
                <td colSpan={7 + qualifierColumns.length} className="px-4 py-10 text-center text-sm font-semibold text-slate-soft">
                  No sailors match the selected filters.
                </td>
              </tr>
            ) : null}
          </tbody>
        </table>
      </div>
    </div>
  );
}
