"use client";

import { useMemo, useState } from "react";
import Link from "next/link";
import {
  computeIlcaRankings,
  ilcaSquadCutoff,
  selectIlca4NationalSquad,
  ILCA_POLICY_NOTES,
  type IlcaIntakeKind,
} from "@/lib/ilcaRanking";
import { ILCA4_NATIONAL_RANKING_NAMES } from "@/lib/ilca4NationalList";
import { Trophy, Users } from "lucide-react";

export type IlcaPublicSailor = {
  id: string;
  name: string;
  handle?: string | null;
  gender?: string | null;
  dob?: string | null;
  nationality?: string | null;
  sailNumber?: string | null;
  sailNumberIlca4?: string | null;
  club?: string | null;
};

export type IlcaPublicRegatta = {
  id: string;
  name: string;
  date: string;
  totalFleetSize: number;
  boatClass?: string | null;
  countsForRanking?: boolean | null;
};

export type IlcaPublicResult = {
  sailorId: string;
  regattaId: string;
  rank: number;
  isDns?: boolean | null;
  isOverseasCommitment?: boolean | null;
};

type Props = {
  sailors: IlcaPublicSailor[];
  regattas: IlcaPublicRegatta[];
  results: IlcaPublicResult[];
};

export function IlcaRankingsView({ sailors, regattas, results }: Props) {
  const now = new Date();
  const y = now.getFullYear();
  const [intakeKind, setIntakeKind] = useState<IlcaIntakeKind>(
    now.getMonth() < 6 ? "january" : "july"
  );
  const [intakeYear, setIntakeYear] = useState(
    intakeKind === "january" && now.getMonth() === 11 ? y + 1 : y
  );
  const [genderFilter, setGenderFilter] = useState<"all" | "M" | "F">("all");

  const cutoff = useMemo(
    () => ilcaSquadCutoff(intakeKind, intakeYear),
    [intakeKind, intakeYear]
  );

  const ranked = useMemo(
    () =>
      computeIlcaRankings(
        "ILCA 4",
        cutoff.asOf,
        sailors.map((s) => ({
          id: s.id,
          name: s.name,
          gender: s.gender,
          dob: s.dob,
          nationality: s.nationality,
          sailNumber: s.sailNumber,
          sailNumberIlca4: s.sailNumberIlca4,
          club: s.club,
          handle: s.handle,
        })),
        regattas,
        results,
        { intakeYear: cutoff.intakeYear, restrictToNationalList: true }
      ),
    [cutoff, sailors, regattas, results]
  );

  const filtered = useMemo(() => {
    if (genderFilter === "all") return ranked;
    return ranked.filter((r) => r.gender === genderFilter);
  }, [ranked, genderFilter]);

  const squad = useMemo(
    () => selectIlca4NationalSquad(ranked),
    [ranked]
  );

  const handleById = useMemo(() => {
    const m = new Map<string, string>();
    for (const s of sailors) {
      if (s.handle) m.set(s.id, s.handle);
    }
    return m;
  }, [sailors]);

  return (
    <div className="mx-auto max-w-6xl px-4 sm:px-6 py-8 sm:py-10 space-y-6">
      <div className="space-y-2">
        <div className="inline-flex items-center gap-2 rounded-full border border-sky-500/20 bg-sky-500/10 px-3 py-1 text-[11px] font-bold text-sky-300">
          <Trophy className="h-3.5 w-3.5" />
          SG ILCA 4 · High Ranking Points
        </div>
        <h1 className="text-2xl sm:text-3xl font-black text-white tracking-tight">
          ILCA 4 national standings
        </h1>
        <p className="text-sm text-slate-400 max-w-3xl leading-relaxed">
          {ILCA_POLICY_NOTES.highPoints} {ILCA_POLICY_NOTES.nationalList} Squad
          shortlist: SGP nationality only.
        </p>
      </div>

      <div className="flex flex-wrap gap-3 items-end">
        <label className="text-xs text-slate-400">
          Intake
          <select
            className="mt-1 block rounded-lg bg-slate-900 border border-white/10 text-white px-3 py-2 text-xs min-w-[12rem]"
            value={intakeKind}
            onChange={(e) => setIntakeKind(e.target.value as IlcaIntakeKind)}
          >
            <option value="july">July (as of 30 Jun)</option>
            <option value="january">January (as of 20 Dec)</option>
          </select>
        </label>
        <label className="text-xs text-slate-400">
          Intake year
          <input
            type="number"
            min={2022}
            max={2040}
            className="mt-1 block rounded-lg bg-slate-900 border border-white/10 text-white px-3 py-2 text-xs w-28"
            value={intakeYear}
            onChange={(e) => setIntakeYear(Number(e.target.value) || y)}
          />
        </label>
        <label className="text-xs text-slate-400">
          Gender
          <select
            className="mt-1 block rounded-lg bg-slate-900 border border-white/10 text-white px-3 py-2 text-xs"
            value={genderFilter}
            onChange={(e) =>
              setGenderFilter(e.target.value as "all" | "M" | "F")
            }
          >
            <option value="all">All</option>
            <option value="M">Male</option>
            <option value="F">Female</option>
          </select>
        </label>
        <p className="text-[11px] text-sky-300/90 font-medium pb-2">
          {cutoff.label} · {filtered.length} of {ranked.length} on list · Best 3
          of last 5 ≤ {cutoff.asOf}
        </p>
      </div>

      <div className="grid grid-cols-1 xl:grid-cols-5 gap-4">
        <div className="xl:col-span-3 rounded-2xl border border-white/5 bg-[#0f1118] overflow-hidden">
          <div className="px-4 py-3 border-b border-white/5">
            <h2 className="text-xs font-bold text-white uppercase tracking-wider">
              National ranking list
            </h2>
            <p className="text-[10px] text-slate-500 mt-0.5">
              {ILCA4_NATIONAL_RANKING_NAMES.length} authorised names · scores
              only for sailors with ranking results
            </p>
          </div>
          {filtered.length === 0 ? (
            <p className="p-6 text-sm text-slate-500 text-center">
              No ILCA 4 ranking results on or before {cutoff.asOf} for listed
              sailors. Import ILCA 4 regattas to populate scores.
            </p>
          ) : (
            <div className="overflow-x-auto max-h-[40rem] overflow-y-auto">
              <table className="w-full text-left text-xs">
                <thead className="sticky top-0 bg-[#131520] z-10">
                  <tr className="text-[10px] uppercase tracking-wide text-slate-500 border-b border-white/5">
                    <th className="px-3 py-2 font-bold">#</th>
                    <th className="px-3 py-2 font-bold">Sailor</th>
                    <th className="px-3 py-2 font-bold">G</th>
                    <th className="px-3 py-2 font-bold">Birth year</th>
                    <th className="px-3 py-2 font-bold">Best 3 pts</th>
                    <th className="px-3 py-2 font-bold">Total</th>
                  </tr>
                </thead>
                <tbody className="divide-y divide-white/5">
                  {filtered.map((r) => {
                    const handle = handleById.get(r.sailorId);
                    return (
                      <tr
                        key={r.sailorId}
                        className={
                          r.rank <= 25 ? "text-slate-200" : "text-slate-500"
                        }
                      >
                        <td className="px-3 py-2 tabular-nums font-bold text-white">
                          {r.rank}
                        </td>
                        <td className="px-3 py-2 font-semibold text-white">
                          {handle ? (
                            <Link
                              href={`/${handle}`}
                              className="hover:text-sky-300"
                            >
                              {r.name}
                            </Link>
                          ) : (
                            r.name
                          )}
                        </td>
                        <td className="px-3 py-2">{r.gender || "—"}</td>
                        <td className="px-3 py-2 tabular-nums">
                          {r.birthYear ?? "—"}
                        </td>
                        <td className="px-3 py-2 tabular-nums text-slate-400">
                          {r.bestThreePoints.join(" + ")}
                        </td>
                        <td className="px-3 py-2 tabular-nums font-bold text-sky-400">
                          {r.totalPoints}
                        </td>
                      </tr>
                    );
                  })}
                </tbody>
              </table>
            </div>
          )}
        </div>

        <div className="xl:col-span-2 rounded-2xl border border-white/5 bg-[#0f1118] overflow-hidden">
          <div className="px-4 py-3 border-b border-white/5 flex items-center gap-2">
            <Users className="h-4 w-4 text-orange-400" />
            <h2 className="text-xs font-bold text-white uppercase tracking-wider">
              National squad shortlist
            </h2>
          </div>
          {squad.length === 0 ? (
            <p className="p-4 text-xs text-slate-500">
              No eligible SGP sailors yet (need results, top 25, and SGP
              nationality).
            </p>
          ) : (
            <ol className="divide-y divide-white/5 max-h-[40rem] overflow-y-auto">
              {squad.map((s, i) => (
                <li
                  key={s.sailorId}
                  className="px-4 py-2.5 flex items-start justify-between gap-2 text-xs"
                >
                  <span>
                    <span className="text-slate-500 tabular-nums mr-2">
                      {i + 1}.
                    </span>
                    <span className="font-semibold text-white">{s.name}</span>
                    <span className="block text-[10px] text-slate-500 mt-0.5">
                      Series #{s.rankingPosition} · {s.gender} · {s.totalPoints}{" "}
                      pts
                    </span>
                  </span>
                </li>
              ))}
            </ol>
          )}
          <p className="px-4 py-2 text-[9px] text-slate-600 border-t border-white/5">
            {ILCA_POLICY_NOTES.squad}
          </p>
        </div>
      </div>
    </div>
  );
}
