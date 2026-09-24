"use client";

import { useEffect, useMemo, useState, type ReactNode } from "react";
import Link from "next/link";
import { Plus, Trash2, Calendar, Trophy, ExternalLink, Sparkles, Loader2 } from "lucide-react";
import { AdminNorAmendmentCard } from "@/components/admin/AdminNorAmendmentCard";
import {
  ADMIN_BOAT_CLASS_GROUPS,
  ILCA_FLEETS,
  OPTIMIST_FLEETS,
  REGATTA_CLASS_FAMILIES,
} from "@/lib/admin/regattaClass";
import { norAmendmentForRegatta } from "@/lib/admin/norAmendments";
import type { RegattaAdmin } from "@/types/regatta";
import { regattaDateLabel } from "@/types/regatta";
import { GeographySelect } from "@/components/CountrySelect";
import {
  emptyRegattaForm,
  type RegattaFormState,
} from "@/components/admin/adminForms";
import { AdminEmptyState } from "@/components/admin/AdminEmptyState";
import { useFeedback } from "@/components/ui/FeedbackProvider";
import {
  eventStatusLabel,
  groupRegattaEvents,
  sheetClassLabel,
  UNASSIGNED_EVENT_SLUG,
  type AdminEventGroup,
  type GroupableRegatta,
} from "@/lib/admin/groupRegattaEvents";

export type { RegattaFormState };

export type AdminRegattasPanelProps = {
  isSuperadmin?: boolean;
  filteredRegattaList: RegattaAdmin[];
  regattaSearch: string;
  setRegattaSearch: (v: string) => void;
  regattaDivisionFilter: string;
  setRegattaDivisionFilter: (v: string) => void;
  regattaClassFilter?: string;
  setRegattaClassFilter?: (v: string) => void;
  regattaRankingFilter: string;
  setRegattaRankingFilter: (v: string) => void;
  editingRegattaId: string | null;
  setEditingRegattaId: (id: string | null) => void;
  regattaForm: RegattaFormState;
  setRegattaForm: React.Dispatch<React.SetStateAction<RegattaFormState>>;
  /** True while the save mutation is in flight. */
  saving: boolean;
  handleSaveRegatta: () => void | Promise<void>;
  handleDeleteRegatta: (id: string) => void | Promise<void>;
  onOpenResults?: (regattaId: string) => void;
  onClearSheet?: () => void;
  /** Sheet opened from ?sheet= or the results editor. */
  activeSheetId?: string;
  resultsEditor?: ReactNode;
};

