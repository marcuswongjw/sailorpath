"use client";

import { useEffect, useMemo, useRef, useState, type ReactNode } from "react";
import Link from "next/link";
import {
  Plus,
  Trash2,
  Calendar,
  Trophy,
  ExternalLink,
  Sparkles,
  Loader2,
  Wand2,
  Link2,
  ArrowLeft,
  FileText,
  ChevronDown,
  ChevronUp,
  Globe,
  Sliders,
} from "lucide-react";
import { slugifyWithDate, slugify } from "@/lib/slug";
import { classResultsHref } from "@/lib/calendar/calendarResultLinks";
import { AdminNorAmendmentCard } from "@/components/admin/AdminNorAmendmentCard";
import {
  ADMIN_BOAT_CLASS_GROUPS,
  ILCA_FLEETS,
  OPTIMIST_FLEETS,
  REGATTA_CLASS_FAMILIES,
} from "@/lib/admin/regattaClass";
import { norAmendmentForRegatta } from "@/lib/admin/norAmendments";
import type { RegattaAdmin } from "@/types/regatta";
import { GeographySelect } from "@/components/CountrySelect";
import {
  emptyRegattaForm,
  type RegattaFormState,
} from "@/components/admin/adminForms";
import { useFeedback } from "@/components/ui/FeedbackProvider";
import {
  eventStatusLabel,
  groupRegattaEvents,
  missingClassesFor,
  sheetClassLabel,
  UNASSIGNED_EVENT_SLUG,
  type AdminEventGroup,
  type GroupableRegatta,
} from "@/lib/admin/groupRegattaEvents";

type SavedCalendarEvent = {
  slug: string;
  name: string;
  startDate: string;
  endDate?: string | null;
  venue?: string | null;
  organizer?: string | null;
  classes?: string[] | null;
  norUrl?: string | null;
  registrationUrl?: string | null;
  countsForRanking?: boolean | null;
  isSelectionTrial?: boolean | null;
  keyDeadlines?: string | null;
};

const DEFAULT_CALENDAR_CLASSES = [
  "Optimist",
  "ILCA 4",
  "ILCA 6",
  "ILCA 7",
  "29er",
  "420",
  "Techno 293",
  "iQFOiL",
  "WingFoil",
  "RS Feva",
] as const;

type CalendarFormState = {
  name: string;
  startDate: string;
  endDate: string;
  venue: string;
  organizer: string;
  classes: string;
  norUrl: string;
  registrationUrl: string;
  keyDeadlines: string;
  countsForRanking: boolean;
  isSelectionTrial: boolean;
};

function withSavedEvent(
  event: AdminEventGroup,
  saved?: SavedCalendarEvent
): AdminEventGroup {
  if (!saved) return event;
  const classes = (saved.classes || []).map((item) => item.trim()).filter(Boolean);
  const expectedClasses = classes.length > 0 ? classes : event.expectedClasses;
  return {
    ...event,
    name: saved.name || event.name,
    startDate: String(saved.startDate || event.startDate).slice(0, 10),
    endDate: saved.endDate ? String(saved.endDate).slice(0, 10) : "",
    venue: saved.venue ?? "",
    organizer: saved.organizer ?? "",
    norUrl: saved.norUrl ?? "",
    registrationUrl: saved.registrationUrl ?? "",
    countsForRanking: saved.countsForRanking ?? event.countsForRanking,
    isSelectionTrial: Boolean(saved.isSelectionTrial),
    keyDeadlines: saved.keyDeadlines ?? "",
    expectedClasses,
    missingClasses: missingClassesFor(expectedClasses, [
      ...event.sheets,
      ...event.shells,
    ]),
  };
}

