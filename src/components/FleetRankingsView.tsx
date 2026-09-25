"use client";

import { useEffect, useMemo, useRef, useState } from "react";
import Link from "next/link";
import type { RankedSailor, Period } from "@/lib/ranking";
import { reRankWithExcluded, sharedOverallRanks } from "@/lib/ranking";
import {
  currentPeriodFromSgToday,
  rankingPeriodOptions,
} from "@/lib/datesSg";
import {
  projectedNextSquadLabel,
  withProjectedNextSquadStatus,
} from "@/lib/optimistSquadPreview";
import { Trophy, Calendar, RotateCcw, Lock } from "lucide-react";
import { trackClientUsage } from "@/lib/clientUsage";
import { formatGenderLabel, normalizeGender } from "@/lib/gender";
import { bestThreeSelectedIndexes } from "@/lib/bestThreeSelection";
import { useAccount } from "@/components/AccountProvider";
import { RankMedalBadge } from "@/components/ui/RankMedalBadge";

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
  if (s === "drop" || s === "dropped") {
    return "bg-slate-200/80 border-slate-300 text-slate-600";
  }
  if (s === "ds" || s.includes("development")) {
    return "bg-violet-500/15 border-violet-400/35 text-violet-300";
  }
  return "bg-orange-500/10 border-orange-500/20 text-[var(--sp-racing-deep)]";
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

