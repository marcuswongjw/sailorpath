"use client";

import { useCallback, useEffect, useRef, useState } from "react";
import Link from "next/link";
import { useRouter } from "next/navigation";
import {
  Trophy,
  User,
  Search,
  ChevronRight,
  Clock,
  Sailboat,
  AlertTriangle,
  StickyNote,
  Plus,
  Trash2,
  Calendar,
  CheckSquare,
  Square,
  RotateCcw,
  CheckCircle2,
  Lock,
  ExternalLink,
  Award,
  Users,
  Compass,
  Star,
  X,
} from "lucide-react";
import { relationLabel, type ClaimRelation } from "@/lib/claimRelation";
import { birthYear } from "@/lib/age";
import { fleetPillClass } from "@/components/sailor-profile/helpers";
import { useFeedback } from "@/components/ui/FeedbackProvider";
import {
  YOUTH_EQUIPMENT_PRESETS,
  SIMPLIFIED_CONDITION_META,
  toSimplifiedCondition,
  fromSimplifiedCondition,
  brandsForCategory,
  categoryLabel,
  type QuickEquipmentPreset,
  type EquipmentCategory,
  type SimplifiedCondition,
} from "@/lib/equipment";

type Standing = {
  periodLabel: string;
  fleet: string;
  overallRank: number;
  fleetSize: number;
  best3of5: number;
  trendNote: string;
};

type SelectionTrials = {
  rank: number;
  nettScore: number;
  eventsSailed: number;
  isQualifiedAsian: boolean;
  isQualifiedPerth: boolean;
  asianTeamRank?: number;
  gapToCutoff?: number;
};

type RecentResult = {
  regattaName: string;
  regattaDate: string;
  rank: number;
  boatClass: string | null;
};

type PrimaryGearItem = {
  id: string;
  category: string;
  brand: string | null;
  model: string | null;
  label: string | null;
  condition: string;
  status: string;
  isPrimary: boolean;
};

type CoachFeedbackItem = {
  id: string;
  type: string;
  category: string | null;
  title: string;
  detail: string | null;
  recordDate: string;
  status: string;
};

type Note = {
  id: string;
  body: string;
  createdAt: string;
};

type Athlete = {
  id: string;
  name: string;
  handle: string;
  sailNumber: string;
  sailNumberIlca4?: string | null;
  club: string;
  school?: string | null;
  gender?: string | null;
  nationality?: string | null;
  avatarUrl?: string | null;
  currentFleet?: string | null;
  ownerRelation?: ClaimRelation | null;
  nationalSquadStatus?: string | null;
  dob?: string | null;
  standing: Standing | null;
  selectionTrials?: SelectionTrials | null;
  recentResults?: RecentResult[];
  primaryGear?: PrimaryGearItem[];
  equipmentAlertCount?: number;
  equipmentAlerts?: { label: string; reason: string }[];
  coachFeedback?: CoachFeedbackItem[];
  notes?: Note[];
};

type UpcomingRegatta = {
  id: string;
  name: string;
  date: string;
  boatClass: string | null;
  division: string | null;
  slug: string | null;
};

type PendingClaim = {
  id: string;
  status: string;
  relation: ClaimRelation | null;
  sailorName: string;
  sailorHandle: string;
  createdAt: string;
};

const NOTE_CATEGORIES = [
  "General",
  "Training",
  "Regatta Debrief",
  "Logistics",
  "Gear",
] as const;
type NoteCategory = (typeof NOTE_CATEGORIES)[number];

const DEFAULT_RACE_CHECKLIST_ITEMS = [
  {
    id: "measurement_cert",
    label: "Official class measurement certificate verified & onboard",
  },
  {
    id: "spares_rigging",
    label: "Spare battens, sail ties (2.5mm / 3.0mm) & wind indicator checked",
  },
] as const;

const CARD =
  "rounded-2xl border border-[var(--sp-cool-veil)] bg-[var(--sp-warm-white)] shadow-xs";
const NESTED =
  "rounded-xl border border-[var(--sp-cool-veil)] bg-[var(--sp-sailcloth)]";
const SECONDARY_BTN =
  "inline-flex items-center justify-center gap-1.5 rounded-full border border-[var(--sp-cool-veil)] bg-[var(--sp-warm-white)] px-4 py-2 text-xs font-bold text-[var(--sp-harbour-shadow)] hover:border-[var(--sp-harbour-teal)] transition-colors";
const PRIMARY_BTN = "sp-btn-primary";
const SECTION_KICKER =
  "text-[10px] font-bold uppercase tracking-[0.16em] text-[var(--sp-racing-orange)]";
const SECTION_TITLE =
  "mt-1 text-base font-black text-[var(--sp-harbour-shadow)]";
const MUTED = "text-[var(--sp-slate-soft)]";
const INK = "text-[var(--sp-harbour-shadow)]";
const BODY = "text-[var(--sp-charcoal-slate)]";
const LINK_TEAL =
  "text-[11px] font-bold text-[var(--sp-harbour-teal)] hover:underline";

function formatAgeCategory(dob?: string | null) {
  const by = birthYear(dob);
  if (!by) return null;
  const currentYear = new Date().getFullYear();
  const age = currentYear - by;
  return `${by} · U${age + 1} (${age} yrs)`;
}

function parseNoteCategory(body: string): { category: string | null; text: string } {
  const match = body.match(/^\[(.*?)\]\s*(.*)$/);
  if (match) {
    return { category: match[1], text: match[2] };
  }
  return { category: null, text: body };
}

