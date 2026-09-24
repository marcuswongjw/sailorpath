import { describe, expect, it } from "vitest";
import type { RegattaRecord } from "@/lib/ranking";
import {
  classResultsHref,
  matchCalendarResults,
} from "./calendarResultLinks";

function row(
  partial: Pick<RegattaRecord, "slug" | "name"> &
    Partial<Pick<RegattaRecord, "boatClass" | "division" | "raceCount" | "totalFleetSize" | "date">>
): RegattaRecord {
  return {
    id: partial.slug,
    date: partial.date || "2026-01-01",
    totalFleetSize: partial.totalFleetSize ?? 40,
    boatClass: partial.boatClass ?? "Optimist",
    division: partial.division,
    raceCount: partial.raceCount,
    ...partial,
  };
}

const published: RegattaRecord[] = [
  row({ slug: "202606-temasek-gold-2026-06-20", name: "Temasek Gold (Jun 26)", division: "Gold", totalFleetSize: 72 }),
  row({ slug: "temasek-silver-jun-26-2026-06-20", name: "Temasek Silver (Jun 26)", division: "Silver", totalFleetSize: 61 }),
  row({ slug: "temasek-ilca-jun-26-2026-06-20", name: "Temasek ILCA (Jun 26)", boatClass: "ILCA 4", totalFleetSize: 42 }),
  row({ slug: "temasek-ilca6-jun-26-2026-06-20", name: "Temasek ILCA 6", boatClass: "ILCA 6" }),
  row({ slug: "safyc-gold-jul-26-2026-07-04", name: "SAFYC Gold (Jul 26)", division: "Gold", totalFleetSize: 91 }),
  row({ slug: "safyc-silver-jul-26-2026-07-04", name: "SAFYC Silver (Jul 26)", division: "Silver", totalFleetSize: 57 }),
  row({ slug: "safyc-gold-mar-26-2026-03-28", name: "SAFYC Gold (Mar 26)", division: "Gold", totalFleetSize: 83 }),
  row({ slug: "safyc-silver-mar-26-2026-03-28", name: "SAFYC Silver (Mar 26)", division: "Silver", totalFleetSize: 66 }),
  row({ slug: "safyc-ilca4-feb-26-2026-02-14", name: "SAFYC ILCA4 (Feb 26)", boatClass: "ILCA 4" }),
  row({ slug: "cincapura-regatta-2026-gold", name: "Cincapura Regatta 2026 (Gold)", division: "Gold", raceCount: 3, totalFleetSize: 86 }),
  row({ slug: "cincapura-gold-jul-26-2026-07-18", name: "Cincapura Gold (Jul 26)", division: "Gold", raceCount: 0, totalFleetSize: 82 }),
  row({ slug: "cincapura-regatta-2026-silver", name: "Cincapura Regatta 2026 (Silver)", division: "Silver", raceCount: 4, totalFleetSize: 55 }),
  row({ slug: "cincapura-silver-jul-26-2026-07-18", name: "Cincapura Silver (Jul 26)", division: "Silver", raceCount: 1, totalFleetSize: 55 }),
  row({ slug: "cincapura-ilca4-jul-26-2026-07-18", name: "Cincapura ILCA4 (Jul 26)", boatClass: "ILCA 4" }),
  row({ slug: "pesta-sukan-gold-aug-26-2026-08-01", name: "Pesta Sukan (Gold) (Aug 26)", division: "Gold" }),
  row({ slug: "pesta-sukan-silver-aug-26-2026-08-01", name: "Pesta Sukan Silver (Aug 26)", division: "Silver" }),
  row({ slug: "pesta-sukan-ilca4-aug-26-2026-08-01", name: "Pesta Sukan ILCA4 (Aug 26)", boatClass: "ILCA 4" }),
  row({ slug: "pesta-sukan-gold-aug-25-2025-08-02", name: "Pesta Sukan Gold (Aug 25)", division: "Gold", date: "2025-08-02" }),
  row({ slug: "pulau-ujong-gold-feb-26-2026-02-21", name: "Pulau Ujong Gold (Feb 26)", division: "Gold" }),
  row({ slug: "pulau-ujong-silver-feb-26-2026-02-21", name: "Pulau Ujong Silver (Feb 26)", division: "Silver" }),
  row({ slug: "pulau-ujong-ilca-feb-26-2026-02-21", name: "Pulau Ujong ILCA (Feb 26)", boatClass: "ILCA 4" }),
  row({ slug: "selection-trials-aug-26-2026-08-22", name: "Selection Trials (Aug 26)", division: "Gold" }),
  row({ slug: "sysc-gold-mar-26-2026-03-14", name: "SYSC Gold (Mar 26)", division: "Gold" }),
  row({ slug: "csc-gold-jan-26-2026-01-24", name: "CSC Gold (Jan 26)", division: "Gold" }),
  row({ slug: "snsc-gold-sep-26-2026-09-11", name: "SNSC Gold (Sep 26)", division: "Gold" }),
];

