import { describe, expect, it, vi } from "vitest";
import { crawlAndUpdateRegattas } from "./crawlRegattas";

vi.mock("@/db", () => ({
  db: {
    select: () => ({
      from: () => ({
        where: () => ({
          limit: () => Promise.resolve([]),
        }),
      }),
    }),
    insert: () => ({
      values: () => Promise.resolve(),
    }),
    update: () => ({
      set: () => ({
        where: () => Promise.resolve(),
      }),
    }),
  },
}));

vi.mock("@/lib/revalidatePublic", () => ({
  revalidatePublicRankings: vi.fn(),
}));

describe("crawlAndUpdateRegattas", () => {
  it("processes calendar sources and reports summary", async () => {
    const summary = await crawlAndUpdateRegattas();
    expect(summary.sourcesChecked.length).toBeGreaterThan(0);
    expect(summary.regattasProcessed).toBeGreaterThan(0);
    expect(typeof summary.newRegattasFound).toBe("number");
    expect(typeof summary.timestamp).toBe("string");
  });
});
