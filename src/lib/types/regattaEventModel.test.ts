import { describe, expect, it } from "vitest";
import {
  deriveEventTimingStatus,
  deriveResultAvailability,
} from "./regattaEventModel";

describe("regattaEventModel status orthodoxy", () => {
  it("derives event timing status strictly from dates regardless of results", () => {
    // Past event with no results: timing status is completed, NOT upcoming!
    const pastStatus = deriveEventTimingStatus(
      "2025-02-08",
      "2025-02-09",
      new Date("2026-10-06T00:00:00Z")
    );
    expect(pastStatus).toBe("completed");

    // Missing results gives "unavailable", but never changes timing status
    const resultStatus = deriveResultAvailability(0);
    expect(resultStatus).toBe("unavailable");

    // Future event
    const futureStatus = deriveEventTimingStatus(
      "2026-11-01",
      "2026-11-02",
      new Date("2026-10-06T00:00:00Z")
    );
    expect(futureStatus).toBe("upcoming");

    // Ongoing event
    const inProgressStatus = deriveEventTimingStatus(
      "2026-10-05",
      "2026-10-07",
      new Date("2026-10-06T12:00:00Z")
    );
    expect(inProgressStatus).toBe("in_progress");
  });

  it("derives result availability correctly for provisional and final results", () => {
    expect(deriveResultAvailability(17, true)).toBe("provisional");
    expect(deriveResultAvailability(17, false)).toBe("final");
    expect(deriveResultAvailability(0, true)).toBe("unavailable");
  });
});
