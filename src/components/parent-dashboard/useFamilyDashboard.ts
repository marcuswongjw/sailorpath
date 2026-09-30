"use client";

import { useCallback, useEffect, useRef, useState } from "react";
import { useRouter } from "next/navigation";
import { useFeedback } from "@/components/ui/FeedbackProvider";
import {
  toSimplifiedCondition,
  fromSimplifiedCondition,
  type QuickEquipmentPreset,
  type EquipmentCategory,
  type SimplifiedCondition,
} from "@/lib/equipment";
import type {
  Athlete,
  UpcomingRegatta,
  PendingClaim,
  NoteCategory,
} from "./types";

export function useFamilyDashboard() {
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


  const activeAthlete =
    selectedAthleteId === "all"
      ? null
      : athletes.find((a) => a.id === selectedAthleteId) || null;

  const title = isParentStyle ? "Parent Dashboard" : "Sailor Dashboard";
  const subtitle = isParentStyle
    ? "Linked athletes, series standing, boat locker, coach logs, and race-day prep."
    : "Your series ranking, selection trials, boat locker, and private notes.";

  return {
    loading,
    error,
    athletes,
    upcomingRegattas,
    pendingClaims,
    isParentStyle,
    selectedAthleteId,
    setSelectedAthleteId,
    selectedCategory,
    setSelectedCategory,
    noteDraft,
    setNoteDraft,
    noteBusy,
    checklistState,
    customChecklistItems,
    newChecklistText,
    setNewChecklistText,
    showAddGearModal,
    setShowAddGearModal,
    addGearTab,
    setAddGearTab,
    addGearBusy,
    customGearCategory,
    setCustomGearCategory,
    customGearBrand,
    setCustomGearBrand,
    customGearModel,
    setCustomGearModel,
    customGearLabel,
    setCustomGearLabel,
    customGearCondition,
    setCustomGearCondition,
    customGearPrimary,
    setCustomGearPrimary,
    toggleChecklistItem,
    addCustomChecklistItem,
    removeCustomChecklistItem,
    resetChecklist,
    handleToggleGearCondition,
    handleToggleGearPrimary,
    handleDeleteGear,
    handleAddGearPreset,
    handleCreateCustomGear,
    addNote,
    deleteNote,
    activeAthlete,
    title,
    subtitle,
  };
}
