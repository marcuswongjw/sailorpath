import { describe, expect, it } from "vitest";
import { hasLocalMatch } from "next/dist/shared/lib/match-local-pattern";
import config from "../../next.config";
describe("photo optimiser isolation", () => {
  it("permits brand assets while denying every source of consent-controlled photos", () => {
    const patterns = config.images?.localPatterns;
    expect(patterns).toBeDefined();
    expect(hasLocalMatch(patterns, "/brand/sailorpath-icon.png")).toBe(true);
    for (const url of [
      "/api/sailors/11111111-1111-4111-8111-111111111111/photo",
      "/api/sailors/11111111-1111-4111-8111-111111111111/photo?portrait=example.jpg",
      "/athlete-portraits/team-singapore/example.jpg",
      "/brand/../api/sailors/id/photo",
    ]) expect(hasLocalMatch(patterns, url)).toBe(false);
  });
});
