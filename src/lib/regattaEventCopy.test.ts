import { describe, expect, it } from "vitest";
import { applyRegattaEventCopy } from "@/lib/regattaEventCopy";
import type { RegattaEventDef } from "@/lib/regattaEvents";

const event: RegattaEventDef = {
  slug: "rsyc-optimist-silver-fleet-knockout-championship-2026",
  name: "RSYC Optimist Silver Fleet Knockout Championship 2026",
  shortName: "RSYC Knockout 2026",
  datesText: "26–27 September 2026",
  venue: "Republic of Singapore Yacht Club, Singapore",
  organizer: "Republic of Singapore Yacht Club",
  scheduleSummary: "Built-in description.",
  scoringRules: "Built-in scoring.",
  slices: [],
};

describe("applyRegattaEventCopy", () => {
  it("uses saved description and scoring when they are set", () => {
    const next = applyRegattaEventCopy(event, {
      scheduleSummary: "Updated knockout description.",
      scoringRules: "Updated prizes.",
    });
    expect(next.scheduleSummary).toBe("Updated knockout description.");
    expect(next.scoringRules).toBe("Updated prizes.");
    expect(next.name).toBe(event.name);
  });

  it("keeps the built-in wording when the saved text is blank", () => {
    const next = applyRegattaEventCopy(event, {
      scheduleSummary: "   ",
      scoringRules: null,
    });
    expect(next.scheduleSummary).toBe("Built-in description.");
    expect(next.scoringRules).toBe("Built-in scoring.");
  });

  it("returns the event unchanged when nothing is saved", () => {
    expect(applyRegattaEventCopy(event, null)).toBe(event);
  });
});
