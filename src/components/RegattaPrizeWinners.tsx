"use client";

import { useState } from "react";
import Link from "next/link";
import { Trophy, Compass } from "lucide-react";
import {
  prizeNameKey,
  type PrizeCategory,
  type RegattaPrizeFleet,
  type RegattaPrizeSchedule,
} from "@/lib/regattaPrizes";

type Props = {
  schedule: RegattaPrizeSchedule;
  filterFleet?: string;
  profileHandles?: Record<string, string>;
};

/** School-related categories are hidden from the public podium view. */
function isSchoolCategory(name: string): boolean {
  const lower = name.toLowerCase();
  return (
    lower.includes("school") ||
    lower.includes("primary") ||
    lower.includes("secondary") ||
    lower.includes("college") ||
    lower.includes("jc") ||
    lower.includes("poly")
  );
}

/** Derive a category icon from the category name. */
function categoryIcon(name: string): string {
  const lower = name.toLowerCase();
  if (lower.includes("female") || lower.includes("girl") || lower.includes("women"))
    return "♀";
  if (
    lower.includes("age") ||
    lower.includes("year") ||
    lower.includes("born") ||
    lower.includes("junior") ||
    lower.includes("youth")
  )
    return "👶";
  return "🏆";
}

/** Medal colours per spec: 1st=#FFD700, 2nd=#C0C0C0, 3rd=#CD7F32 */
function medalStyle(rank: number): { bg: string; fg: string } {
  if (rank === 1) return { bg: "#FFD700", fg: "#1a1a1a" };
  if (rank === 2) return { bg: "#C0C0C0", fg: "#1a1a1a" };
  if (rank === 3) return { bg: "#CD7F32", fg: "#ffffff" };
  return { bg: "var(--sp-warm-white)", fg: "var(--sp-slate-soft)" };
}

/** Row tint for top-3 winner rows */
function winnerRowTint(rank: number): string {
  if (rank === 1) return "bg-[#FFF9DB] border-[#FFD700]/30";
  if (rank === 2) return "bg-[#F5F5F5] border-[#C0C0C0]/40";
  if (rank === 3) return "bg-[#FBF2E7] border-[#CD7F32]/30";
  return "bg-[var(--sp-warm-white)] border-[var(--sp-cool-veil)]/80";
}

function WinnerRow({ w, profileHandles }: { w: PrizeCategory["winners"][number]; profileHandles?: Record<string, string> }) {
  const { bg, fg } = medalStyle(w.rank);
  const tint = winnerRowTint(w.rank);
  return (
    <div className={`flex items-center gap-2.5 rounded-lg border px-2.5 py-2 text-xs ${tint}`}>
      <span
        role="img"
        aria-label={
          w.rank === 1 ? "1st Place – Gold Medal"
          : w.rank === 2 ? "2nd Place – Silver Medal"
          : w.rank === 3 ? "3rd Place – Bronze Medal"
          : `${w.rank}th Place`
        }
        className="inline-flex h-5 w-5 shrink-0 items-center justify-center rounded-full font-black text-[10px]"
        style={{ backgroundColor: bg, color: fg }}
        title={w.prizeTitle}
      >
        {w.rank}
      </span>
      <div className="min-w-0 flex-1 flex items-baseline justify-between gap-1">
        <PrizeSailorName
          name={w.sailorName}
          handle={profileHandles?.[prizeNameKey(w.sailorName)]}
        />
        <div className="flex items-center gap-2 shrink-0">
          {w.club && (
            <span className="inline-flex items-center gap-0.5 text-[10px] text-[var(--sp-charcoal)] hidden sm:inline-flex">
              <Compass className="h-2.5 w-2.5 shrink-0" aria-hidden />
              <span className="truncate max-w-[8rem]">{w.club}</span>
            </span>
          )}
          {w.sailNumber && (
            <span className="font-mono text-[10px] text-[var(--sp-charcoal)]">
              #{w.sailNumber}
            </span>
          )}
        </div>
      </div>
      {w.notes && (
        <p className="text-[10px] text-[var(--sp-racing-deep)] font-medium shrink-0">
          {w.notes}
        </p>
      )}
    </div>
  );
}

