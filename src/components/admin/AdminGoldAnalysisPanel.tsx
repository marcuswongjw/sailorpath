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

/**
 * Admin: compare Optimist Gold sailors on a post-promotion timeline.
 */
export function AdminGoldAnalysisPanel({
  sailors,
  regattas,
  results,
}: Props) {
  const [gender, setGender] = useState<"all" | "F" | "M">("F");
  const [windowN, setWindowN] = useState(3);
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
    () =>
      seriesForSailors(selectedSailors, regattas, results, {
        boatClass: "Optimist",
        window: windowN,
      }),
    [selectedSailors, regattas, results, windowN]
  );

  const maxSeq = useMemo(
    () => Math.max(0, ...series.map((s) => s.postPromo.length)),
    [series]
  );

  const chart = useMemo(() => {
    if (series.length === 0 || maxSeq < 1) return null;
    const w = 720;
    const h = 280;
    const padL = 40;
    const padR = 16;
    const padT = 20;
    const padB = 36;
    const allRanks = series.flatMap((s) => s.postPromo.map((p) => p.rank));
    if (!allRanks.length) return null;
    let minR = Math.max(1, Math.min(...allRanks) - 2);
    let maxR = Math.max(...allRanks) + 2;
    if (maxR - minR < 8) maxR = minR + 8;
    const yFor = (rank: number) =>
      padT + ((rank - minR) / (maxR - minR)) * (h - padT - padB);
    const xFor = (seq: number) =>
      padL + ((seq - 1) / Math.max(maxSeq - 1, 1)) * (w - padL - padR);
    const ticks: number[] = [];
    const step = maxR - minR <= 12 ? 2 : 5;
    for (let r = Math.ceil(minR / step) * step; r <= maxR; r += step)
      ticks.push(r);

    const paths = series.map((s, si) => {
      if (s.postPromo.length < 1) return { s, d: "", color: COLORS[si % COLORS.length]! };
      const d = s.postPromo
        .map((p, i) => {
          const x = xFor(p.seq);
          const y = yFor(p.rank);
          return `${i === 0 ? "M" : "L"} ${x.toFixed(1)} ${y.toFixed(1)}`;
        })
        .join(" ");
      return { s, d, color: COLORS[si % COLORS.length]! };
    });

    return { w, h, padL, padR, padT, padB, minR, maxR, xFor, yFor, ticks, paths, maxSeq };
  }, [series, maxSeq]);

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
              Compare Optimist Gold sailors on a{" "}
              <strong className="text-slate-300">post-promotion timeline</strong>
              : event 1 = first ranking result on/after gold entry, event 2 =
              second, and so on. This lines up sailors who promoted on different
              dates.{" "}
              <span className="text-slate-500">
                Immediate form = avg rank of first {windowN} post-promo events;
                current form = avg of last {windowN}.
              </span>
            </p>
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
          <label className="text-xs text-slate-400">
            Immediate / current window
            <select
              className="mt-1 w-full rounded-lg bg-slate-900 border border-white/10 text-white px-3 py-2 text-xs"
              value={windowN}
              onChange={(e) => setWindowN(Number(e.target.value) || 3)}
            >
              <option value={2}>First / last 2 events</option>
              <option value={3}>First / last 3 events</option>
              <option value={5}>First / last 5 events</option>
            </select>
          </label>
          <div className="text-xs text-slate-400 flex flex-col justify-end gap-1.5">
            <span>
              Pool:{" "}
              <strong className="text-white">{goldPool.length}</strong> gold
              sailors
              {gender !== "all" ? ` (${genderLabel(gender)})` : ""}
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
        {/* Sailor picker */}
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

        {/* Chart + table */}
        <div className="lg:col-span-2 space-y-4">
          <div className="glass-panel rounded-2xl border border-white/5 p-4 sm:p-5">
            <h3 className="text-xs font-bold text-white uppercase tracking-wider mb-1">
              Rank by post-promotion event
            </h3>
            <p className="text-[11px] text-slate-500 mb-4">
              Lower is better. X-axis = 1st, 2nd, 3rd… ranking result after gold
              entry (not calendar date).
            </p>
            {series.length === 0 ? (
              <p className="text-sm text-slate-500 py-10 text-center">
                Select two or more gold sailors to compare.
              </p>
            ) : !chart ? (
              <p className="text-sm text-slate-500 py-10 text-center">
                Selected sailors have no ranking results after gold entry yet.
              </p>
            ) : (
              <>
                <svg
                  viewBox={`0 0 ${chart.w} ${chart.h}`}
                  className="w-full h-auto"
                  role="img"
                  aria-label="Post-promotion rank comparison"
                >
                  {chart.ticks.map((r) => (
                    <g key={r}>
                      <line
                        x1={chart.padL}
                        x2={chart.w - chart.padR}
                        y1={chart.yFor(r)}
                        y2={chart.yFor(r)}
                        stroke="rgba(255,255,255,0.06)"
                        strokeDasharray="3 3"
                      />
                      <text
                        x={chart.padL - 6}
                        y={chart.yFor(r) + 3}
                        textAnchor="end"
                        fill="#64748b"
                        fontSize="10"
                      >
                        {r}
                      </text>
                    </g>
                  ))}
                  {Array.from({ length: chart.maxSeq }, (_, i) => i + 1).map(
                    (seq) => (
                      <text
                        key={seq}
                        x={chart.xFor(seq)}
                        y={chart.h - 12}
                        textAnchor="middle"
                        fill="#64748b"
                        fontSize="10"
                      >
                        E{seq}
                      </text>
                    )
                  )}
                  {chart.paths.map(({ s, d, color }) => (
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
                      {s.postPromo.map((p) => (
                        <circle
                          key={`${s.sailorId}-${p.seq}`}
                          cx={chart.xFor(p.seq)}
                          cy={chart.yFor(p.rank)}
                          r={4}
                          fill={color}
                          stroke="#090a0f"
                          strokeWidth="1.5"
                        >
                          <title>
                            {s.name}: E{p.seq} · {p.regattaName} · #{p.rank}
                          </title>
                        </circle>
                      ))}
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
                  Summary
                </h3>
              </div>
              <div className="overflow-x-auto">
                <table className="w-full text-left text-xs">
                  <thead>
                    <tr className="text-[10px] uppercase tracking-wide text-slate-500 border-b border-white/5">
                      <th className="px-3 py-2 font-bold">Sailor</th>
                      <th className="px-3 py-2 font-bold">Gold entry</th>
                      <th className="px-3 py-2 font-bold">Events</th>
                      <th className="px-3 py-2 font-bold">
                        Immediate (avg first {windowN})
                      </th>
                      <th className="px-3 py-2 font-bold">
                        Current (avg last {windowN})
                      </th>
                      <th className="px-3 py-2 font-bold">Best</th>
                      <th className="px-3 py-2 font-bold">Last</th>
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
                          {s.age != null && (
                            <span className="text-slate-500 ml-1">
                              · {s.age}y
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
                          {s.eventCount}
                        </td>
                        <td className="px-3 py-2.5 tabular-nums font-semibold text-emerald-400">
                          {s.immediateAvgRank ?? "—"}
                        </td>
                        <td className="px-3 py-2.5 tabular-nums font-semibold text-sky-400">
                          {s.currentAvgRank ?? "—"}
                        </td>
                        <td className="px-3 py-2.5 tabular-nums">
                          {s.bestPostRank ?? "—"}
                        </td>
                        <td className="px-3 py-2.5 tabular-nums">
                          {s.lastRank ?? "—"}
                        </td>
                      </tr>
                    ))}
                  </tbody>
                </table>
              </div>
            </div>
          )}
        </div>
      </div>

      <p className="text-[10px] text-slate-600 leading-relaxed max-w-3xl">
        Scope: Optimist ranking regattas only (non-ranking excluded). Pre-gold
        results are ignored so promotion dates can differ. Sailors may also race
        ILCA 4 while in Optimist; this board is Optimist Gold ranking only.
        Optimist eligibility ends when age is over 15 — dual-class ILCA 4 is
        allowed before that.
      </p>
    </div>
  );
}
