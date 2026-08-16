"use client";

import { useCallback, useEffect, useMemo, useState } from "react";
import {
  AlertTriangle,
  Check,
  ChevronDown,
  ChevronUp,
  Plus,
  Settings,
  Star,
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
  /** Notify parent of gear-by-regatta for results linkage */
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

function resolvedBrand(form: typeof emptyForm): string {
  // Other category: free-text brand field
  if (form.category === "other") {
    return form.brand.trim();
  }
  if (form.brand === BRAND_OTHER || isCustomBrand(form.category, form.brand)) {
    return form.brandCustom.trim() || form.brand.trim();
  }
  return form.brand.trim();
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
  const [fullRigBrand, setFullRigBrand] = useState("");
  const [fullRigBrandCustom, setFullRigBrandCustom] = useState("");

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
  const sections = useMemo(
    () =>
      groupEquipmentSections(
        classItems.filter((i) => i.status !== "retired")
      ),
    [classItems]
  );
  const archived = classItems.filter((i) => i.status === "retired");
  const classAlerts = alerts.filter((a) => a.boatClass === classTab);
  const brandPresets = brandsForCategory(form.category);
  const showCustomBrand =
    form.brand === BRAND_OTHER ||
    (form.brand !== "" && isCustomBrand(form.category, form.brand));

  const openQuick = (cat?: EquipmentCategory) => {
    setEditing(null);
    setShowMore(false);
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
    // Auto-suggest wind from sail windRange tags when logging a single sail
    const sail = selectedItems.find(
      (i) => i.category === "sail" && i.windRange
    );
    setUseWind(sail?.windRange || "");
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
      // Model only for sails + mast set; label only for hull/sail/other
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
        windRange:
          form.category === "sail" ? form.windRange || null : null,
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

  if (loading) {
    return (
      <section className={`${cardClass} p-4 sm:p-5`}>
        <p className="text-xs text-slate-500">Loading equipment…</p>
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
        <p className="text-xs text-slate-500 text-center py-6">
          Equipment is private.
        </p>
      </section>
    );
  }

  return (
    <section className={`${cardClass} p-4 sm:p-5 space-y-4 min-w-0 overflow-x-clip`}>
      <div className="flex items-start justify-between gap-2 flex-wrap">
        <div className="min-w-0 flex-1">
          <div className="flex items-center gap-2 mb-1">
            <Settings className="h-3.5 w-3.5 text-orange-400/90 shrink-0" />
            <h2 className="text-[11px] font-medium uppercase tracking-[0.14em] text-neutral-500">
              Equipment
            </h2>
          </div>
          <p className="text-[11px] text-neutral-500 max-w-md leading-relaxed">
            Track every hull, sail, foil, and rig. Know what to rig on race day
            — and when it&apos;s time to replace.
          </p>
        </div>
        {isOwner && (
          <div className="flex flex-wrap gap-2 shrink-0">
            <button
              type="button"
              onClick={() => openLogUse()}
              disabled={!classItems.some((i) => i.status === "active")}
              className="rounded-full border border-white/10 bg-white/5 px-3 py-2 text-[10px] font-bold text-white disabled:opacity-40 touch-manipulation min-h-[2.25rem]"
            >
              Log session
            </button>
            <button
              type="button"
              onClick={() => openQuick()}
              className="rounded-full bg-orange-600 px-3 py-2 text-[10px] font-bold text-white inline-flex items-center gap-1 touch-manipulation min-h-[2.25rem]"
            >
              <Plus className="h-3 w-3" />
              Add
            </button>
          </div>
        )}
      </div>

      <div className="flex flex-wrap gap-1.5 items-center">
        <button
          type="button"
          onClick={() => setClassTab("optimist")}
          className={`rounded-full px-3 py-1 text-[11px] font-bold ${
            classTab === "optimist"
              ? "bg-orange-600 text-white"
              : "bg-white/5 text-slate-400 border border-white/10"
          }`}
        >
          Optimist
        </button>
        {showIlcaTab ? (
          <button
            type="button"
            onClick={() => setClassTab("ilca4")}
            className={`rounded-full px-3 py-1 text-[11px] font-bold ${
              classTab === "ilca4"
                ? "bg-sky-600 text-white"
                : "bg-white/5 text-slate-400 border border-white/10"
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
            className="rounded-full border border-sky-500/30 bg-sky-500/10 px-3 py-1 text-[11px] font-bold text-sky-300"
          >
            + Add ILCA 4 equipment
          </button>
        ) : null}
      </div>

      {classAlerts.length > 0 && isOwner && (
        <div className="rounded-xl border border-amber-500/30 bg-amber-500/10 px-3 py-2.5 space-y-1">
          <p className="text-[11px] font-bold text-amber-200 flex items-center gap-1.5">
            <AlertTriangle className="h-3.5 w-3.5" />
            {classAlerts.length} replacement alert
            {classAlerts.length === 1 ? "" : "s"}
          </p>
          {classAlerts.slice(0, 4).map((a) => (
            <p key={a.id} className="text-[11px] text-amber-100/90">
              <BadgeChip badge={a.badge} label={a.badgeLabel} />{" "}
              {displayName(a)}
              {a.attentionReason ? ` — ${a.attentionReason}` : ""}
            </p>
          ))}
        </div>
      )}

      {/* Bulk bar */}
      {isOwner && selected.size > 0 && (
        <div className="sticky top-14 z-20 rounded-xl border border-orange-500/30 bg-[#1a1210] px-3 py-2 flex flex-wrap items-center gap-2 shadow-lg">
          <span className="text-[11px] font-bold text-orange-200">
            {selected.size} selected
          </span>
          <button
            type="button"
            disabled={busy}
            onClick={() => openLogUse([...selected])}
            className="rounded-full bg-sky-600 px-2.5 py-1 text-[10px] font-bold text-white"
          >
            Log session
          </button>
          <button
            type="button"
            disabled={busy}
            onClick={() => setModal("bulkTag")}
            className="rounded-full border border-white/15 px-2.5 py-1 text-[10px] font-bold text-white"
          >
            Tag
          </button>
          <button
            type="button"
            disabled={busy}
            onClick={() => void bulkArchive()}
            className="rounded-full border border-white/15 px-2.5 py-1 text-[10px] font-bold text-slate-300"
          >
            Archive
          </button>
          <button
            type="button"
            onClick={() => setSelected(new Set())}
            className="text-[10px] text-slate-500 ml-auto"
          >
            Clear
          </button>
        </div>
      )}

      {classItems.filter((i) => i.status !== "retired").length === 0 ? (
        <div className="py-8 text-center space-y-2">
          <Wrench className="h-7 w-7 text-slate-600 mx-auto" />
          <p className="text-xs text-slate-500">
            {isOwner
              ? "Quick-add a sail or hull to start tracking gear."
              : "No equipment logged yet."}
          </p>
          {isOwner && (
            <button
              type="button"
              onClick={() => openQuick("sail")}
              className="text-[11px] font-bold text-orange-400"
            >
              + Quick add
            </button>
          )}
        </div>
      ) : (
        <div className="space-y-5">
          {sections.map((sec) => {
            if (sec.isEmpty && !isOwner) return null;
            const isSet = sec.id === "mast_set" || sec.id === "foil_set";
            return (
              <div
                key={sec.id}
                className="rounded-xl border border-white/5 bg-black/15 p-3 space-y-2.5"
              >
                <div className="flex items-start justify-between gap-2">
                  <div>
                    <p className="text-[11px] font-black uppercase tracking-wider text-slate-300">
                      {sec.label}
                    </p>
                    <p className="text-[10px] text-slate-600 mt-0.5">
                      {sec.hint}
                    </p>
                  </div>
                  {isOwner && !isSet && (
                    <button
                      type="button"
                      onClick={() => openQuick(sec.categories[0])}
                      className="text-[10px] font-bold text-orange-400/90 shrink-0"
                    >
                      + Add
                    </button>
                  )}
                </div>

                {isSet && isOwner && (
                  <div className="flex flex-wrap gap-1.5">
                    {sec.categories.map((cat) => (
                      <button
                        key={cat}
                        type="button"
                        onClick={() => openQuick(cat)}
                        className="rounded-full border border-white/10 bg-white/5 px-2.5 py-1 text-[10px] font-bold text-slate-300 hover:border-orange-500/40"
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
                        className="rounded-full border border-orange-500/30 bg-orange-500/10 px-2.5 py-1 text-[10px] font-bold text-orange-200"
                      >
                        + Add full rig set
                      </button>
                    )}
                  </div>
                )}

                {sec.isEmpty ? (
                  <p className="text-[11px] text-slate-600 py-1">
                    Nothing logged yet.
                  </p>
                ) : isSet ? (
                  sec.byCategory
                    .filter((g) => g.items.length > 0)
                    .map((g) => (
                      <div key={g.category} className="space-y-1.5">
                        <p className="text-[10px] font-bold text-slate-500 uppercase pl-0.5">
                          {g.label}
                        </p>
                        <ul className="space-y-2">
                          {g.items.map((item) => (
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
                      </div>
                    ))
                ) : (
                  <ul className="space-y-2">
                    {sec.items.map((item) => (
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
        <details className="text-[11px] text-slate-500">
          <summary className="cursor-pointer font-semibold">
            Past equipment ({archived.length})
          </summary>
          <ul className="mt-2 space-y-1">
            {archived.map((r) => (
              <li key={r.id}>
                {displayName(r)} · {categoryLabel(r.category)}
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
            className="absolute inset-0 bg-black/70"
            aria-label="Close"
            onClick={() => setModal(null)}
          />
          <div className="relative w-full max-w-md max-h-[90vh] overflow-y-auto rounded-t-2xl sm:rounded-2xl border border-white/10 bg-[#12141c] p-5 space-y-3 shadow-2xl">
            <div className="flex items-center justify-between">
              <h3 className="text-sm font-black text-white">
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
              <button
                type="button"
                onClick={() => setModal(null)}
                className="text-slate-400 p-1"
              >
                <X className="h-4 w-4" />
              </button>
            </div>
            {msg && (
              <p className="text-[11px] text-rose-300 font-semibold">{msg}</p>
            )}

            {modal === "bulkTag" && (
              <>
                <p className="text-[11px] text-slate-500">
                  Apply tag to {selected.size} item(s)
                </p>
                <select
                  value={bulkTag}
                  onChange={(e) =>
                    setBulkTag(e.target.value as EquipmentTag)
                  }
                  className="w-full rounded-lg bg-black/40 border border-white/10 px-3 py-2 text-sm text-white"
                >
                  {EQUIPMENT_TAGS.map((t) => (
                    <option key={t.value} value={t.value}>
                      {t.label}
                    </option>
                  ))}
                </select>
                <button
                  type="button"
                  disabled={busy}
                  onClick={() => void bulkTagApply()}
                  className="w-full rounded-full bg-orange-600 py-2.5 text-xs font-bold text-white"
                >
                  Apply tag
                </button>
              </>
            )}

            {modal === "fullRig" && (
              <>
                <p className="text-[11px] text-slate-500">
                  Creates primary mast, boom, and sprit with the same brand.
                </p>
                <label className="block text-[10px] font-bold text-slate-500 uppercase">
                  Brand
                  <select
                    value={fullRigBrand}
                    onChange={(e) => setFullRigBrand(e.target.value)}
                    className="mt-1 w-full rounded-lg bg-black/40 border border-white/10 px-3 py-2 text-sm text-white"
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
                    className="w-full rounded-lg bg-black/40 border border-white/10 px-3 py-2 text-sm text-white"
                  />
                )}
                <button
                  type="button"
                  disabled={busy}
                  onClick={() => void saveFullRig()}
                  className="w-full rounded-full bg-orange-600 py-2.5 text-xs font-bold text-white"
                >
                  {busy ? "Saving…" : "Add mast + boom + sprit"}
                </button>
              </>
            )}

            {modal === "use" && (
              <>
                <ul className="space-y-1.5 max-h-40 overflow-y-auto">
                  {classItems
                    .filter((i) => i.status === "active")
                    .map((i) => (
                      <label
                        key={i.id}
                        className="flex items-center gap-2 rounded-lg border border-white/5 bg-black/25 px-2.5 py-2 text-[12px] text-white"
                      >
                        <input
                          type="checkbox"
                          checked={useItemIds.includes(i.id)}
                          onChange={(e) => {
                            setUseItemIds((prev) =>
                              e.target.checked
                                ? [...prev, i.id]
                                : prev.filter((x) => x !== i.id)
                            );
                          }}
                        />
                        <span>
                          {displayName(i)}{" "}
                          <span className="text-slate-500">
                            ({categoryLabel(i.category)})
                          </span>
                        </span>
                      </label>
                    ))}
                </ul>
                <div className="grid grid-cols-2 gap-2">
                  <label className="block text-[10px] font-bold text-slate-500 uppercase">
                    Type
                    <select
                      value={useSessionType}
                      onChange={(e) => {
                        const t = e.target.value as SessionType;
                        setUseSessionType(t);
                        if (t === "training") setUseRegattaId("");
                      }}
                      className="mt-1 w-full rounded-lg bg-black/40 border border-white/10 px-2 py-2 text-sm text-white"
                    >
                      <option value="regatta">Regatta</option>
                      <option value="training">Training</option>
                    </select>
                  </label>
                  <label className="block text-[10px] font-bold text-slate-500 uppercase">
                    Date
                    <input
                      type="date"
                      value={useDate}
                      onChange={(e) => setUseDate(e.target.value)}
                      className="mt-1 w-full rounded-lg bg-black/40 border border-white/10 px-2 py-2 text-sm text-white"
                    />
                  </label>
                </div>
                {useSessionType === "regatta" && (
                  <label className="block text-[10px] font-bold text-slate-500 uppercase">
                    Regatta link
                    <select
                      value={useRegattaId}
                      onChange={(e) => {
                        setUseRegattaId(e.target.value);
                        // Auto-fill date from regatta when selected
                        const r = regattaOptions.find(
                          (x) => x.id === e.target.value
                        );
                        if (r?.date) setUseDate(r.date);
                      }}
                      className="mt-1 w-full rounded-lg bg-black/40 border border-white/10 px-3 py-2 text-sm text-white"
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
                <label className="block text-[10px] font-bold text-slate-500 uppercase">
                  Wind
                  <select
                    value={useWind}
                    onChange={(e) =>
                      setUseWind(e.target.value as WindRange | "")
                    }
                    className="mt-1 w-full rounded-lg bg-black/40 border border-white/10 px-3 py-2 text-sm text-white"
                  >
                    <option value="">—</option>
                    {WIND_RANGES.map((w) => (
                      <option key={w.value} value={w.value}>
                        {w.label}
                      </option>
                    ))}
                  </select>
                </label>
                <button
                  type="button"
                  disabled={busy || !useItemIds.length}
                  onClick={() => void logUses()}
                  className="w-full rounded-full bg-sky-600 py-2.5 text-xs font-bold text-white disabled:opacity-50"
                >
                  {busy ? "Saving…" : "Save session"}
                </button>
              </>
            )}

            {(modal === "quick" || modal === "edit" || modal === "advanced") && (
              <>
                <div className="grid grid-cols-2 gap-2">
                  <label className="block text-[10px] font-bold text-slate-500 uppercase">
                    Part
                    <select
                      value={form.category}
                      onChange={(e) => {
                        const category = e.target.value as EquipmentCategory;
                        const presets = brandsForCategory(category);
                        setForm((f) => ({
                          ...f,
                          category,
                          brand:
                            category === "other"
                              ? ""
                              : presets[0] || BRAND_OTHER,
                          brandCustom: "",
                          model: "",
                          label: "",
                        }));
                      }}
                      className="mt-1 w-full rounded-lg bg-black/40 border border-white/10 px-2 py-2 text-sm text-white"
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
                  {form.category === "other" ? (
                    <label className="block text-[10px] font-bold text-slate-500 uppercase">
                      Brand
                      <input
                        value={form.brand}
                        onChange={(e) =>
                          setForm((f) => ({ ...f, brand: e.target.value }))
                        }
                        placeholder="Free text brand"
                        className="mt-1 w-full rounded-lg bg-black/40 border border-white/10 px-2 py-2 text-sm text-white"
                      />
                    </label>
                  ) : (
                    <label className="block text-[10px] font-bold text-slate-500 uppercase">
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
                        className="mt-1 w-full rounded-lg bg-black/40 border border-white/10 px-2 py-2 text-sm text-white"
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
                </div>
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
                    className="w-full rounded-lg bg-black/40 border border-white/10 px-3 py-2 text-sm text-white"
                  />
                )}
                {form.category === "other" && (
                  <label className="block text-[10px] font-bold text-slate-500 uppercase">
                    What is this?
                    <input
                      value={form.label}
                      onChange={(e) =>
                        setForm((f) => ({ ...f, label: e.target.value }))
                      }
                      placeholder="e.g. tiller extension, trolley, sheet"
                      className="mt-1 w-full rounded-lg bg-black/40 border border-white/10 px-3 py-2 text-sm text-white"
                    />
                  </label>
                )}
                {(form.category === "hull" || form.category === "sail") && (
                  <label className="block text-[10px] font-bold text-slate-500 uppercase">
                    {form.category === "hull" ? "Hull number" : "Sail number"}
                    <input
                      value={form.label}
                      onChange={(e) =>
                        setForm((f) => ({ ...f, label: e.target.value }))
                      }
                      placeholder={
                        form.category === "hull" ? "SZ 12345" : "e.g. 115"
                      }
                      className="mt-1 w-full rounded-lg bg-black/40 border border-white/10 px-3 py-2 text-sm text-white"
                    />
                  </label>
                )}
                {/* Mast set: model only (no label/number) */}
                {isMastSetCategory(form.category) && (
                  <label className="block text-[10px] font-bold text-slate-500 uppercase">
                    Model
                    <input
                      value={form.model}
                      onChange={(e) =>
                        setForm((f) => ({ ...f, model: e.target.value }))
                      }
                      placeholder="Optional model"
                      className="mt-1 w-full rounded-lg bg-black/40 border border-white/10 px-3 py-2 text-sm text-white"
                    />
                  </label>
                )}
                {form.category === "sail" && (
                  <>
                    <label className="block text-[10px] font-bold text-slate-500 uppercase">
                      Sail cut / series
                      <input
                        value={form.model}
                        onChange={(e) =>
                          setForm((f) => ({ ...f, model: e.target.value }))
                        }
                        placeholder='e.g. "Racing", "Power"'
                        className="mt-1 w-full rounded-lg bg-black/40 border border-white/10 px-3 py-2 text-sm text-white"
                      />
                    </label>
                    <label className="block text-[10px] font-bold text-slate-500 uppercase">
                      Wind range
                      <select
                        value={form.windRange}
                        onChange={(e) =>
                          setForm((f) => ({
                            ...f,
                            windRange: e.target.value as WindRange | "",
                          }))
                        }
                        className="mt-1 w-full rounded-lg bg-black/40 border border-white/10 px-3 py-2 text-sm text-white"
                      >
                        <option value="">—</option>
                        {WIND_RANGES.map((w) => (
                          <option key={w.value} value={w.value}>
                            {w.label}
                          </option>
                        ))}
                      </select>
                    </label>
                  </>
                )}

                {(showMore || modal === "edit") && (
                  <div className="space-y-3 border-t border-white/5 pt-3">
                    <div className="grid grid-cols-2 gap-2">
                      <label className="block text-[10px] font-bold text-slate-500 uppercase">
                        Status
                        <select
                          value={form.status}
                          onChange={(e) =>
                            setForm((f) => ({
                              ...f,
                              status: e.target.value as EquipmentStatus,
                            }))
                          }
                          className="mt-1 w-full rounded-lg bg-black/40 border border-white/10 px-2 py-2 text-sm text-white"
                        >
                          <option value="active">Active</option>
                          <option value="backup">Backup</option>
                          <option value="retired">Archived</option>
                        </select>
                      </label>
                      <label className="block text-[10px] font-bold text-slate-500 uppercase">
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
                          className="mt-1 w-full rounded-lg bg-black/40 border border-white/10 px-2 py-2 text-sm text-white"
                        >
                          {CONDITION_OPTIONS.map((c) => (
                            <option key={c.value} value={c.value}>
                              {c.label}
                            </option>
                          ))}
                        </select>
                      </label>
                    </div>
                    <label className="block text-[10px] font-bold text-slate-500 uppercase">
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
                        className="mt-1 w-full rounded-lg bg-black/40 border border-white/10 px-3 py-2 text-sm text-white"
                      />
                    </label>
                    <div>
                      <p className="text-[10px] font-bold text-slate-500 uppercase mb-1.5">
                        Tags
                      </p>
                      <div className="flex flex-wrap gap-1.5">
                        {EQUIPMENT_TAGS.map((t) => (
                          <button
                            key={t.value}
                            type="button"
                            onClick={() => toggleTag(t.value)}
                            className={`rounded-full px-2.5 py-1 text-[10px] font-bold border ${
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
                    <label className="flex items-center gap-2 text-[12px] text-slate-300">
                      <input
                        type="checkbox"
                        checked={form.isPrimary}
                        onChange={(e) =>
                          setForm((f) => ({
                            ...f,
                            isPrimary: e.target.checked,
                          }))
                        }
                      />
                      Set as primary for this part
                    </label>
                    <label className="block text-[10px] font-bold text-slate-500 uppercase">
                      Notes
                      <textarea
                        value={form.notes}
                        onChange={(e) =>
                          setForm((f) => ({ ...f, notes: e.target.value }))
                        }
                        rows={2}
                        className="mt-1 w-full rounded-lg bg-black/40 border border-white/10 px-3 py-2 text-sm text-white resize-none"
                      />
                    </label>
                  </div>
                )}

                {modal === "quick" && !showMore && (
                  <button
                    type="button"
                    onClick={() => setShowMore(true)}
                    className="flex items-center gap-1 text-[11px] font-bold text-slate-400"
                  >
                    <ChevronDown className="h-3.5 w-3.5" />
                    More details
                  </button>
                )}
                {modal === "quick" && showMore && (
                  <button
                    type="button"
                    onClick={() => setShowMore(false)}
                    className="flex items-center gap-1 text-[11px] font-bold text-slate-400"
                  >
                    <ChevronUp className="h-3.5 w-3.5" />
                    Fewer details
                  </button>
                )}

                <button
                  type="button"
                  disabled={busy}
                  onClick={() => void saveItem()}
                  className="w-full rounded-full bg-orange-600 py-2.5 text-xs font-bold text-white disabled:opacity-50"
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
  // Skip "Good" replacement badge when condition already shows status
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
  isOwner,
  selected,
  onToggleSelect,
  onLogUse,
  onEdit,
  onMakePrimary,
}: {
  item: EquipmentItemDto;
  isOwner: boolean;
  selected: boolean;
  onToggleSelect: () => void;
  onLogUse: () => void;
  onEdit: () => void;
  onMakePrimary: () => void;
}) {
  return (
    <li
      className={`rounded-xl border px-3 py-2.5 list-none ${
        item.needsAttention
          ? "border-amber-500/25 bg-amber-500/[0.06]"
          : "border-white/5 bg-black/20"
      }`}
    >
      <div className="flex items-start gap-2">
        {isOwner && (
          <input
            type="checkbox"
            checked={selected}
            onChange={onToggleSelect}
            className="mt-1.5 shrink-0"
            aria-label="Select"
          />
        )}
        <div className="min-w-0 flex-1">
          <p className="text-sm font-bold text-white flex items-center gap-1.5 flex-wrap">
            <button
              type="button"
              disabled={!isOwner || item.isPrimary}
              onClick={onMakePrimary}
              title={
                item.isPrimary ? "Primary" : "Make primary"
              }
              className={`shrink-0 ${
                item.isPrimary
                  ? "text-amber-400"
                  : "text-slate-600 hover:text-amber-400"
              }`}
            >
              <Star
                className={`h-3.5 w-3.5 ${
                  item.isPrimary ? "fill-amber-400/50" : ""
                }`}
              />
            </button>
            {displayName(item)}
            <ConditionChip condition={item.condition} />
            <BadgeChip badge={item.badge} label={item.badgeLabel} />
            {item.windRange && (
              <span className="text-[9px] font-bold uppercase text-sky-400/90">
                {item.windRange}
              </span>
            )}
          </p>
          <p className="text-[11px] text-slate-500 mt-0.5">
            {[
              item.category === "sail" && item.model
                ? item.model
                : null,
              item.category === "other" && item.label
                ? item.label
                : null,
              ...item.tags.map((t) =>
                EQUIPMENT_TAGS.find((x) => x.value === t)?.label || t
              ),
              formatUseSummary(item),
            ]
              .filter(Boolean)
              .join(" · ")}
          </p>
          {(item.usageHistory?.length ?? 0) > 0 && (
            <p className="text-[10px] text-slate-500 mt-1">
              Used at:{" "}
              {item
                .usageHistory!.filter((u) => u.regattaName)
                .slice(0, 4)
                .map(
                  (u) =>
                    `${u.regattaName}${
                      u.rank != null ? ` (#${u.rank})` : ""
                    }`
                )
                .join(", ")}
            </p>
          )}
        </div>
        {isOwner && (
          <div className="flex flex-col gap-1 shrink-0">
            {!item.isPrimary && (
              <button
                type="button"
                onClick={onMakePrimary}
                className="text-[10px] font-bold text-amber-400/90"
              >
                Make primary
              </button>
            )}
            <button
              type="button"
              onClick={onLogUse}
              className="text-[10px] font-bold text-sky-400"
            >
              Log session
            </button>
            <button
              type="button"
              onClick={onEdit}
              className="text-[10px] font-bold text-slate-400"
            >
              Edit
            </button>
          </div>
        )}
      </div>
    </li>
  );
}
