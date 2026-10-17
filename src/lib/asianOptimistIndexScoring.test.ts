import { describe, expect, it } from "vitest";
import {
  ASIAN_OPTIMIST_INDEX_PROVISIONAL_QUALIFIER_RESULTS,
  ASIAN_OPTIMIST_INDEX_PROVISIONAL_RELEASE,
  createAsianOptimistIndexProvisionalEntries,
  normalisedFleetScore,
} from "@/lib/asianOptimistIndexScoring";
import { createAsianOptimistIndexBaseline } from "@/lib/asianOptimistIndex";

describe("Asian Optimist Index provisional scoring", () => {
  it("connects Ilzani’s confirmed identity to both Malaysian finishes and scores only the strongest country result", () => {
    const entries = createAsianOptimistIndexProvisionalEntries();
    const ilzani = entries.find(entry => entry.name === "Khairulilzani Afendy")!;
    expect(ilzani).toMatchObject({ provisionalRank: 12, provisionalScore: 61.3, eligibleStarts: 2, hostCountryCount: 1 });
    expect(ilzani.qualifierResults.map(r => r.rank).sort((a, b) => a - b)).toEqual([4, 9]);
    expect(ilzani.scoredQualifiers).toHaveLength(1);
    expect(ilzani.scoredQualifiers[0]).toMatchObject({ rank: 4, qualifier: { shortName: "LIRP" } });
  });

  it("normalises a verified final classification to a 0–100 event score", () => {
    expect(normalisedFleetScore(1, 170)).toBe(100);
    expect(normalisedFleetScore(170, 170)).toBe(0);
    expect(normalisedFleetScore(2, 59)).toBeCloseTo(98.275862, 6);
  });

  it("scores the fixed 2025 Asian cohort with transparent qualifier coverage", () => {
    const entries = createAsianOptimistIndexProvisionalEntries();

    expect(entries).toHaveLength(122);
    expect(entries.slice(0, 6).map((entry) => entry.name)).toEqual([
      "Yaasin Syahrizan",
      "Sorawit Naksuk",
      "Anya Zahedi",
      "Suthinan Nakpasom",
      "Rachata Sadtrakulwattana",
      "Rohan Maliah",
    ]);

    const sorawit = entries.find((entry) => entry.name === "Sorawit Naksuk")!;
    expect(sorawit).toMatchObject({
      provisionalRank: 2,
      provisionalScore: 79.6,
      championshipScore: 100,
      championshipPoints: 60,
      qualifierPoints: 19.6,
      eligibleStarts: 1,
      hostCountryCount: 1,
    });

    const suthinan = entries.find((entry) => entry.name === "Suthinan Nakpasom")!;
    expect(suthinan).toMatchObject({
      provisionalRank: 4,
      provisionalScore: 77,
      eligibleStarts: 2,
      hostCountryCount: 2,
    });
    expect(suthinan.scoredQualifiers.map((score) => score.qualifier.hostCountry)).toEqual([
      "Thailand",
      "Malaysia",
    ]);
    expect(suthinan.qualifierResults.map((score) => score.qualifier.shortName)).toEqual([
      "LIRP",
      "Thailand International",
    ]);
    expect(suthinan.scoredQualifiers[0].pointsContribution).toBeCloseTo(28, 8);
    expect(suthinan.scoredQualifiers[1].pointsContribution).toBeCloseTo(7.8621, 4);

    const yaasin = entries.find((entry) => entry.name === "Yaasin Syahrizan")!;
    expect(yaasin).toMatchObject({
      provisionalRank: 1,
      eligibleStarts: 1,
      hostCountryCount: 1,
    });
    expect(yaasin.qualifierResults).toMatchObject([
      { rank: 1, qualifier: { shortName: "LYSC", hostCountry: "Malaysia" } },
    ]);

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

    const anya = entries.find((entry) => entry.name === "Anya Zahedi")!;
    expect(anya).toMatchObject({
      provisionalRank: 3,
      provisionalScore: 78.5,
      eligibleStarts: 2,
      hostCountryCount: 1,
      qualifierPoints: 19.6,
    });
    expect(anya.qualifierResults.map((score) => score.rank).sort((a, b) => a - b)).toEqual([3, 7]);

    const alyssa = entries.find((entry) => entry.name === "Alyssa Wong")!;
    expect(alyssa).toMatchObject({
      eligibleStarts: 2,
      hostCountryCount: 1,
      qualifierPoints: 19.6,
    });
    expect(alyssa.qualifierResults.map((score) => score.rank).sort((a, b) => a - b)).toEqual([1, 9]);

    const ethan = entries.find((entry) => entry.name === "Ethan Chia")!;
    expect(ethan).toMatchObject({
      provisionalScore: 59.6,
      eligibleStarts: 0,
      hostCountryCount: 0,
      qualifierPoints: 0,
    });
  });

  it("only awards inputs that belong to the fixed 2025 cohort", () => {
    const cohortKeys = new Set(
      createAsianOptimistIndexBaseline().map((entry) =>
        `${entry.nationality}:${entry.name.toLowerCase().replace(/[^a-z0-9]/g, "")}`
      )
    );

    for (const result of ASIAN_OPTIMIST_INDEX_PROVISIONAL_QUALIFIER_RESULTS) {
      expect(cohortKeys).toContain(
        `${result.nationality}:${result.name.toLowerCase().replace(/[^a-z0-9]/g, "")}`
      );
    }
  });

  it("keeps the pre-Colombo release formula versioned and weighted to the championship", () => {
    expect(ASIAN_OPTIMIST_INDEX_PROVISIONAL_RELEASE).toMatchObject({
      version: "Provisional v1.0",
      cohortSize: 122,
      anchorWeight: 0.6,
      qualifierEventCap: 5,
      qualifyingResultLimit: 3,
      qualifierWeights: [0.28, 0.08, 0.04],
    });
  });
});
