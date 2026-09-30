import { describe, expect, it } from "vitest";
import { planRegattaEventDelete } from "./planRegattaEventDelete";
import {
  eventShellSlug,
  eventStatusLabel,
  groupRegattaEvents,
  missingClassesFor,
  sheetClassLabel,
  sheetIdsForEvent,
} from "./groupRegattaEvents";

function row(
  partial: Partial<{
    id: string;
    name: string;
    slug: string;
    date: string;
    boatClass: string;
    division: string;
    status: string;
  }> & { slug: string }
) {
  return {
    id: partial.id || partial.slug,
    name: partial.name || partial.slug,
    slug: partial.slug,
    date: partial.date || "2026-06-20",
    boatClass: partial.boatClass || "Optimist",
    division: partial.division || "Gold",
    status: partial.status || "published",
  };
}

describe("missingClassesFor", () => {
  it("follows the saved class list instead of the original calendar", () => {
    const sheets = [
      row({
        slug: "sheet-gold",
        boatClass: "Optimist",
        division: "Gold",
      }),
    ];
    expect(missingClassesFor(["Optimist", "ILCA 4"], sheets)).toEqual(["ILCA 4"]);
    expect(missingClassesFor(["Optimist"], sheets)).toEqual([]);
    expect(missingClassesFor(["Optimist Gold", "Optimist Silver"], sheets)).toEqual([
      "Optimist Silver",
    ]);
  });
});

describe("groupRegattaEvents", () => {
  it("uses an explicit weekend link before trying to infer from the sheet name", () => {
    const linked = row({
      id: "linked-sheet",
      slug: "historical-name-that-does-not-match",
      name: "Imported results",
    });
    const grouped = groupRegattaEvents(
      [{ ...linked, eventId: "event-1" }],
      new Map([["event-1", "pesta-sukan-2026"]])
    );

    expect(grouped.unassigned).toHaveLength(0);
    expect(
      grouped.events.find((event) => event.slug === "pesta-sukan-2026")?.sheets[0]?.id
    ).toBe("linked-sheet");
  });

  it("treats a calendar slug as the event, not a class sheet", () => {
    expect(eventShellSlug("temasek-regatta-2026")).toBe("temasek-regatta-2026");
    expect(eventShellSlug("202606-temasek-gold-2026-06-20")).toBeNull();
    expect(eventShellSlug("singapore-national-sailing-championships-2026")).toBe(
      "snsc-2026"
    );
  });

  it("puts class sheets under the weekend and leaves unknown rows unassigned", () => {
    const grouped = groupRegattaEvents([
      row({
        slug: "temasek-regatta-2026",
        name: "Temasek Regatta 2026",
        date: "2026-06-20",
      }),
      row({
        slug: "202606-temasek-gold-2026-06-20",
        name: "Temasek Gold",
        division: "Gold",
        status: "published",
      }),
      row({
        slug: "202606-temasek-silver-2026-06-20",
        name: "Temasek Silver",
        division: "Silver",
        status: "draft",
      }),
      row({
        slug: "club-training-2026-04-01",
        name: "Club training",
        date: "2026-04-01",
        boatClass: "Optimist",
      }),
    ]);

    expect(grouped.unassigned.map((item) => item.slug)).toEqual([
      "club-training-2026-04-01",
    ]);
    const temasek = grouped.events.find((event) => event.slug === "temasek-regatta-2026");
    expect(temasek?.shell?.slug).toBe("temasek-regatta-2026");
    expect(temasek?.sheets.map((item) => item.slug)).toEqual([
      "202606-temasek-gold-2026-06-20",
      "202606-temasek-silver-2026-06-20",
    ]);
    expect(temasek?.sheets.map(sheetClassLabel)).toEqual([
      "Optimist Gold",
      "Optimist Silver",
    ]);
    expect(temasek && eventStatusLabel(temasek)).toBe("1 of 8 classes published");
  });

  it("folds the SNSC calendar card and a gold sheet into one event", () => {
    const grouped = groupRegattaEvents([
      row({
        slug: "singapore-national-sailing-championships-2026",
        name: "SNSC card",
        date: "2026-09-05",
      }),
      row({
        slug: "snsc-gold-sep-26-2026-09-11",
        name: "SNSC Gold",
        date: "2026-09-11",
        division: "Gold",
        status: "published",
      }),
    ]);
    expect(grouped.unassigned).toHaveLength(0);
    const snsc = grouped.events.find((event) => event.slug === "snsc-2026");
    expect(snsc?.name).toMatch(/National Sailing Championships/);
    expect(snsc?.shell?.slug).toBe("singapore-national-sailing-championships-2026");
    expect(snsc?.sheets).toHaveLength(1);
    expect(snsc?.missingClasses).toContain("ILCA 4");
    expect(snsc?.missingClasses).not.toContain("Optimist");
  });

  it("keeps every calendar row for a weekend selectable", () => {
    const grouped = groupRegattaEvents([
      row({
        id: "card",
        slug: "singapore-national-sailing-championships-2026",
        name: "SNSC card",
        date: "2026-09-05",
      }),
      row({
        id: "ilca-card",
        slug: "singapore-national-sailing-championships-2026-ilca4",
        name: "SNSC ILCA 4 card",
        date: "2026-09-11",
        boatClass: "ILCA 4",
        division: "Open",
      }),
    ]);
    const snsc = grouped.events.find((event) => event.slug === "snsc-2026");
    expect(snsc?.shells.map((item) => item.id).sort()).toEqual(["card", "ilca-card"]);
    expect(grouped.unassigned).toHaveLength(0);
  });

  it("collects class sheets and calendar shells for a weekend delete", () => {
    const grouped = groupRegattaEvents([
      row({
        slug: "temasek-regatta-2026",
        name: "Temasek Regatta 2026",
        date: "2026-06-20",
      }),
      row({
        slug: "202606-temasek-gold-2026-06-20",
        name: "Temasek Gold",
        division: "Gold",
      }),
    ]);
    expect(sheetIdsForEvent(grouped, "temasek-regatta-2026").sort()).toEqual([
      "202606-temasek-gold-2026-06-20",
      "temasek-regatta-2026",
    ]);
    const planned = planRegattaEventDelete({
      slug: "temasek-regatta-2026",
      grouped,
      eventRows: [
        { id: "evt-1", slug: "temasek-regatta-2026", name: "Temasek Regatta 2026" },
      ],
      sheets: [
        { id: "orphan-link", eventId: "evt-1" },
        { id: "other", eventId: "evt-2" },
      ],
    });
    expect(planned.ok).toBe(true);
    if (!planned.ok) return;
    expect(planned.eventId).toBe("evt-1");
    expect(planned.sheetIds.sort()).toEqual([
      "202606-temasek-gold-2026-06-20",
      "orphan-link",
      "temasek-regatta-2026",
    ]);
  });

  it("refuses to delete the unassigned bucket", () => {
    const planned = planRegattaEventDelete({
      slug: "__unassigned__",
      grouped: { events: [], unassigned: [row({ slug: "club-training" })] },
      eventRows: [],
      sheets: [],
    });
    expect(planned).toEqual({
      ok: false,
      status: 400,
      error: "Cannot delete the unassigned sailing-class bucket",
    });
  });
});
