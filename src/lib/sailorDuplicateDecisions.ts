export const duplicatePairKey = (a: string, b: string) => [a, b].sort().join("|");

export type SailorDuplicateDecision = {
  pairKey: string;
  aId: string;
  bId: string;
  aName: string;
  bName: string;
  reason: string;
};
