import type { Metadata } from "next";
import Link from "next/link";
import { CalendarDays, ExternalLink, Info, MapPin } from "lucide-react";

export const metadata: Metadata = {
  title: "X-15 class hub | SailorPath",
  description:
    "X-15 class context for the 2026 Worlds and Asian Championships, with sourced class history and no SailorPath ranking.",
  alternates: { canonical: "/classes/x15" },
  robots: { index: true, follow: true },
};

const officialCalendarHref = "https://x-15class.org/events/";
const worldsNoticeHref =
  "https://x-15class.org/blog/entries-open-for-the-first-x-15-world-championships/";
const asianNoticeHref = "https://www.instagram.com/p/DcIit1VP9_d/";

const events = [
  {
    label: "X-15 World Championships 2026",
    date: "4–8 November 2026",
    place: "Port Nàutic Ibiza, Spain",
    host: "Hosted by Club Mare Nostrum",
    status: "Upcoming · entries open in the 20 July 2026 class notice",
    note:
      "Registration is on 4 November, with racing from that afternoon through 8 November. World Sailing titles are Senior male, Senior female, Youth male under 19, Youth female under 19, and Junior under 15. Masters and other divisions receive championship awards. That 20 July notice opened entries first come, first served. A SailorPath scorecard waits until final results are imported and source-linked.",
    region: "International",
    sourceHref: "https://x-15class.org/events/x-15-world-championships-2026/",
    sourceLabel: "Official X-15 Worlds page",
    noticeHref: worldsNoticeHref,
    noticeLabel: "20 July 2026 entries notice",
  },
  {
    label: "X-15 Asian Championships 2026",
    date: "16–17 December training · 18–20 December racing",
    place: "Amara Watersports Club, Jomtien, Thailand",
    host: "Dates from the class post, August 2026",
    status: "Upcoming · class post",
    note:
      "Training is 16–17 December and racing is 18–20 December. A SailorPath scorecard waits until final results are imported and source-linked.",
    region: "Asia",
    sourceHref: asianNoticeHref,
    sourceLabel: "Class post, August 2026",
    noticeHref: null,
    noticeLabel: null,
  },
] as const;

const foundationHistory = [
  {
    year: "July 2023",
    title: "First test event",
    body: "Foiling Week was the class’s first test event. This is class history, not a SailorPath ranking.",
    href: "https://x-15class.org/blog/news/foiling-week-2023-showcases-the-future-of-wingfoil-racing/",
    sourceLabel: "Class report",
  },
  {
    year: "December 2024",
    title: "Pattaya",
    body: "The class raced at Pattaya with 25 competitors. This is class history, not a SailorPath ranking.",
    href: "https://x-15class.org/blog/news/x-15-class-wingfoil-one-design-shines-at-pattaya-international-windsurfing-championships/",
    sourceLabel: "Class report",
  },
  {
    year: "14–18 February 2025",
    title: "44th Singapore Open",
    body: "X-15 made its debut at the 44th Singapore Open. This is class history, not a SailorPath ranking.",
    href: "https://x-15class.org/blog/news/thailand-leads-the-charge-as-x-15-class-makes-impactful-debut-at-the-44th-singapore-open/",
    sourceLabel: "Class report",
  },
  {
    year: "8 November 2025",
    title: "World Sailing recognition",
    body: "The class’s own account places World Sailing recognition on 8 November 2025 in Dún Laoghaire, as the first one-design wingfoil class. This is class history, not a SailorPath ranking.",
    href: null,
    sourceLabel: null,
  },
  {
    year: "9–11 February 2026",
    title: "Langkawi",
    body: "Langkawi was the first official race after that recognition. The class published seven places: 1 Romain Ghio FRA, 2 Itsarakul Boonchird Kyo THA, 3 Renz Angelo Amboy PHI, 4 Geylord Coveta PHI, 5 Ryo En Hua Bateman SGP, 6 Kate En Rui Bateman SGP, 7 Reneric Moreno PHI. SailorPath does not turn that list into a ranking.",
    href: "https://x-15class.org/blog/langkawi-2026-x15-racing/",
    sourceLabel: "Class recap",
  },
] as const;

