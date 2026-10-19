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
      provisionalRank: 29,
      provisionalScore: 158.54,
      eligibleStarts: 3,
      hostCountryCount: 2,
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

  it("scores the 176 Asian and Oceania sailors under the V1 (Beta) methodology", () => {
    const entries = createAsianOptimistIndexProvisionalEntries();

    expect(entries).toHaveLength(176);

    // Top 6 under V1 (Beta) formula (Points = E * (N - P + 1) / N)
    expect(entries.slice(0, 6).map((entry) => entry.name)).toEqual([
      "Anya Zahedi",
      "Margaux Nguyen-Minh",
      "Lucas Cao",
      "Rohan Maliah",
      "Suthinan Nakpasom",
      "Tara Maliah",
    ]);

    const anya = entries.find((entry) => entry.name === "Anya Zahedi")!;
    expect(anya).toMatchObject({
      provisionalRank: 1,
      provisionalScore: 385.6,
      championshipPoints: 217.43,
      qualifierPoints: 168.16,
      eligibleStarts: 5,
      countedResultsCount: 5,
      hostCountryCount: 4,
    });
    expect(anya.qualifierResults.map((score) => score.rank).sort((a, b) => a - b)).toEqual([3, 7, 19, 66]);
    expect(anya.scoredQualifiers).toHaveLength(4);

    const suthinan = entries.find((entry) => entry.name === "Suthinan Nakpasom")!;
    expect(suthinan).toMatchObject({
      provisionalRank: 5,
      provisionalScore: 313.23,
      championshipPoints: 164.5,
      qualifierPoints: 148.73,
      eligibleStarts: 4,
      countedResultsCount: 4,
      hostCountryCount: 4,
    });
    expect(suthinan.scoredQualifiers.map((score) => score.qualifier.hostCountry).sort()).toEqual([
      "Malaysia",
      "Morocco",
      "Thailand",
    ]);

    const sorawit = entries.find((entry) => entry.name === "Sorawit Naksuk")!;
    expect(sorawit).toMatchObject({
      provisionalRank: 8,
      provisionalScore: 294,
      championshipPoints: 221.83,
      qualifierPoints: 72.17,
      eligibleStarts: 3,
      countedResultsCount: 3,
      hostCountryCount: 3,
    });

    const ethanChia = entries.find((entry) => entry.name === "Ethan Chia")!;
    expect(ethanChia).toMatchObject({
      provisionalScore: 149.12,
      eligibleStarts: 1,
      hostCountryCount: 1,
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

    // Verify new sailors from Worlds and Europeans
    const walterHeeley = entries.find((entry) => entry.name === "Walter Heeley")!;
    expect(walterHeeley).toMatchObject({
      nationality: "AUS",
      overallPlace: null,
      provisionalRank: 38,
      provisionalScore: 141.55,
      championshipPoints: 141.55,
      profileHref: "/walter-heeley-worlds26-c34abc",
    });

    const auroraEdhouse = entries.find((entry) => entry.name === "Aurora Edhouse")!;
    expect(auroraEdhouse).toMatchObject({
      nationality: "NZL",
      overallPlace: null,
      provisionalRank: 52,
      provisionalScore: 126.64,
      championshipPoints: 126.64,
      profileHref: "/aurora-edhouse-euro26-ba2f7c",
    });
  });

  it("only awards inputs that belong to the cohort", () => {
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
      cohortSize: 176,
      maxResultsCounted: 5,
      maxGrade150: 2,
      maxWorlds: 1,
      maxUpperGrade: 4,
    });
  });
});
