/**
 * Admin results list shape (from listResults / API), not always full DB row.
 */
export type ResultAdmin = {
  id: string;
  sailorId: string;
  regattaId: string;
  entryLabel?: string | null;
  entrySailNumber?: string | null;
  entryBoardNumber?: string | null;
  entryType?: "individual" | "crew" | null;
  participants?: ResultParticipantAdmin[];
  rank: number;
  nettScore?: number | null;
  totalScore?: number | null;
  isDns?: boolean | null;
  /** Alias used in some admin UI paths */
  isDNS?: boolean | null;
  isOverseasCommitment?: boolean | null;
  sailorName?: string | null;
  regattaName?: string | null;
  createdAt?: Date | string | null;
  updatedAt?: Date | string | null;
  /** Loaded only when includeRaces=1 is requested. */
  raceResults?: OfficialRaceResultInput[];
};
import type { OfficialRaceResultInput } from "@/types/raceResult";

export type ResultParticipantAdmin = {
  id?: string;
  sailorId: string | null;
  sailorName?: string | null;
  sailorHandle?: string | null;
  sourceName: string;
  displayOrder: number;
  role: "solo" | "helm" | "crew" | "member" | "unknown";
  matchStatus?: "matched" | "needs_review" | "unresolved";
  rankingCredit?: boolean;
};
