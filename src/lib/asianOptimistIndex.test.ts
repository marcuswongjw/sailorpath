import { describe, expect, it } from "vitest";
import {
  ASIAN_OPTIMIST_INDEX_EVENT,
  ASIAN_OPTIMIST_INDEX_SOURCE_ENTRIES,
  createAsianOptimistIndexBaseline,
} from "@/lib/asianOptimistIndex";

describe("SailorPath Asian and Oceania Optimist Index baseline", () => {
  it("contains the Asian and Oceanian sailors from verified international championships", () => {
    expect(ASIAN_OPTIMIST_INDEX_SOURCE_ENTRIES).toHaveLength(176);
    expect(ASIAN_OPTIMIST_INDEX_EVENT.totalFleetSize).toBe(170);
    expect(ASIAN_OPTIMIST_INDEX_SOURCE_ENTRIES[0]).toMatchObject({
      overallPlace: 1,
      sailNumber: "THA 1493",
      name: "Sorawit Naksuk",
      netPoints: 13,
    });
    expect(ASIAN_OPTIMIST_INDEX_SOURCE_ENTRIES[135]).toMatchObject({
      overallPlace: 170,
      sailNumber: "SRI 203",
      name: "Ruwaneka Rajapaksa",
      netPoints: 320,
    });
    expect(ASIAN_OPTIMIST_INDEX_SOURCE_ENTRIES.at(-1)).toMatchObject({
      overallPlace: null,
      sailNumber: "THA 1888",
      name: "PUNTHITA WEROTJANAKUL",
    });
  });

  it("gives baseline ranks while preserving the official field finish for age-eligible competitors", () => {
    const baseline = createAsianOptimistIndexBaseline();

    expect(baseline).toHaveLength(163);
    expect(baseline[0]).toMatchObject({ baselineRank: 1, overallPlace: 1 });
    // Ethan Chia (2010) is aged out (>15), so baseline[1] is Anya Zahedi (overallPlace: 4)
    expect(baseline[1]).toMatchObject({ baselineRank: 2, overallPlace: 4 });
    expect(baseline.every((entry) => entry.birthYear == null || entry.birthYear > 2010)).toBe(true);
  });

  it("preserves the complete 175-sailor founding baseline when includeOveraged is enabled", () => {
    const baseline = createAsianOptimistIndexBaseline({ includeOveraged: true });

    expect(baseline).toHaveLength(175);
    expect(baseline[0]).toMatchObject({ baselineRank: 1, overallPlace: 1 });
    expect(baseline[1]).toMatchObject({ baselineRank: 2, overallPlace: 2 });
    expect(baseline[2]).toMatchObject({ baselineRank: 3, overallPlace: 4 });
    expect(baseline[135]).toMatchObject({ baselineRank: 136, overallPlace: 170 });
    expect(baseline.at(-1)).toMatchObject({ baselineRank: 176, overallPlace: null });
  });

  it("links every founding sailor to the persisted SailorPath profile handle", () => {
    const baseline = createAsianOptimistIndexBaseline({ includeOveraged: true });

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
