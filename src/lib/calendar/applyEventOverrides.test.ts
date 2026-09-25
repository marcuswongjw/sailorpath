import { describe, expect, it } from "vitest";
import {
  applyCalendarEventOverride,
  canonicalCalendarEventSlug,
} from "./applyEventOverrides";
import type { RegattaRecord } from "@/lib/ranking";

const card: RegattaRecord = {
  id: "singapore-national-sailing-championships-2026",
  name: "Singapore National Sailing Championships 2026",
  slug: "singapore-national-sailing-championships-2026",
  date: "2026-09-05",
  endDate: "2026-09-13",
  totalFleetSize: 130,
  venue: "National Sailing Centre, East Coast",
  organizer: "Singapore Sailing Federation",
  countsForRanking: true,
  isSelectionTrial: true,
  keyDeadlines: "Entry closes 24 August 2026",
  norUrl: "https://example.com/nor",
  classes: ["Optimist", "ILCA 4"],
  boatClass: "Optimist",
};

describe("applyCalendarEventOverride", () => {
  it("maps the public SNSC card onto the admin weekend slug", () => {
    expect(
      canonicalCalendarEventSlug("singapore-national-sailing-championships-2026")
    ).toBe("snsc-2026");
  });

  it("replaces the card fields an admin saved", () => {
    const next = applyCalendarEventOverride(
      card,
      {
        slug: "snsc-2026",
        name: "SNSC 2026",
        startDate: "2026-09-06",
        endDate: "2026-09-14",
        venue: "NSC",
        organizer: "SSF",
        classes: ["Optimist", "ILCA 4", "29er"],
        norUrl: "https://example.com/notice",
        registrationUrl: null,
        countsForRanking: true,
        isSelectionTrial: false,
        keyDeadlines: "Entry closes 1 August 2026",
      },
      true
    );
    expect(next.name).toBe("SNSC 2026");
    expect(next.date).toBe("2026-09-06");
    expect(next.endDate).toBe("2026-09-14");
    expect(next.venue).toBe("NSC");
    expect(next.isSelectionTrial).toBe(false);
    expect(next.keyDeadlines).toBe("Entry closes 1 August 2026");
    expect(next.classes).toEqual(["Optimist", "ILCA 4", "29er"]);
    expect(next.norUrl).toBe("https://example.com/notice");
    const cleared = applyCalendarEventOverride(
      card,
      {
        slug: "snsc-2026",
        name: "SNSC 2026",
        startDate: "2026-09-06",
        venue: null,
        keyDeadlines: null,
        norUrl: null,
      },
      true
    );
    expect(cleared.venue).toBeUndefined();
    expect(cleared.keyDeadlines).toBeUndefined();
    expect(cleared.norUrl).toBeUndefined();
  });

  it("leaves a sibling card's name and classes alone", () => {
    const next = applyCalendarEventOverride(card, {
      slug: "pesta-sukan-2026",
      name: "Pesta Sukan 2026",
      startDate: "2026-07-25",
      classes: ["ILCA 4"],
      keyDeadlines: "Entry closes 13 July 2026",
    }, false);
    expect(next.name).toBe(card.name);
    expect(next.classes).toEqual(card.classes);
    expect(next.date).toBe("2026-07-25");
    expect(next.keyDeadlines).toBe("Entry closes 13 July 2026");
  });
});
