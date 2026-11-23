import { RegattaDirectoryLink } from "@/components/regattas/RegattaDirectoryLink";
import { classDisplayLabels } from "@/lib/classPresentation";
import type { PendingRegatta } from "@/lib/calendar/pendingRegattas";

export function PendingRegattaCards({ events }: { events: readonly PendingRegatta[] }) {
  if (!events.length) return null;
  return (
    <section aria-label="Regattas awaiting confirmed dates" className="space-y-3">
      <h2 className="text-lg font-bold text-[var(--sp-harbour-shadow)]">Dates to be confirmed</h2>
      {events.map((event) => {
        const classLabel = classDisplayLabels(
          event.classes?.length ? event.classes : [event.boatClass]
        ).join(", ");
        return (
          <article key={event.slug} className="space-y-3 rounded-2xl border border-[var(--sp-cool-veil)] bg-[var(--sp-warm-white)] p-5">
            <div className="flex flex-wrap items-center gap-2">
              <h3 className="text-base font-bold text-[var(--sp-harbour-shadow)]">
                <RegattaDirectoryLink href={`/regattas/${event.slug}`} className="hover:underline">
                  {event.name}
                </RegattaDirectoryLink>
              </h3>
              {event.isSelectionTrial ? (
                <span className="rounded-md border border-[var(--sp-racing-orange)]/40 bg-[var(--sp-racing-mist)]/30 px-2.5 py-0.5 text-[10px] font-black uppercase tracking-wider text-[var(--sp-racing-orange)]">
                  Official Selection Trial
                </span>
              ) : null}
            </div>
            <p className="text-sm text-[var(--sp-charcoal-slate)]">
              {event.period || event.year} · {classLabel} · {event.venue}
            </p>
            <p className="text-sm text-[var(--sp-charcoal-slate)]">
              {event.notice
                ? `${event.notice} Exact dates are awaiting confirmation from ${event.organizer}.`
                : `Exact dates are awaiting confirmation from ${event.organizer}.`}
            </p>
            {event.officialUrl ? (
              <a
                href={event.officialUrl}
                target="_blank"
                rel="noopener noreferrer"
                className="inline-flex min-h-11 items-center font-semibold text-[var(--sp-harbour-teal)] underline"
              >
                Official event website
              </a>
            ) : null}
          </article>
        );
      })}
    </section>
  );
}
