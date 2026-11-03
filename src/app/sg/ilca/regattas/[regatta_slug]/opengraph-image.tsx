import { renderResultShareImage, SHARE_IMAGE_SIZE } from "@/lib/og/shareImage";
import { resolveClassScorecard } from "@/lib/publicShareData";

export const runtime = "nodejs";
export const revalidate = 3600;
export const alt = "SailorPath ILCA results";
export const size = SHARE_IMAGE_SIZE;
export const contentType = "image/png";

const emptySheet = {
  regattaName: "SailorPath results",
  classLabel: "ILCA",
  datesText: null,
  top3: [],
};

export default async function Image({
  params,
}: {
  params: Promise<{ regatta_slug: string }>;
}) {
  const { regatta_slug } = await params;
  try {
    const loaded = await resolveClassScorecard(regatta_slug, "ilca");
    if (loaded.status !== "ready") return renderResultShareImage(emptySheet);
    return renderResultShareImage(loaded.sheet, { cachePublicResult: true });
  } catch {
    return renderResultShareImage(emptySheet);
  }
}
