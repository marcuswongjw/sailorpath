"use client";

import { useCallback, useMemo, useState } from "react";
import Link from "next/link";
import {
  ILCA_POLICY_NOTES,
  type IlcaIntakeKind,
  type IlcaRankedSailor,
} from "@/lib/ilcaRanking";
import { Trophy, Calendar, RefreshCw } from "lucide-react";
import { trackClientUsage } from "@/lib/clientUsage";
import { bestThreeSelectedIndexes } from "@/lib/bestThreeSelection";

type Props = {
  initialRanked: IlcaRankedSailor[];
  initialIntakeKind: IlcaIntakeKind;
  initialIntakeYear: number;
  initialLabel: string;
  initialAsOf: string;
};

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
  initialLabel,
  initialAsOf,
}: Props) {
  const now = new Date();
  const y = now.getFullYear();
  const [intakeKind, setIntakeKind] = useState<IlcaIntakeKind>(initialIntakeKind);
  const [intakeYear, setIntakeYear] = useState(initialIntakeYear);
  const [ranked, setRanked] = useState(initialRanked);
  const [label, setLabel] = useState(initialLabel);
  const [asOf, setAsOf] = useState(initialAsOf);
  const [genderFilter, setGenderFilter] = useState<"all" | "M" | "F">("all");
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState<string | null>(null);

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
      if (data.label) setLabel(data.label);
      if (data.asOf) setAsOf(data.asOf);
    } catch (e) {
      setError(e instanceof Error ? e.message : "Could not load rankings");
    } finally {
      setLoading(false);
    }
  }, []);

  const filtered = useMemo(() => {
    if (genderFilter === "all") return ranked;
    return ranked.filter((r) => r.gender === genderFilter);
  }, [ranked, genderFilter]);

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
    <div className="print-rankings mx-auto w-full max-w-7xl min-w-0 px-3 sm:px-6 lg:px-8 py-6 sm:py-12 space-y-4 sm:space-y-6 overflow-x-clip">
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
              High Ranking Points · Best 3 of last 5 · highlighted scores are
              selected · 1st = fleet size pts · * = DNS (0 pts)
            </p>
          </div>
        </div>
        <div className="flex flex-col sm:flex-row flex-wrap items-stretch sm:items-center gap-2 w-full lg:w-auto min-w-0">
          <div className="flex items-center gap-2 min-w-0 w-full sm:w-auto">
            <Calendar className="h-4 w-4 text-sky-400 shrink-0" />
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
              className="flex-1 sm:flex-none min-w-0 w-full sm:w-auto max-w-full rounded-xl bg-slate-950 border border-white/10 px-3 sm:px-4 py-2.5 text-sm text-white font-semibold"
            >
              {[y - 1, y, y + 1].flatMap((yr) => [
                <option key={`july-${yr}`} value={`july|${yr}`}>
                  July {yr} intake (as of 30 Jun)
                </option>,
                <option key={`jan-${yr}`} value={`january|${yr}`}>
                  January {yr} intake (as of 20 Dec {yr - 1})
                </option>,
              ])}
            </select>
          </div>
          <select
            value={genderFilter}
            onChange={(e) =>
              setGenderFilter(e.target.value as "all" | "M" | "F")
            }
            className="min-w-0 w-full sm:w-auto rounded-xl bg-slate-950 border border-white/10 px-2.5 sm:px-3 py-2.5 text-xs sm:text-sm text-white font-semibold"
            aria-label="Filter by gender"
          >
            <option value="all">All genders</option>
            <option value="M">Male</option>
            <option value="F">Female</option>
          </select>
        </div>
      </div>

      <p className="text-[11px] text-sky-300/90 font-medium inline-flex items-center gap-2">
        {loading && <RefreshCw className="h-3 w-3 animate-spin" />}
        {label} · {displayRanked.length}
        {genderFilter !== "all" ? ` of ${ranked.length}` : ""} ranked · scoring
        window ≤ {asOf}
      </p>
      {!loading && ranked.length > 0 && (
        <p className="text-[11px] font-medium text-slate-500">
          {latestResultDate ? `Results through ${latestResultDate} · ` : ""}
          Source: published regatta results reviewed before import
        </p>
      )}
      {error && (
        <p className="text-[11px] text-rose-300 font-medium">{error}</p>
      )}
      <p className="text-[11px] text-slate-500 leading-relaxed max-w-3xl">
        {ILCA_POLICY_NOTES.highPoints} {ILCA_POLICY_NOTES.nationalList}
      </p>

      {genderFilter !== "all" && (
        <p className="text-[11px] text-amber-200/90 font-semibold no-print">
          Showing {displayRanked.length} of {ranked.length} sailors ·{" "}
          {genderFilter === "M" ? "Male" : "Female"}. Rank # restarts within
          this filter.
        </p>
      )}

      {eventSlots.length > 0 && (
        <div className="rounded-xl border border-white/10 bg-[#0c0d14]/95 px-2.5 sm:px-4 py-2 sm:py-3 space-y-2 min-w-0">
          <p className="text-[10px] font-bold text-slate-500 uppercase tracking-wider">
            Scoring events — R1 oldest · R{eventSlots.length} newest (last{" "}
            {eventSlots.length} ranking regattas)
          </p>
          <div className="grid grid-cols-5 gap-1 sm:gap-2 w-full min-w-0">
            {eventSlots.map((ev, idx) => (
              <div
                key={ev.regattaId}
                className="min-w-0 rounded-lg border border-white/5 bg-white/5 px-1 sm:px-2.5 py-1.5 sm:py-2 text-center"
                title={`${ev.regattaName} · ${ev.date} · fleet ${ev.fleetSize}`}
              >
                <p className="text-[9px] sm:text-[10px] font-black text-sky-400">
                  R{idx + 1}
                </p>
                <p className="text-[7px] sm:text-[11px] font-semibold text-slate-200 leading-tight line-clamp-2 break-words">
                  {shortRegattaName(ev.regattaName, idx)}
                </p>
                <p className="text-[7px] sm:text-[9px] text-slate-500 mt-0.5 tabular-nums">
                  {ev.date.slice(5)} · n={ev.fleetSize}
                </p>
              </div>
            ))}
            {Array.from({ length: Math.max(0, 5 - eventSlots.length) }).map(
              (_, i) => (
                <div
                  key={`empty-${i}`}
                  className="min-w-0 rounded-lg border border-white/5 bg-slate-950/40 px-1 py-1.5 text-center opacity-40"
                >
                  <p className="text-[9px] font-black text-slate-600">
                    R{eventSlots.length + i + 1}
                  </p>
                  <p className="text-[8px] text-slate-600">—</p>
                </div>
              )
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

      <div className="md:hidden space-y-2.5 no-print w-full max-w-full min-w-0">
        {displayRanked.map((s) => {
          const handle = s.handle;
          const selectedIndexes = bestThreeSelectedIndexes(
            eventSlots.map((event) => pointsFor(s, event.regattaId).points),
            { higherIsBetter: true }
          );
          return (
            <div
              key={s.sailorId}
              className="w-full max-w-full min-w-0 rounded-2xl p-3 border border-white/5 bg-[#131520]/80 space-y-2.5"
            >
              <div className="flex items-start justify-between gap-2 min-w-0">
                <div className="min-w-0 flex-1">
                  <div className="flex items-baseline gap-2 min-w-0">
                    <p className="text-sky-400 font-black text-sm shrink-0 tabular-nums">
                      #{s.displayRank}
                    </p>
                    {handle ? (
                      <Link
                        href={`/${handle}`}
                        className="font-bold text-white hover:text-sky-300 text-[15px] leading-snug break-words min-w-0"
                      >
                        {s.name}
                      </Link>
                    ) : (
                      <span className="font-bold text-white text-[15px]">
                        {s.name}
                      </span>
                    )}
                  </div>
                  <p className="text-[11px] text-slate-500 mt-1">
                    {s.gender || "—"} · Born {s.birthYear ?? "—"}
                  </p>
                </div>
                <div className="text-right shrink-0 pl-1">
                  <p className="text-[9px] text-slate-500 uppercase font-bold tracking-wide">
                    Best 3
                  </p>
                  <p className="font-black text-white text-lg tabular-nums leading-none mt-0.5">
                    {s.totalPoints}
                  </p>
                </div>
              </div>
              <div className="grid grid-cols-5 gap-1 w-full min-w-0">
                {Array.from({ length: 5 }).map((_, idx) => {
                  const ev = eventSlots[idx];
                  if (!ev) {
                    return (
                      <div
                        key={`pad-${idx}`}
                        className="min-w-0 rounded-lg border border-white/5 bg-slate-950/30 px-0.5 py-1.5 text-center opacity-40"
                      >
                        <p className="text-[9px] text-slate-600 font-black">
                          R{idx + 1}
                        </p>
                        <p className="text-[11px] text-slate-600">—</p>
                      </div>
                    );
                  }
                  const { points, isDns } = pointsFor(s, ev.regattaId);
                  const selected = selectedIndexes.has(idx);
                  return (
                    <div
                      key={ev.regattaId}
                      data-best-three-selected={selected || undefined}
                      className={`min-w-0 rounded-lg border px-0.5 py-1.5 text-center ${selected ? "border-sky-400/45 bg-sky-500/15 shadow-[inset_0_0_0_1px_rgba(56,189,248,0.12)]" : "border-white/5 bg-white/5"}`}
                      title={`${ev.regattaName}${selected ? " · counts toward Best 3 of 5" : ""}`}
                    >
                      <p className="text-[9px] text-sky-400/90 font-black">
                        R{idx + 1}
                      </p>
                      <p className="text-[7px] text-slate-500 leading-tight line-clamp-2 min-h-[1.4rem] break-words">
                        {shortRegattaName(ev.regattaName, idx)}
                      </p>
                      <p className={`mt-0.5 font-mono text-[11px] tabular-nums ${selected ? "font-black text-sky-200" : "font-semibold text-slate-500"}`}>
                        {selected && <span className="sr-only">Selected score: </span>}
                        {scoreCell(points, isDns)}
                      </p>
                    </div>
                  );
                })}
              </div>
            </div>
          );
        })}
      </div>

      <div className="hidden md:block rounded-2xl border border-white/5 overflow-hidden w-full max-w-full min-w-0">
        <div className="overflow-x-auto max-h-[min(75vh,900px)] overflow-y-auto max-w-full">
          <table className="w-full text-left text-sm min-w-[720px] border-collapse">
            <thead className="text-[10px] text-slate-400 uppercase tracking-wider">
              <tr>
                <th className="sticky top-0 z-20 px-4 lg:px-5 py-3 w-12 bg-[#12141c] border-b border-white/10">
                  #
                </th>
                <th className="sticky top-0 z-20 px-4 lg:px-5 py-3 bg-[#12141c] border-b border-white/10">
                  Sailor
                </th>
                <th className="sticky top-0 z-20 px-3 py-3 text-center bg-[#12141c] border-b border-white/10">
                  Gender
                </th>
                <th className="sticky top-0 z-20 px-3 py-3 text-center bg-[#12141c] border-b border-white/10">
                  Birth year
                </th>
                {Array.from({ length: 5 }).map((_, idx) => {
                  const ev = eventSlots[idx];
                  return (
                    <th
                      key={ev?.regattaId || `r${idx}`}
                      className="sticky top-0 z-20 px-2 py-2 text-center bg-[#12141c] border-b border-white/10 max-w-[7.5rem]"
                      title={
                        ev
                          ? `${ev.regattaName} · ${ev.date} · fleet ${ev.fleetSize}`
                          : `R${idx + 1}`
                      }
                    >
                      <span className="block text-sky-400 font-black normal-case tracking-normal">
                        R{idx + 1}
                      </span>
                      <span className="block text-[9px] font-semibold text-slate-400 normal-case tracking-normal leading-tight mt-0.5 line-clamp-2">
                        {ev ? shortRegattaName(ev.regattaName, idx) : "—"}
                      </span>
                    </th>
                  );
                })}
                <th className="sticky top-0 z-20 px-4 lg:px-5 py-3 text-center bg-[#12141c] border-b border-white/10">
                  Best 3 of 5
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
                  { higherIsBetter: true }
                );
                return (
                  <tr
                    key={s.sailorId}
                    className="border-t border-white/5 hover:bg-white/[0.02]"
                  >
                    <td className="px-4 lg:px-5 py-3.5 font-bold text-sky-400">
                      {s.displayRank}
                    </td>
                    <td className="px-4 lg:px-5 py-3.5">
                      {handle ? (
                        <Link
                          href={`/${handle}`}
                          className="font-bold text-white hover:text-sky-300"
                        >
                          {s.name}
                        </Link>
                      ) : (
                        <span className="font-bold text-white">{s.name}</span>
                      )}
                    </td>
                    <td className="px-3 py-3.5 text-center text-slate-300">
                      {s.gender || "—"}
                    </td>
                    <td className="px-3 py-3.5 text-center font-mono text-slate-300">
                      {s.birthYear ?? "—"}
                    </td>
                    {Array.from({ length: 5 }).map((_, idx) => {
                      const ev = eventSlots[idx];
                      if (!ev) {
                        return (
                          <td
                            key={`empty-${idx}`}
                            className="px-3 py-3.5 text-center text-slate-600"
                          >
                            —
                          </td>
                        );
                      }
                      const { points, isDns } = pointsFor(s, ev.regattaId);
                      const selected = selectedIndexes.has(idx);
                      return (
                        <td
                          key={ev.regattaId}
                          data-best-three-selected={selected || undefined}
                          className={`px-3 py-3.5 text-center font-mono text-xs ${selected ? "bg-sky-500/15 font-black text-sky-200 shadow-[inset_0_0_0_1px_rgba(56,189,248,0.18)]" : "font-medium text-slate-500"}`}
                          title={
                            isDns
                              ? `${ev.regattaName} · DNS${selected ? " · counts toward Best 3 of 5" : ""}`
                              : `${ev.regattaName} · ${points} pts${selected ? " · counts toward Best 3 of 5" : ""}`
                          }
                        >
                          {selected && <span className="sr-only">Selected score: </span>}
                          {scoreCell(points, isDns)}
                        </td>
                      );
                    })}
                    <td className="px-4 lg:px-5 py-3.5 text-center font-black text-white text-base">
                      {s.totalPoints}
                    </td>
                  </tr>
                );
              })}
            </tbody>
          </table>
        </div>
        <p className="px-4 py-2 text-[10px] text-slate-600 border-t border-white/5 bg-[#0c0d14]">
          R1–R5 = last up to 5 ILCA 4 ranking regattas on or before the cutoff
          (R1 oldest). Cell = High Ranking Points (1st = fleet size). Best 3 of
          5 = sum of the three highest point scores. Highlighted cells are the
          three selected scores. * = DNS (0). Higher total is better.
        </p>
      </div>
    </div>
  );
}
