import { describe, expect, it } from "vitest";
import {
  CACHE_TAG_FLEET_RANKINGS,
  CACHE_TAG_ILCA_RANKINGS,
  CACHE_TAG_PUBLIC_REGATTAS,
  PUBLIC_RANKING_CACHE_TAGS,
} from "./cacheTags";

describe("cacheTags", () => {
  it("exports stable public ranking tags", () => {
    expect(CACHE_TAG_FLEET_RANKINGS).toBe("fleet-rankings");
    expect(CACHE_TAG_ILCA_RANKINGS).toBe("ilca-rankings");
    expect(CACHE_TAG_PUBLIC_REGATTAS).toBe("public-regattas");
    expect(PUBLIC_RANKING_CACHE_TAGS).toEqual([
      CACHE_TAG_FLEET_RANKINGS,
      CACHE_TAG_ILCA_RANKINGS,
      CACHE_TAG_PUBLIC_REGATTAS,
    ]);
  });
});
