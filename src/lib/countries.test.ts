import { describe, expect, it } from "vitest";
import {
  extractNationalityFromSailNumber,
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
