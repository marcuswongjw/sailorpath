import { describe, expect, it } from "vitest";
import type { RegattaRecord } from "@/lib/ranking";
import {
  defaultEventFleetKey,
  eventHubHref,
  findEventSliceForRegattaSlug,
  getRegattaEvent,
  getSliceResultAvailability,
  getStaticBoardRegatta,
  resolveEventSlices,
  sliceMatchesRegattaSlug,
  CINCAPURA_2026_EVENT,
  PESTA_SUKAN_2025_EVENT,
  PESTA_SUKAN_2026_EVENT,
  SAFYC_OPTIMIST_2025_EVENT,
  SAFYC_OPTIMIST_2026_EVENT,
  SNSC_2025_EVENT,
  SNSC_2026_EVENT,
  PSA_NATIONAL_ELIMINATION_SERIES_2026_EVENT,
  RSYC_OPTIMIST_2026_EVENT,
  RSYC_OPTIMIST_GOLD_2026_EVENT,
  YOUTH_THAILAND_NATIONAL_SAILING_CHAMPIONSHIP_2026_EVENT,
} from "@/lib/regattaEvents";

function regatta(slug: string): RegattaRecord {
  return {
    id: `id-${slug}`,
    name: slug,
    slug,
    date: "2026-09-11",
    totalFleetSize: 40,
  };
}

const LIVE_SLUGS = [
  "snsc-gold-sep-26-2026-09-11",
  "snsc-silver-sep-26-2026-09-05",
  "snsc-ilca-4-sep-26-2026-09-11",
  // Other events that must NOT match
  "cincapura-regatta-2026-gold",
  "snsc-gold-sep-25-2025-09-06",
  "pesta-sukan-gold-aug-26-2026-08-01",
];

describe("getRegattaEvent", () => {
  it("resolves the SNSC 2026 event slug case-insensitively", () => {
    expect(getRegattaEvent("snsc-2026")?.slug).toBe("snsc-2026");
    expect(getRegattaEvent("SNSC-2026")?.slug).toBe("snsc-2026");
  });

  it("returns null for slice slugs and unknown events", () => {
    expect(getRegattaEvent("snsc-gold-sep-26-2026-09-11")).toBeNull();
    expect(getRegattaEvent("")).toBeNull();
  });

  it("opens the other 2026 regattas, including both Pesta calendar cards, on one event", () => {
    expect(getRegattaEvent("cincapura-regatta-2026")?.slices.map((s) => s.key)).toEqual([
      "optimist-gold",
      "optimist-silver",
      "ilca-4",
      "ilca-6",
      "29er",
      "techno-293",
    ]);
    expect(getRegattaEvent("sysc-2026")?.slices.map((s) => s.key)).toEqual([
      "optimist-gold",
      "optimist-silver",
      "ilca-4",
      "ilca-6",
      "29er",
      "techno-293",
      "iqfoil",
    ]);
    expect(getRegattaEvent("pesta-sukan-regatta-2026-optimist")?.slug).toBe("pesta-sukan-2026");
    expect(getRegattaEvent("pesta-sukan-regatta-2026-ilca-wingfoil")?.slug).toBe("pesta-sukan-2026");
    expect(getRegattaEvent("singapore-national-sailing-championships-2026")?.slug).toBe("snsc-2026");
    expect(getRegattaEvent("singapore-national-sailing-championships-2025")?.slug).toBe("snsc-2025");
    expect(getRegattaEvent("snsc-2025")?.slug).toBe("snsc-2025");
  });
});

