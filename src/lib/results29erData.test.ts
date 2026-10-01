import { describe, expect, it } from "vitest";
import { getStatic29erResults, matchesCsc29erStaticSlug } from "@/lib/results29erData";

describe("CSC 29er static fallback", () => {
  it("keeps the 2026 29er sheet for a 29er-only slug", () => {
    expect(matchesCsc29erStaticSlug("csc-2026-29er")).toBe(true);
    expect(getStatic29erResults("csc-2026-29er")?.length).toBeGreaterThan(0);
  });

  it("does not treat the 2025 ILCA and 29er weekend as the 2026 29er sheet", () => {
    expect(matchesCsc29erStaticSlug("5th-csc-ilca-29er-open-2025")).toBe(false);
    expect(getStatic29erResults("5th-csc-ilca-29er-open-2025")).toBeNull();
  });
});
