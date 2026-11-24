"use client";

import { useMemo, useState } from "react";
import { useMutation, useQuery, useQueryClient } from "@tanstack/react-query";
import {
  ArrowDown,
  ArrowUp,
  ArrowUpDown,
  BookmarkCheck,
  ExternalLink,
  RefreshCw,
  Sparkles,
  TrendingUp,
  Trophy,
  Users,
} from "lucide-react";
import {
  compareSnapshotWithActuals,
  type GoldFormIndexSummary,
  type GoldFormScope,
  type GoldSailorFormEntry,
} from "@/lib/admin/goldFormIndex";
import type { AdminGoldFormResponse } from "@/app/api/admin/gold-form/route";
import { fetchAdminGoldForm, saveAdminGoldFormSnapshot } from "./adminFetch";
import { adminQueryKeys } from "./adminQueryKeys";

type FocusPreset = "best_form" | "up_and_coming" | "all";
type SortColumn =
  | "name"
  | "birthYear"
  | "currentNationalRank"
  | "projectedNationalRankJun2027"
  | "totalStarts"
  | "formIndex"
  | "watchlistIndex"
  | "recentAvgRank"
  | "momentumDelta"
  | "cohortPeerEdge"
  | "projectedPercentile";
type SortDirection = "ascending" | "descending";

type Props = {
  isSuperadmin: boolean;
  onOpenSailor?: (sailorId: string, sailorName?: string) => void;
};

const COLLATOR = new Intl.Collator(undefined, {
  numeric: true,
  sensitivity: "base",
});

function formatSigned(value: number | null, suffix = ""): string {
  if (value == null || !Number.isFinite(value)) return "—";
  const prefix = value > 0 ? "+" : "";
  return `${prefix}${value.toFixed(1)}${suffix}`;
}

function tierBadge(tier: GoldSailorFormEntry["tier"]): {
  label: string;
  className: string;
} {
  switch (tier) {
    case "best_form":
      return {
        label: "Best form",
        className: "bg-teal-50 text-teal-800 border-teal-200",
      };
    case "up_and_coming":
      return {
        label: "Up & coming",
        className: "bg-orange-50 text-orange-800 border-orange-200",
      };
    case "steady_core":
      return {
        label: "Steady Gold",
        className: "bg-slate-100 text-slate-700 border-slate-200",
      };
    case "developing":
      return {
        label: "Developing",
        className: "bg-amber-50 text-amber-800 border-amber-200",
      };
    default:
      return {
        label: "Low sample",
        className: "bg-slate-50 text-slate-500 border-slate-200",
      };
  }
}

function pointColor(entry: GoldSailorFormEntry, isSelected: boolean): string {
  if (isSelected) return "#ea580c";
  if (entry.tier === "up_and_coming") return "#f97316";
  if (entry.tier === "best_form") return "#0d9488";
  if (entry.tier === "steady_core") return "#334155";
  return "#94a3b8";
}

function Sparkline({
  entry,
}: {
  entry: GoldSailorFormEntry;
}) {
  const pts = entry.history.slice(-10);
  if (pts.length < 2) {
    return (
      <span className="text-xs text-slate-400" aria-hidden="true">
        {pts.length === 1 ? `#${pts[0]!.rank}` : "—"}
      </span>
    );
  }
  const w = 92;
  const h = 28;
  const pad = 3;
  const xAt = (i: number) =>
    pad + (i / Math.max(pts.length - 1, 1)) * (w - pad * 2);
  const yAt = (pct: number) =>
    pad + ((100 - Math.max(0, Math.min(100, pct))) / 100) * (h - pad * 2);
  const d = pts
    .map((p, i) => `${i === 0 ? "M" : "L"}${xAt(i).toFixed(1)},${yAt(p.percentile).toFixed(1)}`)
    .join(" ");
  const last = pts[pts.length - 1]!;
  const projX = w - pad;
  const projY = yAt(entry.projectedPercentile);
  const stroke =
    (entry.momentumDelta ?? 0) >= 8
      ? "#ea580c"
      : entry.formIndex >= 72
        ? "#0d9488"
        : "#475569";

  return (
    <svg
      width={w}
      height={h}
      viewBox={`0 0 ${w} ${h}`}
      aria-hidden="true"
      className="block shrink-0"
    >
      <path d={d} fill="none" stroke={stroke} strokeWidth={1.75} strokeLinecap="round" />
      <line
        x1={xAt(pts.length - 1)}
        y1={yAt(last.percentile)}
        x2={projX}
        y2={projY}
        stroke={stroke}
        strokeWidth={1.25}
        strokeDasharray="2 2"
      />
      <circle cx={xAt(pts.length - 1)} cy={yAt(last.percentile)} r={2.2} fill={stroke} />
    </svg>
  );
}

