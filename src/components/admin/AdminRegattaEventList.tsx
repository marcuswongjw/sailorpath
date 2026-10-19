"use client";

import { useState } from "react";
import {
  eventClassProgress,
  UNASSIGNED_EVENT_SLUG,
  type AdminEventGroup,
} from "@/lib/admin/groupRegattaEvents";

export type AdminRegattaEventListItem = {
  slug: string;
  event: AdminEventGroup;
};
type Scope = "recent" | "upcoming" | "all";

export function AdminRegattaEventList({
  events,
  unassignedCount,
  selectedSlug,
  onSelect,
}: {
  events: AdminEventGroup[];
  unassignedCount: number;
  selectedSlug: string | null;
  onSelect: (slug: string) => void;
}) {
  const [scope, setScope] = useState<Scope>("recent");
  const today = new Intl.DateTimeFormat("en-CA", {
    timeZone: "Asia/Singapore",
    year: "numeric",
    month: "2-digit",
    day: "2-digit",
  }).format(new Date());
  const yearAgo = `${Number(today.slice(0, 4)) - 1}${today.slice(4)}`;
  const visible = events.filter(
    (event) =>
      scope === "all" ||
      (scope === "upcoming"
        ? event.startDate > today
        : event.startDate <= today &&
          (event.endDate || event.startDate) >= yearAgo),
  );
  // Keep explicit bookmark/class context visible even outside the chosen view.
  const selected = events.find((event) => event.slug === selectedSlug);
  const rows =
    selected && !visible.includes(selected) ? [selected, ...visible] : visible;

  return (
    <section
      className="rounded-xl border border-slate-200 bg-white"
      aria-label="Event index"
    >
      <div className="border-b border-slate-200 p-3">
        <div className="flex flex-wrap items-center justify-between gap-2">
          <h2 className="text-sm font-bold text-slate-900">Events</h2>
          <span className="text-xs text-slate-500">
            {events.length} events
            {unassignedCount ? ` · ${unassignedCount} unassigned classes` : ""}
          </span>
        </div>
        <div
          className="mt-2 flex flex-wrap gap-1"
          aria-label="Event date views"
        >
          {(
            [
              ["recent", "Recent"],
              ["upcoming", "Upcoming"],
              ["all", "All history"],
            ] as const
          ).map(([value, label]) => (
            <button
              key={value}
              type="button"
              aria-pressed={scope === value}
              onClick={() => setScope(value)}
              className={`min-h-11 rounded-lg px-3 text-xs font-semibold ${scope === value ? "bg-harbour text-white" : "text-slate-700 hover:bg-slate-50"}`}
            >
              {label}
            </button>
          ))}
        </div>
      </div>
      <ul
        className="max-h-[42rem] divide-y divide-slate-100 overflow-y-auto"
        aria-label="Regatta events"
      >
        {rows.map((event) => {
          const { published, total } = eventClassProgress(event);
          const scheduled = event.startDate > today;
          return (
            <li key={event.slug}>
              <button
                type="button"
                aria-pressed={selectedSlug === event.slug}
                onClick={() => onSelect(event.slug)}
                className={`w-full p-3 text-left focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-inset focus-visible:ring-orange-600 ${selectedSlug === event.slug ? "bg-orange-50" : "hover:bg-slate-50"}`}
              >
                <span className="block text-sm font-semibold leading-snug text-slate-900">
                  {event.name}
                </span>
                <span className="mt-1 block text-xs text-slate-600">
                  {event.startDate || "Date TBD"}
                  {event.endDate && event.endDate !== event.startDate
                    ? ` – ${event.endDate}`
                    : ""}
                  {event.isSelectionTrial ? " · Trial" : ""}
                </span>
                <span
                  className={`mt-1 block text-xs ${scheduled ? "text-slate-500" : "text-harbour"}`}
                >
                  {scheduled
                    ? "Scheduled · results not due"
                    : total
                      ? `${published} of ${total} classes published`
                      : "Coverage not recorded"}
                </span>
              </button>
            </li>
          );
        })}
        {unassignedCount > 0 ? (
          <li>
            <button
              type="button"
              aria-pressed={selectedSlug === UNASSIGNED_EVENT_SLUG}
              onClick={() => onSelect(UNASSIGNED_EVENT_SLUG)}
              className="min-h-14 w-full p-3 text-left text-sm font-semibold text-amber-900"
            >
              Classes not on an event{" "}
              <span className="font-normal">({unassignedCount})</span>
            </button>
          </li>
        ) : null}
      </ul>
      {rows.length === 0 ? (
        <p className="p-5 text-sm text-slate-600">
          No events in this view. Try All history or clear the search.
        </p>
      ) : null}
      <p className="border-t border-slate-100 p-3 text-xs text-slate-500">
        Publication counts reflect recorded class scope, not a source or scoring
        audit.
      </p>
    </section>
  );
}
