import { describe, expect, it } from "vitest";
import {
  adminAuditRegattaId,
  formatAdminAuditDetails,
  normalizeAdminAuditDetails,
  toAdminAuditJsonValue,
} from "@/lib/adminAuditDetails";

describe("admin audit details", () => {
  it("accepts a live JSONB object and formats it safely", () => {
    const details = { regattaId: "sheet-123", fields: ["rank", "score"] };

    expect(normalizeAdminAuditDetails(details)).toEqual(details);
    expect(formatAdminAuditDetails(details)).toBe(
      JSON.stringify(details, null, 2)
    );
    expect(adminAuditRegattaId(details)).toBe("sheet-123");
  });

  it("continues to parse legacy JSON text", () => {
    const details = '{"regattaId":"legacy-sheet","rank":2}';

    expect(normalizeAdminAuditDetails(details)).toEqual({
      regattaId: "legacy-sheet",
      rank: 2,
    });
    expect(adminAuditRegattaId(details)).toBe("legacy-sheet");
  });

  it("preserves non-JSON legacy text for display without inventing a link", () => {
    expect(normalizeAdminAuditDetails("legacy note")).toBe("legacy note");
    expect(formatAdminAuditDetails("legacy note")).toBe('"legacy note"');
    expect(adminAuditRegattaId("legacy note")).toBeNull();
  });

  it("handles null and missing details", () => {
    expect(normalizeAdminAuditDetails(null)).toBeNull();
    expect(normalizeAdminAuditDetails(undefined)).toBeNull();
    expect(formatAdminAuditDetails(null)).toBeNull();
    expect(adminAuditRegattaId(null)).toBeNull();
    expect(toAdminAuditJsonValue(undefined)).toBeNull();
  });

  it("stores structured JSON and bounds oversized details without invalid JSON", () => {
    expect(toAdminAuditJsonValue({ rank: 1 })).toEqual({ rank: 1 });

    const stored = toAdminAuditJsonValue({ note: "x".repeat(9_000) });

    expect(stored).toEqual(
      expect.objectContaining({ truncated: true, preview: expect.any(String) })
    );
    expect(JSON.stringify(stored)).toContain('"truncated":true');
  });

  it("fails soft for circular audit input", () => {
    const circular: Record<string, unknown> = {};
    circular.self = circular;

    expect(toAdminAuditJsonValue(circular)).toBeNull();
  });
});
