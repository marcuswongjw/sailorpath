"use client";

import { useCallback, useEffect, useMemo, useState } from "react";
import {
  AlertTriangle,
  Plus,
  Settings,
  Star,
  Wrench,
  X,
} from "lucide-react";
import {
  BRAND_PRESETS,
  EQUIPMENT_CATEGORIES,
  EQUIPMENT_TAGS,
  categoryLabel,
  displayName,
  groupEquipmentItems,
  type EquipmentBoatClass,
  type EquipmentCategory,
  type EquipmentCondition,
  type EquipmentItemDto,
  type EquipmentStatus,
  type EquipmentTag,
} from "@/lib/equipment";

type Props = {
  sailorId: string;
  isOwner: boolean;
  canSeeEquipment: boolean;
  /** Dual-class already (ILCA sail # / results / national list) */
  mayHaveIlca: boolean;
  regattaOptions?: { id: string; name: string; date: string }[];
  cardClass?: string;
};

const emptyForm = {
  boatClass: "optimist" as EquipmentBoatClass,
  category: "sail" as EquipmentCategory,
  brand: "",
  model: "",
  label: "",
  status: "active" as EquipmentStatus,
  condition: "good" as EquipmentCondition,
  isPrimary: true,
  tags: ["racing"] as EquipmentTag[],
  acquiredOn: "",
  notes: "",
};

