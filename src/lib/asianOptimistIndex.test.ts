import { describe, expect, it } from "vitest";
import {
  ASIAN_OPTIMIST_INDEX_EVENT,
  ASIAN_OPTIMIST_INDEX_SOURCE_ENTRIES,
  createAsianOptimistIndexBaseline,
} from "@/lib/asianOptimistIndex";

describe("Asian Optimist Index baseline", () => {
  it("contains the Asian sailors from the 2025 official final classification", () => {
    expect(ASIAN_OPTIMIST_INDEX_SOURCE_ENTRIES).toHaveLength(122);
    expect(ASIAN_OPTIMIST_INDEX_EVENT.totalFleetSize).toBe(170);
    expect(ASIAN_OPTIMIST_INDEX_SOURCE_ENTRIES[0]).toMatchObject({
      overallPlace: 1,
      sailNumber: "THA 1493",
      name: "Sorawit Naksuk",
      netPoints: 13,
    });
    expect(ASIAN_OPTIMIST_INDEX_SOURCE_ENTRIES.at(-1)).toMatchObject({
      overallPlace: 170,
      sailNumber: "SRI 203",
      name: "Ruwaneka Rajapaksa",
      netPoints: 320,
    });
  });

  it("gives Asian-only baseline ranks while preserving the official field finish", () => {
    const baseline = createAsianOptimistIndexBaseline();

    expect(baseline[0]).toMatchObject({ baselineRank: 1, overallPlace: 1 });
    expect(baseline[1]).toMatchObject({ baselineRank: 2, overallPlace: 2 });
    expect(baseline[2]).toMatchObject({ baselineRank: 3, overallPlace: 4 });
    expect(baseline.at(-1)).toMatchObject({ baselineRank: 122, overallPlace: 170 });
  });
});
