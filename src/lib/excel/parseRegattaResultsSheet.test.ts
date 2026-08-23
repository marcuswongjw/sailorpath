import { describe, expect, it } from "vitest";
import {
  inferLikelyDnsRows,
  parseRegattaResultRows,
} from "./parseRegattaResultsSheet";

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

  it("reads an explicit DNS status and suggests repeated bottom ranks", () => {
    const rows = inferLikelyDnsRows(
      parseRegattaResultRows([
        { Rank: "1", Name: "Finisher", Status: "Finished" },
        { Rank: "50", Name: "Bottom A", Status: "DNS" },
        { Rank: "50", Name: "Bottom B" },
      ])
    );

    expect(rows.map((row) => row.isDns)).toEqual([false, true, true]);
  });

  it("suggests DNS when every published race is DNS or DNC", () => {
    const rows = inferLikelyDnsRows(
      parseRegattaResultRows([
        {
          Rank: "12",
          Name: "Non-starter",
          R1: "20 DNS",
          R2: "20 DNC",
        },
      ])
    );

    expect(rows[0].isDns).toBe(true);
  });
});
