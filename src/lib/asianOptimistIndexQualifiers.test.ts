import { describe, expect, it } from "vitest";
import {
  ASIAN_OPTIMIST_INDEX_2026_QUALIFIERS,
  formatAsianIndexDateRange,
} from "@/lib/asianOptimistIndexQualifiers";

describe("Asian Optimist Index 2026 qualifier ledger", () => {
  it("keeps eleven verified inputs and one scheduled Thai candidate", () => {
    expect(ASIAN_OPTIMIST_INDEX_2026_QUALIFIERS).toHaveLength(12);
    expect(
      ASIAN_OPTIMIST_INDEX_2026_QUALIFIERS.filter(
        (qualifier) => !qualifier.usesSailorPathResults
      )
    ).toHaveLength(3);
    expect(
      ASIAN_OPTIMIST_INDEX_2026_QUALIFIERS.filter(
        (qualifier) => qualifier.usesSailorPathResults
      )
    ).toHaveLength(9);
    expect(
      ASIAN_OPTIMIST_INDEX_2026_QUALIFIERS.map(
        (qualifier) => qualifier.resultCount
      )
    ).toEqual([284, 292, 50, 59, 106, 65, 83, 77, 58, 45, 43, null]);
    expect(
      ASIAN_OPTIMIST_INDEX_2026_QUALIFIERS.find(
        (qualifier) => qualifier.id === "eastern-seaboard-regatta-2026"
      )
    ).toMatchObject({
      hostCountry: "Thailand",
      resultStatus: "scheduled",
      sailorPathRegattaSlug: null,
      startDate: "2026-10-29",
      endDate: "2026-10-31",
    });
  });

  it("renders inclusive source dates in a stable, timezone-safe form", () => {
    expect(formatAsianIndexDateRange("2026-02-08", "2026-02-12")).toBe(
      "8 Feb 2026–12 Feb 2026"
    );
    expect(formatAsianIndexDateRange("2026-03-14", "2026-03-14")).toBe(
      "14 Mar 2026"
    );
  });
});
