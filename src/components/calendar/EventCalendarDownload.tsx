"use client";

import { CalendarPlus } from "lucide-react";
import { eventIcs, type CalendarDownloadEvent } from "@/lib/calendar/eventIcs";

export function EventCalendarDownload({ event }: { event: CalendarDownloadEvent }) {
  if (!eventIcs(event)) return null;
  return <button type="button" onClick={() => {
    const content = eventIcs(event);
    if (!content) return;
    const url = URL.createObjectURL(new Blob([content], { type: "text/calendar;charset=utf-8" }));
    const link = document.createElement("a");
    link.href = url;
    link.download = `${event.slug}.ics`;
    document.body.appendChild(link);
    link.click();
    link.remove();
    setTimeout(() => URL.revokeObjectURL(url), 1000);
  }} className="inline-flex min-h-11 w-full items-center justify-between gap-3 rounded-xl border border-[var(--sp-cool-veil)] bg-[var(--sp-warm-white)] px-4 py-3 text-sm font-semibold text-[var(--sp-harbour-shadow)] hover:bg-[var(--sp-sailcloth)]">
    Add to calendar (.ics)<CalendarPlus className="h-4 w-4 shrink-0" aria-hidden />
  </button>;
}
