"use client";

import { useEffect, useMemo, useState } from "react";
import Link from "next/link";
import type { RankedSailor, Period } from "@/lib/ranking";
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
  if (score == null || !Number.isFinite(score)) return "—";
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
  // Prefer first ~18 chars of meaningful words
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
};

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

  /** R1–R5 slots shared across the fleet (same 5 most recent eligible events) */
  const eventSlots: Slot[] = useMemo(() => {
    const slots: Slot[] = [];
    for (let i = 0; i < 5; i++) {
      let name = "";
      let id = `slot-${i}`;
      for (const s of ranked) {
        const rs = s.regattaScores?.[i];
        if (rs?.regattaName) {
          name = rs.regattaName;
          id = rs.regattaId || id;
          break;
        }
      }
      slots.push({ regattaId: id, regattaName: name });
    }
    return slots;
  }, [ranked]);

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
              Best 3 of 5 · DNS = fleet size + 1 (shown as score*)
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

      {/* Sticky event legend — always visible while scrolling rankings */}
      {!loading && ranked.length > 0 && (
        <div className="sticky top-0 z-30 -mx-1 px-1">
          <div className="rounded-xl border border-white/10 bg-[#0c0d14]/95 backdrop-blur-md shadow-lg shadow-black/40 px-4 py-3">
            <p className="text-[10px] font-bold text-slate-500 uppercase tracking-wider mb-2">
              Scoring events (newest first)
            </p>
            <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-5 gap-2">
              {eventSlots.map((ev, idx) => (
                <div
                  key={ev.regattaId + idx}
                  className="rounded-lg bg-white/5 border border-white/5 px-2.5 py-2 min-h-[3.25rem]"
                >
                  <p className="text-[10px] font-black text-orange-400">R{idx + 1}</p>
                  <p
                    className="text-[11px] font-semibold text-slate-200 leading-snug line-clamp-2"
                    title={ev.regattaName || undefined}
                  >
                    {ev.regattaName || "— (no event yet)"}
                  </p>
                </div>
              ))}
            </div>
          </div>
        </div>
      )}

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
          No ranked sailors for this period. Import regattas and set fleet entry /
          current fleet in admin.
        </p>
      )}

      {/* Mobile cards */}
      <div className="md:hidden space-y-3">
        {ranked.map((s, i) => {
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
                      {s.nationalSquadStatus || s.natSquadStatusJul26 || "—"}
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
                {scores.map((rs, idx) => (
                  <div
                    key={rs.regattaId + idx}
                    className="rounded-lg bg-white/5 border border-white/5 px-1 py-1.5 text-center"
                    title={rs.regattaName || eventSlots[idx]?.regattaName || undefined}
                  >
                    <p className="text-[9px] text-orange-400/90 font-black">
                      R{idx + 1}
                    </p>
                    <p
                      className="text-[8px] text-slate-500 leading-tight line-clamp-2 min-h-[1.5rem]"
                      title={
                        rs.regattaName || eventSlots[idx]?.regattaName || undefined
                      }
                    >
                      {shortRegattaName(
                        rs.regattaName || eventSlots[idx]?.regattaName,
                        idx
                      )}
                    </p>
                    <p className="text-xs font-mono font-bold text-white mt-0.5">
                      {Number.isFinite(rs.score)
                        ? scoreCell(rs.score, rs.isDNS)
                        : "—"}
                    </p>
                  </div>
                ))}
              </div>
            </div>
          );
        })}
      </div>

      {/* Desktop table — sticky column headers */}
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
                  <th className="sticky top-0 z-20 px-4 lg:px-5 py-3 bg-[#12141c] border-b border-white/10 shadow-[0_1px_0_0_rgba(255,255,255,0.06)]">
                    Squad
                  </th>
                )}
                {eventSlots.map((ev, idx) => (
                  <th
                    key={ev.regattaId + idx}
                    className="sticky top-0 z-20 px-2 py-2 text-center bg-[#12141c] border-b border-white/10 shadow-[0_1px_0_0_rgba(255,255,255,0.06)] max-w-[7.5rem]"
                    title={ev.regattaName || `R${idx + 1}`}
                  >
                    <span className="block text-orange-400 font-black normal-case tracking-normal">
                      R{idx + 1}
                    </span>
                    <span className="block text-[9px] font-semibold text-slate-400 normal-case tracking-normal leading-tight mt-0.5 line-clamp-2">
                      {shortRegattaName(ev.regattaName, idx)}
                    </span>
                  </th>
                ))}
                <th className="sticky top-0 z-20 px-4 lg:px-5 py-3 text-center bg-[#12141c] border-b border-white/10 shadow-[0_1px_0_0_rgba(255,255,255,0.06)]">
                  Best 3 of 5
                </th>
              </tr>
            </thead>
            <tbody>
              {ranked.map((s, i) => {
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
                        {s.nationalSquadStatus || s.natSquadStatusJul26 ? (
                          <span className="rounded-full bg-orange-500/10 border border-orange-500/20 px-2 py-0.5 text-[10px] font-extrabold text-orange-400">
                            {s.nationalSquadStatus || s.natSquadStatusJul26}
                          </span>
                        ) : (
                          <span className="text-slate-600">—</span>
                        )}
                      </td>
                    )}
                    {scores.map((rs, idx) => (
                      <td
                        key={rs.regattaId + idx}
                        className="px-3 py-3.5 text-center font-mono text-xs text-slate-300"
                        title={
                          rs.regattaName || eventSlots[idx]?.regattaName
                            ? `${rs.regattaName || eventSlots[idx]?.regattaName}${
                                rs.isDNS ? " (DNS)" : ""
                              }`
                            : undefined
                        }
                      >
                        {Number.isFinite(rs.score)
                          ? scoreCell(rs.score, rs.isDNS)
                          : "—"}
                      </td>
                    ))}
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
          R1–R5 = last five eligible regattas for this fleet (newest first) — see sticky
          legend and column subtitles. Best 3 of 5 = sum of the three best (lowest)
          scores. * = DNS (fleet size + 1).
        </p>
      </div>
    </div>
  );
}
