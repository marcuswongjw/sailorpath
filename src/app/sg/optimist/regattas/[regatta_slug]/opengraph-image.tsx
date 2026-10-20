import { renderResultShareImage, SHARE_IMAGE_SIZE } from "@/lib/og/shareImage";
import { resolveClassScorecard } from "@/lib/publicShareData";

export const runtime = "nodejs";
export const dynamic = "force-dynamic";
export const alt = "SailorPath Optimist results";
export const size = SHARE_IMAGE_SIZE;
export const contentType = "image/png";

const emptySheet = {
  regattaName: "SailorPath results",
  classLabel: "Optimist",
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
    const loaded = await resolveClassScorecard(regatta_slug, "optimist");
    if (loaded.status !== "ready") return renderResultShareImage(emptySheet);
    return renderResultShareImage(loaded.sheet);
  } catch {
    return renderResultShareImage(emptySheet);
  }
}
