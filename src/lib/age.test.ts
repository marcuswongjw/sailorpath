import { describe, expect, it } from "vitest";
import { ageYears, birthYear } from "./age";

describe("ageYears", () => {
  it("returns null for missing/invalid", () => {
    expect(ageYears(null)).toBeNull();
    expect(ageYears("")).toBeNull();
    expect(ageYears("not-a-date")).toBeNull();
  });

  it("computes whole years", () => {
    const asOf = new Date("2026-07-21T12:00:00");
    expect(ageYears("2013-07-21", asOf)).toBe(13);
    expect(ageYears("2013-07-22", asOf)).toBe(12);
    expect(ageYears("2013-01-01", asOf)).toBe(13);
  });
});

describe("birthYear", () => {
  it("extracts calendar year", () => {
    expect(birthYear("2013-07-21")).toBe(2013);
    expect(birthYear(null)).toBeNull();
  });
});
