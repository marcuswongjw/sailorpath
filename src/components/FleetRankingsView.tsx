"use client";

import { useEffect, useMemo, useRef, useState } from "react";
import Link from "next/link";
import type { RankedSailor, Period } from "@/lib/ranking";
import { reRankWithExcluded } from "@/lib/ranking";
import {
  currentPeriodFromSgToday,
  rankingPeriodOptions,
} from "@/lib/datesSg";
import {
  projectedNextSquadLabel,
  withProjectedNextSquadStatus,
} from "@/lib/optimistSquadPreview";
import { Trophy, Calendar, RotateCcw } from "lucide-react";
import { trackClientUsage } from "@/lib/clientUsage";
import { formatGenderLabel, normalizeGender } from "@/lib/gender";

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

/** Distinct colours for Nat A vs Nat B (and other squad labels). */
function squadBadgeClass(label: string | null | undefined): string {
  const s = String(label || "")
    .trim()
    .toLowerCase();
  if (s === "nat a" || s === "national a" || s === "a") {
    return "bg-amber-500/15 border-amber-400/35 text-amber-300";
  }
  if (s === "nat b" || s === "national b" || s === "b") {
    return "bg-sky-500/15 border-sky-400/35 text-sky-300";
  }
  if (s === "ds" || s.includes("development")) {
    return "bg-violet-500/15 border-violet-400/35 text-violet-300";
  }
  return "bg-orange-500/10 border-orange-500/20 text-orange-400";
}

