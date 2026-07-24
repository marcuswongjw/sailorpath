"use client";

import type { Dispatch, SetStateAction } from "react";
import {
  Columns3,
  ArrowUpDown,
  ArrowUp,
  ArrowDown,
  Plus,
  Trash2,
  Edit3,
  User,
  Medal,
  Copy,
  AlertTriangle,
  CheckCircle,
  RefreshCw,
  Save,
  Grid,
  UserCheck,
} from "lucide-react";
import { ageYears } from "@/lib/age";
import {
  halfBoundaryOptions,
  isHalfBoundaryYmd,
  todayYmdSg,
} from "@/lib/datesSg";
import {
  DB_SAILOR_COLUMNS,
  defaultDbColVisible,
} from "@/components/admin/adminConstants";
import type { SailorAdmin } from "@/types/sailor";

const HALF_BOUNDARY_OPTS = halfBoundaryOptions();

export type DuplicatePair = {
  a: { id: string; name: string; sailNumber?: string | null };
  b: { id: string; name: string; sailNumber?: string | null };
  similarity: number;
  band?: string;
  how?: string;
};

export type AdminSailorsPanelProps = {
  isSuperadmin: boolean;
  sailorList: SailorAdmin[];
  filteredDbSailors: SailorAdmin[];
  sortedDbSailors: SailorAdmin[];
  selectedSailors: string[];
  setSelectedSailors: Dispatch<SetStateAction<string[]>>;
  dbSearch: string;
  setDbSearch: (v: string) => void;
  dbFleetFilter: string;
  setDbFleetFilter: (v: string) => void;
  dbSquadFilter: string;
  setDbSquadFilter: (v: string) => void;
  setDbColVisible: Dispatch<SetStateAction<Record<string, boolean>>>;
  dbColPickerOpen: boolean;
  setDbColPickerOpen: Dispatch<SetStateAction<boolean>>;
  dbSortKey: string;
  dbSortDir: "asc" | "desc";
  toggleDbSort: (key: string) => void;
  colOn: (key: string) => boolean;
  seriesLabelOf: (s: SailorAdmin) => string;
  best3BySailor: Record<string, number>;
  duplicatePairs: DuplicatePair[];
  bulkField: string;
  setBulkField: (v: string) => void;
  bulkValue: string;
  setBulkValue: (v: string) => void;
  handleApplyBulk: () => void | Promise<void>;
  handleBulkDelete: () => void | Promise<void>;
  handleMergeSailors: () => void | Promise<void>;
  toggleSelectSailor: (id: string) => void;
  toggleSelectAllVisible: () => void;
  editingSailorId: string | null;
  setEditingSailorId: (id: string | null) => void;
  sailorForm: any;
  setSailorForm: Dispatch<SetStateAction<any>>;
  handleSaveSailor: () => void | Promise<void>;
  handleDeleteSailor: (id: string) => void | Promise<void>;
  showDuplicateFinder: boolean;
  setShowDuplicateFinder: Dispatch<SetStateAction<boolean>>;
  ignoreDuplicatePair: (aId: string, bId: string) => void;
  bulkStatus: string | null;
  openSailorResults: (id: string) => void | Promise<void>;
  competitionsSailorId: string | null;
  setCompetitionsSailorId: (id: string | null) => void;
  /** Fix Series members with no gold/silver entry */
  onCleanupEmptySeries?: () => void | Promise<void>;
  emptySeriesCount?: number;
};

