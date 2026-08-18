import { describe, expect, it } from "vitest";
import {
  buildGenderAuditRows,
  formatGenderLabel,
  formatGenderLong,
  normalizeGender,
  suggestGenderFromName,
} from "./gender";

describe("normalizeGender", () => {
  it("accepts exact male/female tokens", () => {
    expect(normalizeGender("M")).toBe("M");
    expect(normalizeGender("male")).toBe("M");
    expect(normalizeGender("F")).toBe("F");
    expect(normalizeGender("Female")).toBe("F");
    expect(normalizeGender("girl")).toBe("F");
  });

  it("rejects ambiguous prefixes that used to become M/F", () => {
    expect(normalizeGender("mixed")).toBeNull();
    expect(normalizeGender("miss")).toBeNull();
    expect(normalizeGender("maiden")).toBeNull();
    expect(normalizeGender("first")).toBeNull();
  });

  it("treats empty / n/a as null", () => {
    expect(normalizeGender("")).toBeNull();
    expect(normalizeGender("n/a")).toBeNull();
    expect(normalizeGender(null)).toBeNull();
  });
});

describe("formatGenderLabel", () => {
  it("maps stored Male/Female strings for display", () => {
    expect(formatGenderLabel("Male")).toBe("M");
    expect(formatGenderLabel("FEMALE")).toBe("F");
    expect(formatGenderLabel("")).toBe("—");
    expect(formatGenderLong("m")).toBe("Male");
  });
});

describe("suggestGenderFromName / buildGenderAuditRows", () => {
  it("suggests F for Adele and flags conflict when stored as M", () => {
    expect(suggestGenderFromName("Chiang Ziyi Adele")).toBe("F");
    const rows = buildGenderAuditRows([
      {
        id: "1",
        name: "Chiang Ziyi Adele",
        gender: "M",
        club: "SAFYC",
      },
    ]);
    expect(rows[0]?.suggested).toBe("F");
    expect(rows[0]?.conflict).toBe(true);
  });
});
