import { describe, expect, it } from "vitest";
import { missingFallbackSheets } from "./resultSheetIdentity";
import { ILCA6_STATIC_REGATTAS } from "./ilca6ResultsData";
import { ilcaRankingRegattas } from "./ilcaRanking";

const fallback = ILCA6_STATIC_REGATTAS.find((row) => row.slug.includes("cincapura"))!;
const saved = { ...fallback, id: "53cfe38c-9b07-48af-9d8e-6a9fc6738215", slug: "cincapura-2026-ilca-6", name: "Cincapura 2026 (ILCA 6)" };

describe("fallback result sheets", () => {
  it("keeps Cincapura once in discovery and in the ranking window despite different names and IDs", () => {
    const rows = [saved, ...missingFallbackSheets([saved], [fallback])];
    expect(rows).toEqual([saved]);
    expect(ilcaRankingRegattas(rows, "ILCA 6", "2026-08-01").map((row) => row.id)).toEqual([saved.id]);
  });
  it("preserves the fallback when no saved sheet exists", () => {
    expect(missingFallbackSheets([], [fallback])).toEqual([fallback]);
  });
  it("keeps different years, classes and fleets separate", () => {
    for (const different of [
      { ...saved, id: "2025", slug: "cincapura-2025-ilca-6", date: "2025-07-20", name: "Cincapura 2025 (ILCA 6)" },
      { ...saved, id: "ilca4", slug: "cincapura-2026-ilca4", boatClass: "ILCA 4" },
      { ...saved, id: "women", slug: "cincapura-women", division: "Women" },
    ]) expect(missingFallbackSheets([different], [fallback])).toEqual([fallback]);
  });
});
