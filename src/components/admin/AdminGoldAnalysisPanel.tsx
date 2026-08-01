"use client";

import { useMemo, useState } from "react";
import {
  filterGoldSailors,
  seriesForSailors,
  type SailorGoldSeries,
} from "@/lib/goldPerformanceAnalysis";
import type { SailorAdmin } from "@/types/sailor";
import type { RegattaAdmin } from "@/types/regatta";
import type { ResultAdmin } from "@/types/result";
import { GitCompareArrows, Users } from "lucide-react";

type Props = {
  sailors: SailorAdmin[];
  regattas: RegattaAdmin[];
  results: ResultAdmin[];
};

const COLORS = [
  "#f97316",
  "#38bdf8",
  "#a78bfa",
  "#34d399",
  "#f472b6",
  "#facc15",
  "#fb7185",
  "#2dd4bf",
];

function genderLabel(g: string | null | undefined) {
  if (g === "F") return "Female";
  if (g === "M") return "Male";
  return g || "—";
}

function fmtScore(n: number | null | undefined) {
  if (n == null || !Number.isFinite(n)) return "—";
  return String(n);
}

/**
 * Admin: compare Optimist Gold sailors by series half after promotion.
 */
export function AdminGoldAnalysisPanel({
  sailors,
  regattas,
  results,
}: Props) {
  const [gender, setGender] = useState<"all" | "F" | "M">("F");
  const [selectedIds, setSelectedIds] = useState<string[]>([]);
  const [search, setSearch] = useState("");

  const goldPool = useMemo(
    () => filterGoldSailors(sailors, { gender }),
    [sailors, gender]
  );

  const filteredPool = useMemo(() => {
    const q = search.trim().toLowerCase();
    if (!q) return goldPool;
    return goldPool.filter(
      (s) =>
        s.name.toLowerCase().includes(q) ||
        String(s.sailNumber || "")
          .toLowerCase()
          .includes(q)
    );
  }, [goldPool, search]);

  const selectedSailors = useMemo(
    () => goldPool.filter((s) => selectedIds.includes(s.id)),
    [goldPool, selectedIds]
  );

  const series = useMemo(
    () => seriesForSailors(selectedSailors, sailors, regattas, results),
    [selectedSailors, sailors, regattas, results]
  );

  /** Chart points: H1 best3, H2 best3, Current best3 */
  const chart = useMemo(() => {
    if (series.length === 0) return null;
    const cols = ["H1", "H2", "Now"] as const;
    const scores = series.flatMap((s) =>
      [s.half1?.best3of5, s.half2?.best3of5, s.currentHalf?.best3of5].filter(
        (n): n is number => n != null && Number.isFinite(n) && n < 9000
      )
    );
    if (!scores.length) return null;

    const w = 640;
    const h = 260;
    const padL = 44;
    const padR = 20;
    const padT = 24;
    const padB = 40;
    let minS = Math.min(...scores);
    let maxS = Math.max(...scores);
    if (maxS - minS < 6) {
      minS = Math.max(0, minS - 3);
      maxS = minS + 6;
    } else {
      minS = Math.max(0, minS - 2);
      maxS = maxS + 2;
    }
    const yFor = (score: number) =>
      padT + ((score - minS) / (maxS - minS)) * (h - padT - padB);
    const xFor = (i: number) =>
      padL + (i / Math.max(cols.length - 1, 1)) * (w - padL - padR);

    const ticks: number[] = [];
    const step = maxS - minS <= 15 ? 2 : 5;
    for (let t = Math.ceil(minS / step) * step; t <= maxS; t += step)
      ticks.push(t);

    const paths = series.map((s, si) => {
      const pts = [
        s.half1?.best3of5,
        s.half2?.best3of5,
        s.currentHalf?.best3of5,
      ].map((v) =>
        v != null && Number.isFinite(v) && v < 9000 ? v : null
      );
      const segments: string[] = [];
      let started = false;
      pts.forEach((v, i) => {
        if (v == null) {
          started = false;
          return;
        }
        const cmd = started ? "L" : "M";
        segments.push(
          `${cmd} ${xFor(i).toFixed(1)} ${yFor(v).toFixed(1)}`
        );
        started = true;
      });
      return {
        s,
        d: segments.join(" "),
        pts,
        color: COLORS[si % COLORS.length]!,
      };
    });

    return { w, h, padL, padR, padT, padB, minS, maxS, xFor, yFor, ticks, paths, cols };
  }, [series]);

  const toggle = (id: string) => {
    setSelectedIds((prev) =>
      prev.includes(id) ? prev.filter((x) => x !== id) : [...prev, id]
    );
  };

  const selectTop = (n: number) => {
    setSelectedIds(filteredPool.slice(0, n).map((s) => s.id));
  };

  return (
    <div className="w-full min-w-0 space-y-6">
      <div className="glass-panel rounded-3xl border border-white/5 p-5 sm:p-6 space-y-4">
        <div className="flex items-start gap-3">
          <div className="flex h-10 w-10 shrink-0 items-center justify-center rounded-xl bg-orange-500/15">
            <GitCompareArrows className="h-5 w-5 text-orange-400" />
          </div>
          <div>
            <h2 className="text-base font-bold text-white">
              Gold fleet performance analysis
            </h2>
            <p className="text-[12px] text-slate-400 mt-1 max-w-3xl leading-relaxed">
              Compare Optimist Gold sailors using{" "}
              <strong className="text-slate-300">series half-years</strong> so
              different promotion dates line up fairly.
            </p>
            <ul className="mt-2 text-[11px] text-slate-500 space-y-0.5 list-disc pl-4">
              <li>
                <strong className="text-slate-400">Immediate form</strong> —
                1st series half of gold entry + 2nd series half (Best 3 of 5)
              </li>
              <li>
                <strong className="text-slate-400">Current form</strong> —
                current series half (Best 3 of 5)
              </li>
              <li>
                <strong className="text-slate-400">Ranking only</strong> —
                non-ranking regattas excluded
              </li>
            </ul>
          </div>
        </div>

        <div className="grid grid-cols-1 sm:grid-cols-3 gap-3">
          <label className="text-xs text-slate-400">
            Gender filter
            <select
              className="mt-1 w-full rounded-lg bg-slate-900 border border-white/10 text-white px-3 py-2 text-xs"
              value={gender}
              onChange={(e) => {
                setGender(e.target.value as "all" | "F" | "M");
                setSelectedIds([]);
              }}
            >
              <option value="all">All gold sailors</option>
              <option value="F">Female</option>
              <option value="M">Male</option>
            </select>
          </label>
          <div className="text-xs text-slate-400 flex flex-col justify-end gap-1.5 sm:col-span-2">
            <span>
              Pool:{" "}
              <strong className="text-white">{goldPool.length}</strong> gold
              sailors
              {gender !== "all" ? ` (${genderLabel(gender)})` : ""} · selected{" "}
              <strong className="text-white">{selectedIds.length}</strong>
            </span>
            <div className="flex flex-wrap gap-1.5">
              <button
                type="button"
                onClick={() => selectTop(5)}
                className="rounded-full bg-white/5 border border-white/10 px-2.5 py-1 text-[10px] font-bold text-slate-300 hover:text-white"
              >
                Select first 5
              </button>
              <button
                type="button"
                onClick={() => setSelectedIds([])}
                className="rounded-full bg-white/5 border border-white/10 px-2.5 py-1 text-[10px] font-bold text-slate-300 hover:text-white"
              >
                Clear
              </button>
            </div>
          </div>
        </div>
      </div>

      <div className="grid grid-cols-1 lg:grid-cols-3 gap-4">
        <div className="glass-panel rounded-2xl border border-white/5 p-4 space-y-3 lg:col-span-1">
          <div className="flex items-center gap-2">
            <Users className="h-4 w-4 text-orange-400" />
            <h3 className="text-xs font-bold text-white uppercase tracking-wider">
              Select sailors
            </h3>
          </div>
          <input
            value={search}
            onChange={(e) => setSearch(e.target.value)}
            placeholder="Search name or sail #"
            className="w-full rounded-lg bg-slate-950 border border-white/10 text-white px-3 py-2 text-xs"
          />
          <ul className="max-h-80 overflow-y-auto space-y-1">
            {filteredPool.length === 0 ? (
              <li className="text-xs text-slate-500 py-4 text-center">
                No gold sailors in this filter.
              </li>
            ) : (
              filteredPool.map((s) => {
                const on = selectedIds.includes(s.id);
                return (
                  <li key={s.id}>
                    <button
                      type="button"
                      onClick={() => toggle(s.id)}
                      className={`w-full text-left rounded-xl px-3 py-2 text-xs border transition-colors ${
                        on
                          ? "bg-orange-500/15 border-orange-500/30 text-white"
                          : "bg-white/[0.02] border-white/5 text-slate-300 hover:border-white/15"
                      }`}
                    >
                      <span className="font-semibold">{s.name}</span>
                      <span className="block text-[10px] text-slate-500 mt-0.5">
                        Gold {String(s.goldEntryDate).slice(0, 10)}
                        {s.sailNumber ? ` · ${s.sailNumber}` : ""}
                        {s.gender ? ` · ${s.gender}` : ""}
                      </span>
                    </button>
                  </li>
                );
              })
            )}
          </ul>
        </div>

        <div className="lg:col-span-2 space-y-4">
          <div className="glass-panel rounded-2xl border border-white/5 p-4 sm:p-5">
            <h3 className="text-xs font-bold text-white uppercase tracking-wider mb-1">
              Best 3 of 5 by series half
            </h3>
            <p className="text-[11px] text-slate-500 mb-4">
              Lower is better. H1 = promotion half, H2 = next half, Now =
              current half.
            </p>
            {series.length === 0 ? (
              <p className="text-sm text-slate-500 py-10 text-center">
                Select gold sailors to compare.
              </p>
            ) : !chart ? (
              <p className="text-sm text-slate-500 py-10 text-center">
                No ranking scores available for the selected sailors in these
                halves.
              </p>
            ) : (
              <>
                <svg
                  viewBox={`0 0 ${chart.w} ${chart.h}`}
                  className="w-full h-auto"
                  role="img"
                  aria-label="Half-year Best 3 of 5 comparison"
                >
                  {chart.ticks.map((t) => (
                    <g key={t}>
                      <line
                        x1={chart.padL}
                        x2={chart.w - chart.padR}
                        y1={chart.yFor(t)}
                        y2={chart.yFor(t)}
                        stroke="rgba(255,255,255,0.06)"
                        strokeDasharray="3 3"
                      />
                      <text
                        x={chart.padL - 6}
                        y={chart.yFor(t) + 3}
                        textAnchor="end"
                        fill="#64748b"
                        fontSize="10"
                      >
                        {t}
                      </text>
                    </g>
                  ))}
                  {chart.cols.map((c, i) => (
                    <text
                      key={c}
                      x={chart.xFor(i)}
                      y={chart.h - 14}
                      textAnchor="middle"
                      fill="#94a3b8"
                      fontSize="11"
                      fontWeight="600"
                    >
                      {c}
                    </text>
                  ))}
                  {chart.paths.map(({ s, d, pts, color }) => (
                    <g key={s.sailorId}>
                      {d ? (
                        <path
                          d={d}
                          fill="none"
                          stroke={color}
                          strokeWidth="2"
                          strokeLinejoin="round"
                          strokeLinecap="round"
                        />
                      ) : null}
                      {pts.map((v, i) =>
                        v == null ? null : (
                          <g key={`${s.sailorId}-${i}`}>
                            <circle
                              cx={chart.xFor(i)}
                              cy={chart.yFor(v)}
                              r={5}
                              fill={color}
                              stroke="#090a0f"
                              strokeWidth="1.5"
                            />
                            <text
                              x={chart.xFor(i)}
                              y={chart.yFor(v) - 10}
                              textAnchor="middle"
                              fill={color}
                              fontSize="10"
                              fontWeight="600"
                            >
                              {v}
                            </text>
                          </g>
                        )
                      )}
                    </g>
                  ))}
                </svg>
                <div className="mt-3 flex flex-wrap gap-3">
                  {chart.paths.map(({ s, color }) => (
                    <span
                      key={s.sailorId}
                      className="inline-flex items-center gap-1.5 text-[11px] text-slate-300"
                    >
                      <span
                        className="h-2 w-2 rounded-full"
                        style={{ background: color }}
                      />
                      {s.name}
                    </span>
                  ))}
                </div>
              </>
            )}
          </div>

          {series.length > 0 && (
            <div className="glass-panel rounded-2xl border border-white/5 overflow-hidden">
              <div className="px-4 py-3 border-b border-white/5">
                <h3 className="text-xs font-bold text-white uppercase tracking-wider">
                  Summary (Best 3 of 5 · lower is better)
                </h3>
              </div>
              <div className="overflow-x-auto">
                <table className="w-full text-left text-xs">
                  <thead>
                    <tr className="text-[10px] uppercase tracking-wide text-slate-500 border-b border-white/5">
                      <th className="px-3 py-2 font-bold">Sailor</th>
                      <th className="px-3 py-2 font-bold">Gold entry</th>
                      <th className="px-3 py-2 font-bold">H1 (promo)</th>
                      <th className="px-3 py-2 font-bold">H2</th>
                      <th className="px-3 py-2 font-bold">Immediate avg</th>
                      <th className="px-3 py-2 font-bold">Current half</th>
                      <th className="px-3 py-2 font-bold">Series # now</th>
                    </tr>
                  </thead>
                  <tbody className="divide-y divide-white/5">
                    {series.map((s: SailorGoldSeries, i) => (
                      <tr key={s.sailorId} className="text-slate-200">
                        <td className="px-3 py-2.5">
                          <span
                            className="inline-block h-2 w-2 rounded-full mr-2"
                            style={{
                              background: COLORS[i % COLORS.length],
                            }}
                          />
                          <span className="font-semibold text-white">
                            {s.name}
                          </span>
                          {s.birthYear != null && (
                            <span className="text-slate-500 ml-1">
                              · b.{s.birthYear}
                            </span>
                          )}
                        </td>
                        <td className="px-3 py-2.5 tabular-nums text-slate-400">
                          {s.goldEntryDate}
                          <span className="block text-[10px] text-slate-600">
                            {s.monthsInGold} mo in gold
                          </span>
                        </td>
                        <td className="px-3 py-2.5 tabular-nums">
                          <span className="font-semibold text-white">
                            {fmtScore(s.half1?.best3of5)}
                          </span>
                          {s.half1?.seriesRank != null && (
                            <span className="block text-[10px] text-slate-500">
                              #{s.half1.seriesRank}
                              {s.half1.fleetSize
                                ? ` / ${s.half1.fleetSize}`
                                : ""}
                            </span>
                          )}
                          <span className="block text-[9px] text-slate-600">
                            {s.half1?.periodLabel}
                          </span>
                        </td>
                        <td className="px-3 py-2.5 tabular-nums">
                          <span className="font-semibold text-white">
                            {fmtScore(s.half2?.best3of5)}
                          </span>
                          {s.half2?.seriesRank != null && (
                            <span className="block text-[10px] text-slate-500">
                              #{s.half2.seriesRank}
                              {s.half2.fleetSize
                                ? ` / ${s.half2.fleetSize}`
                                : ""}
                            </span>
                          )}
                          <span className="block text-[9px] text-slate-600">
                            {s.half2?.periodLabel}
                          </span>
                        </td>
                        <td className="px-3 py-2.5 tabular-nums font-semibold text-emerald-400">
                          {fmtScore(s.immediateBest3Avg)}
                          {s.immediateRankAvg != null && (
                            <span className="block text-[10px] font-normal text-slate-500">
                              avg rank #{s.immediateRankAvg}
                            </span>
                          )}
                        </td>
                        <td className="px-3 py-2.5 tabular-nums font-semibold text-sky-400">
                          {fmtScore(s.currentBest3)}
                          <span className="block text-[9px] font-normal text-slate-600">
                            {s.currentHalf?.periodLabel}
                          </span>
                        </td>
                        <td className="px-3 py-2.5 tabular-nums">
                          {s.currentSeriesRank != null
                            ? `#${s.currentSeriesRank}`
                            : "—"}
                          {s.currentHalf?.fleetSize != null && (
                            <span className="text-slate-500">
                              {" "}
                              / {s.currentHalf.fleetSize}
                            </span>
                          )}
                        </td>
                      </tr>
                    ))}
                  </tbody>
                </table>
              </div>
            </div>
          )}

          {/* Individual ranking regatta results per half */}
          {series.length > 0 && (
            <div className="space-y-3">
              <h3 className="text-xs font-bold text-white uppercase tracking-wider px-1">
                Individual ranking results
              </h3>
              {series.map((s, si) => {
                const halves = [
                  { key: "H1", label: "H1 · promotion half", half: s.half1 },
                  { key: "H2", label: "H2 · second half", half: s.half2 },
                  {
                    key: "Now",
                    label: "Current half",
                    half: s.currentHalf,
                  },
                ] as const;
                return (
                  <div
                    key={s.sailorId}
                    className="glass-panel rounded-2xl border border-white/5 overflow-hidden"
                  >
                    <div className="px-4 py-3 border-b border-white/5 flex items-center gap-2">
                      <span
                        className="h-2.5 w-2.5 rounded-full shrink-0"
                        style={{ background: COLORS[si % COLORS.length] }}
                      />
                      <h4 className="text-sm font-bold text-white">
                        {s.name}
                      </h4>
                      <span className="text-[10px] text-slate-500">
                        Gold {s.goldEntryDate}
                      </span>
                    </div>
                    <div className="grid grid-cols-1 md:grid-cols-3 divide-y md:divide-y-0 md:divide-x divide-white/5">
                      {halves.map(({ key, label, half }) => (
                        <div key={key} className="p-3 sm:p-4 min-w-0">
                          <p className="text-[10px] font-bold uppercase tracking-wide text-slate-500">
                            {label}
                          </p>
                          <p className="text-[11px] text-slate-400 mt-0.5">
                            {half?.periodLabel || "—"}
                            {half?.best3of5 != null && (
                              <span className="text-white font-semibold ml-1">
                                · Best 3 = {half.best3of5}
                              </span>
                            )}
                          </p>
                          {!half?.events?.length ? (
                            <p className="text-[11px] text-slate-600 mt-3">
                              No ranking events in window
                            </p>
                          ) : (
                            <ul className="mt-2 space-y-1.5">
                              {half.events.map((ev, ei) => (
                                <li
                                  key={`${s.sailorId}-${key}-${ev.regattaId}-${ei}`}
                                  className="flex items-start justify-between gap-2 text-[11px] rounded-lg bg-black/25 border border-white/[0.04] px-2 py-1.5"
                                >
                                  <span className="min-w-0">
                                    <span className="text-[9px] font-bold text-orange-400/90">
                                      R{ei + 1}
                                      {ev.isCarryForward ? " CF" : ""}
                                    </span>
                                    <span className="block text-slate-200 font-medium truncate">
                                      {ev.regattaName}
                                    </span>
                                    {ev.periodLabel && (
                                      <span className="block text-[9px] text-slate-600">
                                        {ev.periodLabel}
                                      </span>
                                    )}
                                  </span>
                                  <span className="shrink-0 text-right tabular-nums">
                                    <span
                                      className={`font-bold ${
                                        ev.isDNS && !ev.isOverseasCommitment
                                          ? "text-rose-400"
                                          : "text-white"
                                      }`}
                                    >
                                      {ev.score}
                                      {ev.isOverseasCommitment
                                        ? "†"
                                        : ev.isDNS
                                          ? "*"
                                          : ""}
                                    </span>
                                    <span className="block text-[9px] text-slate-500">
                                      rank
                                    </span>
                                  </span>
                                </li>
                              ))}
                            </ul>
                          )}
                        </div>
                      ))}
                    </div>
                    <p className="px-4 py-2 text-[9px] text-slate-600 border-t border-white/5">
                      * DNS · † overseas commitment · CF = carry-forward from
                      prior half
                    </p>
                  </div>
                );
              })}
            </div>
          )}
        </div>
      </div>

      <p className="text-[10px] text-slate-600 leading-relaxed max-w-3xl">
        Ranking Optimist Gold events only (DNS = fleet size + 1; overseas
        commitment scores included as stored). Non-ranking regattas are never
        used. ILCA 4 analysis can be added later as a separate single-fleet
        board.
      </p>
    </div>
  );
}
