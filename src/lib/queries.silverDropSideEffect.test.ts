import { readFileSync } from "node:fs";
import { describe, expect, it } from "vitest";

/**
 * Regression: public fleet ranking compute must never persist Optimist
 * drop_date. Writes belong in admin `applySilverInactivityDrops` only.
 */
describe("computeFleetRankings silver drop side effects", () => {
  it("does not mutate sailors / persist drop_date on the public read path", () => {
    const src = readFileSync(new URL("./queries.ts", import.meta.url), "utf8");
    const fnStart = src.indexOf("export async function computeFleetRankings");
    expect(fnStart).toBeGreaterThanOrEqual(0);
    const fnEnd = src.indexOf("export const getCachedFleetRankings", fnStart);
    expect(fnEnd).toBeGreaterThan(fnStart);
    const body = src.slice(fnStart, fnEnd);

    expect(body).not.toMatch(/findSilverInactivityDrops\s*\(/);
    expect(body).not.toMatch(/\.update\(\s*sailors\s*\)/);
    expect(body).not.toMatch(/dropDate:\s*d\.dropDate/);
    expect(body).toMatch(/applySilverInactivityDrops/);
  });
});
