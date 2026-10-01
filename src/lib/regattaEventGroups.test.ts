import { describe, expect, it } from "vitest";
import type { RegattaRecord } from "@/lib/ranking";
import {
  groupedHubForSlug,
  hubHrefForClassSlug,
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

  it("leaves a registered event on its own hub", () => {
    expect(groupedHubForSlug("cincapura-regatta-2026-gold", published)).toBeNull();
    expect(groupedHubForSlug("pesta-sukan-gold-aug-25-2025-08-02", published)).toBeNull();
  });
});
