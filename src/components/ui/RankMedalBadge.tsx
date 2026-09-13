import React from "react";

export type RankMedalBadgeProps = {
  rank: number;
  suffix?: string;
  className?: string;
  nonPodiumClassName?: string;
};

/**
 * Renders consistent Gold (#1), Silver (#2), Bronze (#3) medal badges
 * across SailorPath regattas and rankings, with fallback font-mono text for other ranks.
 */
export function RankMedalBadge({
  rank,
  suffix = "",
  className = "",
  nonPodiumClassName = "",
}: RankMedalBadgeProps) {
  if (rank === 1) {
    return (
      <span
        className={`inline-flex h-6 w-6 items-center justify-center rounded-full bg-amber-400 text-slate-950 font-black text-[11px] shadow-sm shadow-amber-400/30 shrink-0 ${className}`}
        title="1st Place (Gold Medal)"
      >
        1{suffix}
      </span>
    );
  }
  if (rank === 2) {
    return (
      <span
        className={`inline-flex h-6 w-6 items-center justify-center rounded-full bg-slate-300 text-slate-950 font-black text-[11px] shadow-sm shadow-white/10 shrink-0 ${className}`}
        title="2nd Place (Silver Medal)"
      >
        2{suffix}
      </span>
    );
  }
  if (rank === 3) {
    return (
      <span
        className={`inline-flex h-6 w-6 items-center justify-center rounded-full bg-amber-700 text-amber-100 font-black text-[11px] shadow-sm shadow-amber-900/30 shrink-0 ${className}`}
        title="3rd Place (Bronze Medal)"
      >
        3{suffix}
      </span>
    );
  }
  return (
    <span
      className={
        nonPodiumClassName
          ? `${nonPodiumClassName} ${className}`
          : `font-mono font-bold text-slate-400 ${className}`
      }
    >
      {rank}{suffix}
    </span>
  );
}

