"use client";

import { useCallback, useEffect, useMemo, useState } from "react";
import {
  BRAND_OTHER,
  brandsForCategory,
  categoryLabel,
  displayName,
  groupEquipmentSections,
  isCustomBrand,
  isMastSetCategory,
  resolveBrand,
  type EquipmentBoatClass,
  type EquipmentCategory,
  type EquipmentItemDto,
  type EquipmentTag,
  type SessionType,
  type WindRange,
} from "@/lib/equipment";
import {
  buildEquipmentSavePayload,
  buildFullRigPayload,
} from "@/lib/equipmentPayload";
import { todayYmdSg } from "@/lib/datesSg";
import { useFeedback } from "@/components/ui/FeedbackProvider";
import { emptyForm } from "./constants";
import type { EquipmentInventoryProps, ModalKind } from "./types";
import { defaultFullRigBrand } from "./utils";

type HookProps = Pick<
  EquipmentInventoryProps,
  | "sailorId"
  | "mayHaveIlca"
  | "onGearByRegatta"
  | "regattaOptions"
  | "preferredBoatClass"
>;

export function useEquipmentInventory({
  sailorId,
  mayHaveIlca,
  onGearByRegatta,
  regattaOptions = [],
  preferredBoatClass = null,
}: HookProps) {
  const { toast: feedbackToast, confirm } = useFeedback();
  const [items, setItems] = useState<EquipmentItemDto[]>([]);
  const [alerts, setAlerts] = useState<EquipmentItemDto[]>([]);
  const [loading, setLoading] = useState(true);
  const [isPrivate, setIsPrivate] = useState(false);
  const [classTab, setClassTab] = useState<EquipmentBoatClass>("optimist");
  const [ilcaUnlocked, setIlcaUnlocked] = useState(false);

  // Sync with dual-class profile tabs (Optimist / ILCA 4)
  useEffect(() => {
    if (preferredBoatClass === "optimist" || preferredBoatClass === "ilca4") {
      setClassTab(preferredBoatClass);
      if (preferredBoatClass === "ilca4") setIlcaUnlocked(true);
    }
  }, [preferredBoatClass]);
  const [modal, setModal] = useState<ModalKind>(null);
  const [editing, setEditing] = useState<EquipmentItemDto | null>(null);
  const [form, setForm] = useState(emptyForm);
  const [showMore, setShowMore] = useState(false);
  const [useItemIds, setUseItemIds] = useState<string[]>([]);
  const [useDate, setUseDate] = useState(todayYmdSg());
  const [useRegattaId, setUseRegattaId] = useState("");
  const [useSessionType, setUseSessionType] =
    useState<SessionType>("regatta");
  const [useWind, setUseWind] = useState<WindRange | "">("");
  const [selected, setSelected] = useState<Set<string>>(new Set());
  const [bulkTag, setBulkTag] = useState<EquipmentTag>("spare");
  const [busy, setBusy] = useState(false);
  const [msg, setMsg] = useState<string | null>(null);
  const [toast, setToast] = useState<string | null>(null);
  const [alertsOpen, setAlertsOpen] = useState(true);
  const [fullRigBrand, setFullRigBrand] = useState("");
  const [fullRigBrandCustom, setFullRigBrandCustom] = useState("");

  const flash = (text: string) => {
    setToast(text);
    window.setTimeout(() => setToast(null), 2200);
  };

  const load = useCallback(async () => {
    setLoading(true);
    try {
      const res = await fetch(
        `/api/account/equipment?sailorId=${encodeURIComponent(sailorId)}`,
        { credentials: "include" }
      );
      const data = await res.json();
      if (data.private) {
        setIsPrivate(true);
        setItems([]);
        setAlerts([]);
        return;
      }
      setIsPrivate(false);
      const list: EquipmentItemDto[] = data.items || [];
      setItems(list);
      setAlerts(data.alerts || []);
      if (data.gearByRegatta && onGearByRegatta) {
        onGearByRegatta(data.gearByRegatta);
      }
      if (mayHaveIlca || list.some((i) => i.boatClass === "ilca4")) {
        setIlcaUnlocked(true);
      }
    } catch {
      setItems([]);
    } finally {
      setLoading(false);
    }
  }, [sailorId, mayHaveIlca, onGearByRegatta]);

  useEffect(() => {
    void load();
  }, [load]);

  const showIlcaTab = ilcaUnlocked || mayHaveIlca;
  const classItems = useMemo(
    () => items.filter((i) => i.boatClass === classTab),
    [items, classTab]
  );
  const activeItems = useMemo(
    () => classItems.filter((i) => i.status !== "retired"),
    [classItems]
  );
  const sections = useMemo(
    () => groupEquipmentSections(activeItems),
    [activeItems]
  );
  const archived = classItems.filter((i) => i.status === "retired");
  const classAlerts = alerts.filter((a) => a.boatClass === classTab);
  const primaryCount = activeItems.filter((i) => i.isPrimary).length;

  const openQuick = (cat?: EquipmentCategory) => {
    setEditing(null);
    setShowMore(false);
    setMsg(null);
    const category = cat || "sail";
    const presets = brandsForCategory(category);
    setForm({
      ...emptyForm,
      boatClass: classTab,
      category,
      brand: category === "other" ? "" : presets[0] || BRAND_OTHER,
      acquiredOn: todayYmdSg(),
      isPrimary: !classItems.some(
        (i) => i.category === category && i.isPrimary
      ),
    });
    setModal("quick");
  };

  const openEdit = (item: EquipmentItemDto) => {
    setEditing(item);
    setShowMore(true);
    setMsg(null);
    if (item.category === "other") {
      setForm({
        boatClass: item.boatClass,
        category: item.category,
        brand: item.brand || "",
        brandCustom: "",
        model: item.model || "",
        label: item.label || "",
        status: item.status,
        condition: item.condition,
        isPrimary: item.isPrimary,
        tags: item.tags || [],
        windRange: item.windRange || "",
        acquiredOn: item.acquiredOn || todayYmdSg(),
        notes: item.notes || "",
      });
    } else {
      const custom = isCustomBrand(item.category, item.brand);
      setForm({
        boatClass: item.boatClass,
        category: item.category,
        brand: custom ? BRAND_OTHER : item.brand || "",
        brandCustom: custom ? item.brand || "" : "",
        model: item.model || "",
        label: item.label || "",
        status: item.status,
        condition: item.condition,
        isPrimary: item.isPrimary,
        tags: item.tags || [],
        windRange: item.windRange || "",
        acquiredOn: item.acquiredOn || todayYmdSg(),
        notes: item.notes || "",
      });
    }
    setModal("edit");
  };

  const openLogUse = (ids?: string[]) => {
    const active = classItems.filter((i) => i.status === "active");
    const selectedItems = ids?.length
      ? classItems.filter((i) => ids.includes(i.id))
      : active.filter((i) => i.isPrimary);
    setUseItemIds(
      ids?.length
        ? ids
        : active.filter((i) => i.isPrimary).map((i) => i.id)
    );
    setUseDate(todayYmdSg());
    setUseRegattaId("");
    setUseSessionType("regatta");
    const sail = selectedItems.find(
      (i) => i.category === "sail" && i.windRange
    );
    setUseWind(sail?.windRange || "");
    setMsg(null);
    setModal("use");
  };

  const openFullRig = () => {
    setFullRigBrand(defaultFullRigBrand());
    setFullRigBrandCustom("");
    setMsg(null);
    setModal("fullRig");
  };

  const saveItem = async () => {
    setBusy(true);
    setMsg(null);
    try {
      if (form.category === "other" && !form.label.trim()) {
        setMsg("Describe what this item is (e.g. tiller extension)");
        setBusy(false);
        return;
      }
      if (form.brand === BRAND_OTHER && !form.brandCustom.trim()) {
        setMsg("Enter the brand name for Other");
        setBusy(false);
        return;
      }
      const built = buildEquipmentSavePayload(sailorId, {
        ...form,
        acquiredOn: form.acquiredOn || todayYmdSg(),
      });
      if (!built.ok) {
        setMsg(built.error);
        setBusy(false);
        return;
      }
      const res = await fetch("/api/account/equipment", {
        method: editing ? "PATCH" : "POST",
        credentials: "include",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify(
          editing ? { id: editing.id, ...built.payload } : built.payload
        ),
      });
      const data = await res.json();
      if (!res.ok) throw new Error(data.error || "Save failed");
      setModal(null);
      setSelected(new Set());
      flash(editing ? "Equipment updated" : "Equipment added");
      await load();
    } catch (e) {
      setMsg(e instanceof Error ? e.message : "Error");
    } finally {
      setBusy(false);
    }
  };

  const saveFullRig = async () => {
    setBusy(true);
    setMsg(null);
    try {
      const built = buildFullRigPayload(
        sailorId,
        classTab,
        fullRigBrand,
        fullRigBrandCustom
      );
      if (!built.ok) {
        setMsg(built.error);
        setBusy(false);
        return;
      }
      const res = await fetch("/api/account/equipment", {
        method: "POST",
        credentials: "include",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify(built.payload),
      });
      const data = await res.json();
      if (!res.ok) throw new Error(data.error || "Save failed");
      setModal(null);
      flash("Full rig set added");
      await load();
    } catch (e) {
      setMsg(e instanceof Error ? e.message : "Error");
    } finally {
      setBusy(false);
    }
  };

  const logUses = async () => {
    if (!useItemIds.length) return;
    if (useSessionType === "regatta" && !useRegattaId) {
      setMsg("Select a regatta for regatta sessions");
      return;
    }
    setBusy(true);
    setMsg(null);
    const sessionPayload = {
      sessionType: useSessionType,
      usedOn: useDate || todayYmdSg(),
      regattaId:
        useSessionType === "regatta" ? useRegattaId || undefined : undefined,
      wind: useWind || undefined,
    };
    try {
      if (useItemIds.length > 1) {
        const res = await fetch("/api/account/equipment", {
          method: "PATCH",
          credentials: "include",
          headers: { "Content-Type": "application/json" },
          body: JSON.stringify({
            bulk: true,
            ids: useItemIds,
            action: "logSession",
            ...sessionPayload,
          }),
        });
        const data = await res.json();
        if (!res.ok) throw new Error(data.error || "Log failed");
      } else {
        const res = await fetch("/api/account/equipment", {
          method: "PATCH",
          credentials: "include",
          headers: { "Content-Type": "application/json" },
          body: JSON.stringify({
            id: useItemIds[0],
            logSession: true,
            ...sessionPayload,
          }),
        });
        const data = await res.json();
        if (!res.ok) throw new Error(data.error || "Log failed");
      }
      setModal(null);
      setSelected(new Set());
      flash(
        useSessionType === "regatta"
          ? "Regatta session logged"
          : "Training session logged"
      );
      await load();
    } catch (e) {
      setMsg(e instanceof Error ? e.message : "Error");
    } finally {
      setBusy(false);
    }
  };

  const makePrimary = async (item: EquipmentItemDto) => {
    if (item.isPrimary) return;
    const ok = await confirm({
      title: `Set “${displayName(item)}” as the primary ${categoryLabel(item.category)}?`,
      confirmLabel: "Set primary",
    });
    if (!ok) return;
    setBusy(true);
    try {
      const res = await fetch("/api/account/equipment", {
        method: "PATCH",
        credentials: "include",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({ id: item.id, isPrimary: true }),
      });
      if (!res.ok) {
        const data = await res.json();
        throw new Error(data.error || "Failed");
      }
      flash("Primary updated");
      await load();
    } catch (e) {
      feedbackToast.error(e instanceof Error ? e.message : "Error");
    } finally {
      setBusy(false);
    }
  };

  const bulkArchive = async () => {
    const ids = [...selected];
    if (!ids.length) return;
    const ok = await confirm({
      title: `Archive ${ids.length} item(s) to Past equipment?`,
      tone: "danger",
      confirmLabel: "Archive",
    });
    if (!ok) return;
    setBusy(true);
    try {
      const res = await fetch("/api/account/equipment", {
        method: "PATCH",
        credentials: "include",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({ bulk: true, ids, action: "archive" }),
      });
      if (!res.ok) throw new Error((await res.json()).error || "Failed");
      setSelected(new Set());
      flash("Moved to past equipment");
      await load();
    } catch (e) {
      feedbackToast.error(e instanceof Error ? e.message : "Error");
    } finally {
      setBusy(false);
    }
  };

  const bulkTagApply = async () => {
    const ids = [...selected];
    if (!ids.length) return;
    setBusy(true);
    try {
      const res = await fetch("/api/account/equipment", {
        method: "PATCH",
        credentials: "include",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({
          bulk: true,
          ids,
          action: "tag",
          tags: [bulkTag],
        }),
      });
      if (!res.ok) throw new Error((await res.json()).error || "Failed");
      setModal(null);
      setSelected(new Set());
      flash("Tag applied");
      await load();
    } catch (e) {
      feedbackToast.error(e instanceof Error ? e.message : "Error");
    } finally {
      setBusy(false);
    }
  };

  const toggleSelect = (id: string) => {
    setSelected((prev) => {
      const next = new Set(prev);
      if (next.has(id)) next.delete(id);
      else next.add(id);
      return next;
    });
  };

  const toggleTag = (t: EquipmentTag) => {
    setForm((f) => ({
      ...f,
      tags: f.tags.includes(t)
        ? f.tags.filter((x) => x !== t)
        : [...f.tags, t],
    }));
  };

  const closeModal = () => {
    setModal(null);
    setMsg(null);
  };

  const unlockIlca = () => {
    setIlcaUnlocked(true);
    setClassTab("ilca4");
  };

  return {
    loading,
    isPrivate,
    toast,
    classTab,
    setClassTab,
    showIlcaTab,
    unlockIlca,
    activeItems,
    primaryCount,
    classAlerts,
    alertsOpen,
    setAlertsOpen,
    selected,
    setSelected,
    setModal,
    busy,
    sections,
    archived,
    classItems,
    modal,
    editing,
    msg,
    form,
    setForm,
    showMore,
    setShowMore,
    bulkTag,
    setBulkTag,
    fullRigBrand,
    setFullRigBrand,
    fullRigBrandCustom,
    setFullRigBrandCustom,
    useItemIds,
    useSessionType,
    useDate,
    useRegattaId,
    useWind,
    setUseWind,
    setUseDate,
    regattaOptions,
    openQuick,
    openEdit,
    openLogUse,
    openFullRig,
    saveItem,
    saveFullRig,
    logUses,
    makePrimary,
    bulkArchive,
    bulkTagApply,
    toggleSelect,
    toggleTag,
    closeModal,
    setUseItemIds,
    setUseSessionType,
    setUseRegattaId,
  };
}
