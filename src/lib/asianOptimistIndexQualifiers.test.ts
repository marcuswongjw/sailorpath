import { describe, expect, it } from "vitest";
import {
  ASIAN_OPTIMIST_INDEX_2026_QUALIFIERS,
  formatAsianIndexDateRange,
} from "@/lib/asianOptimistIndexQualifiers";

describe("Asian Optimist Index 2026 qualifier ledger", () => {
  it("contains the two verified external sources and two direct Singapore sources", () => {
    expect(ASIAN_OPTIMIST_INDEX_2026_QUALIFIERS).toHaveLength(4);
    expect(
      ASIAN_OPTIMIST_INDEX_2026_QUALIFIERS.filter(
        (qualifier) => !qualifier.usesSailorPathResults
      )
    ).toHaveLength(2);
    expect(
      ASIAN_OPTIMIST_INDEX_2026_QUALIFIERS.filter(
        (qualifier) => qualifier.usesSailorPathResults
      )
    ).toHaveLength(2);
    expect(
      ASIAN_OPTIMIST_INDEX_2026_QUALIFIERS.map(
        (qualifier) => qualifier.resultCount
      )
    ).toEqual([59, 106, 65, 83]);
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
