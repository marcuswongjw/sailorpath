import { describe, expect, it } from "vitest";
import { toPublicRegattaResult } from "./publicRegattaResult";
import type { PublicRegattaResult } from "./queries";
describe("public scorecard projection", () => {
  it("strips private and unexpected fields at every nested boundary, including fallback rows", () => {
    const row = {
      resultId: "result", sailorId: "sailor", regattaId: "regatta", rank: 1,
      nettScore: 3, totalScore: 5, isDns: false, isOverseasCommitment: false,
      sailorName: "Fixture sailor", sailNumber: "123", handle: "fixture",
      dob: "2012-08-23", school: "PRIVATE_SCHOOL", parentId: "PRIVATE_OWNER", futurePrivateField: "PRIVATE_FUTURE",
      participants: [{ id: "participant", sourceName: "Fixture crew", role: "crew", privateNote: "PRIVATE_CREW" }],
      raceResults: [{ raceNumber: 1, score: 3, scoringCode: null, discarded: true, rawValue: "(3)", privateNote: "PRIVATE_RACE" }],
    } as unknown as PublicRegattaResult;
    const projected = toPublicRegattaResult(row);
    expect(projected.birthYear).toBe(2012);
    expect(projected.raceResults[0]).toMatchObject({ score: 3, discarded: true, rawValue: "(3)" });
    expect(JSON.stringify(projected)).not.toMatch(/PRIVATE_|2012-08-23|"dob"|"school"|"parentId"/);
    expect(toPublicRegattaResult({ ...row, birthYear: 2011 }).birthYear).toBe(2011);
  });
});
