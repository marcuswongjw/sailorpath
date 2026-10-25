import { RegattaDirectoryLink } from "@/components/regattas/RegattaDirectoryLink";
import { sailingClassDisplayLabel } from "@/lib/classPresentation";
import type { PendingRegatta } from "@/lib/calendar/pendingRegattas";

export function PendingRegattaCards({ events }: { events: readonly PendingRegatta[] }) {
  if (!events.length) return null;
  return (
    <section aria-label="Regattas awaiting confirmed dates" className="space-y-3">
      <h2 className="text-lg font-bold text-[var(--sp-harbour-shadow)]">Dates to be confirmed</h2>
      {events.map((event) => (
        <article key={event.slug} className="space-y-3 rounded-2xl border border-[var(--sp-cool-veil)] bg-[var(--sp-warm-white)] p-5">
          <h3 className="text-base font-bold text-[var(--sp-harbour-shadow)]"><RegattaDirectoryLink href={`/regattas/${event.slug}`} className="hover:underline">{event.name}</RegattaDirectoryLink></h3>
          <p className="text-sm text-[var(--sp-charcoal-slate)]">{event.year} · {sailingClassDisplayLabel(event.boatClass)} · {event.venue}</p>
          <p className="text-sm text-[var(--sp-charcoal-slate)]">Exact dates are awaiting confirmation from {event.organizer}.</p>
          <a href={event.officialUrl} target="_blank" rel="noopener noreferrer" className="inline-flex min-h-11 items-center font-semibold text-[var(--sp-harbour-teal)] underline">Official event website</a>
        </article>
      ))}
    </section>
  );
}
