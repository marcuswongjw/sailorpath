import { describe, expect, it } from "vitest";
import { dedupeEventSheets, savedEventRegion } from "./publicCalendar";
import type { RegattaRecord } from "@/lib/ranking";

describe("dedupeEventSheets", () => {
  it("deduplicates sheets that represent the same boat class and division", () => {
    const dbSheet: RegattaRecord = {
      id: "00000000-0000-0000-0000-000000000001",
      name: "Cincapura Regatta 2026 (ILCA 6)",
      slug: "cincapura-2026-ilca6",
      date: "2026-07-20",
      boatClass: "ILCA 6",
      division: "Open",
      raceCount: 3,
      totalFleetSize: 16,
      countsForRanking: true,
    };
    const staticSheet: RegattaRecord = {
      id: "reg-cincapura-2026-ilca-6",
      name: "Cincapura Regatta 2026 (ILCA 6)",
      slug: "cincapura-regatta-2026-ilca-6",
      date: "2026-07-20",
      boatClass: "ILCA 6",
      division: "Open",
      raceCount: 3,
      totalFleetSize: 16,
      countsForRanking: true,
    };

    const deduped = dedupeEventSheets([dbSheet, staticSheet]);
    expect(deduped).toHaveLength(1);
    // Should prefer the database sheet over the static fallback
    expect(deduped[0].id).toBe("00000000-0000-0000-0000-000000000001");
  });

  it("retains different divisions of the same boat class", () => {
    const goldSheet: RegattaRecord = {
      id: "gold-id",
      name: "Cincapura 2026 (Gold)",
      slug: "cincapura-2026-gold",
      date: "2026-07-20",
      boatClass: "Optimist",
      division: "Gold",
      totalFleetSize: 20,
    };
    const silverSheet: RegattaRecord = {
      id: "silver-id",
      name: "Cincapura 2026 (Silver)",
      slug: "cincapura-2026-silver",
      date: "2026-07-20",
      boatClass: "Optimist",
      division: "Silver",
      totalFleetSize: 15,
    };

    const deduped = dedupeEventSheets([goldSheet, silverSheet]);
    expect(deduped).toHaveLength(2);
  });
});

describe("saved event regions", () => {
  it("does not label Australian events or unknown venues as Singapore", () => {
    expect(savedEventRegion("Royal Brighton Yacht Club, Port Phillip Bay, Victoria")).toBe("International");
    expect(savedEventRegion("Port Denison Sailing Club, Bowen, Queensland")).toBe("International");
    expect(savedEventRegion("Royal Queensland Yacht Squadron, Manly, Queensland")).toBe("International");
    expect(savedEventRegion("Langkawi, Malaysia")).toBe("Asia");
    expect(savedEventRegion("Kiel, Germany")).toBe("Europe");
    expect(savedEventRegion("Bodrum, Turkey")).toBe("Europe");
    expect(savedEventRegion("Weymouth, UK")).toBe("Europe");
    expect(savedEventRegion(null)).toBeUndefined();
    expect(savedEventRegion("Changi Sailing Club, Singapore")).toBe("Singapore");
  });
});