export function EquipmentInventory({
  sailorId,
  isOwner,
  canSeeEquipment,
  mayHaveIlca,
  regattaOptions = [],
  cardClass = "rounded-2xl border border-white/5 bg-[#131520]/80",
}: Props) {
  const [items, setItems] = useState<EquipmentItemDto[]>([]);
  const [alerts, setAlerts] = useState<EquipmentItemDto[]>([]);
  const [loading, setLoading] = useState(true);
  const [isPrivate, setIsPrivate] = useState(false);
  const [classTab, setClassTab] = useState<EquipmentBoatClass>("optimist");
  const [ilcaUnlocked, setIlcaUnlocked] = useState(false);
  const [modal, setModal] = useState<"add" | "edit" | "use" | null>(null);
  const [editing, setEditing] = useState<EquipmentItemDto | null>(null);
  const [form, setForm] = useState(emptyForm);
  const [useItemIds, setUseItemIds] = useState<string[]>([]);
  const [useDate, setUseDate] = useState("");
  const [useRegattaId, setUseRegattaId] = useState("");
  const [busy, setBusy] = useState(false);
  const [msg, setMsg] = useState<string | null>(null);

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
      if (
        mayHaveIlca ||
        list.some((i) => i.boatClass === "ilca4")
      ) {
        setIlcaUnlocked(true);
      }
    } catch {
      setItems([]);
    } finally {
      setLoading(false);
    }
  }, [sailorId, mayHaveIlca]);

  useEffect(() => {
    void load();
  }, [load]);

  const showIlcaTab = ilcaUnlocked || mayHaveIlca;
  const classItems = useMemo(
    () => items.filter((i) => i.boatClass === classTab),
    [items, classTab]
  );
  const groups = useMemo(
    () => groupEquipmentItems(classItems.filter((i) => i.status !== "retired")),
    [classItems]
  );
  const retired = classItems.filter((i) => i.status === "retired");
  const classAlerts = alerts.filter((a) => a.boatClass === classTab);

  const openAdd = (cat?: EquipmentCategory) => {
    setEditing(null);
    setForm({
      ...emptyForm,
      boatClass: classTab,
      category: cat || "sail",
      isPrimary: !classItems.some(
        (i) => i.category === (cat || "sail") && i.isPrimary
      ),
    });
    setModal("add");
  };

  const openEdit = (item: EquipmentItemDto) => {
    setEditing(item);
    setForm({
      boatClass: item.boatClass,
      category: item.category,
      brand: item.brand || "",
      model: item.model || "",
      label: item.label || "",
      status: item.status,
      condition: item.condition,
      isPrimary: item.isPrimary,
      tags: item.tags || [],
      acquiredOn: item.acquiredOn || "",
      notes: item.notes || "",
    });
    setModal("edit");
  };

  const openLogUse = (item?: EquipmentItemDto) => {
    const active = classItems.filter((i) => i.status === "active");
    setUseItemIds(
      item ? [item.id] : active.filter((i) => i.isPrimary).map((i) => i.id)
    );
    setUseDate(new Date().toISOString().slice(0, 10));
    setUseRegattaId("");
    setModal("use");
  };

  const saveItem = async () => {
    setBusy(true);
    setMsg(null);
    try {
      const payload = {
        sailorId,
        boatClass: form.boatClass,
        category: form.category,
        brand: form.brand || null,
        model: form.model || null,
        label: form.label || null,
        status: form.status,
        condition: form.condition,
        isPrimary: form.isPrimary,
        tags: form.tags,
        acquiredOn: form.acquiredOn || null,
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
      await load();
    } catch (e) {
      setMsg(e instanceof Error ? e.message : "Error");
    } finally {
      setBusy(false);
    }
  };

  const logUses = async () => {
    if (!useItemIds.length) return;
    setBusy(true);
    setMsg(null);
    try {
      for (const id of useItemIds) {
        const res = await fetch("/api/account/equipment", {
          method: "PATCH",
          credentials: "include",
          headers: { "Content-Type": "application/json" },
          body: JSON.stringify({
            id,
            logUse: true,
            usedOn: useDate || undefined,
            regattaId: useRegattaId || undefined,
          }),
        });
        const data = await res.json();
        if (!res.ok) throw new Error(data.error || "Log failed");
      }
      setModal(null);
      await load();
    } catch (e) {
      setMsg(e instanceof Error ? e.message : "Error");
    } finally {
      setBusy(false);
    }
  };

  const retireItem = async (item: EquipmentItemDto) => {
    if (!confirm(`Retire “${displayName(item)}”?`)) return;
    setBusy(true);
    try {
      await fetch("/api/account/equipment", {
        method: "PATCH",
        credentials: "include",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({ id: item.id, status: "retired" }),
      });
      await load();
    } finally {
      setBusy(false);
    }
  };

  const deleteItem = async (item: EquipmentItemDto) => {
    if (!confirm(`Delete “${displayName(item)}” permanently?`)) return;
    setBusy(true);
    try {
      await fetch(
        `/api/account/equipment?id=${encodeURIComponent(item.id)}`,
        { method: "DELETE", credentials: "include" }
      );
      setModal(null);
      await load();
    } finally {
      setBusy(false);
    }
  };

  const toggleTag = (t: EquipmentTag) => {
    setForm((f) => ({
      ...f,
      tags: f.tags.includes(t)
        ? f.tags.filter((x) => x !== t)
        : [...f.tags, t],
    }));
  };

  const brandHints = BRAND_PRESETS[form.category] || [];

  if (loading) {
    return (
      <section className={`${cardClass} p-5`}>
        <p className="text-xs text-slate-500">Loading equipment…</p>
      </section>
    );
  }

  if (isPrivate || !canSeeEquipment) {
    return (
      <section className={`${cardClass} p-5`}>
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
    <section className={`${cardClass} p-5 space-y-4`}>
      <div className="flex items-start justify-between gap-2 flex-wrap">
        <div>
          <div className="flex items-center gap-2 mb-1">
            <Settings className="h-3.5 w-3.5 text-orange-400/90" />
            <h2 className="text-[11px] font-medium uppercase tracking-[0.14em] text-neutral-500">
              Equipment
            </h2>
          </div>
          <p className="text-[11px] text-neutral-500">
            Inventory, tags &amp; usage — flag when gear may need replacing
          </p>
        </div>
        {isOwner && (
          <div className="flex flex-wrap gap-2">
            <button
              type="button"
              onClick={() => openLogUse()}
              disabled={!classItems.some((i) => i.status === "active")}
              className="rounded-full border border-white/10 bg-white/5 px-3 py-1.5 text-[10px] font-bold text-white disabled:opacity-40"
            >
              Log use
            </button>
            <button
              type="button"
              onClick={() => openAdd()}
              className="rounded-full bg-orange-600 px-3 py-1.5 text-[10px] font-bold text-white inline-flex items-center gap-1"
            >
              <Plus className="h-3 w-3" />
              Add
            </button>
          </div>
        )}
      </div>

      {/* Class tabs */}
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
            {classAlerts.length} item
            {classAlerts.length === 1 ? "" : "s"} may need attention
          </p>
          {classAlerts.slice(0, 3).map((a) => (
            <p key={a.id} className="text-[11px] text-amber-100/90">
              {displayName(a)} — {a.attentionReason}
            </p>
          ))}
          <p className="text-[10px] text-amber-200/60">
            Advisory only — based on uses, age, and condition you set.
          </p>
        </div>
      )}

      {groups.length === 0 ? (
        <div className="py-8 text-center space-y-2">
          <Wrench className="h-7 w-7 text-slate-600 mx-auto" />
          <p className="text-xs text-slate-500">
            {classTab === "ilca4"
              ? isOwner
                ? "No ILCA 4 gear yet — add your first hull, sail, or foils."
                : "No ILCA 4 equipment logged."
              : isOwner
                ? "Add your race sail, foils, and spars to track wear."
                : "No equipment shared yet."}
          </p>
          {isOwner && (
            <button
              type="button"
              onClick={() => openAdd("sail")}
              className="text-[11px] font-bold text-orange-400"
            >
              + Add equipment
            </button>
          )}
        </div>
      ) : (
        <div className="space-y-4">
          {groups.map((g) => (
            <div key={g.category}>
              <div className="flex items-center justify-between mb-1.5">
                <p className="text-[10px] font-bold uppercase tracking-wider text-slate-500">
                  {g.label}
                </p>
                {isOwner && (
                  <button
                    type="button"
                    onClick={() => openAdd(g.category)}
                    className="text-[10px] font-bold text-orange-400/90"
                  >
                    + Add
                  </button>
                )}
              </div>
              <ul className="space-y-2">
                {g.items.map((item) => (
                  <li
                    key={item.id}
                    className={`rounded-xl border px-3 py-2.5 ${
                      item.needsAttention
                        ? "border-amber-500/25 bg-amber-500/[0.06]"
                        : "border-white/5 bg-black/20"
                    }`}
                  >
                    <div className="flex items-start justify-between gap-2">
                      <div className="min-w-0">
                        <p className="text-sm font-bold text-white flex items-center gap-1.5 flex-wrap">
                          {item.isPrimary && (
                            <Star className="h-3.5 w-3.5 text-amber-400 shrink-0 fill-amber-400/40" />
                          )}
                          {displayName(item)}
                          {item.status === "backup" && (
                            <span className="text-[9px] font-bold uppercase text-slate-500">
                              backup
                            </span>
                          )}
                        </p>
                        <p className="text-[11px] text-slate-500 mt-0.5">
                          {[
                            item.brand && item.label ? item.brand : null,
                            item.model,
                            ...item.tags.map((t) =>
                              t.replace(/_/g, " ")
                            ),
                            item.condition.replace(/_/g, " "),
                            `${item.useCount} use${item.useCount === 1 ? "" : "s"}`,
                          ]
                            .filter(Boolean)
                            .join(" · ")}
                        </p>
                        {item.lastUsedOn && (
                          <p className="text-[10px] text-slate-600 mt-0.5">
                            Last used {item.lastUsedOn}
                          </p>
                        )}
                        {item.needsAttention && item.attentionReason && (
                          <p className="text-[10px] text-amber-300/90 mt-1">
                            {item.attentionReason}
                          </p>
                        )}
                      </div>
                      {isOwner && (
                        <div className="flex flex-col gap-1 shrink-0">
                          <button
                            type="button"
                            onClick={() => openLogUse(item)}
                            className="text-[10px] font-bold text-sky-400"
                          >
                            Log use
                          </button>
                          <button
                            type="button"
                            onClick={() => openEdit(item)}
                            className="text-[10px] font-bold text-slate-400"
                          >
                            Edit
                          </button>
                        </div>
                      )}
                    </div>
                  </li>
                ))}
              </ul>
            </div>
          ))}
        </div>
      )}

      {retired.length > 0 && isOwner && (
        <details className="text-[11px] text-slate-500">
          <summary className="cursor-pointer font-semibold">
            Retired ({retired.length})
          </summary>
          <ul className="mt-2 space-y-1">
            {retired.map((r) => (
              <li key={r.id}>
                {displayName(r)} · {categoryLabel(r.category)}
              </li>
            ))}
          </ul>
        </details>
      )}

      {/* Modal */}
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
                  ? "Log equipment use"
                  : modal === "edit"
                    ? "Edit equipment"
                    : "Add equipment"}
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

            {modal === "use" ? (
              <>
                <p className="text-[11px] text-slate-500">
                  Select gear used at an event or training day.
                </p>
                <ul className="space-y-1.5 max-h-48 overflow-y-auto">
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
                <label className="block text-[10px] font-bold text-slate-500 uppercase">
                  Date
                  <input
                    type="date"
                    value={useDate}
                    onChange={(e) => setUseDate(e.target.value)}
                    className="mt-1 w-full rounded-lg bg-black/40 border border-white/10 px-3 py-2 text-sm text-white"
                  />
                </label>
                {regattaOptions.length > 0 && (
                  <label className="block text-[10px] font-bold text-slate-500 uppercase">
                    Link regatta (optional)
                    <select
                      value={useRegattaId}
                      onChange={(e) => setUseRegattaId(e.target.value)}
                      className="mt-1 w-full rounded-lg bg-black/40 border border-white/10 px-3 py-2 text-sm text-white"
                    >
                      <option value="">—</option>
                      {regattaOptions.map((r) => (
                        <option key={r.id} value={r.id}>
                          {r.date} · {r.name}
                        </option>
                      ))}
                    </select>
                  </label>
                )}
                <button
                  type="button"
                  disabled={busy || !useItemIds.length}
                  onClick={() => void logUses()}
                  className="w-full rounded-full bg-sky-600 py-2.5 text-xs font-bold text-white disabled:opacity-50"
                >
                  {busy ? "Saving…" : "Save use"}
                </button>
              </>
            ) : (
              <>
                <div className="grid grid-cols-2 gap-2">
                  <label className="block text-[10px] font-bold text-slate-500 uppercase">
                    Class
                    <select
                      value={form.boatClass}
                      onChange={(e) =>
                        setForm((f) => ({
                          ...f,
                          boatClass: e.target.value as EquipmentBoatClass,
                        }))
                      }
                      className="mt-1 w-full rounded-lg bg-black/40 border border-white/10 px-2 py-2 text-sm text-white"
                    >
                      <option value="optimist">Optimist</option>
                      <option value="ilca4">ILCA 4</option>
                    </select>
                  </label>
                  <label className="block text-[10px] font-bold text-slate-500 uppercase">
                    Category
                    <select
                      value={form.category}
                      onChange={(e) =>
                        setForm((f) => ({
                          ...f,
                          category: e.target.value as EquipmentCategory,
                        }))
                      }
                      className="mt-1 w-full rounded-lg bg-black/40 border border-white/10 px-2 py-2 text-sm text-white"
                    >
                      {EQUIPMENT_CATEGORIES.map((c) => (
                        <option key={c.value} value={c.value}>
                          {c.label}
                        </option>
                      ))}
                    </select>
                  </label>
                </div>
                <label className="block text-[10px] font-bold text-slate-500 uppercase">
                  Brand
                  <input
                    list={`brands-${form.category}`}
                    value={form.brand}
                    onChange={(e) =>
                      setForm((f) => ({ ...f, brand: e.target.value }))
                    }
                    className="mt-1 w-full rounded-lg bg-black/40 border border-white/10 px-3 py-2 text-sm text-white"
                    placeholder="e.g. North"
                  />
                  <datalist id={`brands-${form.category}`}>
                    {brandHints.map((b) => (
                      <option key={b} value={b} />
                    ))}
                  </datalist>
                </label>
                <label className="block text-[10px] font-bold text-slate-500 uppercase">
                  Model / size
                  <input
                    value={form.model}
                    onChange={(e) =>
                      setForm((f) => ({ ...f, model: e.target.value }))
                    }
                    className="mt-1 w-full rounded-lg bg-black/40 border border-white/10 px-3 py-2 text-sm text-white"
                  />
                </label>
                <label className="block text-[10px] font-bold text-slate-500 uppercase">
                  Nickname
                  <input
                    value={form.label}
                    onChange={(e) =>
                      setForm((f) => ({ ...f, label: e.target.value }))
                    }
                    placeholder="Race sail"
                    className="mt-1 w-full rounded-lg bg-black/40 border border-white/10 px-3 py-2 text-sm text-white"
                  />
                </label>
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
                      <option value="retired">Retired</option>
                    </select>
                  </label>
                  <label className="block text-[10px] font-bold text-slate-500 uppercase">
                    Condition
                    <select
                      value={form.condition}
                      onChange={(e) =>
                        setForm((f) => ({
                          ...f,
                          condition: e.target.value as EquipmentCondition,
                        }))
                      }
                      className="mt-1 w-full rounded-lg bg-black/40 border border-white/10 px-2 py-2 text-sm text-white"
                    >
                      <option value="new">New</option>
                      <option value="good">Good</option>
                      <option value="fair">Fair</option>
                      <option value="worn">Worn</option>
                      <option value="replace_soon">Replace soon</option>
                    </select>
                  </label>
                </div>
                <label className="block text-[10px] font-bold text-slate-500 uppercase">
                  Acquired
                  <input
                    type="date"
                    value={form.acquiredOn}
                    onChange={(e) =>
                      setForm((f) => ({ ...f, acquiredOn: e.target.value }))
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
                      setForm((f) => ({ ...f, isPrimary: e.target.checked }))
                    }
                  />
                  Set as primary for this category
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
                <button
                  type="button"
                  disabled={busy}
                  onClick={() => void saveItem()}
                  className="w-full rounded-full bg-orange-600 py-2.5 text-xs font-bold text-white disabled:opacity-50"
                >
                  {busy ? "Saving…" : editing ? "Save changes" : "Add item"}
                </button>
                {editing && (
                  <div className="flex gap-2">
                    <button
                      type="button"
                      disabled={busy}
                      onClick={() => void retireItem(editing)}
                      className="flex-1 rounded-full border border-white/10 py-2 text-[11px] font-bold text-slate-300"
                    >
                      Retire
                    </button>
                    <button
                      type="button"
                      disabled={busy}
                      onClick={() => void deleteItem(editing)}
                      className="flex-1 rounded-full border border-rose-500/30 py-2 text-[11px] font-bold text-rose-300"
                    >
                      Delete
                    </button>
                  </div>
                )}
              </>
            )}
          </div>
        </div>
      )}
    </section>
  );
}
