"use client";

import Link from "next/link";
import { useQuery } from "@tanstack/react-query";
import { ArrowRight, RefreshCw } from "lucide-react";
import type { RegattaAdmin } from "@/types/regatta";
import type { ResultAdmin } from "@/types/result";
import type {
  AdminInboxQueueCounts,
  AdminInboxQueueStates,
} from "@/lib/admin/adminInboxCounts";
import {
  inboxIsComplete,
  totalPendingAdminInboxItems,
} from "@/lib/admin/adminInboxCounts";
import {
  buildAdminOverview,
  type OverviewSheet,
} from "@/lib/admin/adminOverview";
import { adminQueryKeys } from "./adminQueryKeys";
import {
  adminJson,
  fetchAdminDuplicateCount,
  fetchAdminOverview,
} from "./adminFetch";

const queues = [
  ["claims", "Claims"],
  ["coaches", "Coach access"],
  ["suggestions", "Suggestions"],
  ["support", "Support"],
] as const;
const quickLinks = [
  ["/admin/result-imports", "Results import inbox"],
  ["/admin?area=events&view=card", "Find an event"],
  ["/admin?area=sailors&view=directory", "Find a sailor"],
  ["/admin/news", "Write an update"],
  ["/admin?area=insights&view=metrics", "View insights"],
];
const panel = "rounded-xl border border-slate-200 bg-white p-4";

function sheetHref(sheet: OverviewSheet) {
  const params = new URLSearchParams({
    area: "events",
    sheet: sheet.id,
    view: "readiness",
  });
  if (sheet.event) params.set("event", sheet.event);
  return `/admin?${params}`;
}
function timeLabel(value: number) {
  return value
    ? new Intl.DateTimeFormat("en-GB", { timeStyle: "short" }).format(value)
    : "Not checked yet";
}
function SummaryLink({
  title,
  value,
  hint,
  href,
}: {
  title: string;
  value: number | string;
  hint: string;
  href: string;
}) {
  return (
    <Link
      href={href}
      className={`${panel} hover:border-harbour focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-orange-600`}
    >
      <p className="text-sm font-semibold text-slate-600">{title}</p>
      <p className="my-2 text-2xl font-bold tabular-nums text-slate-900">
        {value}
      </p>
      <p className="text-xs text-slate-600">{hint}</p>
    </Link>
  );
}
function Retry({
  onRetry,
  children,
}: {
  onRetry: () => void;
  children: React.ReactNode;
}) {
  return (
    <button
      type="button"
      onClick={onRetry}
      className="inline-flex min-h-11 items-center gap-2 text-sm font-semibold text-harbour underline"
    >
      <RefreshCw className="h-4 w-4" aria-hidden="true" />
      {children}
    </button>
  );
}
type Change = { id: string; createdAt: string; summary: string };

