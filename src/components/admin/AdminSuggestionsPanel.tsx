"use client";

import { useCallback, useEffect, useState } from "react";
import { AlertTriangle, CheckCircle, RefreshCw, Sparkles } from "lucide-react";
import { regattaDateLabel } from "@/types/regatta";
import type { RegattaAdmin } from "@/types/regatta";

type Suggestion = {
  id: string;
  name: string;
  date: string | Date;
  totalFleetSize: number;
  division?: string | null;
  geography?: string | null;
  boatClass?: string | null;
  countsForRanking?: boolean | null;
  reviewedAt?: string | Date | null;
  results: {
    resultId: string;
    rank: number;
    nettScore?: number | null;
    sailorId: string;
    sailorName: string;
    sailorHandle: string;
  }[];
};

export function AdminSuggestionsPanel({
  onRegattaUpdated,
}: {
  onRegattaUpdated?: (reg: RegattaAdmin) => void;
}) {
  const [items, setItems] = useState<Suggestion[]>([]);
  const [busy, setBusy] = useState(false);
  const [err, setErr] = useState<string | null>(null);
  const [actionId, setActionId] = useState<string | null>(null);
  const [promoteForm, setPromoteForm] = useState<
    Record<
      string,
      { division: string; geography: string; totalFleetSize: string }
    >
  >({});

  const load = useCallback(async () => {
    setBusy(true);
    setErr(null);
    try {
      const res = await fetch("/api/admin/regatta-suggestions", {
        credentials: "include",
      });
      const data = await res.json();
      if (!res.ok) throw new Error(data.error || "Failed to load");
      setItems(data.suggestions || []);
      const forms: typeof promoteForm = {};
      for (const s of data.suggestions || []) {
        forms[s.id] = {
          division: "Gold",
          geography: s.geography || "SG",
          totalFleetSize: String(s.totalFleetSize || 50),
        };
      }
      setPromoteForm(forms);
    } catch (e) {
      setErr(e instanceof Error ? e.message : "Failed");
    } finally {
      setBusy(false);
    }
  }, []);

  useEffect(() => {
    void load();
  }, [load]);

  const patch = async (
    id: string,
    body: Record<string, unknown>
  ): Promise<RegattaAdmin | null> => {
    setActionId(id);
    try {
      const res = await fetch("/api/admin/regattas", {
        method: "PATCH",
        headers: { "Content-Type": "application/json" },
        credentials: "include",
        body: JSON.stringify({ id, ...body }),
      });
      const data = await res.json();
      if (!res.ok) throw new Error(data.error || "Update failed");
      onRegattaUpdated?.(data.regatta);
      setItems((prev) => prev.filter((x) => x.id !== id));
      return data.regatta;
    } catch (e) {
      alert(e instanceof Error ? e.message : "Failed");
      return null;
    } finally {
      setActionId(null);
    }
  };

  return (
    <div className="w-full min-w-0 space-y-4">
      <div className="glass-panel rounded-2xl border border-white/5 p-5 sm:p-6 space-y-3">
        <div className="flex flex-col sm:flex-row sm:items-center justify-between gap-3">
          <div>
            <h2 className="text-lg font-bold text-white flex items-center gap-2">
              <Sparkles className="h-5 w-5 text-sky-400" />
              Non-ranking suggestions
            </h2>
            <p className="text-xs text-slate-500 mt-1 max-w-2xl">
              When a claimed sailor adds an overseas / other logbook event, it
              appears here. <strong className="text-slate-300">Promote</strong>{" "}
              to put it on the official regatta list (eligible for Best 3 of 5),
              or <strong className="text-slate-300">Dismiss</strong> to keep it
              logbook-only.
            </p>
          </div>
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

        {err && (
          <div className="rounded-xl border border-rose-500/30 bg-rose-500/10 px-3 py-2 text-xs text-rose-200 flex gap-2">
            <AlertTriangle className="h-4 w-4 shrink-0" />
            {err}
            {/reviewed_at|column/i.test(err) && (
              <span className="block mt-1 text-rose-100/80">
                Run migration 018_regatta_reviewed_at.sql in Supabase.
              </span>
            )}
          </div>
        )}

        {items.length === 0 && !busy && !err ? (
          <div className="rounded-xl border border-white/5 bg-slate-950/40 px-4 py-8 text-center text-sm text-slate-500 flex flex-col items-center gap-2">
            <CheckCircle className="h-6 w-6 text-emerald-500/80" />
            No pending suggestions — queue is clear.
          </div>
        ) : (
          <ul className="space-y-3">
            {items.map((s) => {
              const form = promoteForm[s.id] || {
                division: "Gold",
                geography: "SG",
                totalFleetSize: "50",
              };
              return (
                <li
                  key={s.id}
                  className="rounded-2xl border border-sky-500/20 bg-sky-500/5 p-4 space-y-3"
                >
                  <div className="flex flex-wrap items-start justify-between gap-2">
                    <div>
                      <p className="text-sm font-bold text-white">{s.name}</p>
                      <p className="text-[11px] text-slate-400 font-mono mt-0.5">
                        {regattaDateLabel(s.date)} · {s.geography || "—"} · fleet{" "}
                        {s.totalFleetSize}
                      </p>
                      <span className="inline-block mt-1.5 rounded-full bg-sky-500/15 border border-sky-500/30 px-2 py-0.5 text-[9px] font-black text-sky-300 uppercase">
                        Non-ranking · needs review
                      </span>
                    </div>
                  </div>

                  <div className="rounded-xl border border-white/5 bg-slate-950/50 overflow-hidden">
                    <p className="text-[10px] font-bold text-slate-500 uppercase px-3 py-1.5 bg-white/5">
                      Sailor results on this event
                    </p>
                    <ul className="divide-y divide-white/5 text-xs">
                      {s.results.length === 0 ? (
                        <li className="px-3 py-2 text-slate-600">No results</li>
                      ) : (
                        s.results.map((r) => (
                          <li
                            key={r.resultId}
                            className="px-3 py-2 flex justify-between gap-2"
                          >
                            <span className="text-slate-200 font-semibold">
                              {r.sailorName}
                            </span>
                            <span className="font-mono text-slate-400">
                              Place {r.rank}
                              {r.nettScore != null ? ` · nett ${r.nettScore}` : ""}
                            </span>
                          </li>
                        ))
                      )}
                    </ul>
                  </div>

                  <div className="grid grid-cols-1 sm:grid-cols-3 gap-2">
                    <label className="text-[10px] font-bold text-slate-500 uppercase">
                      Division (on promote)
                      <select
                        value={form.division}
                        onChange={(e) =>
                          setPromoteForm((f) => ({
                            ...f,
                            [s.id]: { ...form, division: e.target.value },
                          }))
                        }
                        className="mt-1 w-full rounded-lg bg-slate-950 border border-white/10 text-white text-xs px-2 py-1.5"
                      >
                        <option value="Gold">Gold</option>
                        <option value="Silver">Silver</option>
                        <option value="Both">Both</option>
                      </select>
                    </label>
                    <label className="text-[10px] font-bold text-slate-500 uppercase">
                      Geography
                      <input
                        value={form.geography}
                        onChange={(e) =>
                          setPromoteForm((f) => ({
                            ...f,
                            [s.id]: {
                              ...form,
                              geography: e.target.value.toUpperCase(),
                            },
                          }))
                        }
                        className="mt-1 w-full rounded-lg bg-slate-950 border border-white/10 text-white text-xs px-2 py-1.5 font-mono"
                      />
                    </label>
                    <label className="text-[10px] font-bold text-slate-500 uppercase">
                      Fleet size
                      <input
                        type="number"
                        value={form.totalFleetSize}
                        onChange={(e) =>
                          setPromoteForm((f) => ({
                            ...f,
                            [s.id]: {
                              ...form,
                              totalFleetSize: e.target.value,
                            },
                          }))
                        }
                        className="mt-1 w-full rounded-lg bg-slate-950 border border-white/10 text-white text-xs px-2 py-1.5 font-mono"
                      />
                    </label>
                  </div>

                  <div className="flex flex-wrap gap-2">
                    <button
                      type="button"
                      disabled={actionId === s.id}
                      onClick={() =>
                        void patch(s.id, {
                          action: "promote",
                          division: form.division,
                          geography: form.geography,
                          totalFleetSize: Number(form.totalFleetSize) || 50,
                        })
                      }
                      className="rounded-full bg-orange-600 hover:bg-orange-500 px-4 py-1.5 text-[11px] font-bold text-white disabled:opacity-50"
                    >
                      Promote to series list
                    </button>
                    <button
                      type="button"
                      disabled={actionId === s.id}
                      onClick={() => void patch(s.id, { action: "dismiss" })}
                      className="rounded-full border border-white/10 bg-white/5 px-4 py-1.5 text-[11px] font-bold text-slate-300 hover:text-white disabled:opacity-50"
                    >
                      Dismiss (keep non-ranking)
                    </button>
                  </div>
                </li>
              );
            })}
          </ul>
        )}
      </div>
    </div>
  );
}
