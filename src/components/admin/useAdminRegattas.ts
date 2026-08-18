"use client";

import { useState, useMemo, type Dispatch, type SetStateAction } from "react";
import { parseApi } from "@/components/admin/parseApi";
import type { RegattaAdmin } from "@/types/regatta";
import type { ResultAdmin } from "@/types/result";

type UseAdminRegattasArgs = {
  isSuperadmin: boolean;
  regattaList: RegattaAdmin[];
  setRegattaList: Dispatch<SetStateAction<RegattaAdmin[]>>;
  setResultsList: Dispatch<SetStateAction<ResultAdmin[]>>;
  selectedRegattaIdForResultEdit: string;
  setSelectedRegattaIdForResultEdit: Dispatch<SetStateAction<string>>;
};

/**
 * Regattas Database sub-tab: filters, form, CRUD (+ cascade results on delete).
 */
export function useAdminRegattas({
  isSuperadmin,
  regattaList,
  setRegattaList,
  setResultsList,
  selectedRegattaIdForResultEdit,
  setSelectedRegattaIdForResultEdit,
}: UseAdminRegattasArgs) {
  const [regattaSearch, setRegattaSearch] = useState("");
  const [regattaDivisionFilter, setRegattaDivisionFilter] =
    useState<string>("all");
  /** all | series | nonranking */
  const [regattaRankingFilter, setRegattaRankingFilter] =
    useState<string>("all");
  const [editingRegattaId, setEditingRegattaId] = useState<string | null>(null);
  const [regattaForm, setRegattaForm] = useState<any>({
    id: "",
    name: "",
    date: "",
    totalFleetSize: 50,
    division: "Gold",
    raceCount: "",
    geography: "SGP",
    boatClass: "Optimist",
    countsForRanking: true,
  });

  const filteredRegattaList = useMemo(() => {
    const q = regattaSearch.trim().toLowerCase();
    return [...(regattaList || [])]
      .filter((r) => {
        if (
          regattaDivisionFilter !== "all" &&
          String(r.division || "Gold") !== regattaDivisionFilter
        ) {
          return false;
        }
        const isNon = r.countsForRanking === false;
        if (regattaRankingFilter === "series" && isNon) return false;
        if (regattaRankingFilter === "nonranking" && !isNon) return false;
        if (!q) return true;
        const hay =
          `${r.name || ""} ${r.date || ""} ${r.division || ""} ${r.slug || ""}`.toLowerCase();
        return hay.includes(q);
      })
      .sort((a, b) => String(b.date || "").localeCompare(String(a.date || "")));
  }, [
    regattaList,
    regattaSearch,
    regattaDivisionFilter,
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
    if (!isSuperadmin) {
      alert(
        "Error: 403 Forbidden. Only Superadmins can write to the database."
      );
      return;
    }
    if (!regattaForm.name || !regattaForm.date) {
      alert("Regatta Name and Date are required.");
      return;
    }
    try {
      if (editingRegattaId === "new") {
        const res = await fetch("/api/admin/regattas", {
          method: "POST",
          headers: { "Content-Type": "application/json" },
          body: JSON.stringify(regattaForm),
        });
        const data = await parseApi(res);
        if (!res.ok) throw new Error(data.error || "Create failed");
        setRegattaList((prev) => [...prev, data.regatta]);
        if (!selectedRegattaIdForResultEdit) {
          setSelectedRegattaIdForResultEdit(data.regatta.id);
        }
        alert("Regatta created successfully!");
      } else {
        const res = await fetch("/api/admin/regattas", {
          method: "PATCH",
          headers: { "Content-Type": "application/json" },
          body: JSON.stringify({ ...regattaForm, id: editingRegattaId }),
        });
        const data = await parseApi(res);
        if (!res.ok) throw new Error(data.error || "Update failed");
        setRegattaList((prev) =>
          prev.map((r) => (r.id === editingRegattaId ? data.regatta : r))
        );
        alert("Regatta updated successfully!");
      }
      setEditingRegattaId(null);
    } catch (e: any) {
      alert(e.message);
    }
  };

  const handleDeleteRegatta = async (id: string) => {
    if (!isSuperadmin) {
      alert(
        "Error: 403 Forbidden. Only Superadmins can write to the database."
      );
      return;
    }
    if (!id) {
      alert("Missing regatta id — refresh the page and try again.");
      return;
    }
    if (
      !confirm(
        "Are you sure you want to delete this regatta? All results associated with it will also be deleted."
      )
    ) {
      return;
    }
    try {
      const res = await fetch(
        `/api/admin/regattas?id=${encodeURIComponent(id)}`,
        { method: "DELETE" }
      );
      const data = await parseApi(res);
      if (!res.ok) throw new Error(data.error || "Delete failed");
      setRegattaList((prev) => prev.filter((r) => r.id !== id));
      setResultsList((prev) => prev.filter((row) => row.regattaId !== id));
      if (selectedRegattaIdForResultEdit === id) {
        setSelectedRegattaIdForResultEdit("");
      }
      alert("Regatta deleted.");
    } catch (e: any) {
      alert(e.message);
    }
  };

  const panelProps = {
    filteredRegattaList,
    regattaSearch,
    setRegattaSearch,
    regattaDivisionFilter,
    setRegattaDivisionFilter,
    regattaRankingFilter,
    setRegattaRankingFilter,
    editingRegattaId,
    setEditingRegattaId,
    regattaForm,
    setRegattaForm,
    handleSaveRegatta,
    handleDeleteRegatta,
  };

  return {
    panelProps,
    editingRegattaId,
    setEditingRegattaId,
    suggestionCount,
  };
}