export function AdminSailorsPanel(p: AdminSailorsPanelProps) {
  const {
    isSuperadmin,
    sailorList,
    filteredDbSailors,
    sortedDbSailors,
    selectedSailors,
    setSelectedSailors,
    dbSearch,
    setDbSearch,
    dbFleetFilter,
    setDbFleetFilter,
    dbSquadFilter,
    setDbSquadFilter,
    setDbColVisible,
    dbColPickerOpen,
    setDbColPickerOpen,
    dbSortKey,
    dbSortDir,
    toggleDbSort,
    colOn,
    seriesLabelOf,
    best3BySailor,
    duplicatePairs,
    bulkField,
    setBulkField,
    bulkValue,
    setBulkValue,
    handleApplyBulk,
    handleBulkDelete,
    handleMergeSailors,
    toggleSelectSailor,
    toggleSelectAllVisible,
    editingSailorId,
    setEditingSailorId,
    sailorForm,
    setSailorForm,
    handleSaveSailor,
    handleDeleteSailor,
    showDuplicateFinder,
    setShowDuplicateFinder,
    ignoreDuplicatePair,
    bulkStatus,
    openSailorResults,
    competitionsSailorId,
    setCompetitionsSailorId,
    onCleanupEmptySeries,
    emptySeriesCount = 0,
  } = p;

  return (
              <div className="w-full min-w-0 space-y-6">

                {emptySeriesCount > 0 && onCleanupEmptySeries && (
                  <div className="rounded-2xl border border-amber-500/30 bg-amber-500/5 px-4 py-3 flex flex-col sm:flex-row sm:items-center justify-between gap-3">
                    <div className="flex items-start gap-2">
                      <AlertTriangle className="h-4 w-4 text-amber-400 shrink-0 mt-0.5" />
                      <p className="text-xs text-amber-100/90">
                        <strong className="text-amber-200">{emptySeriesCount}</strong> In SG Fleet
                        sailor(s) have no silver/gold entry date — they are not ranked.
                        Stamp today&apos;s date as Silver entry (SG) to include them.
                      </p>
                    </div>
                    <button
                      type="button"
                      disabled={!isSuperadmin}
                      onClick={() => void onCleanupEmptySeries()}
                      className="shrink-0 rounded-full bg-amber-600/90 hover:bg-amber-500 disabled:opacity-40 px-4 py-2 text-xs font-bold text-white"
                    >
                      Stamp silver entry for empty Series
                    </button>
                  </div>
                )}
                {/* Filters */}
                <div className="glass-panel rounded-2xl border border-white/5 p-4 grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-3">
                  <div>
                    <label className="text-[10px] font-bold text-slate-500 uppercase">Search</label>
                    <input
                      type="search"
                      placeholder="Name, sail #, club, school…"
                      value={dbSearch}
                      onChange={(e) => setDbSearch(e.target.value)}
                      className="mt-1 w-full rounded-xl border border-white/10 bg-slate-950 px-3 py-2 text-xs text-white"
                    />
                  </div>
                  <div>
                    <label className="text-[10px] font-bold text-slate-500 uppercase">SG Series</label>
                    <select
                      value={dbFleetFilter}
                      onChange={(e) => setDbFleetFilter(e.target.value)}
                      className="mt-1 w-full rounded-xl border border-white/10 bg-slate-950 px-3 py-2 text-xs text-white"
                    >
                      <option value="all">All</option>
                      <option value="series">In SG Fleet</option>
                      <option value="guest">Guest</option>
                      <option value="gold">Has Gold entry</option>
                      <option value="silver">Series · no Gold entry</option>
                    </select>
                  </div>
                  <div>
                    <label className="text-[10px] font-bold text-slate-500 uppercase">Squad Jul 26</label>
                    <select
                      value={dbSquadFilter}
                      onChange={(e) => setDbSquadFilter(e.target.value)}
                      className="mt-1 w-full rounded-xl border border-white/10 bg-slate-950 px-3 py-2 text-xs text-white"
                    >
                      <option value="all">All squads</option>
                      <option value="Nat A">Nat A</option>
                      <option value="Nat B">Nat B</option>
                      <option value="DS">DS</option>
                    </select>
                  </div>
                  <p className="sm:col-span-2 lg:col-span-4 text-[11px] text-slate-500">
                    Showing <strong className="text-white">{filteredDbSailors.length}</strong> of{" "}
                    {sailorList.length} sailors
                    {selectedSailors.length > 0 && (
                      <>
                        {" "}
                        · <strong className="text-orange-400">{selectedSailors.length}</strong> selected
                        for bulk edit
                      </>
                    )}
                  </p>
                </div>

                {/* Bulk edit toolbar (merged from former Bulk Date Editor) */}
                <div className="glass-panel rounded-2xl border border-orange-500/20 bg-orange-500/[0.03] p-4 space-y-3">
                  <div className="flex items-center gap-2">
                    <Grid className="h-4 w-4 text-orange-500" />
                    <h3 className="text-sm font-bold text-white">Bulk edit selected sailors</h3>
                  </div>
                  <p className="text-[11px] text-slate-500">
                    Tick sailors in the table below, choose a property and value, then apply. Use
                    Columns to show historical / overseas fields in the same overview.
                  </p>
                  <div className="flex flex-wrap items-end gap-4">
                    <div className="flex flex-col gap-1 min-w-[180px]">
                      <label className="text-[10px] font-bold text-slate-400 uppercase">Property</label>
                      <select
                        value={bulkField}
                        onChange={(e) => {
                          setBulkField(e.target.value);
                          setBulkValue("");
                        }}
                        className="rounded-lg bg-slate-900 border border-white/10 text-white px-3 py-2 text-xs"
                      >
                        <option value="">-- Select property --</option>
                        <optgroup label="SG Series & Dates">
                          <option value="currentFleet">SG Series (Guest / In SG Fleet)</option>
                          <option value="goldEntryDate">Gold Fleet Entry Date</option>
                          <option value="silverEntryDate">Silver Fleet Entry Date</option>
                          <option value="dropDate">Optimist Drop Date</option>
                        </optgroup>
                        <optgroup label="Profile">
                          <option value="club">Club</option>
                          <option value="school">School</option>
                          <option value="nationality">Nationality</option>
                          <option value="sailNumber">Sail Number</option>
                          <option value="gender">Gender (M/F)</option>
                          <option value="dob">Date of Birth</option>
                          <option value="weight">Weight (kg)</option>
                        </optgroup>
                        <optgroup label="Squad history">
                          <option value="natSquadStatusJan25">Squad Jan 25</option>
                          <option value="natSquadStatusJul25">Squad Jul 25</option>
                          <option value="natSquadStatusJan26">Squad Jan 26</option>
                          <option value="natSquadStatusJul26">Squad Jul 26</option>
                        </optgroup>
                        <optgroup label="Historical rankings">
                          <option value="histRankingJun24">Hist Jun 24</option>
                          <option value="histRankingDec24">Hist Dec 24</option>
                          <option value="histRankingJun25">Hist Jun 25</option>
                          <option value="histRankingDec25">Hist Dec 25</option>
                          <option value="histRankingJun26">Hist Jun 26</option>
                        </optgroup>
                        <optgroup label="Overseas Representation">
                          <option value="worlds">Worlds years (e.g. 2023, 2025)</option>
                          <option value="european">European years</option>
                          <option value="asian">Asian years</option>
                          <option value="seaGames">SEA Games years</option>
                        </optgroup>
                      </select>
                    </div>
                    <div className="flex flex-col gap-1 min-w-[140px]">
                      <label className="text-[10px] font-bold text-slate-400 uppercase">Value</label>
                      {bulkField === "goldEntryDate" || bulkField === "dropDate" ? (
                        <select
                          value={bulkValue}
                          onChange={(e) => setBulkValue(e.target.value)}
                          className="rounded-lg bg-slate-900 border border-white/10 text-white px-3 py-2 text-xs"
                        >
                          <option value="">— clear / none —</option>
                          {HALF_BOUNDARY_OPTS.map((o) => (
                            <option key={o.value} value={o.value}>
                              {o.label}
                            </option>
                          ))}
                        </select>
                      ) : ["silverEntryDate", "dob"].includes(bulkField) ? (
                        <input
                          type="date"
                          value={bulkValue}
                          onChange={(e) => setBulkValue(e.target.value)}
                          className="rounded-lg bg-slate-900 border border-white/10 text-white px-3 py-2 text-xs"
                        />
                      ) : bulkField === "gender" ? (
                        <select
                          value={bulkValue}
                          onChange={(e) => setBulkValue(e.target.value)}
                          className="rounded-lg bg-slate-900 border border-white/10 text-white px-3 py-2 text-xs"
                        >
                          <option value="">—</option>
                          <option value="M">M</option>
                          <option value="F">F</option>
                        </select>
                      ) : bulkField === "currentFleet" ? (
                        <select
                          value={bulkValue}
                          onChange={(e) => setBulkValue(e.target.value)}
                          className="rounded-lg bg-slate-900 border border-white/10 text-white px-3 py-2 text-xs"
                        >
                          <option value="Guest">Guest</option>
                          <option value="Series">In SG Fleet</option>
                        </select>
                      ) : [
                          "natSquadStatusJan25",
                          "natSquadStatusJul25",
                          "natSquadStatusJan26",
                          "natSquadStatusJul26",
                        ].includes(bulkField) ? (
                        <select
                          value={bulkValue}
                          onChange={(e) => setBulkValue(e.target.value)}
                          className="rounded-lg bg-slate-900 border border-white/10 text-white px-3 py-2 text-xs"
                        >
                          <option value="">—</option>
                          <option value="Nat A">Nat A</option>
                          <option value="Nat B">Nat B</option>
                          <option value="DS">DS</option>
                          <option value="CLEAR">Clear</option>
                        </select>
                      ) : [
                          "histRankingJun24",
                          "histRankingDec24",
                          "histRankingJun25",
                          "histRankingDec25",
                          "histRankingJun26",
                          "weight",
                        ].includes(bulkField) ? (
                        <input
                          type="number"
                          value={bulkValue}
                          onChange={(e) => setBulkValue(e.target.value)}
                          className="rounded-lg bg-slate-900 border border-white/10 text-white px-3 py-2 text-xs font-mono"
                          placeholder="Number"
                        />
                      ) : (
                        <input
                          type="text"
                          value={bulkValue}
                          onChange={(e) => setBulkValue(e.target.value)}
                          disabled={!bulkField}
                          className="rounded-lg bg-slate-900 border border-white/10 text-white px-3 py-2 text-xs disabled:opacity-40"
                          placeholder={bulkField ? "Value" : "Select property first"}
                        />
                      )}
                    </div>
                    <button
                      type="button"
                      disabled={!isSuperadmin || selectedSailors.length === 0 || !bulkField}
                      onClick={handleApplyBulk}
                      className="rounded-full bg-orange-600 px-5 py-2 text-xs font-bold text-white hover:bg-orange-500 disabled:opacity-40 flex items-center gap-1.5"
                    >
                      <Save className="h-4 w-4" />
                      Apply to {selectedSailors.length || 0}
                    </button>
                    <button
                      type="button"
                      disabled={!isSuperadmin || selectedSailors.length !== 2}
                      onClick={handleMergeSailors}
                      title="Select exactly 2 sailors to merge duplicates"
                      className="rounded-full bg-emerald-600 px-4 py-2 text-xs font-bold text-white hover:bg-emerald-500 disabled:opacity-40 flex items-center gap-1.5"
                    >
                      <UserCheck className="h-4 w-4" />
                      Merge 2 selected
                      {selectedSailors.length === 2 ? "" : ` (${selectedSailors.length}/2)`}
                    </button>
                    <button
                      type="button"
                      disabled={!isSuperadmin || selectedSailors.length === 0}
                      onClick={handleBulkDelete}
                      className="rounded-full bg-rose-600/90 px-4 py-2 text-xs font-bold text-white hover:bg-rose-500 disabled:opacity-40 flex items-center gap-1.5"
                    >
                      <Trash2 className="h-4 w-4" />
                      Delete selected
                    </button>
                  </div>
                  <div className="flex flex-wrap items-center gap-3">
                    <p className="text-[10px] text-slate-500 flex-1 min-w-[200px]">
                      <strong className="text-slate-400">Merge duplicates:</strong> tick exactly two
                      rows → <strong className="text-emerald-400">Merge 2 selected</strong>. The more
                      complete profile is kept; the other is deleted after results/aliases move over.
                    </p>
                    <button
                      type="button"
                      onClick={() => setShowDuplicateFinder((v) => !v)}
                      className="rounded-full border border-white/10 bg-white/5 px-3 py-1.5 text-[11px] font-bold text-slate-300 hover:text-white flex items-center gap-1.5"
                    >
                      <Copy className="h-3.5 w-3.5 text-orange-400" />
                      Find similar names
                      {duplicatePairs.length > 0 && (
                        <span className="rounded-full bg-orange-600/20 text-orange-300 px-1.5 py-0.5 text-[10px]">
                          {duplicatePairs.length}
                        </span>
                      )}
                    </button>
                  </div>

                  {showDuplicateFinder && (
                    <div className="rounded-xl border border-white/10 bg-slate-950/60 p-4 space-y-3">
                      <div className="flex items-start justify-between gap-3">
                        <div>
                          <h4 className="text-xs font-bold text-white uppercase tracking-wider">
                            Possible duplicate sailors
                          </h4>
                          <p className="text-[11px] text-slate-500 mt-1">
                            Shows pairs with ≥60% match (jumbled names, partial names, same sail #).
                            <span className="text-rose-300/90 font-semibold"> High ≥80%</span>
                            {" · "}
                            <span className="text-amber-300/90 font-semibold">Medium 60–79%</span>
                            . Select both → Merge 2 selected.
                          </p>
                        </div>
                        <button
                          type="button"
                          onClick={() => setShowDuplicateFinder(false)}
                          className="text-[11px] font-bold text-slate-500 hover:text-white"
                        >
                          Hide
                        </button>
                      </div>
                      {duplicatePairs.length === 0 ? (
                        <p className="text-xs text-slate-500 py-4 text-center">
                          No pairs at 60%+ similarity.
                        </p>
                      ) : (
                        <ul className="space-y-2 max-h-72 overflow-y-auto">
                          {duplicatePairs.slice(0, 60).map((p) => {
                            const pct = Math.round(p.similarity * 100);
                            const high = p.band === "high" || pct >= 80;
                            return (
                              <li
                                key={`${p.a.id}-${p.b.id}`}
                                className={`flex flex-col sm:flex-row sm:items-center justify-between gap-2 rounded-lg border px-3 py-2 text-xs ${
                                  high
                                    ? "border-rose-500/40 bg-rose-500/10"
                                    : "border-amber-500/35 bg-amber-500/10"
                                }`}
                              >
                                <div className="min-w-0">
                                  <div className="flex flex-wrap items-center gap-2 mb-1">
                                    <span
                                      className={`rounded-full px-2 py-0.5 text-[10px] font-black ${
                                        high
                                          ? "bg-rose-500/20 text-rose-200 border border-rose-500/30"
                                          : "bg-amber-500/20 text-amber-100 border border-amber-500/30"
                                      }`}
                                    >
                                      {pct}% · {high ? "High" : "Medium"}
                                    </span>
                                    <span className="text-[10px] text-slate-500">
                                      {p.how}
                                    </span>
                                  </div>
                                  <p className="text-white font-semibold truncate">
                                    {p.a.name}
                                    <span className="text-slate-500 font-mono text-[10px] ml-2">
                                      {p.a.sailNumber || "—"}
                                    </span>
                                  </p>
                                  <p className="text-slate-300 font-semibold truncate">
                                    {p.b.name}
                                    <span className="text-slate-500 font-mono text-[10px] ml-2">
                                      {p.b.sailNumber || "—"}
                                    </span>
                                  </p>
                                </div>
                                <div className="flex flex-wrap gap-2 shrink-0">
                                  <button
                                    type="button"
                                    onClick={() => {
                                      setSelectedSailors([p.a.id, p.b.id]);
                                      setDbSearch("");
                                      setShowDuplicateFinder(true);
                                    }}
                                    className="rounded-full bg-emerald-600/90 hover:bg-emerald-500 px-3 py-1.5 text-[10px] font-bold text-white"
                                  >
                                    Select pair
                                  </button>
                                  <button
                                    type="button"
                                    onClick={() =>
                                      ignoreDuplicatePair(p.a.id, p.b.id)
                                    }
                                    className="rounded-full border border-white/15 bg-white/5 px-3 py-1.5 text-[10px] font-bold text-slate-400 hover:text-white"
                                  >
                                    Ignore
                                  </button>
                                </div>
                              </li>
                            );
                          })}
                        </ul>
                      )}
                    </div>
                  )}
                  {bulkStatus && (
                    <div className="flex items-center gap-2 text-xs font-bold text-emerald-400">
                      <CheckCircle className="h-4 w-4" />
                      {bulkStatus}
                    </div>
                  )}
                </div>

                {/* Sailor Form — fixed modal so Edit is always visible */}
                {editingSailorId && (
                  <div className="fixed inset-0 z-[100] flex items-end sm:items-center justify-center p-0 sm:p-4">
                    <button
                      type="button"
                      aria-label="Close edit form"
                      className="absolute inset-0 bg-black/70 backdrop-blur-sm"
                      onClick={() => setEditingSailorId(null)}
                    />
                    <div
                      id="sailor-edit-form"
                      className="relative z-10 w-full sm:max-w-3xl max-h-[92vh] overflow-y-auto rounded-t-3xl sm:rounded-3xl border border-orange-500/30 bg-[#0c0d14] shadow-2xl p-5 sm:p-6 space-y-4"
                    >
                    <h3 className="text-sm font-bold text-white uppercase tracking-wider sticky top-0 bg-[#0c0d14] pb-2 z-10">
                      {editingSailorId === "new" ? "Add New Sailor Profile" : "Edit Sailor Profile"}
                      <span className="block text-[11px] font-semibold text-slate-500 normal-case tracking-normal mt-0.5">
                        {editingSailorId !== "new" ? sailorForm.name || "" : "Fill in details and save"}
                      </span>
                    </h3>
                    <div className="grid grid-cols-1 md:grid-cols-3 gap-4">
                      <div className="md:col-span-2">
                        <label className="text-[10px] font-bold text-slate-500 uppercase">Full Name</label>
                        <input
                          type="text"
                          value={sailorForm.name}
                          onChange={(e) => setSailorForm({ ...sailorForm, name: e.target.value })}
                          className="mt-1 w-full rounded-xl border border-white/5 bg-slate-950 px-3 py-2 text-white text-xs"
                        />
                      </div>
                      <div>
                        <label className="text-[10px] font-bold text-slate-500 uppercase">Sail Number</label>
                        <input
                          type="text"
                          value={sailorForm.sailNumber}
                          onChange={(e) => setSailorForm({ ...sailorForm, sailNumber: e.target.value })}
                          className="mt-1 w-full rounded-xl border border-white/5 bg-slate-950 px-3 py-2 text-white text-xs text-slate-300 font-mono"
                        />
                      </div>
                      <div>
                        <label className="text-[10px] font-bold text-slate-500 uppercase">Club</label>
                        <input
                          type="text"
                          value={sailorForm.club}
                          onChange={(e) => setSailorForm({ ...sailorForm, club: e.target.value })}
                          className="mt-1 w-full rounded-xl border border-white/5 bg-slate-950 px-3 py-2 text-white text-xs"
                        />
                      </div>
                      <div>
                        <label className="text-[10px] font-bold text-slate-500 uppercase">School</label>
                        <input
                          type="text"
                          value={sailorForm.school || ""}
                          onChange={(e) =>
                            setSailorForm({ ...sailorForm, school: e.target.value })
                          }
                          className="mt-1 w-full rounded-xl border border-white/5 bg-slate-950 px-3 py-2 text-white text-xs"
                          placeholder="e.g. Raffles Institution"
                        />
                      </div>
                      <div>
                        <label className="text-[10px] font-bold text-slate-500 uppercase">Nationality</label>
                        <input
                          type="text"
                          value={sailorForm.nationality || ""}
                          onChange={(e) =>
                            setSailorForm({ ...sailorForm, nationality: e.target.value })
                          }
                          className="mt-1 w-full rounded-xl border border-white/5 bg-slate-950 px-3 py-2 text-white text-xs"
                          placeholder="e.g. Singapore / SGP"
                        />
                      </div>
                      <div>
                        <label className="text-[10px] font-bold text-slate-500 uppercase">Gender (M/F)</label>
                        <select
                          value={sailorForm.gender || "M"}
                          onChange={(e) => setSailorForm({ ...sailorForm, gender: e.target.value })}
                          className="mt-1 w-full rounded-xl border border-white/5 bg-slate-950 px-3 py-2 text-white text-xs focus:outline-none"
                        >
                          <option value="M">Male (M)</option>
                          <option value="F">Female (F)</option>
                        </select>
                      </div>
                      <div className="md:col-span-3 grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-4 border-t border-white/5 pt-4">
                        <p className="sm:col-span-2 lg:col-span-4 text-[10px] font-bold text-orange-400/90 uppercase tracking-wider">
                          Nat squad by period (fixed for the whole half-year)
                        </p>
                        {(
                          [
                            ["natSquadStatusJan25", "Jan – Jun 2025"],
                            ["natSquadStatusJul25", "Jul – Dec 2025"],
                            ["natSquadStatusJan26", "Jan – Jun 2026"],
                            ["natSquadStatusJul26", "Jul – Dec 2026 (current)"],
                          ] as const
                        ).map(([key, label]) => (
                          <div key={key}>
                            <label className="text-[10px] font-bold text-slate-500 uppercase">
                              {label}
                            </label>
                            <select
                              value={(sailorForm as any)[key] || ""}
                              onChange={(e) => {
                                const v = e.target.value;
                                setSailorForm({
                                  ...sailorForm,
                                  [key]: v,
                                  // Keep legacy “current squad” in sync with Jul–Dec 2026
                                  ...(key === "natSquadStatusJul26"
                                    ? { nationalSquadStatus: v }
                                    : {}),
                                });
                              }}
                              className="mt-1 w-full rounded-xl border border-white/5 bg-slate-950 px-3 py-2 text-white text-xs focus:outline-none"
                            >
                              <option value="">None</option>
                              <option value="Nat A">National A (Nat A)</option>
                              <option value="Nat B">National B (Nat B)</option>
                              <option value="DS">Development Squad (DS)</option>
                            </select>
                          </div>
                        ))}
                        <p className="sm:col-span-2 lg:col-span-4 text-[10px] text-slate-600 leading-relaxed">
                          Rankings boards show the squad for the period selected.
                          Jul–Dec 2026 also updates the live “current squad” field.
                          History is visible on Gold register and each sailor profile.
                        </p>
                      </div>
                      <div>
                        <label className="text-[10px] font-bold text-slate-500 uppercase">DOB (YYYY-MM-DD)</label>
                        <input
                          type="date"
                          value={sailorForm.dob || ""}
                          onChange={(e) => setSailorForm({ ...sailorForm, dob: e.target.value })}
                          className="mt-1 w-full rounded-xl border border-white/5 bg-slate-950 px-3 py-2 text-white text-xs font-mono"
                        />
                      </div>
                      <div>
                        <label className="text-[10px] font-bold text-slate-500 uppercase">Weight (kg)</label>
                        <input
                          type="number"
                          value={sailorForm.weight || ""}
                          onChange={(e) => setSailorForm({ ...sailorForm, weight: e.target.value })}
                          className="mt-1 w-full rounded-xl border border-white/5 bg-slate-950 px-3 py-2 text-white text-xs font-mono"
                        />
                      </div>
                      <div>
                        <label className="text-[10px] font-bold text-slate-500 uppercase">Handle (URL Parameter)</label>
                        <input
                          type="text"
                          value={sailorForm.handle}
                          onChange={(e) => setSailorForm({ ...sailorForm, handle: e.target.value })}
                          className="mt-1 w-full rounded-xl border border-white/5 bg-slate-950 px-3 py-2 text-white text-xs font-mono"
                          placeholder="e.g. ashlyn-t"
                        />
                      </div>
                      <div>
                        <label className="text-[10px] font-bold text-slate-500 uppercase">Instagram Handle</label>
                        <input
                          type="text"
                          value={sailorForm.instagram || ""}
                          onChange={(e) => setSailorForm({ ...sailorForm, instagram: e.target.value })}
                          className="mt-1 w-full rounded-xl border border-white/5 bg-slate-950 px-3 py-2 text-white text-xs font-mono"
                          placeholder="e.g. @username"
                        />
                      </div>
                      <div>
                        <label className="text-[10px] font-bold text-slate-500 uppercase">Avatar URL</label>
                        <input
                          type="url"
                          value={sailorForm.avatarUrl || ""}
                          onChange={(e) => setSailorForm({ ...sailorForm, avatarUrl: e.target.value })}
                          className="mt-1 w-full rounded-xl border border-white/5 bg-slate-950 px-3 py-2 text-white text-xs font-mono"
                          placeholder="https://… (public image URL)"
                        />
                      </div>
                      <div className="md:col-span-3 grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-4 border-t border-white/5 pt-4">
                        <p className="sm:col-span-2 lg:col-span-4 text-[10px] font-bold text-emerald-400/90 uppercase tracking-wider">
                          Overseas Representation — multiple years allowed (e.g. 2023, 2025)
                        </p>
                        <div>
                          <label className="text-[10px] font-bold text-slate-500 uppercase">Worlds years</label>
                          <input
                            type="text"
                            value={sailorForm.worlds || ""}
                            onChange={(e) => setSailorForm({ ...sailorForm, worlds: e.target.value })}
                            className="mt-1 w-full rounded-xl border border-white/5 bg-slate-950 px-3 py-2 text-white text-xs font-mono"
                            placeholder="2023, 2025"
                          />
                        </div>
                        <div>
                          <label className="text-[10px] font-bold text-slate-500 uppercase">European years</label>
                          <input
                            type="text"
                            value={sailorForm.european || ""}
                            onChange={(e) => setSailorForm({ ...sailorForm, european: e.target.value })}
                            className="mt-1 w-full rounded-xl border border-white/5 bg-slate-950 px-3 py-2 text-white text-xs font-mono"
                            placeholder="2024"
                          />
                        </div>
                        <div>
                          <label className="text-[10px] font-bold text-slate-500 uppercase">Asian years</label>
                          <input
                            type="text"
                            value={sailorForm.asian || ""}
                            onChange={(e) => setSailorForm({ ...sailorForm, asian: e.target.value })}
                            className="mt-1 w-full rounded-xl border border-white/5 bg-slate-950 px-3 py-2 text-white text-xs font-mono"
                            placeholder="2022, 2024"
                          />
                        </div>
                        <div>
                          <label className="text-[10px] font-bold text-slate-500 uppercase">SEA Games years</label>
                          <input
                            type="text"
                            value={sailorForm.seaGames || ""}
                            onChange={(e) => setSailorForm({ ...sailorForm, seaGames: e.target.value })}
                            className="mt-1 w-full rounded-xl border border-white/5 bg-slate-950 px-3 py-2 text-white text-xs font-mono"
                            placeholder="2023"
                          />
                        </div>
                      </div>
                      <div>
                        <label className="text-[10px] font-bold text-slate-500 uppercase">Biography</label>
                        <textarea
                          value={sailorForm.bio || ""}
                          onChange={(e) => setSailorForm({ ...sailorForm, bio: e.target.value })}
                          className="mt-1 w-full rounded-xl border border-white/5 bg-slate-950 px-3 py-2 text-white text-xs h-10"
                        />
                      </div>
                      <div>
                        <label className="text-[10px] font-bold text-slate-500 uppercase">
                          SG Series Fleet
                        </label>
                        <select
                          value={
                            ["series", "gold", "silver"].includes(
                              String(sailorForm.currentFleet || "").toLowerCase()
                            )
                              ? "Series"
                              : "Guest"
                          }
                          onChange={(e) => {
                            const v = e.target.value;
                            const next: any = {
                              ...sailorForm,
                              currentFleet: v === "Series" ? "Series" : "Guest",
                            };
                            // Admit to series: stamp silver entry if empty (SG calendar)
                            if (
                              v === "Series" &&
                              !next.silverEntryDate &&
                              !next.goldEntryDate
                            ) {
                              next.silverEntryDate = todayYmdSg();
                            }
                            setSailorForm(next);
                          }}
                          className="mt-1 w-full rounded-xl border border-white/5 bg-slate-950 px-3 py-2 text-white text-xs focus:outline-none"
                        >
                          <option value="Guest">Guest (not ranked)</option>
                          <option value="Series">In SG Fleet</option>
                        </select>
                        <p className="mt-1 text-[10px] text-slate-500 leading-snug">
                          Guest = never ranked. In SG Fleet needs a Silver or
                          Gold entry date to appear on boards (empty Series is
                          not ranked). Silver until Gold entry, then Gold until
                          Drop. Gold entry & drop: 1 Jan / 1 Jul from 2022 only.
                        </p>
                      </div>
                      <div>
                        <label className="text-[10px] font-bold text-slate-500 uppercase">Gold Fleet Entry Date</label>
                        <select
                          value={sailorForm.goldEntryDate || ""}
                          onChange={(e) =>
                            setSailorForm({
                              ...sailorForm,
                              goldEntryDate: e.target.value,
                            })
                          }
                          className="mt-1 w-full rounded-xl border border-white/5 bg-slate-950 px-3 py-2 text-white text-xs font-mono"
                        >
                          <option value="">— none —</option>
                          {/* Preserve legacy non-boundary values so admin can fix them */}
                          {sailorForm.goldEntryDate &&
                            !HALF_BOUNDARY_OPTS.some(
                              (o) => o.value === sailorForm.goldEntryDate
                            ) && (
                              <option value={sailorForm.goldEntryDate}>
                                {sailorForm.goldEntryDate} (not 1 Jan/1 Jul —
                                pick a boundary)
                              </option>
                            )}
                          {HALF_BOUNDARY_OPTS.map((o) => (
                            <option key={o.value} value={o.value}>
                              {o.label}
                            </option>
                          ))}
                        </select>
                        <p className="mt-1 text-[10px] text-slate-500">
                          Only 1 Jan or 1 Jul — applies for the whole half-year.
                        </p>
                      </div>
                      <div>
                        <label className="text-[10px] font-bold text-slate-500 uppercase">Silver Fleet Entry Date</label>
                        <input
                          type="date"
                          value={sailorForm.silverEntryDate || ""}
                          onChange={(e) => setSailorForm({ ...sailorForm, silverEntryDate: e.target.value })}
                          className="mt-1 w-full rounded-xl border border-white/5 bg-slate-950 px-3 py-2 text-white text-xs font-mono"
                        />
                      </div>
                      <div>
                        <label className="text-[10px] font-bold text-slate-500 uppercase">Optimist Drop Date</label>
                        <select
                          value={sailorForm.dropDate || ""}
                          onChange={(e) =>
                            setSailorForm({
                              ...sailorForm,
                              dropDate: e.target.value,
                            })
                          }
                          className="mt-1 w-full rounded-xl border border-white/5 bg-slate-950 px-3 py-2 text-white text-xs font-mono"
                        >
                          <option value="">— none —</option>
                          {sailorForm.dropDate &&
                            !HALF_BOUNDARY_OPTS.some(
                              (o) => o.value === sailorForm.dropDate
                            ) && (
                              <option value={sailorForm.dropDate}>
                                {sailorForm.dropDate} (not 1 Jan/1 Jul — pick a
                                boundary)
                              </option>
                            )}
                          {HALF_BOUNDARY_OPTS.map((o) => (
                            <option key={`d-${o.value}`} value={o.value}>
                              {o.label}
                            </option>
                          ))}
                        </select>
                        <p className="mt-1 text-[10px] text-slate-500">
                          Only 1 Jan or 1 Jul. Drop on that day removes the
                          sailor from that half and later.
                        </p>
                      </div>
                      <div className="md:col-span-3 grid grid-cols-2 sm:grid-cols-3 lg:grid-cols-5 gap-3 border-t border-white/5 pt-4">
                        <p className="col-span-2 sm:col-span-3 lg:col-span-5 text-[10px] font-bold text-blue-400/90 uppercase tracking-wider">
                          Historical rankings (shown on All Gold Fleet Sailors)
                        </p>
                        {(
                          [
                            ["histRankingJun24", "Jun 24"],
                            ["histRankingDec24", "Dec 24"],
                            ["histRankingJun25", "Jun 25"],
                            ["histRankingDec25", "Dec 25"],
                            ["histRankingJun26", "Jun 26"],
                          ] as const
                        ).map(([key, label]) => (
                          <div key={key}>
                            <label className="text-[10px] font-bold text-slate-500 uppercase">
                              {label}
                            </label>
                            <input
                              type="number"
                              min={1}
                              value={(sailorForm as any)[key] ?? ""}
                              onChange={(e) =>
                                setSailorForm({
                                  ...sailorForm,
                                  [key]: e.target.value,
                                })
                              }
                              className="mt-1 w-full rounded-xl border border-white/5 bg-slate-950 px-3 py-2 text-white text-xs font-mono"
                              placeholder="—"
                            />
                          </div>
                        ))}
                      </div>
                    </div>

                    <div className="flex justify-end gap-2 border-t border-white/5 pt-4 sticky bottom-0 bg-[#0c0d14] pb-1">
                      <button
                        type="button"
                        onClick={() => setEditingSailorId(null)}
                        className="rounded-full bg-slate-800 px-4 py-2 text-xs font-bold text-slate-400 hover:text-white"
                      >
                        Cancel
                      </button>
                      <button
                        type="button"
                        onClick={handleSaveSailor}
                        className="rounded-full bg-orange-600 px-5 py-2 text-xs font-bold text-white hover:bg-orange-500"
                      >
                        Save Sailor
                      </button>
                    </div>
                    </div>
                  </div>
                )}

                {/* Sailors List */}
                <div className="glass-panel rounded-3xl border border-white/5 overflow-hidden">
                  <div className="p-6 border-b border-white/5 flex flex-col sm:flex-row sm:items-center justify-between gap-3">
                    <div>
                      <h3 className="text-base font-bold text-white">Sailors List</h3>
                      <p className="text-xs text-slate-500">
                        Click headers to sort. Choose columns to show. Edit profile or competitions per sailor.
                      </p>
                    </div>
                    <div className="flex flex-wrap items-center gap-2">
                      <div className="relative">
                        <button
                          type="button"
                          onClick={() => setDbColPickerOpen((o) => !o)}
                          className="rounded-full bg-slate-800 border border-white/10 px-4 py-2 text-xs font-bold text-white hover:bg-slate-700 flex items-center gap-1.5"
                        >
                          <Columns3 className="h-4 w-4 text-orange-400" />
                          Columns
                        </button>
                        {dbColPickerOpen && (
                          <div className="absolute right-0 top-full mt-2 z-30 w-56 rounded-xl border border-white/10 bg-slate-950 shadow-xl p-3 space-y-1.5">
                            <p className="text-[10px] font-bold text-slate-500 uppercase mb-2">
                              Visible columns
                            </p>
                            {DB_SAILOR_COLUMNS.map((c) => (
                              <label
                                key={c.key}
                                className="flex items-center gap-2 text-xs text-slate-300 cursor-pointer hover:text-white"
                              >
                                <input
                                  type="checkbox"
                                  checked={colOn(c.key)}
                                  disabled={c.key === "name"}
                                  onChange={() =>
                                    setDbColVisible((prev) => ({
                                      ...prev,
                                      [c.key]: !colOn(c.key),
                                    }))
                                  }
                                  className="rounded border-slate-700 bg-slate-900 text-orange-600 h-3.5 w-3.5"
                                />
                                {c.label}
                                {!c.defaultOn && (
                                  <span className="text-[9px] text-slate-600">optional</span>
                                )}
                              </label>
                            ))}
                            <button
                              type="button"
                              onClick={() => setDbColVisible(defaultDbColVisible())}
                              className="mt-2 w-full text-[10px] font-bold text-orange-400 hover:text-orange-300"
                            >
                              Reset defaults
                            </button>
                          </div>
                        )}
                      </div>
                      <button
                        onClick={() => {
                          setCompetitionsSailorId(null);
                          setEditingSailorId("new");
                          setSailorForm({
                            id: "",
                            name: "",
                            handle: "",
                            sailNumber: "SGP ",
                            club: "",
                            nationality: "",
                            gender: "M",
                            nationalSquadStatus: "",
                            currentFleet: "",
                            instagram: "",
                                                    dob: "",
                            weight: "",
                            bio: "",
                            goldEntryDate: "",
                            silverEntryDate: "",
                            dropDate: "",
                            natSquadStatusJan25: "",
                            natSquadStatusJul25: "",
                            natSquadStatusJan26: "",
                            natSquadStatusJul26: "",
                            histRankingJun24: "",
                            histRankingDec24: "",
                            histRankingJun25: "",
                            histRankingDec25: "",
                            histRankingJun26: "",
                            worlds: "",
                            european: "",
                            asian: "",
                            seaGames: "",
                          });
                        }}
                        className="rounded-full bg-orange-600 hover:bg-orange-500 px-4 py-2 text-xs font-bold text-white flex items-center gap-1"
                      >
                        <Plus className="h-4 w-4" />
                        Add Sailor
                      </button>
                    </div>
                  </div>

                  <div className="overflow-x-auto">
                    <table className="w-full text-left border-collapse text-xs min-w-[720px]">
                      <thead>
                        <tr className="border-b border-white/5 bg-white/5 text-[10px] font-bold text-slate-400 uppercase tracking-wider">
                          <th className="py-3 px-3 w-10 text-center">
                            <input
                              type="checkbox"
                              checked={
                                sortedDbSailors.length > 0 &&
                                sortedDbSailors.every((s) =>
                                  selectedSailors.includes(s.id)
                                )
                              }
                              onChange={toggleSelectAllVisible}
                              className="rounded border-slate-700 bg-slate-900 text-orange-600 h-3.5 w-3.5"
                              title="Select all visible"
                            />
                          </th>
                          {DB_SAILOR_COLUMNS.filter((c) => colOn(c.key)).map((c) => (
                            <th
                              key={c.key}
                              className={`py-3 px-4 whitespace-nowrap ${
                                c.key === "best3" ||
                                c.key === "goldEntry" ||
                                c.key === "silverEntry" ||
                                c.key === "dropDate" ||
                                c.key.startsWith("hist") ||
                                ["worlds", "european", "asian", "seaGames"].includes(
                                  c.key
                                )
                                  ? "text-center"
                                  : ""
                              }`}
                            >
                              <button
                                type="button"
                                onClick={() => toggleDbSort(c.key)}
                                className="inline-flex items-center gap-1 hover:text-white"
                              >
                                {c.label}
                                {dbSortKey === c.key ? (
                                  dbSortDir === "asc" ? (
                                    <ArrowUp className="h-3 w-3 text-orange-400" />
                                  ) : (
                                    <ArrowDown className="h-3 w-3 text-orange-400" />
                                  )
                                ) : (
                                  <ArrowUpDown className="h-3 w-3 opacity-40" />
                                )}
                              </button>
                            </th>
                          ))}
                          <th className="py-3 px-4 text-right">Actions</th>
                        </tr>
                      </thead>
                      <tbody className="divide-y divide-white/5 font-semibold text-slate-300">
                        {sortedDbSailors.map((s) => {
                          const seriesLabel = seriesLabelOf(s);
                          const isChecked = selectedSailors.includes(s.id);
                          const cells: Record<string, any> = {
                            name: (
                              <span className="font-bold text-white">
                                {s.name}
                                {s.nationality && !colOn("nationality") ? (
                                  <span className="block text-[10px] font-semibold text-slate-500 mt-0.5">
                                    {s.nationality}
                                  </span>
                                ) : null}
                              </span>
                            ),
                            sailNumber: (
                              <span className="font-mono text-slate-400">
                                {s.sailNumber}
                              </span>
                            ),
                            series: (
                              <span
                                className={`text-[10px] font-bold px-2 py-0.5 rounded border ${
                                  seriesLabel.startsWith("Series")
                                    ? "bg-sky-500/10 text-sky-300 border-sky-500/25"
                                    : seriesLabel === "Dropped"
                                      ? "bg-amber-500/10 text-amber-300 border-amber-500/20"
                                      : "bg-white/5 text-slate-500 border-white/10"
                                }`}
                              >
                                {seriesLabel}
                              </span>
                            ),
                            best3: (
                              <span className="font-mono font-black text-white">
                                {best3BySailor[s.id] != null
                                  ? best3BySailor[s.id]
                                  : "—"}
                              </span>
                            ),
                            gender: s.gender || "M",
                            age: (() => {
                              const a = ageYears(s.dob as string | null);
                              return a != null ? (
                                <span className="font-mono text-white">{a}</span>
                              ) : (
                                <span className="text-slate-600">—</span>
                              );
                            })(),
                            club: s.club || "—",
                            nationality: s.nationality || "—",
                            school: s.school || "—",
                            goldEntry: (
                              <span className="font-mono">
                                {s.goldEntryDate
                                  ? String(s.goldEntryDate).slice(0, 10)
                                  : "-"}
                              </span>
                            ),
                            silverEntry: (
                              <span className="font-mono">
                                {s.silverEntryDate
                                  ? String(s.silverEntryDate).slice(0, 10)
                                  : "-"}
                              </span>
                            ),
                            dropDate: (
                              <span className="font-mono">
                                {s.dropDate ? String(s.dropDate).slice(0, 10) : "-"}
                              </span>
                            ),
                            squadJan25: s.natSquadStatusJan25 || "—",
                            squadJul25: s.natSquadStatusJul25 || "—",
                            squadJan26: s.natSquadStatusJan26 || "—",
                            squadJul26: s.natSquadStatusJul26 || "—",
                            histJun24: s.histRankingJun24 ?? "—",
                            histDec24: s.histRankingDec24 ?? "—",
                            histJun25: s.histRankingJun25 ?? "—",
                            histDec25: s.histRankingDec25 ?? "—",
                            histJun26: s.histRankingJun26 ?? "—",
                            worlds: s.worlds != null && s.worlds !== "" ? String(s.worlds) : "—",
                            european: s.european != null && s.european !== "" ? String(s.european) : "—",
                            asian: s.asian != null && s.asian !== "" ? String(s.asian) : "—",
                            seaGames: s.seaGames != null && s.seaGames !== "" ? String(s.seaGames) : "—",
                          };
                          return (
                            <tr
                              key={s.id}
                              className={`hover:bg-white/5 transition-colors ${
                                isChecked
                                  ? "bg-orange-500/5"
                                  : competitionsSailorId === s.id
                                    ? "bg-orange-500/[0.03]"
                                    : ""
                              }`}
                            >
                              <td className="py-3 px-3 text-center">
                                <input
                                  type="checkbox"
                                  checked={isChecked}
                                  onChange={() => toggleSelectSailor(s.id)}
                                  className="rounded border-slate-700 bg-slate-900 text-orange-600 h-3.5 w-3.5"
                                />
                              </td>
                              {DB_SAILOR_COLUMNS.filter((c) => colOn(c.key)).map(
                                (c) => (
                                  <td
                                    key={c.key}
                                    className={`py-3 px-4 ${
                                      c.key === "best3" ||
                                      c.key === "goldEntry" ||
                                      c.key === "silverEntry" ||
                                      c.key === "dropDate" ||
                                      c.key.startsWith("hist") ||
                                      [
                                        "worlds",
                                        "european",
                                        "asian",
                                        "seaGames",
                                      ].includes(c.key)
                                        ? "text-center font-mono"
                                        : ""
                                    }`}
                                  >
                                    {cells[c.key]}
                                  </td>
                                )
                              )}
                              <td className="py-3 px-4 text-right">
                                <div className="flex justify-end items-center gap-2">
                                  <button
                                    type="button"
                                    title="View & edit all regatta results for this sailor"
                                    onClick={(e) => {
                                      e.preventDefault();
                                      e.stopPropagation();
                                      void openSailorResults(s.id);
                                    }}
                                    className="inline-flex items-center gap-1 rounded-full border border-white/10 bg-white/5 px-2.5 py-1 text-[10px] font-bold text-orange-300 hover:border-orange-500/40 hover:text-orange-200"
                                  >
                                    <Medal className="h-3.5 w-3.5" />
                                    Results
                                  </button>
                                  <button
                                    type="button"
                                    title="Edit profile"
                                    onClick={(e) => {
                                      e.preventDefault();
                                      e.stopPropagation();
                                      setCompetitionsSailorId(null);
                                      const d = (v: unknown) =>
                                        v ? String(v).slice(0, 10) : "";
                                      setSailorForm({
                                        ...s,
                                        weight: s.weight
                                          ? s.weight.toString()
                                          : "",
                                        nationalSquadStatus:
                                          s.natSquadStatusJul26 ||
                                          s.nationalSquadStatus ||
                                          "",
                                        natSquadStatusJan25:
                                          s.natSquadStatusJan25 || "",
                                        natSquadStatusJul25:
                                          s.natSquadStatusJul25 || "",
                                        natSquadStatusJan26:
                                          s.natSquadStatusJan26 || "",
                                        natSquadStatusJul26:
                                          s.natSquadStatusJul26 ||
                                          s.nationalSquadStatus ||
                                          "",
                                        nationality: s.nationality || "",
                                        currentFleet: s.currentFleet || "",
                                        school: s.school || "",
                                        histRankingJun24:
                                          s.histRankingJun24 != null
                                            ? String(s.histRankingJun24)
                                            : "",
                                        histRankingDec24:
                                          s.histRankingDec24 != null
                                            ? String(s.histRankingDec24)
                                            : "",
                                        histRankingJun25:
                                          s.histRankingJun25 != null
                                            ? String(s.histRankingJun25)
                                            : "",
                                        histRankingDec25:
                                          s.histRankingDec25 != null
                                            ? String(s.histRankingDec25)
                                            : "",
                                        histRankingJun26:
                                          s.histRankingJun26 != null
                                            ? String(s.histRankingJun26)
                                            : "",
                                        instagram: s.instagram || "",
                                        avatarUrl: s.avatarUrl || "",
                                        dob: d(s.dob),
                                        bio: s.bio || "",
                                        goldEntryDate: d(s.goldEntryDate),
                                        silverEntryDate: d(s.silverEntryDate),
                                        dropDate: d(s.dropDate),
                                        worlds: s.worlds != null ? String(s.worlds) : "",
                                        european: s.european != null ? String(s.european) : "",
                                        asian: s.asian != null ? String(s.asian) : "",
                                        seaGames: s.seaGames != null ? String(s.seaGames) : "",
                                      });
                                      setEditingSailorId(s.id);
                                    }}
                                    className="inline-flex items-center gap-1 rounded-full border border-white/10 bg-white/5 px-2.5 py-1 text-[10px] font-bold text-slate-300 hover:text-white hover:border-orange-500/40"
                                  >
                                    <Edit3 className="h-3.5 w-3.5" />
                                    Edit
                                  </button>
                                  <button
                                    type="button"
                                    title="Delete sailor"
                                    onClick={() => handleDeleteSailor(s.id)}
                                    className="text-slate-500 hover:text-red-400"
                                  >
                                    <Trash2 className="h-4 w-4" />
                                  </button>
                                </div>
                              </td>
                            </tr>
                          );
                        })}
                      </tbody>
                    </table>
                  </div>
                  <p className="px-4 py-2 text-[10px] text-slate-600 border-t border-white/5">
                    Tick rows for bulk edit · Best 3 of 5 = Jul–Dec 2026 series score ·
                    Results button = all competitions for that sailor · Columns for squad / overseas.
                  </p>
                </div>
              </div>

  );
}
