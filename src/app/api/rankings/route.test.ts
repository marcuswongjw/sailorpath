import { describe, expect, it, vi } from "vitest";
import type { RankedSailor } from "@/lib/ranking";

vi.mock("@/lib/queries", () => ({
  defaultIlcaIntake: vi.fn(),
  getCachedFleetRankings: vi.fn(),
  getCachedIlcaRankings: vi.fn(),
}));

import { GET } from "@/app/api/rankings/route";
import { getCachedFleetRankings } from "@/lib/queries";

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

describe("GET /api/rankings", () => {
  it("never serializes a full date of birth", async () => {
    vi.mocked(getCachedFleetRankings).mockResolvedValue([rankedSailor]);

    const response = await GET(
      new Request(
        "https://sailorpath.com/api/rankings?fleet=Gold&year=2026&half=Jul-Dec"
      )
    );

    expect(response.status).toBe(200);
    await expect(response.json()).resolves.toMatchObject({
      ranked: [{ dob: "2013-01-01" }],
    });
  });

  it("rejects iQFOiL instead of falling back to Optimist Gold", async () => {
    vi.clearAllMocks();
    const response = await GET(
      new Request("https://sailorpath.com/api/rankings?fleet=iqfoil")
    );

    expect(response.status).toBe(400);
    await expect(response.json()).resolves.toMatchObject({
      error: "Unsupported ranking fleet",
      fleet: "iqfoil",
    });
    expect(getCachedFleetRankings).not.toHaveBeenCalled();
  });
});