export function AdminOverviewPanel({
  regattas,
  results,
  duplicateCount,
  inboxQueueCounts,
  inboxQueueStates,
  onRetryInbox,
}: {
  regattas?: RegattaAdmin[];
  results?: ResultAdmin[];
  duplicateCount?: number;
  inboxQueueCounts: AdminInboxQueueCounts;
  inboxQueueStates?: AdminInboxQueueStates;
  onRetryInbox?: () => void;
}) {
  const remote = !regattas || !results;
  const events = useQuery({
    queryKey: adminQueryKeys.overview(),
    queryFn: ({ signal }) => fetchAdminOverview({ signal }),
    enabled: remote,
  });
  const duplicates = useQuery({
    queryKey: adminQueryKeys.duplicates(),
    queryFn: ({ signal }) => fetchAdminDuplicateCount({ signal }),
    enabled: duplicateCount == null,
  });
  const recent = useQuery({
    queryKey: adminQueryKeys.recentChanges(),
    queryFn: ({ signal }) =>
      adminJson<{ changes: Change[] }>(
        "/api/admin/change-log?limit=5&days=14",
        { signal },
      ),
  });
  const overview =
    regattas && results ? buildAdminOverview(regattas, results) : events.data;
  const knownInbox = totalPendingAdminInboxItems(inboxQueueCounts);
  const completeInbox = inboxQueueStates
    ? inboxIsComplete(inboxQueueStates)
    : true;
  const issues = overview
    ? [...overview.blocked, ...overview.incomplete].sort(
        (a, b) =>
          Number(b.status === "published") - Number(a.status === "published") ||
          b.date.localeCompare(a.date),
      )
    : [];
  const duplicateValue = duplicateCount ?? duplicates.data?.duplicateCount;
  const staleEvents = remote && events.isError && Boolean(events.data);

  return (
    <section className="space-y-6" aria-label="Daily admin work">
      <div className="flex flex-wrap items-center justify-between gap-3">
        <p className="text-sm text-slate-600">
          Review waiting requests, fix event checks and continue your work.
        </p>
        <Link
          href="/admin?area=events&view=import"
          className="sp-primary inline-flex min-h-11 items-center gap-2 rounded-lg px-4 text-sm font-bold"
        >
          Import results <ArrowRight className="h-4 w-4" aria-hidden="true" />
        </Link>
      </div>
      <div className="grid gap-3 sm:grid-cols-2 xl:grid-cols-4">
        <SummaryLink
          title="Inbox"
          value={completeInbox ? knownInbox : `${knownInbox} known`}
          hint={
            completeInbox
              ? "Requests waiting for a decision"
              : "Some queues are loading or unavailable"
          }
          href="/admin?area=inbox&view=claims"
        />
        <SummaryLink
          title="Missing results"
          value={
            overview
              ? overview.missingResults.length
              : events.isError
                ? "Unavailable"
                : "Loading…"
          }
          hint={
            staleEvents
              ? "Last available count · refresh failed"
              : "Completed class sheets without results"
          }
          href="/admin?area=events&view=missing-results"
        />
        <SummaryLink
          title="Ready for review"
          value={
            overview
              ? overview.ready.length
              : events.isError
                ? "Unavailable"
                : "Loading…"
          }
          hint="Metadata complete; source scores still need review"
          href="/admin?area=events&view=ready-to-publish"
        />
        <SummaryLink
          title="Duplicate candidates"
          value={
            duplicateValue ?? (duplicates.isError ? "Unavailable" : "Loading…")
          }
          hint={
            duplicates.isError && duplicateValue != null
              ? "Last available count · refresh failed"
              : "Compare evidence before merging identities"
          }
          href="/admin?area=sailors&view=duplicates"
        />
      </div>
      <div className="grid gap-5 xl:grid-cols-[minmax(0,1.6fr)_minmax(16rem,1fr)]">
        <div className="space-y-5">
          <section className={panel} aria-labelledby="today-inbox-heading">
            <div className="flex flex-wrap items-center justify-between gap-2">
              <h2 id="today-inbox-heading" className="font-bold text-slate-900">
                Requests awaiting review
              </h2>
              {!completeInbox && onRetryInbox ? (
                <Retry onRetry={onRetryInbox}>Retry queues</Retry>
              ) : null}
            </div>
            {!completeInbox ? (
              <p role="status" className="mt-2 text-sm text-amber-800">
                The Inbox total is incomplete. Available queues remain usable.
              </p>
            ) : knownInbox === 0 ? (
              <p className="mt-2 text-sm text-slate-600">
                No requests are waiting for review.
              </p>
            ) : null}
            <ul className="mt-2 divide-y divide-slate-100">
              {queues.map(([view, label]) => {
                const state = inboxQueueStates?.[view];
                const usable =
                  !state ||
                  state.status === "ready" ||
                  state.status === "stale";
                const count = inboxQueueCounts[view];
                const value = usable
                  ? String(count)
                  : state.status === "loading"
                    ? "Loading…"
                    : "Unavailable";
                return (
                  <li key={view}>
                    <Link
                      href={`/admin?area=inbox&view=${view}`}
                      aria-label={
                        usable
                          ? `${label}: ${count} pending`
                          : `${label}: ${value}`
                      }
                      className="flex min-h-14 items-center justify-between gap-3 py-3 text-sm text-slate-900 hover:text-harbour"
                    >
                      <span>
                        {label}
                        {state ? (
                          <small className="ml-2 text-slate-500">
                            {state.status === "stale"
                              ? "Last available count"
                              : state.status === "ready"
                                ? `Checked ${timeLabel(state.updatedAt)}`
                                : ""}
                          </small>
                        ) : null}
                      </span>
                      <span className="inline-flex items-center gap-2 font-semibold">
                        {value}
                        <ArrowRight className="h-4 w-4" aria-hidden="true" />
                      </span>
                    </Link>
                  </li>
                );
              })}
            </ul>
          </section>
          {events.data?.demographics ? (
            <section className={panel} aria-labelledby="platform-coverage-heading">
              <div className="flex flex-wrap items-center justify-between gap-2 border-b border-slate-100 pb-3">
                <div>
                  <h2
                    id="platform-coverage-heading"
                    className="font-bold text-slate-900"
                  >
                    Platform Scale & Demographics
                  </h2>
                  <p className="mt-0.5 text-xs text-slate-500">
                    Active competitive fleet size, international representation and supported boat classes.
                  </p>
                </div>
                <Link
                  href="/admin?area=insights&view=metrics"
                  className="text-xs font-semibold text-harbour hover:underline"
                >
                  Full metrics →
                </Link>
              </div>

              {/* Top 4 Metrics Grid */}
              <div className="mt-4 grid grid-cols-2 gap-3 sm:grid-cols-4">
                <div className="rounded-lg bg-slate-50 p-3">
                  <p className="text-xs font-medium text-slate-500">Unique Sailors</p>
                  <p className="mt-1 text-xl font-bold tabular-nums text-slate-900">
                    {events.data.demographics.sailorsTotal.toLocaleString()}
                  </p>
                  <p className="mt-0.5 text-[10px] font-medium text-emerald-600">100% active competitors</p>
                </div>
                <div className="rounded-lg bg-slate-50 p-3">
                  <p className="text-xs font-medium text-slate-500">Nationalities</p>
                  <p className="mt-1 text-xl font-bold tabular-nums text-slate-900">
                    {events.data.demographics.nationalitiesCount.toLocaleString()}
                  </p>
                  <p className="mt-0.5 text-[10px] text-slate-500">Global representation</p>
                </div>
                <div className="rounded-lg bg-slate-50 p-3">
                  <p className="text-xs font-medium text-slate-500">Boat & Board Classes</p>
                  <p className="mt-1 text-xl font-bold tabular-nums text-slate-900">
                    {events.data.demographics.classesCount.toLocaleString()}
                  </p>
                  <p className="mt-0.5 text-[10px] text-slate-500">With verified results</p>
                </div>
                <div className="rounded-lg bg-slate-50 p-3">
                  <p className="text-xs font-medium text-slate-500">Recorded Results</p>
                  <p className="mt-1 text-xl font-bold tabular-nums text-slate-900">
                    {events.data.demographics.resultsTotal.toLocaleString()}
                  </p>
                  <p className="mt-0.5 text-[10px] text-slate-500">Scored race finishes</p>
                </div>
              </div>

              {/* Top Nationalities Badges */}
              {events.data.demographics.topNationalities?.length ? (
                <div className="mt-4">
                  <p className="text-xs font-semibold text-slate-600">Top Nationalities:</p>
                  <div className="mt-2 flex flex-wrap gap-1.5">
                    {events.data.demographics.topNationalities.map((item) => (
                      <span
                        key={item.country}
                        className="inline-flex items-center gap-1 rounded-md bg-slate-100 px-2 py-0.5 text-xs text-slate-700"
                      >
                        <span className="font-semibold">{item.country}:</span>
                        <span className="tabular-nums">{item.count.toLocaleString()}</span>
                      </span>
                    ))}
                  </div>
                </div>
              ) : null}

              {/* Boat Classes Breakdown */}
              {events.data.demographics.boatClasses?.length ? (
                <div className="mt-4 border-t border-slate-100 pt-3">
                  <p className="text-xs font-semibold text-slate-600">Classes with Results:</p>
                  <div className="mt-2 max-h-52 overflow-y-auto overflow-x-auto rounded-lg border border-slate-100">
                    <table className="w-full text-left text-xs text-slate-700">
                      <thead className="sticky top-0 bg-slate-50 text-slate-500">
                        <tr className="border-b border-slate-100">
                          <th className="py-1.5 px-3 font-semibold">Class</th>
                          <th className="py-1.5 px-3 text-right font-semibold">Regattas</th>
                          <th className="py-1.5 px-3 text-right font-semibold">Results</th>
                          <th className="py-1.5 px-3 text-right font-semibold">Sailors</th>
                        </tr>
                      </thead>
                      <tbody className="divide-y divide-slate-100">
                        {events.data.demographics.boatClasses.map((cls) => (
                          <tr key={cls.className} className="hover:bg-slate-50/60">
                            <td className="py-1.5 px-3 font-medium text-slate-900">{cls.className}</td>
                            <td className="py-1.5 px-3 text-right tabular-nums text-slate-600">{cls.regattaCount.toLocaleString()}</td>
                            <td className="py-1.5 px-3 text-right tabular-nums font-semibold text-slate-900">{cls.resultCount.toLocaleString()}</td>
                            <td className="py-1.5 px-3 text-right tabular-nums text-slate-600">{cls.sailorCount.toLocaleString()}</td>
                          </tr>
                        ))}
                      </tbody>
                    </table>
                  </div>
                </div>
              ) : null}
            </section>
          ) : null}
          <section className={panel} aria-labelledby="today-events-heading">
            <div className="flex flex-wrap items-center justify-between gap-2">
              <h2
                id="today-events-heading"
                className="font-bold text-slate-900"
              >
                Event checks
              </h2>
              <Link
                href="/admin?area=events&view=attention"
                className="text-sm font-semibold text-harbour"
              >
                View all checks →
              </Link>
            </div>
            {remote && events.isError ? (
              <div
                role="alert"
                className="mt-3 rounded-lg bg-amber-50 p-3 text-sm text-amber-900"
              >
                <p>
                  {overview
                    ? "Showing previous checks. The latest refresh failed."
                    : "Event checks could not load. No all-clear has been issued."}
                </p>
                <Retry onRetry={() => void events.refetch()}>
                  Retry event checks
                </Retry>
              </div>
            ) : null}
            {!overview && events.isPending ? (
              <p role="status" className="mt-3 text-sm text-slate-600">
                Loading event checks… You can continue in Inbox or Events.
              </p>
            ) : null}
            {overview ? (
              <>
                <p className="mt-2 text-xs text-slate-500">
                  {remote
                    ? `Checked ${timeLabel(events.dataUpdatedAt)} · `
                    : ""}
                  Metadata and result-presence checks; not a score audit.
                </p>
                {issues.length ? (
                  <ul className="mt-3 divide-y divide-slate-100">
                    {issues.slice(0, 6).map((sheet) => (
                      <li key={sheet.id}>
                        <Link
                          href={sheetHref(sheet)}
                          className="flex min-h-16 items-center justify-between gap-3 py-3 hover:text-harbour"
                        >
                          <span className="min-w-0">
                            <span className="block text-sm font-semibold text-slate-900">
                              {sheet.name}
                            </span>
                            <span className="mt-1 block text-xs text-slate-600">
                              {sheet.status === "published"
                                ? "Public result · "
                                : ""}
                              {sheet.issues?.[0] ||
                                (sheet.summary === "blocked"
                                  ? "Resolve a blocking check"
                                  : "Complete missing event details")}
                            </span>
                          </span>
                          <span className="shrink-0 text-sm font-semibold text-harbour">
                            Review →
                          </span>
                        </Link>
                      </li>
                    ))}
                  </ul>
                ) : !staleEvents ? (
                  <p className="mt-4 text-sm text-slate-600">
                    No blocking metadata issues found. Source and score review
                    remains a separate step.
                  </p>
                ) : null}
              </>
            ) : null}
            {duplicateCount == null && duplicates.isError ? (
              <div role="status" className="mt-3 text-sm text-amber-800">
                Duplicate detection could not refresh.{" "}
                <Retry onRetry={() => void duplicates.refetch()}>
                  Retry identity checks
                </Retry>
              </div>
            ) : null}
          </section>
        </div>
        <aside className="space-y-5">
          <section className={panel} aria-labelledby="today-actions-heading">
            <h2 id="today-actions-heading" className="font-bold text-slate-900">
              Continue working
            </h2>
            <ul className="mt-2 divide-y divide-slate-100">
              {quickLinks.map(([href, label]) => (
                <li key={href}>
                  <Link
                    href={href}
                    className="flex min-h-12 items-center justify-between text-sm font-semibold text-harbour"
                  >
                    {label}
                    <ArrowRight className="h-4 w-4" aria-hidden="true" />
                  </Link>
                </li>
              ))}
            </ul>
          </section>
          <section className={panel} aria-labelledby="today-changes-heading">
            <h2 id="today-changes-heading" className="font-bold text-slate-900">
              Recent changes
            </h2>
            <p className="mt-1 text-xs text-slate-500">
              Recent profile edits are activity, not pending inbox items.
            </p>
            {recent.isPending ? (
              <p role="status" className="mt-3 text-sm text-slate-600">
                Loading activity…
              </p>
            ) : null}
            {recent.isError ? (
              <div role="status" className="mt-3 text-sm text-amber-800">
                Activity could not refresh.{" "}
                <Retry onRetry={() => void recent.refetch()}>
                  Retry activity
                </Retry>
              </div>
            ) : null}
            {recent.data?.changes?.length ? (
              <ul className="mt-3 space-y-3">
                {recent.data.changes.map((change) => (
                  <li key={change.id} className="text-sm text-slate-800">
                    <p>{change.summary}</p>
                    <p className="mt-1 text-xs text-slate-500">
                      {new Date(change.createdAt).toLocaleString()}
                    </p>
                  </li>
                ))}
              </ul>
            ) : recent.isSuccess ? (
              <p className="mt-3 text-sm text-slate-600">
                No recorded changes in the last 14 days.
              </p>
            ) : null}
            <Link
              href="/admin?area=settings&view=audit"
              className="mt-4 inline-flex min-h-11 items-center gap-2 text-sm font-semibold text-harbour"
            >
              Open audit history{" "}
              <ArrowRight className="h-4 w-4" aria-hidden="true" />
            </Link>
          </section>
        </aside>
      </div>
    </section>
  );
}
