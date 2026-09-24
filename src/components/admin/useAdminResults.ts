"use client";

import { useState, type Dispatch, type SetStateAction } from "react";
import { parseApi, apiErr } from "@/components/admin/parseApi";
import { emptyResultForm } from "@/components/admin/adminForms";
import { useFeedback } from "@/components/ui/FeedbackProvider";
import { errorMessage } from "@/lib/errors";
import { regattaDateLabel } from "@/types/regatta";
import type { RegattaAdmin } from "@/types/regatta";
import type { ResultAdmin } from "@/types/result";
import type { SailorAdmin } from "@/types/sailor";

type UseAdminResultsArgs = {
  isSuperadmin: boolean;
  regattaList: RegattaAdmin[];
  sailorList: SailorAdmin[];
  resultsList: ResultAdmin[];
  setResultsList: Dispatch<SetStateAction<ResultAdmin[]>>;
  refreshResultsList: (opts?: { regattaId?: string }) => Promise<void>;
  /** Owned by useAdminData (fetch coupling); threaded through for the editor UI. */
  selectedRegattaIdForResultEdit: string;
  setSelectedRegattaIdForResultEdit: Dispatch<SetStateAction<string>>;
  /** Refetch results caches after mutations. */
  invalidateResults?: () => void;
};

/**
 * Results editor: result form, save/delete, DNS fills.
 * selectedRegattaId is owned by useAdminData and passed in.
 */
export function useAdminResults({
  isSuperadmin,
  regattaList,
  sailorList,
  resultsList,
  setResultsList,
  selectedRegattaIdForResultEdit,
  setSelectedRegattaIdForResultEdit,
  invalidateResults,
}: UseAdminResultsArgs) {
  const { toast, confirm } = useFeedback();
  const [editingResultId, setEditingResultId] = useState<string | null>(null);
  const [resultForm, setResultForm] = useState(emptyResultForm);
  /** Double-submit guard for result save. */
  const [saving, setSaving] = useState(false);

  const handleSaveResult = async () => {
    if (saving) return;
    if (!isSuperadmin) {
      toast.error(
        "Error: 403 Forbidden. Only Superadmins can write to the database."
      );
      return;
    }
    if (!resultForm.sailorId || !resultForm.regattaId) {
      toast.error("Sailor and Regatta must be selected.");
      return;
    }
    const overseas = Boolean(resultForm.isOverseasCommitment);
    const rankNum = Number(resultForm.rank);
    const isDns = overseas
      ? false
      : Boolean(resultForm.isDNS || resultForm.isDns);
    const payload = {
      ...resultForm,
      rank: rankNum,
      isDns,
      isDNS: isDns,
      isOverseasCommitment: overseas,
    };
    setSaving(true);
    try {
      if (editingResultId === "new") {
        const res = await fetch("/api/admin/results", {
          method: "POST",
          headers: { "Content-Type": "application/json" },
          body: JSON.stringify(payload),
        });
        const data = await parseApi(res);
        if (!res.ok) throw new Error(apiErr(data, "Create failed"));
        const row = data.result as ResultAdmin;
        setResultsList((prev) => {
          const without = prev.filter(
            (r) =>
              !(r.sailorId === row.sailorId && r.regattaId === row.regattaId)
          );
          return [...without, row];
        });
        toast.success("Result added successfully!");
      } else {
        const res = await fetch("/api/admin/results", {
          method: "PATCH",
          headers: { "Content-Type": "application/json" },
          body: JSON.stringify({ ...payload, id: editingResultId }),
        });
        const data = await parseApi(res);
        if (!res.ok) throw new Error(apiErr(data, "Update failed"));
        const row = data.result as ResultAdmin;
        setResultsList((prev) =>
          prev.map((r) => (r.id === editingResultId ? row : r))
        );
        toast.success("Result updated successfully!");
      }
      setEditingResultId(null);
      invalidateResults?.();
    } catch (e: unknown) {
      toast.error(errorMessage(e));
    } finally {
      setSaving(false);
    }
  };

  const handleQuickUpdateResult = async (
    id: string,
    patch: {
      rank?: number;
      nettScore?: number | null;
      totalScore?: number | null;
      isDns?: boolean;
      isDNS?: boolean;
      isOverseasCommitment?: boolean;
    }
  ) => {
    if (!isSuperadmin) {
      toast.error(
        "Error: 403 Forbidden. Only Superadmins can write to the database."
      );
      return;
    }
    try {
      const res = await fetch("/api/admin/results", {
        method: "PATCH",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({ ...patch, id }),
      });
      const data = await parseApi(res);
      if (!res.ok) throw new Error(apiErr(data, "Update failed"));
      const row = data.result as ResultAdmin;
      setResultsList((prev) =>
        prev.map((r) => (r.id === id ? { ...r, ...row } : r))
      );
      invalidateResults?.();
      toast.success("Score updated");
    } catch (e: unknown) {
      toast.error(errorMessage(e));
    }
  };



  const handleDeleteResult = async (id: string) => {
    if (!isSuperadmin) {
      toast.error(
        "Error: 403 Forbidden. Only Superadmins can write to the database."
      );
      return;
    }
    if (!id) {
      toast.error("Missing result id — refresh the page and try again.");
      return;
    }
    const row = resultsList.find((r) => r.id === id);
    const sailor = row
      ? sailorList.find((s) => s.id === row.sailorId)
      : undefined;
    const reg = row
      ? regattaList.find((r) => r.id === row.regattaId)
      : undefined;
    const sailorLabel = sailor
      ? `${sailor.name} · ${sailor.sailNumber || "—"}`
      : row?.sailorId || "Unknown sailor";
    const regLabel = reg
      ? `${reg.name} (${regattaDateLabel(reg.date)})`
      : row?.regattaId || "Unknown regatta";
    const ok = await confirm({
      title: "Delete this result?",
      message:
        `${sailorLabel}\n${regLabel}\n` +
        `Rank: ${row?.rank ?? "—"}\n` +
        `${row?.isOverseasCommitment ? "Status: Overseas\n" : row?.isDns || row?.isDNS ? "Status: DNS\n" : ""}` +
        `\nThis removes only this score row. It cannot be undone.`,
      confirmLabel: "Delete result",
      tone: "danger",
    });
    if (!ok) return;
    try {
      const res = await fetch(
        `/api/admin/results?id=${encodeURIComponent(id)}`,
        { method: "DELETE" }
      );
      const data = await parseApi(res);
      if (!res.ok) throw new Error(apiErr(data, "Delete failed"));
      setResultsList((prev) => prev.filter((r) => r.id !== id));
      toast.success("Result deleted.");
      invalidateResults?.();
    } catch (e: unknown) {
      toast.error(errorMessage(e));
    }
  };

  const panelProps = {
    selectedRegattaIdForResultEdit,
    setSelectedRegattaIdForResultEdit,
    editingResultId,
    setEditingResultId,
    resultForm,
    setResultForm,
    saving,
    handleSaveResult,
    handleQuickUpdateResult,
    handleDeleteResult,
  };

  return {
    panelProps,
    selectedRegattaIdForResultEdit,
    setSelectedRegattaIdForResultEdit,
    editingResultId,
    setEditingResultId,
    resultForm,
    setResultForm,
    saving,
    handleSaveResult,
    handleQuickUpdateResult,
    handleDeleteResult,
  };
}
