"use client";

import { useCallback, useMemo, useState } from "react";
import Link from "next/link";
import {
  type IlcaIntakeKind,
  type IlcaRankedSailor,
  reRankIlcaWithExcluded,
  selectIlca4NationalSquad,
  squadReasonLabel,
} from "@/lib/ilcaRanking";
import { Trophy, Calendar, RefreshCw, Filter, RotateCcw, Lock } from "lucide-react";
import { trackClientUsage } from "@/lib/clientUsage";
import { bestThreeSelectedIndexes } from "@/lib/bestThreeSelection";
import { mobileRegattaBadge } from "@/components/FleetRankingsView";
import { RankMedalBadge } from "@/components/ui/RankMedalBadge";
import { useAccountOptional } from "@/components/AccountProvider";

const ILCA_INTAKE_OPTIONS: Array<{
  kind: IlcaIntakeKind;
  year: number;
  label: string;
}> = [
  { kind: "july", year: 2026, label: "Jul – Dec 2026" },
  { kind: "january", year: 2026, label: "Jan – Jun 2026" },
  { kind: "july", year: 2025, label: "Jul – Dec 2025" },
  { kind: "january", year: 2025, label: "Jan – Jun 2025" },
  { kind: "july", year: 2024, label: "Jul – Dec 2024" },
  { kind: "january", year: 2024, label: "Jan – Jun 2024" },
];

type Props = {
  initialRanked: IlcaRankedSailor[];
  initialIntakeKind: IlcaIntakeKind;
  initialIntakeYear: number;
  initialLabel: string;
  initialAsOf: string;
};

function regattaDisplayName(name: string | undefined | null, idx: number): string {
  if (!name || !String(name).trim()) return `R${idx + 1}`;
  return String(name).trim();
}

function scoreCell(points: number | undefined, isDns?: boolean) {
  if (points == null || !Number.isFinite(points)) return "—";
  if (isDns) return "0*";
  return String(points);
}

/**
 * Public ILCA 4 standings — same layout language as Optimist Gold/Silver.
 * Board is computed on the server (cached); intake switches hit /api/rankings.
 */
