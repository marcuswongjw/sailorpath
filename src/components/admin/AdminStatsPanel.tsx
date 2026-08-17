"use client";

import { useCallback, useEffect, useState } from "react";
import { AlertTriangle, BarChart3, RefreshCw } from "lucide-react";

type StatsPayload = {
  generatedAt?: string;
  computeMs?: number;
  cached?: boolean;
  cacheAgeMs?: number | null;
  days?: number;
  inventory?: {
    sailors: number;
    regattas: number;
    results: number;
    profiles: number;
    claimsPending: number;
    supportNew: number;
    sailorsClaimed: number;
    sailorsUnclaimed?: number;
  };
  usage?: {
    sinceDays: number;
    totalEvents: number;
    uniqueSessions: number;
    byType: { eventType: string; count: number }[];
    topPaths: { path: string; count: number }[];
    rankingViews: number;
    profileViews: number;
    claimsSubmitted: number;
    claimsApproved: number;
    claimsRejected: number;
    truncated?: boolean;
  };
  ops?: {
    lastSeriesRegattaDate: string | null;
    daysSinceLastSeriesRegatta: number | null;
    lastImportAt: string | null;
    daysSinceLastImport: number | null;
    claimsPending: number;
    claimsApprovedAll: number;
    claimsRejectedAll: number;
    supportNew: number;
  };
  changeLog?: {
    id: string;
    createdAt: string;
    actorEmail: string | null;
    action: string;
    entityType: string;
    entityLabel: string | null;
    summary: string;
  }[];
  changeLogHint?: string | null;
  error?: string;
};

function StatCard({
  label,
  value,
  hint,
  tone = "default",
}: {
  label: string;
  value: string | number | null | undefined;
  hint?: string;
  tone?: "default" | "orange" | "sky" | "emerald" | "amber" | "rose";
}) {
  const tones: Record<string, string> = {
    default: "border-white/5 bg-slate-950/50 text-white",
    orange: "border-orange-500/20 bg-orange-500/5 text-orange-300",
    sky: "border-sky-500/20 bg-sky-500/5 text-sky-300",
    emerald: "border-emerald-500/20 bg-emerald-500/5 text-emerald-300",
    amber: "border-amber-500/25 bg-amber-500/5 text-amber-300",
    rose: "border-rose-500/25 bg-rose-500/5 text-rose-300",
  };
  return (
    <div
      className={`rounded-xl border px-2.5 sm:px-3 py-2 sm:py-2.5 min-w-0 ${tones[tone]}`}
    >
      <p className="text-[9px] sm:text-[10px] font-bold uppercase tracking-wide opacity-80 leading-tight">
        {label}
      </p>
      <p className="text-base sm:text-xl font-black mt-0.5 text-white tabular-nums break-words">
        {value == null || value === "" ? "—" : value}
      </p>
      {hint && (
        <p className="text-[9px] sm:text-[10px] text-slate-500 mt-0.5 leading-snug">
          {hint}
        </p>
      )}
    </div>
  );
}

