"use client";

import { Plus, Trash2, Edit3, Calendar } from "lucide-react";
import type { RegattaAdmin } from "@/types/regatta";
import { regattaDateLabel } from "@/types/regatta";

export type AdminRegattasPanelProps = {
  isSuperadmin: boolean;
  filteredRegattaList: RegattaAdmin[];
  regattaSearch: string;
  setRegattaSearch: (v: string) => void;
  regattaDivisionFilter: string;
  setRegattaDivisionFilter: (v: string) => void;
  regattaRankingFilter: string;
  setRegattaRankingFilter: (v: string) => void;
  editingRegattaId: string | null;
  setEditingRegattaId: (id: string | null) => void;
  regattaForm: any;
  setRegattaForm: React.Dispatch<React.SetStateAction<any>>;
  handleSaveRegatta: () => void | Promise<void>;
  handleDeleteRegatta: (id: string) => void | Promise<void>;
};

export function AdminRegattasPanel({
  isSuperadmin,
  filteredRegattaList,
  regattaSearch,
  setRegattaSearch,
  regattaDivisionFilter,
  setRegattaDivisionFilter,
  regattaRankingFilter,
  setRegattaRankingFilter,
  editingRegattaId,
  setEditingRegattaId,
  regattaForm,
  setRegattaForm,
  handleSaveRegatta,
  handleDeleteRegatta,
}: AdminRegattasPanelProps) {
  return (
              <div className="w-full min-w-0 space-y-4">
                <div className="glass-panel rounded-2xl border border-white/5 p-4 flex flex-col sm:flex-row sm:items-end gap-3 w-full">
                  <div className="flex-1 min-w-0">
                    <label className="text-[10px] font-bold text-slate-500 uppercase">
                      Search events
                    </label>
                    <input
                      type="search"
                      value={regattaSearch}
                      onChange={(e) => setRegattaSearch(e.target.value)}
                      placeholder="Name, date, division…"
                      className="mt-1 w-full rounded-xl border border-white/10 bg-slate-950 px-3 py-2 text-xs text-white"
                    />
                  </div>
                  <div>
                    <label className="text-[10px] font-bold text-slate-500 uppercase">
                      Division
                    </label>
                    <select
                      value={regattaDivisionFilter}
                      onChange={(e) => setRegattaDivisionFilter(e.target.value)}
                      className="mt-1 w-full sm:w-40 rounded-xl border border-white/10 bg-slate-950 px-3 py-2 text-xs text-white"
                    >
                      <option value="all">All</option>
                      <option value="Gold">Gold</option>
                      <option value="Silver">Silver</option>
                      <option value="Both">Both</option>
                      <option value="NonRanking">NonRanking</option>
                    </select>
                  </div>
                  <div>
                    <label className="text-[10px] font-bold text-slate-500 uppercase">
                      Ranking
                    </label>
                    <select
                      value={regattaRankingFilter}
                      onChange={(e) => setRegattaRankingFilter(e.target.value)}
                      className="mt-1 w-full sm:w-40 rounded-xl border border-white/10 bg-slate-950 px-3 py-2 text-xs text-white"
                    >
                      <option value="all">All events</option>
                      <option value="series">Series only</option>
                      <option value="nonranking">Non-ranking only</option>
                    </select>
                  </div>
                  <button
                    type="button"
                    onClick={() => {
                      setEditingRegattaId("new");
                      setRegattaForm({
                        id: "",
                        name: "",
                        date: new Date().toISOString().split("T")[0],
                        totalFleetSize: 50,
                        division: "Gold",
                        raceCount: "",
                        geography: "SG",
                        boatClass: "Optimist",
                        countsForRanking: true,
                      });
                    }}
                    className="rounded-full bg-orange-600 hover:bg-orange-500 px-4 py-2.5 text-xs font-bold text-white flex items-center justify-center gap-1 shrink-0"
                  >
                    <Plus className="h-4 w-4" />
                    Add regatta
                  </button>
                </div>

                <div className="grid grid-cols-1 lg:grid-cols-12 gap-4 w-full min-w-0 items-start">
                  {/* Compact event list */}
                  <div className="lg:col-span-5 glass-panel rounded-2xl border border-white/5 overflow-hidden flex flex-col max-h-[min(70vh,720px)]">
                    <div className="px-4 py-3 border-b border-white/5 flex items-center justify-between shrink-0">
                      <h3 className="text-sm font-bold text-white">
                        Events{" "}
                        <span className="text-slate-500 font-semibold">
                          ({filteredRegattaList.length})
                        </span>
                      </h3>
                    </div>
                    <div className="overflow-y-auto flex-1 divide-y divide-white/5">
                      {filteredRegattaList.length === 0 ? (
                        <p className="p-6 text-xs text-slate-500 text-center">
                          No regattas match filters.
                        </p>
                      ) : (
                        filteredRegattaList.map((r) => {
                          const active = editingRegattaId === r.id;
                          return (
                            <button
                              key={r.id}
                              type="button"
                              onClick={() => {
                                setEditingRegattaId(r.id);
                                setRegattaForm({
                                  ...r,
                                  raceCount:
                                    r.raceCount != null ? String(r.raceCount) : "",
                                  totalFleetSize:
                                    r.totalFleetSize != null
                                      ? String(r.totalFleetSize)
                                      : "",
                                  geography: r.geography || "SG",
                                  boatClass: r.boatClass || "Optimist",
                                  countsForRanking: r.countsForRanking !== false,
                                });
                              }}
                              className={`w-full text-left px-4 py-3 transition-colors hover:bg-white/[0.04] ${
                                active
                                  ? "bg-orange-500/10 border-l-2 border-orange-500"
                                  : "border-l-2 border-transparent"
                              }`}
                            >
                              <p className="text-xs font-bold text-white truncate">
                                {r.name}
                                {r.countsForRanking === false && (
                                  <span className="ml-1.5 rounded-full bg-sky-500/15 border border-sky-500/30 px-1.5 py-0.5 text-[9px] font-black text-sky-300">
                                    Non-ranking
                                  </span>
                                )}
                              </p>
                              <p className="text-[10px] text-slate-500 mt-0.5 font-mono">
                                {regattaDateLabel(r.date)} · {r.geography || "SG"} ·{" "}
                                {r.boatClass || "Optimist"} · {r.division || "Gold"}{" "}
                                · fleet {r.totalFleetSize}
                              </p>
                            </button>
                          );
                        })
                      )}
                    </div>
                  </div>

                  {/* Detail / edit pane */}
                  <div className="lg:col-span-7 glass-panel rounded-2xl border border-white/5 p-5 sm:p-6 min-h-[320px]">
                    {!editingRegattaId ? (
                      <div className="h-full flex flex-col items-center justify-center text-center py-16 px-4">
                        <Calendar className="h-10 w-10 text-slate-600 mb-3" />
                        <p className="text-sm font-bold text-slate-300">
                          Select an event to edit
                        </p>
                        <p className="text-xs text-slate-500 mt-1 max-w-sm">
                          Choose a regatta from the list, or add a new one. Details
                          open here so the list stays compact.
                        </p>
                      </div>
                    ) : (
                      <div className="space-y-4">
                        <div className="flex items-start justify-between gap-3">
                          <div>
                            <h3 className="text-sm font-black text-white uppercase tracking-wider">
                              {editingRegattaId === "new"
                                ? "New regatta"
                                : "Edit regatta"}
                            </h3>
                            <p className="text-[11px] text-slate-500 mt-0.5">
                              Meta only — results stay under Results tab.
                            </p>
                          </div>
                          {editingRegattaId !== "new" && (
                            <button
                              type="button"
                              onClick={() => handleDeleteRegatta(editingRegattaId)}
                              className="text-slate-500 hover:text-red-400 p-1"
                              title="Delete regatta"
                            >
                              <Trash2 className="h-4 w-4" />
                            </button>
                          )}
                        </div>
                        <div className="grid grid-cols-1 sm:grid-cols-2 gap-3">
                          <div className="sm:col-span-2">
                            <label className="text-[10px] font-bold text-slate-500 uppercase">
                              Event name
                            </label>
                            <input
                              type="text"
                              value={regattaForm.name}
                              onChange={(e) =>
                                setRegattaForm({
                                  ...regattaForm,
                                  name: e.target.value,
                                })
                              }
                              className="mt-1 w-full rounded-xl border border-white/5 bg-slate-950 px-3 py-2 text-white text-xs"
                              placeholder="e.g. NSC Cup Series 1"
                            />
                          </div>
                          <div>
                            <label className="text-[10px] font-bold text-slate-500 uppercase">
                              Date
                            </label>
                            <input
                              type="date"
                              value={regattaForm.date}
                              onChange={(e) =>
                                setRegattaForm({
                                  ...regattaForm,
                                  date: e.target.value,
                                })
                              }
                              className="mt-1 w-full rounded-xl border border-white/5 bg-slate-950 px-3 py-2 text-white text-xs font-mono"
                            />
                          </div>
                          <div>
                            <label className="text-[10px] font-bold text-slate-500 uppercase">
                              Total fleet size
                            </label>
                            <input
                              type="number"
                              value={regattaForm.totalFleetSize}
                              onChange={(e) =>
                                setRegattaForm({
                                  ...regattaForm,
                                  totalFleetSize: e.target.value,
                                })
                              }
                              className="mt-1 w-full rounded-xl border border-white/5 bg-slate-950 px-3 py-2 text-white text-xs font-mono"
                            />
                          </div>
                          <div>
                            <label className="text-[10px] font-bold text-slate-500 uppercase">
                              Division
                            </label>
                            <select
                              value={regattaForm.division || "Gold"}
                              onChange={(e) =>
                                setRegattaForm({
                                  ...regattaForm,
                                  division: e.target.value,
                                  countsForRanking:
                                    e.target.value === "NonRanking"
                                      ? false
                                      : regattaForm.countsForRanking !== false,
                                })
                              }
                              className="mt-1 w-full rounded-xl border border-white/5 bg-slate-950 px-3 py-2 text-white text-xs"
                            >
                              <option value="Gold">Gold only</option>
                              <option value="Silver">Silver only</option>
                              <option value="Both">Both</option>
                              <option value="NonRanking">Non-ranking</option>
                            </select>
                          </div>
                          <div className="sm:col-span-2">
                            <label className="flex items-center gap-2 text-xs text-slate-300 cursor-pointer">
                              <input
                                type="checkbox"
                                checked={regattaForm.countsForRanking !== false}
                                onChange={(e) =>
                                  setRegattaForm({
                                    ...regattaForm,
                                    countsForRanking: e.target.checked,
                                    division: e.target.checked
                                      ? regattaForm.division === "NonRanking"
                                        ? "Gold"
                                        : regattaForm.division
                                      : "NonRanking",
                                  })
                                }
                                className="rounded border-slate-600"
                              />
                              <span>
                                <strong className="text-white">Counts for ranking</strong>
                                <span className="block text-[10px] text-slate-500">
                                  Off = logbook / overseas only — not used in Best 3 of 5
                                </span>
                              </span>
                            </label>
                            {regattaForm.countsForRanking === false && (
                              <p className="mt-2 rounded-lg border border-sky-500/30 bg-sky-500/10 px-2 py-1.5 text-[10px] font-bold text-sky-200">
                                Non-ranking event — clearly excluded from series scoring
                              </p>
                            )}
                          </div>
                          <div>
                            <label className="text-[10px] font-bold text-slate-500 uppercase">
                              Geography / country
                            </label>
                            <input
                              type="text"
                              value={regattaForm.geography || "SG"}
                              onChange={(e) =>
                                setRegattaForm({
                                  ...regattaForm,
                                  geography: e.target.value.toUpperCase(),
                                })
                              }
                              className="mt-1 w-full rounded-xl border border-white/5 bg-slate-950 px-3 py-2 text-white text-xs font-mono"
                              placeholder="SG"
                            />
                          </div>
                          <div>
                            <label className="text-[10px] font-bold text-slate-500 uppercase">
                              Class
                            </label>
                            <input
                              type="text"
                              value={regattaForm.boatClass || "Optimist"}
                              onChange={(e) =>
                                setRegattaForm({
                                  ...regattaForm,
                                  boatClass: e.target.value,
                                })
                              }
                              className="mt-1 w-full rounded-xl border border-white/5 bg-slate-950 px-3 py-2 text-white text-xs"
                              placeholder="Optimist"
                            />
                          </div>
                        </div>
                        <div className="flex flex-wrap justify-end gap-2 border-t border-white/5 pt-4">
                          <button
                            type="button"
                            onClick={() => setEditingRegattaId(null)}
                            className="rounded-full bg-slate-800 px-4 py-2 text-xs font-bold text-slate-400 hover:text-white"
                          >
                            Close
                          </button>
                          <button
                            type="button"
                            onClick={handleSaveRegatta}
                            className="rounded-full bg-orange-600 px-5 py-2 text-xs font-bold text-white hover:bg-orange-500"
                          >
                            Save regatta
                          </button>
                        </div>
                      </div>
                    )}
                  </div>
                </div>
              </div>
  );
}
