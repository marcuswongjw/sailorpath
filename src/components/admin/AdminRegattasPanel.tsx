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
  Sliders,
} from "lucide-react";
import { slugify } from "@/lib/slug";
import {
  duplicateRegattaChoice,
  mergeRegattaIdentities,
  planNewRegattaSave,
  regattaIdentityFromApi,
  registryRegattaIdentities,
  type RegattaDuplicateDecision,
  type RegattaEventSaveBody,
  type RegattaIdentity,
} from "@/lib/admin/regattaDuplicate";
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
import { EventFacts, joinDateRange } from "@/components/EventFacts";
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
import { getRegattaEvent } from "@/lib/regattaEvents";

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
    scheduleSummary: saved.scheduleSummary?.trim() || event.scheduleSummary || "",
    scoringRules: saved.scoringRules?.trim() || event.scoringRules || "",
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
  onRegattaMoved?: (row: RegattaAdmin) => void;
  onOpenResults?: (regattaId: string) => void;
  onOpenCheck?: (regattaId: string) => void;
  onClearSheet?: () => void;
  onImportClass?: (sheetId: string) => void;
  eventsView?: "card" | "results" | "import" | "readiness" | "wingfoil" | "techno293";
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
  onRegattaMoved,
  onOpenResults,
  onOpenCheck,
  onClearSheet,
  onImportClass,
  eventsView = "results",
  activeSheetId,
  resultsEditor,
  readinessRevision,
}: AdminRegattasPanelProps) {
  const { toast, confirm, choose } = useFeedback();
  const [selectedEventSlug, setSelectedEventSlug] = useState<string | null>(null);
  const [savedEvents, setSavedEvents] = useState<Record<string, SavedCalendarEvent>>({});
  const [calendarForm, setCalendarForm] = useState<CalendarFormState | null>(null);
  const [calendarSaving, setCalendarSaving] = useState(false);
  const calendarSlug = useRef("");
  const [calendarSnap, setCalendarSnap] = useState("");
  const classLabel = useRef("Class settings");
  const [readiness, setReadiness] = useState<PublicationReadiness | null>(null);
  const [cardReadiness, setCardReadiness] = useState<Record<string, PublicationReadiness>>({});
  const [sheetTab, setSheetTab] = useState<"details" | "results" | "check" | "publish">("details");
  const [showCalendarForm, setShowCalendarForm] = useState(false);
  const [creatingEvent, setCreatingEvent] = useState(false);
  const [newEvent, setNewEvent] = useState({ name: "", startDate: "", endDate: "", venue: "" });
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
      const registry = getRegattaEvent(saved.slug);
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
        scheduleSummary:
          saved.scheduleSummary?.trim() || registry?.scheduleSummary || "",
        scoringRules: saved.scoringRules?.trim() || registry?.scoringRules || "",
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
    if (!confirmLeave()) return;
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
      if (!data.regatta || data.regatta.id !== sheetId || data.regatta.eventId !== eventId) {
        throw new Error("The class move could not be confirmed. Refresh and try again.");
      }
      onRegattaMoved?.(data.regatta as RegattaAdmin);
      const wasUnassigned = grouped.unassigned.some((sheet) => sheet.id === sheetId);
      const destination = Object.values(savedEvents).find((event) => event.id === eventId);
      toast.success(
        wasUnassigned ? "Class linked to the event." : "Class moved to the other regatta."
      );
      if (destination) setSelectedEventSlug(destination.slug);
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
  const appliedSheetView = useRef("");

  useEffect(() => {
    const token = `${activeSheetId || ""}|${eventsView}`;
    if (token === appliedSheetView.current) return;
    if (!activeSheetId) {
      appliedSheetView.current = token;
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
    const sheetChanged = seenSheetId.current !== activeSheetId;
    seenSheetId.current = activeSheetId;
    appliedSheetView.current = token;
    if (sheetChanged) {
      setSelectedEventSlug(event ? event.slug : UNASSIGNED_EVENT_SLUG);
      setEditingRegattaId(row.id);
      const next = formFrom(row);
      setClassSnap(JSON.stringify(next));
      classLabel.current = `${sheetClassLabel(row)} class settings`;
      setRegattaForm(next);
    }
    if (eventsView === "readiness" || eventsView === "results") {
      // The selected tab mirrors the URL-driven view when opening a class sheet.
      // eslint-disable-next-line react-hooks/set-state-in-effect -- Synchronize external route state.
      setSheetTab(eventsView === "readiness" ? "check" : "results");
    }
  }, [activeSheetId, eventsView, filteredRegattaList, grouped.events, setClassSnap, setEditingRegattaId, setRegattaForm]);

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
          ? `Calendar card saved. ${held} class${held === 1 ? "" : "es"} stayed non-ranking because fewer than 3 races were completed.`
          : updated > 0
            ? "Calendar card saved. Classes now use this ranking setting."
            : "Calendar card saved. No classes are linked yet, so series scores are unchanged."
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

  const openSheetKey = selectedEventView
    ? [...selectedEventView.sheets, ...selectedEventView.shells].map((sheet) => sheet.id).join(",")
    : "";

  useEffect(() => {
    const ids = openSheetKey.split(",").filter(Boolean);
    if (ids.length === 0) return;
    let cancelled = false;
    void Promise.all(
      ids.map(async (id) => {
        const res = await fetch(`/api/admin/regatta-readiness?sheet=${encodeURIComponent(id)}`, {
          credentials: "include",
        });
        const body = (await res.json()) as { readiness?: PublicationReadiness };
        return [id, body.readiness] as const;
      })
    )
      .then((rows) => {
        if (cancelled) return;
        const next: Record<string, PublicationReadiness> = {};
        for (const [id, value] of rows) {
          if (value) next[id] = value;
        }
        setCardReadiness(next);
      })
      .catch(() => {
        if (!cancelled) setCardReadiness({});
      });
    return () => {
      cancelled = true;
    };
  }, [openSheetKey]);

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

  const createLock = useRef(false);

  const createEvent = async () => {
    if (!isSuperadmin) {
      toast.error("Only a superadmin can create an event.");
      return;
    }
    const name = newEvent.name.trim();
    const startDate = newEvent.startDate.trim();
    if (!name || !startDate || !slugify(name)) {
      toast.error("An event needs a name and a start date.");
      return;
    }
    if (createLock.current) return;
    createLock.current = true;
    const input = {
      name,
      startDate,
      endDate: newEvent.endDate,
      venue: newEvent.venue,
    };
    const knownEvents = (): RegattaIdentity[] =>
      mergeRegattaIdentities([
        registryRegattaIdentities(),
        grouped.events.map((event) => {
          const saved = savedEvents[event.slug];
          return {
            id: saved?.id,
            slug: event.slug,
            name: saved?.name || event.name,
            startDate: saved?.startDate || event.startDate,
            classes: saved?.classes?.length ? saved.classes : event.expectedClasses,
            countsForRanking: saved?.countsForRanking ?? event.countsForRanking,
          };
        }),
        Object.values(savedEvents).map((event) => ({
          id: event.id,
          slug: event.slug,
          name: event.name,
          startDate: event.startDate,
          classes: event.classes,
          countsForRanking: event.countsForRanking,
        })),
      ]);
    const ask = (existing: RegattaIdentity) =>
      choose(
        duplicateRegattaChoice({
          enteredName: name,
          existing,
          noun: "regatta",
        })
      );
    try {
      let known = knownEvents();
      let decision: RegattaDuplicateDecision | null = null;
      const first = planNewRegattaSave(input, known, null);
      if (first.action === "needs-decision") {
        decision = await ask(first.duplicate.existing);
        if (!decision) return;
      }
      let plan = planNewRegattaSave(input, known, decision);
      if (plan.action !== "save") return;
      setCalendarSaving(true);
      const send = async (body: RegattaEventSaveBody) => {
        const res = await fetch("/api/admin/regatta-events", {
          method: "PATCH",
          credentials: "include",
          headers: { "Content-Type": "application/json" },
          body: JSON.stringify(body),
        });
        const data = await res.json().catch(() => ({}));
        return { res, data };
      };
      let sent = await send(plan.body);
      if (sent.res.status === 409 && decision !== "update") {
        const serverExisting = regattaIdentityFromApi(sent.data.existing);
        if (!serverExisting) {
          throw new Error(sent.data.error || "A regatta with this name already exists.");
        }
        known = mergeRegattaIdentities([known, [serverExisting]]);
        decision = await ask(serverExisting);
        if (!decision) return;
        plan = planNewRegattaSave(input, known, decision);
        if (plan.action !== "save") return;
        sent = await send(plan.body);
      }
      if (!sent.res.ok) {
        throw new Error(sent.data.error || "Could not create the event");
      }
      const saved = sent.data.event as SavedCalendarEvent;
      setSavedEvents((prev) => ({ ...prev, [saved.slug]: saved }));
      setCreatingEvent(false);
      setNewEvent({ name: "", startDate: "", endDate: "", venue: "" });
      setSelectedEventSlug(saved.slug);
      toast.success(
        plan.body.create === false
          ? "Existing regatta updated. Its classes were left in place."
          : "Event created. Add a class when you are ready to enter results."
      );
    } catch (err: unknown) {
      toast.error(err instanceof Error ? err.message : "Could not create the event");
    } finally {
      createLock.current = false;
      setCalendarSaving(false);
    }
  };

  const startAddClass = () => {
    if (!selectedEventView || selectedEventView.slug === UNASSIGNED_EVENT_SLUG) return;
    const eventId = savedEvents[selectedEventView.slug]?.id || "";
    if (!eventId) {
      toast.error("Save the event first, so the new class stays on it.");
      setShowCalendarForm(true);
      return;
    }
    if (!confirmLeave()) return;
    const boatClass =
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
                  : "Optimist";
    const division =
      regattaClassFilter === "ilca" || regattaDivisionFilter.startsWith("ILCA")
        ? "Open"
        : regattaDivisionFilter === "Gold" || regattaDivisionFilter === "Silver"
          ? regattaDivisionFilter
          : "Gold";
    setEditingRegattaId("new");
    setSheetTab("details");
    setRegattaForm({
      ...emptyRegattaForm(),
      eventId,
      name: selectedEventView.name,
      date: selectedEventView.startDate || new Date().toISOString().slice(0, 10),
      venue: selectedEventView.venue || "",
      organizer: selectedEventView.organizer || "",
      boatClass,
      division,
      countsForRanking: selectedEventView.countsForRanking,
      status: "draft",
    });
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
        `This removes the event from the admin calendar and deletes every class under it.\n\n` +
        `${event.startDate || "No date"}${event.venue ? ` · ${event.venue}` : ""}\n\n` +
        `Classes:\n${names.listed}${extraLine}\n\n` +
        `Cascade:\n${cascadeLine("Classes", classes.length)}\n` +
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
                  onNewEvent={() => setCreatingEvent(true)}
                />

                {creatingEvent ? (
                  <form
                    className="rounded-2xl border border-slate-200 bg-white p-4"
                    onSubmit={(event) => {
                      event.preventDefault();
                      void createEvent();
                    }}
                  >
                    <h3 className="text-sm font-black text-slate-900">New event</h3>
                    <p className="mt-1 text-xs text-slate-700">
                      A name and start date create the weekend. Add classes after it is saved.
                    </p>
                    <div className="mt-3 grid gap-3 sm:grid-cols-2">
                      <label className="text-xs font-bold text-slate-800">
                        Name
                        <input
                          required
                          value={newEvent.name}
                          onChange={(event) => setNewEvent({ ...newEvent, name: event.target.value })}
                          className="mt-1 w-full rounded-xl border border-slate-300 bg-white px-3 py-2 text-sm text-slate-900"
                        />
                      </label>
                      <label className="text-xs font-bold text-slate-800">
                        Start date
                        <input
                          required
                          type="date"
                          value={newEvent.startDate}
                          onChange={(event) => setNewEvent({ ...newEvent, startDate: event.target.value })}
                          className="mt-1 w-full rounded-xl border border-slate-300 bg-white px-3 py-2 text-sm text-slate-900"
                        />
                      </label>
                      <label className="text-xs font-bold text-slate-800">
                        End date
                        <input
                          type="date"
                          value={newEvent.endDate}
                          onChange={(event) => setNewEvent({ ...newEvent, endDate: event.target.value })}
                          className="mt-1 w-full rounded-xl border border-slate-300 bg-white px-3 py-2 text-sm text-slate-900"
                        />
                      </label>
                      <label className="text-xs font-bold text-slate-800">
                        Venue
                        <input
                          value={newEvent.venue}
                          onChange={(event) => setNewEvent({ ...newEvent, venue: event.target.value })}
                          className="mt-1 w-full rounded-xl border border-slate-300 bg-white px-3 py-2 text-sm text-slate-900"
                        />
                      </label>
                    </div>
                    <div className="mt-3 flex gap-2">
                      <button
                        type="submit"
                        disabled={calendarSaving}
                        className="inline-flex min-h-11 items-center rounded-full bg-orange-600 px-4 text-sm font-bold text-white disabled:opacity-40"
                      >
                        {calendarSaving ? "Saving…" : "Save event"}
                      </button>
                      <button
                        type="button"
                        onClick={() => setCreatingEvent(false)}
                        className="inline-flex min-h-11 items-center rounded-full border border-slate-300 px-4 text-sm font-bold text-slate-800"
                      >
                        Cancel
                      </button>
                    </div>
                  </form>
                ) : null}

                <div className="grid grid-cols-1 gap-4 lg:grid-cols-[minmax(17rem,22rem)_minmax(0,1fr)] lg:items-start">
                <div className={selectedEventSlug || editingRegattaId ? "hidden lg:block" : "block"}>
                  <AdminRegattaEventList
                    events={grouped.events.map((event) =>
                      withSavedEvent(event, savedEvents[event.slug])
                    )}
                    unassignedCount={grouped.unassigned.length}
                    selectedSlug={effectiveEventSlug}
                    onSelect={(slug) => selectEvent(slug)}
                  />
                </div>

                {/* Detail / edit pane */}
                <div className={`w-full glass-panel rounded-2xl border border-slate-200 p-5 sm:p-6 min-h-[320px] transition-all ${
                  selectedEventSlug || editingRegattaId ? "block" : "hidden lg:block"
                }`}>
                  {!selectedEvent && !editingRegattaId ? (
                    <div className="h-full flex flex-col items-center justify-center text-center py-16 px-4">
                      <Calendar className="h-10 w-10 text-slate-600 mb-3" />
                      <p className="text-sm font-bold text-slate-800">
                        Select an event
                      </p>
                      <p className="text-xs text-slate-700 mt-1 max-w-sm">
                        Choose an event to review its classes, edit the calendar card, or enter results.
                      </p>
                    </div>
                  ) : editingRegattaId ? (
                      <div className="space-y-5">
                        {/* Sheet Header */}
                        <div className="flex flex-col sm:flex-row sm:items-center justify-between gap-3 pb-3 border-b border-white/5">
                          <div className="flex items-center gap-2 flex-wrap min-w-0">
                            <button
                              type="button"
                              aria-label="Back to events"
                              onClick={() => {
                                setEditingRegattaId(null);
                                onClearSheet?.();
                              }}
                              className="mr-1 inline-flex items-center gap-1 rounded p-1 text-xs font-bold text-slate-700 transition-colors hover:bg-slate-100 hover:text-slate-900"
                              title="Back to events"
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
                              <h3 className="mt-1 max-w-lg truncate text-base font-black text-slate-900">
                                {editingRegattaId === "new"
                                  ? "New class"
                                  : regattaForm.name || "Untitled class"}
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
                                className="inline-flex items-center gap-1 rounded-full border border-slate-200 bg-white px-3 py-1 text-xs font-semibold text-slate-800 transition-all hover:bg-slate-50"
                                title="Open public leaderboard in new tab"
                              >
                                <ExternalLink className="h-3 w-3 text-orange-400" />
                                <span>Public page</span>
                              </Link>
                            )}
                            {editingRegattaId !== "new" && (
                              <button
                                type="button"
                                aria-label={`Delete ${regattaForm.name || "class"} and all of its results`}
                                onClick={() => handleDeleteRegatta(editingRegattaId)}
                                className="rounded-full border border-slate-200 bg-white p-1.5 text-slate-600 transition-colors hover:border-rose-300 hover:bg-rose-50 hover:text-rose-800 focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-rose-700"
                                title="Delete this class and its results"
                              >
                                <Trash2 className="h-3.5 w-3.5" />
                              </button>
                            )}
                          </div>
                        </div>

                        <div
                          className="flex flex-wrap items-center gap-1 border-b border-slate-200 pb-3"
                          role="tablist"
                          aria-label="Class steps"
                        >
                          {(
                            [
                              ["event", "Event"],
                              ["details", "Class"],
                              ["results", "Results"],
                              ["check", "Check"],
                              ["publish", "Publish"],
                            ] as const
                          ).map(([id, label], index) => {
                            const locked = editingRegattaId === "new" && id !== "event" && id !== "details";
                            const selected = id !== "event" && sheetTab === id;
                            return (
                              <button
                                key={id}
                                type="button"
                                role="tab"
                                id={id === "details" ? "regatta-details-tab" : id === "results" ? "regatta-results-tab" : undefined}
                                aria-selected={selected}
                                disabled={locked}
                                onClick={() => {
                                  if (id === "event") {
                                    if (!confirmLeave()) return;
                                    setEditingRegattaId(null);
                                    onClearSheet?.();
                                    return;
                                  }
                                  if (id === "results" && editingRegattaId && editingRegattaId !== "new") {
                                    onOpenResults?.(editingRegattaId);
                                  } else if (id === "check" && editingRegattaId && editingRegattaId !== "new") {
                                    onOpenCheck?.(editingRegattaId);
                                  }
                                  setSheetTab(id);
                                }}
                                className={`inline-flex min-h-11 items-center gap-1.5 rounded-xl px-3 text-xs font-bold focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-orange-600 disabled:opacity-40 ${
                                  selected
                                    ? "bg-[var(--sp-harbour-teal)] text-white"
                                    : "text-slate-800 hover:bg-slate-100"
                                }`}
                              >
                                <span className="font-mono text-[10px]">{index + 1}</span>
                                {label}
                              </button>
                            );
                          })}
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
                            <div className="rounded-2xl border border-slate-200 bg-white p-4 sm:p-5 space-y-4">
                              <h4 className="text-xs font-black uppercase tracking-wider text-slate-400 flex items-center gap-1.5">
                                <Calendar className="h-3.5 w-3.5 text-orange-800" />
                                Class
                              </h4>

                              <div className="grid grid-cols-1 sm:grid-cols-2 gap-3">
                                <div>
                                  <label className="text-[11px] font-bold text-slate-400 uppercase">
                                    Class name
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
                                    className="mt-1 w-full rounded-xl border border-slate-300 bg-white px-3 py-2 text-slate-900 text-xs focus:outline-none focus:border-orange-500/50"
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
                                    className="mt-1 w-full rounded-xl border border-slate-300 bg-white px-3 py-2 text-slate-900 text-xs font-semibold focus:outline-none focus:border-orange-500/50"
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
                                      <label className="flex items-center gap-1.5 text-[11px] font-black uppercase tracking-wider text-orange-900">
                                        <Link2 className="h-3.5 w-3.5 text-orange-400" />
                                        URL Slug
                                      </label>
                                      <p className="text-[11px] text-slate-400 mt-0.5">
                                        The public path for this class. Results and rankings stay in place when it changes.
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
                                      className="inline-flex shrink-0 items-center gap-1 rounded-lg border border-orange-300 bg-orange-50 px-2.5 py-1 text-[11px] font-bold text-orange-900 transition-colors hover:bg-orange-100"
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
                                      className="w-full rounded-xl border border-slate-300 bg-white px-3 py-2 text-xs font-mono text-slate-900 focus:outline-none focus:border-orange-500/50"
                                    />
                                  </div>
                                  {canonicalPublicHref && (
                                    <div className="flex items-center gap-2 text-[11px] font-mono text-slate-400 pt-0.5">
                                      <span className="text-slate-500 shrink-0">Live URL:</span>
                                      <span className="truncate font-semibold text-emerald-800">
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
                                    className="mt-1 w-full rounded-xl border border-slate-300 bg-white px-3 py-2 text-slate-900 text-xs font-mono focus:outline-none focus:border-orange-500/50"
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
                                    className="mt-1 w-full rounded-xl border border-slate-300 bg-white px-3 py-2 text-slate-900 text-xs font-mono focus:outline-none focus:border-orange-500/50"
                                  />
                                </div>
                              </div>
                            </div>

                            {/* Fleet & Scoring Card */}
                            <div className="rounded-2xl border border-slate-200 bg-white p-4 sm:p-5 space-y-4">
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
                                                  : "bg-slate-100 text-slate-700 hover:bg-slate-200 hover:text-slate-900"
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
                                    className="w-full rounded-xl border border-slate-300 bg-white px-3 py-2 text-slate-900 text-xs focus:outline-none focus:border-orange-500/50"
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
                                    className="mt-1 w-full rounded-xl border border-slate-300 bg-white px-3 py-2 text-slate-900 text-xs focus:outline-none focus:border-orange-500/50"
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
                                    className="mt-1 w-full rounded-xl border border-slate-300 bg-white px-3 py-2 text-slate-900 text-xs font-mono focus:outline-none focus:border-orange-500/50"
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
                                    className="mt-1 w-full rounded-xl border border-slate-300 bg-white px-3 py-2 text-slate-900 text-xs font-mono focus:outline-none focus:border-orange-500/50"
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
                                      <span className="block font-bold text-slate-900">
                                        Counts for Series Ranking
                                      </span>
                                      <span className="text-[11px] text-slate-400 leading-relaxed block mt-0.5">
                                        Optimist: Best 3 of 5. ILCA: Best 3 of last 5. Minimum 3 completed races required to rank.
                                      </span>
                                    </div>
                                  </label>

                                  {regattaForm.raceCount !== "" &&
                                    Number(regattaForm.raceCount) < 3 && (
                                      <div className="rounded-xl border border-amber-300 bg-amber-50 px-3 py-2 text-xs font-semibold text-amber-950">
                                        {String(regattaForm.raceCount)} completed race(s). Ranking needs at least 3 completed races, so this class stays non-ranking.
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
                                      <span className="block font-bold text-amber-950">
                                        Official Selection Trial / Qualifier
                                      </span>
                                      <span className="text-[11px] text-slate-400 leading-relaxed block mt-0.5">
                                        Marks this class as a selection trial. Link it to the selection event these results count toward.
                                      </span>
                                    </div>
                                  </label>
                                  {regattaForm.isSelectionTrial ? (
                                    <div className="rounded-xl border border-amber-300 bg-amber-50 p-3">
                                      <label className="text-[11px] font-bold uppercase text-amber-950">
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
                                        className="mt-1 w-full rounded-xl border border-slate-300 bg-white px-3 py-2 text-slate-900 text-xs focus:outline-none focus:border-orange-500/50"
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
                                      <p className="mt-1.5 text-[11px] leading-relaxed text-amber-950">
                                        {selectionEventsForBoatClass(regattaForm.boatClass).length === 0
                                          ? "No selection events are defined for this class."
                                          : "The linked event uses this class sheet in the selection campaign."}
                                      </p>
                                    </div>
                                  ) : null}
                                </div>
                              </div>
                            </div>

                            {/* Form Action Buttons */}
                            <div className="flex flex-wrap items-center justify-between gap-3 border-t border-white/5 pt-4">
                              <button
                                type="button"
                                onClick={() => {
                                  if (!confirmLeave()) return;
                                  setEditingRegattaId(null);
                                  onClearSheet?.();
                                }}
                                className="rounded-full border border-slate-300 bg-white px-4 py-2 text-xs font-bold text-slate-800 transition-colors hover:bg-slate-50"
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
                                    className="rounded-full border border-slate-300 bg-white px-4 py-2 text-xs font-bold text-slate-800 transition-colors hover:bg-slate-50"
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
                                    className="inline-flex items-center gap-1.5 rounded-full border border-slate-300 bg-white px-4 py-2 text-xs font-bold text-slate-800 transition-colors hover:bg-slate-50"
                                  >
                                    <Trophy className="h-3.5 w-3.5 text-orange-400" />
                                    <span>Enter results</span>
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
                                    <span>Save class</span>
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

                        {(sheetTab === "check" || sheetTab === "publish") && editingRegattaId !== "new" && (
                          <div className="space-y-4 rounded-2xl border border-slate-200 bg-white p-4" aria-live="polite">
                            <h4 className="text-sm font-black text-slate-900">
                              {readiness?.summary === "publishable_ranking"
                                ? "Publishable and ranking"
                                : readiness?.summary === "publishable_non_ranking"
                                  ? "Publishable, non-ranking"
                                  : readiness?.summary === "blocked"
                                    ? "Blocked"
                                    : readiness
                                      ? "Needs work"
                                      : "Checking this class…"}
                            </h4>
                            {readiness ? (
                              <ul className="space-y-1">
                                {readiness.checks.map((check) => (
                                  <li key={check.code} className="text-sm text-slate-800">
                                    {check.severity === "ok" ? "Ready. " : check.severity === "warning" ? "Note. " : "Needed. "}
                                    {check.label}
                                  </li>
                                ))}
                              </ul>
                            ) : (
                              <p className="text-sm text-slate-700">The publication check is loading.</p>
                            )}
                            {sheetTab === "publish" && editingRegattaId ? (
                              <button
                                type="button"
                                disabled={publishingId === editingRegattaId}
                                onClick={() => void handleTogglePublish(editingRegattaId, regattaForm.status)}
                                className="inline-flex min-h-11 items-center rounded-full bg-emerald-700 px-4 text-sm font-bold text-white disabled:opacity-40"
                              >
                                {regattaForm.status === "published" ? "Unpublish" : "Publish"}
                              </button>
                            ) : (
                              <button
                                type="button"
                                onClick={() => setSheetTab("publish")}
                                className="inline-flex min-h-11 items-center rounded-full border border-slate-300 px-4 text-sm font-bold text-slate-900"
                              >
                                Continue to publish
                              </button>
                            )}
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
                                All events
                              </button>
                            ) : null}
                            <h3 className="text-base font-black text-slate-900 mt-0.5">
                              {selectedEventView.name}
                            </h3>
                            {selectedEventView.slug === UNASSIGNED_EVENT_SLUG ? (
                              <p className="mt-1 max-w-xl text-xs font-medium text-slate-600">
                                {selectedEventView.sheets.length === 1
                                  ? "1 class is not on an event."
                                  : `${selectedEventView.sheets.length} classes are not on an event.`}{" "}
                                Choose an event for each class, then link it.
                              </p>
                            ) : (
                              <EventFacts
                                dates={
                                  joinDateRange(
                                    selectedEventView.startDate,
                                    selectedEventView.endDate
                                  ) || "—"
                                }
                                venue={selectedEventView.venue}
                                organiser={selectedEventView.organizer}
                                className="mt-1.5 space-y-0.5 text-xs font-medium"
                                labelClassName="font-bold text-slate-900"
                                valueClassName="text-slate-700"
                              />
                            )}
                          </div>
                          <div className="flex items-center gap-2">
                            {selectedEventView.slug !== UNASSIGNED_EVENT_SLUG && (
                              <button
                                type="button"
                                onClick={() => setShowCalendarForm((prev) => !prev)}
                                className="inline-flex min-h-11 items-center gap-1.5 rounded-full border border-slate-300 bg-white px-3.5 text-xs font-bold text-slate-800 hover:bg-slate-50"
                              >
                                <Sliders className="h-3 w-3 text-orange-700" />
                                <span>{showCalendarForm ? "Hide event editor" : "Edit event"}</span>
                              </button>
                            )}
                            {selectedEventView.slug !== UNASSIGNED_EVENT_SLUG && isSuperadmin ? (
                              <button
                                type="button"
                                onClick={startAddClass}
                                className="inline-flex min-h-11 items-center gap-1.5 rounded-full bg-orange-600 px-3.5 text-xs font-bold text-white hover:bg-orange-500"
                              >
                                <Plus className="h-3.5 w-3.5" />
                                Add class
                              </button>
                            ) : null}
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
                                ? `Classes (${selectedEventView.sheets.length})`
                                : `Classes (${selectedEventView.sheets.length + selectedEventView.shells.length})`}
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
                                        currentEventId={
                                          selectedEventView.slug === UNASSIGNED_EVENT_SLUG
                                            ? ""
                                            : savedEvents[selectedEventView.slug]?.id || ""
                                        }
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
                                        onDelete={
                                          isSuperadmin
                                            ? () => {
                                                void handleDeleteRegatta(sheet.id);
                                              }
                                            : undefined
                                        }
                                        readiness={cardReadiness[sheet.id]}
                                        onEditDetails={() => {
                                          if (editingRegattaId !== sheet.id && !confirmLeave()) return;
                                          seenSheetId.current = sheet.id;
                                          appliedSheetView.current = `${sheet.id}|${eventsView}`;
                                          setEditingRegattaId(sheet.id);
                                          rememberClassForm(sheet);
                                          setSheetTab("details");
                                        }}
                                        onOpenResults={() => {
                                          if (editingRegattaId !== sheet.id && !confirmLeave()) return;
                                          seenSheetId.current = sheet.id;
                                          appliedSheetView.current = `${sheet.id}|results`;
                                          setEditingRegattaId(sheet.id);
                                          rememberClassForm(sheet);
                                          setSheetTab("results");
                                          onOpenResults?.(sheet.id);
                                        }}
                                        onOpenCheck={() => {
                                          if (editingRegattaId !== sheet.id && !confirmLeave()) return;
                                          seenSheetId.current = sheet.id;
                                          appliedSheetView.current = `${sheet.id}|readiness`;
                                          setEditingRegattaId(sheet.id);
                                          rememberClassForm(sheet);
                                          setSheetTab("publish");
                                          onOpenCheck?.(sheet.id);
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
