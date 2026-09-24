import { readFileSync } from "node:fs";
import { describe, expect, it } from "vitest";
import { calculateRankings, type Period, type RegattaRecord, type SailorRecord } from "./ranking";
import { computeIlcaRankings } from "./ilcaRanking";
import { filterPublicRankingRegattas } from "./regattaStatus";

/**
 * Public Optimist/ILCA ranking loaders must require published status.
 * draft / in_review / archived must not contribute starts or scores.
 */
describe("public ranking published-regatta guard (source)", () => {
  const queriesSrc = readFileSync(new URL("./queries.ts", import.meta.url), "utf8");

  function fnBody(startMarker: string, endMarker: string): string {
    const start = queriesSrc.indexOf(startMarker);
    expect(start).toBeGreaterThanOrEqual(0);
    const end = queriesSrc.indexOf(endMarker, start + 1);
    expect(end).toBeGreaterThan(start);
    return queriesSrc.slice(start, end);
  }

  it("queryPublishedOptimistSnapshot filters regattas to published", () => {
    const body = fnBody(
      "async function queryPublishedOptimistSnapshot",
      "export const getCachedFleetRankings"
    );
    expect(body).toMatch(/eq\(\s*regattas\.status\s*,\s*PUBLIC_RANKING_REGATTA_STATUS\s*\)/);
    expect(body).toMatch(/PUBLIC_RANKING_REGATTA_STATUS/);
  });

  it("computeIlcaRankingsBoard filters regattas to published", () => {
    const body = fnBody(
      "async function computeIlcaRankingsBoard",
      "export async function getSailorIlcaStanding"
    );
    expect(body).toMatch(/eq\(\s*regattas\.status\s*,\s*PUBLIC_RANKING_REGATTA_STATUS\s*\)/);
  });
});

describe("unpublished regattas do not score on public Optimist rankings", () => {
  const period: Period = { year: 2026, half: "Jul-Dec" };

  const sailor = (id: string): SailorRecord => ({
    id,
    name: id,
    handle: id,
    sailNumber: "SGP 1",
    club: "C",
    goldEntryDate: "2025-01-01",
    silverEntryDate: "2024-01-01",
    dropDate: null,
    currentFleet: "Gold",
  });

  const regatta = (
    id: string,
    date: string,
    status: string
  ): RegattaRecord & { status: string } => ({
    id,
    name: id,
    slug: id,
    date,
    totalFleetSize: 40,
    division: "Gold",
    boatClass: "Optimist",
    countsForRanking: true,
    status,
  });

  it("draft and in_review events are excluded before calculateRankings", () => {
    const withStatus = [
      regatta("pub-a", "2026-07-04", "published"),
      regatta("draft-x", "2026-07-18", "draft"),
      regatta("review-y", "2026-08-01", "in_review"),
      regatta("pub-b", "2026-08-15", "published"),
      regatta("arch-z", "2026-08-29", "archived"),
    ];
    const publicOnly = filterPublicRankingRegattas(withStatus);
    expect(publicOnly.map((r) => r.id).sort()).toEqual(["pub-a", "pub-b"]);

    const results = [
      { sailorId: "alice", regattaId: "pub-a", rank: 5, isDns: false },
      // Would dominate Best 3 if draft counted:
      { sailorId: "alice", regattaId: "draft-x", rank: 1, isDns: false },
      { sailorId: "alice", regattaId: "review-y", rank: 1, isDns: false },
      { sailorId: "alice", regattaId: "pub-b", rank: 8, isDns: false },
      { sailorId: "alice", regattaId: "arch-z", rank: 1, isDns: false },
    ];
    const publicResults = results.filter((r) =>
      publicOnly.some((reg) => reg.id === r.regattaId)
    );

    const ranked = calculateRankings(period, [sailor("alice")], publicOnly, publicResults);
    expect(ranked).toHaveLength(1);
    const alice = ranked[0];
    const scoredIds = alice.regattaScores
      .filter((s) => s.score > 0 && s.score < 9999)
      .map((s) => s.regattaId)
      .sort();
    // Only published regattas appear as real starts (DNS pads for missing
    // published events may still show; draft/in_review/archived must not).
    expect(scoredIds.every((id) => id === "pub-a" || id === "pub-b")).toBe(true);
    expect(scoredIds).not.toContain("draft-x");
    expect(scoredIds).not.toContain("review-y");
    expect(scoredIds).not.toContain("arch-z");
    // Best 3 uses published ranks 5 + 8 (+ DNS pad), not the draft 1sts
    expect(alice.bestThreeScores).toContain(5);
    expect(alice.bestThreeScores).toContain(8);
    expect(alice.bestThreeScores).not.toContain(1);
  });
});

describe("unpublished regattas do not score on public ILCA rankings", () => {
  it("draft / in_review / archived are dropped before computeIlcaRankings", () => {
    const withStatus = [
      {
        id: "ilca-pub",
        name: "Published Cup",
        date: "2026-05-01",
        totalFleetSize: 20,
        boatClass: "ILCA 4",
        countsForRanking: true,
        raceCount: 6,
        status: "published",
      },
      {
        id: "ilca-draft",
        name: "Draft Cup",
        date: "2026-05-15",
        totalFleetSize: 20,
        boatClass: "ILCA 4",
        countsForRanking: true,
        raceCount: 6,
        status: "draft",
      },
      {
        id: "ilca-review",
        name: "Review Cup",
        date: "2026-06-01",
        totalFleetSize: 20,
        boatClass: "ILCA 4",
        countsForRanking: true,
        raceCount: 6,
        status: "in_review",
      },
    ];
    const publicOnly = filterPublicRankingRegattas(withStatus);
    expect(publicOnly.map((r) => r.id)).toEqual(["ilca-pub"]);

    const sailors = [
      {
        id: "s1",
        name: "Sailor One",
        gender: "M",
        dob: "2012-01-01",
        nationality: "SGP",
      },
    ];
    const results = [
      { sailorId: "s1", regattaId: "ilca-pub", rank: 4 },
      // Would add 20 high points if draft counted (1st of 20):
      { sailorId: "s1", regattaId: "ilca-draft", rank: 1 },
      { sailorId: "s1", regattaId: "ilca-review", rank: 1 },
    ];
    const publicResults = results.filter((r) =>
      publicOnly.some((reg) => reg.id === r.regattaId)
    );

    const ranked = computeIlcaRankings(
      "ILCA 4",
      "2026-06-30",
      sailors,
      publicOnly,
      publicResults,
      { intakeYear: 2026, restrictToNationalList: false }
    );
    expect(ranked).toHaveLength(1);
    expect(ranked[0].eventScores.map((e) => e.regattaId)).toEqual(["ilca-pub"]);
    // 4th of 20 → 17 high points; draft 1sts must not inflate total
    expect(ranked[0].totalPoints).toBe(17);
    expect(ranked[0].eventScores).toHaveLength(1);
  });
});