describe("PSA National Elimination Series 2026 hub", () => {
  it("resolves the hub slug and links the four draft class slices", () => {
    const event = getRegattaEvent("psa-national-elimination-series-2026");
    expect(event?.name).toBe("PSA National Elimination Series 2026");
    expect(event?.slices.map((s) => s.key)).toEqual([
      "optimist",
      "ilca-4",
      "ilca-6",
      "ilca-7",
    ]);
    expect(event?.scheduleSummary).toMatch(/NTP/);
    expect(event?.officialNoticeBoardUrl).toBe(
      "https://www.racingrulesofsailing.org/documents/15290/event"
    );
  });

  it("maps each draft class slug to the correct fleet without cross-matching", () => {
    const [opt, ilca4, ilca6, ilca7] = PSA_NATIONAL_ELIMINATION_SERIES_2026_EVENT.slices;
    expect(sliceMatchesRegattaSlug(opt, "psa-national-elimination-series-2026-optimist")).toBe(true);
    expect(sliceMatchesRegattaSlug(ilca4, "psa-national-elimination-series-2026-ilca-4")).toBe(true);
    expect(sliceMatchesRegattaSlug(ilca6, "psa-national-elimination-series-2026-ilca-6")).toBe(true);
    expect(sliceMatchesRegattaSlug(ilca7, "psa-national-elimination-series-2026-ilca-7")).toBe(true);

    expect(sliceMatchesRegattaSlug(ilca4, "psa-national-elimination-series-2026-ilca-6")).toBe(false);
    expect(sliceMatchesRegattaSlug(ilca6, "psa-national-elimination-series-2026-ilca-4")).toBe(false);
    expect(sliceMatchesRegattaSlug(opt, "psa-national-elimination-series-2026-ilca-4")).toBe(false);

    expect(findEventSliceForRegattaSlug("psa-national-elimination-series-2026-ilca-7")).toEqual({
      event: PSA_NATIONAL_ELIMINATION_SERIES_2026_EVENT,
      slice: ilca7,
    });
  });
});


describe("Youth Thailand National Sailing Championship 2026 hub", () => {
  it("resolves the hub slug and links Optimist Open + ILCA 4 draft slices", () => {
    const event = getRegattaEvent("youth-thailand-national-sailing-championship-2026");
    expect(event?.name).toBe("Youth Thailand National Sailing Championship 2026");
    expect(event?.slices.map((s) => s.key)).toEqual(["optimist", "ilca-4"]);
    expect(event?.scheduleSummary).toMatch(/Does not count toward Singapore ranking/);
    expect(event?.officialNoticeBoardUrl).toBe(
      "https://www.racingrulesofsailing.org/documents/15865/event"
    );
  });

  it("maps each draft class slug without cross-matching", () => {
    const [opt, ilca4] = YOUTH_THAILAND_NATIONAL_SAILING_CHAMPIONSHIP_2026_EVENT.slices;
    expect(
      sliceMatchesRegattaSlug(
        opt,
        "youth-thailand-national-sailing-championship-2026-optimist"
      )
    ).toBe(true);
    expect(
      sliceMatchesRegattaSlug(
        ilca4,
        "youth-thailand-national-sailing-championship-2026-ilca-4"
      )
    ).toBe(true);
    expect(
      sliceMatchesRegattaSlug(
        opt,
        "youth-thailand-national-sailing-championship-2026-ilca-4"
      )
    ).toBe(false);
    expect(
      findEventSliceForRegattaSlug(
        "youth-thailand-national-sailing-championship-2026-ilca-4"
      )
    ).toEqual({
      event: YOUTH_THAILAND_NATIONAL_SAILING_CHAMPIONSHIP_2026_EVENT,
      slice: ilca4,
    });
  });
});

