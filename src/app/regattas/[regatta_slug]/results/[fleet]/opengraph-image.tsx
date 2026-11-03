import { renderResultShareImage, SHARE_IMAGE_SIZE } from "@/lib/og/shareImage";
import { resolveFleetResultSheet } from "@/lib/publicShareData";

export const runtime = "nodejs";
export const revalidate = 3600;
export const alt = "SailorPath regatta results";
export const size = SHARE_IMAGE_SIZE;
export const contentType = "image/png";

const emptySheet = {
  regattaName: "SailorPath results",
  classLabel: "Results",
  datesText: null,
  top3: [],
};

export default async function Image({
  params,
}: {
  params: Promise<{ regatta_slug: string; fleet: string }>;
}) {
  const { regatta_slug, fleet } = await params;
  try {
    const resolved = await resolveFleetResultSheet(regatta_slug, fleet);
    if (!resolved) return renderResultShareImage(emptySheet);
    return renderResultShareImage(resolved.sheet, { cachePublicResult: true });
  } catch {
    return renderResultShareImage(emptySheet);
  }
}
