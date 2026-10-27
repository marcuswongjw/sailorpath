import { describe, expect, it, vi } from "vitest";

const state = vi.hoisted(() => ({ rows: [] as object[] }));
vi.mock("@/db", () => ({ getDatabaseUrlMeta: () => true }));
vi.mock("@/lib/queries", () => ({
  getCachedPublicRegattas: async () => state.rows,
  getResultsForRegatta: async () => [],
  getCachedSailorByHandle: vi.fn(), getCachedResultsForSailor: vi.fn(), getRegattaBySlug: vi.fn(),
}));

import { resolveFleetResultSheet } from "./publicShareData";

describe("canonical and legacy Class A/B scorecards", () => {
  it.each([[7, 13, "optimist-class-b"], [7, 7, "optimist-class-a"]])(
    "retains the former classless destination with race counts %s/%s",
    async (aRaces, bRaces, legacyKey) => {
      state.rows = ["a", "b"].map((fleet, index) => ({ id: fleet, slug: `japan-class-${fleet}`,
        name: `Japan Optimist (Class ${fleet.toUpperCase()})`, boatClass: "Optimist",
        division: `Class ${fleet.toUpperCase()}`, date: "2026-08-21", eventSlug: "japan-2026",
        raceCount: index === 0 ? aRaces : bRaces, totalFleetSize: index === 0 ? 87 : 22 }));
      expect((await resolveFleetResultSheet("japan-2026", "optimist"))?.sheet.canonicalPath)
        .toBe(`/regattas/japan-2026/results/${legacyKey}`);
      for (const fleet of ["a", "b"]) {
        expect((await resolveFleetResultSheet("japan-2026", `optimist-class-${fleet}`))?.sheet.canonicalPath)
          .toBe(`/regattas/japan-2026/results/optimist-class-${fleet}`);
      }
    }
  );
});
