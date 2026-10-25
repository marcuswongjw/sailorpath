import { describe, expect, it } from "vitest";
import { resolvePrizeWinnerProfile, prizeWinnerProfileHandles } from "./prizeWinnerProfiles";
const winner = { sailorName: "Amy Tan", rank: 1, prizeTitle: "1st" };
describe("award identity linking", () => {
  it("matches reordered names uniquely but never a reused sail number alone", () => {
    expect(resolvePrizeWinnerProfile(winner, [{ sailorName: "Tan, Amy", handle: "amy", sailorId: "a" }])?.handle).toBe("amy");
    expect(resolvePrizeWinnerProfile({ ...winner, sailNumber: "123" }, [{ sailorName: "Other Person", handle: "other", sailNumber: "123" }])).toBeNull();
    expect(resolvePrizeWinnerProfile(winner, [{ sailorName: "Amy Tan", handle: "amy" }, { sailorName: "Amy Tan", handle: "amy-other" }])).toBeNull();
  });
  it("links both crew members instead of reusing the helm's handle", () => {
    const rows = [{ sailorName: "Amy Tan / Ben Lee", handle: "amy", sailorId: "a", participants: [
      { sailorName: "Amy Tan", sourceName: "Amy Tan", handle: "amy", sailorId: "a", matchStatus: "matched" },
      { sailorName: "Ben Lee", sourceName: "Ben Lee", handle: "ben", sailorId: "b", matchStatus: "matched" },
    ] }];
    expect(prizeWinnerProfileHandles([{ ...winner, sailorName: "Amy Tan / Ben Lee", sailorHandle: "amy" }], rows)).toEqual({ "amy tan": "amy", "ben lee": "ben" });
  });
});
