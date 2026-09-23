import { describe, expect, it } from "vitest";
import {
  restoreBestNettHiddenAsDns,
  restoreBestNettHiddenAsDnsByRegatta,
} from "./restoreFinisherRank";

describe("restoreBestNettHiddenAsDns", () => {
  it("puts the winning nett back in first when it was stored as a DNS placeholder", () => {
    const rows = [
      { name: "Lucas", rank: 2, nettScore: 16, isDns: false },
      { name: "Yuk Jun", rank: 3, nettScore: 16, isDns: false },
      { name: "Caleb", rank: 44, nettScore: 6, isDns: true },
    ];

    expect(restoreBestNettHiddenAsDns(rows).map((row) => [row.name, row.rank, row.isDns])).toEqual([
      ["Caleb", 1, false],
      ["Lucas", 2, false],
      ["Yuk Jun", 3, false],
    ]);
  });

  it("leaves a real last-place DNS sailor in place", () => {
    const rows = [
      { name: "Winner", rank: 1, nettScore: 6, isDns: false },
      { name: "Did not start", rank: 38, nettScore: 176, isDns: true },
    ];
    expect(restoreBestNettHiddenAsDns(rows)).toEqual(rows);
  });

  it("does not guess when two sailors share the best nett", () => {
    const rows = [
      { name: "A", rank: 2, nettScore: 10, isDns: false },
      { name: "B", rank: 44, nettScore: 10, isDns: true },
    ];
    expect(restoreBestNettHiddenAsDns(rows)).toEqual(rows);
  });

  it("repairs each regatta on its own", () => {
    const rows = restoreBestNettHiddenAsDnsByRegatta([
      { regattaId: "pesta", name: "Second", rank: 2, nettScore: 16, isDns: false },
      { regattaId: "pesta", name: "Winner", rank: 44, nettScore: 6, isDns: true },
      { regattaId: "other", name: "DNS", rank: 20, nettScore: 80, isDns: true },
      { regattaId: "other", name: "First", rank: 1, nettScore: 4, isDns: false },
    ]);
    const pesta = rows.filter((row) => row.regattaId === "pesta");
    expect(pesta.map((row) => row.name)).toEqual(["Winner", "Second"]);
    expect(pesta[0].isDns).toBe(false);
    expect(rows.find((row) => row.name === "DNS")?.isDns).toBe(true);
  });
});
