type FinishRow = {
  rank: number;
  nettScore: number | null;
  isDns: boolean;
  isOverseasCommitment?: boolean | null;
};

/**
 * A finisher can be stored as DNS with rank = fleet size + 1 while the
 * race scores and nett still show they won. When one sailor has the best
 * nett, is flagged DNS, and is ranked behind everyone else, put them back
 * in first and clear the DNS flag.
 */
export function restoreBestNettHiddenAsDns<T extends FinishRow>(
  rows: readonly T[]
): T[] {
  if (rows.length < 2) return rows.slice();

  let bestNett = Infinity;
  for (const row of rows) {
    const nett = Number(row.nettScore);
    if (Number.isFinite(nett) && nett < bestNett) bestNett = nett;
  }
  if (!Number.isFinite(bestNett)) return rows.slice();

  const winners = rows.filter((row) => Number(row.nettScore) === bestNett);
  if (winners.length !== 1) return rows.slice();

  const winner = winners[0];
  if (!winner.isDns || winner.isOverseasCommitment) return rows.slice();

  const otherMaxRank = rows.reduce(
    (max, row) => (row === winner ? max : Math.max(max, row.rank)),
    0
  );
  if (winner.rank <= otherMaxRank) return rows.slice();

  return rows
    .map((row) =>
      row === winner ? { ...row, rank: 1, isDns: false } : row
    )
    .sort((a, b) => a.rank - b.rank);
}

export function restoreBestNettHiddenAsDnsByRegatta<
  T extends FinishRow & { regattaId: string },
>(rows: readonly T[]): T[] {
  const groups = new Map<string, T[]>();
  for (const row of rows) {
    const list = groups.get(row.regattaId) || [];
    list.push(row);
    groups.set(row.regattaId, list);
  }
  const repaired: T[] = [];
  for (const group of groups.values()) {
    repaired.push(...restoreBestNettHiddenAsDns(group));
  }
  return repaired;
}
