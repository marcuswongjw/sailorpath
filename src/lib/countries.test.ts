import { describe, expect, it } from "vitest";
import {
  isUnrecognizedCountry,
  normalizeGeography,
  normalizeNationalityCode,
  nationalitySelectOptions,
} from "./countries";

describe("normalizeGeography", () => {
  it("maps names and codes to ISO2", () => {
    expect(normalizeGeography("Singapore")).toBe("SG");
    expect(normalizeGeography("sg")).toBe("SG");
    expect(normalizeGeography("SGP")).toBe("SG");
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
