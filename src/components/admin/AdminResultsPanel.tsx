"use client";

import { Plus, Trash2, Edit3 } from "lucide-react";
import { rankingPeriodOptions } from "@/lib/datesSg";
import type { SailorAdmin } from "@/types/sailor";
import type { RegattaAdmin } from "@/types/regatta";
import { regattaDateLabel } from "@/types/regatta";
import type { ResultAdmin } from "@/types/result";

const DNS_PERIODS = rankingPeriodOptions(4);

export type AdminResultsPanelProps = {
  isSuperadmin: boolean;
  sailorList: SailorAdmin[];
  regattaList: RegattaAdmin[];
  resultsList: ResultAdmin[];
  selectedRegattaIdForResultEdit: string;
  setSelectedRegattaIdForResultEdit: (id: string) => void;
  editingResultId: string | null;
  setEditingResultId: (id: string | null) => void;
  resultForm: any;
  setResultForm: (v: any) => void;
  handleSaveResult: () => void | Promise<void>;
  handleDeleteResult: (id: string) => void | Promise<void>;
  handleFillDnsForRegatta: (regattaId: string) => void | Promise<void>;
  handleFillDnsForPeriod: (
    fleet: "Gold" | "Silver",
    year: number,
    half: "Jan-Jun" | "Jul-Dec"
  ) => void | Promise<void>;
};

