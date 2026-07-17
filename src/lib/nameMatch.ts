/**
 * Name matching helpers for regatta import + duplicate detection.
 * Handles case, extra spaces, and jumbled word order
 * (e.g. "Lee Thian Tsek Bryan" vs "Bryan Lee Thian Tsek").
 */

export function normalizeName(n: string): string {
  return n
    .trim()
    .toLowerCase()
    .replace(/[^a-z0-9\s'-]/g, " ")
    .replace(/\s+/g, " ")
    .trim();
}

/** Sorted tokens — same person regardless of given/family name order */
export function nameTokenKey(n: string): string {
  return normalizeName(n)
    .split(/[\s'-]+/)
    .filter((t) => t.length > 0)
    .sort()
    .join(" ");
}

/** Jaccard-ish overlap of name tokens (0–1) */
export function nameTokenSimilarity(a: string, b: string): number {
  const ta = new Set(
    normalizeName(a)
      .split(/[\s'-]+/)
      .filter((t) => t.length > 1)
  );
  const tb = new Set(
    normalizeName(b)
      .split(/[\s'-]+/)
      .filter((t) => t.length > 1)
  );
  if (!ta.size || !tb.size) return 0;
  let inter = 0;
  for (const t of ta) if (tb.has(t)) inter++;
  const union = ta.size + tb.size - inter;
  return union === 0 ? 0 : inter / union;
}

export type SailorMatchRow = {
  id: string;
  name: string;
};

export type DuplicatePair = {
  a: SailorMatchRow & { sailNumber?: string | null };
  b: SailorMatchRow & { sailNumber?: string | null };
  similarity: number;
  how: string;
};

/**
 * Find pairs of sailors that look like the same person (jumbled names, near-duplicates).
 */
export function findDuplicateSailorPairs(
  sailors: (SailorMatchRow & { sailNumber?: string | null })[],
  minSimilarity = 0.72
): DuplicatePair[] {
  const pairs: DuplicatePair[] = [];
  for (let i = 0; i < sailors.length; i++) {
    for (let j = i + 1; j < sailors.length; j++) {
      const a = sailors[i];
      const b = sailors[j];
      if (!a.name?.trim() || !b.name?.trim()) continue;

      if (nameTokenKey(a.name) === nameTokenKey(b.name)) {
        pairs.push({ a, b, similarity: 1, how: "same-name-tokens" });
        continue;
      }
      if (normalizeName(a.name) === normalizeName(b.name)) {
        pairs.push({ a, b, similarity: 1, how: "same-normalized-name" });
        continue;
      }
      const sim = nameTokenSimilarity(a.name, b.name);
      if (sim >= minSimilarity) {
        pairs.push({
          a,
          b,
          similarity: Math.round(sim * 100) / 100,
          how: "fuzzy-name",
        });
        continue;
      }
      // Same sail number (non-placeholder) with moderate name overlap
      const sa = (a.sailNumber || "").trim();
      const sb = (b.sailNumber || "").trim();
      if (
        sa &&
        sb &&
        sa === sb &&
        !/^SGP\s*0+$/i.test(sa) &&
        sim >= 0.4
      ) {
        pairs.push({
          a,
          b,
          similarity: Math.round(sim * 100) / 100,
          how: "same-sail-number",
        });
      }
    }
  }
  pairs.sort((x, y) => y.similarity - x.similarity);
  return pairs;
}

/**
 * Find best sailor for a raw import name.
 * 1) exact  2) case-insensitive  3) token-order key  4) high token overlap
 */
export function findSailorByName(
  rawName: string,
  sailors: SailorMatchRow[],
  aliases: { sailorId: string; aliasName: string }[] = []
): { sailor: SailorMatchRow; how: string } | null {
  const raw = rawName.trim();
  if (!raw) return null;
  const norm = normalizeName(raw);
  const key = nameTokenKey(raw);

  const byId = new Map(sailors.map((s) => [s.id, s]));

  // Alias exact / token key
  for (const a of aliases) {
    if (a.aliasName === raw || normalizeName(a.aliasName) === norm) {
      const s = byId.get(a.sailorId);
      if (s) return { sailor: s, how: "alias" };
    }
    if (nameTokenKey(a.aliasName) === key) {
      const s = byId.get(a.sailorId);
      if (s) return { sailor: s, how: "alias-tokens" };
    }
  }

  for (const s of sailors) {
    if (s.name === raw) return { sailor: s, how: "exact" };
  }
  for (const s of sailors) {
    if (normalizeName(s.name) === norm) return { sailor: s, how: "case" };
  }
  for (const s of sailors) {
    if (nameTokenKey(s.name) === key) return { sailor: s, how: "tokens" };
  }

  // High token overlap (e.g. missing middle name)
  let best: SailorMatchRow | null = null;
  let bestSim = 0;
  for (const s of sailors) {
    const sim = nameTokenSimilarity(raw, s.name);
    if (sim > bestSim) {
      bestSim = sim;
      best = s;
    }
  }
  // Require strong overlap: at least 2 shared tokens or sim >= 0.75
  if (best && bestSim >= 0.75) {
    return { sailor: best, how: `fuzzy:${bestSim.toFixed(2)}` };
  }
  const rawTokens = new Set(
    normalizeName(raw)
      .split(/[\s'-]+/)
      .filter((t) => t.length > 1)
  );
  if (best && bestSim >= 0.5) {
    const bestTokens = new Set(
      normalizeName(best.name)
        .split(/[\s'-]+/)
        .filter((t) => t.length > 1)
    );
    let shared = 0;
    for (const t of rawTokens) if (bestTokens.has(t)) shared++;
    if (shared >= 2 && bestSim >= 0.55) {
      return { sailor: best, how: `fuzzy-shared:${shared}` };
    }
  }

  return null;
}

export function suggestSailorByName(
  rawName: string,
  sailors: SailorMatchRow[]
): { id: string; name: string; similarity: number } | null {
  let best: SailorMatchRow | null = null;
  let bestSim = 0;
  for (const s of sailors) {
    const sim = Math.max(
      nameTokenSimilarity(rawName, s.name),
      nameTokenKey(rawName) === nameTokenKey(s.name) ? 1 : 0
    );
    if (sim > bestSim) {
      bestSim = sim;
      best = s;
    }
  }
  if (best && bestSim >= 0.35) {
    return { id: best.id, name: best.name, similarity: bestSim };
  }
  return null;
}
