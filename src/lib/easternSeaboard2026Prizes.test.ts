import fs from "node:fs";
import { describe, expect, it } from "vitest";
import { EASTERN_SEABOARD_2026_PRIZES as schedule } from "./easternSeaboard2026Prizes";
import { getPrizeDefinitionsForSheet, getPrizeFleetDefinitions, getRegattaPrizeSchedule } from "./regattaPrizes";
import { getSailorPrizes } from "./sailorPrizes";
import { fillUnlistedPrizeWinners } from "./prizeWinnersFromResults";

type SourceRow = {
  rank: number; name: string; sailorId: string; gender: string; birthYear: number | null;
};
const sheets = Object.fromEntries(["optimist-gold", "optimist-silver", "ilca4", "ilca6"].map((key) => [
  key, JSON.parse(fs.readFileSync(new URL(`../../scripts/imports/eastern-seaboard-2026/${key}.json`, import.meta.url), "utf8")).results as SourceRow[],
]));
const optimist = [...sheets["optimist-gold"], ...sheets["optimist-silver"]];
const categories = (boatClass: string) => schedule.fleets.find((fleet) => fleet.boatClass === boatClass)!.categories;

describe("Eastern Seaboard NoR 13.1 prizes", () => {
  it("awards the ten published categories using explicit birth-year and sex eligibility", () => {
    const expected = [
      ...[
        ["Overall", optimist.slice(0, 10)],
        ["Female", optimist.filter((row) => row.gender === "F").slice(0, 3)],
        ["U12 Male (born 2015 or later)", optimist.filter((row) => row.gender === "M" && (row.birthYear || 0) >= 2015).slice(0, 3)],
        ["U12 Female (born 2015 or later)", optimist.filter((row) => row.gender === "F" && (row.birthYear || 0) >= 2015).slice(0, 3)],
        ["U10 (born 2017 or later)", optimist.filter((row) => (row.birthYear || 0) >= 2017).slice(0, 3)],
      ].map(([name, rows]) => ["Optimist", name, rows] as const),
      ["ILCA 4", "Male", sheets.ilca4.filter((row) => row.gender === "M").slice(0, 3)],
      ["ILCA 4", "Female", sheets.ilca4.filter((row) => row.gender === "F").slice(0, 3)],
      ["ILCA 4", "U15 (born 2011 or later)", sheets.ilca4.filter((row) => (row.birthYear || 0) >= 2011).slice(0, 3)],
      ["ILCA 6", "Male", sheets.ilca6.filter((row) => row.gender === "M").slice(0, 3)],
      ["ILCA 6", "Female", sheets.ilca6.filter((row) => row.gender === "F").slice(0, 3)],
    ] as [string, string, SourceRow[]][];
    for (const [boatClass, categoryName, rows] of expected) {
      const category = categories(boatClass).find((item) => item.categoryName === categoryName)!;
      expect(category.winners.map((winner) => winner.sailorName)).toHaveLength(rows.length);
      category.winners.forEach((winner, index) => {
        expect(winner.notes).toContain(`Official source name: ${rows[index].name}.`);
      });
    }
    const all = schedule.fleets.flatMap((fleet) => fleet.categories.flatMap((category) => category.winners));
    expect(schedule.fleets.flatMap((fleet) => fleet.categories)).toHaveLength(10);
    expect(all).toHaveLength(37);
    expect(new Set(all.map((winner) => winner.sailorHandle)).size).toBe(30);
  });

  it("uses Gold then Silver instead of sorting the two fleets by net points", () => {
    const u10 = categories("Optimist").find((category) => category.categoryName.startsWith("U10"))!;
    expect(u10.winners.map((winner) => winner.sailorHandle)).toEqual([
      "matthias-kai-lun-lee", "min-myat-ponnya-mya396", "skyler-kang",
    ]);
    expect(categories("Optimist").find((category) => category.categoryName.startsWith("U12 Female"))!.winners[2]).toMatchObject({
      sailorHandle: "mikaelawong", rank: 3,
    });
  });

  it("selects class-wide Optimist prizes from either sheet without leaking ILCA awards", () => {
    for (const division of ["Gold", "Silver"]) {
      const slug = `eastern-seaboard-regatta-2026-optimist-${division.toLowerCase()}`;
      expect(getPrizeDefinitionsForSheet({ slug, boatClass: "Optimist", division })?.fleets.map((fleet) => fleet.fleetName)).toEqual(["Optimist"]);
      expect(getPrizeFleetDefinitions(slug)?.fleets.map((fleet) => fleet.fleetName)).toEqual(["Optimist"]);
      expect(getRegattaPrizeSchedule(slug)).toBe(schedule);
    }
    for (const rig of ["4", "6"]) {
      expect(getPrizeDefinitionsForSheet({ slug: `eastern-seaboard-regatta-2026-ilca${rig}`, boatClass: `ILCA ${rig}`, division: "Open" })?.fleets.map((fleet) => fleet.boatClass)).toEqual([`ILCA ${rig}`]);
    }
    expect(getRegattaPrizeSchedule("eastern-seaboard-regatta-2025-optimist")).toBeNull();
    expect(getRegattaPrizeSchedule("eastern-seaboard-regatta-2026-ilca7")).toBeNull();
    expect(fillUnlistedPrizeWinners(schedule.fleets, [], 2026)).toEqual(schedule.fleets);
  });

  it("links category winners to profiles without creating unlisted Silver or overall ILCA prizes", () => {
    const mikaela = getSailorPrizes({ name: "Mikaela Hui Ting Wong", handle: "mikaelawong" }, [], [schedule]);
    expect(mikaela).toMatchObject([{ rank: 3, categoryName: "U12 Female (born 2015 or later)", medal: "bronze" }]);
    const gabi = getSailorPrizes({ name: "Gabi Oh", handle: "gabi-oh-fv3x3cs" }, [
      { regattaSlug: "eastern-seaboard-regatta-2026-ilca6", boatClass: "ILCA 6", rank: 2 },
    ], [schedule]);
    expect(gabi).toHaveLength(1);
    expect(gabi[0].categoryName).toBe("Female");
    const silverChampion = getSailorPrizes({ name: "Aung Kaung Myat" }, [
      { regattaSlug: "eastern-seaboard-regatta-2026-optimist-silver", boatClass: "Optimist", division: "Silver", rank: 1 },
    ], [schedule]);
    expect(silverChampion).toEqual([]);
    expect(getSailorPrizes({ name: "Mikaela Hui Ting Wong", handle: "another-mikaela" }, [], [schedule])).toEqual([]);
  });

  it("does not use either disputed birth year to assign an age prize", () => {
    // Both source/profile alternatives are outside any affected winning cut-off.
    for (const [name, years] of [["SORAWIT NAKSUK", [2012, 2014]], ["SETTHAWIT YODMANEE", [2017, 2019]]] as const) {
      for (const year of years) {
        const rows = optimist.map((row) => row.name === name ? { ...row, birthYear: year } : row);
        for (const cutoff of [2015, 2017]) {
          for (const gender of ["M", "F", null]) {
            const leaders = rows.filter((row) => (row.birthYear || 0) >= cutoff && (!gender || row.gender === gender)).slice(0, 3);
            expect(leaders.some((row) => row.name === name)).toBe(false);
          }
        }
      }
    }
  });
});
