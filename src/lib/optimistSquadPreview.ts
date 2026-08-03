/**
 * National Junior Training Squad — Optimist ‘A’ and ‘B’ (Appendix I).
 *
 * - Each squad ≤ 16 sailors.
 * - A places are not eligible for B.
 * - All sailors must be ≤ 15 years old in the intake year (age as of 31 Dec intake year).
 * - Ranking: National Optimist Gold Best 3 of last 5, as of:
 *     a) 30 June for July intake
 *     b) 20 December for January intake
 *
 * Nat A (in order):
 *   1. Top 8 ranked males
 *   2. Top 8 ranked females
 *
 * Nat B (from remaining, in order):
 *   3. Top 2 M + top 2 F who are 13 in intake year
 *   4. Top 3 M + top 3 F who are 12 in intake year
 *   5. Top 3 M + top 3 F who are ≤ 11 in intake year
 * Unfilled age buckets → next highest ranked same gender (still ≤ 15).
 */

import { ageYears, birthYear } from "@/lib/age";
import type { Period, RankedSailor } from "@/lib/ranking";
import { isSingaporeNationality } from "@/lib/ilca4NationalList";

export type OptimistSquadTier = "Nat A" | "Nat B";

export type OptimistSquadPickReason =
  | "top8_male"
  | "top8_female"
  | "age13"
  | "age12"
  | "age11_or_under"
  | "fill_same_gender";

export type OptimistSquadPick = {
  sailorId: string;
  name: string;
  handle?: string | null;
  gender: "M" | "F";
  rankingPosition: number;
  overallScore: number;
  tier: OptimistSquadTier;
  reason: OptimistSquadPickReason;
  ageInIntakeYear: number | null;
  birthYear: number | null;
  nationality: string | null;
  isSgp: boolean;
  currentPeriodSquad: string | null;
};

export type OptimistIntakeKind = "july" | "january";

export const OPTIMIST_SQUAD_POLICY = {
  maxPerSquad: 16,
  maxAgeInIntakeYear: 15,
  activeGoldCap: 100,
  notes:
    "National Junior Training Squad Optimist A/B (≤16 each). Ranking = Gold Best 3 of 5 as of 30 Jun (July intake) or 20 Dec (January intake). A: top 8 M + top 8 F. B (from remainder): age-13 (2M+2F), age-12 (3M+3F), age ≤11 (3M+3F); fill unfilled with next same gender. All must be ≤15 in intake year. A places excluded from B.",
} as const;

/** Ranking cutoff + series period for squad selection. */
export function optimistSquadCutoff(
  kind: OptimistIntakeKind,
  intakeYear: number
): {
  asOf: string;
  intakeYear: number;
  /** Series half used for Best 3 of 5 window */
  period: Period;
  label: string;
} {
  if (kind === "july") {
    return {
      asOf: `${intakeYear}-06-30`,
      intakeYear,
      period: { year: intakeYear, half: "Jan-Jun" },
      label: `July ${intakeYear} intake · Gold ranking as of 30 Jun ${intakeYear}`,
    };
  }
  const asOfYear = intakeYear - 1;
  return {
    asOf: `${asOfYear}-12-20`,
    intakeYear,
    period: { year: asOfYear, half: "Jul-Dec" },
    label: `January ${intakeYear} intake · Gold ranking as of 20 Dec ${asOfYear}`,
  };
}

/** @deprecated use optimistSquadCutoff */
export function rankingPeriodForJanuaryIntake(intakeYear: number): {
  year: number;
  half: "Jul-Dec";
  label: string;
} {
  const c = optimistSquadCutoff("january", intakeYear);
  return {
    year: c.period.year,
    half: "Jul-Dec",
    label: c.label,
  };
}

export function ageInIntakeYear(
  dob: string | Date | null | undefined,
  intakeYear: number
): number | null {
  const d =
    typeof dob === "string"
      ? dob.slice(0, 10)
      : dob
        ? dob.toISOString().slice(0, 10)
        : null;
  if (!d || !/^\d{4}-\d{2}-\d{2}$/.test(d)) return null;
  return ageYears(d, new Date(`${intakeYear}-12-31T12:00:00`));
}

function normalizeGender(g: string | null | undefined): "M" | "F" | null {
  const s = String(g || "")
    .trim()
    .toLowerCase();
  if (s === "f" || s === "female" || s === "girl" || s === "w" || s === "woman")
    return "F";
  if (s === "m" || s === "male" || s === "boy" || s === "man") return "M";
  return null;
}

