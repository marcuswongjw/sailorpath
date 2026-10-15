import type { Metadata } from "next";
import Link from "next/link";
import { CalendarDays, ExternalLink, Info, MapPin } from "lucide-react";

export const metadata: Metadata = {
  title: "X-15 class hub | SailorPath",
  description: "Pre-Worlds X-15 class context, event planning and verified foundation-circuit history.",
  robots: {
    index: false,
    follow: false,
  },
};

const foundationHistory = [
  ["2023", "Foundation circuit", "Recorded reference results establish the first SailorPath X-15 baseline."],
  ["2024", "Regional growth", "Published event sheets are retained as source-linked history, not a retrospective ranking."],
  ["2025", "International build-up", "Foundation records provide context for the next verified international results."],
] as const;

const events = [
  {
    place: "Ibiza, Spain",
    label: "X-15 Worlds",
    status: "Pre-Worlds · event source under review",
    note: "The pilot is live before the Worlds deadline. Official final scorecards will appear only after they are imported and source-linked.",
    region: "International",
  },
  {
    place: "Pattaya, Thailand",
    label: "X-15 regional event",
    status: "Upcoming · organiser material pending",
    note: "Regional event context for sailors and families planning the Asian calendar.",
    region: "Asia",
  },
] as const;

export default function X15ClassHub() {
  return (
    <main className="mx-auto max-w-6xl space-y-10 px-4 py-10 sm:px-6 sm:py-14">
      <header className="rounded-3xl border border-harbour/15 bg-harbour-shadow px-6 py-8 text-sailcloth shadow-sm sm:px-10 sm:py-12">
        <p className="text-xs font-bold uppercase tracking-[0.16em] text-soft-aqua">International class context · beta</p>
        <h1 className="mt-3 text-3xl font-black tracking-tight sm:text-5xl">X-15 on SailorPath</h1>
        <p className="mt-4 max-w-2xl text-base leading-7 text-soft-aqua sm:text-lg">A public, source-led place to follow the X-15 class before Worlds results are final. Built for sailors, families, coaches and organisers who need event context without unsupported ranking claims.</p>
        <div className="mt-6 flex flex-wrap gap-3">
          <Link href="/calendar?class=x-15" className="sp-primary inline-flex items-center gap-2 px-4 py-2.5 text-sm font-bold"><CalendarDays className="h-4 w-4" />View calendar</Link>
          <Link href="/news" className="inline-flex items-center gap-2 rounded-xl border border-soft-aqua/40 px-4 py-2.5 text-sm font-bold text-sailcloth hover:bg-white/10">Pilot updates</Link>
        </div>
      </header>

      <section className="grid gap-4 md:grid-cols-3" aria-label="X-15 pilot status">
        <article className="rounded-2xl border border-cool-veil bg-warm-white p-5"><p className="text-xs font-bold uppercase tracking-wider text-harbour">Status</p><p className="mt-2 text-lg font-black text-harbour-shadow">Pre-Worlds beta</p><p className="mt-2 text-sm leading-6 text-slate-soft">No numbered ranking is published at this stage.</p></article>
        <article className="rounded-2xl border border-cool-veil bg-warm-white p-5"><p className="text-xs font-bold uppercase tracking-wider text-harbour">Scope</p><p className="mt-2 text-lg font-black text-harbour-shadow">Regional &amp; international</p><p className="mt-2 text-sm leading-6 text-slate-soft">Singapore is context, not a restriction: this hub follows relevant X-15 racing wherever verified records are published.</p></article>
        <article className="rounded-2xl border border-cool-veil bg-warm-white p-5"><p className="text-xs font-bold uppercase tracking-wider text-harbour">Trust model</p><p className="mt-2 text-lg font-black text-harbour-shadow">Source-linked results</p><p className="mt-2 text-sm leading-6 text-slate-soft">Final scorecards appear after a public organiser source is reviewed and linked.</p></article>
      </section>

      <section className="space-y-4">
        <div><p className="text-xs font-bold uppercase tracking-[0.16em] text-harbour">Calendar</p><h2 className="mt-2 text-2xl font-black text-harbour-shadow">Ibiza and Pattaya</h2></div>
        <div className="grid gap-4 md:grid-cols-2">
          {events.map((event) => <article key={event.label} className="rounded-2xl border border-cool-veil bg-warm-white p-5 shadow-xs"><div className="flex items-start justify-between gap-4"><div><h3 className="text-lg font-bold text-harbour-shadow">{event.label}</h3><p className="mt-1 inline-flex items-center gap-1.5 text-sm font-semibold text-harbour"><MapPin className="h-4 w-4" />{event.place}</p></div><span className="rounded-full bg-aqua-mist px-2.5 py-1 text-[11px] font-bold text-harbour">{event.region}</span></div><p className="mt-3 text-sm font-semibold text-charcoal">{event.status}</p><p className="mt-2 text-sm leading-6 text-slate-soft">{event.note}</p><p className="mt-4 inline-flex items-center gap-1 text-xs font-semibold text-harbour"><ExternalLink className="h-3.5 w-3.5" />Organiser source will be linked when published</p></article>)}
        </div>
      </section>

      <section className="grid gap-6 lg:grid-cols-[1.15fr_.85fr]">
        <div className="rounded-2xl border border-cool-veil bg-warm-white p-5 sm:p-6"><p className="text-xs font-bold uppercase tracking-[0.16em] text-harbour">Foundation history</p><h2 className="mt-2 text-2xl font-black text-harbour-shadow">2023–25 reference record</h2><ol className="mt-5 space-y-4 border-l border-cool-veil pl-5">{foundationHistory.map(([year,title,body]) => <li key={year} className="relative"><span className="absolute -left-[1.84rem] top-1.5 h-2.5 w-2.5 rounded-full bg-harbour" /><p className="text-sm font-black text-harbour">{year}</p><h3 className="mt-0.5 text-sm font-bold text-charcoal">{title}</h3><p className="mt-1 text-sm leading-6 text-slate-soft">{body}</p></li>)}</ol></div>
        <aside className="rounded-2xl border border-harbour/20 bg-aqua-mist p-5 sm:p-6"><Info className="h-5 w-5 text-harbour" /><h2 className="mt-3 text-lg font-black text-harbour-shadow">How the beta works</h2><ul className="mt-3 space-y-2 text-sm leading-6 text-charcoal"><li>• Event pages distinguish published, provisional and awaiting-review states.</li><li>• No ranking is inferred from incomplete or unsourced results.</li><li>• Once official final results are imported, a clearly labelled Beta Ranking may be activated.</li></ul><Link href="/about" className="mt-5 inline-flex text-sm font-bold text-harbour hover:underline">Read the sourcing approach →</Link></aside>
      </section>
    </main>
  );
}