function CategoryCard({
  cat,
  profileHandles,
  wide,
}: {
  cat: PrizeCategory;
  profileHandles?: Record<string, string>;
  wide?: boolean;
}) {
  // If wide and exactly 3 winners (e.g. Open top 3 podium), display in 3 columns
  const isThreePodium = wide && cat.winners.length === 3;
  // If wide and > 5 entries (e.g. Open top 10), explicit half-split columns: 1-5 left, 6-10 right
  const splitAt = wide && cat.winners.length > 5 ? Math.ceil(cat.winners.length / 2) : null;
  const leftCol = splitAt ? cat.winners.slice(0, splitAt) : cat.winners;
  const rightCol = splitAt ? cat.winners.slice(splitAt) : [];

  return (
    <article
      aria-label={`${cat.categoryName} podium`}
      className="rounded-xl border border-[var(--sp-cool-veil)] bg-[var(--sp-sailcloth)]/60 overflow-hidden flex flex-col"
    >
      {/* Card header */}
      <div className="flex items-center justify-between gap-2 px-3.5 py-2.5 border-b border-[var(--sp-cool-veil)] bg-[var(--sp-warm-white)]">
        <span className="flex items-center gap-1.5 text-xs font-black uppercase tracking-wider text-[var(--sp-harbour-shadow)]">
          <span aria-hidden className="text-sm">{categoryIcon(cat.categoryName)}</span>
          {cat.categoryName}
        </span>
        <span className="rounded-full bg-[var(--sp-sailcloth)] border border-[var(--sp-cool-veil)] px-2 py-0.5 text-[10px] font-bold text-[var(--sp-slate-soft)] whitespace-nowrap">
          {cat.prizesAwarded}
        </span>
      </div>

      {cat.eligibilityNotes && (
        <p className="px-3.5 py-1.5 text-[11px] text-[var(--sp-slate-soft)] italic leading-snug border-b border-[var(--sp-cool-veil)]/60">
          {cat.eligibilityNotes}
        </p>
      )}

      {/* Winners layout */}
      {isThreePodium ? (
        <div className="p-3 flex-1 grid grid-cols-1 sm:grid-cols-3 gap-2.5 items-stretch">
          {cat.winners.map((w) => (
            <WinnerRow key={`${w.rank}-${w.sailorName}`} w={w} profileHandles={profileHandles} />
          ))}
        </div>
      ) : splitAt ? (
        <div className="p-2.5 flex-1 grid grid-cols-1 sm:grid-cols-2 gap-x-3 gap-y-1.5 items-start">
          <div className="space-y-1.5">
            {leftCol.map((w) => (
              <WinnerRow key={`${w.rank}-${w.sailorName}`} w={w} profileHandles={profileHandles} />
            ))}
          </div>
          <div className="space-y-1.5">
            {rightCol.map((w) => (
              <WinnerRow key={`${w.rank}-${w.sailorName}`} w={w} profileHandles={profileHandles} />
            ))}
          </div>
        </div>
      ) : (
        <div className="p-2.5 flex-1 space-y-1.5">
          {leftCol.map((w) => (
            <WinnerRow key={`${w.rank}-${w.sailorName}`} w={w} profileHandles={profileHandles} />
          ))}
        </div>
      )}
    </article>
  );
}

