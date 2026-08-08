/**
 * Pure display helpers for sailor profile.
 */

import {
  seriesFleetStatus,
  normalizeNationality,
} from "@/lib/seriesMembership";
import { nationalityLabelForCode } from "@/lib/countries";

/** Cards match main page background (#090a0f); separation via border only */
export const PROFILE_CARD_CLASS =
  "rounded-2xl border border-white/[0.07] bg-[#090a0f]";

/**
 * Profile fleet badge from Optimist series status.
 * Optional flags let ILCA-focused / aged-out sailors show ILCA 4 instead of
 * a stale Optimist “Silver fleet” label.
 */
export function resolveDisplayFleet(
  sailor: Record<string, unknown>,
  opts?: {
    /** Has ILCA 4 results or sail number */
    hasIlca4?: boolean;
    /** Prefer ILCA (dropped, aged out of Optimist) */
    preferIlca?: boolean;
    /** No Optimist results at all */
    optimistOnlyAbsent?: boolean;
  }
): {
  label: string;
  className: string;
} {
  const status = seriesFleetStatus(sailor as never);
  // Primary class is ILCA — don't show Optimist Silver/Gold for aged-out / ILCA-only
  if (
    opts?.hasIlca4 &&
    (opts.preferIlca || opts.optimistOnlyAbsent || status === "dropped" || status === "guest")
  ) {
    // Still show gold/dropped if actively in Optimist gold and not preferring ILCA
    if (status === "gold" && !opts.preferIlca && !opts.optimistOnlyAbsent) {
      return {
        label: "Gold fleet",
        className: "bg-yellow-400 text-yellow-950 border border-yellow-300/30",
      };
    }
    if (opts.preferIlca || opts.optimistOnlyAbsent || status === "dropped" || status === "guest") {
      return {
        label: "ILCA 4",
        className: "bg-sky-500/20 text-sky-200 border border-sky-500/30",
      };
    }
  }
  if (status === "gold") {
    return {
      label: "Gold fleet",
      className: "bg-yellow-400 text-yellow-950 border border-yellow-300/30",
    };
  }
  if (status === "silver" || status === "series") {
    return {
      label: "Silver fleet",
      className: "bg-neutral-600/80 text-neutral-100 border border-neutral-500/30",
    };
  }
  if (status === "dropped") {
    return {
      label: "Dropped",
      className: "bg-rose-500/15 text-rose-300 border border-rose-500/25",
    };
  }
  return {
    label: "Guest",
    className: "bg-white/10 text-neutral-300 border border-white/10",
  };
}

export function fleetPillClass(
  fleet: "Gold" | "Silver" | "Open" | "—" | string
): string {
  if (fleet === "Gold") {
    return "bg-yellow-400 text-yellow-950 border border-yellow-300/20";
  }
  if (fleet === "Silver") {
    return "bg-neutral-600 text-neutral-100 border border-neutral-500/30";
  }
  if (fleet === "Open" || fleet === "ILCA 4") {
    return "bg-sky-500/15 text-sky-300 border border-sky-500/25";
  }
  return "bg-white/5 text-neutral-500 border border-white/10";
}

export function nationalityFlag(raw: unknown): string {
  const code = normalizeNationality(raw);
  if (code === "SGP" || code === "SG") return "🇸🇬";
  if (code === "MAS" || code === "MY") return "🇲🇾";
  if (code === "INA" || code === "ID") return "🇮🇩";
  if (code === "THA" || code === "TH") return "🇹🇭";
  if (code === "PHI" || code === "PH") return "🇵🇭";
  if (code === "CHN" || code === "CN") return "🇨🇳";
  if (code === "HKG" || code === "HK") return "🇭🇰";
  if (code === "AUS" || code === "AU") return "🇦🇺";
  if (code === "JPN" || code === "JP") return "🇯🇵";
  if (code === "KOR" || code === "KR") return "🇰🇷";
  if (code === "NZL" || code === "NZ") return "🇳🇿";
  if (code === "USA" || code === "US") return "🇺🇸";
  if (code === "GBR" || code === "GB") return "🇬🇧";
  return "🏳️";
}

export function nationalityLabel(raw: unknown): string {
  const code = normalizeNationality(raw);
  if (!code) return "—";
  if (code === "SGP" || code === "SG") return "Singapore";
  const label = nationalityLabelForCode(code);
  if (label && label !== "—" && label.includes("—")) {
    return label.split("—")[1]!.trim();
  }
  return code;
}

export function initials(name: string) {
  const parts = String(name || "")
    .trim()
    .split(/\s+/)
    .filter(Boolean);
  if (!parts.length) return "?";
  if (parts.length === 1) return parts[0].slice(0, 2).toUpperCase();
  return (parts[0][0] + parts[parts.length - 1][0]).toUpperCase();
}

export function formatFullDob(ymd: string): string | null {
  if (!/^\d{4}-\d{2}-\d{2}$/.test(ymd)) return null;
  const months = [
    "Jan",
    "Feb",
    "Mar",
    "Apr",
    "May",
    "Jun",
    "Jul",
    "Aug",
    "Sep",
    "Oct",
    "Nov",
    "Dec",
  ];
  const d = Number(ymd.slice(8, 10));
  const m = months[Number(ymd.slice(5, 7)) - 1] || ymd.slice(5, 7);
  return `${d} ${m} ${ymd.slice(0, 4)}`;
}
