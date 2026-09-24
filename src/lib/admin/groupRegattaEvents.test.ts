import { describe, expect, it } from "vitest";
import {
  eventShellSlug,
  eventStatusLabel,
  groupRegattaEvents,
  sheetClassLabel,
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

describe("groupRegattaEvents", () => {
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
});
