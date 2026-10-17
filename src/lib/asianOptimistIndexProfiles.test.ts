import { beforeEach, describe, expect, it, vi } from "vitest";
const state = vi.hoisted(() => ({ confirmed: [] as object[], profiles: [] as object[] }));
vi.mock("server-only", () => ({}));
vi.mock("@/db", () => ({ db: { select: () => ({ from: () => ({
  innerJoin: async () => state.confirmed,
  then: (resolve: (rows: object[]) => void) => resolve(state.profiles),
}) }) } }));
import { getAsianOptimistIndexEntries } from "./asianOptimistIndexProfiles";
beforeEach(() => { state.confirmed = []; state.profiles = []; });
describe("confirmed Asian Index profile links", () => {
  it("links Ilzani’s compact source name to the explicitly confirmed full-name profile without exposing private DOB", async () => {
    state.confirmed = [{ identityKey: "mas:khairulilzaniafendy", name: "Khairul Ilzani bin Mohd Afendy",
      handle: "confirmed-ilzani", dob: "2013-01-01", isPublicDob: false }];
    const rows = await getAsianOptimistIndexEntries();
    expect(rows.find(r => r.name === "Khairulilzani Afendy")).toMatchObject({
      displayName: "Khairul Ilzani bin Mohd Afendy", profileHref: "/confirmed-ilzani", birthYear: null,
      sourceName: "AFENDY, Khairulilzani", overallPlace: 72, netPoints: 132,
    });
  });
});
