import { describe, expect, it } from "vitest";
import { publicationReadiness } from "./publicationReadiness";

const complete = {
  name: "SNSC ILCA 4",
  date: "2026-09-05",
  boatClass: "ILCA 4",
  division: "Open",
  totalFleetSize: 40,
  raceCount: 6,
  countsForRanking: true,
  resultCount: 20,
  status: "draft",
};

describe("publicationReadiness", () => {
  it("is publishable and ranking when scoring accepts the class", () => {
    expect(publicationReadiness(complete).summary).toBe("publishable_ranking");
  });

  it("treats zero races as known and non-ranking, not missing", () => {
    const result = publicationReadiness({
      ...complete,
      raceCount: 0,
      resultCount: 0,
    });
    expect(result.summary).toBe("publishable_non_ranking");
    expect(result.checks.some((check) => check.code === "race-count-unknown")).toBe(
      false
    );
    expect(result.checks.some((check) => check.code === "results-missing")).toBe(
      false
    );
  });

  it("treats an unknown race count as incomplete", () => {
    expect(
      publicationReadiness({ ...complete, raceCount: null }).summary
    ).toBe("incomplete");
  });

  it("lets blocked beat incomplete", () => {
    expect(
      publicationReadiness({
        ...complete,
        name: "",
        status: "archived",
      }).summary
    ).toBe("blocked");
  });

  it("does not let the ranking flag override fewer than three races", () => {
    const result = publicationReadiness({
      ...complete,
      raceCount: 2,
      countsForRanking: true,
    });
    expect(result.summary).toBe("publishable_non_ranking");
    expect(result.checks.some((check) => check.code === "ranking-excluded")).toBe(
      true
    );
  });

  it("requires an official source and non-ranking status for external results", () => {
    const missingSource = publicationReadiness({
      ...complete,
      geography: "MAS",
      countsForRanking: false,
    });
    expect(missingSource.summary).toBe("incomplete");
    expect(
      missingSource.checks.some((check) => check.code === "official-results-url-missing")
    ).toBe(true);
    expect(
      missingSource.checks.some((check) => check.code === "official-results-source-missing")
    ).toBe(true);

    const rankingExternal = publicationReadiness({
      ...complete,
      geography: "MAS",
      officialResultsUrl: "https://example.com/results",
      officialResultsSourceName: "Official results",
      countsForRanking: true,
    });
    expect(rankingExternal.summary).toBe("blocked");
    expect(
      rankingExternal.checks.some((check) => check.code === "external-ranking-blocked")
    ).toBe(true);

    expect(
      publicationReadiness({
        ...complete,
        geography: "MAS",
        officialResultsUrl: "https://example.com/results",
        officialResultsSourceName: "Official results",
        countsForRanking: false,
      }).summary
    ).toBe("publishable_non_ranking");
  });
});
