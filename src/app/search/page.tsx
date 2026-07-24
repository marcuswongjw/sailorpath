import Link from "next/link";
import { DbOffline } from "@/components/DbOffline";
import { searchSailors } from "@/lib/queries";
import { DbUnavailableError } from "@/db";
import { seriesMembershipLabel } from "@/lib/seriesMembership";

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
      <h1 className="text-2xl font-black text-white">Search sailors</h1>

      <form className="glass-panel rounded-2xl border border-white/5 p-4 space-y-3">
        <input
          name="query"
          defaultValue={query}
          placeholder="Name, sail number, club, school…"
          className="w-full rounded-xl bg-slate-950 border border-white/10 px-4 py-3 text-sm text-white focus:border-orange-500 focus:outline-none"
        />
        <div className="grid grid-cols-2 sm:grid-cols-3 gap-2">
          <label className="text-[10px] font-bold text-slate-500 uppercase">
            Fleet
            <select
              name="fleet"
              defaultValue={fleet}
              className="mt-1 w-full rounded-lg bg-slate-950 border border-white/10 px-2 py-2 text-xs text-white"
            >
              <option value="all">All</option>
              <option value="gold">Gold (active now)</option>
              <option value="silver">Silver (active now)</option>
              <option value="guest">Guest / not ranked</option>
            </select>
          </label>
          <label className="text-[10px] font-bold text-slate-500 uppercase">
            Squad
            <select
              name="squad"
              defaultValue={squad}
              className="mt-1 w-full rounded-lg bg-slate-950 border border-white/10 px-2 py-2 text-xs text-white"
            >
              <option value="all">All</option>
              <option value="Nat A">Nat A</option>
              <option value="Nat B">Nat B</option>
              <option value="DS">DS</option>
            </select>
          </label>
          <label className="text-[10px] font-bold text-slate-500 uppercase">
            Nationality
            <input
              name="nationality"
              defaultValue={nationality}
              placeholder="SGP, MAS…"
              className="mt-1 w-full rounded-lg bg-slate-950 border border-white/10 px-2 py-2 text-xs text-white"
            />
          </label>
          <label className="text-[10px] font-bold text-slate-500 uppercase">
            Club
            <input
              name="club"
              defaultValue={club}
              className="mt-1 w-full rounded-lg bg-slate-950 border border-white/10 px-2 py-2 text-xs text-white"
            />
          </label>
          <label className="text-[10px] font-bold text-slate-500 uppercase">
            School
            <input
              name="school"
              defaultValue={school}
              className="mt-1 w-full rounded-lg bg-slate-950 border border-white/10 px-2 py-2 text-xs text-white"
            />
          </label>
          <label className="text-[10px] font-bold text-slate-500 uppercase">
            Birth year from–to
            <div className="mt-1 flex gap-1">
              <input
                name="birthFrom"
                type="number"
                placeholder="2010"
                defaultValue={sp.birthFrom || ""}
                className="w-full rounded-lg bg-slate-950 border border-white/10 px-2 py-2 text-xs text-white font-mono"
              />
              <input
                name="birthTo"
                type="number"
                placeholder="2015"
                defaultValue={sp.birthTo || ""}
                className="w-full rounded-lg bg-slate-950 border border-white/10 px-2 py-2 text-xs text-white font-mono"
              />
            </div>
          </label>
        </div>
        <button
          type="submit"
          className="rounded-full bg-orange-600 px-5 py-2.5 text-xs font-bold text-white hover:bg-orange-500"
        >
          Search
        </button>
      </form>

      {hasAny && (
        <p className="text-xs text-slate-500">{results.length} result(s)</p>
      )}
      <ul className="space-y-2">
        {results.map((s) => {
          const fleetLabel = seriesMembershipLabel(s);
          return (
            <li key={s.id}>
              <Link
                href={`/${s.handle}`}
                className="block glass-card rounded-xl px-4 py-3 border border-white/5 hover:border-orange-500/30"
              >
                <span className="font-bold text-white">{s.name}</span>
                <span className="text-xs text-slate-400 ml-2">
                  {s.sailNumber} · {s.club}
                  {s.nationality ? ` · ${s.nationality}` : ""}
                </span>
                <span className="ml-2 text-[10px] font-bold text-orange-400/90">
                  {fleetLabel}
                  {s.nationalSquadStatus ? ` · ${s.nationalSquadStatus}` : ""}
                </span>
              </Link>
            </li>
          );
        })}
      </ul>
      {hasAny && results.length === 0 && (
        <p className="text-sm text-slate-500">No sailors match these filters.</p>
      )}
    </div>
  );
}