describe("matchCalendarResults", () => {
  it("opens Temasek on the 2026 Optimist fleets and ILCA 4, not ILCA 6", () => {
    expect(matchCalendarResults("temasek-regatta-2026", published).map((r) => r.slug)).toEqual([
      "202606-temasek-gold-2026-06-20",
      "temasek-silver-jun-26-2026-06-20",
      "temasek-ilca-jun-26-2026-06-20",
    ]);
  });

  it("keeps the two 2026 SAFYC events apart", () => {
    expect(matchCalendarResults("2nd-safyc-optimist-championships-2026", published).map((r) => r.slug)).toEqual([
      "safyc-gold-jul-26-2026-07-04",
      "safyc-silver-jul-26-2026-07-04",
    ]);
    expect(matchCalendarResults("22nd-safyc-regatta-2026", published).map((r) => r.slug)).toEqual([
      "safyc-gold-mar-26-2026-03-28",
      "safyc-silver-mar-26-2026-03-28",
      "safyc-ilca4-feb-26-2026-02-14",
    ]);
  });

  it("keeps the fuller Cincapura sheet when the same fleet was imported twice", () => {
    expect(matchCalendarResults("cincapura-regatta-2026", published).map((r) => r.slug)).toEqual([
      "cincapura-regatta-2026-gold",
      "cincapura-regatta-2026-silver",
      "cincapura-ilca4-jul-26-2026-07-18",
    ]);
  });

  it("sends each Pesta card to its own classes and ignores 2025", () => {
    expect(matchCalendarResults("pesta-sukan-regatta-2026-optimist", published).map((r) => r.slug)).toEqual([
      "pesta-sukan-gold-aug-26-2026-08-01",
      "pesta-sukan-silver-aug-26-2026-08-01",
    ]);
    expect(matchCalendarResults("pesta-sukan-regatta-2026-ilca-wingfoil", published).map((r) => r.slug)).toEqual([
      "pesta-sukan-ilca4-aug-26-2026-08-01",
    ]);
  });

  it("does not treat a different regatta in the same year as a match", () => {
    expect(matchCalendarResults("singapore-youth-sailing-championships-2026", published)).toEqual([]);
    expect(matchCalendarResults("csc-youth-championship-2026", published)).toEqual([]);
    expect(matchCalendarResults("eastern-seaboard-regatta-2026", published)).toEqual([]);
  });

  it("links ILCA rows to the unified ILCA results page and Optimist rows to Optimist", () => {
    const ilca = published.find((r) => r.slug === "pesta-sukan-ilca4-aug-26-2026-08-01")!;
    const gold = published.find((r) => r.slug === "pesta-sukan-gold-aug-26-2026-08-01")!;
    expect(classResultsHref(ilca)).toBe("/sg/ilca/regattas/pesta-sukan-ilca4-aug-26-2026-08-01");
    expect(classResultsHref(gold)).toBe("/sg/optimist/regattas/pesta-sukan-gold-aug-26-2026-08-01");
  });
});
