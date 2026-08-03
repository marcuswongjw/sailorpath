"use client";

import { useMemo, useState } from "react";
import Link from "next/link";
import {
  calculateRankings,
  periodLabel,
  type Period,
  type SailorRecord,
  type RegattaRecord,
  type RegattaResultRecord,
} from "@/lib/ranking";
import { currentPeriodFromSgToday } from "@/lib/datesSg";
import { birthYear } from "@/lib/age";
import {
  OPTIMIST_SQUAD_POLICY,
  rankingPeriodForJanuaryIntake,
  selectOptimistNatSquadPreview,
} from "@/lib/optimistSquadPreview";
import type { SailorAdmin } from "@/types/sailor";
import type { RegattaAdmin } from "@/types/regatta";
import type { ResultAdmin } from "@/types/result";
import { Trophy, Users, Medal } from "lucide-react";

type Props = {
  sailors: SailorAdmin[];
  regattas: RegattaAdmin[];
  results: ResultAdmin[];
};

function toSailorRecords(rows: SailorAdmin[]): SailorRecord[] {
  return rows.map((s) => ({
    id: s.id,
    name: s.name,
    handle: s.handle,
    sailNumber: s.sailNumber,
    sailNumberIlca4: s.sailNumberIlca4,
    club: s.club,
    school: s.school,
    nationality: s.nationality,
    avatarUrl: s.avatarUrl,
    goldEntryDate: s.goldEntryDate
      ? String(s.goldEntryDate).slice(0, 10)
      : null,
    silverEntryDate: s.silverEntryDate
      ? String(s.silverEntryDate).slice(0, 10)
      : null,
    dropDate: s.dropDate ? String(s.dropDate).slice(0, 10) : null,
    currentFleet: s.currentFleet,
    dob: s.dob ? String(s.dob).slice(0, 10) : null,
    gender: s.gender,
    nationalSquadStatus: s.nationalSquadStatus,
    natSquadStatusJan25: s.natSquadStatusJan25,
    natSquadStatusJul25: s.natSquadStatusJul25,
    natSquadStatusJan26: s.natSquadStatusJan26,
    natSquadStatusJul26: s.natSquadStatusJul26,
  }));
}

function toRegattaRecords(rows: RegattaAdmin[]): RegattaRecord[] {
  return rows.map((r) => ({
    id: r.id,
    name: r.name,
    slug: r.slug,
    date: String(r.date).slice(0, 10),
    totalFleetSize: r.totalFleetSize,
    division: r.division ?? undefined,
    raceCount: r.raceCount ?? undefined,
    geography: r.geography ?? "SG",
    boatClass: r.boatClass ?? "Optimist",
    countsForRanking: r.countsForRanking !== false,
  }));
}

function toResultRecords(rows: ResultAdmin[]): RegattaResultRecord[] {
  return rows.map((r) => ({
    sailorId: r.sailorId,
    regattaId: r.regattaId,
    rank: r.rank,
    nettScore: r.nettScore,
    totalScore: r.totalScore,
    isDns: Boolean(r.isDns || r.isDNS),
    isOverseasCommitment: Boolean(r.isOverseasCommitment),
  }));
}