function SquadBadge({ label }: { label: string }) {
  return (
    <span
      className={`inline-flex rounded-full border px-2 py-0.5 text-[10px] font-extrabold ${squadBadgeClass(label)}`}
    >
      {label}
    </span>
  );
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
  initialRanked,
  initialError,
}: {
  fleet: "Gold" | "Silver";
  initialPeriod?: Period;
  /** SSR/ISR payload — skips the first client fetch for this period */
  initialRanked?: RankedSailor[];
  initialError?: string | null;
}) {
  const ssrPeriod = initialPeriod || DEFAULT_PERIOD;
  const [period, setPeriod] = useState<Period>(ssrPeriod);
  const [ranked, setRanked] = useState<RankedSailor[]>(initialRanked ?? []);
  const [error, setError] = useState<string | null>(initialError ?? null);
  // No spinner when server already sent the current board
  const [loading, setLoading] = useState(initialRanked === undefined);
  /** Regatta IDs excluded from Best 3 of 5 (client what-if) */
  const [excluded, setExcluded] = useState<Set<string>>(new Set());
  const [genderFilter, setGenderFilter] = useState<
    "all" | "M" | "F" | "unknown"
  >("all");
  const [squadFilter, setSquadFilter] = useState<string>("all");
  /** Skip client fetch once for the SSR period (then always fetch on change). */
  const skipSsrKey = useRef(
    initialRanked !== undefined
      ? `${fleet}:${ssrPeriod.year}:${ssrPeriod.half}`
      : null
  );

  useEffect(() => {
    const key = `${fleet}:${period.year}:${period.half}`;
    if (skipSsrKey.current === key) {
      skipSsrKey.current = null;
      setLoading(false);
      return;
    }

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

  /** Projected next-half Nat A/B column (e.g. Proj. Squad Jan 27) */
  const nextSquadColumnLabel = useMemo(
    () => projectedNextSquadLabel(period),
    [period]
  );

  /** Period squad only (natSquadStatus* for selected half via API periodSquadStatus) */
  const squadForFilter = (s: RankedSailor) =>
    String(s.periodSquadStatus || s.nationalSquadStatus || "").trim();

  const nextSquadFor = (s: RankedSailor) =>
    String(s.nextPeriodSquadStatus || "").trim() || null;

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

  /**
   * Full-fleet what-if rank (exclusions) then Nat A/B projection, then
   * gender / current-squad filters (display # restarts within filter).
   */
  const rankingBase = useMemo(() => {
    if (excluded.size === 0) return ranked;
    return reRankWithExcluded(ranked, excluded);
  }, [ranked, excluded]);

  const rankingWithProjection = useMemo(() => {
    if (fleet !== "Gold" || rankingBase.length === 0) return rankingBase;
    return withProjectedNextSquadStatus(rankingBase, period);
  }, [fleet, rankingBase, period]);

  const displayRanked = useMemo(() => {
    return rankingWithProjection.filter((s) => {
      if (genderFilter !== "all") {
        const g = normalizeGender(s.gender);
        if (genderFilter === "unknown") {
          if (g) return false;
        } else if (g !== genderFilter) {
          return false;
        }
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
  }, [rankingWithProjection, genderFilter, squadFilter, showSquad]);

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
    <div className="print-rankings mx-auto w-full max-w-7xl min-w-0 px-3 sm:px-6 lg:px-8 py-6 sm:py-12 space-y-4 sm:space-y-6 overflow-x-clip">
      <div className="flex flex-col lg:flex-row lg:items-end justify-between gap-3 sm:gap-4 no-print min-w-0">
        <div className="flex items-start gap-2.5 sm:gap-3 min-w-0">
          <span className="flex h-9 w-9 sm:h-10 sm:w-10 shrink-0 items-center justify-center rounded-xl bg-orange-600/10 text-orange-500 border border-orange-500/20">
            <Trophy className="h-4 w-4 sm:h-5 sm:w-5" />
          </span>
          <div className="min-w-0 flex-1">
            <p className="text-[10px] sm:text-xs font-bold text-orange-400 uppercase tracking-wide">
              SG Optimist
            </p>
            <h1 className="text-xl sm:text-3xl lg:text-4xl font-black text-white tracking-tight break-words">
              {fleet} Fleet Rankings
            </h1>
            <p className="text-[11px] sm:text-sm text-slate-500 mt-1 leading-snug">
              Best 3 of 5 · * DNS · † overseas
              {carryCount > 0 && (
                <span className="ml-1.5 text-sky-400/90 font-semibold">
                  · {carryCount} carry-forward
                </span>
              )}
              {!isCurrent && (
                <span className="ml-1.5 text-amber-400/90 font-semibold">
                  · Archive
                </span>
              )}
            </p>
          </div>
        </div>
        <div className="flex flex-col sm:flex-row flex-wrap items-stretch sm:items-center gap-2 w-full lg:w-auto min-w-0">
          <div className="flex items-center gap-2 min-w-0 w-full sm:w-auto">
            <Calendar className="h-4 w-4 text-orange-500 shrink-0" />
            <select
              value={`${period.year}|${period.half}`}
              onChange={(e) => {
                const [year, half] = e.target.value.split("|");
                const next = {
                  year: Number(year),
                  half: half as Period["half"],
                };
                trackClientUsage("ranking_period_change", undefined, {
                  fleet,
                  year: next.year,
                  half: next.half,
                });
                setPeriod(next);
              }}
              className="flex-1 sm:flex-none min-w-0 w-full sm:w-auto max-w-full rounded-xl bg-slate-950 border border-white/10 px-3 sm:px-4 py-2.5 text-sm text-white font-semibold"
            >
              {PERIODS.map(({ period: p, label }) => (
                <option key={`${p.year}-${p.half}`} value={`${p.year}|${p.half}`}>
                  {label}
                </option>
              ))}
            </select>
          </div>
          <div className="grid grid-cols-2 sm:flex gap-2 w-full sm:w-auto min-w-0">
            <select
              value={genderFilter}
              onChange={(e) =>
                setGenderFilter(
                  e.target.value as "all" | "M" | "F" | "unknown"
                )
              }
              className="min-w-0 w-full rounded-xl bg-slate-950 border border-white/10 px-2.5 sm:px-3 py-2.5 text-xs sm:text-sm text-white font-semibold"
              aria-label="Filter by gender"
            >
              <option value="all">All genders</option>
              <option value="M">Male</option>
              <option value="F">Female</option>
              <option value="unknown">Unknown</option>
            </select>
            {showSquad && (
              <select
                value={squadFilter}
                onChange={(e) => setSquadFilter(e.target.value)}
                className="min-w-0 w-full rounded-xl bg-slate-950 border border-white/10 px-2.5 sm:px-3 py-2.5 text-xs sm:text-sm text-white font-semibold"
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
            ? ` · ${
                genderFilter === "M"
                  ? "Male"
                  : genderFilter === "F"
                    ? "Female"
                    : "Unknown gender"
              }`
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

      {/* Sticky event legend + exclude toggles (below site header on mobile) */}
      {!loading && ranked.length > 0 && (
        <div className="sticky top-14 sm:top-16 z-30 w-full max-w-full min-w-0 no-print">
          <div className="rounded-xl border border-white/10 bg-[#0c0d14]/95 backdrop-blur-md shadow-lg shadow-black/40 px-2.5 sm:px-4 py-2 sm:py-3 space-y-2 min-w-0">
            <div className="flex flex-col sm:flex-row sm:items-center justify-between gap-1.5 sm:gap-2 min-w-0">
              <p className="text-[10px] font-bold text-slate-500 uppercase tracking-wider">
                Scoring events — R1 oldest · R5 newest
                {carryCount > 0 && (
                  <span className="normal-case tracking-normal text-sky-400/90 font-semibold ml-1">
                    ({currentCount} this + {carryCount} prev)
                  </span>
                )}
              </p>
              <div className="flex items-center gap-2 min-w-0 flex-wrap">
                <p className="text-[10px] text-slate-500 font-semibold hidden sm:block">
                  Uncheck a regatta to exclude it from Best 3 of 5
                </p>
                <p className="text-[10px] text-slate-500 font-semibold sm:hidden">
                  Tap R# to exclude from Best 3 of 5
                </p>
                {excluded.size > 0 && (
                  <button
                    type="button"
                    onClick={() => setExcluded(new Set())}
                    className="inline-flex items-center gap-1 rounded-full border border-amber-500/30 bg-amber-500/10 px-2.5 py-1 text-[10px] font-bold text-amber-200 shrink-0"
                  >
                    <RotateCcw className="h-3 w-3" />
                    Reset ({excluded.size})
                  </button>
                )}
              </div>
            </div>
            {/* Mobile: equal-width row that fits viewport (no page-wide overflow) */}
            <div className="grid md:hidden grid-cols-5 gap-1 w-full min-w-0">
              {eventSlots.map((ev, idx) => {
                const off = excluded.has(ev.regattaId);
                const canToggle = Boolean(ev.regattaName) && !ev.regattaId.startsWith("slot-");
                return (
                  <button
                    key={ev.regattaId + idx}
                    type="button"
                    disabled={!canToggle}
                    onClick={() => toggleExclude(ev.regattaId)}
                    className={`min-w-0 w-full rounded-lg border px-0.5 py-1.5 text-center transition-all ${
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
                    <p className="text-[7px] sm:text-[8px] font-semibold text-slate-300 leading-tight line-clamp-2 break-words">
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

      {loading && (
        <div className="space-y-3 py-4" role="status" aria-live="polite">
          <div className="h-1.5 w-full max-w-xs overflow-hidden rounded-full bg-white/10">
            <div className="h-full w-2/5 animate-pulse rounded-full bg-gradient-to-r from-orange-600 via-orange-400 to-amber-300" />
          </div>
          <p className="text-sm font-semibold text-slate-500">
            Loading rankings…
          </p>
        </div>
      )}
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

      {/* Mobile cards — constrained to viewport width (aligned with header) */}
      <div className="md:hidden space-y-2.5 no-print w-full max-w-full min-w-0">
        {displayRanked.map((s, i) => {
          const scores = padScores(s, i);
          return (
            <div
              key={s.id}
              className="w-full max-w-full min-w-0 rounded-2xl p-3 border border-white/5 bg-[#131520]/80 space-y-2.5"
            >
              <div className="flex items-start justify-between gap-2 min-w-0">
                <div className="min-w-0 flex-1">
                  <div className="flex items-baseline gap-2 min-w-0">
                    <p className="text-orange-400 font-black text-sm shrink-0 tabular-nums">
                      #{i + 1}
                    </p>
                    <Link
                      href={`/${s.handle}`}
                      prefetch
                      className="font-bold text-white hover:text-orange-400 text-[15px] leading-snug break-words min-w-0"
                    >
                      {s.name}
                    </Link>
                  </div>
                  <p className="text-[11px] text-slate-500 mt-1">
                    {formatGenderLabel(s.gender)} · Born {birthYear(s.dob)}
                    {showSquad ? (
                      <span className="text-slate-500 font-semibold inline-flex flex-wrap items-center gap-x-1.5 gap-y-1 mt-0.5">
                        <span>
                          {squadColumnLabel}:{" "}
                          {squadFor(s) ? (
                            <SquadBadge label={squadFor(s)!} />
                          ) : (
                            "—"
                          )}
                        </span>
                        <span>
                          {nextSquadColumnLabel}:{" "}
                          {nextSquadFor(s) ? (
                            <SquadBadge label={nextSquadFor(s)!} />
                          ) : (
                            "—"
                          )}
                        </span>
                      </span>
                    ) : null}
                  </p>
                </div>
                <div className="text-right shrink-0 pl-1">
                  <p className="text-[9px] text-slate-500 uppercase font-bold tracking-wide">
                    Best 3
                  </p>
                  <p className="font-black text-white text-lg tabular-nums leading-none mt-0.5">
                    {s.overallScore}
                  </p>
                </div>
              </div>
              {/* Equal 5-col score grid — never expands past card width */}
              <div className="grid grid-cols-5 gap-1 w-full min-w-0">
                {scores.map((rs, idx) => {
                  const off = excluded.has(rs.regattaId);
                  return (
                    <div
                      key={rs.regattaId + idx}
                      className={`min-w-0 rounded-lg border px-0.5 py-1.5 text-center ${
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
                      <p className="text-[7px] text-slate-500 leading-tight line-clamp-2 min-h-[1.4rem] break-words">
                        {shortRegattaName(
                          rs.regattaName || eventSlots[idx]?.regattaName,
                          idx
                        )}
                      </p>
                      <p className="text-[11px] font-mono font-bold text-white mt-0.5 tabular-nums">
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

      {/* Desktop table — horizontal scroll isolated inside container */}
      <div className="hidden md:block rounded-2xl border border-white/5 overflow-hidden w-full max-w-full min-w-0">
        <div className="overflow-x-auto max-h-[min(75vh,900px)] overflow-y-auto max-w-full">
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
                {showSquad && (
                  <th
                    className="sticky top-0 z-20 px-4 lg:px-5 py-3 bg-[#12141c] border-b border-white/10 shadow-[0_1px_0_0_rgba(255,255,255,0.06)]"
                    title={`Projected Nat A / Nat B for the next half after ${periodLabelText} (Appendix I: top 8 M/F → age buckets). Live from this Gold ranking — not a locked admin stamp.`}
                  >
                    {nextSquadColumnLabel}
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
                        prefetch
                        className="font-bold text-white hover:text-orange-400"
                      >
                        {s.name}
                      </Link>
                    </td>
                    <td className="px-3 py-3.5 text-center text-slate-300">
                      {formatGenderLabel(s.gender)}
                    </td>
                    <td className="px-3 py-3.5 text-center font-mono text-slate-300">
                      {birthYear(s.dob)}
                    </td>
                    {showSquad && (
                      <td className="px-4 lg:px-5 py-3.5">
                        {squadFor(s) ? (
                          <SquadBadge label={squadFor(s)!} />
                        ) : (
                          <span className="text-slate-600">—</span>
                        )}
                      </td>
                    )}
                    {showSquad && (
                      <td className="px-4 lg:px-5 py-3.5">
                        {nextSquadFor(s) ? (
                          <SquadBadge label={nextSquadFor(s)!} />
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
          commitment. {squadColumnLabel} = official national squad for the selected
          period. {nextSquadColumnLabel} = live projection for the following half
          using Nat A (top 8 male + top 8 female) then Nat B age buckets (13 / 12 /
          ≤11), max 16 each, age ≤15 in intake year.
        </p>
      </div>
    </div>
  );
}
