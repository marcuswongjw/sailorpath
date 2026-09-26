import { describe, expect, it } from "vitest";
import { buildAdminOverview } from "./adminOverview";

const complete = {
  id: "sheet-1",
  name: "Example Optimist",
  slug: "example-optimist",
  date: "2026-06-01",
  totalFleetSize: 20,
  division: "Gold",
  raceCount: 3,
  boatClass: "Optimist",
  countsForRanking: true,
};

describe("buildAdminOverview", () => {
  it("uses publication readiness rules for actionable event counts", () => {
    const overview = buildAdminOverview(
      [complete],
      [{ id: "result-1", sailorId: "s1", regattaId: "sheet-1", rank: 1 }]
    );
    expect(overview.ready).toHaveLength(1);
    expect(overview.missingResults).toHaveLength(0);
  });

  it("treats zero races as known and does not report missing results", () => {
    const overview = buildAdminOverview([{ ...complete, raceCount: 0 }], []);
    expect(overview.ready[0]?.summary).toBe("publishable_non_ranking");
    expect(overview.missingResults).toHaveLength(0);
  });

  it("reports a raced sheet without score rows", () => {
    const overview = buildAdminOverview([complete], []);
    expect(overview.missingResults).toHaveLength(1);
    expect(overview.incomplete).toHaveLength(1);
  });
});