describe("RSYC Optimist Knockout 2026", () => {
  const silverSlug = "rsyc-optimist-silver-fleet-knockout-championship-2026";
  const goldSlug = "rsyc-optimist-gold-fleet-knockout-championship-2026";

  it("opens Gold and Silver as separate event hubs", () => {
    expect(getRegattaEvent(silverSlug)?.slug).toBe(silverSlug);
    expect(getRegattaEvent(goldSlug)?.slug).toBe(goldSlug);
    expect(getRegattaEvent(silverSlug)?.slices.map((slice) => slice.key)).toEqual([
      "optimist-silver",
    ]);
    expect(getRegattaEvent(goldSlug)?.slices.map((slice) => slice.key)).toEqual([
      "optimist-gold",
    ]);
    expect(getRegattaEvent("rsyc-knockout-2026")?.slug).toBe(silverSlug);
  });

  it("keeps Gold results off the Silver slice and Silver results off the Gold slice", () => {
    const [silverSlice] = RSYC_OPTIMIST_2026_EVENT.slices;
    const [goldSlice] = RSYC_OPTIMIST_GOLD_2026_EVENT.slices;

    expect(sliceMatchesRegattaSlug(silverSlice, silverSlug)).toBe(true);
    expect(sliceMatchesRegattaSlug(silverSlice, goldSlug)).toBe(false);
    expect(sliceMatchesRegattaSlug(goldSlice, goldSlug)).toBe(true);
    expect(sliceMatchesRegattaSlug(goldSlice, silverSlug)).toBe(false);
    expect(sliceMatchesRegattaSlug(goldSlice, "rsyc-optimist-gold-fleet-knockout-championship-2025")).toBe(
      false
    );

    expect(findEventSliceForRegattaSlug(goldSlug)).toEqual({
      event: RSYC_OPTIMIST_GOLD_2026_EVENT,
      slice: goldSlice,
    });
    expect(findEventSliceForRegattaSlug(silverSlug)?.event.slug).toBe(silverSlug);

    const silverResolved = resolveEventSlices(RSYC_OPTIMIST_2026_EVENT, [
      regatta(silverSlug),
      regatta(goldSlug),
    ]);
    expect(silverResolved.map((slice) => slice.regatta?.slug ?? null)).toEqual([silverSlug]);

    const goldResolved = resolveEventSlices(RSYC_OPTIMIST_GOLD_2026_EVENT, [
      regatta(silverSlug),
      regatta(goldSlug),
    ]);
    expect(goldResolved.map((slice) => slice.regatta?.slug ?? null)).toEqual([goldSlug]);
  });
});

