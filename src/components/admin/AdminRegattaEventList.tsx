"use client";

import { Calendar, Trash2 } from "lucide-react";
import {
  eventClassProgress,
  eventStatusLabel,
  UNASSIGNED_EVENT_SLUG,
  type AdminEventGroup,
} from "@/lib/admin/groupRegattaEvents";

export type AdminRegattaEventListItem = {
  slug: string;
  event: AdminEventGroup;
};

function yearLabel(date: string): string {
  const year = String(date || "").slice(0, 4);
  return /^\d{4}$/.test(year) ? year : "Undated";
}

function groupByYear(items: AdminRegattaEventListItem[]): {
  year: string;
  items: AdminRegattaEventListItem[];
}[] {
  const buckets = new Map<string, AdminRegattaEventListItem[]>();
  for (const item of items) {
    const year = yearLabel(item.event.startDate);
    const list = buckets.get(year) ?? [];
    list.push(item);
    buckets.set(year, list);
  }
  return [...buckets.entries()].map(([year, yearItems]) => ({
    year,
    items: yearItems,
  }));
}

function ProgressMeter({ event }: { event: AdminEventGroup }) {
  const { published, total } = eventClassProgress(event);
  const pct = total > 0 ? Math.round((published / total) * 100) : 0;
  return (
    <div className="mt-2">
      <div className="flex items-center justify-between gap-2 text-[10px] font-bold uppercase tracking-wide text-slate-500">
        <span>{eventStatusLabel(event)}</span>
        {total > 0 ? <span>{pct}%</span> : null}
      </div>
      <div
        className="mt-1 h-1.5 overflow-hidden rounded-full bg-slate-200"
        aria-hidden="true"
      >
        <div
          className={`h-full rounded-full ${
            total === 0
              ? "bg-slate-300"
              : published === total
                ? "bg-emerald-500"
                : published === 0
                  ? "bg-amber-400"
                  : "bg-orange-500"
          }`}
          style={{ width: `${total === 0 ? 0 : Math.max(pct, published > 0 ? 8 : 0)}%` }}
        />
      </div>
    </div>
  );
}

