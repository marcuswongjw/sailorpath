import { describe, expect, it } from "vitest";
import {
  extractNationalityFromSailNumber,
  formatSailNumber,
  isUnrecognizedCountry,
  nationalityFromSailNumber,
  normalizeGeography,
  normalizeNationalityCode,
  nationalitySelectOptions,
} from "./countries";

describe("normalizeGeography", () => {
  it("maps names and codes to NOC-style", () => {
    expect(normalizeGeography("Singapore")).toBe("SGP");
    expect(normalizeGeography("sg")).toBe("SGP");
    expect(normalizeGeography("SGP")).toBe("SGP");
    expect(normalizeGeography("Malaysia")).toBe("MAS");
    expect(normalizeGeography("Morocco")).toBe("MAR");
    expect(normalizeGeography("MA")).toBe("MAR");
    expect(nationalitySelectOptions()).toContainEqual({ code: "MAR", name: "Morocco" });
  });
});

describe("normalizeNationalityCode", () => {
  it("maps to NOC codes", () => {
    expect(normalizeNationalityCode("Singapore")).toBe("SGP");
    expect(normalizeNationalityCode("SG")).toBe("SGP");
    expect(normalizeNationalityCode("Malaysia")).toBe("MAS");
    expect(normalizeNationalityCode("THA")).toBe("THA");
  });
});

describe("isUnrecognizedCountry", () => {
  it("flags garbage free text", () => {
    expect(isUnrecognizedCountry("SGP")).toBe(false);
    expect(isUnrecognizedCountry("Singapore")).toBe(false);
    expect(isUnrecognizedCountry("Planet Mars")).toBe(true);
  });
});

describe("nationalitySelectOptions", () => {
  it("lists SGP first", () => {
    const opts = nationalitySelectOptions();
    expect(opts[0]?.code).toBe("SGP");
    expect(opts.length).toBeGreaterThan(100);
  });
});

describe("nationalityFromSailNumber", () => {
  it("parses leading NOC from sail numbers", () => {
    expect(nationalityFromSailNumber("SGP 115")).toBe("SGP");
    expect(nationalityFromSailNumber("SGP115")).toBe("SGP");
    expect(nationalityFromSailNumber("MAS-42")).toBe("MAS");
    expect(nationalityFromSailNumber("AUS 2001")).toBe("AUS");
    expect(nationalityFromSailNumber("SIN 1")).toBe("SGP");
  });

  it("returns null without a country prefix", () => {
    expect(nationalityFromSailNumber("115")).toBe(null);
    expect(nationalityFromSailNumber("")).toBe(null);
    expect(nationalityFromSailNumber(null)).toBe(null);
  });
});

describe("extractNationalityFromSailNumber", () => {
  it("extracts nationality from prefix, glued, and embedded tokens", () => {
    expect(extractNationalityFromSailNumber("SGP3029")).toBe("SGP");
    expect(extractNationalityFromSailNumber("SGP 3029")).toBe("SGP");
    expect(extractNationalityFromSailNumber("SGP-3029")).toBe("SGP");
    expect(extractNationalityFromSailNumber("SIN 4639")).toBe("SGP");
    expect(extractNationalityFromSailNumber("HKG 123")).toBe("HKG");
    expect(extractNationalityFromSailNumber("INA-456")).toBe("INA");
    expect(extractNationalityFromSailNumber("3029 SGP")).toBe("SGP");
  });

  it("returns null for pure numbers", () => {
    expect(extractNationalityFromSailNumber("3029")).toBe(null);
    expect(extractNationalityFromSailNumber("0")).toBe(null);
    expect(extractNationalityFromSailNumber("")).toBe(null);
    expect(extractNationalityFromSailNumber(null)).toBe(null);
  });
});

describe("formatSailNumber", () => {
  it("formats William Handley as NZL 4818 (not SGP NZL 4818)", () => {
    expect(formatSailNumber("NZL 4818", "NZL")).toBe("NZL 4818");
    expect(formatSailNumber("SGP NZL 4818", "NZL")).toBe("NZL 4818");
    expect(formatSailNumber("NZL4818", "NZL")).toBe("NZL 4818");
  });

  it("formats Andre Baou Martin as MAS 1024 (not SGP 1024)", () => {
    expect(formatSailNumber("1024", "MAS")).toBe("MAS 1024");
    expect(formatSailNumber("SGP 1024", "MAS")).toBe("MAS 1024");
    expect(formatSailNumber("MAS 1024", "MAS")).toBe("MAS 1024");
  });

  it("formats Claire Bao as NZL 4811 (not SGP NZL 4811)", () => {
    expect(formatSailNumber("NZL 4811", "NZL")).toBe("NZL 4811");
    expect(formatSailNumber("SGP NZL 4811", "NZL")).toBe("NZL 4811");
    expect(formatSailNumber("4811", "NZL")).toBe("NZL 4811");
  });

  it("formats Singapore sailors with SGP prefix", () => {
    expect(formatSailNumber("4508", "SGP")).toBe("SGP 4508");
    expect(formatSailNumber("SGP 4508", "SGP")).toBe("SGP 4508");
    expect(formatSailNumber("SGP4508", "Singapore")).toBe("SGP 4508");
    expect(formatSailNumber("SIN 4508", "SGP")).toBe("SGP 4508");
    expect(formatSailNumber("4508", null)).toBe("SGP 4508");
  });

  it("normalizes other nationalities and formats with country code", () => {
    expect(formatSailNumber("1794", "THA")).toBe("THA 1794");
    expect(formatSailNumber("HKG253", "HKG")).toBe("HKG 253");
    expect(formatSailNumber("253", "Hong Kong")).toBe("HKG 253");
    expect(formatSailNumber("10", "MYA")).toBe("MYA 10");
  });

  it("returns empty string for empty, zero, or placeholder sail numbers", () => {
    expect(formatSailNumber("0", "SGP")).toBe("");
    expect(formatSailNumber("", "SGP")).toBe("");
    expect(formatSailNumber(null, "SGP")).toBe("");
    expect(formatSailNumber(undefined, "SGP")).toBe("");
    expect(formatSailNumber("-", "SGP")).toBe("");
    expect(formatSailNumber("N/A", "SGP")).toBe("");
    expect(formatSailNumber("NONE4", null)).toBe("");
    expect(formatSailNumber("TBD", "CHN")).toBe("");
  });
});
