import { describe, expect, it } from "vitest";
import { annualSeriesKey, meetsRecordedIndexGates, selectActiveIndexEvents } from "./asianOptimistIndexRollover";

const event = (name: string, endDate: string, options: { resultStatus?: string; slugs?: string[]; isWorlds?: boolean } = {}) => ({
  name, endDate, indexRole: "championship", isWorlds: options.isWorlds ?? false,
  resultStatus: options.resultStatus ?? "verified", grade: 150, regattaSlugs: options.slugs ?? ["results"],
});
const now = new Date("2027-02-01T12:00:00Z");

describe("annual Index rollover", () => {
  it("keeps a verified annual edition beyond 12 months while its successor is scheduled or incomplete", () => {
    const old = event("2025 Optimist Asian & Oceanian Championship", "2025-11-01");
    const scheduled = event("2026 IODA Asian & Oceanian Championship", "2026-12-19", { resultStatus: "scheduled", slugs: [] });
    expect(selectActiveIndexEvents([old, scheduled], now)).toEqual([old, scheduled]);
    expect(selectActiveIndexEvents([old, { ...scheduled, resultStatus: "verified" }], now)).toEqual([old]);
  });
  it("replaces an edition only with the completed, verified matching edition", () => {
    const old = event("2025 Optimist Asian & Oceanian Championship", "2025-11-01");
    const next = event("2026 IODA Asian & Oceanian Championship", "2026-12-19");
    expect(selectActiveIndexEvents([old, next], now)).toEqual([next]);
    expect(selectActiveIndexEvents([old, { ...next, endDate: "2027-12-19" }], now)).toEqual([old]);
  });
  it("keeps separate boys and girls editions and does not conflate unrelated championships", () => {
    const boys = event("2025 Optimist European Championship — Boys", "2025-07-31");
    const girls = event("2025 Optimist European Championship — Girls", "2025-07-31");
    const nextBoys = event("2026 Optimist European Championship — Boys", "2026-07-31");
    expect(selectActiveIndexEvents([boys, girls, nextBoys], now)).toEqual([girls, nextBoys]);
    expect(annualSeriesKey(event("2026 Asian & Oceanian Championship", "2026-12-19"))).not.toBe(annualSeriesKey(nextBoys));
  });
  it("expires unrecognised events after twelve months", () => {
    expect(selectActiveIndexEvents([event("One-off invitational", "2025-01-01")], now)).toEqual([]);
  });
  it("enforces grade-specific fleet, race and MNA gates", () => {
    expect(meetsRecordedIndexGates({ grade: 40, fleetSize: 58, raceCount: 3, verifiedMnas: 1 })).toBe(false);
    expect(meetsRecordedIndexGates({ grade: 40, fleetSize: 25, raceCount: 4, verifiedMnas: 1 })).toBe(true);
    expect(meetsRecordedIndexGates({ grade: 75, fleetSize: 40, raceCount: 4, verifiedMnas: 3 })).toBe(false);
    expect(meetsRecordedIndexGates({ grade: 150, fleetSize: 10, raceCount: 4, verifiedMnas: null })).toBe(false);
  });
});
