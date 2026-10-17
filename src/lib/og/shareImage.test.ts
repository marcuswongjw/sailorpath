import { describe, expect, it } from "vitest";
import { renderProfileShareImage, renderResultShareImage } from "@/lib/og/shareImage";
import { sailorShareModel } from "@/lib/publicSeo";
import { getRegattaEvent } from "@/lib/regattaEvents";
import { resultSheetFromEventSlice } from "@/lib/publicSeo";
import { SAMPLE_RESULTS, SAMPLE_SAILOR } from "@/lib/sampleProfile";

describe("share images", () => {
  it("renders a profile card and a result card as PNG", async () => {
    const profile = await renderProfileShareImage(
      sailorShareModel({
        name: SAMPLE_SAILOR.name,
        handle: SAMPLE_SAILOR.handle,
        nationality: SAMPLE_SAILOR.nationality,
        club: SAMPLE_SAILOR.club,
        results: SAMPLE_RESULTS,
        path: "/sample",
      })
    );
    const event = getRegattaEvent("snsc-2025")!;
    const slice = event.slices.find((item) => item.key === "optimist-gold")!;
    const result = await renderResultShareImage(
      resultSheetFromEventSlice(event, slice, [
        { rank: 1, name: "Ada Lim", handle: "ada-lim" },
        { rank: 2, name: "Bo Tan", handle: null },
        { rank: 3, name: "Cai Ng", handle: null },
      ])
    );
    for (const image of [profile, result]) {
      const bytes = new Uint8Array(await image.arrayBuffer());
      expect(bytes.byteLength).toBeGreaterThan(1000);
      expect(String.fromCharCode(...bytes.slice(0, 8))).toBe("\x89PNG\r\n\x1a\n");
    }
  }, 20000);
});
