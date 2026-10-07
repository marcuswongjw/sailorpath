"use client";

import Link from "next/link";
import { ArrowLeft, ArrowRight, CheckCircle2, ClipboardCheck, Sailboat } from "lucide-react";
import type { RegattaAdmin } from "@/types/regatta";
import type { ResultAdmin } from "@/types/result";
import type { AdminEventsQueueView } from "@/components/admin/adminNav";
import { regattaDateLabel } from "@/types/regatta";
import { buildAdminOverview, type OverviewSheet } from "@/lib/admin/adminOverview";

type QueueConfig = {
  title: string;
  description: string;
  emptyTitle: string;
  emptyDescription: string;
  detailView: "results" | "readiness";
  actionLabel: string;
  icon: typeof Sailboat;
  sheets: OverviewSheet[];
};

function detailHref(sheet: OverviewSheet, view: QueueConfig["detailView"]): string {
  const params = new URLSearchParams({ area: "events", view, sheet: sheet.id });
  if (sheet.event) params.set("event", sheet.event);
  return `/admin?${params.toString()}`;
}

function sortNewestFirst(sheets: OverviewSheet[]): OverviewSheet[] {
  return [...sheets].sort(
    (a, b) => b.date.localeCompare(a.date) || a.name.localeCompare(b.name)
  );
}

function queueFor(
  view: AdminEventsQueueView,
  overview: ReturnType<typeof buildAdminOverview>
): QueueConfig {
  if (view === "missing-results") {
    return {
      title: "Missing results",
      description: "Class sheets with a recorded race count but no result rows.",
      emptyTitle: "No missing results",
      emptyDescription: "Every class with completed races has at least one score row.",
      detailView: "results",
      actionLabel: "Enter results",
      icon: Sailboat,
      sheets: sortNewestFirst(overview.missingResults),
    };
  }
  if (view === "ready-to-publish") {
    return {
      title: "Ready to publish",
      description: "Complete class sheets that passed the publication checks and still need a final review.",
      emptyTitle: "Nothing is ready to publish",
      emptyDescription: "Incomplete or blocked sheets will appear in Event data health instead.",
      detailView: "readiness",
      actionLabel: "Review checks",
      icon: CheckCircle2,
      sheets: sortNewestFirst(overview.ready),
    };
  }
  const attention = [...overview.blocked, ...overview.incomplete].sort(
    (a, b) => b.date.localeCompare(a.date) || a.name.localeCompare(b.name)
  );
  return {
    title: "Event data health",
    description: "Class sheets with blocking or incomplete publication checks.",
    emptyTitle: "No event data issues",
    emptyDescription: "There are no blocked or incomplete class sheets to review.",
    detailView: "readiness",
    actionLabel: "Review checks",
    icon: ClipboardCheck,
    sheets: attention,
  };
}

export function AdminEventsQueuePanel({
  view,
  regattas,
  results,
}: {
  view: AdminEventsQueueView;
  regattas: RegattaAdmin[];
  results: ResultAdmin[];
}) {
  const queue = queueFor(view, buildAdminOverview(regattas, results));
  const Icon = queue.icon;

  return (
    <section className="space-y-4" aria-labelledby="events-queue-title">
      <div className="flex flex-wrap items-start justify-between gap-3 rounded-2xl border border-slate-200 bg-white p-5">
        <div className="flex items-start gap-3">
          <span className="mt-0.5 rounded-xl bg-slate-100 p-2 text-[var(--sp-harbour-teal)]">
            <Icon className="h-5 w-5" aria-hidden="true" />
          </span>
          <div>
            <h2 id="events-queue-title" className="text-lg font-black text-slate-900">
              {queue.title}
            </h2>
            <p className="mt-1 max-w-2xl text-sm text-slate-600">{queue.description}</p>
          </div>
        </div>
        <Link
          href="/admin?area=events&view=card"
          className="inline-flex min-h-11 items-center gap-2 rounded-xl border border-slate-300 px-3 text-sm font-bold text-slate-800 hover:bg-slate-50 focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-orange-600"
        >
          <ArrowLeft className="h-4 w-4" aria-hidden="true" />
          All events
        </Link>
      </div>

      {queue.sheets.length > 0 ? (
        <div className="overflow-hidden rounded-2xl border border-slate-200 bg-white">
          <div className="flex items-center justify-between gap-3 border-b border-slate-200 px-4 py-3">
            <h3 className="text-sm font-bold text-slate-900">Class sheets</h3>
            <span className="text-sm font-semibold text-slate-600">
              {queue.sheets.length} item{queue.sheets.length === 1 ? "" : "s"}
            </span>
          </div>
          <ul className="divide-y divide-slate-200">
            {queue.sheets.map((sheet) => (
              <li key={sheet.id}>
                <Link
                  href={detailHref(sheet, queue.detailView)}
                  className="flex min-h-16 flex-wrap items-center justify-between gap-3 px-4 py-3 hover:bg-slate-50 focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-inset focus-visible:ring-orange-600"
                >
                  <span className="min-w-0">
                    <span className="block truncate text-sm font-bold text-slate-900">
                      {sheet.name}
                    </span>
                    <span className="mt-1 block text-xs text-slate-600">
                      {[sheet.boatClass, sheet.division, regattaDateLabel(sheet.date)]
                        .filter(Boolean)
                        .join(" · ")}
                      {sheet.raceCount != null ? ` · ${sheet.raceCount} races` : ""}
                      {view === "missing-results" ? " · 0 result rows" : ""}
                    </span>
                  </span>
                  <span className="inline-flex shrink-0 items-center gap-1 text-sm font-bold text-[var(--sp-harbour-teal)]">
                    {queue.actionLabel}
                    <ArrowRight className="h-4 w-4" aria-hidden="true" />
                  </span>
                </Link>
              </li>
            ))}
          </ul>
        </div>
      ) : (
        <div className="rounded-2xl border border-dashed border-slate-300 bg-white px-4 py-12 text-center">
          <Icon className="mx-auto h-8 w-8 text-emerald-600" aria-hidden="true" />
          <h3 className="mt-3 text-sm font-bold text-slate-900">{queue.emptyTitle}</h3>
          <p className="mx-auto mt-1 max-w-md text-sm text-slate-600">
            {queue.emptyDescription}
          </p>
        </div>
      )}
    </section>
  );
}
