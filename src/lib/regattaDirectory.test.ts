import { describe, expect, it } from "vitest";
import { directoryFromCalendar, directoryFromPublished, mergeRegattaDirectory, filterRegattaDirectory, regattaDirectoryTitle, type DirectoryRegatta } from "./regattaDirectory";

const rows: DirectoryRegatta[] = [
  { id: "a", name: "NSC Cup", slug: "nsc-cup", date: "2026-11-02", endDate: null, venue: "National Sailing Centre", boatClass: "Optimist", region: "Singapore" },
  { id: "b", name: "ILCA Open", slug: "ilca-open", date: "2026-03-01", endDate: "2026-03-02", venue: "Changi", boatClass: "ILCA 4", region: "Singapore" },
];

describe("regatta directory", () => {
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
