import { beforeEach, describe, expect, it, vi } from "vitest";
import type { RankedSailor } from "@/lib/ranking";

vi.mock("@/lib/queries", () => ({
  defaultIlcaIntake: vi.fn(),
  getCachedFleetRankings: vi.fn(),
  getCachedIlcaRankings: vi.fn(),
}));

import { DbUnavailableError } from "@/db";
import { clearPublicReadMemory } from "@/lib/publicReadMemory";
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
  beforeEach(() => {
    clearPublicReadMemory();
    vi.mocked(getCachedFleetRankings).mockReset();
  });

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

  it("returns the last board instead of a 503 when the database times out", async () => {
    vi.mocked(getCachedFleetRankings).mockResolvedValueOnce([rankedSailor]);
    const first = await GET(
      new Request("https://sailorpath.com/api/rankings?fleet=Gold&year=2026&half=Jul-Dec")
    );
    expect(first.status).toBe(200);

    vi.mocked(getCachedFleetRankings).mockRejectedValueOnce(
      new DbUnavailableError("DB_OPERATION_TIMEOUT")
    );
    const second = await GET(
      new Request("https://sailorpath.com/api/rankings?fleet=Gold&year=2026&half=Jul-Dec")
    );
    expect(second.status).toBe(200);
    await expect(second.json()).resolves.toMatchObject({
      stale: true,
      ranked: [{ dob: "2013-01-01" }],
    });
  });

  it("returns an unavailable payload without a 5xx when no board has been cached", async () => {
    vi.mocked(getCachedFleetRankings).mockRejectedValueOnce(
      new DbUnavailableError("DB_OPERATION_TIMEOUT")
    );
    const response = await GET(
      new Request("https://sailorpath.com/api/rankings?fleet=Silver&year=2026&half=Jan-Jun")
    );
    expect(response.status).toBe(200);
    expect(response.headers.get("Cache-Control")).toBe("no-store");
    await expect(response.json()).resolves.toMatchObject({
      unavailable: true,
      ranked: [],
    });
  });
});