export default function X15ClassHub() {
  return (
    <main className="mx-auto max-w-6xl space-y-10 px-4 py-10 sm:px-6 sm:py-14">
      <header className="rounded-3xl border border-harbour/15 bg-harbour-shadow px-6 py-8 text-sailcloth shadow-sm sm:px-10 sm:py-12">
        <p className="text-xs font-bold uppercase tracking-[0.16em] text-soft-aqua">
          International class context · beta
        </p>
        <h1 className="mt-3 text-3xl font-black tracking-tight sm:text-5xl">
          X-15 on SailorPath
        </h1>
        <p className="mt-4 max-w-2xl text-base leading-7 text-soft-aqua sm:text-lg">
          A source-led place to follow the X-15 class before Worlds results are
          final. Built for sailors, families, coaches and organisers who need
          event context without unsupported ranking claims.
        </p>
        <div className="mt-6 flex flex-wrap gap-3">
          <a
            href={officialCalendarHref}
            target="_blank"
            rel="noreferrer"
            className="sp-primary inline-flex items-center gap-2 px-4 py-2.5 text-sm font-bold"
          >
            <CalendarDays className="h-4 w-4" />
            Official X-15 calendar
          </a>
          <Link
            href="/news"
            className="inline-flex items-center gap-2 rounded-xl border border-soft-aqua/40 px-4 py-2.5 text-sm font-bold text-sailcloth hover:bg-white/10"
          >
            Pilot updates
          </Link>
          <Link
            href="/classes"
            className="inline-flex items-center gap-2 rounded-xl border border-soft-aqua/40 px-4 py-2.5 text-sm font-bold text-sailcloth hover:bg-white/10"
          >
            All classes
          </Link>
        </div>
      </header>

      <section className="grid gap-4 md:grid-cols-3" aria-label="X-15 pilot status">
        <article className="rounded-2xl border border-cool-veil bg-warm-white p-5">
          <p className="text-xs font-bold uppercase tracking-wider text-harbour">Status</p>
          <p className="mt-2 text-lg font-black text-harbour-shadow">Pre-Worlds beta</p>
          <p className="mt-2 text-sm leading-6 text-slate-soft">
            No numbered ranking is published at this stage.
          </p>
        </article>
        <article className="rounded-2xl border border-cool-veil bg-warm-white p-5">
          <p className="text-xs font-bold uppercase tracking-wider text-harbour">Scope</p>
          <p className="mt-2 text-lg font-black text-harbour-shadow">Regional &amp; international</p>
          <p className="mt-2 text-sm leading-6 text-slate-soft">
            Singapore is context, not a restriction: this hub follows relevant
            X-15 racing wherever reviewed records are published.
          </p>
        </article>
        <article className="rounded-2xl border border-cool-veil bg-warm-white p-5">
          <p className="text-xs font-bold uppercase tracking-wider text-harbour">Trust model</p>
          <p className="mt-2 text-lg font-black text-harbour-shadow">Source-linked results</p>
          <p className="mt-2 text-sm leading-6 text-slate-soft">
            Final scorecards appear only after a public organiser source is reviewed and linked.
          </p>
        </article>
      </section>

      <section className="space-y-4" aria-labelledby="x15-calendar-heading">
        <div>
          <p className="text-xs font-bold uppercase tracking-[0.16em] text-harbour">Calendar</p>
          <h2 id="x15-calendar-heading" className="mt-2 text-2xl font-black text-harbour-shadow">
            Ibiza and Thailand
          </h2>
        </div>
        <div className="grid gap-4 md:grid-cols-2">
          {events.map((event) => (
            <article
              key={event.label}
              className="rounded-2xl border border-cool-veil bg-warm-white p-5 shadow-xs"
            >
              <div className="flex items-start justify-between gap-4">
                <div>
                  <h3 className="text-lg font-bold text-harbour-shadow">{event.label}</h3>
                  <p className="mt-2 text-sm font-semibold text-charcoal">{event.date}</p>
                  <p className="mt-1 inline-flex items-center gap-1.5 text-sm font-semibold text-harbour">
                    <MapPin className="h-4 w-4" />
                    {event.place}
                  </p>
                </div>
                <span className="rounded-full bg-aqua-mist px-2.5 py-1 text-[11px] font-bold text-harbour">
                  {event.region}
                </span>
              </div>
              <p className="mt-3 text-sm font-semibold text-charcoal">{event.status}</p>
              <p className="mt-1 text-sm text-slate-soft">{event.host}</p>
              <p className="mt-2 text-sm leading-6 text-slate-soft">{event.note}</p>
              <div className="mt-4 flex flex-col gap-2">
                <a
                  href={event.sourceHref}
                  target="_blank"
                  rel="noreferrer"
                  className="inline-flex items-center gap-1 text-xs font-semibold text-harbour hover:underline"
                >
                  <ExternalLink className="h-3.5 w-3.5" />
                  {event.sourceLabel}
                </a>
                {event.noticeHref ? (
                  <a
                    href={event.noticeHref}
                    target="_blank"
                    rel="noreferrer"
                    className="inline-flex items-center gap-1 text-xs font-semibold text-harbour hover:underline"
                  >
                    <ExternalLink className="h-3.5 w-3.5" />
                    {event.noticeLabel}
                  </a>
                ) : null}
              </div>
            </article>
          ))}
        </div>
      </section>

      <section className="grid gap-6 lg:grid-cols-[1.15fr_.85fr]">
        <div className="rounded-2xl border border-cool-veil bg-warm-white p-5 sm:p-6">
          <p className="text-xs font-bold uppercase tracking-[0.16em] text-harbour">Foundation history</p>
          <h2 className="mt-2 text-2xl font-black text-harbour-shadow">Class history</h2>
          <p className="mt-2 text-sm leading-6 text-slate-soft">
            Each item links to a class report. None of them is a SailorPath ranking.
          </p>
          <ol className="mt-5 space-y-4 border-l border-cool-veil pl-5">
            {foundationHistory.map((item) => (
              <li key={item.year} className="relative">
                <span className="absolute -left-[1.84rem] top-1.5 h-2.5 w-2.5 rounded-full bg-harbour" />
                <p className="text-sm font-black text-harbour">{item.year}</p>
                <h3 className="mt-0.5 text-sm font-bold text-charcoal">{item.title}</h3>
                <p className="mt-1 text-sm leading-6 text-slate-soft">{item.body}</p>
                {item.href ? (
                  <a
                    href={item.href}
                    target="_blank"
                    rel="noreferrer"
                    className="mt-1 inline-flex items-center gap-1 text-xs font-semibold text-harbour hover:underline"
                  >
                    <ExternalLink className="h-3.5 w-3.5" />
                    {item.sourceLabel}
                  </a>
                ) : null}
              </li>
            ))}
          </ol>
        </div>
        <aside className="rounded-2xl border border-harbour/20 bg-aqua-mist p-5 sm:p-6">
          <Info className="h-5 w-5 text-harbour" />
          <h2 className="mt-3 text-lg font-black text-harbour-shadow">How the beta works</h2>
          <ul className="mt-3 space-y-2 text-sm leading-6 text-charcoal">
            <li>• Event pages distinguish published, provisional and awaiting-review states.</li>
            <li>• No ranking is inferred from incomplete or unsourced results.</li>
            <li>• A numbered SailorPath ranking stays off until final results are imported and reconciled.</li>
          </ul>
          <Link href="/about" className="mt-5 inline-flex text-sm font-bold text-harbour hover:underline">
            Read the sourcing approach →
          </Link>
        </aside>
      </section>
    </main>
  );
}
