import { describe, expect, it, vi } from "vitest";
import { canManageSailor } from "./claimAccess";

vi.mock("@/db", () => ({
  db: {
    select: vi.fn(() => ({
      from: vi.fn(() => ({
        where: vi.fn(() => ({
          limit: vi.fn().mockResolvedValue([{ id: "claim-1" }]),
        })),
      })),
    })),
  },
}));

describe("canManageSailor", () => {
  it("allows superadmin unconditionally", async () => {
    expect(await canManageSailor("sailor-1", "user-admin", true)).toBe(true);
    expect(await canManageSailor("sailor-1", null, true)).toBe(true);
  });

  it("denies unauthenticated or empty sailorId", async () => {
    expect(await canManageSailor("", "user-1", false)).toBe(false);
    expect(await canManageSailor("sailor-1", null, false)).toBe(false);
    expect(await canManageSailor("sailor-1", undefined, false)).toBe(false);
  });

  it("allows primary linked parent directly via knownParentId", async () => {
    expect(await canManageSailor("sailor-1", "user-parent-1", false, "user-parent-1")).toBe(true);
  });
});
