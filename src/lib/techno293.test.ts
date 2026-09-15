import { describe, expect, it } from "vitest";
import {
  parseTechno293RegattaDate,
  sortTechno293Regattas,
  normalizeTechno293SailorName,
  SINGAPORE_TECHNO293_REGATTAS,
  TECHNO293_SPECIFICATIONS,
  type Techno293Regatta,
} from "./techno293";

describe("Techno 293 data and utilities", () => {
  it("provides comprehensive class specifications", () => {
    expect(TECHNO293_SPECIFICATIONS.boardSpec).toContain("Bic Techno 293");
    expect(TECHNO293_SPECIFICATIONS.rigSizes).toContain("6.8 m²");
    expect(TECHNO293_SPECIFICATIONS.rigSizes).toContain("7.8 m²");
    expect(TECHNO293_SPECIFICATIONS.rigSizes).toContain("8.5 m²");
  });

  it("parses dates correctly for chronological sorting", () => {
    const oct = parseTechno293RegattaDate("10 - 11 October 2026");
    const aug = parseTechno293RegattaDate("29 - 30 August 2026");
    const jul = parseTechno293RegattaDate("11 - 12 July 2026");

    expect(oct).toBeGreaterThan(aug);
    expect(aug).toBeGreaterThan(jul);
  });

  it("sorts regattas in reverse chronological order (latest first)", () => {
    const sorted = sortTechno293Regattas(SINGAPORE_TECHNO293_REGATTAS);
    expect(sorted).toHaveLength(6);
    expect(sorted[0].shortName).toBe("SW Monsoon GP3");
    expect(sorted[1].shortName).toBe("SW Monsoon GP2");
    expect(sorted[2].shortName).toBe("SW Monsoon GP1");
    expect(sorted[3].shortName).toBe("NE Monsoon GP3");
    expect(sorted[4].shortName).toBe("NE Monsoon GP2");
    expect(sorted[5].shortName).toBe("NE Monsoon GP1");
  });

  it("normalizes sailor names accurately", () => {
    expect(normalizeTechno293SailorName("Trevor Ng")).toBe("trevor ng");
    expect(normalizeTechno293SailorName("Addy Armand Anuar")).toBe("addy armand anuar");
    expect(normalizeTechno293SailorName("  Eunice Yi Ning Tan  ")).toBe("eunice yi ning tan");
  });

  it("includes SW GP1 and GP2 completed official results", () => {
    const gp1 = SINGAPORE_TECHNO293_REGATTAS.find((r) => r.id === "techno-sw-gp1-2026");
    const gp2 = SINGAPORE_TECHNO293_REGATTAS.find((r) => r.id === "techno-sw-gp2-2026");

    expect(gp1).toBeDefined();
    expect(gp1?.status).toBe("Completed");
    expect(gp1?.results).toHaveLength(8);
    expect(gp1?.results?.[0].name).toBe("Trevor Ng");
    expect(gp1?.results?.[0].nettScore).toBe(9.0);

    expect(gp2).toBeDefined();
    expect(gp2?.status).toBe("Completed");
    expect(gp2?.results).toHaveLength(8);
    expect(gp2?.results?.[0].name).toBe("Trevor Ng");
    expect(gp2?.results?.[0].nettScore).toBe(10.0);
  });

  it("includes NE GP1, GP2, and GP3 completed official results", () => {
    const neGp1 = SINGAPORE_TECHNO293_REGATTAS.find((r) => r.id === "techno-ne-gp1-2026");
    const neGp2 = SINGAPORE_TECHNO293_REGATTAS.find((r) => r.id === "techno-ne-gp2-2026");
    const neGp3 = SINGAPORE_TECHNO293_REGATTAS.find((r) => r.id === "techno-ne-gp3-2026");

    expect(neGp1).toBeDefined();
    expect(neGp1?.status).toBe("Completed");
    expect(neGp1?.results).toHaveLength(8);
    expect(neGp1?.results?.[0].name).toBe("Trevor Ng");
    expect(neGp1?.results?.[0].races).toHaveLength(11);

    expect(neGp2).toBeDefined();
    expect(neGp2?.status).toBe("Completed");
    expect(neGp2?.results).toHaveLength(8);
    expect(neGp2?.results?.[0].name).toBe("Axl Tan");
    expect(neGp2?.results?.[0].races).toHaveLength(14);

    expect(neGp3).toBeDefined();
    expect(neGp3?.status).toBe("Completed");
    expect(neGp3?.results).toHaveLength(8);
    expect(neGp3?.results?.[0].name).toBe("Axl Tan");
    expect(neGp3?.results?.[0].races).toHaveLength(7);
  });
});
