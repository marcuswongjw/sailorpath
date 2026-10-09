import { describe, expect, it } from "vitest";
import {
  canonicalBoatClass,
  matchesSailingClass,
  requiresExplicitImportMetadata,
  resolveSailingClass,
  supportsNationalRanking,
} from "./classRegistry";

describe("classRegistry", () => {
  it("normalizes approved aliases without merging board disciplines", () => {
    expect(canonicalBoatClass("Laser 4.7")).toBe("ILCA 4");
    expect(canonicalBoatClass("Laser Radial")).toBe("ILCA 6");
    expect(canonicalBoatClass("Laser Standard")).toBe("ILCA 7");
    expect(canonicalBoatClass("iQFoil")).toBe("iQFOiL");
    expect(canonicalBoatClass("Wing Foil")).toBe("WingFoil");
    expect(canonicalBoatClass("T293")).toBe("Techno 293");

    expect(resolveSailingClass("Windfoil")?.key).toBe("windsurfing");
    expect(resolveSailingClass("Windsurfing LT")?.key).toBe("windsurfing");
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
