import { describe, expect, it, vi } from "vitest";

const unifiedSearch = vi.hoisted(() => vi.fn());
vi.mock("@/lib/search", () => ({ unifiedSearch }));

import { GET } from "./route";

describe("GET /api/search", () => {
  it("forwards only the public search contract", async () => {
    unifiedSearch.mockResolvedValue({ sailors: [], regattas: [], total: 0 });
    const response = await GET(new Request("https://sailorpath.test/api/search?q=Test&club=CSC&nationality=SGP&school=private&squad=Nat+A&birthYearFrom=2012"));
    expect(response.status).toBe(200);
    expect(unifiedSearch).toHaveBeenCalledWith("Test", {
      fleet: "all",
      club: "CSC",
      nationality: "SGP",
      type: "all",
      limit: undefined,
    });
  });
});
