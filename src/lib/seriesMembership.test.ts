import { describe, expect, it } from "vitest";
import {
  hasSilverHistory,
  isSeriesMember,
  normalizeNationality,
  normalizeYearsList,
  seriesFleetStatus,
  validateGoldPromotion,
} from "./seriesMembership";

describe("hasSilverHistory / isSeriesMember / seriesFleetStatus", () => {
  it("silver entry counts as history", () => {
    expect(hasSilverHistory({ silverEntryDate: "2024-01-01" })).toBe(true);
  });

  it("gold entry alone counts as history (seeded)", () => {
    expect(hasSilverHistory({ goldEntryDate: "2023-06-01" })).toBe(true);
  });

  it("guest without dates is not a series member", () => {
    expect(isSeriesMember({})).toBe(false);
    expect(seriesFleetStatus({})).toBe("guest");
  });

  it("drop date marks dropped status", () => {
    expect(
      seriesFleetStatus({
        currentFleet: "Series",
        goldEntryDate: "2024-01-01",
        dropDate: "2020-01-01",
      })
    ).toBe("dropped");
    expect(
      isSeriesMember({
        goldEntryDate: "2024-01-01",
        dropDate: "2020-01-01",
      })
    ).toBe(false);
  });

  it("Series / legacy Gold tag is in series", () => {
    expect(seriesFleetStatus({ currentFleet: "Series" })).toBe("series");
    // Legacy Gold tag without gold entry → series (not ranking Gold)
    expect(seriesFleetStatus({ currentFleet: "Gold" })).toBe("series");
    expect(
      seriesFleetStatus({ currentFleet: "Series", goldEntryDate: "2024-01-01" })
    ).toBe("gold");
    expect(seriesFleetStatus({ currentFleet: "Guest" })).toBe("guest");
  });
});

describe("validateGoldPromotion", () => {
  it("blocks gold without silver history", () => {
    const err = validateGoldPromotion({ goldEntryDate: "2026-01-01" });
    expect(err).toMatch(/Silver history/i);
  });

  it("allows gold when silver entry set", () => {
    expect(
      validateGoldPromotion({
        currentFleet: "Series",
        silverEntryDate: "2024-01-01",
        goldEntryDate: "2025-01-01",
      })
    ).toBeNull();
  });

  it("allows edits when already gold in DB", () => {
    expect(
      validateGoldPromotion({
        goldEntryDate: "2025-01-01",
        existing: { goldEntryDate: "2024-01-01", currentFleet: "Series" },
      })
    ).toBeNull();
  });
});

describe("normalizeNationality / normalizeYearsList", () => {
  it("maps common SG codes", () => {
    const n = normalizeNationality("Singapore");
    expect(n === "SGP" || n === "Singapore").toBe(true);
  });

  it("normalizes multi-year lists", () => {
    expect(normalizeYearsList("2025, 2023")).toBe("2023, 2025");
    expect(normalizeYearsList(2024)).toBe("2024");
    expect(normalizeYearsList("")).toBeNull();
  });
});
