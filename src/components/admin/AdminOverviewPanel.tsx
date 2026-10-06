"use client";

import Link from "next/link";
import { useQuery } from "@tanstack/react-query";
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
  inboxCount,
  inboxHref,
  suggestionsCount,
  claimsCount,
}: {
  regattas: RegattaAdmin[];
  results: ResultAdmin[];
  duplicateCount: number;
  inboxCount: number;
  inboxHref: string;
  suggestionsCount: number;
  claimsCount: number;
}) {
  const overview = buildAdminOverview(regattas, results);
  const attention = [...overview.blocked, ...overview.incomplete].slice(0, 6);
  const missing = overview.missingResults.slice(0, 6);
  const ready = overview.ready.slice(0, 6);
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
        <ActionCard title="Inbox" count={inboxCount} description={`${suggestionsCount} suggestion${suggestionsCount === 1 ? "" : "s"} · ${claimsCount} claim${claimsCount === 1 ? "" : "s"} · coach access and support`} href={inboxHref} icon={Inbox} tone={inboxCount ? "rose" : "emerald"} />
        <ActionCard title="Missing results" count={overview.missingResults.length} description="Classes with races recorded and no score rows." href={missing[0] ? sheetHref(missing[0], "results") : "/admin?area=events&view=card"} icon={Sailboat} tone={overview.missingResults.length ? "amber" : "emerald"} />
        <ActionCard title="Duplicate sailors" count={duplicateCount} description="Likely duplicate records waiting for review or merge." href="/admin?area=sailors&view=duplicates" icon={UserRoundSearch} tone={duplicateCount ? "amber" : "emerald"} />
        <ActionCard title="Ready to publish" count={overview.ready.length} description="Valid, complete classes ready for a final publication review." href={ready[0] ? sheetHref(ready[0], "readiness") : "/admin?area=events&view=card"} icon={CheckCircle2} tone="emerald" />
      </div>

      <div className="grid gap-4 lg:grid-cols-[minmax(0,1.4fr)_minmax(17rem,0.6fr)]">
        <div className="rounded-2xl border border-white/10 bg-white/[0.03] p-4">
          <div className="flex items-center justify-between gap-3">
            <h2 className="font-bold text-white">Event data health</h2>
            <span className="text-xs font-bold text-slate-400">{overview.blocked.length} blocked · {overview.incomplete.length} incomplete</span>
          </div>
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
