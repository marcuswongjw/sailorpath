import { describe, expect, it } from "vitest";
import { metadata } from "./page";

describe("X-15 class hub", () => {
  it("is available by direct URL but excluded from search indexing during review", () => {
    expect(metadata.title).toBe("X-15 class hub | SailorPath");
    expect(metadata.robots).toEqual({
      index: false,
      follow: false,
    });
  });
});
