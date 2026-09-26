import { describe, it, expect } from "vitest";
import { parseSearchQuery, CLUB_ABBREVIATIONS, SCHOOL_ABBREVIATIONS } from "./search";

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

  it("expands school abbreviations for RI, ACSI, RGS, SJI", () => {
    const resRi = parseSearchQuery("RI");
    expect(resRi.schoolExpansions).toContain("Raffles Institution");

    const resAcsi = parseSearchQuery("ACSI");
    expect(resAcsi.schoolExpansions).toContain("Anglo-Chinese School (Independent)");

    const resRgs = parseSearchQuery("RGS");
    expect(resRgs.schoolExpansions).toContain("Raffles Girls' School");

    const resSji = parseSearchQuery("SJI");
    expect(resSji.schoolExpansions).toContain("St. Joseph's Institution");
  });

  it("handles complex multi-term queries cleanly", () => {
    const res = parseSearchQuery("Kenan Tan SGP 1 SAFYC");
    expect(res.countryPrefix).toBe("SGP");
    expect(res.extractedSailNumber).toBe("1");
    expect(res.clubExpansions).toContain("SAF Yacht Club");
  });
});
