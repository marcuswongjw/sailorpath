"use client";

import { FileText, Globe, Link2, Loader2, Trophy } from "lucide-react";
import { sheetClassLabel, type GroupableRegatta } from "@/lib/admin/groupRegattaEvents";

export type LinkableWeekend = {
  id: string;
  name: string;
  startDate: string;
};

function ymd(value: string | Date | null | undefined): string {
  if (value == null || value === "") return "";
  return String(value).slice(0, 10);
}

function raceLabel(count: number | null | undefined): string {
  if (count == null) return "Races not set";
  if (count === 1) return "1 completed race";
  return `${count} completed races`;
}

function fleetLabel(size: number | null | undefined): string {
  if (size == null) return "Fleet size not set";
  return `Fleet ${size}`;
}

function MetaLine({ items }: { items: string[] }) {
  return (
    <p className="mt-1 flex flex-wrap gap-x-1.5 gap-y-0.5 text-xs font-medium text-slate-600">
      {items.map((item, index) => (
        <span key={`${item}-${index}`} className="whitespace-nowrap">
          {index > 0 ? <span className="text-slate-300"> · </span> : null}
          {item}
        </span>
      ))}
    </p>
  );
}

export function AdminClassSheetCard({
  sheet,
  isShell = false,
  unassigned = false,
  isSuperadmin = false,
  weekends = [],
  linkTarget = "",
  linking = false,
  publishing = false,
  publishBlocked = false,
  onLinkTargetChange,
  onLink,
  onTogglePublish,
  onEditDetails,
  onOpenResults,
}: {
  sheet: GroupableRegatta;
  isShell?: boolean;
  unassigned?: boolean;
  isSuperadmin?: boolean;
  weekends?: LinkableWeekend[];
  linkTarget?: string;
  linking?: boolean;
  publishing?: boolean;
  publishBlocked?: boolean;
  onLinkTargetChange?: (eventId: string) => void;
  onLink?: () => void;
  onTogglePublish?: () => void;
  onEditDetails: () => void;
  onOpenResults: () => void;
}) {
  const classLabel = isShell ? sheet.name : sheetClassLabel(sheet);
  const title = unassigned ? sheet.name || classLabel : classLabel;
  const status = sheet.status || "published";
  const meta = [
    unassigned ? classLabel : "",
    raceLabel(sheet.raceCount),
    fleetLabel(sheet.totalFleetSize),
    ymd(sheet.date),
  ].filter(Boolean);

  return (
    <article className="rounded-xl border border-slate-200 bg-white p-3.5 shadow-xs sm:p-4">
      <div className="flex items-start justify-between gap-3">
        <div className="min-w-0 flex-1">
          <h5 className="text-sm font-bold leading-snug text-slate-900">{title}</h5>
          <MetaLine items={meta} />
          {sheet.slug ? (
            <p className="mt-0.5 truncate font-mono text-[11px] text-slate-500" title={sheet.slug}>
              {sheet.slug}
            </p>
          ) : null}
        </div>
        <div className="flex shrink-0 flex-col items-end gap-1">
          <span
            className={`rounded border px-2 py-0.5 text-[10px] font-bold uppercase ${
              status === "published"
                ? "border-emerald-200 bg-emerald-100 text-emerald-800"
                : status === "draft"
                  ? "border-amber-300 bg-amber-100 text-amber-800"
                  : status === "in_review"
                    ? "border-sky-200 bg-sky-100 text-sky-800"
                    : "border-slate-200 bg-slate-100 text-slate-700"
            }`}
          >
            {status}
          </span>
          {sheet.countsForRanking === false ? (
            <span className="rounded border border-sky-200 bg-sky-100 px-2 py-0.5 text-[10px] font-bold uppercase text-sky-800">
              Non-ranking
            </span>
          ) : null}
        </div>
      </div>

      {unassigned && isSuperadmin ? (
        <div className="mt-3 rounded-lg border border-dashed border-amber-200 bg-amber-50/70 p-2.5">
          <p className="mb-1.5 text-[10px] font-bold uppercase tracking-wider text-amber-900">
            Link to a weekend
          </p>
          <div className="flex flex-col gap-2 sm:flex-row sm:items-center">
            <label className="sr-only" htmlFor={`link-event-${sheet.id}`}>
              Weekend for {title}
            </label>
            <select
              id={`link-event-${sheet.id}`}
              value={linkTarget}
              onChange={(event) => onLinkTargetChange?.(event.target.value)}
              className="min-w-0 w-full flex-1 rounded-lg border border-slate-300 bg-white px-2.5 py-1.5 text-xs font-semibold text-slate-800"
            >
              <option value="">Choose a weekend…</option>
              {weekends.map((event) => (
                <option key={event.id} value={event.id}>
                  {event.name} ({event.startDate})
                </option>
              ))}
            </select>
            <button
              type="button"
              disabled={!linkTarget || linking}
              onClick={onLink}
              className="inline-flex shrink-0 items-center justify-center gap-1.5 rounded-lg border border-orange-300 bg-orange-50 px-3 py-1.5 text-xs font-bold text-orange-900 hover:bg-orange-100 disabled:opacity-40"
            >
              {linking ? <Loader2 className="h-3 w-3 animate-spin" /> : <Link2 className="h-3 w-3" />}
              Link
            </button>
          </div>
        </div>
      ) : null}

      <div className="mt-3 flex flex-wrap items-center justify-end gap-2 border-t border-slate-100 pt-3">
        {isSuperadmin && onTogglePublish ? (
          status === "draft" ? (
            <button
              type="button"
              disabled={publishing || publishBlocked}
              onClick={onTogglePublish}
              className="inline-flex items-center gap-1.5 rounded-lg bg-emerald-600 px-3 py-1.5 text-xs font-bold text-white shadow-xs transition-colors hover:bg-emerald-500 disabled:opacity-50"
              title="Publish this sailing class to rankings and public results"
            >
              {publishing ? <Loader2 className="h-3 w-3 animate-spin" /> : <Globe className="h-3 w-3" />}
              <span>Publish</span>
            </button>
          ) : (
            <button
              type="button"
              disabled={publishing}
              onClick={onTogglePublish}
              className="inline-flex items-center gap-1 rounded-lg border border-slate-300 bg-white px-2.5 py-1.5 text-xs font-semibold text-slate-700 shadow-xs transition-colors hover:bg-slate-50 disabled:opacity-50"
              title="Revert to draft (hide from public views)"
            >
              {publishing ? <Loader2 className="h-3 w-3 animate-spin" /> : null}
              <span>Unpublish</span>
            </button>
          )
        ) : null}
        <button
          type="button"
          onClick={onEditDetails}
          className="inline-flex items-center gap-1.5 rounded-lg border border-slate-300 bg-white px-3 py-1.5 text-xs font-bold text-slate-800 shadow-xs transition-colors hover:bg-slate-50"
        >
          <FileText className="h-3 w-3 text-slate-600" />
          <span>Edit Details</span>
        </button>
        <button
          type="button"
          onClick={onOpenResults}
          className="inline-flex items-center gap-1.5 rounded-lg bg-orange-600 px-3 py-1.5 text-xs font-bold text-white shadow-sm transition-colors hover:bg-orange-500"
        >
          <Trophy className="h-3 w-3" />
          <span>Results &amp; Scores</span>
        </button>
      </div>
    </article>
  );
}
