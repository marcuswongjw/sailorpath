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

  it("deduplicates overpainted headers and merges wrapped Sailwave cells", () => {
    const header: Array<[number, string]> = [
      [10, "Rank"], [60, "Name"], [150, "Sail"], [200, "Age"],
      [250, "Gender"], [300, "Sch"], [350, "Sch Name"], [500, "Club"],
      [650, "R1"], [700, "R2"], [750, "Total"], [800, "Nett"],
    ];
    const result = parseSailwaveResults([
      {
        pageNumber: 1,
        text: "Sailed: 2, Discards: 1, Entries: 2",
        items: [
          ...line(700, header),
          ...line(699.25, header),
          ...line(680, [
            [10, "1st"], [60, "Damien Huang"], [150, "3300"], [200, "11-"],
            [250, "M"], [300, "SEC"], [350, "Raffles Institution"],
            [500, "SAF Yacht Club"], [650, "16"], [700, "(78"],
            [750, "94"], [800, "16"],
          ]),
          ...line(666.5, [[200, "12yo"], [700, "DSQ)"]]),
          ...line(640, [
            [10, "2nd"], [60, "Wangsun Chen"], [150, "SGP20"], [250, "M"],
            [350, "NA"], [500, "Constant Wind"], [650, "(35"], [700, "5"],
            [750, "40"], [800, "5"],
          ]),
          ...line(626.5, [[650, "SCP)"]]),
          ...line(590, [[10, "Prizes"]]),
          ...line(570, [[10, "1st"], [60, "Not a competitor"]]),
        ],
      },
    ]);

    expect(result).toMatchObject({ raceCount: 2, entries: 2, discards: 1 });
    expect(result.rows).toHaveLength(2);
    expect(result.rows[0]).toMatchObject({
      name: "Damien Huang",
      sailNumber: "3300",
      gender: "M",
      school: "Raffles Institution",
      club: "SAF Yacht Club",
    });
    expect(result.rows[0].races).toHaveLength(2);
    expect(result.rows[0].races[1]).toMatchObject({
      raceNumber: 2,
      score: 78,
      scoringCode: "DSQ",
      discarded: true,
      rawValue: "(78 DSQ)",
    });
    expect(result.rows[1]).toMatchObject({ sailNumber: "SGP20", school: null });
    expect(result.rows[1].races[0]).toMatchObject({
      scoringCode: "SCP",
      discarded: true,
      rawValue: "(35 SCP)",
    });
  });

  it("rejects extracted race scores that do not reconcile with published totals", () => {
    expect(() =>
      parseSailwaveResults([
        {
          pageNumber: 1,
          text: "Sailed: 1, Discards: 0, Entries: 1",
          items: [
            ...line(700, [[10, "Rank"], [60, "Name"], [200, "R1"], [250, "Total"], [300, "Nett"]]),
            ...line(680, [[10, "1st"], [60, "Incorrect Total"], [200, "1"], [250, "2"], [300, "1"]]),
          ],
        },
      ])
    ).toThrow("race scores do not match the published total");
  });

  it("accepts tied ranks and suggests DNS only for the tied worst rank", () => {
    const header: Array<[number, string]> = [
      [10, "Rank"], [60, "Name"], [200, "R1"], [250, "Total"], [300, "Nett"],
    ];
    const result = parseSailwaveResults([
      {
        pageNumber: 1,
        text: "Sailed: 1, Discards: 0, Entries: 4",
        items: [
          ...line(700, header),
          ...line(680, [[10, "1st"], [60, "Winner"], [200, "1"], [250, "1"], [300, "1"]]),
          ...line(660, [[10, "2nd"], [60, "Tied finisher A"], [200, "2"], [250, "2"], [300, "2"]]),
          ...line(640, [[10, "2nd"], [60, "Tied finisher B"], [200, "2"], [250, "2"], [300, "2"]]),
          ...line(620, [[10, "4th"], [60, "Last sailor"], [200, "4"], [250, "4"], [300, "4"]]),
        ],
      },
    ]);

    expect(result.rows.map((row) => row.rank)).toEqual([1, 2, 2, 4]);
    expect(result.rows.map((row) => row.isDns)).toEqual([false, false, false, false]);
  });

  it("suggests tied bottom-ranked sailors as DNS for admin review", () => {
    const header: Array<[number, string]> = [
      [10, "Rank"], [60, "Name"], [200, "R1"], [250, "Total"], [300, "Nett"],
    ];
    const result = parseSailwaveResults([
      {
        pageNumber: 1,
        text: "Sailed: 1, Discards: 0, Entries: 3",
        items: [
          ...line(700, header),
          ...line(680, [[10, "1st"], [60, "Winner"], [200, "1"], [250, "1"], [300, "1"]]),
          ...line(660, [[10, "50th"], [60, "Non-starter A"], [200, "4 DNS"], [250, "4"], [300, "4"]]),
          ...line(640, [[10, "50th"], [60, "Non-starter B"], [200, "4 DNS"], [250, "4"], [300, "4"]]),
        ],
      },
    ]);

    expect(result.rows.map((row) => row.isDns)).toEqual([false, true, true]);
  });
});
