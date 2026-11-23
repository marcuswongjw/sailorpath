import { describe, expect, it } from "vitest";
import {
  buildGoldFormIndex,
  percentileFromRank,
  rankFromPercentile,
  type GoldFormRegattaInput,
  type GoldFormResultInput,
  type GoldFormSailorInput,
} from "./goldFormIndex";

const REGATTAS: GoldFormRegattaInput[] = [
  {
    id: "r1",
    name: "SNSC Gold (Sep 25)",
    date: "2025-09-10",
    division: "Gold",
    boatClass: "Optimist",
    geography: "SGP",
    countsForRanking: true,
    status: "published",
    totalFleetSize: 80,
  },
  {
    id: "r2",
    name: "CSC Gold (Jan 26)",
    date: "2026-01-24",
    division: "Gold",
    boatClass: "Optimist",
    geography: "SGP",
    countsForRanking: true,
    status: "published",
    totalFleetSize: 80,
  },
  {
    id: "r3",
    name: "SYSC Gold (Mar 26)",
    date: "2026-03-14",
    division: "Gold",
    boatClass: "Optimist",
    geography: "SGP",
    countsForRanking: true,
    status: "published",
    totalFleetSize: 80,
  },
  {
    id: "r4",
    name: "2nd SAFYC Gold (Jul 26)",
    date: "2026-07-04",
    division: "Gold",
    boatClass: "Optimist",
    geography: "SGP",
    countsForRanking: true,
    status: "published",
    totalFleetSize: 80,
  },
  {
    id: "r5",
    name: "Pesta Sukan Gold (Jul 26)",
    date: "2026-07-25",
    division: "Gold",
    boatClass: "Optimist",
    geography: "SGP",
    countsForRanking: true,
    status: "published",
    totalFleetSize: 80,
  },
  {
    id: "r6",
    name: "SNSC Gold (Sep 26)",
    date: "2026-09-11",
    division: "Gold",
    boatClass: "Optimist",
    geography: "SGP",
    countsForRanking: true,
    status: "published",
    totalFleetSize: 80,
  },
  {
    id: "r7",
    name: "RSYC Gold (Oct 26)",
    date: "2026-10-03",
    division: "Gold",
    boatClass: "Optimist",
    geography: "SGP",
    countsForRanking: true,
    status: "published",
    totalFleetSize: 80,
  },
  {
    id: "os1",
    name: "Eastern Seaboard Gold (Oct 26)",
    date: "2026-10-28",
    division: "Gold",
    boatClass: "Optimist",
    geography: "THA",
    countsForRanking: false,
    status: "published",
    totalFleetSize: 60,
  },
  {
    id: "draft1",
    name: "Draft Gold Event",
    date: "2026-10-15",
    division: "Gold",
    boatClass: "Optimist",
    geography: "SGP",
    countsForRanking: true,
    status: "draft",
    totalFleetSize: 80,
  },
  {
    id: "silver1",
    name: "RSYC Silver (Oct 26)",
    date: "2026-10-03",
    division: "Silver",
    boatClass: "Optimist",
    geography: "SGP",
    countsForRanking: true,
    status: "published",
    totalFleetSize: 70,
  },
];

const SAILORS: GoldFormSailorInput[] = [
  {
    id: "leader",
    name: "Alyssa Form Leader",
    gender: "F",
    dob: "2012-03-01",
    goldEntryDate: "2023-01-01",
    currentFleet: "Series",
    nationalSquadStatus: "Nat A",
  },
  {
    id: "riser",
    name: "Timothy Young Riser",
    gender: "M",
    dob: "2015-05-12",
    goldEntryDate: "2026-01-01",
    currentFleet: "Series",
    nationalSquadStatus: "Nat B",
  },
  {
    id: "prodigy",
    name: "Kirsten Peer Outlier",
    gender: "F",
    dob: "2016-06-01",
    goldEntryDate: "2025-07-01",
    currentFleet: "Series",
    nationalSquadStatus: "DS",
  },
  {
    id: "same-cohort",
    name: "Peer Control 2016",
    gender: "M",
    dob: "2016-08-01",
    goldEntryDate: "2026-01-01",
    currentFleet: "Series",
  },
  {
    id: "dropped",
    name: "Dropped Veteran",
    gender: "M",
    dob: "2011-01-01",
    goldEntryDate: "2022-01-01",
    dropDate: "2026-07-01",
    currentFleet: "Series",
  },
  {
    id: "guest",
    name: "Guest Sailor",
    gender: "F",
    dob: "2014-01-01",
    goldEntryDate: "2024-01-01",
    currentFleet: "Guest",
  },
  {
    id: "silver-only",
    name: "Silver Sailor",
    gender: "M",
    dob: "2015-01-01",
    silverEntryDate: "2025-01-01",
    currentFleet: "Series",
  },
];

