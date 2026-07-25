/**
 * Pure display helpers for SailorProfileView.
 */

import {
  seriesFleetStatus,
  seriesStatusBadge,
} from "@/lib/seriesMembership";

export function resolveDisplayFleet(sailor: {
  currentFleet?: string | null;
  goldEntryDate?: string | null;
  silverEntryDate?: string | null;
  dropDate?: string | null;
  [key: string]: unknown;
}): { label: string; className: string } {
  return seriesStatusBadge(seriesFleetStatus(sailor));
}

export const SQUAD_HISTORY_SLOTS: { key: string; label: string }[] = [
  { key: "natSquadStatusJan25", label: "Jan – Jun 2025" },
  { key: "natSquadStatusJul25", label: "Jul – Dec 2025" },
  { key: "natSquadStatusJan26", label: "Jan – Jun 2026" },
  { key: "natSquadStatusJul26", label: "Jul – Dec 2026" },
];

export function buildHonorTags(sailor: {
  natSquadStatusJul26?: string | null;
  nationalSquadStatus?: string | null;
  natSquadStatusJan26?: string | null;
  worlds?: string | number | null;
  european?: string | number | null;
  asian?: string | number | null;
  seaGames?: string | number | null;
}): { text: string; className: string }[] {
  const tags: { text: string; className: string }[] = [];
  const squad =
    sailor.natSquadStatusJul26 ||
    sailor.nationalSquadStatus ||
    sailor.natSquadStatusJan26;
  if (squad) {
    tags.push({
      text: `Nat Squad (current): ${squad}`,
      className:
        "bg-orange-500/10 text-orange-300 border border-orange-500/25",
    });
  }
  if (sailor.worlds) {
    tags.push({
      text: `World Optimist Championships ${sailor.worlds}`,
      className: "bg-red-500/10 text-red-400 border border-red-500/20",
    });
  }
  if (sailor.european) {
    tags.push({
      text: `European Optimist Championships ${sailor.european}`,
      className: "bg-blue-500/10 text-blue-300 border border-blue-500/20",
    });
  }
  if (sailor.asian) {
    tags.push({
      text: `Asian Optimist Championships ${sailor.asian}`,
      className:
        "bg-emerald-500/10 text-emerald-400 border border-emerald-500/20",
    });
  }
  if (sailor.seaGames) {
    tags.push({
      text: `SEA Games ${sailor.seaGames}`,
      className: "bg-violet-500/10 text-violet-300 border border-violet-500/20",
    });
  }
  return tags;
}

export function initials(name: string): string {
  const parts = String(name || "")
    .trim()
    .split(/\s+/)
    .filter(Boolean);
  if (!parts.length) return "?";
  if (parts.length === 1) return parts[0].slice(0, 2).toUpperCase();
  return (parts[0][0] + parts[parts.length - 1][0]).toUpperCase();
}
