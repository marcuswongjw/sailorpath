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
import { birthYear } from "@/lib/age";
import {
  OPTIMIST_SQUAD_POLICY,
  optimistSquadCutoff,
  selectOptimistNatSquadPreview,
  type OptimistIntakeKind,
} from "@/lib/optimistSquadPreview";
import {
  ASIAN_OCEANIA_2026,
  PERTH_CAMP_2026,
  computeCombinedSelectionScores,
  matchSelectionEvents,
  selectAsianOceaniaTeam,
  selectPerthCamp,
} from "@/lib/optimistEventSelection";
import {
  findGoldParticipationDrops,
  GOLD_MIN_RANKING_REGATTAS_PER_HALF,
  type GoldDropCandidate,
} from "@/lib/goldFleetDrop";
import type { SailorAdmin } from "@/types/sailor";
import type { RegattaAdmin } from "@/types/regatta";
import type { ResultAdmin } from "@/types/result";
import { Trophy, Users, Medal, Plane, Tent, Loader2 } from "lucide-react";

type Props = {
  sailors: SailorAdmin[];
  regattas: RegattaAdmin[];
  results: ResultAdmin[];
  onSailorsChange?: (sailors: SailorAdmin[]) => void;
};

const REASON_LABEL: Record<string, string> = {
  top8_male: "Top 8 male",
  top8_female: "Top 8 female",
  age13: "Age 13 bucket",
  age12: "Age 12 bucket",
  age11_or_under: "Age ≤11 bucket",
  fill_same_gender: "Fill (same gender)",
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
  onSailorsChange,
}: Props) {
  const now = new Date();
  const y = now.getFullYear();
  const defaultKind: OptimistIntakeKind =
    now.getMonth() < 6 ? "january" : "july";
  const defaultYear =
    defaultKind === "january" && now.getMonth() === 11 ? y + 1 : y;

  const [intakeKind, setIntakeKind] =
    useState<OptimistIntakeKind>(defaultKind);
  const [intakeYear, setIntakeYear] = useState(defaultYear);
  const [genderFilter, setGenderFilter] = useState<"all" | "M" | "F">("all");
  const [dropBusy, setDropBusy] = useState(false);
  const [dropMsg, setDropMsg] = useState<string | null>(null);

  const cutoff = useMemo(
    () => optimistSquadCutoff(intakeKind, intakeYear),
    [intakeKind, intakeYear]
  );

  const rankingPeriod: Period = cutoff.period;

  const sailorRecs = useMemo(() => toSailorRecords(sailors), [sailors]);
  const regattaRecs = useMemo(() => toRegattaRecords(regattas), [regattas]);
  const resultRecs = useMemo(() => toResultRecords(results), [results]);

  const asOfYmd = useMemo(
    () =>
      new Date().toLocaleDateString("en-CA", { timeZone: "Asia/Singapore" }),
    []
  );

  const participationDrops = useMemo(
    (): GoldDropCandidate[] =>
      findGoldParticipationDrops(
        sailorRecs,
        regattaRecs,
        resultRecs,
        asOfYmd
      ),
    [sailorRecs, regattaRecs, resultRecs, asOfYmd]
  );

  const applyParticipationDrops = async () => {
    if (participationDrops.length === 0) {
      setDropMsg("No participation drops needed.");
      return;
    }
    const preview = participationDrops
      .slice(0, 12)
      .map(
        (d) =>
          `• ${d.name}: drop ${d.dropDate} (${d.participationCount} ranking gold in ${d.failedPeriod.half} ${d.failedPeriod.year})`
      )
      .join("\n");
    if (
      !confirm(
        `Auto-drop ${participationDrops.length} gold sailor(s) with fewer than ${GOLD_MIN_RANKING_REGATTAS_PER_HALF} ranking gold regattas in a completed half?\n\n${preview}${
          participationDrops.length > 12 ? "\n…" : ""
        }\n\nThis sets their gold drop date.`
      )
    ) {
      return;
    }
    setDropBusy(true);
    setDropMsg(null);
    try {
      const res = await fetch("/api/admin/sailors", {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({
          action: "applyGoldParticipationDrops",
          asOf: asOfYmd,
        }),
      });
      const data = await res.json();
      if (!res.ok) throw new Error(data.error || "Drop failed");
      setDropMsg(data.message || `Updated ${data.updated}`);
      // Refresh sailor list if parent provided callback
      if (onSailorsChange) {
        const listRes = await fetch("/api/admin/sailors");
        const listData = await listRes.json();
        if (listRes.ok && listData.sailors) {
          onSailorsChange(listData.sailors);
        }
      }
    } catch (e) {
      setDropMsg(e instanceof Error ? e.message : "Drop failed");
    } finally {
      setDropBusy(false);
    }
  };

  const goldRanked = useMemo(() => {
    // Only count ranking regattas on/before official cutoff date
    const asOf = cutoff.asOf;
    const regsCapped = regattaRecs.map((r) => ({
      ...r,
      countsForRanking:
        r.countsForRanking !== false &&
        String(r.date).slice(0, 10) <= asOf,
    }));
    const ranked = calculateRankings(
      rankingPeriod,
      sailorRecs,
      regsCapped,
      resultRecs,
      "Optimist"
    ).filter((x) => x.fleet === "Gold");
    return ranked.slice(0, OPTIMIST_SQUAD_POLICY.activeGoldCap);
  }, [sailorRecs, regattaRecs, resultRecs, rankingPeriod, cutoff.asOf]);

  const filteredGold = useMemo(() => {
    if (genderFilter === "all") return goldRanked;
    return goldRanked.filter(
      (s) => String(s.gender || "").toUpperCase() === genderFilter
    );
  }, [goldRanked, genderFilter]);

  const squadPreview = useMemo(
    () => selectOptimistNatSquadPreview(goldRanked, cutoff.intakeYear),
    [goldRanked, cutoff.intakeYear]
  );
  const natA = squadPreview.filter((p) => p.tier === "Nat A");
  const natB = squadPreview.filter((p) => p.tier === "Nat B");
  const squadById = useMemo(() => {
    const m = new Map(squadPreview.map((p) => [p.sailorId, p]));
    return m;
  }, [squadPreview]);

  // ── Asian + Perth selection (same events) ──────────────
  const selectionMatched = useMemo(
    () => matchSelectionEvents(regattaRecs, ASIAN_OCEANIA_2026.events),
    [regattaRecs]
  );
  const combinedScores = useMemo(
    () =>
      computeCombinedSelectionScores(
        selectionMatched,
        sailorRecs,
        resultRecs
      ),
    [selectionMatched, sailorRecs, resultRecs]
  );
  const asianTeam = useMemo(
    () => selectAsianOceaniaTeam(combinedScores),
    [combinedScores]
  );
  const perth = useMemo(
    () => selectPerthCamp(combinedScores),
    [combinedScores]
  );

  return (
    <div className="w-full min-w-0 space-y-6">
      {/* ── Header ───────────────────────────────────────────── */}
      <div className="glass-panel rounded-3xl border border-white/5 p-5 sm:p-6 space-y-3">
        <div className="flex items-start gap-3">
          <div className="flex h-10 w-10 shrink-0 items-center justify-center rounded-xl bg-amber-500/15">
            <Trophy className="h-5 w-5 text-amber-400" />
          </div>
          <div className="min-w-0 flex-1">
            <h2 className="text-base font-bold text-white">
              Optimist Gold ranking · Nat A/B · campaigns
            </h2>
            <p className="text-[12px] text-slate-400 mt-1 max-w-3xl leading-relaxed">
              {OPTIMIST_SQUAD_POLICY.notes}
            </p>
            <p className="text-[11px] text-slate-500 mt-1 max-w-3xl">
              Participation rule: gold sailors need ≥
              {GOLD_MIN_RANKING_REGATTAS_PER_HALF} ranking gold regattas in each
              completed half (Jan–Jun / Jul–Dec) or they are dropped at the next
              half boundary.
            </p>
          </div>
        </div>

        {participationDrops.length > 0 && (
          <div className="rounded-xl border border-rose-500/25 bg-rose-500/10 px-4 py-3 flex flex-wrap items-center justify-between gap-3">
            <div className="min-w-0">
              <p className="text-xs font-semibold text-rose-200">
                {participationDrops.length} gold sailor
                {participationDrops.length === 1 ? "" : "s"} below participation
                threshold
              </p>
              <p className="text-[11px] text-rose-200/70 mt-0.5">
                {participationDrops
                  .slice(0, 4)
                  .map((d) => d.name)
                  .join(", ")}
                {participationDrops.length > 4
                  ? ` +${participationDrops.length - 4} more`
                  : ""}
              </p>
            </div>
            <button
              type="button"
              disabled={dropBusy}
              onClick={() => void applyParticipationDrops()}
              className="inline-flex items-center gap-1.5 rounded-full border border-rose-400/40 bg-rose-500/20 px-3 py-1.5 text-[10px] font-bold text-rose-100 hover:bg-rose-500/30 disabled:opacity-50"
            >
              {dropBusy ? (
                <Loader2 className="h-3 w-3 animate-spin" />
              ) : null}
              Apply auto-drops
            </button>
          </div>
        )}
        {dropMsg && (
          <p className="text-[11px] text-emerald-400 font-medium">{dropMsg}</p>
        )}

        <div className="grid grid-cols-1 sm:grid-cols-3 gap-3">
          <label className="text-xs text-slate-400">
            Intake
            <select
              className="mt-1 w-full rounded-lg bg-slate-900 border border-white/10 text-white px-3 py-2 text-xs"
              value={intakeKind}
              onChange={(e) =>
                setIntakeKind(e.target.value as OptimistIntakeKind)
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
              min={2024}
              max={2040}
              className="mt-1 w-full rounded-lg bg-slate-900 border border-white/10 text-white px-3 py-2 text-xs"
              value={intakeYear}
              onChange={(e) =>
                setIntakeYear(Number(e.target.value) || defaultYear)
              }
            />
          </label>
          <label className="text-xs text-slate-400">
            Gender filter (Gold table)
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
          {cutoff.label} · series {periodLabel(rankingPeriod)} ·{" "}
          {goldRanked.length} active Gold (max {OPTIMIST_SQUAD_POLICY.activeGoldCap})
          · Nat A {natA.length} · Nat B {natB.length}
        </p>
      </div>

      {/* ── Gold table + Nat A/B ─────────────────────────────── */}
      <div className="grid grid-cols-1 xl:grid-cols-5 gap-4">
        <div className="xl:col-span-3 glass-panel rounded-2xl border border-white/5 overflow-hidden">
          <div className="px-4 py-3 border-b border-white/5">
            <h3 className="text-xs font-bold text-white uppercase tracking-wider flex items-center gap-2">
              <Medal className="h-4 w-4 text-amber-400" />
              Active Gold sailors (top {OPTIMIST_SQUAD_POLICY.activeGoldCap})
            </h3>
            <p className="text-[11px] text-slate-500 mt-0.5">
              Best 3 of 5 · lower is better · ≤15 in intake year for squad
              eligibility
            </p>
          </div>
          {filteredGold.length === 0 ? (
            <p className="p-6 text-sm text-slate-500 text-center">
              No active Gold sailors for this period.
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
                    <th className="px-3 py-2 font-bold">Best 3</th>
                    <th className="px-3 py-2 font-bold">Stored</th>
                    <th className="px-3 py-2 font-bold">Preview</th>
                  </tr>
                </thead>
                <tbody className="divide-y divide-white/5">
                  {filteredGold.map((s, i) => {
                    const rank =
                      genderFilter === "all"
                        ? i + 1
                        : goldRanked.findIndex((x) => x.id === s.id) + 1;
                    const prev = squadById.get(s.id);
                    return (
                      <tr
                        key={s.id}
                        className={
                          prev ? "text-slate-200" : "text-slate-500"
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
                          {prev ? (
                            <span
                              className={`rounded-full px-2 py-0.5 text-[10px] font-bold border ${
                                prev.tier === "Nat A"
                                  ? "bg-amber-500/15 border-amber-500/30 text-amber-200"
                                  : "bg-sky-500/10 border-sky-500/25 text-sky-200"
                              }`}
                              title={REASON_LABEL[prev.reason] || prev.reason}
                            >
                              {prev.tier}
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

        <div className="xl:col-span-2 space-y-4">
          <SquadList
            title={`Nat A · ${intakeKind === "july" ? "July" : "January"} ${intakeYear}`}
            color="amber"
            picks={natA}
            empty="No Nat A places filled."
          />
          <SquadList
            title={`Nat B · ${intakeKind === "july" ? "July" : "January"} ${intakeYear}`}
            color="sky"
            picks={natB}
            empty="No Nat B places filled."
            footer="A places are excluded from B. Age buckets then fill same gender. Max 16 each."
          />
        </div>
      </div>

      {/* ── Selection event match status ─────────────────────── */}
      <div className="glass-panel rounded-2xl border border-white/5 p-4 space-y-2">
        <h3 className="text-xs font-bold text-white uppercase tracking-wider">
          2026 selection events (shared by Asian Champs &amp; Perth Camp)
        </h3>
        <p className="text-[11px] text-slate-500">
          Combined score = sum of finishing places in Optimist Gold. Missing
          event → fleet size + 1 penalty. Match regattas by name + date window.
        </p>
        <ul className="space-y-1.5">
          {selectionMatched.map((m) => (
            <li
              key={m.def.id}
              className="flex flex-wrap items-center gap-2 text-xs"
            >
              <span
                className={`rounded-full px-2 py-0.5 text-[10px] font-bold border ${
                  m.matched
                    ? "bg-emerald-500/15 border-emerald-500/30 text-emerald-300"
                    : "bg-rose-500/10 border-rose-500/30 text-rose-300"
                }`}
              >
                {m.matched ? "Matched" : "Not found"}
              </span>
              <span className="text-slate-300 font-semibold">
                {m.def.label}
              </span>
              <span className="text-slate-600">
                {m.def.dateFrom} → {m.def.dateTo}
              </span>
              {m.regatta && (
                <span className="text-slate-500">
                  → {m.regatta.name} ({m.regatta.date})
                </span>
              )}
            </li>
          ))}
        </ul>
      </div>

      {/* ── Asian Oceania + Perth ────────────────────────────── */}
      <div className="grid grid-cols-1 lg:grid-cols-2 gap-4">
        <div className="glass-panel rounded-2xl border border-white/5 overflow-hidden">
          <div className="px-4 py-3 border-b border-white/5 flex items-start gap-2">
            <Plane className="h-4 w-4 text-violet-400 mt-0.5 shrink-0" />
            <div>
              <h3 className="text-xs font-bold text-white uppercase tracking-wider">
                {ASIAN_OCEANIA_2026.title}
              </h3>
              <p className="text-[11px] text-slate-500 mt-0.5">
                {ASIAN_OCEANIA_2026.subtitle}
              </p>
              <p className="text-[10px] text-slate-600 mt-1">
                {ASIAN_OCEANIA_2026.notes}
              </p>
            </div>
          </div>
          <p className="px-4 py-2 text-[11px] text-violet-300/90 border-b border-white/5">
            {asianTeam.reason}
          </p>
          {asianTeam.selected.length === 0 ? (
            <p className="p-4 text-xs text-slate-500">
              Import Gold results for SSF Selection Trials (22–30 Aug 2026) and
              SNSC (11–13 Sep 2026) to populate.
            </p>
          ) : (
            <ol className="divide-y divide-white/5 max-h-[22rem] overflow-y-auto">
              {asianTeam.selected.map((s) => (
                <li
                  key={s.sailorId}
                  className="px-4 py-2 text-xs flex justify-between gap-2"
                >
                  <span>
                    <span className="text-slate-500 tabular-nums mr-2">
                      #{s.teamRank}
                    </span>
                    <span className="font-semibold text-white">{s.name}</span>
                    <span className="block text-[10px] text-slate-500 mt-0.5">
                      {s.gender || "?"} · BY {s.birthYear ?? "—"} · combined{" "}
                      {s.combinedScore}
                      {s.eventScores
                        .map(
                          (e) =>
                            ` · ${e.missing ? "miss" : e.isDns ? "DNS" : e.rank}`
                        )
                        .join("")}
                    </span>
                  </span>
                </li>
              ))}
            </ol>
          )}
        </div>

        <div className="glass-panel rounded-2xl border border-white/5 overflow-hidden">
          <div className="px-4 py-3 border-b border-white/5 flex items-start gap-2">
            <Tent className="h-4 w-4 text-emerald-400 mt-0.5 shrink-0" />
            <div>
              <h3 className="text-xs font-bold text-white uppercase tracking-wider">
                {PERTH_CAMP_2026.title}
              </h3>
              <p className="text-[11px] text-slate-500 mt-0.5">
                {PERTH_CAMP_2026.subtitle}
              </p>
              <p className="text-[10px] text-slate-600 mt-1">
                {PERTH_CAMP_2026.notes}
              </p>
            </div>
          </div>
          {perth.notes.length > 0 && (
            <p className="px-4 py-2 text-[11px] text-amber-200/80 border-b border-white/5">
              {perth.notes.join(" · ")}
            </p>
          )}
          {perth.picks.length === 0 ? (
            <p className="p-4 text-xs text-slate-500">
              No birth-year matches yet. Need selection-event results and DOBs
              for 2013 / 2014 / 2015.
            </p>
          ) : (
            <ul className="divide-y divide-white/5 max-h-[22rem] overflow-y-auto">
              {(["by2013", "by2014", "by2015"] as const).map((bucket) => {
                const group = perth.picks.filter((p) => p.bucket === bucket);
                if (!group.length) return null;
                return (
                  <li key={bucket} className="px-4 py-2">
                    <p className="text-[10px] font-bold uppercase tracking-wider text-emerald-400/90 mb-1.5">
                      {group[0]?.bucketLabel}
                    </p>
                    <ul className="space-y-1">
                      {group.map((p) => (
                        <li
                          key={p.sailorId}
                          className="text-xs flex justify-between gap-2"
                        >
                          <span>
                            <span className="font-semibold text-white">
                              {p.name}
                            </span>
                            <span className="text-slate-500 ml-1.5">
                              {p.slot} · combined {p.combinedScore}
                            </span>
                          </span>
                        </li>
                      ))}
                    </ul>
                  </li>
                );
              })}
            </ul>
          )}
        </div>
      </div>

      {/* Full combined leaderboard for transparency */}
      {combinedScores.length > 0 && (
        <div className="glass-panel rounded-2xl border border-white/5 overflow-hidden">
          <div className="px-4 py-3 border-b border-white/5">
            <h3 className="text-xs font-bold text-white uppercase tracking-wider">
              Selection events · combined place leaderboard
            </h3>
          </div>
          <div className="overflow-x-auto max-h-64 overflow-y-auto">
            <table className="w-full text-left text-xs">
              <thead className="sticky top-0 bg-[#131520]">
                <tr className="text-[10px] uppercase text-slate-500 border-b border-white/5">
                  <th className="px-3 py-2">#</th>
                  <th className="px-3 py-2">Sailor</th>
                  <th className="px-3 py-2">G</th>
                  <th className="px-3 py-2">BY</th>
                  {selectionMatched.map((m) => (
                    <th key={m.def.id} className="px-3 py-2">
                      {m.def.label.slice(0, 12)}…
                    </th>
                  ))}
                  <th className="px-3 py-2">Combined</th>
                </tr>
              </thead>
              <tbody className="divide-y divide-white/5">
                {combinedScores.slice(0, 40).map((s, i) => (
                  <tr key={s.sailorId} className="text-slate-300">
                    <td className="px-3 py-1.5 tabular-nums text-slate-500">
                      {i + 1}
                    </td>
                    <td className="px-3 py-1.5 font-semibold text-white">
                      {s.name}
                    </td>
                    <td className="px-3 py-1.5">{s.gender || "—"}</td>
                    <td className="px-3 py-1.5 tabular-nums">
                      {s.birthYear ?? "—"}
                    </td>
                    {s.eventScores.map((e) => (
                      <td
                        key={e.regattaId}
                        className="px-3 py-1.5 tabular-nums"
                      >
                        {e.missing
                          ? `—(${e.score})`
                          : e.isDns
                            ? `DNS(${e.score})`
                            : e.rank}
                      </td>
                    ))}
                    <td className="px-3 py-1.5 tabular-nums font-bold text-white">
                      {s.combinedScore}
                    </td>
                  </tr>
                ))}
              </tbody>
            </table>
          </div>
        </div>
      )}
    </div>
  );
}

function SquadList({
  title,
  color,
  picks,
  empty,
  footer,
}: {
  title: string;
  color: "amber" | "sky";
  picks: {
    sailorId: string;
    name: string;
    rankingPosition: number;
    overallScore: number;
    gender: string;
    reason: string;
    ageInIntakeYear: number | null;
    currentPeriodSquad: string | null;
  }[];
  empty: string;
  footer?: string;
}) {
  const icon =
    color === "amber" ? "text-amber-400" : "text-sky-400";
  const badge =
    color === "amber"
      ? "text-amber-300"
      : "text-sky-300";
  return (
    <div className="glass-panel rounded-2xl border border-white/5 overflow-hidden">
      <div className="px-4 py-3 border-b border-white/5 flex items-center gap-2">
        <Users className={`h-4 w-4 ${icon}`} />
        <h3 className="text-xs font-bold text-white uppercase tracking-wider">
          {title}
        </h3>
        <span className="text-[10px] text-slate-500 ml-auto">
          {picks.length}/16
        </span>
      </div>
      {picks.length === 0 ? (
        <p className="p-4 text-xs text-slate-500">{empty}</p>
      ) : (
        <ol className="divide-y divide-white/5 max-h-[18rem] overflow-y-auto">
          {picks.map((p, i) => (
            <li
              key={p.sailorId}
              className="px-4 py-2 text-xs flex justify-between gap-2"
            >
              <span>
                <span className="text-slate-500 tabular-nums mr-2">
                  {i + 1}.
                </span>
                <span className="font-semibold text-white">{p.name}</span>
                <span className="block text-[10px] text-slate-500 mt-0.5">
                  Series #{p.rankingPosition} · {p.gender} · age{" "}
                  {p.ageInIntakeYear ?? "?"} · best3 {p.overallScore}
                  {p.currentPeriodSquad
                    ? ` · stored ${p.currentPeriodSquad}`
                    : ""}
                  {" · "}
                  {REASON_LABEL[p.reason] || p.reason}
                </span>
              </span>
              <span className={`shrink-0 text-[9px] font-bold ${badge}`}>
                {title.includes("Nat A") ? "A" : "B"}
              </span>
            </li>
          ))}
        </ol>
      )}
      {footer && (
        <p className="px-4 py-2 text-[9px] text-slate-600 border-t border-white/5">
          {footer}
        </p>
      )}
    </div>
  );
}
