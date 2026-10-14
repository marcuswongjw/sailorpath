import { describe, expect, it } from "vitest";
import {
  ASIAN_OPTIMIST_INDEX_PROVISIONAL_RELEASE,
  createAsianOptimistIndexProvisionalEntries,
  normalisedFleetScore,
} from "@/lib/asianOptimistIndexScoring";

describe("Asian Optimist Index provisional scoring", () => {
  it("normalises a verified final classification to a 0–100 event score", () => {
    expect(normalisedFleetScore(1, 170)).toBe(100);
    expect(normalisedFleetScore(170, 170)).toBe(0);
    expect(normalisedFleetScore(2, 59)).toBeCloseTo(98.275862, 6);
  });

  it("scores the fixed 2025 Asian cohort with transparent qualifier coverage", () => {
    const entries = createAsianOptimistIndexProvisionalEntries();

    expect(entries).toHaveLength(122);
    expect(entries.slice(0, 6).map((entry) => entry.name)).toEqual([
      "Sorawit Naksuk",
      "Suthinan Nakpasom",
      "Rohan Maliah",
      "Youjia Xu",
      "Wenyu Cheng",
      "Ethan Chia",
    ]);

    const sorawit = entries.find((entry) => entry.name === "Sorawit Naksuk")!;
    expect(sorawit).toMatchObject({
      provisionalRank: 1,
      provisionalScore: 79.6,
      championshipScore: 100,
      championshipPoints: 60,
      qualifierPoints: 19.6,
      eligibleStarts: 1,
      hostCountryCount: 1,
    });

    const suthinan = entries.find((entry) => entry.name === "Suthinan Nakpasom")!;
    expect(suthinan).toMatchObject({
      provisionalRank: 2,
      provisionalScore: 77,
      eligibleStarts: 2,
      hostCountryCount: 2,
    });
    expect(suthinan.scoredQualifiers.map((score) => score.qualifier.hostCountry)).toEqual([
      "Thailand",
      "Malaysia",
    ]);
    expect(suthinan.scoredQualifiers[0].pointsContribution).toBeCloseTo(28, 8);
    expect(suthinan.scoredQualifiers[1].pointsContribution).toBeCloseTo(7.8621, 4);

    const wenyu = entries.find((entry) => entry.name === "Wenyu Cheng")!;
    expect(wenyu).toMatchObject({
      eligibleStarts: 2,
      hostCountryCount: 1,
      qualifierPoints: 19.6,
    });
    expect(wenyu.scoredQualifiers).toHaveLength(1);
    expect(wenyu.scoredQualifiers[0]).toMatchObject({
      rank: 1,
      qualifier: { shortName: "SYSC", hostCountry: "Singapore" },
    });

    const ethan = entries.find((entry) => entry.name === "Ethan Chia")!;
    expect(ethan).toMatchObject({
      provisionalRank: 6,
      provisionalScore: 59.6,
      eligibleStarts: 0,
      hostCountryCount: 0,
      qualifierPoints: 0,
    });
  });

  it("keeps the pre-Colombo release formula versioned and weighted to the championship", () => {
    expect(ASIAN_OPTIMIST_INDEX_PROVISIONAL_RELEASE).toMatchObject({
      version: "Provisional v1.0",
      cohortSize: 122,
      anchorWeight: 0.6,
      qualifierWeights: [0.28, 0.08, 0.04],
    });
  });
});
