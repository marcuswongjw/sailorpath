"use client";

import { useCallback, useEffect, useState } from "react";
import { BarChart3, RefreshCw, AlertTriangle } from "lucide-react";

type StatsPayload = {
  generatedAt?: string;
  inventory?: {
    sailors: number;
    regattas: number;
    results: number;
    profiles: number;
    claimsPending: number;
    supportNew: number;
    sailorsClaimed: number;
    fleet: Record<string, number>;
  };
  usage?: {
    sinceDays: number;
    totalEvents: number;
    uniqueSessions: number;
    byType: { eventType: string; count: number }[];
    topPaths: { path: string; count: number }[];
    migrationHint?: string;
  };
  error?: string;
};

export function AdminStatsPanel() {
  const [data, setData] = useState<StatsPayload | null>(null);
  const [days, setDays] = useState(7);
  const [busy, setBusy] = useState(false);
  const [err, setErr] = useState<string | null>(null);

  const load = useCallback(async () => {
    setBusy(true);
    setErr(null);
    try {
      const res = await fetch(`/api/admin/stats?days=${days}`, {
        credentials: "include",
      });
      const json = await res.json();
      if (!res.ok) throw new Error(json.error || "Failed to load stats");
      setData(json);
    } catch (e) {
      setErr(e instanceof Error ? e.message : "Failed");
      setData(null);
    } finally {
      setBusy(false);
    }
  }, [days]);

  useEffect(() => {
    void load();
  }, [load]);

  const inv = data?.inventory;
  const usage = data?.usage;

  return (
    <div className="w-full min-w-0 space-y-6">
      <div className="glass-panel rounded-3xl p-6 sm:p-8 border border-white/5 space-y-4">
        <div className="flex flex-col sm:flex-row sm:items-center justify-between gap-3">
          <div>
            <h2 className="text-lg font-bold text-white flex items-center gap-2">
              <BarChart3 className="h-5 w-5 text-orange-500" />
              Stats & usage
            </h2>
            <p className="text-xs text-slate-500 mt-1">
              Product inventory from the database + privacy-light page events
              (no emails or names). Run migration{" "}
              <code className="text-slate-400">016_usage_events.sql</code> once
              for traffic tracking.
            </p>
          </div>
          <div className="flex items-center gap-2">
            <select
              value={days}
              onChange={(e) => setDays(Number(e.target.value))}
              className="rounded-lg bg-slate-950 border border-white/10 text-white text-xs px-2 py-1.5"
            >
              <option value={1}>Last 1 day</option>
              <option value={7}>Last 7 days</option>
              <option value={30}>Last 30 days</option>
              <option value={90}>Last 90 days</option>
            </select>
            <button
              type="button"
              onClick={() => void load()}
              disabled={busy}
              className="rounded-full border border-white/10 bg-white/5 px-3 py-1.5 text-xs font-bold text-slate-200 hover:bg-white/10 disabled:opacity-50 flex items-center gap-1.5"
            >
              <RefreshCw className={`h-3.5 w-3.5 ${busy ? "animate-spin" : ""}`} />
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

        {usage?.migrationHint && (
          <div className="rounded-xl border border-amber-500/30 bg-amber-500/10 px-3 py-2 text-xs text-amber-100">
            Usage table: {usage.migrationHint}
          </div>
        )}

        {data?.generatedAt && (
          <p className="text-[10px] text-slate-600 font-mono">
            Generated {data.generatedAt}
          </p>
        )}

        {/* Inventory */}
        <div>
          <h3 className="text-[10px] font-bold uppercase tracking-wider text-slate-500 mb-2">
            Product inventory
          </h3>
          <div className="grid grid-cols-2 sm:grid-cols-3 lg:grid-cols-4 gap-2">
            {[
              ["Sailors", inv?.sailors],
              ["Claimed profiles", inv?.sailorsClaimed],
              ["Regattas", inv?.regattas],
              ["Results rows", inv?.results],
              ["User accounts", inv?.profiles],
              ["Claims pending", inv?.claimsPending],
              ["Support new", inv?.supportNew],
            ].map(([label, n]) => (
              <div
                key={String(label)}
                className="rounded-xl border border-white/5 bg-slate-950/50 px-3 py-2.5"
              >
                <p className="text-[10px] text-slate-500 font-bold uppercase">
                  {label}
                </p>
                <p className="text-xl font-black text-white mt-0.5">
                  {n == null ? "—" : n}
                </p>
              </div>
            ))}
          </div>
          {inv?.fleet && Object.keys(inv.fleet).length > 0 && (
            <div className="mt-3 flex flex-wrap gap-2">
              {Object.entries(inv.fleet).map(([k, n]) => (
                <span
                  key={k}
                  className="rounded-full border border-white/10 bg-white/5 px-2.5 py-0.5 text-[10px] font-bold text-slate-300"
                >
                  Fleet {k}: {n}
                </span>
              ))}
            </div>
          )}
        </div>

        {/* Traffic */}
        <div>
          <h3 className="text-[10px] font-bold uppercase tracking-wider text-slate-500 mb-2">
            Traffic (last {usage?.sinceDays ?? days} days)
          </h3>
          <div className="grid grid-cols-2 gap-2 mb-3">
            <div className="rounded-xl border border-orange-500/20 bg-orange-500/5 px-3 py-2.5">
              <p className="text-[10px] text-orange-300/80 font-bold uppercase">
                Events
              </p>
              <p className="text-xl font-black text-orange-400">
                {usage?.totalEvents ?? "—"}
              </p>
            </div>
            <div className="rounded-xl border border-white/5 bg-slate-950/50 px-3 py-2.5">
              <p className="text-[10px] text-slate-500 font-bold uppercase">
                Unique sessions
              </p>
              <p className="text-xl font-black text-white">
                {usage?.uniqueSessions ?? "—"}
              </p>
            </div>
          </div>

          <div className="grid grid-cols-1 lg:grid-cols-2 gap-4">
            <div className="rounded-xl border border-white/5 overflow-hidden">
              <p className="text-[10px] font-bold text-slate-500 uppercase px-3 py-2 bg-white/5">
                By event type
              </p>
              <ul className="max-h-48 overflow-y-auto text-xs divide-y divide-white/5">
                {(usage?.byType || []).length === 0 ? (
                  <li className="px-3 py-3 text-slate-600">No events yet</li>
                ) : (
                  usage!.byType.map((r) => (
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
              <ul className="max-h-48 overflow-y-auto text-xs divide-y divide-white/5">
                {(usage?.topPaths || []).length === 0 ? (
                  <li className="px-3 py-3 text-slate-600">No paths yet</li>
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
        </div>
      </div>
    </div>
  );
}