const RESULTS: GoldFormResultInput[] = [
  // Form leader: consistently top 3
  { sailorId: "leader", regattaId: "r1", rank: 6 },
  { sailorId: "leader", regattaId: "r2", rank: 4 },
  { sailorId: "leader", regattaId: "r3", rank: 3 },
  { sailorId: "leader", regattaId: "r4", rank: 1 },
  { sailorId: "leader", regattaId: "r5", rank: 2 },
  { sailorId: "leader", regattaId: "r6", rank: 1 },
  { sailorId: "leader", regattaId: "r7", rank: 3 },
  // DNS & overseas commitment should be excluded from performance scores
  { sailorId: "leader", regattaId: "draft1", rank: 50 },
  // Riser: rapid climb from 65 -> 58 -> 50 to 24 -> 14 -> 8 -> 6 + rookie 2026 + 2015 cohort
  { sailorId: "riser", regattaId: "r1", rank: 65 },
  { sailorId: "riser", regattaId: "r2", rank: 58 },
  { sailorId: "riser", regattaId: "r3", rank: 50 },
  { sailorId: "riser", regattaId: "r4", rank: 24 },
  { sailorId: "riser", regattaId: "r5", rank: 14 },
  { sailorId: "riser", regattaId: "r6", rank: 8 },
  { sailorId: "riser", regattaId: "r7", rank: 6 },
  // Plain DNS in r5 would hurt if wrongly included; keep one DNS on peer control
  // Prodigy 2016: solid ~22nd vs 2016 cohort peer sitting ~64th
  { sailorId: "prodigy", regattaId: "r1", rank: 36 },
  { sailorId: "prodigy", regattaId: "r2", rank: 28 },
  { sailorId: "prodigy", regattaId: "r3", rank: 24 },
  { sailorId: "prodigy", regattaId: "r4", rank: 22 },
  { sailorId: "prodigy", regattaId: "r5", rank: 20 },
  { sailorId: "prodigy", regattaId: "r6", rank: 18 },
  { sailorId: "prodigy", regattaId: "r7", rank: 17 },
  { sailorId: "same-cohort", regattaId: "r2", rank: 70 },
  { sailorId: "same-cohort", regattaId: "r3", rank: 68 },
  { sailorId: "same-cohort", regattaId: "r4", rank: 66 },
  { sailorId: "same-cohort", regattaId: "r5", rank: 2, isDns: true },
  { sailorId: "same-cohort", regattaId: "r6", rank: 62 },
  { sailorId: "same-cohort", regattaId: "r7", rank: 59 },
  { sailorId: "same-cohort", regattaId: "os1", rank: 15 },
  { sailorId: "dropped", regattaId: "r1", rank: 1 },
  { sailorId: "guest", regattaId: "r4", rank: 5 },
  { sailorId: "silver-only", regattaId: "silver1", rank: 1 },
];

describe("buildGoldFormIndex", () => {
  it("converts rank and fleet size symmetrically between percentile and rank", () => {
    expect(percentileFromRank(1, 80)).toBe(100);
    expect(percentileFromRank(80, 80)).toBe(0);
    expect(rankFromPercentile(100, 80)).toBe(1);
    expect(rankFromPercentile(0, 80)).toBe(80);
  });

  it("includes only current active Gold sailors and filters out DNS, draft, Silver, Guest, and dropped", () => {
    const summary = buildGoldFormIndex({
      sailors: SAILORS,
      regattas: REGATTAS,
      results: RESULTS,
      scope: "sg_ranking",
      asOfYmd: "2026-11-23",
    });

    const ids = summary.entries.map((e) => e.sailorId);
    expect(ids).toEqual(expect.arrayContaining(["leader", "riser", "prodigy", "same-cohort"]));
    expect(ids).not.toContain("dropped");
    expect(ids).not.toContain("guest");
    expect(ids).not.toContain("silver-only");
    expect(summary.regattaCount).toBe(7);

    const peer = summary.entries.find((e) => e.sailorId === "same-cohort")!;
    // r2, r3, r4, r6, r7 count; DNS row in r5 and overseas row in os1 must NOT be in sg_ranking history
    expect(peer.totalStarts).toBe(5);
    expect(peer.overseasStarts).toBe(1);
    expect(peer.history.some((h) => h.regattaId === "r5")).toBe(false);
    expect(peer.history.some((h) => h.regattaId === "os1")).toBe(false);
  });

  it("ranks the top current performer first on Form Index and surfaces young rising stars on Watchlist", () => {
    const summary = buildGoldFormIndex({
      sailors: SAILORS,
      regattas: REGATTAS,
      results: RESULTS,
      scope: "sg_ranking",
      asOfYmd: "2026-11-23",
    });

    expect(summary.entries[0]?.sailorId).toBe("leader");
    expect(summary.entries[0]!.formIndex).toBeGreaterThan(90);
    expect(summary.entries[0]!.projectedPercentile).toBeLessThanOrEqual(99.5);

    const riser = summary.entries.find((e) => e.sailorId === "riser")!;
    const leader = summary.entries.find((e) => e.sailorId === "leader")!;
    expect(riser.momentumDelta).toBeGreaterThan(40);
    expect(riser.slopePerHalf).toBeGreaterThan(15);
    expect(riser.watchlistIndex).toBeGreaterThan(leader.watchlistIndex);
    expect(riser.projectedRankGain).toBeGreaterThan(0);
    expect(riser.tags).toEqual(expect.arrayContaining(["Surging momentum"]));
  });

  it("captures birth-year cohort peer edge and expands scope when all_gold is requested", () => {
    const sg = buildGoldFormIndex({
      sailors: SAILORS,
      regattas: REGATTAS,
      results: RESULTS,
      scope: "sg_ranking",
      asOfYmd: "2026-11-23",
    });

    const prodigy = sg.entries.find((e) => e.sailorId === "prodigy")!;
    const peer = sg.entries.find((e) => e.sailorId === "same-cohort")!;
    expect(prodigy.cohortPeerEdge).toBeGreaterThan(20);
    expect(peer.cohortPeerEdge).toBeLessThan(-20);
    expect(prodigy.tags).toContain("Young Gold riser");

    const all = buildGoldFormIndex({
      sailors: SAILORS,
      regattas: REGATTAS,
      results: RESULTS,
      scope: "all_gold",
      asOfYmd: "2026-11-23",
    });
    expect(all.regattaCount).toBe(8);
    expect(
      all.entries.find((e) => e.sailorId === "same-cohort")!.history.some((h) => h.regattaId === "os1"),
    ).toBe(true);
  });
});
