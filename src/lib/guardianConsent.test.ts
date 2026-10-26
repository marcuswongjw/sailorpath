import { describe, expect, it } from "vitest";
import { requiresGuardianConsent } from "./guardianConsent";
describe("guardian age boundary", () => {
  it.each([null, undefined, "", "unknown", "2000-02-31", "2100-01-01"])("requires consent for an unknown/invalid age: %s", (dob) => {
    expect(requiresGuardianConsent(dob, new Date("2026-10-26T00:00:00Z"))).toBe(true);
  });
  it("keeps the guard until the eighteenth birthday in Singapore", () => {
    expect(requiresGuardianConsent("2008-10-27", new Date("2026-10-26T15:59:59Z"))).toBe(true);
    expect(requiresGuardianConsent("2008-10-27", new Date("2026-10-26T16:00:00Z"))).toBe(false);
    expect(requiresGuardianConsent("2008-12-31", new Date("2026-10-26T00:00:00Z"))).toBe(true);
  });
});
