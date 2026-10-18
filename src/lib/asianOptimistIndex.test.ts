import { describe, expect, it } from "vitest";
import {
  ASIAN_OPTIMIST_INDEX_EVENT,
  ASIAN_OPTIMIST_INDEX_SOURCE_ENTRIES,
  createAsianOptimistIndexBaseline,
} from "@/lib/asianOptimistIndex";

describe("SailorPath Asian and Oceania Optimist Index baseline", () => {
  it("contains the Asian and Oceanian sailors from the 2025 official final classification", () => {
    expect(ASIAN_OPTIMIST_INDEX_SOURCE_ENTRIES).toHaveLength(136);
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

  it("gives baseline ranks while preserving the official field finish", () => {
    const baseline = createAsianOptimistIndexBaseline();

    expect(baseline[0]).toMatchObject({ baselineRank: 1, overallPlace: 1 });
    expect(baseline[1]).toMatchObject({ baselineRank: 2, overallPlace: 2 });
    expect(baseline[2]).toMatchObject({ baselineRank: 3, overallPlace: 4 });
    expect(baseline.at(-1)).toMatchObject({ baselineRank: 136, overallPlace: 170 });
  });

  it("links every founding sailor to the persisted SailorPath profile handle", () => {
    const baseline = createAsianOptimistIndexBaseline();

    expect(baseline.every((entry) => entry.profileHref?.startsWith("/"))).toBe(true);
    expect(baseline.find((entry) => entry.name === "Sorawit Naksuk")).toMatchObject({
      profileHref: "/sorawit-naksuk-812d4t4",
    });
    expect(baseline.find((entry) => entry.name === "Ethan Chia")).toMatchObject({
      profileHref: "/ethan-chia-han-wei",
      profileReview: null,
      displayName: "Ethan Chia Han Wei",
      nationality: "SGP",
      gender: "M",
      birthYear: 2010,
    });
    expect(baseline.find((entry) => entry.name === "Lin Shi")).toMatchObject({
      profileHref: "/shi-lin-vysogv7",
      profileReview: null,
      displayName: "Shi Lin",
    });
    expect(baseline.find((entry) => entry.name === "Suthinan Nakpasom")).toMatchObject({
      birthYear: 2012,
    });
  });
});
