import { describe, expect, it } from "vitest";
import {
  canonicalBoatClass,
  publishedResultClasses,
  matchesSailingClass,
  requiresExplicitImportMetadata,
  resolveSailingClass,
  supportsNationalRanking,
} from "./classRegistry";

describe("classRegistry", () => {
  it("counts published result classes independently of featured hubs", () => {
    const rows = ["Windfoil", "WindFoil", "Windsurfing", "Windsurfing LT", "Wingfoil", "WingFoil", "iQFOiL", "29er", "420"]
      .map((boatClass) => ({boatClass, raceCount: 3, totalFleetSize: 10}));
    expect(publishedResultClasses([...rows, {boatClass: "Future class", raceCount: 0, totalFleetSize: 0}]))
      .toEqual(["29er", "420", "iQFOiL", "Windfoil", "Windsurfing", "Windsurfing LT", "WingFoil"].sort((a,b) => a.localeCompare(b)));
  });
  it("normalizes approved aliases without merging board disciplines", () => {
    expect(canonicalBoatClass("Laser 4.7")).toBe("ILCA 4");
    expect(canonicalBoatClass("Laser Radial")).toBe("ILCA 6");
    expect(canonicalBoatClass("Laser Standard")).toBe("ILCA 7");
    expect(canonicalBoatClass("iQFoil")).toBe("iQFOiL");
    expect(canonicalBoatClass("Wing Foil")).toBe("WingFoil");
    expect(canonicalBoatClass("T293")).toBe("Techno 293");

    expect(resolveSailingClass("Windfoil")?.key).toBe("windfoil");
    expect(resolveSailingClass("Windsurfing LT")?.key).toBe("windsurfing-lt");
    expect(resolveSailingClass("Windfoil")?.key).not.toBe("wingfoil");
    expect(resolveSailingClass("iQFOiL")?.key).not.toBe("wingfoil");
    expect(resolveSailingClass("Techno 293")?.key).not.toBe("iqfoil");
  });

  it("keeps ranking policy limited to the implemented classes", () => {
    expect(supportsNationalRanking("Optimist")).toBe(true);
    expect(supportsNationalRanking("ILCA 4")).toBe(true);
    expect(supportsNationalRanking("ILCA 6")).toBe(true);
    for (const boatClass of ["ILCA 7", "iQFOiL", "WingFoil", "Techno 293"]) {
      expect(supportsNationalRanking(boatClass)).toBe(false);
      expect(requiresExplicitImportMetadata(boatClass)).toBe(true);
    }
  });

  it("matches public filters only to the intended class", () => {
    expect(matchesSailingClass("iQ Foil", "iqfoil")).toBe(true);
    expect(matchesSailingClass("WingFoil", "iqfoil")).toBe(false);
    expect(matchesSailingClass("Windsurfing", "wingfoil")).toBe(false);
    expect(matchesSailingClass("Laser 4.7", "ilca")).toBe(true);
  });
});
