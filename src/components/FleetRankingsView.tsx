"use client";

import { useEffect, useMemo, useState } from "react";
import Link from "next/link";
import type { RankedSailor, Period } from "@/lib/ranking";
import { reRankWithExcluded } from "@/lib/ranking";
import {
  currentPeriodFromSgToday,
  rankingPeriodOptions,
} from "@/lib/datesSg";
import { Trophy, Calendar, RotateCcw } from "lucide-react";

const PERIODS = rankingPeriodOptions(6);
const DEFAULT_PERIOD = currentPeriodFromSgToday();

function scoreCell(
  score: number | undefined,
  isDNS?: boolean,
  isOverseas?: boolean
) {
  if (score == null || !Number.isFinite(score)) return "—";
  if (isOverseas) return `${score}†`;
  if (isDNS) return `${score}*`;
  return String(score);
}

function birthYear(dob?: string | null) {
  if (!dob) return "—";
  const y = new Date(dob).getFullYear();
  return Number.isFinite(y) ? String(y) : "—";
}

/** Compact header label for a regatta (keep readable in sticky column) */
function shortRegattaName(name: string | undefined | null, idx: number) {
  if (!name || !String(name).trim()) return `R${idx + 1}`;
  const n = String(name).trim();
  if (n.length <= 18) return n;
  const words = n.split(/\s+/);
  let out = "";
  for (const w of words) {
    const next = out ? `${out} ${w}` : w;
    if (next.length > 16) break;
    out = next;
  }
  return (out || n.slice(0, 16)) + "…";
}

type Slot = {
  regattaId: string;
  regattaName: string;
  isCarryForward?: boolean;
  periodLabel?: string;
};

