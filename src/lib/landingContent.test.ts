import { describe, expect, it } from "vitest";
import type { RegattaRecord } from "./ranking";
import { recentLandingResults, upcomingLandingEvents, landingResultStatus, landingCountry } from "./landingContent";

const row = (extra: Partial<RegattaRecord>): RegattaRecord => ({ id: "one", slug: "one", name: "Regatta", date: "2026-10-22", totalFleetSize: 10, raceCount: 3, ...extra });

describe("landing event selection", () => {
  it("includes scored events ending today while excluding tomorrow, empty and unscored tables", () => {
    const rows = [row({ id: "today" }), row({id: "tomorrow", date: "2026-10-23"}), row({id:"empty"}), row({id:"unscored",raceCount:0})];
    expect(recentLandingResults(rows,"2026-10-22",{today:10,tomorrow:10,empty:0,unscored:10}).map(r=>r.id)).toEqual(["today"]);
  });
  it("includes ongoing calendar events and excludes ended events without requiring results", () => {
    const rows = [row({id:"future",date:"2026-10-24",raceCount:0}),row({id:"ongoing",date:"2026-10-21",endDate:"2026-10-23",raceCount:0}),row({id:"ended",date:"2026-10-20"})];
    expect(upcomingLandingEvents(rows,"2026-10-22").map(r=>r.id)).toEqual(["ongoing","future"]);
  });
  it("does not equate review with final source status", () => {
    expect(landingResultStatus(row({}))).toBe("Reviewed");
    expect(landingResultStatus(row({scheduleNotes:"Official source status: provisional."}))).toBe("Provisional");
    expect(landingResultStatus(row({scheduleNotes:"Official source status: final."}))).toBe("Final");
  });
  it("normalises legacy Singapore country codes", () => {
    expect(landingCountry(row({geography:"SG"}))).toBe("Singapore");
    expect(landingCountry(row({geography:"SGP"}))).toBe("Singapore");
  });
});
