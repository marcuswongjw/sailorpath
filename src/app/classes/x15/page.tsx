import type { Metadata } from "next";
import Link from "next/link";
import {
  CalendarDays,
  ExternalLink,
  MapPin,
  ArrowRight,
  Award,
  Globe,
  CheckCircle2,
  ChevronDown,
  Sparkles,
} from "lucide-react";
import { getCachedPublicRegattas } from "@/lib/queries";
import { directoryFromPublished } from "@/lib/regattaDirectory";
import {
  X15_AGM_2026,
  X15_ASIANS_2026,
  X15_EQUIPMENT_OVERVIEW,
  X15_HISTORY,
  X15_NATIONAL_ASSOCIATIONS,
  X15_QUICK_FACTS,
  X15_SOURCE_CHECKED_ON,
  X15_WORLDS_2026,
  publishedX15Sheets,
  x15WorldsStatus,
} from "@/lib/x15";
import { X15_LISTINGS, X15_OFFICIAL_CALENDAR_URL } from "@/lib/x15Calendar";

export const revalidate = 3600;
export const metadata: Metadata = {
  title: "X-15 wingfoil racing, events & results | SailorPath",
  description: "Follow X-15 one-design wingfoil racing: the 2026 Ibiza Worlds, Asian Cup & Championships, 2026–2027 international calendar, one-design equipment rules and reviewed results.",
  alternates: { canonical: "/classes/x15" },
  robots: { index: true, follow: true },
};

function OfficialLink({ href, children }: { href: string; children: React.ReactNode }) {
  return (
    <a
      href={href}
      target="_blank"
      rel="noopener noreferrer"
      className="inline-flex items-center gap-1.5 text-sm font-semibold text-harbour hover:underline focus-visible:outline-2 focus-visible:outline-offset-4"
    >
      <span>{children}</span>
      <ExternalLink aria-hidden="true" className="h-3.5 w-3.5 shrink-0" />
    </a>
  );
}

