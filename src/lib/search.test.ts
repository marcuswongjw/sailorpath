import { readFileSync } from "node:fs";
import { describe, it, expect } from "vitest";
import { limitSearchResults, parseSearchQuery } from "./search";

const source = readFileSync(new URL("./search.ts", import.meta.url), "utf8");

describe("parseSearchQuery", () => {
  it("extracts sail number and country prefix from SGP 4652", () => {
    const res = parseSearchQuery("SGP 4652");
    expect(res.countryPrefix).toBe("SGP");
    expect(res.extractedSailNumber).toBe("4652");
  });

  it("extracts sail number from SGP4652 without space", () => {
    const res = parseSearchQuery("SGP4652");
    expect(res.countryPrefix).toBe("SGP");
    expect(res.extractedSailNumber).toBe("4652");
  });

  it("extracts sail number from SIN-3133", () => {
    const res = parseSearchQuery("SIN-3133");
    expect(res.countryPrefix).toBe("SIN");
    expect(res.extractedSailNumber).toBe("3133");
  });

  it("extracts pure digit sail number", () => {
    const res = parseSearchQuery("224245");
    expect(res.extractedSailNumber).toBe("224245");
  });

  it("expands club abbreviations for CSC and SAFYC", () => {
    const resCsc = parseSearchQuery("Lucas CSC");
    expect(resCsc.clubExpansions).toContain("Changi Sailing Club");

    const resSaf = parseSearchQuery("SAFYC");
    expect(resSaf.clubExpansions).toContain("SAF Yacht Club");
  });

  it("does not add private-field expansions", () => {
    const resRi = parseSearchQuery("RI");
    expect(resRi.clubExpansions).toEqual([]);
  });

  it("handles complex multi-term queries cleanly", () => {
    const res = parseSearchQuery("Kenan Tan SGP 1 SAFYC");
    expect(res.countryPrefix).toBe("SGP");
    expect(res.extractedSailNumber).toBe("1");
    expect(res.clubExpansions).toContain("SAF Yacht Club");
  });
});

describe("limitSearchResults", () => {
  it("returns the full roster unless a caller sets a finite limit", () => {
    expect(limitSearchResults([1, 2, 3])).toEqual([1, 2, 3]);
    expect(limitSearchResults([1, 2, 3], undefined)).toEqual([1, 2, 3]);
    expect(limitSearchResults([1, 2, 3], Number.NaN)).toEqual([1, 2, 3]);
    expect(limitSearchResults([1, 2, 3], 2)).toEqual([1, 2]);
    expect(limitSearchResults([1, 2, 3], 0)).toEqual([]);
    expect(source).not.toContain("f.limit ?? 500");
    const directory = readFileSync(new URL("../app/sailors/page.tsx", import.meta.url), "utf8");
    expect(directory).not.toContain("limit: 500");
  });
});

describe("public search projection", () => {
  it("caches one minimal public sailor directory for all public filters", () => {
    expect(source).toContain("getCachedSearchSailorDirectory()");
    expect(source).toContain("sailorMatchesPublicSearch");
    expect(source).not.toContain(".where(and(...conditions))");
  });

  it("does not read or filter private school, squad, DOB, weight, or equipment fields", () => {
    const projection = source.slice(
      source.indexOf("const searchSailorColumns"),
      source.indexOf("const getCachedSearchSailorDirectory")
    );
    for (const privateField of [
      "school:",
      "nationalSquadStatus:",
      "dob:",
      "weight:",
      "equipmentNotes:",
    ]) {
      expect(projection).not.toContain(privateField);
    }
    expect(source).not.toContain("SCHOOL_ABBREVIATIONS");
    expect(source).not.toContain("birthYearFrom");
    expect(source).not.toContain("birthYearTo");
    expect(source).not.toContain("squad:");
  });

  it("uses the published regatta cache instead of querying draft rows during public search", () => {
    expect(source).toContain("getCachedPublicRegattas()");
    expect(source).not.toContain("from(regattas)");
  });
});
