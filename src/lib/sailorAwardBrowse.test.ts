import { describe, expect, it } from "vitest";
import type { SailorPrizeAward } from "./sailorPrizes";
import { mergeSailorPrizes } from "./sailorPrizes";
import { EMPTY_AWARD_FILTERS, awardDate, awardDateLabel, awardScheduleEndDate, browseSailorAwards, sortSailorAwards } from "./sailorAwardBrowse";

const award = (values: Partial<SailorPrizeAward>): SailorPrizeAward => ({
  id: "old", regattaName: "January Cup", regattaSlug: "january", year: 2026,
  regattaDate: "2026-01-01", boatClass: "Optimist", fleetName: "Gold",
  categoryName: "Overall", rank: 1, medal: "gold", prizeTitle: "1st", isOfficialNoR: false,
  venue: "Singapore", ...values,
});
const old = award({});
const recent = award({ id: "new", regattaName: "Eastern Seaboard", regattaSlug: "eastern", regattaDate: "2026-10-28", regattaEndDate: "2026-11-01", venue: "Pattaya", medal: "bronze", rank: 3, prizeTitle: "3rd", categoryName: "Under 12 Female" });

describe("award browsing", () => {
  it("puts a recent bronze before an older gold, including when merging sources", () => {
    const input = [old, recent];
    expect(sortSailorAwards(input).map((a) => a.id)).toEqual(["new", "old"]);
    expect(mergeSailorPrizes([old], [recent]).map((a) => a.id)).toEqual(["new", "old"]);
    expect(input).toEqual([old, recent]);
    expect(sortSailorAwards(input, "oldest").map((a) => a.id)).toEqual(["old", "new"]);
    expect(sortSailorAwards(input, "placing").map((a) => a.id)).toEqual(["old", "new"]);
  });
  it("uses the event's final date and handles legacy ranges without publication dates", () => {
    expect(awardDate(recent)).toBe("2026-11-01");
    expect(awardDateLabel(recent)).toBe("28 Oct 2026 – 1 Nov 2026");
    expect(awardScheduleEndDate("25–26 July 2026 & 1–2 August 2026", 2026)).toBe("2026-08-02");
    expect(awardScheduleEndDate("18–20 July 2026 (Results finalized 21 July 2026)", 2026)).toBe("2026-07-20");
    expect(awardScheduleEndDate("28 February & 1 March 2026", 2026)).toBe("2026-03-01");
    expect(awardScheduleEndDate("2026", 2026)).toBeNull();
    expect(awardDate(award({ regattaDate: "2026-02-30" }))).toBeNull();
  });
  it("combines search, year, location, class, medal and inclusive date filters", () => {
    const filters = { ...EMPTY_AWARD_FILTERS, query: "eastern female", year: "2026", location: "Pattaya", boatClass: "Optimist", medal: "bronze", from: "2026-11-01", to: "2026-11-01" };
    expect(browseSailorAwards([old, recent], filters, "newest")).toEqual([recent]);
    expect(browseSailorAwards([old, recent], { ...filters, location: "Singapore" }, "newest")).toEqual([]);
    expect(browseSailorAwards([old, recent], { ...filters, to: "2026-10-31" }, "newest")).toEqual([]);
  });
  it("keeps year-only awards available by year but excludes them from a specific date range", () => {
    const unknown = award({ id: "unknown", regattaDate: undefined, year: 2025 });
    expect(browseSailorAwards([unknown], { ...EMPTY_AWARD_FILTERS, year: "2025" }, "newest")).toEqual([unknown]);
    expect(browseSailorAwards([unknown], { ...EMPTY_AWARD_FILTERS, from: "2025-01-01" }, "newest")).toEqual([]);
    expect(awardDateLabel(unknown)).toBe("2025");
  });
});
