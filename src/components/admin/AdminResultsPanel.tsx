"use client";

import {
  Fragment,
  useEffect,
  useMemo,
  useRef,
  useState,
  type Dispatch,
  type SetStateAction,
} from "react";
import Link from "next/link";
import {
  Plus,
  Trash2,
  Edit3,
  Search,
  ChevronsUpDown,
  ChevronDown,
  ChevronUp,
  Calendar,
  Trophy,
  ExternalLink,
  Medal,
} from "lucide-react";
import {
  ILCA_FLEETS,
  OPTIMIST_FLEETS,
  regattaMatchesAdminClass,
} from "@/lib/admin/regattaClass";
import type { SailorAdmin } from "@/types/sailor";
import type { RegattaAdmin } from "@/types/regatta";
import { regattaDateLabel } from "@/types/regatta";
import type { ResultAdmin } from "@/types/result";
import {
  emptyResultForm,
  type ResultFormState,
} from "@/components/admin/adminForms";
import { AdminEmptyState } from "@/components/admin/AdminEmptyState";
import { RankMedalBadge } from "@/components/ui/RankMedalBadge";


export type { ResultFormState };

/**
 * Group 1 national DNS points when marking a sailor DNS on the sheet:
 * started (non-DNS, non-overseas rows) + 1.
 */
function dnsPointsFromResults(
  regattaId: string,
  results: {
    regattaId: string;
    isDns?: boolean | null;
    isDNS?: boolean | null;
    isOverseasCommitment?: boolean | null;
  }[]
): number {
  let started = 0;
  for (const r of results) {
    if (r.regattaId !== regattaId) continue;
    if (Boolean(r.isDns || r.isDNS)) continue;
    if (Boolean(r.isOverseasCommitment)) continue;
    started += 1;
  }
  return started + 1;
}

export type AdminResultsPanelProps = {
  isSuperadmin: boolean;
  sailorList: SailorAdmin[];
  regattaList: RegattaAdmin[];
  resultsList: ResultAdmin[];
  selectedRegattaIdForResultEdit: string;
  setSelectedRegattaIdForResultEdit: (id: string) => void;
  editingResultId: string | null;
  setEditingResultId: (id: string | null) => void;
  resultForm: ResultFormState;
  setResultForm: Dispatch<SetStateAction<ResultFormState>>;
  /** True while the save mutation is in flight. */
  saving: boolean;
  handleSaveResult: () => void | Promise<void>;
  handleQuickUpdateResult?: (
    id: string,
    patch: {
      rank?: number;
      nettScore?: number | null;
      totalScore?: number | null;
      isDns?: boolean;
      isDNS?: boolean;
      isOverseasCommitment?: boolean;
    }
  ) => Promise<void>;
  handleDeleteResult: (id: string) => void | Promise<void>;
  /** Hide the global regatta search. The event page already chose the class. */
  embedded?: boolean;
};

