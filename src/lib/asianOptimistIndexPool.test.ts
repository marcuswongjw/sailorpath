import { describe, expect, it } from "vitest";
import { selectPowerPool } from "./asianOptimistIndexPool";

describe("Asian Index Power Rating pool", () => {
  it("omits excluded ASAF fleets without removing other eligible published scorecards", () => {
    const regattas = [
      { slug: "asaf-cup-optimist-open-championships-2026-boys", date: "2026-08-05", endDate: "2026-08-10", raceCount: 8 },
      { slug: "asaf-cup-optimist-open-championships-2026-girls", date: "2026-08-05", endDate: "2026-08-10", raceCount: 8 },
      { slug: "another-published-event", date: "2026-09-01", endDate: null, raceCount: 4 },
      { slug: "too-few-races", date: "2026-10-01", endDate: null, raceCount: 2 },
    ];
    const excluded = new Set(regattas.slice(0, 2).map((regatta) => regatta.slug));
    expect(selectPowerPool(regattas, excluded, "2025-11-17").map((regatta) => regatta.slug))
      .toEqual(["another-published-event"]);
  });
});