/** Short recognizable badge for Singapore regattas on mobile screens */
export function mobileRegattaBadge(name: string | undefined | null, idx: number): string {
  if (!name || !String(name).trim()) return `R${idx + 1}`;
  const n = String(name).trim();
  const lower = n.toLowerCase();

  if (lower.includes("changi") || lower.includes("csc")) return "CSC";
  if (lower.includes("saf yacht club") || lower.includes("safyc")) return "SAFYC";
  if (lower.includes("pesta")) return "Pesta";
  if (lower.includes("national sailing championship") || lower.includes("snsc")) return "SNSC";
  if (lower.includes("singapore youth") || lower.includes("sysc")) return "SYSC";
  if (lower.includes("raffles marina") || lower.includes("rmyc") || lower.includes("rm")) return "RM";
  if (lower.includes("asian") || lower.includes("asians")) return "Asians";
  if (lower.includes("worlds") || lower.includes("world")) return "Worlds";
  if (lower.includes("sea games")) return "SEA";
  if (lower.includes("national youth")) return "NYSC";

  const firstWord = n.split(/\s+/)[0];
  if (firstWord && firstWord.length <= 7) return firstWord;
  return n.slice(0, 6);
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
  const ssrPeriod = initialPeriod || currentPeriodFromSgToday();
  const { email, ready: accountReady } = useAccount();
  const isLoggedIn = Boolean(email);
  const PERIODS = useMemo(() => rankingPeriodOptions(6), []);
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
  /** Live next-half Nat A/B projection is signed-in only. */
  const showProjectedSquad = showSquad && isLoggedIn;

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
    if (!showProjectedSquad || rankingBase.length === 0) return rankingBase;
    // The server already projected Nat A/B and Drop. Re-project only for a
    // what-if, and keep Drop so a sailor who cannot reach 2 starts does not
    // take a squad place.
    if (excluded.size === 0) return rankingBase;
    const dropIds = new Set(
      rankingBase
        .filter((sailor) => sailor.nextPeriodSquadStatus === "Drop")
        .map((sailor) => sailor.id)
    );
    const projected = withProjectedNextSquadStatus(
      rankingBase.filter((sailor) => !dropIds.has(sailor.id)),
      period
    );
    const statusById = new Map(
      projected.map((sailor) => [sailor.id, sailor.nextPeriodSquadStatus])
    );
    return rankingBase.map((sailor) => ({
      ...sailor,
      nextPeriodSquadStatus: dropIds.has(sailor.id)
        ? "Drop"
        : (statusById.get(sailor.id) ?? null),
    }));
  }, [showProjectedSquad, rankingBase, period, excluded.size]);

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

  const displayRanks = useMemo(
    () => sharedOverallRanks(displayRanked),
    [displayRanked]
  );

  const carryCount = eventSlots.filter((s) => s.isCarryForward && s.regattaName).length;
  const currentCount = eventSlots.filter((s) => !s.isCarryForward && s.regattaName).length;
  const latestResultDate = useMemo(() => {
    const dates = ranked
      .flatMap((s) => s.regattaScores || [])
      .map((score) => String(score.regattaDate || ""))
      .filter((date) => /^\d{4}-\d{2}-\d{2}$/.test(date))
      .sort();
    return dates.at(-1) || null;
  }, [ranked]);

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

  const isCurrent = Boolean(
    PERIODS.find(
      (p) =>
        p.isCurrent &&
        p.period.year === period.year &&
        p.period.half === period.half
    )
  );
  const periodLabelText =
    PERIODS.find(
      (p) => p.period.year === period.year && p.period.half === period.half
    )?.label || `${period.half} ${period.year}`;

  const squadFor = (s: RankedSailor) =>
    s.periodSquadStatus || s.nationalSquadStatus || null;

  return (
    <div className="print-rankings mx-auto w-full max-w-7xl min-w-0 px-3 sm:px-6 lg:px-8 pt-4 pb-8 sm:pt-6 sm:pb-10 space-y-4 sm:space-y-6 overflow-x-clip">
      {fleet === "Gold" && accountReady && !isLoggedIn && (
        <div className="rounded-xl border border-orange-500/25 bg-orange-500/[0.07] px-3.5 py-3 sm:px-4 sm:py-3.5 flex flex-col md:flex-row md:items-center justify-between gap-3 no-print">
          <div className="flex items-start gap-2.5 min-w-0 flex-1">
            <span className="mt-0.5 flex h-8 w-8 shrink-0 items-center justify-center rounded-lg bg-orange-500/15 text-[var(--sp-racing-deep)] border border-orange-500/20">
              <Lock className="h-3.5 w-3.5" />
            </span>
            <div className="min-w-0">
              <div className="flex flex-wrap items-center gap-2">
                <p className="text-sm font-bold text-white leading-snug">
                  Projected National Squad &amp; 2026 Selection Trials
                </p>
                <span className="inline-flex items-center gap-1 text-[10px] font-bold text-[var(--sp-racing-deep)] bg-orange-500/15 px-1.5 py-0.5 rounded-full border border-orange-500/25">
                  Sign in required
                </span>
              </div>
              <p className="text-[12px] text-slate-400 mt-0.5 leading-snug">
                Signed-in accounts can access projected Nat A / Nat B squad status and the 2026 Asian &amp; Perth Selection Trials leaderboard.
              </p>
            </div>
          </div>
          <div className="flex flex-wrap items-center gap-2 sm:shrink-0 pl-10 md:pl-0">
            <Link
              href="/sg/optimist/selection"
              prefetch
              className="inline-flex items-center gap-1 rounded-full bg-orange-500/15 border border-orange-500/30 px-3 py-1.5 text-xs font-bold text-[var(--sp-racing-deep)] hover:bg-orange-500/25 transition-colors"
            >
              <Trophy className="h-3 w-3 text-[var(--sp-racing-deep)]" />
              <span>Selection Trials</span>
              <span>→</span>
            </Link>
            <Link
              href="/register?next=%2Fsg%2Foptimist%2Fgold"
              className="inline-flex rounded-full bg-orange-600 px-3.5 py-1.5 text-xs font-bold text-white hover:bg-orange-500 shadow-sm"
            >
              Create account
            </Link>
            <Link
              href="/login?next=%2Fsg%2Foptimist%2Fgold"
              className="text-xs font-semibold text-slate-400 hover:text-white px-1.5 py-1"
            >
              Log in
            </Link>
          </div>
        </div>
      )}

      <div className="flex flex-col lg:flex-row lg:items-end justify-between gap-3 sm:gap-4 no-print min-w-0">
        <div className="flex items-start gap-2.5 sm:gap-3 min-w-0">
          <span className="flex h-9 w-9 sm:h-10 sm:w-10 shrink-0 items-center justify-center rounded-xl bg-orange-600/10 text-[var(--sp-racing-deep)] border border-orange-500/20">
            <Trophy className="h-4 w-4 sm:h-5 sm:w-5" />
          </span>
          <div className="min-w-0 flex-1">
            <p className="text-[10px] sm:text-xs font-bold text-[var(--sp-racing-deep)] uppercase tracking-wide">
              SG Optimist
            </p>
            <h1 className="text-xl sm:text-3xl lg:text-4xl font-black text-white tracking-tight break-words">
              {fleet} Fleet Rankings
            </h1>
            <p className="text-[11px] sm:text-sm text-slate-500 mt-1 leading-snug">
              Best 3 of 5 · highlighted scores are selected · * DNS · † overseas
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
            {fleet === "Gold" && isLoggedIn && (
              <div className="mt-2.5">
                <Link
                  href="/sg/optimist/selection"
                  prefetch
                  className="inline-flex items-center gap-1.5 rounded-full border border-orange-500/30 bg-orange-500/10 px-3 py-1 text-[11px] font-bold text-[var(--sp-racing-deep)] hover:bg-orange-500/20 transition-colors"
                >
                  <Trophy className="h-3 w-3 text-[var(--sp-racing-deep)]" />
                  <span>2026 Selection Trials (Asian &amp; Perth)</span>
                  <span>→</span>
                </Link>
              </div>
            )}
          </div>
        </div>
        <div className="flex flex-col sm:flex-row flex-wrap items-stretch sm:items-center gap-2 w-full lg:w-auto min-w-0">
          <div className="flex items-center gap-2 min-w-0 w-full sm:w-auto">
            <Calendar className="h-4 w-4 text-[var(--sp-racing-deep)] shrink-0" />
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
              className="flex-1 sm:flex-none min-w-0 w-full sm:w-auto max-w-full rounded-xl bg-warm-white border border-cool-veil px-3 sm:px-4 py-2.5 text-sm text-charcoal font-semibold"
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
              className="min-w-0 w-full rounded-xl bg-warm-white border border-cool-veil px-2.5 sm:px-3 py-2.5 text-xs sm:text-sm text-charcoal font-semibold"
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
                className="min-w-0 w-full rounded-xl bg-warm-white border border-cool-veil px-2.5 sm:px-3 py-2.5 text-xs sm:text-sm text-charcoal font-semibold"
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

      {!loading && ranked.length > 0 && (
        <p className="text-[11px] font-medium text-slate-500">
          {latestResultDate ? `Results through ${latestResultDate} · ` : ""}
          Source: published regatta results reviewed before import
        </p>
      )}

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

      {/* Scoring events legend + exclude toggles */}
      {!loading && ranked.length > 0 && (
        <div className="w-full max-w-full min-w-0 no-print">
          <div className="rounded-xl border border-cool-veil bg-warm-white shadow-sm px-2.5 sm:px-4 py-2 sm:py-3 space-y-2 min-w-0">
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
                <p className="text-[10px] text-slate-500 font-semibold hidden md:block">
                  Uncheck a regatta to exclude it from Best 3 of 5
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
            {/* Mobile: Always-visible 5-regatta event strip with clear badges and what-if toggle */}
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
                  const canToggle =
                    Boolean(ev.regattaName) &&
                    !ev.regattaId.startsWith("slot-");
                  const badge = mobileRegattaBadge(ev.regattaName, idx);
                  return (
                    <button
                      key={ev.regattaId + idx}
                      type="button"
                      disabled={!canToggle}
                      onClick={() => toggleExclude(ev.regattaId)}
                      className={`min-w-0 w-full rounded-lg border px-1 py-1.5 text-center transition-all ${
                        off
                          ? "bg-rose-950/30 border-rose-500/40 text-rose-300 opacity-60 line-through"
                          : ev.isCarryForward
                            ? "bg-sky-500/10 border-sky-500/30 text-sky-200"
                            : "bg-white/[0.04] border-white/10 text-white"
                      } ${canToggle ? "cursor-pointer active:scale-95" : "cursor-default"}`}
                      title={
                        canToggle
                          ? `${off ? "Include" : "Exclude"} ${ev.regattaName}`
                          : undefined
                      }
                    >
                      <div className="flex items-center justify-center gap-1">
                        <span className="text-[9px] font-black text-[var(--sp-racing-deep)]">
                          R{idx + 1}
                        </span>
                        {ev.isCarryForward && (
                          <span className="text-[8px] font-bold text-sky-400">
                            CF
                          </span>
                        )}
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
                            : "bg-sailcloth border-cool-veil"
                    } ${canToggle ? "cursor-pointer hover:border-orange-500/30" : ""}`}
                  >
                    <div className="flex items-start justify-between gap-1">
                      <p className="text-[10px] font-black text-[var(--sp-racing-deep)]">R{idx + 1}</p>
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
                scores. Current standings return when you reset.
              </p>
            )}
          </div>
        </div>
      )}

      {loading && (
        <div
          className="space-y-2 py-2"
          role="status"
          aria-live="polite"
          aria-label="Loading rankings"
        >
          {Array.from({ length: 6 }).map((_, i) => (
            <div
              key={i}
              className="h-12 rounded-xl border border-white/5 bg-white/[0.03] animate-pulse"
              style={{ animationDelay: `${i * 50}ms` }}
            />
          ))}
        </div>
      )}
      {error && (
        <div className="rounded-xl border border-rose-500/30 bg-rose-500/10 p-4 text-xs sm:text-sm text-rose-300 no-print">
          Rankings could not be loaded. Try again in a moment or{" "}
          <Link href="/support" className="underline font-bold">
            contact support
          </Link>
          .
        </div>
      )}
      {!loading && !error && ranked.length === 0 && (
        <p className="text-sm text-slate-500">
          {isCurrent
            ? "No ranked sailors for this period. Import regattas and set fleet entry / current fleet in admin."
            : `No ranked sailors for archive period ${periodLabelText}. Try another half-year or check entry dates.`}
        </p>
      )}

      {/* Mobile cards — compact: rank · name · Best 3 · score strip */}
      <div className="md:hidden space-y-2 no-print w-full max-w-full min-w-0">
        {displayRanked.map((s, i) => {
          const scores = padScores(s, i);
          const excludedIndexes = new Set(
            scores.flatMap((score, index) =>
              excluded.has(score.regattaId) ? [index] : []
            )
          );
          const selectedIndexes = bestThreeSelectedIndexes(
            scores.map((score) => score.score),
            { excludedIndexes }
          );
          return (
            <div
              key={s.id}
              className="w-full max-w-full min-w-0 rounded-xl px-3 py-2.5 border border-cool-veil bg-warm-white"
            >
              <div className="flex items-center justify-between gap-2 min-w-0">
                <div className="min-w-0 flex-1 flex items-center gap-2">
                  <RankMedalBadge
                    rank={displayRanks[i] ?? i + 1}
                    className="w-6 shrink-0"
                    nonPodiumClassName="text-[var(--sp-racing-deep)] font-black text-sm shrink-0 tabular-nums w-6 text-center"
                  />
                  <div className="min-w-0 flex-1">
                    <Link
                      href={`/${s.handle}`}
                      prefetch
                      className="font-bold text-charcoal hover:text-racing-orange text-[14px] leading-snug truncate block"
                    >
                      {s.name}
                    </Link>
                    <p className="text-[10px] text-slate-500 mt-0.5 truncate">
                      {formatGenderLabel(s.gender)}
                      {birthYear(s.dob) != null
                        ? ` · ${birthYear(s.dob)}`
                        : ""}
                      {showSquad && squadFor(s)
                        ? ` · ${squadFor(s)}`
                        : ""}
                      {showProjectedSquad && nextSquadFor(s)
                        ? ` · proj. ${nextSquadFor(s)}`
                        : ""}
                    </p>
                  </div>
                </div>
                <div className="text-right shrink-0">
                  <p className="text-[9px] text-slate-500 uppercase font-bold tracking-wide">
                    Best 3
                  </p>
                  <p className="font-black text-charcoal text-base tabular-nums leading-none mt-0.5">
                    {s.overallScore}
                  </p>
                </div>
              </div>
              <div className="mt-2.5 grid grid-cols-5 gap-1.5 w-full min-w-0">
                {scores.map((rs, idx) => {
                  const off = excluded.has(rs.regattaId);
                  const selected = selectedIndexes.has(idx);
                  const regName = rs.regattaName || eventSlots[idx]?.regattaName;
                  const badge = mobileRegattaBadge(regName, idx);
                  const isCounted = selected && !off && Number.isFinite(rs.score);
                  const isDropped = !selected && !off && Number.isFinite(rs.score);
                  return (
                    <div
                      key={rs.regattaId + idx}
                      data-best-three-selected={selected || undefined}
                      className={`min-w-0 rounded-lg border px-1 py-1.5 flex flex-col justify-between text-center transition-all ${
                        off
                          ? "bg-rose-950/20 border-rose-500/30 opacity-50"
                          : isCounted
                            ? "bg-orange-500/20 border-orange-400/60 ring-1 ring-orange-500/40 shadow-sm"
                            : isDropped
                              ? "bg-white/[0.02] border-white/5 opacity-70"
                              : rs.isCarryForward
                                ? "bg-sky-500/10 border-sky-500/20"
                                : "bg-white/[0.03] border-white/5"
                      }`}
                      title={regName || undefined}
                    >
                      <div className="flex items-center justify-center gap-0.5 text-[8px] leading-tight font-bold truncate">
                        <span className="text-[var(--sp-racing-deep)] font-black">R{idx + 1}</span>
                        <span className="text-slate-500">·</span>
                        <span className="text-slate-300 truncate">{badge}</span>
                        {rs.isCarryForward && (
                          <span className="text-sky-400 font-black" title="Carry-forward">ᶜ</span>
                        )}
                      </div>

                      <div className={`my-0.5 text-[13px] font-mono tabular-nums leading-tight ${
                        off
                          ? "text-rose-400 line-through font-semibold"
                          : isCounted
                            ? "text-white font-black text-[14px]"
                            : isDropped
                              ? "text-slate-400 font-semibold line-through decoration-slate-500/60"
                              : "text-slate-500 font-medium"
                      }`}>
                        {selected && <span className="sr-only">Selected score: </span>}
                        {Number.isFinite(rs.score)
                          ? scoreCell(
                              rs.score,
                              rs.isDNS,
                              rs.isOverseasCommitment
                            )
                          : "—"}
                      </div>

                      <div>
                        {off ? (
                          <span className="inline-block text-[7px] font-bold uppercase tracking-wider text-rose-400/80 leading-none">
                            Excl
                          </span>
                        ) : isCounted ? (
                          <span className="inline-flex items-center justify-center text-[7.5px] font-black uppercase tracking-wider text-orange-200 bg-orange-500/30 border border-orange-400/30 rounded px-1 py-0.5 leading-none w-full">
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
            </div>
          );
        })}
      </div>

      {/* Desktop table — horizontal scroll isolated inside container */}
      <div className="hidden md:block rounded-2xl border border-cool-veil bg-warm-white overflow-hidden w-full max-w-full min-w-0">
        <div className="overflow-x-auto max-w-full">
          <table className="w-full text-left text-sm min-w-[720px] border-collapse">
            <thead className="text-[10px] text-slate-400 uppercase tracking-wider">
              <tr>
                <th className="sticky top-0 left-0 z-30 px-4 lg:px-5 py-3 w-12 bg-aqua-mist border-b border-cool-veil">
                  #
                </th>
                <th className="sticky top-0 left-12 z-30 px-4 lg:px-5 py-3 min-w-[9rem] bg-aqua-mist border-b border-cool-veil">
                  Sailor
                </th>
                <th className="sticky top-0 z-20 px-3 py-3 text-center bg-aqua-mist border-b border-cool-veil">
                  Gender
                </th>
                <th className="sticky top-0 z-20 px-3 py-3 text-center bg-aqua-mist border-b border-cool-veil">
                  Birth year
                </th>
                {showSquad && (
                  <th
                    className="sticky top-0 z-20 px-4 lg:px-5 py-3 bg-aqua-mist border-b border-cool-veil"
                    title={`National squad for ${periodLabelText}`}
                  >
                    {squadColumnLabel}
                  </th>
                )}
                {showProjectedSquad && (
                  <th
                    className="sticky top-0 z-20 px-4 lg:px-5 py-3 bg-aqua-mist border-b border-cool-veil"
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
                          ? "bg-racing-mist"
                          : ev.isCarryForward
                            ? "bg-aqua-mist"
                            : "bg-aqua-mist"
                      }`}
                      title={
                        (ev.regattaName || `R${idx + 1}`) +
                        (ev.isCarryForward ? " (carry-forward)" : "") +
                        (off ? " · excluded" : "")
                      }
                    >
                      <span className="block text-[var(--sp-racing-deep)] font-black normal-case tracking-normal">
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
                <th className="sticky top-0 z-20 px-4 lg:px-5 py-3 text-center bg-aqua-mist border-b border-cool-veil">
                  Best 3 of 5
                </th>
              </tr>
            </thead>
            <tbody>
              {displayRanked.map((s, i) => {
                const scores = padScores(s, i);
                const excludedIndexes = new Set(
                  scores.flatMap((score, index) =>
                    excluded.has(score.regattaId) ? [index] : []
                  )
                );
                const selectedIndexes = bestThreeSelectedIndexes(
                  scores.map((score) => score.score),
                  { excludedIndexes }
                );
                return (
                  <tr
                    key={s.id}
                    className="border-t border-white/5 hover:bg-white/[0.02]"
                  >
                    <td className="sticky left-0 z-10 px-4 lg:px-5 py-3.5 bg-warm-white">
                      <RankMedalBadge
                        rank={displayRanks[i] ?? i + 1}
                        nonPodiumClassName="font-bold text-[var(--sp-racing-deep)] font-mono"
                      />
                    </td>
                    <td className="sticky left-12 z-10 px-4 lg:px-5 py-3.5 bg-warm-white">
                      <Link
                        href={`/${s.handle}`}
                        prefetch
                        className="font-bold text-charcoal hover:text-racing-orange"
                      >
                        {s.name}
                      </Link>
                    </td>
                    <td className="px-3 py-3.5 text-center text-slate-soft">
                      {formatGenderLabel(s.gender)}
                    </td>
                    <td className="px-3 py-3.5 text-center font-mono text-slate-soft">
                      {birthYear(s.dob)}
                    </td>
                    {showSquad && (
                      <td className="px-4 lg:px-5 py-3.5">
                        {squadFor(s) ? (
                          <SquadBadge label={squadFor(s)!} />
                        ) : (
                          <span className="text-slate-soft/50">—</span>
                        )}
                      </td>
                    )}
                    {showProjectedSquad && (
                      <td className="px-4 lg:px-5 py-3.5">
                        {nextSquadFor(s) ? (
                          <SquadBadge label={nextSquadFor(s)!} />
                        ) : (
                          <span className="text-slate-soft/50">—</span>
                        )}
                      </td>
                    )}
                    {scores.map((rs, idx) => {
                      const off = excluded.has(rs.regattaId);
                      const selected = selectedIndexes.has(idx);
                      return (
                        <td
                          key={rs.regattaId + idx}
                          data-best-three-selected={selected || undefined}
                          className={`px-3 py-3.5 text-center font-mono text-xs ${
                            off
                              ? "text-slate-soft/40 line-through"
                              : selected
                                ? "bg-aqua-mist font-bold text-harbour shadow-[inset_0_0_0_1px_rgba(10,85,87,0.2)]"
                                : "font-medium text-slate-soft"
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
                                }${off ? " · excluded" : selected ? " · counts toward Best 3 of 5" : ""}`
                              : undefined
                          }
                        >
                          {selected && <span className="sr-only">Selected score: </span>}
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
                    <td className="px-4 lg:px-5 py-3.5 text-center font-black text-charcoal text-base">
                      {s.overallScore}
                    </td>
                  </tr>
                );
              })}
            </tbody>
          </table>
        </div>
        <p className="px-4 py-2 text-[10px] text-slate-soft border-t border-cool-veil bg-sailcloth">
          R1–R5 = scoring window for this fleet (R1 = oldest, R5 = newest). If the
          current half has fewer than 5 events, the most recent events from the
          previous half fill the window (sky “prev” / carry). Highlighted cells are
          the three selected scores. Best 3 of 5 = sum of the three best (lowest)
          scores. Sailors with the same Best 3 of 5 share that rank. Within a tie,
          order is best regatta rank first (a 1st beats a 2nd), then name. Uncheck events
          above for a what-if score. * = DNS (Group 1: starters+1; Group 2: max sheet place+1). † = SSF overseas
          commitment. {squadColumnLabel} = official national squad for the selected
          period.{showProjectedSquad
            ? ` ${nextSquadColumnLabel} = live projection for the following half using Nat A (top 8 male + top 8 female) then Nat B age buckets (13 / 12 / ≤11), max 16 each, age ≤15 in intake year. Drop = cannot reach 2 Gold ranking starts this half, even if they sail every regatta still to come.`
            : ""}
        </p>
      </div>
    </div>
  );
}
