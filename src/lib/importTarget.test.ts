import { describe, expect, it } from "vitest";
import {
  NEW_IMPORT_TARGET,
  resolveImportTarget,
} from "@/lib/importTarget";

const first = { id: "event-a", slug: "first-event-2026-01-01" };
const second = { id: "event-b", slug: "second-event-2026-01-01" };

describe("resolveImportTarget", () => {
  it("requires an explicit choice for one differently named same-day event", () => {
    expect(
      resolveImportTarget({
        sameDay: [first],
        incomingSlug: "different-event-2026-01-01",
        slugMatch: null,
        selectedId: null,
      })
    ).toEqual({ kind: "selection-required" });
  });

  it("requires an explicit choice for ambiguous same-day events", () => {
    expect(
      resolveImportTarget({
        sameDay: [first, second],
        incomingSlug: "renamed-event-2026-01-01",
        slugMatch: null,
        selectedId: null,
      })
    ).toEqual({ kind: "selection-required" });
  });

  it("uses an explicitly selected same-day event", () => {
    expect(
      resolveImportTarget({
        sameDay: [first, second],
        incomingSlug: "renamed-event-2026-01-01",
        slugMatch: null,
        selectedId: second.id,
      })
    ).toEqual({ kind: "target", target: second });
  });

  it("creates a separate event when explicitly selected", () => {
    expect(
      resolveImportTarget({
        sameDay: [first],
        incomingSlug: "different-event-2026-01-01",
        slugMatch: null,
        selectedId: NEW_IMPORT_TARGET,
      })
    ).toEqual({ kind: "new-regatta" });
  });

  it("uses an exact slug before a same-day fallback", () => {
    expect(
      resolveImportTarget({
        sameDay: [first, second],
        incomingSlug: second.slug,
        slugMatch: null,
        selectedId: null,
      })
    ).toEqual({ kind: "target", target: second });
  });
});