function regattaLabel(r: RegattaAdmin): string {
  const non = r.countsForRanking === false ? " · non-ranking" : "";
  return `${r.name} (${regattaDateLabel(r.date)})${non}`;
}

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
  saving,
  handleSaveResult,
  handleQuickUpdateResult,
  handleDeleteResult,
  embedded = false,
}: AdminResultsPanelProps) {
  const [regattaQuery, setRegattaQuery] = useState("");
  const [regattaClassFilter, setRegattaClassFilter] = useState<
    "all" | "optimist" | "ilca" | "wingfoil" | "iqfoil" | "29er" | "techno"
  >("all");
  const [regattaFleetFilter, setRegattaFleetFilter] = useState("all");
  const [regattaRankingFilter, setRegattaRankingFilter] = useState<
    "all" | "series" | "nonranking"
  >("all");
  const [pickerOpen, setPickerOpen] = useState(false);
  const [sailorFilter, setSailorFilter] = useState("");
  const [inlineEditing, setInlineEditing] = useState<{
    id: string;
    field: "rank" | "nettScore";
    value: string;
  } | null>(null);
  const [expandedResultId, setExpandedResultId] = useState<string | null>(null);
  const pickerRef = useRef<HTMLDivElement>(null);

  const selectedRegatta = useMemo(
    () => regattaList.find((r) => r.id === selectedRegattaIdForResultEdit),
    [regattaList, selectedRegattaIdForResultEdit]
  );

  const recentRegattas = useMemo(() => {
    return [...regattaList]
      .filter((r) => {
        if (
          !regattaMatchesAdminClass({
            boatClass: r.boatClass,
            division: r.division,
            family: regattaClassFilter,
            fleet: regattaFleetFilter,
          })
        ) {
          return false;
        }
        return true;
      })
      .sort((a, b) => String(b.date || "").localeCompare(String(a.date || "")))
      .slice(0, 4);
  }, [regattaList, regattaClassFilter, regattaFleetFilter]);

  const filteredRegattas = useMemo(() => {
    const q = regattaQuery.trim().toLowerCase();
    return [...regattaList]
      .filter((r) => {
        if (
          !regattaMatchesAdminClass({
            boatClass: r.boatClass,
            division: r.division,
            family: regattaClassFilter,
            fleet: regattaFleetFilter,
          })
        ) {
          return false;
        }
        const isNon = r.countsForRanking === false;
        if (regattaRankingFilter === "series" && isNon) return false;
        if (regattaRankingFilter === "nonranking" && !isNon) return false;
        if (!q) return true;
        const hay =
          `${r.name || ""} ${r.date || ""} ${r.division || ""} ${r.boatClass || ""} ${r.slug || ""}`.toLowerCase();
        return hay.includes(q);
      })
      .sort((a, b) => String(b.date || "").localeCompare(String(a.date || "")));
  }, [regattaList, regattaQuery, regattaClassFilter, regattaFleetFilter, regattaRankingFilter]);

  const sailorById = useMemo(() => {
    const m = new Map<string, SailorAdmin>();
    for (const s of sailorList) m.set(s.id, s);
    return m;
  }, [sailorList]);

  const eventResults = useMemo(() => {
    const q = sailorFilter.trim().toLowerCase();
    return resultsList
      .filter((res) => res.regattaId === selectedRegattaIdForResultEdit)
      .filter((res) => {
        if (!q) return true;
        const sailor = sailorById.get(res.sailorId);
        const hay =
          `${sailor?.name || ""} ${sailor?.sailNumber || ""} ${sailor?.sailNumberIlca4 || ""}`.toLowerCase();
        return hay.includes(q);
      })
      .slice()
      .sort((a, b) => (a.rank || 999) - (b.rank || 999));
  }, [
    resultsList,
    selectedRegattaIdForResultEdit,
    sailorFilter,
    sailorById,
  ]);

  const eventResultCount = useMemo(
    () =>
      resultsList.filter(
        (res) => res.regattaId === selectedRegattaIdForResultEdit
      ).length,
    [resultsList, selectedRegattaIdForResultEdit]
  );

  const raceNumbers = useMemo(() => {
    let maxRace = Number(selectedRegatta?.raceCount) || 0;
    for (const r of eventResults) {
      if (r.raceResults && Array.isArray(r.raceResults)) {
        for (const race of r.raceResults) {
          if (race.raceNumber > maxRace) {
            maxRace = race.raceNumber;
          }
        }
      }
    }
    if (maxRace <= 0) return [];
    return Array.from({ length: maxRace }, (_, i) => i + 1);
  }, [eventResults, selectedRegatta?.raceCount]);

  useEffect(() => {
    if (!pickerOpen) return;
    const onDoc = (e: MouseEvent) => {
      if (!pickerRef.current?.contains(e.target as Node)) {
        setPickerOpen(false);
      }
    };
    document.addEventListener("mousedown", onDoc);
    return () => document.removeEventListener("mousedown", onDoc);
  }, [pickerOpen]);

  const pickRegatta = (id: string) => {
    setSelectedRegattaIdForResultEdit(id);
    setSailorFilter("");
    setEditingResultId(null);
    setPickerOpen(false);
    setRegattaQuery("");
  };

  return (
    <div className="w-full min-w-0 space-y-6">

      {!embedded && (
      <>
      {/* Searchable regatta picker */}
      <div className="glass-panel rounded-3xl p-6 border border-white/5 space-y-3">
        <div className="flex flex-col sm:flex-row sm:items-end justify-between gap-3">
          <div className="space-y-1 min-w-0">
            <h3 className="text-sm font-bold text-white uppercase tracking-wider">
              Select regatta event
            </h3>
            <p className="text-xs text-slate-500">
              Search by name, date, division, or boat class — then edit scores below.
            </p>
          </div>
          <div className="flex flex-wrap items-center gap-2">
            {/* Class Filter */}
            <div className="flex rounded-full bg-white/5 p-0.5 border border-white/10">
              {(
                [
                  ["all", "All"],
                  ["optimist", "Optimist"],
                  ["ilca", "ILCA"],
                  ["wingfoil", "WingFoil"],
                  ["iqfoil", "iQFOiL"],
                  ["29er", "29er"],
                  ["techno", "Techno"],
                ] as const
              ).map(([id, label]) => (
                <button
                  key={id}
                  type="button"
                  onClick={() => {
                    setRegattaClassFilter(id);
                    setRegattaFleetFilter("all");
                  }}
                  className={`rounded-full px-2.5 py-1 text-[12px] font-bold transition-all ${
                    regattaClassFilter === id
                      ? "bg-[var(--sp-harbour-teal)] text-white"
                      : "text-slate-400 hover:text-white"
                  }`}
                >
                  {label}
                </button>
              ))}
            </div>
            {(regattaClassFilter === "optimist" || regattaClassFilter === "ilca") && (
              <div className="flex rounded-full bg-white/5 p-0.5 border border-white/10">
                <button
                  type="button"
                  onClick={() => setRegattaFleetFilter("all")}
                  className={`rounded-full px-2.5 py-1 text-[12px] font-bold transition-all ${
                    regattaFleetFilter === "all"
                      ? "bg-[var(--sp-harbour-teal)] text-white"
                      : "text-slate-400 hover:text-white"
                  }`}
                >
                  All
                </button>
                {(regattaClassFilter === "ilca" ? ILCA_FLEETS : OPTIMIST_FLEETS.filter((fleet) => fleet === "Gold" || fleet === "Silver")).map(
                  (fleet) => (
                    <button
                      key={fleet}
                      type="button"
                      onClick={() => setRegattaFleetFilter(fleet)}
                      className={`rounded-full px-2.5 py-1 text-[12px] font-bold transition-all ${
                        regattaFleetFilter === fleet
                          ? "bg-[var(--sp-harbour-teal)] text-white"
                          : "text-slate-400 hover:text-white"
                      }`}
                    >
                      {regattaClassFilter === "ilca" ? fleet.replace("ILCA ", "") : fleet}
                    </button>
                  )
                )}
              </div>
            )}

            {/* Ranking Filter */}
            <div className="flex rounded-full bg-white/5 p-0.5 border border-white/10">
              {(
                [
                  ["all", "All"],
                  ["series", "Series"],
                  ["nonranking", "Non-ranking"],
                ] as const
              ).map(([id, label]) => (
                <button
                  key={id}
                  type="button"
                  onClick={() => setRegattaRankingFilter(id)}
                  className={`rounded-full px-2.5 py-1 text-[13px] font-bold transition-all ${
                    regattaRankingFilter === id
                      ? "bg-[var(--sp-harbour-teal)] text-white"
                      : "text-slate-400 hover:text-white"
                  }`}
                >
                  {label}
                </button>
              ))}
            </div>
          </div>
        </div>

        <div ref={pickerRef} className="relative">
          <button
            type="button"
            onClick={() => setPickerOpen((o) => !o)}
            className="w-full flex items-center justify-between gap-2 rounded-xl border border-white/10 bg-slate-950 px-4 py-2.5 text-left text-xs font-semibold text-white hover:border-orange-500/40"
          >
            <span className="truncate">
              {selectedRegatta
                ? regattaLabel(selectedRegatta)
                : "— Choose regatta —"}
            </span>
            <ChevronsUpDown className="h-4 w-4 shrink-0 text-slate-500" />
          </button>

          {pickerOpen && (
            <div className="absolute z-30 mt-2 w-full rounded-2xl border border-white/10 bg-[#131520] shadow-xl shadow-black/40 overflow-hidden">
              <div className="p-2 border-b border-white/5">
                <div className="relative">
                  <Search className="absolute left-3 top-1/2 -translate-y-1/2 h-3.5 w-3.5 text-slate-500" />
                  <input
                    type="search"
                    autoFocus
                    value={regattaQuery}
                    onChange={(e) => setRegattaQuery(e.target.value)}
                    placeholder="Filter events…"
                    className="w-full rounded-xl border border-white/10 bg-slate-950 pl-9 pr-3 py-2 text-xs text-white focus:outline-none focus:border-orange-500/40"
                  />
                </div>
              </div>
              <ul className="max-h-64 overflow-y-auto py-1">
                {filteredRegattas.length === 0 && (
                  <li className="px-4 py-6 text-center text-xs text-slate-500">
                    No events match.
                  </li>
                )}
                {filteredRegattas.map((r) => (
                  <li key={r.id}>
                    <button
                      type="button"
                      onClick={() => pickRegatta(r.id)}
                      className={`w-full text-left px-4 py-2.5 text-xs hover:bg-white/5 ${
                        r.id === selectedRegattaIdForResultEdit
                          ? "bg-orange-500/15 text-orange-100"
                          : "text-slate-200"
                      }`}
                    >
                      <span className="font-bold">{r.name}</span>
                      <span className="text-slate-500 ml-2">
                        {regattaDateLabel(r.date)}
                        {r.division ? ` · ${r.division}` : ""}
                        {r.countsForRanking === false ? " · non-ranking" : ""}
                      </span>
                    </button>
                  </li>
                ))}
              </ul>
            </div>
          )}
        </div>

        {recentRegattas.length > 0 && (
          <div className="flex items-center gap-2 pt-1 flex-wrap">
            <span className="text-[12px] font-bold uppercase tracking-wider text-slate-500 shrink-0">
              Quick Select:
            </span>
            <div className="flex items-center gap-1.5 flex-wrap">
              {recentRegattas.map((r) => {
                const isSelected = r.id === selectedRegattaIdForResultEdit;
                return (
                  <button
                    key={r.id}
                    type="button"
                    onClick={() => pickRegatta(r.id)}
                    className={`rounded-lg px-2.5 py-1 text-[13px] font-semibold transition-all ${
                      isSelected
                        ? "bg-[var(--sp-aqua-mist)] text-[var(--sp-harbour-teal)] border border-[var(--sp-harbour-teal)]/40 shadow-sm"
                        : "bg-white/5 hover:bg-white/10 text-slate-300 border border-white/5"
                    }`}
                  >
                    <span>{r.name}</span>
                    <span className="text-[13px] text-slate-500 ml-1.5">
                      {regattaDateLabel(r.date)}
                    </span>
                  </button>
                );
              })}
            </div>
          </div>
        )}
      </div>
      </>
      )}

      {selectedRegatta && (
        <div className="glass-panel rounded-2xl p-4 sm:p-5 border border-white/10 bg-[#131520] flex flex-col md:flex-row md:items-center justify-between gap-4">
          <div className="space-y-1.5 min-w-0">
            <div className="flex items-center gap-2 flex-wrap">
              <span className="text-[12px] font-black uppercase tracking-wider text-orange-400 bg-orange-500/10 px-2 py-0.5 rounded border border-orange-500/20">
                {selectedRegatta.boatClass || "Optimist"}
              </span>
              {selectedRegatta.division && (
                <span className="text-[12px] font-bold uppercase tracking-wider text-slate-300 bg-white/5 px-2 py-0.5 rounded border border-white/10">
                  {selectedRegatta.division}
                </span>
              )}
              <span
                className={`text-[12px] font-bold uppercase tracking-wider px-2 py-0.5 rounded border ${
                  selectedRegatta.countsForRanking === false
                    ? "text-sky-300 bg-sky-500/10 border-sky-500/20"
                    : "text-emerald-300 bg-emerald-500/10 border-emerald-500/20"
                }`}
              >
                {selectedRegatta.countsForRanking === false
                  ? "Non-Ranking"
                  : "Series Ranking"}
              </span>
              <h4 className="text-sm font-bold text-white truncate">
                {selectedRegatta.name}
              </h4>
            </div>
            <div className="flex flex-wrap items-center gap-4 text-xs text-slate-400 pt-1">
              <span className="flex items-center gap-1">
                <Calendar className="h-3.5 w-3.5 text-slate-500" />
                {regattaDateLabel(selectedRegatta.date)}
              </span>
              <span className="flex items-center gap-1">
                <Trophy className="h-3.5 w-3.5 text-slate-500" />
                Fleet Size: {selectedRegatta.totalFleetSize}
                {selectedRegatta.raceCount != null
                  ? ` · ${selectedRegatta.raceCount} Races`
                  : ""}
              </span>
            </div>
          </div>

          <div className="flex items-center gap-2 shrink-0 border-t md:border-t-0 pt-3 md:pt-0 border-white/5">
            {selectedRegatta.slug && (
              <Link
                href={
                  (selectedRegatta.boatClass || "").toLowerCase().includes("ilca")
                    ? `/sg/ilca4/regattas/${selectedRegatta.slug}`
                    : `/sg/optimist/regattas/${selectedRegatta.slug}`
                }
                target="_blank"
                className="inline-flex items-center gap-1.5 rounded-full border border-white/10 bg-white/5 hover:bg-white/10 px-3.5 py-1.5 text-xs font-bold text-slate-300 transition-all"
              >
                <ExternalLink className="h-3.5 w-3.5 text-orange-400" />
                View Public Page
              </Link>
            )}
          </div>
        </div>
      )}

      {!selectedRegattaIdForResultEdit && (
        <AdminEmptyState
          icon={Search}
          title="Choose a regatta to edit results"
          description="Use the searchable picker above (filter by series / non-ranking). Then add scores, fill DNS, or filter sailors in the table."
        />
      )}

      {/* Result Form Card */}
      {editingResultId && (
        <div className="glass-panel rounded-3xl p-6 border border-white/5 space-y-4">
          <h3 className="text-sm font-bold text-white uppercase tracking-wider">
            {editingResultId === "new"
              ? "Add Sailor Regatta Result"
              : "Edit Sailor Regatta Result"}
          </h3>
          {regattaList.find((r) => r.id === resultForm.regattaId)
            ?.countsForRanking === false && (
            <p className="text-[13px] text-sky-300 font-semibold">
              Non-ranking event — not used in series rankings.
            </p>
          )}
          <div className="grid grid-cols-1 md:grid-cols-5 gap-4">
            <div>
              <label className="text-[12px] font-bold text-slate-500 uppercase">
                Sailor Name
              </label>
              <select
                value={resultForm.sailorId}
                onChange={(e) =>
                  setResultForm({ ...resultForm, sailorId: e.target.value })
                }
                className="mt-1 w-full rounded-xl border border-white/5 bg-slate-950 px-3 py-2 text-white text-xs focus:outline-none"
              >
                <option value="" disabled>
                  -- Select Sailor --
                </option>
                {sailorList.map((s) => (
                  <option key={s.id} value={s.id}>
                    {s.name} ({s.sailNumber})
                  </option>
                ))}
              </select>
            </div>
            <div>
              <label className="text-[12px] font-bold text-slate-500 uppercase">
                Total Score
              </label>
              <input
                type="number"
                step="any"
                value={resultForm.totalScore}
                onChange={(e) =>
                  setResultForm({ ...resultForm, totalScore: e.target.value })
                }
                className="mt-1 w-full rounded-xl border border-white/5 bg-slate-950 px-3 py-2 text-white text-xs font-mono"
                placeholder="Optional"
              />
            </div>
            <div>
              <label className="text-[12px] font-bold text-slate-500 uppercase">
                Nett Score (optional)
              </label>
              <input
                type="number"
                step="any"
                value={resultForm.nettScore}
                onChange={(e) =>
                  setResultForm({ ...resultForm, nettScore: e.target.value })
                }
                className="mt-1 w-full rounded-xl border border-white/5 bg-slate-950 px-3 py-2 text-white text-xs font-mono"
              />
            </div>
            <div>
              <label className="text-[12px] font-bold text-slate-500 uppercase">
                Rank (Finishing Pos)
              </label>
              <input
                type="number"
                value={resultForm.rank}
                onChange={(e) =>
                  setResultForm({ ...resultForm, rank: e.target.value })
                }
                className="mt-1 w-full rounded-xl border border-white/5 bg-slate-950 px-3 py-2 text-white text-xs font-mono"
              />
              <p className="mt-1 text-[13px] text-slate-600">
                DNS defaults to starters + 1 (Group 1 registered no-show). Unregistered sailors are auto-scored as max(sheet place) + 1 at ranking time (Group 2).
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
                  const dnsPts = dnsPointsFromResults(reg?.id || resultForm.regattaId, resultsList);
                  setResultForm({
                    ...resultForm,
                    isDNS: on,
                    isDns: on,
                    ...(on ? { rank: dnsPts } : {}),
                  });
                }}
                className="rounded border-slate-700 bg-slate-900 text-orange-600 focus:ring-orange-500 h-4 w-4"
              />
              <label
                htmlFor="dnsCheckbox"
                className="text-xs font-bold text-slate-400 cursor-pointer"
              >
                Did Not Start (DNS) — initially sets rank to started + 1 (Group 1);
                edit if the published sheet used a different place
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
                    isDNS: on ? false : resultForm.isDNS,
                    isDns: on ? false : resultForm.isDns,
                  });
                }}
                className="rounded border-slate-700 bg-slate-900 text-sky-500 focus:ring-sky-500 h-4 w-4"
              />
              <label
                htmlFor="overseasCheckbox"
                className="text-xs font-bold text-sky-300/90 cursor-pointer leading-snug"
              >
                Overseas commitment (SSF) — set points to standing before trip
                (e.g. rank 2 → 2 pts); tag only, does not auto-calc
              </label>
            </div>
          </div>
          <div className="flex justify-end gap-2 border-t border-white/5 pt-4">
            <button
              type="button"
              onClick={() => setEditingResultId(null)}
              className="rounded-full bg-slate-800 px-4 py-2 text-xs font-bold text-slate-400 hover:text-white"
            >
              Cancel
            </button>
            <button
              type="button"
              disabled={!isSuperadmin || saving}
              onClick={() => void handleSaveResult()}
              className="rounded-full bg-orange-600 px-5 py-2 text-[15px] font-semibold text-white hover:bg-orange-500 disabled:opacity-40"
            >
              {saving ? "Saving…" : "Save Result"}
            </button>
          </div>
        </div>
      )}

      {/* Results List */}
      {selectedRegattaIdForResultEdit && (
        <div className="glass-panel rounded-2xl sm:rounded-3xl border border-white/5 overflow-hidden">
          <div className="p-4 sm:p-6 border-b border-white/5 flex flex-col lg:flex-row lg:items-center justify-between gap-3 sm:gap-4">
            <div className="min-w-0">
              <h3 className="text-base font-bold text-white">
                Regatta Results Table
              </h3>
              <p className="text-xs text-slate-500">
                {eventResultCount} row{eventResultCount === 1 ? "" : "s"}
                {sailorFilter.trim()
                  ? ` · showing ${eventResults.length} match${eventResults.length === 1 ? "" : "es"}`
                  : ""}
                . Edit or delete scores for this event.
              </p>
            </div>
            <div className="flex flex-wrap items-stretch sm:items-end gap-2 sm:gap-3">
              <div className="relative min-w-[10rem] flex-1 sm:flex-initial sm:w-48">
                <Search className="absolute left-3 top-1/2 -translate-y-1/2 h-3.5 w-3.5 text-slate-500" />
                <input
                  type="search"
                  value={sailorFilter}
                  onChange={(e) => setSailorFilter(e.target.value)}
                  placeholder="Filter sailors…"
                  className="w-full rounded-full border border-white/10 bg-slate-950 pl-9 pr-3 py-2 text-[13px] sm:text-sm text-white focus:outline-none focus:border-orange-500/40"
                />
              </div>
              <button
                type="button"
                onClick={() => {
                  const reg = regattaList.find(
                    (r) => r.id === selectedRegattaIdForResultEdit
                  );
                  const dnsPts = dnsPointsFromResults(reg?.id || resultForm.regattaId, resultsList);
                  setEditingResultId("new");
                  setResultForm({
                    ...emptyResultForm(),
                    regattaId: selectedRegattaIdForResultEdit,
                    rank: dnsPts,
                  });
                }}
                className="rounded-full bg-orange-600 hover:bg-orange-500 px-3 sm:px-4 py-2 text-[15px] font-semibold text-white flex items-center justify-center gap-1 touch-manipulation"
              >
                <Plus className="h-4 w-4" />
                Add Score
              </button>
            </div>
          </div>

          <p className="px-3 sm:px-6 pb-2 text-[13px] text-slate-500">
            On-sheet DNS (Group 1) national points = starters + 1. Absentees not on
            the sheet (Group 2) are auto-scored at ranking time as max(sheet place) + 1.
            Official finish ranks stay
            as published. Mark{" "}
            <strong className="text-sky-300">Overseas commitment</strong> and
            set points to their standing before the trip (e.g. 2nd → 2 pts).
            {isSuperadmin && handleQuickUpdateResult && (
              <span className="text-orange-400/90 ml-1">
                Tip: Double-click rank or nett to edit inline, or toggle Fin / DNS / OVS directly.
              </span>
            )}
          </p>

          <div className="overflow-x-auto max-w-full -mx-1 px-1">
            <table className="w-full text-left border-collapse text-xs min-w-[720px]">
              <thead>
                <tr className="border-b border-white/5 bg-white/5 text-[12px] font-bold text-slate-400 uppercase tracking-wider">
                  <th className="py-3 px-3 text-center w-14">Rank</th>
                  <th className="py-3 px-4 sm:px-6">Competitor / Sailor</th>
                  <th className="py-3 px-3 text-center">Sail #</th>
                  <th className="py-3 px-3 text-center">Gender</th>
                  <th className="py-3 px-3 text-center">Birth year</th>
                  {raceNumbers.map((rNum) => (
                    <th
                      key={rNum}
                      className="py-3 px-2 text-center font-mono font-black text-orange-400 bg-orange-500/[0.04] border-x border-white/5 min-w-[42px]"
                      title={`Race ${rNum} finish`}
                    >
                      R{rNum}
                    </th>
                  ))}
                  <th className="py-3 px-3 text-center">Total</th>
                  <th className="py-3 px-3 text-center font-black text-orange-300">Nett</th>
                  <th className="py-3 px-3 text-center">Status</th>
                  <th className="py-3 px-4 sm:px-6 text-right">Actions</th>
                </tr>
              </thead>
              <tbody className="divide-y divide-white/5 font-semibold text-slate-300">
                {eventResults.map((res) => {
                  const sailor = sailorById.get(res.sailorId);
                  const dns = Boolean(res.isDns || res.isDNS);
                  const overseas = Boolean(res.isOverseasCommitment);
                  const birthY = (() => {
                    if (!sailor?.dob) return "—";
                    const y = new Date(sailor.dob).getFullYear();
                    if (!Number.isFinite(y)) return "—";
                    return String(y);
                  })();
                  return (
                    <Fragment key={res.id}>
                      <tr
                        className={`hover:bg-white/[0.03] transition-colors ${
                        overseas
                          ? "bg-sky-500/[0.04]"
                          : dns
                            ? "bg-rose-500/[0.03]"
                            : ""
                      }`}
                    >
                      <td className="py-3 px-3 text-center">
                        {inlineEditing?.id === res.id && inlineEditing?.field === "rank" ? (
                          <input
                            type="number"
                            autoFocus
                            className="w-16 rounded border border-orange-500/50 bg-slate-950 px-1.5 py-0.5 text-center text-xs font-mono text-white focus:outline-none shadow-lg"
                            value={inlineEditing.value}
                            onChange={(e) => setInlineEditing({ ...inlineEditing, value: e.target.value })}
                            onKeyDown={(e) => {
                              if (e.key === "Enter") {
                                const val = parseInt(inlineEditing.value, 10);
                                if (Number.isFinite(val) && val >= 1) {
                                  void handleQuickUpdateResult?.(res.id, { rank: val });
                                }
                                setInlineEditing(null);
                              } else if (e.key === "Escape") {
                                setInlineEditing(null);
                              }
                            }}
                            onBlur={() => {
                              const val = parseInt(inlineEditing.value, 10);
                              if (Number.isFinite(val) && val >= 1 && val !== res.rank) {
                                void handleQuickUpdateResult?.(res.id, { rank: val });
                              }
                              setInlineEditing(null);
                            }}
                          />
                        ) : (
                          <div
                            onDoubleClick={() => {
                              if (isSuperadmin && handleQuickUpdateResult) {
                                setInlineEditing({ id: res.id, field: "rank", value: String(res.rank ?? "") });
                              }
                            }}
                            className={`inline-flex items-center justify-center gap-1 ${
                              isSuperadmin && handleQuickUpdateResult
                                ? "cursor-pointer group hover:bg-white/5 px-1.5 py-0.5 rounded transition-colors"
                                : ""
                            }`}
                            title={isSuperadmin && handleQuickUpdateResult ? "Double-click to edit rank inline" : undefined}
                          >
                            <RankMedalBadge
                              rank={res.rank}
                              suffix={overseas ? "†" : dns ? "*" : ""}
                              nonPodiumClassName="font-bold text-orange-400 font-mono"
                            />
                            {isSuperadmin && handleQuickUpdateResult && (
                              <Edit3 className="w-2.5 h-2.5 text-slate-600 opacity-0 group-hover:opacity-100 transition-opacity" />
                            )}
                          </div>
                        )}
                      </td>
                      <td className="py-3 px-4 sm:px-6 min-w-[140px]">
                        <div className="flex items-center gap-1.5">
                          <span className="font-bold text-white leading-tight">
                            {sailor ? sailor.name : "Deleted / Unmapped Sailor"}
                          </span>
                          {res.raceResults && res.raceResults.length > 0 && (
                            <button
                              type="button"
                              onClick={() => setExpandedResultId((prev) => (prev === res.id ? null : res.id))}
                              className="text-slate-500 hover:text-orange-400 p-0.5 rounded transition-colors shrink-0"
                              title={expandedResultId === res.id ? "Hide individual race finishes" : "Show individual race finishes breakdown"}
                            >
                              {expandedResultId === res.id ? (
                                <ChevronUp className="h-3.5 w-3.5 text-orange-400" />
                              ) : (
                                <ChevronDown className="h-3.5 w-3.5" />
                              )}
                            </button>
                          )}
                        </div>
                        <div className="text-[13px] text-slate-400 mt-0.5 truncate max-w-[220px]">
                          {[sailor?.club, sailor?.school, sailor?.nationality]
                            .filter(Boolean)
                            .join(" · ") || "—"}
                        </div>
                      </td>
                      <td className="py-3 px-3 text-center font-mono font-bold text-slate-300">
                        {sailor?.sailNumber || sailor?.sailNumberIlca4 || "—"}
                      </td>
                      <td className="py-3 px-3 text-center text-slate-300">
                        {sailor?.gender || "—"}
                      </td>
                      <td className="py-3 px-3 text-center font-mono text-slate-300">
                        {birthY}
                      </td>
                      {raceNumbers.map((rNum) => {
                        const race = res.raceResults?.find((rr) => rr.raceNumber === rNum);
                        if (!race) {
                          return (
                            <td
                              key={rNum}
                              className="py-3 px-2 text-center font-mono text-slate-600 text-xs border-x border-white/5"
                            >
                              —
                            </td>
                          );
                        }
                        const isDiscarded = Boolean(race.discarded);
                        const hasPenalty = Boolean(race.scoringCode);
                        const displayVal = race.rawValue || String(race.score);

                        return (
                          <td
                            key={rNum}
                            className={`py-3 px-2 text-center text-xs font-mono border-x border-white/5 transition-colors ${
                              isDiscarded ? "bg-white/[0.015]" : ""
                            }`}
                            title={
                              hasPenalty
                                ? `Race ${rNum}: ${race.scoringCode} (${race.score} pts)${isDiscarded ? " - Discarded" : ""}`
                                : `Race ${rNum}: ${race.score} pts${isDiscarded ? " - Discarded" : ""}`
                            }
                          >
                            {hasPenalty ? (
                              <span
                                className={`inline-block px-1.5 py-0.5 rounded text-[10px] font-black ${
                                  isDiscarded
                                    ? "bg-amber-500/10 text-amber-400/60 line-through border border-amber-500/20"
                                    : "bg-amber-500/20 text-amber-300 border border-amber-500/30"
                                }`}
                              >
                                {race.scoringCode}
                              </span>
                            ) : isDiscarded ? (
                              <span className="text-slate-500 line-through text-[11px] font-medium">
                                ({displayVal})
                              </span>
                            ) : (
                              <span className="text-slate-200 font-bold">
                                {displayVal}
                              </span>
                            )}
                          </td>
                        );
                      })}
                      <td className="py-3 px-3 text-center font-mono text-slate-400">
                        {res.totalScore != null ? res.totalScore : "—"}
                      </td>
                      <td className="py-3 px-3 text-center">
                        {inlineEditing?.id === res.id && inlineEditing?.field === "nettScore" ? (
                          <input
                            type="number"
                            step="any"
                            autoFocus
                            className="w-16 rounded border border-orange-500/50 bg-slate-950 px-1.5 py-0.5 text-center text-xs font-mono text-white focus:outline-none shadow-lg"
                            value={inlineEditing.value}
                            onChange={(e) => setInlineEditing({ ...inlineEditing, value: e.target.value })}
                            onKeyDown={(e) => {
                              if (e.key === "Enter") {
                                const val = parseFloat(inlineEditing.value);
                                if (Number.isFinite(val)) {
                                  void handleQuickUpdateResult?.(res.id, { nettScore: val });
                                }
                                setInlineEditing(null);
                              } else if (e.key === "Escape") {
                                setInlineEditing(null);
                              }
                            }}
                            onBlur={() => {
                              const val = parseFloat(inlineEditing.value);
                              if (Number.isFinite(val) && val !== res.nettScore) {
                                void handleQuickUpdateResult?.(res.id, { nettScore: val });
                              }
                              setInlineEditing(null);
                            }}
                          />
                        ) : (
                          <div
                            onDoubleClick={() => {
                              if (isSuperadmin && handleQuickUpdateResult) {
                                setInlineEditing({
                                  id: res.id,
                                  field: "nettScore",
                                  value: res.nettScore != null ? String(res.nettScore) : "",
                                });
                              }
                            }}
                            className={`inline-flex items-center justify-center gap-1 font-mono font-black text-orange-300 ${
                              isSuperadmin && handleQuickUpdateResult
                                ? "cursor-pointer group hover:bg-white/5 px-1.5 py-0.5 rounded transition-colors"
                                : ""
                            }`}
                            title={isSuperadmin && handleQuickUpdateResult ? "Double-click to edit nett score inline" : undefined}
                          >
                            <span>{res.nettScore != null ? res.nettScore : "—"}</span>
                            {isSuperadmin && handleQuickUpdateResult && (
                              <Edit3 className="w-2.5 h-2.5 text-slate-600 opacity-0 group-hover:opacity-100 transition-opacity" />
                            )}
                          </div>
                        )}
                      </td>
                      <td className="py-3 px-3 text-center">
                        {isSuperadmin && handleQuickUpdateResult ? (
                          <div
                            className="inline-flex rounded-lg bg-black/40 p-0.5 border border-white/10"
                            title="Click status to toggle immediately"
                          >
                            <button
                              type="button"
                              onClick={() => {
                                if (overseas || dns) {
                                  void handleQuickUpdateResult(res.id, {
                                    isDns: false,
                                    isDNS: false,
                                    isOverseasCommitment: false,
                                  });
                                }
                              }}
                              className={`px-1.5 py-0.5 text-[13px] font-bold rounded transition-colors ${
                                !overseas && !dns
                                  ? "bg-emerald-500/25 text-emerald-300 border border-emerald-500/40 shadow-sm"
                                  : "text-slate-400 hover:text-white"
                              }`}
                              title="Mark as Finished"
                            >
                              Fin
                            </button>
                            <button
                              type="button"
                              onClick={() => {
                                if (!dns) {
                                  const dnsPts = dnsPointsFromResults(selectedRegatta?.id || selectedRegattaIdForResultEdit, resultsList);
                                  void handleQuickUpdateResult(res.id, {
                                    isDns: true,
                                    isDNS: true,
                                    isOverseasCommitment: false,
                                    rank: dnsPts,
                                  });
                                }
                              }}
                              className={`px-1.5 py-0.5 text-[13px] font-bold rounded transition-colors ${
                                dns
                                  ? "bg-rose-500/25 text-rose-300 border border-rose-500/40 shadow-sm"
                                  : "text-slate-400 hover:text-white"
                              }`}
                              title={`Mark as DNS (${dnsPointsFromResults(selectedRegatta?.id || selectedRegattaIdForResultEdit, resultsList)} pts)`}
                            >
                              DNS
                            </button>
                            <button
                              type="button"
                              onClick={() => {
                                if (!overseas) {
                                  void handleQuickUpdateResult(res.id, {
                                    isOverseasCommitment: true,
                                    isDns: false,
                                    isDNS: false,
                                  });
                                }
                              }}
                              className={`px-1.5 py-0.5 text-[13px] font-bold rounded transition-colors ${
                                overseas
                                  ? "bg-sky-500/25 text-sky-300 border border-sky-500/40 shadow-sm"
                                  : "text-slate-400 hover:text-white"
                              }`}
                              title="Mark as Overseas Commitment"
                            >
                              OVS
                            </button>
                          </div>
                        ) : (
                          <span
                            className={`inline-block px-2 py-0.5 rounded text-[11px] font-bold ${
                              overseas
                                ? "bg-sky-500/15 text-sky-300 border border-sky-500/30"
                                : dns
                                  ? "bg-rose-500/15 text-rose-400 border border-rose-500/30"
                                  : "bg-emerald-500/10 text-emerald-300 border border-emerald-500/20"
                            }`}
                          >
                            {overseas ? "Overseas" : dns ? "DNS" : "Finished"}
                          </span>
                        )}
                      </td>
                      <td className="py-4 px-6 text-right">
                        <div className="flex justify-end items-center gap-2">
                          <button
                            type="button"
                            onClick={() => {
                              setEditingResultId(res.id);
                              setResultForm({
                                ...emptyResultForm(),
                                id: res.id,
                                regattaId: res.regattaId,
                                sailorId: res.sailorId,
                                nettScore:
                                  res.nettScore != null
                                    ? String(res.nettScore)
                                    : "",
                                totalScore:
                                  res.totalScore != null
                                    ? String(res.totalScore)
                                    : "",
                                rank:
                                  res.rank != null ? String(res.rank) : "",
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
                            onClick={() => void handleDeleteResult(res.id)}
                            className="text-slate-500 hover:text-red-400"
                          >
                            <Trash2 className="h-4 w-4" />
                          </button>
                        </div>
                      </td>
                    </tr>
                    {expandedResultId === res.id && res.raceResults && res.raceResults.length > 0 && (
                      <tr className="bg-slate-900/90 border-b border-white/5">
                        <td colSpan={9 + raceNumbers.length} className="px-4 sm:px-6 py-3">
                          <div className="flex flex-col sm:flex-row sm:items-center justify-between gap-3">
                            <div className="flex items-center gap-2">
                              <Trophy className="h-4 w-4 text-orange-400 shrink-0" />
                              <span className="text-xs font-bold text-white">
                                Official Race Finishes for {sailor?.name || res.sailorName || "Sailor"}:
                              </span>
                            </div>
                            <div className="flex flex-wrap items-center gap-1.5">
                              {res.raceResults.map((race) => {
                                const isDiscarded = Boolean(race.discarded);
                                const hasPenalty = Boolean(race.scoringCode);
                                return (
                                  <div
                                    key={race.raceNumber}
                                    className={`flex items-center gap-1 px-2.5 py-1 rounded-lg border text-xs font-mono ${
                                      isDiscarded
                                        ? "bg-white/5 border-white/10 text-slate-400"
                                        : "bg-orange-500/10 border-orange-500/20 text-orange-200"
                                    }`}
                                    title={isDiscarded ? "Worst finish discarded from nett score" : `Race ${race.raceNumber}`}
                                  >
                                    <span className="text-slate-400 font-semibold">R{race.raceNumber}:</span>
                                    <span className={isDiscarded ? "line-through text-slate-400 font-bold" : "font-black text-white"}>
                                      {race.rawValue || race.score}
                                    </span>
                                    {hasPenalty && (
                                      <span className="px-1 py-0.5 rounded text-[10px] font-bold bg-amber-500/20 text-amber-300">
                                        {race.scoringCode}
                                      </span>
                                    )}
                                    {isDiscarded && (
                                      <span className="text-[10px] text-slate-500 font-sans font-semibold">(disc)</span>
                                    )}
                                  </div>
                                );
                              })}
                            </div>
                          </div>
                        </td>
                      </tr>
                    )}
                  </Fragment>
                );
              })}
                {eventResultCount === 0 && (
                  <tr>
                    <td colSpan={9 + raceNumbers.length} className="p-0">
                      <AdminEmptyState
                        icon={Medal}
                        title="No results for this event"
                        description="Add a score manually or fill DNS for series members who did not start."
                        action={{
                          label: "Add score",
                          onClick: () => {
                            const reg = regattaList.find(
                              (r) => r.id === selectedRegattaIdForResultEdit
                            );
                            const dnsPts = dnsPointsFromResults(reg?.id || resultForm.regattaId, resultsList);
                            setEditingResultId("new");
                            setResultForm({
                              ...emptyResultForm(),
                              regattaId: selectedRegattaIdForResultEdit,
                              rank: dnsPts,
                            });
                          },
                        }}
                      />
                    </td>
                  </tr>
                )}
                {eventResultCount > 0 && eventResults.length === 0 && (
                  <tr>
                    <td colSpan={9 + raceNumbers.length} className="p-0">
                      <AdminEmptyState
                        icon={Search}
                        title={`No sailors match “${sailorFilter.trim()}”`}
                        description={`Clear the filter to see all ${eventResultCount} rows.`}
                        action={{
                          label: "Clear filter",
                          onClick: () => setSailorFilter(""),
                        }}
                      />
                    </td>
                  </tr>
                )}
              </tbody>
            </table>
          </div>
        </div>
      )}
    </div>
  );
}
