import { describe, expect, it } from "vitest";
import { runInChunks } from "./runInChunks";

describe("runInChunks", () => {
  it("processes all items and preserves order of results", async () => {
    const seen: number[][] = [];
    const out = await runInChunks([1, 2, 3, 4, 5], 2, async (n) => {
      seen.push([n]);
      return n * 10;
    });
    expect(out).toEqual([10, 20, 30, 40, 50]);
    expect(seen.flat().sort()).toEqual([1, 2, 3, 4, 5]);
  });
});
