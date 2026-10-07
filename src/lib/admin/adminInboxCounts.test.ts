import { describe, expect, it } from "vitest";
import { totalPendingAdminInboxItems } from "./adminInboxCounts";

describe("totalPendingAdminInboxItems", () => {
  it("sums actionable suggestions, claims, coach requests, and support messages", () => {
    expect(
      totalPendingAdminInboxItems({
        suggestions: 2,
        claims: 1,
        coaches: 3,
        support: 4,
      })
    ).toBe(10);
  });
});
