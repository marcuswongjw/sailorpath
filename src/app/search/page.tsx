import { permanentRedirect } from "next/navigation";
import { legacySearchHref } from "@/lib/publicRouteRedirects";

/** Legacy browse-search entry point. Quick search remains available in the header. */
export default async function LegacySearchPage({ searchParams }: { searchParams: Promise<Record<string, string | string[] | undefined>> }) {
  const params = await searchParams;
  permanentRedirect(legacySearchHref(params));
}
