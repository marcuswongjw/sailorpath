import { describe, expect, it } from "vitest";
import { MAX_IMPORT_ROWS } from "./importLimits";

describe("import limits", () => {
  it("caps spreadsheet rows to a safe serverless batch size", () => {
    expect(MAX_IMPORT_ROWS).toBe(400);
    expect(MAX_IMPORT_ROWS).toBeGreaterThan(50);
    expect(MAX_IMPORT_ROWS).toBeLessThanOrEqual(500);
  });
});