function calendarFormFrom(event: AdminEventGroup): CalendarFormState {
  return {
    name: event.name || "",
    startDate: event.startDate || "",
    endDate: event.endDate || "",
    venue: event.venue || "",
    organizer: event.organizer || "",
    classes: event.expectedClasses.join(", "),
    norUrl: event.norUrl || "",
    registrationUrl: event.registrationUrl || "",
    keyDeadlines: event.keyDeadlines || "",
    countsForRanking: event.countsForRanking,
    isSelectionTrial: event.isSelectionTrial,
  };
}

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
  invalidateRegattas?: () => void;
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
  invalidateRegattas,
  onOpenResults,
  onClearSheet,
  activeSheetId,
  resultsEditor,
}: AdminRegattasPanelProps) {
  const { toast } = useFeedback();
  const [isSeeding, setIsSeeding] = useState(false);
  const [selectedEventSlug, setSelectedEventSlug] = useState<string | null>(null);
  const [savedEvents, setSavedEvents] = useState<Record<string, SavedCalendarEvent>>({});
  const [calendarForm, setCalendarForm] = useState<CalendarFormState | null>(null);
  const [calendarSaving, setCalendarSaving] = useState(false);
  const calendarSlug = useRef("");
  const [sheetTab, setSheetTab] = useState<"details" | "results">("details");
  const [showCalendarForm, setShowCalendarForm] = useState(false);
  const [showLogistics, setShowLogistics] = useState(false);

  const grouped = useMemo(
    () => groupRegattaEvents(filteredRegattaList),
    [filteredRegattaList]
  );

  const effectiveEventSlug =
    selectedEventSlug ?? (grouped.events[0]?.slug || null);

  const selectedEvent: AdminEventGroup | null =
    effectiveEventSlug === UNASSIGNED_EVENT_SLUG
      ? {
          slug: UNASSIGNED_EVENT_SLUG,
          name: "Unassigned sheets",
          startDate: "",
          countsForRanking: false,
          isSelectionTrial: false,
          expectedClasses: [],
          missingClasses: [],
          sheets: grouped.unassigned,
          shells: [],
          shell: null,
        }
      : grouped.events.find((event) => event.slug === effectiveEventSlug) ?? null;
  const selectedEventView = selectedEvent
    ? withSavedEvent(selectedEvent, savedEvents[selectedEvent.slug])
    : null;

  const canonicalPublicHref = useMemo(() => {
    if (!regattaForm.slug) return null;
    return classResultsHref({
      boatClass: regattaForm.boatClass,
      slug: regattaForm.slug,
    });
  }, [regattaForm.boatClass, regattaForm.slug]);

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

  const seenSheetId = useRef<string | null>(null);

  useEffect(() => {
    if ((activeSheetId || "") === (seenSheetId.current || "")) return;
    if (!activeSheetId) {
      seenSheetId.current = "";
      return;
    }
    const row = filteredRegattaList.find((item) => item.id === activeSheetId);
    if (!row) return;
    const event = grouped.events.find(
      (item) =>
        item.sheets.some((sheet) => sheet.id === activeSheetId) ||
        item.shells.some((sheet) => sheet.id === activeSheetId)
    );
    seenSheetId.current = activeSheetId;
    // eslint-disable-next-line react-hooks/set-state-in-effect
    setSelectedEventSlug(event ? event.slug : UNASSIGNED_EVENT_SLUG);
    setEditingRegattaId(row.id);
    setRegattaForm(formFrom(row));
    setSheetTab("results");
  }, [activeSheetId, filteredRegattaList, grouped.events, setEditingRegattaId, setRegattaForm]);

  useEffect(() => {
    let cancelled = false;
    void fetch("/api/admin/regatta-events", { credentials: "include" })
      .then((res) => res.json())
      .then((body: { events?: SavedCalendarEvent[] }) => {
        if (cancelled || !Array.isArray(body.events)) return;
        const next: Record<string, SavedCalendarEvent> = {};
        for (const event of body.events) next[event.slug] = event;
        setSavedEvents(next);
      })
      .catch(() => {
        /* Static calendar copy still fills the form. */
      });
    return () => {
      cancelled = true;
    };
  }, []);

  useEffect(() => {
    if (!selectedEventView || selectedEventView.slug === UNASSIGNED_EVENT_SLUG) return;
    const token = `${selectedEventView.slug}:${savedEvents[selectedEventView.slug]?.name ?? ""}:${savedEvents[selectedEventView.slug]?.startDate ?? ""}`;
    if (calendarSlug.current === token) return;
    calendarSlug.current = token;
    setCalendarForm(calendarFormFrom(selectedEventView));
  }, [selectedEventView, savedEvents]);

  const handleSaveCalendar = async () => {
    if (!selectedEventView || !calendarForm || calendarSaving) return;
    if (!isSuperadmin) {
      toast.error("Only a superadmin can update the public calendar.");
      return;
    }
    setCalendarSaving(true);
    try {
      const res = await fetch("/api/admin/regatta-events", {
        method: "PATCH",
        credentials: "include",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({
          slug: selectedEventView.slug,
          ...calendarForm,
        }),
      });
      const data = await res.json();
      if (!res.ok) throw new Error(data.error || "Could not save the calendar card");
      const saved = data.event as SavedCalendarEvent;
      setSavedEvents((prev) => ({ ...prev, [saved.slug]: saved }));
      invalidateRegattas?.();
      const held = Number(data.sheetsKeptNonRanking || 0);
      const updated = Number(data.sheetsUpdated || 0);
      toast.success(
        held > 0
          ? `Calendar card saved. ${held} class sheet${held === 1 ? "" : "s"} stayed non-ranking because fewer than 3 races were completed.`
          : updated > 0
            ? "Calendar card saved. Class sheets now use this ranking setting."
            : "Calendar card saved. No class sheets are linked yet, so series scores are unchanged."
      );
    } catch (err: unknown) {
      toast.error(err instanceof Error ? err.message : "Could not save the calendar card");
    } finally {
      setCalendarSaving(false);
    }
  };

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
                <div className="glass-panel rounded-2xl border border-slate-200 p-4 flex flex-col sm:flex-row sm:items-end gap-3 w-full">
                  <div className="flex-1 min-w-0">
                    <label className="text-[12px] font-bold text-slate-700 uppercase tracking-wider">
                      Search events
                    </label>
                    <input
                      type="search"
                      value={regattaSearch}
                      onChange={(e) => setRegattaSearch(e.target.value)}
                      placeholder="Name, date, division, class…"
                      className="mt-1 w-full rounded-xl border border-slate-300 bg-white px-3 py-2 text-xs text-slate-900 placeholder:text-slate-400 focus:outline-none focus:border-orange-500"
                    />
                  </div>
                  <div>
                    <label className="text-[12px] font-bold text-slate-700 uppercase tracking-wider">
                      Class
                    </label>
                    <select
                      value={regattaClassFilter}
                      onChange={(e) => {
                        setRegattaClassFilter?.(e.target.value);
                        setRegattaDivisionFilter("all");
                      }}
                      className="mt-1 w-full sm:w-36 rounded-xl border border-slate-300 bg-white px-3 py-2 text-xs text-slate-900 font-medium focus:outline-none focus:border-orange-500"
                    >
                      {REGATTA_CLASS_FAMILIES.map((family) => (
                        <option key={family.id} value={family.id}>
                          {family.label}
                        </option>
                      ))}
                    </select>
                  </div>
                  <div>
                    <label className="text-[12px] font-bold text-slate-700 uppercase tracking-wider">
                      {regattaClassFilter === "ilca" ? "ILCA fleet" : "Fleet"}
                    </label>
                    <select
                      value={regattaDivisionFilter}
                      onChange={(e) => setRegattaDivisionFilter(e.target.value)}
                      className="mt-1 w-full sm:w-36 rounded-xl border border-slate-300 bg-white px-3 py-2 text-xs text-slate-900 font-medium focus:outline-none focus:border-orange-500"
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
                    <label className="text-[12px] font-bold text-slate-700 uppercase tracking-wider">
                      Ranking
                    </label>
                    <select
                      value={regattaRankingFilter}
                      onChange={(e) => setRegattaRankingFilter(e.target.value)}
                      className="mt-1 w-full sm:w-36 rounded-xl border border-slate-300 bg-white px-3 py-2 text-xs text-slate-900 font-medium focus:outline-none focus:border-orange-500"
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
                      setSheetTab("details");
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
                      className="rounded-full border border-sky-300 bg-sky-50 hover:bg-sky-100 px-3.5 py-2.5 text-xs font-bold text-sky-800 flex items-center justify-center gap-1.5 shrink-0 transition-colors disabled:opacity-50 shadow-xs"
                      title="Attach 2026 calendar weekends to their class sheets. Does not publish new results."
                    >
                      {isSeeding ? (
                        <Loader2 className="h-3.5 w-3.5 animate-spin" />
                      ) : (
                        <Sparkles className="h-3.5 w-3.5 text-sky-600" />
                      )}
                      Link 2026 events
                    </button>
                  )}
                </div>

                {/* Top Event / Regatta Dropdown Selector Bar */}
                <div className="glass-panel rounded-2xl border border-slate-200 p-3.5 sm:p-4 flex flex-col md:flex-row md:items-center justify-between gap-3 w-full">
                  <div className="flex items-center gap-3 flex-1 min-w-0">
                    <div className="h-10 w-10 rounded-xl bg-orange-100 border border-orange-200 flex items-center justify-center shrink-0">
                      <Calendar className="h-5 w-5 text-orange-600" />
                    </div>
                    <div className="flex-1 min-w-0">
                      <div className="flex items-center justify-between mb-1">
                        <label
                          htmlFor="admin-regatta-selector"
                          className="text-[11px] font-black uppercase tracking-wider text-slate-700"
                        >
                          Selected Regatta Event ({grouped.events.length + (grouped.unassigned.length ? 1 : 0)})
                        </label>
                        {selectedEventView && (
                          <span className="text-[11px] font-medium text-slate-600 hidden sm:inline">
                            {selectedEventView.sheets.length} class sheet{selectedEventView.sheets.length === 1 ? "" : "s"}
                          </span>
                        )}
                      </div>
                      <select
                        id="admin-regatta-selector"
                        value={effectiveEventSlug || ""}
                        onChange={(e) => {
                          setSelectedEventSlug(e.target.value);
                          setEditingRegattaId(null);
                          onClearSheet?.();
                        }}
                        className="w-full rounded-xl border border-slate-300 bg-white hover:border-orange-500 focus:border-orange-500 px-3.5 py-2.5 text-xs sm:text-sm font-bold text-slate-900 shadow-xs focus:outline-none transition-colors"
                      >
                        {grouped.events.length === 0 && grouped.unassigned.length === 0 ? (
                          <option value="">No regattas match filters</option>
                        ) : null}
                        {grouped.events.map((event) => {
                          const shown = withSavedEvent(event, savedEvents[event.slug]);
                          const status = eventStatusLabel(event);
                          return (
                            <option key={event.slug} value={event.slug}>
                              {shown.name} ({shown.startDate || "No date"}) — {status}
                            </option>
                          );
                        })}
                        {grouped.unassigned.length > 0 && (
                          <option value={UNASSIGNED_EVENT_SLUG}>
                            Unassigned class sheets ({grouped.unassigned.length} sheet{grouped.unassigned.length === 1 ? "" : "s"} without weekend)
                          </option>
                        )}
                      </select>
                    </div>
                  </div>

                  {selectedEventView && selectedEventView.slug !== UNASSIGNED_EVENT_SLUG && (
                    <div className="flex flex-wrap items-center gap-2 pt-2 md:pt-0 border-t md:border-t-0 border-slate-200 shrink-0">
                      <span className="text-xs px-2.5 py-1 rounded-full font-bold bg-slate-100 border border-slate-200 text-slate-800">
                        {selectedEventView.startDate || "Date TBD"}
                        {selectedEventView.endDate ? ` to ${selectedEventView.endDate}` : ""}
                      </span>
                      {selectedEventView.venue && (
                        <span className="text-xs px-2.5 py-1 rounded-full font-semibold bg-slate-100 border border-slate-200 text-slate-700 truncate max-w-[180px]">
                          {selectedEventView.venue}
                        </span>
                      )}
                      <span
                        className={`text-xs px-2.5 py-1 rounded-full font-bold border ${
                          selectedEventView.countsForRanking
                            ? "bg-emerald-100 text-emerald-800 border-emerald-300"
                            : "bg-sky-100 text-sky-800 border-sky-300"
                        }`}
                      >
                        {selectedEventView.countsForRanking ? "Series Ranking" : "Non-Ranking"}
                      </span>
                    </div>
                  )}
                </div>

                {/* Detail / edit pane */}
                <div className="w-full glass-panel rounded-2xl border border-white/5 p-5 sm:p-6 min-h-[320px] transition-all">
                  {!selectedEvent && !editingRegattaId ? (
                    <div className="h-full flex flex-col items-center justify-center text-center py-16 px-4">
                      <Calendar className="h-10 w-10 text-slate-600 mb-3" />
                      <p className="text-sm font-bold text-slate-300">
                        Select a regatta event
                      </p>
                      <p className="text-xs text-slate-500 mt-1 max-w-sm">
                        Choose a regatta from the dropdown above to view its class sheets, edit details, or update race scores.
                      </p>
                    </div>
                  ) : editingRegattaId ? (
                      <div className="space-y-5">
                        {/* Sheet Header */}
                        <div className="flex flex-col sm:flex-row sm:items-center justify-between gap-3 pb-3 border-b border-white/5">
                          <div className="flex items-center gap-2 flex-wrap min-w-0">
                            <button
                              type="button"
                              onClick={() => {
                                setEditingRegattaId(null);
                                onClearSheet?.();
                              }}
                              className="inline-flex items-center gap-1 text-xs font-bold text-slate-400 hover:text-white transition-colors mr-1 p-1 rounded hover:bg-white/5"
                              title="Back to weekend events"
                            >
                              <ArrowLeft className="h-4 w-4" />
                              <span className="hidden sm:inline">Events</span>
                            </button>

                            <div>
                              <div className="flex items-center gap-2 flex-wrap">
                                <span className="text-[11px] font-black uppercase tracking-wider text-orange-400 bg-orange-500/10 px-2 py-0.5 rounded border border-orange-500/20">
                                  {regattaForm.boatClass || "Optimist"}
                                </span>
                                {regattaForm.division && (
                                  <span className="text-[11px] font-bold uppercase tracking-wider text-slate-300 bg-white/5 px-2 py-0.5 rounded border border-white/10">
                                    {regattaForm.division}
                                  </span>
                                )}
                                <span
                                  className={`text-[11px] font-bold uppercase tracking-wider px-2 py-0.5 rounded border ${
                                    regattaForm.countsForRanking === false ||
                                    (regattaForm.raceCount !== "" && Number(regattaForm.raceCount) < 3)
                                      ? "text-sky-300 bg-sky-500/10 border-sky-500/20"
                                      : "text-emerald-300 bg-emerald-500/10 border-emerald-500/20"
                                  }`}
                                >
                                  {regattaForm.countsForRanking === false ||
                                  (regattaForm.raceCount !== "" && Number(regattaForm.raceCount) < 3)
                                    ? "Non-Ranking"
                                    : "Series Ranking"}
                                </span>
                                {regattaForm.isSelectionTrial && (
                                  <span className="text-[11px] font-bold uppercase tracking-wider text-amber-300 bg-amber-500/10 px-2 py-0.5 rounded border border-amber-500/20">
                                    Selection Trial
                                  </span>
                                )}
                              </div>
                              <h3 className="text-base font-black text-white mt-1 truncate max-w-lg">
                                {editingRegattaId === "new"
                                  ? "New Regatta Sheet"
                                  : regattaForm.name || "Untitled Regatta"}
                              </h3>
                            </div>
                          </div>

                          {/* Header quick actions */}
                          <div className="flex items-center gap-2 shrink-0 self-end sm:self-auto">
                            {canonicalPublicHref && (
                              <Link
                                href={canonicalPublicHref}
                                target="_blank"
                                className="inline-flex items-center gap-1 rounded-full border border-white/10 bg-white/5 hover:bg-white/10 px-3 py-1 text-xs font-semibold text-slate-300 transition-all hover:text-white"
                                title="Open public leaderboard in new tab"
                              >
                                <ExternalLink className="h-3 w-3 text-orange-400" />
                                <span>Public page</span>
                              </Link>
                            )}
                            {editingRegattaId !== "new" && (
                              <button
                                type="button"
                                onClick={() => handleDeleteRegatta(editingRegattaId)}
                                className="p-1.5 rounded-full border border-white/10 bg-white/5 text-slate-500 hover:text-rose-400 hover:border-rose-500/30 hover:bg-rose-500/10 transition-colors"
                                title="Delete regatta and cascade results"
                              >
                                <Trash2 className="h-3.5 w-3.5" />
                              </button>
                            )}
                          </div>
                        </div>

                        {/* Segmented Workspace Tabs */}
                        <div className="flex items-center gap-2 border-b border-white/10 pb-3">
                          <button
                            type="button"
                            onClick={() => setSheetTab("details")}
                            className={`inline-flex items-center gap-1.5 px-3.5 py-1.5 rounded-xl text-xs font-bold transition-all ${
                              sheetTab === "details"
                                ? "bg-[var(--sp-harbour-teal)] text-white shadow-sm"
                                : "text-slate-400 hover:text-white hover:bg-white/5"
                            }`}
                          >
                            <FileText className="h-3.5 w-3.5" />
                            <span>Regatta Details &amp; Settings</span>
                          </button>
                          <button
                            type="button"
                            onClick={() => {
                              setSheetTab("results");
                              if (editingRegattaId && editingRegattaId !== "new") {
                                onOpenResults?.(editingRegattaId);
                              }
                            }}
                            disabled={editingRegattaId === "new"}
                            className={`inline-flex items-center gap-1.5 px-3.5 py-1.5 rounded-xl text-xs font-bold transition-all ${
                              sheetTab === "results"
                                ? "bg-[var(--sp-harbour-teal)] text-white shadow-sm"
                                : "text-slate-400 hover:text-white hover:bg-white/5 disabled:opacity-40"
                            }`}
                            title={
                              editingRegattaId === "new"
                                ? "Save regatta details first before entering results"
                                : "Manage sailor finishes and race scores"
                            }
                          >
                            <Trophy className="h-3.5 w-3.5" />
                            <span>Results &amp; Race Scores</span>
                            {regattaForm.totalFleetSize ? (
                              <span
                                className={`text-[10px] px-1.5 py-0.5 rounded-full font-mono font-medium ${
                                  sheetTab === "results"
                                    ? "bg-white/20 text-white"
                                    : "bg-white/10 text-slate-400"
                                }`}
                              >
                                fleet {regattaForm.totalFleetSize}
                              </span>
                            ) : null}
                          </button>
                        </div>

                        {/* TAB 1: REGATTA DETAILS & SETTINGS */}
                        {sheetTab === "details" && (
                          <div className="space-y-4">
                            {norAmendmentForRegatta(regattaForm.name, regattaForm.slug) && (
                              <AdminNorAmendmentCard
                                notice={norAmendmentForRegatta(regattaForm.name, regattaForm.slug)!}
                              />
                            )}

                            {/* Primary Details Card */}
                            <div className="rounded-2xl border border-white/5 bg-[#131520] p-4 sm:p-5 space-y-4">
                              <h4 className="text-xs font-black uppercase tracking-wider text-slate-400 flex items-center gap-1.5">
                                <Calendar className="h-3.5 w-3.5 text-orange-400" />
                                Event Identification
                              </h4>

                              <div className="grid grid-cols-1 sm:grid-cols-2 gap-3">
                                <div className="sm:col-span-2">
                                  <label className="text-[11px] font-bold text-slate-400 uppercase">
                                    Regatta / Sheet Name
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
                                    className="mt-1 w-full rounded-xl border border-white/10 bg-slate-950 px-3 py-2 text-white text-xs focus:outline-none focus:border-orange-500/50"
                                    placeholder="e.g. Pesta Sukan 2026 (ILCA 6)"
                                  />
                                </div>

                                {/* EDITABLE SLUG WITH AUTO-GENERATE & LIVE PREVIEW */}
                                <div className="sm:col-span-2 rounded-xl border border-orange-500/20 bg-orange-500/[0.04] p-3.5 space-y-2">
                                  <div className="flex items-center justify-between gap-2">
                                    <div>
                                      <label className="text-[11px] font-black uppercase tracking-wider text-orange-300 flex items-center gap-1.5">
                                        <Link2 className="h-3.5 w-3.5 text-orange-400" />
                                        URL Slug
                                      </label>
                                      <p className="text-[11px] text-slate-400 mt-0.5">
                                        The unique web path for this regatta. Results and rankings stay safe when modified.
                                      </p>
                                    </div>
                                    <button
                                      type="button"
                                      onClick={() => {
                                        const auto = slugifyWithDate(
                                          regattaForm.name,
                                          regattaForm.date
                                        );
                                        setRegattaForm((prev) => ({
                                          ...prev,
                                          slug: auto,
                                        }));
                                      }}
                                      className="inline-flex items-center gap-1 px-2.5 py-1 rounded-lg border border-orange-500/30 bg-orange-500/10 hover:bg-orange-500/20 text-orange-300 text-[11px] font-bold transition-colors shrink-0"
                                      title="Auto-generate slug from current name and date"
                                    >
                                      <Wand2 className="h-3 w-3" />
                                      Auto-generate
                                    </button>
                                  </div>
                                  <div className="relative">
                                    <input
                                      type="text"
                                      value={regattaForm.slug || ""}
                                      onChange={(e) => {
                                        const clean = slugify(e.target.value);
                                        setRegattaForm((prev) => ({
                                          ...prev,
                                          slug: clean,
                                        }));
                                      }}
                                      placeholder="e.g. pesta-sukan-2026-ilca-6"
                                      className="w-full rounded-xl border border-white/10 bg-slate-950 px-3 py-2 text-xs font-mono text-white focus:outline-none focus:border-orange-500/50"
                                    />
                                  </div>
                                  {canonicalPublicHref && (
                                    <div className="flex items-center gap-2 text-[11px] font-mono text-slate-400 pt-0.5">
                                      <span className="text-slate-500 shrink-0">Live URL:</span>
                                      <span className="text-emerald-400 truncate font-semibold">
                                        {canonicalPublicHref}
                                      </span>
                                      {editingRegattaId !== "new" && (
                                        <Link
                                          href={canonicalPublicHref}
                                          target="_blank"
                                          className="text-orange-400 hover:underline inline-flex items-center gap-0.5 ml-auto shrink-0 font-sans font-bold"
                                        >
                                          View <ExternalLink className="h-2.5 w-2.5" />
                                        </Link>
                                      )}
                                    </div>
                                  )}
                                </div>

                                <div>
                                  <label className="text-[11px] font-bold text-slate-400 uppercase">
                                    Start Date
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
                                    className="mt-1 w-full rounded-xl border border-white/10 bg-slate-950 px-3 py-2 text-white text-xs font-mono focus:outline-none focus:border-orange-500/50"
                                  />
                                </div>

                                <div>
                                  <label className="text-[11px] font-bold text-slate-400 uppercase">
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
                                    className="mt-1 w-full rounded-xl border border-white/10 bg-slate-950 px-3 py-2 text-white text-xs font-mono focus:outline-none focus:border-orange-500/50"
                                  />
                                </div>
                              </div>
                            </div>

                            {/* Fleet & Scoring Card */}
                            <div className="rounded-2xl border border-white/5 bg-[#131520] p-4 sm:p-5 space-y-4">
                              <h4 className="text-xs font-black uppercase tracking-wider text-slate-400 flex items-center gap-1.5">
                                <Trophy className="h-3.5 w-3.5 text-orange-400" />
                                Boat Class &amp; Fleet Settings
                              </h4>

                              <div className="grid grid-cols-1 sm:grid-cols-2 gap-3">
                                <div className="sm:col-span-2 space-y-1.5">
                                  <div className="flex items-center justify-between">
                                    <label className="text-[11px] font-bold text-slate-400 uppercase">
                                      Boat Class
                                    </label>
                                    <div className="flex flex-wrap justify-end gap-1">
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
                                              className={`px-2 py-0.5 rounded-lg text-[11px] font-bold transition-all ${
                                                regattaForm.boatClass === cls
                                                  ? "bg-[var(--sp-harbour-teal)] text-white shadow-sm"
                                                  : "bg-white/5 text-slate-400 hover:text-white hover:bg-white/10"
                                              }`}
                                            >
                                              {group.family === "ILCA"
                                                ? cls.replace("ILCA ", "")
                                                : cls}
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
                                    className="w-full rounded-xl border border-white/10 bg-slate-950 px-3 py-2 text-white text-xs focus:outline-none focus:border-orange-500/50"
                                    placeholder="Optimist, ILCA 4, ILCA 6, WingFoil..."
                                  />
                                </div>

                                <div>
                                  <label className="text-[11px] font-bold text-slate-400 uppercase">
                                    Division / Fleet
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
                                    className="mt-1 w-full rounded-xl border border-white/10 bg-slate-950 px-3 py-2 text-white text-xs focus:outline-none focus:border-orange-500/50"
                                  >
                                    {/ilca|laser|radial/i.test(
                                      String(regattaForm.boatClass || "")
                                    ) ? (
                                      <option value="Open">Open</option>
                                    ) : (
                                      <>
                                        <option value="Gold">Gold only</option>
                                        <option value="Silver">Silver only</option>
                                        <option value="Both">Both (Gold + Silver)</option>
                                      </>
                                    )}
                                    <option value="NonRanking">Non-ranking</option>
                                  </select>
                                </div>

                                <div>
                                  <label className="text-[11px] font-bold text-slate-400 uppercase">
                                    Geography (NOC)
                                  </label>
                                  <div className="mt-1">
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
                                </div>

                                <div>
                                  <label className="text-[11px] font-bold text-slate-400 uppercase">
                                    Total Fleet Size
                                  </label>
                                  <input
                                    type="number"
                                    min={1}
                                    value={regattaForm.totalFleetSize}
                                    onChange={(e) =>
                                      setRegattaForm({
                                        ...regattaForm,
                                        totalFleetSize: e.target.value,
                                      })
                                    }
                                    className="mt-1 w-full rounded-xl border border-white/10 bg-slate-950 px-3 py-2 text-white text-xs font-mono focus:outline-none focus:border-orange-500/50"
                                    placeholder="e.g. 50"
                                  />
                                </div>

                                <div>
                                  <label className="text-[11px] font-bold text-slate-400 uppercase">
                                    Completed Races
                                  </label>
                                  <input
                                    type="number"
                                    min={0}
                                    value={regattaForm.raceCount ?? ""}
                                    onChange={(e) => {
                                      const raceCount = e.target.value;
                                      const n = Number(raceCount);
                                      const tooFew =
                                        raceCount !== "" && Number.isFinite(n) && n < 3;
                                      setRegattaForm({
                                        ...regattaForm,
                                        raceCount,
                                        ...(tooFew ? { countsForRanking: false } : {}),
                                      });
                                    }}
                                    className="mt-1 w-full rounded-xl border border-white/10 bg-slate-950 px-3 py-2 text-white text-xs font-mono focus:outline-none focus:border-orange-500/50"
                                    placeholder="e.g. 6"
                                  />
                                </div>

                                {/* Ranking Rule & Selection Trial */}
                                <div className="sm:col-span-2 pt-1 space-y-2">
                                  <label className="flex items-start gap-2.5 p-3 rounded-xl border border-white/10 bg-white/[0.02] cursor-pointer hover:bg-white/[0.04] transition-colors">
                                    <input
                                      type="checkbox"
                                      checked={
                                        regattaForm.countsForRanking !== false &&
                                        !(
                                          regattaForm.raceCount !== "" &&
                                          Number(regattaForm.raceCount) < 3
                                        )
                                      }
                                      onChange={(e) => {
                                        const tooFew =
                                          regattaForm.raceCount !== "" &&
                                          Number(regattaForm.raceCount) < 3;
                                        setRegattaForm({
                                          ...regattaForm,
                                          countsForRanking: e.target.checked && !tooFew,
                                        });
                                      }}
                                      className="mt-0.5 rounded border-slate-600 text-orange-500 focus:ring-0"
                                    />
                                    <div className="text-xs">
                                      <span className="font-bold text-white block">
                                        Counts for Series Ranking
                                      </span>
                                      <span className="text-[11px] text-slate-400 leading-relaxed block mt-0.5">
                                        Optimist: Best 3 of 5. ILCA: Best 3 of last 5. Minimum 3 completed races required to rank.
                                      </span>
                                    </div>
                                  </label>

                                  {regattaForm.raceCount !== "" &&
                                    Number(regattaForm.raceCount) < 3 && (
                                      <div className="rounded-xl border border-amber-500/30 bg-amber-500/10 px-3 py-2 text-xs font-semibold text-amber-300">
                                        {String(regattaForm.raceCount)} completed race(s) — Ranking rules require at least 3 completed races. This event will stay non-ranking.
                                      </div>
                                    )}

                                  <label className="flex items-start gap-2.5 p-3 rounded-xl border border-white/10 bg-white/[0.02] cursor-pointer hover:bg-white/[0.04] transition-colors">
                                    <input
                                      type="checkbox"
                                      checked={Boolean(regattaForm.isSelectionTrial)}
                                      onChange={(e) =>
                                        setRegattaForm({
                                          ...regattaForm,
                                          isSelectionTrial: e.target.checked,
                                        })
                                      }
                                      className="mt-0.5 rounded border-slate-600 text-amber-400 focus:ring-0"
                                    />
                                    <div className="text-xs">
                                      <span className="font-bold text-amber-300 block">
                                        Official Selection Trial / Qualifier
                                      </span>
                                      <span className="text-[11px] text-slate-400 leading-relaxed block mt-0.5">
                                        Highlights this regatta with a special Selection Trial badge on calendar cards and rankings.
                                      </span>
                                    </div>
                                  </label>
                                </div>
                              </div>
                            </div>

                            {/* Logistics & External Documents Accordion */}
                            <div className="rounded-2xl border border-white/5 bg-[#131520] p-4 sm:p-5 space-y-3">
                              <button
                                type="button"
                                onClick={() => setShowLogistics((prev) => !prev)}
                                className="w-full flex items-center justify-between text-left"
                              >
                                <h4 className="text-xs font-black uppercase tracking-wider text-slate-400 flex items-center gap-1.5">
                                  <Globe className="h-3.5 w-3.5 text-orange-400" />
                                  Venue, Notice of Race &amp; Logistics
                                </h4>
                                <span className="text-slate-400 p-1 hover:text-white">
                                  {showLogistics ? (
                                    <ChevronUp className="h-4 w-4" />
                                  ) : (
                                    <ChevronDown className="h-4 w-4" />
                                  )}
                                </span>
                              </button>

                              {showLogistics && (
                                <div className="grid grid-cols-1 sm:grid-cols-2 gap-3 pt-2 border-t border-white/5">
                                  <div>
                                    <label className="text-[11px] font-bold text-slate-400 uppercase">
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
                                      className="mt-1 w-full rounded-xl border border-white/10 bg-slate-950 px-3 py-2 text-white text-xs focus:outline-none focus:border-orange-500/50"
                                      placeholder="e.g. National Sailing Centre / Changi Sailing Club"
                                    />
                                  </div>

                                  <div>
                                    <label className="text-[11px] font-bold text-slate-400 uppercase">
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
                                      className="mt-1 w-full rounded-xl border border-white/10 bg-slate-950 px-3 py-2 text-white text-xs focus:outline-none focus:border-orange-500/50"
                                      placeholder="e.g. Singapore Sailing Federation"
                                    />
                                  </div>

                                  <div>
                                    <label className="text-[11px] font-bold text-slate-400 uppercase">
                                      Notice of Race / Notice Board URL
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
                                      className="mt-1 w-full rounded-xl border border-white/10 bg-slate-950 px-3 py-2 text-white text-xs focus:outline-none focus:border-orange-500/50"
                                      placeholder="https://www.racingrulesofsailing.org/... or nor.pdf"
                                    />
                                  </div>

                                  <div>
                                    <label className="text-[11px] font-bold text-slate-400 uppercase">
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
                                      className="mt-1 w-full rounded-xl border border-white/10 bg-slate-950 px-3 py-2 text-white text-xs focus:outline-none focus:border-orange-500/50"
                                      placeholder="https://singaporesailing.org/..."
                                    />
                                  </div>

                                  <div className="sm:col-span-2">
                                    <label className="text-[11px] font-bold text-slate-400 uppercase">
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
                                      className="mt-1 w-full rounded-xl border border-white/10 bg-slate-950 px-3 py-2 text-white text-xs focus:outline-none focus:border-orange-500/50"
                                      placeholder="e.g. Official selection trial for 2026 Perth Camp and Asian Games"
                                    />
                                  </div>
                                </div>
                              )}
                            </div>

                            {/* Form Action Buttons */}
                            <div className="flex flex-wrap items-center justify-between gap-3 border-t border-white/5 pt-4">
                              <button
                                type="button"
                                onClick={() => {
                                  setEditingRegattaId(null);
                                  onClearSheet?.();
                                }}
                                className="rounded-full bg-slate-800 hover:bg-slate-700 px-4 py-2 text-xs font-bold text-slate-300 hover:text-white transition-colors"
                              >
                                ← Back to Events
                              </button>

                              <div className="flex items-center gap-2">
                                {editingRegattaId !== "new" && (
                                  <button
                                    type="button"
                                    onClick={() => {
                                      setSheetTab("results");
                                      onOpenResults?.(editingRegattaId);
                                    }}
                                    className="rounded-full border border-white/15 bg-white/5 hover:bg-white/10 px-4 py-2 text-xs font-bold text-slate-200 transition-colors inline-flex items-center gap-1.5"
                                  >
                                    <Trophy className="h-3.5 w-3.5 text-orange-400" />
                                    <span>Manage Results</span>
                                  </button>
                                )}
                                <button
                                  type="button"
                                  disabled={saving}
                                  onClick={handleSaveRegatta}
                                  className="rounded-full bg-orange-600 hover:bg-orange-500 px-5 py-2 text-xs font-bold text-white transition-colors disabled:opacity-40 shadow-lg shadow-orange-600/20 inline-flex items-center gap-1.5"
                                >
                                  {saving ? (
                                    <>
                                      <Loader2 className="h-3.5 w-3.5 animate-spin" />
                                      <span>Saving…</span>
                                    </>
                                  ) : (
                                    <span>Save Class Sheet</span>
                                  )}
                                </button>
                              </div>
                            </div>
                          </div>
                        )}

                        {/* TAB 2: RESULTS & RACE SCORES */}
                        {sheetTab === "results" && editingRegattaId !== "new" && (
                          <div className="space-y-4">
                            {resultsEditor}
                          </div>
                        )}
                      </div>
                    ) : selectedEventView ? (
                      <div className="space-y-5">
                        {/* Weekend header */}
                        <div className="flex flex-col sm:flex-row sm:items-center justify-between gap-3 pb-3 border-b border-slate-200">
                          <div>
                            <h3 className="text-base font-black text-slate-900 mt-0.5">
                              {selectedEventView.name}
                            </h3>
                            <p className="text-xs text-slate-700 font-medium mt-0.5">
                              {selectedEventView.startDate || "—"}
                              {selectedEventView.endDate ? ` to ${selectedEventView.endDate}` : ""}
                              {selectedEventView.venue ? ` · ${selectedEventView.venue}` : ""}
                            </p>
                          </div>
                          <div className="flex items-center gap-2">
                            {selectedEventView.slug !== UNASSIGNED_EVENT_SLUG && (
                              <button
                                type="button"
                                onClick={() => setShowCalendarForm((prev) => !prev)}
                                className="rounded-full border border-slate-300 bg-white hover:bg-slate-50 px-3.5 py-1.5 text-xs font-bold text-slate-800 shadow-xs transition-colors inline-flex items-center gap-1.5"
                              >
                                <Sliders className="h-3 w-3 text-orange-600" />
                                <span>{showCalendarForm ? "Hide Event Editor" : "Edit Event"}</span>
                              </button>
                            )}
                          </div>
                        </div>

                        {/* Optional Collapsible Calendar Card Form */}
                        {selectedEventView.slug !== UNASSIGNED_EVENT_SLUG && calendarForm && showCalendarForm && (
                          <div className="rounded-2xl border border-slate-200 bg-slate-50/70 p-4 sm:p-5 space-y-4 shadow-xs">
                            <div className="flex items-center justify-between">
                              <h4 className="text-xs font-black uppercase tracking-wider text-orange-600 flex items-center gap-1.5">
                                <Calendar className="h-3.5 w-3.5" />
                                Public Notice Board &amp; Calendar Details
                              </h4>
                            </div>

                            <div className="grid grid-cols-1 sm:grid-cols-2 gap-3">
                              <div className="sm:col-span-2">
                                <label className="text-[11px] font-bold text-slate-700 uppercase tracking-wider">
                                  Event Name
                                </label>
                                <input
                                  value={calendarForm.name}
                                  onChange={(e) =>
                                    setCalendarForm({ ...calendarForm, name: e.target.value })
                                  }
                                  className="mt-1 w-full rounded-xl border border-slate-300 bg-white px-3 py-2 text-slate-900 text-xs focus:outline-none focus:border-orange-500 focus:ring-1 focus:ring-orange-500"
                                />
                              </div>
                              <div>
                                <label className="text-[11px] font-bold text-slate-700 uppercase tracking-wider">
                                  Start Date
                                </label>
                                <input
                                  type="date"
                                  value={calendarForm.startDate}
                                  onChange={(e) =>
                                    setCalendarForm({
                                      ...calendarForm,
                                      startDate: e.target.value,
                                    })
                                  }
                                  className="mt-1 w-full rounded-xl border border-slate-300 bg-white px-3 py-2 text-slate-900 text-xs font-mono focus:outline-none focus:border-orange-500 focus:ring-1 focus:ring-orange-500"
                                />
                              </div>
                              <div>
                                <label className="text-[11px] font-bold text-slate-700 uppercase tracking-wider">
                                  End Date
                                </label>
                                <input
                                  type="date"
                                  value={calendarForm.endDate}
                                  onChange={(e) =>
                                    setCalendarForm({
                                      ...calendarForm,
                                      endDate: e.target.value,
                                    })
                                  }
                                  className="mt-1 w-full rounded-xl border border-slate-300 bg-white px-3 py-2 text-slate-900 text-xs font-mono focus:outline-none focus:border-orange-500 focus:ring-1 focus:ring-orange-500"
                                />
                              </div>
                              <div className="sm:col-span-2">
                                <label className="text-[11px] font-bold text-slate-700 uppercase tracking-wider">
                                  Venue
                                </label>
                                <input
                                  value={calendarForm.venue}
                                  onChange={(e) =>
                                    setCalendarForm({ ...calendarForm, venue: e.target.value })
                                  }
                                  className="mt-1 w-full rounded-xl border border-slate-300 bg-white px-3 py-2 text-slate-900 text-xs focus:outline-none focus:border-orange-500 focus:ring-1 focus:ring-orange-500"
                                />
                              </div>
                              <div className="sm:col-span-2">
                                <label className="text-[11px] font-bold text-slate-700 uppercase tracking-wider">
                                  Organiser
                                </label>
                                <input
                                  value={calendarForm.organizer}
                                  onChange={(e) =>
                                    setCalendarForm({
                                      ...calendarForm,
                                      organizer: e.target.value,
                                    })
                                  }
                                  className="mt-1 w-full rounded-xl border border-slate-300 bg-white px-3 py-2 text-slate-900 text-xs focus:outline-none focus:border-orange-500 focus:ring-1 focus:ring-orange-500"
                                />
                              </div>
                              <div className="sm:col-span-2">
                                <label className="text-[11px] font-bold text-slate-700 uppercase tracking-wider block mb-1.5">
                                  Sailing Classes
                                </label>
                                <div className="p-3 rounded-xl border border-slate-300 bg-white shadow-xs">
                                  <div className="grid grid-cols-2 sm:grid-cols-3 md:grid-cols-5 gap-2">
                                    {Array.from(
                                      new Set([
                                        ...DEFAULT_CALENDAR_CLASSES,
                                        ...((calendarForm.classes || "")
                                          .split(",")
                                          .map((c) => c.trim())
                                          .filter(Boolean)),
                                      ])
                                    ).map((cls) => {
                                      const currentList = (calendarForm.classes || "")
                                        .split(",")
                                        .map((c) => c.trim())
                                        .filter(Boolean);
                                      const isChecked = currentList.includes(cls);
                                      return (
                                        <label
                                          key={cls}
                                          className={`flex items-center gap-2 p-2 rounded-lg border text-xs font-semibold cursor-pointer select-none transition-all ${
                                            isChecked
                                              ? "bg-orange-50 border-orange-300 text-orange-900 shadow-xs"
                                              : "bg-slate-50 border-slate-200 text-slate-700 hover:bg-slate-100"
                                          }`}
                                        >
                                          <input
                                            type="checkbox"
                                            checked={isChecked}
                                            onChange={(e) => {
                                              const updated = e.target.checked
                                                ? [...currentList, cls]
                                                : currentList.filter((item) => item !== cls);
                                              setCalendarForm({
                                                ...calendarForm,
                                                classes: updated.join(", "),
                                              });
                                            }}
                                            className="rounded border-slate-300 text-orange-600 focus:ring-orange-500 h-4 w-4"
                                          />
                                          <span className="truncate">{cls}</span>
                                        </label>
                                      );
                                    })}
                                  </div>
                                </div>
                              </div>
                              <div className="sm:col-span-2">
                                <label className="text-[11px] font-bold text-slate-700 uppercase tracking-wider">
                                  Status / Deadline
                                </label>
                                <input
                                  value={calendarForm.keyDeadlines}
                                  onChange={(e) =>
                                    setCalendarForm({
                                      ...calendarForm,
                                      keyDeadlines: e.target.value,
                                    })
                                  }
                                  placeholder="Entry closes 24 August 2026, 2359h"
                                  className="mt-1 w-full rounded-xl border border-slate-300 bg-white px-3 py-2 text-slate-900 text-xs focus:outline-none focus:border-orange-500 focus:ring-1 focus:ring-orange-500"
                                />
                              </div>
                              <div className="sm:col-span-2">
                                <label className="text-[11px] font-bold text-slate-700 uppercase tracking-wider">
                                  Official Notice Board URL
                                </label>
                                <input
                                  type="url"
                                  value={calendarForm.norUrl}
                                  onChange={(e) =>
                                    setCalendarForm({ ...calendarForm, norUrl: e.target.value })
                                  }
                                  className="mt-1 w-full rounded-xl border border-slate-300 bg-white px-3 py-2 text-slate-900 text-xs focus:outline-none focus:border-orange-500 focus:ring-1 focus:ring-orange-500"
                                />
                              </div>
                              <div className="sm:col-span-2">
                                <label className="text-[11px] font-bold text-slate-700 uppercase tracking-wider">
                                  Registration Link
                                </label>
                                <input
                                  type="url"
                                  value={calendarForm.registrationUrl}
                                  onChange={(e) =>
                                    setCalendarForm({
                                      ...calendarForm,
                                      registrationUrl: e.target.value,
                                    })
                                  }
                                  className="mt-1 w-full rounded-xl border border-slate-300 bg-white px-3 py-2 text-slate-900 text-xs focus:outline-none focus:border-orange-500 focus:ring-1 focus:ring-orange-500"
                                />
                              </div>
                              <label className="sm:col-span-2 flex items-start gap-2.5 text-xs font-semibold text-slate-800 cursor-pointer">
                                <input
                                  type="checkbox"
                                  className="mt-0.5 rounded border-slate-300 text-orange-600 focus:ring-orange-500 h-4 w-4"
                                  checked={calendarForm.countsForRanking}
                                  onChange={(e) =>
                                    setCalendarForm({
                                      ...calendarForm,
                                      countsForRanking: e.target.checked,
                                    })
                                  }
                                />
                                <span>
                                  Ranking regatta
                                  <span className="block text-[11px] font-normal text-slate-600">
                                    Applies to linked class sheets. Fewer than 3 races stays non-ranking.
                                  </span>
                                </span>
                              </label>
                              <label className="flex items-center gap-2.5 text-xs font-semibold text-slate-800 cursor-pointer">
                                <input
                                  type="checkbox"
                                  className="rounded border-slate-300 text-amber-600 focus:ring-amber-500 h-4 w-4"
                                  checked={calendarForm.isSelectionTrial}
                                  onChange={(e) =>
                                    setCalendarForm({
                                      ...calendarForm,
                                      isSelectionTrial: e.target.checked,
                                    })
                                  }
                                />
                                Official selection trial
                              </label>
                              <div className="sm:col-span-2 flex justify-end">
                                <button
                                  type="button"
                                  disabled={calendarSaving}
                                  onClick={handleSaveCalendar}
                                  className="rounded-full bg-orange-600 hover:bg-orange-500 px-5 py-2 text-xs font-bold text-white transition-colors disabled:opacity-40 shadow-sm"
                                >
                                  {calendarSaving ? "Saving…" : "Save Event Details"}
                                </button>
                              </div>
                            </div>
                          </div>
                        )}

                        {/* Class sheets section */}
                        <div className="space-y-3">
                          <div className="flex items-center justify-between">
                            <h4 className="text-xs font-black uppercase tracking-wider text-slate-800">
                              Class Sheets ({selectedEventView.sheets.length + selectedEventView.shells.length})
                            </h4>
                          </div>

                          {selectedEventView.sheets.length === 0 &&
                            selectedEventView.shells.length === 0 &&
                            selectedEventView.missingClasses.length === 0 && (
                              <p className="text-xs text-slate-600 font-medium py-4 text-center">
                                No class sheets attached yet.
                              </p>
                            )}

                          <div className="grid grid-cols-1 gap-2.5">
                            {[...selectedEventView.shells, ...selectedEventView.sheets].map(
                              (sheet) => {
                                const isShell = selectedEventView.shells.some(
                                  (row) => row.id === sheet.id
                                );
                                return (
                                  <div
                                    key={sheet.id}
                                    className="rounded-xl border border-slate-200 bg-white p-3.5 sm:p-4 flex flex-col sm:flex-row sm:items-center justify-between gap-3 shadow-xs hover:border-orange-500/40 transition-all"
                                  >
                                    <div className="space-y-1.5 min-w-0">
                                      <div className="flex items-center gap-2 flex-wrap">
                                        <span className="text-xs font-bold text-slate-900">
                                          {isShell ? sheet.name : sheetClassLabel(sheet)}
                                        </span>
                                        <span className="text-[10px] uppercase font-bold px-2 py-0.5 rounded bg-emerald-100 text-emerald-800 border border-emerald-200">
                                          {sheet.status || "published"}
                                        </span>
                                        {sheet.countsForRanking === false && (
                                          <span className="text-[10px] uppercase font-bold px-2 py-0.5 rounded bg-sky-100 text-sky-800 border border-sky-200">
                                            Non-ranking
                                          </span>
                                        )}
                                      </div>
                                      <div className="flex items-center gap-2.5 text-xs text-slate-700 font-medium flex-wrap">
                                        <span>
                                          {sheet.raceCount != null
                                            ? `${sheet.raceCount} completed races`
                                            : "No race count"}
                                        </span>
                                        <span className="text-slate-400">·</span>
                                        <span>
                                          {sheet.totalFleetSize != null
                                            ? `Fleet ${sheet.totalFleetSize}`
                                            : "Fleet size not set"}
                                        </span>
                                        {sheet.slug && (
                                          <>
                                            <span className="text-slate-400">·</span>
                                            <span className="font-mono text-slate-600 text-[11px] truncate max-w-[200px]">
                                              {sheet.slug}
                                            </span>
                                          </>
                                        )}
                                      </div>
                                    </div>

                                    <div className="flex items-center gap-2 shrink-0 self-end sm:self-auto">
                                      <button
                                        type="button"
                                        onClick={() => {
                                          seenSheetId.current = sheet.id;
                                          setEditingRegattaId(sheet.id);
                                          setRegattaForm(formFrom(sheet));
                                          setSheetTab("details");
                                        }}
                                        className="rounded-lg border border-slate-300 bg-white hover:bg-slate-50 px-3 py-1.5 text-xs font-bold text-slate-800 shadow-xs transition-colors inline-flex items-center gap-1.5"
                                      >
                                        <FileText className="h-3 w-3 text-slate-600" />
                                        <span>Edit Details</span>
                                      </button>
                                      <button
                                        type="button"
                                        onClick={() => {
                                          seenSheetId.current = sheet.id;
                                          setEditingRegattaId(sheet.id);
                                          setRegattaForm(formFrom(sheet));
                                          setSheetTab("results");
                                          onOpenResults?.(sheet.id);
                                        }}
                                        className="rounded-lg bg-orange-600 hover:bg-orange-500 px-3 py-1.5 text-xs font-bold text-white transition-colors inline-flex items-center gap-1.5 shadow-sm"
                                      >
                                        <Trophy className="h-3 w-3" />
                                        <span>Results &amp; Scores</span>
                                      </button>
                                    </div>
                                  </div>
                                );
                              }
                            )}

                            {selectedEventView.missingClasses.map((label) => (
                              <div
                                key={label}
                                className="flex items-center justify-between gap-3 rounded-xl border border-dashed border-slate-300 bg-slate-50/60 p-3.5 sm:p-4"
                              >
                                <div>
                                  <span className="text-xs font-bold text-slate-800">
                                    {label}
                                  </span>
                                  <span className="block text-[11px] text-slate-600 font-medium mt-0.5">
                                    Awaiting scoreboard sheet
                                  </span>
                                </div>
                                <button
                                  type="button"
                                  onClick={() => {
                                    const optimist = /optimist/i.test(label);
                                    setEditingRegattaId("new");
                                    setSheetTab("details");
                                    const baseName = `${selectedEventView.name} ${label}`;
                                    setRegattaForm({
                                      ...emptyRegattaForm(),
                                      name: baseName,
                                      slug: slugifyWithDate(
                                        baseName,
                                        selectedEventView.startDate
                                      ),
                                      date: selectedEventView.startDate,
                                      endDate: selectedEventView.endDate || "",
                                      venue: selectedEventView.venue || "",
                                      organizer: selectedEventView.organizer || "",
                                      norUrl: selectedEventView.norUrl || "",
                                      registrationUrl:
                                        selectedEventView.registrationUrl || "",
                                      boatClass: optimist ? "Optimist" : label,
                                      division: /gold/i.test(label)
                                        ? "Gold"
                                        : /silver/i.test(label)
                                          ? "Silver"
                                          : "Open",
                                      countsForRanking:
                                        selectedEventView.countsForRanking,
                                      isSelectionTrial:
                                        selectedEventView.isSelectionTrial,
                                    });
                                  }}
                                  className="shrink-0 rounded-lg border border-orange-300 bg-orange-50 hover:bg-orange-100 px-3 py-1.5 text-xs font-bold text-orange-900 transition-colors inline-flex items-center gap-1.5 shadow-xs"
                                >
                                  <Plus className="h-3 w-3" />
                                  <span>Add Sheet</span>
                                </button>
                              </div>
                            ))}
                          </div>
                        </div>
                      </div>
                    ) : null}
                  </div>
                </div>
  );
}