export function AdminResultsPanel({
  isSuperadmin,
  sailorList,
  regattaList,
  resultsList,
  selectedRegattaIdForResultEdit,
  setSelectedRegattaIdForResultEdit,
  editingResultId,
  setEditingResultId,
  resultForm,
  setResultForm,
  handleSaveResult,
  handleDeleteResult,
  handleFillDnsForRegatta,
  handleFillDnsForPeriod,
}: AdminResultsPanelProps) {
  return (
              <div className="w-full min-w-0 space-y-6">
                {/* Period-wide DNS: every fleet sailor gets a result for each ranking regatta */}
                <div className="glass-panel rounded-3xl p-6 border border-rose-500/20 bg-rose-500/[0.03] space-y-3">
                  <h3 className="text-sm font-bold text-white uppercase tracking-wider">
                    Ensure DNS for fleet period
                  </h3>
                  <p className="text-xs text-slate-500 leading-relaxed">
                    Gold (or Silver) fleet sailors must have a result for{" "}
                    <strong className="text-slate-400">every ranking regatta</strong> in the
                    half-year they are in that fleet. Missing events get DNS = fleet size + 1.
                    Run this after importing period regattas. Edit overseas commitment scores
                    afterwards.
                  </p>
                  <div className="flex flex-wrap gap-2">
                    {DNS_PERIODS.flatMap(({ period, label }) =>
                      (["Gold", "Silver"] as const).map((fleet) => (
                        <button
                          key={`${fleet}-${period.year}-${period.half}`}
                          type="button"
                          disabled={!isSuperadmin}
                          onClick={() =>
                            void handleFillDnsForPeriod(
                              fleet,
                              period.year,
                              period.half
                            )
                          }
                          className={
                            fleet === "Gold"
                              ? "rounded-full bg-rose-600/90 hover:bg-rose-500 disabled:opacity-40 px-4 py-2 text-xs font-bold text-white"
                              : "rounded-full bg-slate-700 hover:bg-slate-600 disabled:opacity-40 px-4 py-2 text-xs font-bold text-white"
                          }
                        >
                          {fleet} · {label.replace(" (Current)", "")}
                        </button>
                      ))
                    )}
                  </div>
                </div>

                {/* Select Regatta Dropdown */}
                <div className="glass-panel rounded-3xl p-6 border border-white/5 flex flex-col md:flex-row md:items-center justify-between gap-4">
                  <div className="space-y-1">
                    <h3 className="text-sm font-bold text-white uppercase tracking-wider">Select Regatta Event</h3>
                    <p className="text-xs text-slate-500">Choose a regatta to view and edit individual results.</p>
                  </div>
                  <select
                    value={selectedRegattaIdForResultEdit}
                    onChange={(e) => {
                      setSelectedRegattaIdForResultEdit(e.target.value);
                      setEditingResultId(null);
                    }}
                    className="rounded-xl border border-white/5 bg-slate-950 px-4 py-2.5 text-white text-xs font-semibold focus:outline-none w-full md:w-72"
                  >
                    <option value="" disabled>-- Choose Regatta --</option>
                    {regattaList.map((r) => (
                      <option key={r.id} value={r.id}>
                        {r.name} ({regattaDateLabel(r.date)})
                        {r.countsForRanking === false ? " · non-ranking" : ""}
                      </option>
                    ))}
                  </select>
                </div>

                {selectedRegattaIdForResultEdit &&
                  regattaList.find((r) => r.id === selectedRegattaIdForResultEdit)
                    ?.countsForRanking === false && (
                    <div className="rounded-xl border border-sky-500/30 bg-sky-500/10 px-4 py-3 text-xs font-bold text-sky-200">
                      This regatta is <strong>non-ranking</strong> — results here are
                      for logbook only and are not used in Best 3 of 5 series scoring.
                    </div>
                  )}

                {/* Result Form Card */}
                {editingResultId && (
                  <div className="glass-panel rounded-3xl p-6 border border-white/5 space-y-4">
                    <h3 className="text-sm font-bold text-white uppercase tracking-wider">
                      {editingResultId === "new" ? "Add Sailor Regatta Result" : "Edit Sailor Regatta Result"}
                    </h3>
                    {regattaList.find((r) => r.id === resultForm.regattaId)
                      ?.countsForRanking === false && (
                      <p className="text-[11px] text-sky-300 font-semibold">
                        Non-ranking event — not used in series rankings.
                      </p>
                    )}
                    <div className="grid grid-cols-1 md:grid-cols-5 gap-4">
                      <div>
                        <label className="text-[10px] font-bold text-slate-500 uppercase">Sailor Name</label>
                        <select
                          value={resultForm.sailorId}
                          onChange={(e) => setResultForm({ ...resultForm, sailorId: e.target.value })}
                          className="mt-1 w-full rounded-xl border border-white/5 bg-slate-950 px-3 py-2 text-white text-xs focus:outline-none"
                        >
                          <option value="" disabled>-- Select Sailor --</option>
                          {sailorList.map((s) => (
                            <option key={s.id} value={s.id}>
                              {s.name} ({s.sailNumber})
                            </option>
                          ))}
                        </select>
                      </div>
                      <div>
                        <label className="text-[10px] font-bold text-slate-500 uppercase">Total Score</label>
                        <input
                          type="number"
                          step="any"
                          value={resultForm.totalScore}
                          onChange={(e) => setResultForm({ ...resultForm, totalScore: e.target.value })}
                          className="mt-1 w-full rounded-xl border border-white/5 bg-slate-950 px-3 py-2 text-white text-xs font-mono"
                          placeholder="Optional"
                        />
                      </div>
                      <div>
                        <label className="text-[10px] font-bold text-slate-500 uppercase">Nett Score (optional)</label>
                        <input
                          type="number"
                          step="any"
                          value={resultForm.nettScore}
                          onChange={(e) => setResultForm({ ...resultForm, nettScore: e.target.value })}
                          className="mt-1 w-full rounded-xl border border-white/5 bg-slate-950 px-3 py-2 text-white text-xs font-mono"
                        />
                      </div>
                      <div>
                        <label className="text-[10px] font-bold text-slate-500 uppercase">Rank (Finishing Pos)</label>
                        <input
                          type="number"
                          value={resultForm.rank}
                          onChange={(e) => {
                            const val = e.target.value;
                            const reg = regattaList.find(
                              (r) => r.id === resultForm.regattaId
                            );
                            const dnsPts =
                              (reg?.totalFleetSize || 50) + 1;
                            const n = Number(val);
                            // Better than DNS score (fleet+1) → uncheck DNS
                            const clearDns =
                              Number.isFinite(n) && n > 0 && n < dnsPts;
                            setResultForm({
                              ...resultForm,
                              rank: val,
                              ...(clearDns
                                ? { isDNS: false, isDns: false }
                                : {}),
                            });
                          }}
                          className="mt-1 w-full rounded-xl border border-white/5 bg-slate-950 px-3 py-2 text-white text-xs font-mono"
                        />
                        <p className="mt-1 text-[10px] text-slate-600">
                          DNS points = fleet+1. Enter a better rank to clear DNS.
                        </p>
                      </div>
                      <div className="flex items-center gap-2 h-full pt-5 md:pl-4">
                        <input
                          type="checkbox"
                          id="dnsCheckbox"
                          checked={Boolean(resultForm.isDNS || resultForm.isDns)}
                          onChange={(e) => {
                            const on = e.target.checked;
                            const reg = regattaList.find(
                              (r) => r.id === resultForm.regattaId
                            );
                            const dnsPts =
                              (reg?.totalFleetSize || 50) + 1;
                            setResultForm({
                              ...resultForm,
                              isDNS: on,
                              isDns: on,
                              // When marking DNS, default points to fleet+1 (editable)
                              ...(on
                                ? {
                                    rank: dnsPts,
                                  }
                                : {}),
                            });
                          }}
                          className="rounded border-slate-700 bg-slate-900 text-orange-600 focus:ring-orange-500 h-4 w-4"
                        />
                        <label htmlFor="dnsCheckbox" className="text-xs font-bold text-slate-400 cursor-pointer">
                          Did Not Start (DNS) — sets rank to fleet+1; better rank auto-clears this
                        </label>
                      </div>
                      <div className="flex items-center gap-2 h-full pt-2 md:pl-4 md:col-span-2">
                        <input
                          type="checkbox"
                          id="overseasCheckbox"
                          checked={Boolean(resultForm.isOverseasCommitment)}
                          onChange={(e) => {
                            const on = e.target.checked;
                            setResultForm({
                              ...resultForm,
                              isOverseasCommitment: on,
                              // Overseas is not generic DNS
                              isDNS: on ? false : resultForm.isDNS,
                              isDns: on ? false : resultForm.isDns,
                            });
                          }}
                          className="rounded border-slate-700 bg-slate-900 text-sky-500 focus:ring-sky-500 h-4 w-4"
                        />
                        <label htmlFor="overseasCheckbox" className="text-xs font-bold text-sky-300/90 cursor-pointer leading-snug">
                          Overseas commitment (SSF) — set points to standing before trip (e.g. rank 2 → 2 pts); tag only, does not auto-calc
                        </label>
                      </div>
                    </div>

                    <div className="flex justify-end gap-2 border-t border-white/5 pt-4">
                      <button
                        onClick={() => setEditingResultId(null)}
                        className="rounded-full bg-slate-800 px-4 py-2 text-xs font-bold text-slate-400 hover:text-white"
                      >
                        Cancel
                      </button>
                      <button
                        onClick={handleSaveResult}
                        className="rounded-full bg-orange-600 px-5 py-2 text-xs font-bold text-white hover:bg-orange-500"
                      >
                        Save Result
                      </button>
                    </div>
                  </div>
                )}

                {/* Results List */}
                {selectedRegattaIdForResultEdit && (
                  <div className="glass-panel rounded-3xl border border-white/5 overflow-hidden">
                    <div className="p-6 border-b border-white/5 flex flex-col lg:flex-row lg:items-center justify-between gap-4">
                      <div>
                        <h3 className="text-base font-bold text-white">Regatta Results Table</h3>
                        <p className="text-xs text-slate-500">Edit or delete scores for this event.</p>
                      </div>
                      <div className="flex flex-wrap items-end gap-3">
                        <button
                          type="button"
                          onClick={() =>
                            void handleFillDnsForRegatta(
                              selectedRegattaIdForResultEdit
                            )
                          }
                          className="rounded-full bg-slate-800 border border-rose-500/30 hover:bg-rose-500/10 px-4 py-2 text-xs font-bold text-rose-300 flex items-center gap-1"
                          title="Create DNS (fleet size + 1) for series members with no result"
                        >
                          Fill DNS for non-starters
                        </button>
                        <button
                          onClick={() => {
                            const reg = regattaList.find(
                              (r) => r.id === selectedRegattaIdForResultEdit
                            );
                            const dnsPts = (reg?.totalFleetSize || 50) + 1;
                            setEditingResultId("new");
                            setResultForm({
                              id: "",
                              regattaId: selectedRegattaIdForResultEdit,
                              sailorId: "",
                              rank: 1,
                              nettScore: "",
                              totalScore: "",
                              isDNS: false,
                              _dnsDefault: dnsPts,
                            });
                          }}
                          className="rounded-full bg-orange-600 hover:bg-orange-500 px-4 py-2 text-xs font-bold text-white flex items-center gap-1"
                        >
                          <Plus className="h-4 w-4" />
                          Add Score
                        </button>
                      </div>
                    </div>

                    <p className="px-6 pb-2 text-[11px] text-slate-500">
                      Non-starters: <strong className="text-slate-400">Fill DNS</strong> (fleet size + 1)
                      or mark <strong className="text-sky-300">Overseas commitment</strong> and set
                      points to their standing before the trip (e.g. 2nd → 2 pts). Both are editable.
                    </p>

                    <table className="w-full text-left border-collapse text-xs">
                      <thead>
                        <tr className="border-b border-white/5 bg-white/5 text-[10px] font-bold text-slate-400 uppercase tracking-wider">
                          <th className="py-4 px-4 text-center">Rank</th>
                          <th className="py-4 px-6">Name</th>
                          <th className="py-4 px-4 text-center">Gender</th>
                          <th className="py-4 px-4 text-center">Age</th>
                          <th className="py-4 px-4 text-center">Total Score</th>
                          <th className="py-4 px-4 text-center">Nett Score</th>
                          <th className="py-4 px-4 text-center">Status</th>
                          <th className="py-4 px-6 text-right">Actions</th>
                        </tr>
                      </thead>
                      <tbody className="divide-y divide-white/5 font-semibold text-slate-300">
                        {resultsList
                          .filter((res) => res.regattaId === selectedRegattaIdForResultEdit)
                          .slice()
                          .sort((a, b) => (a.rank || 999) - (b.rank || 999))
                          .map((res) => {
                            const sailor = sailorList.find((s) => s.id === res.sailorId);
                            const dns = Boolean(res.isDns || res.isDNS);
                            const overseas = Boolean(res.isOverseasCommitment);
                            const age = (() => {
                              if (!sailor?.dob) return "—";
                              const y = new Date(sailor.dob).getFullYear();
                              if (!Number.isFinite(y)) return "—";
                              return String(new Date().getFullYear() - y);
                            })();
                            return (
                              <tr
                                key={res.id}
                                className={`hover:bg-white/5 transition-colors ${
                                  overseas
                                    ? "bg-sky-500/[0.04]"
                                    : dns
                                      ? "bg-rose-500/[0.03]"
                                      : ""
                                }`}
                              >
                                <td className="py-4 px-4 text-center font-mono font-bold text-orange-400">
                                  {res.rank}
                                  {overseas ? "†" : dns ? "*" : ""}
                                </td>
                                <td className="py-4 px-6 font-bold text-white">
                                  {sailor ? sailor.name : "Deleted / Unmapped Sailor"}
                                </td>
                                <td className="py-4 px-4 text-center text-slate-300">
                                  {sailor?.gender || "—"}
                                </td>
                                <td className="py-4 px-4 text-center font-mono text-slate-300">
                                  {age}
                                </td>
                                <td className="py-4 px-4 text-center font-mono">
                                  {res.totalScore != null ? res.totalScore : "—"}
                                </td>
                                <td className="py-4 px-4 text-center font-mono">
                                  {res.nettScore != null ? res.nettScore : "—"}
                                </td>
                                <td className="py-4 px-4 text-center">
                                  <span className={`inline-block px-2 py-0.5 rounded text-[10px] ${
                                    overseas
                                      ? "bg-sky-500/10 text-sky-300 border border-sky-500/25"
                                      : dns
                                        ? "bg-rose-500/10 text-rose-500 border border-rose-500/20"
                                        : "bg-slate-800 text-slate-400"
                                  }`}>
                                    {overseas ? "Overseas" : dns ? "DNS" : "Finished"}
                                  </span>
                                </td>
                                <td className="py-4 px-6 text-right">
                                  <div className="flex justify-end items-center gap-2">
                                    <button
                                      onClick={() => {
                                        setEditingResultId(res.id);
                                        setResultForm({
                                          ...res,
                                          nettScore: res.nettScore?.toString?.() ?? res.nettScore,
                                          totalScore:
                                            res.totalScore != null
                                              ? String(res.totalScore)
                                              : "",
                                          rank: res.rank?.toString?.() ?? res.rank,
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
                                      onClick={() => handleDeleteResult(res.id)}
                                      className="text-slate-500 hover:text-red-400"
                                    >
                                      <Trash2 className="h-4 w-4" />
                                    </button>
                                  </div>
                                </td>
                              </tr>
                            );
                          })}
                        {resultsList.filter((res) => res.regattaId === selectedRegattaIdForResultEdit).length === 0 && (
                          <tr>
                            <td colSpan={8} className="text-center py-12 text-slate-500">
                              No sailor results logged. Click Add Score or Fill DNS for non-starters.
                            </td>
                          </tr>
                        )}
                      </tbody>
                    </table>
                  </div>
                )}
              </div>
  );
}