export function AdminGoldRankingPanel({
  sailors,
  regattas,
  results,
}: Props) {
  const current = currentPeriodFromSgToday();
  /** End of current season → January next-year intake */
  const defaultIntakeYear =
    current.half === "Jul-Dec" ? current.year + 1 : current.year;
  const [intakeYear, setIntakeYear] = useState(defaultIntakeYear);
  const [genderFilter, setGenderFilter] = useState<"all" | "M" | "F">("all");

  const rankingPeriod: Period = useMemo(
    () => rankingPeriodForJanuaryIntake(intakeYear),
    [intakeYear]
  );

  const goldRanked = useMemo(() => {
    const ranked = calculateRankings(
      rankingPeriod,
      toSailorRecords(sailors),
      toRegattaRecords(regattas),
      toResultRecords(results),
      "Optimist"
    ).filter((x) => x.fleet === "Gold");
    return ranked.slice(0, OPTIMIST_SQUAD_POLICY.activeGoldCap);
  }, [sailors, regattas, results, rankingPeriod]);

  const filteredGold = useMemo(() => {
    if (genderFilter === "all") return goldRanked;
    return goldRanked.filter(
      (s) => String(s.gender || "").toUpperCase() === genderFilter
    );
  }, [goldRanked, genderFilter]);

  const squadPreview = useMemo(
    () => selectOptimistNatSquadPreview(goldRanked),
    [goldRanked]
  );
  const natA = squadPreview.filter((p) => p.tier === "Nat A");
  const natB = squadPreview.filter((p) => p.tier === "Nat B");

  const periodInfo = rankingPeriodForJanuaryIntake(intakeYear);

  return (
    <div className="w-full min-w-0 space-y-6">
      <div className="glass-panel rounded-3xl border border-white/5 p-5 sm:p-6 space-y-3">
        <div className="flex items-start gap-3">
          <div className="flex h-10 w-10 shrink-0 items-center justify-center rounded-xl bg-amber-500/15">
            <Trophy className="h-5 w-5 text-amber-400" />
          </div>
          <div className="min-w-0 flex-1">
            <h2 className="text-base font-bold text-white">
              Optimist Gold ranking &amp; Nat A / B preview
            </h2>
            <p className="text-[12px] text-slate-400 mt-1 max-w-3xl leading-relaxed">
              Active Gold fleet Best 3 of 5 (Optimist class only). Cap{" "}
              {OPTIMIST_SQUAD_POLICY.activeGoldCap} sailors. Squad shortlist is a
              ranking preview for the January intake — not auto-applied to sailor
              records.
            </p>
            <p className="text-[11px] text-slate-500 mt-1 max-w-3xl">
              {OPTIMIST_SQUAD_POLICY.notes}
            </p>
          </div>
        </div>

        <div className="grid grid-cols-1 sm:grid-cols-3 gap-3">
          <label className="text-xs text-slate-400">
            January intake year (squad target)
            <input
              type="number"
              min={2025}
              max={2040}
              className="mt-1 w-full rounded-lg bg-slate-900 border border-white/10 text-white px-3 py-2 text-xs"
              value={intakeYear}
              onChange={(e) =>
                setIntakeYear(Number(e.target.value) || defaultIntakeYear)
              }
            />
          </label>
          <label className="text-xs text-slate-400">
            Ranking period (auto)
            <div className="mt-1 w-full rounded-lg bg-slate-950 border border-white/10 text-white px-3 py-2 text-xs font-semibold">
              {periodLabel(rankingPeriod)}
            </div>
          </label>
          <label className="text-xs text-slate-400">
            Gender filter (table)
            <select
              className="mt-1 w-full rounded-lg bg-slate-900 border border-white/10 text-white px-3 py-2 text-xs"
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
        </div>
        <p className="text-[11px] text-amber-300/90 font-medium">
          {periodInfo.label} · {goldRanked.length} active Gold (max{" "}
          {OPTIMIST_SQUAD_POLICY.activeGoldCap}) · Nat A preview {natA.length} ·
          Nat B preview {natB.length}
        </p>
      </div>

      <div className="grid grid-cols-1 xl:grid-cols-5 gap-4">
        {/* Active 100 gold */}
        <div className="xl:col-span-3 glass-panel rounded-2xl border border-white/5 overflow-hidden">
          <div className="px-4 py-3 border-b border-white/5">
            <h3 className="text-xs font-bold text-white uppercase tracking-wider flex items-center gap-2">
              <Medal className="h-4 w-4 text-amber-400" />
              Active Gold sailors (top {OPTIMIST_SQUAD_POLICY.activeGoldCap})
            </h3>
            <p className="text-[11px] text-slate-500 mt-0.5">
              {periodLabel(rankingPeriod)} · Best 3 of 5 (lower is better)
            </p>
          </div>
          {filteredGold.length === 0 ? (
            <p className="p-6 text-sm text-slate-500 text-center">
              No active Gold sailors for this period. Check gold entry dates and
              Optimist ranking results.
            </p>
          ) : (
            <div className="overflow-x-auto max-h-[36rem] overflow-y-auto">
              <table className="w-full text-left text-xs">
                <thead className="sticky top-0 bg-[#131520] z-10">
                  <tr className="text-[10px] uppercase tracking-wide text-slate-500 border-b border-white/5">
                    <th className="px-3 py-2 font-bold">#</th>
                    <th className="px-3 py-2 font-bold">Sailor</th>
                    <th className="px-3 py-2 font-bold">G</th>
                    <th className="px-3 py-2 font-bold">BY</th>
                    <th className="px-3 py-2 font-bold">Sail #</th>
                    <th className="px-3 py-2 font-bold">Best 3</th>
                    <th className="px-3 py-2 font-bold">Period squad</th>
                    <th className="px-3 py-2 font-bold">Preview</th>
                  </tr>
                </thead>
                <tbody className="divide-y divide-white/5">
                  {filteredGold.map((s, i) => {
                    const rank =
                      genderFilter === "all"
                        ? i + 1
                        : goldRanked.findIndex((x) => x.id === s.id) + 1;
                    const preview =
                      rank >= 1 && rank <= 15
                        ? "Nat A"
                        : rank >= 16 && rank <= 30
                          ? "Nat B"
                          : "—";
                    return (
                      <tr
                        key={s.id}
                        className={
                          rank <= 30 ? "text-slate-200" : "text-slate-500"
                        }
                      >
                        <td className="px-3 py-2 tabular-nums font-bold text-amber-400">
                          {rank}
                        </td>
                        <td className="px-3 py-2 font-semibold text-white">
                          {s.handle ? (
                            <Link
                              href={`/${s.handle}`}
                              className="hover:text-amber-300"
                              target="_blank"
                            >
                              {s.name}
                            </Link>
                          ) : (
                            s.name
                          )}
                        </td>
                        <td className="px-3 py-2">{s.gender || "—"}</td>
                        <td className="px-3 py-2 tabular-nums">
                          {birthYear(s.dob as string | null) ?? "—"}
                        </td>
                        <td className="px-3 py-2 font-mono text-[11px] text-slate-400">
                          {s.sailNumber || "—"}
                        </td>
                        <td className="px-3 py-2 tabular-nums font-bold text-white">
                          {s.overallScore}
                        </td>
                        <td className="px-3 py-2">
                          {s.periodSquadStatus ? (
                            <span className="rounded-full bg-orange-500/10 border border-orange-500/20 px-2 py-0.5 text-[10px] font-bold text-orange-300">
                              {s.periodSquadStatus}
                            </span>
                          ) : (
                            <span className="text-slate-600">—</span>
                          )}
                        </td>
                        <td className="px-3 py-2">
                          {preview !== "—" ? (
                            <span
                              className={`rounded-full px-2 py-0.5 text-[10px] font-bold border ${
                                preview === "Nat A"
                                  ? "bg-amber-500/15 border-amber-500/30 text-amber-200"
                                  : "bg-sky-500/10 border-sky-500/25 text-sky-200"
                              }`}
                            >
                              {preview}
                            </span>
                          ) : (
                            <span className="text-slate-600">—</span>
                          )}
                        </td>
                      </tr>
                    );
                  })}
                </tbody>
              </table>
            </div>
          )}
        </div>

        {/* Nat A / B shortlists */}
        <div className="xl:col-span-2 space-y-4">
          <div className="glass-panel rounded-2xl border border-white/5 overflow-hidden">
            <div className="px-4 py-3 border-b border-white/5 flex items-center gap-2">
              <Users className="h-4 w-4 text-amber-400" />
              <h3 className="text-xs font-bold text-white uppercase tracking-wider">
                Nat A shortlist (Jan {intakeYear})
              </h3>
            </div>
            {natA.length === 0 ? (
              <p className="p-4 text-xs text-slate-500">No Gold ranks 1–15 yet.</p>
            ) : (
              <ol className="divide-y divide-white/5 max-h-[16rem] overflow-y-auto">
                {natA.map((p) => (
                  <li
                    key={p.sailorId}
                    className="px-4 py-2 text-xs flex justify-between gap-2"
                  >
                    <span>
                      <span className="text-slate-500 tabular-nums mr-2">
                        #{p.rankingPosition}
                      </span>
                      <span className="font-semibold text-white">{p.name}</span>
                      <span className="block text-[10px] text-slate-500 mt-0.5">
                        Best 3: {p.overallScore}
                        {p.currentPeriodSquad
                          ? ` · stored ${p.currentPeriodSquad}`
                          : ""}
                        {!p.isSgp && p.nationality
                          ? ` · ${p.nationality}`
                          : ""}
                      </span>
                    </span>
                    <span className="shrink-0 text-[9px] font-bold text-amber-300">
                      Nat A
                    </span>
                  </li>
                ))}
              </ol>
            )}
          </div>

          <div className="glass-panel rounded-2xl border border-white/5 overflow-hidden">
            <div className="px-4 py-3 border-b border-white/5 flex items-center gap-2">
              <Users className="h-4 w-4 text-sky-400" />
              <h3 className="text-xs font-bold text-white uppercase tracking-wider">
                Nat B shortlist (Jan {intakeYear})
              </h3>
            </div>
            {natB.length === 0 ? (
              <p className="p-4 text-xs text-slate-500">
                No Gold ranks 16–30 yet.
              </p>
            ) : (
              <ol className="divide-y divide-white/5 max-h-[16rem] overflow-y-auto">
                {natB.map((p) => (
                  <li
                    key={p.sailorId}
                    className="px-4 py-2 text-xs flex justify-between gap-2"
                  >
                    <span>
                      <span className="text-slate-500 tabular-nums mr-2">
                        #{p.rankingPosition}
                      </span>
                      <span className="font-semibold text-white">{p.name}</span>
                      <span className="block text-[10px] text-slate-500 mt-0.5">
                        Best 3: {p.overallScore}
                        {p.currentPeriodSquad
                          ? ` · stored ${p.currentPeriodSquad}`
                          : ""}
                      </span>
                    </span>
                    <span className="shrink-0 text-[9px] font-bold text-sky-300">
                      Nat B
                    </span>
                  </li>
                ))}
              </ol>
            )}
            <p className="px-4 py-2 text-[9px] text-slate-600 border-t border-white/5">
              January {intakeYear} intake · ranking from{" "}
              {periodLabel(rankingPeriod)}. Edit official Nat A/B on sailor
              records (Database tab) for the matching period field.
            </p>
          </div>
        </div>
      </div>
    </div>
  );
}
