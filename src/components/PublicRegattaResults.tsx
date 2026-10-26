"use client";

import { useId, useState } from "react";
import { ResultScoringGuide } from "@/components/ResultScoringGuide";
import { describeRaceScore } from "@/lib/raceScorePresentation";
import Link from "next/link";
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
  pendingIdentityReview?: boolean;
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
  if (rank === 1) return "bg-[#FFF9DB]";
  if (rank === 2) return "bg-[#F5F5F5]";
  if (rank === 3) return "bg-[#FBF2E7]";
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

function RaceScore({ race, raceNumber }: { race: OfficialRaceResultInput | undefined; raceNumber: number }) {
  const description = describeRaceScore(race, raceNumber);
  return (
    <span title={description} className={raceValueClass(race)}>
      <span aria-hidden="true">{raceValue(race)}</span>
      <span className="sr-only">{description}</span>
    </span>
  );
}

function claimProfileHref(handle: string): string {
  return `/login?next=${encodeURIComponent(`/sailors/${handle}`)}`;
}

function unclaimedSailors(result: PublicRegattaResult): { handle: string; name: string }[] {
  const links: { handle: string; name: string }[] = [];
  const seen = new Set<string>();
  const add = (
    handle: string | null | undefined,
    name: string | null | undefined,
    claimed: boolean | undefined
  ) => {
    const safeHandle = String(handle || "").trim();
    if (!safeHandle || claimed !== false || seen.has(safeHandle)) return;
    seen.add(safeHandle);
    links.push({ handle: safeHandle, name: String(name || "").trim() || safeHandle });
  };
  add(result.handle, result.sailorName, result.profileClaimed);
  for (const member of result.participants || []) {
    add(member.handle, member.sailorName || member.sourceName, member.profileClaimed);
  }
  return links;
}

function ClaimProfileLinks({ result }: { result: PublicRegattaResult }) {
  const links = unclaimedSailors(result);
  if (!links.length) return null;
  return (
    <div className="mt-1 flex flex-col gap-0.5">
      {links.map((link) => (
        <Link
          key={link.handle}
          href={claimProfileHref(link.handle)}
          className="text-[11px] font-semibold leading-snug text-[var(--sp-harbour-teal)] hover:underline"
          aria-label={
            links.length > 1
              ? `Is this you? Claim profile for ${link.name}`
              : "Is this you? Claim profile"
          }
        >
          Is this you? Claim profile
        </Link>
      ))}
    </div>
  );
}

function crewSummary(result: PublicRegattaResult): string | null {
  const members = (result.participants || [])
    .slice()
    .sort((a, b) => a.displayOrder - b.displayOrder);
  if (members.length < 2) return null;
  return members
    .map((member) => {
      const name = member.sailorName || member.sourceName;
      return member.role === "unknown" ? name : `${name} (${member.role})`;
    })
    .join(" / ");
}

const CJK_REGEX = /[\u3000-\u303f\u3040-\u309f\u30a0-\u30ff\uff00-\uff9f\u4e00-\u9faf\u3400-\u4dbf]/;

function secondaryEntryLabel(result: PublicRegattaResult): { text: string; lang?: string } | null {
  if (result.entryType === "crew" || (result.participants && result.participants.length > 1)) {
    return null;
  }
  const raw = (result.entryLabel || result.participants?.[0]?.sourceName || "").trim();
  if (!raw) return null;

  const primary = (result.sailorName || "").trim().toLowerCase();
  if (raw.toLowerCase() === primary) return null;

  const isCjk = CJK_REGEX.test(raw);
  if (isCjk) {
    return { text: raw, lang: "ja" };
  }

  const cleanRaw = raw.replace(/[^a-zA-Z0-9]/g, "").toLowerCase();
  const cleanPrimary = primary.replace(/[^a-zA-Z0-9]/g, "").toLowerCase();
  if (cleanRaw && cleanRaw === cleanPrimary) return null;

  return { text: raw };
}

