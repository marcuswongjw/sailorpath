vi.mock("next/cache", () => ({ unstable_cache: (fn: unknown) => fn }));
import { beforeEach, describe, expect, it, vi } from "vitest";
vi.mock("@/lib/queries", () => ({ getCachedPublicRegattas: vi.fn(), getResultsForRegatta: vi.fn() }));
import { getCachedPublicRegattas, getResultsForRegatta } from "@/lib/queries";
import { loadSailorPrizeAwards } from "./loadSailorPrizeAwards";
import { getSailorPrizes, mergeSailorPrizes } from "./sailorPrizes";
import type { PublicRegattaResult } from "./queries";
const slug = "rsyc-2026-gold";
const sailor = { id: "a", name: "Test Award Sailor", handle: "test-award" };
const history = [{ regattaId: "g", regattaSlug: slug }];
beforeEach(() => vi.resetAllMocks());
describe("event awards on sailor profiles", () => {
  it("uses the same calculated category winners as the event page and excludes other sailors", async () => {
    vi.mocked(getCachedPublicRegattas).mockResolvedValue([{ id: "g", name: "RSYC", slug, date: "2026-10-03", boatClass: "Optimist", division: "Gold", totalFleetSize: 2 }]);
    vi.mocked(getResultsForRegatta).mockResolvedValue([
      { sailorId: "a", sailorName: sailor.name, handle: sailor.handle, rank: 1, gender: "F", birthYear: 2014, school: "Private current school", sailNumber: "123" },
      { sailorId: "b", sailorName: "Other Winner", handle: "other", rank: 2, gender: "M", birthYear: 2014, sailNumber: "456" },
    ] as PublicRegattaResult[]);
    const awards = await loadSailorPrizeAwards(sailor, history);
    expect(awards.map((award) => award.categoryName)).toEqual(["Overall", "Female", "Under 13"]);
    expect(awards.every((award) => award.rank === 1)).toBe(true);
    expect(awards.every((award) => award.schoolName === undefined)).toBe(true);
    const fallback = getSailorPrizes(sailor, [{ regattaSlug: slug, rank: 1, boatClass: "Optimist", division: "Gold" }]);
    expect(mergeSailorPrizes(fallback, awards)).toHaveLength(3);
  });
  it("never guesses official prizes for events without a verified schedule", async () => {
    expect(await loadSailorPrizeAwards(sailor, [{ regattaId: "x", regattaSlug: "unknown" }])).toEqual([]);
    expect(getResultsForRegatta).not.toHaveBeenCalled();
  });
});
