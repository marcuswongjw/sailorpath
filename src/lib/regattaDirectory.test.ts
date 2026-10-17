import { describe, expect, it } from "vitest";
import { filterRegattaDirectory, regattaDirectoryTitle, type DirectoryRegatta } from "./regattaDirectory";

const rows: DirectoryRegatta[] = [
  { id: "a", name: "NSC Cup", slug: "nsc-cup", date: "2026-11-02", endDate: null, venue: "National Sailing Centre", boatClass: "Optimist", region: "Singapore" },
  { id: "b", name: "ILCA Open", slug: "ilca-open", date: "2026-03-01", endDate: "2026-03-02", venue: "Changi", boatClass: "ILCA 4", region: "Singapore" },
];

describe("regatta directory", () => {
  it("filters upcoming optimist events on the server query", () => {
    const visible = filterRegattaDirectory(rows, { boatClass: "optimist", when: "upcoming" }, "2026-10-17");
    expect(visible.map((row) => row.slug)).toEqual(["nsc-cup"]);
  });

  it("builds a page-specific title from the active filter", () => {
    expect(regattaDirectoryTitle({ q: "NSC" })).toBe("Regattas matching “NSC” | SailorPath");
    expect(regattaDirectoryTitle({})).toBe("Regattas | SailorPath");
  });
});