export function ParentDashboard() {
  const router = useRouter();
  const { toast, confirm } = useFeedback();
  const [athletes, setAthletes] = useState<Athlete[]>([]);
  const [upcomingRegattas, setUpcomingRegattas] = useState<UpcomingRegatta[]>([]);
  const [pendingClaims, setPendingClaims] = useState<PendingClaim[]>([]);
  const [isParentStyle, setIsParentStyle] = useState(true);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<string | null>(null);

  // Selected athlete: 'all' or athlete ID
  const [selectedAthleteId, setSelectedAthleteId] = useState<string | "all">("all");
  const initialSelectionDone = useRef(false);

  // Private note draft state
  const [selectedCategory, setSelectedCategory] = useState<NoteCategory>("General");
  const [noteDraft, setNoteDraft] = useState<Record<string, string>>({});
  const [noteBusy, setNoteBusy] = useState<string | null>(null);

  // Pre-race checklist state persisted per athlete (lazy initialized from localStorage)
  const [checklistState, setChecklistState] = useState<Record<string, Record<string, boolean>>>(() => {
    if (typeof window === "undefined") return {};
    try {
      const raw = localStorage.getItem("sailorpath_race_checklist");
      return raw ? JSON.parse(raw) : {};
    } catch {
      return {};
    }
  });

  const [customChecklistItems, setCustomChecklistItems] = useState<
    Record<string, Array<{ id: string; label: string }>>
  >(() => {
    if (typeof window === "undefined") return {};
    try {
      const raw = localStorage.getItem("sailorpath_custom_checklist_items");
      return raw ? JSON.parse(raw) : {};
    } catch {
      return {};
    }
  });
  const [newChecklistText, setNewChecklistText] = useState("");

  // Equipment in-place management state
  const [showAddGearModal, setShowAddGearModal] = useState(false);
  const [addGearTab, setAddGearTab] = useState<"presets" | "custom">("presets");
  const [addGearBusy, setAddGearBusy] = useState(false);
  const [customGearCategory, setCustomGearCategory] = useState<EquipmentCategory>("sail");
  const [customGearBrand, setCustomGearBrand] = useState("");
  const [customGearModel, setCustomGearModel] = useState("");
  const [customGearLabel, setCustomGearLabel] = useState("");
  const [customGearCondition, setCustomGearCondition] = useState<SimplifiedCondition>("race_ready");
  const [customGearPrimary, setCustomGearPrimary] = useState(true);

  const load = useCallback(async () => {
    setLoading(true);
    setError(null);
    try {
      const res = await fetch("/api/account/family", {
        credentials: "include",
      });
      if (res.status === 401) {
        router.replace(`/login?next=${encodeURIComponent("/parent")}`);
        return;
      }
      const data = await res.json();
      if (!res.ok) throw new Error(data.error || "Could not load dashboard");
      const athleteList: Athlete[] = data.athletes || [];
      setAthletes(athleteList);
      setUpcomingRegattas(data.upcomingRegattas || []);
      setPendingClaims(data.pendingClaims || []);
      setIsParentStyle(Boolean(data.isParentStyle));

      // Select first athlete on initial load if available
      if (!initialSelectionDone.current) {
        initialSelectionDone.current = true;
        if (athleteList.length > 0) {
          setSelectedAthleteId(athleteList[0].id);
        }
      } else {
        setSelectedAthleteId((prev) => {
          if (prev !== "all" && !athleteList.some((a) => a.id === prev)) {
            return athleteList[0]?.id || "all";
          }
          return prev;
        });
      }
    } catch (e) {
      setError(e instanceof Error ? e.message : "Error");
    } finally {
      setLoading(false);
    }
  }, [router]);

  useEffect(() => {
    // eslint-disable-next-line react-hooks/set-state-in-effect
    void load();
  }, [load]);

  useEffect(() => {
    if (!showAddGearModal) return;
    const onKey = (e: KeyboardEvent) => {
      if (e.key === "Escape") setShowAddGearModal(false);
    };
    document.addEventListener("keydown", onKey);
    const prevOverflow = document.body.style.overflow;
    document.body.style.overflow = "hidden";
    return () => {
      document.removeEventListener("keydown", onKey);
      document.body.style.overflow = prevOverflow;
    };
  }, [showAddGearModal]);

  const toggleChecklistItem = (athleteId: string, itemId: string) => {
    setChecklistState((prev) => {
      const athleteState = prev[athleteId] || {};
      const updated = {
        ...prev,
        [athleteId]: {
          ...athleteState,
          [itemId]: !athleteState[itemId],
        },
      };
      try {
        localStorage.setItem("sailorpath_race_checklist", JSON.stringify(updated));
      } catch {
        // storage quota
      }
      return updated;
    });
  };

  const addCustomChecklistItem = (athleteId: string) => {
    const trimmed = newChecklistText.trim();
    if (!trimmed) return;
    const newItem = {
      id: `custom_${Date.now()}`,
      label: trimmed,
    };
    setCustomChecklistItems((prev) => {
      const list = prev[athleteId] || [];
      const updated = {
        ...prev,
        [athleteId]: [...list, newItem],
      };
      try {
        localStorage.setItem(
          "sailorpath_custom_checklist_items",
          JSON.stringify(updated)
        );
      } catch {
        // ignore
      }
      return updated;
    });
    setNewChecklistText("");
    toast.success("Checklist item added.");
  };

  const removeCustomChecklistItem = (athleteId: string, itemId: string) => {
    setCustomChecklistItems((prev) => {
      const list = (prev[athleteId] || []).filter((it) => it.id !== itemId);
      const updated = {
        ...prev,
        [athleteId]: list,
      };
      try {
        localStorage.setItem(
          "sailorpath_custom_checklist_items",
          JSON.stringify(updated)
        );
      } catch {
        // ignore
      }
      return updated;
    });
    setChecklistState((prev) => {
      const athleteState = { ...(prev[athleteId] || {}) };
      delete athleteState[itemId];
      const updated = { ...prev, [athleteId]: athleteState };
      try {
        localStorage.setItem("sailorpath_race_checklist", JSON.stringify(updated));
      } catch {
        // ignore
      }
      return updated;
    });
  };

  const resetChecklist = (athleteId: string) => {
    setChecklistState((prev) => {
      const updated = { ...prev, [athleteId]: {} };
      try {
        localStorage.setItem("sailorpath_race_checklist", JSON.stringify(updated));
      } catch {
        // ignore
      }
      return updated;
    });
    toast.info("Checklist reset for next regatta.");
  };

  const handleToggleGearCondition = async (
    athleteId: string,
    gearId: string,
    currentCondition: string
  ) => {
    const currentSimplified = toSimplifiedCondition(currentCondition);
    const nextSimplified: SimplifiedCondition =
      currentSimplified === "race_ready"
        ? "practice_only"
        : currentSimplified === "practice_only"
        ? "needs_attention"
        : "race_ready";
    const nextCondition = fromSimplifiedCondition(nextSimplified);

    let previousAthletes: Athlete[] = athletes;
    setAthletes((prev) => {
      previousAthletes = prev;
      return prev.map((ath) => {
        if (ath.id !== athleteId) return ath;
        return {
          ...ath,
          primaryGear: (ath.primaryGear || []).map((g) =>
            g.id === gearId ? { ...g, condition: nextCondition } : g
          ),
        };
      });
    });

    try {
      const res = await fetch("/api/account/equipment", {
        method: "PATCH",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({ id: gearId, condition: nextCondition }),
        credentials: "include",
      });
      if (!res.ok) throw new Error();
      toast.success(
        nextSimplified === "race_ready"
          ? "Gear marked Race Ready"
          : nextSimplified === "practice_only"
          ? "Gear marked Practice Only"
          : "Gear marked Needs Repair"
      );
    } catch {
      setAthletes(previousAthletes);
      toast.error("Failed to update equipment condition.");
    }
  };

  const handleToggleGearPrimary = async (
    athleteId: string,
    gearId: string,
    currentPrimary: boolean
  ) => {
    const nextPrimary = !currentPrimary;

    let previousAthletes: Athlete[] = athletes;
    setAthletes((prev) => {
      previousAthletes = prev;
      return prev.map((ath) => {
        if (ath.id !== athleteId) return ath;
        return {
          ...ath,
          primaryGear: (ath.primaryGear || []).map((g) =>
            g.id === gearId ? { ...g, isPrimary: nextPrimary } : g
          ),
        };
      });
    });

    try {
      const res = await fetch("/api/account/equipment", {
        method: "PATCH",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({ id: gearId, isPrimary: nextPrimary }),
        credentials: "include",
      });
      if (!res.ok) throw new Error();
      toast.success(
        nextPrimary ? "Set as primary race gear" : "Removed from primary gear."
      );
    } catch {
      setAthletes(previousAthletes);
      toast.error("Failed to update gear priority.");
    }
  };

  const handleDeleteGear = async (athleteId: string, gearId: string) => {
    const confirmed = await confirm({
      title: "Remove Equipment",
      message:
        "Are you sure you want to remove this item from your equipment locker?",
      confirmLabel: "Remove",
      tone: "danger",
    });
    if (!confirmed) return;

    let previousAthletes: Athlete[] = athletes;
    setAthletes((prev) => {
      previousAthletes = prev;
      return prev.map((ath) => {
        if (ath.id !== athleteId) return ath;
        return {
          ...ath,
          primaryGear: (ath.primaryGear || []).filter((g) => g.id !== gearId),
        };
      });
    });

    try {
      const res = await fetch(
        `/api/account/equipment?id=${encodeURIComponent(gearId)}`,
        {
          method: "DELETE",
          credentials: "include",
        }
      );
      if (!res.ok) throw new Error();
      toast.success("Equipment item removed.");
    } catch {
      setAthletes(previousAthletes);
      toast.error("Failed to remove equipment.");
    }
  };

  const handleAddGearPreset = async (
    athleteId: string,
    preset: QuickEquipmentPreset
  ) => {
    setAddGearBusy(true);
    try {
      const itemsToAdd =
        preset.bundleItems && preset.bundleItems.length > 0
          ? preset.bundleItems.map((b) => ({
              sailorId: athleteId,
              boatClass: preset.boatClass,
              category: b.category,
              brand: b.brand,
              model: b.model,
              condition: "good",
              status: "active",
              isPrimary: true,
            }))
          : [
              {
                sailorId: athleteId,
                boatClass: preset.boatClass,
                category: preset.category,
                brand: preset.brand,
                model: preset.model,
                windRange: preset.windRange,
                condition: "good",
                status: "active",
                isPrimary: true,
              },
            ];

      for (const item of itemsToAdd) {
        const res = await fetch("/api/account/equipment", {
          method: "POST",
          headers: { "Content-Type": "application/json" },
          body: JSON.stringify(item),
          credentials: "include",
        });
        const data = await res.json().catch(() => ({}));
        if (!res.ok) {
          throw new Error(data.error || "Failed to add preset gear");
        }
        if (data.item) {
          setAthletes((prev) =>
            prev.map((ath) => {
              if (ath.id !== athleteId) return ath;
              const existing = ath.primaryGear || [];
              return {
                ...ath,
                primaryGear: [
                  ...existing.filter((x) => x.id !== data.item.id),
                  {
                    id: data.item.id,
                    category: data.item.category,
                    brand: data.item.brand,
                    model: data.item.model,
                    label: data.item.label,
                    condition: data.item.condition,
                    status: data.item.status,
                    isPrimary: data.item.isPrimary,
                  },
                ],
              };
            })
          );
        }
      }
      setShowAddGearModal(false);
      toast.success(`Added ${preset.name} to locker!`);
    } catch {
      toast.error("Failed to add preset gear.");
    } finally {
      setAddGearBusy(false);
    }
  };

  const handleCreateCustomGear = async (athleteId: string) => {
    setAddGearBusy(true);
    try {
      const item = {
        sailorId: athleteId,
        boatClass: "optimist",
        category: customGearCategory,
        brand: customGearBrand.trim() || null,
        model: customGearModel.trim() || null,
        label: customGearLabel.trim() || null,
        condition: fromSimplifiedCondition(customGearCondition),
        status: "active",
        isPrimary: customGearPrimary,
      };

      const res = await fetch("/api/account/equipment", {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify(item),
        credentials: "include",
      });
      const data = await res.json();
      if (!res.ok || !data.item)
        throw new Error(data.error || "Failed to add gear");

      setAthletes((prev) =>
        prev.map((ath) => {
          if (ath.id !== athleteId) return ath;
          const existing = ath.primaryGear || [];
          return {
            ...ath,
            primaryGear: [
              ...existing.filter((x) => x.id !== data.item.id),
              {
                id: data.item.id,
                category: data.item.category,
                brand: data.item.brand,
                model: data.item.model,
                label: data.item.label,
                condition: data.item.condition,
                status: data.item.status,
                isPrimary: data.item.isPrimary,
              },
            ],
          };
        })
      );
      setShowAddGearModal(false);
      setCustomGearBrand("");
      setCustomGearModel("");
      setCustomGearLabel("");
      toast.success("Added item to equipment locker!");
    } catch (e) {
      toast.error(e instanceof Error ? e.message : "Failed to add equipment.");
    } finally {
      setAddGearBusy(false);
    }
  };

  const addNote = async (sailorId: string) => {
    const rawBody = (noteDraft[sailorId] || "").trim();
    if (rawBody.length < 2) return;
    const body = selectedCategory !== "General" ? `[${selectedCategory}] ${rawBody}` : rawBody;

    setNoteBusy(sailorId);
    try {
      const res = await fetch("/api/account/parent-notes", {
        method: "POST",
        credentials: "include",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({ sailorId, body }),
      });
      const data = await res.json();
      if (!res.ok) throw new Error(data.error || "Could not save note");
      setNoteDraft((d) => ({ ...d, [sailorId]: "" }));
      await load();
      toast.success("Private note added");
    } catch (e) {
      toast.error(e instanceof Error ? e.message : "Error");
    } finally {
      setNoteBusy(null);
    }
  };

  const deleteNote = async (id: string) => {
    const ok = await confirm({
      title: "Delete this private note?",
      tone: "danger",
      confirmLabel: "Delete",
    });
    if (!ok) return;
    setNoteBusy(id);
    try {
      const res = await fetch(
        `/api/account/parent-notes?id=${encodeURIComponent(id)}`,
        { method: "DELETE", credentials: "include" }
      );
      if (!res.ok) {
        const data = await res.json();
        throw new Error(data.error || "Delete failed");
      }
      await load();
      toast.success("Note deleted");
    } catch (e) {
      toast.error(e instanceof Error ? e.message : "Error");
    } finally {
      setNoteBusy(null);
    }
  };

  if (loading) {
    return (
      <div className="flex-1 flex flex-col items-center justify-center gap-3 py-24 px-4">
        <div
          className="h-1 w-40 max-w-[60vw] overflow-hidden rounded-full bg-[var(--sp-cool-veil)]"
          role="status"
          aria-live="polite"
          aria-label="Loading dashboard"
        >
          <div className="h-full w-1/2 animate-pulse rounded-full bg-[var(--sp-harbour-teal)]" />
        </div>
        <p className="text-sm font-semibold text-[var(--sp-slate-soft)]">Loading dashboard…</p>
      </div>
    );
  }

  const activeAthlete =
    selectedAthleteId === "all"
      ? null
      : athletes.find((a) => a.id === selectedAthleteId) || null;

  const title = isParentStyle ? "Parent Dashboard" : "Sailor Dashboard";
  const subtitle = isParentStyle
    ? "Linked athletes, series standing, boat locker, coach logs, and race-day prep."
    : "Your series ranking, selection trials, boat locker, and private notes.";

  return (
    <div className="mx-auto max-w-6xl w-full px-4 py-8 sm:py-12 space-y-6 sm:space-y-8">
      <header className="flex flex-col gap-4 sm:flex-row sm:items-end sm:justify-between">
        <div className="min-w-0">
          <p className="text-[11px] font-bold uppercase tracking-[0.18em] text-[var(--sp-racing-orange)]">
            {isParentStyle ? "Parent workspace" : "Sailor workspace"}
          </p>
          <h1 className="mt-1 text-3xl font-black tracking-tight text-[var(--sp-harbour-shadow)] sm:text-4xl">
            {title}
          </h1>
          <p className={`mt-2 text-sm ${BODY} max-w-2xl`}>{subtitle}</p>
        </div>
        <div className="flex items-center gap-2">
          <Link href="/search" className={SECONDARY_BTN}>
            <Search className="h-3.5 w-3.5" />
            Find a sailor
          </Link>
          <Link href="/account" className={SECONDARY_BTN}>
            Settings
          </Link>
        </div>
      </header>

      {error && (
        <p className="text-sm font-bold text-rose-700 rounded-xl border border-rose-200 bg-rose-50 px-4 py-3">
          {error}
        </p>
      )}

      {pendingClaims.length > 0 && (
        <section className="rounded-2xl border border-[var(--sp-racing-orange)]/25 bg-[var(--sp-racing-mist)]/40 p-5 space-y-3">
          <h2 className="text-xs font-black text-[var(--sp-racing-deep)] uppercase tracking-wider flex items-center gap-2">
            <Clock className="h-4 w-4" />
            Claims awaiting approval ({pendingClaims.length})
          </h2>
          <ul className="grid grid-cols-1 sm:grid-cols-2 gap-2">
            {pendingClaims.map((c) => (
              <li
                key={c.id}
                className={`${NESTED} bg-[var(--sp-warm-white)] px-3.5 py-3 flex items-center justify-between gap-2`}
              >
                <div>
                  <Link
                    href={`/${c.sailorHandle}`}
                    className={`text-sm font-bold ${INK} hover:text-[var(--sp-racing-orange)]`}
                  >
                    {c.sailorName}
                  </Link>
                  <p className={`text-[11px] ${MUTED}`}>
                    {relationLabel(c.relation)} · submitted{" "}
                    {c.createdAt ? new Date(c.createdAt).toLocaleDateString() : "—"}
                  </p>
                </div>
                <span className="text-[10px] font-black uppercase text-[var(--sp-racing-deep)] px-2 py-0.5 rounded-full border border-[var(--sp-racing-orange)]/30 bg-[var(--sp-racing-mist)]">
                  Pending
                </span>
              </li>
            ))}
          </ul>
        </section>
      )}

      {athletes.length === 0 ? (
        <div className={`${CARD} p-8 sm:p-12 text-center space-y-4`}>
          <Sailboat className={`h-10 w-10 ${MUTED} mx-auto`} />
          <h2 className={`text-lg font-bold ${INK}`}>No linked sailor profiles yet</h2>
          <p className={`text-sm ${BODY} max-w-md mx-auto leading-relaxed`}>
            Search for your child (or yourself), open their profile, and submit a claim as{" "}
            <strong className={INK}>Parent</strong> or{" "}
            <strong className={INK}>Sailor</strong>. Once verified, their dashboard will appear here.
          </p>
          <div className="flex flex-col sm:flex-row gap-2 justify-center pt-2">
            <Link href="/search" className="sp-btn-primary">
              Search sailors
            </Link>
            <Link href="/claim-profile" className={SECONDARY_BTN}>
              How claiming works
            </Link>
          </div>
        </div>
      ) : (
        <>
          {athletes.length > 1 && (
            <div
              className="flex items-center gap-2 overflow-x-auto pb-1 border-b border-[var(--sp-cool-veil)]"
              role="tablist"
              aria-label="Linked athletes"
            >
              <button
                type="button"
                role="tab"
                aria-selected={selectedAthleteId === "all"}
                data-testid="tab-all-summary"
                onClick={() => setSelectedAthleteId("all")}
                className={`flex items-center gap-2 px-4 py-2 rounded-full text-xs font-bold transition-colors whitespace-nowrap ${
                  selectedAthleteId === "all"
                    ? "bg-harbour text-sailcloth shadow-xs"
                    : `${NESTED} ${MUTED} hover:border-[var(--sp-harbour-teal)] hover:text-[var(--sp-harbour-shadow)]`
                }`}
              >
                <Users className="h-3.5 w-3.5" />
                All Athletes Summary ({athletes.length})
              </button>

              {athletes.map((a) => {
                const isSelected = selectedAthleteId === a.id;
                return (
                  <button
                    key={a.id}
                    type="button"
                    role="tab"
                    aria-selected={isSelected}
                    onClick={() => setSelectedAthleteId(a.id)}
                    className={`flex items-center gap-2 px-4 py-2 rounded-full text-xs font-bold transition-colors whitespace-nowrap ${
                      isSelected
                        ? "bg-harbour text-sailcloth shadow-xs"
                        : `${NESTED} ${MUTED} hover:border-[var(--sp-harbour-teal)] hover:text-[var(--sp-harbour-shadow)]`
                    }`}
                  >
                    {a.avatarUrl ? (
                      // eslint-disable-next-line @next/next/no-img-element
                      <img
                        src={a.avatarUrl}
                        alt=""
                        className="h-4 w-4 rounded-full object-cover"
                      />
                    ) : (
                      <User className="h-3.5 w-3.5" />
                    )}
                    <span>{a.name}</span>
                    {a.standing?.fleet && (
                      <span
                        className={`text-[10px] px-1.5 py-0.5 rounded-full font-black border ${
                          isSelected
                            ? "border-sailcloth/30 bg-white/15 text-sailcloth"
                            : fleetPillClass(a.standing.fleet)
                        }`}
                      >
                        {a.standing.fleet} #{a.standing.overallRank}
                      </span>
                    )}
                    {(a.equipmentAlertCount ?? 0) > 0 && (
                      <span className="h-2 w-2 rounded-full bg-rose-500" aria-label="Equipment alert" />
                    )}
                  </button>
                );
              })}
            </div>
          )}

          {selectedAthleteId === "all" && athletes.length > 1 && (
            <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
              {athletes.map((a) => (
                <article
                  key={a.id}
                  className={`${CARD} p-5 space-y-4 hover:border-[var(--sp-harbour-teal)] transition-colors`}
                >
                  <div className="flex items-start justify-between gap-3">
                    <div className="flex items-center gap-3 min-w-0">
                      {a.avatarUrl ? (
                        // eslint-disable-next-line @next/next/no-img-element
                        <img
                          src={a.avatarUrl}
                          alt=""
                          className="h-12 w-12 rounded-2xl object-cover border border-[var(--sp-cool-veil)] shrink-0"
                        />
                      ) : (
                        <span className="flex h-12 w-12 shrink-0 items-center justify-center rounded-2xl bg-[var(--sp-harbour-teal)] text-[var(--sp-sailcloth)] border border-[var(--sp-harbour-teal)]">
                          <User className="h-6 w-6" />
                        </span>
                      )}
                      <div className="min-w-0">
                        <div className="flex flex-wrap items-center gap-2">
                          <h3 className={`text-base font-black ${INK}`}>{a.name}</h3>
                          {a.ownerRelation && (
                            <span className="rounded-full border border-[var(--sp-harbour-teal)]/20 bg-[var(--sp-aqua-mist)] px-2 py-0.5 text-[10px] font-bold text-[var(--sp-harbour-teal)]">
                              {relationLabel(a.ownerRelation)}
                            </span>
                          )}
                        </div>
                        <p className={`text-xs ${MUTED} mt-0.5`}>
                          {[a.club, a.sailNumber, formatAgeCategory(a.dob)]
                            .filter(Boolean)
                            .join(" · ")}
                        </p>
                      </div>
                    </div>
                    <div className="flex items-center gap-1.5 shrink-0">
                      <Link
                        href={`/athlete?id=${a.id}`}
                        className={`${SECONDARY_BTN} px-2.5 py-1.5 text-[11px]`}
                      >
                        Athlete Hub ↗
                      </Link>
                      <button
                        type="button"
                        onClick={() => setSelectedAthleteId(a.id)}
                        className={`${PRIMARY_BTN} px-3 py-1.5 text-[11px]`}
                      >
                        Open Dashboard
                        <ChevronRight className="h-3 w-3" />
                      </button>
                    </div>
                  </div>

                  <div className="grid grid-cols-2 sm:grid-cols-3 gap-2.5">
                    <div className={`${NESTED} p-2.5`}>
                      <p className={`text-[10px] font-bold ${MUTED} uppercase`}>
                        Series Rank
                      </p>
                      <p className={`text-sm font-black ${INK} mt-0.5`}>
                        {a.standing ? (
                          <>
                            #{a.standing.overallRank}{" "}
                            <span className={`text-[11px] font-normal ${MUTED}`}>
                              ({a.standing.fleet})
                            </span>
                          </>
                        ) : (
                          <span className={`${MUTED} text-xs font-normal`}>—</span>
                        )}
                      </p>
                    </div>

                    <div className={`${NESTED} p-2.5`}>
                      <p className={`text-[10px] font-bold ${MUTED} uppercase`}>
                        Selection Trials
                      </p>
                      <p className={`text-sm font-black ${INK} mt-0.5`}>
                        {a.selectionTrials ? (
                          <>
                            #{a.selectionTrials.rank}{" "}
                            <span className="text-[11px] font-normal text-[var(--sp-harbour-teal)]">
                              ({a.selectionTrials.nettScore} pts)
                            </span>
                          </>
                        ) : (
                          <span className={`${MUTED} text-xs font-normal`}>N/A</span>
                        )}
                      </p>
                    </div>

                    <div className={`${NESTED} p-2.5 col-span-2 sm:col-span-1`}>
                      <p className={`text-[10px] font-bold ${MUTED} uppercase`}>
                        Locker Alerts
                      </p>
                      <p className="text-sm font-black mt-0.5">
                        {(a.equipmentAlertCount ?? 0) > 0 ? (
                          <span className="text-rose-700 font-bold">
                            {a.equipmentAlertCount} alert
                            {a.equipmentAlertCount === 1 ? "" : "s"}
                          </span>
                        ) : (
                          <span className="text-[var(--sp-harbour-teal)] font-semibold text-xs flex items-center gap-1">
                            <CheckCircle2 className="h-3 w-3" /> All good
                          </span>
                        )}
                      </p>
                    </div>
                  </div>

                  {a.coachFeedback && a.coachFeedback.length > 0 && (
                    <div className="rounded-xl border border-[var(--sp-harbour-teal)]/20 bg-[var(--sp-aqua-mist)]/60 p-2.5 text-xs flex items-start gap-2">
                      <Award className="h-4 w-4 text-[var(--sp-harbour-teal)] shrink-0 mt-0.5" />
                      <div className="min-w-0 flex-1">
                        <p className="font-bold text-[11px] text-[var(--sp-harbour-teal)] truncate">
                          Latest Coach Feedback: {a.coachFeedback[0].title}
                        </p>
                        <p className={`${BODY} text-[11px] line-clamp-1 mt-0.5`}>
                          {a.coachFeedback[0].detail}
                        </p>
                      </div>
                    </div>
                  )}
                </article>
              ))}
            </div>
          )}

          {activeAthlete && (
            <div className="space-y-6 sm:space-y-8">
              <section className={`${CARD} p-5 sm:p-7`}>
                <div className="flex flex-col sm:flex-row sm:items-center justify-between gap-4">
                  <div className="flex items-start gap-4">
                    {activeAthlete.avatarUrl ? (
                      // eslint-disable-next-line @next/next/no-img-element
                      <img
                        src={activeAthlete.avatarUrl}
                        alt=""
                        className="h-16 w-16 sm:h-20 sm:w-20 rounded-2xl object-cover border-2 border-[var(--sp-cool-veil)] shrink-0"
                      />
                    ) : (
                      <span className="flex h-16 w-16 sm:h-20 sm:w-20 shrink-0 items-center justify-center rounded-2xl bg-[var(--sp-harbour-teal)] text-[var(--sp-sailcloth)] border-2 border-[var(--sp-harbour-teal)]">
                        <User className="h-8 w-8" />
                      </span>
                    )}
                    <div className="min-w-0">
                      <div className="flex flex-wrap items-center gap-2">
                        <h2 className={`text-xl sm:text-2xl font-black ${INK} tracking-tight`}>
                          {activeAthlete.name}
                        </h2>
                        {activeAthlete.ownerRelation && (
                          <span className="rounded-full border border-[var(--sp-harbour-teal)]/20 bg-[var(--sp-aqua-mist)] px-2.5 py-0.5 text-[10px] font-black uppercase tracking-wider text-[var(--sp-harbour-teal)]">
                            {relationLabel(activeAthlete.ownerRelation)}
                          </span>
                        )}
                        {activeAthlete.nationalSquadStatus && (
                          <span className="rounded-full border border-[var(--sp-cool-veil)] bg-[var(--sp-sailcloth)] px-2.5 py-0.5 text-[10px] font-black uppercase tracking-wider text-[var(--sp-charcoal-slate)]">
                            {activeAthlete.nationalSquadStatus}
                          </span>
                        )}
                      </div>

                      <p className={`text-xs sm:text-sm ${MUTED} mt-1 flex flex-wrap items-center gap-x-2 gap-y-1`}>
                        <span className={`font-semibold ${INK}`}>{activeAthlete.club}</span>
                        {activeAthlete.school && (
                          <>
                            <span aria-hidden>·</span>
                            <span>{activeAthlete.school}</span>
                          </>
                        )}
                        {activeAthlete.dob && (
                          <>
                            <span aria-hidden>·</span>
                            <span className="font-mono text-xs">
                              {formatAgeCategory(activeAthlete.dob)}
                            </span>
                          </>
                        )}
                      </p>

                      <div className="flex flex-wrap items-center gap-2 mt-2.5">
                        <span className="rounded-full border border-[var(--sp-harbour-teal)]/20 bg-[var(--sp-aqua-mist)] px-2.5 py-1 text-xs font-mono font-bold text-[var(--sp-harbour-teal)] inline-flex items-center gap-1.5">
                          <Sailboat className="h-3.5 w-3.5" />
                          Opti {activeAthlete.sailNumber}
                        </span>

                        {activeAthlete.sailNumberIlca4 && (
                          <span className="rounded-full border border-[var(--sp-cool-veil)] bg-[var(--sp-sailcloth)] px-2.5 py-1 text-xs font-mono font-bold text-[var(--sp-harbour-shadow)] inline-flex items-center gap-1.5">
                            <Compass className="h-3.5 w-3.5 text-[var(--sp-harbour-teal)]" />
                            ILCA 4 {activeAthlete.sailNumberIlca4}
                          </span>
                        )}

                        {activeAthlete.standing?.fleet && (
                          <span
                            className={`rounded-full border px-2.5 py-1 text-xs font-black uppercase tracking-wider ${fleetPillClass(activeAthlete.standing.fleet)}`}
                          >
                            {activeAthlete.standing.fleet} Fleet
                          </span>
                        )}
                      </div>
                    </div>
                  </div>

                  <div className="flex flex-wrap sm:flex-col gap-2 shrink-0">
                    <Link
                      href={`/athlete?id=${activeAthlete.id}&tab=results&action=new`}
                      className={`${SECONDARY_BTN} border-orange-500/30 bg-orange-500/10 hover:bg-orange-500/20 text-orange-600 font-bold`}
                    >
                      <Trophy className="h-3.5 w-3.5 text-orange-500" />
                      Log Score & Evidence ↗
                    </Link>
                    <Link href={`/${activeAthlete.handle}`} className={PRIMARY_BTN}>
                      Public Profile
                      <ExternalLink className="h-3.5 w-3.5" />
                    </Link>
                    {activeAthlete.standing?.fleet === "Gold" && (
                      <Link href="/sg/optimist/gold" className={SECONDARY_BTN}>
                        <Trophy className="h-3.5 w-3.5 text-[var(--sp-racing-orange)]" />
                        Gold Leaderboard
                      </Link>
                    )}
                    {activeAthlete.standing?.fleet === "Silver" && (
                      <Link href="/sg/optimist/silver" className={SECONDARY_BTN}>
                        <Trophy className="h-3.5 w-3.5 text-[var(--sp-harbour-teal)]" />
                        Silver Leaderboard
                      </Link>
                    )}
                  </div>
                </div>
              </section>

              <div className="grid grid-cols-1 lg:grid-cols-3 gap-6">
                <div className="lg:col-span-2 space-y-6">
                  <section className={`${CARD} p-5 sm:p-6`}>
                    <div className="grid grid-cols-1 md:grid-cols-3 gap-6 divide-y md:divide-y-0 md:divide-x divide-[var(--sp-cool-veil)]">
                      <div className="space-y-3 md:pr-4 flex flex-col justify-between">
                        <div className="space-y-2.5">
                          <div className="flex items-center justify-between gap-2">
                            <span className={`${SECTION_KICKER} flex items-center gap-1.5`}>
                              <Trophy className="h-3.5 w-3.5" />
                              Selection Trial
                            </span>
                            <Link href="/sg/optimist/selection" className={LINK_TEAL}>
                              Board →
                            </Link>
                          </div>

                          {(() => {
                            const isGoldFleet =
                              activeAthlete.standing?.fleet === "Gold" ||
                              activeAthlete.currentFleet === "Gold" ||
                              activeAthlete.currentFleet === "Series";
                            const trials = activeAthlete.selectionTrials;
                            const tookPart = Boolean(
                              isGoldFleet && trials && (trials.eventsSailed > 0 || trials.rank > 0)
                            );

                            if (!tookPart) {
                              return (
                                <div className="space-y-1.5 pt-1">
                                  <span className={`inline-flex items-center px-2.5 py-1 rounded-full text-xs font-semibold ${NESTED} ${MUTED}`}>
                                    Not Applicable
                                  </span>
                                  <p className={`text-[11px] ${MUTED} leading-snug`}>
                                    Only for Gold fleet sailors who took part in selection trial.
                                  </p>
                                </div>
                              );
                            }

                            const isSelected = Boolean(
                              trials?.isQualifiedAsian || trials?.isQualifiedPerth
                            );

                            if (isSelected) {
                              const squadDetails =
                                trials?.isQualifiedAsian && trials?.isQualifiedPerth
                                  ? "Asian Games & Perth Camp"
                                  : trials?.isQualifiedAsian
                                  ? `Asian Games Squad (Rank #${trials.asianTeamRank})`
                                  : "Selected for Perth Camp";

                              return (
                                <div className="space-y-2 pt-1">
                                  <div>
                                    <span className="inline-flex items-center gap-1.5 px-3 py-1 rounded-full text-xs font-black bg-[var(--sp-aqua-mist)] border border-[var(--sp-harbour-teal)]/30 text-[var(--sp-harbour-teal)]">
                                      <CheckCircle2 className="h-3.5 w-3.5" />
                                      Selected
                                    </span>
                                  </div>
                                  <p className={`text-xs font-bold ${INK} leading-tight`}>
                                    {squadDetails}
                                  </p>
                                  <p className={`text-[11px] ${MUTED} font-mono`}>
                                    Trials Rank #{trials?.rank} · {trials?.nettScore} pts ({trials?.eventsSailed}/2 events)
                                  </p>
                                </div>
                              );
                            }

                            return (
                              <div className="space-y-2 pt-1">
                                <div>
                                  <span className={`inline-flex items-center gap-1.5 px-3 py-1 rounded-full text-xs font-bold ${NESTED} ${BODY}`}>
                                    Not Selected
                                  </span>
                                </div>
                                <p className={`text-xs ${BODY}`}>
                                  Trials Rank #{trials?.rank} ({trials?.eventsSailed}/2 events)
                                </p>
                                {trials?.gapToCutoff != null && (
                                  <p className={`text-[11px] ${MUTED} font-mono`}>
                                    {trials.gapToCutoff > 0 ? `+${trials.gapToCutoff.toFixed(1)}` : trials.gapToCutoff.toFixed(1)} pts to cutoff
                                  </p>
                                )}
                              </div>
                            );
                          })()}
                        </div>

                        <div className="pt-2">
                          <Link
                            href="/sg/optimist/selection"
                            className="text-xs font-bold text-[var(--sp-harbour-teal)] hover:underline inline-flex items-center gap-1"
                          >
                            View Trials Board →
                          </Link>
                        </div>
                      </div>

                      <div className="space-y-3 pt-4 md:pt-0 md:px-4 flex flex-col justify-between">
                        <div className="space-y-2.5">
                          <div className="flex items-center justify-between gap-2">
                            <span className="text-[10px] font-bold uppercase tracking-[0.16em] text-[var(--sp-harbour-teal)] flex items-center gap-1.5">
                              <Award className="h-3.5 w-3.5" />
                              National Ranking
                            </span>
                            <Link
                              href={
                                activeAthlete.standing?.fleet === "Gold"
                                  ? "/sg/optimist/gold"
                                  : "/sg/optimist/silver"
                              }
                              className={LINK_TEAL}
                            >
                              Board →
                            </Link>
                          </div>

                          {activeAthlete.standing ? (
                            <div className="space-y-1 pt-1">
                              <div className="flex items-baseline gap-2">
                                <span className={`text-3xl font-black ${INK} tabular-nums`}>
                                  #{activeAthlete.standing.overallRank}
                                </span>
                                <span className={`text-xs font-semibold ${BODY}`}>
                                  in {activeAthlete.standing.fleet} Fleet
                                </span>
                              </div>
                              <p className={`text-[11px] ${MUTED}`}>
                                {activeAthlete.standing.fleetSize} sailors · {activeAthlete.standing.periodLabel}
                              </p>
                              <p className={`text-[11px] ${MUTED}`}>
                                Best 3 of 5:{" "}
                                <span className={`font-bold ${INK}`}>
                                  {activeAthlete.standing.best3of5} pts
                                </span>
                              </p>
                            </div>
                          ) : (
                            <div className="pt-1">
                              <span className={`text-xs ${MUTED}`}>
                                No series ranking recorded for current half.
                              </span>
                            </div>
                          )}
                        </div>

                        <div className="pt-2">
                          <Link
                            href={
                              activeAthlete.standing?.fleet === "Gold"
                                ? "/sg/optimist/gold"
                                : "/sg/optimist/silver"
                            }
                            className="text-xs font-bold text-[var(--sp-harbour-teal)] hover:underline inline-flex items-center gap-1"
                          >
                            Explore Fleet Board →
                          </Link>
                        </div>
                      </div>

                      <div className="space-y-3 pt-4 md:pt-0 md:pl-4 flex flex-col justify-between">
                        <div className="space-y-2.5">
                          <div className="flex items-center justify-between gap-2">
                            <span className="text-[10px] font-bold uppercase tracking-[0.16em] text-[var(--sp-harbour-teal)] flex items-center gap-1.5">
                              <Sailboat className="h-3.5 w-3.5" />
                              Recent Results
                            </span>
                            <Link href={`/${activeAthlete.handle}`} className={LINK_TEAL}>
                              All →
                            </Link>
                          </div>

                          {activeAthlete.recentResults && activeAthlete.recentResults.length > 0 ? (
                            <div className="space-y-1.5 pt-1">
                              {activeAthlete.recentResults.slice(0, 3).map((r, i) => (
                                <div
                                  key={i}
                                  className={`flex items-center justify-between gap-2 p-2 ${NESTED} text-xs`}
                                >
                                  <div className="min-w-0 flex-1">
                                    <p className={`font-bold ${INK} truncate text-xs`}>
                                      {r.regattaName}
                                    </p>
                                    <p className={`text-[10px] ${MUTED} font-mono`}>
                                      {r.regattaDate}
                                    </p>
                                  </div>
                                  <span className="text-xs font-black text-[var(--sp-racing-orange)] tabular-nums px-2 py-0.5 rounded-md bg-[var(--sp-racing-mist)]/50 border border-[var(--sp-racing-orange)]/20 shrink-0">
                                    #{r.rank}
                                  </span>
                                </div>
                              ))}
                            </div>
                          ) : (
                            <div className="pt-1">
                              <span className={`text-xs ${MUTED}`}>
                                No recent regatta finishes logged.
                              </span>
                            </div>
                          )}
                        </div>

                        <div className="pt-2">
                          <Link
                            href={`/${activeAthlete.handle}`}
                            className="text-xs font-bold text-[var(--sp-harbour-teal)] hover:underline inline-flex items-center gap-1"
                          >
                            View Full Profile →
                          </Link>
                        </div>
                      </div>
                    </div>
                  </section>

                  <section className={`${CARD} p-5 sm:p-6 space-y-4`}>
                    <div className="flex items-start justify-between gap-3 flex-wrap">
                      <div>
                        <p className={SECTION_KICKER}>Boat locker</p>
                        <h3 className={`${SECTION_TITLE} flex items-center gap-2`}>
                          <Sailboat className="h-4 w-4 text-[var(--sp-harbour-teal)]" />
                          Boat Locker & Equipment
                        </h3>
                        <p className={`text-xs ${MUTED} mt-0.5`}>
                          Track hull condition, sails, spars, measurement certificates, and race-day gear.
                        </p>
                      </div>
                      <div className="flex items-center gap-2">
                        <button
                          type="button"
                          onClick={() => setShowAddGearModal(true)}
                          className={PRIMARY_BTN}
                        >
                          <Plus className="h-3.5 w-3.5" />
                          Add Equipment
                        </button>
                        <Link
                          href={`/${activeAthlete.handle}#profile-equipment`}
                          className={`${SECONDARY_BTN} px-2.5 py-1.5 text-[11px]`}
                        >
                          Full Profile →
                        </Link>
                      </div>
                    </div>

                    {(activeAthlete.equipmentAlertCount ?? 0) > 0 && (
                      <div className="rounded-xl border border-rose-200 bg-rose-50 p-3.5 space-y-2">
                        <p className="text-xs font-bold text-rose-800 flex items-center gap-1.5">
                          <AlertTriangle className="h-4 w-4 text-rose-600 shrink-0" />
                          {activeAthlete.equipmentAlertCount} Equipment Alert
                          {activeAthlete.equipmentAlertCount === 1 ? "" : "s"} Require Action
                        </p>
                        <div className="space-y-1 pl-5">
                          {(activeAthlete.equipmentAlerts || []).map((al, idx) => (
                            <p key={idx} className="text-xs text-rose-800">
                              <span className="font-bold">{al.label}:</span> {al.reason}
                            </p>
                          ))}
                        </div>
                      </div>
                    )}

                    {activeAthlete.primaryGear && activeAthlete.primaryGear.length > 0 ? (
                      <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-2.5">
                        {activeAthlete.primaryGear.map((g) => (
                          <div
                            key={g.id}
                            className={`${NESTED} p-3 flex flex-col justify-between gap-2.5 hover:border-[var(--sp-harbour-teal)] transition group`}
                          >
                            <div className="flex items-start justify-between gap-1.5">
                              <div className="min-w-0 flex-1">
                                <div className="flex items-center gap-1.5">
                                  <span className={`text-[10px] font-black uppercase tracking-wider ${MUTED}`}>
                                    {g.category}
                                  </span>
                                  {g.isPrimary && (
                                    <span className="text-[9px] font-bold text-[var(--sp-racing-orange)] bg-[var(--sp-racing-mist)]/50 border border-[var(--sp-racing-orange)]/25 px-1.5 py-0.5 rounded-full">
                                      Primary
                                    </span>
                                  )}
                                </div>
                                <p className={`text-xs font-bold ${INK} mt-0.5 truncate`}>
                                  {g.label || [g.brand, g.model].filter(Boolean).join(" ") || "Equipment Item"}
                                </p>
                              </div>
                              <div className="flex items-center gap-1 shrink-0">
                                <button
                                  type="button"
                                  title={g.isPrimary ? "Primary race gear (click to unset)" : "Make primary race gear"}
                                  onClick={() => void handleToggleGearPrimary(activeAthlete.id, g.id, g.isPrimary)}
                                  className={`p-1 rounded-lg hover:bg-[var(--sp-warm-white)] transition ${
                                    g.isPrimary ? "text-[var(--sp-racing-orange)]" : `${MUTED} hover:text-[var(--sp-racing-orange)]`
                                  }`}
                                >
                                  <Star className={`h-3.5 w-3.5 ${g.isPrimary ? "fill-[var(--sp-racing-orange)]" : ""}`} />
                                </button>
                                <button
                                  type="button"
                                  title="Remove gear from locker"
                                  onClick={() => void handleDeleteGear(activeAthlete.id, g.id)}
                                  className={`p-1 rounded-lg ${MUTED} hover:text-rose-600 hover:bg-rose-50 transition`}
                                >
                                  <Trash2 className="h-3.5 w-3.5" />
                                </button>
                              </div>
                            </div>

                            <div className="flex items-center justify-between pt-1.5 border-t border-[var(--sp-cool-veil)]">
                              {(() => {
                                const simplified = toSimplifiedCondition(g.condition);
                                return (
                                  <button
                                    type="button"
                                    onClick={() => void handleToggleGearCondition(activeAthlete.id, g.id, g.condition)}
                                    title="Click to toggle condition (Race Ready / Practice Only / Needs Repair)"
                                    className={`text-[10px] font-bold capitalize px-2 py-0.5 rounded-full border transition flex items-center gap-1 touch-manipulation ${
                                      simplified === "race_ready"
                                        ? "bg-[var(--sp-aqua-mist)] border-[var(--sp-harbour-teal)]/30 text-[var(--sp-harbour-teal)]"
                                        : simplified === "practice_only"
                                        ? "bg-[var(--sp-racing-mist)]/50 border-[var(--sp-racing-orange)]/30 text-[var(--sp-racing-deep)]"
                                        : "bg-rose-50 border-rose-200 text-rose-700"
                                    }`}
                                  >
                                    <span className="h-1.5 w-1.5 rounded-full bg-current opacity-80" />
                                    {simplified === "race_ready"
                                      ? "Race Ready"
                                      : simplified === "practice_only"
                                      ? "Practice Only"
                                      : "Needs Repair"}
                                  </button>
                                );
                              })()}
                              <span className={`text-[10px] ${MUTED} font-medium`}>
                                Tap to toggle
                              </span>
                            </div>
                          </div>
                        ))}
                      </div>
                    ) : (
                      <div className="rounded-xl border border-dashed border-[var(--sp-cool-veil)] bg-[var(--sp-sailcloth)] p-6 text-center space-y-3">
                        <div className="mx-auto flex h-10 w-10 items-center justify-center rounded-xl bg-[var(--sp-racing-mist)]/50 border border-[var(--sp-racing-orange)]/20">
                          <Sailboat className="h-5 w-5 text-[var(--sp-racing-orange)]" />
                        </div>
                        <div className="space-y-1">
                          <p className={`text-xs font-bold ${INK}`}>No equipment registered yet</p>
                          <p className={`text-[11px] ${MUTED} max-w-sm mx-auto`}>
                            Add your sailor&apos;s hull, spars, sails, and foils to track safety checks, condition, and race-day readiness.
                          </p>
                        </div>
                        <div className="flex flex-wrap justify-center gap-2 pt-1">
                          <button
                            type="button"
                            onClick={() => setShowAddGearModal(true)}
                            className={PRIMARY_BTN}
                          >
                            <Plus className="h-3.5 w-3.5" />
                            Add Equipment
                          </button>
                          <button
                            type="button"
                            onClick={() => void handleAddGearPreset(activeAthlete.id, YOUTH_EQUIPMENT_PRESETS[0])}
                            className={SECONDARY_BTN}
                          >
                            + Optimax Rig Set
                          </button>
                          <button
                            type="button"
                            onClick={() => void handleAddGearPreset(activeAthlete.id, YOUTH_EQUIPMENT_PRESETS[6])}
                            className={SECONDARY_BTN}
                          >
                            + OneSails Racing Sail
                          </button>
                        </div>
                      </div>
                    )}
                  </section>

                  {showAddGearModal && (
                    <div
                      className="fixed inset-0 z-50 flex items-start justify-center overflow-y-auto bg-black/60 backdrop-blur-xs p-4 sm:pt-20"
                      role="dialog"
                      aria-modal="true"
                      aria-labelledby="add-gear-title"
                      onMouseDown={(event) => {
                        if (event.target === event.currentTarget) setShowAddGearModal(false);
                      }}
                    >
                      <div className="w-full max-w-lg rounded-2xl border border-[var(--sp-cool-veil)] bg-[var(--sp-warm-white)] p-5 sm:p-6 space-y-4 shadow-2xl relative my-8">
                        <div className="flex items-center justify-between pb-2 border-b border-[var(--sp-cool-veil)]">
                          <div>
                            <h3 id="add-gear-title" className={`text-sm font-bold ${INK} flex items-center gap-1.5`}>
                              <Plus className="h-4 w-4 text-[var(--sp-racing-orange)]" />
                              Add Equipment to Locker
                            </h3>
                            <p className={`text-xs ${MUTED}`}>
                              For {activeAthlete.name} ({activeAthlete.currentFleet || "Optimist"} Fleet)
                            </p>
                          </div>
                          <button
                            type="button"
                            onClick={() => setShowAddGearModal(false)}
                            aria-label="Close add equipment"
                            className={`rounded-lg p-1.5 ${MUTED} hover:text-[var(--sp-harbour-shadow)] hover:bg-[var(--sp-sailcloth)] transition`}
                          >
                            <X className="h-4 w-4" />
                          </button>
                        </div>

                        <div className={`flex rounded-xl ${NESTED} p-1`}>
                          <button
                            type="button"
                            onClick={() => setAddGearTab("presets")}
                            className={`flex-1 py-1.5 text-xs font-bold rounded-lg transition ${
                              addGearTab === "presets"
                                ? "bg-racing-orange text-sailcloth shadow-xs"
                                : `${MUTED} hover:text-[var(--sp-harbour-shadow)]`
                            }`}
                          >
                            1-Click Popular Presets
                          </button>
                          <button
                            type="button"
                            onClick={() => setAddGearTab("custom")}
                            className={`flex-1 py-1.5 text-xs font-bold rounded-lg transition ${
                              addGearTab === "custom"
                                ? "bg-racing-orange text-sailcloth shadow-xs"
                                : `${MUTED} hover:text-[var(--sp-harbour-shadow)]`
                            }`}
                          >
                            Custom Gear
                          </button>
                        </div>

                        {addGearTab === "presets" ? (
                          <div className="space-y-2 max-h-80 overflow-y-auto pr-1">
                            <p className={`text-[11px] ${MUTED}`}>
                              Select standard youth equipment packages to add immediately:
                            </p>
                            <div className="grid grid-cols-1 gap-2">
                              {YOUTH_EQUIPMENT_PRESETS.map((preset) => (
                                <div
                                  key={preset.id}
                                  className={`${NESTED} p-3 flex items-center justify-between gap-3 hover:border-[var(--sp-racing-orange)]/40 transition`}
                                >
                                  <div className="min-w-0 flex-1">
                                    <div className="flex items-center gap-2">
                                      <span className={`text-xs font-bold ${INK}`}>
                                        {preset.name}
                                      </span>
                                      <span className={`text-[9px] font-bold uppercase tracking-wider px-1.5 py-0.5 rounded-full bg-[var(--sp-warm-white)] border border-[var(--sp-cool-veil)] ${MUTED}`}>
                                        {preset.category}
                                      </span>
                                    </div>
                                    <p className={`text-[11px] ${MUTED} mt-0.5 leading-snug`}>
                                      {preset.subtitle}
                                    </p>
                                  </div>
                                  <button
                                    type="button"
                                    disabled={addGearBusy}
                                    onClick={() => void handleAddGearPreset(activeAthlete.id, preset)}
                                    className="shrink-0 sp-btn-primary px-3 py-1.5 disabled:opacity-50"
                                  >
                                    {addGearBusy ? "Adding…" : "+ Add"}
                                  </button>
                                </div>
                              ))}
                            </div>
                          </div>
                        ) : (
                          <div className="space-y-3">
                            <div>
                              <label className={`text-[11px] font-bold ${BODY} block mb-1`}>
                                Equipment Category
                              </label>
                              <select
                                value={customGearCategory}
                                onChange={(e) => {
                                  const cat = e.target.value as EquipmentCategory;
                                  setCustomGearCategory(cat);
                                  const presets = brandsForCategory(cat);
                                  setCustomGearBrand(presets[0] || "");
                                }}
                                className="sp-select w-full text-xs"
                              >
                                {(
                                  [
                                    "hull",
                                    "sail",
                                    "mast",
                                    "boom",
                                    "sprit",
                                    "daggerboard",
                                    "rudder",
                                    "other",
                                  ] as EquipmentCategory[]
                                ).map((cat) => (
                                  <option key={cat} value={cat}>
                                    {categoryLabel(cat)}
                                  </option>
                                ))}
                              </select>
                            </div>

                            <div className="grid grid-cols-2 gap-2">
                              <div>
                                <label className={`text-[11px] font-bold ${BODY} block mb-1`}>
                                  Brand / Maker
                                </label>
                                <input
                                  value={customGearBrand}
                                  onChange={(e) => setCustomGearBrand(e.target.value)}
                                  placeholder="e.g. Winner, OneSails, Optimax"
                                  className="sp-input w-full text-xs"
                                />
                              </div>
                              <div>
                                <label className={`text-[11px] font-bold ${BODY} block mb-1`}>
                                  Model / Cut
                                </label>
                                <input
                                  value={customGearModel}
                                  onChange={(e) => setCustomGearModel(e.target.value)}
                                  placeholder="e.g. CD Cut, Mk3 Flex"
                                  className="sp-input w-full text-xs"
                                />
                              </div>
                            </div>

                            <div>
                              <label className={`text-[11px] font-bold ${BODY} block mb-1`}>
                                Sail # / Serial / Identifier
                              </label>
                              <input
                                value={customGearLabel}
                                onChange={(e) => setCustomGearLabel(e.target.value)}
                                placeholder="e.g. SIN 4639 or Hull #184491"
                                className="sp-input w-full text-xs"
                              />
                            </div>

                            <div>
                              <label className={`text-[11px] font-bold ${BODY} block mb-1.5`}>
                                Condition
                              </label>
                              <div className="grid grid-cols-3 gap-1.5">
                                {(["race_ready", "practice_only", "needs_attention"] as SimplifiedCondition[]).map(
                                  (key) => {
                                    const meta = SIMPLIFIED_CONDITION_META[key];
                                    const active = customGearCondition === key;
                                    const lightActive =
                                      key === "race_ready"
                                        ? "bg-[var(--sp-aqua-mist)] border-[var(--sp-harbour-teal)]/40 text-[var(--sp-harbour-teal)]"
                                        : key === "practice_only"
                                        ? "bg-[var(--sp-racing-mist)]/50 border-[var(--sp-racing-orange)]/40 text-[var(--sp-racing-deep)]"
                                        : "bg-rose-50 border-rose-200 text-rose-700";
                                    return (
                                      <button
                                        key={key}
                                        type="button"
                                        onClick={() => setCustomGearCondition(key)}
                                        className={`rounded-xl px-2 py-2 text-center border transition flex flex-col items-center gap-1 ${
                                          active
                                            ? lightActive
                                            : `${NESTED} ${MUTED} hover:border-[var(--sp-harbour-teal)]`
                                        }`}
                                      >
                                        <span className={`h-2 w-2 rounded-full ${
                                          key === "race_ready"
                                            ? "bg-[var(--sp-harbour-teal)]"
                                            : key === "practice_only"
                                            ? "bg-[var(--sp-racing-orange)]"
                                            : "bg-rose-600"
                                        }`} />
                                        <span className="text-[10px] font-bold leading-tight">
                                          {meta.shortLabel}
                                        </span>
                                      </button>
                                    );
                                  }
                                )}
                              </div>
                            </div>

                            <label className={`flex items-center gap-2.5 text-xs ${BODY} ${NESTED} px-3 py-2 cursor-pointer`}>
                              <input
                                type="checkbox"
                                checked={customGearPrimary}
                                onChange={(e) => setCustomGearPrimary(e.target.checked)}
                                className="rounded border-[var(--sp-cool-veil)] accent-[var(--sp-racing-orange)]"
                              />
                              <span className={`font-semibold ${INK}`}>Set as Primary Race-Day Gear</span>
                            </label>

                            <button
                              type="button"
                              disabled={addGearBusy}
                              onClick={() => void handleCreateCustomGear(activeAthlete.id)}
                              className="w-full sp-btn-primary py-2.5 disabled:opacity-50"
                            >
                              {addGearBusy ? "Saving…" : "Save to Equipment Locker"}
                            </button>
                          </div>
                        )}
                      </div>
                    </div>
                  )}

                  <section className={`${CARD} p-5 sm:p-6 space-y-4`}>
                    <div className="flex items-start justify-between gap-3">
                      <div>
                        <p className="text-[10px] font-bold uppercase tracking-[0.16em] text-[var(--sp-harbour-teal)]">Coach feed</p>
                        <h3 className={`${SECTION_TITLE} flex items-center gap-2`}>
                          <Award className="h-4 w-4 text-[var(--sp-harbour-teal)]" />
                          Coach Observations & Development Records
                        </h3>
                        <p className={`text-xs ${MUTED} mt-0.5`}>
                          Technical debriefs, starts, tactics, and boat speed observations logged by accredited coaches.
                        </p>
                      </div>
                      <span className={`text-[10px] font-bold ${MUTED} uppercase tracking-wider`}>
                        Read-Only Feed
                      </span>
                    </div>

                    {activeAthlete.coachFeedback && activeAthlete.coachFeedback.length > 0 ? (
                      <div className="space-y-3">
                        {activeAthlete.coachFeedback.map((cf) => (
                          <div
                            key={cf.id}
                            className={`${NESTED} p-3.5 space-y-1.5`}
                          >
                            <div className="flex flex-wrap items-center justify-between gap-2">
                              <div className="flex items-center gap-2">
                                <span className={`text-xs font-bold ${INK}`}>
                                  {cf.title}
                                </span>
                                {cf.category && (
                                  <span className="rounded-full border border-[var(--sp-harbour-teal)]/20 bg-[var(--sp-aqua-mist)] px-2 py-0.5 text-[10px] font-bold text-[var(--sp-harbour-teal)] capitalize">
                                    {cf.category}
                                  </span>
                                )}
                              </div>
                              <span className={`text-[10px] ${MUTED} font-mono`}>
                                {cf.recordDate}
                              </span>
                            </div>
                            {cf.detail && (
                              <p className={`text-xs ${BODY} leading-relaxed`}>
                                {cf.detail}
                              </p>
                            )}
                          </div>
                        ))}
                      </div>
                    ) : (
                      <div className={`rounded-xl border border-dashed border-[var(--sp-cool-veil)] bg-[var(--sp-sailcloth)] p-4 text-center text-xs ${MUTED}`}>
                        No coach observations logged yet for this period. Entries recorded by your child&apos;s coaches will automatically show here.
                      </div>
                    )}
                  </section>
                </div>

                <div className="space-y-6">
                  <section className={`${CARD} p-5 space-y-4`}>
                    <div className="flex items-start justify-between gap-2">
                      <div>
                        <p className={SECTION_KICKER}>Race day</p>
                        <h3 className={`${SECTION_TITLE} flex items-center gap-2`}>
                          <Calendar className="h-4 w-4 text-[var(--sp-harbour-teal)]" />
                          Regatta Prep & Checklist
                        </h3>
                        <p className={`text-[11px] ${MUTED} mt-0.5`}>
                          Upcoming calendar & race-day verification items.
                        </p>
                      </div>
                      <button
                        type="button"
                        onClick={() => resetChecklist(activeAthlete.id)}
                        className={`text-[11px] font-semibold ${MUTED} hover:text-[var(--sp-harbour-shadow)] inline-flex items-center gap-1 p-1`}
                        title="Reset checklist"
                      >
                        <RotateCcw className="h-3 w-3" />
                        Reset
                      </button>
                    </div>

                    {upcomingRegattas.length > 0 ? (
                      <div className="space-y-2">
                        <div className="flex items-center justify-between">
                          <p className={`text-[10px] font-black uppercase tracking-wider ${MUTED}`}>
                            Upcoming Regattas
                          </p>
                          <Link href="/calendar" className={LINK_TEAL}>
                            Full Calendar →
                          </Link>
                        </div>
                        <div className="space-y-1.5">
                          {upcomingRegattas.slice(0, 3).map((reg) => (
                            <div
                              key={reg.id}
                              className={`${NESTED} p-2.5 text-xs flex justify-between items-center gap-2`}
                            >
                              <div className="min-w-0 flex-1">
                                <p className={`font-bold ${INK} truncate`}>{reg.name}</p>
                                <p className={`text-[10px] ${MUTED} font-mono mt-0.5`}>
                                  {reg.date}{" "}
                                  {reg.boatClass ? `· ${reg.boatClass}` : ""}
                                </p>
                              </div>
                              <Link
                                href="/calendar"
                                className="text-[11px] font-bold text-[var(--sp-racing-orange)] hover:underline shrink-0"
                              >
                                Details
                              </Link>
                            </div>
                          ))}
                        </div>
                      </div>
                    ) : (
                      <div className={`rounded-xl border border-dashed border-[var(--sp-cool-veil)] bg-[var(--sp-sailcloth)] p-3 text-xs ${MUTED} text-center`}>
                        No upcoming regattas scheduled.{" "}
                        <Link href="/calendar" className="text-[var(--sp-racing-orange)] font-bold hover:underline">
                          View full calendar
                        </Link>
                      </div>
                    )}

                    <div className="space-y-2.5 pt-2 border-t border-[var(--sp-cool-veil)]">
                      <div className="flex items-center justify-between">
                        <p className={`text-[10px] font-black uppercase tracking-wider ${MUTED}`}>
                          Race Day Morning Checklist
                        </p>
                        {(() => {
                          const athleteCustom = customChecklistItems[activeAthlete.id] || [];
                          const allItems = [...DEFAULT_RACE_CHECKLIST_ITEMS, ...athleteCustom];
                          const state = checklistState[activeAthlete.id] || {};
                          const doneCount = allItems.filter((item) => state[item.id]).length;
                          return (
                            <span className="text-[11px] font-bold text-[var(--sp-harbour-teal)]">
                              {doneCount}/{allItems.length} ready
                            </span>
                          );
                        })()}
                      </div>

                      <div className="space-y-1.5">
                        {[
                          ...DEFAULT_RACE_CHECKLIST_ITEMS.map((item) => ({ ...item, isCustom: false })),
                          ...(customChecklistItems[activeAthlete.id] || []).map((item) => ({ ...item, isCustom: true })),
                        ].map((item) => {
                          const isDone = Boolean(checklistState[activeAthlete.id]?.[item.id]);
                          return (
                            <div
                              key={item.id}
                              className={`group w-full rounded-xl p-2.5 text-xs flex items-center justify-between gap-2.5 transition-colors ${
                                isDone
                                  ? "bg-[var(--sp-aqua-mist)]/70 border border-[var(--sp-harbour-teal)]/25 text-[var(--sp-harbour-shadow)]"
                                  : `${NESTED} ${BODY} hover:border-[var(--sp-harbour-teal)]`
                              }`}
                            >
                              <button
                                type="button"
                                onClick={() => toggleChecklistItem(activeAthlete.id, item.id)}
                                className="flex items-start gap-2.5 flex-1 text-left min-w-0"
                              >
                                {isDone ? (
                                  <CheckSquare className="h-4 w-4 text-[var(--sp-harbour-teal)] shrink-0 mt-0.5" />
                                ) : (
                                  <Square className={`h-4 w-4 ${MUTED} shrink-0 mt-0.5`} />
                                )}
                                <span className={isDone ? "line-through opacity-75" : "font-normal"}>
                                  {item.label}
                                </span>
                              </button>
                              {item.isCustom && (
                                <button
                                  type="button"
                                  onClick={(e) => {
                                    e.stopPropagation();
                                    removeCustomChecklistItem(activeAthlete.id, item.id);
                                  }}
                                  className={`opacity-60 group-hover:opacity-100 p-1 ${MUTED} hover:text-rose-600 transition-opacity shrink-0`}
                                  title="Remove item"
                                >
                                  <Trash2 className="h-3.5 w-3.5" />
                                </button>
                              )}
                            </div>
                          );
                        })}
                      </div>

                      <div className="flex items-center gap-2 pt-1">
                        <input
                          type="text"
                          value={newChecklistText}
                          onChange={(e) => setNewChecklistText(e.target.value)}
                          onKeyDown={(e) => {
                            if (e.key === "Enter") {
                              e.preventDefault();
                              addCustomChecklistItem(activeAthlete.id);
                            }
                          }}
                          placeholder="Add race prep item…"
                          className="sp-input flex-1 text-xs"
                        />
                        <button
                          type="button"
                          onClick={() => addCustomChecklistItem(activeAthlete.id)}
                          disabled={!newChecklistText.trim()}
                          className={`${PRIMARY_BTN} px-3 py-1.5 disabled:opacity-40 shrink-0`}
                        >
                          <Plus className="h-3.5 w-3.5" />
                          Add
                        </button>
                      </div>
                    </div>
                  </section>

                  <section className={`${CARD} p-5 space-y-4`}>
                    <div>
                      <p className="text-[10px] font-bold uppercase tracking-[0.16em] text-[var(--sp-harbour-teal)]">Private notes</p>
                      <h3 className={`${SECTION_TITLE} flex items-center gap-2`}>
                        <StickyNote className="h-4 w-4 text-[var(--sp-harbour-teal)]" />
                        Private Parent Journal
                      </h3>
                      <p className={`text-[11px] ${MUTED} mt-0.5 flex items-center gap-1`}>
                        <Lock className="h-3 w-3" />
                        100% private to your parent account.
                      </p>
                    </div>

                    <div className="space-y-2">
                      <div className="flex flex-wrap gap-1.5">
                        {NOTE_CATEGORIES.map((cat) => (
                          <button
                            key={cat}
                            type="button"
                            onClick={() => setSelectedCategory(cat)}
                            className={`px-2 py-0.5 rounded-full text-[10px] font-bold transition-colors border ${
                              selectedCategory === cat
                                ? "bg-[var(--sp-aqua-mist)] text-[var(--sp-harbour-teal)] border-[var(--sp-harbour-teal)]/30"
                                : `${NESTED} ${MUTED} hover:text-[var(--sp-harbour-shadow)] hover:border-[var(--sp-harbour-teal)]`
                            }`}
                          >
                            {cat}
                          </button>
                        ))}
                      </div>

                      <div className="flex gap-2">
                        <input
                          value={noteDraft[activeAthlete.id] || ""}
                          onChange={(e) =>
                            setNoteDraft((d) => ({
                              ...d,
                              [activeAthlete.id]: e.target.value,
                            }))
                          }
                          placeholder={`Add a private ${selectedCategory.toLowerCase()} note…`}
                          className="sp-input flex-1 min-w-0 text-xs"
                          onKeyDown={(e) => {
                            if (e.key === "Enter") void addNote(activeAthlete.id);
                          }}
                        />
                        <button
                          type="button"
                          disabled={
                            noteBusy === activeAthlete.id ||
                            !(noteDraft[activeAthlete.id] || "").trim()
                          }
                          onClick={() => void addNote(activeAthlete.id)}
                          className={`${PRIMARY_BTN} px-3 py-2 disabled:opacity-40 shrink-0`}
                        >
                          <Plus className="h-4 w-4" />
                          Save
                        </button>
                      </div>
                    </div>

                    {(activeAthlete.notes?.length ?? 0) === 0 ? (
                      <p className={`text-[11px] ${MUTED} text-center py-3`}>
                        No private notes yet. Log training thoughts, regatta debriefs, logistics, or equipment orders.
                      </p>
                    ) : (
                      <div className="space-y-2 max-h-72 overflow-y-auto pr-1">
                        {activeAthlete.notes!.map((n) => {
                          const parsed = parseNoteCategory(n.body);
                          return (
                            <div
                              key={n.id}
                              className={`${NESTED} p-2.5 flex items-start justify-between gap-2`}
                            >
                              <div className="min-w-0 flex-1 space-y-1">
                                <div className="flex items-center gap-2">
                                  {parsed.category && (
                                    <span className="rounded-full px-1.5 py-0.5 text-[9px] font-black uppercase tracking-wider bg-[var(--sp-aqua-mist)] text-[var(--sp-harbour-teal)] border border-[var(--sp-harbour-teal)]/25">
                                      {parsed.category}
                                    </span>
                                  )}
                                  <span className={`text-[10px] ${MUTED} font-mono`}>
                                    {n.createdAt ? n.createdAt.slice(0, 10) : ""}
                                  </span>
                                </div>
                                <p className={`text-xs ${BODY} leading-relaxed whitespace-pre-wrap`}>
                                  {parsed.text}
                                </p>
                              </div>
                              <button
                                type="button"
                                disabled={noteBusy === n.id}
                                onClick={() => void deleteNote(n.id)}
                                className={`${MUTED} hover:text-rose-600 p-1 shrink-0 transition-colors`}
                                aria-label="Delete note"
                              >
                                <Trash2 className="h-3.5 w-3.5" />
                              </button>
                            </div>
                          );
                        })}
                      </div>
                    )}
                  </section>
                </div>
              </div>
            </div>
          )}
        </>
      )}

      <p className={`text-center text-xs ${MUTED} pt-4`}>
        <Link href="/account" className={`${MUTED} hover:text-[var(--sp-harbour-teal)] transition-colors`}>
          Account Settings
        </Link>
        {" · "}
        <Link href="/search" className={`${MUTED} hover:text-[var(--sp-harbour-teal)] transition-colors`}>
          Find Sailors
        </Link>
        {" · "}
        <Link href="/support" className={`${MUTED} hover:text-[var(--sp-harbour-teal)] transition-colors`}>
          Support & Feedback
        </Link>
      </p>
    </div>
  );
}