type Eligible = RankedSailor & {
  rankingPosition: number;
  ageInIntakeYear: number | null;
  genderNorm: "M" | "F";
};

/**
 * Select Nat A then Nat B shortlists from ordered Gold ranking (1 = best).
 * `goldRanked` must already be sorted Best 3 of 5 (lower overall better).
 */
export function selectOptimistNatSquadPreview(
  goldRanked: RankedSailor[],
  intakeYear: number
): OptimistSquadPick[] {
  const eligible: Eligible[] = [];
  goldRanked.forEach((s, i) => {
    const genderNorm = normalizeGender(s.gender);
    if (!genderNorm) return;
    const age = ageInIntakeYear(s.dob, intakeYear);
    if (age != null && age > OPTIMIST_SQUAD_POLICY.maxAgeInIntakeYear) return;
    eligible.push({
      ...s,
      rankingPosition: i + 1,
      ageInIntakeYear: age,
      genderNorm,
    });
  });

  const picked = new Set<string>();
  const out: OptimistSquadPick[] = [];

  const toPick = (
    s: Eligible,
    tier: OptimistSquadTier,
    reason: OptimistSquadPickReason
  ): OptimistSquadPick => {
    const nationality =
      (s as { nationality?: string | null }).nationality ?? null;
    return {
      sailorId: s.id,
      name: s.name,
      handle: s.handle,
      gender: s.genderNorm,
      rankingPosition: s.rankingPosition,
      overallScore: s.overallScore,
      tier,
      reason,
      ageInIntakeYear: s.ageInIntakeYear,
      birthYear: birthYear(s.dob),
      nationality,
      isSgp: isSingaporeNationality(nationality),
      currentPeriodSquad: s.periodSquadStatus ?? null,
    };
  };

  const take = (
    list: Eligible[],
    n: number,
    tier: OptimistSquadTier,
    reason: OptimistSquadPickReason
  ) => {
    let taken = 0;
    for (const s of list) {
      if (taken >= n) break;
      if (picked.has(s.id)) continue;
      picked.add(s.id);
      out.push(toPick(s, tier, reason));
      taken++;
    }
    return n - taken; // remaining unfilled
  };

  const males = eligible.filter((s) => s.genderNorm === "M");
  const females = eligible.filter((s) => s.genderNorm === "F");

  // ── Nat A ──────────────────────────────────────────────
  take(males, 8, "Nat A", "top8_male");
  take(females, 8, "Nat A", "top8_female");

  // ── Nat B (exclude A) ──────────────────────────────────
  const remM = males.filter((s) => !picked.has(s.id));
  const remF = females.filter((s) => !picked.has(s.id));

  // 3) Age 13: 2M + 2F
  let needM = take(
    remM.filter((s) => s.ageInIntakeYear === 13),
    2,
    "Nat B",
    "age13"
  );
  let needF = take(
    remF.filter((s) => s.ageInIntakeYear === 13),
    2,
    "Nat B",
    "age13"
  );

  // 4) Age 12: 3M + 3F
  needM += take(
    remM.filter((s) => s.ageInIntakeYear === 12 && !picked.has(s.id)),
    3,
    "Nat B",
    "age12"
  );
  needF += take(
    remF.filter((s) => s.ageInIntakeYear === 12 && !picked.has(s.id)),
    3,
    "Nat B",
    "age12"
  );

  // 5) Age ≤ 11: 3M + 3F
  needM += take(
    remM.filter(
      (s) =>
        s.ageInIntakeYear != null &&
        s.ageInIntakeYear <= 11 &&
        !picked.has(s.id)
    ),
    3,
    "Nat B",
    "age11_or_under"
  );
  needF += take(
    remF.filter(
      (s) =>
        s.ageInIntakeYear != null &&
        s.ageInIntakeYear <= 11 &&
        !picked.has(s.id)
    ),
    3,
    "Nat B",
    "age11_or_under"
  );

  // Fill unfilled B slots with next highest same gender (≤15 already enforced)
  take(
    remM.filter((s) => !picked.has(s.id)),
    needM,
    "Nat B",
    "fill_same_gender"
  );
  take(
    remF.filter((s) => !picked.has(s.id)),
    needF,
    "Nat B",
    "fill_same_gender"
  );

  // Cap each squad at 16
  const a = out.filter((p) => p.tier === "Nat A").slice(0, 16);
  const b = out.filter((p) => p.tier === "Nat B").slice(0, 16);
  return [...a, ...b];
}
