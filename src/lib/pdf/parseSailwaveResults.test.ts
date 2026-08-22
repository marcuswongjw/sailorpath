import { describe, expect, it } from "vitest";
import { parseSailwaveResults, type PdfTextItem } from "./parseSailwaveResults";

function line(y: number, cells: Array<[number, string]>): PdfTextItem[] {
  return cells.map(([x, str]) => ({ x, y, str }));
}

describe("parseSailwaveResults", () => {
  it("extracts race scores and scoring codes from repeated PDF table headers", () => {
    const header: Array<[number, string]> = [
      [10, "Rank"], [60, "Sail Num"], [150, "Name"],
      [300, "R1"], [350, "R2"], [400, "Total"], [455, "Nett"],
    ];
    const result = parseSailwaveResults([
      {
        pageNumber: 1,
        text: "Sailed: 2, Discards: 0, Entries: 2",
        items: [
          ...line(700, header),
          ...line(680, [[10, "1st"], [60, "SGP 140"], [150, "Elijah Ong"], [300, "2.0"], [350, "1.0"], [400, "3.0"], [455, "3.0"]]),
        ],
      },
      {
        pageNumber: 2,
        text: "",
        items: [
          ...line(700, header),
          ...line(680, [[10, "2nd"], [60, "SGP3128"], [150, "Aaron Chiang"], [300, "3.0"], [350, "52.0 DSQ"], [400, "55.0"], [455, "55.0"]]),
        ],
      },
    ]);

    expect(result).toMatchObject({ raceCount: 2, entries: 2, discards: 0 });
    expect(result.rows).toHaveLength(2);
    expect(result.rows[0]).toMatchObject({ name: "Elijah Ong", sailNumber: "SGP 140", rank: 1 });
    expect(result.rows[1].races[1]).toMatchObject({
      raceNumber: 2,
      score: 52,
      scoringCode: "DSQ",
      rawValue: "52.0 DSQ",
    });
  });
});
