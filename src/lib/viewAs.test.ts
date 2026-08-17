import { describe, expect, it } from "vitest";
import { parseViewAs, resolveProfileAccess } from "./viewAs";

describe("parseViewAs", () => {
  it("always returns admin (parent mode removed)", () => {
    expect(parseViewAs(null)).toBe("admin");
    expect(parseViewAs("")).toBe("admin");
    expect(parseViewAs("parent")).toBe("admin");
    expect(parseViewAs("PARENT")).toBe("admin");
  });
});

describe("resolveProfileAccess", () => {
  const uid = "user-1";
  const kid = "sailor-1";

  it("superadmin only owns linked kids", () => {
    const a = resolveProfileAccess({
      userId: uid,
      role: "superadmin",
      sailorParentId: uid,
    });
    expect(a.isOwner).toBe(true);
    expect(a.canSeePrivate).toBe(true);
    expect(a.canClaim).toBe(false);
    expect(a.isParentMode).toBe(false);

    const b = resolveProfileAccess({
      userId: uid,
      role: "superadmin",
      sailorParentId: kid,
    });
    expect(b.isOwner).toBe(false);
    expect(b.canSeePrivate).toBe(true); // admin can see private
    expect(b.canClaim).toBe(false);
  });

  it("superadmin cannot claim via profile UI", () => {
    const a = resolveProfileAccess({
      userId: uid,
      role: "superadmin",
      sailorParentId: null,
    });
    expect(a.canClaim).toBe(false);
    expect(a.isOwner).toBe(false);
  });

  it("normal parent role", () => {
    const a = resolveProfileAccess({
      userId: uid,
      role: "parent",
      sailorParentId: uid,
    });
    expect(a.isOwner).toBe(true);
    expect(a.canSeePrivate).toBe(true);
  });

  it("signed-in user can claim unclaimed", () => {
    const a = resolveProfileAccess({
      userId: uid,
      role: "sailor",
      sailorParentId: null,
    });
    expect(a.canClaim).toBe(true);
  });
});
