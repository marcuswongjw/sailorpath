import { describe, expect, it } from "vitest";
import { buildCoachInviteEmail } from "./coachInviteNotify";

describe("buildCoachInviteEmail", () => {
  it("includes accept and decline links for the token", () => {
    const email = buildCoachInviteEmail({ name: "Alex Tan", token: "abc 123" });
    expect(email?.subject).toBe("Accept or decline coach access on SailorPath");
    expect(email?.text).toContain("Hi Alex Tan,");
    expect(email?.text).toContain(
      "https://sailorpath.com/account/coach-invite?token=abc%20123&action=accept"
    );
    expect(email?.text).toContain(
      "https://sailorpath.com/account/coach-invite?token=abc%20123&action=decline"
    );
  });

  it("skips when the token is missing", () => {
    expect(buildCoachInviteEmail({ token: "  " })).toBeNull();
  });
});
