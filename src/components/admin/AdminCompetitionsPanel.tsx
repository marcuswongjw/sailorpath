"use client";

import { Medal, Plus, Edit3, Trash2 } from "lucide-react";
import type { SailorAdmin } from "@/types/sailor";
import type { RegattaAdmin } from "@/types/regatta";
import { regattaDateLabel } from "@/types/regatta";
import type { ResultAdmin } from "@/types/result";

export type AdminCompetitionsPanelProps = {
  competitionsSailorId: string | null;
  competitionsLoading: boolean;
  sailorList: SailorAdmin[];
  regattaList: RegattaAdmin[];
  resultsList: ResultAdmin[];
  editingResultId: string | null;
  setEditingResultId: (id: string | null) => void;
  resultForm: any;
  setResultForm: (v: any) => void;
  closeSailorResults: () => void;
  handleSaveResult: () => void | Promise<void>;
  handleDeleteResult: (id: string) => void | Promise<void>;
};

export function AdminCompetitionsPanel({
  competitionsSailorId,
  competitionsLoading,
  sailorList,
  regattaList,
  resultsList,
  editingResultId,
  setEditingResultId,
  resultForm,
  setResultForm,
  closeSailorResults,
  handleSaveResult,
  handleDeleteResult,
}: AdminCompetitionsPanelProps) {
  if (!competitionsSailorId) return null;

  const sailor = sailorList.find((x) => x.id === competitionsSailorId);
  const sid = competitionsSailorId;
  const sailorResults = resultsList
    .filter((r) => String(r.sailorId) === String(sid))
    .map((r) => {
      const reg = regattaList.find((g) => g.id === r.regattaId);
      return { ...r, regatta: reg };
    })
    .sort((a, b) => {
      const da = a.regatta?.date || "";
      const db_ = b.regatta?.date || "";
      return String(db_).localeCompare(String(da));
    });

  return (
<div
            className="fixed inset-0 z-[200] flex items-end sm:items-center justify-center p-0 sm:p-4"
            role="dialog"
            aria-modal="true"
            aria-label="Sailor regatta results"
          >
            <button
              type="button"
              className="absolute inset-0 bg-black/70 backdrop-blur-sm"
              aria-label="Close"
              onClick={closeSailorResults}
            />
            <div className="relative z-10 w-full sm:max-w-4xl max-h-[92vh] overflow-y-auto rounded-t-3xl sm:rounded-3xl border border-orange-500/30 bg-[#0c0d14] shadow-2xl p-5 sm:p-6 space-y-4">
              <div className="flex flex-col sm:flex-row sm:items-start justify-between gap-3">
                <div>
                  <h3 className="text-base font-black text-white flex items-center gap-2">
                    <Medal className="h-5 w-5 text-orange-400" />
                    All regatta results — {sailor?.name || "Sailor"}
                  </h3>
                  <p className="text-xs text-slate-500 mt-1">
                    Edit rank / total / nett for each event, add a missing regatta, or delete.
                    {competitionsLoading ? " Refreshing…" : ""}
                  </p>
                  <p className="text-[11px] text-slate-600 mt-1">
                    {sailorResults.length} result
                    {sailorResults.length === 1 ? "" : "s"} found
                    {sailor?.sailNumber ? ` · ${sailor.sailNumber}` : ""}
                  </p>
                </div>
                <div className="flex flex-wrap gap-2">
                  <button
                    type="button"
                    onClick={() => {
                      setEditingResultId("new");
                      setResultForm({
                        id: "",
                        regattaId: regattaList[0]?.id || "",
                        sailorId: sid,
                        rank: 1,
                        nettScore: "",
                        totalScore: "",
                        isDNS: false,
                      });
                    }}
                    className="rounded-full bg-orange-600 hover:bg-orange-500 px-4 py-2 text-xs font-bold text-white flex items-center gap-1"
                  >
                    <Plus className="h-4 w-4" />
                    Add result
                  </button>
                  <button
                    type="button"
                    onClick={closeSailorResults}
                    className="rounded-full bg-slate-800 px-4 py-2 text-xs font-bold text-slate-300 hover:text-white"
                  >
                    Close
                  </button>
                </div>
              </div>

              {editingResultId && (
                <div className="rounded-2xl border border-white/10 bg-slate-950/80 p-4 space-y-3">
                  <p className="text-[10px] font-bold text-slate-500 uppercase">
                    {editingResultId === "new" ? "New result" : "Edit result"}
                  </p>
                  <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-3">
                    <div className="sm:col-span-2">
                      <label className="text-[10px] font-bold text-slate-500 uppercase">
                        Regatta
                      </label>
                      <select
                        value={resultForm.regattaId}
                        onChange={(e) =>
                          setResultForm({
                            ...resultForm,
                            regattaId: e.target.value,
                            sailorId: sid,
                          })
                        }
                        className="mt-1 w-full rounded-xl border border-white/5 bg-slate-950 px-3 py-2 text-white text-xs"
                      >
                        <option value="">— Select —</option>
                        {regattaList.map((r) => (
                          <option key={r.id} value={r.id}>
                            {r.name} ({regattaDateLabel(r.date)}) · {r.division}
                          </option>
                        ))}
                      </select>
                    </div>
                    <div>
                      <label className="text-[10px] font-bold text-slate-500 uppercase">
                        Rank
                      </label>
                      <input
                        type="number"
                        value={resultForm.rank}
                        onChange={(e) =>
                          setResultForm({ ...resultForm, rank: e.target.value })
                        }
                        className="mt-1 w-full rounded-xl border border-white/5 bg-slate-950 px-3 py-2 text-white text-xs font-mono"
                      />
                    </div>
                    <div>
                      <label className="text-[10px] font-bold text-slate-500 uppercase">
                        Total Score
                      </label>
                      <input
                        type="number"
                        step="any"
                        value={resultForm.totalScore}
                        onChange={(e) =>
                          setResultForm({
                            ...resultForm,
                            totalScore: e.target.value,
                          })
                        }
                        className="mt-1 w-full rounded-xl border border-white/5 bg-slate-950 px-3 py-2 text-white text-xs font-mono"
                      />
                    </div>
                    <div>
                      <label className="text-[10px] font-bold text-slate-500 uppercase">
                        Nett Score (optional)
                      </label>
                      <input
                        type="number"
                        step="any"
                        value={resultForm.nettScore}
                        onChange={(e) =>
                          setResultForm({
                            ...resultForm,
                            nettScore: e.target.value,
                          })
                        }
                        className="mt-1 w-full rounded-xl border border-white/5 bg-slate-950 px-3 py-2 text-white text-xs font-mono"
                      />
                    </div>
                    <div className="flex items-center gap-2 sm:col-span-2">
                      <input
                        type="checkbox"
                        id="modalDns"
                        checked={Boolean(resultForm.isDNS || resultForm.isDns)}
                        onChange={(e) => {
                          const on = e.target.checked;
                          const reg = regattaList.find(
                            (r) => r.id === resultForm.regattaId
                          );
                          const dnsPts = (reg?.totalFleetSize || 50) + 1;
                          setResultForm({
                            ...resultForm,
                            isDNS: on,
                            isDns: on,
                            ...(on ? { rank: dnsPts } : {}),
                          });
                        }}
                        className="rounded border-slate-700 bg-slate-900 text-orange-600 h-4 w-4"
                      />
                      <label htmlFor="modalDns" className="text-xs text-slate-400 font-bold cursor-pointer">
                        DNS (default rank = fleet size + 1; editable)
                      </label>
                    </div>
                    <div className="flex items-center gap-2 sm:col-span-2">
                      <input
                        type="checkbox"
                        id="modalOverseas"
                        checked={Boolean(resultForm.isOverseasCommitment)}
                        onChange={(e) => {
                          const on = e.target.checked;
                          setResultForm({
                            ...resultForm,
                            isOverseasCommitment: on,
                            isDNS: on ? false : resultForm.isDNS,
                            isDns: on ? false : resultForm.isDns,
                          });
                        }}
                        className="rounded border-slate-700 bg-slate-900 text-sky-500 h-4 w-4"
                      />
                      <label htmlFor="modalOverseas" className="text-xs text-sky-300/90 font-bold cursor-pointer leading-snug">
                        Overseas commitment (SSF) — set rank/pts to standing (e.g. 2nd → 2 pts)
                      </label>
                    </div>
                  </div>
                  <div className="flex justify-end gap-2">
                    <button
                      type="button"
                      onClick={() => setEditingResultId(null)}
                      className="rounded-full bg-slate-800 px-4 py-2 text-xs font-bold text-slate-400"
                    >
                      Cancel
                    </button>
                    <button
                      type="button"
                      onClick={() => void handleSaveResult()}
                      className="rounded-full bg-orange-600 px-4 py-2 text-xs font-bold text-white"
                    >
                      Save result
                    </button>
                  </div>
                </div>
              )}

              <div className="overflow-x-auto rounded-xl border border-white/5">
                <table className="w-full text-left text-xs">
                  <thead>
                    <tr className="bg-white/5 text-[10px] font-bold text-slate-400 uppercase">
                      <th className="py-3 px-4">Regatta</th>
                      <th className="py-3 px-4 text-center">Date</th>
                      <th className="py-3 px-4 text-center">Div</th>
                      <th className="py-3 px-4 text-center">Rank</th>
                      <th className="py-3 px-4 text-center">Total</th>
                      <th className="py-3 px-4 text-center">Nett</th>
                      <th className="py-3 px-4 text-center">Status</th>
                      <th className="py-3 px-4 text-right">Actions</th>
                    </tr>
                  </thead>
                  <tbody className="divide-y divide-white/5 text-slate-300">
                    {sailorResults.map((r) => {
                      const dns = Boolean(r.isDns || r.isDNS);
                      const overseas = Boolean(r.isOverseasCommitment);
                      return (
                      <tr key={r.id || `${r.sailorId}-${r.regattaId}`} className="hover:bg-white/5">
                        <td className="py-3 px-4 font-bold text-white">
                          {r.regatta?.name || "Unknown regatta"}
                        </td>
                        <td className="py-3 px-4 text-center font-mono text-slate-400">
                          {r.regatta?.date
                            ? String(r.regatta.date).slice(0, 10)
                            : "—"}
                        </td>
                        <td className="py-3 px-4 text-center">
                          {r.regatta?.division || "—"}
                        </td>
                        <td className="py-3 px-4 text-center font-mono">
                          {r.rank}{overseas ? "†" : dns ? "*" : ""}
                        </td>
                        <td className="py-3 px-4 text-center font-mono">
                          {r.totalScore != null ? r.totalScore : "—"}
                        </td>
                        <td className="py-3 px-4 text-center font-mono">
                          {r.nettScore != null ? r.nettScore : "—"}
                        </td>
                        <td className="py-3 px-4 text-center">
                          <span className={`text-[10px] px-2 py-0.5 rounded ${
                            overseas
                              ? "bg-sky-500/10 text-sky-300 border border-sky-500/25"
                              : dns
                                ? "bg-rose-500/10 text-rose-400 border border-rose-500/20"
                                : "text-slate-500"
                          }`}>
                            {overseas ? "Overseas" : dns ? "DNS" : "Finished"}
                          </span>
                        </td>
                        <td className="py-3 px-4 text-right">
                          <div className="flex justify-end gap-2">
                            <button
                              type="button"
                              onClick={() => {
                                setEditingResultId(r.id);
                                setResultForm({
                                  id: r.id,
                                  regattaId: r.regattaId,
                                  sailorId: sid,
                                  nettScore:
                                    r.nettScore?.toString?.() ?? r.nettScore,
                                  totalScore:
                                    r.totalScore != null
                                      ? String(r.totalScore)
                                      : "",
                                  rank: r.rank?.toString?.() ?? r.rank,
                                  isDNS: dns && !overseas,
                                  isDns: dns && !overseas,
                                  isOverseasCommitment: overseas,
                                });
                              }}
                              className="text-slate-400 hover:text-white"
                            >
                              <Edit3 className="h-4 w-4" />
                            </button>
                            <button
                              type="button"
                              onClick={() => void handleDeleteResult(r.id)}
                              className="text-slate-500 hover:text-red-400"
                            >
                              <Trash2 className="h-4 w-4" />
                            </button>
                          </div>
                        </td>
                      </tr>
                      );
                    })}
                    {!competitionsLoading && sailorResults.length === 0 && (
                      <tr>
                        <td
                          colSpan={8}
                          className="py-10 text-center text-slate-500"
                        >
                          No competitions logged yet. Click Add result (use DNS for non-starts).
                        </td>
                      </tr>
                    )}
                  </tbody>
                </table>
              </div>
            </div>
          </div>
        
  );
}
