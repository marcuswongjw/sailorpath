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

  it("omits a best finish when every result is DNS", () => {
    expect(
      buildSailorResultsBio("Alex Tan", [
        { regattaName: "Harbour Regatta", regattaDate: "2025-04-02", boatClass: "Optimist", rank: 20, isDns: true },
      ])
    ).toBe("Alex Tan first raced at Harbour Regatta on 2 Apr 2025. Class sailed: Optimist.");
  });
});
