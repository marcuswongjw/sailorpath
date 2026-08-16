"use client";

import { useCallback, useEffect, useMemo, useState } from "react";
import {
  AlertTriangle,
  Archive,
  Check,
  ChevronDown,
  ChevronUp,
  History,
  Plus,
  Settings,
  Star,
  Tag,
  Wrench,
  X,
} from "lucide-react";
import {
  BADGE_STYLES,
  BRAND_OTHER,
  CONDITION_OPTIONS,
  CONDITION_STYLES,
  EQUIPMENT_SECTIONS,
  EQUIPMENT_TAGS,
  WIND_RANGES,
  brandsForCategory,
  categoryLabel,
  displayName,
  formatUseSummary,
  groupEquipmentSections,
  isCustomBrand,
  isMastSetCategory,
  type EquipmentBadge,
  type EquipmentBoatClass,
  type EquipmentCategory,
  type EquipmentCondition,
  type EquipmentItemDto,
  type EquipmentStatus,
  type EquipmentTag,
  type SessionType,
  type WindRange,
} from "@/lib/equipment";
import { todayYmdSg } from "@/lib/datesSg";

type Props = {
  sailorId: string;
  isOwner: boolean;
  canSeeEquipment: boolean;
  mayHaveIlca: boolean;
  regattaOptions?: { id: string; name: string; date: string }[];
  cardClass?: string;
  onGearByRegatta?: (
    map: Record<
      string,
      { category: string; brand: string | null; label: string | null }[]
    >
  ) => void;
};

const emptyForm = {
  boatClass: "optimist" as EquipmentBoatClass,
  category: "sail" as EquipmentCategory,
  brand: "",
  brandCustom: "",
  model: "",
  label: "",
  status: "active" as EquipmentStatus,
  condition: "good" as EquipmentCondition,
  isPrimary: true,
  tags: ["racing"] as EquipmentTag[],
  windRange: "" as WindRange | "",
  acquiredOn: todayYmdSg(),
  notes: "",
};

const fieldClass =
  "mt-1 w-full rounded-xl bg-black/35 border border-white/10 px-3 py-2.5 text-sm text-white placeholder:text-slate-600 focus:border-orange-500/40 focus:outline-none focus:ring-1 focus:ring-orange-500/20";
const labelClass =
  "block text-[10px] font-bold uppercase tracking-wide text-slate-500";
const primaryBtn =
  "w-full rounded-full bg-orange-600 py-3 text-xs font-bold text-white disabled:opacity-50 touch-manipulation active:scale-[0.99] transition";
const secondaryBtn =
  "rounded-full border border-white/10 bg-white/5 px-3 py-2 text-[11px] font-bold text-white touch-manipulation disabled:opacity-40";

function resolvedBrand(form: typeof emptyForm): string {
  if (form.category === "other") return form.brand.trim();
  if (form.brand === BRAND_OTHER || isCustomBrand(form.category, form.brand)) {
    return form.brandCustom.trim() || form.brand.trim();
  }
  return form.brand.trim();
}

function sectionIcon(id: string): string {
  return EQUIPMENT_SECTIONS.find((s) => s.id === id)?.icon || "•";
}

