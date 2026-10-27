import { beforeEach, describe, expect, it, vi } from "vitest";

vi.mock("next/cache", () => ({
  revalidatePath: vi.fn(),
  revalidateTag: vi.fn(),
}));

import { revalidatePath, revalidateTag } from "next/cache";
import { revalidatePublicNews, revalidatePublicRankings } from "./revalidatePublic";

describe("public cache refresh", () => {
  beforeEach(() => {
    vi.mocked(revalidateTag).mockClear();
    vi.mocked(revalidatePath).mockClear();
  });

  it("keeps the previous public payload available while rankings refresh", () => {
    revalidatePublicRankings("results:publish");
    expect(vi.mocked(revalidateTag).mock.calls.length).toBeGreaterThan(0);
    for (const call of vi.mocked(revalidateTag).mock.calls) {
      expect(call[1]).toBe("max");
    }
  });

  it("invalidates each public page once without expiring the root layout", () => {
    revalidatePublicRankings("results:publish");
    const calls = vi.mocked(revalidatePath).mock.calls;
    expect(calls.length).toBeGreaterThan(0);
    expect(new Set(calls.map(([path]) => path)).size).toBe(calls.length);
    expect(calls.every((call) => call.length === 1)).toBe(true);
    expect(calls).toContainEqual(["/"]);
    expect(calls).not.toContainEqual(["/", "layout"]);
  });

  it("keeps the previous news payload available while an article refresh runs", () => {
    revalidatePublicNews("harbour-cup");
    expect(vi.mocked(revalidateTag)).toHaveBeenCalledWith(expect.any(String), "max");
    expect(vi.mocked(revalidatePath)).toHaveBeenCalledWith("/news");
    expect(vi.mocked(revalidatePath)).toHaveBeenCalledWith("/news/harbour-cup");
  });
});
