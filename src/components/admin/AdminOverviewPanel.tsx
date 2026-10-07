"use client";

import Link from "next/link";
import { useQuery } from "@tanstack/react-query";
import type { AdminInboxView } from "@/components/admin/adminNav";
import {
  AlertTriangle,
  ArrowRight,
  CheckCircle2,
  History,
  Inbox,
  Sailboat,
  UserRoundSearch,
} from "lucide-react";
import type { RegattaAdmin } from "@/types/regatta";
import type { ResultAdmin } from "@/types/result";
import type { AdminInboxQueueCounts } from "@/lib/admin/adminInboxCounts";
import { totalPendingAdminInboxItems } from "@/lib/admin/adminInboxCounts";
import { buildAdminOverview, type OverviewSheet } from "@/lib/admin/adminOverview";

function sheetHref(sheet: OverviewSheet, view: "results" | "readiness") {
  const params = new URLSearchParams({
    area: "events",
    sheet: sheet.id,
    view,
  });
  if (sheet.event) params.set("event", sheet.event);
  return `/admin?${params.toString()}`;
}

type AuditRow = {
  id: string;
  createdAt: string;
  summary: string;
  entityType: string;
  entityId: string | null;
};

const INBOX_QUEUES: { view: AdminInboxView; label: string }[] = [
  { view: "suggestions", label: "Suggestions" },
  { view: "claims", label: "Claims" },
  { view: "coaches", label: "Coach access" },
  { view: "support", label: "Support" },
];

function InboxQueueCard({
  queues,
}: {
  queues: AdminInboxQueueCounts;
}) {
  const total = totalPendingAdminInboxItems(queues);
  return (
    <div className={`rounded-2xl border p-4 text-slate-300 ${total ? "border-rose-500/25 bg-rose-500/5" : "border-emerald-500/25 bg-emerald-500/5"}`}>
      <div className="flex items-start justify-between gap-3">
        <Inbox className="h-5 w-5" aria-hidden={true} />
        <span className="text-2xl font-black text-white">{total}</span>
      </div>
      <h2 className="mt-4 font-bold text-white">Inbox</h2>
      <p className="mt-1 text-xs leading-relaxed text-slate-400">
        {total === 0 ? "No items are waiting for review." : "Items awaiting a response or review."}
      </p>
      <ul className="mt-3 grid grid-cols-2 gap-2">
        {INBOX_QUEUES.map(({ view, label }) => (
          <li key={view}>
            <Link
              href={`/admin?area=inbox&view=${view}`}
              aria-label={`${label}: ${queues[view]} pending`}
              className="flex min-h-11 items-center justify-between gap-2 rounded-xl border border-white/10 px-2.5 text-xs font-semibold text-slate-200 hover:bg-white/5 focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-orange-400"
            >
              <span>{label}</span>
              <span className="font-black text-white">{queues[view]}</span>
            </Link>
          </li>
        ))}
      </ul>
      <p className="mt-3 text-[11px] leading-relaxed text-slate-500">
        Recent profile edits are activity, not pending inbox items; see Recent changes.
      </p>
    </div>
  );
}

function ActionCard({
  title,
  count,
  description,
  href,
  icon: Icon,
  tone = "slate",
}: {
  title: string;
  count: number;
  description: string;
  href: string;
  icon: React.ComponentType<{ className?: string; "aria-hidden"?: boolean }>;
  tone?: "slate" | "amber" | "rose" | "emerald";
}) {
  const tones = {
    slate: "border-white/10 bg-white/[0.03] text-slate-300",
    amber: "border-amber-500/25 bg-amber-500/5 text-amber-300",
    rose: "border-rose-500/25 bg-rose-500/5 text-rose-300",
    emerald: "border-emerald-500/25 bg-emerald-500/5 text-emerald-300",
  };
  return (
    <Link href={href} className={`group rounded-2xl border p-4 focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-orange-400 ${tones[tone]}`}>
      <div className="flex items-start justify-between gap-3">
        <Icon className="h-5 w-5" aria-hidden={true} />
        <span className="text-2xl font-black text-white">{count}</span>
      </div>
      <h2 className="mt-4 font-bold text-white">{title}</h2>
      <p className="mt-1 text-xs leading-relaxed text-slate-400">{description}</p>
      <span className="mt-3 inline-flex items-center gap-1 text-xs font-bold">
        Open workspace <ArrowRight className="h-3.5 w-3.5 transition-transform group-hover:translate-x-0.5" aria-hidden={true} />
      </span>
    </Link>
  );
}

