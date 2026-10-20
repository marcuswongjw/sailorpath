import { renderResultShareImage, SHARE_IMAGE_SIZE } from "@/lib/og/shareImage";
import { eventHubShare } from "@/lib/publicSeo";
import { getRegattaEvent } from "@/lib/regattaEvents";

export const runtime = "nodejs";
export const dynamic = "force-dynamic";
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
  params: Promise<{ regatta_slug: string }>;
}) {
  const { regatta_slug } = await params;
  const event = getRegattaEvent(regatta_slug);
  if (!event) return renderResultShareImage(emptySheet);
  return renderResultShareImage(eventHubShare(event));
}
