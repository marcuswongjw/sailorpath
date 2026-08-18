"use client";

import { useState, type Dispatch, type SetStateAction } from "react";
import { parseApi } from "@/components/admin/parseApi";
import type { RegattaAdmin } from "@/types/regatta";
import type { ResultAdmin } from "@/types/result";

type UseAdminResultsArgs = {
  isSuperadmin: boolean;
  regattaList: RegattaAdmin[];
  setResultsList: Dispatch<SetStateAction<ResultAdmin[]>>;
  refreshResultsList: (opts?: { regattaId?: string }) => Promise<void>;
  /** Owned by useAdminData (fetch coupling); threaded through for the editor UI. */
  selectedRegattaIdForResultEdit: string;
  setSelectedRegattaIdForResultEdit: Dispatch<SetStateAction<string>>;
};

/**
 * Results editor: result form, save/delete, DNS fills.
 * selectedRegattaId is owned by useAdminData and passed in.
 */
export function useAdminResults({
  isSuperadmin,
  regattaList,
  setResultsList,
  refreshResultsList,
  selectedRegattaIdForResultEdit,
  setSelectedRegattaIdForResultEdit,
}: UseAdminResultsArgs) {
  const [editingResultId, setEditingResultId] = useState<string | null>(null);
  const [resultForm, setResultForm] = useState<any>({
    id: "",
    regattaId: "",
    sailorId: "",
    rank: 1,
    nettScore: "",
    totalScore: "",
    isDNS: false,
    isOverseasCommitment: false,
  });

  const handleSaveResult = async () => {
    if (!isSuperadmin) {
      alert(
        "Error: 403 Forbidden. Only Superadmins can write to the database."
      );
      return;
    }
    if (!resultForm.sailorId || !resultForm.regattaId) {
      alert("Sailor and Regatta must be selected.");
      return;
    }
    const overseas = Boolean(resultForm.isOverseasCommitment);
    const reg = regattaList.find((r) => r.id === resultForm.regattaId);
    const dnsPts = (reg?.totalFleetSize || 50) + 1;
    const rankNum = Number(resultForm.rank);
    let isDns = overseas
      ? false
      : Boolean(resultForm.isDNS || resultForm.isDns);
    if (isDns && Number.isFinite(rankNum) && rankNum < dnsPts) {
      isDns = false;
    }
    const payload = {
      ...resultForm,
      rank: rankNum,
      isDns,
      isDNS: isDns,
      isOverseasCommitment: overseas,
    };
    try {
      if (editingResultId === "new") {
        const res = await fetch("/api/admin/results", {
          method: "POST",
          headers: { "Content-Type": "application/json" },
          body: JSON.stringify(payload),
        });
        const data = await parseApi(res);
        if (!res.ok) throw new Error(data.error || "Create failed");
        setResultsList((prev) => {
          const row = data.result;
          const without = prev.filter(
            (r) =>
              !(r.sailorId === row.sailorId && r.regattaId === row.regattaId)
          );
          return [...without, row];
        });
        alert("Result added successfully!");
      } else {
        const res = await fetch("/api/admin/results", {
          method: "PATCH",
          headers: { "Content-Type": "application/json" },
          body: JSON.stringify({ ...payload, id: editingResultId }),
        });
        const data = await parseApi(res);
        if (!res.ok) throw new Error(data.error || "Update failed");
        setResultsList((prev) =>
          prev.map((r) => (r.id === editingResultId ? data.result : r))
        );
        alert("Result updated successfully!");
      }
      setEditingResultId(null);
    } catch (e: any) {
      alert(e.message);
    }
  };

  const handleFillDnsForRegatta = async (regattaId: string) => {
    if (!isSuperadmin) {
      alert("Error: 403 Forbidden.");
      return;
    }
    if (!regattaId) {
      alert("Select a regatta first.");
      return;
    }
    const reg = regattaList.find((r) => r.id === regattaId);
    const ok = confirm(
      `Create DNS scores for active ${reg?.division || ""} fleet members who do not have a result at “${reg?.name || "this regatta"}”?\n\n` +
        `DNS points = fleet size + 1 = ${(reg?.totalFleetSize || 0) + 1}.\n` +
        `You can edit any row afterwards (e.g. overseas commitment).`
    );
    if (!ok) return;
    try {
      const res = await fetch("/api/admin/results", {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({ action: "fillDns", regattaId }),
      });
      const data = await parseApi(res);
      if (!res.ok) throw new Error(data.error || "Fill DNS failed");
      await refreshResultsList({ regattaId });
      alert(data.message || `Created ${data.created} DNS rows.`);
    } catch (e: any) {
      alert(e.message || "Fill DNS failed");
    }
  };

  /** Ensure every active fleet sailor has results for all ranking regattas in a half-year */
  const handleFillDnsForPeriod = async (
    fleet: "Gold" | "Silver",
    year: number,
    half: "Jan-Jun" | "Jul-Dec"
  ) => {
    if (!isSuperadmin) {
      alert("Error: 403 Forbidden.");
      return;
    }
    const ok = confirm(
      `Ensure DNS for all active ${fleet} fleet sailors in ${half} ${year}?\n\n` +
        `Each sailor will get a result for every ranking regatta in that period they are missing.\n` +
        `Missing → rank = that regatta’s fleet size + 1 (DNS).\n` +
        `Existing results (including overseas) are left unchanged.`
    );
    if (!ok) return;
    try {
      const res = await fetch("/api/admin/results", {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({
          action: "fillDnsPeriod",
          fleet,
          year,
          half,
        }),
      });
      const data = await parseApi(res);
      if (!res.ok) throw new Error(data.error || "Period DNS fill failed");
      await refreshResultsList();
      const events = (data.rankingRegattas || [])
        .map((e: any) => `• ${e.name} (${e.date}) → DNS ${e.dnsPoints}`)
        .join("\n");
      alert(
        `${data.message}\n\nRanking regattas:\n${events || "(none found — import regattas with dates in this period)"}`
      );
    } catch (e: any) {
      alert(e.message || "Period DNS fill failed");
    }
  };

  const handleDeleteResult = async (id: string) => {
    if (!isSuperadmin) {
      alert(
        "Error: 403 Forbidden. Only Superadmins can write to the database."
      );
      return;
    }
    if (!id) {
      alert("Missing result id — refresh the page and try again.");
      return;
    }
    if (!confirm("Are you sure you want to delete this result?")) return;
    try {
      const res = await fetch(
        `/api/admin/results?id=${encodeURIComponent(id)}`,
        { method: "DELETE" }
      );
      const data = await parseApi(res);
      if (!res.ok) throw new Error(data.error || "Delete failed");
      setResultsList((prev) => prev.filter((r) => r.id !== id));
      alert("Result deleted.");
    } catch (e: any) {
      alert(e.message);
    }
  };

  const panelProps = {
    selectedRegattaIdForResultEdit,
    setSelectedRegattaIdForResultEdit,
    editingResultId,
    setEditingResultId,
    resultForm,
    setResultForm,
    handleSaveResult,
    handleDeleteResult,
    handleFillDnsForRegatta,
    handleFillDnsForPeriod,
  };

  return {
    panelProps,
    selectedRegattaIdForResultEdit,
    setSelectedRegattaIdForResultEdit,
    editingResultId,
    setEditingResultId,
    resultForm,
    setResultForm,
    handleSaveResult,
    handleDeleteResult,
  };
}
