"use client";

import { useState } from "react";
import Link from "next/link";
import { birthYear } from "@/lib/age";
import { formatGenderLabel } from "@/lib/gender";
import { getPercentileBadge } from "@/lib/ranking";
import { RankMedalBadge } from "@/components/ui/RankMedalBadge";
import type { getResultsForRegatta } from "@/lib/queries";
import type { OfficialRaceResultInput } from "@/types/raceResult";

type PublicRegattaResult = Awaited<
  ReturnType<typeof getResultsForRegatta>
>[number];

type Props = {
  results: PublicRegattaResult[];
  totalFleetSize: number;
  raceCount?: number | null;
  accent: "orange" | "sky";
};

type SortKey = "rank" | "name" | "nationality" | "gender" | "birthYear" | "total" | "nett";
type SortDir = "asc" | "desc";

const accentClasses = {
  orange: {
    rank: "text-[var(--sp-racing-orange)]",
    link: "hover:text-[var(--sp-racing-orange)]",
  },
  sky: {
    rank: "text-[var(--sp-harbour-teal)]",
    link: "hover:text-[var(--sp-harbour-teal)]",
  },
} as const;

/** Row background tints for top 3 */
function podiumRowClass(rank: number | null | undefined): string {
  if (rank === 1) return "bg-[#FFF9DB]/70";
  if (rank === 2) return "bg-[#F5F5F5]/80";
  if (rank === 3) return "bg-[#FBF2E7]/70";
  return "";
}

function raceValue(race: OfficialRaceResultInput | undefined) {
  if (!race) return "—";
  return race.rawValue || String(race.score);
}

function raceValueClass(race: OfficialRaceResultInput | undefined) {
  if (!race) return "text-[var(--sp-charcoal-slate)]";
  if (race.discarded) return "text-[var(--sp-charcoal)] line-through";
  if (race.scoringCode) return "text-amber-800 font-bold bg-amber-50 rounded px-1";
  return "text-[var(--sp-charcoal-slate)]";
}

function MobileRaceScores({ races }: { races: OfficialRaceResultInput[] }) {
  if (races.length === 0) return null;
  return (
    <details open={races.length <= 8} className="group rounded-xl border border-[var(--sp-cool-veil)] bg-[var(--sp-sailcloth)]">
      <summary className="cursor-pointer list-none px-3 py-2 text-[11px] font-semibold text-[var(--sp-harbour-teal)] marker:content-none flex items-center justify-between">
        <span className="inline-flex items-center gap-1.5">
          <span aria-hidden className="transition-transform group-open:rotate-90">›</span>
          <span>{races.length} published race score{races.length === 1 ? "" : "s"}</span>
        </span>
        <span className="text-[10px] text-[var(--sp-slate-soft)] font-normal group-open:hidden">Tap to expand</span>
      </summary>
      <div className="grid grid-cols-3 gap-1.5 border-t border-[var(--sp-cool-veil)] p-2.5">
        {races.map((race) => (
          <div key={race.raceNumber} className="rounded-lg bg-[var(--sp-warm-white)] border border-[var(--sp-cool-veil)] px-2 py-1.5 text-center">
            <p className="text-[9px] font-semibold uppercase text-[var(--sp-slate-soft)]">R{race.raceNumber}</p>
            <p className={`text-xs font-bold tabular-nums ${raceValueClass(race)}`}>
              {raceValue(race)}
            </p>
          </div>
        ))}
      </div>
    </details>
  );
}

/** Sort indicator shown inside column headers */
function SortIcon({ active, dir }: { active: boolean; dir: SortDir }) {
  return (
    <span
      aria-hidden
      className={`ml-1 inline-block text-[10px] leading-none transition-opacity ${active ? "opacity-100" : "opacity-30"}`}
    >
      {active ? (dir === "asc" ? "▲" : "▼") : "⇅"}
    </span>
  );
}

