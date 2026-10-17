import { birthYear } from "@/lib/age";
import { renderProfileShareImage, SHARE_IMAGE_SIZE } from "@/lib/og/shareImage";
import { sailorShareModel } from "@/lib/publicSeo";
import { SAMPLE_RESULTS, SAMPLE_SAILOR } from "@/lib/sampleProfile";

export const runtime = "nodejs";
export const alt = "Kimberly Tan sailing profile on SailorPath";
export const size = SHARE_IMAGE_SIZE;
export const contentType = "image/png";

export default async function Image() {
  return renderProfileShareImage(
    sailorShareModel({
      name: SAMPLE_SAILOR.name,
      handle: SAMPLE_SAILOR.handle,
      nationality: SAMPLE_SAILOR.nationality,
      club: SAMPLE_SAILOR.club,
      birthYear: birthYear(SAMPLE_SAILOR.dob),
      results: SAMPLE_RESULTS,
      path: "/sample",
    })
  );
}