describe("sliceMatchesRegattaSlug", () => {
  it("matches the live SNSC 2026 slice slugs to the right slices", () => {
    const [gold, silver, ilca] = SNSC_2026_EVENT.slices;
    expect(sliceMatchesRegattaSlug(gold, "snsc-gold-sep-26-2026-09-11")).toBe(true);
    expect(sliceMatchesRegattaSlug(silver, "snsc-silver-sep-26-2026-09-05")).toBe(true);
    expect(sliceMatchesRegattaSlug(ilca, "snsc-ilca-4-sep-26-2026-09-11")).toBe(true);
  });

  it("matches the full-name SNSC 2026 slugs to the right slices", () => {
    const [gold, silver, ilca4, ilca6, ilca7] = SNSC_2026_EVENT.slices;
    expect(
      sliceMatchesRegattaSlug(gold, "singapore-national-sailing-championships-2026-gold")
    ).toBe(true);
    expect(
      sliceMatchesRegattaSlug(silver, "singapore-national-sailing-championships-2026-silver")
    ).toBe(true);
    expect(
      sliceMatchesRegattaSlug(ilca4, "singapore-national-sailing-championships-2026-ilca4")
    ).toBe(true);
    expect(
      sliceMatchesRegattaSlug(ilca6, "snsc-ilca-6-sep-26")
    ).toBe(true);
    expect(
      sliceMatchesRegattaSlug(ilca7, "singapore-national-sailing-championships-2026-ilca7")
    ).toBe(true);

    expect(
      sliceMatchesRegattaSlug(gold, "singapore-national-sailing-championships-2026-silver")
    ).toBe(false);
    expect(
      sliceMatchesRegattaSlug(silver, "singapore-national-sailing-championships-2026-gold")
    ).toBe(false);
    expect(
      sliceMatchesRegattaSlug(ilca4, "singapore-national-sailing-championships-2026-gold")
    ).toBe(false);
  });

  it("matches the live SNSC 2025 slice slugs to the right slices", () => {
    const [gold, silver, ilca4, ilca6] = SNSC_2025_EVENT.slices;
    expect(sliceMatchesRegattaSlug(gold, "snsc-gold-sep-25-2025-09-06")).toBe(true);
    expect(sliceMatchesRegattaSlug(silver, "snsc-silver-sep-25-2025-09-06")).toBe(true);
    expect(sliceMatchesRegattaSlug(ilca4, "snsc-ilca-4-sep-25-2025-09-06")).toBe(true);
    expect(sliceMatchesRegattaSlug(ilca6, "snsc-ilca-6-sep-25-2025-09-06")).toBe(true);
  });

  it("does not cross-match slices or other years", () => {
    const [gold, silver, ilca] = SNSC_2026_EVENT.slices;
    expect(sliceMatchesRegattaSlug(gold, "snsc-silver-sep-26-2026-09-05")).toBe(false);
    expect(sliceMatchesRegattaSlug(silver, "snsc-gold-sep-26-2026-09-11")).toBe(false);
    expect(sliceMatchesRegattaSlug(ilca, "snsc-gold-sep-26-2026-09-11")).toBe(false);
    expect(sliceMatchesRegattaSlug(ilca, "snsc-ilca-6-sep-26-2026-09-11")).toBe(false);
    expect(sliceMatchesRegattaSlug(ilca, "snsc-ilca-7-sep-26-2026-09-11")).toBe(false);
    expect(sliceMatchesRegattaSlug(gold, "snsc-gold-sep-25-2025-09-06")).toBe(false);
    expect(sliceMatchesRegattaSlug(gold, "cincapura-regatta-2026-gold")).toBe(false);
  });

  it("keeps Pesta 2025 and the two SAFYC months off the wrong event", () => {
    const [pestaGold, , pestaIlca] = PESTA_SUKAN_2026_EVENT.slices;
    const [julyGold] = SAFYC_OPTIMIST_2026_EVENT.slices;
    expect(sliceMatchesRegattaSlug(pestaGold, "pesta-sukan-gold-aug-25-2025-08-02")).toBe(false);
    expect(sliceMatchesRegattaSlug(pestaIlca, "pesta-sukan-ilca4-aug-26-2026-08-01")).toBe(true);
    expect(sliceMatchesRegattaSlug(julyGold, "safyc-gold-mar-26-2026-03-28")).toBe(false);
    expect(sliceMatchesRegattaSlug(julyGold, "safyc-gold-jul-26-2026-07-04")).toBe(true);

    const [safyc25Gold, safyc25Silver] = SAFYC_OPTIMIST_2025_EVENT.slices;
    expect(sliceMatchesRegattaSlug(safyc25Gold, "21st-safyc-regatta-2025-gold")).toBe(false);
    expect(sliceMatchesRegattaSlug(safyc25Gold, "safyc-gold-feb-25-2025-02-15")).toBe(false);
    expect(sliceMatchesRegattaSlug(safyc25Gold, "safyc-optimist-2025-gold")).toBe(true);
    expect(sliceMatchesRegattaSlug(safyc25Silver, "21st-safyc-regatta-2025-silver")).toBe(false);
    expect(sliceMatchesRegattaSlug(safyc25Silver, "safyc-silver-feb-25-2025-02-15")).toBe(false);
    expect(sliceMatchesRegattaSlug(safyc25Silver, "safyc-silver-jul-25-2025-07-12")).toBe(true);
    expect(findEventSliceForRegattaSlug("21st-safyc-regatta-2025-gold")).toBeNull();
    expect(findEventSliceForRegattaSlug("safyc-silver-feb-25-2025-02-15")).toBeNull();
    expect(findEventSliceForRegattaSlug("safyc-optimist-2025-gold")?.event.slug).toBe(
      "1st-safyc-optimist-championship-2025"
    );

    const [pesta25Gold, pesta25Silver, pesta25Ilca4, pesta25Ilca6] = PESTA_SUKAN_2025_EVENT.slices;
    expect(sliceMatchesRegattaSlug(pesta25Gold, "pesta-sukan-gold-aug-25-2025-08-02")).toBe(true);
    expect(sliceMatchesRegattaSlug(pesta25Silver, "pesta-sukan-silver-aug-25-2025-08-02")).toBe(true);
    expect(sliceMatchesRegattaSlug(pesta25Ilca4, "pesta-sukan-ilca-4-aug-25-2025-08-02")).toBe(true);
    expect(sliceMatchesRegattaSlug(pesta25Ilca6, "pesta-sukan-ilca-6-aug-25-2025-08-02")).toBe(true);
    expect(sliceMatchesRegattaSlug(pesta25Ilca6, "pesta-sukan-ilca6-aug-25-2025-08-02")).toBe(true);
    expect(sliceMatchesRegattaSlug(pesta25Ilca4, "pesta-sukan-ilca6-aug-25-2025-08-02")).toBe(false);
  });

  it("matches slugified ILCA 6 and ILCA 7 sheets without taking ILCA 4", () => {
    const temasek = findEventSliceForRegattaSlug("temasek-ilca6-jun-26-2026-06-20");
    expect(temasek?.event.slug).toBe("temasek-regatta-2026");
    expect(temasek?.slice.key).toBe("ilca-6");
    expect(findEventSliceForRegattaSlug("temasek-ilca-6-jun-26-2026-06-20")?.slice.key).toBe("ilca-6");
    expect(findEventSliceForRegattaSlug("temasek-ilca7-jun-26-2026-06-20")?.slice.key).toBe("ilca-7");
    expect(findEventSliceForRegattaSlug("temasek-ilca4-jun-26-2026-06-20")?.slice.key).toBe("ilca-4");
    expect(findEventSliceForRegattaSlug("cincapura-2026-ilca6")?.slice.key).toBe("ilca-6");
    expect(findEventSliceForRegattaSlug("cincapura-2026-ilca4")?.slice.key).toBe("ilca-4");
    expect(findEventSliceForRegattaSlug("snsc-ilca6-sep-26-2026-09-11")?.slice.key).toBe("ilca-6");
    expect(findEventSliceForRegattaSlug("snsc-ilca6-sep-26-2026-09-11")?.slice.key).not.toBe("ilca-4");
  });

  it("keeps the fuller Cincapura sheet when the fleet was imported twice", () => {
    const slices = resolveEventSlices(CINCAPURA_2026_EVENT, [
      regatta("cincapura-gold-jul-26-2026-07-18"),
      { ...regatta("cincapura-regatta-2026-gold"), raceCount: 3, totalFleetSize: 86 },
    ]);
    expect(slices.find((slice) => slice.def.key === "optimist-gold")?.regatta?.slug).toBe(
      "cincapura-regatta-2026-gold"
    );
  });

  it("never matches slices without slug tokens (board classes)", () => {
    const wingfoil = SNSC_2026_EVENT.slices.find((s) => s.key === "wingfoil")!;
    expect(sliceMatchesRegattaSlug(wingfoil, "snsc-2026-wingfoil")).toBe(false);
  });
});

