import { CalendarDays, MapPin, ExternalLink } from "lucide-react";
import { RegattasBackLink } from "@/components/RegattasBackLink";
import { EventCalendarDownload } from "@/components/calendar/EventCalendarDownload";
import { classDisplayLabels } from "@/lib/classPresentation";
import type { CalendarDownloadEvent } from "@/lib/calendar/eventIcs";

export type RegattaOverviewProps = {
  name: string;
  dates: string;
  venue?: string | null;
  organiser?: string | null;
  classes: string[];
  status: string;
  region?: string | null;
  registrationUrl?: string | null;
  noticeBoardUrl?: string | null;
  noticeOfRaceUrl?: string | null;
  websiteUrl?: string | null;
  keyDeadlines?: string | null;
  calendarEvent?: CalendarDownloadEvent;
  backHref?: string;
  summary?: string | null;
};

export function regattaTimelineStatus(start: string, end?: string | null, now = new Date()): string {
  const today = new Intl.DateTimeFormat("en-CA", { timeZone: "Asia/Singapore", year: "numeric", month: "2-digit", day: "2-digit" }).format(now);
  return start > today ? "Upcoming" : (end || start) < today ? "Past event" : "Event underway";
}

export function formatRegattaDates(start: string, end?: string | null): string {
  const format = (value: string) => new Intl.DateTimeFormat("en-SG", { day: "numeric", month: "long", year: "numeric", timeZone: "UTC" }).format(new Date(`${value.slice(0, 10)}T00:00:00Z`));
  return end && end !== start ? `${format(start)} – ${format(end)}` : format(start);
}

function OfficialLink({ href, label, primary = false }: { href: string; label: string; primary?: boolean }) {
  return <a href={href} target="_blank" rel="noopener noreferrer" className={`inline-flex min-h-11 w-full items-center justify-between gap-3 rounded-xl border px-4 py-3 text-sm font-semibold ${primary ? "border-[var(--sp-harbour-teal)] bg-[var(--sp-harbour-teal)] text-white hover:bg-[var(--sp-harbour-shadow)]" : "border-[var(--sp-cool-veil)] bg-[var(--sp-warm-white)] text-[var(--sp-harbour-shadow)] hover:bg-[var(--sp-sailcloth)]"}`}>
    {label}<ExternalLink className="h-4 w-4 shrink-0" aria-hidden />
  </a>;
}

export function RegattaOverview(props: RegattaOverviewProps) {
  const classes = classDisplayLabels(props.classes);
  const hasActions = props.registrationUrl || props.noticeBoardUrl || props.noticeOfRaceUrl || props.websiteUrl || props.calendarEvent;
  return <header className="min-w-0 space-y-6">
    <RegattasBackLink href={props.backHref || "/calendar"} className="inline-flex min-h-11 items-center text-sm font-semibold text-[var(--sp-harbour-teal)] hover:underline">← Back to regattas</RegattasBackLink>
    <div>
      <div className="mb-3 flex flex-wrap items-center gap-3 text-xs text-[var(--sp-charcoal-slate)]"><span className="rounded-full bg-[var(--sp-aqua-mist)] px-3 py-1.5 font-bold text-[var(--sp-harbour-shadow)]">{props.status}</span>{props.region && <span>{props.region}</span>}</div>
      <h1 className="max-w-4xl break-words text-2xl font-black leading-snug tracking-tight text-[var(--sp-harbour-shadow)] sm:text-3xl">{props.name}</h1>
    </div>
    <div className={`grid min-w-0 gap-6 ${hasActions ? "lg:grid-cols-[minmax(0,1fr)_20rem]" : ""}`}>
      <div className="min-w-0 space-y-5">
        <dl className="flex flex-wrap gap-x-8 gap-y-5 border-b border-[var(--sp-cool-veil)] pb-5">
          <div className="flex gap-3"><CalendarDays className="mt-1 h-5 w-5 shrink-0 text-[var(--sp-harbour-teal)]" aria-hidden /><div><dt className="mb-1 text-xs text-[var(--sp-charcoal-slate)]">Regatta dates</dt><dd className="text-sm font-bold text-[var(--sp-harbour-shadow)]">{props.dates}</dd></div></div>
          {props.venue && <div className="flex min-w-0 gap-3"><MapPin className="mt-1 h-5 w-5 shrink-0 text-[var(--sp-harbour-teal)]" aria-hidden /><div><dt className="mb-1 text-xs text-[var(--sp-charcoal-slate)]">Venue</dt><dd className="break-words text-sm font-semibold text-[var(--sp-harbour-shadow)]">{props.venue}</dd></div></div>}
        </dl>
        {classes.length > 0 && <section aria-label="Scheduled classes"><h2 className="mb-3 text-base font-bold text-[var(--sp-harbour-shadow)]">Classes at this event</h2><ul className="flex flex-wrap gap-2">{classes.map((label) => <li key={label} className="rounded-lg border border-[var(--sp-cool-veil)] bg-[var(--sp-warm-white)] px-3 py-1.5 text-xs font-semibold text-[var(--sp-charcoal)]">{label}</li>)}</ul></section>}
        {props.organiser && <dl className="text-sm"><dt className="mb-1 text-xs text-[var(--sp-charcoal-slate)]">Organisers</dt><dd className="text-[var(--sp-charcoal)]">{props.organiser}</dd></dl>}
        {props.summary && <p className="max-w-3xl whitespace-pre-line text-sm leading-relaxed text-[var(--sp-charcoal-slate)]">{props.summary}</p>}
      </div>
      {hasActions && <aside aria-label="Official event information" className="space-y-2.5 self-start rounded-2xl border border-[var(--sp-cool-veil)] bg-[var(--sp-warm-white)] p-5">
        <h2 className="mb-3 text-base font-bold text-[var(--sp-harbour-shadow)]">{props.status === "Upcoming" || props.status === "Dates TBC" ? "Plan your entry" : "Official event information"}</h2>
        {props.registrationUrl && <OfficialLink href={props.registrationUrl} label="Entry information" primary />}
        {props.noticeBoardUrl && <OfficialLink href={props.noticeBoardUrl} label="Official notice board" />}
        {props.noticeOfRaceUrl && props.noticeOfRaceUrl !== props.noticeBoardUrl && <OfficialLink href={props.noticeOfRaceUrl} label="Notice of Race" />}
        {props.websiteUrl && props.websiteUrl !== props.registrationUrl && <OfficialLink href={props.websiteUrl} label="Official event website" primary={!props.registrationUrl} />}
        {props.calendarEvent && <EventCalendarDownload event={props.calendarEvent} />}
        <div className="border-t border-[var(--sp-cool-veil)] pt-3 text-xs leading-relaxed text-[var(--sp-charcoal-slate)]"><h3 className="mb-1 font-bold text-[var(--sp-charcoal)]">{props.keyDeadlines ? "Key dates and deadlines" : "Entry deadline"}</h3><p className="whitespace-pre-line">{props.keyDeadlines || "Check the organiser’s entry information."}</p></div>
      </aside>}
    </div>
    <p className="text-xs leading-relaxed text-[var(--sp-charcoal-slate)]">Dates, eligibility and entry requirements are governed by the organiser’s official documents.</p>
  </header>;
}
