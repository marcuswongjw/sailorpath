import { describe, it, expect, vi, beforeEach } from "vitest";
import { computeOptimistSelectionData } from "./selectionQueries";
import * as queries from "./queries";
import { DbUnavailableError } from "@/db";

vi.mock("./queries", () => ({
  listRegattas: vi.fn(),
  listSailorsFull: vi.fn(),
  getResultsForRegatta: vi.fn(),
}));

describe("computeOptimistSelectionData", () => {
  beforeEach(() => {
    vi.clearAllMocks();
  });

  it("handles empty database or unmatched selection regattas gracefully", async () => {
    vi.mocked(queries.listRegattas).mockResolvedValue([]);
    vi.mocked(queries.listSailorsFull).mockResolvedValue([]);

    const data = await computeOptimistSelectionData();

    expect(data.matched).toHaveLength(2);
    expect(data.matched.every((m) => !m.matched)).toBe(true);
    expect(data.combinedScores).toEqual([]);
    expect(data.asianTeam.selected).toEqual([]);
    expect(data.perthCamp.picks).toEqual([]);
    expect(data.campaigns.asianOceania.id).toBe("asian-oceania-2026");
  });

  it("handles DbUnavailableError gracefully by returning fallback structure", async () => {
    vi.mocked(queries.listRegattas).mockRejectedValue(
      new DbUnavailableError("No valid DATABASE_URL")
    );

    const data = await computeOptimistSelectionData();

    expect(data.selectionStatus.warnings).toContain("Database is currently unavailable.");
    expect(data.combinedScores).toEqual([]);
    expect(data.asianTeam.reason).toBe("Database unavailable.");
  });

  it("matches selection regattas and computes team picks correctly", async () => {
    vi.mocked(queries.listRegattas).mockResolvedValue([
      {
        id: "regatta-1",
        name: "SSF Selection Trials 2026",
        slug: "ssf-trials-2026",
        date: "2026-08-25",
        totalFleetSize: 20,
        division: "Gold",
        raceCount: 5,
        boatClass: "Optimist",
        countsForRanking: true,
      },
    ]);

    vi.mocked(queries.getResultsForRegatta).mockResolvedValue([
      {
        resultId: "res-1",
        sailorId: "s1",
        regattaId: "regatta-1",
        rank: 1,
        nettScore: 4,
        totalScore: 8,
        isDns: false,
        isOverseasCommitment: false,
        sailorName: "Lucas Wong",
        sailNumber: "4682",
        handle: "lucas-wong",
        gender: "M",
        sailorGender: "M",
        birthYear: 2013,
        dob: "2013-05-10",
        nationality: "SGP",
        sailorNationality: "SGP",
        raceResults: [
          {
            regattaResultId: "res-1",
            raceNumber: 1,
            score: 1,
            scoringCode: null,
            discarded: false,
            rawValue: "1",
          },
        ],
      },
    ]);

    vi.mocked(queries.listSailorsFull).mockResolvedValue([
      {
        id: "s1",
        name: "Lucas Wong",
        handle: "lucas-wong",
        sailNumber: "4682",
        sailNumberIlca4: null,
        club: "Changi Sailing Club",
        school: "Tao Nan School",
        nationality: "SGP",
        avatarUrl: null,
        goldEntryDate: null,
        silverEntryDate: null,
        dropDate: null,
        currentFleet: "Gold",
        dob: "2013-05-10",
        gender: "M",
        nationalSquadStatus: "Nat A",
        natSquadStatusJan25: null,
        natSquadStatusJul25: null,
        natSquadStatusJan26: null,
        natSquadStatusJul26: null,
        natSquadStatusJan27: null,
      } as unknown as Awaited<ReturnType<typeof queries.listSailorsFull>>[number],
    ]);

    const data = await computeOptimistSelectionData();

    expect(data.matched[0].matched).toBe(true);
    expect(data.combinedScores).toHaveLength(1);
    expect(data.combinedScores[0].name).toBe("Lucas Wong");
    expect(data.asianTeam.selected).toHaveLength(1);
    expect(data.asianTeam.selected[0].sailorId).toBe("s1");
    expect(data.perthCamp.picks).toHaveLength(1);
    expect(data.perthCamp.picks[0].bucket).toBe("by2013");
  });
});
