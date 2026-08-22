import { describe, expect, it } from "vitest";
import { parseRegattaResultRows } from "./parseRegattaResultsSheet";

describe("parseRegattaResultRows official races", () => {
  it("preserves R columns from a converted workbook", () => {
    const [row] = parseRegattaResultRows([
      { Rank: "4", "Sail Num": "SGP 99", Name: "Sailor A", R1: "5.0", R2: "52.0 BFD", Total: "57", Nett: "57" },
    ]);
    expect(row.races).toEqual([
      { raceNumber: 1, score: 5, scoringCode: null, discarded: false, rawValue: "5.0" },
      { raceNumber: 2, score: 52, scoringCode: "BFD", discarded: false, rawValue: "52.0 BFD" },
    ]);
  });
});
