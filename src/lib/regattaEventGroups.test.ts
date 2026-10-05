import { describe, expect, it } from "vitest";
import type { RegattaRecord } from "@/lib/ranking";
import { resolveEventSlices } from "@/lib/regattaEvents";
import {
  groupedHubForSlug,
  hubHrefForClassSlug,
  isWingfoilBoatClass,
  regattaGroupKey,
  savedEventHubForSlug,
} from "./regattaEventGroups";

function row(
  partial: Pick<RegattaRecord, "slug" | "name" | "date"> &
    Partial<RegattaRecord>
): RegattaRecord {
  return {
    id: partial.slug,
    boatClass: "Optimist",
    totalFleetSize: 40,
    ...partial,
  };
}

describe("regattaGroupKey", () => {
  it("keeps March and July SAFYC apart and joins a gold/silver pair", () => {
    const march = regattaGroupKey({
      name: "SAFYC Gold (Mar 26)",
      date: "2026-03-28",
    });
    const july = regattaGroupKey({
      name: "SAFYC Gold (Jul 26)",
      date: "2026-07-04",
    });
    const julySilver = regattaGroupKey({
      name: "SAFYC Silver (Jul 26)",
      date: "2026-07-04",
    });
    expect(march).not.toBe(july);
    expect(july).toBe(julySilver);
  });
});

