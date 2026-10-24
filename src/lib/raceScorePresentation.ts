import type { OfficialRaceResultInput } from "@/types/raceResult";

// Plain-language summaries of World Sailing RRS 2025–2028 Appendix A10.
// Event sailing instructions and official scoring decisions remain authoritative.
const CODE_MEANINGS: Readonly<Record<string, string>> = {
  DNC: "Absent from the starting area; no start recorded.",
  DNS: "No start recorded (excluding DNC and OCS).",
  OCS: "Start infringement involving the course side of the line or rule 30.1.",
  ZFP: "Rule 30.2 starting penalty of 20%.",
  UFD: "Excluded for a U-flag start infringement (rule 30.3).",
  BFD: "Excluded for a black-flag start infringement (rule 30.4).",
  SCP: "A scoring penalty was applied.",
  NSC: "Recorded for not sailing the course.",
  DNF: "No finish recorded.",
  RET: "Entry retired from the race.",
  DSQ: "Entry disqualified from the race.",
  DNE: "Disqualification that must remain in the series score.",
  RDG: "Redress awarded.",
  DPI: "Penalty chosen at the protest committee’s discretion.",
};

export function scoringCodeMeaning(code: string): string {
  return CODE_MEANINGS[code.trim().toUpperCase()] || "See the organiser’s scoring notes for this code.";
}

export function describeRaceScore(race: OfficialRaceResultInput | undefined, raceNumber: number): string {
  if (!race) return "Race " + raceNumber + ": score unavailable.";
  const value = race.rawValue || String(race.score);
  const parts = ["Race " + raceNumber + ": " + value + "."];
  if (race.discarded) parts.push("Discarded score.");
  if (race.scoringCode?.trim()) {
    const code = race.scoringCode.trim().toUpperCase();
    parts.push(code + ": " + scoringCodeMeaning(code));
  }
  return parts.join(" ");
}