function QuadrantChart({
  entries,
  selectedId,
  hoveredId,
  onHover,
  onSelect,
}: {
  entries: GoldSailorFormEntry[];
  selectedId: string | null;
  hoveredId: string | null;
  onHover: (id: string | null) => void;
  onSelect: (id: string) => void;
}) {
  const w = 640;
  const h = 330;
  const padL = 48;
  const padR = 24;
  const padT = 26;
  const padB = 42;
  const plotW = w - padL - padR;
  const plotH = h - padT - padB;
  const xFor = (form: number) => padL + (Math.max(0, Math.min(100, form)) / 100) * plotW;
  const yFor = (watch: number) =>
    padT + ((100 - Math.max(0, Math.min(100, watch))) / 100) * plotH;

  const formThreshold = 68;
  const watchThreshold = 52;
  const activePts = entries.filter((e) => e.totalStarts > 0);
  const spotlightIds = new Set([
    ...entries.slice(0, 3).map((e) => e.sailorId),
    ...[...entries]
      .filter((e) => e.confidence !== "low")
      .sort((a, b) => b.watchlistIndex - a.watchlistIndex)
      .slice(0, 4)
      .map((e) => e.sailorId),
  ]);
  const inspectEntry =
    activePts.find((e) => e.sailorId === hoveredId) ??
    activePts.find((e) => e.sailorId === selectedId) ??
    null;

  return (
    <figure className="rounded-xl border border-slate-200 bg-white p-4">
      <div className="mb-3 flex flex-wrap items-start justify-between gap-2">
        <div>
          <h3 className="text-sm font-bold text-slate-900">
            Form vs. Up-and-Coming Quadrant
          </h3>
          <p className="text-xs text-slate-600">
            Click any point or table row to inspect chronological trajectory.
          </p>
        </div>
        <div className="flex flex-wrap items-center gap-3 text-[11px] font-semibold text-slate-600">
          <span className="inline-flex items-center gap-1.5">
            <span className="h-2.5 w-2.5 rounded-full bg-teal-600" aria-hidden="true" />
            Best form
          </span>
          <span className="inline-flex items-center gap-1.5">
            <span className="h-2.5 w-2.5 rounded-full bg-orange-500" aria-hidden="true" />
            Up &amp; coming
          </span>
          <span className="inline-flex items-center gap-1.5">
            <span className="h-2.5 w-2.5 rounded-full bg-slate-700" aria-hidden="true" />
            Steady
          </span>
        </div>
      </div>

      <svg
        viewBox={`0 0 ${w} ${h}`}
        role="img"
        aria-label="Scatter chart plotting Form Index horizontally against Up-and-Coming Watchlist Index vertically for current Optimist Gold sailors"
        className="w-full h-auto"
      >
        <title>
          Optimist Gold Form Index vs. Watchlist Index quadrant scatter plot
        </title>
        <rect
          x={xFor(formThreshold)}
          y={padT}
          width={xFor(100) - xFor(formThreshold)}
          height={yFor(watchThreshold) - padT}
          fill="#f0fdfa"
        />
        <rect
          x={padL}
          y={padT}
          width={xFor(formThreshold) - padL}
          height={yFor(watchThreshold) - padT}
          fill="#fff7ed"
        />

        {[20, 40, 60, 80].map((tick) => (
          <g key={tick}>
            <line
              x1={xFor(tick)}
              y1={padT}
              x2={xFor(tick)}
              y2={h - padB}
              stroke="#e2e8f0"
              strokeWidth={1}
            />
            <line
              x1={padL}
              y1={yFor(tick)}
              x2={w - padR}
              y2={yFor(tick)}
              stroke="#e2e8f0"
              strokeWidth={1}
            />
            <text
              x={xFor(tick)}
              y={h - padB + 16}
              textAnchor="middle"
              className="fill-slate-500 text-[10px]"
            >
              {tick}
            </text>
            <text
              x={padL - 8}
              y={yFor(tick) + 3}
              textAnchor="end"
              className="fill-slate-500 text-[10px]"
            >
              {tick}
            </text>
          </g>
        ))}

        <line
          x1={xFor(formThreshold)}
          y1={padT}
          x2={xFor(formThreshold)}
          y2={h - padB}
          stroke="#94a3b8"
          strokeDasharray="4 4"
        />
        <line
          x1={padL}
          y1={yFor(watchThreshold)}
          x2={w - padR}
          y2={yFor(watchThreshold)}
          stroke="#94a3b8"
          strokeDasharray="4 4"
        />

        <text x={padL + 6} y={padT + 14} className="fill-orange-800 text-[10px] font-bold">
          Rising watchlist
        </text>
        <text x={w - padR - 6} y={padT + 14} textAnchor="end" className="fill-teal-800 text-[10px] font-bold">
          Peak &amp; rising contenders
        </text>
        <text x={w - padR - 6} y={h - padB - 8} textAnchor="end" className="fill-slate-600 text-[10px] font-semibold">
          Established form leaders
        </text>
        <text x={padL + 6} y={h - padB - 8} className="fill-slate-500 text-[10px]">
          Developing / low sample
        </text>

        <rect
          x={padL}
          y={padT}
          width={plotW}
          height={plotH}
          fill="none"
          stroke="#cbd5e1"
        />

        <text
          x={padL + plotW / 2}
          y={h - 6}
          textAnchor="middle"
          className="fill-slate-700 text-[11px] font-semibold"
        >
          Current Form Index (0–100) →
        </text>
        <text
          x={14}
          y={padT + plotH / 2}
          textAnchor="middle"
          transform={`rotate(-90 14 ${padT + plotH / 2})`}
          className="fill-slate-700 text-[11px] font-semibold"
        >
          Up &amp; Coming Watchlist →
        </text>

        {activePts.map((entry) => {
          const isSel = entry.sailorId === selectedId;
          const isHover = entry.sailorId === hoveredId;
          const cx = xFor(entry.formIndex);
          const cy = yFor(entry.watchlistIndex);
          const showLabel = isSel || isHover || spotlightIds.has(entry.sailorId);
          const shortName = entry.name.split(" ").slice(0, 2).join(" ");
          return (
            <g
              key={entry.sailorId}
              className="cursor-pointer"
              onMouseEnter={() => onHover(entry.sailorId)}
              onMouseLeave={() => onHover(null)}
              onClick={() => onSelect(entry.sailorId)}
            >
              <circle
                cx={cx}
                cy={cy}
                r={isSel ? 7 : isHover ? 6 : entry.confidence === "low" ? 3.5 : 4.75}
                fill={pointColor(entry, isSel)}
                fillOpacity={isSel || isHover ? 0.95 : entry.confidence === "low" ? 0.45 : 0.8}
                stroke={isSel ? "#0f172a" : "#ffffff"}
                strokeWidth={isSel ? 2 : 1.2}
              >
                <title>
                  {`${entry.name} (${entry.birthYear ?? "?"}) — Form ${entry.formIndex}, Watchlist ${entry.watchlistIndex}, Proj ~#${entry.projectedRank ?? "—"}`}
                </title>
              </circle>
              {showLabel ? (
                <text
                  x={cx > w - 120 ? cx - 9 : cx + 8}
                  y={cy < padT + 22 ? cy + 12 : cy - 5}
                  textAnchor={cx > w - 120 ? "end" : "start"}
                  className={
                    isSel
                      ? "fill-slate-950 text-[10.5px] font-bold"
                      : "fill-slate-700 text-[9.5px] font-semibold"
                  }
                >
                  {shortName}
                </text>
              ) : null}
            </g>
          );
        })}
      </svg>

      <figcaption className="mt-2 flex flex-wrap items-center justify-between gap-2 border-t border-slate-100 pt-2 text-xs text-slate-600">
        {inspectEntry ? (
          <span>
            <strong className="text-slate-900">{inspectEntry.name}</strong>{" "}
            ({inspectEntry.birthYear ?? "—"}) · Form{" "}
            <strong className="tabular-nums text-slate-900">{inspectEntry.formIndex}</strong> ·
            Watchlist{" "}
            <strong className="tabular-nums text-slate-900">{inspectEntry.watchlistIndex}</strong> ·
            Momentum{" "}
            <strong className="tabular-nums text-slate-900">
              {formatSigned(inspectEntry.momentumDelta, " pts")}
            </strong>
          </span>
        ) : (
          <span>No Gold starts match current filters.</span>
        )}
        <span className="tabular-nums text-slate-500">{activePts.length} sailors plotted</span>
      </figcaption>
    </figure>
  );
}

