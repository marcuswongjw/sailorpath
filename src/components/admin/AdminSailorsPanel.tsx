"use client";

import { useState, type Dispatch, type SetStateAction } from "react";
import {
  Columns3,
  ArrowUpDown,
  ArrowUp,
  ArrowDown,
  Plus,
  Trash2,
  Edit3,
  Edit2,
  Check,
  X,
  Medal,
  Copy,
  AlertTriangle,
  CheckCircle,
  Save,
  Grid,
  UserCheck,
  Users,
} from "lucide-react";
import {
  parseSailingJourney,
  serializeSailingJourney,
  newJourneyId,
  type JourneyHighlight,
} from "@/lib/sailingJourney";
import { birthYear } from "@/lib/age";
import {
  halfBoundaryOptions,
  todayYmdSg,
} from "@/lib/datesSg";
import {
  DB_SAILOR_COLUMNS,
  defaultDbColVisible,
} from "@/components/admin/adminConstants";
import { NationalitySelect } from "@/components/CountrySelect";
import {
  emptySailorForm,
  type SailorFormState,
} from "@/components/admin/adminForms";
import type { SailorAdmin } from "@/types/sailor";
import { AdminEmptyState } from "@/components/admin/AdminEmptyState";
import { AdminGenderAuditPanel } from "@/components/admin/AdminGenderAuditPanel";
import { formatGenderLabel } from "@/lib/gender";

const HALF_BOUNDARY_OPTS = halfBoundaryOptions();

export type DuplicatePair = {
  a: { id: string; name: string; sailNumber?: string | null };
  b: { id: string; name: string; sailNumber?: string | null };
  similarity: number;
  band?: string;
  how?: string;
};

export type { SailorFormState };

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
  /** True while a mutating action (save / bulk / merge / delete) is in flight. */
  saving: boolean;
  handleApplyBulk: () => void | Promise<void>;
  handleBulkDelete: () => void | Promise<void>;
  handleMergeSailors: () => void | Promise<void>;
  toggleSelectSailor: (id: string) => void;
  toggleSelectAllVisible: () => void;
  editingSailorId: string | null;
  setEditingSailorId: (id: string | null) => void;
  sailorForm: SailorFormState;
  setSailorForm: Dispatch<SetStateAction<SailorFormState>>;
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
  onBackfillNationalityFromSail?: () => void | Promise<void>;
  onUpdateOptimistSailNumbers?: () => void | Promise<void>;
  onCleanOptimistSailNumbers?: () => void | Promise<void>;
  onSailorsChange?: (sailors: SailorAdmin[]) => void;
};