export function AdminStatsPanel() {
  const [data, setData] = useState<StatsPayload | null>(null);
  const [days, setDays] = useState(7);
  const [busy, setBusy] = useState(false);
  const [err, setErr] = useState<string | null>(null);

  const load = useCallback(
    async (opts?: { force?: boolean }) => {
      setBusy(true);
      setErr(null);
      try {
        const q = new URLSearchParams({ days: String(days) });
        if (opts?.force) q.set("refresh", "1");
        const res = await fetch(`/api/admin/stats?${q}`, {
          credentials: "include",
        });
        const json = await res.json();
        if (!res.ok) throw new Error(json.error || "Failed to load stats");
        setData(json);
      } catch (e) {
        setErr(e instanceof Error ? e.message : "Failed");
      } finally {
        setBusy(false);
      }
    },
    [days]
  );

  useEffect(() => {
    let ignore = false;
    (async () => {
      setBusy(true);
      setErr(null);
      try {
        const res = await fetch(`/api/admin/stats?days=${days}`, {
          credentials: "include",
        });
        const json = await res.json();
        if (!res.ok) throw new Error(json.error || "Failed to load stats");
        if (!ignore) setData(json);
      } catch (e) {
        if (!ignore) setErr(e instanceof Error ? e.message : "Failed");
      } finally {
        if (!ignore) setBusy(false);
      }
    })();
    return () => {
      ignore = true;
    };
  }, [days]);

  const inv = data?.inventory;
  const usage = data?.usage;
  const ops = data?.ops;
  const log = data?.changeLog || [];

  const claimedPct =
    inv?.sailors && inv.sailors > 0 && inv.sailorsClaimed != null
      ? Math.round((inv.sailorsClaimed / inv.sailors) * 1000) / 10
      : null;

  return (
    <div className="w-full min-w-0 space-y-4 sm:space-y-6 overflow-x-clip">
      <div className="glass-panel rounded-2xl sm:rounded-3xl p-4 sm:p-6 border border-white/5 space-y-5">
        <div className="flex flex-col sm:flex-row sm:items-center justify-between gap-3">
          <div className="min-w-0">
            <h2 className="text-base sm:text-lg font-bold text-white flex items-center gap-2">
              <BarChart3 className="h-5 w-5 text-orange-500 shrink-0" />
              Stats & usage
            </h2>
            <p className="text-[11px] sm:text-xs text-slate-500 mt-1">
              Essential ops metrics only — privacy-light traffic sample + DB
              counts.
            </p>
          </div>
          <div className="flex items-center gap-2 shrink-0">
            <select
              value={days}
              onChange={(e) => setDays(Number(e.target.value))}
              className="rounded-lg bg-slate-950 border border-white/10 text-white text-xs px-2 py-2 min-h-[2.25rem]"
            >
              <option value={1}>Last 1 day</option>
              <option value={7}>Last 7 days</option>
              <option value={30}>Last 30 days</option>
            </select>
            <button
              type="button"
              onClick={() => void load({ force: true })}
              disabled={busy}
              className="rounded-full border border-white/10 bg-white/5 px-3 py-1.5 text-xs font-bold text-slate-200 hover:bg-white/10 disabled:opacity-50 flex items-center gap-1.5"
            >
              <RefreshCw
                className={`h-3.5 w-3.5 ${busy ? "animate-spin" : ""}`}
              />
              Refresh
            </button>
          </div>
        </div>

        {err && (
          <div className="rounded-xl border border-rose-500/30 bg-rose-500/10 px-3 py-2 text-xs text-rose-200 flex gap-2">
            <AlertTriangle className="h-4 w-4 shrink-0" />
            {err}
          </div>
        )}

        {busy && !data && (
          <div className="grid grid-cols-2 sm:grid-cols-4 gap-2 animate-pulse">
            {Array.from({ length: 8 }).map((_, i) => (
              <div
                key={i}
                className="h-16 rounded-xl border border-white/5 bg-white/[0.04]"
              />
            ))}
          </div>
        )}

        {data && (
          <p className="text-[10px] text-slate-600 font-mono">
            {data.computeMs != null ? `${data.computeMs}ms` : "—"}
            {data.cached
              ? ` · cached${
                  data.cacheAgeMs != null
                    ? ` ${Math.round(data.cacheAgeMs / 1000)}s`
                    : ""
                }`
              : " · live"}
            {busy ? " · refreshing…" : ""}
          </p>
        )}

        {data && (
          <>
            {/* Snapshot */}
            <div>
              <h3 className="text-[10px] font-bold uppercase tracking-wider text-slate-500 mb-2">
                Last {usage?.sinceDays ?? days} days
              </h3>
              <div className="grid grid-cols-2 sm:grid-cols-3 lg:grid-cols-6 gap-2">
                <StatCard
                  label="Sessions"
                  value={usage?.uniqueSessions}
                  tone="orange"
                />
                <StatCard label="Events" value={usage?.totalEvents} />
                <StatCard
                  label="Ranking views"
                  value={usage?.rankingViews}
                />
                <StatCard
                  label="Profile views"
                  value={usage?.profileViews}
                />
                <StatCard
                  label="Claims in → out"
                  value={`${usage?.claimsSubmitted ?? 0} → ${usage?.claimsApproved ?? 0}`}
                  hint={
                    (usage?.claimsRejected ?? 0) > 0
                      ? `${usage?.claimsRejected} rejected`
                      : undefined
                  }
                  tone="emerald"
                />
                <StatCard
                  label="% claimed"
                  value={claimedPct != null ? `${claimedPct}%` : "—"}
                  hint={
                    inv
                      ? `${inv.sailorsClaimed} of ${inv.sailors}`
                      : undefined
                  }
                />
              </div>
              {usage?.truncated && (
                <p className="text-[10px] text-slate-600 mt-2">
                  Traffic sample capped for speed — not a full event dump.
                </p>
              )}
            </div>

            {/* Ops */}
            <div>
              <h3 className="text-[10px] font-bold uppercase tracking-wider text-slate-500 mb-2">
                Ops
              </h3>
              <div className="grid grid-cols-2 sm:grid-cols-3 lg:grid-cols-4 gap-2">
                <StatCard
                  label="Claims pending"
                  value={ops?.claimsPending}
                  tone={
                    (ops?.claimsPending ?? 0) > 0 ? "amber" : "default"
                  }
                />
                <StatCard
                  label="Support new"
                  value={ops?.supportNew}
                  tone={(ops?.supportNew ?? 0) > 0 ? "amber" : "default"}
                />
                <StatCard
                  label="Last series regatta"
                  value={ops?.lastSeriesRegattaDate}
                  hint={
                    ops?.daysSinceLastSeriesRegatta != null
                      ? `${ops.daysSinceLastSeriesRegatta}d ago`
                      : undefined
                  }
                />
                <StatCard
                  label="Days since import"
                  value={ops?.daysSinceLastImport}
                  tone={
                    ops?.daysSinceLastImport != null &&
                    ops.daysSinceLastImport > 21
                      ? "amber"
                      : "default"
                  }
                />
                <StatCard
                  label="Claims approved"
                  value={ops?.claimsApprovedAll}
                />
                <StatCard
                  label="Claims rejected"
                  value={ops?.claimsRejectedAll}
                />
              </div>
            </div>

            {/* Inventory */}
            <div>
              <h3 className="text-[10px] font-bold uppercase tracking-wider text-slate-500 mb-2">
                Database
              </h3>
              <div className="grid grid-cols-2 sm:grid-cols-4 gap-2">
                <StatCard label="Sailors" value={inv?.sailors} />
                <StatCard label="Claimed" value={inv?.sailorsClaimed} />
                <StatCard label="Unclaimed" value={inv?.sailorsUnclaimed} />
                <StatCard label="Regattas" value={inv?.regattas} />
                <StatCard label="Results" value={inv?.results} />
                <StatCard label="Accounts" value={inv?.profiles} />
              </div>
            </div>

            {/* Traffic sample */}
            <div className="grid grid-cols-1 lg:grid-cols-2 gap-3">
              <div className="rounded-xl border border-white/5 overflow-hidden">
                <p className="text-[10px] font-bold text-slate-500 uppercase px-3 py-2 bg-white/5">
                  By event type
                </p>
                <ul className="max-h-40 overflow-y-auto text-xs divide-y divide-white/5">
                  {(usage?.byType || []).length === 0 ? (
                    <li className="px-3 py-3 text-slate-600">No events</li>
                  ) : (
                    usage!.byType.slice(0, 12).map((r) => (
                      <li
                        key={r.eventType}
                        className="px-3 py-1.5 flex justify-between gap-2"
                      >
                        <span className="font-mono text-slate-300">
                          {r.eventType}
                        </span>
                        <span className="font-black text-white">{r.count}</span>
                      </li>
                    ))
                  )}
                </ul>
              </div>
              <div className="rounded-xl border border-white/5 overflow-hidden">
                <p className="text-[10px] font-bold text-slate-500 uppercase px-3 py-2 bg-white/5">
                  Top paths
                </p>
                <ul className="max-h-40 overflow-y-auto text-xs divide-y divide-white/5">
                  {(usage?.topPaths || []).length === 0 ? (
                    <li className="px-3 py-3 text-slate-600">No paths</li>
                  ) : (
                    usage!.topPaths.map((r) => (
                      <li
                        key={r.path}
                        className="px-3 py-1.5 flex justify-between gap-2"
                      >
                        <span className="font-mono text-slate-300 truncate">
                          {r.path}
                        </span>
                        <span className="font-black text-white shrink-0">
                          {r.count}
                        </span>
                      </li>
                    ))
                  )}
                </ul>
              </div>
            </div>

            {/* Change log */}
            <div>
              <h3 className="text-[10px] font-bold uppercase tracking-wider text-slate-500 mb-2">
                Recent admin changes
              </h3>
              {data.changeLogHint && log.length === 0 && (
                <p className="text-[11px] text-slate-600">{data.changeLogHint}</p>
              )}
              <ul className="rounded-xl border border-white/5 divide-y divide-white/5 max-h-48 overflow-y-auto text-xs">
                {log.length === 0 ? (
                  <li className="px-3 py-3 text-slate-600">No recent changes</li>
                ) : (
                  log.map((e) => (
                    <li key={e.id} className="px-3 py-2 space-y-0.5">
                      <div className="flex justify-between gap-2">
                        <span className="font-mono text-[10px] text-slate-500">
                          {e.createdAt
                            ? String(e.createdAt).slice(0, 16).replace("T", " ")
                            : "—"}
                        </span>
                        <span className="text-[9px] font-bold uppercase text-slate-500">
                          {e.action}
                        </span>
                      </div>
                      <p className="text-slate-200 font-semibold leading-snug">
                        {e.summary}
                      </p>
                    </li>
                  ))
                )}
              </ul>
            </div>
          </>
        )}
      </div>
    </div>
  );
}
