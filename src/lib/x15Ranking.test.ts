import { readFileSync } from "node:fs";
import path from "node:path";
import { describe, expect, it } from "vitest";
import {
  X15_BETA_RANKING_NOTICE,
  calculateX15EventPoints,
  computeX15RiderRollingSeries,
  isAllDnsOrDnc,
  minCompletedRacesForCategory,
  normalizeX15RankingDivision,
  reindexDivisionStarters,
  type X15RiderResultCandidate,
} from "./x15Ranking";

describe("x15Ranking v0.2 methodology (6 Class Governance Principles)", () => {
  describe("Principle 1: Simplified counting rules & total maximization", () => {
    it("allows up to 6 Grade 50 results when no higher grades exist", () => {
      const candidates: X15RiderResultCandidate[] = Array.from({ length: 8 }, (_, i) => ({
        eventId: `ev-50-${i}`,
        eventSlug: `ev-50-${i}`,
        eventName: `Circuit Open #${i + 1}`,
        division: "senior-men",
        eventEndDate: "2027-05-01",
        grade: 50,
        category: "class-circuit-open",
        points: 50 - i * 2, // 50, 48, 46, 44, 42, 40, 38, 36
        reindexedPlace: i + 1,
        officialPlace: i + 1,
        validStarters: 20,
      }));

      const summary = computeX15RiderRollingSeries(candidates, "2027-06-01", "senior-men");
      expect(summary.eventsCounted).toBe(6);
      expect(summary.countedEvents.map((e) => e.eventId)).toEqual([
        "ev-50-0",
        "ev-50-1",
        "ev-50-2",
        "ev-50-3",
        "ev-50-4",
        "ev-50-5",
      ]);
      expect(summary.totalPoints).toBe(50 + 48 + 46 + 44 + 42 + 40);
      expect(summary.excludedEvents.filter((e) => e.reason === "surpassed-by-better-combination")).toHaveLength(2);
    });

    it("automatically picks the combination that maximizes total points (even skipping a low Worlds result if Grade 50 is better)", () => {
      const lowWorlds: X15RiderResultCandidate = {
        eventId: "worlds-2026",
        eventSlug: "x15-worlds-2026",
        eventName: "Ibiza Worlds",
        division: "senior-men",
        eventEndDate: "2026-11-08",
        grade: 200,
        category: "world-championship",
        points: 10, // Back of the fleet finish
        reindexedPlace: 38,
        officialPlace: 38,
        validStarters: 38,
      };

      const highOpens: X15RiderResultCandidate[] = Array.from({ length: 6 }, (_, i) => ({
        eventId: `open-${i}`,
        eventSlug: `open-${i}`,
        eventName: `Open #${i}`,
        division: "senior-men",
        eventEndDate: "2027-04-01",
        grade: 50,
        category: "class-circuit-open",
        points: 40,
        reindexedPlace: 2,
        officialPlace: 2,
        validStarters: 15,
      }));

      // 6 opens @ 40 pts = 240 pts.
      // If Worlds (10 pts) was forced, 1 Worlds (10) + 5 opens (200) = 210 pts.
      // System must select the 6 opens yielding 240 pts!
      const summary = computeX15RiderRollingSeries([lowWorlds, ...highOpens], "2027-05-01", "senior-men");
      expect(summary.totalPoints).toBe(240);
      expect(summary.countedEvents).toHaveLength(6);
      expect(summary.countedEvents.every((e) => e.grade === 50)).toBe(true);
      expect(summary.excludedEvents).toEqual([
        expect.objectContaining({
          candidate: expect.objectContaining({ eventId: "worlds-2026" }),
          reason: "surpassed-by-better-combination",
        }),
      ]);
    });
  });

  describe("Principle 2: Rider-specific Worlds rollover (24 months or until next Worlds)", () => {
    const ibizaWorlds: X15RiderResultCandidate = {
      eventId: "ibiza-2026",
      eventSlug: "x15-worlds-2026",
      eventName: "Ibiza Worlds 2026",
      division: "senior-men",
      eventEndDate: "2026-11-08",
      grade: 200,
      category: "world-championship",
      points: 200,
      reindexedPlace: 1,
      officialPlace: 1,
      validStarters: 38,
    };

    it("retains previous Worlds result for up to 24 months if the rider skips a subsequent Worlds", () => {
      // 14 months after Ibiza (Jan 2028), rider did not attend Oct 2027 Soma Bay
      const summary = computeX15RiderRollingSeries([ibizaWorlds], "2028-01-15", "senior-men");
      expect(summary.totalPoints).toBe(200);
      expect(summary.countedEvents).toHaveLength(1);
      expect(summary.countedEvents[0].eventId).toBe("ibiza-2026");

      // 25 months after Ibiza (Dec 2028) -> expired
      const expiredSummary = computeX15RiderRollingSeries([ibizaWorlds], "2028-12-15", "senior-men");
      expect(expiredSummary.totalPoints).toBe(0);
      expect(expiredSummary.excludedEvents[0].reason).toBe("expired-24m-worlds");
    });

    it("replaces previous Worlds result when the rider competes in a subsequent valid Worlds, even if lower", () => {
      const somaBayWorlds: X15RiderResultCandidate = {
        eventId: "soma-bay-2027",
        eventSlug: "x15-worlds-2027",
        eventName: "Soma Bay Worlds 2027",
        division: "senior-men",
        eventEndDate: "2027-10-20",
        grade: 200,
        category: "world-championship",
        points: 120, // Lower than 200
        reindexedPlace: 15,
        officialPlace: 15,
        validStarters: 40,
      };

      const summary = computeX15RiderRollingSeries([ibizaWorlds, somaBayWorlds], "2027-10-25", "senior-men");
      expect(summary.countedEvents.map((e) => e.eventId)).toEqual(["soma-bay-2027"]);
      expect(summary.totalPoints).toBe(120);
      expect(summary.excludedEvents).toEqual([
        expect.objectContaining({
          candidate: expect.objectContaining({ eventId: "ibiza-2026" }),
          reason: "replaced-by-subsequent-worlds",
        }),
      ]);
    });

    it("does not replace previous Worlds if the subsequent championship was cancelled or invalid", () => {
      const invalidWorlds: X15RiderResultCandidate = {
        eventId: "abandoned-worlds-2027",
        eventSlug: "x15-worlds-2027-abandoned",
        eventName: "Abandoned Worlds 2027",
        division: "senior-men",
        eventEndDate: "2027-10-20",
        grade: 200,
        category: "world-championship",
        points: 0,
        reindexedPlace: 1,
        officialPlace: 1,
        validStarters: 30,
        isValidChampionship: false,
      };

      const summary = computeX15RiderRollingSeries([ibizaWorlds, invalidWorlds], "2027-10-25", "senior-men");
      expect(summary.countedEvents.map((e) => e.eventId)).toEqual(["ibiza-2026"]);
      expect(summary.totalPoints).toBe(200);
    });
  });

  describe("Principle 3: Fleet size (N), valid starters, and re-indexing (P)", () => {
    it("excludes riders who only scored DNS/DNC from N and re-indexes P in [1, N]", () => {
      expect(isAllDnsOrDnc([{ code: "DNS" }, { code: "DNC" }])).toBe(true);
      expect(isAllDnsOrDnc([{ score: 1 }, { code: "DNS" }])).toBe(false);

      const rawEntries = [
        { officialRank: 1, races: [{ score: 1 }, { score: 2 }] },
        { officialRank: 2, races: [{ code: "DNS" }, { code: "DNS" }] }, // Ghost entry
        { officialRank: 3, races: [{ score: 3 }, { code: "UFD" }] }, // Started, race-level penalty
        { officialRank: 4, races: [{ code: "DNC" }, { code: "DNC" }] }, // Ghost entry
        { officialRank: 5, races: [{ score: 5 }, { score: 4 }] },
      ];

      const { validStartersCount, reindexed } = reindexDivisionStarters(rawEntries);
      expect(validStartersCount).toBe(3); // Only 3 valid starters out of 5 entries

      expect(reindexed).toEqual([
        { record: rawEntries[0], isValidStarter: true, reindexedPlace: 1, heldForReview: false },
        { record: rawEntries[1], isValidStarter: false, reindexedPlace: null, heldForReview: false },
        { record: rawEntries[2], isValidStarter: true, reindexedPlace: 2, heldForReview: false }, // Official 3rd becomes P=2
        { record: rawEntries[3], isValidStarter: false, reindexedPlace: null, heldForReview: false },
        { record: rawEntries[4], isValidStarter: true, reindexedPlace: 3, heldForReview: false }, // Official 5th becomes P=3
      ]);
    });

    it("holds series-level disqualifications for review", () => {
      const rawEntries = [
        { officialRank: 1, races: [{ score: 1 }] },
        { officialRank: 2, races: [{ score: 2 }], seriesDisqualification: true }, // DGM / RRS 69
      ];

      const { validStartersCount, reindexed } = reindexDivisionStarters(rawEntries);
      expect(validStartersCount).toBe(1);
      expect(reindexed[1].heldForReview).toBe(true);
      expect(reindexed[1].isValidStarter).toBe(false);
    });
  });

  describe("Principle 4: Division mapping & Junior progression", () => {
    it("preserves Junior results on Junior ladder and does not merge them into Youth", () => {
      const juniorResult: X15RiderResultCandidate = {
        eventId: "ibiza-junior-2026",
        eventSlug: "x15-worlds-2026",
        eventName: "Ibiza Worlds 2026 (U15 & U13)",
        division: "junior-u15-u13",
        eventEndDate: "2026-11-08",
        grade: 200,
        category: "world-championship",
        points: 200,
        reindexedPlace: 1,
        officialPlace: 1,
        validStarters: 15,
      };

      // Junior ladder query
      const juniorLadder = computeX15RiderRollingSeries([juniorResult], "2026-11-10", "junior-u15-u13");
      expect(juniorLadder.totalPoints).toBe(200);

      // Youth ladder query for same rider
      const youthLadder = computeX15RiderRollingSeries([juniorResult], "2026-11-10", "youth-men-u19-u17");
      expect(youthLadder.totalPoints).toBe(0);
      expect(youthLadder.eventsCounted).toBe(0);
    });
  });

  describe("Principle 5 & 6: Governance, provisional flags, and Ibiza verification", () => {
    it("flags provisional status on rider summary when a result is provisional", () => {
      const provisionalResult: X15RiderResultCandidate = {
        eventId: "ibiza-u19m-2026",
        eventSlug: "x15-worlds-2026",
        eventName: "Ibiza Worlds 2026 (U19 Men)",
        division: "youth-men-u19-u17",
        eventEndDate: "2026-11-08",
        grade: 200,
        category: "world-championship",
        points: 185.71,
        reindexedPlace: 3,
        officialPlace: 3,
        validStarters: 28,
        isProvisional: true, // Discrepancy flagged
      };

      const summary = computeX15RiderRollingSeries([provisionalResult], "2026-11-10", "youth-men-u19-u17");
      expect(summary.hasProvisionalResults).toBe(true);
      expect(summary.betaNotice).toBe(X15_BETA_RANKING_NOTICE);
    });

    it("scores 2-race Senior Worlds divisions while requiring 3 races for Opens", () => {
      expect(minCompletedRacesForCategory("world-championship")).toBe(2);
      expect(minCompletedRacesForCategory("class-circuit-open")).toBe(3);

      expect(
        calculateX15EventPoints({
          grade: 200,
          category: "world-championship",
          validStarters: 38,
          place: 1,
          completedRaces: 2,
        }),
      ).toBe(200);

      expect(
        calculateX15EventPoints({
          grade: 50,
          category: "class-circuit-open",
          validStarters: 20,
          place: 1,
          completedRaces: 2,
        }),
      ).toBe(0);
    });

    it("computes baseline Grade 200 points across all 5 imported 2026 Ibiza Worlds manifests", () => {
      const files = [
        ["SeniorMen.json", "Kamil Manowiecki", 38, 2, 200],
        ["SeniorWomen.json", "Jette Koep", 16, 2, 200],
        ["U19Men.json", "Holland Vierling", 28, 4, 200],
        ["U19Women.json", "Yana Li", 10, 3, 200],
        ["U15.json", "Benjamin Almeida", 15, 4, 200],
      ] as const;

      for (const [filename, expectedWinner, expectedN, expectedRaces, expectedWinnerPts] of files) {
        const fullPath = path.join(process.cwd(), "scripts/imports/x15-worlds-2026", filename);
        const manifest = JSON.parse(readFileSync(fullPath, "utf8"));
        expect(normalizeX15RankingDivision(manifest.sheet.division)).not.toBeNull();
        expect(manifest.sheet.totalFleetSize).toBe(expectedN);
        expect(manifest.sheet.raceCount).toBe(expectedRaces);
        expect(manifest.results[0].name).toBe(expectedWinner);

        const winnerPts = calculateX15EventPoints({
          grade: 200,
          category: "world-championship",
          validStarters: manifest.sheet.totalFleetSize,
          place: manifest.results[0].rank,
          completedRaces: manifest.sheet.raceCount,
        });
        expect(winnerPts).toBe(expectedWinnerPts);
      }
    });
  });
});