export function EquipmentInventory({
  sailorId,
  isOwner,
  canSeeEquipment,
  mayHaveIlca,
  regattaOptions = [],
  cardClass = "rounded-2xl border border-white/5 bg-[#131520]/80",
  onGearByRegatta,
}: Props) {
  const [items, setItems] = useState<EquipmentItemDto[]>([]);
  const [alerts, setAlerts] = useState<EquipmentItemDto[]>([]);
  const [loading, setLoading] = useState(true);
  const [isPrivate, setIsPrivate] = useState(false);
  const [classTab, setClassTab] = useState<EquipmentBoatClass>("optimist");
  const [ilcaUnlocked, setIlcaUnlocked] = useState(false);
  const [modal, setModal] = useState<
    "quick" | "advanced" | "edit" | "use" | "fullRig" | "bulkTag" | null
  >(null);
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
  const brandPresets = brandsForCategory(form.category);
  const showCustomBrand =
    form.brand === BRAND_OTHER ||
    (form.brand !== "" && isCustomBrand(form.category, form.brand));
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

  const saveItem = async () => {
    setBusy(true);
    setMsg(null);
    try {
      const brand = resolvedBrand(form);
      if (form.category === "other") {
        if (!brand) {
          setMsg("Enter a brand or name");
          setBusy(false);
          return;
        }
        if (!form.label.trim()) {
          setMsg("Describe what this item is (e.g. tiller extension)");
          setBusy(false);
          return;
        }
      } else if (form.brand === BRAND_OTHER && !form.brandCustom.trim()) {
        setMsg("Enter the brand name for Other");
        setBusy(false);
        return;
      }
      const model =
        form.category === "sail" || isMastSetCategory(form.category)
          ? form.model || null
          : null;
      const label =
        form.category === "hull" ||
        form.category === "sail" ||
        form.category === "other"
          ? form.label || null
          : null;
      const payload = {
        sailorId,
        boatClass: form.boatClass,
        category: form.category,
        brand: brand || null,
        model,
        label,
        status: form.status,
        condition: form.condition,
        isPrimary: form.isPrimary,
        tags: form.tags,
        windRange: form.category === "sail" ? form.windRange || null : null,
        acquiredOn: form.acquiredOn || todayYmdSg(),
        notes: form.notes || null,
      };
      const res = await fetch("/api/account/equipment", {
        method: editing ? "PATCH" : "POST",
        credentials: "include",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify(
          editing ? { id: editing.id, ...payload } : payload
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
      const brand =
        fullRigBrand === BRAND_OTHER
          ? fullRigBrandCustom.trim()
          : fullRigBrand.trim();
      if (!brand) {
        setMsg("Select or enter a brand");
        setBusy(false);
        return;
      }
      const res = await fetch("/api/account/equipment", {
        method: "POST",
        credentials: "include",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({
          sailorId,
          boatClass: classTab,
          fullRig: true,
          brand,
          tags: ["racing"],
        }),
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
    if (
      !confirm(
        `Set “${displayName(item)}” as the primary ${categoryLabel(item.category)}?`
      )
    ) {
      return;
    }
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
      alert(e instanceof Error ? e.message : "Error");
    } finally {
      setBusy(false);
    }
  };

  const bulkArchive = async () => {
    const ids = [...selected];
    if (!ids.length) return;
    if (!confirm(`Archive ${ids.length} item(s) to Past equipment?`)) return;
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
      alert(e instanceof Error ? e.message : "Error");
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
      alert(e instanceof Error ? e.message : "Error");
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

  if (loading) {
    return (
      <section className={`${cardClass} p-4 sm:p-5`}>
        <div className="flex items-center gap-2 mb-4">
          <div className="h-3.5 w-3.5 rounded bg-white/10 animate-pulse" />
          <div className="h-3 w-20 rounded bg-white/10 animate-pulse" />
        </div>
        <div className="space-y-2">
          <div className="h-16 rounded-xl bg-white/[0.04] animate-pulse" />
          <div className="h-16 rounded-xl bg-white/[0.04] animate-pulse" />
        </div>
      </section>
    );
  }

  if (isPrivate || !canSeeEquipment) {
    return (
      <section className={`${cardClass} p-4 sm:p-5`}>
        <div className="flex items-center gap-2 mb-2">
          <Settings className="h-3.5 w-3.5 text-orange-400/90" />
          <h2 className="text-[11px] font-medium uppercase tracking-[0.14em] text-neutral-500">
            Equipment
          </h2>
        </div>
        <p className="text-xs text-slate-500 text-center py-8">
          Equipment is private to the owner.
        </p>
      </section>
    );
  }

  return (
    <section
      className={`${cardClass} p-4 sm:p-5 space-y-4 min-w-0 overflow-x-clip relative`}
    >
      {/* Toast */}
      {toast && (
        <div className="absolute left-1/2 -translate-x-1/2 top-3 z-30 rounded-full border border-emerald-500/30 bg-emerald-500/15 px-3.5 py-1.5 text-[11px] font-bold text-emerald-200 shadow-lg pointer-events-none">
          <span className="inline-flex items-center gap-1.5">
            <Check className="h-3.5 w-3.5" />
            {toast}
          </span>
        </div>
      )}

      {/* Header */}
      <div className="flex items-start justify-between gap-3 flex-wrap">
        <div className="min-w-0 flex-1">
          <div className="flex items-center gap-2 mb-1">
            <Settings className="h-3.5 w-3.5 text-orange-400/90 shrink-0" />
            <h2 className="text-[11px] font-medium uppercase tracking-[0.14em] text-neutral-500">
              Equipment
            </h2>
            {activeItems.length > 0 && (
              <span className="rounded-full bg-white/5 border border-white/10 px-2 py-0.5 text-[10px] font-bold text-slate-400 tabular-nums">
                {activeItems.length}
              </span>
            )}
          </div>
          <p className="text-[11px] text-neutral-500 max-w-md leading-relaxed">
            Track every hull, sail, foil, and rig. Know what to rig on race day
            — and when it&apos;s time to replace.
          </p>
          {activeItems.length > 0 && (
            <p className="text-[10px] text-slate-600 mt-1.5 tabular-nums">
              {primaryCount} primary
              {classAlerts.length > 0
                ? ` · ${classAlerts.length} need attention`
                : ""}
            </p>
          )}
        </div>
        {isOwner && (
          <div className="flex flex-wrap gap-2 shrink-0">
            <button
              type="button"
              onClick={() => openLogUse()}
              disabled={!activeItems.some((i) => i.status === "active")}
              className={secondaryBtn}
            >
              Log session
            </button>
            <button
              type="button"
              onClick={() => openQuick()}
              className="rounded-full bg-orange-600 px-3.5 py-2 text-[11px] font-bold text-white inline-flex items-center gap-1 touch-manipulation min-h-[2.25rem] shadow-md shadow-orange-950/30"
            >
              <Plus className="h-3.5 w-3.5" />
              Add
            </button>
          </div>
        )}
      </div>

      {/* Class segmented control */}
      <div className="inline-flex rounded-full border border-white/10 bg-black/25 p-0.5 gap-0.5">
        <button
          type="button"
          onClick={() => setClassTab("optimist")}
          className={`rounded-full px-3.5 py-1.5 text-[11px] font-bold transition touch-manipulation ${
            classTab === "optimist"
              ? "bg-orange-600 text-white shadow-sm"
              : "text-slate-400 hover:text-white"
          }`}
        >
          Optimist
        </button>
        {showIlcaTab ? (
          <button
            type="button"
            onClick={() => setClassTab("ilca4")}
            className={`rounded-full px-3.5 py-1.5 text-[11px] font-bold transition touch-manipulation ${
              classTab === "ilca4"
                ? "bg-sky-600 text-white shadow-sm"
                : "text-slate-400 hover:text-white"
            }`}
          >
            ILCA 4
          </button>
        ) : isOwner ? (
          <button
            type="button"
            onClick={() => {
              setIlcaUnlocked(true);
              setClassTab("ilca4");
            }}
            className="rounded-full px-3.5 py-1.5 text-[11px] font-bold text-sky-300/90 hover:text-sky-200 touch-manipulation"
          >
            + ILCA 4
          </button>
        ) : null}
      </div>

      {/* Alerts */}
      {classAlerts.length > 0 && isOwner && (
        <div className="rounded-xl border border-amber-500/30 bg-gradient-to-br from-amber-500/10 to-transparent overflow-hidden">
          <button
            type="button"
            onClick={() => setAlertsOpen((o) => !o)}
            className="w-full flex items-center justify-between gap-2 px-3 py-2.5 text-left touch-manipulation"
          >
            <span className="text-[11px] font-bold text-amber-200 flex items-center gap-1.5">
              <AlertTriangle className="h-3.5 w-3.5 shrink-0" />
              {classAlerts.length} replacement alert
              {classAlerts.length === 1 ? "" : "s"}
            </span>
            {alertsOpen ? (
              <ChevronUp className="h-3.5 w-3.5 text-amber-300/70" />
            ) : (
              <ChevronDown className="h-3.5 w-3.5 text-amber-300/70" />
            )}
          </button>
          {alertsOpen && (
            <ul className="px-3 pb-2.5 space-y-1.5 border-t border-amber-500/15 pt-2">
              {classAlerts.slice(0, 5).map((a) => (
                <li key={a.id}>
                  <button
                    type="button"
                    onClick={() => openEdit(a)}
                    className="w-full text-left rounded-lg px-2 py-1.5 hover:bg-amber-500/10 transition text-[11px] text-amber-50/90 flex items-center gap-2 flex-wrap"
                  >
                    <BadgeChip badge={a.badge} label={a.badgeLabel} />
                    <span className="font-semibold text-white">
                      {displayName(a)}
                    </span>
                    {a.attentionReason && (
                      <span className="text-amber-200/60">
                        — {a.attentionReason}
                      </span>
                    )}
                  </button>
                </li>
              ))}
            </ul>
          )}
        </div>
      )}

      {/* Bulk bar */}
      {isOwner && selected.size > 0 && (
        <div className="sticky top-14 z-20 rounded-xl border border-orange-500/35 bg-[#1a1210]/95 backdrop-blur-md px-3 py-2.5 flex flex-wrap items-center gap-2 shadow-xl">
          <span className="text-[11px] font-black text-orange-200 tabular-nums">
            {selected.size} selected
          </span>
          <div className="flex flex-wrap gap-1.5 ml-auto">
            <button
              type="button"
              disabled={busy}
              onClick={() => openLogUse([...selected])}
              className="inline-flex items-center gap-1 rounded-full bg-sky-600 px-2.5 py-1.5 text-[10px] font-bold text-white touch-manipulation"
            >
              <History className="h-3 w-3" />
              Log session
            </button>
            <button
              type="button"
              disabled={busy}
              onClick={() => setModal("bulkTag")}
              className="inline-flex items-center gap-1 rounded-full border border-white/15 px-2.5 py-1.5 text-[10px] font-bold text-white touch-manipulation"
            >
              <Tag className="h-3 w-3" />
              Tag
            </button>
            <button
              type="button"
              disabled={busy}
              onClick={() => void bulkArchive()}
              className="inline-flex items-center gap-1 rounded-full border border-white/15 px-2.5 py-1.5 text-[10px] font-bold text-slate-300 touch-manipulation"
            >
              <Archive className="h-3 w-3" />
              Archive
            </button>
            <button
              type="button"
              onClick={() => setSelected(new Set())}
              className="text-[10px] text-slate-500 px-1 touch-manipulation"
            >
              Clear
            </button>
          </div>
        </div>
      )}

      {/* Empty / inventory */}
      {activeItems.length === 0 ? (
        <div className="rounded-2xl border border-dashed border-white/10 bg-black/20 py-10 px-4 text-center space-y-4">
          <div className="mx-auto flex h-12 w-12 items-center justify-center rounded-2xl bg-orange-500/10 border border-orange-500/20">
            <Wrench className="h-6 w-6 text-orange-400/90" />
          </div>
          <div>
            <p className="text-sm font-bold text-white">
              {isOwner ? "Build your gear bag" : "No equipment logged yet"}
            </p>
            <p className="text-[11px] text-slate-500 mt-1 max-w-xs mx-auto leading-relaxed">
              {isOwner
                ? "Start with the hull and race sail you use most. You can add the rest anytime."
                : "This sailor hasn’t added private gear yet."}
            </p>
          </div>
          {isOwner && (
            <div className="flex flex-wrap justify-center gap-2">
              {(
                [
                  ["hull", "Hull"],
                  ["sail", "Sail"],
                  ["daggerboard", "Foil"],
                ] as const
              ).map(([cat, label]) => (
                <button
                  key={cat}
                  type="button"
                  onClick={() => openQuick(cat)}
                  className="rounded-full border border-white/10 bg-white/5 px-3.5 py-2 text-[11px] font-bold text-slate-200 hover:border-orange-500/40 touch-manipulation"
                >
                  + {label}
                </button>
              ))}
              <button
                type="button"
                onClick={() => {
                  setFullRigBrand(brandsForCategory("mast")[0] || "");
                  setFullRigBrandCustom("");
                  setMsg(null);
                  setModal("fullRig");
                }}
                className="rounded-full border border-orange-500/30 bg-orange-500/10 px-3.5 py-2 text-[11px] font-bold text-orange-200 touch-manipulation"
              >
                + Full rig set
              </button>
            </div>
          )}
        </div>
      ) : (
        <div className="space-y-3">
          {sections.map((sec) => {
            // Owners always see empty slots; others only non-empty
            if (sec.isEmpty && !isOwner) return null;
            const isSet = sec.id === "mast_set" || sec.id === "foil_set";
            return (
              <div
                key={sec.id}
                className="rounded-2xl border border-white/[0.06] bg-black/20 overflow-hidden"
              >
                <div className="flex items-start justify-between gap-2 px-3.5 pt-3 pb-2">
                  <div className="min-w-0 flex items-start gap-2.5">
                    <span
                      className="flex h-8 w-8 shrink-0 items-center justify-center rounded-xl bg-white/[0.04] border border-white/[0.06] text-base leading-none"
                      aria-hidden
                    >
                      {sectionIcon(sec.id)}
                    </span>
                    <div className="min-w-0 pt-0.5">
                      <p className="text-[12px] font-black text-white tracking-tight flex items-center gap-2">
                        {sec.label}
                        {!sec.isEmpty && (
                          <span className="text-[10px] font-bold text-slate-500 tabular-nums">
                            {sec.items.length}
                          </span>
                        )}
                      </p>
                      <p className="text-[10px] text-slate-600 mt-0.5 leading-snug">
                        {sec.hint}
                      </p>
                    </div>
                  </div>
                  {isOwner && !isSet && (
                    <button
                      type="button"
                      onClick={() => openQuick(sec.categories[0])}
                      className="shrink-0 rounded-full border border-white/10 bg-white/5 px-2.5 py-1 text-[10px] font-bold text-orange-300 hover:border-orange-500/40 touch-manipulation"
                    >
                      + Add
                    </button>
                  )}
                </div>

                {isSet && isOwner && (
                  <div className="flex flex-wrap gap-1.5 px-3.5 pb-2">
                    {sec.categories.map((cat) => (
                      <button
                        key={cat}
                        type="button"
                        onClick={() => openQuick(cat)}
                        className="rounded-full border border-white/10 bg-white/[0.03] px-2.5 py-1 text-[10px] font-bold text-slate-300 hover:border-orange-500/35 touch-manipulation"
                      >
                        + {categoryLabel(cat)}
                      </button>
                    ))}
                    {sec.id === "mast_set" && (
                      <button
                        type="button"
                        onClick={() => {
                          setFullRigBrand(brandsForCategory("mast")[0] || "");
                          setFullRigBrandCustom("");
                          setMsg(null);
                          setModal("fullRig");
                        }}
                        className="rounded-full border border-orange-500/30 bg-orange-500/10 px-2.5 py-1 text-[10px] font-bold text-orange-200 touch-manipulation"
                      >
                        + Full rig set
                      </button>
                    )}
                  </div>
                )}

                {sec.isEmpty ? (
                  <p className="text-[11px] text-slate-600 px-3.5 pb-3.5 pt-0.5">
                    Nothing here yet
                    {isOwner ? " — tap + to add." : "."}
                  </p>
                ) : (
                  <ul className="px-2.5 pb-2.5 space-y-2">
                    {isSet
                      ? sec.byCategory
                          .filter((g) => g.items.length > 0)
                          .flatMap((g) =>
                            g.items.map((item) => (
                              <EquipmentCard
                                key={item.id}
                                item={item}
                                partLabel={g.label}
                                isOwner={isOwner}
                                selected={selected.has(item.id)}
                                onToggleSelect={() => toggleSelect(item.id)}
                                onLogUse={() => openLogUse([item.id])}
                                onEdit={() => openEdit(item)}
                                onMakePrimary={() => void makePrimary(item)}
                              />
                            ))
                          )
                      : sec.items.map((item) => (
                          <EquipmentCard
                            key={item.id}
                            item={item}
                            isOwner={isOwner}
                            selected={selected.has(item.id)}
                            onToggleSelect={() => toggleSelect(item.id)}
                            onLogUse={() => openLogUse([item.id])}
                            onEdit={() => openEdit(item)}
                            onMakePrimary={() => void makePrimary(item)}
                          />
                        ))}
                  </ul>
                )}
              </div>
            );
          })}
        </div>
      )}

      {archived.length > 0 && isOwner && (
        <details className="group rounded-xl border border-white/5 bg-black/15 open:bg-black/20">
          <summary className="cursor-pointer list-none flex items-center justify-between gap-2 px-3.5 py-2.5 text-[11px] font-semibold text-slate-500 touch-manipulation">
            <span className="inline-flex items-center gap-1.5">
              <Archive className="h-3.5 w-3.5" />
              Past equipment ({archived.length})
            </span>
            <ChevronDown className="h-3.5 w-3.5 group-open:rotate-180 transition" />
          </summary>
          <ul className="px-3.5 pb-3 space-y-1.5 border-t border-white/5 pt-2">
            {archived.map((r) => (
              <li
                key={r.id}
                className="text-[11px] text-slate-500 flex items-center justify-between gap-2"
              >
                <span>
                  {displayName(r)}
                  <span className="text-slate-600">
                    {" "}
                    · {categoryLabel(r.category)}
                  </span>
                </span>
                <button
                  type="button"
                  onClick={() => openEdit(r)}
                  className="text-[10px] font-bold text-slate-400 hover:text-white"
                >
                  Edit
                </button>
              </li>
            ))}
          </ul>
        </details>
      )}

      {/* Modals */}
      {modal && (
        <div className="fixed inset-0 z-[80] flex items-end sm:items-center justify-center p-0 sm:p-4">
          <button
            type="button"
            className="absolute inset-0 bg-black/75 backdrop-blur-[2px]"
            aria-label="Close"
            onClick={closeModal}
          />
          <div className="relative w-full max-w-md max-h-[92vh] overflow-y-auto rounded-t-3xl sm:rounded-2xl border border-white/10 bg-[#12141c] p-5 sm:p-6 space-y-4 shadow-2xl pb-[max(1.25rem,env(safe-area-inset-bottom))]">
            {/* Mobile drag affordance */}
            <div className="sm:hidden flex justify-center -mt-1 mb-1">
              <div className="h-1 w-10 rounded-full bg-white/15" />
            </div>
            <div className="flex items-start justify-between gap-3">
              <div>
                <h3 className="text-base font-black text-white tracking-tight">
                  {modal === "use"
                    ? "Log session"
                    : modal === "fullRig"
                      ? "Add full rig set"
                      : modal === "bulkTag"
                        ? "Tag selected"
                        : modal === "edit"
                          ? "Edit equipment"
                          : "Quick add"}
                </h3>
                <p className="text-[11px] text-slate-500 mt-0.5">
                  {modal === "use"
                    ? "Record regatta or training use"
                    : modal === "fullRig"
                      ? "Mast + boom + sprit in one step"
                      : modal === "bulkTag"
                        ? `${selected.size} item(s)`
                        : modal === "edit"
                          ? displayName(editing || {})
                          : "Part, brand, number — more details optional"}
                </p>
              </div>
              <button
                type="button"
                onClick={closeModal}
                className="rounded-full border border-white/10 p-2 text-slate-400 hover:text-white touch-manipulation shrink-0"
                aria-label="Close"
              >
                <X className="h-4 w-4" />
              </button>
            </div>

            {msg && (
              <p className="rounded-xl border border-rose-500/30 bg-rose-500/10 px-3 py-2 text-[11px] text-rose-200 font-semibold">
                {msg}
              </p>
            )}

            {modal === "bulkTag" && (
              <>
                <label className={labelClass}>
                  Tag
                  <select
                    value={bulkTag}
                    onChange={(e) =>
                      setBulkTag(e.target.value as EquipmentTag)
                    }
                    className={fieldClass}
                  >
                    {EQUIPMENT_TAGS.map((t) => (
                      <option key={t.value} value={t.value}>
                        {t.label}
                      </option>
                    ))}
                  </select>
                </label>
                <button
                  type="button"
                  disabled={busy}
                  onClick={() => void bulkTagApply()}
                  className={primaryBtn}
                >
                  Apply tag
                </button>
              </>
            )}

            {modal === "fullRig" && (
              <>
                <label className={labelClass}>
                  Brand
                  <select
                    value={fullRigBrand}
                    onChange={(e) => setFullRigBrand(e.target.value)}
                    className={fieldClass}
                  >
                    {brandsForCategory("mast").map((b) => (
                      <option key={b} value={b}>
                        {b}
                      </option>
                    ))}
                    <option value={BRAND_OTHER}>Other…</option>
                  </select>
                </label>
                {fullRigBrand === BRAND_OTHER && (
                  <input
                    value={fullRigBrandCustom}
                    onChange={(e) => setFullRigBrandCustom(e.target.value)}
                    placeholder="Brand name"
                    className={fieldClass}
                  />
                )}
                <p className="text-[11px] text-slate-500 leading-relaxed">
                  Creates primary mast, boom, and sprit with the same brand —
                  typical for Optimist rig replacements.
                </p>
                <button
                  type="button"
                  disabled={busy}
                  onClick={() => void saveFullRig()}
                  className={primaryBtn}
                >
                  {busy ? "Saving…" : "Add mast + boom + sprit"}
                </button>
              </>
            )}

            {modal === "use" && (
              <>
                <div>
                  <p className={`${labelClass} mb-1.5`}>Gear used</p>
                  <ul className="space-y-1.5 max-h-36 overflow-y-auto rounded-xl border border-white/5 bg-black/20 p-1.5">
                    {classItems
                      .filter((i) => i.status === "active")
                      .map((i) => {
                        const on = useItemIds.includes(i.id);
                        return (
                          <label
                            key={i.id}
                            className={`flex items-center gap-2.5 rounded-lg px-2.5 py-2 text-[12px] cursor-pointer transition ${
                              on
                                ? "bg-sky-500/15 border border-sky-500/25 text-white"
                                : "border border-transparent text-slate-300 hover:bg-white/[0.03]"
                            }`}
                          >
                            <input
                              type="checkbox"
                              checked={on}
                              onChange={(e) => {
                                setUseItemIds((prev) =>
                                  e.target.checked
                                    ? [...prev, i.id]
                                    : prev.filter((x) => x !== i.id)
                                );
                              }}
                              className="rounded border-white/20"
                            />
                            <span className="min-w-0 flex-1 truncate font-semibold">
                              {displayName(i)}
                            </span>
                            <span className="text-[10px] text-slate-500 shrink-0">
                              {categoryLabel(i.category)}
                            </span>
                          </label>
                        );
                      })}
                  </ul>
                </div>

                <div>
                  <p className={`${labelClass} mb-1.5`}>Type</p>
                  <div className="grid grid-cols-2 gap-1.5 rounded-xl border border-white/10 bg-black/25 p-1">
                    {(
                      [
                        ["regatta", "Regatta"],
                        ["training", "Training"],
                      ] as const
                    ).map(([val, lab]) => (
                      <button
                        key={val}
                        type="button"
                        onClick={() => {
                          setUseSessionType(val);
                          if (val === "training") setUseRegattaId("");
                        }}
                        className={`rounded-lg py-2 text-[12px] font-bold transition touch-manipulation ${
                          useSessionType === val
                            ? val === "regatta"
                              ? "bg-sky-600 text-white"
                              : "bg-emerald-600 text-white"
                            : "text-slate-400 hover:text-white"
                        }`}
                      >
                        {lab}
                      </button>
                    ))}
                  </div>
                </div>

                <label className={labelClass}>
                  Date
                  <input
                    type="date"
                    value={useDate}
                    onChange={(e) => setUseDate(e.target.value)}
                    className={fieldClass}
                  />
                </label>

                {useSessionType === "regatta" && (
                  <label className={labelClass}>
                    Link regatta result
                    <select
                      value={useRegattaId}
                      onChange={(e) => {
                        setUseRegattaId(e.target.value);
                        const r = regattaOptions.find(
                          (x) => x.id === e.target.value
                        );
                        if (r?.date) setUseDate(r.date);
                      }}
                      className={fieldClass}
                    >
                      <option value="">Select result…</option>
                      {regattaOptions.map((r) => (
                        <option key={r.id} value={r.id}>
                          {r.date} · {r.name}
                        </option>
                      ))}
                    </select>
                  </label>
                )}

                <div>
                  <p className={`${labelClass} mb-1.5`}>Wind</p>
                  <div className="flex flex-wrap gap-1.5">
                    {(
                      [
                        ["", "—"],
                        ...WIND_RANGES.map((w) => [w.value, w.label] as const),
                      ] as const
                    ).map(([val, lab]) => (
                      <button
                        key={lab}
                        type="button"
                        onClick={() =>
                          setUseWind(val as WindRange | "")
                        }
                        className={`rounded-full px-3 py-1.5 text-[11px] font-bold border touch-manipulation ${
                          useWind === val
                            ? "bg-white/10 border-white/25 text-white"
                            : "border-white/10 text-slate-400"
                        }`}
                      >
                        {lab}
                      </button>
                    ))}
                  </div>
                </div>

                <button
                  type="button"
                  disabled={busy || !useItemIds.length}
                  onClick={() => void logUses()}
                  className="w-full rounded-full bg-sky-600 py-3 text-xs font-bold text-white disabled:opacity-50 touch-manipulation"
                >
                  {busy ? "Saving…" : "Save session"}
                </button>
              </>
            )}

            {(modal === "quick" || modal === "edit" || modal === "advanced") && (
              <>
                {/* Part chips for quick add */}
                {modal === "quick" && (
                  <div>
                    <p className={`${labelClass} mb-1.5`}>Part</p>
                    <div className="flex flex-wrap gap-1.5">
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
                        <button
                          key={cat}
                          type="button"
                          onClick={() => {
                            const presets = brandsForCategory(cat);
                            setForm((f) => ({
                              ...f,
                              category: cat,
                              brand:
                                cat === "other"
                                  ? ""
                                  : presets[0] || BRAND_OTHER,
                              brandCustom: "",
                              model: "",
                              label: "",
                              windRange: "",
                            }));
                          }}
                          className={`rounded-full px-2.5 py-1.5 text-[10px] font-bold border touch-manipulation ${
                            form.category === cat
                              ? "bg-orange-500/20 border-orange-500/40 text-orange-100"
                              : "border-white/10 text-slate-400"
                          }`}
                        >
                          {categoryLabel(cat)}
                        </button>
                      ))}
                    </div>
                  </div>
                )}

                {modal === "edit" && (
                  <label className={labelClass}>
                    Part
                    <select
                      value={form.category}
                      onChange={(e) => {
                        const category = e.target
                          .value as EquipmentCategory;
                        const presets = brandsForCategory(category);
                        setForm((f) => ({
                          ...f,
                          category,
                          brand:
                            category === "other"
                              ? ""
                              : presets[0] || BRAND_OTHER,
                          brandCustom: "",
                        }));
                      }}
                      className={fieldClass}
                    >
                      {EQUIPMENT_SECTIONS.map((sec) => (
                        <optgroup key={sec.id} label={sec.label}>
                          {sec.categories.map((cat) => (
                            <option key={cat} value={cat}>
                              {categoryLabel(cat)}
                            </option>
                          ))}
                        </optgroup>
                      ))}
                    </select>
                  </label>
                )}

                {form.category === "other" ? (
                  <label className={labelClass}>
                    Brand
                    <input
                      value={form.brand}
                      onChange={(e) =>
                        setForm((f) => ({ ...f, brand: e.target.value }))
                      }
                      placeholder="Brand name"
                      className={fieldClass}
                    />
                  </label>
                ) : (
                  <label className={labelClass}>
                    Brand
                    <select
                      value={
                        showCustomBrand
                          ? BRAND_OTHER
                          : form.brand || BRAND_OTHER
                      }
                      onChange={(e) =>
                        setForm((f) => ({
                          ...f,
                          brand: e.target.value,
                          brandCustom:
                            e.target.value === BRAND_OTHER
                              ? f.brandCustom
                              : "",
                        }))
                      }
                      className={fieldClass}
                    >
                      {brandPresets.map((b) => (
                        <option key={b} value={b}>
                          {b}
                        </option>
                      ))}
                      <option value={BRAND_OTHER}>Other…</option>
                    </select>
                  </label>
                )}

                {form.category !== "other" && showCustomBrand && (
                  <input
                    value={form.brandCustom}
                    onChange={(e) =>
                      setForm((f) => ({
                        ...f,
                        brandCustom: e.target.value,
                        brand: BRAND_OTHER,
                      }))
                    }
                    placeholder="Other brand name"
                    className={fieldClass}
                  />
                )}

                {form.category === "other" && (
                  <label className={labelClass}>
                    What is this?
                    <input
                      value={form.label}
                      onChange={(e) =>
                        setForm((f) => ({ ...f, label: e.target.value }))
                      }
                      placeholder="e.g. tiller extension, trolley"
                      className={fieldClass}
                    />
                  </label>
                )}

                {(form.category === "hull" || form.category === "sail") && (
                  <label className={labelClass}>
                    {form.category === "hull" ? "Hull number" : "Sail number"}
                    <input
                      value={form.label}
                      onChange={(e) =>
                        setForm((f) => ({ ...f, label: e.target.value }))
                      }
                      placeholder={
                        form.category === "hull" ? "SZ 12345" : "e.g. 115"
                      }
                      className={fieldClass}
                    />
                  </label>
                )}

                {isMastSetCategory(form.category) && (
                  <label className={labelClass}>
                    Model
                    <input
                      value={form.model}
                      onChange={(e) =>
                        setForm((f) => ({ ...f, model: e.target.value }))
                      }
                      placeholder="Optional"
                      className={fieldClass}
                    />
                  </label>
                )}

                {form.category === "sail" && (
                  <>
                    <label className={labelClass}>
                      Sail cut / series
                      <input
                        value={form.model}
                        onChange={(e) =>
                          setForm((f) => ({ ...f, model: e.target.value }))
                        }
                        placeholder='e.g. "Racing", "Power"'
                        className={fieldClass}
                      />
                    </label>
                    <div>
                      <p className={`${labelClass} mb-1.5`}>Wind range</p>
                      <div className="flex flex-wrap gap-1.5">
                        {(
                          [
                            ["", "—"],
                            ...WIND_RANGES.map(
                              (w) => [w.value, w.label] as const
                            ),
                          ] as const
                        ).map(([val, lab]) => (
                          <button
                            key={lab}
                            type="button"
                            onClick={() =>
                              setForm((f) => ({
                                ...f,
                                windRange: val as WindRange | "",
                              }))
                            }
                            className={`rounded-full px-3 py-1.5 text-[11px] font-bold border touch-manipulation ${
                              form.windRange === val
                                ? "bg-sky-500/20 border-sky-500/40 text-sky-100"
                                : "border-white/10 text-slate-400"
                            }`}
                          >
                            {lab}
                          </button>
                        ))}
                      </div>
                    </div>
                  </>
                )}

                {(showMore || modal === "edit") && (
                  <div className="space-y-3 border-t border-white/5 pt-3">
                    <div className="grid grid-cols-2 gap-2.5">
                      <label className={labelClass}>
                        Status
                        <select
                          value={form.status}
                          onChange={(e) =>
                            setForm((f) => ({
                              ...f,
                              status: e.target.value as EquipmentStatus,
                            }))
                          }
                          className={fieldClass}
                        >
                          <option value="active">Active</option>
                          <option value="backup">Backup</option>
                          <option value="retired">Archived</option>
                        </select>
                      </label>
                      <label className={labelClass}>
                        Condition
                        <select
                          value={form.condition}
                          onChange={(e) =>
                            setForm((f) => ({
                              ...f,
                              condition: e.target
                                .value as EquipmentCondition,
                            }))
                          }
                          className={fieldClass}
                        >
                          {CONDITION_OPTIONS.map((c) => (
                            <option key={c.value} value={c.value}>
                              {c.label}
                            </option>
                          ))}
                        </select>
                      </label>
                    </div>
                    <label className={labelClass}>
                      Acquired
                      <input
                        type="date"
                        value={form.acquiredOn}
                        onChange={(e) =>
                          setForm((f) => ({
                            ...f,
                            acquiredOn: e.target.value,
                          }))
                        }
                        className={fieldClass}
                      />
                    </label>
                    <div>
                      <p className={`${labelClass} mb-1.5`}>Tags</p>
                      <div className="flex flex-wrap gap-1.5">
                        {EQUIPMENT_TAGS.map((t) => (
                          <button
                            key={t.value}
                            type="button"
                            onClick={() => toggleTag(t.value)}
                            className={`rounded-full px-2.5 py-1.5 text-[10px] font-bold border touch-manipulation ${
                              form.tags.includes(t.value)
                                ? "bg-orange-500/20 border-orange-500/40 text-orange-200"
                                : "border-white/10 text-slate-400"
                            }`}
                          >
                            {t.label}
                          </button>
                        ))}
                      </div>
                    </div>
                    <label className="flex items-center gap-2.5 text-[12px] text-slate-300 rounded-xl border border-white/5 bg-black/20 px-3 py-2.5 cursor-pointer">
                      <input
                        type="checkbox"
                        checked={form.isPrimary}
                        onChange={(e) =>
                          setForm((f) => ({
                            ...f,
                            isPrimary: e.target.checked,
                          }))
                        }
                        className="rounded border-white/20"
                      />
                      <span>
                        <span className="font-semibold text-white">
                          Primary
                        </span>
                        <span className="text-slate-500">
                          {" "}
                          — main {categoryLabel(form.category).toLowerCase()}{" "}
                          for race day
                        </span>
                      </span>
                    </label>
                    <label className={labelClass}>
                      Notes
                      <textarea
                        value={form.notes}
                        onChange={(e) =>
                          setForm((f) => ({ ...f, notes: e.target.value }))
                        }
                        rows={2}
                        placeholder="Optional"
                        className={`${fieldClass} resize-none`}
                      />
                    </label>
                  </div>
                )}

                {modal === "quick" && !showMore && (
                  <button
                    type="button"
                    onClick={() => setShowMore(true)}
                    className="flex items-center gap-1 text-[11px] font-bold text-slate-400 hover:text-slate-200 touch-manipulation"
                  >
                    <ChevronDown className="h-3.5 w-3.5" />
                    More details
                  </button>
                )}
                {modal === "quick" && showMore && (
                  <button
                    type="button"
                    onClick={() => setShowMore(false)}
                    className="flex items-center gap-1 text-[11px] font-bold text-slate-400 hover:text-slate-200 touch-manipulation"
                  >
                    <ChevronUp className="h-3.5 w-3.5" />
                    Fewer details
                  </button>
                )}

                <button
                  type="button"
                  disabled={busy}
                  onClick={() => void saveItem()}
                  className={primaryBtn}
                >
                  {busy ? "Saving…" : editing ? "Save changes" : "Save"}
                </button>
              </>
            )}
          </div>
        </div>
      )}
    </section>
  );
}

function BadgeChip({
  badge,
  label,
}: {
  badge: EquipmentBadge;
  label: string;
}) {
  if (badge === "good" || badge === "new") return null;
  return (
    <span
      className={`inline-flex rounded-full border px-1.5 py-0.5 text-[9px] font-bold ${BADGE_STYLES[badge].className}`}
    >
      {label}
    </span>
  );
}

function ConditionChip({ condition }: { condition: EquipmentCondition }) {
  const s = CONDITION_STYLES[condition] || CONDITION_STYLES.good;
  return (
    <span
      className={`inline-flex rounded-full border px-1.5 py-0.5 text-[9px] font-bold ${s.className}`}
    >
      {s.label}
    </span>
  );
}

function EquipmentCard({
  item,
  partLabel,
  isOwner,
  selected,
  onToggleSelect,
  onLogUse,
  onEdit,
  onMakePrimary,
}: {
  item: EquipmentItemDto;
  partLabel?: string;
  isOwner: boolean;
  selected: boolean;
  onToggleSelect: () => void;
  onLogUse: () => void;
  onEdit: () => void;
  onMakePrimary: () => void;
}) {
  const tags = item.tags
    .map((t) => EQUIPMENT_TAGS.find((x) => x.value === t)?.label || t)
    .filter(Boolean);

  return (
    <li
      className={`list-none rounded-xl border transition ${
        selected
          ? "border-orange-500/40 bg-orange-500/[0.07]"
          : item.needsAttention
            ? "border-amber-500/25 bg-amber-500/[0.05]"
            : item.isPrimary
              ? "border-white/10 bg-gradient-to-br from-white/[0.04] to-transparent"
              : "border-white/[0.05] bg-black/25"
      }`}
    >
      <div className="px-3 pt-2.5 pb-2 flex items-start gap-2.5">
        {isOwner && (
          <input
            type="checkbox"
            checked={selected}
            onChange={onToggleSelect}
            className="mt-1 shrink-0 rounded border-white/20"
            aria-label={`Select ${displayName(item)}`}
          />
        )}
        <div className="min-w-0 flex-1">
          <div className="flex items-start gap-1.5 flex-wrap">
            <button
              type="button"
              disabled={!isOwner || item.isPrimary}
              onClick={onMakePrimary}
              title={item.isPrimary ? "Primary gear" : "Make primary"}
              className={`mt-0.5 shrink-0 touch-manipulation ${
                item.isPrimary
                  ? "text-amber-400"
                  : "text-slate-600 hover:text-amber-400"
              }`}
            >
              <Star
                className={`h-3.5 w-3.5 ${
                  item.isPrimary ? "fill-amber-400/60" : ""
                }`}
              />
            </button>
            <p className="text-[13px] font-bold text-white leading-snug min-w-0">
              {displayName(item)}
            </p>
            {partLabel && (
              <span className="text-[9px] font-bold uppercase tracking-wide text-slate-500 mt-0.5">
                {partLabel}
              </span>
            )}
          </div>

          <div className="mt-1.5 flex flex-wrap items-center gap-1">
            <ConditionChip condition={item.condition} />
            <BadgeChip badge={item.badge} label={item.badgeLabel} />
            {item.windRange && (
              <span className="inline-flex rounded-full border border-sky-500/25 bg-sky-500/10 px-1.5 py-0.5 text-[9px] font-bold uppercase text-sky-300">
                {item.windRange}
              </span>
            )}
            {item.isPrimary && (
              <span className="inline-flex rounded-full border border-amber-500/25 bg-amber-500/10 px-1.5 py-0.5 text-[9px] font-bold text-amber-200">
                Primary
              </span>
            )}
            {tags.slice(0, 3).map((t) => (
              <span
                key={t}
                className="inline-flex rounded-full border border-white/10 bg-white/[0.03] px-1.5 py-0.5 text-[9px] font-semibold text-slate-400"
              >
                {t}
              </span>
            ))}
          </div>

          <p className="text-[10px] text-slate-500 mt-1.5 tabular-nums">
            {formatUseSummary(item)}
            {item.category === "sail" && item.model
              ? ` · ${item.model}`
              : ""}
          </p>

          {(item.usageHistory?.length ?? 0) > 0 && (
            <p className="text-[10px] text-slate-600 mt-1 leading-snug">
              <span className="text-slate-500">Used at</span>{" "}
              {item
                .usageHistory!.filter((u) => u.regattaName)
                .slice(0, 3)
                .map(
                  (u) =>
                    `${u.regattaName}${
                      u.rank != null ? ` (#${u.rank})` : ""
                    }`
                )
                .join(" · ")}
            </p>
          )}
        </div>
      </div>

      {isOwner && (
        <div className="flex border-t border-white/[0.04] divide-x divide-white/[0.04]">
          {!item.isPrimary && (
            <button
              type="button"
              onClick={onMakePrimary}
              className="flex-1 py-2 text-[10px] font-bold text-amber-400/90 hover:bg-white/[0.03] touch-manipulation"
            >
              Make primary
            </button>
          )}
          <button
            type="button"
            onClick={onLogUse}
            className="flex-1 py-2 text-[10px] font-bold text-sky-400 hover:bg-white/[0.03] touch-manipulation"
          >
            Log session
          </button>
          <button
            type="button"
            onClick={onEdit}
            className="flex-1 py-2 text-[10px] font-bold text-slate-400 hover:bg-white/[0.03] touch-manipulation"
          >
            Edit
          </button>
        </div>
      )}
    </li>
  );
}