export function AdminOverviewPanel({
  regattas,
  results,
  duplicateCount,
  inboxQueueCounts,
}: {
  regattas: RegattaAdmin[];
  results: ResultAdmin[];
  duplicateCount: number;
  inboxQueueCounts: AdminInboxQueueCounts;
}) {
  const overview = buildAdminOverview(regattas, results);
  const attention = [...overview.blocked, ...overview.incomplete].slice(0, 6);
  const recent = useQuery({
    queryKey: ["admin", "overview-changes"],
    queryFn: async () => {
      const res = await fetch("/api/admin/change-log?limit=5&days=14");
      const data = await res.json();
      if (!res.ok) throw new Error(data.error || "Could not load recent changes");
      return (data.changes || []) as AuditRow[];
    },
  });

  return (
    <section className="space-y-6" aria-labelledby="overview-heading">
      <div className="glass-panel rounded-2xl border border-white/5 p-5">
        <h2 id="overview-heading" className="text-lg font-black text-white">Work requiring attention</h2>
        <p className="mt-1 text-sm text-slate-400">Open an item to continue in the workspace that owns it.</p>
      </div>

      <div className="grid gap-3 sm:grid-cols-2 xl:grid-cols-4">
        <InboxQueueCard queues={inboxQueueCounts} />
        <ActionCard title="Missing results" count={overview.missingResults.length} description="Classes with a recorded race count but no score rows." href="/admin?area=events&view=missing-results" icon={Sailboat} tone={overview.missingResults.length ? "amber" : "emerald"} />
        <ActionCard title="Duplicate sailors" count={duplicateCount} description="Likely duplicate records waiting for review or merge." href="/admin?area=sailors&view=duplicates" icon={UserRoundSearch} tone={duplicateCount ? "amber" : "emerald"} />
        <ActionCard title="Ready to publish" count={overview.ready.length} description="Valid, complete classes ready for a final publication review." href="/admin?area=events&view=ready-to-publish" icon={CheckCircle2} tone="emerald" />
      </div>

      <div className="grid gap-4 lg:grid-cols-[minmax(0,1.4fr)_minmax(17rem,0.6fr)]">
        <div className="rounded-2xl border border-white/10 bg-white/[0.03] p-4">
          <div className="flex items-center justify-between gap-3">
            <h2 className="font-bold text-white">Event data health</h2>
            <span className="text-xs font-bold text-slate-400">{overview.blocked.length} blocked · {overview.incomplete.length} incomplete</span>
          </div>
          <Link
            href="/admin?area=events&view=attention"
            className="mt-2 inline-flex min-h-11 items-center gap-1 text-xs font-bold text-orange-300 hover:text-orange-200 focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-orange-400"
          >
            View all {overview.blocked.length + overview.incomplete.length} issues
            <ArrowRight className="h-3.5 w-3.5" aria-hidden={true} />
          </Link>
          {attention.length ? (
            <ul className="mt-3 divide-y divide-white/10">
              {attention.map((sheet) => (
                <li key={sheet.id}>
                  <Link href={sheetHref(sheet, sheet.summary === "blocked" || sheet.summary === "incomplete" ? "readiness" : "results")} className="flex min-h-12 items-center justify-between gap-3 py-2 text-sm hover:text-orange-800 focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-orange-600">
                    <span className="inline-flex min-w-0 items-center gap-2"><AlertTriangle className="h-4 w-4 shrink-0 text-amber-400" aria-hidden={true} /><span className="truncate text-slate-200">{sheet.name}</span></span>
                    <span className="shrink-0 text-xs font-bold capitalize text-slate-500">{sheet.summary.replace("_", " ")}</span>
                  </Link>
                </li>
              ))}
            </ul>
          ) : (
            <p className="mt-4 text-sm text-emerald-300">No blocked or incomplete class sheets.</p>
          )}
        </div>

        <div className="rounded-2xl border border-white/10 bg-white/[0.03] p-4">
          <History className="h-5 w-5 text-slate-400" aria-hidden={true} />
          <h2 className="mt-3 font-bold text-white">Recent changes</h2>
          <p className="mt-1 text-xs leading-relaxed text-slate-500">
            Recent profile edits are activity, not pending inbox work.
          </p>
          {recent.isLoading ? (
            <p className="mt-1 text-xs leading-relaxed text-slate-600">Loading recent changes…</p>
          ) : recent.data && recent.data.length > 0 ? (
            <ul className="mt-3 space-y-2">
              {recent.data.map((row) => (
                <li key={row.id} className="text-sm text-slate-800">
                  <span className="block font-semibold text-slate-900">{row.summary}</span>
                  <span className="text-xs text-slate-600">{new Date(row.createdAt).toLocaleString()}</span>
                </li>
              ))}
            </ul>
          ) : (
            <p className="mt-1 text-xs leading-relaxed text-slate-600">
              {recent.isError ? "Recent changes are available to a superadmin." : "No recent changes in the last 14 days."}
            </p>
          )}
          <div className="mt-4 flex flex-col gap-2">
            <Link href="/admin?area=settings&view=audit" className="inline-flex min-h-11 items-center justify-between rounded-xl border border-slate-200 px-3 text-sm font-bold text-slate-900 hover:bg-slate-50">Audit log <ArrowRight className="h-4 w-4" aria-hidden={true} /></Link>
          </div>
        </div>
      </div>
    </section>
  );
}