export function RegattaPrizeWinners({ schedule, filterFleet, profileHandles }: Props) {
  const matched = filterFleet
    ? schedule.fleets.filter(
        (f) =>
          f.fleetName.toLowerCase().includes(filterFleet.toLowerCase()) ||
          f.boatClass.toLowerCase().includes(filterFleet.toLowerCase())
      )
    : schedule.fleets;

  const fleetsToDisplay = matched
    .map((fleet) => ({
      ...fleet,
      categories: fleet.categories.filter(
        (cat) => cat.winners.length > 0 && !isSchoolCategory(cat.categoryName)
      ),
    }))
    .filter((fleet) => fleet.categories.length > 0);

  const [selectedFleetIdx, setSelectedFleetIdx] = useState(0);
  const currentFleet: RegattaPrizeFleet | undefined =
    fleetsToDisplay[selectedFleetIdx] || fleetsToDisplay[0];

  if (!currentFleet) return null;

  // Split into "main" (open / overall — first category or any large one) and "sub" categories
  const [mainCat, ...subCats] = currentFleet.categories;

  return (
    <section
      aria-label="Official NoR Prize Winners"
      className="rounded-2xl border border-[var(--sp-cool-veil)] bg-[var(--sp-warm-white)] shadow-xs overflow-hidden"
    >
      {/* ── Header ─────────────────────────────────────────────────── */}
      <div className="px-4 sm:px-6 pt-5 pb-4 border-b border-[var(--sp-cool-veil)] space-y-3">
        <div className="flex flex-col sm:flex-row sm:items-start justify-between gap-3">
          <div className="space-y-1.5">
            <div className="inline-flex items-center gap-1.5 rounded-full bg-amber-500/10 border border-amber-500/30 px-2.5 py-0.5 text-xs font-bold text-amber-800">
              <Trophy className="h-3.5 w-3.5 text-amber-600" />
              Official Notice of Race (NoR) Prizes
            </div>
            <h2 className="text-xl sm:text-2xl font-black text-[var(--sp-harbour-shadow)] tracking-tight leading-tight">
              Verified Prize Winners &amp; Podiums
            </h2>
            <p className="text-xs text-[var(--sp-slate-soft)]">
              Awarded per Section 19 of the official Notice of Race ({schedule.regattaName})
            </p>
          </div>

          {/* Fleet tabs (only when multiple fleets) */}
          {fleetsToDisplay.length > 1 && (
            <nav aria-label="Prize fleet selector" className="flex flex-wrap gap-1.5 shrink-0">
              {fleetsToDisplay.map((f, idx) => {
                const isActive = idx === selectedFleetIdx;
                return (
                  <button
                    key={f.fleetName}
                    type="button"
                    role="tab"
                    aria-selected={isActive}
                    onClick={() => setSelectedFleetIdx(idx)}
                    className={`
                      relative px-4 py-2 text-xs font-bold transition-all cursor-pointer
                      border-b-2 focus-visible:outline-2 focus-visible:outline-[#2D6A6F]
                      ${isActive
                        ? "border-b-[#2D6A6F] text-[#2D6A6F] bg-[var(--sp-aqua-mist)]/40"
                        : "border-b-transparent text-[var(--sp-charcoal)] hover:text-[#2D6A6F] hover:bg-[var(--sp-sailcloth)]"
                      }
                    `}
                  >
                    {f.fleetName}
                  </button>
                );
              })}
            </nav>
          )}
        </div>
      </div>

      {/* ── Podium layout ───────────────────────────────────────────── */}
      <div className="p-4 sm:p-6 space-y-4">
        {mainCat && (mainCat.winners.length > 5 || mainCat.winners.length === 3) ? (
          // Main category full-width (2-col split for >5 winners, 3-col split for 3 winners), sub-cats grid below
          <>
            <CategoryCard cat={mainCat} profileHandles={profileHandles} wide />
            {subCats.length > 0 && (
              <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-4">
                {subCats.map((cat) => (
                  <CategoryCard key={cat.categoryName} cat={cat} profileHandles={profileHandles} />
                ))}
              </div>
            )}
          </>
        ) : (
          // General layout
          <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-4">
            {currentFleet.categories.map((cat) => (
              <CategoryCard key={cat.categoryName} cat={cat} profileHandles={profileHandles} />
            ))}
          </div>
        )}
      </div>

      {/* ── Visual bridge to results table ─────────────────────────── */}
      <div className="mx-4 sm:mx-6 mb-5 flex items-center gap-3">
        <div className="h-px flex-1 bg-gradient-to-r from-transparent via-[var(--sp-cool-veil)] to-transparent" />
        <span className="text-[11px] font-semibold text-[var(--sp-slate-soft)] uppercase tracking-wider whitespace-nowrap">
          Full results below
        </span>
        <div className="h-px flex-1 bg-gradient-to-r from-transparent via-[var(--sp-cool-veil)] to-transparent" />
      </div>
    </section>
  );
}

function PrizeSailorName({ name, handle }: { name: string; handle?: string }) {
  if (!handle) {
    return <span className="font-bold text-[var(--sp-charcoal)] truncate">{name}</span>;
  }
  return (
    <Link
      href={`/${handle}`}
      className="font-bold text-[var(--sp-harbour-shadow)] hover:text-[var(--sp-racing-orange)] truncate"
    >
      {name}
    </Link>
  );
}
