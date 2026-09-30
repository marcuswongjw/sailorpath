import { describe, expect, it } from "vitest";
import {
  deriveAllSilverEntryDates,
  deriveSilverEntryYmd,
  type ResultRegattaLink,
} from "./deriveFleetEntryDates";
import {
  calculateRankings,
  type Period,
  type RegattaRecord,
  type RegattaResultRecord,
  type SailorRecord,
} from "./ranking";

describe("deriveSilverEntryYmd and deriveAllSilverEntryDates", () => {
  it("derives earliest silver fleet regatta date for each sailor", () => {
    const links: ResultRegattaLink[] = [
      // Yu An's regattas:
      {
        sailorId: "yu-an",
        regattaDate: "2026-03-14",
        division: "Silver",
        countsForRanking: true,
        boatClass: "Optimist",
      },
      {
        sailorId: "yu-an",
        regattaDate: "2026-01-17", // CSC Silver - earliest!
        division: "Silver",
        countsForRanking: true,
        boatClass: "Optimist",
      },
      {
        sailorId: "yu-an",
        regattaDate: "2026-02-07", // SAFYC Silver
        division: "Silver",
        countsForRanking: true,
        boatClass: "Optimist",
      },
      // Allison's regattas:
      {
        sailorId: "allison",
        regattaDate: "2026-07-20", // Cincapura Silver - earliest!
        division: "Silver",
        countsForRanking: true,
        boatClass: "Optimist",
      },
      {
        sailorId: "allison",
        regattaDate: "2026-09-26", // RSYC Knockout
        division: "Silver",
        countsForRanking: true,
        boatClass: "Optimist",
      },
      // Other sailor with Gold and Silver
      {
        sailorId: "other",
        regattaDate: "2025-08-02", // Pesta Sukan Silver
        division: "Silver",
        countsForRanking: true,
        boatClass: "Optimist",
      },
      {
        sailorId: "other",
        regattaDate: "2025-09-06", // SNSC Gold - ignored for silver entry!
        division: "Gold",
        countsForRanking: true,
        boatClass: "Optimist",
      },
    ];

    const map = deriveAllSilverEntryDates(links);
    expect(deriveSilverEntryYmd(links, "yu-an")).toBe("2026-01-17");
    expect(map.get("yu-an")).toBe("2026-01-17");
    expect(map.get("allison")).toBe("2026-07-20");
    expect(map.get("other")).toBe("2025-08-02");
  });

  it("ensures Yu An and Allison appear in rankings after stamping silver entry date", () => {
    const regattas: RegattaRecord[] = [
      {
        id: "csc-silver",
        name: "CSC Silver 2026",
        slug: "csc-silver-jan-26-2026-01-17",
        date: "2026-01-17",
        totalFleetSize: 58,
        division: "Silver",
        boatClass: "Optimist",
        countsForRanking: true,
      },
      {
        id: "safyc-silver",
        name: "SAFYC Silver 2026",
        slug: "safyc-silver-feb-26-2026-02-07",
        date: "2026-02-07",
        totalFleetSize: 55,
        division: "Silver",
        boatClass: "Optimist",
        countsForRanking: true,
      },
      {
        id: "sysc-silver",
        name: "SYSC Silver 2026",
        slug: "sysc-2026-silver",
        date: "2026-03-14",
        totalFleetSize: 68,
        division: "Silver",
        boatClass: "Optimist",
        countsForRanking: true,
      },
      {
        id: "cincapura-silver",
        name: "Cincapura Silver 2026",
        slug: "cincapura-regatta-2026-silver",
        date: "2026-07-20",
        totalFleetSize: 55,
        division: "Silver",
        boatClass: "Optimist",
        countsForRanking: true,
      },
      {
        id: "rsyc-knockout-silver",
        name: "RSYC Knockout Silver 2026",
        slug: "rsyc-optimist-silver-fleet-knockout-championship-2026",
        date: "2026-09-26",
        totalFleetSize: 53,
        division: "Silver",
        boatClass: "Optimist",
        countsForRanking: true,
      },
    ];

    // Canonical merged Yu An with stamped silverEntryDate
    const yuAn: SailorRecord = {
      id: "yu-an",
      name: "Yu An Li",
      handle: "yu-an-li-617cfe",
      sailNumber: "2056",
      club: "Constant Wind",
      gender: "F",
      nationality: "SGP",
      currentFleet: "Series",
      silverEntryDate: "2026-01-17",
      goldEntryDate: null,
      dropDate: null,
    };

    // Allison with stamped silverEntryDate
    const allison: SailorRecord = {
      id: "allison",
      name: "Allison Li Xin Teh",
      handle: "allison-li-xin-teh-8d2a4b",
      sailNumber: "787",
      club: "SAF Yacht Club",
      gender: "F",
      nationality: "SGP",
      currentFleet: "Series",
      silverEntryDate: "2026-07-20",
      goldEntryDate: null,
      dropDate: null,
    };

    const results: RegattaResultRecord[] = [
      { sailorId: "yu-an", regattaId: "csc-silver", rank: 41, isDns: false },
      { sailorId: "yu-an", regattaId: "safyc-silver", rank: 37, isDns: false },
      { sailorId: "yu-an", regattaId: "sysc-silver", rank: 46, isDns: false },
      { sailorId: "yu-an", regattaId: "cincapura-silver", rank: 39, isDns: false },
      { sailorId: "yu-an", regattaId: "rsyc-knockout-silver", rank: 31, isDns: false },
      { sailorId: "allison", regattaId: "cincapura-silver", rank: 32, isDns: false },
      { sailorId: "allison", regattaId: "rsyc-knockout-silver", rank: 31, isDns: false },
    ];

    // 1H 2026 (Jan-Jun 2026): Yu An is in Silver ranking with 3 scores!
    const periodJan26: Period = { year: 2026, half: "Jan-Jun" };
    const rankedJan26 = calculateRankings(periodJan26, [yuAn, allison], regattas, results);
    expect(rankedJan26.some(s => s.id === "yu-an")).toBe(true);
    const yuAnJan26 = rankedJan26.find(s => s.id === "yu-an")!;
    expect(yuAnJan26.fleet).toBe("Silver");
    // Her scores are real scores (37, 41, 46) and Best 3 is 37+41+46 = 124, NOT padded with 9999!
    expect(yuAnJan26.bestThreeScores).toEqual([37, 41, 46]);
    expect(yuAnJan26.overallScore).toBe(124);

    // Allison does not rank in Jan-Jun 2026 (entered in Jul 2026)
    expect(rankedJan26.some(s => s.id === "allison")).toBe(false);

    // 2H 2026 (Jul-Dec 2026): BOTH Yu An and Allison are in Silver ranking!
    const periodJul26: Period = { year: 2026, half: "Jul-Dec" };
    const rankedJul26 = calculateRankings(periodJul26, [yuAn, allison], regattas, results);
    expect(rankedJul26.some(s => s.id === "yu-an")).toBe(true);
    expect(rankedJul26.some(s => s.id === "allison")).toBe(true);
    const allisonJul26 = rankedJul26.find(s => s.id === "allison")!;
    expect(allisonJul26.fleet).toBe("Silver");
  });
});
