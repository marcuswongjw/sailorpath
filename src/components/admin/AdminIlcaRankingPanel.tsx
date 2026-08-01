"use client";

import { useMemo, useState } from "react";
import {
  computeIlcaRankings,
  ilcaSquadCutoff,
  selectIlca4NationalSquad,
  ILCA_POLICY_NOTES,
  type IlcaBoatClass,
  type IlcaIntakeKind,
} from "@/lib/ilcaRanking";
import type { SailorAdmin } from "@/types/sailor";
import type { RegattaAdmin } from "@/types/regatta";
import type { ResultAdmin } from "@/types/result";
import { Trophy, Users } from "lucide-react";

type Props = {
  sailors: SailorAdmin[];
  regattas: RegattaAdmin[];
  results: ResultAdmin[];
};

const REASON_LABEL: Record<string, string> = {
  top2_overall: "Top 2 overall",
  age16: "Intake bucket 16",
  age15_or_under: "Intake bucket ≤15",
  fill_same_gender: "Fill (same gender)",
};

export function AdminIlcaRankingPanel({
  sailors,
  regattas,
  results,
}: Props) {
  const now = new Date();
  const y = now.getFullYear();
  const [boatClass, setBoatClass] = useState<IlcaBoatClass>("ILCA 4");
  const [intakeKind, setIntakeKind] = useState<IlcaIntakeKind>(
    now.getMonth() < 6 ? "january" : "july"
  );
  const [intakeYear, setIntakeYear] = useState(
    intakeKind === "january" && now.getMonth() === 11 ? y + 1 : y
  );

  const cutoff = useMemo(
    () => ilcaSquadCutoff(intakeKind, intakeYear),
    [intakeKind, intakeYear]
  );

  const ranked = useMemo(
    () =>
      computeIlcaRankings(
        boatClass,
        cutoff.asOf,
        sailors.map((s) => ({
          id: s.id,
          name: s.name,
          gender: s.gender,
          dob: s.dob,
          nationality: s.nationality,
          sailNumber: s.sailNumber,
          sailNumberIlca4: (s as { sailNumberIlca4?: string | null })
            .sailNumberIlca4,
          club: s.club,
          handle: s.handle,
        })),
        regattas,
        results,
        { intakeYear: cutoff.intakeYear, restrictToNationalList: true }
      ),
    [boatClass, cutoff, sailors, regattas, results]
  );

  const squad = useMemo(
    () =>
      boatClass === "ILCA 4" ? selectIlca4NationalSquad(ranked) : [],
    [boatClass, ranked]
  );

  return (
    <div className="w-full min-w-0 space-y-6">
      <div className="glass-panel rounded-3xl border border-white/5 p-5 sm:p-6 space-y-3">
        <div className="flex items-start gap-3">
          <div className="flex h-10 w-10 shrink-0 items-center justify-center rounded-xl bg-sky-500/15">
            <Trophy className="h-5 w-5 text-sky-400" />
          </div>
          <div>
            <h2 className="text-base font-bold text-white">
              ILCA high-points ranking
            </h2>
            <p className="text-[12px] text-slate-400 mt-1 max-w-3xl leading-relaxed">
              {ILCA_POLICY_NOTES.highPoints}
            </p>
            <p className="text-[11px] text-slate-500 mt-1 max-w-3xl">
              {ILCA_POLICY_NOTES.dualSail}
            </p>
          </div>
        </div>

        <div className="grid grid-cols-1 sm:grid-cols-3 gap-3">
          <label className="text-xs text-slate-400">
            Class
            <select
              className="mt-1 w-full rounded-lg bg-slate-900 border border-white/10 text-white px-3 py-2 text-xs"
              value={boatClass}
              onChange={(e) =>
                setBoatClass(e.target.value as IlcaBoatClass)
              }
            >
              <option value="ILCA 4">ILCA 4</option>
              <option value="ILCA 6">ILCA 6</option>
            </select>
          </label>
          <label className="text-xs text-slate-400">
            Intake
            <select
              className="mt-1 w-full rounded-lg bg-slate-900 border border-white/10 text-white px-3 py-2 text-xs"
              value={intakeKind}
              onChange={(e) =>
                setIntakeKind(e.target.value as IlcaIntakeKind)
              }
            >
              <option value="july">July intake (as of 30 Jun)</option>
              <option value="january">January intake (as of 20 Dec)</option>
            </select>
          </label>
          <label className="text-xs text-slate-400">
            Intake year
            <input
              type="number"
              min={2022}
              max={2040}
              className="mt-1 w-full rounded-lg bg-slate-900 border border-white/10 text-white px-3 py-2 text-xs"
              value={intakeYear}
              onChange={(e) =>
                setIntakeYear(Number(e.target.value) || y)
              }
            />
          </label>
        </div>
        <p className="text-[11px] text-sky-300/90 font-medium">
          {cutoff.label} · {ranked.length} ranked sailors · Best 3 of last 5
          ranking events ≤ {cutoff.asOf}
        </p>
      </div>

      <div className="grid grid-cols-1 xl:grid-cols-5 gap-4">
        <div className="xl:col-span-3 glass-panel rounded-2xl border border-white/5 overflow-hidden">
          <div className="px-4 py-3 border-b border-white/5">
            <h3 className="text-xs font-bold text-white uppercase tracking-wider">
              {boatClass} series ranking
            </h3>
          </div>
          {ranked.length === 0 ? (
            <p className="p-6 text-sm text-slate-500 text-center">
              No {boatClass} ranking results on or before {cutoff.asOf}.
              Import ILCA regattas with Class = {boatClass}.
            </p>
          ) : (
            <div className="overflow-x-auto max-h-[32rem] overflow-y-auto">
              <table className="w-full text-left text-xs">
                <thead className="sticky top-0 bg-[#131520]">
                  <tr className="text-[10px] uppercase tracking-wide text-slate-500 border-b border-white/5">
                    <th className="px-3 py-2 font-bold">#</th>
                    <th className="px-3 py-2 font-bold">Sailor</th>
                    <th className="px-3 py-2 font-bold">Gender</th>
                    <th className="px-3 py-2 font-bold">Birth year</th>
                    <th className="px-3 py-2 font-bold">Best 3 pts</th>
                    <th className="px-3 py-2 font-bold">Total</th>
                    <th className="px-3 py-2 font-bold">Events</th>
                  </tr>
                </thead>
                <tbody className="divide-y divide-white/5">
                  {ranked.map((r) => (
                    <tr
                      key={r.sailorId}
                      className={
                        r.rank <= 25
                          ? "text-slate-200"
                          : "text-slate-500"
                      }
                    >
                      <td className="px-3 py-2 tabular-nums font-bold text-white">
                        {r.rank}
                      </td>
                      <td className="px-3 py-2 font-semibold text-white">
                        {r.name}
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
                      <td className="px-3 py-2 text-[10px] text-slate-500 max-w-[14rem]">
                        {r.eventScores
                          .filter((e) => !e.isDns)
                          .map((e) => `${e.regattaName.slice(0, 12)}:${e.points}`)
                          .join(" · ") || "—"}
                      </td>
                    </tr>
                  ))}
                </tbody>
              </table>
            </div>
          )}
          <p className="px-4 py-2 text-[9px] text-slate-600 border-t border-white/5">
            Birth year from DOB. National list only. Top 25 (SGP) for squad
            eligibility · intake year {cutoff.intakeYear}.
          </p>
        </div>

        <div className="xl:col-span-2 glass-panel rounded-2xl border border-white/5 overflow-hidden">
          <div className="px-4 py-3 border-b border-white/5 flex items-center gap-2">
            <Users className="h-4 w-4 text-orange-400" />
            <h3 className="text-xs font-bold text-white uppercase tracking-wider">
              {boatClass === "ILCA 4"
                ? "ILCA 4 squad shortlist (preview)"
                : "Squad selection (ILCA 4 only)"}
            </h3>
          </div>
          {boatClass !== "ILCA 4" ? (
            <p className="p-4 text-xs text-slate-500">
              National squad rules in this tool are configured for ILCA 4.
              Switch class to ILCA 4 to preview selection.
            </p>
          ) : squad.length === 0 ? (
            <p className="p-4 text-xs text-slate-500">
              No eligible sailors (need top-25 ranking + SGP nationality +
              gender + intake-year ≤ 17).
            </p>
          ) : (
            <ol className="divide-y divide-white/5 max-h-[32rem] overflow-y-auto">
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
                      Series #{s.rankingPosition} · {s.gender} ·{" "}
                      {s.totalPoints} pts
                    </span>
                  </span>
                  <span className="shrink-0 rounded-full bg-white/5 border border-white/10 px-2 py-0.5 text-[9px] font-bold text-slate-400">
                    {REASON_LABEL[s.reason] || s.reason}
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
