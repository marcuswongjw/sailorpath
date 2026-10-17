import { describe, expect, it } from "vitest";
import { readFollowAction } from "./followRequest";

describe("readFollowAction", () => {
  it("keeps a JSON follow on the page", async () => {
    const action = await readFollowAction(
      new Request("https://sailorpath.com/api/following", {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({ sailorId: "sailor-1", intent: "follow" }),
      })
    );
    expect(action).toEqual({
      sailorId: "sailor-1",
      nextPath: "/following",
      intent: "follow",
      redirect: false,
    });
  });

  it("reads a form unfollow and keeps only a local return path", async () => {
    const body = new URLSearchParams({
      sailorId: "sailor-2",
      intent: "unfollow",
      next: "https://evil.example/phish",
    });
    const action = await readFollowAction(
      new Request("https://sailorpath.com/api/following", {
        method: "POST",
        headers: { "Content-Type": "application/x-www-form-urlencoded" },
        body,
      })
    );
    expect(action.sailorId).toBe("sailor-2");
    expect(action.intent).toBe("unfollow");
    expect(action.redirect).toBe(true);
    expect(action.nextPath).toBe("/following");
  });
});
