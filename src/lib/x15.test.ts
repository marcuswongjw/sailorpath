import { describe, expect, it } from "vitest";
import { publishedX15Sheets, x15WorldsStatus } from "./x15";
import { resolveSailingClass, supportsNationalRanking, requiresExplicitImportMetadata } from "./classRegistry";
import type { RegattaRecord } from "./ranking";

describe("X-15 results preparation", () => {
  it.each([["2026-11-03", "Upcoming"], ["2026-11-04", "Racing window"], ["2026-11-08", "Racing window"], ["2026-11-09", "Awaiting reviewed results"]])("uses event boundaries on %s", (date, status) => expect(x15WorldsStatus(date)).toBe(status));
  it("only announces results when reviewed sheets exist", () => expect(x15WorldsStatus("2026-11-09", true)).toBe("Results available"));
  it("keeps X-15 distinct from other foil classes", () => {
    for (const label of ["X-15", "X15", "X-15 Class", "X15 Wingfoil"]) expect(resolveSailingClass(label)?.key).toBe("x15");
    expect(resolveSailingClass("X150")).toBeNull();
    expect(resolveSailingClass("WingFoil")?.key).toBe("wingfoil");
    expect(resolveSailingClass("iQFOiL")?.key).toBe("iqfoil");
    expect(supportsNationalRanking("X-15")).toBe(false);
    expect(requiresExplicitImportMetadata("X-15")).toBe(true);
  });
  it("excludes drafts, empty imports and other classes while sorting newest first", () => {
    const row = (slug: string, extra = {}): RegattaRecord => ({ id: slug, slug, name: slug, date: "2026-11-08", boatClass: "X-15", totalFleetSize: 10, ...extra });
    const rows = [row("old", { date: "2025-01-01" }), row("new"), row("draft", { status: "draft" }), row("empty", { importedEntryCount: 0 }), row("wing", { boatClass: "WingFoil" })];
    expect(publishedX15Sheets(rows).map(r => r.slug)).toEqual(["new", "old"]);
  });
});
