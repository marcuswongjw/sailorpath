import { describe, expect, it } from "vitest";
import { organiserResultStatus, resultCoverageLabel, resultSourceStatus } from "./resultCardStatus";
describe("result card context", () => {
 it("never assumes published means final", () => {
  expect(resultSourceStatus({})).toBe("Organiser: Final status not confirmed");
  expect(resultSourceStatus({ scheduleNotes: "Provisional results" })).toBe("Organiser: Provisional");
  expect(resultSourceStatus({ officialResultsSourceName: "Final results" })).toBe("Organiser: Final");
 });
 it("does not mistake final fleets or missing final documents for final results", () => {
  expect(organiserResultStatus({ name: "Final Selection Trials", scheduleNotes: "Gold final fleet" })).toBe("Final status not confirmed");
  expect(organiserResultStatus({ scheduleNotes: "Awaiting final results" })).toBe("Final status not confirmed");
  expect(organiserResultStatus({ officialResultsSourceName: "Final results", scheduleNotes: "Source is provisional" })).toBe("Provisional");
  expect(organiserResultStatus({ scheduleNotes: "Official source status: final." })).toBe("Final");
 });
 it("distinguishes missing entries from confirmed identity review", () => {
  expect(resultCoverageLabel({ totalFleetSize: 48, importedEntryCount: 46 })).toContain("2 not imported");
  expect(resultCoverageLabel({ totalFleetSize: 48, importedEntryCount: 46, scheduleNotes: "2 awaiting identity review" })).toContain("2 await identity review");
  expect(resultCoverageLabel({ totalFleetSize: 48, importedEntryCount: 48 })).toBe("48 entries shown");
  expect(resultCoverageLabel({ totalFleetSize: 48 })).toBeNull();
  expect(resultCoverageLabel({ totalFleetSize: 48, importedEntryCount: 50 })).toBe("Coverage check needed: 50 entries shown; recorded source fleet size 48");
 });
});
