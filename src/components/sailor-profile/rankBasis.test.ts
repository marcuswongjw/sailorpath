import { describe, expect, it } from "vitest";
import { describeProfileRank } from "./rankBasis";

describe("describeProfileRank", () => {
  it("labels an ILCA rank on the managed list as official", () => {
    const rank = describeProfileRank({
      boatClass: "ilca4",
      standing: {
        overallRank: 12,
        fleetSize: 36,
        periodLabel: "ILCA 4 · ranking as of 2026-09-30",
        fleet: "Open",
        rankBasis: "official-list",
        unrestricted: false,
      },
    });
    expect(rank.hasRank).toBe(true);
    expect(rank.rankLabel).toBe("12 of 36");
    expect(rank.basisLabel).toBe("Official national list");
    expect(rank.cycleLabel).toBe("ranking as of 2026-09-30");
    expect(rank.basisDetail).toMatch(/managed ILCA 4 national ranking list/i);
  });

  it("labels a results-board ILCA rank as recorded results", () => {
    const rank = describeProfileRank({
      boatClass: "ilca4",
      standing: {
        overallRank: 20,
        fleetSize: 80,
        periodLabel: "ILCA 4 · ranking as of 2026-09-30",
        unrestricted: true,
      },
    });
    expect(rank.basisLabel).toBe("Recorded results");
    expect(rank.basisDetail).toMatch(/not on the managed/i);
  });

  it("uses the Optimist series label and a real empty state", () => {
    const ranked = describeProfileRank({
      boatClass: "optimist",
      standing: {
        overallRank: 4,
        fleetSize: 68,
        periodLabel: "Jul – Dec 2026",
        fleet: "Gold",
      },
    });
    expect(ranked.basisLabel).toBe("Gold fleet series");
    expect(ranked.rankLabel).toBe("4 of 68");

    const empty = describeProfileRank({
      boatClass: "ilca4",
      standing: null,
    });
    expect(empty.hasRank).toBe(false);
    expect(empty.emptyMessage).toBe(
      "No ranked ILCA 4 results for this series yet."
    );
  });
});
