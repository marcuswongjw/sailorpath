import { describe, expect, it } from "vitest";
import type { Period } from "@/lib/ranking";
import {
  buildPersonalSeasonView,
  decorateSeasonSlots,
  explainSeasonPlace,
  pickNextCountingEvent,
} from "@/lib/personalSeason";

const period: Period = { year: 2026, half: "Jul-Dec" };

describe("personal season slots", () => {
  it("marks the three lowest scores as counting and keeps DNS, overseas, and carry-forward", () => {
    const slots = decorateSeasonSlots([
      { regattaId: "a", regattaName: "NSC", score: 8, isCarryForward: true },
      { regattaId: "b", regattaName: "SAFYC", score: 4 },
      { regattaId: "c", regattaName: "Pesta", score: 12, isDNS: true },
      { regattaId: "d", regattaName: "CSC", score: 6 },
      { regattaId: "e", regattaName: "RM", score: 20, isOverseasCommitment: true },
    ]);

    expect(slots).toHaveLength(5);
    expect(slots.map((slot) => slot.counting)).toEqual([true, true, false, true, false]);
    expect(slots.map((slot) => slot.discarded)).toEqual([false, false, true, false, true]);
    expect(slots[0].carryForward).toBe(true);
    expect(slots[2].dns).toBe(true);
    expect(slots[4].overseas).toBe(true);
  });

  it("pads a short window with open slots", () => {
    const slots = decorateSeasonSlots([
      { regattaId: "a", regattaName: "NSC", score: 5 },
    ]);
    expect(slots.filter((slot) => slot.empty)).toHaveLength(4);
    expect(slots[0].counting).toBe(true);
  });

  it("explains a Gold place from the real Best 3 scores", () => {
    const slots = decorateSeasonSlots([
      { regattaId: "a", regattaName: "NSC", score: 8, isCarryForward: true },
      { regattaId: "b", regattaName: "SAFYC", score: 4 },
      { regattaId: "c", regattaName: "Pesta", score: 12, isDNS: true },
      { regattaId: "d", regattaName: "CSC", score: 6 },
      { regattaId: "e", regattaName: "RM", score: 20, isOverseasCommitment: true },
    ]);
    const why = explainSeasonPlace({
      sailorName: "Ava Tan",
      periodLabel: "Jul – Dec 2026",
      fleet: "Gold",
      ilcaClass: null,
      rank: 4,
      fleetSize: 42,
      best3: 18,
      higherIsBetter: false,
      slots,
      nextCountingEvent: { name: "SYC Gold", date: "2026-10-18" },
      tiedWith: 1,
    });

    expect(why).toHaveLength(2);
    expect(why[0]).toBe(
      "Ava Tan is 4th of 42 in Gold for Jul – Dec 2026 with a Best 3 of 5 of 18, counting places 8, 4, and 6."
    );
    expect(why[1]).toContain("12 at Pesta (DNS)");
    expect(why[1]).toContain("20 at RM (overseas)");
    expect(why[1]).toContain("outside the Best 3");
    expect(why[1]).toContain("NSC carries forward");
    expect(why[1]).toContain("SYC Gold on 18 Oct 2026");
  });

  it("says a dropped sailor is not on the board", () => {
    const view = buildPersonalSeasonView({
      sailor: {
        id: "kai",
        name: "Kai Lim",
        handle: "kai-lim",
        dropDate: "2026-07-01",
        currentFleet: "Series",
        goldEntryDate: "2025-01-01",
      },
      period,
      goldBoard: [],
      silverBoard: [],
      ilcaBoards: [],
      events: [],
      today: "2026-10-02",
      lastResultDate: "2026-06-20",
    });

    expect(view.fleet).toBe("Dropped");
    expect(view.rank).toBeNull();
    expect(view.slots.every((slot) => slot.empty)).toBe(true);
    expect(view.why[0]).toContain("not include a place");
    expect(view.resultsHref).toBe("/kai-lim#results");
  });
});

describe("next counting event", () => {
  const events = [
    {
      id: "past",
      name: "Past Gold",
      date: "2026-09-01",
      slug: "past",
      boatClass: "Optimist",
      division: "Gold",
      countsForRanking: true,
      raceCount: 6,
    },
    {
      id: "short",
      name: "Too few races",
      date: "2026-10-10",
      slug: "short",
      boatClass: "Optimist",
      division: "Gold",
      countsForRanking: true,
      raceCount: 2,
    },
    {
      id: "silver",
      name: "Soon Silver",
      date: "2026-10-12",
      slug: "silver",
      boatClass: "Optimist",
      division: "Silver",
      countsForRanking: true,
      raceCount: null,
    },
    {
      id: "gold",
      name: "SYC Gold",
      date: "2026-10-18",
      slug: "syc-gold",
      boatClass: "Optimist",
      division: "Gold",
      countsForRanking: true,
      raceCount: null,
    },
    {
      id: "ilca",
      name: "ILCA Open",
      date: "2026-10-11",
      slug: "ilca-open",
      boatClass: "ILCA 4",
      division: "Open",
      countsForRanking: true,
      raceCount: 5,
    },
  ];

  it("picks the soonest future Gold sheet that can count", () => {
    expect(
      pickNextCountingEvent(events, {
        today: "2026-10-02",
        seriesClass: "Optimist",
        fleet: "Gold",
      })
    ).toMatchObject({ name: "SYC Gold", date: "2026-10-18", href: "/regattas/syc-gold" });
  });

  it("picks the ILCA class sheet for an ILCA sailor", () => {
    expect(
      pickNextCountingEvent(events, {
        today: "2026-10-02",
        seriesClass: "ILCA 4",
        fleet: null,
      })?.name
    ).toBe("ILCA Open");
  });
});
