import type { Metadata } from "next";
import Link from "next/link";
import { CalendarDays, ExternalLink, MapPin, ArrowRight } from "lucide-react";
import { getCachedPublicRegattas } from "@/lib/queries";
import { directoryFromPublished } from "@/lib/regattaDirectory";
import {
  X15_AGM_2026,
  X15_ASIANS_2026,
  X15_EQUIPMENT_OVERVIEW,
  X15_HISTORY,
  X15_NATIONAL_ASSOCIATIONS,
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
  return <a href={href} target="_blank" rel="noopener noreferrer" className="inline-flex items-center gap-2 text-sm font-semibold text-harbour hover:underline focus-visible:outline-2 focus-visible:outline-offset-4"><span>{children}</span><ExternalLink aria-hidden="true" className="h-3.5 w-3.5 shrink-0" /></a>;
}

export default async function X15ClassHub() {
  let available = true;
  let sheets: ReturnType<typeof publishedX15Sheets> = [];
  try { sheets = publishedX15Sheets(await getCachedPublicRegattas()); }
  catch { available = false; }
  const results = directoryFromPublished(sheets);
  const worlds = X15_WORLDS_2026;
  const today = new Intl.DateTimeFormat("en-CA", { timeZone: "Europe/Madrid", year: "numeric", month: "2-digit", day: "2-digit" }).format(new Date());
  const status = x15WorldsStatus(today, sheets.some((row) => row.eventSlug === worlds.eventSlug));
  const confirmedEvents = X15_LISTINGS.filter((item) => item.startDate);
  const provisionalEvents = X15_LISTINGS.filter((item) => !item.startDate);

  return <main className="mx-auto max-w-6xl space-y-10 px-4 py-10 sm:px-6 sm:py-14">
    <header className="grid gap-8 rounded-3xl border border-harbour/15 bg-harbour-shadow px-6 py-8 text-sailcloth sm:px-10 sm:py-10 lg:grid-cols-[1.1fr_1fr]">
      <div>
        <p className="text-xs font-bold uppercase tracking-[0.16em] text-soft-aqua">One-design wingfoil racing</p>
        <h1 className="mt-3 text-3xl font-black tracking-tight sm:text-5xl">Follow the X-15 class</h1>
        <p className="mt-4 max-w-xl text-base leading-7 text-soft-aqua">Events, official class equipment rules, national associations and race results for riders, families and coaches. Start with the inaugural World Championships in Ibiza ({worlds.confirmedFleetSummary}) and the 2026–2027 international calendar.</p>
        <nav aria-label="On this X-15 page" className="mt-6 flex flex-wrap gap-x-5 gap-y-3 text-sm font-bold">
          {[['#results', 'Results'], ['#events', '2026 championships'], ['#calendar', '2026–2027 calendar'], ['#about-class', 'About & equipment']].map(([href, label]) => <a key={href} href={href} className="underline decoration-soft-aqua/50 underline-offset-4 hover:text-soft-aqua focus-visible:outline-2 focus-visible:outline-offset-4">{label}</a>)}
        </nav>
      </div>
      <div className="rounded-2xl border border-soft-aqua/25 bg-white/5 p-5">
        <span className="rounded-full bg-soft-aqua px-3 py-1 text-xs font-bold text-harbour-shadow">{status}</span>
        <h2 className="mt-4 text-xl font-bold">{worlds.name}</h2>
        <p className="mt-3 flex items-center gap-2 font-semibold"><CalendarDays aria-hidden="true" className="h-4 w-4 shrink-0" />{worlds.dates}</p>
        <p className="mt-2 flex items-center gap-2 text-sm text-soft-aqua"><MapPin aria-hidden="true" className="h-4 w-4 shrink-0" />{worlds.venue}</p>
        <p className="mt-2 text-xs text-soft-aqua/90">{worlds.confirmedFleetSummary}</p>
        <a href={worlds.websiteUrl} target="_blank" rel="noopener noreferrer" className="mt-5 inline-flex items-center gap-2 rounded-xl bg-soft-aqua px-4 py-2.5 text-sm font-bold text-harbour-shadow hover:bg-sailcloth focus-visible:outline-2 focus-visible:outline-offset-4">Official Worlds information <ExternalLink aria-hidden="true" className="h-4 w-4" /></a>
      </div>
    </header>

    <section id="results" aria-labelledby="x15-results-heading" className="scroll-mt-24 space-y-4">
      <div className="flex flex-wrap items-end justify-between gap-3"><div><p className="text-xs font-bold uppercase tracking-wider text-harbour">On the water</p><h2 id="x15-results-heading" className="mt-2 text-2xl font-black text-harbour-shadow">Race results</h2></div><p className="text-sm text-slate-soft">Event placings · no SailorPath national ranking</p></div>
      {/* eslint-disable-next-line @next/next/no-html-link-for-pages -- A full document request retries a failed server-side results load. */}
      {!available ? <div role="status" className="rounded-2xl border border-cool-veil bg-warm-white p-6"><p className="font-bold text-harbour-shadow">Results are temporarily unavailable</p><p className="mt-2 text-sm text-slate-soft">The event guide is still available below.</p><a href="/classes/x15#results" className="mt-3 inline-block text-sm font-bold text-harbour hover:underline">Try loading results again</a></div>
        : results.length ? <div className="grid gap-4 sm:grid-cols-2">{results.map((event) => <article key={event.slug} className="rounded-2xl border border-cool-veil bg-warm-white p-5"><p className="text-xs font-semibold text-slate-soft">{event.date}</p><h3 className="mt-2 text-lg font-bold text-harbour-shadow">{event.name}</h3><ul className="mt-4 space-y-2">{event.fleets?.map((fleet) => <li key={fleet.id}><Link href={fleet.href} className="inline-flex items-center gap-2 text-sm font-bold text-harbour hover:underline">{fleet.label}<ArrowRight aria-hidden="true" className="h-4 w-4" /></Link></li>)}</ul></article>)}</div>
          : <div className="rounded-2xl border border-cool-veil bg-aqua-mist p-6 sm:p-8"><h3 className="text-lg font-bold text-harbour-shadow">{status === 'Upcoming' ? 'Worlds racing starts on 4 November' : status === 'Racing window' ? 'Worlds racing is scheduled for 4–8 November' : 'Worlds results are awaiting review'}</h3><p className="mt-2 max-w-2xl text-sm leading-6 text-charcoal">No reviewed X-15 scorecards are published on SailorPath yet. Official race scores, category placings and rider profile links will appear here as results are reviewed.</p><div className="mt-4"><OfficialLink href={worlds.websiteUrl}>Check the organiser’s latest updates</OfficialLink></div></div>}
    </section>

    <section id="events" aria-labelledby="x15-events-heading" className="scroll-mt-24 space-y-4">
      <h2 id="x15-events-heading" className="text-2xl font-black text-harbour-shadow">2026 championship &amp; clinic guide</h2>
      <div className="grid gap-4 md:grid-cols-2">
        <article className="rounded-2xl border border-cool-veil bg-warm-white p-5 sm:p-6">
          <p className="text-xs font-bold uppercase tracking-wider text-harbour">Spain · Worlds</p><h3 className="mt-2 text-xl font-bold text-harbour-shadow">{worlds.name}</h3><p className="mt-3 font-semibold text-charcoal">{worlds.dates}</p><p className="mt-1 text-sm text-slate-soft">{worlds.venue} · Hosted by {worlds.organiser}</p>
          <p className="mt-4 text-sm leading-6 text-charcoal">Registration opened on 4 November, with racing scheduled through 8 November for {worlds.confirmedFleetSummary}.</p>
          <p className="mt-4 text-xs font-bold uppercase tracking-wider text-slate-soft">World titles announced by the class</p><ul className="mt-2 flex flex-wrap gap-2">{worlds.advertisedTitles.map((title) => <li key={title} className="rounded-lg bg-aqua-mist px-2.5 py-1.5 text-xs font-semibold text-harbour">{title}</li>)}</ul><p className="mt-3 text-sm leading-6 text-slate-soft">Masters and additional divisions have separate championship awards.</p>
          <div className="mt-5 flex flex-col gap-3"><OfficialLink href={worlds.websiteUrl}>Event information and official documents</OfficialLink><OfficialLink href={worlds.fleetReportUrl}>107-sailor fleet announcement (24 nations)</OfficialLink><OfficialLink href={worlds.noticeUrl}>Class announcement and entry guidance</OfficialLink></div>
        </article>
        <article className="rounded-2xl border border-cool-veil bg-warm-white p-5 sm:p-6">
          <p className="text-xs font-bold uppercase tracking-wider text-harbour">Thailand · Asia (Updated dates)</p><h3 className="mt-2 text-xl font-bold text-harbour-shadow">{X15_ASIANS_2026.name}</h3><p className="mt-3 font-semibold text-charcoal">{X15_ASIANS_2026.dates}</p><p className="mt-1 text-sm font-semibold text-harbour">{X15_ASIANS_2026.training} · {X15_ASIANS_2026.clinicName}</p><p className="mt-2 text-sm text-slate-soft">{X15_ASIANS_2026.venue}</p>
          <p className="mt-4 text-sm leading-6 text-charcoal">The class calendar lists an updated December window at Amara Watersports Club: a three-day {X15_ASIANS_2026.clinicName} (15–17 December, sign-up via {X15_ASIANS_2026.clinicContactEmail}) leads directly into three days of racing (18–20 December). The organiser’s registration form has clinic, equipment charter and entry details; riders under 18 need guardian consent.</p>
          <p className="mt-3 text-xs leading-5 text-slate-soft">Training and racing dates follow the official X-15 class calendar and registration form.</p>
          <div className="mt-5 flex flex-col gap-3"><OfficialLink href={X15_ASIANS_2026.registrationUrl}>Registration and clinic information</OfficialLink><OfficialLink href={X15_ASIANS_2026.sourceUrl}>Japan WingFoil Association event notice</OfficialLink></div>
        </article>
      </div>
      <article className="rounded-2xl border border-cool-veil bg-warm-white p-5">
        <div className="flex flex-wrap items-center justify-between gap-3">
          <div>
            <p className="text-xs font-bold uppercase tracking-wider text-harbour">Class governance · {X15_AGM_2026.date}</p>
            <h3 className="mt-1 text-base font-bold text-harbour-shadow">{X15_AGM_2026.title}</h3>
            <p className="mt-1 text-sm text-charcoal">Online Annual General Meeting covering class rule updates, Executive Committee elections, Class President and Sustainability Lead appointments.</p>
          </div>
          <OfficialLink href={X15_AGM_2026.noticeUrl}>Official AGM notice</OfficialLink>
        </div>
      </article>
      <p className="text-xs text-slate-soft">Event sources checked {X15_SOURCE_CHECKED_ON}. Confirm the latest notices with the organiser before booking or entering.</p>
    </section>

    <section id="calendar" aria-labelledby="x15-calendar-heading" className="scroll-mt-24 space-y-6">
      <div className="flex flex-wrap items-end justify-between gap-3">
        <div>
          <p className="text-xs font-bold uppercase tracking-wider text-harbour">International circuit</p>
          <h2 id="x15-calendar-heading" className="mt-2 text-2xl font-black text-harbour-shadow">Upcoming X-15 events (2026–2027)</h2>
          <p className="mt-1 text-sm text-slate-soft">Published on the official International X-15 Class calendar and synced to the SailorPath regatta directory.</p>
        </div>
        <div className="flex flex-wrap items-center gap-4">
          <Link href="/calendar?class=x15" className="inline-flex items-center gap-1.5 text-sm font-bold text-harbour hover:underline">Open in Regatta Calendar <ArrowRight aria-hidden="true" className="h-4 w-4" /></Link>
          <OfficialLink href={X15_OFFICIAL_CALENDAR_URL}>Official X-15 events page</OfficialLink>
        </div>
      </div>

      <div className="space-y-3">
        <h3 className="text-base font-bold text-harbour-shadow">Confirmed event dates</h3>
        <div className="grid gap-3 sm:grid-cols-2 lg:grid-cols-4">
          {confirmedEvents.map((event) => (
            <article key={event.slug} className="flex flex-col justify-between rounded-2xl border border-cool-veil bg-warm-white p-4">
              <div>
                <div className="flex items-center justify-between gap-2">
                  <span className="rounded-md bg-aqua-mist px-2 py-0.5 text-xs font-bold text-harbour">{event.year}</span>
                  <span className="text-xs font-semibold text-slate-soft">{event.region}</span>
                </div>
                <h4 className="mt-2.5 text-base font-bold text-harbour-shadow">
                  <Link href={`/regattas/${event.slug}`} className="hover:underline">{event.name}</Link>
                </h4>
                <p className="mt-1.5 text-xs font-semibold text-charcoal">{event.period}</p>
                <p className="mt-1 text-xs text-slate-soft">{event.venue}</p>
              </div>
              <div className="mt-4 flex flex-wrap items-center justify-between gap-2 border-t border-cool-veil/60 pt-3 text-xs">
                <Link href={`/regattas/${event.slug}`} className="font-bold text-harbour hover:underline">Event page →</Link>
                {event.registrationUrl ? (
                  <a href={event.registrationUrl} target="_blank" rel="noopener noreferrer" className="font-semibold text-harbour hover:underline">Register</a>
                ) : null}
              </div>
            </article>
          ))}
        </div>
      </div>

      <div className="space-y-3">
        <h3 className="text-base font-bold text-harbour-shadow">2027 provisional calendar (month or exact dates TBC)</h3>
        <div className="grid gap-3 sm:grid-cols-2 lg:grid-cols-3">
          {provisionalEvents.map((event) => (
            <article key={event.slug} className="rounded-2xl border border-cool-veil bg-warm-white p-4">
              <div className="flex items-center justify-between gap-2">
                <span className="text-xs font-bold text-harbour">{event.period}</span>
                <span className="rounded-md bg-aqua-mist px-2 py-0.5 text-xs font-semibold text-harbour">{event.region}</span>
              </div>
              <h4 className="mt-1.5 text-sm font-bold text-harbour-shadow">
                <Link href={`/regattas/${event.slug}`} className="hover:underline">{event.name}</Link>
              </h4>
              <p className="mt-1 text-xs text-slate-soft">{event.venue}</p>
            </article>
          ))}
        </div>
      </div>
    </section>

    <section id="about-class" aria-labelledby="x15-about-heading" className="space-y-6 scroll-mt-24">
      <div className="grid gap-6 lg:grid-cols-2">
        <div className="rounded-2xl border border-cool-veil bg-warm-white p-6">
          <h2 id="x15-about-heading" className="text-2xl font-black text-harbour-shadow">What is X-15?</h2>
          <p className="mt-3 text-sm leading-7 text-charcoal">X-15 is World Sailing’s first official one-design wingfoil racing class, recognised at the World Sailing Annual Conference in Dún Laoghaire, Ireland on 8 November 2025. Named in tribute to aeronautical engineer and windsurfing/winging co-inventor Jim Drake (designer of the North American X-15 rocket plane), the class standardises boards, foils and wings so race results reflect rider skill and tactics rather than an equipment arms race.</p>
          <p className="mt-3 text-sm leading-7 text-charcoal">Equipment evolves on a controlled two-year cycle under class rules, and previous-generation masts, wings and foils remain class-legal for 2026 events. Through Starboard’s Plastic Impact Program and WIF Foundation, each X-15 board removes 6 kg of coastal plastic and plants three mangrove trees. SailorPath keeps X-15 event results distinct from open WingFoil, iQFOiL and national dinghy selection rankings.</p>
          <div className="mt-5 flex flex-wrap gap-4">
            <OfficialLink href="https://x-15class.org/">Explore the official class website</OfficialLink>
            <OfficialLink href={X15_EQUIPMENT_OVERVIEW.rulesUrl}>Class rules &amp; constitution</OfficialLink>
          </div>
        </div>

        <div className="rounded-2xl border border-cool-veil bg-warm-white p-6">
          <div className="flex flex-wrap items-center justify-between gap-2">
            <h3 className="text-xl font-black text-harbour-shadow">One-design equipment by division</h3>
            <OfficialLink href={X15_EQUIPMENT_OVERVIEW.equipmentUrl}>Equipment guide</OfficialLink>
          </div>
          <p className="mt-2 text-xs leading-5 text-slate-soft">Board: {X15_EQUIPMENT_OVERVIEW.board} · Default front wing: {X15_EQUIPMENT_OVERVIEW.defaultFrontFoil} · {X15_EQUIPMENT_OVERVIEW.tailAndFuselage}</p>
          <ul className="mt-4 grid gap-2.5 sm:grid-cols-2">
            {X15_EQUIPMENT_OVERVIEW.divisions.map((item) => (
              <li key={item.division} className="rounded-xl border border-cool-veil/80 bg-aqua-mist/40 p-3">
                <div className="flex items-center justify-between">
                  <span className="text-sm font-bold text-harbour-shadow">{item.division}</span>
                  <span className="rounded bg-warm-white px-2 py-0.5 text-xs font-bold text-harbour">Wings: {item.wings}</span>
                </div>
                <p className="mt-1.5 text-xs text-charcoal">Mast: {item.mast}</p>
                <p className="mt-0.5 text-xs text-slate-soft">Foil set: {item.foil}</p>
              </li>
            ))}
          </ul>
          <p className="mt-3 text-xs text-slate-soft">{X15_EQUIPMENT_OVERVIEW.evolutionPolicy}</p>
        </div>
      </div>

      <div className="grid gap-6 lg:grid-cols-2">
        <div className="rounded-2xl border border-cool-veil bg-warm-white p-6">
          <div className="flex flex-wrap items-center justify-between gap-2">
            <h3 className="text-lg font-bold text-harbour-shadow">National associations &amp; class contacts</h3>
            <OfficialLink href="https://x-15class.org/national-associations/">All national bodies</OfficialLink>
          </div>
          <p className="mt-2 text-sm text-slate-soft">Twelve national sailing federations and wingfoil class associations coordinate X-15 fleets across Asia-Pacific, Europe and the Americas.</p>
          <ul className="mt-4 grid gap-2 sm:grid-cols-2">
            {X15_NATIONAL_ASSOCIATIONS.map((assoc) => (
              <li key={assoc.country} className="rounded-xl border border-cool-veil/70 px-3 py-2 text-xs">
                <span className="font-bold text-harbour-shadow">{assoc.country}:</span>{" "}
                <a href={assoc.href} target="_blank" rel="noopener noreferrer" className="font-semibold text-harbour hover:underline">{assoc.body}</a>
              </li>
            ))}
          </ul>
        </div>

        <details className="rounded-2xl border border-cool-veil bg-warm-white p-6" open>
          <summary className="cursor-pointer text-lg font-bold text-harbour-shadow">How the class developed</summary>
          <ol className="mt-5 space-y-5 border-l border-cool-veil pl-5">
            {X15_HISTORY.map((item) => (
              <li key={item.date}>
                <p className="text-xs font-bold text-harbour">{item.date}</p>
                <h3 className="mt-1 font-bold text-charcoal">{item.title}</h3>
                <p className="mt-1 text-sm leading-6 text-slate-soft">{item.copy}</p>
                <div className="mt-2"><OfficialLink href={item.href}>Class report</OfficialLink></div>
              </li>
            ))}
          </ol>
        </details>
      </div>
    </section>

    <footer className="flex flex-wrap items-center gap-5 border-t border-cool-veil pt-6 text-sm"><OfficialLink href={X15_OFFICIAL_CALENDAR_URL}>Official class calendar</OfficialLink><Link href="/calendar?class=x15" className="font-semibold text-harbour hover:underline">X-15 regatta calendar</Link><Link href="/classes" className="font-semibold text-harbour hover:underline">Explore all classes</Link><Link href="/support" className="font-semibold text-harbour hover:underline">Suggest a correction</Link></footer>
  </main>;
}
