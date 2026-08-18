"use client";

import { useMemo, useState } from "react";
import { birthYear } from "@/lib/age";

import Link from "next/link";
import {
  ArrowRight,
  ArrowUpDown,
  ArrowUp,
  ArrowDown,
  Trophy,
} from "lucide-react";
import { formatYearsDisplay } from "@/lib/seriesMembership";

type GoldSailor = {
  id: string;
  name: string;
  handle: string;
  sailNumber: string;
  dob?: string | null;
  gender?: string | null;
  dropDate?: string | null;
  goldEntryDate?: string | null;
  currentFleet?: string | null;
  natSquadStatusJan25?: string | null;
  natSquadStatusJul25?: string | null;
  natSquadStatusJan26?: string | null;
  natSquadStatusJul26?: string | null;
  natSquadStatusJan27?: string | null;
  natSquadStatusJul27?: string | null;
  histRankingJun24?: number | null;
  histRankingDec24?: number | null;
  histRankingJun25?: number | null;
  histRankingDec25?: number | null;
  histRankingJun26?: number | null;
  worlds?: string | number | null;
  european?: string | number | null;
  asian?: string | number | null;
  seaGames?: string | number | null;
};

type SortKey =
  | "name"
  | "sailNumber"
  | "birthYear"
  | "natSquadStatusJan25"
  | "natSquadStatusJul25"
  | "natSquadStatusJan26"
  | "natSquadStatusJul26"
  | "natSquadStatusJan27"
  | "natSquadStatusJul27"
  | "histRankingJun24"
  | "histRankingDec24"
  | "histRankingJun25"
  | "histRankingDec25"
  | "histRankingJun26"
  | "worlds"
  | "european"
  | "asian"
  | "seaGames";

function birthYearOf(dob?: string | null) {
  return birthYear(dob);
}

function SortIcon({
  active,
  dir,
}: {
  active: boolean;
  dir: "asc" | "desc";
}) {
  if (!active) return <ArrowUpDown className="h-3 w-3 opacity-40 shrink-0" />;
  return dir === "asc" ? (
    <ArrowUp className="h-3 w-3 text-orange-400 shrink-0" />
  ) : (
    <ArrowDown className="h-3 w-3 text-orange-400 shrink-0" />
  );
}

function Th({
  label,
  sortKey,
  current,
  dir,
  onSort,
  className = "",
}: {
  label: string;
  sortKey: SortKey;
  current: SortKey;
  dir: "asc" | "desc";
  onSort: (k: SortKey) => void;
  className?: string;
}) {
  return (
    <th className={className}>
      <button
        type="button"
        onClick={() => onSort(sortKey)}
        className="inline-flex w-full items-center justify-center gap-0.5 hover:text-white transition-colors uppercase tracking-wider"
      >
        <span className="leading-tight">{label}</span>
        <SortIcon active={current === sortKey} dir={dir} />
      </button>
    </th>
  );
}

/** Shared cell chrome so group headers, sub-headers, and body stay aligned */
const CELL = {
  name: "w-[11rem] min-w-[11rem] max-w-[11rem]",
  sail: "w-[6.5rem] min-w-[6.5rem]",
  birth: "w-[6.5rem] min-w-[6.5rem]",
  squad: "w-[4.5rem] min-w-[4.5rem]",
  rank: "w-[4rem] min-w-[4rem]",
  years: "w-[4.5rem] min-w-[4.5rem]",
  action: "w-[6.5rem] min-w-[6.5rem]",
} as const;

