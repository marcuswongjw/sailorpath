type BestThreeSelectionOptions = {
  higherIsBetter?: boolean;
  excludedIndexes?: ReadonlySet<number>;
};

/**
 * Return the positions of the three finite scores used in a Best 3 calculation.
 * Original order breaks equal-score ties so exactly three real events are marked.
 */
export function bestThreeSelectedIndexes(
  scores: readonly (number | null | undefined)[],
  options: BestThreeSelectionOptions = {}
): ReadonlySet<number> {
  const { higherIsBetter = false, excludedIndexes } = options;
  const candidates = scores
    .map((score, index) => ({ score, index }))
    .filter(
      (item): item is { score: number; index: number } =>
        Number.isFinite(item.score) && !excludedIndexes?.has(item.index)
    )
    .sort((a, b) => {
      const scoreOrder = higherIsBetter
        ? b.score - a.score
        : a.score - b.score;
      return scoreOrder || a.index - b.index;
    });

  return new Set(candidates.slice(0, 3).map(({ index }) => index));
}
