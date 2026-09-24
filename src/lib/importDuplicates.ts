import { combinedNameSimilarity } from "@/lib/nameMatch";
import type { ImportPossibleDuplicate } from "@/types/import";

export const MAX_DUPLICATE_FLAGS = 40;

/** Pairwise similar names within an import sheet (60%+). Cap pairs for speed. */
export function findWithinFileDuplicates(
  names: string[],
  minSimilarity = 0.6,
  maxPairs = MAX_DUPLICATE_FLAGS
): ImportPossibleDuplicate[] {
  const out: ImportPossibleDuplicate[] = [];
  const seen = new Set<string>();
  const list = names.slice(0, 120);
  for (let i = 0; i < list.length; i++) {
    for (let j = i + 1; j < list.length; j++) {
      if (out.length >= maxPairs) {
        return out.sort((x, y) => y.similarity - x.similarity);
      }
      const a = list[i];
      const b = list[j];
      if (!a || !b || a === b) continue;
      const sim = combinedNameSimilarity(a, b);
      if (sim < minSimilarity) continue;
      const key = [a, b]
        .map((n) => n.toLowerCase())
        .sort()
        .join("|");
      if (seen.has(key)) continue;
      seen.add(key);
      out.push({
        kind: "within-file",
        importName: a,
        otherName: b,
        similarity: Math.round(sim * 100) / 100,
        band: sim >= 0.8 ? "high" : "medium",
        note: "Two rows in this file look like the same sailor",
      });
    }
  }
  return out.sort((x, y) => y.similarity - x.similarity);
}
