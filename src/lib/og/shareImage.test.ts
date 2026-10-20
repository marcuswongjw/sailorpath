import { describe, expect, it } from "vitest";
import { profileShareSubtitle, renderProfileShareImage, renderResultShareImage } from "@/lib/og/shareImage";
import { resultSheetFromEventSlice, sailorShareModel } from "@/lib/publicSeo";
import { getRegattaEvent } from "@/lib/regattaEvents";
import { SAMPLE_RESULTS, SAMPLE_SAILOR } from "@/lib/sampleProfile";

describe("share images", () => {
  it("leaves the birth year out of profile image props", () => {
    const share = sailorShareModel({
      name: SAMPLE_SAILOR.name,
      handle: SAMPLE_SAILOR.handle,
      nationality: SAMPLE_SAILOR.nationality,
      club: SAMPLE_SAILOR.club,
      results: SAMPLE_RESULTS,
      path: "/sample",
    });
    expect(share).not.toHaveProperty("birthYear");
    expect(JSON.stringify(share)).not.toContain("2013");
    expect(profileShareSubtitle(share)).toBe("Singapore | Changi Sailing Club");
    expect(profileShareSubtitle(share)).not.toMatch(/\b20\d{2}\b/);
  });

  it("renders a profile card and a result card as PNG", async () => {
    const share = sailorShareModel({
      name: SAMPLE_SAILOR.name,
      handle: SAMPLE_SAILOR.handle,
      nationality: SAMPLE_SAILOR.nationality,
      club: SAMPLE_SAILOR.club,
      results: SAMPLE_RESULTS,
      path: "/sample",
    });
    const profile = await renderProfileShareImage(share);
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
