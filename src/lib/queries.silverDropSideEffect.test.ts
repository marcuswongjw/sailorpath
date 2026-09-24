import { readFileSync } from "node:fs";
import { describe, expect, it } from "vitest";

/**
 * Regression: public fleet ranking compute must never persist Optimist
 * drop_date. Writes belong in admin `applySilverInactivityDrops` only.
 *
 * Preferred: computeFleetRankings does not call findSilverInactivityDrops /
 * db.update(sailors). Fallback: findSilverInactivityDrops is a legacy no-op
 * shim (returns []) so even a stale public caller cannot stamp drops.
 */
describe("computeFleetRankings silver drop side effects", () => {
  it("does not mutate sailors / persist drop_date on the public read path", () => {
    const queriesSrc = readFileSync(new URL("./queries.ts", import.meta.url), "utf8");
    const silverSrc = readFileSync(
      new URL("./silverSeriesDrop.ts", import.meta.url),
      "utf8"
    );
    const fnStart = queriesSrc.indexOf("export async function computeFleetRankings");
    expect(fnStart).toBeGreaterThanOrEqual(0);
    const fnEnd = queriesSrc.indexOf("export const getCachedFleetRankings", fnStart);
    expect(fnEnd).toBeGreaterThan(fnStart);
    const body = queriesSrc.slice(fnStart, fnEnd);

    const queriesClean =
      !/findSilverInactivityDrops\s*\(/.test(body) &&
      !/\.update\(\s*sailors\s*\)/.test(body) &&
      !/dropDate:\s*d\.dropDate/.test(body) &&
      /applySilverInactivityDrops/.test(body);

    const legacyShimSafe =
      /Legacy name kept for any remaining public ranking imports/.test(silverSrc) &&
      /export function findSilverInactivityDrops\(/.test(silverSrc) &&
      /return \[\];/.test(silverSrc) &&
      /export function detectSilverInactivityDrops\(/.test(silverSrc);

    expect(queriesClean || legacyShimSafe).toBe(true);
  });
});
