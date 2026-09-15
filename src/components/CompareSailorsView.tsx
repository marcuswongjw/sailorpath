"use client";

import { useEffect, useState } from "react";
import Link from "next/link";
import type { Period, RankedSailor } from "@/lib/ranking";
import {
  currentPeriodFromSgToday,
  rankingPeriodOptions,
} from "@/lib/datesSg";
import { GitCompareArrows } from "lucide-react";

const PERIODS = rankingPeriodOptions(4);
const DEFAULT_PERIOD = currentPeriodFromSgToday();

function scoreCell(s?: { score: number; isDNS?: boolean; isOverseasCommitment?: boolean }) {
  if (!s || !Number.isFinite(s.score)) return "—";
  if (s.isOverseasCommitment) return `${s.score}†`;
  if (s.isDNS) return `${s.score}*`;
  return String(s.score);
}

export function CompareSailorsView({
  initialFleet = "Gold",
  initialYear,
  initialHalf,
  initialA,
  initialB,
}: {
  initialFleet?: "Gold" | "Silver";
  initialYear?: number;
  initialHalf?: Period["half"];
  initialA?: string;
  initialB?: string;
}) {
  const [fleet, setFleet] = useState<"Gold" | "Silver">(initialFleet);
  const [period, setPeriod] = useState<Period>(() => {
    if (initialYear != null && initialHalf) {
      return { year: initialYear, half: initialHalf };
    }
    return DEFAULT_PERIOD;
  });
  const [ranked, setRanked] = useState<RankedSailor[]>([]);
  const [aId, setAId] = useState(initialA || "");
  const [bId, setBId] = useState(initialB || "");
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<string | null>(null);

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
        if (!res.ok) throw new Error(data.error || "Failed");
        if (!cancelled) {
          setRanked(data.ranked || []);
          if (!aId && data.ranked?.[0]) setAId(data.ranked[0].id);
          if (!bId && data.ranked?.[1]) setBId(data.ranked[1].id);
        }
      } catch (e) {
        if (!cancelled) setError(e instanceof Error ? e.message : "Error");
      } finally {
        if (!cancelled) setLoading(false);
      }
    })();
    return () => {
      cancelled = true;
    };
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [fleet, period.year, period.half]);

  const a = ranked.find((s) => s.id === aId);
  const b = ranked.find((s) => s.id === bId);

  return (
    <div className="mx-auto max-w-5xl px-4 py-10 space-y-6">
      <div className="flex items-start gap-3">
        <span className="flex h-10 w-10 items-center justify-center rounded-xl bg-[var(--sp-racing-orange)]/10 text-[var(--sp-racing-orange)] border border-[var(--sp-racing-orange)]/20">
          <GitCompareArrows className="h-5 w-5" />
        </span>
        <div>
          <h1 className="text-2xl sm:text-3xl font-black text-[var(--sp-harbour-shadow)] tracking-tight">
            Compare sailors
          </h1>
          <p className="text-xs text-[var(--sp-charcoal-slate)] mt-1">
            Side-by-side R1–R5 and Best 3 of 5 for a ranking period.
          </p>
        </div>
      </div>

      <div className="rounded-2xl border border-[var(--sp-cool-veil)] bg-[var(--sp-warm-white)] p-4 grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-3 shadow-xs">
        <label className="text-[10px] font-bold text-[var(--sp-slate-soft)] uppercase">
          Fleet
          <select
            value={fleet}
            onChange={(e) => setFleet(e.target.value as "Gold" | "Silver")}
            className="mt-1 w-full rounded-lg bg-[var(--sp-sailcloth)] border border-[var(--sp-cool-veil)] px-3 py-2 text-xs text-[var(--sp-harbour-shadow)] font-medium outline-none focus:border-[var(--sp-harbour-teal)]"
          >
            <option value="Gold">Gold</option>
            <option value="Silver">Silver</option>
          </select>
        </label>
        <label className="text-[10px] font-bold text-[var(--sp-slate-soft)] uppercase">
          Period
          <select
            value={`${period.year}|${period.half}`}
            onChange={(e) => {
              const [year, half] = e.target.value.split("|");
              setPeriod({ year: Number(year), half: half as Period["half"] });
            }}
            className="mt-1 w-full rounded-lg bg-[var(--sp-sailcloth)] border border-[var(--sp-cool-veil)] px-3 py-2 text-xs text-[var(--sp-harbour-shadow)] font-medium outline-none focus:border-[var(--sp-harbour-teal)]"
          >
            {PERIODS.map(({ period: p, label }) => (
              <option key={`${p.year}-${p.half}`} value={`${p.year}|${p.half}`}>
                {label}
              </option>
            ))}
          </select>
        </label>
        <label className="text-[10px] font-bold text-[var(--sp-slate-soft)] uppercase">
          Sailor A
          <select
            value={aId}
            onChange={(e) => setAId(e.target.value)}
            className="mt-1 w-full rounded-lg bg-[var(--sp-sailcloth)] border border-[var(--sp-cool-veil)] px-3 py-2 text-xs text-[var(--sp-harbour-shadow)] font-medium outline-none focus:border-[var(--sp-harbour-teal)]"
          >
            <option value="">—</option>
            {ranked.map((s) => (
              <option key={s.id} value={s.id}>
                {s.name}
              </option>
            ))}
          </select>
        </label>
        <label className="text-[10px] font-bold text-[var(--sp-slate-soft)] uppercase">
          Sailor B
          <select
            value={bId}
            onChange={(e) => setBId(e.target.value)}
            className="mt-1 w-full rounded-lg bg-[var(--sp-sailcloth)] border border-[var(--sp-cool-veil)] px-3 py-2 text-xs text-[var(--sp-harbour-shadow)] font-medium outline-none focus:border-[var(--sp-harbour-teal)]"
          >
            <option value="">—</option>
            {ranked.map((s) => (
              <option key={s.id} value={s.id}>
                {s.name}
              </option>
            ))}
          </select>
        </label>
      </div>

      {loading && <p className="text-sm text-[var(--sp-slate-soft)]">Loading…</p>}
      {error && <p className="text-sm text-rose-600 font-medium">{error}</p>}

      {!loading && a && b && (
        <div className="overflow-x-auto rounded-2xl border border-[var(--sp-cool-veil)] bg-[var(--sp-warm-white)] shadow-xs">
          <table className="w-full text-sm text-left min-w-[560px]">
            <thead className="bg-[var(--sp-sailcloth)] text-[10px] uppercase text-[var(--sp-slate-soft)] font-semibold border-b border-[var(--sp-cool-veil)]">
              <tr>
                <th className="px-4 py-3">Metric</th>
                <th className="px-4 py-3">
                  <Link href={`/${a.handle}`} className="text-[var(--sp-harbour-shadow)] font-bold hover:text-[var(--sp-racing-orange)] normal-case text-sm">
                    {a.name}
                  </Link>
                </th>
                <th className="px-4 py-3">
                  <Link href={`/${b.handle}`} className="text-[var(--sp-harbour-shadow)] font-bold hover:text-[var(--sp-racing-orange)] normal-case text-sm">
                    {b.name}
                  </Link>
                </th>
              </tr>
            </thead>
            <tbody className="text-[var(--sp-charcoal-slate)]">
              <tr className="border-t border-[var(--sp-cool-veil)]">
                <td className="px-4 py-3 text-[var(--sp-slate-soft)] text-xs font-bold uppercase">Overall rank</td>
                <td className="px-4 py-3 font-black text-[var(--sp-racing-orange)]">
                  #{ranked.findIndex((s) => s.id === a.id) + 1}
                </td>
                <td className="px-4 py-3 font-black text-[var(--sp-racing-orange)]">
                  #{ranked.findIndex((s) => s.id === b.id) + 1}
                </td>
              </tr>
              <tr className="border-t border-[var(--sp-cool-veil)]">
                <td className="px-4 py-3 text-[var(--sp-slate-soft)] text-xs font-bold uppercase">Best 3 of 5</td>
                <td className="px-4 py-3 font-black text-[var(--sp-harbour-shadow)] text-lg">{a.overallScore}</td>
                <td className="px-4 py-3 font-black text-[var(--sp-harbour-shadow)] text-lg">{b.overallScore}</td>
              </tr>
              <tr className="border-t border-[var(--sp-cool-veil)]">
                <td className="px-4 py-3 text-[var(--sp-slate-soft)] text-xs font-bold uppercase">Fleet / squad</td>
                <td className="px-4 py-3">
                  {a.fleet}
                  {a.nationalSquadStatus ? ` · ${a.nationalSquadStatus}` : ""}
                </td>
                <td className="px-4 py-3">
                  {b.fleet}
                  {b.nationalSquadStatus ? ` · ${b.nationalSquadStatus}` : ""}
                </td>
              </tr>
              {[0, 1, 2, 3, 4].map((i) => (
                <tr key={i} className="border-t border-[var(--sp-cool-veil)]">
                  <td className="px-4 py-3 text-[var(--sp-slate-soft)] text-xs font-bold uppercase">
                    R{i + 1}
                    <span className="block normal-case font-semibold text-[10px] text-[var(--sp-slate-soft)] max-w-[10rem] truncate">
                      {a.regattaScores?.[i]?.regattaName ||
                        b.regattaScores?.[i]?.regattaName ||
                        "—"}
                    </span>
                  </td>
                  <td className="px-4 py-3 font-mono font-medium">
                    {scoreCell(a.regattaScores?.[i])}
                  </td>
                  <td className="px-4 py-3 font-mono font-medium">
                    {scoreCell(b.regattaScores?.[i])}
                  </td>
                </tr>
              ))}
            </tbody>
          </table>
          <p className="px-4 py-2 text-[10px] text-[var(--sp-slate-soft)] border-t border-[var(--sp-cool-veil)] bg-[var(--sp-sailcloth)]/30">
            * DNS · † Overseas commitment
          </p>
        </div>
      )}

      {!loading && (!a || !b) && ranked.length > 0 && (
        <p className="text-sm text-slate-500">Select two sailors to compare.</p>
      )}
    </div>
  );
}
