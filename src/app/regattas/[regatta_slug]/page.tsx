import { permanentRedirect, redirect } from "next/navigation";
import { RegattaEventHub } from "@/components/RegattaEventHub";
import { regattaResultsHref } from "@/lib/classPages";
import { getRegattaBySlug } from "@/lib/queries";
import {
  eventHubHref,
  findEventSliceForRegattaSlug,
  getRegattaEvent,
} from "@/lib/regattaEvents";
import type { Metadata } from "next";

export const dynamic = "force-dynamic";

export async function generateMetadata({
  params,
}: {
  params: Promise<{ regatta_slug: string }>;
}): Promise<Metadata> {
  const { regatta_slug } = await params;
  const event = getRegattaEvent(regatta_slug);
  if (event) {
    return {
      title: `${event.name} — results | SailorPath`,
      description: `All classes at ${event.name} — ${event.slices
        .map((s) => s.label)
        .join(", ")} — standings and race scores.`,
    };
  }
  return {};
}

export default async function RegattaRedirectPage({
  params,
  searchParams,
}: {
  params: Promise<{ regatta_slug: string }>;
  searchParams: Promise<{ fleet?: string }>;
}) {
  const { regatta_slug } = await params;

  // Multi-class event hub (pilot) — one page, tab per class/division slice.
  const event = getRegattaEvent(regatta_slug);
  if (event) {
    const { fleet } = await searchParams;
    return <RegattaEventHub event={event} activeFleet={fleet ?? null} />;
  }

  const eventSlice = findEventSliceForRegattaSlug(regatta_slug);
  if (eventSlice) {
    permanentRedirect(eventHubHref(eventSlice.event.slug, eventSlice.slice.key));
  }

  if (regatta_slug === "cincapura-regatta-2026") {
    redirect("/sg/optimist/regattas/cincapura-regatta-2026-gold");
  }
  const regatta = await getRegattaBySlug(regatta_slug).catch(() => null);

  if (!regatta) {
    redirect("/calendar");
  }

  redirect(regattaResultsHref(regatta.boatClass, regatta_slug));
}
