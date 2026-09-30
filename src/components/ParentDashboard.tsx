"use client";

import { useCallback, useEffect, useRef, useState } from "react";
import Link from "next/link";
import { useRouter } from "next/navigation";
import {
  Trophy,
  User,
  Search,
  Clock,
  Sailboat,
  CheckCircle2,
  ExternalLink,
  Award,
  Compass,
} from "lucide-react";
import {
  PrivateNotesPanel,
  PreRaceChecklist,
  EquipmentInPlacePanel,
  AthleteSelector,
} from "@/components/parent-dashboard";
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

type NoteCategory = "General" | "Training" | "Regatta Debrief" | "Logistics" | "Gear";

const CARD =
  "rounded-2xl border border-[var(--sp-cool-veil)] bg-[var(--sp-warm-white)] shadow-xs";
const NESTED =
  "rounded-xl border border-[var(--sp-cool-veil)] bg-[var(--sp-sailcloth)]";
const SECONDARY_BTN =
  "inline-flex items-center justify-center gap-1.5 rounded-full border border-[var(--sp-cool-veil)] bg-[var(--sp-warm-white)] px-4 py-2 text-xs font-bold text-[var(--sp-harbour-shadow)] hover:border-[var(--sp-harbour-teal)] transition-colors";
const PRIMARY_BTN = "sp-btn-primary";
const SECTION_KICKER =
  "text-[11px] font-bold uppercase tracking-[0.16em] text-[var(--sp-racing-orange)]";
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

    setAthletes((prev) =>
      prev.map((ath) => {
        if (ath.id !== athleteId) return ath;
        return {
          ...ath,
          primaryGear: (ath.primaryGear || []).map((g) =>
            g.id === gearId ? { ...g, condition: nextCondition } : g
          ),
        };
      })
    );

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
      // Revert only this gear item so other optimistic updates are preserved
      setAthletes((prev) =>
        prev.map((ath) => {
          if (ath.id !== athleteId) return ath;
          return {
            ...ath,
            primaryGear: (ath.primaryGear || []).map((g) =>
              g.id === gearId ? { ...g, condition: currentCondition } : g
            ),
          };
        })
      );
      toast.error("Failed to update equipment condition.");
    }
  };

  const handleToggleGearPrimary = async (
    athleteId: string,
    gearId: string,
    currentPrimary: boolean
  ) => {
    const nextPrimary = !currentPrimary;

    setAthletes((prev) =>
      prev.map((ath) => {
        if (ath.id !== athleteId) return ath;
        return {
          ...ath,
          primaryGear: (ath.primaryGear || []).map((g) =>
            g.id === gearId ? { ...g, isPrimary: nextPrimary } : g
          ),
        };
      })
    );

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
      // Revert only this gear item so other optimistic updates are preserved
      setAthletes((prev) =>
        prev.map((ath) => {
          if (ath.id !== athleteId) return ath;
          return {
            ...ath,
            primaryGear: (ath.primaryGear || []).map((g) =>
              g.id === gearId ? { ...g, isPrimary: currentPrimary } : g
            ),
          };
        })
      );
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

    // Capture the item (and its position) for a targeted rollback
    const sourceAthlete = athletes.find((a) => a.id === athleteId);
    const gearIndex =
      sourceAthlete?.primaryGear?.findIndex((g) => g.id === gearId) ?? -1;
    const removedGear =
      gearIndex >= 0 ? sourceAthlete!.primaryGear![gearIndex] : null;

    setAthletes((prev) =>
      prev.map((ath) => {
        if (ath.id !== athleteId) return ath;
        return {
          ...ath,
          primaryGear: (ath.primaryGear || []).filter((g) => g.id !== gearId),
        };
      })
    );

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
      // Re-insert the removed item at its original position, preserving
      // any other optimistic updates that landed in between
      if (removedGear) {
        setAthletes((prev) =>
          prev.map((ath) => {
            if (ath.id !== athleteId) return ath;
            const gear = [...(ath.primaryGear || [])];
            gear.splice(Math.min(gearIndex, gear.length), 0, removedGear);
            return { ...ath, primaryGear: gear };
          })
        );
      }
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
        <p className="text-sm font-bold text-[var(--sp-color-error)] rounded-xl border border-rose-200 bg-rose-50 px-4 py-3">
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
                  <p className={`text-[13px] ${MUTED}`}>
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
          <AthleteSelector
            athletes={athletes}
            selectedAthleteId={selectedAthleteId}
            onSelectAthlete={(id) => setSelectedAthleteId(id)}
          />

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
                          <span className="rounded-full border border-[var(--sp-harbour-teal)]/20 bg-[var(--sp-aqua-mist)] px-2.5 py-0.5 text-[11px] font-black uppercase tracking-wider text-[var(--sp-harbour-teal)]">
                            {relationLabel(activeAthlete.ownerRelation)}
                          </span>
                        )}
                        {activeAthlete.nationalSquadStatus && (
                          <span className="rounded-full border border-[var(--sp-cool-veil)] bg-[var(--sp-sailcloth)] px-2.5 py-0.5 text-[11px] font-black uppercase tracking-wider text-[var(--sp-charcoal-slate)]">
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
                      className={SECONDARY_BTN}
                    >
                      <Trophy className="h-3.5 w-3.5 text-[var(--sp-racing-orange)]" />
                      Log Score & Evidence ↗
                    </Link>
                    <Link href={`/${activeAthlete.handle}`} className={SECONDARY_BTN}>
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
                                  <p className={`text-[13px] ${MUTED} leading-snug`}>
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
                                  <p className={`text-[13px] ${MUTED} font-mono`}>
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
                                  <p className={`text-[13px] ${MUTED} font-mono`}>
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
                            <span className="text-[11px] font-bold uppercase tracking-[0.16em] text-[var(--sp-harbour-teal)] flex items-center gap-1.5">
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
                              <p className={`text-[13px] ${MUTED}`}>
                                {activeAthlete.standing.fleetSize} sailors · {activeAthlete.standing.periodLabel}
                              </p>
                              <p className={`text-[13px] ${MUTED}`}>
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
                            <span className="text-[11px] font-bold uppercase tracking-[0.16em] text-[var(--sp-harbour-teal)] flex items-center gap-1.5">
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
                                    <p className={`text-[13px] ${MUTED} font-mono`}>
                                      {r.regattaDate}
                                    </p>
                                  </div>
                                  <span className="text-xs font-black text-[var(--sp-racing-deep)] tabular-nums px-2 py-0.5 rounded-md bg-[var(--sp-racing-mist)]/50 border border-[var(--sp-racing-orange)]/20 shrink-0">
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

                  <EquipmentInPlacePanel
                    activeAthlete={activeAthlete}
                    showAddGearModal={showAddGearModal}
                    addGearTab={addGearTab}
                    addGearBusy={addGearBusy}
                    customGearCategory={customGearCategory}
                    customGearBrand={customGearBrand}
                    customGearModel={customGearModel}
                    customGearLabel={customGearLabel}
                    customGearCondition={customGearCondition}
                    customGearPrimary={customGearPrimary}
                    onOpenAddGear={() => setShowAddGearModal(true)}
                    onCloseAddGear={() => setShowAddGearModal(false)}
                    onSetAddGearTab={(tab) => setAddGearTab(tab)}
                    onSetCustomCategory={(cat) => setCustomGearCategory(cat)}
                    onSetCustomBrand={(val) => setCustomGearBrand(val)}
                    onSetCustomModel={(val) => setCustomGearModel(val)}
                    onSetCustomLabel={(val) => setCustomGearLabel(val)}
                    onSetCustomCondition={(val) => setCustomGearCondition(val)}
                    onSetCustomPrimary={(val) => setCustomGearPrimary(val)}
                    onToggleCondition={(gearId, currentCondition) =>
                      void handleToggleGearCondition(activeAthlete.id, gearId, currentCondition)
                    }
                    onTogglePrimary={(gearId, currentPrimary) =>
                      void handleToggleGearPrimary(activeAthlete.id, gearId, currentPrimary)
                    }
                    onDeleteGear={(gearId) =>
                      void handleDeleteGear(activeAthlete.id, gearId)
                    }
                    onAddGearPreset={(preset) =>
                      void handleAddGearPreset(activeAthlete.id, preset)
                    }
                    onCreateCustomGear={() =>
                      void handleCreateCustomGear(activeAthlete.id)
                    }
                  />

                  <section className={`${CARD} p-5 sm:p-6 space-y-4`}>
                    <div className="flex items-start justify-between gap-3">
                      <div>
                        <p className="text-[11px] font-bold uppercase tracking-[0.16em] text-[var(--sp-harbour-teal)]">Coach feed</p>
                        <h3 className={`${SECTION_TITLE} flex items-center gap-2`}>
                          <Award className="h-4 w-4 text-[var(--sp-harbour-teal)]" />
                          Coach Observations & Development Records
                        </h3>
                        <p className={`text-xs ${MUTED} mt-0.5`}>
                          Technical debriefs, starts, tactics, and boat speed observations logged by accredited coaches.
                        </p>
                      </div>
                      <span className={`text-[11px] font-bold ${MUTED} uppercase tracking-wider`}>
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
                              <span className={`text-[13px] ${MUTED} font-mono`}>
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
                  <PreRaceChecklist
                    activeAthlete={activeAthlete}
                    upcomingRegattas={upcomingRegattas}
                    checklistState={checklistState}
                    customChecklistItems={customChecklistItems}
                    newChecklistText={newChecklistText}
                    onToggleItem={(id, itemId) => toggleChecklistItem(id, itemId)}
                    onAddCustomItem={(id) => addCustomChecklistItem(id)}
                    onRemoveCustomItem={(id, itemId) => removeCustomChecklistItem(id, itemId)}
                    onResetChecklist={(id) => resetChecklist(id)}
                    onNewChecklistTextChange={(v) => setNewChecklistText(v)}
                  />

                  <PrivateNotesPanel
                    activeAthlete={activeAthlete}
                    noteDraft={noteDraft}
                    selectedCategory={selectedCategory}
                    noteBusy={noteBusy}
                    onDraftChange={(id, value) =>
                      setNoteDraft((d) => ({ ...d, [id]: value }))
                    }
                    onCategoryChange={(cat) =>
                      setSelectedCategory(cat as NoteCategory)
                    }
                    onAddNote={(id) => void addNote(id)}
                    onDeleteNote={(id) => void deleteNote(id)}
                  />
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

