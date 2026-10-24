import { describe, expect, it } from "vitest";
import { describeRaceScore, scoringCodeMeaning } from "./raceScorePresentation";

describe("race score explanations", () => {
  it("keeps missing scores distinct from zero scores", () => {
    expect(describeRaceScore(undefined, 3)).toBe("Race 3: score unavailable.");
    expect(describeRaceScore({raceNumber:3,score:0,rawValue:"0",scoringCode:null,discarded:false},3)).toBe("Race 3: 0.");
  });
  it("describes a penalty even when that score is discarded", () => {
    const race = {raceNumber:6,score:78,rawValue:"(78 DSQ)",scoringCode:"DSQ",discarded:true};
    const before = {...race};
    expect(describeRaceScore(race,6)).toBe("Race 6: (78 DSQ). Discarded score. DSQ: Entry disqualified from the race.");
    expect(race).toEqual(before);
  });
  it("normalizes code lookup and leaves unfamiliar codes to the organiser", () => {
    expect(scoringCodeMeaning(" dns ")).toContain("No start recorded");
    expect(scoringCodeMeaning("CUSTOM")).toBe("See the organiser’s scoring notes for this code.");
    expect(scoringCodeMeaning("DNE")).toContain("must remain");
  });
});
