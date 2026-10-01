"use client";

import { useEffect, useMemo, useRef, useState, type ReactNode } from "react";
import Link from "next/link";
import {
  Plus,
  Trash2,
  Calendar,
  Trophy,
  ExternalLink,
  Loader2,
  Wand2,
  Link2,
  ArrowLeft,
  FileText,
  Sliders,
} from "lucide-react";
import { slugify } from "@/lib/slug";
import { classResultsHref } from "@/lib/calendar/calendarResultLinks";
import {
  ADMIN_BOAT_CLASS_GROUPS,
  regattaClassFamily,
} from "@/lib/admin/regattaClass";
import type { RegattaAdmin } from "@/types/regatta";
import { setAdminRegattaStatus } from "@/components/admin/adminRegattaLifecycle";
import { GeographySelect } from "@/components/CountrySelect";
import {
  emptyRegattaForm,
  regattaToClassForm,
  type RegattaFormState,
} from "@/components/admin/adminForms";
import {
  SELECTION_EVENT_OPTIONS,
  selectionEventsForBoatClass,
} from "@/lib/selectionEventCatalog";
import { useFeedback } from "@/components/ui/FeedbackProvider";
import { setAdminLeaveGuard } from "@/components/admin/adminLeaveGuard";
import { RegattaFilterBar } from "@/components/admin/RegattaFilterBar";
import { AdminRegattaEventList } from "@/components/admin/AdminRegattaEventList";
import { AdminClassSheetCard } from "@/components/admin/AdminClassSheetCard";
import { CalendarEventForm, calendarFormFrom, type CalendarFormState, type SavedCalendarEvent } from "@/components/admin/CalendarEventForm";
import { cascadeLine, summarizeNames } from "@/lib/confirmCopy";
import type { PublicationReadiness } from "@/lib/admin/publicationReadiness";
import {
  groupRegattaEvents,
  missingClassesFor,
  sheetClassLabel,
  UNASSIGNED_EVENT_SLUG,
  type AdminEventGroup,
  type GroupableRegatta,
} from "@/lib/admin/groupRegattaEvents";

