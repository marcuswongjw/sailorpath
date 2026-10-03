import { describe, expect, it } from "vitest";
import { buildSailorAssignmentInviteEmail } from "./sailorInviteNotify";

describe("buildSailorAssignmentInviteEmail", () => {
  it("asks the user to accept a parent assignment", () => {
    const email = buildSailorAssignmentInviteEmail({
      name: "May Tan",
      sailorName: "Ava Tan",
      relation: "parent",
    });
    expect(email?.subject).toBe("Accept your SailorPath link to Ava Tan");
    expect(email?.text).toContain("Hi May Tan,");
    expect(email?.text).toContain(
      "assigned Ava Tan to your account as Parent / guardian"
    );
    expect(email?.text).toContain("Accept the request: https://sailorpath.com/account");
  });

  it("skips when the sailor name is missing", () => {
    expect(
      buildSailorAssignmentInviteEmail({
        sailorName: "  ",
        relation: "sailor",
      })
    ).toBeNull();
  });
});
