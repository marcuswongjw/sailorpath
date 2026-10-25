import { describe, expect, it } from "vitest";
import { eventIcs } from "./eventIcs";

describe("regatta calendar download", () => {
  it("uses an exclusive UTC end date across month and year boundaries", () => {
    const content = eventIcs({ slug: "race", name: "Race", startDate: "2026-12-30", endDate: "2026-12-31" });
    expect(content).toContain("DTSTART;VALUE=DATE:20261230\r\nDTEND;VALUE=DATE:20270101");
    expect(eventIcs({ slug: "one", name: "One day", startDate: "2027-02-28" })).toContain("DTEND;VALUE=DATE:20270301");
  });
  it("rejects unknown, impossible and reversed dates", () => {
    for (const startDate of ["TBC", "2027-02-29", "2027-1-02"]) expect(eventIcs({ slug: "x", name: "X", startDate })).toBeNull();
    expect(eventIcs({ slug: "x", name: "X", startDate: "2027-02-02", endDate: "2027-02-01" })).toBeNull();
  });
  it("escapes calendar text and folds long Unicode lines by byte count", () => {
    const content = eventIcs({ slug: "race", name: "Race, A; B\nC", venue: "海".repeat(40), startDate: "2027-02-16" })!;
    expect(content).toContain("SUMMARY:Race\\, A\\; B\\nC");
    expect(content).toContain("\r\n ");
    expect(content.split("\r\n").every((line) => new TextEncoder().encode(line).length <= 75)).toBe(true);
  });
});
