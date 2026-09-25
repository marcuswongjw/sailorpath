"use client";

import { useState, useMemo, type Dispatch, type SetStateAction } from "react";
import { parseApi, apiErr } from "@/components/admin/parseApi";
import { emptyRegattaForm } from "@/components/admin/adminForms";
import { useFeedback } from "@/components/ui/FeedbackProvider";
import { errorMessage } from "@/lib/errors";
import { cascadeLine } from "@/lib/confirmCopy";
import { regattaMatchesAdminClass } from "@/lib/admin/regattaClass";
import type { RegattaAdmin } from "@/types/regatta";
import { regattaDateLabel } from "@/types/regatta";
import type { ResultAdmin } from "@/types/result";

type UseAdminRegattasArgs = {
  isSuperadmin: boolean;
  regattaList: RegattaAdmin[];
  setRegattaList: Dispatch<SetStateAction<RegattaAdmin[]>>;
  resultsList: ResultAdmin[];
  setResultsList: Dispatch<SetStateAction<ResultAdmin[]>>;
  selectedRegattaIdForResultEdit: string;
  setSelectedRegattaIdForResultEdit: Dispatch<SetStateAction<string>>;
  /** Refetch regattas (and results when deletes cascade) from the server. */
  invalidateRegattas?: () => void;
  invalidateResults?: () => void;
};

/**
 * Regattas Database sub-tab: filters, form, CRUD (+ cascade results on delete).
 */