describe("resolveEventSlices", () => {
  it("maps each DB-backed slice to its regatta row and claims rows once", () => {
    const slices = resolveEventSlices(
      SNSC_2026_EVENT,
      LIVE_SLUGS.map(regatta)
    );
    const byKey = new Map(slices.map((s) => [s.def.key, s.regatta?.slug ?? null]));
    expect(byKey.get("optimist-gold")).toBe("snsc-gold-sep-26-2026-09-11");
    expect(byKey.get("optimist-silver")).toBe("snsc-silver-sep-26-2026-09-05");
    expect(byKey.get("ilca-4")).toBe("snsc-ilca-4-sep-26-2026-09-11");
    expect(byKey.get("wingfoil")).toBeNull();
    expect(byKey.get("techno-293")).toBeNull();
  });

  it("leaves slices unmatched when the regatta row is missing", () => {
    const slices = resolveEventSlices(SNSC_2026_EVENT, [
      regatta("snsc-gold-sep-26-2026-09-11"),
    ]);
    const silver = slices.find((s) => s.def.key === "optimist-silver")!;
    expect(silver.regatta).toBeNull();
  });
});

describe("getStaticBoardRegatta", () => {
  it("resolves the SNSC board-class scoreboards", () => {
    const wingfoil = SNSC_2026_EVENT.slices.find((s) => s.key === "wingfoil")!;
    const techno = SNSC_2026_EVENT.slices.find((s) => s.key === "techno-293")!;
    expect(getStaticBoardRegatta(wingfoil)?.id).toBe("snsc-2026-wingfoil");
    expect(getStaticBoardRegatta(techno)?.id).toBe("techno-snsc-2026");
    expect(getStaticBoardRegatta(SNSC_2026_EVENT.slices[0])).toBeNull();
  });
});