function AdminMilestonesEditor({
  journeyRaw,
  onChange,
}: {
  journeyRaw: string;
  onChange: (nextRaw: string) => void;
}) {
  const items = parseSailingJourney(journeyRaw);
  const [editingId, setEditingId] = useState<string | null>(null);
  const [editWhen, setEditWhen] = useState("");
  const [editTitle, setEditTitle] = useState("");
  const [editDetail, setEditDetail] = useState("");

  const [newWhen, setNewWhen] = useState("");
  const [newTitle, setNewTitle] = useState("");
  const [newDetail, setNewDetail] = useState("");

  const handleSaveEdit = (id: string) => {
    if (!editTitle.trim()) return;
    const next = items.map((it) =>
      it.id === id
        ? {
            ...it,
            when: editWhen.trim(),
            title: editTitle.trim(),
            detail: editDetail.trim(),
          }
        : it
    );
    onChange(serializeSailingJourney(next) || "");
    setEditingId(null);
  };

  const handleDelete = (id: string) => {
    const next = items.filter((it) => it.id !== id);
    onChange(serializeSailingJourney(next) || "");
  };

  const handleAdd = () => {
    if (!newTitle.trim()) return;
    const item: JourneyHighlight = {
      id: newJourneyId(),
      when: newWhen.trim(),
      title: newTitle.trim(),
      detail: newDetail.trim(),
    };
    const next = [item, ...items];
    onChange(serializeSailingJourney(next) || "");
    setNewWhen("");
    setNewTitle("");
    setNewDetail("");
  };

  return (
    <div className="space-y-3 rounded-xl border border-[var(--sp-cool-veil)] bg-[var(--sp-sailcloth)]/50 p-3.5">
      {items.length === 0 ? (
        <p className="text-xs text-[var(--sp-slate-soft)] italic">
          No custom milestones recorded yet. Add one below.
        </p>
      ) : (
        <ul className="space-y-2 max-h-56 overflow-y-auto">
          {items.map((it) => (
            <li
              key={it.id}
              className="rounded-lg border border-[var(--sp-cool-veil)] bg-white p-2.5 text-xs space-y-1.5 shadow-2xs"
            >
              {editingId === it.id ? (
                <div className="space-y-2">
                  <div className="grid grid-cols-1 sm:grid-cols-3 gap-2">
                    <div>
                      <label className="text-[9px] font-bold text-[var(--sp-charcoal)] uppercase">When</label>
                      <input
                        value={editWhen}
                        onChange={(e) => setEditWhen(e.target.value)}
                        placeholder="e.g. Oct 2025"
                        className="mt-0.5 w-full rounded border border-[var(--sp-cool-veil)] bg-[var(--sp-sailcloth)] px-2 py-1 text-xs text-[var(--sp-charcoal)]"
                      />
                    </div>
                    <div className="sm:col-span-2">
                      <label className="text-[9px] font-bold text-[var(--sp-charcoal)] uppercase">Title</label>
                      <input
                        value={editTitle}
                        onChange={(e) => setEditTitle(e.target.value)}
                        placeholder="Milestone title"
                        className="mt-0.5 w-full rounded border border-[var(--sp-cool-veil)] bg-[var(--sp-sailcloth)] px-2 py-1 text-xs text-[var(--sp-charcoal)]"
                      />
                    </div>
                  </div>
                  <div>
                    <label className="text-[9px] font-bold text-[var(--sp-charcoal)] uppercase">Details</label>
                    <textarea
                      value={editDetail}
                      onChange={(e) => setEditDetail(e.target.value)}
                      placeholder="Details, boat class, takeaways"
                      rows={2}
                      className="mt-0.5 w-full rounded border border-[var(--sp-cool-veil)] bg-[var(--sp-sailcloth)] px-2 py-1 text-xs text-[var(--sp-charcoal)]"
                    />
                  </div>
                  <div className="flex items-center gap-2 pt-1">
                    <button
                      type="button"
                      onClick={() => handleSaveEdit(it.id)}
                      className="inline-flex items-center gap-1 rounded bg-[var(--sp-racing-orange)] px-2.5 py-1 text-[11px] font-bold text-white shadow-2xs"
                    >
                      <Check className="h-3 w-3" />
                      Save
                    </button>
                    <button
                      type="button"
                      onClick={() => setEditingId(null)}
                      className="inline-flex items-center gap-1 rounded border border-[var(--sp-cool-veil)] bg-white px-2.5 py-1 text-[11px] font-bold text-[var(--sp-charcoal)] hover:bg-[var(--sp-sailcloth)]"
                    >
                      <X className="h-3 w-3" />
                      Cancel
                    </button>
                  </div>
                </div>
              ) : (
                <div className="flex items-start justify-between gap-2">
                  <div>
                    <div className="flex items-center gap-1.5">
                      {it.when && (
                        <span className="font-bold text-[var(--sp-harbour-teal)] text-[10px] uppercase tracking-wide">
                          {it.when} ·
                        </span>
                      )}
                      <span className="font-bold text-[var(--sp-charcoal)]">{it.title}</span>
                    </div>
                    {it.detail && (
                      <p className="text-[11px] text-[var(--sp-slate-soft)] mt-0.5 leading-snug">
                        {it.detail}
                      </p>
                    )}
                  </div>
                  <div className="flex items-center gap-1 shrink-0">
                    <button
                      type="button"
                      onClick={() => {
                        setEditingId(it.id);
                        setEditWhen(it.when || "");
                        setEditTitle(it.title || "");
                        setEditDetail(it.detail || "");
                      }}
                      className="inline-flex items-center gap-1 text-[10px] font-bold text-[var(--sp-harbour-teal)] hover:underline"
                    >
                      <Edit2 className="h-3 w-3" />
                      Edit
                    </button>
                    <button
                      type="button"
                      onClick={() => handleDelete(it.id)}
                      className="text-[10px] font-bold text-rose-600 hover:underline ml-1.5"
                    >
                      Delete
                    </button>
                  </div>
                </div>
              )}
            </li>
          ))}
        </ul>
      )}

      {/* Add new milestone inline */}
      <div className="border-t border-[var(--sp-cool-veil)] pt-2.5 space-y-2">
        <p className="text-[10px] font-bold text-[var(--sp-charcoal)] uppercase tracking-wider">
          Add New Milestone
        </p>
        <div className="grid grid-cols-1 sm:grid-cols-3 gap-2">
          <input
            value={newWhen}
            onChange={(e) => setNewWhen(e.target.value)}
            placeholder="When (e.g. Oct 2025)"
            className="rounded-lg border border-[var(--sp-cool-veil)] bg-white px-2.5 py-1 text-xs text-[var(--sp-charcoal)]"
          />
          <input
            value={newTitle}
            onChange={(e) => setNewTitle(e.target.value)}
            placeholder="Milestone title"
            className="sm:col-span-2 rounded-lg border border-[var(--sp-cool-veil)] bg-white px-2.5 py-1 text-xs text-[var(--sp-charcoal)]"
          />
        </div>
        <textarea
          value={newDetail}
          onChange={(e) => setNewDetail(e.target.value)}
          placeholder="Details, boat class, takeaways"
          rows={2}
          className="w-full rounded-lg border border-[var(--sp-cool-veil)] bg-white px-2.5 py-1 text-xs text-[var(--sp-charcoal)]"
        />
        <button
          type="button"
          disabled={!newTitle.trim()}
          onClick={handleAdd}
          className="inline-flex items-center gap-1 rounded-lg bg-[var(--sp-harbour-teal)] px-3 py-1 text-xs font-bold text-white shadow-2xs disabled:opacity-50"
        >
          <Plus className="h-3.5 w-3.5" />
          Add Milestone
        </button>
      </div>
    </div>
  );
}

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
    saving,
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
    onBackfillNationalityFromSail,
    onUpdateOptimistSailNumbers,
    onCleanOptimistSailNumbers,
    onSailorsChange,
  } = p;

  return (
              <div className="w-full min-w-0 space-y-4 sm:space-y-6 overflow-x-clip">

                <AdminGenderAuditPanel
                  sailors={sailorList}
                  onSailorsChange={onSailorsChange}
                />

                {emptySeriesCount > 0 && onCleanupEmptySeries && (
                  <div className="rounded-2xl border border-[var(--sp-cool-veil)] bg-[var(--sp-warm-white)] px-4 py-3 flex flex-col sm:flex-row sm:items-center justify-between gap-3">
                    <div className="flex items-start gap-2">
                      <AlertTriangle className="h-4 w-4 text-[var(--sp-racing-deep)] shrink-0 mt-0.5" />
                      <p className="text-xs text-[var(--sp-charcoal)] leading-relaxed">
                        <strong className="text-[var(--sp-racing-deep)]">{emptySeriesCount}</strong> In SG Fleet
                        sailor(s) have no silver/gold entry date — they are not ranked.
                        Stamp today&apos;s date as Silver entry (SG) to include them.
                      </p>
                    </div>
                    <button
                      type="button"
                      disabled={!isSuperadmin}
                      onClick={() => void onCleanupEmptySeries()}
                      className="shrink-0 rounded-full bg-amber-600 hover:bg-amber-700 disabled:opacity-40 px-4 py-2 text-xs font-bold text-white"
                    >
                      Stamp silver entry for empty Series
                    </button>
                  </div>
                )}
                {onBackfillNationalityFromSail && (
                  <div className="rounded-2xl border border-[var(--sp-cool-veil)] bg-[var(--sp-warm-white)] px-4 py-3 flex flex-col sm:flex-row sm:items-center justify-between gap-3">
                    <div className="flex items-start gap-2">
                      <AlertTriangle className="h-4 w-4 text-[var(--sp-harbour-teal)] shrink-0 mt-0.5" />
                      <p className="text-xs text-[var(--sp-charcoal)] leading-relaxed">
                        Sailors with a country code on their sail # (e.g.{" "}
                        <span className="font-mono font-semibold text-[var(--sp-harbour-teal)]">SGP 115</span>) but no
                        nationality can be tagged automatically. Flagged rows show{" "}
                        <span className="font-semibold text-[var(--sp-racing-deep)]">from sail</span>{" "}
                        — verify and set nationality manually to clear the flag.
                        Import nationality columns always win (latest regatta).
                      </p>
                    </div>
                    <button
                      type="button"
                      disabled={!isSuperadmin}
                      onClick={() => void onBackfillNationalityFromSail()}
                      className="shrink-0 rounded-full bg-[var(--sp-harbour-teal)] hover:bg-[var(--sp-harbour-shadow)] disabled:opacity-40 px-4 py-2 text-xs font-bold text-white"
                    >
                      Fill nationality from sail #
                    </button>
                  </div>
                )}
                {onUpdateOptimistSailNumbers && (
                  <div className="rounded-2xl border border-[var(--sp-cool-veil)] bg-[var(--sp-warm-white)] px-4 py-3 flex flex-col sm:flex-row sm:items-center justify-between gap-3">
                    <div className="flex items-start gap-2">
                      <CheckCircle className="h-4 w-4 text-[var(--sp-harbour-teal)] shrink-0 mt-0.5" />
                      <p className="text-xs text-[var(--sp-charcoal)] leading-relaxed">
                        Official Optimist Ranking Sync: Update missing or placeholder (0 / SGP 0)
                        sail numbers for 134 Optimist sailors based on the official ranking list.
                      </p>
                    </div>
                    <button
                      type="button"
                      disabled={!isSuperadmin}
                      onClick={() => void onUpdateOptimistSailNumbers()}
                      className="shrink-0 rounded-full bg-[var(--sp-harbour-teal)] hover:bg-[var(--sp-harbour-shadow)] disabled:opacity-40 px-4 py-2 text-xs font-bold text-white"
                    >
                      Update 134 Optimist Sail #s
                    </button>
                  </div>
                )}
                {onCleanOptimistSailNumbers && (
                  <div className="rounded-2xl border border-[var(--sp-cool-veil)] bg-[var(--sp-warm-white)] px-4 py-3 flex flex-col sm:flex-row sm:items-center justify-between gap-3">
                    <div className="flex items-start gap-2">
                      <CheckCircle className="h-4 w-4 text-[var(--sp-harbour-teal)] shrink-0 mt-0.5" />
                      <p className="text-xs text-[var(--sp-charcoal)] leading-relaxed">
                        Numeric Optimist Sail #s: Ensure all Optimist sail numbers contain only digits (e.g.{" "}
                        <span className="font-mono font-semibold text-[var(--sp-harbour-teal)]">SGP3029 → 3029</span>) and extract
                        missing nationality from country prefixes.
                      </p>
                    </div>
                    <button
                      type="button"
                      disabled={!isSuperadmin}
                      onClick={() => void onCleanOptimistSailNumbers()}
                      className="shrink-0 rounded-full bg-[var(--sp-harbour-teal)] hover:bg-[var(--sp-harbour-shadow)] disabled:opacity-40 px-4 py-2 text-xs font-bold text-white"
                    >
                      Clean Sail Numbers (Digits Only)
                    </button>
                  </div>
                )}
                {/* Filters */}
                <div className="rounded-2xl border border-[var(--sp-cool-veil)] bg-[var(--sp-warm-white)] p-4 grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-3 shadow-xs">
                  <div>
                    <label className="text-[10px] font-bold text-[var(--sp-charcoal)] uppercase tracking-wider">Search</label>
                    <input
                      type="search"
                      placeholder="Name, sail #, club, school…"
                      value={dbSearch}
                      onChange={(e) => setDbSearch(e.target.value)}
                      className="mt-1 w-full rounded-xl border border-[var(--sp-cool-veil)] bg-white px-3 py-2 text-xs text-[var(--sp-charcoal)] focus:border-[var(--sp-harbour-teal)] focus:ring-1 focus:ring-[var(--sp-harbour-teal)] shadow-2xs"
                    />
                  </div>
                  <div>
                    <label className="text-[10px] font-bold text-[var(--sp-charcoal)] uppercase tracking-wider">
                      Class / Series
                    </label>
                    <select
                      value={dbFleetFilter}
                      onChange={(e) => setDbFleetFilter(e.target.value)}
                      className="mt-1 w-full rounded-xl border border-[var(--sp-cool-veil)] bg-white px-3 py-2 text-xs text-[var(--sp-charcoal)] focus:border-[var(--sp-harbour-teal)] focus:ring-1 focus:ring-[var(--sp-harbour-teal)] shadow-2xs"
                    >
                      <option value="all">All sailors</option>
                      <option value="series">Optimist · In SG Fleet</option>
                      <option value="guest">Optimist · Guest</option>
                      <option value="gold">Optimist · Has Gold entry</option>
                      <option value="silver">Optimist · Series · no Gold</option>
                      <option value="ilca4">ILCA 4 (sail # or national list)</option>
                      <option value="dual">Dual-class (Opti + ILCA 4)</option>
                    </select>
                  </div>
                  <div>
                    <label className="text-[10px] font-bold text-[var(--sp-charcoal)] uppercase tracking-wider">Squad Jul 26</label>
                    <select
                      value={dbSquadFilter}
                      onChange={(e) => setDbSquadFilter(e.target.value)}
                      className="mt-1 w-full rounded-xl border border-[var(--sp-cool-veil)] bg-white px-3 py-2 text-xs text-[var(--sp-charcoal)] focus:border-[var(--sp-harbour-teal)] focus:ring-1 focus:ring-[var(--sp-harbour-teal)] shadow-2xs"
                    >
                      <option value="all">All squads</option>
                      <option value="Nat A">Nat A</option>
                      <option value="Nat B">Nat B</option>
                      <option value="DS">DS</option>
                    </select>
                  </div>
                  <p className="sm:col-span-2 lg:col-span-4 text-[11px] text-[var(--sp-slate-soft)]">
                    Showing <strong className="text-[var(--sp-charcoal)]">{filteredDbSailors.length}</strong> of{" "}
                    {sailorList.length} sailors
                    {selectedSailors.length > 0 && (
                      <>
                        {" "}
                        · <strong className="text-[var(--sp-racing-orange)]">{selectedSailors.length}</strong> selected
                        for bulk edit
                      </>
                    )}
                  </p>
                </div>

                {/* Duplicate finder — always available; bulk tip only when nothing selected */}
                <div className="flex flex-wrap items-center justify-between gap-2">
                  {selectedSailors.length === 0 ? (
                    <p className="text-[11px] text-slate-500">
                      Tick rows to open bulk edit, merge, or delete.
                    </p>
                  ) : (
                    <p className="text-[11px] text-slate-500">
                      Bulk toolbar is open above the table.
                    </p>
                  )}
                  <button
                    type="button"
                    onClick={() => setShowDuplicateFinder((v) => !v)}
                    className="rounded-full border border-[var(--sp-cool-veil)] bg-white px-3 py-1.5 text-[11px] font-bold text-[var(--sp-slate)] hover:text-[var(--sp-charcoal)] flex items-center gap-1.5"
                  >
                    <Copy className="h-3.5 w-3.5 text-orange-500" />
                    Find similar names
                    {duplicatePairs.length > 0 && (
                      <span className="rounded-full bg-orange-100 border border-orange-200 text-orange-800 px-1.5 py-0.5 text-[10px]">
                        {duplicatePairs.length}
                      </span>
                    )}
                  </button>
                </div>

                {/* Bulk edit toolbar — only when at least one row is selected */}
                {selectedSailors.length > 0 && (
                <div className="rounded-2xl border border-orange-200 bg-orange-50/40 p-4 space-y-3">
                  <div className="flex items-center gap-2">
                    <Grid className="h-4 w-4 text-orange-600" />
                    <h3 className="text-sm font-bold text-[var(--sp-charcoal)]">
                      Bulk edit · {selectedSailors.length} selected
                    </h3>
                  </div>
                  <p className="text-[11px] text-[var(--sp-slate)]">
                    Choose a property and value, then apply. Use Columns to show historical /
                    overseas fields in the same overview.
                  </p>
                  <div className="flex flex-wrap items-end gap-4">
                    <div className="flex flex-col gap-1 min-w-[180px]">
                      <label className="text-[10px] font-bold text-[var(--sp-slate)] uppercase">Property</label>
                      <select
                        value={bulkField}
                        onChange={(e) => {
                          setBulkField(e.target.value);
                          setBulkValue("");
                        }}
                        className="rounded-lg bg-white border border-[var(--sp-cool-veil)] text-[var(--sp-charcoal)] px-3 py-2 text-xs"
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
                          <option value="sailNumber">Optimist sail #</option>
                          <option value="gender">Gender (M/F)</option>
                          <option value="dob">Date of Birth</option>
                          <option value="weight">Weight (kg)</option>
                        </optgroup>
                        <optgroup label="ILCA 4">
                          <option value="sailNumberIlca4">ILCA 4 sail #</option>
                          <option value="ilca4NationalList">
                            ILCA 4 national list (true/false)
                          </option>
                        </optgroup>
                        <optgroup label="Squad history">
                          <option value="natSquadStatusJan25">Squad Jan 25</option>
                          <option value="natSquadStatusJul25">Squad Jul 25</option>
                          <option value="natSquadStatusJan26">Squad Jan 26</option>
                          <option value="natSquadStatusJul26">Squad Jul 26</option>
                          <option value="natSquadStatusJan27">Squad Jan 27</option>
                          <option value="natSquadStatusJul27">Squad Jul 27</option>
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
                      <label className="text-[10px] font-bold text-[var(--sp-slate)] uppercase">Value</label>
                      {bulkField === "goldEntryDate" || bulkField === "dropDate" ? (
                        <select
                          value={bulkValue}
                          onChange={(e) => setBulkValue(e.target.value)}
                          className="rounded-lg bg-white border border-[var(--sp-cool-veil)] text-[var(--sp-charcoal)] px-3 py-2 text-xs"
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
                          className="rounded-lg bg-white border border-[var(--sp-cool-veil)] text-[var(--sp-charcoal)] px-3 py-2 text-xs"
                        />
                      ) : bulkField === "gender" ? (
                        <select
                          value={bulkValue}
                          onChange={(e) => setBulkValue(e.target.value)}
                          className="rounded-lg bg-white border border-[var(--sp-cool-veil)] text-[var(--sp-charcoal)] px-3 py-2 text-xs"
                        >
                          <option value="">—</option>
                          <option value="M">M</option>
                          <option value="F">F</option>
                        </select>
                      ) : bulkField === "currentFleet" ? (
                        <select
                          value={bulkValue}
                          onChange={(e) => setBulkValue(e.target.value)}
                          className="rounded-lg bg-white border border-[var(--sp-cool-veil)] text-[var(--sp-charcoal)] px-3 py-2 text-xs"
                        >
                          <option value="Guest">Guest</option>
                          <option value="Series">In SG Fleet</option>
                        </select>
                      ) : bulkField === "ilca4NationalList" ? (
                        <select
                          value={bulkValue}
                          onChange={(e) => setBulkValue(e.target.value)}
                          className="rounded-lg bg-white border border-[var(--sp-cool-veil)] text-[var(--sp-charcoal)] px-3 py-2 text-xs"
                        >
                          <option value="true">On list (true)</option>
                          <option value="false">Off list (false)</option>
                        </select>
                      ) : [
                          "natSquadStatusJan25",
                          "natSquadStatusJul25",
                          "natSquadStatusJan26",
                          "natSquadStatusJul26",
                          "natSquadStatusJan27",
                          "natSquadStatusJul27",
                        ].includes(bulkField) ? (
                        <select
                          value={bulkValue}
                          onChange={(e) => setBulkValue(e.target.value)}
                          className="rounded-lg bg-white border border-[var(--sp-cool-veil)] text-[var(--sp-charcoal)] px-3 py-2 text-xs"
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
                          className="rounded-lg bg-white border border-[var(--sp-cool-veil)] text-[var(--sp-charcoal)] px-3 py-2 text-xs font-mono"
                          placeholder="Number"
                        />
                      ) : bulkField === "nationality" ? (
                        <NationalitySelect
                          value={bulkValue}
                          onChange={setBulkValue}
                          className="rounded-lg bg-white border border-[var(--sp-cool-veil)] text-[var(--sp-charcoal)] px-3 py-2 text-xs"
                          emptyLabel="— Clear / select —"
                        />
                      ) : (
                        <input
                          type="text"
                          value={bulkValue}
                          onChange={(e) => setBulkValue(e.target.value)}
                          disabled={!bulkField}
                          className="rounded-lg bg-white border border-[var(--sp-cool-veil)] text-[var(--sp-charcoal)] px-3 py-2 text-xs disabled:opacity-40"
                          placeholder={bulkField ? "Value" : "Select property first"}
                        />
                      )}
                    </div>
                    <button
                      type="button"
                      disabled={!isSuperadmin || saving || selectedSailors.length === 0 || !bulkField}
                      onClick={handleApplyBulk}
                      className="rounded-full bg-orange-600 px-5 py-2 text-xs font-bold text-white hover:bg-orange-500 disabled:opacity-40 flex items-center gap-1.5 shadow-sm"
                    >
                      <Save className="h-4 w-4" />
                      Apply to {selectedSailors.length || 0}
                    </button>
                    <button
                      type="button"
                      disabled={!isSuperadmin || saving || selectedSailors.length !== 2}
                      onClick={handleMergeSailors}
                      title="Select exactly 2 sailors to merge duplicates"
                      className="rounded-full bg-emerald-600 px-4 py-2 text-xs font-bold text-white hover:bg-emerald-500 disabled:opacity-40 flex items-center gap-1.5 shadow-sm"
                    >
                      <UserCheck className="h-4 w-4" />
                      Merge 2 selected
                      {selectedSailors.length === 2 ? "" : ` (${selectedSailors.length}/2)`}
                    </button>
                    <button
                      type="button"
                      disabled={!isSuperadmin || saving || selectedSailors.length === 0}
                      onClick={handleBulkDelete}
                      className="rounded-full bg-rose-600 px-4 py-2 text-xs font-bold text-white hover:bg-rose-500 disabled:opacity-40 flex items-center gap-1.5 shadow-sm"
                    >
                      <Trash2 className="h-4 w-4" />
                      Delete selected
                    </button>
                  </div>
                  <p className="text-[10px] text-[var(--sp-muted)]">
                    <strong className="text-[var(--sp-slate)]">Merge:</strong> tick exactly two rows →{" "}
                    <strong className="text-emerald-700">Merge 2 selected</strong>. The more
                    complete profile is kept; results/aliases move over.
                  </p>
                </div>
                )}

                  {showDuplicateFinder && (
                    <div className="rounded-xl border border-[var(--sp-cool-veil)] bg-[var(--sp-sailcloth)]/50 p-4 space-y-3">
                      <div className="flex items-start justify-between gap-3">
                        <div>
                          <h4 className="text-xs font-bold text-[var(--sp-charcoal)] uppercase tracking-wider">
                            Possible duplicate sailors
                          </h4>
                          <p className="text-[11px] text-[var(--sp-slate)] mt-1">
                            Shows pairs with ≥60% match (jumbled names, partial names, same sail #).
                            <span className="text-rose-700 font-semibold"> High ≥80%</span>
                            {" · "}
                            <span className="text-amber-700 font-semibold">Medium 60–79%</span>
                            . Select both → Merge 2 selected.
                          </p>
                        </div>
                        <button
                          type="button"
                          onClick={() => setShowDuplicateFinder(false)}
                          className="text-[11px] font-bold text-[var(--sp-slate)] hover:text-[var(--sp-charcoal)]"
                        >
                          Hide
                        </button>
                      </div>
                      {duplicatePairs.length === 0 ? (
                        <p className="text-xs text-[var(--sp-muted)] py-4 text-center">
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
                                    ? "border-rose-200 bg-rose-50/60"
                                    : "border-amber-200 bg-amber-50/60"
                                }`}
                              >
                                <div className="min-w-0">
                                  <div className="flex flex-wrap items-center gap-2 mb-1">
                                    <span
                                      className={`rounded-full px-2 py-0.5 text-[10px] font-bold border ${
                                        high
                                          ? "bg-rose-100 text-rose-800 border-rose-300"
                                          : "bg-amber-100 text-amber-800 border-amber-300"
                                      }`}
                                    >
                                      {pct}% · {high ? "High" : "Medium"}
                                    </span>
                                    <span className="text-[10px] text-[var(--sp-muted)]">
                                      {p.how}
                                    </span>
                                  </div>
                                  <p className="text-[var(--sp-charcoal)] font-semibold truncate">
                                    {p.a.name}
                                    <span className="text-[var(--sp-slate)] font-mono text-[10px] ml-2">
                                      {p.a.sailNumber || "—"}
                                    </span>
                                  </p>
                                  <p className="text-[var(--sp-charcoal)] font-semibold truncate">
                                    {p.b.name}
                                    <span className="text-[var(--sp-slate)] font-mono text-[10px] ml-2">
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
                                    className="rounded-full bg-emerald-600 hover:bg-emerald-700 px-3 py-1.5 text-[10px] font-bold text-white shadow-sm"
                                  >
                                    Select pair
                                  </button>
                                  <button
                                    type="button"
                                    onClick={() =>
                                      ignoreDuplicatePair(p.a.id, p.b.id)
                                    }
                                    className="rounded-full border border-[var(--sp-cool-veil)] bg-white px-3 py-1.5 text-[10px] font-bold text-[var(--sp-slate)] hover:text-[var(--sp-charcoal)]"
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
                    <div className="flex items-center gap-2 text-xs font-bold text-emerald-700">
                      <CheckCircle className="h-4 w-4" />
                      {bulkStatus}
                    </div>
                  )}

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
                      className="relative z-10 w-full sm:max-w-3xl max-h-[92vh] overflow-y-auto rounded-t-3xl sm:rounded-3xl border border-[var(--sp-cool-veil)] bg-[var(--sp-warm-white)] shadow-2xl p-5 sm:p-6 space-y-4"
                    >
                    <div className="flex flex-wrap items-center justify-between gap-3 sticky top-0 bg-[var(--sp-warm-white)] pb-3 z-10 border-b border-[var(--sp-cool-veil)]">
                      <div>
                        <h3 className="text-sm font-bold text-[var(--sp-charcoal)] uppercase tracking-wider">
                          {editingSailorId === "new" ? "Add New Sailor Profile" : "Edit Sailor Profile"}
                        </h3>
                        <span className="block text-[11px] font-semibold text-[var(--sp-slate-soft)] normal-case tracking-normal mt-0.5">
                          {editingSailorId !== "new" ? sailorForm.name || "" : "Fill in details and save"}
                        </span>
                      </div>
                      {editingSailorId !== "new" && (
                        <button
                          type="button"
                          onClick={() => {
                            setEditingSailorId(null);
                            void openSailorResults(editingSailorId);
                          }}
                          className="inline-flex items-center gap-1.5 px-3 py-1.5 rounded-xl bg-orange-50 hover:bg-orange-100 text-orange-900 border border-orange-300 text-xs font-semibold shadow-2xs transition-colors"
                        >
                          <Medal className="w-3.5 h-3.5" />
                          <span>View Regatta History & Results</span>
                        </button>
                      )}
                    </div>
                    <div className="grid grid-cols-1 md:grid-cols-3 gap-4">
                      <div className="md:col-span-2">
                        <label className="text-[10px] font-bold text-[var(--sp-charcoal)] uppercase tracking-wider">Full Name</label>
                        <input
                          type="text"
                          value={sailorForm.name}
                          onChange={(e) => setSailorForm({ ...sailorForm, name: e.target.value })}
                          className="mt-1 w-full rounded-xl border border-[var(--sp-cool-veil)] bg-white px-3 py-2 text-[var(--sp-charcoal)] text-xs focus:border-[var(--sp-harbour-teal)] focus:ring-1 focus:ring-[var(--sp-harbour-teal)] shadow-2xs"
                        />
                      </div>
                      <div>
                        <label className="text-[10px] font-bold text-[var(--sp-charcoal)] uppercase tracking-wider">
                          Optimist sail #
                        </label>
                        <input
                          type="text"
                          value={sailorForm.sailNumber}
                          onChange={(e) => setSailorForm({ ...sailorForm, sailNumber: e.target.value })}
                          className="mt-1 w-full rounded-xl border border-[var(--sp-cool-veil)] bg-white px-3 py-2 text-[var(--sp-charcoal)] text-xs font-mono focus:border-[var(--sp-harbour-teal)] focus:ring-1 focus:ring-[var(--sp-harbour-teal)] shadow-2xs"
                        />
                      </div>
                      <div>
                        <label className="text-[10px] font-bold text-[var(--sp-charcoal)] uppercase tracking-wider">
                          ILCA 4 sail #
                        </label>
                        <input
                          type="text"
                          value={sailorForm.sailNumberIlca4 || ""}
                          onChange={(e) =>
                            setSailorForm({
                              ...sailorForm,
                              sailNumberIlca4: e.target.value,
                            })
                          }
                          className="mt-1 w-full rounded-xl border border-[var(--sp-cool-veil)] bg-white px-3 py-2 text-[var(--sp-charcoal)] text-xs font-mono focus:border-[var(--sp-harbour-teal)] focus:ring-1 focus:ring-[var(--sp-harbour-teal)] shadow-2xs"
                          placeholder="e.g. SGP 2115"
                        />
                      </div>
                      <div>
                        <label className="text-[10px] font-bold text-[var(--sp-charcoal)] uppercase tracking-wider">Club</label>
                        <input
                          type="text"
                          value={sailorForm.club}
                          onChange={(e) => setSailorForm({ ...sailorForm, club: e.target.value })}
                          className="mt-1 w-full rounded-xl border border-[var(--sp-cool-veil)] bg-white px-3 py-2 text-[var(--sp-charcoal)] text-xs focus:border-[var(--sp-harbour-teal)] focus:ring-1 focus:ring-[var(--sp-harbour-teal)] shadow-2xs"
                        />
                      </div>
                      <div>
                        <label className="text-[10px] font-bold text-[var(--sp-charcoal)] uppercase tracking-wider">School</label>
                        <input
                          type="text"
                          value={sailorForm.school || ""}
                          onChange={(e) =>
                            setSailorForm({ ...sailorForm, school: e.target.value })
                          }
                          className="mt-1 w-full rounded-xl border border-[var(--sp-cool-veil)] bg-white px-3 py-2 text-[var(--sp-charcoal)] text-xs focus:border-[var(--sp-harbour-teal)] focus:ring-1 focus:ring-[var(--sp-harbour-teal)] shadow-2xs"
                          placeholder="e.g. Raffles Institution"
                        />
                      </div>
                      <div>
                        <label className="text-[10px] font-bold text-[var(--sp-charcoal)] uppercase tracking-wider">Nationality</label>
                        <NationalitySelect
                          value={sailorForm.nationality || ""}
                          onChange={(v) =>
                            setSailorForm({ ...sailorForm, nationality: v })
                          }
                        />
                      </div>
                      <div>
                        <label className="text-[10px] font-bold text-[var(--sp-charcoal)] uppercase tracking-wider">Gender (M/F)</label>
                        <select
                          value={sailorForm.gender || ""}
                          onChange={(e) => setSailorForm({ ...sailorForm, gender: e.target.value })}
                          className="mt-1 w-full rounded-xl border border-[var(--sp-cool-veil)] bg-white px-3 py-2 text-[var(--sp-charcoal)] text-xs focus:border-[var(--sp-harbour-teal)] focus:ring-1 focus:ring-[var(--sp-harbour-teal)] shadow-2xs"
                        >
                          <option value="">Unknown</option>
                          <option value="M">Male (M)</option>
                          <option value="F">Female (F)</option>
                        </select>
                      </div>
                      <div className="md:col-span-3 grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-4 border-t border-[var(--sp-cool-veil)] pt-4">
                        <p className="sm:col-span-2 lg:col-span-4 text-[10px] font-bold text-[var(--sp-charcoal)] uppercase tracking-wider">
                          Nat squad by period (fixed for the whole half-year)
                        </p>
                        {(
                          [
                            ["natSquadStatusJan25", "Jan – Jun 2025"],
                            ["natSquadStatusJul25", "Jul – Dec 2025"],
                            ["natSquadStatusJan26", "Jan – Jun 2026"],
                            ["natSquadStatusJul26", "Jul – Dec 2026"],
                            ["natSquadStatusJan27", "Jan – Jun 2027 (next)"],
                            ["natSquadStatusJul27", "Jul – Dec 2027"],
                          ] as const
                        ).map(([key, label]) => (
                          <div key={key}>
                            <label className="text-[10px] font-bold text-[var(--sp-slate-soft)] uppercase tracking-wider">
                              {label}
                            </label>
                            <select
                              value={((sailorForm as Record<string, unknown>)[key] as string) || ""}
                              onChange={(e) => {
                                const v = e.target.value;
                                setSailorForm({
                                  ...sailorForm,
                                  [key]: v,
                                  // Keep legacy “current squad” in sync with latest half fields
                                  ...(key === "natSquadStatusJan27" ||
                                  key === "natSquadStatusJul27" ||
                                  key === "natSquadStatusJul26"
                                    ? { nationalSquadStatus: v }
                                    : {}),
                                });
                              }}
                              className="mt-1 w-full rounded-xl border border-[var(--sp-cool-veil)] bg-white px-3 py-2 text-[var(--sp-charcoal)] text-xs focus:border-[var(--sp-harbour-teal)] focus:ring-1 focus:ring-[var(--sp-harbour-teal)] shadow-2xs"
                            >
                              <option value="">None</option>
                              <option value="Nat A">National A (Nat A)</option>
                              <option value="Nat B">National B (Nat B)</option>
                              <option value="DS">Development Squad (DS)</option>
                            </select>
                          </div>
                        ))}
                        <p className="sm:col-span-2 lg:col-span-4 text-[10px] text-[var(--sp-slate-soft)] leading-relaxed">
                          Rankings boards show the squad for the period selected.
                          Jul–Dec 2026 also updates the live “current squad” field.
                          History is visible on Gold register and each sailor profile.
                        </p>
                      </div>
                      <div>
                        <label className="text-[10px] font-bold text-[var(--sp-charcoal)] uppercase tracking-wider">DOB (YYYY-MM-DD)</label>
                        <input
                          type="date"
                          value={sailorForm.dob || ""}
                          onChange={(e) => setSailorForm({ ...sailorForm, dob: e.target.value })}
                          className="mt-1 w-full rounded-xl border border-[var(--sp-cool-veil)] bg-white px-3 py-2 text-[var(--sp-charcoal)] text-xs font-mono focus:border-[var(--sp-harbour-teal)] focus:ring-1 focus:ring-[var(--sp-harbour-teal)] shadow-2xs"
                        />
                      </div>
                      <div>
                        <label className="text-[10px] font-bold text-[var(--sp-charcoal)] uppercase tracking-wider">Weight (kg)</label>
                        <input
                          type="number"
                          value={sailorForm.weight ?? ""}
                          onChange={(e) => setSailorForm({ ...sailorForm, weight: e.target.value })}
                          className="mt-1 w-full rounded-xl border border-[var(--sp-cool-veil)] bg-white px-3 py-2 text-[var(--sp-charcoal)] text-xs font-mono focus:border-[var(--sp-harbour-teal)] focus:ring-1 focus:ring-[var(--sp-harbour-teal)] shadow-2xs"
                        />
                      </div>
                      <div>
                        <label className="text-[10px] font-bold text-[var(--sp-charcoal)] uppercase tracking-wider">Handle (URL Parameter)</label>
                        <input
                          type="text"
                          value={sailorForm.handle}
                          onChange={(e) => setSailorForm({ ...sailorForm, handle: e.target.value })}
                          className="mt-1 w-full rounded-xl border border-[var(--sp-cool-veil)] bg-white px-3 py-2 text-[var(--sp-charcoal)] text-xs font-mono focus:border-[var(--sp-harbour-teal)] focus:ring-1 focus:ring-[var(--sp-harbour-teal)] shadow-2xs"
                          placeholder="e.g. ashlyn-t"
                        />
                      </div>
                      <div>
                        <label className="text-[10px] font-bold text-[var(--sp-charcoal)] uppercase tracking-wider">Instagram Handle</label>
                        <input
                          type="text"
                          value={sailorForm.instagram || ""}
                          onChange={(e) => setSailorForm({ ...sailorForm, instagram: e.target.value })}
                          className="mt-1 w-full rounded-xl border border-[var(--sp-cool-veil)] bg-white px-3 py-2 text-[var(--sp-charcoal)] text-xs font-mono focus:border-[var(--sp-harbour-teal)] focus:ring-1 focus:ring-[var(--sp-harbour-teal)] shadow-2xs"
                          placeholder="e.g. @username"
                        />
                      </div>
                      <div>
                        <label className="text-[10px] font-bold text-[var(--sp-charcoal)] uppercase tracking-wider">Avatar URL</label>
                        <input
                          type="url"
                          value={sailorForm.avatarUrl || ""}
                          onChange={(e) => setSailorForm({ ...sailorForm, avatarUrl: e.target.value })}
                          className="mt-1 w-full rounded-xl border border-[var(--sp-cool-veil)] bg-white px-3 py-2 text-[var(--sp-charcoal)] text-xs font-mono focus:border-[var(--sp-harbour-teal)] focus:ring-1 focus:ring-[var(--sp-harbour-teal)] shadow-2xs"
                          placeholder="https://… (public image URL)"
                        />
                      </div>
                      <div className="md:col-span-3 grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-4 border-t border-[var(--sp-cool-veil)] pt-4">
                        <p className="sm:col-span-2 lg:col-span-4 text-[10px] font-bold text-[var(--sp-charcoal)] uppercase tracking-wider">
                          Overseas Representation — multiple years allowed (e.g. 2023, 2025)
                        </p>
                        <div>
                          <label className="text-[10px] font-bold text-[var(--sp-slate-soft)] uppercase tracking-wider">Worlds years</label>
                          <input
                            type="text"
                            value={sailorForm.worlds || ""}
                            onChange={(e) => setSailorForm({ ...sailorForm, worlds: e.target.value })}
                            className="mt-1 w-full rounded-xl border border-[var(--sp-cool-veil)] bg-white px-3 py-2 text-[var(--sp-charcoal)] text-xs font-mono focus:border-[var(--sp-harbour-teal)] focus:ring-1 focus:ring-[var(--sp-harbour-teal)] shadow-2xs"
                            placeholder="2023, 2025"
                          />
                        </div>
                        <div>
                          <label className="text-[10px] font-bold text-[var(--sp-slate-soft)] uppercase tracking-wider">European years</label>
                          <input
                            type="text"
                            value={sailorForm.european || ""}
                            onChange={(e) => setSailorForm({ ...sailorForm, european: e.target.value })}
                            className="mt-1 w-full rounded-xl border border-[var(--sp-cool-veil)] bg-white px-3 py-2 text-[var(--sp-charcoal)] text-xs font-mono focus:border-[var(--sp-harbour-teal)] focus:ring-1 focus:ring-[var(--sp-harbour-teal)] shadow-2xs"
                            placeholder="2024"
                          />
                        </div>
                        <div>
                          <label className="text-[10px] font-bold text-[var(--sp-slate-soft)] uppercase tracking-wider">Asian years</label>
                          <input
                            type="text"
                            value={sailorForm.asian || ""}
                            onChange={(e) => setSailorForm({ ...sailorForm, asian: e.target.value })}
                            className="mt-1 w-full rounded-xl border border-[var(--sp-cool-veil)] bg-white px-3 py-2 text-[var(--sp-charcoal)] text-xs font-mono focus:border-[var(--sp-harbour-teal)] focus:ring-1 focus:ring-[var(--sp-harbour-teal)] shadow-2xs"
                            placeholder="2022, 2024"
                          />
                        </div>
                        <div>
                          <label className="text-[10px] font-bold text-[var(--sp-slate-soft)] uppercase tracking-wider">SEA Games years</label>
                          <input
                            type="text"
                            value={sailorForm.seaGames || ""}
                            onChange={(e) => setSailorForm({ ...sailorForm, seaGames: e.target.value })}
                            className="mt-1 w-full rounded-xl border border-[var(--sp-cool-veil)] bg-white px-3 py-2 text-[var(--sp-charcoal)] text-xs font-mono focus:border-[var(--sp-harbour-teal)] focus:ring-1 focus:ring-[var(--sp-harbour-teal)] shadow-2xs"
                            placeholder="2023"
                          />
                        </div>
                      </div>
                      <div>
                        <label className="text-[10px] font-bold text-[var(--sp-charcoal)] uppercase tracking-wider">Biography</label>
                        <textarea
                          value={sailorForm.bio || ""}
                          onChange={(e) => setSailorForm({ ...sailorForm, bio: e.target.value })}
                          className="mt-1 w-full rounded-xl border border-[var(--sp-cool-veil)] bg-white px-3 py-2 text-[var(--sp-charcoal)] text-xs h-10 focus:border-[var(--sp-harbour-teal)] focus:ring-1 focus:ring-[var(--sp-harbour-teal)] shadow-2xs"
                        />
                      </div>
                      <div>
                        <label className="text-[10px] font-bold text-[var(--sp-charcoal)] uppercase tracking-wider">
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
                            const next: SailorFormState = {
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
                          className="mt-1 w-full rounded-xl border border-[var(--sp-cool-veil)] bg-white px-3 py-2 text-[var(--sp-charcoal)] text-xs focus:border-[var(--sp-harbour-teal)] focus:ring-1 focus:ring-[var(--sp-harbour-teal)] shadow-2xs"
                        >
                          <option value="Guest">Guest (not ranked)</option>
                          <option value="Series">In SG Fleet</option>
                        </select>
                        <p className="mt-1 text-[10px] text-[var(--sp-slate-soft)] leading-snug">
                          Guest = never ranked. In SG Fleet needs a Silver or
                          Gold entry date to appear on boards (empty Series is
                          not ranked). Silver until Gold entry, then Gold until
                          Drop. Gold entry & drop: 1 Jan / 1 Jul from 2022 only.
                        </p>
                      </div>
                      <div>
                        <label className="text-[10px] font-bold text-[var(--sp-charcoal)] uppercase tracking-wider">Gold Fleet Entry Date</label>
                        <select
                          value={sailorForm.goldEntryDate || ""}
                          onChange={(e) =>
                            setSailorForm({
                              ...sailorForm,
                              goldEntryDate: e.target.value,
                            })
                          }
                          className="mt-1 w-full rounded-xl border border-[var(--sp-cool-veil)] bg-white px-3 py-2 text-[var(--sp-charcoal)] text-xs font-mono focus:border-[var(--sp-harbour-teal)] focus:ring-1 focus:ring-[var(--sp-harbour-teal)] shadow-2xs"
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
                        <p className="mt-1 text-[10px] text-[var(--sp-slate-soft)]">
                          Only 1 Jan or 1 Jul — applies for the whole half-year.
                        </p>
                      </div>
                      <div>
                        <label className="text-[10px] font-bold text-[var(--sp-charcoal)] uppercase tracking-wider">Silver Fleet Entry Date</label>
                        <input
                          type="date"
                          value={sailorForm.silverEntryDate || ""}
                          onChange={(e) => setSailorForm({ ...sailorForm, silverEntryDate: e.target.value })}
                          className="mt-1 w-full rounded-xl border border-[var(--sp-cool-veil)] bg-white px-3 py-2 text-[var(--sp-charcoal)] text-xs font-mono focus:border-[var(--sp-harbour-teal)] focus:ring-1 focus:ring-[var(--sp-harbour-teal)] shadow-2xs"
                        />
                      </div>
                      <div>
                        <label className="text-[10px] font-bold text-[var(--sp-charcoal)] uppercase tracking-wider">Optimist Drop Date</label>
                        <select
                          value={sailorForm.dropDate || ""}
                          onChange={(e) =>
                            setSailorForm({
                              ...sailorForm,
                              dropDate: e.target.value,
                            })
                          }
                          className="mt-1 w-full rounded-xl border border-[var(--sp-cool-veil)] bg-white px-3 py-2 text-[var(--sp-charcoal)] text-xs font-mono focus:border-[var(--sp-harbour-teal)] focus:ring-1 focus:ring-[var(--sp-harbour-teal)] shadow-2xs"
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
                        <p className="mt-1 text-[10px] text-[var(--sp-slate-soft)]">
                          Only 1 Jan or 1 Jul. Drop on that day removes the
                          sailor from that half and later.
                        </p>
                      </div>
                      <div className="md:col-span-3 grid grid-cols-2 sm:grid-cols-3 lg:grid-cols-5 gap-3 border-t border-[var(--sp-cool-veil)] pt-4">
                        <p className="col-span-2 sm:col-span-3 lg:col-span-5 text-[10px] font-bold text-[var(--sp-charcoal)] uppercase tracking-wider">
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
                            <label className="text-[10px] font-bold text-[var(--sp-slate-soft)] uppercase tracking-wider">
                              {label}
                            </label>
                            <input
                              type="number"
                              min={1}
                              value={((sailorForm as Record<string, unknown>)[key] as string) ?? ""}
                              onChange={(e) =>
                                setSailorForm({
                                  ...sailorForm,
                                  [key]: e.target.value,
                                })
                              }
                              className="mt-1 w-full rounded-xl border border-[var(--sp-cool-veil)] bg-white px-3 py-2 text-[var(--sp-charcoal)] text-xs font-mono focus:border-[var(--sp-harbour-teal)] focus:ring-1 focus:ring-[var(--sp-harbour-teal)] shadow-2xs"
                              placeholder="—"
                            />
                          </div>
                        ))}
                      </div>

                      {/* Milestones & Sailing Journey Highlights */}
                      <div className="md:col-span-3 border-t border-[var(--sp-cool-veil)] pt-4 space-y-2">
                        <p className="text-[10px] font-bold text-[var(--sp-charcoal)] uppercase tracking-wider">
                          Career Milestones &amp; Sailing Journey Highlights
                        </p>
                        <p className="text-[11px] text-[var(--sp-slate-soft)]">
                          Key moments, breakthroughs, and campaigns displayed on the sailor profile timeline.
                        </p>
                        <AdminMilestonesEditor
                          journeyRaw={sailorForm.sailingJourney}
                          onChange={(nextRaw) =>
                            setSailorForm({ ...sailorForm, sailingJourney: nextRaw })
                          }
                        />
                      </div>
                    </div>

                    <div className="flex justify-end gap-2 border-t border-[var(--sp-cool-veil)] pt-4 sticky bottom-0 bg-[var(--sp-warm-white)] pb-1">
                      <button
                        type="button"
                        onClick={() => setEditingSailorId(null)}
                        className="rounded-full border border-[var(--sp-cool-veil)] bg-white px-4 py-2 text-xs font-bold text-[var(--sp-charcoal)] hover:bg-[var(--sp-sailcloth)] shadow-xs"
                      >
                        Cancel
                      </button>
                      <button
                        type="button"
                        disabled={saving}
                        onClick={handleSaveSailor}
                        className="rounded-full bg-[var(--sp-racing-orange)] px-5 py-2 text-xs font-bold text-white hover:brightness-105 shadow-sm disabled:opacity-40"
                      >
                        {saving ? "Saving…" : "Save Sailor"}
                      </button>
                    </div>
                    </div>
                  </div>
                )}

                {/* Sailors List */}
                <div className="glass-panel rounded-2xl sm:rounded-3xl border border-white/5 overflow-hidden">
                  <div className="p-4 sm:p-6 border-b border-white/5 flex flex-col sm:flex-row sm:items-center justify-between gap-3">
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
                          className="rounded-full bg-white border border-[var(--sp-cool-veil)] px-4 py-2 text-xs font-bold text-[var(--sp-charcoal)] hover:bg-[var(--sp-sailcloth)] flex items-center gap-1.5 shadow-sm"
                        >
                          <Columns3 className="h-4 w-4 text-[var(--sp-racing-orange)]" />
                          Columns
                        </button>
                        {dbColPickerOpen && (
                          <div className="absolute right-0 top-full mt-2 z-30 w-56 rounded-xl border border-[var(--sp-cool-veil)] bg-white shadow-xl p-3 space-y-1.5">
                            <p className="text-[10px] font-bold text-[var(--sp-slate)] uppercase mb-2">
                              Visible columns
                            </p>
                            {DB_SAILOR_COLUMNS.map((c) => (
                              <label
                                key={c.key}
                                className="flex items-center gap-2 text-xs text-[var(--sp-charcoal)] cursor-pointer hover:text-[var(--sp-racing-orange)]"
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
                                  className="rounded border-[var(--sp-cool-veil)] text-orange-600 h-3.5 w-3.5"
                                />
                                {c.label}
                                {!c.defaultOn && (
                                  <span className="text-[9px] text-[var(--sp-muted)]">optional</span>
                                )}
                              </label>
                            ))}
                            <button
                              type="button"
                              onClick={() => setDbColVisible(defaultDbColVisible())}
                              className="mt-2 w-full text-[10px] font-bold text-orange-600 hover:text-orange-700"
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
                            ...emptySailorForm(),
                            sailNumber: "SGP ",
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
                        <tr className="border-b border-[var(--sp-cool-veil)] bg-[var(--sp-sailcloth)] text-[10px] font-bold text-[var(--sp-slate)] uppercase tracking-wider">
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
                              className="rounded border-[var(--sp-cool-veil)] text-orange-600 h-3.5 w-3.5"
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
                        {sortedDbSailors.length === 0 && (
                          <tr>
                            <td colSpan={20} className="p-0">
                              <AdminEmptyState
                                icon={Users}
                                title={
                                  sailorList.length === 0
                                    ? "No sailors loaded"
                                    : "No sailors match filters"
                                }
                                description={
                                  sailorList.length === 0
                                    ? "Import a regatta or add a sailor to start the roster."
                                    : "Clear search or widen fleet/class/squad filters."
                                }
                                action={
                                  isSuperadmin
                                    ? {
                                        label: "Add sailor",
                                        onClick: () => {
                                          setSailorForm({
                                            ...emptySailorForm(),
                                          });
                                          setEditingSailorId("new");
                                        },
                                      }
                                    : undefined
                                }
                              />
                            </td>
                          </tr>
                        )}
                        {sortedDbSailors.map((s) => {
                          const seriesLabel = seriesLabelOf(s);
                          const isChecked = selectedSailors.includes(s.id);
                          const cells: Record<string, React.ReactNode> = {
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
                            sailNumberIlca4: (
                              <span className="font-mono text-sky-300/90">
                                {s.sailNumberIlca4 || "—"}
                              </span>
                            ),
                            nationality: (
                              <span className="text-slate-300">
                                {s.nationality || "—"}
                                {s.nationalityFromSail ? (
                                  <span
                                    className="ml-1.5 inline-flex rounded-full bg-[var(--sp-racing-mist)] border border-[var(--sp-racing-deep)] px-1.5 py-px text-[11px] font-bold text-[var(--sp-charcoal)]"
                                    title="Nationality was auto-set from sail number — verify"
                                  >
                                    from sail
                                  </span>
                                ) : null}
                              </span>
                            ),
                            natFromSail: s.nationalityFromSail ? (
                              <span className="inline-flex rounded-full bg-[var(--sp-racing-mist)] border border-[var(--sp-racing-deep)] px-2 py-0.5 text-[11px] font-bold text-[var(--sp-charcoal)]">
                                From sail #
                              </span>
                            ) : (
                              <span className="text-slate-600">—</span>
                            ),
                            ilca4List: (
                              <span
                                className={`text-[10px] font-bold ${
                                  s.ilca4NationalList
                                    ? "text-sky-300"
                                    : "text-slate-600"
                                }`}
                              >
                                {s.ilca4NationalList ? "On list" : "—"}
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
                            gender: formatGenderLabel(s.gender),
                            birthYear: (() => {
                              const y = birthYear(s.dob as string | null);
                              return y != null ? (
                                <span className="font-mono text-white">{y}</span>
                              ) : (
                                <span className="text-slate-600">—</span>
                              );
                            })(),
                            // legacy localStorage column key
                            age: (() => {
                              const y = birthYear(s.dob as string | null);
                              return y != null ? (
                                <span className="font-mono text-white">{y}</span>
                              ) : (
                                <span className="text-slate-600">—</span>
                              );
                            })(),
                            club: s.club || "—",
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
                            squadJan27: s.natSquadStatusJan27 || "—",
                            squadJul27: s.natSquadStatusJul27 || "—",
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
                              className={`hover:bg-[var(--sp-sailcloth)]/50 transition-colors ${
                                isChecked
                                  ? "bg-orange-500/10"
                                  : competitionsSailorId === s.id
                                    ? "bg-orange-500/5"
                                    : ""
                              }`}
                            >
                              <td className="py-3 px-3 text-center">
                                <input
                                  type="checkbox"
                                  checked={isChecked}
                                  onChange={() => toggleSelectSailor(s.id)}
                                  className="rounded border-[var(--sp-cool-veil)] text-orange-600 h-3.5 w-3.5"
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
                                    className="inline-flex items-center gap-1 rounded-full border border-[var(--sp-cool-veil)] bg-white px-2.5 py-1 text-[10px] font-bold text-[var(--sp-charcoal)] hover:border-orange-300 hover:text-orange-600 shadow-sm"
                                  >
                                    <Medal className="h-3.5 w-3.5 text-orange-500" />
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
                                        ...emptySailorForm(),
                                        id: s.id,
                                        name: s.name || "",
                                        handle: s.handle || "",
                                        sailNumber: s.sailNumber || "",
                                        sailNumberIlca4:
                                          s.sailNumberIlca4 || "",
                                        club: s.club || "",
                                        weight: s.weight
                                          ? s.weight.toString()
                                          : "",
                                        nationalSquadStatus:
                                          s.natSquadStatusJan27 ||
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
                                        natSquadStatusJan27:
                                          s.natSquadStatusJan27 || "",
                                        natSquadStatusJul27:
                                          s.natSquadStatusJul27 || "",
                                        nationality: s.nationality || "",
                                        gender: s.gender || "",
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
                                        worlds:
                                          s.worlds != null
                                            ? String(s.worlds)
                                            : "",
                                        european:
                                          s.european != null
                                            ? String(s.european)
                                            : "",
                                        asian:
                                          s.asian != null
                                            ? String(s.asian)
                                            : "",
                                        seaGames:
                                          s.seaGames != null
                                            ? String(s.seaGames)
                                            : "",
                                        sailingJourney: s.sailingJourney
                                          ? String(s.sailingJourney)
                                          : "",
                                      });
                                      setEditingSailorId(s.id);
                                    }}
                                    className="inline-flex items-center gap-1 rounded-full border border-[var(--sp-cool-veil)] bg-white px-2.5 py-1 text-[10px] font-bold text-[var(--sp-charcoal)] hover:bg-[var(--sp-sailcloth)] shadow-2xs"
                                  >
                                    <Edit3 className="h-3.5 w-3.5 text-[var(--sp-slate-soft)]" />
                                    Edit
                                  </button>
                                  <button
                                    type="button"
                                    aria-label={`Delete sailor ${s.name}`}
                                    title="Delete sailor"
                                    onClick={() => handleDeleteSailor(s.id)}
                                    className="text-[var(--sp-slate-soft)] hover:text-rose-600 focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-rose-500 rounded"
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
                    Tick rows for bulk edit · Filter by ILCA 4 or dual-class · Best 3 of 5 =
                    Optimist SG half score · ILCA sail # / national list via bulk or Columns ·
                    Ranking tools also under the ILCA 4 admin tab.
                  </p>
                </div>
              </div>

  );
}
