import { describe, expect, it } from "vitest";
import {
  cleanOptimistSailNumber,
  excelDateToIso,
  normalizeDob,
  normalizeOptionalText,
  normalizeSailNumber,
  toNumber,
} from "./normalize";

describe("normalize helpers", () => {
  it("toNumber handles commas", () => {
    expect(toNumber("1,234.5")).toBe(1234.5);
    expect(toNumber("")).toBeNull();
  });

  it("normalizeSailNumber drops placeholders", () => {
    expect(normalizeSailNumber("SGP 123")).toBe("SGP 123");
    expect(normalizeSailNumber("N/A")).toBeNull();
  });

  it("cleanOptimistSailNumber strips letters and keeps only digits", () => {
    expect(cleanOptimistSailNumber("SGP3029")).toBe("3029");
    expect(cleanOptimistSailNumber("SGP 3029")).toBe("3029");
    expect(cleanOptimistSailNumber("SGP-3029")).toBe("3029");
    expect(cleanOptimistSailNumber("3029")).toBe("3029");
    expect(cleanOptimistSailNumber("SIN 4639")).toBe("4639");
    expect(cleanOptimistSailNumber("HKG 123")).toBe("123");
    expect(cleanOptimistSailNumber("INA-456")).toBe("456");
    expect(cleanOptimistSailNumber("SGP 07")).toBe("7");
    expect(cleanOptimistSailNumber("SGP 000")).toBe("0");
    expect(cleanOptimistSailNumber("SGP 0")).toBe("0");
    expect(cleanOptimistSailNumber("0")).toBe("0");
    expect(cleanOptimistSailNumber("")).toBe("0");
    expect(cleanOptimistSailNumber(null)).toBe("0");
    expect(cleanOptimistSailNumber("N/A")).toBe("0");
  });

  it("normalizeOptionalText", () => {
    expect(normalizeOptionalText("  Foo ")).toBe("Foo");
    expect(normalizeOptionalText("-")).toBeNull();
  });

  it("normalizeDob year-only and ISO", () => {
    expect(normalizeDob(2013)).toBe("2013-01-01");
    expect(normalizeDob("2013-05-12")).toBe("2013-05-12");
  });

  it("normalizeDob parses DD/MM/YYYY consistently", () => {
    expect(normalizeDob("02/03/2013")).toBe("2013-03-02");
    expect(normalizeDob("15/03/2013")).toBe("2013-03-15");
    expect(normalizeDob("2/3/2013")).toBe("2013-03-02");
  });

  it("excelDateToIso parses DD/MM/YYYY and ISO", () => {
    expect(excelDateToIso("2026-07-01")).toBe("2026-07-01");
    expect(excelDateToIso("02/03/2013")).toBe("2013-03-02");
  });
});
