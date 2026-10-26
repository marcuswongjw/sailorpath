import { birthYear } from "@/lib/age";
import type { PublicRegattaResult } from "@/lib/queries";

/** Allow-list applied to DB, cached and static fallback scorecards alike. */
export function toPublicRegattaResult(row: PublicRegattaResult & { dob?: string | null }): PublicRegattaResult {
  return {
    resultId: row.resultId, sailorId: row.sailorId, regattaId: row.regattaId,
    rank: row.rank, nettScore: row.nettScore, totalScore: row.totalScore,
    isDns: row.isDns, isOverseasCommitment: row.isOverseasCommitment,
    sailorName: row.sailorName, sailNumber: row.sailNumber, handle: row.handle,
    gender: row.gender || row.sailorGender || null,
    birthYear: row.birthYear ?? birthYear(row.dob),
    nationality: row.nationality || row.sailorNationality || null,
    entryLabel: row.entryLabel, entrySailNumber: row.entrySailNumber,
    entryBoardNumber: row.entryBoardNumber, entryType: row.entryType,
    profileClaimed: row.profileClaimed,
    participants: row.participants?.map((member) => ({
      id: member.id, resultId: member.resultId, sailorId: member.sailorId,
      sailorName: member.sailorName, handle: member.handle, sourceName: member.sourceName,
      displayOrder: member.displayOrder, role: member.role, matchStatus: member.matchStatus,
      rankingCredit: member.rankingCredit, profileClaimed: member.profileClaimed,
    })),
    raceResults: row.raceResults.map((race) => ({
      regattaResultId: race.regattaResultId, raceNumber: race.raceNumber,
      score: race.score, rawValue: race.rawValue,
      scoringCode: race.scoringCode, discarded: race.discarded,
    })),
  };
}
