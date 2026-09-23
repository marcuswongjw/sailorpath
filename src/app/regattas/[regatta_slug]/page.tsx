import Link from "next/link";
import { permanentRedirect, redirect } from "next/navigation";
import { RegattaEventHub } from "@/components/RegattaEventHub";
import {
  classResultsHref,
  matchCalendarResults,
} from "@/lib/calendar/calendarResultLinks";
import { SINGAPORE_REGATTAS_2026 } from "@/lib/calendar/singaporeRegattas2026";
import { getCachedPublicRegattas, getRegattaBySlug } from "@/lib/queries";
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
  const calendarEntry = SINGAPORE_REGATTAS_2026.find((entry) => entry.slug === regatta_slug);
  if (calendarEntry) {
    return {
      title: `${calendarEntry.name} — results | SailorPath`,
      description: `Published results for ${calendarEntry.name}.`,
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

  if (
    regatta_slug === "snsc-2026" ||
    regatta_slug.startsWith("singapore-national-sailing-championships-2026")
  ) {
    permanentRedirect("/regattas/snsc-2026");
  }

  const eventSlice = findEventSliceForRegattaSlug(regatta_slug);
  if (eventSlice) {
    permanentRedirect(eventHubHref(eventSlice.event.slug, eventSlice.slice.key));
  }

  const regatta = await getRegattaBySlug(regatta_slug).catch(() => null);
  if (regatta) {
    redirect(classResultsHref(regatta));
  }

  const calendarEntry = SINGAPORE_REGATTAS_2026.find((entry) => entry.slug === regatta_slug);
  const published = await getCachedPublicRegattas().catch(() => []);
  const matches = matchCalendarResults(regatta_slug, published);

  if (matches.length === 1) {
    redirect(classResultsHref(matches[0]));
  }

  const title = calendarEntry?.name || "Results are not published yet";

  return (
    <div className="mx-auto w-full max-w-3xl space-y-4 px-4 py-10">
      <h1 className="text-2xl font-black text-[var(--sp-harbour-shadow)]">{title}</h1>
      {matches.length > 1 ? (
        <>
          <p className="text-[var(--sp-charcoal)]">
            Choose a class to open the published results.
          </p>
          <ul className="space-y-2">
            {matches.map((row) => (
              <li key={row.id}>
                <Link
                  href={classResultsHref(row)}
                  className="block rounded-xl border border-[var(--sp-cool-veil)] bg-[var(--sp-warm-white)] px-4 py-3 text-[var(--sp-charcoal)] hover:border-[var(--sp-harbour-teal)]"
                >
                  <span className="block font-bold">{row.name}</span>
                  <span className="text-sm text-[var(--sp-charcoal-slate)]">
                    {[row.boatClass, row.division].filter(Boolean).join(" · ")}
                  </span>
                </Link>
              </li>
            ))}
          </ul>
        </>
      ) : (
        <p className="text-[var(--sp-charcoal)]">
          Results for this event are not on SailorPath yet.
        </p>
      )}
      <Link href="/calendar" className="inline-block font-semibold text-[var(--sp-harbour-teal)] hover:underline">
        Back to the calendar
      </Link>
    </div>
  );
}
