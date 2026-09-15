import Link from "next/link";
import { DbOffline } from "@/components/DbOffline";
import { searchSailors } from "@/lib/queries";
import { DbUnavailableError } from "@/db";
import { seriesMembershipLabel } from "@/lib/seriesMembership";
import { SearchNationalityField } from "@/components/SearchNationalityField";
import type { Metadata } from "next";

export const metadata: Metadata = {
  title: "Find a sailor profile | SailorPath",
  description: "Search SailorPath by sailor name, sail number, club, school, fleet, or nationality.",
};

export const dynamic = "force-dynamic";

export default async function SearchPage({
  searchParams,
}: {
  searchParams: Promise<{
    query?: string;
    fleet?: string;
    squad?: string;
    nationality?: string;
    club?: string;
    school?: string;
    birthFrom?: string;
    birthTo?: string;
  }>;
}) {
  const sp = await searchParams;
  const query = sp.query || "";
  const fleet = sp.fleet || "all";
  const squad = sp.squad || "all";
  const nationality = sp.nationality || "";
  const club = sp.club || "";
  const school = sp.school || "";
  const birthFrom = sp.birthFrom ? Number(sp.birthFrom) : undefined;
  const birthTo = sp.birthTo ? Number(sp.birthTo) : undefined;

  const hasAny =
    query.trim() ||
    (fleet && fleet !== "all") ||
    (squad && squad !== "all") ||
    nationality.trim() ||
    club.trim() ||
    school.trim() ||
    birthFrom ||
    birthTo;

  let results: Awaited<ReturnType<typeof searchSailors>> = [];
  let offline = false;
  let msg = "";

  if (hasAny) {
    try {
      results = await searchSailors({
        query,
        fleet,
        squad,
        nationality,
        club,
        school,
        birthYearFrom: birthFrom,
        birthYearTo: birthTo,
      });
    } catch (e) {
      offline = true;
      msg = e instanceof DbUnavailableError ? e.message : "DB error";
    }
  }

  if (offline) return <DbOffline message={msg} />;

  return (
    <div className="mx-auto max-w-3xl px-4 py-12 space-y-6">
      <h1 className="text-2xl sm:text-3xl font-black text-[var(--sp-harbour-shadow)] tracking-tight">Search sailors</h1>

      <form className="rounded-2xl border border-[var(--sp-cool-veil)] bg-[var(--sp-warm-white)] p-5 shadow-xs space-y-4">
        <input
          name="query"
          defaultValue={query}
          placeholder="Name, sail number, club, school…"
          className="sp-input w-full text-sm"
        />
        <div className="grid grid-cols-2 sm:grid-cols-3 gap-3">
          <label className="text-[11px] font-bold text-[var(--sp-slate-soft)] uppercase tracking-wider">
            Fleet
            <select
              name="fleet"
              defaultValue={fleet}
              className="mt-1.5 sp-select w-full text-xs"
            >
              <option value="all">All</option>
              <option value="gold">Gold (active now)</option>
              <option value="silver">Silver (active now)</option>
              <option value="guest">Not on current board</option>
            </select>
          </label>
          <label className="text-[11px] font-bold text-[var(--sp-slate-soft)] uppercase tracking-wider">
            Squad
            <select
              name="squad"
              defaultValue={squad}
              className="mt-1.5 sp-select w-full text-xs"
            >
              <option value="all">All</option>
              <option value="Nat A">Nat A</option>
              <option value="Nat B">Nat B</option>
              <option value="DS">DS</option>
            </select>
          </label>
          <label className="text-[11px] font-bold text-[var(--sp-slate-soft)] uppercase tracking-wider col-span-2 sm:col-span-1">
            Nationality
            <div className="mt-1.5">
              <SearchNationalityField defaultValue={nationality} />
            </div>
          </label>
          <label className="text-[11px] font-bold text-[var(--sp-slate-soft)] uppercase tracking-wider">
            Club
            <input
              name="club"
              defaultValue={club}
              className="mt-1.5 sp-input w-full text-xs"
            />
          </label>
          <label className="text-[11px] font-bold text-[var(--sp-slate-soft)] uppercase tracking-wider">
            School
            <input
              name="school"
              defaultValue={school}
              className="mt-1.5 sp-input w-full text-xs"
            />
          </label>
          <label className="text-[11px] font-bold text-[var(--sp-slate-soft)] uppercase tracking-wider">
            Birth year from–to
            <div className="mt-1.5 flex gap-1.5">
              <input
                name="birthFrom"
                type="number"
                placeholder="2010"
                defaultValue={sp.birthFrom || ""}
                className="sp-input w-full text-xs font-mono"
              />
              <input
                name="birthTo"
                type="number"
                placeholder="2015"
                defaultValue={sp.birthTo || ""}
                className="sp-input w-full text-xs font-mono"
              />
            </div>
          </label>
        </div>
        <button
          type="submit"
          className="sp-btn-primary px-6 py-2.5 text-xs font-bold"
        >
          Search
        </button>
      </form>

      {hasAny && (
        <p className="text-xs font-medium text-[var(--sp-slate-soft)]">{results.length} result(s)</p>
      )}
      <ul className="space-y-2">
        {results.map((s) => {
          const fleetLabel = seriesMembershipLabel(s);
          return (
            <li key={s.id}>
              <Link
                href={`/${s.handle}`}
                className="block rounded-xl px-4 py-3 border border-[var(--sp-cool-veil)] bg-[var(--sp-warm-white)] shadow-xs hover:border-[var(--sp-harbour-teal)] transition-colors"
              >
                <span className="font-bold text-[var(--sp-harbour-shadow)]">{s.name}</span>
                <span className="text-xs text-[var(--sp-slate-soft)] ml-2">
                  {s.sailNumber} · {s.club}
                  {s.nationality ? ` · ${s.nationality}` : ""}
                </span>
                <span className="ml-2 text-[10px] font-bold text-[var(--sp-racing-orange)]">
                  {fleetLabel}
                  {s.nationalSquadStatus ? ` · ${s.nationalSquadStatus}` : ""}
                </span>
              </Link>
            </li>
          );
        })}
      </ul>
      {hasAny && results.length === 0 && (
        <p className="text-sm text-[var(--sp-slate-soft)]">No sailors match these filters.</p>
      )}
    </div>
  );
}
