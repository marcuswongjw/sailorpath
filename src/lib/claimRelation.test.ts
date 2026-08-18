import { describe, expect, it } from "vitest";
import {
  parseClaimRelation,
  profileRoleFromRelation,
  relationFromNote,
  relationLabel,
} from "./claimRelation";

describe("claimRelation", () => {
  it("parses known relations", () => {
    expect(parseClaimRelation("parent")).toBe("parent");
    expect(parseClaimRelation("SAILOR")).toBe("sailor");
    expect(parseClaimRelation("other")).toBe("other");
    expect(parseClaimRelation("coach")).toBeNull();
  });

  it("reads relation prefix from legacy notes", () => {
    expect(relationFromNote("[parent] Hello")).toBe("parent");
    expect(relationFromNote("[sailor] me")).toBe("sailor");
    expect(relationFromNote("no prefix")).toBeNull();
  });

  it("maps approve roles without demoting coach/other", () => {
    expect(profileRoleFromRelation("parent")).toBe("parent");
    expect(profileRoleFromRelation("sailor")).toBe("sailor");
    expect(profileRoleFromRelation("other")).toBeNull();
  });

  it("labels relations for admin UI", () => {
    expect(relationLabel("parent")).toMatch(/Parent/);
    expect(relationLabel(null)).toBe("—");
  });
});
