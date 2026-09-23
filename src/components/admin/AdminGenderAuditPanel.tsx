"use client";

import { useMemo, useState } from "react";
import {
  buildGenderAuditRows,
  formatGenderLabel,
  type GenderAuditRow,
} from "@/lib/gender";
import type { SailorAdmin } from "@/types/sailor";
import { Loader2, Users } from "lucide-react";
import { useFeedback } from "@/components/ui/FeedbackProvider";

type Props = {
  sailors: SailorAdmin[];
  onSailorsChange?: (sailors: SailorAdmin[]) => void;
};

type Filter = "needs_review" | "unknown" | "conflict" | "all" | "M" | "F";

export function AdminGenderAuditPanel({ sailors, onSailorsChange }: Props) {
  const { toast, confirm } = useFeedback();
  const [filter, setFilter] = useState<Filter>("needs_review");
  const [q, setQ] = useState("");
  const [busyId, setBusyId] = useState<string | null>(null);
  const [bulkBusy, setBulkBusy] = useState(false);
  const [open, setOpen] = useState(true);

  const rows = useMemo(() => buildGenderAuditRows(sailors), [sailors]);

  const counts = useMemo(() => {
    let unknown = 0;
    let conflict = 0;
    let m = 0;
    let f = 0;
    for (const r of rows) {
      if (r.gender == null) unknown++;
      else if (r.gender === "M") m++;
      else if (r.gender === "F") f++;
      if (r.conflict) conflict++;
    }
    return { unknown, conflict, m, f, needs: unknown + conflict };
  }, [rows]);

  const visible = useMemo(() => {
    const qq = q.trim().toLowerCase();
    return rows.filter((r) => {
      if (filter === "needs_review" && !(r.gender == null || r.conflict)) {
        return false;
      }
      if (filter === "unknown" && r.gender != null) return false;
      if (filter === "conflict" && !r.conflict) return false;
      if (filter === "M" && r.gender !== "M") return false;
      if (filter === "F" && r.gender !== "F") return false;
      if (!qq) return true;
      return (
        r.name.toLowerCase().includes(qq) ||
        (r.handle || "").toLowerCase().includes(qq) ||
        (r.club || "").toLowerCase().includes(qq) ||
        (r.sailNumber || "").toLowerCase().includes(qq)
      );
    });
  }, [rows, filter, q]);

  const applyUpdates = async (
    updates: { sailorId: string; gender: "M" | "F" | null }[]
  ) => {
    if (updates.length === 0) return;
    const res = await fetch("/api/admin/sailors", {
      method: "POST",
      headers: { "Content-Type": "application/json" },
      credentials: "include",
      body: JSON.stringify({ action: "setSailorGenders", updates }),
    });
    const data = await res.json();
    if (!res.ok) throw new Error(data.error || "Update failed");
    if (onSailorsChange) {
      const listRes = await fetch("/api/admin/sailors?all=1", {
        credentials: "include",
      });
      const listData = await listRes.json();
      if (listRes.ok && Array.isArray(listData.sailors)) {
        onSailorsChange(listData.sailors);
      } else {
        // Optimistic local merge
        const byId = new Map(updates.map((u) => [u.sailorId, u.gender]));
        onSailorsChange(
          sailors.map((s) =>
            byId.has(s.id) ? { ...s, gender: byId.get(s.id) ?? null } : s
          )
        );
      }
    }
    toast.success(data.message || `Updated ${updates.length}`);
  };

  const setOne = async (row: GenderAuditRow, gender: "M" | "F" | null) => {
    setBusyId(row.id);
    try {
      await applyUpdates([{ sailorId: row.id, gender }]);
    } catch (e) {
      toast.error(e instanceof Error ? e.message : "Update failed");
    } finally {
      setBusyId(null);
    }
  };

  const applyAllSuggestions = async () => {
    const targets = visible.filter(
      (r) => r.suggested && (r.gender == null || r.conflict)
    );
    if (targets.length === 0) {
      toast.error("No name suggestions in the current filter.");
      return;
    }
    const ok = await confirm({
      title: `Apply ${targets.length} name-based gender suggestion(s)?`,
      message:
        "Only rows with a clear given-name hint are included. Review afterwards — hints can be wrong.",
      confirmLabel: "Apply suggestions",
      tone: "danger",
    });
    if (!ok) return;
    setBulkBusy(true);
    try {
      await applyUpdates(
        targets.map((r) => ({
          sailorId: r.id,
          gender: r.suggested!,
        }))
      );
    } catch (e) {
      toast.error(e instanceof Error ? e.message : "Bulk update failed");
    } finally {
      setBulkBusy(false);
    }
  };

  const normalizeCodes = async () => {
    setBulkBusy(true);
    try {
      const res = await fetch("/api/admin/sailors", {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        credentials: "include",
        body: JSON.stringify({ action: "normalizeSailorGenders" }),
      });
      const data = await res.json();
      if (!res.ok) throw new Error(data.error || "Normalize failed");
      toast.success(data.message || "Normalized");
      if (onSailorsChange) {
        const listRes = await fetch("/api/admin/sailors?all=1", {
          credentials: "include",
        });
        const listData = await listRes.json();
        if (listRes.ok && Array.isArray(listData.sailors)) {
          onSailorsChange(listData.sailors);
        }
      }
    } catch (e) {
      toast.error(e instanceof Error ? e.message : "Normalize failed");
    } finally {
      setBulkBusy(false);
    }
  };

  return (
    <section className="rounded-2xl border border-[var(--sp-cool-veil)] bg-[var(--sp-warm-white)] p-4 sm:p-5 space-y-3 shadow-xs">
      <div className="flex flex-wrap items-start justify-between gap-3">
        <div className="min-w-0">
          <p className="text-[12px] font-bold uppercase tracking-wider text-[var(--sp-harbour-teal)] flex items-center gap-1.5">
            <Users className="h-3.5 w-3.5" />
            Gender audit
          </p>
          <p className="mt-1 text-[12px] text-[var(--sp-charcoal)] leading-relaxed">
            {counts.needs} need review ({counts.conflict} name conflicts,{" "}
            {counts.unknown} unknown) · stored {counts.m} M / {counts.f} F
          </p>
        </div>
        <button
          type="button"
          onClick={() => setOpen((o) => !o)}
          className="text-[11px] font-semibold text-[var(--sp-harbour-teal)] hover:text-[var(--sp-harbour-shadow)]"
        >
          {open ? "Collapse" : "Expand"}
        </button>
      </div>

      {open && (
        <>
          <div className="flex flex-wrap gap-2 items-center">
            {(
              [
                ["needs_review", "Needs review"],
                ["conflict", "Conflicts"],
                ["unknown", "Unknown"],
                ["F", "Female"],
                ["M", "Male"],
                ["all", "All"],
              ] as const
            ).map(([id, label]) => (
              <button
                key={id}
                type="button"
                onClick={() => setFilter(id)}
                className={`rounded-full px-2.5 py-1 text-[13px] font-bold ${
                  filter === id
                    ? "bg-[var(--sp-harbour-teal)] text-white"
                    : "border border-[var(--sp-cool-veil)] bg-[var(--sp-sailcloth)] text-[var(--sp-charcoal)] hover:border-[var(--sp-harbour-teal)]"
                }`}
              >
                {label}
              </button>
            ))}
            <input
              value={q}
              onChange={(e) => setQ(e.target.value)}
              placeholder="Search name / club / sail…"
              className="ml-auto min-w-[10rem] flex-1 rounded-lg border border-[var(--sp-cool-veil)] bg-[var(--sp-sailcloth)] px-2.5 py-1.5 text-[12px] text-[var(--sp-charcoal)] placeholder:text-[var(--sp-slate-soft)]"
            />
          </div>

          <div className="flex flex-wrap gap-2">
            <button
              type="button"
              disabled={bulkBusy}
              onClick={() => void applyAllSuggestions()}
              className="rounded-lg bg-[var(--sp-harbour-teal)] px-3 py-1.5 text-[15px] font-bold text-white hover:bg-[var(--sp-harbour-shadow)] disabled:opacity-50"
            >
              {bulkBusy ? (
                <Loader2 className="h-3.5 w-3.5 animate-spin inline" />
              ) : (
                "Apply name suggestions (filtered)"
              )}
            </button>
            <button
              type="button"
              disabled={bulkBusy}
              onClick={() => void normalizeCodes()}
              className="rounded-lg border border-[var(--sp-harbour-teal)] bg-[var(--sp-warm-white)] px-3 py-1.5 text-[15px] font-semibold text-[var(--sp-harbour-teal)] hover:bg-[var(--sp-aqua-mist)] disabled:opacity-50"
            >
              Normalize Male/Female → M/F
            </button>
          </div>

          <div className="max-h-[28rem] overflow-auto rounded-xl border border-[var(--sp-cool-veil)] bg-[var(--sp-sailcloth)]">
            <table className="w-full text-left text-[12px]">
              <thead className="sticky top-0 bg-[var(--sp-sailcloth)] text-[12px] uppercase tracking-wide text-[var(--sp-charcoal)]">
                <tr>
                  <th className="px-3 py-2 font-bold">Sailor</th>
                  <th className="px-3 py-2 font-bold">Stored</th>
                  <th className="px-3 py-2 font-bold">Hint</th>
                  <th className="px-3 py-2 font-bold text-right">Set</th>
                </tr>
              </thead>
              <tbody className="divide-y divide-[var(--sp-cool-veil)]">
                {visible.slice(0, 200).map((r) => (
                  <tr key={r.id} className="hover:bg-[var(--sp-aqua-mist)]">
                    <td className="px-3 py-2 min-w-0">
                      <p className="font-semibold text-[var(--sp-charcoal)] truncate">
                        {r.name}
                      </p>
                      <p className="text-[13px] text-[var(--sp-slate-soft)] truncate">
                        {[r.sailNumber, r.club, r.handle]
                          .filter(Boolean)
                          .join(" · ")}
                      </p>
                    </td>
                    <td className="px-3 py-2">
                      <span
                        className={`font-bold ${
                          r.gender === "F"
                            ? "text-[var(--sp-error)]"
                            : r.gender === "M"
                              ? "text-[var(--sp-harbour-teal)]"
                              : "text-[var(--sp-slate-soft)]"
                        }`}
                      >
                        {formatGenderLabel(r.gender)}
                      </span>
                    </td>
                    <td className="px-3 py-2">
                      {r.suggested ? (
                        <span
                          className={`text-[13px] font-semibold ${
                            r.conflict
                              ? "text-[var(--sp-racing-deep)]"
                              : "text-[var(--sp-harbour-teal)]"
                          }`}
                        >
                          {r.suggested}
                          {r.conflict ? " ≠ stored" : ""}
                        </span>
                      ) : (
                        <span className="text-[var(--sp-slate-soft)]">—</span>
                      )}
                    </td>
                    <td className="px-3 py-2 text-right whitespace-nowrap">
                      {busyId === r.id ? (
                        <Loader2 className="h-3.5 w-3.5 animate-spin inline text-[var(--sp-slate-soft)]" />
                      ) : (
                        <span className="inline-flex gap-1">
                          <button
                            type="button"
                            onClick={() => void setOne(r, "F")}
                            className="rounded-md border border-[var(--sp-error)] bg-[var(--sp-warm-white)] px-2 py-0.5 text-[15px] font-bold text-[var(--sp-error)] hover:bg-[var(--sp-racing-mist)]"
                          >
                            F
                          </button>
                          <button
                            type="button"
                            onClick={() => void setOne(r, "M")}
                            className="rounded-md border border-[var(--sp-harbour-teal)] bg-[var(--sp-warm-white)] px-2 py-0.5 text-[15px] font-bold text-[var(--sp-harbour-teal)] hover:bg-[var(--sp-aqua-mist)]"
                          >
                            M
                          </button>
                          <button
                            type="button"
                            onClick={() => void setOne(r, null)}
                            className="rounded-md border border-[var(--sp-cool-veil)] bg-[var(--sp-warm-white)] px-2 py-0.5 text-[15px] font-bold text-[var(--sp-charcoal)] hover:border-[var(--sp-charcoal)]"
                          >
                            Clear
                          </button>
                        </span>
                      )}
                    </td>
                  </tr>
                ))}
                {visible.length === 0 && (
                  <tr>
                    <td
                      colSpan={4}
                      className="px-3 py-8 text-center text-[var(--sp-charcoal)]"
                    >
                      No sailors in this filter.
                    </td>
                  </tr>
                )}
              </tbody>
            </table>
            {visible.length > 200 && (
              <p className="px-3 py-2 text-[13px] text-[var(--sp-slate-soft)]">
                Showing first 200 of {visible.length}. Refine search/filter.
              </p>
            )}
          </div>
        </>
      )}
    </section>
  );
}
