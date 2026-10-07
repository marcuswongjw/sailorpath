"use client";

import { useState, useMemo, useRef, type Dispatch, type SetStateAction } from "react";
import { parseApi, apiErr } from "@/components/admin/parseApi";
import { emptyRegattaForm, regattaToClassForm, type RegattaFormState } from "@/components/admin/adminForms";
import { useFeedback } from "@/components/ui/FeedbackProvider";
import { errorMessage } from "@/lib/errors";
import { cascadeLine } from "@/lib/confirmCopy";
import { regattaMatchesAdminClass } from "@/lib/admin/regattaClass";
import {
  duplicateRegattaChoice,
  mergeRegattaIdentities,
  planNewClassSave,
  regattaIdentityFromApi,
  type RegattaDuplicateDecision,
  type RegattaIdentity,
} from "@/lib/admin/regattaDuplicate";
import { slugify } from "@/lib/slug";
import type { RegattaAdmin } from "@/types/regatta";
import { regattaDateLabel } from "@/types/regatta";
import type { ResultAdmin } from "@/types/result";
import { setAdminRegattaStatus } from "@/components/admin/adminRegattaLifecycle";
import {
  isRegattaLifecycleStatus,
  type RegattaLifecycleStatus,
} from "@/lib/regattaStatus";

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
  const { toast, confirm, choose } = useFeedback();
  const saveLock = useRef(false);
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
  /** JSON of the class form last opened or saved. Leave prompts compare against this. */
  const [classSnap, setClassSnap] = useState("");
  /** Double-submit guard for regatta save. */
  const [saving, setSaving] = useState(false);

  const rememberSavedClass = (regatta: RegattaAdmin) => {
    const next = regattaToClassForm(regatta);
    setRegattaForm(next);
    setClassSnap(JSON.stringify(next));
  };

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

  const classIdentities = (): RegattaIdentity[] =>
    (regattaList || [])
      .map((regatta) => ({
        id: regatta.id,
        slug: regatta.slug || slugify(regatta.name || ""),
        name: regatta.name || "",
        startDate: String(regatta.date || "").slice(0, 10),
      }))
      .filter((regatta) => regatta.slug || regatta.name);

  const duplicateClassBody = (form: RegattaFormState) => ({
    name: form.name,
    date: form.date,
    endDate: form.endDate,
    venue: form.venue,
    boatClass: form.boatClass,
    division: form.division,
  });

  const handleSaveRegatta = async () => {
    if (saving || saveLock.current) return;
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
    saveLock.current = true;
    setSaving(true);
    try {
      const rememberCreated = (regatta: RegattaAdmin, rankingNote?: string) => {
        setRegattaList((prev) =>
          prev.some((row) => row.id === regatta.id)
            ? prev.map((row) => (row.id === regatta.id ? regatta : row))
            : [...prev, regatta]
        );
        setEditingRegattaId(regatta.id);
        rememberSavedClass(regatta);
        setSelectedRegattaIdForResultEdit(regatta.id);
        toast.success(
          rankingNote ? `Saved. ${rankingNote}` : "Regatta created successfully!"
        );
      };

      const patchClass = async (
        regattaId: string,
        body: Record<string, unknown>,
        desiredStatus?: RegattaLifecycleStatus
      ) => {
        const current = regattaList.find((row) => row.id === regattaId);
        const res = await fetch("/api/admin/regattas", {
          method: "PATCH",
          headers: { "Content-Type": "application/json" },
          body: JSON.stringify({ ...body, id: regattaId }),
        });
        const data = await parseApi(res);
        if (!res.ok) throw new Error(apiErr(data, "Update failed"));
        let regatta = data.regatta as RegattaAdmin;
        if (desiredStatus && (current?.status || "published") !== desiredStatus) {
          await setAdminRegattaStatus(regattaId, desiredStatus);
          regatta = { ...regatta, status: desiredStatus };
        }
        setRegattaList((prev) =>
          prev.some((row) => row.id === regattaId)
            ? prev.map((row) => (row.id === regattaId ? regatta : row))
            : [...prev, regatta]
        );
        setEditingRegattaId(regatta.id);
        rememberSavedClass(regatta);
        setSelectedRegattaIdForResultEdit(regatta.id);
        return data;
      };

      if (editingRegattaId === "new") {
        const input = {
          name: regattaForm.name,
          date: regattaForm.date,
          boatClass: regattaForm.boatClass,
          division: regattaForm.division,
        };
        let known = classIdentities();
        const ask = (existing: RegattaIdentity) =>
          choose(
            duplicateRegattaChoice({
              enteredName: regattaForm.name,
              existing,
              noun: "class",
            })
          );
        let decision: RegattaDuplicateDecision | null = null;
        const first = planNewClassSave(input, known, null);
        if (first.action === "needs-decision") {
          decision = await ask(first.duplicate.existing);
          if (!decision) return;
        }
        let plan = planNewClassSave(input, known, decision);
        const updatedClassToast = (note: unknown) => {
          toast.success(
            typeof note === "string" && note
              ? `Existing class updated. ${note}`
              : "Existing class updated. Its results, race count, and fleet size were left in place."
          );
        };
        if (plan.action === "update") {
          const data = await patchClass(plan.id, duplicateClassBody(regattaForm));
          updatedClassToast(data.rankingNote);
        } else if (plan.action === "create") {
          const postClass = async (slug: string) => {
            const res = await fetch("/api/admin/regattas", {
              method: "POST",
              headers: { "Content-Type": "application/json" },
              body: JSON.stringify({ ...regattaForm, slug }),
            });
            const data = await parseApi(res);
            return { res, data };
          };
          let posted = await postClass(plan.slug);
          if (posted.res.status === 409) {
            const serverExisting = regattaIdentityFromApi(posted.data.existing);
            if (!serverExisting?.id) {
              throw new Error(apiErr(posted.data, "Create failed"));
            }
            known = mergeRegattaIdentities([known, [serverExisting]]);
            decision = await ask(serverExisting);
            if (!decision) return;
            if (decision === "update") {
              const data = await patchClass(
                serverExisting.id,
                duplicateClassBody(regattaForm)
              );
              updatedClassToast(data.rankingNote);
              invalidateRegattas?.();
              return;
            }
            plan = planNewClassSave(input, known, "separate");
            if (plan.action !== "create") return;
            posted = await postClass(plan.slug);
          }
          if (!posted.res.ok) throw new Error(apiErr(posted.data, "Create failed"));
          rememberCreated(
            posted.data.regatta as RegattaAdmin,
            typeof posted.data.rankingNote === "string"
              ? posted.data.rankingNote
              : undefined
          );
        }
      } else {
        if (!editingRegattaId) {
          throw new Error("Select a sailing class before saving changes.");
        }
        const requestedStatus = regattaForm.status || "published";
        if (!isRegattaLifecycleStatus(requestedStatus)) {
          throw new Error("Select a valid publication status before saving.");
        }
        const detailsForm = { ...regattaForm };
        delete detailsForm.status;
        const data = await patchClass(
          editingRegattaId,
          detailsForm,
          requestedStatus
        );
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
      saveLock.current = false;
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
    classSnap,
    setClassSnap,
    saving,
    handleSaveRegatta,
    handleDeleteRegatta,
    invalidateRegattas,
    onRegattaMoved: (row: RegattaAdmin) => {
      setRegattaList((current) => current.map((item) => item.id === row.id ? row : item));
      setSelectedRegattaIdForResultEdit(row.id);
    },
  };

  return {
    panelProps,
    editingRegattaId,
    setEditingRegattaId,
    suggestionCount,
  };
}
