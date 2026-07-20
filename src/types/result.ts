/**
 * Admin results list shape (from listResults / API), not always full DB row.
 */
export type ResultAdmin = {
  id: string;
  sailorId: string;
  regattaId: string;
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
};
