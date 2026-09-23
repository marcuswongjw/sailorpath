import { renderToStaticMarkup } from "react-dom/server";
import { describe, expect, it } from "vitest";
import { PublicRegattaResults } from "./PublicRegattaResults";

describe("PublicRegattaResults", () => {
  it("renders every race and preserves discard and penalty notation", () => {
    const html = renderToStaticMarkup(
      <PublicRegattaResults
        accent="orange"
        totalFleetSize={77}
        raceCount={6}
        results={[
          {
            resultId: "result-1",
            sailorId: "sailor-1",
            regattaId: "regatta-1",
            rank: 1,
            nettScore: 11,
            totalScore: 27,
            isDns: false,
            isOverseasCommitment: false,
            sailorName: "Test Sailor",
            sailNumber: "SGP 1234",
            school: null,
            handle: "test-sailor",
            gender: "female",
            sailorGender: "female",
            birthYear: 2012,
            dob: null,
            nationality: "SGP",
            sailorNationality: "SGP",
            raceResults: [
              {
                regattaResultId: "result-1",
                raceNumber: 1,
                score: 1,
                scoringCode: null,
                discarded: false,
                rawValue: "1",
              },
              {
                regattaResultId: "result-1",
                raceNumber: 6,
                score: 78,
                scoringCode: "DSQ",
                discarded: true,
                rawValue: "(78 DSQ)",
              },
            ],
          },
        ]}
      />
    );

    expect(html).toContain("R1");
    expect(html).toContain("R6");
    expect(html).toContain("2 published race scores");
    expect(html).toContain("(78 DSQ)");
    expect(html).toContain('title="Discarded score"');
  });

  it("does not render phantom race columns when no race-by-race results have been imported yet", () => {
    const html = renderToStaticMarkup(
      <PublicRegattaResults
        accent="sky"
        totalFleetSize={50}
        raceCount={6}
        results={[
          {
            resultId: "res-only-totals",
            sailorId: "sailor-totals",
            regattaId: "regatta-totals",
            rank: 1,
            nettScore: 10,
            totalScore: 10,
            isDns: false,
            isOverseasCommitment: false,
            sailorName: "Total Only Sailor",
            sailNumber: "SGP 99",
            school: null,
            handle: "total-only",
            gender: "male",
            sailorGender: "male",
            birthYear: 2011,
            dob: null,
            nationality: "SGP",
            sailorNationality: "SGP",
            raceResults: [],
          },
        ]}
      />
    );

    expect(html).not.toContain(">R1<");
    expect(html).not.toContain(">R6<");
    expect(html).not.toContain("published race score");
    expect(html).toContain("Total Only Sailor");
    expect(html).toContain("Total");
    expect(html).toContain("Nett");
  });
});