export function useAdminRegattas({
  isSuperadmin,
  regattaList,
  setRegattaList,
  resultsList,
  setResultsList,
  selectedRegattaIdForResultEdit,
  setSelectedRegattaIdForResultEdit,
  invalidateRegattas,
  invalidateResults,
}: UseAdminRegattasArgs) {
  const { toast, confirm } = useFeedback();
  const [regattaSearch, setRegattaSearch] = useState("");
  const [regattaDivisionFilter, setRegattaDivisionFilter] =
    useState<string>("all");
  /** all | optimist | ilca | wingfoil */
  const [regattaClassFilter, setRegattaClassFilter] = useState<string>("all");
  /** all | series | nonranking */
  const [regattaRankingFilter, setRegattaRankingFilter] =
    useState<string>("all");
  const [editingRegattaId, setEditingRegattaId] = useState<string | null>(null);
  const [regattaForm, setRegattaForm] = useState(emptyRegattaForm);
  /** Double-submit guard for regatta save. */
  const [saving, setSaving] = useState(false);

  const filteredRegattaList = useMemo(() => {
    const q = regattaSearch.trim().toLowerCase();
    return [...(regattaList || [])]
      .filter((r) => {
        if (
          !regattaMatchesAdminClass({
            boatClass: r.boatClass,
            division: r.division,
            family: regattaClassFilter,
            fleet: regattaDivisionFilter,
          })
        ) {
          return false;
        }
        const isNon = r.countsForRanking === false;
        if (regattaRankingFilter === "series" && isNon) return false;
        if (regattaRankingFilter === "nonranking" && !isNon) return false;
        if (!q) return true;
        const hay =
          `${r.name || ""} ${r.date || ""} ${r.division || ""} ${r.boatClass || ""} ${r.slug || ""}`.toLowerCase();
        return hay.includes(q);
      })
      .sort((a, b) => String(b.date || "").localeCompare(String(a.date || "")));
  }, [
    regattaList,
    regattaSearch,
    regattaDivisionFilter,
    regattaClassFilter,
    regattaRankingFilter,
  ]);

  const suggestionCount = useMemo(
    () =>
      (regattaList || []).filter(
        (r) => r.countsForRanking === false && !r.reviewedAt
      ).length,
    [regattaList]
  );

  const handleSaveRegatta = async () => {
    if (saving) return;
    if (!isSuperadmin) {
      toast.error(
        "Error: 403 Forbidden. Only Superadmins can write to the database."
      );
      return;
    }
    if (!regattaForm.name || !regattaForm.date) {
      toast.error("Regatta Name and Date are required.");
      return;
    }
    setSaving(true);
    try {
      if (editingRegattaId === "new") {
        const res = await fetch("/api/admin/regattas", {
          method: "POST",
          headers: { "Content-Type": "application/json" },
          body: JSON.stringify(regattaForm),
        });
        const data = await parseApi(res);
        if (!res.ok) throw new Error(apiErr(data, "Create failed"));
        const regatta = data.regatta as RegattaAdmin;
        setRegattaList((prev) => [...prev, regatta]);
        setEditingRegattaId(regatta.id);
        setRegattaForm({
          id: regatta.id,
          name: regatta.name || "",
          date: String(regatta.date || "").slice(0, 10),
          slug: regatta.slug,
          division: regatta.division || "",
          raceCount: regatta.raceCount != null ? String(regatta.raceCount) : "",
          totalFleetSize:
            regatta.totalFleetSize != null ? String(regatta.totalFleetSize) : "",
          geography: regatta.geography || "SGP",
          boatClass: regatta.boatClass || "Optimist",
          countsForRanking: regatta.countsForRanking !== false,
          endDate: regatta.endDate ? String(regatta.endDate).slice(0, 10) : "",
          venue: regatta.venue || "",
          organizer: regatta.organizer || "",
          norUrl: regatta.norUrl || "",
          registrationUrl: regatta.registrationUrl || "",
          isSelectionTrial: Boolean(regatta.isSelectionTrial),
          scheduleNotes: regatta.scheduleNotes || "",
        });
        setSelectedRegattaIdForResultEdit(regatta.id);
        toast.success(
          data.rankingNote
            ? `Saved. ${data.rankingNote}`
            : "Regatta created successfully!"
        );
      } else {
        const res = await fetch("/api/admin/regattas", {
          method: "PATCH",
          headers: { "Content-Type": "application/json" },
          body: JSON.stringify({ ...regattaForm, id: editingRegattaId }),
        });
        const data = await parseApi(res);
        if (!res.ok) throw new Error(apiErr(data, "Update failed"));
        const regatta = data.regatta as RegattaAdmin;
        setRegattaList((prev) =>
          prev.map((r) => (r.id === editingRegattaId ? regatta : r))
        );
        setRegattaForm({
          id: regatta.id,
          name: regatta.name || "",
          date: String(regatta.date || "").slice(0, 10),
          slug: regatta.slug,
          division: regatta.division || "",
          raceCount: regatta.raceCount != null ? String(regatta.raceCount) : "",
          totalFleetSize:
            regatta.totalFleetSize != null ? String(regatta.totalFleetSize) : "",
          geography: regatta.geography || "SGP",
          boatClass: regatta.boatClass || "Optimist",
          countsForRanking: regatta.countsForRanking !== false,
          endDate: regatta.endDate ? String(regatta.endDate).slice(0, 10) : "",
          venue: regatta.venue || "",
          organizer: regatta.organizer || "",
          norUrl: regatta.norUrl || "",
          registrationUrl: regatta.registrationUrl || "",
          isSelectionTrial: Boolean(regatta.isSelectionTrial),
          scheduleNotes: regatta.scheduleNotes || "",
        });
        toast.success(
          data.rankingNote
            ? `Saved. ${data.rankingNote}`
            : "Regatta updated successfully!"
        );
      }
      invalidateRegattas?.();
    } catch (e: unknown) {
      toast.error(errorMessage(e));
    } finally {
      setSaving(false);
    }
  };

  const handleDeleteRegatta = async (id: string) => {
    if (!isSuperadmin) {
      toast.error(
        "Error: 403 Forbidden. Only Superadmins can write to the database."
      );
      return;
    }
    if (!id) {
      toast.error("Missing regatta id — refresh the page and try again.");
      return;
    }
    const reg = regattaList.find((r) => r.id === id);
    const resultCount = resultsList.filter((row) => row.regattaId === id).length;
    // resultsList may only hold the editor slice — prefer regatta.totalFleetSize hint when 0
    const cascadeHint =
      resultCount > 0
        ? cascadeLine("Result rows (loaded)", resultCount)
        : "• Result rows: all scores for this event (server cascade)";
    const ok = await confirm({
      title: `Delete ${reg?.name || "this regatta"}?`,
      message:
        `${reg?.name || "Regatta"} · ${regattaDateLabel(reg?.date)}\n` +
        `${reg?.division ? `Division: ${reg.division}\n` : ""}` +
        `${reg?.countsForRanking === false ? "Non-ranking event\n" : ""}` +
        `\nCascade:\n${cascadeHint}\n\nThis cannot be undone.`,
      confirmLabel: "Delete regatta",
      tone: "danger",
    });
    if (!ok) return;
    try {
      const res = await fetch(
        `/api/admin/regattas?id=${encodeURIComponent(id)}`,
        { method: "DELETE" }
      );
      const data = await parseApi(res);
      if (!res.ok) throw new Error(apiErr(data, "Delete failed"));
      setRegattaList((prev) => prev.filter((r) => r.id !== id));
      setResultsList((prev) => prev.filter((row) => row.regattaId !== id));
      if (selectedRegattaIdForResultEdit === id) {
        setSelectedRegattaIdForResultEdit("");
      }
      toast.success("Regatta deleted.");
      invalidateRegattas?.();
      invalidateResults?.();
    } catch (e: unknown) {
      toast.error(errorMessage(e));
    }
  };

  const panelProps = {
    filteredRegattaList,
    regattaSearch,
    setRegattaSearch,
    regattaDivisionFilter,
    setRegattaDivisionFilter,
    regattaClassFilter,
    setRegattaClassFilter,
    regattaRankingFilter,
    setRegattaRankingFilter,
    editingRegattaId,
    setEditingRegattaId,
    regattaForm,
    setRegattaForm,
    saving,
    handleSaveRegatta,
    handleDeleteRegatta,
    invalidateRegattas,
  };

  return {
    panelProps,
    editingRegattaId,
    setEditingRegattaId,
    suggestionCount,
  };
}
