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
    sailorsUnclaimed?: number;
    guests?: number;
    personalRegattas?: number;
    personalUnreviewed?: number;
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
  dataQuality?: {
    emptySeries?: number;
    goldBeforeEntryCount?: number;
    goldBeforeEntry?: {
      sailorId: string;
      name: string;
      goldEntryDate: string;
      earliestGoldRegattaDate: string;
      earliestGoldRegattaName: string;
    }[];
    goldWithoutEntryCount?: number;
    goldWithoutEntry?: {
      sailorId: string;
      name: string;
      silverEntryDate: string | null;
      earliestGoldRegattaDate: string;
      earliestGoldRegattaName: string;
    }[];
    overAgeOptimistCount?: number;
    overAgeOptimist?: {
      sailorId: string;
      name: string;
      birthYear: number;
      ageYearsApprox: number;
      dropDate: string | null;
    }[];
    unrecognizedNationalityCount?: number;
    unrecognizedNationality?: {
      sailorId: string;
      name: string;
      nationality: string;
    }[];
  };
  changeLog?: {
    id: string;
    createdAt: string;
    actorEmail: string | null;
    action: string;
    entityType: string;
    entityLabel: string | null;
    summary: string;
    details: string | null;
  }[];
  changeLogHint?: string | null;
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
    let ignore = false;
    async function fetchData() {
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
        if (!ignore) {
          setErr(e instanceof Error ? e.message : "Failed");
          setData(null);
        }
      } finally {
        if (!ignore) setBusy(false);
      }
    }
    fetchData();
    return () => {
      ignore = true;
    };
  }, [days]);

  const inv = data?.inventory;
  const usage = data?.usage;
  const dq = data?.dataQuality;
  const log = data?.changeLog || [];

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
              Inventory, data quality, admin change log (includes names), and
              privacy-light traffic. Migrations:{" "}
              <code className="text-slate-400">016_usage_events.sql</code>,{" "}
              <code className="text-slate-400">023_admin_change_log.sql</code>.
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
              ["Claimed", inv?.sailorsClaimed],
              ["Unclaimed", inv?.sailorsUnclaimed],
              ["Guests (no series)", inv?.guests],
              ["Regattas (series)", inv?.regattas != null && inv?.personalRegattas != null
                ? Math.max(0, inv.regattas - inv.personalRegattas)
                : inv?.regattas],
              ["Personal log events", inv?.personalRegattas],
              ["Suggestions (unreviewed)", inv?.personalUnreviewed],
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

        {/* Data quality */}
        <div>
          <h3 className="text-[10px] font-bold uppercase tracking-wider text-slate-500 mb-2 flex items-center gap-1.5">
            <AlertTriangle className="h-3.5 w-3.5 text-amber-400" />
            Data quality flags
          </h3>
          <div className="grid grid-cols-2 lg:grid-cols-4 gap-2 mb-3">
            <div className="rounded-xl border border-amber-500/25 bg-amber-500/5 px-3 py-2.5">
              <p className="text-[10px] text-amber-200/80 font-bold uppercase">
                Empty Series
              </p>
              <p className="text-xl font-black text-amber-300">
                {dq?.emptySeries ?? "—"}
              </p>
            </div>
            <div className="rounded-xl border border-rose-500/25 bg-rose-500/5 px-3 py-2.5">
              <p className="text-[10px] text-rose-200/80 font-bold uppercase">
                Gold before entry
              </p>
              <p className="text-xl font-black text-rose-300">
                {dq?.goldBeforeEntryCount ?? "—"}
              </p>
            </div>
            <div className="rounded-xl border border-orange-500/25 bg-orange-500/5 px-3 py-2.5">
              <p className="text-[10px] text-orange-200/80 font-bold uppercase">
                Gold race, no gold entry
              </p>
              <p className="text-xl font-black text-orange-300">
                {dq?.goldWithoutEntryCount ?? "—"}
              </p>
            </div>
            <div className="rounded-xl border border-violet-500/25 bg-violet-500/5 px-3 py-2.5">
              <p className="text-[10px] text-violet-200/80 font-bold uppercase">
                Over-age in Optimist
              </p>
              <p className="text-xl font-black text-violet-300">
                {dq?.overAgeOptimistCount ?? "—"}
              </p>
            </div>
          </div>

          {(dq?.goldBeforeEntry || []).length > 0 && (
            <div className="mb-3">
              <p className="text-[10px] font-bold uppercase text-rose-300/90 mb-1">
                Gold result before gold entry date
              </p>
              <ul className="rounded-xl border border-white/5 divide-y divide-white/5 max-h-40 overflow-y-auto text-xs">
                {dq!.goldBeforeEntry!.map((g) => (
                  <li key={g.sailorId} className="px-3 py-2">
                    <p className="font-bold text-white">{g.name}</p>
                    <p className="text-slate-500">
                      Entry {g.goldEntryDate} but raced Gold at{" "}
                      <span className="text-slate-300">
                        {g.earliestGoldRegattaName}
                      </span>{" "}
                      on {g.earliestGoldRegattaDate} — move entry earlier (1
                      Jan / 1 Jul) or fix division.
                    </p>
                  </li>
                ))}
              </ul>
            </div>
          )}

          {(dq?.goldWithoutEntry || []).length > 0 && (
            <div className="mb-3">
              <p className="text-[10px] font-bold uppercase text-orange-300/90 mb-1">
                Raced Gold without gold entry (silver-only stamp)
              </p>
              <ul className="rounded-xl border border-white/5 divide-y divide-white/5 max-h-40 overflow-y-auto text-xs">
                {dq!.goldWithoutEntry!.map((g) => (
                  <li key={g.sailorId} className="px-3 py-2">
                    <p className="font-bold text-white">{g.name}</p>
                    <p className="text-slate-500">
                      Silver entry {g.silverEntryDate || "—"} · first Gold race{" "}
                      <span className="text-slate-300">
                        {g.earliestGoldRegattaName}
                      </span>{" "}
                      on {g.earliestGoldRegattaDate} — set gold entry (half
                      boundary) or reclassify results.
                    </p>
                  </li>
                ))}
              </ul>
            </div>
          )}

          {(dq?.overAgeOptimist || []).length > 0 && (
            <div className="mb-3">
              <p className="text-[10px] font-bold uppercase text-violet-300/90 mb-1">
                Still in Optimist series past under-16 age
              </p>
              <ul className="rounded-xl border border-white/5 divide-y divide-white/5 max-h-40 overflow-y-auto text-xs">
                {dq!.overAgeOptimist!.map((g) => (
                  <li key={g.sailorId} className="px-3 py-2">
                    <p className="font-bold text-white">{g.name}</p>
                    <p className="text-slate-500">
                      Born {g.birthYear} (~{g.ageYearsApprox}y) · set drop date
                      (1 Jan / 1 Jul) if they have left Optimist.
                    </p>
                  </li>
                ))}
              </ul>
            </div>
          )}

          {(dq?.unrecognizedNationality || []).length > 0 && (
            <div className="mb-3">
              <p className="text-[10px] font-bold uppercase text-sky-300/90 mb-1">
                Unrecognized nationality ({dq?.unrecognizedNationalityCount ?? 0})
              </p>
              <ul className="rounded-xl border border-white/5 divide-y divide-white/5 max-h-40 overflow-y-auto text-xs">
                {dq!.unrecognizedNationality!.map((g) => (
                  <li key={g.sailorId} className="px-3 py-2">
                    <p className="font-bold text-white">{g.name}</p>
                    <p className="text-slate-500">
                      Stored as “{g.nationality}” — pick a country from the list
                      on Database → Sailors.
                    </p>
                  </li>
                ))}
              </ul>
            </div>
          )}

          <p className="text-[10px] text-slate-600 mt-2">
            SGP Optimist sailors with ranking results are auto-included in series
            (unless Guest). Empty Series tags still benefit from a silver stamp
            for cleaner profiles. Nationality on import uses the latest regatta
            and flags mismatches for review.
          </p>
        </div>

        {/* Change log */}
        <div>
          <h3 className="text-[10px] font-bold uppercase tracking-wider text-slate-500 mb-2">
            Change log (admin / data)
          </h3>
          {data?.changeLogHint && (
            <p className="text-[11px] text-amber-200/90 mb-2">
              {data.changeLogHint}
            </p>
          )}
          <div className="rounded-xl border border-white/5 overflow-hidden">
            <ul className="max-h-72 overflow-y-auto text-xs divide-y divide-white/5">
              {log.length === 0 ? (
                <li className="px-3 py-4 text-slate-600">
                  No change log entries in this window.
                </li>
              ) : (
                log.map((e) => (
                  <li key={e.id} className="px-3 py-2 space-y-0.5">
                    <div className="flex flex-wrap items-center gap-2 justify-between">
                      <span className="font-mono text-[10px] text-slate-500">
                        {e.createdAt
                          ? String(e.createdAt).slice(0, 19).replace("T", " ")
                          : "—"}
                      </span>
                      <span className="rounded-full bg-white/5 border border-white/10 px-1.5 py-0.5 text-[9px] font-bold text-slate-400 uppercase">
                        {e.action}
                      </span>
                    </div>
                    <p className="text-slate-200 font-semibold leading-snug">
                      {e.summary}
                    </p>
                    <p className="text-[10px] text-slate-500">
                      {e.entityLabel || e.entityType}
                      {e.actorEmail ? ` · ${e.actorEmail}` : ""}
                    </p>
                  </li>
                ))
              )}
            </ul>
          </div>
        </div>

        {/* Traffic */}
        <div>
          <h3 className="text-[10px] font-bold uppercase tracking-wider text-slate-500 mb-2">
            Traffic (privacy-light, last {usage?.sinceDays ?? days} days)
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
