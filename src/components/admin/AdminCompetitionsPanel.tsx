"use client";

import { useMemo, useState } from "react";
import { Medal, Plus, Edit3, Trash2 } from "lucide-react";
import type { SailorAdmin } from "@/types/sailor";
import type { RegattaAdmin } from "@/types/regatta";
import { regattaDateLabel } from "@/types/regatta";
import type { ResultAdmin } from "@/types/result";
import { isIlcaSeriesClass } from "@/lib/ilcaRanking";

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

type ClassFilter = "all" | "optimist" | "ilca4";

function boatClassOf(reg: RegattaAdmin | undefined): string {
  return String(reg?.boatClass || "Optimist").trim() || "Optimist";
}

function isIlcaRegatta(reg: RegattaAdmin | undefined): boolean {
  return isIlcaSeriesClass(reg?.boatClass, "ILCA 4");
}

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
  const [classFilter, setClassFilter] = useState<ClassFilter>("all");
  const sid = competitionsSailorId || "";

  const allSailorResults = useMemo(() => {
    if (!sid) return [];
    return resultsList
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
  }, [resultsList, regattaList, sid]);

  const optimistCount = allSailorResults.filter(
    (r) => !isIlcaRegatta(r.regatta)
  ).length;
  const ilcaCount = allSailorResults.filter((r) =>
    isIlcaRegatta(r.regatta)
  ).length;

  const sailorResults = allSailorResults.filter((r) => {
    if (classFilter === "all") return true;
    if (classFilter === "ilca4") return isIlcaRegatta(r.regatta);
    return !isIlcaRegatta(r.regatta);
  });

  const regattaOptions = useMemo(() => {
    const list = [...regattaList].sort((a, b) =>
      String(b.date || "").localeCompare(String(a.date || ""))
    );
    if (classFilter === "ilca4") {
      return list.filter((r) => isIlcaRegatta(r));
    }
    if (classFilter === "optimist") {
      return list.filter((r) => !isIlcaRegatta(r));
    }
    return list;
  }, [regattaList, classFilter]);

  if (!competitionsSailorId) return null;

  const sailor = sailorList.find((x) => x.id === competitionsSailorId);

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
              Optimist and ILCA 4 events for this sailor. Edit rank / scores, or
              add a missing result.
              {competitionsLoading ? " Refreshing…" : ""}
            </p>
            <p className="text-[11px] text-slate-600 mt-1">
              {allSailorResults.length} total
              {optimistCount > 0 ? ` · ${optimistCount} Optimist` : ""}
              {ilcaCount > 0 ? ` · ${ilcaCount} ILCA 4` : ""}
              {sailor?.sailNumber ? ` · Opti ${sailor.sailNumber}` : ""}
              {sailor?.sailNumberIlca4
                ? ` · ILCA ${sailor.sailNumberIlca4}`
                : ""}
            </p>
          </div>
          <div className="flex flex-wrap gap-2">
            <button
              type="button"
              onClick={() => {
                const preferred =
                  classFilter === "ilca4"
                    ? regattaList.find((r) => isIlcaRegatta(r))
                    : classFilter === "optimist"
                      ? regattaList.find((r) => !isIlcaRegatta(r))
                      : regattaList[0];
                setEditingResultId("new");
                setResultForm({
                  id: "",
                  regattaId: preferred?.id || regattaList[0]?.id || "",
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

        {/* Class filter — Optimist + ILCA 4 */}
        <div
          className="flex gap-1 p-1 rounded-xl bg-black/40 border border-white/10 max-w-md"
          role="tablist"
          aria-label="Boat class"
        >
          {(
            [
              ["all", "All", allSailorResults.length],
              ["optimist", "Optimist", optimistCount],
              ["ilca4", "ILCA 4", ilcaCount],
            ] as const
          ).map(([key, label, count]) => {
            const active = classFilter === key;
            return (
              <button
                key={key}
                type="button"
                role="tab"
                aria-selected={active}
                onClick={() => setClassFilter(key)}
                className={`flex-1 rounded-lg px-2 py-2 text-[11px] font-bold transition-colors ${
                  active
                    ? key === "ilca4"
                      ? "bg-sky-600 text-white"
                      : key === "optimist"
                        ? "bg-orange-500 text-white"
                        : "bg-white/15 text-white"
                    : "text-slate-400 hover:text-white"
                }`}
              >
                {label}
                <span className="ml-1 tabular-nums opacity-80">({count})</span>
              </button>
            );
          })}
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
                  {regattaOptions.map((r) => (
                    <option key={r.id} value={r.id}>
                      {boatClassOf(r)} · {r.name} ({regattaDateLabel(r.date)}) ·{" "}
                      {r.division || "—"}
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
                <label
                  htmlFor="modalDns"
                  className="text-xs text-slate-400 font-bold cursor-pointer"
                >
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
                <label
                  htmlFor="modalOverseas"
                  className="text-xs text-sky-300/90 font-bold cursor-pointer leading-snug"
                >
                  Overseas commitment (SSF) — set rank/pts to standing (e.g. 2nd
                  → 2 pts)
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
                <th className="py-3 px-4">Class</th>
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
                const ilca = isIlcaRegatta(r.regatta);
                const cls = boatClassOf(r.regatta);
                return (
                  <tr
                    key={r.id || `${r.sailorId}-${r.regattaId}`}
                    className="hover:bg-white/5"
                  >
                    <td className="py-3 px-4">
                      <span
                        className={`text-[10px] font-bold px-2 py-0.5 rounded border ${
                          ilca
                            ? "bg-sky-500/15 text-sky-300 border-sky-500/30"
                            : "bg-orange-500/10 text-orange-300 border-orange-500/25"
                        }`}
                      >
                        {ilca ? "ILCA 4" : cls || "Optimist"}
                      </span>
                    </td>
                    <td className="py-3 px-4 font-bold text-white">
                      {r.regatta?.name || "Unknown regatta"}
                    </td>
                    <td className="py-3 px-4 text-center font-mono text-slate-400">
                      {r.regatta?.date
                        ? String(r.regatta.date).slice(0, 10)
                        : "—"}
                    </td>
                    <td className="py-3 px-4 text-center">
                      {r.regatta?.division || (ilca ? "Open" : "—")}
                    </td>
                    <td className="py-3 px-4 text-center font-mono">
                      {r.rank}
                      {overseas ? "†" : dns ? "*" : ""}
                    </td>
                    <td className="py-3 px-4 text-center font-mono">
                      {r.totalScore != null ? r.totalScore : "—"}
                    </td>
                    <td className="py-3 px-4 text-center font-mono">
                      {r.nettScore != null ? r.nettScore : "—"}
                    </td>
                    <td className="py-3 px-4 text-center">
                      <span
                        className={`text-[10px] px-2 py-0.5 rounded ${
                          overseas
                            ? "bg-sky-500/10 text-sky-300 border border-sky-500/25"
                            : dns
                              ? "bg-rose-500/10 text-rose-400 border border-rose-500/20"
                              : "text-slate-500"
                        }`}
                      >
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
                    colSpan={9}
                    className="py-10 text-center text-slate-500"
                  >
                    {allSailorResults.length === 0
                      ? "No competitions logged yet. Click Add result (use DNS for non-starts)."
                      : `No ${classFilter === "ilca4" ? "ILCA 4" : "Optimist"} results in this filter.`}
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
