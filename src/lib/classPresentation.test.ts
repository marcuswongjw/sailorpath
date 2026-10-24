import { describe, expect, it } from "vitest";
import { classDisplayLabels, classFilterKey, classFilterLabel, classFilterMatches, classFilterOptions, sailingClassDisplayLabel } from "./classPresentation";

describe("public class presentation", () => {
  it("combines spelling aliases while retaining distinct board disciplines and ILCA rigs", () => {
    expect(classFilterOptions(["Wingfoil", "WingFoil", "Wing Foil", "WindFoil", "Windfoil", "iQ Foil", "Windsurfing", "Windsurfing LT", "ILCA 4", "Laser Radial", "ILCA 7", "All"]))
      .toEqual(["ILCA 4", "ILCA 6", "ILCA 7", "iQFOiL", "Windfoil", "Windsurfing", "Windsurfing LT", "WingFoil"].sort((a, b) => a.localeCompare(b)));
  });
  it("preserves fleet and category suffixes in visible labels", () => {
    expect(sailingClassDisplayLabel("Wing Foil (U19)")).toBe("WingFoil (U19)");
    expect(sailingClassDisplayLabel("WindFoil - Women")).toBe("Windfoil - Women");
    expect(sailingClassDisplayLabel("Optimist Gold")).toBe("Optimist Gold");
    expect(sailingClassDisplayLabel("Techno 293+")).toBe("Techno 293+");
    expect(classDisplayLabels(["Wingfoil", "WingFoil", "Optimist Gold", "Optimist Silver"])).toEqual(["WingFoil", "Optimist Gold", "Optimist Silver"]);
  });
  it("accepts old filter addresses without including neighbouring disciplines", () => {
    expect(classFilterLabel("Wingfoil")).toBe("WingFoil");
    expect(classFilterKey("Wing Foil")).toBe("wingfoil");
    expect(classFilterKey("ILCA")).toBe("ilca");
    expect(classFilterMatches("Wing Foil (U19)", "wingfoil")).toBe(true);
    expect(classFilterMatches("WindFoil", "Windfoil")).toBe(true);
    expect(classFilterMatches("Wingfoil", "Windfoil")).toBe(false);
    expect(classFilterMatches("ILCA 6", "ILCA 4")).toBe(false);
    expect(classFilterMatches("Laser Standard", "ILCA 7")).toBe(true);
  });
  it("keeps unknown classes and unspecified ILCA intact", () => {
    expect(sailingClassDisplayLabel("RS Feva")).toBe("RS Feva");
    expect(classFilterLabel("ILCA")).toBe("ILCA");
    expect(classFilterMatches("ILCA 7", "ILCA")).toBe(true);
    expect(classFilterMatches("RS Feva", "rs feva")).toBe(true);
    expect(classFilterOptions(["RS Feva", "rs feva", "ILCA", "ILCA 4"])).toEqual(["ILCA", "ILCA 4", "RS Feva"]);
  });
});