describe("groupedHubForSlug", () => {
  const published = [
    row({
      slug: "east-coast-gold-aug-25-2025-08-02",
      name: "East Coast Gold (Aug 25)",
      date: "2025-08-02",
      division: "Gold",
    }),
    row({
      slug: "east-coast-silver-aug-25-2025-08-02",
      name: "East Coast Silver (Aug 25)",
      date: "2025-08-02",
      division: "Silver",
    }),
    row({
      slug: "east-coast-ilca4-aug-25-2025-08-02",
      name: "East Coast ILCA4 (Aug 25)",
      date: "2025-08-02",
      boatClass: "ILCA 4",
    }),
    row({
      slug: "nsc-cup-1-gold-mar-25-2025-03-22",
      name: "NSC Cup 1 Gold (Mar 25)",
      date: "2025-03-22",
      division: "Gold",
    }),
    row({
      slug: "nsc-cup-1-silver-mar-25-2025-03-22",
      name: "NSC Cup 1 Silver (Mar 25)",
      date: "2025-03-22",
      division: "Silver",
    }),
    row({
      slug: "nsc-cup-2-gold-may-25-2025-05-31",
      name: "NSC Cup 2 Gold (May 25)",
      date: "2025-05-31",
      division: "Gold",
    }),
    row({
      slug: "cincapura-regatta-2026-gold",
      name: "Cincapura Regatta 2026 (Gold)",
      date: "2026-07-20",
      division: "Gold",
      raceCount: 3,
      totalFleetSize: 86,
    }),
  ];

  it("opens every class at a past regatta from one tabbed page", () => {
    const hub = groupedHubForSlug("east-coast-gold-aug-25-2025-08-02", published);
    expect(hub?.event.slug).toBe("east-coast-2025-08");
    expect(hub?.event.slices.map((slice) => slice.key)).toEqual([
      "optimist-gold",
      "optimist-silver",
      "ilca-4",
    ]);
    expect(hub?.fleetKey).toBe("optimist-gold");
    expect(groupedHubForSlug("east-coast-2025-08", published)?.fleetKey).toBeNull();
  });

  it("does not merge a later cup into an earlier one", () => {
    const hub = groupedHubForSlug("nsc-cup-1-gold-mar-25-2025-03-22", published);
    expect(hub?.event.slices.map((slice) => slice.label)).toEqual([
      "Optimist Gold",
      "Optimist Silver",
    ]);
    expect(groupedHubForSlug("nsc-cup-2-gold-may-25-2025-05-31", published)).toBeNull();
  });

  it("opens the main regatta slug onto the linked class sheets", () => {
    const published = [
      row({
        slug: "csc-silver-jan-25-2025-01-18",
        name: "CSC Optimist Championships 2025 (Optimist Silver)",
        date: "2025-01-18",
        endDate: "2025-01-19",
        division: "Silver",
        eventSlug: "csc-optimist-championships-2025",
        eventName: "CSC Optimist Championships 2025",
        venue: "Changi Sailing Club",
      }),
      row({
        slug: "csc-gold-jan-25-2025-01-25",
        name: "CSC Optimist Championships 2025 (Optimist Gold)",
        date: "2025-01-25",
        endDate: "2025-01-26",
        division: "Gold",
        eventSlug: "csc-optimist-championships-2025",
        eventName: "CSC Optimist Championships 2025",
        venue: "Changi Sailing Club",
      }),
    ];

    const hub = savedEventHubForSlug("csc-optimist-championships-2025", published);
    expect(hub?.event.name).toBe("CSC Optimist Championships 2025");
    expect(hub?.event.datesText).toBe("18 Jan 2025 – 26 Jan 2025");
    expect(hub?.event.slices.map((slice) => slice.key)).toEqual([
      "optimist-gold",
      "optimist-silver",
    ]);
    expect(savedEventHubForSlug("csc-silver-jan-25-2025-01-18", published)?.fleetKey).toBe(
      "optimist-silver"
    );
    expect(hubHrefForClassSlug("csc-gold-jan-25-2025-01-25", published)).toBe(
      "/regattas/csc-optimist-championships-2025?fleet=optimist-gold"
    );
  });

  it("opens the 21st SAFYC weekend on the sheets that have the race scores", () => {
    const published = [
      row({
        slug: "safyc-gold-feb-25-2025-02-15",
        name: "21st SAFYC Regatta 2025 (Optimist Gold Fleet)",
        date: "2025-02-15",
        endDate: "2025-02-16",
        division: "Gold",
        raceCount: 6,
        totalFleetSize: 86,
        eventSlug: "21st-safyc-regatta-2025",
        eventName: "21st SAFYC Regatta 2025",
      }),
      row({
        slug: "21st-safyc-regatta-2025-gold",
        name: "21st SAFYC Regatta 2025 (Optimist Gold)",
        date: "2025-02-15",
        endDate: "2025-02-16",
        division: "Gold",
        raceCount: 6,
        totalFleetSize: 86,
        eventSlug: "21st-safyc-regatta-2025",
        eventName: "21st SAFYC Regatta 2025",
      }),
      row({
        slug: "safyc-silver-feb-25-2025-02-15",
        name: "21st SAFYC Regatta 2025 (Optimist Silver Fleet)",
        date: "2025-02-15",
        endDate: "2025-02-16",
        division: "Silver",
        raceCount: 5,
        totalFleetSize: 75,
        eventSlug: "21st-safyc-regatta-2025",
        eventName: "21st SAFYC Regatta 2025",
      }),
      row({
        slug: "21st-safyc-regatta-2025-silver",
        name: "21st SAFYC Regatta 2025 (Optimist Silver)",
        date: "2025-02-15",
        endDate: "2025-02-16",
        division: "Silver",
        raceCount: 5,
        totalFleetSize: 75,
        eventSlug: "21st-safyc-regatta-2025",
        eventName: "21st SAFYC Regatta 2025",
      }),
    ];

    const hub = savedEventHubForSlug("21st-safyc-regatta-2025", published);
    expect(hub?.event.name).toBe("21st SAFYC Regatta 2025");
    expect(hub?.event.datesText).toBe("15 Feb 2025 – 16 Feb 2025");
    expect(hub?.event.slices.map((slice) => slice.slugIncludes?.[0])).toEqual([
      "21st-safyc-regatta-2025-gold",
      "21st-safyc-regatta-2025-silver",
    ]);
    expect(hubHrefForClassSlug("21st-safyc-regatta-2025-gold", published)).toBe(
      "/regattas/21st-safyc-regatta-2025?fleet=optimist-gold"
    );
    expect(hubHrefForClassSlug("safyc-silver-feb-25-2025-02-15", published)).toBe(
      "/regattas/21st-safyc-regatta-2025?fleet=optimist-silver"
    );
  });

  it("leaves a registered event on its own hub", () => {
    expect(groupedHubForSlug("cincapura-regatta-2026-gold", published)).toBeNull();
    expect(groupedHubForSlug("pesta-sukan-gold-aug-25-2025-08-02", published)).toBeNull();
  });

  it("does not treat Windsurfing as WingFoil", () => {
    expect(isWingfoilBoatClass("Windsurfing LT")).toBe(false);
    expect(isWingfoilBoatClass("Windsurfing")).toBe(false);
    expect(isWingfoilBoatClass("WingFoil")).toBe(true);
    expect(isWingfoilBoatClass("Wing Foil")).toBe(true);
    expect(isWingfoilBoatClass("Wing")).toBe(true);
  });

  it("lists Techno 293 and Windsurfing LT on the NSC Cup 2024 hub", () => {
    const published = [
      row({
        slug: "nsc-1-gold-dec-24-2024-11-30",
        name: "NSC Cup 2024 (Optimist Gold)",
        date: "2024-11-30",
        endDate: "2024-12-01",
        division: "Gold",
        boatClass: "Optimist",
        eventSlug: "nsc-cup-2024",
        eventName: "NSC Cup 2024",
      }),
      row({
        slug: "nsc-1-silver-dec-24-2024-11-30",
        name: "NSC Cup 2024 (Optimist Silver)",
        date: "2024-11-30",
        division: "Silver",
        boatClass: "Optimist",
        eventSlug: "nsc-cup-2024",
        eventName: "NSC Cup 2024",
      }),
      row({
        slug: "nsc-1-techno-293-dec-24-2024-11-30",
        name: "NSC Cup 2024 (Techno 293)",
        date: "2024-11-30",
        boatClass: "Techno 293",
        raceCount: 8,
        totalFleetSize: 12,
        eventSlug: "nsc-cup-2024",
        eventName: "NSC Cup 2024",
      }),
      row({
        slug: "nsc-1-windsurfing-lt-dec-24-2024-11-30",
        name: "NSC Cup 2024 (Windsurfing LT)",
        date: "2024-11-30",
        boatClass: "Windsurfing LT",
        raceCount: 8,
        totalFleetSize: 6,
        eventSlug: "nsc-cup-2024",
        eventName: "NSC Cup 2024",
      }),
      row({
        slug: "nsc-1-wingfoil-dec-24-2024-11-30",
        name: "NSC Cup 2024 (WingFoil)",
        date: "2024-11-30",
        boatClass: "WingFoil",
        eventSlug: "nsc-cup-2024",
        eventName: "NSC Cup 2024",
      }),
    ];

    const hub = savedEventHubForSlug("nsc-cup-2024", published);
    expect(hub?.event.slices.map((slice) => slice.key)).toEqual([
      "optimist-gold",
      "optimist-silver",
      "techno-293",
      "windsurfing-lt",
    ]);
    expect(hub?.event.slices.map((slice) => slice.series)).toEqual([
      "optimist",
      "optimist",
      "techno293",
      "windsurfing",
    ]);
    expect(hub?.event.slices.find((slice) => slice.key === "windsurfing-lt")?.label).toBe(
      "Windsurfing LT"
    );
    expect(hub?.event.slices.some((slice) => slice.series === "wingfoil")).toBe(false);

    const resolved = resolveEventSlices(hub!.event, published);
    expect(resolved.find((slice) => slice.def.key === "techno-293")?.regatta?.slug).toBe(
      "nsc-1-techno-293-dec-24-2024-11-30"
    );
    expect(resolved.find((slice) => slice.def.key === "windsurfing-lt")?.regatta?.slug).toBe(
      "nsc-1-windsurfing-lt-dec-24-2024-11-30"
    );

    expect(hubHrefForClassSlug("nsc-1-techno-293-dec-24-2024-11-30", published)).toBe(
      "/regattas/nsc-cup-2024?fleet=techno-293"
    );
    expect(hubHrefForClassSlug("nsc-1-windsurfing-lt-dec-24-2024-11-30", published)).toBe(
      "/regattas/nsc-cup-2024?fleet=windsurfing-lt"
    );
  });

  it("puts NSC Cup 2 2024 Techno on that hub and keeps ILCA 6 on its tab", () => {
    const published = [
      row({
        slug: "nsc-2-gold-nov-24-2024-11-18",
        name: "NSC Cup 2 2024 (Optimist Gold)",
        date: "2024-11-16",
        endDate: "2024-11-18",
        division: "Gold",
        boatClass: "Optimist",
        eventSlug: "nsc-cup-2-2024",
        eventName: "NSC Cup 2 2024",
      }),
      row({
        slug: "nsc-2-silver-nov-24-2024-11-18",
        name: "NSC Cup 2 2024 (Optimist Silver)",
        date: "2024-11-16",
        division: "Silver",
        boatClass: "Optimist",
        eventSlug: "nsc-cup-2-2024",
        eventName: "NSC Cup 2 2024",
      }),
      row({
        slug: "nsc-2-ilca4-nov-24-2024-11-16",
        name: "NSC Cup 2 2024 (ILCA 4)",
        date: "2024-11-16",
        boatClass: "ILCA 4",
        eventSlug: "nsc-cup-2-2024",
        eventName: "NSC Cup 2 2024",
      }),
      row({
        slug: "nsc-2-ilca6-nov-24-2024-11-16",
        name: "NSC Cup 2 2024 (ILCA 6)",
        date: "2024-11-16",
        boatClass: "ILCA 6",
        eventSlug: "nsc-cup-2-2024",
        eventName: "NSC Cup 2 2024",
      }),
      row({
        slug: "nsc-2-techno-293-nov-24-2024-11-16",
        name: "NSC Cup 2 2024 (Techno 293)",
        date: "2024-11-16",
        boatClass: "Techno 293",
        eventSlug: "nsc-cup-2-2024",
        eventName: "NSC Cup 2 2024",
      }),
    ];

    const hub = savedEventHubForSlug("nsc-cup-2-2024", published);
    expect(hub?.event.slices.map((slice) => slice.label)).toEqual([
      "Optimist Gold",
      "Optimist Silver",
      "ILCA 4",
      "ILCA 6",
      "Techno 293",
    ]);
    expect(hubHrefForClassSlug("nsc-2-techno-293-nov-24-2024-11-16", published)).toBe(
      "/regattas/nsc-cup-2-2024?fleet=techno-293"
    );
    expect(hubHrefForClassSlug("nsc-2-ilca6-nov-24-2024-11-16", published)).toBe(
      "/regattas/nsc-cup-2-2024?fleet=ilca-6"
    );
  });

  it("leaves SNSC static WingFoil and Techno boards on the registered hub", () => {
    const published = [
      row({
        slug: "snsc-2026-wingfoil",
        name: "SNSC 2026 (WingFoil)",
        date: "2026-09-05",
        boatClass: "WingFoil",
        eventSlug: "snsc-2026",
        eventName: "Singapore National Sailing Championships 2026",
      }),
      row({
        slug: "snsc-2026-techno-293",
        name: "SNSC 2026 (Techno 293)",
        date: "2026-09-05",
        boatClass: "Techno 293",
        eventSlug: "snsc-2026",
        eventName: "Singapore National Sailing Championships 2026",
      }),
    ];
    expect(savedEventHubForSlug("snsc-2026", published)).toBeNull();
    expect(savedEventHubForSlug("snsc-2026-wingfoil", published)).toBeNull();
    expect(hubHrefForClassSlug("snsc-2026", published)).toBe("/regattas/snsc-2026");
  });
});
