/**
 * Optimist Gold fleet — Nat A / Nat B shortlist preview from series ranking.
 *
 * Policy (preview only, ranking-based):
 * - Ranking period = season just ending before the intake.
 *   Jan Y intake → Jul–Dec (Y−1) Gold Best 3 of 5.
 * - Nat A shortlist: Gold ranks 1–15
 * - Nat B shortlist: Gold ranks 16–30
 * - SGP nationality preferred for display flag; non-SGP still listed with note.
 *
 * Official squad assignment remains admin-managed on sailor nat_squad_* fields.
 */

import type { RankedSailor } from "@/lib/ranking";
import { isSingaporeNationality } from "@/lib/ilca4NationalList";

export type OptimistSquadTier = "Nat A" | "Nat B";

export type OptimistSquadPick = {
  sailorId: string;
  name: string;
  handle?: string | null;
  gender: string | null;
  rankingPosition: number;
  overallScore: number;
  tier: OptimistSquadTier;
  nationality: string | null;
  isSgp: boolean;
  /** Current stored squad for the ranking period (if any) */
  currentPeriodSquad: string | null;
};

export const OPTIMIST_SQUAD_POLICY = {
  natARanks: { from: 1, to: 15 },
  natBRanks: { from: 16, to: 30 },
  activeGoldCap: 100,
  notes:
    "Preview only: Nat A = Gold ranks 1–15, Nat B = ranks 16–30 on Best 3 of 5 for the ranking half before intake. Official Nat A/B assignment is set on each sailor’s period squad field.",
} as const;

/**
 * Ranking period used to seed January intake national squads.
 * Jan 2027 intake → Jul–Dec 2026 Gold ranking.
 */
export function rankingPeriodForJanuaryIntake(intakeYear: number): {
  year: number;
  half: "Jul-Dec";
  label: string;
} {
  return {
    year: intakeYear - 1,
    half: "Jul-Dec",
    label: `Jul – Dec ${intakeYear - 1} (for January ${intakeYear} intake)`,
  };
}

export function selectOptimistNatSquadPreview(
  goldRanked: RankedSailor[],
  opts?: { natATo?: number; natBTo?: number }
): OptimistSquadPick[] {
  const natATo = opts?.natATo ?? OPTIMIST_SQUAD_POLICY.natARanks.to;
  const natBTo = opts?.natBTo ?? OPTIMIST_SQUAD_POLICY.natBRanks.to;

  const out: OptimistSquadPick[] = [];
  goldRanked.forEach((s, i) => {
    const rankingPosition = i + 1;
    if (rankingPosition > natBTo) return;
    const tier: OptimistSquadTier =
      rankingPosition <= natATo ? "Nat A" : "Nat B";
    const nationality =
      (s as { nationality?: string | null }).nationality ?? null;
    out.push({
      sailorId: s.id,
      name: s.name,
      handle: s.handle,
      gender: s.gender ?? null,
      rankingPosition,
      overallScore: s.overallScore,
      tier,
      nationality,
      isSgp: isSingaporeNationality(nationality),
      currentPeriodSquad: s.periodSquadStatus ?? null,
    });
  });
  return out;
}
