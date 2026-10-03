import { describe, expect, it } from "vitest";
import { buildAccountRoleChangeEmail } from "./roleChangeNotify";

describe("buildAccountRoleChangeEmail", () => {
  it("describes a sailor becoming a parent for a named sailor", () => {
    const email = buildAccountRoleChangeEmail({
      name: "May Tan",
      previousRole: "sailor",
      nextRole: "parent",
      sailorName: "Ava Tan",
      relation: "parent",
    });
    expect(email?.subject).toBe(
      "Your SailorPath account is now a Parent account"
    );
    expect(email?.text).toContain("Hi May Tan,");
    expect(email?.text).toContain("changed from Sailor to Parent");
    expect(email?.text).toContain("Parent / guardian for Ava Tan");
    expect(email?.text).toContain("https://sailorpath.com/account");
  });

  it("confirms a sailor approval when the account role stays Sailor", () => {
    const email = buildAccountRoleChangeEmail({
      name: "Ava Tan",
      previousRole: "sailor",
      nextRole: "sailor",
      sailorName: "Ava Tan",
      relation: "sailor",
    });
    expect(email?.subject).toBe("Your link to Ava Tan is approved");
    expect(email?.text).toContain("Your account role stays Sailor.");
    expect(email?.text).toContain("Sailor (self) for Ava Tan");
  });

  it("points a new coach at coach tools", () => {
    const email = buildAccountRoleChangeEmail({
      name: "Alex Tan",
      previousRole: "sailor",
      nextRole: "coach",
      relation: "coach",
    });
    expect(email?.subject).toBe(
      "Your SailorPath account is now a Coach account"
    );
    expect(email?.text).toContain("https://sailorpath.com/coach-tools");
  });

  it("tells a revoked coach that coach tools are gone", () => {
    const email = buildAccountRoleChangeEmail({
      name: "Alex Tan",
      previousRole: "coach",
      nextRole: "sailor",
    });
    expect(email?.text).toContain("changed from Coach to Sailor");
    expect(email?.text).toContain("Coach tools are no longer on this account.");
  });

  it("skips when nothing changed and there is no sailor link", () => {
    expect(
      buildAccountRoleChangeEmail({
        previousRole: "coach",
        nextRole: "coach",
      })
    ).toBeNull();
  });
});
