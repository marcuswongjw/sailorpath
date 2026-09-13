import { describe, expect, it } from "vitest";
import { toPublicRankedSailor, toPublicRankedSailors } from "@/lib/publicRankings";
import type { RankedSailor } from "@/lib/ranking";

const rankedSailor: RankedSailor = {
  id: "sailor-1",
  name: "Test Sailor",
  handle: "test-sailor",
  sailNumber: "SGP 123",
  club: "Test Club",
  school: "Test School",
  gender: "F",
  dob: "2013-06-17",
  goldEntryDate: "2024-01-01",
  silverEntryDate: null,
  dropDate: null,
  fleet: "Gold",
  regattaScores: [],
  bestThreeScores: [],
  overallScore: 0,
};

describe("toPublicRankedSailor", () => {
  it("redacts the day and month from an athlete date of birth", () => {
    const publicSailor = toPublicRankedSailor(rankedSailor);

    expect(publicSailor.dob).toBe("2013-01-01");
    expect(publicSailor.dob).not.toBe(rankedSailor.dob);
  });

  it("preserves a missing date of birth as null", () => {
    expect(toPublicRankedSailor({ ...rankedSailor, dob: null }).dob).toBeNull();
  });
});

describe("toPublicRankedSailors", () => {
  it("strips next-half projected squad status", () => {
    const publicSailors = toPublicRankedSailors([
      { ...rankedSailor, nextPeriodSquadStatus: "Nat A" },
    ]);
    expect(publicSailors[0].nextPeriodSquadStatus).toBeNull();
  });
});
