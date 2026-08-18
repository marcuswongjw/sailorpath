"use client";

import { useMemo } from "react";
import { ordinal, type TrendPoint } from "@/lib/profileAnalytics";

export type PositionTrendChartProps = {
  points: TrendPoint[];
  mode: "new_gold" | "established_gold" | "other";
  goldEntryDate: string | null;
};

/**
 * SVG position trend: silver (white) / gold (amber), rank labels, data-driven axis.
 */
export function PositionTrendChart({
  points,
  mode,
  goldEntryDate,
}: PositionTrendChartProps) {
  const trendSvg = useMemo(() => {
    const pts = points;
    if (pts.length < 2) return null;
    const w = 680;
    const h = 240;
    const padL = 44;
    const padR = 24;
    const padT = 36;
    const padB = 36;
    const ranks = pts.map((p) => p.rank);
    const dataMin = Math.min(...ranks);
    const dataMax = Math.max(...ranks);
    const rawSpan = Math.max(dataMax - dataMin, 1);
    const pad = Math.max(1, Math.ceil(rawSpan * 0.15));
    const minR = Math.max(1, dataMin - pad);
    let maxR = dataMax + pad;
    if (maxR - minR < 5) maxR = minR + 5;
    const span = maxR - minR;
    const step =
      span <= 6 ? 1 : span <= 12 ? 2 : span <= 25 ? 5 : span <= 50 ? 10 : 15;
    const gridRanks: number[] = [];
    const tickStart = Math.ceil(minR / step) * step;
    for (let r = tickStart; r <= maxR; r += step) gridRanks.push(r);
    if (!gridRanks.includes(minR)) gridRanks.unshift(minR);
    if (!gridRanks.includes(maxR)) gridRanks.push(maxR);
    const uniqueTicks = [...new Set(gridRanks)].sort((a, b) => a - b);

    const yFor = (rank: number) =>
      padT + ((rank - minR) / (maxR - minR)) * (h - padT - padB);
    const xFor = (i: number) =>
      padL + (i / Math.max(pts.length - 1, 1)) * (w - padL - padR);

    let splitAt = -1;
    if (mode !== "established_gold") {
      if (goldEntryDate) {
        splitAt = pts.findIndex(
          (p) => p.fleet === "Gold" || p.date >= goldEntryDate
        );
      } else {
        splitAt = pts.findIndex((p) => p.fleet === "Gold");
      }
    }

    const pathThrough = (from: number, to: number) => {
      const slice = pts.slice(from, to + 1);
      if (!slice.length) return "";
      return slice
        .map((p, j) => {
          const i = from + j;
          return `${j === 0 ? "M" : "L"} ${xFor(i).toFixed(1)} ${yFor(p.rank).toFixed(1)}`;
        })
        .join(" ");
    };

    let silverPath = "";
    let goldPath = "";
    let promoX: number | null = null;
    if (splitAt > 0) {
      silverPath = pathThrough(0, splitAt);
      goldPath = pathThrough(splitAt, pts.length - 1);
      promoX = xFor(splitAt);
    } else if (splitAt === 0 || mode === "established_gold") {
      goldPath = pathThrough(0, pts.length - 1);
    } else {
      silverPath = pathThrough(0, pts.length - 1);
    }

    return {
      w,
      h,
      padL,
      padR,
      padT,
      padB,
      silverPath,
      goldPath,
      pts,
      xFor,
      yFor,
      promoX,
      gridRanks: uniqueTicks,
      showSegregation: splitAt > 0,
    };
  }, [points, mode, goldEntryDate]);

  if (!trendSvg) {
    return (
      <p className="text-sm text-neutral-600 py-8 text-center">
        Need at least two ranked finishes to chart progress.
      </p>
    );
  }

  return (
    <div className="relative w-full overflow-hidden">
      <svg
        viewBox={`0 0 ${trendSvg.w} ${trendSvg.h}`}
        className="w-full h-auto"
        role="img"
        aria-label="Position trend chart"
      >
        {trendSvg.gridRanks.map((r) => (
          <g key={r}>
            <line
              x1={trendSvg.padL}
              x2={trendSvg.w - trendSvg.padR}
              y1={trendSvg.yFor(r)}
              y2={trendSvg.yFor(r)}
              stroke="rgba(255,255,255,0.05)"
              strokeDasharray="4 4"
            />
            <text
              x={trendSvg.padL - 8}
              y={trendSvg.yFor(r) + 3}
              textAnchor="end"
              fill="#6b7280"
              fontSize="10"
            >
              {r}
            </text>
          </g>
        ))}
        {trendSvg.showSegregation && trendSvg.promoX != null && (
          <>
            <line
              x1={trendSvg.promoX}
              x2={trendSvg.promoX}
              y1={trendSvg.padT - 4}
              y2={trendSvg.h - trendSvg.padB}
              stroke="rgba(255,255,255,0.22)"
              strokeDasharray="3 4"
            />
            <text
              x={trendSvg.promoX}
              y={trendSvg.h - 10}
              textAnchor="middle"
              fill="#6b7280"
              fontSize="9"
            >
              Promotion
            </text>
            <text
              x={trendSvg.promoX - 12}
              y={16}
              textAnchor="end"
              fill="#9ca3af"
              fontSize="10"
            >
              Silver fleet
            </text>
            <text
              x={trendSvg.promoX + 12}
              y={16}
              textAnchor="start"
              fill="#fbbf24"
              fontSize="10"
            >
              Gold fleet
            </text>
          </>
        )}
        {!trendSvg.showSegregation && (
          <text
            x={trendSvg.w / 2}
            y={16}
            textAnchor="middle"
            fill={
              trendSvg.pts.every((p) => p.fleet === "Open")
                ? "#38bdf8"
                : trendSvg.pts.every((p) => p.fleet !== "Gold")
                  ? "#9ca3af"
                  : "#fbbf24"
            }
            fontSize="10"
          >
            {trendSvg.pts.every((p) => p.fleet === "Open")
              ? "ILCA 4"
              : trendSvg.pts.every((p) => p.fleet !== "Gold")
                ? "Silver fleet"
                : "Gold fleet"}
          </text>
        )}
        {trendSvg.silverPath ? (
          <path
            d={trendSvg.silverPath}
            fill="none"
            stroke={
              trendSvg.pts.every((p) => p.fleet === "Open")
                ? "rgba(56,189,248,0.9)"
                : "rgba(229,231,235,0.85)"
            }
            strokeWidth="2"
            strokeLinejoin="round"
            strokeLinecap="round"
          />
        ) : null}
        {trendSvg.goldPath ? (
          <path
            d={trendSvg.goldPath}
            fill="none"
            stroke="#f59e0b"
            strokeWidth="2"
            strokeLinejoin="round"
            strokeLinecap="round"
          />
        ) : null}
        {trendSvg.pts.map((p, i) => {
          const cx = trendSvg.xFor(i);
          const cy = trendSvg.yFor(p.rank);
          const labelAbove = cy > trendSvg.padT + 18;
          const labelY = labelAbove ? cy - 12 : cy + 16;
          const fill =
            p.fleet === "Gold"
              ? "#f59e0b"
              : p.fleet === "Open"
                ? "#38bdf8"
                : "#e5e7eb";
          const dns = Boolean(p.isDns);
          return (
            <g key={i}>
              <circle
                cx={cx}
                cy={cy}
                r={5}
                fill={dns ? "transparent" : fill}
                stroke={fill}
                strokeWidth={dns ? 2 : 2}
                strokeDasharray={dns ? "2 2" : undefined}
              >
                <title>
                  {p.name}:{" "}
                  {dns ? `DNS ${p.rank}*` : ordinal(p.rank)} ({p.date}) ·{" "}
                  {p.fleet}
                </title>
              </circle>
              <text
                x={cx}
                y={labelY}
                textAnchor="middle"
                fill={fill}
                fontSize="11"
                fontWeight="600"
              >
                {dns ? `${p.rank}*` : p.rank}
              </text>
            </g>
          );
        })}
      </svg>
    </div>
  );
}
