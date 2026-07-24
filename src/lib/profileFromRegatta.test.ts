import { describe, expect, it } from "vitest";
import {
  buildProfilePatchFromRow,
  shouldApplyProfileFromRegatta,
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

  it("buildProfilePatch never clears with empty sheet", () => {
    const { patch, changed } = buildProfilePatchFromRow(
      { sailNumber: "", club: null, school: "" },
      { sailNumber: "SGP 1", club: "CSC", school: "RI" },
      true
    );
    expect(changed).toEqual([]);
    expect(patch).toEqual({});
  });

  it("updates sail when different", () => {
    const { patch, changed } = buildProfilePatchFromRow(
      { sailNumber: "SGP 99", club: "CSC", school: null },
      { sailNumber: "SGP 1", club: "CSC", school: "RI" },
      true
    );
    expect(changed).toContain("sailNumber");
    expect(patch.sailNumber).toBe("SGP 99");
    expect(patch.club).toBeUndefined();
  });
});
