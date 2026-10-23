import { describe, expect, it } from "vitest";
import { directoryFilters, directoryHref, directoryPage } from "./sailorDirectory";

describe("directory page links", () => {
  it.each([undefined, "0", "-1", "2.5", "NaN", "Infinity", "9007199254740992"])("defaults invalid page %s to the start", (page) => {
    expect(directoryPage(Array.from({ length: 65 }), page).page).toBe(1);
  });
  it("keeps empty pages valid and bounded", () => {
    expect(directoryPage([], "9")).toMatchObject({ page: 1, pageCount: 1, total: 0, start: 0, end: 0, rows: [] });
  });
  it("encodes query terms and drops unsupported filters", () => {
    const filters = directoryFilters({ q: " Ana & Lee ", fleet: "unknown", club: " A/B " });
    expect(directoryHref(filters, 2)).toBe("/sailors?q=Ana+%26+Lee&club=A%2FB&page=2");
  });
  it("accepts legacy fleet links and repeated query parameters", () => {
    expect(directoryFilters({ q: [" Ana ", "Lee"], fleet: "ilca4" })).toMatchObject({ query: "Ana", fleet: "ilca" });
    expect(directoryFilters({ fleet: "guest" }).fleet).toBe("guest");
    expect(directoryPage(Array.from({ length: 65 }), ["2", "3"]).page).toBe(2);
  });
});
