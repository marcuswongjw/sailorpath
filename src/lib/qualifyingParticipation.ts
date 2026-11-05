/**
 * Entrants in a shared qualifying series, where final fleet sheets are separate.
 * Keep final-fleet sizes intact: they are used for scoring and fleet placings.
 * Sources and audit scope: outputs/qualifying-participation-audit-2026-11-05/report.md.
 */
const qualifyingEntrants: Record<string, number> = {
  "eastern-seaboard-regatta-2026-optimist-gold": 135,
  "eastern-seaboard-regatta-2026-optimist-silver": 135,
  "trat-regatta-2026-optimist-gold": 40,
  "trat-regatta-2026-optimist-green": 40,
  "2025-musto-australian-optimist-championship-optimist-gold": 113,
  "2025-musto-australian-optimist-championship-optimist-silver": 113,
  "2026-musto-australian-optimist-championship-optimist-gold": 90,
  "2026-musto-australian-optimist-championship-optimist-silver": 90,
  "2026-ilca-oceania-australian-open-youth-championships-ilca4-gold": 77,
  "2026-ilca-oceania-australian-open-youth-championships-ilca4-silver": 77,
  "2026-ilca-oceania-australian-open-youth-championships-ilca6-gold": 74,
  "2026-ilca-oceania-australian-open-youth-championships-ilca6-silver": 74,
};

export function qualifyingParticipation(slug: string | null | undefined): number | null {
  return slug ? qualifyingEntrants[slug] ?? null : null;
}
