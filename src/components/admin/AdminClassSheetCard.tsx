"use client";

import { useState } from "react";
import { FileText, Link2, Loader2, Trash2 } from "lucide-react";
import { sheetClassLabel, type GroupableRegatta } from "@/lib/admin/groupRegattaEvents";
import type { PublicationReadiness } from "@/lib/admin/publicationReadiness";

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

function EventLinkControls({
  sheetId,
  heading,
  placeholder,
  actionLabel,
  fieldLabel,
  destinations,
  linkTarget,
  linking,
  onLinkTargetChange,
  onLink,
  emptyText,
  tone = "neutral",
}: {
  sheetId: string;
  heading: string;
  placeholder: string;
  actionLabel: string;
  fieldLabel: string;
  destinations: LinkableWeekend[];
  linkTarget: string;
  linking: boolean;
  onLinkTargetChange?: (eventId: string) => void;
  onLink?: () => void;
  emptyText?: string;
  tone?: "attention" | "neutral";
}) {
  const attention = tone === "attention";
  return (
    <div
      className={`mt-3 rounded-lg border p-2.5 ${
        attention
          ? "border-dashed border-amber-200 bg-amber-50/70"
          : "border-slate-200 bg-slate-50"
      }`}
    >
      <p
        className={`mb-1.5 text-[10px] font-bold uppercase tracking-wider ${
          attention ? "text-amber-900" : "text-slate-700"
        }`}
      >
        {heading}
      </p>
      {destinations.length === 0 && emptyText ? (
        <p className="text-xs font-medium text-slate-600">{emptyText}</p>
      ) : (
        <div className="flex flex-col gap-2 sm:flex-row sm:items-center">
          <label className="sr-only" htmlFor={`link-event-${sheetId}`}>
            {fieldLabel}
          </label>
          <select
            id={`link-event-${sheetId}`}
            value={linkTarget}
            onChange={(event) => onLinkTargetChange?.(event.target.value)}
            className="min-w-0 w-full flex-1 rounded-lg border border-slate-300 bg-white px-2.5 py-1.5 text-xs font-semibold text-slate-800"
          >
            <option value="">{placeholder}</option>
            {destinations.map((event) => (
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
            {actionLabel}
          </button>
        </div>
      )}
    </div>
  );
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
  currentEventId = "",
  linkTarget = "",
  linking = false,
  publishing = false,
  onLinkTargetChange,
  onLink,
  onTogglePublish,
  onDelete,
  onEditDetails,
  onOpenResults,
  onOpenCheck,
  readiness,
}: {
  sheet: GroupableRegatta;
  isShell?: boolean;
  unassigned?: boolean;
  isSuperadmin?: boolean;
  weekends?: LinkableWeekend[];
  /** Regatta this class is on now. Left out of the move list. */
  currentEventId?: string;
  linkTarget?: string;
  linking?: boolean;
  publishing?: boolean;
  publishBlocked?: boolean;
  onLinkTargetChange?: (eventId: string) => void;
  onLink?: () => void;
  onTogglePublish?: () => void;
  onDelete?: () => void;
  onEditDetails: () => void;
  onOpenResults: () => void;
  onOpenCheck?: () => void;
  readiness?: PublicationReadiness | null;
}) {
  const [menuOpen, setMenuOpen] = useState(false);
  const classLabel = isShell ? sheet.name : sheetClassLabel(sheet);
  const title = unassigned ? sheet.name || classLabel : classLabel;
  const status = sheet.status || "published";
  const published = status === "published";
  const primary = published
    ? { label: "View results", run: onOpenResults }
    : readiness &&
        (readiness.summary === "publishable_ranking" ||
          readiness.summary === "publishable_non_ranking")
      ? { label: "Review and publish", run: onOpenCheck || onOpenResults }
      : readiness?.checks.some((check) => check.code === "results-missing")
        ? { label: "Enter results", run: onOpenResults }
        : readiness
          ? { label: "Review class", run: onEditDetails }
          : { label: "Enter results", run: onOpenResults };
  const readinessText = !readiness
    ? null
    : published
      ? "Published"
      : readiness.summary === "blocked"
        ? "Blocked"
        : readiness.summary === "incomplete"
          ? "Needs work"
          : readiness.summary === "publishable_non_ranking"
            ? "Ready, non-ranking"
            : "Ready to publish";
  const showMenu = Boolean(onDelete) || (Boolean(onTogglePublish) && published);
  const destinations = weekends.filter((event) => event.id !== currentEventId);
  const showMove = isSuperadmin && !unassigned && Boolean(onLink);
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
          {readinessText ? (
            <p className="mt-1 text-xs font-bold text-slate-800">{readinessText}</p>
          ) : null}
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
        <EventLinkControls
          sheetId={sheet.id}
          heading="Choose an event"
          placeholder="Choose an event…"
          actionLabel="Link"
          fieldLabel={`Event for ${title}`}
          destinations={destinations}
          linkTarget={linkTarget}
          linking={linking}
          onLinkTargetChange={onLinkTargetChange}
          onLink={onLink}
          tone="attention"
        />
      ) : null}

      {showMove ? (
        <EventLinkControls
          sheetId={sheet.id}
          heading="Move to another regatta"
          placeholder="Choose a regatta…"
          actionLabel="Move"
          fieldLabel={`Regatta for ${title}`}
          destinations={destinations}
          linkTarget={linkTarget}
          linking={linking}
          onLinkTargetChange={onLinkTargetChange}
          onLink={onLink}
          emptyText="Save another regatta before moving this class."
        />
      ) : null}

      <div className="mt-3 flex flex-wrap items-center justify-end gap-2 border-t border-slate-100 pt-3">
        {showMenu ? (
          <div className="relative">
            <button
              type="button"
              aria-expanded={menuOpen}
              aria-haspopup="menu"
              onClick={() => setMenuOpen((open) => !open)}
              className="inline-flex min-h-11 items-center rounded-lg border border-slate-300 bg-white px-3 text-xs font-bold text-slate-800 hover:bg-slate-50"
            >
              Class actions
            </button>
            {menuOpen ? (
              <div
                role="menu"
                className="absolute right-0 z-20 mt-1 min-w-36 rounded-xl border border-slate-200 bg-white p-1 shadow-lg"
              >
                {published && onTogglePublish ? (
                  <button
                    type="button"
                    role="menuitem"
                    disabled={publishing}
                    onClick={() => {
                      setMenuOpen(false);
                      onTogglePublish();
                    }}
                    className="flex min-h-11 w-full items-center rounded-lg px-3 text-left text-xs font-bold text-slate-800 hover:bg-slate-50 disabled:opacity-50"
                  >
                    {publishing ? <Loader2 className="mr-1 h-3 w-3 animate-spin" /> : null}
                    Unpublish
                  </button>
                ) : null}
                {onDelete ? (
                  <button
                    type="button"
                    role="menuitem"
                    aria-label={`Delete ${title}`}
                    onClick={() => {
                      setMenuOpen(false);
                      onDelete();
                    }}
                    className="flex min-h-11 w-full items-center gap-1 rounded-lg px-3 text-left text-xs font-bold text-rose-800 hover:bg-rose-50"
                  >
                    <Trash2 className="h-3 w-3" />
                    Delete
                  </button>
                ) : null}
              </div>
            ) : null}
          </div>
        ) : null}
        <button
          type="button"
          onClick={onEditDetails}
          className="inline-flex min-h-11 items-center gap-1.5 rounded-lg border border-slate-300 bg-white px-3 text-xs font-bold text-slate-800 hover:bg-slate-50"
        >
          <FileText className="h-3 w-3 text-slate-600" />
          <span>Edit details</span>
        </button>
        <button
          type="button"
          onClick={primary.run}
          className="inline-flex min-h-11 items-center gap-1.5 rounded-lg bg-orange-600 px-3 text-xs font-bold text-white shadow-sm hover:bg-orange-500"
        >
          {primary.label}
        </button>
      </div>
    </article>
  );
}
