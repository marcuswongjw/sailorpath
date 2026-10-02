import { describe, expect, it } from "vitest";
import {
  decideFollow,
  followPairsAreUnique,
  followerOwnsRow,
  notifyFollowedResultsEnabled,
} from "@/lib/followSailors";

describe("follow uniqueness and ownership", () => {
  it("rejects a second row for the same follower and sailor", () => {
    expect(
      followPairsAreUnique([
        { followerProfileId: "parent-1", sailorId: "sailor-a" },
        { followerProfileId: "parent-2", sailorId: "sailor-a" },
      ])
    ).toBe(true);
    expect(
      followPairsAreUnique([
        { followerProfileId: "parent-1", sailorId: "sailor-a" },
        { followerProfileId: "parent-1", sailorId: "sailor-a" },
      ])
    ).toBe(false);
  });

  it("lets only the follower read or change the row", () => {
    expect(followerOwnsRow("parent-1", "parent-1")).toBe(true);
    expect(followerOwnsRow("parent-1", "parent-2")).toBe(false);
    expect(followerOwnsRow("parent-1", null)).toBe(false);
  });

  it("blocks a linked owner and treats a repeat follow as already following", () => {
    expect(
      decideFollow({
        followerProfileId: "parent-1",
        sailorOwnerProfileId: "parent-1",
        existingFollowerProfileIds: [],
      })
    ).toEqual({ ok: false, reason: "own-sailor" });

    expect(
      decideFollow({
        followerProfileId: "coach-1",
        sailorOwnerProfileId: "parent-1",
        existingFollowerProfileIds: ["coach-1"],
      })
    ).toEqual({ ok: true, alreadyFollowing: true });

    expect(
      decideFollow({
        followerProfileId: "coach-2",
        sailorOwnerProfileId: null,
        existingFollowerProfileIds: ["coach-1"],
      })
    ).toEqual({ ok: true, alreadyFollowing: false });
  });

  it("keeps follow emails on unless the account turns them off", () => {
    expect(notifyFollowedResultsEnabled(undefined)).toBe(true);
    expect(notifyFollowedResultsEnabled(true)).toBe(true);
    expect(notifyFollowedResultsEnabled(false)).toBe(false);
  });
});
