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
        role="img"
        title="1st Place (Gold Medal)"
        aria-label="1st Place – Gold Medal"
        className={`inline-flex h-6 w-6 items-center justify-center rounded-full font-black text-[11px] shrink-0 ${className}`}
        style={{ backgroundColor: "#FFD700", color: "#1a1a1a" }}
      >
        1{suffix}
      </span>
    );
  }
  if (rank === 2) {
    return (
      <span
        role="img"
        title="2nd Place (Silver Medal)"
        aria-label="2nd Place – Silver Medal"
        className={`inline-flex h-6 w-6 items-center justify-center rounded-full font-black text-[11px] shrink-0 ${className}`}
        style={{ backgroundColor: "#C0C0C0", color: "#1a1a1a" }}
      >
        2{suffix}
      </span>
    );
  }
  if (rank === 3) {
    return (
      <span
        role="img"
        title="3rd Place (Bronze Medal)"
        aria-label="3rd Place – Bronze Medal"
        className={`inline-flex h-6 w-6 items-center justify-center rounded-full font-black text-[11px] shrink-0 ${className}`}
        style={{ backgroundColor: "#CD7F32", color: "#fff" }}
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
