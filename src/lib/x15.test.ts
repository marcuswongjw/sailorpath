import { describe, expect, it } from "vitest";
import { X15_EQUIPMENT_OVERVIEW, X15_NATIONAL_ASSOCIATIONS, publishedX15Sheets, x15WorldsStatus } from "./x15";
import { X15_CALENDAR_ENTRIES, X15_LISTINGS, X15_PENDING_EVENTS } from "./x15Calendar";
import { resolveSailingClass, supportsNationalRanking, requiresExplicitImportMetadata } from "./classRegistry";
import type { RegattaRecord } from "./ranking";

describe("X-15 results preparation", () => {
  it.each([["2026-11-03", "Upcoming"], ["2026-11-04", "Racing window"], ["2026-11-08", "Racing window"], ["2026-11-09", "Awaiting reviewed results"]])("uses event boundaries on %s", (date, status) => expect(x15WorldsStatus(date)).toBe(status));
  it("only announces results when reviewed sheets exist", () => expect(x15WorldsStatus("2026-11-09", true)).toBe("Results available"));
  it("keeps X-15 distinct from other foil classes", () => {
    for (const label of ["X-15", "X15", "X-15 Class", "X15 Wingfoil"]) expect(resolveSailingClass(label)?.key).toBe("x15");
    expect(resolveSailingClass("X150")).toBeNull();
    expect(resolveSailingClass("WingFoil")?.key).toBe("wingfoil");
    expect(resolveSailingClass("iQFOiL")?.key).toBe("iqfoil");
    expect(supportsNationalRanking("X-15")).toBe(false);
    expect(requiresExplicitImportMetadata("X-15")).toBe(true);
  });
  it("excludes drafts, empty imports and other classes while sorting newest first", () => {
    const row = (slug: string, extra = {}): RegattaRecord => ({ id: slug, slug, name: slug, date: "2026-11-08", boatClass: "X-15", totalFleetSize: 10, ...extra });
    const rows = [row("old", { date: "2025-01-01" }), row("new"), row("draft", { status: "draft" }), row("empty", { importedEntryCount: 0 }), row("wing", { boatClass: "WingFoil" })];
    expect(publishedX15Sheets(rows).map(r => r.slug)).toEqual(["new", "old"]);
  });
  it("splits X-15 official calendar listings cleanly into dated calendar entries and undated pending events", () => {
    expect(X15_LISTINGS.length).toBeGreaterThanOrEqual(29);
    expect(X15_CALENDAR_ENTRIES.length + X15_PENDING_EVENTS.length).toBe(X15_LISTINGS.length);
    expect(X15_CALENDAR_ENTRIES.some((e) => e.slug === "x15-asian-cup-2026")).toBe(true);
    expect(X15_CALENDAR_ENTRIES.some((e) => e.slug === "singapore-open-windsurfing-foiling-2027")).toBe(true);
    expect(X15_CALENDAR_ENTRIES.some((e) => e.slug === "x15-youth-world-championships-2027")).toBe(true);
    expect(X15_PENDING_EVENTS.some((e) => e.slug === "x15-world-championships-2027")).toBe(true);
    expect(X15_EQUIPMENT_OVERVIEW.divisions).toHaveLength(6);
    expect(X15_NATIONAL_ASSOCIATIONS.some((a) => a.country === "Singapore")).toBe(true);
  });
});

describe("reviewed X-15 Worlds 2026 scorecards", () => {
  it("keeps all five independently scored divisions in the saved parent hub", async () => {
    const { savedEventHubForSlug } = await import("./regattaEventGroups");
    const manifests = await Promise.all(["SeniorMen", "SeniorWomen", "U19Men", "U19Women", "U15"].map(async (file) => {
      const { readFile } = await import("node:fs/promises");
      return JSON.parse(await readFile(new URL(`../../scripts/imports/x15-worlds-2026/${file}.json`, import.meta.url), "utf8"));
    }));
    const rows: RegattaRecord[] = manifests.map(({ event, sheet }) => ({
      id: sheet.slug, slug: sheet.slug, name: sheet.name, boatClass: sheet.boatClass,
      division: sheet.division, totalFleetSize: sheet.totalFleetSize, raceCount: sheet.raceCount,
      date: event.startDate, endDate: event.endDate, eventSlug: event.slug,
      eventName: event.name, venue: event.venue, countsForRanking: false,
    }));
    const hub = savedEventHubForSlug("x15-world-championships-2026", rows);
    expect(hub?.event.slices.map((slice) => slice.key)).toEqual([
      "x15-senior-men", "x15-senior-women", "x15-u15-and-u13", "x15-u19-and-u17-men", "x15-u19-and-u17-women",
    ]);
    for (const row of rows) {
      expect(savedEventHubForSlug(row.slug, rows)?.fleetKey).toBe(`x15-${row.division!.toLowerCase().replaceAll(" ", "-")}`);
    }
    expect(publishedX15Sheets(rows)).toHaveLength(5);
    expect(rows.reduce((sum, row) => sum + row.totalFleetSize, 0)).toBe(107);
  });
});

describe("X-15 Worlds source scoring", () => {
  it("retains half points, a discarded black flag, and official tied ranks", async () => {
    const { readFile } = await import("node:fs/promises");
    const load = async (file: string) => JSON.parse(await readFile(new URL(`../../scripts/imports/x15-worlds-2026/${file}.json`, import.meta.url), "utf8"));
    const senior = await load("SeniorMen");
    expect(senior.results[0]).toMatchObject({ name: "Kamil Manowiecki", nationality: "POL", grossScore: 1, nettScore: 1 });
    expect(senior.results[0].races.map((race: { score: number }) => race.score)).toEqual([0.5, 0.5]);
    expect(senior.results[14].races[0]).toMatchObject({ score: 19.5, code: "BFD", discarded: false });
    expect(senior.results.slice(-3).map((row: { rank: number }) => row.rank)).toEqual([36, 36, 36]);
    const youthWomen = await load("U19Women");
    expect(youthWomen.results[0]).toMatchObject({ name: "Yana Li", nationality: "CHN", grossScore: 13, nettScore: 2 });
    expect(youthWomen.results[0].races[0]).toMatchObject({ score: 11, code: "BFD", discarded: true });
    expect(youthWomen.results[0].birthYear).toBeUndefined();
    const youthMen = await load("U19Men");
    expect(youthMen.results.slice(2, 4).map((row: { name: string; rank: number }) => [row.name, row.rank])).toEqual([["Leo Zabell", 3], ["Antoni Lutomski", 4]]);
    expect(youthMen.officialSource.discrepancy).toContain("award attribution awaits organiser clarification");
  });
});
