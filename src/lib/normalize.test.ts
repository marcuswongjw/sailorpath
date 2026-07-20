import { describe, expect, it } from "vitest";
import {
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

  it("normalizeOptionalText", () => {
    expect(normalizeOptionalText("  Foo ")).toBe("Foo");
    expect(normalizeOptionalText("-")).toBeNull();
  });

  it("normalizeDob year-only and ISO", () => {
    expect(normalizeDob(2013)).toBe("2013-01-01");
    expect(normalizeDob("2013-05-12")).toBe("2013-05-12");
  });

  it("excelDateToIso", () => {
    expect(excelDateToIso("2026-07-01")).toBe("2026-07-01");
  });
});