export function AdminRegattasPanel({
  isSuperadmin,
  filteredRegattaList,
  regattaSearch,
  setRegattaSearch,
  regattaDivisionFilter,
  setRegattaDivisionFilter,
  regattaClassFilter = "all",
  setRegattaClassFilter,
  regattaRankingFilter,
  setRegattaRankingFilter,
  editingRegattaId,
  setEditingRegattaId,
  regattaForm,
  setRegattaForm,
  saving,
  handleSaveRegatta,
  handleDeleteRegatta,
  onOpenResults,
  onClearSheet,
  activeSheetId,
  resultsEditor,
}: AdminRegattasPanelProps) {
  const { toast } = useFeedback();
  const [isSeeding, setIsSeeding] = useState(false);
  const [selectedEventSlug, setSelectedEventSlug] = useState<string | null>(null);

  const grouped = useMemo(
    () => groupRegattaEvents(filteredRegattaList),
    [filteredRegattaList]
  );
  const selectedEvent: AdminEventGroup | null =
    selectedEventSlug === UNASSIGNED_EVENT_SLUG
      ? {
          slug: UNASSIGNED_EVENT_SLUG,
          name: "Unassigned sheets",
          startDate: "",
          countsForRanking: false,
          isSelectionTrial: false,
          expectedClasses: [],
          missingClasses: [],
          sheets: grouped.unassigned,
          shell: null,
        }
      : grouped.events.find((event) => event.slug === selectedEventSlug) ?? null;

  const formFrom = (r: GroupableRegatta) => ({
    id: r.id,
    name: r.name || "",
    date: String(r.date || "").slice(0, 10),
    slug: r.slug,
    division: r.division || "",
    raceCount: r.raceCount != null ? String(r.raceCount) : "",
    totalFleetSize: r.totalFleetSize != null ? String(r.totalFleetSize) : "",
    geography: r.geography || "SGP",
    boatClass: r.boatClass || "Optimist",
    countsForRanking: r.countsForRanking !== false,
    endDate: r.endDate ? String(r.endDate).slice(0, 10) : "",
    venue: r.venue || "",
    organizer: r.organizer || "",
    norUrl: r.norUrl || "",
    registrationUrl: r.registrationUrl || "",
    isSelectionTrial: Boolean(r.isSelectionTrial),
    scheduleNotes: r.scheduleNotes || "",
  });

  useEffect(() => {
    if (!activeSheetId) return;
    const row = filteredRegattaList.find((item) => item.id === activeSheetId);
    if (!row) return;
    const event = grouped.events.find(
      (item) =>
        item.sheets.some((sheet) => sheet.id === activeSheetId) ||
        item.shell?.id === activeSheetId
    );
    setSelectedEventSlug(event ? event.slug : UNASSIGNED_EVENT_SLUG);
    if (editingRegattaId === activeSheetId) return;
    setEditingRegattaId(row.id);
    setRegattaForm(formFrom(row));
  }, [activeSheetId, editingRegattaId, filteredRegattaList, grouped.events, setEditingRegattaId, setRegattaForm]);

  const handleSeed2026 = async () => {
    if (!isSuperadmin) return;
    setIsSeeding(true);
    try {
      const res = await fetch("/api/admin/regattas", {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({ action: "seed-2026" }),
      });
      const data = await res.json();
      if (!res.ok) throw new Error(data.error || "Seed failed");
      toast.success(data.message || "2026 Calendar seeded successfully!");
      window.location.reload();
    } catch (err: unknown) {
      toast.error(err instanceof Error ? err.message : "Failed to seed calendar");
    } finally {
      setIsSeeding(false);
    }
  };
  return (
              <div className="w-full min-w-0 space-y-4">
                <div className="glass-panel rounded-2xl border border-white/5 p-4 flex flex-col sm:flex-row sm:items-end gap-3 w-full">
                  <div className="flex-1 min-w-0">
                    <label className="text-[12px] font-bold text-slate-500 uppercase">
                      Search events
                    </label>
                    <input
                      type="search"
                      value={regattaSearch}
                      onChange={(e) => setRegattaSearch(e.target.value)}
                      placeholder="Name, date, division, class…"
                      className="mt-1 w-full rounded-xl border border-white/10 bg-slate-950 px-3 py-2 text-xs text-white"
                    />
                  </div>
                  <div>
                    <label className="text-[12px] font-bold text-slate-500 uppercase">
                      Class
                    </label>
                    <select
                      value={regattaClassFilter}
                      onChange={(e) => {
                        setRegattaClassFilter?.(e.target.value);
                        setRegattaDivisionFilter("all");
                      }}
                      className="mt-1 w-full sm:w-36 rounded-xl border border-white/10 bg-slate-950 px-3 py-2 text-xs text-white"
                    >
                      {REGATTA_CLASS_FAMILIES.map((family) => (
                        <option key={family.id} value={family.id}>
                          {family.label}
                        </option>
                      ))}
                    </select>
                  </div>
                  <div>
                    <label className="text-[12px] font-bold text-slate-500 uppercase">
                      {regattaClassFilter === "ilca" ? "ILCA fleet" : "Fleet"}
                    </label>
                    <select
                      value={regattaDivisionFilter}
                      onChange={(e) => setRegattaDivisionFilter(e.target.value)}
                      className="mt-1 w-full sm:w-36 rounded-xl border border-white/10 bg-slate-950 px-3 py-2 text-xs text-white"
                    >
                      <option value="all">
                        {regattaClassFilter === "ilca" ? "All ILCA" : "All fleets"}
                      </option>
                      {(regattaClassFilter === "ilca"
                        ? ILCA_FLEETS
                        : regattaClassFilter === "optimist" || regattaClassFilter === "all"
                          ? OPTIMIST_FLEETS
                          : []
                      ).map(
                        (fleet) => (
                          <option key={fleet} value={fleet}>
                            {fleet === "NonRanking" ? "Non-ranking" : fleet}
                          </option>
                        )
                      )}
                    </select>
                  </div>
                  <div>
                    <label className="text-[12px] font-bold text-slate-500 uppercase">
                      Ranking
                    </label>
                    <select
                      value={regattaRankingFilter}
                      onChange={(e) => setRegattaRankingFilter(e.target.value)}
                      className="mt-1 w-full sm:w-36 rounded-xl border border-white/10 bg-slate-950 px-3 py-2 text-xs text-white"
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
                        ...emptyRegattaForm(),
                        boatClass:
                          regattaClassFilter === "wingfoil"
                            ? "WingFoil"
                            : regattaClassFilter === "29er"
                              ? "29er"
                              : regattaClassFilter === "techno"
                                ? "Techno 293"
                                : regattaClassFilter === "iqfoil"
                                  ? "iQFOiL"
                                : regattaDivisionFilter === "ILCA 6" ||
                                    regattaDivisionFilter === "ILCA 7" ||
                                    regattaDivisionFilter === "ILCA 4"
                                  ? regattaDivisionFilter
                                  : regattaClassFilter === "ilca"
                                    ? "ILCA 4"
                                    : "Optimist",
                        division:
                          regattaClassFilter === "ilca" ||
                          regattaDivisionFilter.startsWith("ILCA")
                            ? "Open"
                            : regattaDivisionFilter === "Gold" ||
                                regattaDivisionFilter === "Silver"
                              ? regattaDivisionFilter
                              : "Gold",
                        date: new Date().toISOString().split("T")[0],
                      });
                    }}
                    className="rounded-full bg-orange-600 hover:bg-orange-500 px-4 py-2.5 text-xs font-bold text-white flex items-center justify-center gap-1 shrink-0"
                  >
                    <Plus className="h-4 w-4" />
                    Add regatta
                  </button>
                  {isSuperadmin && (
                    <button
                      type="button"
                      disabled={isSeeding}
                      onClick={handleSeed2026}
                      className="rounded-full border border-sky-500/30 bg-sky-500/10 hover:bg-sky-500/20 px-3.5 py-2.5 text-xs font-bold text-sky-300 flex items-center justify-center gap-1.5 shrink-0 transition-colors disabled:opacity-50"
                      title="Attach 2026 calendar weekends to their class sheets. Does not publish new results."
                    >
                      {isSeeding ? (
                        <Loader2 className="h-3.5 w-3.5 animate-spin" />
                      ) : (
                        <Sparkles className="h-3.5 w-3.5 text-sky-400" />
                      )}
                      Link 2026 events
                    </button>
                  )}
                </div>

                <div className="grid grid-cols-1 lg:grid-cols-12 gap-4 w-full min-w-0 items-start">
                  {/* Compact event list */}
                  <div className="lg:col-span-5 glass-panel rounded-2xl border border-white/5 overflow-hidden flex flex-col max-h-[min(70vh,720px)]">
                    <div className="px-4 py-3 border-b border-white/5 flex items-center justify-between shrink-0">
                      <h3 className="text-sm font-bold text-white">
                        Events{" "}
                        <span className="text-slate-500 font-semibold">
                          ({grouped.events.length + (grouped.unassigned.length ? 1 : 0)})
                        </span>
                      </h3>
                    </div>
                    <div className="overflow-y-auto flex-1 divide-y divide-white/5">
                      {grouped.events.length === 0 && grouped.unassigned.length === 0 ? (
                        <AdminEmptyState
                          icon={Calendar}
                          title="No regattas match filters"
                          description="Try clearing search or changing division / ranking filters."
                        />
                      ) : (
                        <>
                          {grouped.events.map((event) => {
                            const active = selectedEventSlug === event.slug;
                            return (
                              <button
                                key={event.slug}
                                type="button"
                                onClick={() => {
                                  setSelectedEventSlug(event.slug);
                                  setEditingRegattaId(null);
                                  onClearSheet?.();
                                }}
                                className={`w-full text-left px-4 py-3 transition-colors hover:bg-white/[0.04] ${
                                  active
                                    ? "bg-orange-500/10 border-l-2 border-orange-500"
                                    : "border-l-2 border-transparent"
                                }`}
                              >
                                <p className="text-xs font-bold text-white truncate">
                                  {event.name}
                                </p>
                                <p className="text-[13px] text-slate-500 mt-0.5">
                                  {event.startDate || "—"}
                                  {event.venue ? ` · ${event.venue}` : ""}
                                </p>
                                <p className="text-[12px] text-slate-400 mt-1">
                                  {eventStatusLabel(event)}
                                </p>
                              </button>
                            );
                          })}
                          {grouped.unassigned.length > 0 && (
                            <button
                              type="button"
                              onClick={() => {
                                setSelectedEventSlug(UNASSIGNED_EVENT_SLUG);
                                setEditingRegattaId(null);
                                onClearSheet?.();
                              }}
                              className={`w-full text-left px-4 py-3 transition-colors hover:bg-white/[0.04] ${
                                selectedEventSlug === UNASSIGNED_EVENT_SLUG
                                  ? "bg-orange-500/10 border-l-2 border-orange-500"
                                  : "border-l-2 border-transparent"
                              }`}
                            >
                              <p className="text-xs font-bold text-white">
                                Unassigned sheets
                              </p>
                              <p className="text-[13px] text-slate-500 mt-0.5">
                                {grouped.unassigned.length} class sheet
                                {grouped.unassigned.length === 1 ? "" : "s"} with no weekend
                              </p>
                            </button>
                          )}
                        </>
                      )}
                    </div>
                  </div>

                  {/* Detail / edit pane */}
                  <div className="lg:col-span-7 glass-panel rounded-2xl border border-white/5 p-5 sm:p-6 min-h-[320px]">
                    {!selectedEvent && !editingRegattaId ? (
                      <div className="h-full flex flex-col items-center justify-center text-center py-16 px-4">
                        <Calendar className="h-10 w-10 text-slate-600 mb-3" />
                        <p className="text-sm font-bold text-slate-300">
                          Select an event
                        </p>
                        <p className="text-xs text-slate-500 mt-1 max-w-sm">
                          A weekend opens here. Each class is a scoreboard, and its
                          finishes sit on that class.
                        </p>
                      </div>
                    ) : editingRegattaId ? (
                      <div className="space-y-4">
                        <div className="flex items-start justify-between gap-3">
                          <div>
                            <h3 className="text-sm font-black text-white uppercase tracking-wider">
                              {editingRegattaId === "new"
                                ? "New class sheet"
                                : "Class sheet"}
                            </h3>
                            <p className="text-[13px] text-slate-500 mt-0.5">
                              {selectedEvent ? selectedEvent.name : "Scoreboard details"}
                            </p>
                            {editingRegattaId !== "new" && (
                              <div className="flex flex-wrap items-center gap-2 mt-2">
                                {onOpenResults && (
                                  <button
                                    type="button"
                                    onClick={() => onOpenResults(editingRegattaId)}
                                    className="inline-flex items-center gap-1.5 rounded-full bg-orange-600 hover:bg-orange-500 px-3 py-1 text-xs font-bold text-white shadow-sm transition-all"
                                  >
                                    <Trophy className="h-3 w-3" />
                                    Manage Results &amp; Scores
                                  </button>
                                )}
                                {regattaForm.slug && (
                                  <Link
                                    href={
                                      (regattaForm.boatClass || "").toLowerCase().includes("ilca")
                                        ? `/sg/ilca4/regattas/${regattaForm.slug}`
                                        : `/sg/optimist/regattas/${regattaForm.slug}`
                                    }
                                    target="_blank"
                                    className="inline-flex items-center gap-1 rounded-full border border-white/10 bg-white/5 hover:bg-white/10 px-2.5 py-1 text-[13px] font-semibold text-slate-300 transition-all"
                                  >
                                    <ExternalLink className="h-3 w-3 text-orange-400" />
                                    Public page
                                  </Link>
                                )}
                              </div>
                            )}
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
                        {norAmendmentForRegatta(regattaForm.name, regattaForm.slug) && (
                          <AdminNorAmendmentCard
                            notice={norAmendmentForRegatta(regattaForm.name, regattaForm.slug)!}
                          />
                        )}
                        <div className="grid grid-cols-1 sm:grid-cols-2 gap-3">
                          <div className="sm:col-span-2">
                            <label className="text-[12px] font-bold text-slate-500 uppercase">
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
                            <label className="text-[12px] font-bold text-slate-500 uppercase">
                              Date
                            </label>
                            <input
                              type="date"
                              value={String(regattaForm.date || "").slice(0, 10)}
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
                            <label className="text-[12px] font-bold text-slate-500 uppercase">
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
                            <label className="text-[12px] font-bold text-slate-500 uppercase">
                              Races completed
                            </label>
                            <input
                              type="number"
                              min={0}
                              value={regattaForm.raceCount ?? ""}
                              onChange={(e) => {
                                const raceCount = e.target.value;
                                const n = Number(raceCount);
                                const isIlca = /ilca|laser/i.test(
                                  String(regattaForm.boatClass || "")
                                );
                                setRegattaForm({
                                  ...regattaForm,
                                  raceCount,
                                  // ILCA: fewer than 3 races → non-ranking (insufficient races)
                                  ...(isIlca &&
                                  raceCount !== "" &&
                                  Number.isFinite(n) &&
                                  n < 3
                                    ? { countsForRanking: false }
                                    : {}),
                                });
                              }}
                              className="mt-1 w-full rounded-xl border border-white/5 bg-slate-950 px-3 py-2 text-white text-xs font-mono"
                              placeholder="e.g. 6"
                            />
                            <p className="mt-1 text-[13px] text-slate-500 leading-snug">
                              ILCA 4/6: if fewer than <strong>3</strong> races are
                              completed, the event is non-ranking for series.
                            </p>
                          </div>
                          <div>
                            <label className="text-[12px] font-bold text-slate-500 uppercase">
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
                              {/ilca|laser|radial/i.test(String(regattaForm.boatClass || "")) ? (
                                <option value="Open">Open</option>
                              ) : (
                                <>
                                  <option value="Gold">Gold only</option>
                                  <option value="Silver">Silver only</option>
                                  <option value="Both">Both</option>
                                </>
                              )}
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
                                    // Keep Gold/Silver/Both division even when non-ranking
                                    // (e.g. SG selection trial in Gold fleet that does not score Best 3 of 5)
                                  })
                                }
                                className="rounded border-slate-600"
                              />
                              <span>
                                <strong className="text-white">
                                  Counts for series ranking
                                </strong>
                                <span className="block text-[13px] text-slate-500 leading-snug">
                                  Optimist: Gold/Silver Best 3 of 5. ILCA 4/6: high-points
                                  Best 3 of last 5. Turn off for trials, training, or when
                                  too few races were completed.
                                </span>
                              </span>
                            </label>
                            {regattaForm.countsForRanking === false && (
                              <p className="mt-2 rounded-lg border border-sky-500/30 bg-sky-500/10 px-2 py-1.5 text-[11px] font-bold text-sky-800">
                                Non-ranking — excluded from series (still on profiles /
                                logbook)
                              </p>
                            )}
                            {/ilca|laser/i.test(
                              String(regattaForm.boatClass || "")
                            ) &&
                              regattaForm.raceCount !== "" &&
                              Number(regattaForm.raceCount) < 3 && (
                                <p className="mt-2 rounded-lg border border-amber-500/30 bg-amber-500/10 px-2 py-1.5 text-[11px] font-bold text-amber-800">
                                  Insufficient races ({String(regattaForm.raceCount)}{" "}
                                  &lt; 3) — this ILCA event is treated as non-ranking for
                                  national series.
                                </p>
                              )}
                          </div>
                          <div>
                            <label className="text-[12px] font-bold text-slate-500 uppercase">
                              Geography
                            </label>
                            <GeographySelect
                              value={regattaForm.geography || "SGP"}
                              onChange={(v) =>
                                setRegattaForm({
                                  ...regattaForm,
                                  geography: v || "SGP",
                                })
                              }
                            />
                          </div>
                          <div>
                            <div className="flex items-center justify-between">
                              <label className="text-[12px] font-bold text-slate-500 uppercase">
                                Class
                              </label>
                              <div className="flex flex-wrap justify-end gap-1 max-w-[16rem]">
                                {ADMIN_BOAT_CLASS_GROUPS.map((group) => (
                                  <span key={group.family} className="inline-flex gap-1">
                                    {group.classes.map((cls) => (
                                      <button
                                        key={cls}
                                        type="button"
                                        onClick={() =>
                                          setRegattaForm({
                                            ...regattaForm,
                                            boatClass: cls,
                                            division:
                                              group.family === "ILCA" &&
                                              ["", "Gold", "Silver", "Both"].includes(
                                                regattaForm.division || ""
                                              )
                                                ? "Open"
                                                : group.family === "Optimist" &&
                                                    (regattaForm.division === "Open" ||
                                                      !regattaForm.division)
                                                  ? "Gold"
                                                  : regattaForm.division,
                                          })
                                        }
                                        className={`px-1.5 py-0.5 rounded text-[13px] font-bold transition-all ${
                                          regattaForm.boatClass === cls
                                            ? "bg-[var(--sp-harbour-teal)] text-white"
                                            : "bg-white/5 text-slate-400 hover:text-white"
                                        }`}
                                      >
                                        {group.family === "ILCA" ? cls.replace("ILCA ", "") : cls}
                                      </button>
                                    ))}
                                  </span>
                                ))}
                              </div>
                            </div>
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
                              placeholder="Optimist, ILCA 4, WingFoil..."
                            />
                          </div>

                          {/* Calendar & Schedule metadata */}
                          <div>
                            <label className="text-[12px] font-bold text-slate-500 uppercase">
                              End Date (optional)
                            </label>
                            <input
                              type="date"
                              value={String(regattaForm.endDate || "").slice(0, 10)}
                              onChange={(e) =>
                                setRegattaForm({
                                  ...regattaForm,
                                  endDate: e.target.value,
                                })
                              }
                              className="mt-1 w-full rounded-xl border border-white/5 bg-slate-950 px-3 py-2 text-white text-xs font-mono"
                            />
                          </div>
                          <div>
                            <label className="text-[12px] font-bold text-slate-500 uppercase">
                              Venue
                            </label>
                            <input
                              type="text"
                              value={regattaForm.venue || ""}
                              onChange={(e) =>
                                setRegattaForm({
                                  ...regattaForm,
                                  venue: e.target.value,
                                })
                              }
                              className="mt-1 w-full rounded-xl border border-white/5 bg-slate-950 px-3 py-2 text-white text-xs"
                              placeholder="e.g. National Sailing Centre / Changi Sailing Club"
                            />
                          </div>
                          <div>
                            <label className="text-[12px] font-bold text-slate-500 uppercase">
                              Organizer / Host
                            </label>
                            <input
                              type="text"
                              value={regattaForm.organizer || ""}
                              onChange={(e) =>
                                setRegattaForm({
                                  ...regattaForm,
                                  organizer: e.target.value,
                                })
                              }
                              className="mt-1 w-full rounded-xl border border-white/5 bg-slate-950 px-3 py-2 text-white text-xs"
                              placeholder="e.g. Singapore Sailing Federation"
                            />
                          </div>
                          <div className="sm:col-span-2">
                            <label className="flex items-center gap-2 text-xs text-slate-300 cursor-pointer">
                              <input
                                type="checkbox"
                                checked={Boolean(regattaForm.isSelectionTrial)}
                                onChange={(e) =>
                                  setRegattaForm({
                                    ...regattaForm,
                                    isSelectionTrial: e.target.checked,
                                  })
                                }
                                className="rounded border-slate-600"
                              />
                              <span>
                                <strong className="text-amber-300">
                                  Official Selection Trial / Qualifier
                                </strong>
                                <span className="block text-[13px] text-slate-500 leading-snug">
                                  Highlights this event on the upcoming calendar with a special Selection Trial badge.
                                </span>
                              </span>
                            </label>
                          </div>
                          <div>
                            <label className="text-[12px] font-bold text-slate-500 uppercase">
                              Notice of Race / Official Notice Board URL
                            </label>
                            <input
                              type="url"
                              value={regattaForm.norUrl || ""}
                              onChange={(e) =>
                                setRegattaForm({
                                  ...regattaForm,
                                  norUrl: e.target.value,
                                })
                              }
                              className="mt-1 w-full rounded-xl border border-white/5 bg-slate-950 px-3 py-2 text-white text-xs"
                              placeholder="https://www.racingrulesofsailing.org/... or nor.pdf"
                            />
                          </div>
                          <div>
                            <label className="text-[12px] font-bold text-slate-500 uppercase">
                              Registration / Entry Portal URL
                            </label>
                            <input
                              type="url"
                              value={regattaForm.registrationUrl || ""}
                              onChange={(e) =>
                                setRegattaForm({
                                  ...regattaForm,
                                  registrationUrl: e.target.value,
                                })
                              }
                              className="mt-1 w-full rounded-xl border border-white/5 bg-slate-950 px-3 py-2 text-white text-xs"
                              placeholder="https://singaporesailing.org/..."
                            />
                          </div>
                          <div className="sm:col-span-2">
                            <label className="text-[12px] font-bold text-slate-500 uppercase">
                              Schedule Notes / Description
                            </label>
                            <input
                              type="text"
                              value={regattaForm.scheduleNotes || ""}
                              onChange={(e) =>
                                setRegattaForm({
                                  ...regattaForm,
                                  scheduleNotes: e.target.value,
                                })
                              }
                              className="mt-1 w-full rounded-xl border border-white/5 bg-slate-950 px-3 py-2 text-white text-xs"
                              placeholder="e.g. Official selection trial for 2026 Perth Camp and Asian Games"
                            />
                          </div>
                        </div>
                        <div className="flex flex-wrap justify-end gap-2 border-t border-white/5 pt-4">
                          <button
                            type="button"
                            onClick={() => {
                              setEditingRegattaId(null);
                              onClearSheet?.();
                            }}
                            className="rounded-full bg-slate-800 px-4 py-2 text-xs font-bold text-slate-400 hover:text-white"
                          >
                            Close
                          </button>
                          <button
                            type="button"
                            disabled={saving}
                            onClick={handleSaveRegatta}
                            className="rounded-full bg-orange-600 px-5 py-2 text-xs font-bold text-white hover:bg-orange-500 disabled:opacity-40"
                          >
                            {saving ? "Saving…" : "Save class sheet"}
                          </button>
                        </div>
                        {editingRegattaId !== "new" && resultsEditor}
                      </div>
                    ) : selectedEvent ? (
                      <div className="space-y-5">
                        <div>
                          <h3 className="text-sm font-black text-white uppercase tracking-wider">
                            {selectedEvent.name}
                          </h3>
                          <p className="text-[13px] text-slate-500 mt-1">
                            {selectedEvent.startDate || "No date"}
                            {selectedEvent.endDate && selectedEvent.endDate !== selectedEvent.startDate
                              ? ` – ${selectedEvent.endDate}`
                              : ""}
                            {selectedEvent.venue ? ` · ${selectedEvent.venue}` : ""}
                          </p>
                          <p className="text-[12px] text-slate-400 mt-1">
                            {selectedEvent.slug === UNASSIGNED_EVENT_SLUG
                              ? "These class sheets are not attached to a calendar weekend."
                              : eventStatusLabel(selectedEvent)}
                          </p>
                        </div>
                        {selectedEvent.slug !== UNASSIGNED_EVENT_SLUG && (
                          <div className="rounded-xl border border-white/10 bg-white/[0.03] p-3 text-[13px] text-slate-300 space-y-1">
                            <p>{selectedEvent.countsForRanking ? "Ranking regatta" : "Not a ranking regatta"}</p>
                            {selectedEvent.isSelectionTrial && <p>Selection trial</p>}
                            {selectedEvent.organizer && <p>{selectedEvent.organizer}</p>}
                            {selectedEvent.norUrl && (
                              <a href={selectedEvent.norUrl} target="_blank" rel="noreferrer" className="inline-flex items-center gap-1 text-[var(--sp-harbour-teal)]">
                                <ExternalLink className="h-3 w-3" /> Notice of race
                              </a>
                            )}
                          </div>
                        )}
                        <div className="space-y-2">
                          <h4 className="text-[12px] font-bold uppercase text-slate-500">Classes</h4>
                          {selectedEvent.sheets.length === 0 && selectedEvent.missingClasses.length === 0 && (
                            <p className="text-xs text-slate-500">No class sheets yet.</p>
                          )}
                          {selectedEvent.sheets.map((sheet) => (
                            <button
                              key={sheet.id}
                              type="button"
                              onClick={() => {
                                setEditingRegattaId(sheet.id);
                                setRegattaForm(formFrom(sheet));
                                onOpenResults?.(sheet.id);
                              }}
                              className="w-full text-left rounded-xl border border-white/10 px-3 py-2 hover:bg-white/[0.04]"
                            >
                              <span className="text-xs font-bold text-white">{sheetClassLabel(sheet)}</span>
                              <span className="block text-[12px] text-slate-500 mt-0.5">
                                {sheet.status || "draft"}
                                {sheet.raceCount != null ? ` · ${sheet.raceCount} races` : ""}
                                {sheet.totalFleetSize != null ? ` · fleet ${sheet.totalFleetSize}` : ""}
                                {sheet.countsForRanking === false ? " · non-ranking" : ""}
                              </span>
                            </button>
                          ))}
                          {selectedEvent.missingClasses.map((label) => (
                            <div key={label} className="flex items-center justify-between gap-3 rounded-xl border border-dashed border-white/15 px-3 py-2">
                              <div>
                                <span className="text-xs font-bold text-slate-300">{label}</span>
                                <span className="block text-[12px] text-slate-500 mt-0.5">Awaiting results</span>
                              </div>
                              <button
                                type="button"
                                onClick={() => {
                                  const optimist = /optimist/i.test(label);
                                  setEditingRegattaId("new");
                                  setRegattaForm({
                                    ...emptyRegattaForm(),
                                    name: `${selectedEvent.name} ${label}`,
                                    date: selectedEvent.startDate,
                                    endDate: selectedEvent.endDate || "",
                                    venue: selectedEvent.venue || "",
                                    organizer: selectedEvent.organizer || "",
                                    norUrl: selectedEvent.norUrl || "",
                                    registrationUrl: selectedEvent.registrationUrl || "",
                                    boatClass: optimist ? "Optimist" : label,
                                    division: /gold/i.test(label) ? "Gold" : /silver/i.test(label) ? "Silver" : "Open",
                                    countsForRanking: selectedEvent.countsForRanking,
                                    isSelectionTrial: selectedEvent.isSelectionTrial,
                                  });
                                }}
                                className="shrink-0 rounded-full border border-white/15 px-2.5 py-1 text-[12px] font-bold text-slate-200 hover:bg-white/10"
                              >
                                Add sheet
                              </button>
                            </div>
                          ))}
                        </div>
                      </div>
                    ) : null}
                  </div>
                </div>
              </div>
  );
}
