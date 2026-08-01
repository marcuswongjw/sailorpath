import { describe, expect, it } from "vitest";
import {
  deriveAllSilverEntryDates,
  deriveSilverEntryYmd,
} from "./deriveFleetEntryDates";

describe("deriveSilverEntryYmd", () => {
  const links = [
    {
      sailorId: "a",
      regattaDate: "2026-03-15",
      division: "Silver",
      countsForRanking: true,
    },
    {
      sailorId: "a",
      regattaDate: "2026-01-20",
      division: "Silver",
      countsForRanking: true,
    },
    {
      sailorId: "a",
      regattaDate: "2025-11-01",
      division: "Gold",
      countsForRanking: true,
    },
    {
      sailorId: "a",
      regattaDate: "2025-06-01",
      division: "Silver",
      countsForRanking: false,
    },
    {
      sailorId: "b",
      regattaDate: "2026-07-10",
      division: "Silver",
      countsForRanking: true,
    },
  ];

  it("ignores non-Optimist classes for silver entry", () => {
    const y = deriveSilverEntryYmd(
      [
        {
          sailorId: "a",
          regattaDate: "2025-02-01",
          division: "Silver",
          countsForRanking: true,
          boatClass: "ILCA 4",
        },
        {
          sailorId: "a",
          regattaDate: "2025-03-01",
          division: "Silver",
          countsForRanking: true,
          boatClass: "Optimist",
        },
      ],
      "a"
    );
    expect(y).toBe("2025-03-01");
  });

  it("uses earliest Silver ranking date (not half boundary)", () => {
    expect(deriveSilverEntryYmd(links, "a")).toBe("2026-01-20");
  });

  it("ignores non-ranking silver", () => {
    expect(deriveSilverEntryYmd(links, "a")).not.toBe("2025-06-01");
  });

  it("maps all sailors", () => {
    const m = deriveAllSilverEntryDates(links);
    expect(m.get("a")).toBe("2026-01-20");
    expect(m.get("b")).toBe("2026-07-10");
  });
});
