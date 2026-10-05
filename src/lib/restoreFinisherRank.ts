type FinishRow = {
  rank: number;
  nettScore: number | null;
  isDns: boolean;
  isOverseasCommitment?: boolean | null;
};

function finiteNett(value: number | null | undefined): number | null {
  if (typeof value !== "number" || !Number.isFinite(value)) return null;
  return value;
}

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
    const nett = finiteNett(row.nettScore);
    if (nett != null && nett < bestNett) bestNett = nett;
  }
  if (!Number.isFinite(bestNett)) return rows.slice();

  const winners = rows.filter((row) => finiteNett(row.nettScore) === bestNett);
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

/**
 * A blank nett is not a score of 0. When one DNS sailor in last place has no
 * nett, and every other nett is a positive score, the old display treated the
 * blank as a win. Leave the saved place and return that sailor for an admin
 * to enter the nett.
 */
export function blankNettWouldShowAsWin<T extends FinishRow>(
  rows: readonly T[]
): T[] {
  if (rows.length < 2) return [];
  const blanks = rows.filter(
    (row) =>
      row.isDns &&
      !row.isOverseasCommitment &&
      finiteNett(row.nettScore) == null
  );
  if (blanks.length !== 1) return [];
  const blank = blanks[0];
  const otherMaxRank = rows.reduce(
    (max, row) => (row === blank ? max : Math.max(max, row.rank)),
    0
  );
  if (blank.rank <= otherMaxRank) return [];
  for (const row of rows) {
    if (row === blank) continue;
    const nett = finiteNett(row.nettScore);
    if (nett == null || nett <= 0) return [];
  }
  return [blank];
}