describe("findEventSliceForRegattaSlug", () => {
  it("points a class slug back at the event hub tab", () => {
    const ilca = findEventSliceForRegattaSlug("snsc-ilca-4-sep-26-2026-09-11");
    expect(ilca?.event.slug).toBe("snsc-2026");
    expect(ilca?.slice.key).toBe("ilca-4");
    expect(eventHubHref("snsc-2026", "ilca-4")).toBe(
      "/regattas/snsc-2026?fleet=ilca-4"
    );

    const silver = findEventSliceForRegattaSlug("snsc-silver-sep-26-2026-09-05");
    expect(silver?.slice.key).toBe("optimist-silver");
    expect(
      silver && eventHubHref(silver.event.slug, silver.slice.key)
    ).toBe("/regattas/snsc-2026?fleet=optimist-silver");
  });

  it("gives ILCA 6 and ILCA 7 a public SNSC tab, but not 29er", () => {
    expect(findEventSliceForRegattaSlug("snsc-ilca-6-sep-26-2026-09-11")?.slice.key).toBe("ilca-6");
    expect(findEventSliceForRegattaSlug("snsc-ilca-7-sep-26-2026-09-11")?.slice.key).toBe("ilca-7");
    expect(findEventSliceForRegattaSlug("snsc-29er-sep-26-2026-09-11")).toBeNull();
    expect(findEventSliceForRegattaSlug("cincapura-regatta-2026-gold")?.event.slug).toBe(
      "cincapura-regatta-2026"
    );
  });
});

describe("defaultEventFleetKey", () => {
  it("prefers the first slice with data", () => {
    const slices = resolveEventSlices(
      SNSC_2026_EVENT,
      LIVE_SLUGS.map(regatta)
    );
    expect(defaultEventFleetKey(SNSC_2026_EVENT, slices)).toBe("optimist-gold");
  });

  it("falls back to board-class data when no DB slices matched", () => {
    const slices = resolveEventSlices(SNSC_2026_EVENT, []);
    expect(defaultEventFleetKey(SNSC_2026_EVENT, slices)).toBe("wingfoil");
  });
});

