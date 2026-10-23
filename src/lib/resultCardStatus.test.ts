import { describe, expect, it } from "vitest";
import { resultCoverageLabel, resultSourceStatus } from "./resultCardStatus";
describe("result card context", () => {
 it("never assumes published means final", () => {
  expect(resultSourceStatus({})).toContain("unconfirmed");
  expect(resultSourceStatus({ scheduleNotes: "Provisional results" })).toBe("Provisional source");
  expect(resultSourceStatus({ officialResultsSourceName: "Final results" })).toBe("Final source");
 });
 it("distinguishes missing entries from confirmed identity review", () => {
  expect(resultCoverageLabel({ totalFleetSize: 48, importedEntryCount: 46 })).toContain("2 not imported");
  expect(resultCoverageLabel({ totalFleetSize: 48, importedEntryCount: 46, scheduleNotes: "2 awaiting identity review" })).toContain("2 await identity review");
  expect(resultCoverageLabel({ totalFleetSize: 48, importedEntryCount: 48 })).toBe("48 entries shown");
  expect(resultCoverageLabel({ totalFleetSize: 48 })).toBeNull();
 });
});
