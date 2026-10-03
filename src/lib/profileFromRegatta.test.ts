import { describe, expect, it } from "vitest";
import {
  buildProfilePatchFromRow,
  shouldApplyProfileFromRegatta,
  shouldApplySailNumberFromRegatta,
} from "./profileFromRegatta";

describe("profileFromRegatta", () => {
  it("allows first result", () => {
    expect(
      shouldApplyProfileFromRegatta({
        regattaDate: "2026-03-01",
        latestResultDate: null,
      })
    ).toBe(true);
  });

  it("allows equal or newer regatta", () => {
    expect(
      shouldApplyProfileFromRegatta({
        regattaDate: "2026-06-01",
        latestResultDate: "2026-03-01",
      })
    ).toBe(true);
    expect(
      shouldApplyProfileFromRegatta({
        regattaDate: "2026-03-01",
        latestResultDate: "2026-03-01",
      })
    ).toBe(true);
  });

  it("blocks older regatta", () => {
    expect(
      shouldApplyProfileFromRegatta({
        regattaDate: "2026-01-01",
        latestResultDate: "2026-06-01",
      })
    ).toBe(false);
  });

  it("class-specific sail dates are independent", () => {
    expect(
      shouldApplySailNumberFromRegatta({
        regattaDate: "2026-01-01",
        boatClass: "ILCA 4",
        latestOptimistDate: "2026-06-01",
        latestIlca4Date: null,
      })
    ).toBe(true);
    expect(
      shouldApplySailNumberFromRegatta({
        regattaDate: "2026-01-01",
        boatClass: "Optimist",
        latestOptimistDate: "2026-06-01",
        latestIlca4Date: null,
      })
    ).toBe(false);
  });

  it("buildProfilePatch never clears with empty sheet", () => {
    const { patch, changed } = buildProfilePatchFromRow(
      { sailNumber: "", club: null, school: "", boatClass: "Optimist" },
      { sailNumber: "SGP 1", club: "CSC", school: "RI" },
      true,
      true
    );
    expect(changed).toEqual([]);
    expect(patch).toEqual({});
  });

  it("updates optimist sail when different", () => {
    const { patch, changed } = buildProfilePatchFromRow(
      { sailNumber: "SGP 99", club: "CSC", school: null, boatClass: "Optimist" },
      { sailNumber: "SGP 1", club: "CSC", school: "RI" },
      true,
      true
    );
    expect(changed).toContain("sailNumber");
    expect(patch.sailNumber).toBe("99");
    expect(patch.club).toBeUndefined();
  });

  it("updates ILCA 4 sail into sailNumberIlca4", () => {
    const { patch, changed } = buildProfilePatchFromRow(
      { sailNumber: "SGP 200", boatClass: "ILCA 4" },
      { sailNumber: "SGP 1", sailNumberIlca4: null },
      false,
      true
    );
    expect(changed).toEqual(["sailNumberIlca4"]);
    expect(patch.sailNumberIlca4).toBe("SGP 200");
    expect(patch.sailNumber).toBeUndefined();
  });

  it("writes Techno 293, iQFOiL, and WingFoil plates into boardNumber", () => {
    for (const boatClass of ["Techno 293", "Techno 293+", "iQFOiL", "Wing Foil"]) {
      const { patch, changed } = buildProfilePatchFromRow(
        { sailNumber: "S24", boatClass },
        { sailNumber: "711", sailNumberIlca4: "219111", boardNumber: null },
        false,
        true
      );
      expect(changed).toEqual(["boardNumber"]);
      expect(patch.boardNumber).toBe("S24");
      expect(patch.sailNumber).toBeUndefined();
      expect(patch.sailNumberIlca4).toBeUndefined();
    }
  });

  it("keeps board dates independent of Optimist and ILCA 4", () => {
    expect(
      shouldApplySailNumberFromRegatta({
        regattaDate: "2026-01-01",
        boatClass: "WingFoil",
        latestOptimistDate: "2026-06-01",
        latestIlca4Date: "2026-06-01",
        latestBoardDate: null,
      })
    ).toBe(true);
    expect(
      shouldApplySailNumberFromRegatta({
        regattaDate: "2026-01-01",
        boatClass: "Optimist",
        latestOptimistDate: "2026-06-01",
        latestIlca4Date: null,
        latestBoardDate: null,
      })
    ).toBe(false);
    expect(
      shouldApplySailNumberFromRegatta({
        regattaDate: "2025-01-01",
        boatClass: "iQFOiL",
        latestOptimistDate: null,
        latestIlca4Date: null,
        latestBoardDate: "2026-03-01",
      })
    ).toBe(false);
  });

  it("still stores 29er sail numbers on the Optimist field", () => {
    const { patch, changed } = buildProfilePatchFromRow(
      { sailNumber: "SGP 12", boatClass: "29er" },
      { sailNumber: "1", boardNumber: "45" },
      false,
      true
    );
    expect(changed).toEqual(["sailNumber"]);
    expect(patch.sailNumber).toBe("12");
    expect(patch.boardNumber).toBeUndefined();
  });
});