function classSheetGroups(
  unassigned: boolean,
  shells: GroupableRegatta[],
  sheets: GroupableRegatta[]
): { label: string | null; sheets: GroupableRegatta[] }[] {
  const rows = unassigned
    ? [...sheets].sort(
        (a, b) =>
          sheetClassLabel(a).localeCompare(sheetClassLabel(b)) ||
          a.name.localeCompare(b.name)
      )
    : [...shells, ...sheets];
  const groups: { label: string | null; sheets: GroupableRegatta[] }[] = [];
  for (const sheet of rows) {
    const label = unassigned ? sheetClassLabel(sheet) : null;
    const last = groups[groups.length - 1];
    if (last && last.label === label) last.sheets.push(sheet);
    else groups.push({ label, sheets: [sheet] });
  }
  return groups;
}

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
  classSnap: string;
  setClassSnap: (snap: string) => void;
  /** True while the save mutation is in flight. */
  saving: boolean;
  handleSaveRegatta: () => void | Promise<void>;
  handleDeleteRegatta: (id: string) => void | Promise<void>;
  invalidateRegattas?: () => void;
  onOpenResults?: (regattaId: string) => void;
  onClearSheet?: () => void;
  onImportClass?: (sheetId: string) => void;
  /** Sheet opened from ?sheet= or the results editor. */
  activeSheetId?: string;
  resultsEditor?: ReactNode;
  /** Changes whenever saved class details or result rows change. */
  readinessRevision?: string;
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
  classSnap,
  setClassSnap,
  saving,
  handleSaveRegatta,
  handleDeleteRegatta,
  invalidateRegattas,
  onOpenResults,
  onClearSheet,
  onImportClass,
  activeSheetId,
  resultsEditor,
  readinessRevision,
}: AdminRegattasPanelProps) {
  const { toast, confirm } = useFeedback();
  const [isSeeding, setIsSeeding] = useState(false);
  const [selectedEventSlug, setSelectedEventSlug] = useState<string | null>(null);
  const [savedEvents, setSavedEvents] = useState<Record<string, SavedCalendarEvent>>({});
  const [calendarForm, setCalendarForm] = useState<CalendarFormState | null>(null);
  const [calendarSaving, setCalendarSaving] = useState(false);
  const calendarSlug = useRef("");
  const [calendarSnap, setCalendarSnap] = useState("");
  const classLabel = useRef("Class settings");
  const [readiness, setReadiness] = useState<PublicationReadiness | null>(null);
  const [sheetTab, setSheetTab] = useState<"details" | "results">("details");
  const [showCalendarForm, setShowCalendarForm] = useState(false);
  const [publishingId, setPublishingId] = useState<string | null>(null);
  const [linkingSheetId, setLinkingSheetId] = useState<string | null>(null);
  const [linkTargets, setLinkTargets] = useState<Record<string, string>>({});
  const [deletingEventSlug, setDeletingEventSlug] = useState<string | null>(null);

  const handleTogglePublish = async (sheetId: string, currentStatus?: string | null) => {
    if (!isSuperadmin) {
      toast.error("Only superadmins can change the publication status.");
      return;
    }
    const targetStatus = currentStatus === "published" ? "draft" : "published";
    if (
      targetStatus === "published" &&
      readiness &&
      (readiness.summary === "blocked" || readiness.summary === "incomplete")
    ) {
      toast.error(
        readiness.summary === "blocked"
          ? "Resolve the blocking publication checks first."
          : "Complete the required publication checks first."
      );
      return;
    }
    setPublishingId(sheetId);
    try {
      await setAdminRegattaStatus(sheetId, targetStatus);
      toast.success(
        targetStatus === "published"
          ? "Sailing class published successfully! Results are now visible publicly."
          : "Sailing class set to draft. It is now hidden from public views."
      );
      invalidateRegattas?.();
    } catch (err: unknown) {
      toast.error(err instanceof Error ? err.message : "Failed to update publication status");
    } finally {
      setPublishingId(null);
    }
  };

  const grouped = useMemo(() => {
    const slugsById = new Map(
      Object.values(savedEvents).map((event) => [event.id, event.slug])
    );
    const next = groupRegattaEvents(filteredRegattaList, slugsById);
    const existingSlugs = new Set(next.events.map((event) => event.slug));
    const query = regattaSearch.trim().toLowerCase();

    for (const saved of Object.values(savedEvents)) {
      if (existingSlugs.has(saved.slug)) continue;
      const classes = (saved.classes || []).map((item) => item.trim()).filter(Boolean);
      const families = classes.map((item) => regattaClassFamily(item));
      if (
        regattaClassFilter !== "all" &&
        !families.some((family) => family === regattaClassFilter)
      ) {
        continue;
      }
      if (
        regattaDivisionFilter !== "all" &&
        !classes.some((item) =>
          item.toLowerCase().includes(regattaDivisionFilter.toLowerCase())
        )
      ) {
        continue;
      }
      if (regattaRankingFilter === "series" && saved.countsForRanking === false) continue;
      if (regattaRankingFilter === "nonranking" && saved.countsForRanking !== false) continue;
      const haystack = `${saved.name} ${saved.startDate} ${saved.endDate || ""} ${saved.venue || ""} ${saved.organizer || ""} ${classes.join(" ")} ${saved.slug}`.toLowerCase();
      if (query && !haystack.includes(query)) continue;

      next.events.push({
        slug: saved.slug,
        name: saved.name,
        startDate: String(saved.startDate).slice(0, 10),
        endDate: saved.endDate ? String(saved.endDate).slice(0, 10) : undefined,
        venue: saved.venue || undefined,
        organizer: saved.organizer || undefined,
        norUrl: saved.norUrl || undefined,
        registrationUrl: saved.registrationUrl || undefined,
        countsForRanking: saved.countsForRanking !== false,
        isSelectionTrial: Boolean(saved.isSelectionTrial),
        keyDeadlines: saved.keyDeadlines || undefined,
        expectedClasses: classes,
        missingClasses: classes,
        sheets: [],
        shells: [],
        shell: null,
      });
    }
    next.events.sort(
      (a, b) => b.startDate.localeCompare(a.startDate) || a.name.localeCompare(b.name)
    );
    return next;
  }, [
    filteredRegattaList,
    savedEvents,
    regattaSearch,
    regattaClassFilter,
    regattaDivisionFilter,
    regattaRankingFilter,
  ]);

  const handleLinkSheet = async (sheetId: string) => {
    const eventId = linkTargets[sheetId];
    if (!eventId || linkingSheetId) return;
    setLinkingSheetId(sheetId);
    try {
      const res = await fetch("/api/admin/regattas", {
        method: "PATCH",
        credentials: "include",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({ id: sheetId, action: "link-event", eventId }),
      });
      const data = await res.json();
      if (!res.ok) throw new Error(data.error || "Could not link the sailing class");
      toast.success("Sailing class linked to the regatta event.");
      setLinkTargets((current) => {
        const next = { ...current };
        delete next[sheetId];
        return next;
      });
      invalidateRegattas?.();
    } catch (err: unknown) {
      toast.error(err instanceof Error ? err.message : "Could not link the sailing class");
    } finally {
      setLinkingSheetId(null);
    }
  };

  const effectiveEventSlug =
    selectedEventSlug ?? grouped.events[0]?.slug ?? null;

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

  const formFrom = (r: GroupableRegatta) => regattaToClassForm(r);

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
    const next = formFrom(row);
    setClassSnap(JSON.stringify(next));
    classLabel.current = `${sheetClassLabel(row)} class settings`;
    setRegattaForm(next);
    setSheetTab("results");
  }, [activeSheetId, filteredRegattaList, grouped.events, setClassSnap, setEditingRegattaId, setRegattaForm]);

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
    const nextForm = calendarFormFrom(selectedEventView);
    setCalendarSnap(JSON.stringify(nextForm));
    setCalendarForm(nextForm);
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
      setCalendarSnap(JSON.stringify(calendarForm));
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

  // Dirty-check via memoised comparison of current form vs the snapshot taken
  // when the form was first populated, instead of accessing ref.current during render.
  const calendarDirty =
    calendarForm != null &&
    calendarSnap !== "" &&
    JSON.stringify(calendarForm) !== calendarSnap;
  const classDirty =
    Boolean(editingRegattaId) &&
    classSnap !== "" &&
    JSON.stringify(regattaForm) !== classSnap;

  const confirmLeave = () => {
    const parts: string[] = [];
    if (calendarDirty && selectedEventView) {
      parts.push(`${selectedEventView.name} event details`);
    }
    if (classDirty) parts.push(classLabel.current);
    if (parts.length === 0) return true;
    return window.confirm(`Discard unsaved changes to ${parts.join(" and ")}?`);
  };

  useEffect(() => {
    setAdminLeaveGuard(confirmLeave);
    return () => setAdminLeaveGuard(null);
  });

  useEffect(() => {
    if (!calendarDirty && !classDirty) return;
    const onLeave = (event: BeforeUnloadEvent) => {
      event.preventDefault();
      event.returnValue = "";
    };
    window.addEventListener("beforeunload", onLeave);
    return () => window.removeEventListener("beforeunload", onLeave);
  }, [calendarDirty, classDirty]);

  useEffect(() => {
    if (!editingRegattaId || editingRegattaId === "new") return;
    let cancelled = false;
    void fetch(`/api/admin/regatta-readiness?sheet=${encodeURIComponent(editingRegattaId)}`, {
      credentials: "include",
    })
      .then((res) => res.json())
      .then((body: { readiness?: PublicationReadiness }) => {
        if (!cancelled) setReadiness(body.readiness ?? null);
      })
      .catch(() => {
        if (!cancelled) setReadiness(null);
      });
    return () => {
      cancelled = true;
    };
  }, [editingRegattaId, readinessRevision]);

  const rememberClassForm = (sheet: GroupableRegatta, next = formFrom(sheet)) => {
    setClassSnap(JSON.stringify(next));
    classLabel.current = `${sheetClassLabel(sheet)} class settings`;
    setRegattaForm(next);
  };

  const selectEvent = (slug: string | null) => {
    if (!confirmLeave()) return;
    setSelectedEventSlug(slug);
    setEditingRegattaId(null);
    onClearSheet?.();
  };

  const handleDeleteEvent = async (slug: string) => {
    if (!isSuperadmin) {
      toast.error("Only superadmins can delete a regatta event.");
      return;
    }
    if (slug === UNASSIGNED_EVENT_SLUG) return;
    if (!confirmLeave()) return;
    const event =
      slug === selectedEventView?.slug
        ? selectedEventView
        : withSavedEvent(
            grouped.events.find((item) => item.slug === slug) ?? {
              slug,
              name: slug,
              startDate: "",
              countsForRanking: false,
              isSelectionTrial: false,
              expectedClasses: [],
              missingClasses: [],
              sheets: [],
              shells: [],
              shell: null,
            },
            savedEvents[slug]
          );
    const classes = [...event.sheets, ...event.shells];
    const names = summarizeNames(classes.map((row) => row.name || sheetClassLabel(row)));
    const extraLine = names.extra > 0 ? `\n• +${names.extra} more` : "";
    const ok = await confirm({
      title: `Delete ${event.name}?`,
      message:
        `This removes the weekend from the admin calendar and deletes every sailing class under it.\n\n` +
        `${event.startDate || "No date"}${event.venue ? ` · ${event.venue}` : ""}\n\n` +
        `Classes:\n${names.listed}${extraLine}\n\n` +
        `Cascade:\n${cascadeLine("Class sheets", classes.length)}\n` +
        `• Result rows: all scores for those classes (server cascade)\n\n` +
        `This cannot be undone.`,
      confirmLabel: "Delete event",
      tone: "danger",
    });
    if (!ok) return;
    setDeletingEventSlug(slug);
    try {
      const res = await fetch(
        `/api/admin/regatta-events?slug=${encodeURIComponent(slug)}`,
        { method: "DELETE", credentials: "include" }
      );
      const data = await res.json();
      if (!res.ok) throw new Error(data.error || "Could not delete the event");
      setSavedEvents((prev) => {
        const next = { ...prev };
        delete next[slug];
        return next;
      });
      if (selectedEventSlug === slug) setSelectedEventSlug(null);
      setEditingRegattaId(null);
      onClearSheet?.();
      invalidateRegattas?.();
      toast.success(
        classes.length > 0
          ? `Deleted ${event.name} and ${classes.length} sailing class${classes.length === 1 ? "" : "es"}.`
          : `Deleted ${event.name}.`
      );
    } catch (err: unknown) {
      toast.error(err instanceof Error ? err.message : "Could not delete the event");
    } finally {
      setDeletingEventSlug(null);
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

  const linkableWeekends = Object.values(savedEvents)
    .sort(
      (a, b) =>
        b.startDate.localeCompare(a.startDate) || a.name.localeCompare(b.name)
    )
    .map((event) => ({
      id: event.id,
      name: event.name,
      startDate: event.startDate,
    }));

  return (
                            <div className="w-full min-w-0 space-y-4">
                <RegattaFilterBar
                  regattaSearch={regattaSearch}
                  onRegattaSearchChange={setRegattaSearch}
                  regattaClassFilter={regattaClassFilter}
                  onRegattaClassFilterChange={(v) => {
                    setRegattaClassFilter?.(v);
                    setRegattaDivisionFilter("all");
                  }}
                  regattaDivisionFilter={regattaDivisionFilter}
                  onRegattaDivisionFilterChange={setRegattaDivisionFilter}
                  regattaRankingFilter={regattaRankingFilter}
                  onRegattaRankingFilterChange={setRegattaRankingFilter}
                  isSuperadmin={isSuperadmin}
                  isSeeding={isSeeding}
                  onAddRegatta={(form) => {
                    setEditingRegattaId("new");
                    setSheetTab("details");
                    setRegattaForm(form);
                  }}
                  onSeed2026={handleSeed2026}
                />

                <div className="grid grid-cols-1 gap-4 lg:grid-cols-[minmax(17rem,22rem)_minmax(0,1fr)] lg:items-start">
                <div className="block">
                  <AdminRegattaEventList
                    events={grouped.events.map((event) =>
                      withSavedEvent(event, savedEvents[event.slug])
                    )}
                    unassignedCount={grouped.unassigned.length}
                    selectedSlug={effectiveEventSlug}
                    isSuperadmin={isSuperadmin}
                    deletingSlug={deletingEventSlug}
                    onSelect={(slug) => selectEvent(slug)}
                    onDelete={(slug) => void handleDeleteEvent(slug)}
                  />
                </div>

                {/* Detail / edit pane */}
                <div className="w-full glass-panel rounded-2xl border border-white/5 p-5 sm:p-6 min-h-[320px] transition-all">
                  {!selectedEvent && !editingRegattaId ? (
                    <div className="h-full flex flex-col items-center justify-center text-center py-16 px-4">
                      <Calendar className="h-10 w-10 text-slate-600 mb-3" />
                      <p className="text-sm font-bold text-slate-300">
                        Select a weekend
                      </p>
                      <p className="text-xs text-slate-500 mt-1 max-w-sm">
                        Choose an event from the list to review sailing classes, edit the calendar card, or delete the whole weekend.
                      </p>
                    </div>
                  ) : editingRegattaId ? (
                      <div className="space-y-5">
                        {/* Sheet Header */}
                        <div className="flex flex-col sm:flex-row sm:items-center justify-between gap-3 pb-3 border-b border-white/5">
                          <div className="flex items-center gap-2 flex-wrap min-w-0">
                            <button
                              type="button"
                              aria-label="Back to weekends"
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
                                onClick={(event) => {
                                  if (!confirmLeave()) event.preventDefault();
                                }}
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
                                aria-label={`Delete ${regattaForm.name || "regatta"} and all of its results`}
                                onClick={() => handleDeleteRegatta(editingRegattaId)}
                                className="p-1.5 rounded-full border border-white/10 bg-white/5 text-slate-500 hover:text-rose-400 hover:border-rose-500/30 hover:bg-rose-500/10 transition-colors focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-rose-400"
                                title="Delete regatta and cascade results"
                              >
                                <Trash2 className="h-3.5 w-3.5" />
                              </button>
                            )}
                          </div>
                        </div>

                        {/* Segmented Workspace Tabs */}
                        <div
                          className="flex items-center gap-2 border-b border-white/10 pb-3"
                          role="tablist"
                          aria-label="Sailing class editor"
                        >
                          <button
                            type="button"
                            id="regatta-details-tab"
                            role="tab"
                            aria-selected={sheetTab === "details"}
                            aria-controls="regatta-details-panel"
                            onClick={() => setSheetTab("details")}
                            className={`inline-flex items-center gap-1.5 px-3.5 py-1.5 rounded-xl text-xs font-bold transition-all focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-orange-400 ${
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
                            id="regatta-results-tab"
                            role="tab"
                            aria-selected={sheetTab === "results"}
                            aria-controls="regatta-results-panel"
                            onClick={() => {
                              setSheetTab("results");
                              if (editingRegattaId && editingRegattaId !== "new") {
                                onOpenResults?.(editingRegattaId);
                              }
                            }}
                            disabled={editingRegattaId === "new"}
                            className={`inline-flex items-center gap-1.5 px-3.5 py-1.5 rounded-xl text-xs font-bold transition-all focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-orange-400 ${
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
                          <div
                            id="regatta-details-panel"
                            role="tabpanel"
                            aria-labelledby="regatta-details-tab"
                            className="space-y-4"
                          >
                            {/* Primary Details Card */}
                            <div className="rounded-2xl border border-white/5 bg-[#131520] p-4 sm:p-5 space-y-4">
                              <h4 className="text-xs font-black uppercase tracking-wider text-slate-400 flex items-center gap-1.5">
                                <Calendar className="h-3.5 w-3.5 text-orange-400" />
                                Event Identification
                              </h4>

                              <div className="grid grid-cols-1 sm:grid-cols-2 gap-3">
                                <div>
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
                                <div>
                                  <label className="text-[11px] font-bold text-slate-400 uppercase">
                                    Publication Status
                                  </label>
                                  <select
                                    value={regattaForm.status || "published"}
                                    onChange={(e) =>
                                      setRegattaForm({
                                        ...regattaForm,
                                        status: e.target.value,
                                      })
                                    }
                                    className="mt-1 w-full rounded-xl border border-white/10 bg-slate-950 px-3 py-2 text-white text-xs font-semibold focus:outline-none focus:border-orange-500/50"
                                  >
                                    <option value="published">Published</option>
                                    <option value="draft">Draft</option>
                                    <option value="in_review">In Review</option>
                                    <option value="archived">Archived</option>
                                  </select>
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
                                        const auto = slugify(regattaForm.name);
                                        setRegattaForm((prev) => ({
                                          ...prev,
                                          slug: auto,
                                        }));
                                      }}
                                      className="inline-flex items-center gap-1 px-2.5 py-1 rounded-lg border border-orange-500/30 bg-orange-500/10 hover:bg-orange-500/20 text-orange-300 text-[11px] font-bold transition-colors shrink-0"
                                      title="Auto-generate slug from title"
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
                                          selectionEventId: e.target.checked
                                            ? regattaForm.selectionEventId || ""
                                            : "",
                                        })
                                      }
                                      className="mt-0.5 rounded border-slate-600 text-amber-400 focus:ring-0"
                                    />
                                    <div className="text-xs">
                                      <span className="font-bold text-amber-300 block">
                                        Official Selection Trial / Qualifier
                                      </span>
                                      <span className="text-[11px] text-slate-400 leading-relaxed block mt-0.5">
                                        Marks this class as a selection trial. Link it to the selection event these results count toward.
                                      </span>
                                    </div>
                                  </label>
                                  {regattaForm.isSelectionTrial ? (
                                    <div className="rounded-xl border border-amber-500/30 bg-amber-500/10 p-3">
                                      <label className="text-[11px] font-bold uppercase text-amber-200">
                                        Selection event
                                      </label>
                                      <select
                                        aria-label="Selection event for this class"
                                        value={regattaForm.selectionEventId || ""}
                                        onChange={(e) =>
                                          setRegattaForm({
                                            ...regattaForm,
                                            selectionEventId: e.target.value,
                                          })
                                        }
                                        className="mt-1 w-full rounded-xl border border-white/10 bg-slate-950 px-3 py-2 text-white text-xs focus:outline-none focus:border-orange-500/50"
                                      >
                                        <option value="">Not linked</option>
                                        {(() => {
                                          const options = selectionEventsForBoatClass(
                                            regattaForm.boatClass
                                          );
                                          const current = SELECTION_EVENT_OPTIONS.find(
                                            (event) => event.id === regattaForm.selectionEventId
                                          );
                                          const shown =
                                            current &&
                                            !options.some((event) => event.id === current.id)
                                              ? [current, ...options]
                                              : options;
                                          return shown.map((event) => (
                                            <option key={event.id} value={event.id}>
                                              {event.label} · {event.dates}
                                            </option>
                                          ));
                                        })()}
                                      </select>
                                      <p className="mt-1.5 text-[11px] leading-relaxed text-amber-100/80">
                                        {selectionEventsForBoatClass(regattaForm.boatClass).length === 0
                                          ? "No selection events are defined for this class."
                                          : "The linked event uses this class sheet in the selection campaign."}
                                      </p>
                                    </div>
                                  ) : null}
                                </div>
                              </div>
                            </div>

                            {readiness && editingRegattaId !== "new" && (
                              <div className="rounded-xl border border-white/10 bg-white/[0.03] p-3 space-y-2" aria-live="polite">
                                <p className="text-[12px] font-bold uppercase text-slate-400">
                                  {readiness.summary === "publishable_ranking"
                                    ? "Publishable and ranking"
                                    : readiness.summary === "publishable_non_ranking"
                                      ? "Publishable, non-ranking"
                                      : readiness.summary === "blocked"
                                        ? "Blocked from publishing"
                                        : "Incomplete"}
                                </p>
                                <ul className="space-y-1">
                                  {readiness.checks.map((check) => (
                                    <li key={check.code} className="text-[12px] text-slate-300">
                                      <span aria-hidden="true">
                                        {check.severity === "ok"
                                          ? "✓ "
                                          : check.severity === "warning"
                                            ? "! "
                                            : "– "}
                                      </span>
                                      {check.label}
                                    </li>
                                  ))}
                                </ul>
                              </div>
                            )}

                            {/* Form Action Buttons */}
                            <div className="flex flex-wrap items-center justify-between gap-3 border-t border-white/5 pt-4">
                              <button
                                type="button"
                                onClick={() => {
                                  if (!confirmLeave()) return;
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
                                      if (!confirmLeave()) return;
                                      onImportClass?.(editingRegattaId);
                                    }}
                                    className="rounded-full border border-white/15 bg-white/5 hover:bg-white/10 px-4 py-2 text-xs font-bold text-slate-200 transition-colors"
                                  >
                                    Import into this class
                                  </button>
                                )}
                                {editingRegattaId !== "new" && (
                                  <button
                                    type="button"
                                    onClick={() => {
                                      if (classDirty && !confirmLeave()) return;
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
                                    <span>Save Sailing Class</span>
                                  )}
                                </button>
                              </div>
                            </div>
                          </div>
                        )}

                        {/* TAB 2: RESULTS & RACE SCORES */}
                        {sheetTab === "results" && editingRegattaId !== "new" && (
                          <div
                            id="regatta-results-panel"
                            role="tabpanel"
                            aria-labelledby="regatta-results-tab"
                            className="space-y-4"
                          >
                            {resultsEditor}
                          </div>
                        )}
                      </div>
                    ) : selectedEventView ? (
                      <div className="space-y-5">
                        {/* Weekend header */}
                        <div className="flex flex-col sm:flex-row sm:items-center justify-between gap-3 pb-3 border-b border-slate-200">
                          <div className="min-w-0">
                            {selectedEventSlug ? (
                              <button
                                type="button"
                                onClick={() => selectEvent(null)}
                                className="mb-2 inline-flex items-center gap-1 text-xs font-bold text-slate-600 hover:text-slate-900"
                              >
                                <ArrowLeft className="h-3.5 w-3.5" />
                                All weekends
                              </button>
                            ) : null}
                            <h3 className="text-base font-black text-slate-900 mt-0.5">
                              {selectedEventView.name}
                            </h3>
                            {selectedEventView.slug === UNASSIGNED_EVENT_SLUG ? (
                              <p className="mt-1 max-w-xl text-xs font-medium text-slate-600">
                                {selectedEventView.sheets.length} class sheet
                                {selectedEventView.sheets.length === 1 ? "" : "s"} not attached to a
                                weekend. Choose a weekend on each sheet, then link it.
                              </p>
                            ) : (
                              <p className="text-xs text-slate-700 font-medium mt-0.5">
                                {selectedEventView.startDate || "—"}
                                {selectedEventView.endDate ? ` to ${selectedEventView.endDate}` : ""}
                                {selectedEventView.venue ? ` · ${selectedEventView.venue}` : ""}
                              </p>
                            )}
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
                            {isSuperadmin &&
                              selectedEventView.slug !== UNASSIGNED_EVENT_SLUG && (
                                <button
                                  type="button"
                                  disabled={deletingEventSlug === selectedEventView.slug}
                                  onClick={() => void handleDeleteEvent(selectedEventView.slug)}
                                  className="rounded-full border border-rose-200 bg-rose-50 hover:bg-rose-100 px-3.5 py-1.5 text-xs font-bold text-rose-800 shadow-xs transition-colors inline-flex items-center gap-1.5 disabled:opacity-50"
                                >
                                  {deletingEventSlug === selectedEventView.slug ? (
                                    <Loader2 className="h-3 w-3 animate-spin" />
                                  ) : (
                                    <Trash2 className="h-3 w-3" />
                                  )}
                                  Delete event
                                </button>
                              )}
                          </div>
                        </div>

                        {/* Optional Collapsible Calendar Card Form */}
                        <CalendarEventForm
                          calendarForm={calendarForm}
                          setCalendarForm={setCalendarForm}
                          calendarSaving={calendarSaving}
                          handleSaveCalendar={handleSaveCalendar}
                          showCalendarForm={showCalendarForm}
                          setShowCalendarForm={setShowCalendarForm}
                        />

                        {/* Sailing classes section */}
                        <div className="space-y-3">
                          <div className="flex items-center justify-between">
                            <h4 className="text-xs font-black uppercase tracking-wider text-slate-800">
                              {selectedEventView.slug === UNASSIGNED_EVENT_SLUG
                                ? `Class sheets (${selectedEventView.sheets.length})`
                                : `Sailing class (${selectedEventView.sheets.length + selectedEventView.shells.length})`}
                            </h4>
                          </div>

                          {selectedEventView.sheets.length === 0 &&
                            selectedEventView.shells.length === 0 &&
                            selectedEventView.missingClasses.length === 0 && (
                              <p className="text-xs text-slate-600 font-medium py-4 text-center">
                                No sailing classes attached yet.
                              </p>
                            )}

                          <div className="grid grid-cols-1 gap-4">
                            {classSheetGroups(
                              selectedEventView.slug === UNASSIGNED_EVENT_SLUG,
                              selectedEventView.shells,
                              selectedEventView.sheets
                            ).map((group) => (
                                <div key={group.label ?? "sheets"} className="space-y-2.5">
                                  {group.label ? (
                                    <h5 className="text-[11px] font-black uppercase tracking-wider text-slate-500">
                                      {group.label}
                                      <span className="ml-1.5 font-bold text-slate-400">
                                        {group.sheets.length}
                                      </span>
                                    </h5>
                                  ) : null}
                                  {group.sheets.map((sheet) => {
                                    const isShell = selectedEventView.shells.some(
                                      (row) => row.id === sheet.id
                                    );
                                    return (
                                      <AdminClassSheetCard
                                        key={sheet.id}
                                        sheet={sheet}
                                        isShell={isShell}
                                        unassigned={
                                          selectedEventView.slug === UNASSIGNED_EVENT_SLUG
                                        }
                                        isSuperadmin={isSuperadmin}
                                        weekends={linkableWeekends}
                                        linkTarget={linkTargets[sheet.id] || ""}
                                        linking={linkingSheetId === sheet.id}
                                        publishing={publishingId === sheet.id}
                                        publishBlocked={
                                          editingRegattaId === sheet.id &&
                                          readiness != null &&
                                          (readiness.summary === "blocked" ||
                                            readiness.summary === "incomplete")
                                        }
                                        onLinkTargetChange={(eventId) =>
                                          setLinkTargets((current) => ({
                                            ...current,
                                            [sheet.id]: eventId,
                                          }))
                                        }
                                        onLink={() => handleLinkSheet(sheet.id)}
                                        onTogglePublish={
                                          isSuperadmin
                                            ? () => handleTogglePublish(sheet.id, sheet.status)
                                            : undefined
                                        }
                                        onEditDetails={() => {
                                          if (editingRegattaId !== sheet.id && !confirmLeave()) return;
                                          seenSheetId.current = sheet.id;
                                          setEditingRegattaId(sheet.id);
                                          rememberClassForm(sheet);
                                          setSheetTab("details");
                                        }}
                                        onOpenResults={() => {
                                          if (editingRegattaId !== sheet.id && !confirmLeave()) return;
                                          seenSheetId.current = sheet.id;
                                          setEditingRegattaId(sheet.id);
                                          rememberClassForm(sheet);
                                          setSheetTab("results");
                                          onOpenResults?.(sheet.id);
                                        }}
                                      />
                                    );
                                  })}
                                </div>
                            ))}

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
                                    const baseName = label.startsWith("(")
                                      ? `${selectedEventView.name} ${label}`
                                      : `${selectedEventView.name} (${label})`;
                                    const next = {
                                      ...emptyRegattaForm(),
                                      eventId: savedEvents[selectedEventView.slug]?.id || "",
                                      name: baseName,
                                      slug: slugify(baseName),
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
                                      isSelectionTrial: false,
                                      selectionEventId: "",
                                    };
                                    setClassSnap(JSON.stringify(next));
                                    classLabel.current = `${label} class settings`;
                                    setRegattaForm(next);
                                  }}
                                  className="shrink-0 rounded-lg border border-orange-300 bg-orange-50 hover:bg-orange-100 px-3 py-1.5 text-xs font-bold text-orange-900 transition-colors inline-flex items-center gap-1.5 shadow-xs"
                                >
                                  <Plus className="h-3 w-3" />
                                  <span>Add Sailing Class</span>
                                </button>
                              </div>
                            ))}
                          </div>
                        </div>
                      </div>
                    ) : null}
                  </div>
                </div>
                </div>
  );
}
