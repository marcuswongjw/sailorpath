import { afterEach, describe, expect, it } from "vitest";
import {
  isConfiguredSuperadminEmail,
  superadminRoleDecision,
} from "@/lib/superadminEmail";

describe("superadmin email bootstrap", () => {
  const previous = process.env.SUPERADMIN_EMAIL;

  afterEach(() => {
    if (previous === undefined) delete process.env.SUPERADMIN_EMAIL;
    else process.env.SUPERADMIN_EMAIL = previous;
  });

  it("matches the configured email ignoring case and surrounding space", () => {
    process.env.SUPERADMIN_EMAIL = " Admin@SailorPath.com ";
    expect(isConfiguredSuperadminEmail("admin@sailorpath.com")).toBe(true);
    expect(isConfiguredSuperadminEmail("other@sailorpath.com")).toBe(false);
    expect(isConfiguredSuperadminEmail(null)).toBe(false);
  });

  it("does not grant superadmin until the role is stored", () => {
    process.env.SUPERADMIN_EMAIL = "admin@sailorpath.com";
    expect(superadminRoleDecision(null, "admin@sailorpath.com")).toEqual({
      role: "superadmin",
      persistSuperadmin: true,
    });
    expect(superadminRoleDecision("parent", "admin@sailorpath.com")).toEqual({
      role: "superadmin",
      persistSuperadmin: true,
    });
    expect(superadminRoleDecision("superadmin", "admin@sailorpath.com")).toEqual({
      role: "superadmin",
      persistSuperadmin: false,
    });
    expect(superadminRoleDecision("coach", "sailor@sailorpath.com")).toEqual({
      role: "coach",
      persistSuperadmin: false,
    });
  });

  it("leaves a missing profile as sailor when the email is not configured", () => {
    delete process.env.SUPERADMIN_EMAIL;
    expect(superadminRoleDecision(null, "admin@sailorpath.com")).toEqual({
      role: "sailor",
      persistSuperadmin: false,
    });
  });
});
