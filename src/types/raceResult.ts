export type OfficialRaceResultInput = {
  raceNumber: number;
  score: number;
  scoringCode: string | null;
  discarded: boolean;
  rawValue: string;
};
