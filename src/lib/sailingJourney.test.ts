import { describe, expect, it } from "vitest";
import {
  buildSystemJourneyMilestones,
  dismissSystemMilestone,
  mergeJourneyDisplay,
  parseSailingJourney,
  serializeSailingJourney,
} from "./sailingJourney";

describe("sailingJourney", () => {
  it("round-trips highlights", () => {
    const raw = serializeSailingJourney([
      {
        id: "1",
        when: "2026",
        title: "Nationals win",
        detail: "First big title",
      },
    ]);
    const parsed = parseSailingJourney(raw);
    expect(parsed).toHaveLength(1);
    expect(parsed[0].title).toBe("Nationals win");
  });

  it("drops empty titles", () => {
    expect(
      parseSailingJourney([{ id: "x", when: "1", title: "  ", detail: "no" }])
    ).toHaveLength(0);
  });

  it("does not persist system milestones", () => {
    const raw = serializeSailingJourney([
      {
        id: "sys-gold-entry",
        when: "Jan 2025",
        title: "Broke into gold fleet",
        detail: "x",
        system: true,
      },
      {
        id: "1",
        when: "2026",
        title: "Owner note",
        detail: "y",
      },
    ]);
    const parsed = parseSailingJourney(raw);
    expect(parsed).toHaveLength(1);
    expect(parsed[0].title).toBe("Owner note");
  });

  it("builds gold entry and first silver milestones", () => {
    const sys = buildSystemJourneyMilestones(
      { goldEntryDate: "2025-07-01", silverEntryDate: "2024-01-15" },
      [
        {
          regattaDate: "2024-03-10",
          division: "Silver",
          boatClass: "Optimist",
          regattaName: "NR1 2024",
        },
        {
          regattaDate: "2024-02-01",
          division: "Silver",
          boatClass: "Optimist",
          regattaName: "Early Silver",
        },
      ]
    );
    expect(sys.some((m) => m.id === "sys-gold-entry")).toBe(true);
    const silver = sys.find((m) => m.id === "sys-first-silver");
    expect(silver?.when).toMatch(/2024/);
    expect(silver?.detail).toContain("Early Silver");
  });

  it("merges and sorts journey display", () => {
    const merged = mergeJourneyDisplay(
      [{ id: "o1", when: "2026", title: "Camp", detail: "" }],
      [
        {
          id: "sys-gold-entry",
          when: "Jul 2025",
          title: "Broke into gold fleet",
          detail: "",
          system: true,
        },
      ]
    );
    expect(merged[0].id).toBe("sys-gold-entry");
    expect(merged[1].title).toBe("Camp");
  });

  it("allows dismissing system milestones", () => {
    const owner = dismissSystemMilestone([], "sys-gold-entry");
    const merged = mergeJourneyDisplay(owner, [
      {
        id: "sys-gold-entry",
        when: "Jul 2025",
        title: "Broke into gold fleet",
        detail: "",
        system: true,
      },
    ]);
    expect(merged.some((m) => m.id === "sys-gold-entry")).toBe(false);
  });
});
