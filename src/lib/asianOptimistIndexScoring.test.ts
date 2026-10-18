import { describe, expect, it } from "vitest";
import {
  ASIAN_OPTIMIST_INDEX_PROVISIONAL_QUALIFIER_RESULTS,
  ASIAN_OPTIMIST_INDEX_PROVISIONAL_RELEASE,
  createAsianOptimistIndexProvisionalEntries,
  normalisedFleetScore,
} from "@/lib/asianOptimistIndexScoring";
import { createAsianOptimistIndexBaseline } from "@/lib/asianOptimistIndex";

describe("SailorPath Asian and Oceania Optimist Index V1 (Beta) scoring", () => {
  it("connects Ilzani’s confirmed identity to both Malaysian finishes and scores only the strongest country result", () => {
    const entries = createAsianOptimistIndexProvisionalEntries();
    const ilzani = entries.find((entry) => entry.name === "Khairulilzani Afendy")!;
    expect(ilzani).toMatchObject({
      provisionalRank: 12,
      provisionalScore: 158.54,
      eligibleStarts: 2,
      hostCountryCount: 1,
    });
    expect(ilzani.qualifierResults.map((r) => r.rank).sort((a, b) => a - b)).toEqual([4, 9]);
    expect(ilzani.scoredQualifiers).toHaveLength(1);
    expect(ilzani.scoredQualifiers[0]).toMatchObject({ rank: 4, qualifier: { shortName: "LIRP" } });
  });

  it("normalises a verified final classification to a 0–100 event score", () => {
    expect(normalisedFleetScore(1, 170)).toBe(100);
    expect(normalisedFleetScore(170, 170)).toBe(0);
    expect(normalisedFleetScore(2, 59)).toBeCloseTo(98.275862, 6);
  });

  it("scores the 136 Asian and Oceania sailors under the V1 (Beta) methodology", () => {
    const entries = createAsianOptimistIndexProvisionalEntries();

    expect(entries).toHaveLength(136);

    // Top 6 under V1 (Beta) formula (Points = E * (N - P + 1) / N)
    expect(entries.slice(0, 6).map((entry) => entry.name)).toEqual([
      "Anya Zahedi",
      "Suthinan Nakpasom",
      "Alyssa Wong",
      "Sorawit Naksuk",
      "Ethan Low",
      "Wenyu Cheng",
    ]);

    const anya = entries.find((entry) => entry.name === "Anya Zahedi")!;
    expect(anya).toMatchObject({
      provisionalRank: 1,
      provisionalScore: 258.05,
      championshipPoints: 147.35,
      qualifierPoints: 110.69,
      eligibleStarts: 2,
      hostCountryCount: 1,
    });
    expect(anya.qualifierResults.map((score) => score.rank).sort((a, b) => a - b)).toEqual([3, 7]);
    expect(anya.scoredQualifiers).toHaveLength(2);

    const suthinan = entries.find((entry) => entry.name === "Suthinan Nakpasom")!;
    expect(suthinan).toMatchObject({
      provisionalRank: 2,
      provisionalScore: 251.96,
      championshipPoints: 103.24,
      qualifierPoints: 148.73,
      eligibleStarts: 2,
      hostCountryCount: 2,
    });
    expect(suthinan.scoredQualifiers.map((score) => score.qualifier.hostCountry).sort()).toEqual([
      "Malaysia",
      "Thailand",
    ]);
    expect(suthinan.qualifierResults.map((score) => score.qualifier.shortName).sort()).toEqual([
      "LIRP",
      "Thailand Int'l",
    ]);

    const alyssa = entries.find((entry) => entry.name === "Alyssa Wong")!;
    expect(alyssa).toMatchObject({
      provisionalRank: 3,
      provisionalScore: 241.69,
      championshipPoints: 132.35,
      qualifierPoints: 109.34,
      eligibleStarts: 2,
      hostCountryCount: 1,
    });

    const sorawit = entries.find((entry) => entry.name === "Sorawit Naksuk")!;
    expect(sorawit).toMatchObject({
      provisionalRank: 4,
      provisionalScore: 222.17,
      championshipPoints: 150,
      qualifierPoints: 72.17,
      eligibleStarts: 1,
      hostCountryCount: 1,
    });

    const ethanChia = entries.find((entry) => entry.name === "Ethan Chia")!;
    expect(ethanChia).toMatchObject({
      provisionalScore: 149.12,
      eligibleStarts: 0,
      hostCountryCount: 0,
      qualifierPoints: 0,
    });

    // Verify Oceania sailors are included
    const williamHarris = entries.find((entry) => entry.name === "William Harris")!;
    expect(williamHarris).toMatchObject({
      nationality: "AUS",
      overallPlace: 30,
      championshipPoints: 124.41,
    });

    const jeffreyDu = entries.find((entry) => entry.name === "Jeffrey Chenglin Du")!;
    expect(jeffreyDu).toMatchObject({
      nationality: "NZL",
      overallPlace: 62,
    });

    const rubenSteel = entries.find((entry) => entry.name === "Ruben Steel")!;
    expect(rubenSteel).toMatchObject({
      nationality: "AUS",
      profileHref: "/ruben-steel-0ajhhtd",
    });
  });

  it("only awards inputs that belong to the 2025 cohort", () => {
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

  it("keeps the release configuration versioned as V1 (Beta)", () => {
    expect(ASIAN_OPTIMIST_INDEX_PROVISIONAL_RELEASE).toMatchObject({
      version: "V1 (Beta)",
      name: "SailorPath Asian and Oceania Optimist Index",
      cohortSize: 136,
      maxResultsCounted: 5,
      maxGrade150: 2,
      maxWorlds: 1,
      maxUpperGrade: 4,
    });
  });
});
