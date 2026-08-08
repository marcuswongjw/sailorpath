import { describe, expect, it } from "vitest";
import { parseRegattaTitle } from "./parseRegattaTitle";

describe("parseRegattaTitle", () => {
  it("parses YYYYMMDD + name + Gold", () => {
    const p = parseRegattaTitle("20230429 SAFYC Gold.xlsx");
    expect(p.date).toBe("2023-04-29");
    expect(p.name).toBe("SAFYC Gold (Apr 23)");
    expect(p.division).toBe("Gold");
  });

  it("parses underscores and Silver", () => {
    const p = parseRegattaTitle("20230429_CSC_Silver");
    expect(p.date).toBe("2023-04-29");
    expect(p.name).toBe("CSC Silver (Apr 23)");
    expect(p.division).toBe("Silver");
  });

  it("parses ISO-style date", () => {
    const p = parseRegattaTitle("2023-04-29 SAFYC Gold");
    expect(p.date).toBe("2023-04-29");
    expect(p.name).toBe("SAFYC Gold (Apr 23)");
  });

  it("parses trailing date", () => {
    const p = parseRegattaTitle("SAFYC Gold 20230429");
    expect(p.date).toBe("2023-04-29");
    expect(p.name).toBe("SAFYC Gold (Apr 23)");
  });

  it("detects ILCA 4 class", () => {
    const p = parseRegattaTitle("20240615 National ILCA 4");
    expect(p.date).toBe("2024-06-15");
    expect(p.boatClass).toBe("ILCA 4");
    expect(p.name).toBe("National ILCA 4 (Jun 24)");
  });
});
