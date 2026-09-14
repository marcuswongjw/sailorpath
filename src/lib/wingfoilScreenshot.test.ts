import { describe, expect, it } from "vitest";
import { parseWingfoilOcrText } from "./wingfoilScreenshot";

describe("parseWingfoilOcrText", () => {
  const sampleOcrText = `Results are provisional as of 16:31 on September 7, 2026
Wingfoil Class
Sailed: 9, Discards: 1, To count: 8, Entries: 7, Scoring system: Appendix A

1st ™= Kate En Rui 21 F 16&U CHIJ SECONDARY (TOA Windsurfing Association of (8 4 4 4 8 34 26
sep Bateman PAYOH) Singapore DNF) DNF

2nd ™= Victoria Natasha 18 F 16&U METHODIST GIRLS' SCHOOL PAssion Wave (8 8 DNF 8 35 27
sep Chew DNF) DNF

3rd ™= Mason Qifeng 27 M 16&U TAO NAN SCHOOL Constant Wind SeaSports 3 (8 8 8 35 27
sep Lau DNF) DNF DNF

4th  ™= Ange Chew 3 M 16&U HOME SCHOOL Changi Sailing Club 3 4 (8 4 8 36 28
SGP DNF) DNF

Sth ™= Ryo En Hua 23 M 168U ANGLO-CHINESE SCHOOL Windsurfing Association of 5 5 5 (8 8 39 31
sep Bateman (BARKER ROAD) Singapore DNF) DNF

6th ™= Malo Pichoir 5 M 16&U Tanglin Trust School ONE®15 Marina Club (8 8 8 DNS 8 8 8 8 8DNC 8 72 64
SGP DSQ) DNS DNS DNS DNC DNC DNC

6th ™= Cyrus Jing Yi 2 M 16&U ST. GABRIEL'S SECONDARY SAF Yacht Club (8 8 8 DNF 8 8 8 8 8DNS 8 72 64
sg Chiam SCHOOL DNF) DNF DNF DNF DNS DNF DNF`;

  it("extracts regatta metadata from the header", () => {
    const parsed = parseWingfoilOcrText(sampleOcrText, {
      fileName: "SNSC_2026_Wingfoil_Sprint_Slalom.png",
    });

    expect(parsed.regattaName).toBe("SNSC 2026 Wingfoil Sprint Slalom");
    expect(parsed.startDate).toBe("2026-09-07");
    expect(parsed.sailedCount).toBe(9);
    expect(parsed.discardsCount).toBe(1);
    expect(parsed.scoringSystem).toContain("Appendix A");
  });

  it("extracts all 7 competitors with correct names and sail numbers", () => {
    const parsed = parseWingfoilOcrText(sampleOcrText);

    expect(parsed.results).toHaveLength(7);

    const kate = parsed.results.find((s) => s.sailNumber === "21");
    expect(kate).toBeDefined();
    expect(kate?.name).toBe("Kate En Rui Bateman");
    expect(kate?.gender).toBe("F");
    expect(kate?.ageCategory).toBe("16&U");
    expect(kate?.schoolName).toBe("CHIJ Secondary (Toa Payoh)");
    expect(kate?.club).toBe("Windsurfing Association of Singapore");

    const victoria = parsed.results.find((s) => s.sailNumber === "18");
    expect(victoria).toBeDefined();
    expect(victoria?.name).toBe("Victoria Natasha Chew");
    expect(victoria?.gender).toBe("F");
    expect(victoria?.club).toBe("PAssion Wave");

    const mason = parsed.results.find((s) => s.sailNumber === "27");
    expect(mason).toBeDefined();
    expect(mason?.name).toBe("Mason Qifeng Lau");
    expect(mason?.gender).toBe("M");
    expect(mason?.schoolName).toBe("Tao Nan School");

    const ange = parsed.results.find((s) => s.sailNumber === "3");
    expect(ange).toBeDefined();
    expect(ange?.name).toBe("Ange Chew");

    const ryo = parsed.results.find((s) => s.sailNumber === "23");
    expect(ryo).toBeDefined();
    expect(ryo?.name).toBe("Ryo En Hua Bateman");
    expect(ryo?.gender).toBe("M");

    const malo = parsed.results.find((s) => s.sailNumber === "5");
    expect(malo).toBeDefined();
    expect(malo?.name).toBe("Malo Pichoir");
    expect(malo?.club).toBe("ONE°15 Marina Club");

    const cyrus = parsed.results.find((s) => s.sailNumber === "2");
    expect(cyrus).toBeDefined();
    expect(cyrus?.name).toBe("Cyrus Jing Yi Chiam");
    expect(cyrus?.club).toBe("SAF Yacht Club");
  });

  it("extracts heat races and recalculates discards correctly", () => {
    const parsed = parseWingfoilOcrText(sampleOcrText);

    for (const sailor of parsed.results) {
      expect(sailor.races).toHaveLength(9);
      // Verify exactly 1 race is discarded after 4+ races
      const discarded = sailor.races.filter((r) => r.isDiscarded);
      expect(discarded).toHaveLength(1);
      // Nett score must equal sum of non-discarded races
      const expectedNett = sailor.races
        .filter((r) => !r.isDiscarded)
        .reduce((sum, r) => sum + r.score, 0);
      expect(sailor.nettScore).toBe(expectedNett);
    }
  });

  it("handles fallback when only a minimal filename is provided", () => {
    const minimalOcr = `1st Kate Bateman 21 F 16&U CHIJ Secondary Windsurfing 1 1 1 3 3`;
    const parsed = parseWingfoilOcrText(minimalOcr, {
      fileName: "SW_Monsoon_GP_2026-08-15.png",
    });

    expect(parsed.regattaName).toBe("SW Monsoon GP");
    expect(parsed.startDate).toBe("2026-08-15");
    expect(parsed.results).toHaveLength(1);
    expect(parsed.results[0].name).toBe("Kate Bateman");
    expect(parsed.results[0].sailNumber).toBe("21");
  });

  it("handles redress (RDG) and penalty codes (DSQ, DNS, DNF)", () => {
    const penaltyOcr = `Results provisional as of October 12, 2026
Wingfoil Class
Sailed: 5, Discards: 1, To count: 4, Entries: 2
1st Ryo Bateman 23 M 16&U ACS Barker Windsurfing 2 RDG 1 3 5 (8 DNF) 19 11
2nd Malo Pichoir 5 M 16&U Tanglin ONE 15 (8 DSQ) 8 DNS 8 DNC 2 2 28 20`;

    const parsed = parseWingfoilOcrText(penaltyOcr);
    expect(parsed.results).toHaveLength(2);

    const ryo = parsed.results.find((s) => s.sailNumber === "23");
    expect(ryo).toBeDefined();
    expect(ryo?.races[0].code).toBe("RDG");
    expect(ryo?.races[0].score).toBe(2);
    expect(ryo?.races.some((r) => r.code === "DNF")).toBe(true);

    const malo = parsed.results.find((s) => s.sailNumber === "5");
    expect(malo).toBeDefined();
    expect(malo?.races.some((r) => r.code === "DSQ")).toBe(true);
    expect(malo?.races.some((r) => r.code === "DNS")).toBe(true);
  });

  it("extracts Grand Prix Format B scorecards (20 races, 2 discards, division)", () => {
    const formatBOcr = `Results are provisional as of 17:00 on January 10, 2026
WingFoil Fleet
Sailed: 20, Discards: 2, To count: 18, Entries: 3, Scoring system: Appendix A
Rank Name SailNo Division R1 R2 R3 R4 R5 R6 R7 R8 R9 R10 R11 R12 R13 R14 R15 R16 R17 R18 R19 R20 Total Nett
1st Jun Hao Lo 43 Open 1.0 1.0 1.0 (3.0) 1.0 1.0 1.0 1.0 1.0 1.0 1.0 (3.0) 1.0 1.0 1.0 1.0 1.0 1.0 1.0 1.0 24.0 18.0
2nd Wearn Haw Tan 29 Masters 2.0 2.0 2.0 1.0 2.0 2.0 2.0 (3.0) 2.0 2.0 2.0 1.0 (3.0) 2.0 2.0 2.0 2.0 2.0 2.0 2.0 41.0 35.0
3rd Ker Wan Chew 18 Grand Master (4.0) 3.0 3.0 3.0 3.0 3.0 3.0 2.0 3.0 (4.0) 3.0 3.0 2.0 3.0 3.0 3.0 3.0 3.0 3.0 3.0 64.0 56.0`;

    const parsed = parseWingfoilOcrText(formatBOcr, {
      fileName: "20260110 NE Monsoon Series GP1.png",
    });

    expect(parsed.regattaName).toBe("NE Monsoon Series GP1");
    expect(parsed.startDate).toBe("2026-01-10");
    expect(parsed.sailedCount).toBe(20);
    expect(parsed.discardsCount).toBe(2);
    expect(parsed.results).toHaveLength(3);

    const lo = parsed.results[0];
    expect(lo.name).toBe("Jun Hao Lo");
    expect(lo.sailNumber).toBe("43");
    expect(lo.races).toHaveLength(20);
    expect(lo.grossScore).toBe(24);
    expect(lo.nettScore).toBe(18);

    // Exactly 2 races discarded
    const loDiscards = lo.races.filter((r) => r.isDiscarded);
    expect(loDiscards).toHaveLength(2);

    const tan = parsed.results[1];
    expect(tan.name).toBe("Wearn Haw Tan");
    expect(tan.sailNumber).toBe("29");
    expect(tan.ageCategory).toBe("Masters");
    expect(tan.races).toHaveLength(20);
    expect(tan.nettScore).toBe(34);

    const chew = parsed.results[2];
    expect(chew.name).toBe("Ker Wan Chew");
    expect(chew.sailNumber).toBe("18");
    expect(chew.ageCategory).toBe("Grand Masters");
    expect(chew.races).toHaveLength(20);
    expect(chew.grossScore).toBe(60);
    expect(chew.nettScore).toBe(52);
  });
});