export function FleetRankingsView({
  fleet,
  initialPeriod,
}: {
  fleet: "Gold" | "Silver";
  initialPeriod?: Period;
}) {
  const [period, setPeriod] = useState<Period>(
    initialPeriod || DEFAULT_PERIOD
  );
  const [ranked, setRanked] = useState<RankedSailor[]>([]);
  const [error, setError] = useState<string | null>(null);
  const [loading, setLoading] = useState(true);
  /** Regatta IDs excluded from Best 3 of 5 (client what-if) */
  const [excluded, setExcluded] = useState<Set<string>>(new Set());
  const [genderFilter, setGenderFilter] = useState<"all" | "M" | "F">("all");
  const [squadFilter, setSquadFilter] = useState<string>("all");

  useEffect(() => {
    let cancelled = false;
    (async () => {
      setLoading(true);
      setError(null);
      setExcluded(new Set());
      setGenderFilter("all");
      setSquadFilter("all");
      try {
        const res = await fetch(
          `/api/rankings?fleet=${fleet}&year=${period.year}&half=${encodeURIComponent(period.half)}`
        );
        const data = await res.json();
        if (!res.ok) throw new Error(data.error || "Failed to load rankings");
        if (!cancelled) setRanked(data.ranked || []);
      } catch (e) {
        if (!cancelled) {
          setRanked([]);
          setError(e instanceof Error ? e.message : "Error");
        }
      } finally {
        if (!cancelled) setLoading(false);
      }
    })();
    return () => {
      cancelled = true;
    };
  }, [fleet, period]);

  const showSquad = fleet === "Gold";

  /** Header for period squad, e.g. "Squad Jul 26" for Jul–Dec 2026 */
  const squadColumnLabel = useMemo(() => {
    const half = period.half === "Jan-Jun" ? "Jan" : "Jul";
    const yy = String(period.year).slice(-2);
    return `Squad ${half} ${yy}`;
  }, [period]);

  /** Period squad only (natSquadStatus* for selected half via API periodSquadStatus) */
  const squadForFilter = (s: RankedSailor) =>
    String(s.periodSquadStatus || s.nationalSquadStatus || "").trim();

  const squadOptions = useMemo(() => {
    const set = new Set<string>();
    for (const s of ranked) {
      const v = squadForFilter(s);
      if (v) set.add(v);
    }
    return Array.from(set).sort((a, b) => a.localeCompare(b));
  }, [ranked]);

  /** R1–R5 slots shared across the fleet */
  const eventSlots: Slot[] = useMemo(() => {
    const slots: Slot[] = [];
    for (let i = 0; i < 5; i++) {
      let name = "";
      let id = `slot-${i}`;
      let isCarryForward = false;
      let periodLabel: string | undefined;
      for (const s of ranked) {
        const rs = s.regattaScores?.[i];
        if (rs?.regattaName || rs?.regattaId) {
          name = rs.regattaName || "";
          id = rs.regattaId || id;
          isCarryForward = Boolean(rs.isCarryForward);
          periodLabel = rs.periodLabel;
          break;
        }
      }
      slots.push({ regattaId: id, regattaName: name, isCarryForward, periodLabel });
    }
    return slots;
  }, [ranked]);

  // ranks re-numbered after filter (displayRanked order)

  const filteredRanked = useMemo(() => {
    return ranked.filter((s) => {
      if (genderFilter !== "all") {
        const g = String(s.gender || "").toUpperCase();
        if (g !== genderFilter) return false;
      }
      if (showSquad && squadFilter !== "all") {
        const sq = String(squadForFilter(s) || "").trim();
        if (squadFilter === "none") {
          if (sq) return false;
        } else if (sq !== squadFilter) {
          return false;
        }
      }
      return true;
    });
  }, [ranked, genderFilter, squadFilter, showSquad]);

  const displayRanked = useMemo(() => {
    if (excluded.size === 0) return filteredRanked;
    return reRankWithExcluded(filteredRanked, excluded);
  }, [filteredRanked, excluded]);

  const carryCount = eventSlots.filter((s) => s.isCarryForward && s.regattaName).length;
  const currentCount = eventSlots.filter((s) => !s.isCarryForward && s.regattaName).length;

  const toggleExclude = (regattaId: string) => {
    if (!regattaId || regattaId.startsWith("slot-")) return;
    setExcluded((prev) => {
      const next = new Set(prev);
      if (next.has(regattaId)) next.delete(regattaId);
      else next.add(regattaId);
      return next;
    });
  };

  const padScores = (s: RankedSailor, rowIdx: number) => {
    const scores = [...(s.regattaScores || [])];
    while (scores.length < 5) {
      scores.push({
        regattaId: eventSlots[scores.length]?.regattaId || `pad-${rowIdx}-${scores.length}`,
        regattaName: eventSlots[scores.length]?.regattaName || "",
        score: NaN as unknown as number,
        isDNS: false,
      });
    }
    return scores.slice(0, 5);
  };

  const isCurrent =
    period.year === 2026 && period.half === "Jul-Dec";
  const periodLabelText =
    PERIODS.find(
      (p) => p.period.year === period.year && p.period.half === period.half
    )?.label || `${period.half} ${period.year}`;

  const squadFor = (s: RankedSailor) =>
    s.periodSquadStatus || s.nationalSquadStatus || null;

  return (
    <div className="print-rankings mx-auto max-w-7xl px-4 sm:px-6 lg:px-8 py-8 sm:py-12 space-y-6">
      <div className="flex flex-col lg:flex-row lg:items-end justify-between gap-4 no-print">
        <div className="flex items-start gap-3">
          <span className="flex h-10 w-10 shrink-0 items-center justify-center rounded-xl bg-orange-600/10 text-orange-500 border border-orange-500/20">
            <Trophy className="h-5 w-5" />
          </span>
          <div>
            <p className="text-xs font-bold text-orange-400 uppercase tracking-wide">
              SG Optimist
            </p>
            <h1 className="text-2xl sm:text-3xl lg:text-4xl font-black text-white tracking-tight">
              {fleet} Fleet Rankings
            </h1>
            <p className="text-xs sm:text-sm text-slate-500 mt-1">
              Best 3 of 5 · * = DNS (fleet size + 1) · † = overseas commitment
              (points = standing)
              {carryCount > 0 && (
                <span className="ml-2 text-sky-400/90 font-semibold">
                  · {carryCount} carry-forward from previous period
                </span>
              )}
              {!isCurrent && (
                <span className="ml-2 text-amber-400/90 font-semibold">
                  · Archive period
                </span>
              )}
            </p>
          </div>
        </div>
        <div className="flex flex-col sm:flex-row flex-wrap items-stretch sm:items-center gap-2 w-full lg:w-auto">
          <div className="flex items-center gap-2 min-w-0">
            <Calendar className="h-4 w-4 text-orange-500 shrink-0" />
            <select
              value={`${period.year}|${period.half}`}
              onChange={(e) => {
                const [year, half] = e.target.value.split("|");
                setPeriod({ year: Number(year), half: half as Period["half"] });
              }}
              className="flex-1 sm:flex-none min-w-0 rounded-xl bg-slate-950 border border-white/10 px-3 sm:px-4 py-2.5 text-sm text-white font-semibold"
            >
              {PERIODS.map(({ period: p, label }) => (
                <option key={`${p.year}-${p.half}`} value={`${p.year}|${p.half}`}>
                  {label}
                </option>
              ))}
            </select>
          </div>
          <div className="grid grid-cols-2 sm:flex gap-2">
            <select
              value={genderFilter}
              onChange={(e) =>
                setGenderFilter(e.target.value as "all" | "M" | "F")
              }
              className="rounded-xl bg-slate-950 border border-white/10 px-3 py-2.5 text-xs sm:text-sm text-white font-semibold"
              aria-label="Filter by gender"
            >
              <option value="all">All genders</option>
              <option value="M">Male</option>
              <option value="F">Female</option>
            </select>
            {showSquad && (
              <select
                value={squadFilter}
                onChange={(e) => setSquadFilter(e.target.value)}
                className="rounded-xl bg-slate-950 border border-white/10 px-3 py-2.5 text-xs sm:text-sm text-white font-semibold"
                aria-label="Filter by squad"
              >
                <option value="all">All squads</option>
                <option value="none">No squad</option>
                {squadOptions.map((sq) => (
                  <option key={sq} value={sq}>
                    {sq}
                  </option>
                ))}
              </select>
            )}
          </div>
        </div>
      </div>

      {(genderFilter !== "all" || squadFilter !== "all") && !loading && (
        <p className="text-[11px] text-amber-200/90 font-semibold no-print">
          Showing {displayRanked.length} of {ranked.length} sailors
          {genderFilter !== "all"
            ? ` · ${genderFilter === "M" ? "Male" : "Female"}`
            : ""}
          {squadFilter !== "all"
            ? ` · ${squadFilter === "none" ? "No squad" : squadFilter}`
            : ""}
          . Rank # restarts within this filter.
        </p>
      )}

      <p className="hidden print:block text-sm font-bold text-black">
        SG Optimist {fleet} Fleet Rankings — {periodLabelText}
      </p>

      {/* Sticky event legend + exclude toggles */}
      {!loading && ranked.length > 0 && (
        <div className="sticky top-0 z-30 -mx-1 px-1 no-print">
          <div className="rounded-xl border border-white/10 bg-[#0c0d14]/95 backdrop-blur-md shadow-lg shadow-black/40 px-3 sm:px-4 py-2.5 sm:py-3 space-y-2">
            <div className="flex flex-col sm:flex-row sm:items-center justify-between gap-2">
              <p className="text-[10px] font-bold text-slate-500 uppercase tracking-wider">
                Scoring events — R1 oldest · R5 newest
                {carryCount > 0 && (
                  <span className="normal-case tracking-normal text-sky-400/90 font-semibold ml-1">
                    ({currentCount} this period + {carryCount} previous)
                  </span>
                )}
              </p>
              <div className="flex items-center gap-2">
                <p className="text-[10px] text-slate-500 font-semibold">
                  Uncheck a regatta to exclude it from Best 3 of 5
                </p>
                {excluded.size > 0 && (
                  <button
                    type="button"
                    onClick={() => setExcluded(new Set())}
                    className="inline-flex items-center gap-1 rounded-full border border-amber-500/30 bg-amber-500/10 px-2.5 py-1 text-[10px] font-bold text-amber-200"
                  >
                    <RotateCcw className="h-3 w-3" />
                    Reset ({excluded.size} off)
                  </button>
                )}
              </div>
            </div>
            {/* Mobile strip */}
            <div className="flex md:hidden gap-1.5 overflow-x-auto pb-0.5">
              {eventSlots.map((ev, idx) => {
                const off = excluded.has(ev.regattaId);
                const canToggle = Boolean(ev.regattaName) && !ev.regattaId.startsWith("slot-");
                return (
                  <button
                    key={ev.regattaId + idx}
                    type="button"
                    disabled={!canToggle}
                    onClick={() => toggleExclude(ev.regattaId)}
                    className={`shrink-0 w-[4.75rem] rounded-lg border px-1.5 py-1.5 text-center transition-all ${
                      off
                        ? "bg-slate-900/80 border-rose-500/40 opacity-50"
                        : ev.isCarryForward
                          ? "bg-sky-500/10 border-sky-500/25"
                          : "bg-white/5 border-white/5"
                    } ${canToggle ? "cursor-pointer" : "cursor-default"}`}
                    title={
                      canToggle
                        ? `${off ? "Include" : "Exclude"} ${ev.regattaName}`
                        : undefined
                    }
                  >
                    <p className="text-[9px] font-black text-orange-400">R{idx + 1}</p>
                    <p className="text-[8px] font-semibold text-slate-300 leading-tight line-clamp-2">
                      {shortRegattaName(ev.regattaName, idx)}
                    </p>
                    {ev.isCarryForward && (
                      <p className="text-[7px] font-bold text-sky-400 mt-0.5">prev</p>
                    )}
                    {canToggle && (
                      <p className="text-[7px] font-bold text-slate-500 mt-0.5">
                        {off ? "OFF" : "ON"}
                      </p>
                    )}
                  </button>
                );
              })}
            </div>
            <div className="hidden md:grid grid-cols-5 gap-2">
              {eventSlots.map((ev, idx) => {
                const off = excluded.has(ev.regattaId);
                const canToggle = Boolean(ev.regattaName) && !ev.regattaId.startsWith("slot-");
                return (
                  <label
                    key={ev.regattaId + idx}
                    className={`rounded-lg border px-2.5 py-2 min-h-[3.25rem] flex flex-col gap-1 transition-all ${
                      off
                        ? "bg-slate-900/80 border-rose-500/40 opacity-60"
                        : ev.isCarryForward
                          ? "bg-sky-500/10 border-sky-500/25"
                          : "bg-white/5 border-white/5"
                    } ${canToggle ? "cursor-pointer hover:border-orange-500/30" : ""}`}
                  >
                    <div className="flex items-start justify-between gap-1">
                      <p className="text-[10px] font-black text-orange-400">R{idx + 1}</p>
                      {canToggle && (
                        <input
                          type="checkbox"
                          checked={!off}
                          onChange={() => toggleExclude(ev.regattaId)}
                          className="mt-0.5 h-3.5 w-3.5 rounded border-slate-600 bg-slate-900 text-orange-600 focus:ring-orange-500"
                          title={off ? "Include in Best 3 of 5" : "Exclude from Best 3 of 5"}
                        />
                      )}
                    </div>
                    <p
                      className="text-[11px] font-semibold text-slate-200 leading-snug line-clamp-2"
                      title={ev.regattaName || undefined}
                    >
                      {ev.regattaName || "— (no event yet)"}
                    </p>
                    {ev.isCarryForward && (
                      <p className="text-[9px] font-bold text-sky-400">
                        Carry · {ev.periodLabel || "previous"}
                      </p>
                    )}
                  </label>
                );
              })}
            </div>
            {excluded.size > 0 && (
              <p className="text-[11px] text-amber-200/90 font-semibold">
                Viewing what-if ranking: {excluded.size} regatta
                {excluded.size === 1 ? "" : "s"} excluded · Best 3 of remaining
                scores. Official standings restore when you reset.
              </p>
            )}
          </div>
        </div>
      )}

      {loading && <p className="text-sm text-slate-500">Loading rankings…</p>}
      {error && (
        <div className="rounded-xl border border-rose-500/30 bg-rose-500/10 p-4 text-xs sm:text-sm text-rose-300 no-print">
          {error}{" "}
          <Link href="/api/health" className="underline font-bold">
            Check /api/health
          </Link>
        </div>
      )}
      {!loading && !error && ranked.length === 0 && (
        <p className="text-sm text-slate-500">
          {isCurrent
            ? "No ranked sailors for this period. Import regattas and set fleet entry / current fleet in admin."
            : `No ranked sailors for archive period ${periodLabelText}. Try another half-year or check entry dates.`}
        </p>
      )}

      {/* Mobile cards */}
      <div className="md:hidden space-y-3 no-print">
        {displayRanked.map((s, i) => {
          const scores = padScores(s, i);
          return (
            <div
              key={s.id}
              className="glass-card rounded-2xl p-4 border border-white/5 space-y-3"
            >
              <div className="flex items-start justify-between gap-3">
                <div>
                  <p className="text-orange-400 font-black text-sm">#{i + 1}</p>
                  <Link
                    href={`/${s.handle}`}
                    className="font-bold text-white hover:text-orange-400"
                  >
                    {s.name}
                  </Link>
                  <p className="text-[11px] text-slate-500 mt-1">
                    {s.gender || "—"} · Born {birthYear(s.dob)}
                  </p>
                  {showSquad && (
                    <p className="text-[11px] text-orange-300/90 mt-1 font-semibold">
                      {squadColumnLabel}: {squadFor(s) || "—"}
                    </p>
                  )}
                </div>
                <div className="text-right">
                  <p className="text-[10px] text-slate-500 uppercase font-bold">
                    Best 3 of 5
                  </p>
                  <p className="font-black text-white text-lg">{s.overallScore}</p>
                </div>
              </div>
              <div className="grid grid-cols-5 gap-1.5">
                {scores.map((rs, idx) => {
                  const off = excluded.has(rs.regattaId);
                  return (
                    <div
                      key={rs.regattaId + idx}
                      className={`rounded-lg border px-1 py-1.5 text-center ${
                        off
                          ? "bg-slate-900/60 border-rose-500/30 opacity-50"
                          : rs.isCarryForward
                            ? "bg-sky-500/10 border-sky-500/20"
                            : "bg-white/5 border-white/5"
                      }`}
                      title={rs.regattaName || eventSlots[idx]?.regattaName || undefined}
                    >
                      <p className="text-[9px] text-orange-400/90 font-black">
                        R{idx + 1}
                      </p>
                      <p className="text-[8px] text-slate-500 leading-tight line-clamp-2 min-h-[1.5rem]">
                        {shortRegattaName(
                          rs.regattaName || eventSlots[idx]?.regattaName,
                          idx
                        )}
                      </p>
                      <p className="text-xs font-mono font-bold text-white mt-0.5">
                        {Number.isFinite(rs.score)
                          ? scoreCell(
                              rs.score,
                              rs.isDNS,
                              rs.isOverseasCommitment
                            )
                          : "—"}
                      </p>
                    </div>
                  );
                })}
              </div>
            </div>
          );
        })}
      </div>

      {/* Desktop table */}
      <div className="hidden md:block rounded-2xl border border-white/5 overflow-hidden">
        <div className="overflow-x-auto max-h-[min(75vh,900px)] overflow-y-auto">
          <table className="w-full text-left text-sm min-w-[720px] border-collapse">
            <thead className="text-[10px] text-slate-400 uppercase tracking-wider">
              <tr>
                <th className="sticky top-0 z-20 px-4 lg:px-5 py-3 w-12 bg-[#12141c] border-b border-white/10 shadow-[0_1px_0_0_rgba(255,255,255,0.06)]">
                  #
                </th>
                <th className="sticky top-0 z-20 px-4 lg:px-5 py-3 bg-[#12141c] border-b border-white/10 shadow-[0_1px_0_0_rgba(255,255,255,0.06)]">
                  Sailor
                </th>
                <th className="sticky top-0 z-20 px-3 py-3 text-center bg-[#12141c] border-b border-white/10 shadow-[0_1px_0_0_rgba(255,255,255,0.06)]">
                  Gender
                </th>
                <th className="sticky top-0 z-20 px-3 py-3 text-center bg-[#12141c] border-b border-white/10 shadow-[0_1px_0_0_rgba(255,255,255,0.06)]">
                  Birth year
                </th>
                {showSquad && (
                  <th
                    className="sticky top-0 z-20 px-4 lg:px-5 py-3 bg-[#12141c] border-b border-white/10 shadow-[0_1px_0_0_rgba(255,255,255,0.06)]"
                    title={`National squad for ${periodLabelText}`}
                  >
                    {squadColumnLabel}
                  </th>
                )}
                {eventSlots.map((ev, idx) => {
                  const off = excluded.has(ev.regattaId);
                  return (
                    <th
                      key={ev.regattaId + idx}
                      className={`sticky top-0 z-20 px-2 py-2 text-center border-b border-white/10 shadow-[0_1px_0_0_rgba(255,255,255,0.06)] max-w-[7.5rem] ${
                        off
                          ? "bg-[#1a1214]"
                          : ev.isCarryForward
                            ? "bg-[#101820]"
                            : "bg-[#12141c]"
                      }`}
                      title={
                        (ev.regattaName || `R${idx + 1}`) +
                        (ev.isCarryForward ? " (carry-forward)" : "") +
                        (off ? " · excluded" : "")
                      }
                    >
                      <span className="block text-orange-400 font-black normal-case tracking-normal">
                        R{idx + 1}
                        {off ? " · off" : ""}
                      </span>
                      <span className="block text-[9px] font-semibold text-slate-400 normal-case tracking-normal leading-tight mt-0.5 line-clamp-2">
                        {shortRegattaName(ev.regattaName, idx)}
                      </span>
                      {ev.isCarryForward && (
                        <span className="block text-[8px] font-bold text-sky-400 normal-case mt-0.5">
                          prev
                        </span>
                      )}
                    </th>
                  );
                })}
                <th className="sticky top-0 z-20 px-4 lg:px-5 py-3 text-center bg-[#12141c] border-b border-white/10 shadow-[0_1px_0_0_rgba(255,255,255,0.06)]">
                  Best 3 of 5
                </th>
              </tr>
            </thead>
            <tbody>
              {displayRanked.map((s, i) => {
                const scores = padScores(s, i);
                return (
                  <tr
                    key={s.id}
                    className="border-t border-white/5 hover:bg-white/[0.02]"
                  >
                    <td className="px-4 lg:px-5 py-3.5 font-bold text-orange-400">
                      {i + 1}
                    </td>
                    <td className="px-4 lg:px-5 py-3.5">
                      <Link
                        href={`/${s.handle}`}
                        className="font-bold text-white hover:text-orange-400"
                      >
                        {s.name}
                      </Link>
                    </td>
                    <td className="px-3 py-3.5 text-center text-slate-300">
                      {s.gender || "—"}
                    </td>
                    <td className="px-3 py-3.5 text-center font-mono text-slate-300">
                      {birthYear(s.dob)}
                    </td>
                    {showSquad && (
                      <td className="px-4 lg:px-5 py-3.5">
                        {squadFor(s) ? (
                          <span className="rounded-full bg-orange-500/10 border border-orange-500/20 px-2 py-0.5 text-[10px] font-extrabold text-orange-400">
                            {squadFor(s)}
                          </span>
                        ) : (
                          <span className="text-slate-600">—</span>
                        )}
                      </td>
                    )}
                    {scores.map((rs, idx) => {
                      const off = excluded.has(rs.regattaId);
                      return (
                        <td
                          key={rs.regattaId + idx}
                          className={`px-3 py-3.5 text-center font-mono text-xs ${
                            off ? "text-slate-600 line-through" : "text-slate-300"
                          }`}
                          title={
                            rs.regattaName || eventSlots[idx]?.regattaName
                              ? `${rs.regattaName || eventSlots[idx]?.regattaName}${
                                  rs.isCarryForward ? " · carry-forward" : ""
                                }${
                                  rs.isOverseasCommitment
                                    ? " (Overseas commitment)"
                                    : rs.isDNS
                                      ? " (DNS)"
                                      : ""
                                }${off ? " · excluded" : ""}`
                              : undefined
                          }
                        >
                          {Number.isFinite(rs.score)
                            ? scoreCell(
                                rs.score,
                                rs.isDNS,
                                rs.isOverseasCommitment
                              )
                            : "—"}
                        </td>
                      );
                    })}
                    <td className="px-4 lg:px-5 py-3.5 text-center font-black text-white text-base">
                      {s.overallScore}
                    </td>
                  </tr>
                );
              })}
            </tbody>
          </table>
        </div>
        <p className="px-4 py-2 text-[10px] text-slate-600 border-t border-white/5 bg-[#0c0d14]">
          R1–R5 = scoring window for this fleet (R1 = oldest, R5 = newest). If the
          current half has fewer than 5 events, the most recent events from the
          previous half fill the window (sky “prev” / carry). Best 3 of 5 = sum of
          the three best (lowest) scores. Ties: compare all regatta ranks best-first
          (a 1st beats a 2nd, then next-best, and so on), then name. Uncheck events
          above for a what-if score. * = DNS (fleet size + 1). † = SSF overseas
          commitment. {squadColumnLabel} = national squad for the selected period.
        </p>
      </div>
    </div>
  );
}
