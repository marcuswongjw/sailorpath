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

function nameTokens(n: string): string[] {
  return normalizeName(n)
    .split(/[\s'-]+/)
    .filter((t) => t.length > 1);
}

/** Jaccard-ish overlap of name tokens (0–1) */
export function nameTokenSimilarity(a: string, b: string): number {
  const ta = new Set(nameTokens(a));
  const tb = new Set(nameTokens(b));
  if (!ta.size || !tb.size) return 0;
  let inter = 0;
  for (const t of ta) if (tb.has(t)) inter++;
  const union = ta.size + tb.size - inter;
  return union === 0 ? 0 : inter / union;
}

/** Fraction of tokens in the shorter name that appear in the longer (containment). */
function nameContainment(a: string, b: string): number {
  const ta = nameTokens(a);
  const tb = nameTokens(b);
  if (!ta.length || !tb.length) return 0;
  const [short, long] =
    ta.length <= tb.length ? [ta, new Set(tb)] : [tb, new Set(ta)];
  let hit = 0;
  for (const t of short) if (long.has(t)) hit++;
  return hit / short.length;
}

/** Simple Levenshtein similarity 0–1 on compact strings (max len 64). */
function stringSimilarity(a: string, b: string): number {
  const s = a.slice(0, 64);
  const t = b.slice(0, 64);
  if (!s.length && !t.length) return 1;
  if (!s.length || !t.length) return 0;
  if (s === t) return 1;
  const m = s.length;
  const n = t.length;
  const row = new Array(n + 1);
  for (let j = 0; j <= n; j++) row[j] = j;
  for (let i = 1; i <= m; i++) {
    let prev = row[0];
    row[0] = i;
    for (let j = 1; j <= n; j++) {
      const tmp = row[j];
      const cost = s[i - 1] === t[j - 1] ? 0 : 1;
      row[j] = Math.min(row[j] + 1, row[j - 1] + 1, prev + cost);
      prev = tmp;
    }
  }
  const dist = row[n];
  const maxLen = Math.max(m, n);
  return 1 - dist / maxLen;
}

/**
 * Combined name similarity 0–1 for duplicate detection / import.
 * Uses exact token key, jaccard, containment, and edit distance on token keys.
 */
export function combinedNameSimilarity(a: string, b: string): number {
  if (!a?.trim() || !b?.trim()) return 0;
  const keyA = nameTokenKey(a);
  const keyB = nameTokenKey(b);
  if (keyA === keyB) return 1;
  if (normalizeName(a) === normalizeName(b)) return 1;

  const jaccard = nameTokenSimilarity(a, b);
  const containment = nameContainment(a, b);
  const edit = stringSimilarity(keyA.replace(/\s/g, ""), keyB.replace(/\s/g, ""));
  // Weight: token overlap is primary; containment helps missing middle names
  const score = Math.max(
    jaccard,
    containment * 0.95,
    edit * 0.9,
    (jaccard * 0.6 + containment * 0.4)
  );
  return Math.min(1, Math.round(score * 1000) / 1000);
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
  /** Confidence band for UI: high >= 0.8, medium >= 0.6 */
  band: "high" | "medium";
};

/**
 * Find pairs of sailors that look like the same person.
 * Default threshold 0.60 — UI should highlight 60%+ matches.
 */
export function findDuplicateSailorPairs(
  sailors: (SailorMatchRow & { sailNumber?: string | null })[],
  minSimilarity = 0.6
): DuplicatePair[] {
  const pairs: DuplicatePair[] = [];
  for (let i = 0; i < sailors.length; i++) {
    for (let j = i + 1; j < sailors.length; j++) {
      const a = sailors[i];
      const b = sailors[j];
      if (!a.name?.trim() || !b.name?.trim()) continue;

      let sim = combinedNameSimilarity(a.name, b.name);
      let how = "fuzzy-name";

      if (nameTokenKey(a.name) === nameTokenKey(b.name)) {
        sim = 1;
        how = "same-name-tokens";
      } else if (normalizeName(a.name) === normalizeName(b.name)) {
        sim = 1;
        how = "same-normalized-name";
      }

      // Same sail number (non-placeholder) boosts score
      const sa = (a.sailNumber || "").trim();
      const sb = (b.sailNumber || "").trim();
      if (
        sa &&
        sb &&
        sa === sb &&
        !/^SGP\s*0+$/i.test(sa)
      ) {
        sim = Math.max(sim, Math.min(1, sim + 0.25));
        how = sim >= 0.6 ? "same-sail-number+name" : "same-sail-number";
        if (sim < minSimilarity && sim >= 0.5) {
          // Still surface same sail with moderate name overlap
          sim = Math.max(sim, 0.6);
        }
      }

      if (sim < minSimilarity) continue;

      pairs.push({
        a,
        b,
        similarity: Math.round(sim * 100) / 100,
        how,
        band: sim >= 0.8 ? "high" : "medium",
      });
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

  let best: SailorMatchRow | null = null;
  let bestSim = 0;
  for (const s of sailors) {
    const sim = combinedNameSimilarity(raw, s.name);
    if (sim > bestSim) {
      bestSim = sim;
      best = s;
    }
  }
  if (best && bestSim >= 0.75) {
    return { sailor: best, how: `fuzzy:${bestSim.toFixed(2)}` };
  }
  if (best && bestSim >= 0.55 && nameContainment(raw, best.name) >= 0.66) {
    return { sailor: best, how: `fuzzy-contain:${bestSim.toFixed(2)}` };
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
    const sim = combinedNameSimilarity(rawName, s.name);
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
