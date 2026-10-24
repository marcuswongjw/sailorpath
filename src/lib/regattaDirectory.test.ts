import { describe, expect, it } from "vitest";
import { directoryFromCalendar, directoryFromPublished, mergeRegattaDirectory, filterRegattaDirectory, regattaDirectoryTitle, type DirectoryRegatta } from "./regattaDirectory";
import type { RegattaRecord } from "./ranking";

const rows: DirectoryRegatta[] = [
  { id: "a", name: "NSC Cup", slug: "nsc-cup", date: "2026-11-02", endDate: null, venue: "National Sailing Centre", boatClass: "Optimist", region: "Singapore" },
  { id: "b", name: "ILCA Open", slug: "ilca-open", date: "2026-03-01", endDate: "2026-03-02", venue: "Changi", boatClass: "ILCA 4", region: "Singapore" },
];

describe("regatta directory", () => {
  const csc: RegattaRecord[] = [
    { id: "csc4", slug: "6th-csc-ilca-open-ilca4", name: "CSC ILCA Open (ILCA 4)", date: "2026-02-28", boatClass: "ILCA 4", totalFleetSize: 51, eventId: "csc", eventSlug: "6th-csc-ilca-29er-open-2026", eventName: "6th CSC ILCA & 29er Open 2026" },
    { id: "csc6", slug: "6th-csc-ilca-open-ilca6", name: "CSC ILCA Open (ILCA 6)", date: "2026-02-28", boatClass: "ILCA 6", totalFleetSize: 16, eventId: "csc", eventSlug: "6th-csc-ilca-29er-open-2026", eventName: "6th CSC ILCA & 29er Open 2026" },
    { id: "csc29", slug: "6th-csc-29er-open-2026", name: "CSC 29er Open", date: "2026-02-28", boatClass: "29er", totalFleetSize: 3, eventId: "csc", eventSlug: "6th-csc-ilca-29er-open-2026", eventName: "6th CSC ILCA & 29er Open 2026" },
  ];

  it("groups registered event fleets while retaining distinct scorecard destinations", () => {
    const directory = directoryFromPublished(csc);
    expect(directory).toHaveLength(1);
    expect(directory[0].classes).toEqual(expect.arrayContaining(["ILCA 4", "ILCA 6", "29er"]));
    expect(directory[0].fleets?.map((fleet) => fleet.label)).toEqual(["29er", "ILCA 4", "ILCA 6"]);
    expect(new Set(directory[0].fleets?.map((fleet) => fleet.href)).size).toBe(3);
    expect(directory[0].fleets?.find((fleet) => fleet.label === "ILCA 4")?.href).toContain("fleet=ilca-4");
    expect(directory[0].endDate).toBe("2026-03-01");
  });

  it("filters scorecard links within an event without losing its identity", () => {
    const directory = directoryFromPublished(csc);
    const filtered = filterRegattaDirectory(directory, { boatClass: "ILCA 6", results: "published" });
    expect(filtered).toHaveLength(1);
    expect(filtered[0].slug).toBe(directory[0].slug);
    expect(filtered[0].fleets?.map((fleet) => fleet.label)).toEqual(["ILCA 6"]);
    expect(directory[0].fleets).toHaveLength(3);
  });

  it("does not count an unscored calendar placeholder as another class", () => {
    const directory = directoryFromPublished([...csc, { ...csc[0], id: "shell", slug: "csc-shell", boatClass: "ILCA", totalFleetSize: 0, importedEntryCount: 0 }]);
    expect(directory[0].classes).toHaveLength(3);
    expect(directory[0].fleets).toHaveLength(3);
  });

  it("keeps similar events on different weekends separate using saved links", () => {
    const separate = directoryFromPublished(csc.slice(0, 2).map((row, index) => ({ ...row,
      eventId: `weekend-${index}`, eventSlug: `csc-weekend-${index}`, eventName: `CSC Weekend ${index}`,
      date: index ? "2026-03-07" : "2026-02-28",
    })));
    expect(separate.map((event) => event.slug)).toEqual(expect.arrayContaining(["csc-weekend-0", "csc-weekend-1"]));
    expect(separate).toHaveLength(2);
  });

  it("keeps division names visible and searchable inside a grouped event", () => {
    const directory = directoryFromPublished(["Main", "Intermediate"].map((division) => ({
      id: division, name: `Harbour Optimist ${division}`, slug: `harbour-${division.toLowerCase()}`,
      eventId: "harbour", eventSlug: "harbour-2026", eventName: "Harbour Regatta 2026",
      date: "2026-10-01", boatClass: "Optimist", division, totalFleetSize: 20,
    })));
    expect(directory[0].fleets?.map((fleet) => fleet.label)).toEqual(["Optimist · Intermediate", "Optimist · Main"]);
    expect(filterRegattaDirectory(directory, { q: "Intermediate" })).toHaveLength(1);
  });

  it("does not offer an unscored class through the published-results filter", () => {
    const directory = directoryFromPublished([...csc, { ...csc[0], id: "empty", slug: "6th-csc-ilca-open-ilca7", boatClass: "ILCA 7", importedEntryCount: 0 }]);
    expect(filterRegattaDirectory(directory, { boatClass: "ILCA 7", results: "published" })).toEqual([]);
  });
  it("retains published availability when a calendar event shares its slug", () => {
    const published = directoryFromPublished([{ ...rows[0], totalFleetSize: 20 }]);
    const calendar = directoryFromCalendar([{ name: "NSC Cup", slug: "nsc-cup", startDate: "2026-11-02", boatClass: "Optimist", division: "Gold", venue: "National Sailing Centre", region: "Singapore", organizer: "SSF", countsForRanking: false, isSelectionTrial: false, totalFleetSize: 20 }]);
    const merged = mergeRegattaDirectory(published, calendar);
    expect(merged).toHaveLength(1);
    expect(merged[0].hasPublishedResults).toBe(true);
    expect(filterRegattaDirectory(merged, { results: "published" })).toHaveLength(1);
  });

  it("combines published results with class, year, time and search filters", () => {
    const mixed = [{ ...rows[0], hasPublishedResults: true }, { ...rows[1], hasPublishedResults: false }];
    expect(filterRegattaDirectory(mixed, { results: "published", boatClass: "optimist", year: "2026", when: "upcoming", q: "National" }, "2026-10-24")).toEqual([mixed[0]]);
    expect(filterRegattaDirectory(mixed, { results: "published", boatClass: "ILCA 4" })).toEqual([]);
  });
  it("does not advertise an empty published sheet as available results", () => {
    const emptySheet = directoryFromPublished([{ ...rows[0], totalFleetSize: 20, importedEntryCount: 0 }]);
    expect(emptySheet[0].hasPublishedResults).toBe(false);
    expect(filterRegattaDirectory(emptySheet, { results: "published" })).toEqual([]);
  });
  it("filters upcoming optimist events on the server query", () => {
    const visible = filterRegattaDirectory(rows, { boatClass: "optimist", when: "upcoming" }, "2026-10-17");
    expect(visible.map((row) => row.slug)).toEqual(["nsc-cup"]);
  });

  it("builds a page-specific title from the active filter", () => {
    expect(regattaDirectoryTitle({ q: "NSC" })).toBe("Regattas matching “NSC” | SailorPath");
    expect(regattaDirectoryTitle({})).toBe("Regattas | SailorPath");
  });
});