function SailorTrajectoryChart({
  entry,
  summary,
  onOpenSailor,
}: {
  entry: GoldSailorFormEntry | null;
  summary: GoldFormIndexSummary;
  onOpenSailor?: (sailorId: string, sailorName?: string) => void;
}) {
  if (!entry) {
    return (
      <div className="rounded-xl border border-slate-200 bg-white p-4 text-sm text-slate-600">
        Select a sailor from the chart or table to inspect their Gold progression and +6m projection.
      </div>
    );
  }

  const pts = entry.history.slice(-16);
  const cohortAvg =
    entry.birthYear != null
      ? summary.cohortAverages.find((c) => c.birthYear === entry.birthYear)
          ?.avgWeightedPercentile ?? null
      : null;

  const w = 540;
  const h = 230;
  const padL = 42;
  const padR = 54;
  const padT = 22;
  const padB = 34;
  const plotW = w - padL - padR;
  const plotH = h - padT - padB;
  const totalSlots = Math.max(pts.length, 1);
  const xAt = (i: number) => padL + (i / totalSlots) * plotW;
  const yAt = (pct: number) =>
    padT + ((100 - Math.max(0, Math.min(100, pct))) / 100) * plotH;
  const projX = padL + plotW;
  const projY = yAt(entry.projectedPercentile);

  const linePath = pts
    .map((p, i) => `${i === 0 ? "M" : "L"} ${xAt(i).toFixed(1)} ${yAt(p.percentile).toFixed(1)}`)
    .join(" ");

  const badge = tierBadge(entry.tier);

  return (
    <div className="rounded-xl border border-slate-200 bg-white p-4 flex flex-col gap-3">
      <div className="flex flex-wrap items-start justify-between gap-2">
        <div>
          <div className="flex flex-wrap items-center gap-2">
            <h3 className="text-base font-bold text-slate-900">{entry.name}</h3>
            <span
              className={`rounded-full border px-2 py-0.5 text-[11px] font-semibold ${badge.className}`}
            >
              {badge.label}
            </span>
            {entry.nationalSquadStatus ? (
              <span className="rounded-full bg-slate-100 px-2 py-0.5 text-[11px] font-semibold text-slate-700">
                {entry.nationalSquadStatus}
              </span>
            ) : null}
          </div>
          <p className="mt-0.5 text-xs text-slate-600 tabular-nums">
            {entry.sailNumber || "No sail #"} · Born {entry.birthYear ?? "—"} · Gold since{" "}
            {entry.goldEntryDate || "—"} ({entry.monthsInGold}m)
          </p>
        </div>
        {onOpenSailor ? (
          <button
            type="button"
            onClick={() => onOpenSailor(entry.sailorId, entry.name)}
            className="inline-flex min-h-9 items-center gap-1 rounded-lg border border-slate-300 bg-white px-2.5 text-xs font-semibold text-slate-800 hover:bg-slate-50 focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-orange-600"
          >
            Sailor record
            <ExternalLink className="h-3.5 w-3.5" aria-hidden="true" />
          </button>
        ) : null}
      </div>

      <div className="grid grid-cols-2 sm:grid-cols-3 gap-2 text-xs">
        <div className="rounded-lg bg-slate-50 px-2.5 py-2">
          <span className="text-slate-500">Current Nat Rank</span>
          <p className="font-bold text-slate-900 tabular-nums text-sm">
            {entry.currentNationalRank != null ? `#${entry.currentNationalRank}` : "—"}{" "}
            {entry.currentBest3of5 != null ? (
              <span className="font-normal text-slate-500">(B3: {entry.currentBest3of5})</span>
            ) : null}
          </p>
        </div>
        <div className="rounded-lg bg-slate-50 px-2.5 py-2">
          <span className="text-slate-500">Proj 30 Jun 27</span>
          <p className="font-bold text-slate-900 tabular-nums text-sm">
            {entry.agingOut2027
              ? "Ages out (2011)"
              : entry.projectedNationalRankJun2027 != null
                ? `#${entry.projectedNationalRankJun2027}`
                : "—"}{" "}
            {!entry.agingOut2027 && entry.projectedNationalRankDelta != null && entry.projectedNationalRankDelta !== 0 ? (
              <span
                className={
                  entry.projectedNationalRankDelta > 0
                    ? "text-teal-700 font-semibold"
                    : "text-rose-700 font-semibold"
                }
              >
                ({entry.projectedNationalRankDelta > 0 ? `+${entry.projectedNationalRankDelta}` : entry.projectedNationalRankDelta})
              </span>
            ) : null}
          </p>
        </div>
        <div className="rounded-lg bg-slate-50 px-2.5 py-2">
          <span className="text-slate-500">Form / Watchlist</span>
          <p className="font-bold text-slate-900 tabular-nums text-sm">
            {entry.formIndex} / <span className="text-orange-700">{entry.watchlistIndex}</span>
          </p>
        </div>
        <div className="rounded-lg bg-slate-50 px-2.5 py-2">
          <span className="text-slate-500">Momentum Δ</span>
          <p className="font-bold text-slate-900 tabular-nums text-sm">
            {formatSigned(entry.momentumDelta, " pts")}
          </p>
        </div>
        <div className="rounded-lg bg-slate-50 px-2.5 py-2">
          <span className="text-slate-500">Event Projection</span>
          <p className="font-bold text-slate-900 tabular-nums text-sm">
            {entry.projectedRank != null ? `~#${entry.projectedRank}` : "—"}{" "}
            <span className="font-normal text-slate-500">({entry.projectedPercentile}%)</span>
          </p>
        </div>
        <div className="rounded-lg bg-slate-50 px-2.5 py-2">
          <span className="text-slate-500">Vs Cohort</span>
          <p className="font-bold text-slate-900 tabular-nums text-sm">
            {formatSigned(entry.cohortPeerEdge, " pts")}
          </p>
        </div>
      </div>

      {pts.length > 0 ? (
        <figure>
          <svg
            viewBox={`0 0 ${w} ${h}`}
            role="img"
            aria-label={`Historical Gold finish percentile progression for ${entry.name} across ${pts.length} starts, projecting to ${entry.projectedPercentile} percentile`}
            className="w-full h-auto"
          >
            <title>{`${entry.name} Gold percentile progression and 6-month projection`}</title>
            {[25, 50, 75, 100].map((tick) => (
              <g key={tick}>
                <line
                  x1={padL}
                  y1={yAt(tick)}
                  x2={w - padR}
                  y2={yAt(tick)}
                  stroke="#e2e8f0"
                />
                <text
                  x={padL - 8}
                  y={yAt(tick) + 3}
                  textAnchor="end"
                  className="fill-slate-500 text-[10px]"
                >
                  {tick}%
                </text>
              </g>
            ))}

            {cohortAvg != null ? (
              <g>
                <line
                  x1={padL}
                  y1={yAt(cohortAvg)}
                  x2={w - padR}
                  y2={yAt(cohortAvg)}
                  stroke="#0284c7"
                  strokeDasharray="4 4"
                />
                <text
                  x={w - padR + 4}
                  y={yAt(cohortAvg) + 3}
                  className="fill-sky-700 text-[9px] font-semibold"
                >
                  {entry.birthYear} avg
                </text>
              </g>
            ) : null}

            <path
              d={linePath}
              fill="none"
              stroke="#0d9488"
              strokeWidth={2.2}
              strokeLinecap="round"
            />
            {pts.length > 0 ? (
              <line
                x1={xAt(pts.length - 1)}
                y1={yAt(pts[pts.length - 1]!.percentile)}
                x2={projX}
                y2={projY}
                stroke="#ea580c"
                strokeWidth={2}
                strokeDasharray="4 3"
              />
            ) : null}

            {pts.map((p, i) => (
              <g key={`${p.regattaId}-${i}`}>
                <circle
                  cx={xAt(i)}
                  cy={yAt(p.percentile)}
                  r={p.isRecentWindow ? 4 : 3}
                  fill={p.isRecentWindow ? "#0d9488" : "#64748b"}
                  stroke="#ffffff"
                  strokeWidth={1.2}
                >
                  <title>{`${p.date} ${p.regattaName}: #${p.rank}/${p.fleetSize} (${p.percentile}%)`}</title>
                </circle>
                {i === pts.length - 1 || pts.length <= 8 || i % 2 === 0 ? (
                  <text
                    x={xAt(i)}
                    y={yAt(p.percentile) - 7}
                    textAnchor="middle"
                    className="fill-slate-700 text-[9px] font-semibold"
                  >
                    #{p.rank}
                  </text>
                ) : null}
              </g>
            ))}

            <circle cx={projX} cy={projY} r={4.5} fill="#ea580c" stroke="#ffffff" strokeWidth={1.5} />
            <text
              x={projX}
              y={projY - 8}
              textAnchor="middle"
              className="fill-orange-700 text-[9.5px] font-bold"
            >
              Proj #{entry.projectedRank ?? "—"}
            </text>
            <text x={padL} y={h - 10} className="fill-slate-500 text-[9.5px]">
              {pts[0]?.date.slice(0, 7)}
            </text>
            <text x={xAt(pts.length - 1)} y={h - 10} textAnchor="middle" className="fill-slate-500 text-[9.5px]">
              {pts[pts.length - 1]?.date.slice(0, 7)}
            </text>
            <text x={projX} y={h - 10} textAnchor="middle" className="fill-orange-700 text-[9.5px] font-semibold">
              +6m
            </text>
          </svg>
          <figcaption className="mt-1 flex flex-wrap gap-1.5 text-[11px] text-slate-600">
            <span>Last {pts.length} eligible Gold starts shown (#rank / fleet).</span>
            {entry.tags.length > 0 ? (
              <span className="font-semibold text-slate-800">
                Signals: {entry.tags.join(" · ")}.
              </span>
            ) : null}
          </figcaption>
        </figure>
      ) : (
        <p className="text-xs text-slate-500">No Gold fleet starts recorded in this scope yet.</p>
      )}

      {pts.length > 0 ? (
        <div className="max-h-36 overflow-y-auto rounded-lg border border-slate-100 bg-slate-50/70 p-2">
          <ul className="space-y-1 text-xs">
            {[...entry.history]
              .reverse()
              .slice(0, 8)
              .map((hItem) => (
                <li
                  key={`${hItem.regattaId}-${hItem.date}`}
                  className="flex items-center justify-between gap-2 text-slate-700"
                >
                  <span className="min-w-0 truncate">
                    <span className="tabular-nums text-slate-500 mr-1.5">{hItem.date}</span>
                    {hItem.regattaName}
                  </span>
                  <span className="shrink-0 font-semibold tabular-nums text-slate-900">
                    #{hItem.rank}/{hItem.fleetSize}{" "}
                    <span className="font-normal text-slate-500">({hItem.percentile}%)</span>
                  </span>
                </li>
              ))}
          </ul>
        </div>
      ) : null}
    </div>
  );
}

export function AdminGoldFormPanel({ isSuperadmin, onOpenSailor }: Props) {
  const queryClient = useQueryClient();
  const [scope, setScope] = useState<GoldFormScope>("sg_ranking");
  const [preset, setPreset] = useState<FocusPreset>("best_form");
  const [search, setSearch] = useState("");
  const [birthYearFilter, setBirthYearFilter] = useState<string>("all");
  const [genderFilter, setGenderFilter] = useState<"all" | "F" | "M">("all");
  const [minStartsFilter, setMinStartsFilter] = useState<number>(2);
  const [sortCol, setSortCol] = useState<SortColumn>("formIndex");
  const [sortDir, setSortDir] = useState<SortDirection>("descending");
  const [selectedSailorId, setSelectedSailorId] = useState<string | null>(null);
  const [hoveredSailorId, setHoveredSailorId] = useState<string | null>(null);
  const [selectedSnapshotId, setSelectedSnapshotId] = useState<string | null>(null);
  const [announcement, setAnnouncement] = useState("");

  const query = useQuery<AdminGoldFormResponse>({
    queryKey: adminQueryKeys.goldForm(),
    queryFn: ({ signal }) => fetchAdminGoldForm({ signal }),
    enabled: isSuperadmin,
    retry: false,
  });

  const saveSnapshotMutation = useMutation({
    mutationFn: () => saveAdminGoldFormSnapshot(),
    onSuccess: async (res) => {
      setSelectedSnapshotId(res.snapshot.id);
      setAnnouncement(`Saved baseline snapshot ${res.snapshot.label}`);
      await queryClient.invalidateQueries({ queryKey: adminQueryKeys.goldForm() });
    },
  });

  const summary = query.data
    ? scope === "sg_ranking"
      ? query.data.sgRanking
      : query.data.allGold
    : null;

  const availableBirthYears = useMemo(() => {
    if (!summary) return [];
    const yrs = new Set<number>();
    for (const e of summary.entries) {
      if (e.birthYear != null) yrs.add(e.birthYear);
    }
    return [...yrs].sort((a, b) => a - b);
  }, [summary]);

  const filteredEntries = useMemo(() => {
    if (!summary) return [];
    const q = search.trim().toLowerCase();
    const list = summary.entries.filter((entry) => {
      if (entry.totalStarts < minStartsFilter) return false;
      if (genderFilter !== "all" && entry.gender !== genderFilter) return false;
      if (birthYearFilter !== "all" && String(entry.birthYear ?? "") !== birthYearFilter) {
        return false;
      }
      if (preset === "best_form") {
        if (entry.recentStarts < 1) return false;
      } else if (preset === "up_and_coming") {
        const qualifyingProspect =
          entry.confidence !== "low" &&
          (entry.watchlistIndex >= 42 ||
            (entry.momentumDelta ?? 0) >= 8 ||
            (entry.cohortPeerEdge ?? 0) >= 12);
        if (!qualifyingProspect) return false;
      }
      if (!q) return true;
      return (
        entry.name.toLowerCase().includes(q) ||
        String(entry.sailNumber ?? "").toLowerCase().includes(q) ||
        String(entry.club ?? "").toLowerCase().includes(q)
      );
    });

    const factor = sortDir === "ascending" ? 1 : -1;
    const numCompare = (a: number | null, b: number | null) => {
      if (a == null && b == null) return 0;
      if (a == null) return 1;
      if (b == null) return -1;
      return (a - b) * factor;
    };

    return [...list].sort((a, b) => {
      switch (sortCol) {
        case "name":
          return COLLATOR.compare(a.name, b.name) * factor;
        case "birthYear":
          return numCompare(a.birthYear, b.birthYear);
        case "currentNationalRank":
          return numCompare(a.currentNationalRank, b.currentNationalRank);
        case "projectedNationalRankJun2027":
          return numCompare(a.projectedNationalRankJun2027, b.projectedNationalRankJun2027);
        case "totalStarts":
          return numCompare(a.totalStarts, b.totalStarts);
        case "watchlistIndex":
          return numCompare(a.watchlistIndex, b.watchlistIndex);
        case "recentAvgRank":
          return numCompare(a.recentAvgRank, b.recentAvgRank);
        case "momentumDelta":
          return numCompare(a.momentumDelta, b.momentumDelta);
        case "cohortPeerEdge":
          return numCompare(a.cohortPeerEdge, b.cohortPeerEdge);
        case "projectedPercentile":
          return numCompare(a.projectedPercentile, b.projectedPercentile);
        default:
          return numCompare(a.formIndex, b.formIndex);
      }
    });
  }, [
    summary,
    search,
    minStartsFilter,
    genderFilter,
    birthYearFilter,
    preset,
    sortCol,
    sortDir,
  ]);

  const handlePresetChange = (next: FocusPreset) => {
    setPreset(next);
    if (next === "up_and_coming") {
      setSortCol("watchlistIndex");
      setSortDir("descending");
      setAnnouncement("Filtered to Up and coming watchlist, sorted by Watchlist descending.");
    } else if (next === "best_form") {
      setSortCol("formIndex");
      setSortDir("descending");
      setAnnouncement("Filtered to Best form, sorted by Form Index descending.");
    } else {
      setSortCol("formIndex");
      setSortDir("descending");
      setAnnouncement("Showing all current Gold sailors.");
    }
  };

  const handleSort = (column: SortColumn, label: string, defaultDesc = true) => {
    let nextDir: SortDirection;
    if (sortCol === column) {
      nextDir = sortDir === "ascending" ? "descending" : "ascending";
    } else {
      nextDir = defaultDesc ? "descending" : "ascending";
    }
    setSortCol(column);
    setSortDir(nextDir);
    setAnnouncement(
      `Sorted by ${label}, ${nextDir}, ${filteredEntries.length} rows`,
    );
  };

  if (!isSuperadmin) {
    return <p className="text-sm text-slate-700">Superadmin access is required.</p>;
  }

  if (query.isPending && !summary) {
    return (
      <p role="status" className="py-8 text-sm text-slate-600">
        Computing Gold fleet form and up-and-coming projections…
      </p>
    );
  }

  if (query.isError && !summary) {
    return (
      <div role="alert" className="rounded-xl border border-amber-300 bg-amber-50 p-4 text-sm text-amber-900 space-y-2">
        <p>Could not load Gold fleet form analytics: {query.error?.message || "Unknown error"}</p>
        <button
          type="button"
          onClick={() => void query.refetch()}
          className="inline-flex min-h-10 items-center gap-1.5 rounded-lg border border-amber-400 bg-white px-3 text-xs font-semibold text-amber-900"
        >
          <RefreshCw className="h-3.5 w-3.5" aria-hidden="true" />
          Retry
        </button>
      </div>
    );
  }

  if (!summary) return null;

  const topFormLeader =
    summary.entries.find((e) => e.recentStarts >= 2) ?? summary.entries[0] ?? null;
  const topWatchlistLeader =
    [...summary.entries]
      .filter((e) => e.confidence !== "low")
      .sort((a, b) => b.watchlistIndex - a.watchlistIndex)[0] ?? null;
  const biggestClimber =
    [...summary.entries]
      .filter((e) => e.momentumDelta != null && e.recentStarts >= 2 && e.priorStarts >= 2)
      .sort((a, b) => (b.momentumDelta ?? -999) - (a.momentumDelta ?? -999))[0] ?? null;

  const selectedEntry =
    filteredEntries.find((e) => e.sailorId === selectedSailorId) ??
    summary.entries.find((e) => e.sailorId === selectedSailorId) ??
    filteredEntries[0] ??
    topFormLeader;

  const sortIcon = (col: SortColumn) => {
    if (sortCol !== col) return <ArrowUpDown className="h-3.5 w-3.5 text-slate-400" aria-hidden="true" />;
    return sortDir === "ascending" ? (
      <ArrowUp className="h-3.5 w-3.5 text-slate-900" aria-hidden="true" />
    ) : (
      <ArrowDown className="h-3.5 w-3.5 text-slate-900" aria-hidden="true" />
    );
  };

  return (
    <div className="space-y-5">
      <div role="status" aria-live="polite" className="sr-only">
        {announcement}
      </div>

      {/* Header & scope controls */}
      <div className="rounded-xl border border-slate-200 bg-white p-4 sm:p-5 space-y-4">
        <div className="flex flex-wrap items-start justify-between gap-3">
          <div className="space-y-1">
            <h2 className="text-lg font-bold text-slate-900">
              Optimist Gold Form &amp; Up-and-Coming Index
            </h2>
            <p className="text-xs sm:text-sm text-slate-600 max-w-3xl leading-relaxed">
              Evaluates current active Gold sailors using fleet-size-normalized Gold
              finishes (excluding plain DNS and overseas commitments). Recent window
              covers up to 180 days from{" "}
              <span className="font-semibold text-slate-800">{summary.referenceYmd}</span>{" "}
              vs. prior baseline (181–420 days).
            </p>
          </div>
          <button
            type="button"
            disabled={query.isFetching}
            onClick={() => void query.refetch()}
            className="inline-flex min-h-10 items-center gap-1.5 rounded-lg border border-slate-300 bg-white px-3 text-xs font-semibold text-slate-800 hover:bg-slate-50 disabled:opacity-50"
          >
            <RefreshCw
              className={`h-3.5 w-3.5 ${query.isFetching ? "animate-spin" : ""}`}
              aria-hidden="true"
            />
            Refresh
          </button>
        </div>

        <div className="flex flex-wrap items-center justify-between gap-3 pt-1">
          <div className="flex flex-wrap items-center gap-1.5" role="group" aria-label="View mode">
            {(
              [
                ["best_form", "Best Form"],
                ["up_and_coming", "Up & Coming to Watch"],
                ["all", "All Active Gold"],
              ] as const
            ).map(([key, label]) => (
              <button
                key={key}
                type="button"
                aria-pressed={preset === key}
                onClick={() => handlePresetChange(key)}
                className={`min-h-9 rounded-lg px-3 text-xs font-semibold transition focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-orange-600 ${
                  preset === key
                    ? "bg-[var(--sp-harbour-teal)] text-white"
                    : "border border-slate-200 bg-slate-50 text-slate-700 hover:bg-slate-100"
                }`}
              >
                {label}
              </button>
            ))}
          </div>

          <div className="flex flex-wrap items-center gap-1.5" role="group" aria-label="Regatta scope">
            {(
              [
                ["sg_ranking", "SGP Ranking Gold"],
                ["all_gold", "All Gold (incl. Overseas)"],
              ] as const
            ).map(([key, label]) => (
              <button
                key={key}
                type="button"
                aria-pressed={scope === key}
                onClick={() => setScope(key)}
                className={`min-h-9 rounded-lg px-3 text-xs font-semibold transition focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-orange-600 ${
                  scope === key
                    ? "bg-slate-900 text-white"
                    : "border border-slate-200 bg-white text-slate-700 hover:bg-slate-50"
                }`}
              >
                {label}
              </button>
            ))}
          </div>
        </div>
      </div>

      {/* KPI summary strip */}
      <div className="grid grid-cols-1 sm:grid-cols-2 xl:grid-cols-4 gap-3">
        <div className="rounded-xl border border-slate-200 bg-white p-4">
          <div className="flex items-center justify-between text-xs font-semibold text-slate-600">
            <span>Best current form</span>
            <Trophy className="h-4 w-4 text-teal-600" aria-hidden="true" />
          </div>
          {topFormLeader ? (
            <>
              <button
                type="button"
                onClick={() => setSelectedSailorId(topFormLeader.sailorId)}
                className="mt-1.5 text-left text-base font-bold text-slate-900 hover:underline focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-orange-600"
              >
                {topFormLeader.name}
              </button>
              <p className="mt-1 text-xs text-slate-600 tabular-nums">
                Form <strong className="text-slate-900">{topFormLeader.formIndex}</strong> ·
                Recent avg #{topFormLeader.recentAvgRank ?? "—"} (best #
                {topFormLeader.recentBestRank ?? "—"})
              </p>
            </>
          ) : (
            <p className="mt-2 text-sm text-slate-500">—</p>
          )}
        </div>

        <div className="rounded-xl border border-slate-200 bg-white p-4">
          <div className="flex items-center justify-between text-xs font-semibold text-slate-600">
            <span>Top up-and-coming watch</span>
            <Sparkles className="h-4 w-4 text-orange-500" aria-hidden="true" />
          </div>
          {topWatchlistLeader ? (
            <>
              <button
                type="button"
                onClick={() => setSelectedSailorId(topWatchlistLeader.sailorId)}
                className="mt-1.5 text-left text-base font-bold text-slate-900 hover:underline focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-orange-600"
              >
                {topWatchlistLeader.name}
              </button>
              <p className="mt-1 text-xs text-slate-600 tabular-nums">
                Watchlist{" "}
                <strong className="text-slate-900">{topWatchlistLeader.watchlistIndex}</strong>{" "}
                · {topWatchlistLeader.birthYear ?? "—"} · Proj ~#
                {topWatchlistLeader.projectedRank ?? "—"}
              </p>
            </>
          ) : (
            <p className="mt-2 text-sm text-slate-500">—</p>
          )}
        </div>

        <div className="rounded-xl border border-slate-200 bg-white p-4">
          <div className="flex items-center justify-between text-xs font-semibold text-slate-600">
            <span>Steepest recent surge</span>
            <TrendingUp className="h-4 w-4 text-orange-600" aria-hidden="true" />
          </div>
          {biggestClimber ? (
            <>
              <button
                type="button"
                onClick={() => setSelectedSailorId(biggestClimber.sailorId)}
                className="mt-1.5 text-left text-base font-bold text-slate-900 hover:underline focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-orange-600"
              >
                {biggestClimber.name}
              </button>
              <p className="mt-1 text-xs text-slate-600 tabular-nums">
                <strong className="text-orange-700">
                  {formatSigned(biggestClimber.momentumDelta, " pct pts")}
                </strong>{" "}
                ({biggestClimber.priorAvgPercentile ?? "—"}% →{" "}
                {biggestClimber.recentAvgPercentile ?? "—"}%)
              </p>
            </>
          ) : (
            <p className="mt-2 text-sm text-slate-500">—</p>
          )}
        </div>

        <div className="rounded-xl border border-slate-200 bg-white p-4">
          <div className="flex items-center justify-between text-xs font-semibold text-slate-600">
            <span>Gold cohort analyzed</span>
            <Users className="h-4 w-4 text-slate-600" aria-hidden="true" />
          </div>
          <p className="mt-1.5 text-xl font-bold text-slate-900 tabular-nums">
            {summary.qualifiedCount} / {summary.activeGoldCount}
          </p>
          <p className="mt-1 text-xs text-slate-600 tabular-nums">
            {summary.regattaCount} regattas ({summary.recentRegattaCount} recent) ·{" "}
            ~{summary.typicalFleetSize} boats/sheet
          </p>
        </div>
      </div>

      {/* Birth-year cohort averages strip */}
      {summary.cohortAverages.length > 0 ? (
        <div className="rounded-xl border border-slate-200 bg-white px-4 py-3 flex flex-wrap items-center gap-2 text-xs">
          <span className="font-semibold text-slate-700 mr-1">
            Gold birth-year benchmarks:
          </span>
          {summary.cohortAverages.map((cohort) => (
            <button
              key={cohort.birthYear}
              type="button"
              onClick={() =>
                setBirthYearFilter((prev) =>
                  prev === String(cohort.birthYear) ? "all" : String(cohort.birthYear),
                )
              }
              aria-pressed={birthYearFilter === String(cohort.birthYear)}
              className={`rounded-lg border px-2.5 py-1 tabular-nums transition focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-orange-600 ${
                birthYearFilter === String(cohort.birthYear)
                  ? "border-slate-900 bg-slate-900 text-white font-semibold"
                  : "border-slate-200 bg-slate-50 text-slate-700 hover:bg-slate-100"
              }`}
            >
              {cohort.birthYear}: avg {cohort.avgWeightedPercentile}% ({cohort.count})
            </button>
          ))}
        </div>
      ) : null}

      {/* Dual Chart Grid */}
      <div className="grid grid-cols-1 xl:grid-cols-12 gap-4">
        <div className="xl:col-span-7">
          <QuadrantChart
            entries={filteredEntries}
            selectedId={selectedEntry?.sailorId ?? null}
            hoveredId={hoveredSailorId}
            onHover={setHoveredSailorId}
            onSelect={setSelectedSailorId}
          />
        </div>
        <div className="xl:col-span-5">
          <SailorTrajectoryChart
            entry={selectedEntry}
            summary={summary}
            onOpenSailor={onOpenSailor}
          />
        </div>
      </div>

      {/* Filters + Sortable Index Table */}
      <div className="rounded-xl border border-slate-200 bg-white p-4 space-y-4">
        <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-3">
          <div>
            <label
              htmlFor="gold-form-search"
              className="block text-xs font-semibold text-slate-700 mb-1"
            >
              Search sailor or sail #
            </label>
            <input
              id="gold-form-search"
              type="search"
              value={search}
              onChange={(e) => setSearch(e.target.value)}
              placeholder="Name, SGP sail #, club…"
              className="min-h-10 w-full rounded-lg border border-slate-300 bg-white px-3 text-sm text-slate-900 placeholder:text-slate-400 focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-orange-600"
            />
          </div>

          <div>
            <label
              htmlFor="gold-form-birth-year"
              className="block text-xs font-semibold text-slate-700 mb-1"
            >
              Birth year
            </label>
            <select
              id="gold-form-birth-year"
              value={birthYearFilter}
              onChange={(e) => setBirthYearFilter(e.target.value)}
              className="min-h-10 w-full rounded-lg border border-slate-300 bg-white px-3 text-sm text-slate-900 focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-orange-600"
            >
              <option value="all">All cohorts ({summary.activeGoldCount})</option>
              {availableBirthYears.map((yr) => (
                <option key={yr} value={String(yr)}>
                  {yr}
                </option>
              ))}
            </select>
          </div>

          <div>
            <label
              htmlFor="gold-form-gender"
              className="block text-xs font-semibold text-slate-700 mb-1"
            >
              Gender
            </label>
            <select
              id="gold-form-gender"
              value={genderFilter}
              onChange={(e) => setGenderFilter(e.target.value as "all" | "F" | "M")}
              className="min-h-10 w-full rounded-lg border border-slate-300 bg-white px-3 text-sm text-slate-900 focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-orange-600"
            >
              <option value="all">All</option>
              <option value="F">Female</option>
              <option value="M">Male</option>
            </select>
          </div>

          <div>
            <label
              htmlFor="gold-form-min-starts"
              className="block text-xs font-semibold text-slate-700 mb-1"
            >
              Min Gold starts
            </label>
            <select
              id="gold-form-min-starts"
              value={minStartsFilter}
              onChange={(e) => setMinStartsFilter(Number(e.target.value))}
              className="min-h-10 w-full rounded-lg border border-slate-300 bg-white px-3 text-sm text-slate-900 focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-orange-600"
            >
              <option value={0}>All active Gold</option>
              <option value={2}>2+ starts</option>
              <option value={5}>5+ starts</option>
              <option value={10}>10+ starts</option>
            </select>
          </div>
        </div>

        <div
          tabIndex={0}
          role="region"
          aria-labelledby="gold-form-table-caption"
          className="overflow-x-auto rounded-lg border border-slate-200 focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-orange-600"
        >
          <table className="min-w-[980px] w-full border-collapse text-left text-xs">
            <caption
              id="gold-form-table-caption"
              className="px-3 py-2 text-left text-xs font-semibold text-slate-600 bg-slate-50 border-b border-slate-200"
            >
              Current Gold fleet form and up-and-coming projections ({filteredEntries.length} sailors shown)
            </caption>
            <thead className="bg-slate-50 text-slate-700 border-b border-slate-200">
              <tr>
                <th
                  scope="col"
                  aria-sort={sortCol === "name" ? sortDir : undefined}
                  className="sticky left-0 z-10 bg-slate-50 font-semibold"
                >
                  <button
                    type="button"
                    onClick={() => handleSort("name", "Sailor", false)}
                    className="inline-flex min-h-9 w-full items-center gap-1 px-3 py-2 text-left font-semibold hover:text-slate-950 focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-orange-600"
                  >
                    <span>Sailor</span>
                    {sortIcon("name")}
                  </button>
                </th>
                <th
                  scope="col"
                  aria-sort={sortCol === "birthYear" ? sortDir : undefined}
                  className="font-semibold"
                >
                  <button
                    type="button"
                    onClick={() => handleSort("birthYear", "Birth year", true)}
                    className="inline-flex min-h-9 w-full items-center gap-1 px-2.5 py-2 text-left font-semibold hover:text-slate-950 focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-orange-600"
                  >
                    <span>Born</span>
                    {sortIcon("birthYear")}
                  </button>
                </th>
                <th
                  scope="col"
                  aria-sort={sortCol === "currentNationalRank" ? sortDir : undefined}
                  className="font-semibold"
                >
                  <button
                    type="button"
                    onClick={() => handleSort("currentNationalRank", "Current National Rank", false)}
                    className="inline-flex min-h-9 w-full items-center gap-1 px-2.5 py-2 text-left font-semibold hover:text-slate-950 focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-orange-600"
                  >
                    <span>Nat Rank</span>
                    {sortIcon("currentNationalRank")}
                  </button>
                </th>
                <th
                  scope="col"
                  aria-sort={sortCol === "projectedNationalRankJun2027" ? sortDir : undefined}
                  className="font-semibold"
                >
                  <button
                    type="button"
                    onClick={() => handleSort("projectedNationalRankJun2027", "Projected 30 Jun 2027 Rank", false)}
                    className="inline-flex min-h-9 w-full items-center gap-1 px-2.5 py-2 text-left font-semibold hover:text-slate-950 focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-orange-600"
                  >
                    <span>Proj 30 Jun 27</span>
                    {sortIcon("projectedNationalRankJun2027")}
                  </button>
                </th>
                <th
                  scope="col"
                  aria-sort={sortCol === "formIndex" ? sortDir : undefined}
                  className="font-semibold"
                >
                  <button
                    type="button"
                    onClick={() => handleSort("formIndex", "Form Index", true)}
                    className="inline-flex min-h-9 w-full items-center gap-1 px-2.5 py-2 text-left font-semibold hover:text-slate-950 focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-orange-600"
                  >
                    <span>Form</span>
                    {sortIcon("formIndex")}
                  </button>
                </th>
                <th
                  scope="col"
                  aria-sort={sortCol === "watchlistIndex" ? sortDir : undefined}
                  className="font-semibold"
                >
                  <button
                    type="button"
                    onClick={() => handleSort("watchlistIndex", "Watchlist Index", true)}
                    className="inline-flex min-h-9 w-full items-center gap-1 px-2.5 py-2 text-left font-semibold hover:text-slate-950 focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-orange-600"
                  >
                    <span>Watchlist</span>
                    {sortIcon("watchlistIndex")}
                  </button>
                </th>
                <th
                  scope="col"
                  aria-sort={sortCol === "recentAvgRank" ? sortDir : undefined}
                  className="font-semibold"
                >
                  <button
                    type="button"
                    onClick={() => handleSort("recentAvgRank", "Recent avg rank", false)}
                    className="inline-flex min-h-9 w-full items-center gap-1 px-2.5 py-2 text-left font-semibold hover:text-slate-950 focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-orange-600"
                  >
                    <span>Recent Avg / Best</span>
                    {sortIcon("recentAvgRank")}
                  </button>
                </th>
                <th
                  scope="col"
                  aria-sort={sortCol === "momentumDelta" ? sortDir : undefined}
                  className="font-semibold"
                >
                  <button
                    type="button"
                    onClick={() => handleSort("momentumDelta", "Momentum delta", true)}
                    className="inline-flex min-h-9 w-full items-center gap-1 px-2.5 py-2 text-left font-semibold hover:text-slate-950 focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-orange-600"
                  >
                    <span>Momentum Δ</span>
                    {sortIcon("momentumDelta")}
                  </button>
                </th>
                <th
                  scope="col"
                  aria-sort={sortCol === "cohortPeerEdge" ? sortDir : undefined}
                  className="font-semibold"
                >
                  <button
                    type="button"
                    onClick={() => handleSort("cohortPeerEdge", "Cohort peer edge", true)}
                    className="inline-flex min-h-9 w-full items-center gap-1 px-2.5 py-2 text-left font-semibold hover:text-slate-950 focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-orange-600"
                  >
                    <span>Vs Cohort</span>
                    {sortIcon("cohortPeerEdge")}
                  </button>
                </th>
                <th
                  scope="col"
                  aria-sort={sortCol === "projectedPercentile" ? sortDir : undefined}
                  className="font-semibold"
                >
                  <button
                    type="button"
                    onClick={() => handleSort("projectedPercentile", "6m projection", true)}
                    className="inline-flex min-h-9 w-full items-center gap-1 px-2.5 py-2 text-left font-semibold hover:text-slate-950 focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-orange-600"
                  >
                    <span>6m Proj</span>
                    {sortIcon("projectedPercentile")}
                  </button>
                </th>
                <th
                  scope="col"
                  aria-sort={sortCol === "totalStarts" ? sortDir : undefined}
                  className="font-semibold"
                >
                  <button
                    type="button"
                    onClick={() => handleSort("totalStarts", "Starts", true)}
                    className="inline-flex min-h-9 w-full items-center gap-1 px-2.5 py-2 text-left font-semibold hover:text-slate-950 focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-orange-600"
                  >
                    <span>Starts</span>
                    {sortIcon("totalStarts")}
                  </button>
                </th>
                <th scope="col" className="px-2.5 py-2 text-left font-semibold">
                  Trend
                </th>
              </tr>
            </thead>
            <tbody className="divide-y divide-slate-100">
              {filteredEntries.length === 0 ? (
                <tr>
                  <td colSpan={12} className="px-4 py-8 text-center text-sm text-slate-500">
                    No active Gold sailors match the current filters.
                  </td>
                </tr>
              ) : (
                filteredEntries.map((entry) => {
                  const selected = selectedEntry?.sailorId === entry.sailorId;
                  const badge = tierBadge(entry.tier);
                  return (
                    <tr
                      key={entry.sailorId}
                      className={selected ? "bg-orange-50/60" : "hover:bg-slate-50"}
                    >
                      <th
                        scope="row"
                        className={`sticky left-0 z-[1] px-3 py-2.5 font-normal ${
                          selected ? "bg-orange-50/90" : "bg-white"
                        }`}
                      >
                        <button
                          type="button"
                          onClick={() => setSelectedSailorId(entry.sailorId)}
                          className="text-left focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-orange-600 rounded"
                        >
                          <span className="block font-bold text-slate-900">
                            {entry.name}
                          </span>
                          <span className="mt-0.5 flex flex-wrap items-center gap-1.5 text-[11px] text-slate-500">
                            <span>{entry.sailNumber || "—"}</span>
                            {entry.gender ? <span>· {entry.gender}</span> : null}
                            {entry.nationalSquadStatus ? (
                              <span className="rounded bg-slate-100 px-1.5 py-0.5 font-semibold text-slate-700">
                                {entry.nationalSquadStatus}
                              </span>
                            ) : null}
                            <span
                              className={`rounded-full border px-1.5 py-0.5 text-[10px] font-semibold ${badge.className}`}
                            >
                              {badge.label}
                            </span>
                          </span>
                        </button>
                      </th>
                      <td data-value={entry.birthYear ?? ""} className="px-2.5 py-2.5 tabular-nums text-slate-700">
                        {entry.birthYear ?? "—"}
                      </td>
                      <td
                        data-value={entry.currentNationalRank ?? 999}
                        className="px-2.5 py-2.5 tabular-nums whitespace-nowrap"
                      >
                        <span className="font-bold text-slate-900">
                          {entry.currentNationalRank != null ? `#${entry.currentNationalRank}` : "—"}
                        </span>
                        {entry.currentBest3of5 != null ? (
                          <span className="block text-[10px] text-slate-500">
                            Best 3: {entry.currentBest3of5}
                          </span>
                        ) : null}
                      </td>
                      <td
                        data-value={entry.projectedNationalRankJun2027 ?? 999}
                        className="px-2.5 py-2.5 tabular-nums whitespace-nowrap"
                      >
                        {entry.agingOut2027 ? (
                          <span className="rounded bg-slate-100 px-1.5 py-0.5 text-[10px] font-semibold text-slate-600">
                            Ages out (2011)
                          </span>
                        ) : (
                          <>
                            <span className="font-bold text-slate-900">
                              {entry.projectedNationalRankJun2027 != null
                                ? `#${entry.projectedNationalRankJun2027}`
                                : "—"}
                            </span>
                            {entry.projectedNationalRankDelta != null &&
                            entry.projectedNationalRankDelta !== 0 ? (
                              <span
                                className={`block text-[10px] font-semibold ${
                                  entry.projectedNationalRankDelta > 0
                                    ? "text-teal-700"
                                    : "text-rose-700"
                                }`}
                              >
                                {entry.projectedNationalRankDelta > 0
                                  ? `↑ +${entry.projectedNationalRankDelta}`
                                  : `↓ ${entry.projectedNationalRankDelta}`}
                              </span>
                            ) : null}
                          </>
                        )}
                      </td>
                      <td data-value={entry.formIndex} className="px-2.5 py-2.5 tabular-nums">
                        <span className="font-bold text-slate-900">{entry.formIndex}</span>
                        <span className="block text-[10px] text-slate-500">
                          {entry.weightedPercentile}% wt
                        </span>
                      </td>
                      <td data-value={entry.watchlistIndex} className="px-2.5 py-2.5 tabular-nums">
                        <span
                          className={`font-bold ${
                            entry.watchlistIndex >= 52 ? "text-orange-700" : "text-slate-800"
                          }`}
                        >
                          {entry.watchlistIndex}
                        </span>
                        {entry.tags[0] ? (
                          <span className="block text-[10px] text-slate-500 whitespace-nowrap">
                            {entry.tags[0]}
                          </span>
                        ) : null}
                      </td>
                      <td
                        data-value={entry.recentAvgRank ?? 999}
                        className="px-2.5 py-2.5 tabular-nums text-slate-800 whitespace-nowrap"
                      >
                        {entry.recentAvgRank != null ? `#${entry.recentAvgRank}` : "—"}{" "}
                        <span className="text-slate-500">
                          / {entry.recentBestRank != null ? `#${entry.recentBestRank}` : "—"}
                        </span>
                      </td>
                      <td
                        data-value={entry.momentumDelta ?? -999}
                        className="px-2.5 py-2.5 tabular-nums whitespace-nowrap"
                      >
                        <span
                          className={
                            entry.momentumDelta != null && entry.momentumDelta >= 8
                              ? "font-bold text-orange-700"
                              : entry.momentumDelta != null && entry.momentumDelta <= -8
                                ? "font-semibold text-rose-700"
                                : "font-semibold text-slate-700"
                          }
                        >
                          {formatSigned(entry.momentumDelta, " pts")}
                        </span>
                        {entry.slopePerHalf != null ? (
                          <span className="block text-[10px] text-slate-500">
                            {formatSigned(entry.slopePerHalf, "/6m")}
                          </span>
                        ) : null}
                      </td>
                      <td
                        data-value={entry.cohortPeerEdge ?? -999}
                        className="px-2.5 py-2.5 tabular-nums whitespace-nowrap"
                      >
                        <span
                          className={
                            entry.cohortPeerEdge != null && entry.cohortPeerEdge >= 10
                              ? "font-bold text-teal-700"
                              : "text-slate-700"
                          }
                        >
                          {formatSigned(entry.cohortPeerEdge, " pts")}
                        </span>
                      </td>
                      <td
                        data-value={entry.projectedPercentile}
                        className="px-2.5 py-2.5 tabular-nums whitespace-nowrap"
                      >
                        <span className="font-bold text-slate-900">
                          {entry.projectedRank != null ? `~#${entry.projectedRank}` : "—"}
                        </span>
                        <span className="block text-[10px] text-slate-500">
                          {entry.projectedPercentile}%
                          {entry.projectedRankGain != null && entry.projectedRankGain > 0
                            ? ` (+${entry.projectedRankGain} pl)`
                            : ""}
                        </span>
                      </td>
                      <td
                        data-value={entry.totalStarts}
                        className="px-2.5 py-2.5 tabular-nums text-slate-700 whitespace-nowrap"
                      >
                        {entry.recentStarts} / {entry.totalStarts}
                        {entry.overseasStarts > 0 ? (
                          <span className="block text-[10px] text-slate-500">
                            +{entry.overseasStarts} OS
                          </span>
                        ) : null}
                      </td>
                      <td className="px-2.5 py-2.5">
                        <Sparkline entry={entry} />
                      </td>
                    </tr>
                  );
                })
              )}
            </tbody>
          </table>
        </div>
      </div>

      {/* Baseline Snapshots & 30 Jun 2027 Accuracy Review */}
      {(() => {
        const snapshots = query.data?.snapshots ?? [];
        const activeSnapshot =
          snapshots.find((s) => s.id === selectedSnapshotId) ?? snapshots[0] ?? null;
        const comparison =
          activeSnapshot && query.data
            ? compareSnapshotWithActuals(
                activeSnapshot.summary.entries ?? [],
                query.data.sgRanking.entries,
              )
            : null;
        return (
          <div className="rounded-xl border border-slate-200 bg-white p-4 sm:p-5 space-y-4">
            <div className="flex flex-wrap items-start justify-between gap-3">
              <div>
                <h3 className="text-sm font-bold text-slate-900">
                  30 Jun 2027 Prediction Snapshots &amp; Accuracy Review
                </h3>
                <p className="mt-0.5 text-xs text-slate-600 max-w-2xl">
                  Freeze today&apos;s National Ranking predictions so we can compare
                  predicted vs. actual 30 Jun 2027 Gold National Rankings side-by-side.
                </p>
              </div>
              <button
                type="button"
                disabled={saveSnapshotMutation.isPending}
                onClick={() => saveSnapshotMutation.mutate()}
                className="inline-flex min-h-10 items-center gap-1.5 rounded-lg bg-slate-900 px-3 text-xs font-semibold text-white hover:bg-slate-800 disabled:opacity-50 focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-orange-600"
              >
                <BookmarkCheck className="h-3.5 w-3.5" aria-hidden="true" />
                {saveSnapshotMutation.isPending
                  ? "Saving snapshot…"
                  : "Save Snapshot for 30 Jun 2027 Review"}
              </button>
            </div>

            {saveSnapshotMutation.isError ? (
              <p role="alert" className="text-xs text-rose-700">
                Could not save snapshot: {saveSnapshotMutation.error?.message || "Unknown error"}
              </p>
            ) : null}

            {snapshots.length === 0 ? (
              <p className="text-xs text-slate-500">
                No frozen snapshots saved yet. Save a baseline snapshot to lock in current
                30 Jun 2027 projections.
              </p>
            ) : (
              <div className="space-y-3">
                <div className="flex flex-wrap items-center gap-3">
                  <label
                    htmlFor="gold-form-snapshot-select"
                    className="text-xs font-semibold text-slate-700"
                  >
                    Compare snapshot:
                  </label>
                  <select
                    id="gold-form-snapshot-select"
                    value={activeSnapshot?.id ?? ""}
                    onChange={(e) => setSelectedSnapshotId(e.target.value)}
                    className="min-h-9 rounded-lg border border-slate-300 bg-white px-2.5 text-xs text-slate-900 focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-orange-600"
                  >
                    {snapshots.map((snap) => (
                      <option key={snap.id} value={snap.id}>
                        {snap.label} (saved {snap.baselineDate})
                      </option>
                    ))}
                  </select>
                </div>

                {comparison ? (
                  <>
                    <div className="grid grid-cols-2 sm:grid-cols-4 gap-2 text-xs">
                      <div className="rounded-lg bg-slate-50 px-3 py-2">
                        <span className="text-slate-500">Evaluated</span>
                        <p className="font-bold text-slate-900 tabular-nums text-sm">
                          {comparison.evaluatedCount} sailors
                        </p>
                      </div>
                      <div className="rounded-lg bg-slate-50 px-3 py-2">
                        <span className="text-slate-500">Mean Abs Error</span>
                        <p className="font-bold text-slate-900 tabular-nums text-sm">
                          {comparison.maeRanks != null ? `${comparison.maeRanks} ranks` : "—"}
                        </p>
                      </div>
                      <div className="rounded-lg bg-slate-50 px-3 py-2">
                        <span className="text-slate-500">Top-10 Hit Rate</span>
                        <p className="font-bold text-slate-900 tabular-nums text-sm">
                          {comparison.top10Hits} / {comparison.top10Total}
                        </p>
                      </div>
                      <div className="rounded-lg bg-slate-50 px-3 py-2">
                        <span className="text-slate-500">Top-20 Hit Rate</span>
                        <p className="font-bold text-slate-900 tabular-nums text-sm">
                          {comparison.top20Hits} / {comparison.top20Total}
                        </p>
                      </div>
                    </div>

                    <div className="overflow-x-auto rounded-lg border border-slate-200">
                      <table className="min-w-[540px] w-full border-collapse text-left text-xs">
                        <caption className="px-3 py-1.5 text-left text-[11px] font-semibold text-slate-600 bg-slate-50 border-b border-slate-200">
                          Top 15 predicted 30 Jun 2027 Gold rankings vs. current/actual National Rank
                        </caption>
                        <thead className="bg-slate-50 text-slate-700 border-b border-slate-200">
                          <tr>
                            <th scope="col" className="px-3 py-2 font-semibold">Sailor</th>
                            <th scope="col" className="px-2.5 py-2 font-semibold">Baseline</th>
                            <th scope="col" className="px-2.5 py-2 font-semibold">Pred Jun 27</th>
                            <th scope="col" className="px-2.5 py-2 font-semibold">Actual/Curr</th>
                            <th scope="col" className="px-2.5 py-2 font-semibold">Diff</th>
                          </tr>
                        </thead>
                        <tbody className="divide-y divide-slate-100">
                          {comparison.rows.slice(0, 15).map((row) => (
                            <tr key={row.sailorId}>
                              <th scope="row" className="px-3 py-2 font-semibold text-slate-900">
                                {row.name}{" "}
                                {row.birthYear ? (
                                  <span className="font-normal text-slate-500">({row.birthYear})</span>
                                ) : null}
                              </th>
                              <td className="px-2.5 py-2 tabular-nums text-slate-600">
                                {row.baselineRank != null ? `#${row.baselineRank}` : "—"}
                              </td>
                              <td className="px-2.5 py-2 tabular-nums font-bold text-slate-900">
                                #{row.predictedRank}
                              </td>
                              <td className="px-2.5 py-2 tabular-nums text-slate-800">
                                {row.actualRank != null ? `#${row.actualRank}` : "—"}
                              </td>
                              <td className="px-2.5 py-2 tabular-nums">
                                {row.errorRanks != null
                                  ? row.errorRanks === 0
                                    ? "Exact"
                                    : row.errorRanks > 0
                                      ? `+${row.errorRanks} ahead`
                                      : `${row.errorRanks}`
                                  : "—"}
                              </td>
                            </tr>
                          ))}
                        </tbody>
                      </table>
                    </div>
                  </>
                ) : null}
              </div>
            )}
          </div>
        );
      })()}
    </div>
  );
}
