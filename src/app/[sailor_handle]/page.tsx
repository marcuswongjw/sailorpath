import { notFound, permanentRedirect } from "next/navigation";
import { DbOffline } from "@/components/DbOffline";
import { DbUnavailableError } from "@/db";
import { getCachedSailorByHandle } from "@/lib/queries";

/**
 * Compatibility boundary for the former root-level sailor URL. Static routes
 * resolve before this dynamic segment; verified sailor handles move to the
 * canonical, namespaced public profile route.
 */
export default async function LegacySailorHandlePage({
  params,
}: {
  params: Promise<{ sailor_handle: string }>;
}) {
  const { sailor_handle } = await params;
  let sailor;
  try {
    sailor = await getCachedSailorByHandle(sailor_handle);
  } catch (error) {
    return (
      <DbOffline
        message={error instanceof DbUnavailableError ? error.message : "DB error"}
      />
    );
  }
  if (!sailor) notFound();
  permanentRedirect(`/sailors/${encodeURIComponent(sailor.handle)}`);
}
