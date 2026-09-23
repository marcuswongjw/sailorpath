import { redirect } from "next/navigation";
import { getRegattaBySlug } from "@/lib/queries";

export const dynamic = "force-dynamic";

export default async function RegattaRedirectPage({
  params,
}: {
  params: Promise<{ regatta_slug: string }>;
}) {
  const { regatta_slug } = await params;
  if (regatta_slug === "cincapura-regatta-2026") {
    redirect("/sg/optimist/regattas/cincapura-regatta-2026-gold");
  }
  const regatta = await getRegattaBySlug(regatta_slug).catch(() => null);

  if (!regatta) {
    redirect("/calendar");
  }

  if (regatta.boatClass === "ILCA 4") {
    redirect(`/sg/ilca4/regattas/${encodeURIComponent(regatta_slug)}`);
  }

  redirect(`/sg/optimist/regattas/${encodeURIComponent(regatta_slug)}`);
}