export function GoldSailorsRegister({ sailors }: { sailors: GoldSailor[] }) {
  const [sortKey, setSortKey] = useState<SortKey>("name");
  const [sortDir, setSortDir] = useState<"asc" | "desc">("asc");

  const onSort = (k: SortKey) => {
    if (sortKey === k) setSortDir((d) => (d === "asc" ? "desc" : "asc"));
    else {
      setSortKey(k);
      setSortDir("asc");
    }
  };

  const sorted = useMemo(() => {
    const rows = [...sailors];
    const dir = sortDir === "asc" ? 1 : -1;
    rows.sort((a, b) => {
      const av = (() => {
        if (sortKey === "name") return a.name || "";
        if (sortKey === "sailNumber") return a.sailNumber || "";
        if (sortKey === "birthYear") return birthYearOf(a.dob) ?? 9999;
        const raw = (a as Record<string, unknown>)[sortKey];
        if (raw == null || raw === "") return sortDir === "asc" ? 99999 : -1;
        if (typeof raw === "number") return raw;
        return String(raw);
      })();
      const bv = (() => {
        if (sortKey === "name") return b.name || "";
        if (sortKey === "sailNumber") return b.sailNumber || "";
        if (sortKey === "birthYear") return birthYearOf(b.dob) ?? 9999;
        const raw = (b as Record<string, unknown>)[sortKey];
        if (raw == null || raw === "") return sortDir === "asc" ? 99999 : -1;
        if (typeof raw === "number") return raw;
        return String(raw);
      })();
      if (typeof av === "number" && typeof bv === "number") {
        if (av !== bv) return (av - bv) * dir;
      } else {
        const cmp = String(av).localeCompare(String(bv), undefined, {
          numeric: true,
          sensitivity: "base",
        });
        if (cmp !== 0) return cmp * dir;
      }
      return a.name.localeCompare(b.name);
    });
    return rows;
  }, [sailors, sortKey, sortDir]);

  return (
    <div className="flex-1 bg-[#090a0f] py-6 sm:py-10 lg:py-12 overflow-x-clip">
      <div className="mx-auto max-w-[95%] px-3 sm:px-6 lg:px-8 min-w-0">
        <div className="flex flex-col md:flex-row md:items-center justify-between gap-4 sm:gap-6 border-b border-white/5 pb-6 sm:pb-8 mb-6 sm:mb-10">
          <div>
            <h1 className="text-3xl font-extrabold text-white sm:text-4xl tracking-tight flex items-center gap-3">
              <Trophy className="h-8 w-8 text-yellow-500" />
              All Gold Fleet Sailors
            </h1>
            <p className="mt-2 text-sm text-slate-400 max-w-2xl">
              Superadmin only — Singapore Optimist Gold Fleet sailor register.
              Historical rankings, squad periods, and overseas years are edited
              in Admin → Database → Sailors (or bulk import).
            </p>
            <p className="mt-2 text-[11px] text-slate-600">
              Click any column header to sort. Tap a sailor name to open their
              profile.
            </p>
          </div>

          <div className="bg-[#131520] border border-white/5 px-6 py-3 rounded-2xl flex items-center gap-3">
            <span className="text-2xl font-black text-yellow-500">
              {sailors.length}
            </span>
            <span className="text-xs text-slate-400 font-bold uppercase tracking-wider">
              Total Gold
              <br />
              Sailors
            </span>
          </div>
        </div>

        <div className="glass-panel rounded-3xl border border-white/5 overflow-hidden shadow-2xl">
          <div className="overflow-x-auto max-h-[min(80vh,920px)] overflow-y-auto">
            {/*
              Fixed column widths + correct group colspans keep headers and
              body cells aligned (previously National Squad was colSpan=4
              over 6 sub-columns).
            */}
            <table className="border-collapse text-xs table-fixed w-max min-w-full">
              <colgroup>
                <col className={CELL.name} />
                <col className={CELL.sail} />
                <col className={CELL.birth} />
                {Array.from({ length: 6 }).map((_, i) => (
                  <col key={`s${i}`} className={CELL.squad} />
                ))}
                {Array.from({ length: 5 }).map((_, i) => (
                  <col key={`r${i}`} className={CELL.rank} />
                ))}
                {Array.from({ length: 4 }).map((_, i) => (
                  <col key={`y${i}`} className={CELL.years} />
                ))}
                <col className={CELL.action} />
              </colgroup>
              <thead>
                <tr className="text-[9px] font-black text-slate-500 uppercase tracking-widest text-center">
                  <th
                    colSpan={3}
                    className="sticky top-0 z-30 py-2 px-2 border-b border-r border-white/10 text-left bg-[#0e1018] shadow-[0_1px_0_0_rgba(255,255,255,0.06)]"
                  >
                    Competitor
                  </th>
                  <th
                    colSpan={6}
                    className="sticky top-0 z-30 py-2 px-2 border-b border-r border-white/10 bg-[#16120e] text-orange-400 shadow-[0_1px_0_0_rgba(255,255,255,0.06)]"
                  >
                    National Squad History
                  </th>
                  <th
                    colSpan={5}
                    className="sticky top-0 z-30 py-2 px-2 border-b border-r border-white/10 bg-[#0e1520] text-blue-400 shadow-[0_1px_0_0_rgba(255,255,255,0.06)]"
                  >
                    Historical Rankings
                  </th>
                  <th
                    colSpan={4}
                    className="sticky top-0 z-30 py-2 px-2 border-b border-r border-white/10 bg-[#0e1a14] text-emerald-400 shadow-[0_1px_0_0_rgba(255,255,255,0.06)]"
                  >
                    Overseas Representation
                  </th>
                  <th
                    colSpan={1}
                    className="sticky top-0 z-30 py-2 px-2 border-b border-white/10 bg-[#0e1018] shadow-[0_1px_0_0_rgba(255,255,255,0.06)]"
                  >
                    Profile
                  </th>
                </tr>
                <tr className="text-[9px] font-extrabold text-slate-400 uppercase tracking-wider">
                  <Th
                    label="Sailor Name"
                    sortKey="name"
                    current={sortKey}
                    dir={sortDir}
                    onSort={onSort}
                    className="sticky top-7 z-20 py-2.5 px-2 text-left bg-[#12141c] border-b border-white/10"
                  />
                  <Th
                    label="Sail #"
                    sortKey="sailNumber"
                    current={sortKey}
                    dir={sortDir}
                    onSort={onSort}
                    className="sticky top-7 z-20 py-2.5 px-1 text-center bg-[#12141c] border-b border-white/10"
                  />
                  <Th
                    label="YOB / G"
                    sortKey="birthYear"
                    current={sortKey}
                    dir={sortDir}
                    onSort={onSort}
                    className="sticky top-7 z-20 py-2.5 px-1 text-center border-r border-white/10 bg-[#12141c] border-b"
                  />

                  <Th
                    label="Jan 25"
                    sortKey="natSquadStatusJan25"
                    current={sortKey}
                    dir={sortDir}
                    onSort={onSort}
                    className="sticky top-7 z-20 py-2.5 px-1 text-center bg-[#1a1610] border-b border-white/10"
                  />
                  <Th
                    label="Jul 25"
                    sortKey="natSquadStatusJul25"
                    current={sortKey}
                    dir={sortDir}
                    onSort={onSort}
                    className="sticky top-7 z-20 py-2.5 px-1 text-center bg-[#1a1610] border-b border-white/10"
                  />
                  <Th
                    label="Jan 26"
                    sortKey="natSquadStatusJan26"
                    current={sortKey}
                    dir={sortDir}
                    onSort={onSort}
                    className="sticky top-7 z-20 py-2.5 px-1 text-center bg-[#1a1610] border-b border-white/10"
                  />
                  <Th
                    label="Jul 26"
                    sortKey="natSquadStatusJul26"
                    current={sortKey}
                    dir={sortDir}
                    onSort={onSort}
                    className="sticky top-7 z-20 py-2.5 px-1 text-center bg-[#1a1610] border-b border-white/10"
                  />
                  <Th
                    label="Jan 27"
                    sortKey="natSquadStatusJan27"
                    current={sortKey}
                    dir={sortDir}
                    onSort={onSort}
                    className="sticky top-7 z-20 py-2.5 px-1 text-center bg-[#1a1610] border-b border-white/10 text-sky-300"
                  />
                  <Th
                    label="Jul 27"
                    sortKey="natSquadStatusJul27"
                    current={sortKey}
                    dir={sortDir}
                    onSort={onSort}
                    className="sticky top-7 z-20 py-2.5 px-1 text-center border-r border-white/10 bg-[#1a1610] border-b"
                  />

                  <Th
                    label="Jun 24"
                    sortKey="histRankingJun24"
                    current={sortKey}
                    dir={sortDir}
                    onSort={onSort}
                    className="sticky top-7 z-20 py-2.5 px-1 text-center bg-[#101820] border-b border-white/10"
                  />
                  <Th
                    label="Dec 24"
                    sortKey="histRankingDec24"
                    current={sortKey}
                    dir={sortDir}
                    onSort={onSort}
                    className="sticky top-7 z-20 py-2.5 px-1 text-center bg-[#101820] border-b border-white/10"
                  />
                  <Th
                    label="Jun 25"
                    sortKey="histRankingJun25"
                    current={sortKey}
                    dir={sortDir}
                    onSort={onSort}
                    className="sticky top-7 z-20 py-2.5 px-1 text-center bg-[#101820] border-b border-white/10"
                  />
                  <Th
                    label="Dec 25"
                    sortKey="histRankingDec25"
                    current={sortKey}
                    dir={sortDir}
                    onSort={onSort}
                    className="sticky top-7 z-20 py-2.5 px-1 text-center bg-[#101820] border-b border-white/10"
                  />
                  <Th
                    label="Jun 26"
                    sortKey="histRankingJun26"
                    current={sortKey}
                    dir={sortDir}
                    onSort={onSort}
                    className="sticky top-7 z-20 py-2.5 px-1 text-center border-r border-white/10 bg-[#101820] border-b"
                  />

                  <Th
                    label="Worlds"
                    sortKey="worlds"
                    current={sortKey}
                    dir={sortDir}
                    onSort={onSort}
                    className="sticky top-7 z-20 py-2.5 px-1 text-center bg-[#101a14] border-b border-white/10"
                  />
                  <Th
                    label="European"
                    sortKey="european"
                    current={sortKey}
                    dir={sortDir}
                    onSort={onSort}
                    className="sticky top-7 z-20 py-2.5 px-1 text-center bg-[#101a14] border-b border-white/10"
                  />
                  <Th
                    label="Asian"
                    sortKey="asian"
                    current={sortKey}
                    dir={sortDir}
                    onSort={onSort}
                    className="sticky top-7 z-20 py-2.5 px-1 text-center bg-[#101a14] border-b border-white/10"
                  />
                  <Th
                    label="SEA"
                    sortKey="seaGames"
                    current={sortKey}
                    dir={sortDir}
                    onSort={onSort}
                    className="sticky top-7 z-20 py-2.5 px-1 text-center border-r border-white/10 bg-[#101a14] border-b"
                  />

                  <th className="sticky top-7 z-20 py-2.5 px-2 text-center bg-[#12141c] border-b border-white/10">
                    Action
                  </th>
                </tr>
              </thead>
              <tbody className="divide-y divide-white/5 font-semibold text-slate-300">
                {sorted.map((sailor) => {
                  const by = birthYearOf(sailor.dob);
                  const isDropped = sailor.dropDate != null;

                  return (
                    <tr
                      key={sailor.id}
                      className={`hover:bg-white/5 transition-colors text-center ${
                        isDropped ? "opacity-60 bg-slate-950/20" : ""
                      }`}
                    >
                      <td className="py-3 px-2 text-left font-bold text-white truncate">
                        <Link
                          href={`/${sailor.handle}`}
                          className="hover:text-orange-500 transition-colors"
                          title={sailor.name}
                        >
                          {sailor.name}
                        </Link>
                      </td>
                      <td className="py-3 px-1 font-mono text-slate-400 truncate">
                        {sailor.sailNumber}
                      </td>
                      <td className="py-3 px-1 text-slate-400 border-r border-white/5">
                        {by ?? "—"}/{sailor.gender === "F" || sailor.gender === "M" ? sailor.gender : "—"}
                      </td>

                      <td className="py-3 px-1 bg-orange-600/5 text-[10px] text-slate-400">
                        {sailor.natSquadStatusJan25 || "—"}
                      </td>
                      <td className="py-3 px-1 bg-orange-600/5 text-[10px] text-slate-400">
                        {sailor.natSquadStatusJul25 || "—"}
                      </td>
                      <td className="py-3 px-1 bg-orange-600/5 text-[10px] text-slate-400">
                        {sailor.natSquadStatusJan26 || "—"}
                      </td>
                      <td className="py-3 px-1 bg-orange-600/5 text-[10px] text-slate-400">
                        {sailor.natSquadStatusJul26 || "—"}
                      </td>
                      <td className="py-3 px-1 bg-sky-600/5">
                        {sailor.natSquadStatusJan27 ? (
                          <span className="rounded-full bg-sky-500/10 border border-sky-500/20 px-1.5 py-0.5 text-[10px] text-sky-300 font-extrabold">
                            {sailor.natSquadStatusJan27}
                          </span>
                        ) : (
                          <span className="text-slate-500">—</span>
                        )}
                      </td>
                      <td className="py-3 px-1 border-r border-white/5 bg-orange-600/5 text-[10px] text-slate-400">
                        {sailor.natSquadStatusJul27 || "—"}
                      </td>

                      <td className="py-3 px-1 bg-blue-600/5 font-mono text-slate-400">
                        {sailor.histRankingJun24 ?? "—"}
                      </td>
                      <td className="py-3 px-1 bg-blue-600/5 font-mono text-slate-400">
                        {sailor.histRankingDec24 ?? "—"}
                      </td>
                      <td className="py-3 px-1 bg-blue-600/5 font-mono text-slate-400">
                        {sailor.histRankingJun25 ?? "—"}
                      </td>
                      <td className="py-3 px-1 bg-blue-600/5 font-mono text-slate-400">
                        {sailor.histRankingDec25 ?? "—"}
                      </td>
                      <td className="py-3 px-1 border-r border-white/5 bg-blue-600/5 font-mono font-bold text-white">
                        {sailor.histRankingJun26 ?? "—"}
                      </td>

                      <td className="py-3 px-1 bg-emerald-600/5 font-mono text-emerald-400 text-[11px]">
                        {formatYearsDisplay(sailor.worlds)}
                      </td>
                      <td className="py-3 px-1 bg-emerald-600/5 font-mono text-emerald-400 text-[11px]">
                        {formatYearsDisplay(sailor.european)}
                      </td>
                      <td className="py-3 px-1 bg-emerald-600/5 font-mono text-emerald-400 text-[11px]">
                        {formatYearsDisplay(sailor.asian)}
                      </td>
                      <td className="py-3 px-1 border-r border-white/5 bg-emerald-600/5 font-mono text-emerald-400 text-[11px]">
                        {formatYearsDisplay(sailor.seaGames)}
                      </td>

                      <td className="py-3 px-2 text-center">
                        <Link
                          href={`/${sailor.handle}`}
                          className="inline-flex items-center gap-1 rounded-full bg-white/5 border border-white/10 hover:border-orange-500/40 px-2.5 py-1 text-[10px] font-bold text-slate-300 hover:text-white transition-all"
                        >
                          Profile
                          <ArrowRight className="h-3 w-3" />
                        </Link>
                      </td>
                    </tr>
                  );
                })}
              </tbody>
            </table>
          </div>
        </div>
      </div>
    </div>
  );
}
