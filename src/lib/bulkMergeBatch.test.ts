import { describe, expect, it } from "vitest";
import { planBulkMergeBatch } from "@/lib/bulkMergeBatch";

describe("planBulkMergeBatch", () => {
  const byScore = (scores: Record<string, number>) => (a: { id: string }, b: { id: string }) =>
    scores[b.id] - scores[a.id];

  it("queues every duplicate in a group and reports the ones left for later", () => {
    const plan = planBulkMergeBatch(
      [[{ id: "a" }, { id: "b" }, { id: "c" }]],
      byScore({ a: 3, b: 2, c: 1 }),
      15
    );
    expect(plan.batch).toEqual([
      { survivor: { id: "a" }, duplicate: { id: "b" } },
    ]);
    expect(plan.hasMore).toBe(true);
  });

  it("does not report more work when the batch is exactly the cap", () => {
    const groups = Array.from({ length: 15 }, (_, index) => [
      { id: `keep-${index}` },
      { id: `drop-${index}` },
    ]);
    const plan = planBulkMergeBatch(groups, () => 0, 15);
    expect(plan.batch).toHaveLength(15);
    expect(plan.hasMore).toBe(false);
  });

  it("reports more work when a group remains past the cap", () => {
    const groups = Array.from({ length: 16 }, (_, index) => [
      { id: `keep-${index}` },
      { id: `drop-${index}` },
    ]);
    const plan = planBulkMergeBatch(groups, () => 0, 15);
    expect(plan.batch).toHaveLength(15);
    expect(plan.hasMore).toBe(true);
  });
});
