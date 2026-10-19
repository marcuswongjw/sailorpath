import Link from "next/link";
import { permanentRedirect, redirect } from "next/navigation";
import { JsonLd } from "@/components/JsonLd";
import { RegattaEventHub } from "@/components/RegattaEventHub";
import {
  classResultsHref,
  matchCalendarResults,
} from "@/lib/calendar/calendarResultLinks";
import { SINGAPORE_REGATTAS_2026 } from "@/lib/calendar/singaporeRegattas2026";
import { getDatabaseUrlMeta } from "@/db";
import { withSavedEventCopy } from "@/lib/loadRegattaEventCopy";
import { resolveFleetResultSheet } from "@/lib/publicShareData";
import {
  eventHubShare,
  eventHubTitle,
  resultSheetFromEventSlice,
  shareMetadata,
  sportsEventJsonLd,
  yearFromText,
} from "@/lib/publicSeo";
import { groupedHubForSlug, savedEventHubForSlug } from "@/lib/regattaEventGroups";
import { getCachedPublicRegattas, getRegattaBySlug } from "@/lib/queries";
import {
  eventHubHref,
  findEventSliceForRegattaSlug,
  getRegattaEvent,
  type RegattaEventDef,
} from "@/lib/regattaEvents";
import type { Metadata } from "next";

export const dynamic = "force-dynamic";

function PublishedEventHub({
  event,
  activeFleet,
  calendarView,
}: {
  event: RegattaEventDef;
  activeFleet: string | null;
  calendarView: "past" | null;
}) {
  const slice = activeFleet ? event.slices.find((item) => item.key === activeFleet) : undefined;
  const sheet = slice ? resultSheetFromEventSlice(event, slice) : eventHubShare(event);
  return (
    <>
      <JsonLd data={sportsEventJsonLd(sheet)} />
      <RegattaEventHub event={event} activeFleet={activeFleet} calendarView={calendarView} />
    </>
  );
}

export async function generateMetadata({
  params,
  searchParams,
}: {
  params: Promise<{ regatta_slug: string }>;
  searchParams: Promise<{ fleet?: string }>;
}): Promise<Metadata> {
  const { regatta_slug } = await params;
  const { fleet } = await searchParams;
  try {
    if (fleet) {
      const resolved = await resolveFleetResultSheet(regatta_slug, fleet);
      if (resolved) return shareMetadata(resolved.sheet);
    }
    const direct = getRegattaEvent(regatta_slug);
    if (direct) return shareMetadata(eventHubShare(direct));
    const published = getDatabaseUrlMeta()
      ? await getCachedPublicRegattas().catch(() => [])
      : [];
    const event =
      savedEventHubForSlug(regatta_slug, published)?.event ||
      groupedHubForSlug(regatta_slug, published)?.event;
    if (event) return shareMetadata(eventHubShare(event));
    const calendarEntry = SINGAPORE_REGATTAS_2026.find((entry) => entry.slug === regatta_slug);
    if (calendarEntry) {
      return shareMetadata({
        title: eventHubTitle(calendarEntry.name, yearFromText(calendarEntry.name)),
        description: `Published results for ${calendarEntry.name}.`,
        canonicalPath: `/regattas/${calendarEntry.slug}`,
      });
    }
    return {};
  } catch {
    return {
      title: "Regatta results | SailorPath",
      description: "Published sailing results on SailorPath.",
    };
  }
}

export default async function RegattaRedirectPage({
  params,
  searchParams,
}: {
  params: Promise<{ regatta_slug: string }>;
  searchParams: Promise<{ fleet?: string; calendar?: string }>;
}) {
  const { regatta_slug } = await params;
  const { fleet, calendar } = await searchParams;
  const calendarView = calendar === "past" ? "past" : null;

  const event = getRegattaEvent(regatta_slug);
  if (event) {
    if (event.slug !== regatta_slug.toLowerCase()) {
      const query = new URLSearchParams();
      if (fleet) query.set("fleet", fleet);
      if (calendarView) query.set("calendar", calendarView);
      permanentRedirect(
        `/regattas/${event.slug}${query.size ? `?${query.toString()}` : ""}`
      );
    }
    return (
      <PublishedEventHub
        event={await withSavedEventCopy(event)}
        activeFleet={fleet ?? null}
        calendarView={calendarView}
      />
    );
  }

  const eventSlice = findEventSliceForRegattaSlug(regatta_slug);
  if (eventSlice) {
    permanentRedirect(
      eventHubHref(
        eventSlice.event.slug,
        eventSlice.slice.key,
        calendarView === "past" ? "past" : undefined
      )
    );
  }

  const published = await getCachedPublicRegattas().catch(() => []);
  const saved = savedEventHubForSlug(regatta_slug, published);
  if (saved && saved.event.slices.length > 0) {
    if (saved.event.slug !== regatta_slug.toLowerCase()) {
      permanentRedirect(
        eventHubHref(
          saved.event.slug,
          saved.fleetKey || saved.event.slices[0].key,
          calendarView === "past" ? "past" : undefined
        )
      );
    }
    return (
      <PublishedEventHub
        event={await withSavedEventCopy(saved.event)}
        activeFleet={fleet ?? saved.fleetKey}
        calendarView={calendarView}
      />
    );
  }

  const grouped = groupedHubForSlug(regatta_slug, published);
  if (grouped && grouped.event.slices.length > 1) {
    if (grouped.event.slug !== regatta_slug.toLowerCase()) {
      permanentRedirect(
        eventHubHref(
          grouped.event.slug,
          grouped.fleetKey || grouped.event.slices[0].key,
          calendarView === "past" ? "past" : undefined
        )
      );
    }
    return (
      <PublishedEventHub
        event={await withSavedEventCopy(grouped.event)}
        activeFleet={fleet ?? grouped.fleetKey}
        calendarView={calendarView}
      />
    );
  }

  const regatta = await getRegattaBySlug(regatta_slug).catch(() => null);
  if (regatta) {
    redirect(classResultsHref(regatta));
  }

  const calendarEntry = SINGAPORE_REGATTAS_2026.find((entry) => entry.slug === regatta_slug);
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
      <Link
        href={calendarView === "past" ? "/calendar?view=past" : "/calendar"}
        className="inline-block font-semibold text-[var(--sp-harbour-teal)] hover:underline"
      >
        Back to the calendar
      </Link>
    </div>
  );
}