describe("resolveEventSlices", () => {
  it("resolves both full-name slugs and linked event rows for SNSC 2026", () => {
    const mockRegattas: RegattaRecord[] = [
      {
        id: "r-gold",
        name: "Optimist Gold",
        slug: "singapore-national-sailing-championships-2026-gold",
        date: "2026-09-11",
        boatClass: "Optimist",
        division: "Gold",
        totalFleetSize: 83,
        raceCount: 6,
        countsForRanking: true,
        isSelectionTrial: true,
        eventId: "event-snsc-2026",
        eventSlug: "snsc-2026",
      },
      {
        id: "r-silver",
        name: "Optimist Silver",
        slug: "singapore-national-sailing-championships-2026-silver",
        date: "2026-09-05",
        boatClass: "Optimist",
        division: "Silver",
        totalFleetSize: 50,
        raceCount: 7,
        countsForRanking: true,
        isSelectionTrial: false,
        eventId: "event-snsc-2026",
        eventSlug: "snsc-2026",
      },
      {
        id: "r-ilca4",
        name: "Singapore National Sailing Championships 2026 (ILCA 4)",
        slug: "singapore-national-sailing-championships-2026-ilca4",
        date: "2026-09-05",
        boatClass: "ILCA 4",
        division: "Open",
        totalFleetSize: 46,
        raceCount: 9,
        countsForRanking: true,
        isSelectionTrial: true,
        eventId: "event-snsc-2026",
        eventSlug: "snsc-2026",
      },
      {
        id: "r-ilca6",
        name: "ILCA 6",
        slug: "snsc-ilca-6-sep-26",
        date: "2026-09-11",
        boatClass: "ILCA 6",
        division: "Open",
        totalFleetSize: 19,
        raceCount: 9,
        countsForRanking: true,
        isSelectionTrial: false,
        eventId: "event-snsc-2026",
        eventSlug: "snsc-2026",
      },
    ];

    const resolved = resolveEventSlices(SNSC_2026_EVENT, mockRegattas);
    const goldSlice = resolved.find((s) => s.def.key === "optimist-gold");
    const silverSlice = resolved.find((s) => s.def.key === "optimist-silver");
    const ilca4Slice = resolved.find((s) => s.def.key === "ilca-4");
    const ilca6Slice = resolved.find((s) => s.def.key === "ilca-6");

    expect(goldSlice?.regatta?.id).toBe("r-gold");
    expect(goldSlice?.regatta?.totalFleetSize).toBe(83);
    expect(silverSlice?.regatta?.id).toBe("r-silver");
    expect(silverSlice?.regatta?.totalFleetSize).toBe(50);
    expect(ilca4Slice?.regatta?.id).toBe("r-ilca4");
    expect(ilca4Slice?.regatta?.totalFleetSize).toBe(46);
    expect(ilca6Slice?.regatta?.id).toBe("r-ilca6");
    expect(ilca6Slice?.regatta?.totalFleetSize).toBe(19);
  });
});

describe("2025 NE Monsoon events and getSliceResultAvailability", () => {
  it("resolves the 2025 NE Monsoon Series 2 event with schedules and provisional status", () => {
    const event = getRegattaEvent("ne-monsoon-grand-prix-2025-series-2");
    expect(event).toBeDefined();
    expect(event?.name).toBe("2025 Northeast Monsoon Grand Prix Series 2");
    expect(event?.schedules).toHaveLength(1);
    expect(event?.schedules?.[0].startDate).toBe("2025-02-08");
    expect(event?.schedules?.[0].endDate).toBe("2025-02-09");
    expect(event?.seriesLinks?.[0].seriesId).toBe("ne-monsoon-2025");

    const slices = resolveEventSlices(event!, []);
    const wingfoilSlice = slices.find((s) => s.def.key === "wingfoil");
    expect(wingfoilSlice).toBeDefined();
    const avail = getSliceResultAvailability(wingfoilSlice!);
    expect(avail.status).toBe("provisional");
    expect(avail.competitorCount).toBe(17);
    expect(avail.label).toContain("Provisional · 17 competitors");
  });

  it("resolves the 2025 NE Monsoon GPS Speed Challenge event as final", () => {
    const event = getRegattaEvent("ne-monsoon-grand-prix-2025-gps-speed-challenge");
    expect(event).toBeDefined();
    expect(event?.schedules?.[0].isDateRange).toBe(true);
    expect(event?.venue).toBe("Singapore waters");

    const slices = resolveEventSlices(event!, []);
    const technoSlice = slices.find((s) => s.def.key === "techno293");
    expect(technoSlice).toBeDefined();
    const avail = getSliceResultAvailability(technoSlice!);
    expect(avail.status).toBe("final");
    expect(avail.competitorCount).toBe(5);
    expect(avail.label).toContain("Final · 5 competitors");
  });
});
