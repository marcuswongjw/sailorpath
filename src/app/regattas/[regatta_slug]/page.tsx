import Link from "next/link";
import { DbOffline } from "@/components/DbOffline";
import { RegattaOverview, formatRegattaDates, regattaTimelineStatus } from "@/components/RegattaOverview";
import { PENDING_REGATTAS } from "@/lib/calendar/pendingRegattas";
import { getPublicCalendarData } from "@/lib/calendar/publicCalendar";
import { RegattasBackLink } from "@/components/RegattasBackLink";
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
  resultSheetFromEventSlice,
  shareMetadata,
  sportsEventJsonLd,
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
        title: `${calendarEntry.name} | SailorPath`,
        description: `Dates, venue, classes and official event information for ${calendarEntry.name}.`,
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

  const pending = PENDING_REGATTAS.find((entry) => entry.slug === regatta_slug);
  if (pending) {
    return <div className="mx-auto w-full max-w-6xl space-y-7 px-4 py-8 sm:py-10">
      <RegattaOverview name={pending.name} dates={`${pending.year} · Dates to be confirmed`} venue={pending.venue} organiser={pending.organizer} classes={[pending.boatClass]} region={pending.region} status="Dates TBC" websiteUrl={pending.officialUrl} />
      <section className="border-t border-[var(--sp-cool-veil)] pt-6"><h2 className="mb-3 text-lg font-bold text-[var(--sp-harbour-shadow)]">Fleet results</h2><p className="text-sm text-[var(--sp-charcoal-slate)]">Exact event dates are awaiting confirmation from the organiser.</p></section>
    </div>;
  }

  // Use the calendar inventory so saved overrides and deletions stay authoritative.
  let calendarEvent;
  try {
    calendarEvent = (await getPublicCalendarData()).allRegattas.find((entry) => entry.slug === regatta_slug);
  } catch {
    if (calendarEntry) return <DbOffline title="Event information is temporarily unavailable" />;
  }
  if (calendarEvent) {
    return <div className="mx-auto w-full max-w-6xl space-y-7 px-4 py-8 sm:py-10">
      <RegattaOverview name={calendarEvent.name} dates={formatRegattaDates(calendarEvent.date, calendarEvent.endDate)} venue={calendarEvent.venue} organiser={calendarEvent.organizer} classes={calendarEvent.classes?.length ? calendarEvent.classes : [calendarEvent.boatClass || ""]} region={calendarEvent.region} status={regattaTimelineStatus(calendarEvent.date, calendarEvent.endDate)} registrationUrl={calendarEvent.registrationUrl} noticeBoardUrl={calendarEvent.norUrl} keyDeadlines={calendarEvent.keyDeadlines} summary={calendarEvent.scheduleNotes} backHref={calendarView === "past" ? "/calendar?view=past" : "/calendar"} calendarEvent={{ slug: calendarEvent.slug, name: calendarEvent.name, startDate: calendarEvent.date, endDate: calendarEvent.endDate, venue: calendarEvent.venue }} />
      <section aria-label="Fleet results" className="space-y-4 border-t border-[var(--sp-cool-veil)] pt-6">
        <h2 className="text-lg font-bold text-[var(--sp-harbour-shadow)]">Fleet results</h2>
        {matches.length > 1 ? <ul className="grid gap-3 sm:grid-cols-2">{matches.map((row) => <li key={row.id}><Link href={classResultsHref(row)} className="block rounded-xl border border-[var(--sp-cool-veil)] bg-[var(--sp-warm-white)] p-4 font-semibold text-[var(--sp-harbour-teal)] hover:underline">{[row.boatClass, row.division].filter(Boolean).join(" · ")} →</Link></li>)}</ul> : <div className="rounded-xl bg-[var(--sp-aqua-mist)] p-5"><p className="font-semibold text-[var(--sp-harbour-shadow)]">Results will appear here once published.</p><p className="mt-1 text-sm text-[var(--sp-charcoal-slate)]">Each fleet will have a direct link to its scorecard.</p></div>}
      </section>
    </div>;
  }

  const title = "Results are not published yet";

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
      <RegattasBackLink
        href={calendarView === "past" ? "/calendar?view=past" : "/calendar"}
        className="inline-block font-semibold text-[var(--sp-harbour-teal)] hover:underline"
      >
        Back to regattas
      </RegattasBackLink>
    </div>
  );
}