export function IlcaRankingsView({
  initialRanked,
  initialIntakeKind,
  initialIntakeYear,
  initialAsOf,
}: Props) {
  const now = new Date();
  const y = now.getFullYear();
  const acct = useAccountOptional();
  const isLoggedIn = Boolean(acct?.email);

  const [intakeKind, setIntakeKind] = useState<IlcaIntakeKind>(initialIntakeKind);
  const [intakeYear, setIntakeYear] = useState(initialIntakeYear);
  const [ranked, setRanked] = useState(initialRanked);
  const [asOf, setAsOf] = useState(initialAsOf);
  const [genderFilter, setGenderFilter] = useState<"all" | "M" | "F">("all");
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState<string | null>(null);
  const [excluded, setExcluded] = useState<Set<string>>(new Set());

  const toggleExclude = (regattaId: string) => {
    setExcluded((prev) => {
      const next = new Set(prev);
      if (next.has(regattaId)) next.delete(regattaId);
      else next.add(regattaId);
      return next;
    });
  };

  const loadBoard = useCallback(async (kind: IlcaIntakeKind, year: number) => {
    setLoading(true);
    setError(null);
    try {
      const res = await fetch(
        `/api/rankings?fleet=ILCA4&intake=${encodeURIComponent(kind)}&year=${year}`,
        { credentials: "same-origin" }
      );
      const data = (await res.json()) as {
        error?: string;
        ranked?: IlcaRankedSailor[];
        label?: string;
        asOf?: string;
      };
      if (!res.ok) throw new Error(data.error || "Could not load rankings");
      setRanked(Array.isArray(data.ranked) ? data.ranked : []);
      setExcluded(new Set());
      if (data.asOf) setAsOf(data.asOf);
    } catch (e) {
      setError(e instanceof Error ? e.message : "Could not load rankings");
    } finally {
      setLoading(false);
    }
  }, []);

  const rankingBase = useMemo(() => {
    if (excluded.size === 0) return ranked;
    return reRankIlcaWithExcluded(ranked, excluded);
  }, [ranked, excluded]);

  const projectedSquad = useMemo(() => {
    return selectIlca4NationalSquad(rankingBase);
  }, [rankingBase]);

  const projectedSquadMap = useMemo(() => {
    return new Map(projectedSquad.map((s) => [s.sailorId, s]));
  }, [projectedSquad]);

  const filtered = useMemo(() => {
    if (genderFilter === "all") return rankingBase;
    return rankingBase.filter((r) => r.gender === genderFilter);
  }, [rankingBase, genderFilter]);

  const displayRanked = useMemo(() => {
    return filtered.map((r, i) => ({ ...r, displayRank: i + 1 }));
  }, [filtered]);

  const eventSlots = useMemo(() => {
    const first = ranked.find((r) => r.eventScores?.length);
    if (!first) return [] as {
      regattaId: string;
      regattaName: string;
      date: string;
      fleetSize: number;
      idx: number;
    }[];
    return first.eventScores.map((e, idx) => ({
      regattaId: e.regattaId,
      regattaName: e.regattaName,
      date: e.date,
      fleetSize: e.fleetSize,
      idx,
    }));
  }, [ranked]);

  const excludedIndexes = useMemo(() => {
    const set = new Set<number>();
    eventSlots.forEach((slot, idx) => {
      if (excluded.has(slot.regattaId)) {
        set.add(idx);
      }
    });
    return set;
  }, [eventSlots, excluded]);

  const latestResultDate = useMemo(
    () =>
      eventSlots
        .map((event) => event.date)
        .filter(Boolean)
        .sort()
        .at(-1),
    [eventSlots]
  );

  const pointsFor = (r: IlcaRankedSailor, regattaId: string) => {
    const e = r.eventScores.find((x) => x.regattaId === regattaId);
    if (!e) return { points: undefined as number | undefined, isDns: true };
    return { points: e.points, isDns: e.isDns };
  };

  return (
    <div className="print-rankings mx-auto w-full max-w-7xl min-w-0 px-3 sm:px-6 lg:px-8 pt-4 pb-8 sm:pt-6 sm:pb-10 space-y-4 sm:space-y-6 overflow-x-clip">
      <div className="flex flex-col lg:flex-row lg:items-end justify-between gap-3 sm:gap-4 no-print min-w-0">
        <div className="flex items-start gap-2.5 sm:gap-3 min-w-0">
          <span className="flex h-9 w-9 sm:h-10 sm:w-10 shrink-0 items-center justify-center rounded-xl bg-sky-600/15 text-sky-400 border border-sky-500/25">
            <Trophy className="h-4 w-4 sm:h-5 sm:w-5" />
          </span>
          <div className="min-w-0 flex-1">
            <p className="text-[10px] sm:text-xs font-bold text-sky-400 uppercase tracking-wide">
              SG ILCA 4
            </p>
            <h1 className="text-xl sm:text-3xl lg:text-4xl font-black text-white tracking-tight break-words">
              National standings
            </h1>
            <p className="text-[11px] sm:text-sm text-slate-500 mt-1 leading-snug">
              Best 3 of last 5 · highlighted scores are selected · 1st = fleet
              size pts · * = DNS (0 pts)
            </p>
            <div className="mt-2.5 flex flex-wrap items-center gap-2">
              <Link
                href="/sg/ilca4/selection"
                prefetch
                className="inline-flex items-center gap-1.5 rounded-full border border-sky-500/30 bg-sky-500/10 px-3 py-1 text-[11px] font-bold text-sky-300 hover:bg-sky-500/20 transition-colors"
              >
                <Trophy className="h-3 w-3 text-sky-400" />
                <span>Selection trials &amp; NJTS policy</span>
                <span>→</span>
              </Link>
              {isLoggedIn && projectedSquad.length > 0 && (
                <span className="inline-flex items-center gap-1.5 rounded-full border border-amber-500/30 bg-amber-500/10 px-3 py-1 text-[11px] font-bold text-amber-300">
                  <span>{projectedSquad.length} Projected NJTS</span>
                </span>
              )}
            </div>
          </div>
        </div>
        <div className="flex flex-col sm:flex-row flex-wrap items-stretch sm:items-center gap-2.5 w-full lg:w-auto min-w-0">
          <div className="relative flex items-center min-w-0 w-full sm:w-auto">
            <Calendar className="absolute left-3.5 h-4 w-4 text-sky-400 pointer-events-none" />
            <select
              value={`${intakeKind}|${intakeYear}`}
              onChange={(e) => {
                const [kind, year] = e.target.value.split("|");
                const nextKind = kind as IlcaIntakeKind;
                const nextYear = Number(year) || y;
                setIntakeKind(nextKind);
                setIntakeYear(nextYear);
                trackClientUsage("ranking_period_change", "/sg/ilca4", {
                  fleet: "ILCA4",
                  intake: nextKind,
                  year: nextYear,
                });
                void loadBoard(nextKind, nextYear);
              }}
              className="flex-1 sm:flex-none min-w-0 w-full sm:w-auto max-w-full rounded-xl bg-warm-white border border-cool-veil pl-10 pr-8 py-2 text-xs sm:text-sm text-charcoal font-semibold cursor-pointer hover:border-harbour/40 focus:border-harbour focus:outline-none focus:ring-1 focus:ring-harbour/30 transition-all shadow-sm"
              aria-label="Select ILCA 4 intake period"
            >
              {ILCA_INTAKE_OPTIONS.map((opt) => (
                <option
                  key={`${opt.kind}-${opt.year}`}
                  value={`${opt.kind}|${opt.year}`}
                  className="bg-warm-white text-charcoal"
                >
                  {opt.label}
                </option>
              ))}
            </select>
          </div>
          <div className="relative flex items-center min-w-0 w-full sm:w-auto">
            <Filter className="absolute left-3 h-3.5 w-3.5 text-slate-400 pointer-events-none" />
            <select
              value={genderFilter}
              onChange={(e) =>
                setGenderFilter(e.target.value as "all" | "M" | "F")
              }
              className="min-w-0 w-full sm:w-auto rounded-xl bg-warm-white border border-cool-veil pl-8 pr-8 py-2 text-xs sm:text-sm text-charcoal font-semibold cursor-pointer hover:border-harbour/40 focus:border-harbour focus:outline-none focus:ring-1 focus:ring-harbour/30 transition-all shadow-sm"
              aria-label="Filter by gender"
            >
              <option value="all" className="bg-warm-white text-charcoal">
                All genders
              </option>
              <option value="M" className="bg-warm-white text-charcoal">
                Male
              </option>
              <option value="F" className="bg-warm-white text-charcoal">
                Female
              </option>
            </select>
          </div>
        </div>
      </div>

      {loading && (
        <p className="text-[11px] text-sky-300 font-medium inline-flex items-center gap-2">
          <RefreshCw className="h-3 w-3 animate-spin" />
          <span>Updating standings…</span>
        </p>
      )}
      {!loading && ranked.length > 0 && (
        <p className="text-[11px] font-medium text-slate-500">
          {latestResultDate ? `Results through ${latestResultDate} · ` : ""}
          Source: published regatta results reviewed before import
        </p>
      )}
      {error && (
        <p className="text-[11px] text-rose-300 font-medium">{error}</p>
      )}

      {genderFilter !== "all" && (
        <p className="text-[11px] text-amber-200/90 font-semibold no-print">
          Showing {displayRanked.length} of {rankingBase.length} sailors ·{" "}
          {genderFilter === "M" ? "Male" : "Female"}. Rank # restarts within
          this filter.
        </p>
      )}

      {/* Scoring events & what-if regatta exclusion toggles */}
      {eventSlots.length > 0 && (
        <div className="w-full max-w-full min-w-0 no-print">
          <div className="rounded-xl border border-cool-veil bg-warm-white px-2.5 sm:px-4 py-2 sm:py-3 space-y-2 min-w-0 shadow-sm">
            <div className="flex flex-col sm:flex-row sm:items-center justify-between gap-1.5 sm:gap-2 min-w-0">
              <p className="text-[10px] font-bold text-slate-500 uppercase tracking-wider">
                Scoring events — R1 oldest · R{eventSlots.length} newest (last{" "}
                {eventSlots.length} ranking regattas)
              </p>
              <div className="flex items-center gap-2 min-w-0 flex-wrap">
                <p className="text-[10px] text-slate-500 font-semibold hidden md:block">
                  Uncheck a regatta to exclude it from Best 3 of 5
                </p>
                {excluded.size > 0 && (
                  <button
                    type="button"
                    onClick={() => setExcluded(new Set())}
                    className="inline-flex items-center gap-1 rounded-full border border-amber-500/30 bg-amber-500/10 px-2.5 py-1 text-[10px] font-bold text-amber-200 shrink-0 cursor-pointer hover:bg-amber-500/20 transition-colors"
                  >
                    <RotateCcw className="h-3 w-3" />
                    Reset ({excluded.size})
                  </button>
                )}
              </div>
            </div>

            {/* Mobile: Tap button strip */}
            <div className="md:hidden w-full min-w-0 space-y-1.5">
              <div className="flex items-center justify-between text-[11px] text-slate-400 font-medium">
                <span className="text-[10px] uppercase font-bold text-slate-500 tracking-wider">
                  Tap event to include/exclude
                </span>
                {excluded.size > 0 && (
                  <button
                    type="button"
                    onClick={() => setExcluded(new Set())}
                    className="inline-flex items-center gap-1 text-[10px] font-bold text-amber-300 hover:text-amber-200"
                  >
                    <RotateCcw className="h-2.5 w-2.5" />
                    Reset ({excluded.size})
                  </button>
                )}
              </div>
              <div className="grid grid-cols-5 gap-1 w-full min-w-0">
                {eventSlots.map((ev, idx) => {
                  const off = excluded.has(ev.regattaId);
                  const badge = mobileRegattaBadge(ev.regattaName, idx);
                  return (
                    <button
                      key={ev.regattaId}
                      type="button"
                      onClick={() => toggleExclude(ev.regattaId)}
                      className={`min-w-0 w-full rounded-lg border px-1 py-1.5 text-center transition-all cursor-pointer active:scale-95 ${
                        off
                          ? "bg-rose-950/30 border-rose-500/40 text-rose-300 opacity-60 line-through"
                          : "bg-sailcloth border-cool-veil text-charcoal"
                      }`}
                      title={`${off ? "Include" : "Exclude"} ${ev.regattaName}`}
                    >
                      <div className="flex items-center justify-center gap-1">
                        <span className="text-[9px] font-black text-sky-400">
                          R{idx + 1}
                        </span>
                      </div>
                      <p className="text-[10px] font-bold truncate leading-tight mt-0.5">
                        {badge}
                      </p>
                      {off && (
                        <p className="text-[8px] font-extrabold text-rose-400 uppercase tracking-tighter mt-0.5 no-underline">
                          EXCL
                        </p>
                      )}
                    </button>
                  );
                })}
              </div>
            </div>

            {/* Desktop: Checkbox grid */}
            <div className="hidden md:grid grid-cols-5 gap-2">
              {eventSlots.map((ev, idx) => {
                const off = excluded.has(ev.regattaId);
                return (
                  <label
                    key={ev.regattaId}
                    className={`rounded-lg border px-2.5 py-2 min-h-[3.25rem] flex flex-col gap-1 transition-all cursor-pointer hover:border-sky-500/30 ${
                      off
                        ? "bg-slate-900/80 border-rose-500/40 opacity-60"
                        : "bg-sailcloth border-cool-veil"
                    }`}
                  >
                    <div className="flex items-start justify-between gap-1">
                      <p className="text-[10px] font-black text-sky-400">R{idx + 1}</p>
                      <input
                        type="checkbox"
                        checked={!off}
                        onChange={() => toggleExclude(ev.regattaId)}
                        className="mt-0.5 h-3.5 w-3.5 rounded border-slate-600 bg-slate-900 text-sky-600 focus:ring-sky-500 cursor-pointer"
                        title={off ? "Include in Best 3 of 5" : "Exclude from Best 3 of 5"}
                      />
                    </div>
                    <p
                      className="text-[11px] font-semibold text-charcoal leading-snug line-clamp-2"
                      title={`${ev.regattaName} · ${ev.date} · fleet ${ev.fleetSize}`}
                    >
                      {regattaDisplayName(ev.regattaName, idx)}
                    </p>
                    <p className="text-[9px] text-slate-soft tabular-nums">
                      {ev.date.slice(5)} · n={ev.fleetSize}
                    </p>
                  </label>
                );
              })}
              {Array.from({ length: Math.max(0, 5 - eventSlots.length) }).map(
                (_, i) => (
                  <div
                    key={`empty-${i}`}
                    className="min-w-0 rounded-lg border border-cool-veil bg-sailcloth px-1 py-1.5 text-center opacity-40"
                  >
                    <p className="text-[9px] font-black text-slate-600">
                      R{eventSlots.length + i + 1}
                    </p>
                    <p className="text-[8px] text-slate-600">—</p>
                  </div>
                )
              )}
            </div>

            {excluded.size > 0 && (
              <p className="text-[11px] text-amber-700 dark:text-amber-200/90 font-semibold">
                Viewing what-if ranking: {excluded.size} regatta
                {excluded.size === 1 ? "" : "s"} excluded · Best 3 of remaining
                scores. Current standings return when you reset.
              </p>
            )}
          </div>
        </div>
      )}

      {displayRanked.length === 0 && !loading && (
        <p className="text-sm text-slate-500">
          No ILCA 4 ranking results for listed sailors on or before {asOf}.
          Import ILCA 4 regattas and ensure sailors are on the national list
          (admin).
        </p>
      )}

      {/* Mobile Card List */}
      <div className="md:hidden space-y-2.5 no-print w-full max-w-full min-w-0">
        {displayRanked.map((s) => {
          const handle = s.handle;
          const selectedIndexes = bestThreeSelectedIndexes(
            eventSlots.map((event) => pointsFor(s, event.regattaId).points),
            { higherIsBetter: true, excludedIndexes }
          );
          const squadPick = projectedSquadMap.get(s.sailorId);
          return (
            <div
              key={s.sailorId}
              className="w-full max-w-full min-w-0 rounded-2xl p-3 border border-cool-veil bg-warm-white space-y-2.5"
            >
              <div className="flex items-start justify-between gap-2 min-w-0">
                <div className="min-w-0 flex-1">
                  <div className="flex items-center gap-2 min-w-0">
                    <RankMedalBadge
                      rank={s.displayRank}
                      className="w-6 shrink-0"
                      nonPodiumClassName="text-sky-400 font-black text-sm shrink-0 tabular-nums w-6 text-center"
                    />
                    {handle ? (
                      <Link
                        href={`/${handle}`}
                        className="font-bold text-charcoal hover:text-harbour text-[15px] leading-snug break-words min-w-0"
                      >
                        {s.name}
                      </Link>
                    ) : (
                      <span className="font-bold text-charcoal text-[15px]">
                        {s.name}
                      </span>
                    )}
                  </div>
                  <p className="text-[11px] text-slate-soft mt-1">
                    {s.gender || "—"} · Born {s.birthYear ?? "—"}
                  </p>
                </div>
                <div className="text-right shrink-0 pl-1">
                  <p className="text-[9px] text-slate-soft uppercase font-bold tracking-wide">
                    Best 3
                  </p>
                  <p className="font-black text-charcoal text-lg tabular-nums leading-none mt-0.5">
                    {s.totalPoints}
                  </p>
                </div>
              </div>

              {/* Regatta Scores Strip */}
              <div className="grid grid-cols-5 gap-1.5 w-full min-w-0">
                {Array.from({ length: 5 }).map((_, idx) => {
                  const ev = eventSlots[idx];
                  if (!ev) {
                    return (
                      <div
                        key={`pad-${idx}`}
                        className="min-w-0 rounded-lg border border-cool-veil bg-sailcloth/30 px-1 py-1.5 flex flex-col justify-between text-center opacity-40"
                      >
                        <p className="text-[8px] text-slate-600 font-black">
                          R{idx + 1}
                        </p>
                        <p className="text-[13px] font-mono text-slate-600 my-0.5">—</p>
                        <span className="text-[7.5px] text-slate-700 leading-none py-0.5">—</span>
                      </div>
                    );
                  }
                  const isRegattaExcluded = excluded.has(ev.regattaId);
                  const { points, isDns } = pointsFor(s, ev.regattaId);
                  const selected = selectedIndexes.has(idx);
                  const badge = mobileRegattaBadge(ev.regattaName, idx);
                  const hasScore = points != null && Number.isFinite(points);
                  const isCounted = selected && hasScore && !isRegattaExcluded;
                  const isDropped = (!selected || isRegattaExcluded) && hasScore;
                  return (
                    <div
                      key={ev.regattaId}
                      data-best-three-selected={selected || undefined}
                      className={`min-w-0 rounded-lg border px-1 py-1.5 flex flex-col justify-between text-center transition-all ${
                        isRegattaExcluded
                          ? "border-rose-500/20 bg-rose-500/5 opacity-50"
                          : isCounted
                            ? "border-sky-400/60 bg-sky-500/20 ring-1 ring-sky-500/40 shadow-sm"
                            : isDropped
                              ? "border-cool-veil bg-sailcloth/40 opacity-70"
                              : "border-cool-veil bg-sailcloth"
                      }`}
                      title={`${ev.regattaName}${selected ? " · counts toward Best 3 of 5" : ""}${isRegattaExcluded ? " (regatta excluded)" : ""}`}
                    >
                      <div className="flex items-center justify-center gap-0.5 text-[8px] leading-tight font-bold truncate">
                        <span className="text-sky-400/90 font-black">R{idx + 1}</span>
                        <span className="text-slate-500">·</span>
                        <span className="text-slate-soft truncate">{badge}</span>
                      </div>

                      <div className={`my-0.5 text-[13px] font-mono tabular-nums leading-tight ${
                        isCounted
                          ? "text-charcoal font-black text-[14px]"
                          : isDropped
                            ? "text-slate-400 font-semibold line-through decoration-slate-500/60"
                            : "text-slate-500 font-medium"
                      }`}>
                        {selected && <span className="sr-only">Selected score: </span>}
                        {scoreCell(points, isDns)}
                      </div>

                      <div>
                        {isRegattaExcluded ? (
                          <span className="inline-block text-[7.5px] font-bold uppercase tracking-wider text-rose-500 leading-none py-0.5">
                            Excl
                          </span>
                        ) : isCounted ? (
                          <span className="inline-flex items-center justify-center text-[7.5px] font-black uppercase tracking-wider text-sky-700 dark:text-sky-200 bg-sky-500/30 border border-sky-400/30 rounded px-1 py-0.5 leading-none w-full">
                            ★ Count
                          </span>
                        ) : isDropped ? (
                          <span className="inline-block text-[7.5px] font-medium uppercase tracking-wider text-slate-500 leading-none py-0.5">
                            Drop
                          </span>
                        ) : (
                          <span className="inline-block text-[7.5px] text-slate-600 leading-none py-0.5">
                            —
                          </span>
                        )}
                      </div>
                    </div>
                  );
                })}
              </div>

              {/* Projected Squad Footer in mobile card */}
              <div className="pt-2 border-t border-cool-veil flex items-center justify-between text-[11px]">
                <span className="text-slate-soft text-[10px] font-bold uppercase tracking-wider">
                  Proj. NJTS:
                </span>
                {isLoggedIn ? (
                  squadPick ? (
                    <span className="inline-flex items-center rounded-full bg-amber-500/15 border border-amber-400/30 px-2 py-0.5 text-[10px] font-bold text-amber-600 dark:text-amber-300">
                      {squadReasonLabel(squadPick.reason)}
                    </span>
                  ) : (
                    <span className="text-slate-soft/60 text-[11px]">—</span>
                  )
                ) : (
                  <Link
                    href="/login"
                    className="inline-flex items-center gap-1 text-[10px] text-sky-600 dark:text-sky-400 font-semibold hover:underline"
                  >
                    <Lock className="h-2.5 w-2.5" />
                    Sign in to view
                  </Link>
                )}
              </div>
            </div>
          );
        })}
      </div>

      {/* Desktop Table View */}
      <div className="hidden md:block rounded-2xl border border-cool-veil bg-warm-white overflow-hidden w-full max-w-full min-w-0">
        <div className="overflow-x-auto max-w-full">
          <table className="w-full text-left text-sm min-w-[760px] border-collapse">
            <thead className="text-[10px] text-slate-400 uppercase tracking-wider">
              <tr>
                <th className="sticky top-0 z-20 px-4 lg:px-5 py-3 w-12 bg-aqua-mist border-b border-cool-veil">
                  #
                </th>
                <th className="sticky top-0 z-20 px-4 lg:px-5 py-3 bg-aqua-mist border-b border-cool-veil">
                  Sailor
                </th>
                <th className="sticky top-0 z-20 px-3 py-3 text-center bg-aqua-mist border-b border-cool-veil">
                  Gender
                </th>
                <th className="sticky top-0 z-20 px-3 py-3 text-center bg-aqua-mist border-b border-cool-veil">
                  Birth year
                </th>
                {Array.from({ length: 5 }).map((_, idx) => {
                  const ev = eventSlots[idx];
                  const off = ev ? excluded.has(ev.regattaId) : false;
                  return (
                    <th
                      key={ev?.regattaId || `r${idx}`}
                      className={`sticky top-0 z-20 px-2.5 py-2.5 text-center bg-aqua-mist border-b border-cool-veil min-w-[7.5rem] max-w-[12rem] ${off ? "opacity-50" : ""}`}
                      title={
                        ev
                          ? `${ev.regattaName} · ${ev.date} · fleet ${ev.fleetSize}${off ? " (Excluded)" : ""}`
                          : `R${idx + 1}`
                      }
                    >
                      <span className="block text-sky-400 font-black normal-case tracking-normal">
                        R{idx + 1} {off && <span className="text-[9px] text-rose-400 uppercase tracking-tight">(Excl)</span>}
                      </span>
                      <span className="block text-[10px] font-semibold text-charcoal normal-case tracking-normal leading-snug mt-0.5 whitespace-normal break-words">
                        {ev ? regattaDisplayName(ev.regattaName, idx) : "—"}
                      </span>
                    </th>
                  );
                })}
                <th className="sticky top-0 z-20 px-4 lg:px-5 py-3 text-center bg-aqua-mist border-b border-cool-veil">
                  Best 3 of 5
                </th>
                <th className="sticky top-0 z-20 px-3 py-3 text-center bg-aqua-mist border-b border-cool-veil">
                  {isLoggedIn ? (
                    <span title="Projected National Junior Training Squad selection based on current ranking and eligibility criteria">
                      Proj. Squad
                    </span>
                  ) : (
                    <span className="inline-flex items-center justify-center gap-1 text-slate-soft" title="Sign in to view projected squad status">
                      <Lock className="h-3 w-3" />
                      <span>Proj. Squad</span>
                    </span>
                  )}
                </th>
              </tr>
            </thead>
            <tbody>
              {displayRanked.map((s) => {
                const handle = s.handle;
                const selectedIndexes = bestThreeSelectedIndexes(
                  eventSlots.map((event) =>
                    pointsFor(s, event.regattaId).points
                  ),
                  { higherIsBetter: true, excludedIndexes }
                );
                const squadPick = projectedSquadMap.get(s.sailorId);
                return (
                  <tr
                    key={s.sailorId}
                    className="border-t border-cool-veil hover:bg-sailcloth/30"
                  >
                    <td className="px-4 lg:px-5 py-3.5">
                      <RankMedalBadge
                        rank={s.displayRank}
                        nonPodiumClassName="font-bold text-sky-400 font-mono"
                      />
                    </td>
                    <td className="px-4 lg:px-5 py-3.5">
                      {handle ? (
                        <Link
                          href={`/${handle}`}
                          className="font-bold text-charcoal hover:text-harbour"
                        >
                          {s.name}
                        </Link>
                      ) : (
                        <span className="font-bold text-charcoal">{s.name}</span>
                      )}
                    </td>
                    <td className="px-3 py-3.5 text-center text-slate-soft">
                      {s.gender || "—"}
                    </td>
                    <td className="px-3 py-3.5 text-center font-mono text-slate-soft">
                      {s.birthYear ?? "—"}
                    </td>
                    {Array.from({ length: 5 }).map((_, idx) => {
                      const ev = eventSlots[idx];
                      if (!ev) {
                        return (
                          <td
                            key={`empty-${idx}`}
                            className="px-3 py-3.5 text-center text-slate-soft/40"
                          >
                            —
                          </td>
                        );
                      }
                      const isRegattaExcluded = excluded.has(ev.regattaId);
                      const { points, isDns } = pointsFor(s, ev.regattaId);
                      const selected = selectedIndexes.has(idx);
                      return (
                        <td
                          key={ev.regattaId}
                          data-best-three-selected={selected || undefined}
                          className={`px-3 py-3.5 text-center font-mono text-xs ${
                            isRegattaExcluded
                              ? "opacity-40 line-through text-slate-400 bg-rose-500/5"
                              : selected
                                ? "bg-aqua-mist font-bold text-harbour shadow-[inset_0_0_0_1px_rgba(10,85,87,0.2)]"
                                : "font-medium text-slate-soft"
                          }`}
                          title={
                            isRegattaExcluded
                              ? `${ev.regattaName} · (Excluded from ranking)`
                              : isDns
                                ? `${ev.regattaName} · DNS${selected ? " · counts toward Best 3 of 5" : ""}`
                                : `${ev.regattaName} · ${points} pts${selected ? " · counts toward Best 3 of 5" : ""}`
                          }
                        >
                          {selected && !isRegattaExcluded && <span className="sr-only">Selected score: </span>}
                          {scoreCell(points, isDns)}
                        </td>
                      );
                    })}
                    <td className="px-4 lg:px-5 py-3.5 text-center font-black text-charcoal text-base">
                      {s.totalPoints}
                    </td>
                    <td className="px-3 py-3.5 text-center">
                      {isLoggedIn ? (
                        squadPick ? (
                          <span
                            className="inline-flex items-center rounded-full bg-amber-500/15 border border-amber-400/30 px-2 py-0.5 text-[10px] font-bold text-amber-600 dark:text-amber-300 whitespace-nowrap"
                            title={`Rank #${squadPick.rankingPosition} · ${squadReasonLabel(squadPick.reason)}`}
                          >
                            {squadReasonLabel(squadPick.reason)}
                          </span>
                        ) : (
                          <span className="text-slate-soft/50 text-xs">—</span>
                        )
                      ) : (
                        <Link
                          href="/login"
                          className="inline-flex items-center gap-1 text-[10px] text-slate-soft hover:text-sky-500 transition-colors"
                          title="Sign in to view projected squad status"
                        >
                          <Lock className="h-2.5 w-2.5" />
                          <span>Sign in</span>
                        </Link>
                      )}
                    </td>
                  </tr>
                );
              })}
            </tbody>
          </table>
        </div>
        <p className="px-4 py-3 text-[11px] text-slate-soft border-t border-cool-veil bg-sailcloth leading-relaxed">
          <strong className="text-charcoal">Scoring &amp; Selection:</strong> High Ranking Points apply: in a fleet of N, 1st earns N points, 2nd earns N−1, and * = DNS (0 pts). R1–R5 show up to the last 5 ranking regattas on or before the cutoff (R1 oldest). Best 3 of 5 is the sum of the three highest scores (highlighted in aqua; higher total is better). Projected National Junior Training Squad (NJTS) status is computed according to the Singapore ILCA 4 Ranking System criteria (top 25 overall, age ≤ 17, gender/age quotas).
        </p>
      </div>
    </div>
  );
}
