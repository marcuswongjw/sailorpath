import { renderToStaticMarkup } from "react-dom/server";
import { describe, expect, it } from "vitest";
import { PublicRegattaResults } from "./PublicRegattaResults";

describe("PublicRegattaResults", () => {
  it("shows the imported count and official fleet size when identities are deferred", () => {
    const html = renderToStaticMarkup(
      <PublicRegattaResults accent="orange" totalFleetSize={4} results={[]} pendingIdentityReview />
    );
    expect(html).toContain('role="status"');
    expect(html).toContain("Partial import: 0 of 4 entries are shown.");
    expect(html).toContain("4 entries await sailor identity review.");
  });

  it("does not imply an identity hold for ordinary result tables", () => {
    const html = renderToStaticMarkup(
      <PublicRegattaResults accent="orange" totalFleetSize={4} results={[]} />
    );
    expect(html).not.toContain("Partial import:");
  });

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
    expect(html).not.toContain("Is this you? Claim profile");
  });

  it("links an unclaimed sailor to claim, and skips a claimed sailor", () => {
    const html = renderToStaticMarkup(
      <PublicRegattaResults
        accent="orange"
        totalFleetSize={12}
        results={[
          {
            resultId: "open-result",
            sailorId: "sailor-open",
            regattaId: "regatta-1",
            rank: 2,
            nettScore: 8,
            totalScore: 10,
            isDns: false,
            isOverseasCommitment: false,
            sailorName: "Open Sailor",
            sailNumber: "SGP 1",
            handle: "open-sailor",
            profileClaimed: false,
            raceResults: [],
          },
          {
            resultId: "claimed-result",
            sailorId: "sailor-claimed",
            regattaId: "regatta-1",
            rank: 1,
            nettScore: 4,
            totalScore: 6,
            isDns: false,
            isOverseasCommitment: false,
            sailorName: "Claimed Sailor",
            sailNumber: "SGP 2",
            handle: "claimed-sailor",
            profileClaimed: true,
            raceResults: [],
          },
        ]}
      />
    );

    expect(html).toContain("Is this you? Claim profile");
    expect(html).toContain('href="/login?next=%2Fsailors%2Fopen-sailor"');
    expect(html).toContain('href="/sailors/claimed-sailor"');
    expect(html).not.toContain("next=%2Fsailors%2Fclaimed-sailor");
  });

  it("labels a crewed boat entry without duplicating its score row", () => {
    const html = renderToStaticMarkup(
      <PublicRegattaResults
        accent="orange"
        totalFleetSize={12}
        results={[
          {
            resultId: "crew-result",
            sailorId: "sailor-1",
            regattaId: "regatta-crew",
            rank: 1,
            nettScore: 8,
            totalScore: 11,
            isDns: false,
            isOverseasCommitment: false,
            sailorName: "Seth Low / Amos Tham",
            sailNumber: "SGP 29",
            handle: "seth-low",
            raceResults: [],
            entryType: "crew",
            entrySailNumber: "SGP 29",
            participants: [
              {
                id: "participant-1",
                resultId: "crew-result",
                sailorId: "sailor-1",
                sailorName: "Seth Low",
                handle: "seth-low",
                sourceName: "Seth Low",
                displayOrder: 1,
                role: "helm",
                matchStatus: "matched",
                rankingCredit: false,
              },
              {
                id: "participant-2",
                resultId: "crew-result",
                sailorId: "sailor-2",
                sailorName: "Amos Tham",
                handle: "amos-tham",
                sourceName: "Amos Tham",
                displayOrder: 2,
                role: "crew",
                matchStatus: "matched",
                rankingCredit: false,
              },
            ],
          },
        ]}
      />
    );

    expect(html).toContain("Crew · Seth Low (helm) / Amos Tham (crew) · Sail SGP 29");
    expect((html.match(/Seth Low \/ Amos Tham/g) || []).length).toBeGreaterThan(0);
  });

  it("renders primary English name with native Japanese Kanji as secondary subtext", () => {
    const html = renderToStaticMarkup(
      <PublicRegattaResults
        accent="orange"
        totalFleetSize={81}
        results={[
          {
            resultId: "res-jpn-1",
            sailorId: "sailor-shoi",
            regattaId: "regatta-all-japan",
            rank: 1,
            nettScore: 9,
            totalScore: 14,
            isDns: false,
            isOverseasCommitment: false,
            sailorName: "Shoi Fujita",
            entryLabel: "藤田 翔伊",
            sailNumber: "JPN 3407",
            handle: "opti-jpn-shoi-fujita-3407",
            raceResults: [],
          },
          {
            resultId: "res-sgp-1",
            sailorId: "sailor-ethan",
            regattaId: "regatta-all-japan",
            rank: 2,
            nettScore: 12,
            totalScore: 18,
            isDns: false,
            isOverseasCommitment: false,
            sailorName: "Ethan Chia",
            entryLabel: "ETHAN CHIA",
            sailNumber: "SGP 111",
            handle: "ethan-chia",
            raceResults: [],
          },
        ]}
      />
    );

    // English names rendered as primary text inside links
    expect(html).toContain("Shoi Fujita");
    expect(html).toContain("Ethan Chia");

    // Kanji rendered with Japanese language attribute and subtle style
    expect(html).toContain('lang="ja"');
    expect(html).toContain("藤田 翔伊");

    // Case-insensitive duplicate entry label is suppressed (not rendered as secondary text)
    expect(html).not.toContain(">ETHAN CHIA<");
  });
});
