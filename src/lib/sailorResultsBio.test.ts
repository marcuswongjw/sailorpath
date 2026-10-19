import { describe, expect, it } from "vitest";
import { buildSailorResultsBio } from "./sailorResultsBio";

describe("buildSailorResultsBio", () => {
  it("describes the first regatta, classes, and best finish in each class", () => {
    const bio = buildSailorResultsBio("Kimberly Tan", [
      {
        regattaName: "NSC Cup 2026",
        regattaDate: "2026-01-18",
        boatClass: "Optimist",
        rank: 56,
        isDns: true,
        fleetSize: 80,
      },
      {
        regattaName: "Singapore National Championship 2026",
        regattaDate: "2026-06-15",
        boatClass: "Optimist",
        rank: 1,
        fleetSize: 92,
      },
      {
        regattaName: "CSC ILCA Open 2026",
        regattaDate: "2026-07-05",
        boatClass: "ILCA 4",
        rank: 4,
        fleetSize: 30,
      },
      {
        regattaName: "Changi ILCA Training Series 2026",
        regattaDate: "2026-03-08",
        boatClass: "ILCA 4",
        rank: 5,
        fleetSize: 22,
      },
    ]);

    expect(bio).toBe(
      "Kimberly Tan first raced at NSC Cup 2026 on 18 Jan 2026. Classes sailed: Optimist and ILCA 4. Best finishes: 1st of 92 in Optimist at Singapore National Championship 2026 and 4th of 30 in ILCA 4 at CSC ILCA Open 2026."
    );
  });

  it("returns null when there are no named results", () => {
    expect(buildSailorResultsBio("Alex", [])).toBeNull();
    expect(buildSailorResultsBio("Alex", [{ regattaName: "  ", rank: 1 }])).toBeNull();
  });

  it("does not call a weak-results-only record best finishes", () => {
    const bio = buildSailorResultsBio("Alex Tan", [
      {
        regattaName: "Harbour Regatta",
        regattaDate: "2026-01-10",
        boatClass: "ILCA 4",
        rank: 46,
        fleetSize: 49,
      },
      {
        regattaName: "CSC Open",
        regattaDate: "2026-03-02",
        boatClass: "ILCA 4",
        rank: 40,
        fleetSize: 42,
      },
    ]);

    expect(bio).toBe(
      "Alex Tan first raced at Harbour Regatta on 10 Jan 2026. Class sailed: ILCA 4. Most recent results: 40th of 42 at CSC Open and 46th of 49 at Harbour Regatta."
    );
    expect(bio).not.toMatch(/best finish/i);
  });

  it("keeps best-finish wording for a strong result and omits a weak class", () => {
    const bio = buildSailorResultsBio("Alex Tan", [
      {
        regattaName: "National Championship",
        regattaDate: "2026-02-01",
        boatClass: "Optimist",
        rank: 1,
        fleetSize: 20,
      },
      {
        regattaName: "CSC ILCA Open",
        regattaDate: "2026-03-01",
        boatClass: "ILCA 4",
        rank: 46,
        fleetSize: 49,
      },
    ]);

    expect(bio).toContain("Best finish: 1st of 20 in Optimist at National Championship.");
    expect(bio).not.toContain("46th");
    expect(bio).not.toMatch(/best finishes/i);
  });

  it("chooses the best finish by fleet share rather than raw place", () => {
    const bio = buildSailorResultsBio("Alex Tan", [
      {
        regattaName: "Small Fleet",
        regattaDate: "2026-01-01",
        boatClass: "ILCA 4",
        rank: 2,
        fleetSize: 10,
      },
      {
        regattaName: "Large Fleet",
        regattaDate: "2026-02-01",
        boatClass: "ILCA 4",
        rank: 8,
        fleetSize: 100,
      },
    ]);

    expect(bio).toContain("Best finish: 8th of 100 at Large Fleet.");
    expect(bio).not.toContain("2nd of 10");
  });

  it("omits a best finish when every result is DNS", () => {
    expect(
      buildSailorResultsBio("Alex Tan", [
        { regattaName: "Harbour Regatta", regattaDate: "2025-04-02", boatClass: "Optimist", rank: 20, isDns: true },
      ])
    ).toBe("Alex Tan first raced at Harbour Regatta on 2 Apr 2025. Class sailed: Optimist.");
  });
});