export default async function X15ClassHub() {
  let available = true;
  let sheets: ReturnType<typeof publishedX15Sheets> = [];
  try {
    sheets = publishedX15Sheets(await getCachedPublicRegattas());
  } catch {
    available = false;
  }
  const results = directoryFromPublished(sheets);
  const worlds = X15_WORLDS_2026;
  const today = new Intl.DateTimeFormat("en-CA", {
    timeZone: "Europe/Madrid",
    year: "numeric",
    month: "2-digit",
    day: "2-digit",
  }).format(new Date());
  const status = x15WorldsStatus(today, sheets.some((row) => row.eventSlug === worlds.eventSlug));
  const confirmedEvents = X15_LISTINGS.filter((item) => item.startDate);
  const provisionalEvents = X15_LISTINGS.filter((item) => !item.startDate);

  return (
    <main className="mx-auto max-w-6xl space-y-12 px-4 py-8 sm:px-6 sm:py-12">
      {/* HERO & QUICK FACTS */}
      <header className="overflow-hidden rounded-3xl border border-harbour/15 bg-harbour-shadow text-sailcloth shadow-md">
        <div className="grid gap-8 px-6 py-8 sm:px-10 sm:py-10 lg:grid-cols-[1.08fr_1fr] lg:items-center">
          <div>
            <div className="flex flex-wrap items-center gap-3">
              {/* eslint-disable-next-line @next/next/no-img-element -- Self-hosted class wordmark with explicit dimensions */}
              <img
                src="/classes/x15/x15-logo-white.png"
                alt="International X-15 Class logo"
                width="152"
                height="40"
                className="h-8 w-auto object-contain"
              />
              <span className="rounded-full border border-soft-aqua/30 bg-white/10 px-3 py-1 text-xs font-bold uppercase tracking-[0.14em] text-soft-aqua">
                World Sailing One-Design Wingfoil
              </span>
            </div>

            <h1 className="mt-4 text-3xl font-black tracking-tight sm:text-5xl">
              Follow the X-15 class
            </h1>
            <p className="mt-4 max-w-xl text-base leading-7 text-soft-aqua">
              Official events, one-design equipment rules, national associations and race results for riders, families and coaches. Follow the inaugural World Championships in Ibiza ({worlds.confirmedFleetSummary}) and the 2026–2027 international circuit.
            </p>

            <nav aria-label="On this X-15 page" className="mt-6 flex flex-wrap gap-2.5 text-xs font-bold sm:text-sm">
              {[
                ["#results", "Race results"],
                ["#events", "2026 championships"],
                ["#calendar", "2026–2027 calendar"],
                ["#equipment", "Equipment & divisions"],
                ["#about-class", "Class story & nations"],
              ].map(([href, label]) => (
                <a
                  key={href}
                  href={href}
                  className="rounded-xl border border-soft-aqua/30 bg-white/10 px-3.5 py-2 text-sailcloth transition hover:border-soft-aqua hover:bg-white/15 focus-visible:outline-2 focus-visible:outline-offset-4"
                >
                  {label}
                </a>
              ))}
            </nav>
          </div>

          <div className="overflow-hidden rounded-2xl border border-soft-aqua/25 bg-white/5 shadow-inner">
            <div className="relative aspect-[3/2] w-full overflow-hidden bg-harbour">
              {/* eslint-disable-next-line @next/next/no-img-element -- LCP hero image with explicit dimensions and high fetchpriority */}
              <img
                src="/classes/x15/ibiza-worlds-2026.jpg"
                alt="X-15 wingfoil racers foiling upwind side-by-side on red one-design Starboard X-15 82L boards"
                fetchPriority="high"
                width="1200"
                height="800"
                className="h-full w-full object-cover"
              />
              <div className="absolute inset-0 bg-gradient-to-t from-harbour-shadow/90 via-harbour-shadow/25 to-transparent" />
              <div className="absolute top-3 left-3 flex flex-wrap items-center gap-2">
                <span className="rounded-full bg-soft-aqua px-3 py-1 text-xs font-bold text-harbour-shadow shadow-xs">
                  {status}
                </span>
                <span className="rounded-full bg-harbour-shadow/85 px-3 py-1 text-xs font-semibold text-sailcloth backdrop-blur-xs">
                  107 riders · 24 nations
                </span>
              </div>
              <div className="absolute right-4 bottom-3 left-4">
                <h2 className="text-lg font-black text-sailcloth sm:text-xl">{worlds.name}</h2>
                <div className="mt-1 flex flex-wrap items-center gap-x-4 gap-y-1 text-xs font-semibold text-soft-aqua sm:text-sm">
                  <span className="inline-flex items-center gap-1.5">
                    <CalendarDays aria-hidden="true" className="h-4 w-4 shrink-0" />
                    {worlds.dates}
                  </span>
                  <span className="inline-flex items-center gap-1.5">
                    <MapPin aria-hidden="true" className="h-4 w-4 shrink-0" />
                    {worlds.venue}
                  </span>
                </div>
              </div>
            </div>

            <div className="flex flex-wrap items-center justify-between gap-3 p-4">
              <p className="text-xs text-soft-aqua/90">
                Hosted by {worlds.organiser} · 5 World Championship titles
              </p>
              <a
                href={worlds.websiteUrl}
                target="_blank"
                rel="noopener noreferrer"
                className="inline-flex items-center gap-2 rounded-xl bg-soft-aqua px-4 py-2 text-xs font-bold text-harbour-shadow transition hover:bg-sailcloth focus-visible:outline-2 focus-visible:outline-offset-4 sm:text-sm"
              >
                Official Worlds information
                <ExternalLink aria-hidden="true" className="h-3.5 w-3.5" />
              </a>
            </div>
          </div>
        </div>

        {/* AT-A-GLANCE QUICK FACTS BAR */}
        <dl
          aria-label="X-15 class quick facts"
          className="grid gap-px border-t border-soft-aqua/15 bg-soft-aqua/15 sm:grid-cols-2 lg:grid-cols-4"
        >
          {X15_QUICK_FACTS.map((fact) => (
            <div key={fact.label} className="bg-harbour-shadow/95 px-6 py-4">
              <dt className="text-[11px] font-bold uppercase tracking-wider text-soft-aqua/80">
                {fact.label}
              </dt>
              <dd className="mt-1 text-base font-black text-sailcloth">{fact.value}</dd>
              <dd className="mt-0.5 text-xs text-soft-aqua/75">{fact.detail}</dd>
            </div>
          ))}
        </dl>
      </header>

      {/* RACE RESULTS SECTION */}
      <section id="results" aria-labelledby="x15-results-heading" className="scroll-mt-24 space-y-4">
        <div className="flex flex-wrap items-end justify-between gap-3">
          <div>
            <p className="text-xs font-bold uppercase tracking-wider text-harbour">On the water</p>
            <h2 id="x15-results-heading" className="mt-1 text-2xl font-black text-harbour-shadow">
              Race results
            </h2>
          </div>
          <p className="rounded-full bg-aqua-mist px-3 py-1 text-xs font-bold text-harbour">
            Event placings · kept separate from open WingFoil &amp; national dinghy rankings
          </p>
        </div>

        {!available ? (
          <div role="status" className="rounded-2xl border border-cool-veil bg-warm-white p-6">
            <p className="font-bold text-harbour-shadow">Results are temporarily unavailable</p>
            <p className="mt-2 text-sm text-slate-soft">The event guide is still available below.</p>
            {/* eslint-disable-next-line @next/next/no-html-link-for-pages -- A full document request retries a failed server-side results load. */}
            <a href="/classes/x15#results" className="mt-3 inline-block text-sm font-bold text-harbour hover:underline">
              Try loading results again
            </a>
          </div>
        ) : results.length ? (
          <div className="grid gap-4 sm:grid-cols-2">
            {results.map((event) => (
              <article key={event.slug} className="rounded-2xl border border-cool-veil bg-warm-white p-5 shadow-2xs">
                <p className="text-xs font-semibold text-slate-soft">{event.date}</p>
                <h3 className="mt-2 text-lg font-bold text-harbour-shadow">{event.name}</h3>
                <ul className="mt-4 space-y-2">
                  {event.fleets?.map((fleet) => (
                    <li key={fleet.id}>
                      <Link href={fleet.href} className="inline-flex items-center gap-2 text-sm font-bold text-harbour hover:underline">
                        {fleet.label}
                        <ArrowRight aria-hidden="true" className="h-4 w-4" />
                      </Link>
                    </li>
                  ))}
                </ul>
              </article>
            ))}
          </div>
        ) : (
          <div className="grid gap-6 rounded-2xl border border-cool-veil bg-aqua-mist p-6 sm:p-8 lg:grid-cols-[1.35fr_1fr] lg:items-center">
            <div>
              <h3 className="text-lg font-bold text-harbour-shadow">
                {status === "Upcoming"
                  ? "Worlds racing starts on 4 November"
                  : status === "Racing window"
                    ? "Worlds racing is scheduled for 4–8 November"
                    : "Worlds results are awaiting review"}
              </h3>
              <p className="mt-2 max-w-2xl text-sm leading-6 text-charcoal">
                No reviewed X-15 scorecards are published on SailorPath yet. Official race scores, category placings and rider profile links will appear here as results are reviewed.
              </p>
              <div className="mt-4 flex flex-wrap items-center gap-4">
                <OfficialLink href={worlds.websiteUrl}>Check the organiser’s latest updates</OfficialLink>
                <Link href="/calendar?class=x15" className="inline-flex items-center gap-1.5 text-sm font-bold text-harbour hover:underline">
                  Browse X-15 regatta calendar <ArrowRight aria-hidden="true" className="h-4 w-4" />
                </Link>
              </div>
            </div>
            <div className="rounded-xl border border-cool-veil bg-warm-white p-4 text-xs leading-5 text-charcoal">
              <p className="font-bold text-harbour-shadow">How SailorPath handles X-15 results</p>
              <ul className="mt-2 space-y-1.5 text-slate-soft">
                <li className="flex items-start gap-2">
                  <CheckCircle2 aria-hidden="true" className="mt-0.5 h-3.5 w-3.5 shrink-0 text-harbour" />
                  <span>Each official division (Senior, U19, U17, U15, U13) is preserved as published by the race committee.</span>
                </li>
                <li className="flex items-start gap-2">
                  <CheckCircle2 aria-hidden="true" className="mt-0.5 h-3.5 w-3.5 shrink-0 text-harbour" />
                  <span>Verified against official final result sheets before appearing on rider profiles.</span>
                </li>
              </ul>
            </div>
          </div>
        )}
      </section>

      {/* 2026 CHAMPIONSHIP & CLINIC GUIDE */}
      <section id="events" aria-labelledby="x15-events-heading" className="scroll-mt-24 space-y-5">
        <div className="flex flex-wrap items-end justify-between gap-3">
          <div>
            <p className="text-xs font-bold uppercase tracking-wider text-harbour">Major 2026 showcases</p>
            <h2 id="x15-events-heading" className="mt-1 text-2xl font-black text-harbour-shadow">
              2026 championship &amp; clinic guide
            </h2>
          </div>
          <p className="text-xs text-slate-soft">Sources checked {X15_SOURCE_CHECKED_ON}</p>
        </div>

        <div className="grid gap-6 md:grid-cols-2">
          {/* IBIZA WORLDS CARD */}
          <article className="flex flex-col justify-between overflow-hidden rounded-2xl border border-cool-veil bg-warm-white shadow-2xs">
            <div>
              <div className="relative aspect-[16/9] w-full overflow-hidden bg-harbour-shadow">
                {/* eslint-disable-next-line @next/next/no-img-element -- Below-the-fold event card image with lazy loading and explicit dimensions */}
                <img
                  src="/classes/x15/asian-training-fleet.jpg"
                  alt="Four X-15 wingfoil racers foiling in close formation during championship racing"
                  loading="lazy"
                  width="1200"
                  height="1060"
                  className="h-full w-full object-cover"
                />
                <div className="absolute top-3 left-3 flex flex-wrap gap-2">
                  <span className="rounded-lg bg-harbour-shadow/90 px-2.5 py-1 text-xs font-bold text-sailcloth backdrop-blur-xs">
                    Spain · Worlds
                  </span>
                  <span className="rounded-lg bg-soft-aqua px-2.5 py-1 text-xs font-bold text-harbour-shadow">
                    Inaugural World Championship
                  </span>
                </div>
              </div>

              <div className="p-5 sm:p-6">
                <h3 className="text-xl font-black text-harbour-shadow">{worlds.name}</h3>
                <dl className="mt-3 grid grid-cols-2 gap-3 rounded-xl bg-aqua-mist/50 p-3 text-xs">
                  <div>
                    <dt className="font-bold text-slate-soft">Dates</dt>
                    <dd className="mt-0.5 font-bold text-charcoal">{worlds.dates}</dd>
                  </div>
                  <div>
                    <dt className="font-bold text-slate-soft">Venue &amp; Host</dt>
                    <dd className="mt-0.5 font-semibold text-charcoal">
                      {worlds.venue} · {worlds.organiser}
                    </dd>
                  </div>
                </dl>

                <p className="mt-4 text-sm leading-6 text-charcoal">
                  Registration opened on 4 November, with racing scheduled through 8 November for {worlds.confirmedFleetSummary}.
                </p>

                <p className="mt-4 text-xs font-bold uppercase tracking-wider text-slate-soft">
                  World titles announced by the class
                </p>
                <ul className="mt-2 flex flex-wrap gap-1.5">
                  {worlds.advertisedTitles.map((title) => (
                    <li
                      key={title}
                      className="rounded-lg border border-cool-veil bg-aqua-mist px-2.5 py-1 text-xs font-semibold text-harbour"
                    >
                      {title}
                    </li>
                  ))}
                </ul>
                <p className="mt-2.5 text-xs text-slate-soft">
                  Masters and additional youth/junior divisions have separate championship awards.
                </p>
              </div>
            </div>

            <div className="space-y-2.5 border-t border-cool-veil/70 bg-aqua-mist/25 px-5 py-4 sm:px-6">
              <div className="flex flex-wrap items-center justify-between gap-2">
                <OfficialLink href={worlds.websiteUrl}>Event information and official documents</OfficialLink>
                <Link href={`/regattas/${worlds.eventSlug}`} className="text-xs font-bold text-harbour hover:underline">
                  SailorPath event page →
                </Link>
              </div>
              <div className="flex flex-wrap gap-x-5 gap-y-1.5">
                <OfficialLink href={worlds.fleetReportUrl}>107-sailor fleet announcement (24 nations)</OfficialLink>
                <OfficialLink href={worlds.noticeUrl}>Class entry guidance</OfficialLink>
              </div>
            </div>
          </article>

          {/* THAILAND ASIAN CUP & EMERGING NATIONS CLINIC CARD */}
          <article className="flex flex-col justify-between overflow-hidden rounded-2xl border border-cool-veil bg-warm-white shadow-2xs">
            <div>
              <div className="relative aspect-[16/9] w-full overflow-hidden bg-harbour-shadow">
                {/* eslint-disable-next-line @next/next/no-img-element -- Below-the-fold event card image with lazy loading and explicit dimensions */}
                <img
                  src="/classes/x15/jomtien-pattaya-lineup.jpg"
                  alt="Four X-15 wingfoil riders foiling in line off the Jomtien Beach skyline in Pattaya, Thailand"
                  loading="lazy"
                  width="1200"
                  height="799"
                  className="h-full w-full object-cover"
                />
                <div className="absolute top-3 left-3 flex flex-wrap gap-2">
                  <span className="rounded-lg bg-harbour-shadow/90 px-2.5 py-1 text-xs font-bold text-sailcloth backdrop-blur-xs">
                    Thailand · Asia
                  </span>
                  <span className="rounded-lg bg-soft-aqua px-2.5 py-1 text-xs font-bold text-harbour-shadow">
                    Updated December Dates
                  </span>
                </div>
              </div>

              <div className="p-5 sm:p-6">
                <h3 className="text-xl font-black text-harbour-shadow">{X15_ASIANS_2026.name}</h3>
                <dl className="mt-3 grid grid-cols-2 gap-3 rounded-xl bg-aqua-mist/50 p-3 text-xs">
                  <div>
                    <dt className="font-bold text-slate-soft">Racing Window</dt>
                    <dd className="mt-0.5 font-bold text-charcoal">{X15_ASIANS_2026.dates}</dd>
                  </div>
                  <div>
                    <dt className="font-bold text-slate-soft">Clinic &amp; Training</dt>
                    <dd className="mt-0.5 font-bold text-harbour">
                      {X15_ASIANS_2026.training} · {X15_ASIANS_2026.clinicName}
                    </dd>
                  </div>
                </dl>

                <p className="mt-3 flex items-center gap-1.5 text-xs font-semibold text-slate-soft">
                  <MapPin aria-hidden="true" className="h-3.5 w-3.5 shrink-0 text-harbour" />
                  {X15_ASIANS_2026.venue}
                </p>

                <p className="mt-3 text-sm leading-6 text-charcoal">
                  The official class calendar lists an updated December window at Amara Watersports Club: a three-day{" "}
                  <strong>{X15_ASIANS_2026.clinicName}</strong> (15–17 December, clinic enquiries via{" "}
                  <a href={`mailto:${X15_ASIANS_2026.clinicContactEmail}`} className="font-semibold text-harbour underline">
                    {X15_ASIANS_2026.clinicContactEmail}
                  </a>
                  ) leads directly into three days of racing (18–20 December). The organiser’s registration form covers clinic sign-up, equipment charter and race entry; riders under 18 require guardian consent.
                </p>
              </div>
            </div>

            <div className="space-y-2.5 border-t border-cool-veil/70 bg-aqua-mist/25 px-5 py-4 sm:px-6">
              <div className="flex flex-wrap items-center justify-between gap-2">
                <OfficialLink href={X15_ASIANS_2026.registrationUrl}>Registration and clinic information</OfficialLink>
                <Link href="/regattas/x15-asian-cup-2026" className="text-xs font-bold text-harbour hover:underline">
                  SailorPath event page →
                </Link>
              </div>
              <div className="flex flex-wrap gap-x-5 gap-y-1.5">
                <OfficialLink href={X15_ASIANS_2026.sourceUrl}>Japan WingFoil Association event notice</OfficialLink>
              </div>
            </div>
          </article>
        </div>

        {/* GOVERNANCE CALLOUT */}
        <article className="rounded-2xl border border-cool-veil bg-warm-white p-5">
          <div className="flex flex-wrap items-center justify-between gap-4">
            <div className="space-y-1">
              <p className="text-xs font-bold uppercase tracking-wider text-harbour">
                Class governance · {X15_AGM_2026.date}
              </p>
              <h3 className="text-base font-bold text-harbour-shadow">{X15_AGM_2026.title}</h3>
              <p className="text-sm text-charcoal">
                Online Annual General Meeting covering class rule updates, Executive Committee elections, Class President and Sustainability Lead appointments.
              </p>
            </div>
            <OfficialLink href={X15_AGM_2026.noticeUrl}>Official AGM notice</OfficialLink>
          </div>
        </article>
      </section>

      {/* 2026–2027 INTERNATIONAL CIRCUIT CALENDAR */}
      <section id="calendar" aria-labelledby="x15-calendar-heading" className="scroll-mt-24 space-y-6">
        <div className="flex flex-wrap items-end justify-between gap-3">
          <div>
            <p className="text-xs font-bold uppercase tracking-wider text-harbour">International circuit</p>
            <h2 id="x15-calendar-heading" className="mt-1 text-2xl font-black text-harbour-shadow">
              Upcoming X-15 events (2026–2027)
            </h2>
            <p className="mt-1 text-sm text-slate-soft">
              Synced from the official International X-15 Class calendar. Events with confirmed dates link directly to full SailorPath regatta pages.
            </p>
          </div>
          <div className="flex flex-wrap items-center gap-4">
            <Link
              href="/calendar?class=x15"
              className="inline-flex items-center gap-1.5 rounded-xl bg-harbour px-4 py-2 text-xs font-bold text-sailcloth transition hover:bg-harbour-shadow sm:text-sm"
            >
              Filter in Regatta Calendar <ArrowRight aria-hidden="true" className="h-4 w-4" />
            </Link>
            <OfficialLink href={X15_OFFICIAL_CALENDAR_URL}>Official X-15 events page</OfficialLink>
          </div>
        </div>

        {/* CONFIRMED DATES GRID */}
        <div className="space-y-3">
          <div className="flex items-center justify-between">
            <h3 className="text-base font-bold text-harbour-shadow">
              Confirmed event dates ({confirmedEvents.length})
            </h3>
            <span className="text-xs text-slate-soft">Click any event for schedule &amp; Notice of Race links</span>
          </div>
          <div className="grid gap-3.5 sm:grid-cols-2 lg:grid-cols-3">
            {confirmedEvents.map((event) => (
              <article
                key={event.slug}
                className="flex flex-col justify-between rounded-2xl border border-cool-veil bg-warm-white p-4 transition hover:border-harbour/60 hover:shadow-xs"
              >
                <div>
                  <div className="flex items-center justify-between gap-2">
                    <span className="inline-flex items-center gap-1 rounded-md bg-aqua-mist px-2.5 py-0.5 text-xs font-bold text-harbour">
                      <CalendarDays aria-hidden="true" className="h-3 w-3" />
                      {event.period}
                    </span>
                    <span className="text-xs font-semibold text-slate-soft">{event.region}</span>
                  </div>
                  <h4 className="mt-2.5 text-base font-bold text-harbour-shadow">
                    <Link href={`/regattas/${event.slug}`} className="hover:underline">
                      {event.name}
                    </Link>
                  </h4>
                  <p className="mt-1.5 flex items-start gap-1.5 text-xs text-slate-soft">
                    <MapPin aria-hidden="true" className="mt-0.5 h-3.5 w-3.5 shrink-0 text-harbour" />
                    <span>{event.venue}</span>
                  </p>
                </div>
                <div className="mt-4 flex flex-wrap items-center justify-between gap-2 border-t border-cool-veil/60 pt-3 text-xs">
                  <Link href={`/regattas/${event.slug}`} className="font-bold text-harbour hover:underline">
                    Event overview →
                  </Link>
                  {event.registrationUrl ? (
                    <a
                      href={event.registrationUrl}
                      target="_blank"
                      rel="noopener noreferrer"
                      className="rounded-lg bg-aqua-mist px-2.5 py-1 font-bold text-harbour hover:bg-soft-aqua/40"
                    >
                      Register ↗
                    </a>
                  ) : null}
                </div>
              </article>
            ))}
          </div>
        </div>

        {/* PROVISIONAL 2027 CALENDAR DISCLOSURE (REDUCES SCROLL FATIGUE WHILE PRESERVING FULL HTML & FIND-IN-PAGE) */}
        <details className="group rounded-2xl border border-cool-veil bg-warm-white p-5">
          <summary className="flex cursor-pointer list-none flex-wrap items-center justify-between gap-3">
            <div>
              <div className="flex flex-wrap items-center gap-2">
                <h3 className="text-base font-bold text-harbour-shadow">
                  2027 provisional calendar — month or exact dates TBC
                </h3>
                <span className="rounded-full bg-aqua-mist px-2.5 py-0.5 text-xs font-bold text-harbour">
                  {provisionalEvents.length} provisional stops
                </span>
              </div>
              <p className="mt-1 text-xs text-slate-soft">
                Includes 2027 World Championships (Soma Bay, Egypt), European Championships (Ibiza), X-15 Games Malaysia (Langkawi), Hong Kong, Thailand, Italy, UK and America One Racing Foiling Tour stops.
              </p>
            </div>
            <span className="inline-flex items-center gap-1.5 rounded-xl border border-cool-veil bg-aqua-mist/40 px-3 py-1.5 text-xs font-bold text-harbour">
              <span>Show all {provisionalEvents.length} provisional events</span>
              <ChevronDown aria-hidden="true" className="h-4 w-4 transition-transform group-open:rotate-180" />
            </span>
          </summary>

          <div className="mt-5 grid gap-3 border-t border-cool-veil pt-5 sm:grid-cols-2 lg:grid-cols-3">
            {provisionalEvents.map((event) => (
              <article key={event.slug} className="rounded-xl border border-cool-veil/80 bg-aqua-mist/20 p-3.5">
                <div className="flex items-center justify-between gap-2">
                  <span className="text-xs font-bold text-harbour">{event.period}</span>
                  <span className="rounded-md bg-warm-white px-2 py-0.5 text-[11px] font-semibold text-slate-soft">
                    {event.region}
                  </span>
                </div>
                <h4 className="mt-1.5 text-sm font-bold text-harbour-shadow">
                  <Link href={`/regattas/${event.slug}`} className="hover:underline">
                    {event.name}
                  </Link>
                </h4>
                <p className="mt-1 text-xs text-slate-soft">{event.venue}</p>
              </article>
            ))}
          </div>
        </details>
      </section>

      {/* ONE-DESIGN EQUIPMENT & DIVISIONS SECTION */}
      <section id="equipment" aria-labelledby="x15-equipment-heading" className="scroll-mt-24 space-y-6">
        <div className="flex flex-wrap items-end justify-between gap-3">
          <div>
            <p className="text-xs font-bold uppercase tracking-wider text-harbour">Strict one-design hardware</p>
            <h2 id="x15-equipment-heading" className="mt-1 text-2xl font-black text-harbour-shadow">
              Official X-15 equipment &amp; division setup
            </h2>
            <p className="mt-1 max-w-2xl text-sm text-slate-soft">
              Every rider competes on the same 82-litre board platform and modular foil system, scaling wing area and mast construction by age and gender division.
            </p>
          </div>
          <div className="flex flex-wrap gap-4">
            <OfficialLink href={X15_EQUIPMENT_OVERVIEW.equipmentUrl}>Official equipment guide</OfficialLink>
            <OfficialLink href={X15_EQUIPMENT_OVERVIEW.rulesUrl}>Class rules &amp; constitution</OfficialLink>
          </div>
        </div>

        {/* 3 VISUAL HARDWARE CARDS */}
        <div className="grid gap-5 md:grid-cols-3">
          {X15_EQUIPMENT_OVERVIEW.hardwareCards.map((card) => (
            <article
              key={card.title}
              className="flex flex-col overflow-hidden rounded-2xl border border-cool-veil bg-warm-white shadow-2xs"
            >
              <div className="aspect-square w-full overflow-hidden bg-sailcloth">
                {/* eslint-disable-next-line @next/next/no-img-element -- Self-hosted equipment image with lazy loading and explicit square dimensions */}
                <img
                  src={card.imageSrc}
                  alt={card.imageAlt}
                  loading="lazy"
                  width={card.width}
                  height={card.height}
                  className="h-full w-full object-cover"
                />
              </div>
              <div className="flex flex-1 flex-col justify-between p-5">
                <div>
                  <p className="text-xs font-bold uppercase tracking-wider text-harbour">{card.subtitle}</p>
                  <h3 className="mt-1 text-lg font-black text-harbour-shadow">{card.title}</h3>
                  <p className="mt-2 text-xs leading-5 text-charcoal">{card.description}</p>
                </div>
              </div>
            </article>
          ))}
        </div>

        {/* DIVISION-BY-DIVISION MATRIX CARDS */}
        <div className="rounded-2xl border border-cool-veil bg-warm-white p-5 sm:p-6">
          <div className="flex flex-wrap items-center justify-between gap-2">
            <div>
              <h3 className="text-lg font-black text-harbour-shadow">
                Allowed wing sizes &amp; mast by division
              </h3>
              <p className="mt-1 text-xs text-slate-soft">
                Board: {X15_EQUIPMENT_OVERVIEW.board} · Default front wing: {X15_EQUIPMENT_OVERVIEW.defaultFrontFoil} · {X15_EQUIPMENT_OVERVIEW.tailAndFuselage}
              </p>
            </div>
            <span className="rounded-full bg-aqua-mist px-3 py-1 text-xs font-bold text-harbour">
              2026 Class Rules
            </span>
          </div>

          <ul className="mt-4 grid gap-3 sm:grid-cols-2 lg:grid-cols-3">
            {X15_EQUIPMENT_OVERVIEW.divisions.map((item) => (
              <li
                key={item.division}
                className="rounded-xl border border-cool-veil/90 bg-aqua-mist/35 p-4"
              >
                <div className="flex items-center justify-between gap-2">
                  <span className="text-base font-black text-harbour-shadow">{item.division}</span>
                  <span className="rounded-md bg-warm-white px-2.5 py-0.5 text-xs font-bold text-harbour shadow-2xs">
                    Wings: {item.wings}
                  </span>
                </div>
                <div className="mt-2.5 space-y-1 text-xs">
                  <p className="font-semibold text-charcoal">
                    <span className="text-slate-soft">Mast:</span> {item.mast}
                  </p>
                  <p className="text-slate-soft">
                    <span>Foil set (Front / Tail / Fuselage):</span> {item.foil}
                  </p>
                </div>
              </li>
            ))}
          </ul>

          <p className="mt-4 flex items-center gap-2 text-xs text-slate-soft">
            <Sparkles aria-hidden="true" className="h-3.5 w-3.5 shrink-0 text-harbour" />
            <span>{X15_EQUIPMENT_OVERVIEW.evolutionPolicy}</span>
          </p>
        </div>
      </section>

      {/* ABOUT X-15, SOUTHEAST ASIA PHOTO FEATURE, NATIONAL ASSOCIATIONS & TIMELINE */}
      <section id="about-class" aria-labelledby="x15-about-heading" className="scroll-mt-24 space-y-6">
        <div className="grid gap-6 lg:grid-cols-[1.15fr_1fr]">
          <div className="flex flex-col justify-between rounded-2xl border border-cool-veil bg-warm-white p-6">
            <div>
              <p className="text-xs font-bold uppercase tracking-wider text-harbour">Class background</p>
              <h2 id="x15-about-heading" className="mt-1 text-2xl font-black text-harbour-shadow">
                What is X-15?
              </h2>
              <p className="mt-3 text-sm leading-7 text-charcoal">
                X-15 is World Sailing’s first official one-design wingfoil racing class, recognised at the World Sailing Annual Conference in Dún Laoghaire, Ireland on 8 November 2025. Named in tribute to aeronautical engineer and windsurfing/winging co-inventor Jim Drake (designer of the North American X-15 rocket plane), the class standardises boards, foils and wings so race results reflect rider skill and tactics rather than an equipment arms race.
              </p>
              <p className="mt-3 text-sm leading-7 text-charcoal">
                In Southeast Asia, X-15 debuted at Pattaya (Dec 2024) and the 44th Singapore Open at Constant Wind Sea Sports Centre (Feb 2025), followed by the 22nd Langkawi International Regatta Perdana (Feb 2026) and the upcoming 46th Singapore Open (Jan 2027). Through Starboard’s Plastic Impact Program and WIF Foundation, each X-15 board removes 6 kg of coastal plastic and plants three mangrove trees.
              </p>
            </div>
            <div className="mt-5 flex flex-wrap gap-4 border-t border-cool-veil/70 pt-4">
              <OfficialLink href="https://x-15class.org/">Explore the official class website</OfficialLink>
              <OfficialLink href="https://x-15class.org/about/">World Sailing recognition &amp; story</OfficialLink>
            </div>
          </div>

          <figure className="flex flex-col justify-between overflow-hidden rounded-2xl border border-cool-veil bg-warm-white">
            <div className="aspect-[16/9] w-full overflow-hidden bg-harbour-shadow">
              {/* eslint-disable-next-line @next/next/no-img-element -- Self-hosted regional racing photo with lazy loading and explicit dimensions */}
              <img
                src="/classes/x15/langkawi-fleet-action.jpg"
                alt="Two X-15 wingfoil riders foiling across tropical waters at the 2026 Langkawi International Regatta Perdana in Malaysia"
                loading="lazy"
                width="1200"
                height="675"
                className="h-full w-full object-cover"
              />
            </div>
            <figcaption className="p-5 text-xs leading-5 text-slate-soft">
              <span className="font-bold text-harbour-shadow">Southeast Asia circuit in action:</span> Riders from seven nations competed across 11 races at the 22nd Langkawi International Regatta Perdana (February 2026), with Singapore youth siblings Ryo and Kate Bateman finishing 5th and 6th overall. Photo via <cite>International X-15 Class</cite>.
            </figcaption>
          </figure>
        </div>

        <div className="grid gap-6 lg:grid-cols-2">
          <div className="rounded-2xl border border-cool-veil bg-warm-white p-6">
            <div className="flex flex-wrap items-center justify-between gap-2">
              <div className="flex items-center gap-2">
                <Globe aria-hidden="true" className="h-5 w-5 text-harbour" />
                <h3 className="text-lg font-bold text-harbour-shadow">
                  National associations &amp; class contacts
                </h3>
              </div>
              <OfficialLink href="https://x-15class.org/national-associations/">All national bodies</OfficialLink>
            </div>
            <p className="mt-2 text-sm text-slate-soft">
              Twelve national sailing federations and wingfoil class associations coordinate X-15 fleets across Asia-Pacific, Europe and the Americas.
            </p>
            <ul className="mt-4 grid gap-2 sm:grid-cols-2">
              {X15_NATIONAL_ASSOCIATIONS.map((assoc) => (
                <li key={assoc.country} className="rounded-xl border border-cool-veil/70 bg-aqua-mist/20 px-3 py-2.5 text-xs">
                  <span className="font-bold text-harbour-shadow">{assoc.country}:</span>{" "}
                  <a
                    href={assoc.href}
                    target="_blank"
                    rel="noopener noreferrer"
                    className="font-semibold text-harbour hover:underline"
                  >
                    {assoc.body}
                  </a>
                </li>
              ))}
            </ul>
          </div>

          <details className="rounded-2xl border border-cool-veil bg-warm-white p-6" open>
            <summary className="flex cursor-pointer items-center gap-2 text-lg font-bold text-harbour-shadow">
              <Award aria-hidden="true" className="h-5 w-5 text-harbour" />
              <span>How the class developed (2023–2026)</span>
            </summary>
            <ol className="mt-5 space-y-5 border-l-2 border-harbour/30 pl-5">
              {X15_HISTORY.map((item) => (
                <li key={item.date} className="relative">
                  <span
                    aria-hidden="true"
                    className="absolute top-1.5 -left-[1.45rem] h-2.5 w-2.5 rounded-full bg-harbour ring-4 ring-warm-white"
                  />
                  <p className="text-xs font-bold text-harbour">{item.date}</p>
                  <h4 className="mt-0.5 font-bold text-charcoal">{item.title}</h4>
                  <p className="mt-1 text-sm leading-6 text-slate-soft">{item.copy}</p>
                  <div className="mt-1.5">
                    <OfficialLink href={item.href}>Class report</OfficialLink>
                  </div>
                </li>
              ))}
            </ol>
          </details>
        </div>
      </section>

      <footer className="flex flex-wrap items-center gap-5 border-t border-cool-veil pt-6 text-sm">
        <OfficialLink href={X15_OFFICIAL_CALENDAR_URL}>Official class calendar</OfficialLink>
        <Link href="/calendar?class=x15" className="font-semibold text-harbour hover:underline">
          X-15 regatta calendar
        </Link>
        <Link href="/classes" className="font-semibold text-harbour hover:underline">
          Explore all classes
        </Link>
        <Link href="/support" className="font-semibold text-harbour hover:underline">
          Suggest a correction
        </Link>
      </footer>
    </main>
  );
}