export function AdminRegattaEventList({
  events,
  unassignedCount,
  selectedSlug,
  isSuperadmin,
  deletingSlug,
  onSelect,
  onDelete,
}: {
  events: AdminEventGroup[];
  unassignedCount: number;
  selectedSlug: string | null;
  isSuperadmin?: boolean;
  deletingSlug: string | null;
  onSelect: (slug: string) => void;
  onDelete: (slug: string) => void;
}) {
  const items: AdminRegattaEventListItem[] = events.map((event) => ({
    slug: event.slug,
    event,
  }));
  const years = groupByYear(items);
  const total = events.length + (unassignedCount > 0 ? 1 : 0);

  return (
    <div className="glass-panel flex max-h-[min(70vh,40rem)] min-h-[20rem] flex-col overflow-hidden rounded-2xl border border-slate-200 lg:max-h-[calc(100vh-14rem)] lg:sticky lg:top-4">
      <div className="border-b border-slate-200 px-4 py-3">
        <p className="text-[11px] font-black uppercase tracking-wider text-slate-700">
          Weekends
        </p>
        <p className="mt-0.5 text-xs font-medium text-slate-500">
          {total === 0
            ? "No events match the filters"
            : `${events.length} event${events.length === 1 ? "" : "s"}${
                unassignedCount > 0
                  ? ` · ${unassignedCount} unassigned class${unassignedCount === 1 ? "" : "es"}`
                  : ""
              }`}
        </p>
      </div>
      <div
        className="min-h-0 flex-1 overflow-y-auto p-2"
        role="listbox"
        aria-label="Regatta events"
      >
        {years.map(({ year, items: yearItems }) => (
          <div key={year} className="mb-2">
            <p className="sticky top-0 z-10 bg-white/95 px-2 py-1.5 text-[10px] font-black uppercase tracking-widest text-slate-500 backdrop-blur-sm">
              {year}
            </p>
            <div className="space-y-1">
              {yearItems.map(({ slug, event }) => {
                const selected = selectedSlug === slug;
                return (
                  <div
                    key={slug}
                    className={`group relative rounded-xl border transition-colors ${
                      selected
                        ? "border-orange-400 bg-orange-50"
                        : "border-transparent bg-white hover:border-slate-200 hover:bg-slate-50"
                    }`}
                  >
                    <button
                      type="button"
                      role="option"
                      aria-selected={selected}
                      onClick={() => onSelect(slug)}
                      className="w-full px-3 py-2.5 text-left"
                    >
                      <span className="block text-sm font-bold leading-snug text-slate-900">
                        {event.name}
                      </span>
                      <span className="mt-0.5 block text-[11px] font-medium text-slate-600">
                        {event.startDate || "Date TBD"}
                        {event.endDate ? ` – ${event.endDate}` : ""}
                        {event.venue ? ` · ${event.venue}` : ""}
                      </span>
                      <div className="mt-1.5 flex flex-wrap gap-1">
                        <span
                          className={`rounded-full border px-1.5 py-0.5 text-[10px] font-bold ${
                            event.countsForRanking
                              ? "border-emerald-200 bg-emerald-50 text-emerald-800"
                              : "border-sky-200 bg-sky-50 text-sky-800"
                          }`}
                        >
                          {event.countsForRanking ? "Series" : "Non-ranking"}
                        </span>
                        {event.isSelectionTrial ? (
                          <span className="rounded-full border border-amber-200 bg-amber-50 px-1.5 py-0.5 text-[10px] font-bold text-amber-800">
                            Trial
                          </span>
                        ) : null}
                      </div>
                      <ProgressMeter event={event} />
                    </button>
                    {isSuperadmin ? (
                      <button
                        type="button"
                        aria-label={`Delete ${event.name}`}
                        disabled={deletingSlug === slug}
                        onClick={(e) => {
                          e.stopPropagation();
                          onDelete(slug);
                        }}
                        className="absolute right-2 top-2 rounded-lg border border-transparent p-1.5 text-slate-400 opacity-0 hover:border-rose-200 hover:bg-rose-50 hover:text-rose-600 focus-visible:opacity-100 group-hover:opacity-100 disabled:opacity-40"
                      >
                        <Trash2 className="h-3.5 w-3.5" />
                      </button>
                    ) : null}
                  </div>
                );
              })}
            </div>
          </div>
        ))}

        {unassignedCount > 0 ? (
          <button
            type="button"
            role="option"
            aria-selected={selectedSlug === UNASSIGNED_EVENT_SLUG}
            onClick={() => onSelect(UNASSIGNED_EVENT_SLUG)}
            className={`mt-1 w-full rounded-xl border px-3 py-2.5 text-left ${
              selectedSlug === UNASSIGNED_EVENT_SLUG
                ? "border-amber-400 bg-amber-50"
                : "border-dashed border-amber-300 bg-amber-50/40 hover:bg-amber-50"
            }`}
          >
            <span className="block text-sm font-bold text-amber-950">
              Unassigned sailing classes
            </span>
            <span className="mt-0.5 block text-[11px] font-medium text-amber-800">
              {unassignedCount} class{unassignedCount === 1 ? "" : "es"} without a weekend
            </span>
          </button>
        ) : null}

        {total === 0 ? (
          <div className="flex flex-col items-center px-4 py-12 text-center">
            <Calendar className="mb-2 h-8 w-8 text-slate-300" />
            <p className="text-sm font-bold text-slate-600">No matching events</p>
            <p className="mt-1 text-xs text-slate-500">
              Clear search or filters to see the calendar again.
            </p>
          </div>
        ) : null}
      </div>
    </div>
  );
}
