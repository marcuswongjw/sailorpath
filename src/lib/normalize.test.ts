import { describe, expect, it } from "vitest";
import {
  cleanOptimistSailNumber,
  excelDateToIso,
  normalizeDob,
  normalizeOptionalText,
  normalizeSailNumber,
  normalizeSailorName,
  optimistSailNumberForProfile,
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

  it("keeps a blank Optimist sail blank on a profile save", () => {
    expect(optimistSailNumberForProfile("")).toBe("");
    expect(optimistSailNumberForProfile("   ")).toBe("");
    expect(optimistSailNumberForProfile(null)).toBe("");
    expect(optimistSailNumberForProfile("SGP 3029")).toBe("3029");
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

  describe("normalizeSailorName", () => {
    it("converts all-caps names to title case", () => {
      expect(normalizeSailorName("ANDRE BAOU MARTIN")).toBe("Andre Baou Martin");
      expect(normalizeSailorName("ASHER LOW")).toBe("Asher Low");
      expect(normalizeSailorName("CHLOE KONG")).toBe("Chloe Kong");
      expect(normalizeSailorName("PROUD PARINTARAKUL")).toBe("Proud Parintarakul");
      expect(normalizeSailorName("XU JIAYAN")).toBe("Xu Jiayan");
    });

    it("respects Malay/Singaporean patronymics and abbreviations", () => {
      expect(normalizeSailorName("AMZAR SYAABAN BIN MOHD NOOR AZMAN")).toBe(
        "Amzar Syaaban Bin Mohd Noor Azman"
      );
      expect(normalizeSailorName("NUR AMNI IRDINA BINTI NORHISAM")).toBe(
        "Nur Amni Irdina Binti Norhisam"
      );
      expect(normalizeSailorName("AHMAD IRFAN DANIAL B. AHMAD ZULMA")).toBe(
        "Ahmad Irfan Danial b. Ahmad Zulma"
      );
      expect(normalizeSailorName("HANIS NAJIHAH BT YUSRI HERMAN")).toBe(
        "Hanis Najihah bt Yusri Herman"
      );
      expect(normalizeSailorName("IRFAN YUSRAN BIN MD SAID")).toBe(
        "Irfan Yusran Bin Md Said"
      );
      expect(normalizeSailorName("MUHD AIMAN BIN MANGSOR")).toBe(
        "Muhd Aiman Bin Mangsor"
      );
    });

    it("handles hyphenated and apostrophe names", () => {
      expect(normalizeSailorName("NATTHANAN CHAIYA-O-CHA")).toBe(
        "Natthanan Chaiya-o-Cha"
      );
      expect(normalizeSailorName("NURUL 'AFIYA BINTE MOHAMED SHAHROM")).toBe(
        "Nurul 'Afiya Binte Mohamed Shahrom"
      );
    });

    it("capitalizes accidental all-lowercase words while respecting particles", () => {
      expect(normalizeSailorName("faith ng")).toBe("Faith Ng");
      expect(normalizeSailorName("Hayden tan")).toBe("Hayden Tan");
      expect(normalizeSailorName("Abigail Wut Yi chiang")).toBe("Abigail Wut Yi Chiang");
      expect(normalizeSailorName("Dani Pieter Mahmoud van Olphen")).toBe("Dani Pieter Mahmoud van Olphen");
      expect(normalizeSailorName("de Silva")).toBe("De Silva");
    });

    it("leaves already-properly-cased names untouched", () => {
      expect(normalizeSailorName("Ryan Lo Jun Han")).toBe("Ryan Lo Jun Han");
      expect(normalizeSailorName("HoYeung Choi")).toBe("HoYeung Choi");
      expect(normalizeSailorName("McDonald")).toBe("McDonald");
    });

    it("handles empty or nullish values gracefully", () => {
      expect(normalizeSailorName("")).toBe("");
      expect(normalizeSailorName(null)).toBe("");
      expect(normalizeSailorName(undefined)).toBe("");
    });
  });
});
