import { describe, expect, it } from "vitest";
import { parseViewAs, resolveProfileAccess } from "./viewAs";

describe("parseViewAs", () => {
  it("defaults to admin", () => {
    expect(parseViewAs(null)).toBe("admin");
    expect(parseViewAs("")).toBe("admin");
    expect(parseViewAs("nope")).toBe("admin");
  });
  it("accepts parent", () => {
    expect(parseViewAs("parent")).toBe("parent");
    expect(parseViewAs("PARENT")).toBe("parent");
  });
});

describe("resolveProfileAccess", () => {
  const uid = "user-1";
  const kid = "sailor-1";

  it("parent mode: superadmin only owns linked kids", () => {
    const a = resolveProfileAccess({
      userId: uid,
      role: "superadmin",
      viewAs: "parent",
      sailorParentId: uid,
    });
    expect(a.isOwner).toBe(true);
    expect(a.canSeePrivate).toBe(true);
    expect(a.canClaim).toBe(false);
    expect(a.isParentMode).toBe(true);

    const b = resolveProfileAccess({
      userId: uid,
      role: "superadmin",
      viewAs: "parent",
      sailorParentId: kid,
    });
    expect(b.isOwner).toBe(false);
    expect(b.canSeePrivate).toBe(false);
  });

  it("parent mode: superadmin can claim unclaimed profile", () => {
    const a = resolveProfileAccess({
      userId: uid,
      role: "superadmin",
      viewAs: "parent",
      sailorParentId: null,
    });
    expect(a.canClaim).toBe(true);
    expect(a.isOwner).toBe(false);
  });

  it("admin mode: superadmin sees private but is not owner of unlinked", () => {
    const a = resolveProfileAccess({
      userId: uid,
      role: "superadmin",
      viewAs: "admin",
      sailorParentId: kid,
    });
    expect(a.isOwner).toBe(false);
    expect(a.canSeePrivate).toBe(true);
    expect(a.canClaim).toBe(false);
  });

  it("normal parent role", () => {
    const a = resolveProfileAccess({
      userId: uid,
      role: "parent",
      viewAs: "admin",
      sailorParentId: uid,
    });
    expect(a.isOwner).toBe(true);
    expect(a.canSeePrivate).toBe(true);
  });
});
