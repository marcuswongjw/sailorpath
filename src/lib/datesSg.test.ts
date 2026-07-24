import { describe, expect, it } from "vitest";
import {
  compareYmd,
  halfBoundaryOptions,
  isHalfBoundaryYmd,
  periodHalfFromYmd,
  toYmd,
  validateHalfBoundaryDate,
  ymdInRange,
} from "./datesSg";

describe("datesSg", () => {
  it("toYmd keeps ISO date-only", () => {
    expect(toYmd("2026-06-30")).toBe("2026-06-30");
    expect(toYmd("2026-07-01T00:00:00.000Z")?.startsWith("2026-0")).toBe(true);
  });

  it("compareYmd is lexicographic", () => {
    expect(compareYmd("2026-06-30", "2026-07-01")).toBeLessThan(0);
    expect(compareYmd("2026-06-30", "2026-06-30")).toBe(0);
  });

  it("ymdInRange inclusive", () => {
    expect(ymdInRange("2026-06-30", "2026-01-01", "2026-06-30")).toBe(true);
    expect(ymdInRange("2026-07-01", "2026-01-01", "2026-06-30")).toBe(false);
  });

  it("periodHalfFromYmd", () => {
    expect(periodHalfFromYmd("2026-06-30")).toEqual({
      year: 2026,
      half: "Jan-Jun",
    });
    expect(periodHalfFromYmd("2026-07-01")).toEqual({
      year: 2026,
      half: "Jul-Dec",
    });
  });

  it("isHalfBoundaryYmd allows only 1 Jan and 1 Jul", () => {
    expect(isHalfBoundaryYmd("2026-01-01")).toBe(true);
    expect(isHalfBoundaryYmd("2026-07-01")).toBe(true);
    expect(isHalfBoundaryYmd("2026-06-30")).toBe(false);
    expect(isHalfBoundaryYmd("2026-03-15")).toBe(false);
    expect(isHalfBoundaryYmd(null)).toBe(false);
  });

  it("validateHalfBoundaryDate", () => {
    expect(validateHalfBoundaryDate(null)).toBeNull();
    expect(validateHalfBoundaryDate("")).toBeNull();
    expect(validateHalfBoundaryDate("2026-01-01")).toBeNull();
    expect(validateHalfBoundaryDate("2026-07-01")).toBeNull();
    expect(validateHalfBoundaryDate("2026-06-30", "Drop date")).toMatch(
      /1 Jan or 1 Jul/
    );
  });

  it("halfBoundaryOptions include boundaries", () => {
    const opts = halfBoundaryOptions(2025, 2026);
    const values = opts.map((o) => o.value);
    expect(values).toContain("2026-01-01");
    expect(values).toContain("2026-07-01");
    expect(values).toContain("2025-01-01");
    expect(values.every((v) => isHalfBoundaryYmd(v))).toBe(true);
  });
});