function MobileRaceScores({ races }: { races: OfficialRaceResultInput[] }) {
  if (races.length === 0) return null;
  return (
    <details open={races.length <= 8} className="group rounded-xl border border-[var(--sp-cool-veil)] bg-[var(--sp-sailcloth)]">
      <summary className="cursor-pointer list-none min-h-11 px-3 py-2 text-[13px] font-semibold text-[var(--sp-harbour-teal)] marker:content-none flex items-center justify-between">
        <span className="inline-flex items-center gap-1.5">
          <span aria-hidden className="transition-transform group-open:rotate-90">›</span>
          <span>{races.length} published race score{races.length === 1 ? "" : "s"}</span>
        </span>
        <span className="text-[10px] text-[var(--sp-slate-soft)] font-normal group-open:hidden">Tap to expand</span>
      </summary>
      <div className="grid grid-cols-3 gap-1.5 border-t border-[var(--sp-cool-veil)] p-2.5">
        {races.map((race) => (
          <div key={race.raceNumber} className="rounded-lg bg-[var(--sp-warm-white)] border border-[var(--sp-cool-veil)] px-2 py-1.5 text-center">
            <p className="text-[11px] font-semibold uppercase text-[var(--sp-slate-soft)]">R{race.raceNumber}</p>
            <p className="text-sm font-bold tabular-nums">
              <RaceScore race={race} raceNumber={race.raceNumber} />
            </p>
            {race.discarded && <p aria-hidden="true" className="mt-0.5 text-[10px] text-[var(--sp-charcoal)]">Discarded</p>}
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
  pendingIdentityReview = false,
}: Props) {
  const colors = accentClasses[accent];
  const viewId = useId();
  const [mobileView, setMobileView] = useState<"cards" | "table">("cards");

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
      setSortDir("asc");
    }
  }

  function sortValue(r: PublicRegattaResult, key: SortKey): string | number {
    switch (key) {
      case "rank": return r.rank ?? 9999;
      case "name": return r.sailorName?.toLowerCase() ?? "";
      case "nationality": return r.nationality?.toLowerCase() ?? "";
      case "gender": return formatGenderLabel(r.gender)?.toLowerCase() ?? "";
      case "birthYear": return r.birthYear ?? 9999;
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
      onKeyDown: (e: React.KeyboardEvent) => { if (e.key === "Enter" || e.key === " ") { e.preventDefault(); handleSort(key); } },
    };
  }

  // ── Mobile cards ─────────────────────────────────────────────────────
  const mobileList = (
    <div id={viewId + "-cards"} className={mobileView === "cards" ? "sm:hidden space-y-2" : "hidden"}>
      {sorted.map((result) => {
        const badge = getPercentileBadge(result.rank, totalFleetSize);
        const overseas = Boolean(result.isOverseasCommitment);
        const dns = Boolean(result.isDns) && !overseas;
        const races = result.raceResults.slice().sort((a, b) => a.raceNumber - b.raceNumber);
        const crew = crewSummary(result);
        const secondary = secondaryEntryLabel(result);
        return (
          <article
            key={`${result.sailorId}-${result.regattaId}`}
            className="rounded-2xl border border-[var(--sp-cool-veil)] bg-[var(--sp-warm-white)] p-3.5 space-y-2 shadow-2xs"
          >
            <div className="flex items-start justify-between gap-2">
              <div className="min-w-0 flex-1">
                <div className="flex items-start gap-2">
                  <RankMedalBadge
                    rank={result.rank}
                    suffix={overseas ? "†" : dns ? "*" : ""}
                    nonPodiumClassName={`${colors.rank} shrink-0 font-black tabular-nums`}
                  />
                  <div className="min-w-0">
                    <Link
                      href={`/sailors/${result.handle}`}
                      prefetch
                      className={`${colors.link} inline-flex flex-col items-start break-words text-[15px] font-bold leading-snug text-[var(--sp-harbour-shadow)]`}
                    >
                      <span>{result.sailorName}</span>
                      {secondary && (
                        <span
                          lang={secondary.lang}
                          className="text-[12px] font-normal leading-tight text-[var(--sp-charcoal)] opacity-75"
                        >
                          {secondary.text}
                        </span>
                      )}
                    </Link>
                    <ClaimProfileLinks result={result} />
                    {crew && (
                      <p className="mt-1 text-[11px] font-semibold text-[var(--sp-harbour-teal)]">
                        Crew · {crew}
                        {result.entrySailNumber ? ` · Sail ${result.entrySailNumber}` : ""}
                      </p>
                    )}
                  </div>
                </div>
                <p className="mt-1 text-[11px] text-[var(--sp-charcoal)]">
                  {[
                    result.nationality,
                    formatGenderLabel(result.gender) !== "—"
                      ? formatGenderLabel(result.gender)
                      : null,
                    result.birthYear,
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
    <div
      id={viewId + "-table"}
      role="region"
      aria-label="Scrollable regatta results"
      aria-describedby={results.length ? viewId + "-scroll-help" : undefined}
      tabIndex={0}
      className={(mobileView === "table" ? "block" : "hidden") + " sm:block max-w-full overflow-x-auto rounded-2xl border border-[var(--sp-cool-veil)] bg-[var(--sp-warm-white)] shadow-xs focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-harbour"}
    >
      <table
        className={`w-full ${hasRaceResults ? "min-w-[1050px]" : "min-w-[680px]"} text-left text-sm`}
        aria-label="Regatta results"
      >
        <thead className="bg-[var(--sp-sailcloth)] text-xs uppercase text-[var(--sp-charcoal)] font-bold border-b border-[var(--sp-cool-veil)]">
          <tr>
            <th {...thProps("rank", "Rank", "text-center")}>
              Rank <SortIcon active={sortKey === "rank"} dir={sortDir} />
            </th>
            <th {...thProps("name", "Name", "sticky left-0 z-20 min-w-40 max-w-48 bg-[var(--sp-sailcloth)] shadow-[2px_0_0_var(--sp-cool-veil)]")}>
              Name <SortIcon active={sortKey === "name"} dir={sortDir} />
            </th>
            <th {...thProps("nationality", "Nationality", "hidden sm:table-cell text-center")}>
              Nationality <SortIcon active={sortKey === "nationality"} dir={sortDir} />
            </th>
            <th {...thProps("gender", "Gender", "hidden sm:table-cell text-center")}>
              Gender <SortIcon active={sortKey === "gender"} dir={sortDir} />
            </th>
            <th {...thProps("birthYear", "Birth year", "hidden sm:table-cell text-center")}>
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
            const crew = crewSummary(result);
            const secondary = secondaryEntryLabel(result);
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
                <td className={`sticky left-0 z-10 min-w-40 max-w-48 px-3 py-3 break-words shadow-[2px_0_0_var(--sp-cool-veil)] ${podiumTint || "bg-[var(--sp-warm-white)]"}`}>
                  <Link
                    href={`/sailors/${result.handle}`}
                    prefetch
                    className={`${colors.link} inline-flex flex-col items-start font-bold text-[var(--sp-harbour-shadow)]`}
                  >
                    <span>{result.sailorName}</span>
                    {secondary && (
                      <span
                        lang={secondary.lang}
                        className="text-xs font-normal leading-tight text-[var(--sp-charcoal)] opacity-75"
                      >
                        {secondary.text}
                      </span>
                    )}
                  </Link>
                  <ClaimProfileLinks result={result} />
                  {crew && (
                    <p className="mt-0.5 text-[11px] font-semibold text-[var(--sp-harbour-teal)]">
                      Crew · {crew}
                      {result.entrySailNumber ? ` · Sail ${result.entrySailNumber}` : ""}
                    </p>
                  )}
                </td>
                <td className="hidden sm:table-cell px-3 py-3 text-center font-mono text-[var(--sp-charcoal)]">
                  {result.nationality || "—"}
                </td>
                <td className="hidden sm:table-cell px-3 py-3 text-center text-[var(--sp-charcoal)]">
                  {formatGenderLabel(result.gender)}
                </td>
                <td className="hidden sm:table-cell px-3 py-3 text-center font-mono text-[var(--sp-charcoal)]">
                  {result.birthYear ?? "—"}
                </td>
                {raceNumbers.map((raceNumber) => {
                  const race = races.get(raceNumber);
                  return (
                    <td
                      key={raceNumber}
                      className={`px-2 py-3 text-center font-mono text-xs font-semibold tabular-nums ${raceValueClass(race)}`}
                      title={race?.discarded ? "Discarded score" : race?.scoringCode || undefined}
                    >
                      <RaceScore race={race} raceNumber={raceNumber} />
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
      {pendingIdentityReview && results.length < totalFleetSize && (
        <p role="status" className="rounded-xl border border-amber-200 bg-amber-50 px-4 py-3 text-sm text-amber-950">
          Partial import: {results.length} of {totalFleetSize} entries are shown.{" "}
          {totalFleetSize - results.length} entries await sailor identity review.
        </p>
      )}
      {results.length > 0 && (
        <>
          <ResultScoringGuide codes={results.flatMap((result) => result.raceResults.map((race) => race.scoringCode || ""))} hasDnsEntries={results.some((result) => result.isDns && !result.isOverseasCommitment)} hasOverseasEntries={results.some((result) => result.isOverseasCommitment)} />
          <div role="group" aria-label="Mobile results view" className="sm:hidden flex flex-wrap gap-2">
            <button type="button" aria-pressed={mobileView === "cards"} aria-controls={viewId + "-cards"} onClick={() => setMobileView("cards")} className={mobileView === "cards" ? "sp-primary min-h-11 px-4 text-sm font-semibold" : "sp-secondary min-h-11 px-4 text-sm font-semibold"}>Sailor cards</button>
            <button type="button" aria-pressed={mobileView === "table"} aria-controls={viewId + "-table"} onClick={() => setMobileView("table")} className={mobileView === "table" ? "sp-primary min-h-11 px-4 text-sm font-semibold" : "sp-secondary min-h-11 px-4 text-sm font-semibold"}>Compare scores</button>
          </div>
          <div className="sm:hidden flex flex-wrap items-center gap-2">
            <label htmlFor={viewId + "-sort"} className="text-sm font-semibold text-harbour">Sort results</label>
            <select id={viewId + "-sort"} value={sortKey} onChange={(event) => { setSortKey(event.target.value as SortKey); setSortDir("asc"); }} className="min-h-11 min-w-0 rounded-xl border border-cool-veil bg-warm-white px-3 text-base text-charcoal">
              <option value="rank">Rank</option><option value="name">Name</option><option value="nationality">Nationality</option><option value="gender">Gender</option><option value="birthYear">Birth year</option><option value="total">Total</option><option value="nett">Nett</option>
            </select>
            <button type="button" onClick={() => setSortDir((direction) => direction === "asc" ? "desc" : "asc")} className="sp-secondary min-h-11 px-3 text-sm font-semibold" aria-label={sortDir === "asc" ? "Change to descending order" : "Change to ascending order"}>{sortDir === "asc" ? "Ascending" : "Descending"}</button>
          </div>
          <p role="status" className="sr-only">Sorted by {sortKey}, {sortDir === "asc" ? "ascending" : "descending"}.</p>
          <p id={viewId + "-scroll-help"} className={(mobileView === "table" ? "block" : "hidden") + " sm:block text-xs leading-5 text-slate-soft"}>
            Scroll across to compare {hasRaceResults ? "race scores and totals" : "totals"}. Sailor names stay in view. Missing scores are shown as —.
          </p>
        </>
      )}
      {mobileList}
      {desktopTable}
    </>
  );
}
