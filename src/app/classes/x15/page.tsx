import type { Metadata } from "next";
import Link from "next/link";
import { CalendarDays, ExternalLink, MapPin, ArrowRight } from "lucide-react";
import { getCachedPublicRegattas } from "@/lib/queries";
import { directoryFromPublished } from "@/lib/regattaDirectory";
import { X15_ASIANS_2026, X15_SOURCE_CHECKED_ON, X15_WORLDS_2026, publishedX15Sheets, x15WorldsStatus } from "@/lib/x15";

export const revalidate = 3600;
export const metadata: Metadata = {
  title: "X-15 wingfoil racing, events & results | SailorPath",
  description: "Follow X-15 one-design wingfoil racing: the 2026 Ibiza Worlds, Asian Championships, official event information and reviewed results.",
  alternates: { canonical: "/classes/x15" },
  robots: { index: true, follow: true },
};

const history = [
  { date: "July 2023", title: "The first test event", copy: "Foiling Week at Lake Garda introduced the one-design racing format.", href: "https://x-15class.org/blog/news/foiling-week-2023-premieres-x-15-class-wingfoiling-event-at-lake-garda/" },
  { date: "December 2024", title: "Racing in Pattaya", copy: "The class expanded its Asian racing programme with a 25-rider event.", href: "https://x-15class.org/blog/news/x-15-class-wingfoil-one-design-shines-at-pattaya-international-windsurfing-championships/" },
  { date: "14–18 February 2025", title: "Singapore Open debut", copy: "X-15 joined the 44th Singapore Open at Constant Wind Sea Sports Centre.", href: "https://x-15class.org/blog/news/thailand-leads-the-charge-as-x-15-class-makes-impactful-debut-at-the-44th-singapore-open/" },
  { date: "February 2026", title: "Langkawi opens the season", copy: "Riders from seven nations raced in the class’s first official event after World Sailing recognition.", href: "https://x-15class.org/blog/langkawi-2026-x15-racing/" },
];

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

  return <main className="mx-auto max-w-6xl space-y-10 px-4 py-10 sm:px-6 sm:py-14">
    <header className="grid gap-8 rounded-3xl border border-harbour/15 bg-harbour-shadow px-6 py-8 text-sailcloth sm:px-10 sm:py-10 lg:grid-cols-[1.1fr_1fr]">
      <div>
        <p className="text-xs font-bold uppercase tracking-[0.16em] text-soft-aqua">One-design wingfoil racing</p>
        <h1 className="mt-3 text-3xl font-black tracking-tight sm:text-5xl">Follow the X-15 class</h1>
        <p className="mt-4 max-w-xl text-base leading-7 text-soft-aqua">Events, official information and race results for riders, families and coaches. Start with the inaugural World Championships in Ibiza.</p>
        <nav aria-label="On this X-15 page" className="mt-6 flex flex-wrap gap-x-5 gap-y-3 text-sm font-bold">
          {[['#results', 'Results'], ['#events', 'Upcoming events'], ['#about-class', 'About X-15']].map(([href, label]) => <a key={href} href={href} className="underline decoration-soft-aqua/50 underline-offset-4 hover:text-soft-aqua focus-visible:outline-2 focus-visible:outline-offset-4">{label}</a>)}
        </nav>
      </div>
      <div className="rounded-2xl border border-soft-aqua/25 bg-white/5 p-5">
        <span className="rounded-full bg-soft-aqua px-3 py-1 text-xs font-bold text-harbour-shadow">{status}</span>
        <h2 className="mt-4 text-xl font-bold">{worlds.name}</h2>
        <p className="mt-3 flex items-center gap-2 font-semibold"><CalendarDays aria-hidden="true" className="h-4 w-4 shrink-0" />{worlds.dates}</p>
        <p className="mt-2 flex items-center gap-2 text-sm text-soft-aqua"><MapPin aria-hidden="true" className="h-4 w-4 shrink-0" />{worlds.venue}</p>
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
      <h2 id="x15-events-heading" className="text-2xl font-black text-harbour-shadow">2026 championship guide</h2>
      <div className="grid gap-4 md:grid-cols-2">
        <article className="rounded-2xl border border-cool-veil bg-warm-white p-5 sm:p-6">
          <p className="text-xs font-bold uppercase tracking-wider text-harbour">Spain · Worlds</p><h3 className="mt-2 text-xl font-bold text-harbour-shadow">{worlds.name}</h3><p className="mt-3 font-semibold text-charcoal">{worlds.dates}</p><p className="mt-1 text-sm text-slate-soft">{worlds.venue} · Hosted by {worlds.organiser}</p>
          <p className="mt-4 text-sm leading-6 text-charcoal">Registration is on 4 November, with racing scheduled from that afternoon through 8 November. Check the organiser for current entry availability and event documents.</p>
          <p className="mt-4 text-xs font-bold uppercase tracking-wider text-slate-soft">World titles announced by the class</p><ul className="mt-2 flex flex-wrap gap-2">{worlds.advertisedTitles.map((title) => <li key={title} className="rounded-lg bg-aqua-mist px-2.5 py-1.5 text-xs font-semibold text-harbour">{title}</li>)}</ul><p className="mt-3 text-sm leading-6 text-slate-soft">Masters and additional divisions have separate championship awards.</p>
          <div className="mt-5 flex flex-col gap-3"><OfficialLink href={worlds.websiteUrl}>Event information and official documents</OfficialLink><OfficialLink href={worlds.noticeUrl}>Class announcement and entry guidance</OfficialLink></div>
        </article>
        <article className="rounded-2xl border border-cool-veil bg-warm-white p-5 sm:p-6">
          <p className="text-xs font-bold uppercase tracking-wider text-harbour">Thailand · Asia</p><h3 className="mt-2 text-xl font-bold text-harbour-shadow">{X15_ASIANS_2026.name}</h3><p className="mt-3 font-semibold text-charcoal">{X15_ASIANS_2026.dates}</p><p className="mt-1 text-sm font-semibold text-harbour">{X15_ASIANS_2026.training}</p><p className="mt-2 text-sm text-slate-soft">{X15_ASIANS_2026.venue}</p>
          <p className="mt-4 text-sm leading-6 text-charcoal">A training clinic leads into three days of racing. The organiser’s registration form has clinic, equipment charter and entry details. Riders under 18 need guardian consent.</p><p className="mt-3 text-xs leading-5 text-slate-soft">Training dates follow the organiser’s current registration form.</p>
          <div className="mt-5 flex flex-col gap-3"><OfficialLink href={X15_ASIANS_2026.registrationUrl}>Registration and clinic information</OfficialLink><OfficialLink href={X15_ASIANS_2026.sourceUrl}>Japan WingFoil Association event notice</OfficialLink></div>
        </article>
      </div><p className="text-xs text-slate-soft">Event sources checked {X15_SOURCE_CHECKED_ON}. Confirm the latest notices with the organiser before booking or entering.</p>
    </section>

    <section id="about-class" aria-labelledby="x15-about-heading" className="grid scroll-mt-24 gap-6 lg:grid-cols-2">
      <div className="rounded-2xl border border-cool-veil bg-warm-white p-6"><h2 id="x15-about-heading" className="text-2xl font-black text-harbour-shadow">What is X-15?</h2><p className="mt-3 text-sm leading-7 text-charcoal">X-15 is a one-design wingfoil racing class: riders use class-approved boards, foils and wings. Standardised equipment puts the emphasis on racing skill, with equipment limits set by the class rules.</p><p className="mt-3 text-sm leading-7 text-charcoal">World Sailing recognised the class in 2025. SailorPath keeps X-15 event results separate from generic WingFoil, iQFOiL and national selection rankings.</p><div className="mt-5"><OfficialLink href="https://x-15class.org/">Explore the official class website</OfficialLink></div></div>
      <details className="rounded-2xl border border-cool-veil bg-warm-white p-6"><summary className="cursor-pointer text-lg font-bold text-harbour-shadow">How the class developed</summary><ol className="mt-5 space-y-5 border-l border-cool-veil pl-5">{history.map((item) => <li key={item.date}><p className="text-xs font-bold text-harbour">{item.date}</p><h3 className="mt-1 font-bold text-charcoal">{item.title}</h3><p className="mt-1 text-sm leading-6 text-slate-soft">{item.copy}</p><div className="mt-2"><OfficialLink href={item.href}>Class report</OfficialLink></div></li>)}</ol></details>
    </section>
    <footer className="flex flex-wrap items-center gap-5 border-t border-cool-veil pt-6 text-sm"><OfficialLink href="https://x-15class.org/events/">Official class calendar</OfficialLink><Link href="/classes" className="font-semibold text-harbour hover:underline">Explore all classes</Link><Link href="/support" className="font-semibold text-harbour hover:underline">Suggest a correction</Link></footer>
  </main>;
}
