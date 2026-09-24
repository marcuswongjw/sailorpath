import { describe, expect, it } from "vitest";
import {
  PUBLIC_RANKING_REGATTA_STATUS,
  filterPublicRankingRegattas,
  isPublicRankingRegattaStatus,
} from "./regattaStatus";

describe("isPublicRankingRegattaStatus", () => {
  it("accepts only published", () => {
    expect(isPublicRankingRegattaStatus("published")).toBe(true);
    expect(PUBLIC_RANKING_REGATTA_STATUS).toBe("published");
  });

  it("rejects draft, in_review, archived, and missing", () => {
    expect(isPublicRankingRegattaStatus("draft")).toBe(false);
    expect(isPublicRankingRegattaStatus("in_review")).toBe(false);
    expect(isPublicRankingRegattaStatus("archived")).toBe(false);
    expect(isPublicRankingRegattaStatus(null)).toBe(false);
    expect(isPublicRankingRegattaStatus(undefined)).toBe(false);
    expect(isPublicRankingRegattaStatus("")).toBe(false);
  });
});

describe("filterPublicRankingRegattas", () => {
  it("keeps only published rows", () => {
    const rows = [
      { id: "d", status: "draft" },
      { id: "r", status: "in_review" },
      { id: "p", status: "published" },
      { id: "a", status: "archived" },
      { id: "n", status: null },
    ];
    expect(filterPublicRankingRegattas(rows).map((x) => x.id)).toEqual(["p"]);
  });
});
