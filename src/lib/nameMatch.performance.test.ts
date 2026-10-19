import { describe, expect, it } from "vitest";
import { combinedNameSimilarity, findDuplicateSailorPairs, nameTokenKey, normalizeName } from "./nameMatch";

// Independent, unpruned reference for the original score, including duplicate
// tokens, single-character tokens, 64-character edit limits and rounding.
function referenceSimilarity(a: string, b: string) {
  if (!a.trim() || !b.trim()) return 0;
  const keyA = nameTokenKey(a), keyB = nameTokenKey(b);
  if (keyA === keyB || normalizeName(a) === normalizeName(b)) return 1;
  const tokens = (name: string) => normalizeName(name).split(/[\s'-]+/).filter(t => t.length > 1);
  const ta = tokens(a), tb = tokens(b), sa = new Set(ta), sb = new Set(tb);
  const intersection = [...sa].filter(t => sb.has(t)).length;
  const union = sa.size + sb.size - intersection;
  const jaccard = union ? intersection / union : 0;
  const [short, long] = ta.length <= tb.length ? [ta, sb] : [tb, sa];
  const containment = short.length ? short.filter(t => long.has(t)).length / short.length : 0;
  const s = keyA.replace(/\s/g, "").slice(0, 64), t = keyB.replace(/\s/g, "").slice(0, 64);
  const dp = Array.from({ length: s.length + 1 }, (_, i) => Array.from({ length: t.length + 1 }, (_, j) => i === 0 ? j : j === 0 ? i : 0));
  for (let i = 1; i <= s.length; i++) for (let j = 1; j <= t.length; j++) {
    dp[i][j] = Math.min(dp[i - 1][j] + 1, dp[i][j - 1] + 1, dp[i - 1][j - 1] + Number(s[i - 1] !== t[j - 1]));
  }
  const edit = s.length || t.length ? 1 - dp[s.length][t.length] / Math.max(s.length, t.length) : 1;
  const raw = Math.max(jaccard, containment * 0.95, edit * 0.9, jaccard * 0.6 + containment * 0.4);
  return Math.min(1, Math.round((containment >= 1 && jaccard < 1 ? Math.min(raw, 0.74) : raw) * 1000) / 1000);
}
const base = ["", " ", "!!!", "A", "B", "Alice Tan", "Tan Alice", "Alice Tan Wei", "Tan Tan Alice", "Álice Tan", "O'Neill Smith", "x".repeat(80), "y".repeat(80)];
const names = [...base, ...Array.from({ length: 40 }, (_, i) => `${["Benjamin", "Charlotte", "Daniel", "Elizabeth"][i % 4]} ${["Williams", "Thompson", "Anderson"][i % 3]} ${i}`)];
const roster = names.map((name, id) => ({ id: String(id), name }));

describe("optimized duplicate scanning preserves identity suggestions", () => {
  it("matches the original score across punctuation, repeated tokens, blank and long names", () => {
    for (const a of names) for (const b of names) {
      expect(combinedNameSimilarity(a, b), `${a} / ${b}`).toBe(referenceSimilarity(a, b));
    }
  });
  it.each([0, 0.5995, 0.6, 0.74, 0.75, 0.8, 1])("preserves every pair and its score at threshold %s", threshold => {
    const expected = [];
    for (let i = 0; i < roster.length; i++) for (let j = i + 1; j < roster.length; j++) {
      if (!roster[i].name.trim() || !roster[j].name.trim()) continue;
      const score = referenceSimilarity(roster[i].name, roster[j].name);
      if (score >= threshold) expected.push({ a: roster[i].id, b: roster[j].id, score: Math.round(score * 100) / 100 });
    }
    expected.sort((a, b) => b.score - a.score);
    const actual = findDuplicateSailorPairs(roster, threshold).map(p => ({ a: p.a.id, b: p.b.id, score: p.similarity }));
    expect(actual).toEqual(expected);
  });
});
