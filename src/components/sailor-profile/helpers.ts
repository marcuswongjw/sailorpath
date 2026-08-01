/**
 * Pure display helpers for sailor profile.
 */

import {
  seriesFleetStatus,
  normalizeNationality,
} from "@/lib/seriesMembership";

/** Cards match main page background (#090a0f); separation via border only */
export const PROFILE_CARD_CLASS =
  "rounded-2xl border border-white/[0.07] bg-[#090a0f]";

export function resolveDisplayFleet(sailor: Record<string, unknown>): {
  label: string;
  className: string;
} {
  const status = seriesFleetStatus(sailor as never);
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
  if (fleet === "Open" || fleet === "ILCA 4" || fleet === "ILCA 6") {
    return "bg-sky-500/15 text-sky-300 border border-sky-500/25";
  }
  return "bg-white/5 text-neutral-500 border border-white/10";
}

export function nationalityFlag(raw: unknown): string {
  const code = normalizeNationality(raw);
  if (code === "SGP") return "🇸🇬";
  if (code === "MAS") return "🇲🇾";
  if (code === "INA") return "🇮🇩";
  if (code === "THA") return "🇹🇭";
  if (code === "PHI") return "🇵🇭";
  if (code === "CHN") return "🇨🇳";
  if (code === "HKG") return "🇭🇰";
  if (code === "AUS") return "🇦🇺";
  return "🏳️";
}

export function nationalityLabel(raw: unknown): string {
  const code = normalizeNationality(raw);
  if (!code) return "—";
  if (code === "SGP") return "Singapore";
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