export function PublicRegattaResults({
  results,
  totalFleetSize,
  accent,
}: Props) {
  const colors = accentClasses[accent];

  const importedRaceCount = results.reduce(
    (max, result) =>
      Math.max(max, ...result.raceResults.map((race) => race.raceNumber), 0),
    0
  );
  const hasRaceResults = importedRaceCount > 0;
  const raceNumbers = hasRaceResults
    ? Array.from({ length: importedRaceCount }, (_, index) => index + 1)
    : [];

  // ── Sort state ───────────────────────────────────────────────────────
  const [sortKey, setSortKey] = useState<SortKey>("rank");
  const [sortDir, setSortDir] = useState<SortDir>("asc");

  function handleSort(key: SortKey) {
    if (sortKey === key) {
      setSortDir((d) => (d === "asc" ? "desc" : "asc"));
    } else {
      setSortKey(key);
      setSortDir(key === "name" || key === "nationality" || key === "gender" ? "asc" : "asc");
    }
  }

  function sortValue(r: PublicRegattaResult, key: SortKey): string | number {
    switch (key) {
      case "rank": return r.rank ?? 9999;
      case "name": return r.sailorName?.toLowerCase() ?? "";
      case "nationality": return r.nationality?.toLowerCase() ?? "";
      case "gender": return formatGenderLabel(r.gender)?.toLowerCase() ?? "";
      case "birthYear": return r.birthYear ?? birthYear(r.dob) ?? 9999;
      case "total": return r.totalScore ?? 9999;
      case "nett": return r.nettScore ?? 9999;
    }
  }

  const sorted = [...results].sort((a, b) => {
    const va = sortValue(a, sortKey);
    const vb = sortValue(b, sortKey);
    const cmp = typeof va === "string" ? va.localeCompare(vb as string) : (va as number) - (vb as number);
    return sortDir === "asc" ? cmp : -cmp;
  });

  function thProps(key: SortKey, label: string, extraClass = "") {
    const isActive = sortKey === key;
    return {
      onClick: () => handleSort(key),
      role: "columnheader" as const,
      "aria-sort": isActive ? (sortDir === "asc" ? "ascending" : "descending") : ("none" as "ascending" | "descending" | "none"),
      className: `px-3 py-3 ${extraClass} cursor-pointer select-none whitespace-nowrap hover:text-[#2D6A6F] transition-colors ${isActive ? "text-[#2D6A6F]" : ""}`,
      tabIndex: 0,
      onKeyDown: (e: React.KeyboardEvent) => { if (e.key === "Enter" || e.key === " ") handleSort(key); },
    };
  }

  // ── Mobile cards ─────────────────────────────────────────────────────
  const mobileList = (
    <div className="sm:hidden space-y-2">
      {results.map((result) => {
        const badge = getPercentileBadge(result.rank, totalFleetSize);
        const overseas = Boolean(result.isOverseasCommitment);
        const dns = Boolean(result.isDns) && !overseas;
        const races = result.raceResults.slice().sort((a, b) => a.raceNumber - b.raceNumber);
        return (
          <article
            key={`${result.sailorId}-${result.regattaId}`}
            className="rounded-2xl border border-[var(--sp-cool-veil)] bg-[var(--sp-warm-white)] p-3.5 space-y-2 shadow-2xs"
          >
            <div className="flex items-start justify-between gap-2">
              <div className="min-w-0 flex-1">
                <div className="flex items-center gap-2">
                  <RankMedalBadge
                    rank={result.rank}
                    suffix={overseas ? "†" : dns ? "*" : ""}
                    nonPodiumClassName={`${colors.rank} shrink-0 font-black tabular-nums`}
                  />
                  <Link
                    href={`/${result.handle}`}
                    prefetch
                    className={`${colors.link} break-words text-[15px] font-bold leading-snug text-[var(--sp-harbour-shadow)]`}
                  >
                    {result.sailorName}
                  </Link>
                </div>
                <p className="mt-1 text-[11px] text-[var(--sp-charcoal)]">
                  {[
                    result.nationality,
                    formatGenderLabel(result.gender) !== "—"
                      ? formatGenderLabel(result.gender)
                      : null,
                    result.birthYear ?? birthYear(result.dob),
                  ].filter(Boolean).join(" · ") || "—"}
                </p>
              </div>
              <span className={`shrink-0 rounded-full px-2 py-0.5 text-[10px] font-bold ${badge.className}`}>
                {badge.label}
              </span>
            </div>

            <div className="grid grid-cols-2 gap-2 text-[12px]">
              {[
                ["Total", result.totalScore],
                ["Nett", result.nettScore],
              ].map(([label, value]) => (
                <div key={String(label)} className="rounded-lg bg-[var(--sp-sailcloth)] px-2.5 py-2">
                  <p className="text-[10px] font-semibold uppercase text-[var(--sp-charcoal)]">{label}</p>
                  <p className="font-mono font-bold tabular-nums text-[var(--sp-harbour-shadow)]">{value ?? "—"}</p>
                </div>
              ))}
            </div>

            <MobileRaceScores races={races} />

            {(overseas || dns) && (
              <div className="flex flex-wrap gap-1.5">
                {overseas && (
                  <span className="rounded-full border border-sky-200 bg-sky-50 px-2 py-0.5 text-[10px] font-bold text-sky-800">
                    Overseas
                  </span>
                )}
                {dns && (
                  <span className="rounded-full border border-rose-200 bg-rose-50 px-2 py-0.5 text-[10px] font-bold text-rose-800">
                    DNS
                  </span>
                )}
              </div>
            )}
          </article>
        );
      })}
    </div>
  );

  // ── Desktop table ─────────────────────────────────────────────────────
  const desktopTable = (
    <div className="hidden sm:block overflow-x-auto rounded-2xl border border-[var(--sp-cool-veil)] bg-[var(--sp-warm-white)] shadow-xs">
      <table
        className={`w-full ${hasRaceResults ? "min-w-[1050px]" : "min-w-[680px]"} text-left text-sm`}
        aria-label="Regatta results"
      >
        <thead className="bg-[var(--sp-sailcloth)] text-xs uppercase text-[var(--sp-charcoal)] font-bold border-b border-[var(--sp-cool-veil)]">
          <tr>
            <th {...thProps("rank", "Rank", "text-center")}>
              Rank <SortIcon active={sortKey === "rank"} dir={sortDir} />
            </th>
            <th {...thProps("name", "Name")}>
              Name <SortIcon active={sortKey === "name"} dir={sortDir} />
            </th>
            <th {...thProps("nationality", "Nationality", "text-center")}>
              Nationality <SortIcon active={sortKey === "nationality"} dir={sortDir} />
            </th>
            <th {...thProps("gender", "Gender", "text-center")}>
              Gender <SortIcon active={sortKey === "gender"} dir={sortDir} />
            </th>
            <th {...thProps("birthYear", "Birth year", "text-center")}>
              Birth year <SortIcon active={sortKey === "birthYear"} dir={sortDir} />
            </th>
            {raceNumbers.map((raceNumber) => (
              <th key={raceNumber} className="px-2 py-3 text-center">
                R{raceNumber}
              </th>
            ))}
            <th {...thProps("total", "Total", "text-center")}>
              Total <SortIcon active={sortKey === "total"} dir={sortDir} />
            </th>
            <th
              {...thProps("nett", "Nett", "text-center font-black text-[var(--sp-harbour-teal)]")}
            >
              Nett <SortIcon active={sortKey === "nett"} dir={sortDir} />
            </th>
            <th className="px-3 py-3">Percentile</th>
          </tr>
        </thead>
        <tbody>
          {sorted.map((result) => {
            const badge = getPercentileBadge(result.rank, totalFleetSize);
            const overseas = Boolean(result.isOverseasCommitment);
            const dns = Boolean(result.isDns) && !overseas;
            const races = new Map(result.raceResults.map((race) => [race.raceNumber, race]));
            const podiumTint = podiumRowClass(result.rank);
            return (
              <tr
                key={`${result.sailorId}-${result.regattaId}`}
                className={`border-t border-[var(--sp-cool-veil)] hover:brightness-95 transition-colors ${podiumTint}`}
              >
                <td className="px-3 py-3 text-center">
                  <RankMedalBadge
                    rank={result.rank}
                    suffix={overseas ? "†" : dns ? "*" : ""}
                    nonPodiumClassName={colors.rank}
                  />
                </td>
                <td className="px-3 py-3">
                  <Link
                    href={`/${result.handle}`}
                    prefetch
                    className={`${colors.link} font-bold text-[var(--sp-harbour-shadow)]`}
                  >
                    {result.sailorName}
                  </Link>
                </td>
                <td className="px-3 py-3 text-center font-mono text-[var(--sp-charcoal)]">
                  {result.nationality || "—"}
                </td>
                <td className="px-3 py-3 text-center text-[var(--sp-charcoal)]">
                  {formatGenderLabel(result.gender)}
                </td>
                <td className="px-3 py-3 text-center font-mono text-[var(--sp-charcoal)]">
                  {result.birthYear ?? birthYear(result.dob) ?? "—"}
                </td>
                {raceNumbers.map((raceNumber) => {
                  const race = races.get(raceNumber);
                  return (
                    <td
                      key={raceNumber}
                      className={`px-2 py-3 text-center font-mono text-xs font-semibold tabular-nums ${raceValueClass(race)}`}
                      title={race?.discarded ? "Discarded score" : race?.scoringCode || undefined}
                    >
                      {raceValue(race)}
                    </td>
                  );
                })}
                <td className="px-3 py-3 text-center font-mono text-[var(--sp-charcoal-slate)]">
                  {result.totalScore ?? "—"}
                </td>
                <td className="px-3 py-3 text-center font-mono font-bold text-[var(--sp-harbour-shadow)]">
                  {result.nettScore ?? "—"}
                </td>
                <td className="px-3 py-3">
                  <div className="flex flex-wrap items-center gap-1.5">
                    {overseas && (
                      <span className="rounded-full border border-sky-200 bg-sky-50 px-2 py-0.5 text-[10px] font-bold text-sky-800">
                        Overseas
                      </span>
                    )}
                    {dns && (
                      <span className="rounded-full border border-rose-200 bg-rose-50 px-2 py-0.5 text-[10px] font-bold text-rose-800">
                        DNS
                      </span>
                    )}
                    <span className={`rounded-full px-2 py-0.5 text-[10px] font-bold ${badge.className}`}>
                      {badge.label}
                    </span>
                  </div>
                </td>
              </tr>
            );
          })}
        </tbody>
      </table>
    </div>
  );

  return (
    <>
      {mobileList}
      {desktopTable}
    </>
  );
}
