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
    expect(patch.sailNumber).toBe("SGP 99");
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
});
