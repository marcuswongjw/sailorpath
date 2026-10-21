import { describe, expect, it } from "vitest";
import { createAsianOptimistIndexProvisionalEntries } from "@/lib/asianOptimistIndexScoring";
import { filterAsianOptimistIndexEntries } from "@/components/AsianOptimistIndexStandings";

describe("Asian Optimist Index standings filters", () => {
  const entries = createAsianOptimistIndexProvisionalEntries();

  it("filters the fixed cohort by three-letter country code", () => {
    const singapore = filterAsianOptimistIndexEntries(entries, "SGP", "all", "all");

    expect(singapore).toHaveLength(13);
    expect(singapore.every((entry) => entry.nationality === "SGP")).toBe(true);
    expect(singapore.map((entry) => entry.name)).toContain("Anya Zahedi");

    const australia = filterAsianOptimistIndexEntries(entries, "AUS", "all", "all");
    expect(australia).toHaveLength(16);
    expect(australia.every((entry) => entry.nationality === "AUS")).toBe(true);
    expect(australia.map((entry) => entry.name)).toContain("William Harris");
  });

  it("intersects country, M/F gender, and birth-year filters", () => {
    const singaporeGirlsBornIn2013 = filterAsianOptimistIndexEntries(
      entries,
      "SGP",
      "F",
      "2013"
    );

    expect(singaporeGirlsBornIn2013.map((entry) => entry.name).sort()).toEqual([
      "Alyssa Wong",
      "Anya Zahedi",
    ]);
  });

  it("keeps sailors with no recorded birth year discoverable", () => {
    const unknownBirthYear = filterAsianOptimistIndexEntries(entries, "all", "all", "unknown");

    expect(unknownBirthYear.length).toBeGreaterThan(0);
    expect(unknownBirthYear.every((entry) => entry.birthYear == null)).toBe(true);
  });
});
