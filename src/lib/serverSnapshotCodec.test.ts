import { randomUUID } from "node:crypto";
import { describe, expect, it } from "vitest";
import { encodeServerSnapshot, decodeServerSnapshot } from "./serverSnapshotCodec";
import { calculateRankings, type SailorRecord, type RegattaRecord, type RegattaResultRecord } from "./ranking";

describe("server ranking snapshot cache", () => {
  it("round-trips scoring inputs and produces identical standings", async () => {
    const sailors: SailorRecord[] = ["a", "b"].map((id) => ({ id, name: id, handle: id, sailNumber: id,
      club: "Club", nationality: "SGP", goldEntryDate: "2025-01-01", silverEntryDate: null, dropDate: null, currentFleet: "Series", dob: "2012-05-15" }));
    const regattas: RegattaRecord[] = [1,2,3].map(i => ({ id: `r${i}`, name: `Regatta ${i}`, slug: `r${i}`, date: `2026-0${i}-01`, division: "Gold", boatClass: "Optimist", totalFleetSize: 2, raceCount: 6, countsForRanking: true }));
    const results: RegattaResultRecord[] = regattas.flatMap(r => sailors.map((s,i) => ({ sailorId: s.id, regattaId: r.id, rank: i+1, nettScore: i+4, totalScore: i+6, isDns: false, isOverseasCommitment: false })));
    const snapshot = { sailors, regattas, results };
    const decoded = await decodeServerSnapshot<typeof snapshot>(await encodeServerSnapshot(snapshot));
    expect(decoded).toEqual(snapshot);
    const original = calculateRankings({ year: 2026, half: "Jan-Jun" }, sailors, regattas, results);
    expect(original).toHaveLength(2);
    expect(calculateRankings({ year: 2026, half: "Jan-Jun" }, decoded.sailors, decoded.regattas, decoded.results)).toEqual(original);
  });
  it("keeps a large high-cardinality fixture comfortably below the cache item limit", async () => {
    const sailorIds = Array.from({ length: 3200 }, () => randomUUID());
    const regattaIds = Array.from({ length: 200 }, () => randomUUID());
    const snapshot = {
      sailors: sailorIds.map((id,i) => ({ id, name: `Fixture sailor ${i}`, handle: `fixture-${i}`, sailNumber: String(i), club: "Fixture club", school: null, nationality: "SGP", gender: "F", dob: "2012-01-01", goldEntryDate: "2025-01-01", silverEntryDate: null, dropDate: null, currentFleet: "Series", nationalSquadStatus: null })),
      results: Array.from({ length: 10000 }, (_,i) => ({ sailorId: sailorIds[i%sailorIds.length], regattaId: regattaIds[i%regattaIds.length], rank: i%100+1, nettScore: i%500, totalScore: i%600, isDns: false, isOverseasCommitment: false })),
    };
    expect(Buffer.byteLength(JSON.stringify(snapshot))).toBeGreaterThan(2*1024*1024);
    const encoded = await encodeServerSnapshot(snapshot);
    // Include Next's escaped JSON body envelope, not just compressed bytes.
    expect(Buffer.byteLength(JSON.stringify({ kind: "FETCH", data: { body: JSON.stringify(encoded) } }))).toBeLessThan(1024*1024);
    expect(await decodeServerSnapshot(encoded)).toEqual(snapshot);
  });
  it("rejects a damaged cache entry rather than returning incorrect standings", async () => {
    await expect(decodeServerSnapshot("invalid")).rejects.toThrow();
  });
});
