import { describe, expect, it } from "vitest";
import type { RegattaRecord } from "./ranking";
import {
  recentLandingResults,
  distinctRecentLandingResults,
  landingAdditionalFleetCount,
  landingRegattaName,
  upcomingLandingEvents,
  landingResultStatus,
  landingCountry,
} from "./landingContent";

const row = (extra: Partial<RegattaRecord>): RegattaRecord => ({ id: "one", slug: "one", name: "Regatta", date: "2026-10-22", totalFleetSize: 10, raceCount: 3, ...extra });

describe("landing event selection", () => {
  it("includes scored events ending today while excluding tomorrow, empty and unscored tables", () => {
    const rows = [row({ id: "today" }), row({id: "tomorrow", date: "2026-10-23"}), row({id:"empty"}), row({id:"unscored",raceCount:0})];
    expect(recentLandingResults(rows,"2026-10-22",{today:10,tomorrow:10,empty:0,unscored:10}).map(r=>r.id)).toEqual(["today"]);
  });
  it("deduplicates sibling fleet sheets from the same parent regatta event across the 3 featured slots", () => {
    const rows = [
      row({ id: "es-gold", slug: "es-gold", name: "Eastern Seaboard — Optimist Gold", date: "2026-11-01", endDate: "2026-11-01", eventSlug: "eastern-seaboard-2026" }),
      row({ id: "es-silver", slug: "es-silver", name: "Eastern Seaboard — Optimist Silver", date: "2026-11-01", endDate: "2026-11-01", eventSlug: "eastern-seaboard-2026" }),
      row({ id: "es-ilca4", slug: "es-ilca4", name: "Eastern Seaboard — ILCA 4", date: "2026-11-01", endDate: "2026-11-01", eventSlug: "eastern-seaboard-2026" }),
      row({ id: "aus-ilca", slug: "aus-ilca", name: "Australian ILCA Championships", date: "2026-10-28", endDate: "2026-10-28", eventSlug: "aus-ilca-2026" }),
      row({ id: "ag-2026", slug: "ag-2026", name: "20th Asian Games Sailing", date: "2026-10-03", endDate: "2026-10-03", eventSlug: "asian-games-2026" }),
    ];
    const featured = distinctRecentLandingResults(rows, "2026-11-02", undefined, 3);
    expect(featured.map((r) => r.id)).toEqual(["es-ilca4", "aus-ilca", "ag-2026"]);
    const scored = recentLandingResults(rows, "2026-11-02");
    expect(landingAdditionalFleetCount(featured[0], scored, rows)).toBe(2);
    expect(landingAdditionalFleetCount(featured[1], scored, rows)).toBe(0);
  });
  it("includes ongoing calendar events and excludes ended events without requiring results", () => {
    const rows = [row({id:"future",date:"2026-10-24",raceCount:0}),row({id:"ongoing",date:"2026-10-21",endDate:"2026-10-23",raceCount:0}),row({id:"ended",date:"2026-10-20"})];
    expect(upcomingLandingEvents(rows,"2026-10-22").map(r=>r.id)).toEqual(["ongoing","future"]);
  });
  it("does not equate review with final source status", () => {
    expect(landingResultStatus(row({}))).toBe("Final status not confirmed");
    expect(landingResultStatus(row({scheduleNotes:"Official source status: provisional."}))).toBe("Provisional");
    expect(landingResultStatus(row({scheduleNotes:"Official source status: final."}))).toBe("Final");
  });
  it("normalises legacy Singapore country codes", () => {
    expect(landingCountry(row({geography:"SG"}))).toBe("Singapore");
    expect(landingCountry(row({geography:"SGP"}))).toBe("Singapore");
  });
  it("strips class and fleet suffixes from recent regatta result titles", () => {
    expect(landingRegattaName({ name: "18th Eastern Seaboard Regatta 2026 — ILCA 4" })).toBe(
      "18th Eastern Seaboard Regatta 2026",
    );
    expect(landingRegattaName({ name: "2026 ACT Optimist Championship — Intermediate Fleet" })).toBe(
      "2026 ACT Optimist Championship",
    );
    expect(landingRegattaName({ name: "HKODA Open and National Championships 2026 — Optimist Main" })).toBe(
      "HKODA Open and National Championships 2026",
    );
    expect(landingRegattaName({ name: "20th Asian Games 2026 (ILCA 6)" })).toBe(
      "20th Asian Games 2026",
    );
  });
});
