import { describe, expect, it } from "vitest";
import {
  compareYmd,
  periodHalfFromYmd,
  toYmd,
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
});
