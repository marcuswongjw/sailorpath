import { describe, expect, it } from "vitest";
import {
  getPublicCalendarEvents,
  getClassRegattas,
  getNormalizedClassRegattas,
  getPublishedScorecardRegattas,
} from "./publicDataLoader";

describe("publicDataLoader shared layer", () => {
  it("excludes series combined standings from the calendar", () => {
    const calendarEvents = getPublicCalendarEvents({
      referenceDate: new Date("2026-10-06T00:00:00Z"),
    });

    const combined = calendarEvents.find((e) => e.slug.includes("combined"));
    expect(combined).toBeUndefined();

    // 2025 Series 2 and GPS Challenge exist
    const series2 = calendarEvents.find(
      (e) => e.slug === "ne-monsoon-grand-prix-2025-series-2"
    );
    expect(series2).toBeDefined();
    expect(series2?.classes).toContain("Wingfoil");
    expect(series2?.classes).toContain("Techno 293");
    expect(series2?.resultStatus).toBe("provisional");
    expect(series2?.timingStatus).toBe("completed");

    const gps = calendarEvents.find(
      (e) => e.slug === "ne-monsoon-grand-prix-2025-gps-speed-challenge"
    );
    expect(gps).toBeDefined();
    expect(gps?.venue).toBe("Singapore waters");
    expect(gps?.resultStatus).toBe("final");
    expect(gps?.timingStatus).toBe("completed");
  });

  it("returns class regatta lists with links to the canonical event and selected class tab", () => {
    const wingfoilRegattas = getClassRegattas("wingfoil", {
      referenceDate: new Date("2026-10-06T00:00:00Z"),
    });

    // Excludes combined sheets from regattas view
    expect(wingfoilRegattas.find((r) => r.eventSlug.includes("combined"))).toBeUndefined();

    // Contains Series 2 and GPS challenge
    const s2 = wingfoilRegattas.find(
      (r) => r.eventSlug === "ne-monsoon-grand-prix-2025-series-2"
    );
    expect(s2).toBeDefined();
    expect(s2?.canonicalHref).toBe("/regattas/ne-monsoon-grand-prix-2025-series-2?fleet=wingfoil");
    expect(s2?.resultStatus).toBe("provisional");
    expect(s2?.competitorCount).toBe(17);

    const gps = wingfoilRegattas.find(
      (r) => r.eventSlug === "ne-monsoon-grand-prix-2025-gps-speed-challenge"
    );
    expect(gps).toBeDefined();
    expect(gps?.canonicalHref).toBe("/regattas/ne-monsoon-grand-prix-2025-gps-speed-challenge?fleet=wingfoil");
    expect(gps?.resultStatus).toBe("final");
    expect(gps?.competitorCount).toBe(17);
  });

  it("filters class regattas by year", () => {
    const regattas2025 = getClassRegattas("techno293", {
      year: 2025,
      referenceDate: new Date("2026-10-06T00:00:00Z"),
    });
    expect(regattas2025.length).toBeGreaterThanOrEqual(2);
    expect(regattas2025.every((r) => r.startDate.startsWith("2025"))).toBe(true);
  });

  it("surfaces published special scorecards without a catalog entry", () => {
    const rows = getPublishedScorecardRegattas(
      "wingfoil",
      [
        {
          id: "unregistered-wingfoil-round",
          name: "Unregistered WingFoil Round",
          dates: "2026-10-10",
          venue: "Singapore",
          lifecycleStatus: "published",
          results: [{ rank: 1 }],
        },
        {
          id: "combined-wingfoil-series",
          name: "Combined WingFoil Series",
          dates: "2026-10-11",
          lifecycleStatus: "published",
          results: [{ rank: 1 }],
        },
      ],
      { parseDate: (dates) => Date.parse(String(dates)) }
    );

    expect(rows).toHaveLength(1);
    expect(rows[0]).toMatchObject({
      eventSlug: "unregistered-wingfoil-round",
      canonicalHref: "/sg/wingfoil?tab=results&regatta=unregistered-wingfoil-round",
      source: { kind: "special_scorecard", label: "Published scorecard" },
    });
  });

  it("projects iQFOiL from normalized sheets rather than a special scoreboard", () => {
    const rows = getNormalizedClassRegattas("iqfoil", [
      {
        id: "iqfoil-sheet",
        slug: "sample-iqfoil",
        name: "Sample iQFoil Open",
        date: "2026-03-14",
        endDate: "2026-03-16",
        totalFleetSize: 8,
        boatClass: "iQFoil",
        division: "Open",
        raceCount: 5,
      },
      {
        id: "wingfoil-sheet",
        slug: "sample-wingfoil",
        name: "Sample WingFoil Open",
        date: "2026-03-14",
        totalFleetSize: 8,
        boatClass: "WingFoil",
      },
    ]);

    expect(rows).toHaveLength(1);
    expect(rows[0]).toMatchObject({
      name: "Sample iQFoil Open",
      fleetKey: "iqfoil",
      source: { kind: "normalized_result", label: "Normalized result" },
    });
  });
});
