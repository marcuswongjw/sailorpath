import { afterEach, describe, expect, it, vi } from "vitest";
import {
  buildFollowerPublishNotices,
  deliverFollowerPublishNotices,
} from "@/lib/followNotify";
import { sendResendTextEmail } from "@/lib/notifications";

describe("publish follower emails", () => {
  const originalKey = process.env.RESEND_API_KEY;

  afterEach(() => {
    if (originalKey == null) delete process.env.RESEND_API_KEY;
    else process.env.RESEND_API_KEY = originalKey;
    vi.restoreAllMocks();
  });

  it("sends one digest per follower and skips opt-outs", () => {
    const notices = buildFollowerPublishNotices({
      eventName: "Singapore Optimist Championship",
      slug: "soc-2026",
      boatClass: "Optimist",
      finishers: [
        {
          sailorId: "sailor-a",
          sailorName: "Ava Tan",
          sailorHandle: "ava-tan",
          place: 4,
        },
        {
          sailorId: "sailor-b",
          sailorName: "Kai Lim",
          sailorHandle: "kai-lim",
          place: 12,
        },
      ],
      follows: [
        {
          followerProfileId: "parent-1",
          followerEmail: "parent@example.com",
          notifyFollowedResults: true,
          sailorId: "sailor-a",
        },
        {
          followerProfileId: "parent-1",
          followerEmail: "parent@example.com",
          notifyFollowedResults: true,
          sailorId: "sailor-b",
        },
        {
          followerProfileId: "parent-2",
          followerEmail: "quiet@example.com",
          notifyFollowedResults: false,
          sailorId: "sailor-a",
        },
        {
          followerProfileId: "parent-3",
          followerEmail: "other@example.com",
          notifyFollowedResults: null,
          sailorId: "sailor-missing",
        },
      ],
    });

    expect(notices).toHaveLength(1);
    expect(notices[0].to).toBe("parent@example.com");
    expect(notices[0].sailorIds).toEqual(["sailor-a", "sailor-b"]);
    expect(notices[0].subject).toContain("2 sailors you follow");
    expect(notices[0].text).toContain("Ava Tan — 4th");
    expect(notices[0].text).toContain("https://sailorpath.com/ava-tan#results");
    expect(notices[0].text).toContain("https://sailorpath.com/regattas/soc-2026");
    expect(notices[0].text).toContain("Kai Lim — 12th");
  });

  it("does nothing when RESEND_API_KEY is missing", async () => {
    delete process.env.RESEND_API_KEY;
    const fetchSpy = vi.spyOn(globalThis, "fetch");
    expect(
      await sendResendTextEmail({
        to: "parent@example.com",
        subject: "Results published",
        text: "Hello",
      })
    ).toBe("skipped");
    const delivered = await deliverFollowerPublishNotices([
      {
        to: "parent@example.com",
        followerProfileId: "parent-1",
        subject: "Results published",
        text: "Hello",
        sailorIds: ["sailor-a"],
      },
    ]);
    expect(delivered).toEqual({ sent: 0, skipped: 1, failed: 0 });
    expect(fetchSpy).not.toHaveBeenCalled();
  });
});
