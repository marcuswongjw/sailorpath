import { describe, expect, it } from "vitest";
import { assertImportSheetTarget } from "./importSheetTarget";

describe("assertImportSheetTarget", () => {
  it("rejects an unknown class", () => {
    expect(assertImportSheetTarget({ sheet: null }).ok).toBe(false);
  });

  it("rejects a class from another weekend", () => {
    const result = assertImportSheetTarget({
      sheet: { id: "abc", eventSlug: "temasek-regatta-2026" },
      eventSlug: "snsc-2026",
    });
    expect(result.ok).toBe(false);
    if (!result.ok) expect(result.status).toBe(409);
  });

  it("accepts the requested class", () => {
    expect(
      assertImportSheetTarget({
        sheet: { id: "abc", eventSlug: "snsc-2026" },
        eventSlug: "snsc-2026",
      })
    ).toEqual({ ok: true, sheetId: "abc" });
  });
});
