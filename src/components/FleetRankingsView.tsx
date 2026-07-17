"use client";

import { useEffect, useState } from "react";
import Link from "next/link";
import type { RankedSailor, Period } from "@/lib/ranking";
import { getPercentileBadge } from "@/lib/ranking";
import { Trophy, Calendar } from "lucide-react";

const PERIODS: { period: Period; label: string }[] = [
  { period: { year: 2026, half: "Jul-Dec" }, label: "Jul – Dec 2026 (Current)" },
  { period: { year: 2026, half: "Jan-Jun" }, label: "Jan – Jun 2026" },
  { period: { year: 2025, half: "Jul-Dec" }, label: "Jul – Dec 2025" },
  { period: { year: 2025, half: "Jan-Jun" }, label: "Jan – Jun 2025" },
  { period: { year: 2024, half: "Jul-Dec" }, label: "Jul – Dec 2024" },
  { period: { year: 2024, half: "Jan-Jun" }, label: "Jan – Jun 2024" },
];

function scoreCell(score: number | undefined, isDNS?: boolean) {
  if (score == null) return "—";
  if (isDNS) return `${score}*`;
  return String(score);
}

export function FleetRankingsView({
  fleet,
  initialPeriod,
}: {
  fleet: "Gold" | "Silver";
  initialPeriod?: Period;
}) {
  const [period, setPeriod] = useState<Period>(
    initialPeriod || { year: 2026, half: "Jul-Dec" }
  );
  const [ranked, setRanked] = useState<RankedSailor[]>([]);
  const [error, setError] = useState<string | null>(null);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    let cancelled = false;
    (async () => {
      setLoading(true);
      setError(null);
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

  return (
    <div className="mx-auto max-w-7xl px-4 sm:px-6 lg:px-8 py-8 sm:py-12 space-y-6">
      <div className="flex flex-col lg:flex-row lg:items-end justify-between gap-4">
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
              Best 3 of last 5 regattas · DNS = fleet size + 1 (shown as score*)
            </p>
          </div>
        </div>
        <div className="flex items-center gap-2">
          <Calendar className="h-4 w-4 text-orange-500 shrink-0" />
          <select
            value={`${period.year}|${period.half}`}
            onChange={(e) => {
              const [year, half] = e.target.value.split("|");
              setPeriod({ year: Number(year), half: half as Period["half"] });
            }}
            className="w-full sm:w-auto rounded-xl bg-slate-950 border border-white/10 px-4 py-2.5 text-sm text-white font-semibold"
          >
            {PERIODS.map(({ period: p, label }) => (
              <option key={`${p.year}-${p.half}`} value={`${p.year}|${p.half}`}>
                {label}
              </option>
            ))}
          </select>
        </div>
      </div>

      {loading && <p className="text-sm text-slate-500">Loading rankings…</p>}
      {error && (
        <div className="rounded-xl border border-rose-500/30 bg-rose-500/10 p-4 text-xs sm:text-sm text-rose-300">
          {error}{" "}
          <Link href="/api/health" className="underline font-bold">
            Check /api/health
          </Link>
        </div>
      )}
      {!loading && !error && ranked.length === 0 && (
        <p className="text-sm text-slate-500">
          No ranked sailors for this period. Import regattas and set fleet
          entry / current fleet in admin.
        </p>
      )}

      {/* Mobile cards */}
      <div className="md:hidden space-y-3">
        {ranked.map((s, i) => {
          const badge = getPercentileBadge(i + 1, ranked.length);
          const scores = [...(s.regattaScores || [])];
          while (scores.length < 5) {
            scores.push({
              regattaId: `pad-${scores.length}`,
              regattaName: "",
              score: NaN as unknown as number,
              isDNS: false,
            });
          }
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
                  {showSquad && (
                    <p className="text-[11px] text-orange-300/90 mt-1 font-semibold">
                      {s.nationalSquadStatus ||
                        s.natSquadStatusJul26 ||
                        "—"}
                    </p>
                  )}
                </div>
                <div className="text-right">
                  <p className="font-black text-white text-lg">{s.overallScore}</p>
                  <span
                    className={`text-[10px] font-bold px-2 py-0.5 rounded-full ${badge.className}`}
                  >
                    {badge.label}
                  </span>
                </div>
              </div>
              <div className="grid grid-cols-5 gap-1.5">
                {scores.slice(0, 5).map((rs, idx) => (
                  <div
                    key={rs.regattaId + idx}
                    className="rounded-lg bg-white/5 border border-white/5 px-1 py-1.5 text-center"
                    title={rs.regattaName || undefined}
                  >
                    <p className="text-[9px] text-slate-500 font-bold">R{idx + 1}</p>
                    <p className="text-xs font-mono font-bold text-white">
                      {Number.isFinite(rs.score)
                        ? scoreCell(rs.score, rs.isDNS)
                        : "—"}
                    </p>
                  </div>
                ))}
              </div>
              <p className="text-[10px] text-slate-500">
                Best 3: {s.bestThreeScores.join(" · ")}
              </p>
            </div>
          );
        })}
      </div>

      {/* Desktop table */}
      <div className="hidden md:block overflow-x-auto rounded-2xl border border-white/5">
        <table className="w-full text-left text-sm min-w-[640px]">
          <thead className="bg-white/5 text-[10px] text-slate-400 uppercase tracking-wider">
            <tr>
              <th className="px-4 lg:px-5 py-3 w-12">#</th>
              <th className="px-4 lg:px-5 py-3">Sailor</th>
              {showSquad && (
                <th className="px-4 lg:px-5 py-3">Squad</th>
              )}
              <th className="px-3 py-3 text-center">R1</th>
              <th className="px-3 py-3 text-center">R2</th>
              <th className="px-3 py-3 text-center">R3</th>
              <th className="px-3 py-3 text-center">R4</th>
              <th className="px-3 py-3 text-center">R5</th>
              <th className="px-4 lg:px-5 py-3 text-center">Best 3</th>
              <th className="px-4 lg:px-5 py-3 text-center">Overall</th>
              <th className="px-4 lg:px-5 py-3">Badge</th>
            </tr>
          </thead>
          <tbody>
            {ranked.map((s, i) => {
              const badge = getPercentileBadge(i + 1, ranked.length);
              const scores = [...(s.regattaScores || [])];
              while (scores.length < 5) {
                scores.push({
                  regattaId: `empty-${i}-${scores.length}`,
                  regattaName: "",
                  score: NaN as unknown as number,
                  isDNS: false,
                });
              }
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
                  {showSquad && (
                    <td className="px-4 lg:px-5 py-3.5">
                      {s.nationalSquadStatus || s.natSquadStatusJul26 ? (
                        <span className="rounded-full bg-orange-500/10 border border-orange-500/20 px-2 py-0.5 text-[10px] font-extrabold text-orange-400">
                          {s.nationalSquadStatus || s.natSquadStatusJul26}
                        </span>
                      ) : (
                        <span className="text-slate-600">—</span>
                      )}
                    </td>
                  )}
                  {scores.slice(0, 5).map((rs, idx) => (
                    <td
                      key={rs.regattaId + idx}
                      className="px-3 py-3.5 text-center font-mono text-xs text-slate-300"
                      title={
                        rs.regattaName
                          ? `${rs.regattaName}${rs.isDNS ? " (DNS)" : ""}`
                          : undefined
                      }
                    >
                      {Number.isFinite(rs.score)
                        ? scoreCell(rs.score, rs.isDNS)
                        : "—"}
                    </td>
                  ))}
                  <td className="px-4 lg:px-5 py-3.5 text-center font-mono text-xs text-slate-400">
                    {s.bestThreeScores.join(" · ")}
                  </td>
                  <td className="px-4 lg:px-5 py-3.5 text-center font-black text-white text-base">
                    {s.overallScore}
                  </td>
                  <td className="px-4 lg:px-5 py-3.5">
                    <span
                      className={`text-[10px] font-bold px-2 py-0.5 rounded-full ${badge.className}`}
                    >
                      {badge.label}
                    </span>
                  </td>
                </tr>
              );
            })}
          </tbody>
        </table>
        <p className="px-4 py-2 text-[10px] text-slate-600 border-t border-white/5">
          R1–R5 = last five eligible regattas (newest first). * = DNS score
          (fleet size + 1). Hover cells for regatta name.
        </p>
      </div>
    </div>
  );
}
