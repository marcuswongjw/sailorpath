import { describe, expect, it } from "vitest";
import type { RegattaRecord } from "@/lib/ranking";
import {
  defaultEventFleetKey,
  getRegattaEvent,
  getStaticBoardRegatta,
  resolveEventSlices,
  sliceMatchesRegattaSlug,
  SNSC_2026_EVENT,
} from "@/lib/regattaEvents";

function regatta(slug: string): RegattaRecord {
  return {
    id: `id-${slug}`,
    name: slug,
    slug,
    date: "2026-09-11",
    totalFleetSize: 40,
  };
}

const LIVE_SLUGS = [
  "snsc-gold-sep-26-2026-09-11",
  "snsc-silver-sep-26-2026-09-05",
  "snsc-ilca-4-sep-26-2026-09-11",
  // Other events that must NOT match
  "cincapura-regatta-2026-gold",
  "snsc-gold-sep-25-2025-09-06",
  "pesta-sukan-gold-aug-26-2026-08-01",
];

describe("getRegattaEvent", () => {
  it("resolves the SNSC 2026 event slug case-insensitively", () => {
    expect(getRegattaEvent("snsc-2026")?.slug).toBe("snsc-2026");
    expect(getRegattaEvent("SNSC-2026")?.slug).toBe("snsc-2026");
  });

  it("returns null for slice slugs and unknown events", () => {
    expect(getRegattaEvent("snsc-gold-sep-26-2026-09-11")).toBeNull();
    expect(getRegattaEvent("cincapura-regatta-2026")).toBeNull();
    expect(getRegattaEvent("")).toBeNull();
  });
});

describe("sliceMatchesRegattaSlug", () => {
  it("matches the live SNSC 2026 slice slugs to the right slices", () => {
    const [gold, silver, ilca] = SNSC_2026_EVENT.slices;
    expect(sliceMatchesRegattaSlug(gold, "snsc-gold-sep-26-2026-09-11")).toBe(true);
    expect(sliceMatchesRegattaSlug(silver, "snsc-silver-sep-26-2026-09-05")).toBe(true);
    expect(sliceMatchesRegattaSlug(ilca, "snsc-ilca-4-sep-26-2026-09-11")).toBe(true);
  });

  it("does not cross-match slices or other years", () => {
    const [gold, silver, ilca] = SNSC_2026_EVENT.slices;
    expect(sliceMatchesRegattaSlug(gold, "snsc-silver-sep-26-2026-09-05")).toBe(false);
    expect(sliceMatchesRegattaSlug(silver, "snsc-gold-sep-26-2026-09-11")).toBe(false);
    expect(sliceMatchesRegattaSlug(ilca, "snsc-gold-sep-26-2026-09-11")).toBe(false);
    expect(sliceMatchesRegattaSlug(gold, "snsc-gold-sep-25-2025-09-06")).toBe(false);
    expect(sliceMatchesRegattaSlug(gold, "cincapura-regatta-2026-gold")).toBe(false);
  });

  it("never matches slices without slug tokens (board classes)", () => {
    const wingfoil = SNSC_2026_EVENT.slices.find((s) => s.key === "wingfoil")!;
    expect(sliceMatchesRegattaSlug(wingfoil, "snsc-2026-wingfoil")).toBe(false);
  });
});

describe("resolveEventSlices", () => {
  it("maps each DB-backed slice to its regatta row and claims rows once", () => {
    const slices = resolveEventSlices(
      SNSC_2026_EVENT,
      LIVE_SLUGS.map(regatta)
    );
    const byKey = new Map(slices.map((s) => [s.def.key, s.regatta?.slug ?? null]));
    expect(byKey.get("optimist-gold")).toBe("snsc-gold-sep-26-2026-09-11");
    expect(byKey.get("optimist-silver")).toBe("snsc-silver-sep-26-2026-09-05");
    expect(byKey.get("ilca-4")).toBe("snsc-ilca-4-sep-26-2026-09-11");
    expect(byKey.get("wingfoil")).toBeNull();
    expect(byKey.get("techno-293")).toBeNull();
  });

  it("leaves slices unmatched when the regatta row is missing", () => {
    const slices = resolveEventSlices(SNSC_2026_EVENT, [
      regatta("snsc-gold-sep-26-2026-09-11"),
    ]);
    const silver = slices.find((s) => s.def.key === "optimist-silver")!;
    expect(silver.regatta).toBeNull();
  });
});

describe("getStaticBoardRegatta", () => {
  it("resolves the SNSC board-class scoreboards", () => {
    const wingfoil = SNSC_2026_EVENT.slices.find((s) => s.key === "wingfoil")!;
    const techno = SNSC_2026_EVENT.slices.find((s) => s.key === "techno-293")!;
    expect(getStaticBoardRegatta(wingfoil)?.id).toBe("snsc-2026-wingfoil");
    expect(getStaticBoardRegatta(techno)?.id).toBe("techno-snsc-2026");
    expect(getStaticBoardRegatta(SNSC_2026_EVENT.slices[0])).toBeNull();
  });
});

describe("defaultEventFleetKey", () => {
  it("prefers the first slice with data", () => {
    const slices = resolveEventSlices(
      SNSC_2026_EVENT,
      LIVE_SLUGS.map(regatta)
    );
    expect(defaultEventFleetKey(SNSC_2026_EVENT, slices)).toBe("optimist-gold");
  });

  it("falls back to board-class data when no DB slices matched", () => {
    const slices = resolveEventSlices(SNSC_2026_EVENT, []);
    expect(defaultEventFleetKey(SNSC_2026_EVENT, slices)).toBe("wingfoil");
  });
});
