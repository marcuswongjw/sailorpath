import { toPublicSailorProps } from "@/lib/publicSailor";
import { renderProfileShareImage, SHARE_IMAGE_SIZE } from "@/lib/og/shareImage";
import { sailorShareModel } from "@/lib/publicSeo";
import { loadShareSailor, loadShareSailorResults } from "@/lib/publicShareData";

export const runtime = "nodejs";
export const dynamic = "force-dynamic";
export const alt = "SailorPath sailor profile";
export const size = SHARE_IMAGE_SIZE;
export const contentType = "image/png";

const emptyShare = sailorShareModel({ name: "Sailor", handle: "sailor", results: [] });

export default async function Image({
  params,
}: {
  params: Promise<{ sailor_handle: string }>;
}) {
  const { sailor_handle } = await params;
  try {
    const sailor = await loadShareSailor(sailor_handle);
    if (!sailor) return renderProfileShareImage(emptyShare);
    const publicSailor = toPublicSailorProps(sailor, { canSeePrivate: false });
    const results = await loadShareSailorResults(sailor.id).catch(() => []);
    return renderProfileShareImage(
      sailorShareModel({
        name: publicSailor.name,
        handle: publicSailor.handle,
        nationality: publicSailor.nationality,
        club: publicSailor.club,
        results: results.map((result) => ({
          regattaName: result.regattaName,
          regattaDate: result.regattaDate,
          boatClass: result.boatClass,
          rank: result.rank,
          isDns: result.isDns,
        })),
      })
    );
  } catch {
    return renderProfileShareImage(emptyShare);
  }
}
