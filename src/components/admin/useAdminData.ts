"use client";

import { useState, useEffect, useMemo, useCallback } from "react";
import type { SailorAdmin } from "@/types/sailor";
import type { RegattaAdmin } from "@/types/regatta";
import type { ResultAdmin } from "@/types/result";
import { parseApi } from "@/components/admin/parseApi";

export type AdminDataKey = "sailors" | "regattas" | "results";

export type AdminActiveTab = "import" | "edit" | "analysis" | "gold" | "ilca";
export type AdminEditSubTab =
  | "sailors"
  | "regattas"
  | "results"
  | "suggestions"
  | "claims"
  | "promote"
  | "support";

type UseAdminDataArgs = {
  isSuperadmin: boolean;
  activeTab: AdminActiveTab;
  editSubTab: AdminEditSubTab;
};

/**
 * Lazy-loaded admin lists + refresh/patch helpers.
 * Ranking tabs load `?all=1` and set hasFullResults; results editor merges per regattaId.
 * Owns selectedRegattaId because lazy results fetch is coupled to it.
 */
export function useAdminData({
  isSuperadmin,
  activeTab,
  editSubTab,
}: UseAdminDataArgs) {
  const [sailorList, setSailorList] = useState<SailorAdmin[]>([]);
  const [regattaList, setRegattaList] = useState<RegattaAdmin[]>([]);
  const [resultsList, setResultsList] = useState<ResultAdmin[]>([]);
  const [selectedRegattaIdForResultEdit, setSelectedRegattaIdForResultEdit] =
    useState<string>("");
  const [loadedData, setLoadedData] = useState<Record<AdminDataKey, boolean>>({
    sailors: false,
    regattas: false,
    results: false,
  });
  /** Results editor loads one regatta; ranking tabs need the full set. */
  const [hasFullResults, setHasFullResults] = useState(false);
  const [dataLoading, setDataLoading] = useState(false);
  const [dataLoadError, setDataLoadError] = useState<string | null>(null);

  const requiredData = useMemo<AdminDataKey[]>(() => {
    if (
      activeTab === "analysis" ||
      activeTab === "gold" ||
      activeTab === "ilca"
    ) {
      return ["sailors", "regattas", "results"];
    }
    if (activeTab !== "edit") return [];
    if (editSubTab === "sailors") return ["sailors"];
    if (editSubTab === "regattas" || editSubTab === "suggestions") {
      return ["regattas"];
    }
    if (editSubTab === "results") return ["sailors", "regattas", "results"];
    return [];
  }, [activeTab, editSubTab]);

  // Load only the records required for the active workspace.
  useEffect(() => {
    if (!isSuperadmin) return;
    const needsFullResults =
      activeTab === "analysis" ||
      activeTab === "gold" ||
      activeTab === "ilca";

    const missing = requiredData.filter((key) => {
      if (key === "results" && needsFullResults && !hasFullResults) return true;
      return !loadedData[key];
    });
    if (missing.length === 0) return;

    let cancelled = false;
    setDataLoading(true);
    setDataLoadError(null);

    const endpoints: Record<AdminDataKey, string> = {
      sailors: "/api/admin/sailors?all=1",
      regattas: "/api/admin/regattas?all=1",
      results: needsFullResults
        ? "/api/admin/results?all=1"
        : selectedRegattaIdForResultEdit
          ? `/api/admin/results?regattaId=${encodeURIComponent(selectedRegattaIdForResultEdit)}`
          : "",
    };

    void Promise.all(
      missing.map(async (key) => {
        const url = endpoints[key];
        if (!url) {
          return { key, body: { results: [] as ResultAdmin[] } };
        }
        const response = await fetch(url, { credentials: "include" });
        const body = (await response.json()) as {
          error?: string;
          sailors?: SailorAdmin[];
          regattas?: RegattaAdmin[];
          results?: ResultAdmin[];
        };
        if (!response.ok) throw new Error(body.error || `Could not load ${key}`);
        return { key, body };
      })
    )
      .then((responses) => {
        if (cancelled) return;
        for (const { key, body } of responses) {
          if (key === "sailors" && Array.isArray(body.sailors)) {
            setSailorList(body.sailors);
          }
          if (key === "regattas" && Array.isArray(body.regattas)) {
            const rows = [...body.regattas].sort((a, b) =>
              String(b.date || "").localeCompare(String(a.date || ""))
            );
            setRegattaList(rows);
            setSelectedRegattaIdForResultEdit(
              (current) => current || rows[0]?.id || ""
            );
          }
          if (key === "results" && Array.isArray(body.results)) {
            if (needsFullResults) {
              setResultsList(body.results);
              setHasFullResults(true);
            } else {
              // Merge/replace rows for the selected regatta only
              const rid = selectedRegattaIdForResultEdit;
              setResultsList((prev) => {
                const others = rid
                  ? prev.filter((r) => r.regattaId !== rid)
                  : prev;
                return [...others, ...body.results!];
              });
            }
          }
        }
        setLoadedData((current) => {
          const next = { ...current };
          for (const key of missing) next[key] = true;
          return next;
        });
      })
      .catch((error: unknown) => {
        if (!cancelled) {
          setDataLoadError(
            error instanceof Error ? error.message : "Failed to load admin data"
          );
        }
      })
      .finally(() => {
        if (!cancelled) setDataLoading(false);
      });

    return () => {
      cancelled = true;
    };
  }, [
    isSuperadmin,
    loadedData,
    requiredData,
    activeTab,
    selectedRegattaIdForResultEdit,
    hasFullResults,
  ]);

  // Results editor: reload when switching regatta (avoid downloading every result).
  useEffect(() => {
    if (!isSuperadmin) return;
    if (activeTab !== "edit" || editSubTab !== "results") return;
    const rid = selectedRegattaIdForResultEdit;
    if (!rid) return;

    let cancelled = false;
    void (async () => {
      try {
        const response = await fetch(
          `/api/admin/results?regattaId=${encodeURIComponent(rid)}`,
          { credentials: "include" }
        );
        const body = (await response.json()) as {
          error?: string;
          results?: ResultAdmin[];
        };
        if (!response.ok) throw new Error(body.error || "Could not load results");
        if (cancelled || !Array.isArray(body.results)) return;
        setResultsList((prev) => {
          const others = prev.filter((r) => r.regattaId !== rid);
          return [...others, ...body.results!];
        });
      } catch {
        /* keep existing rows; banner handled elsewhere */
      }
    })();

    return () => {
      cancelled = true;
    };
  }, [isSuperadmin, activeTab, editSubTab, selectedRegattaIdForResultEdit]);

  const refreshResultsList = useCallback(
    async (opts?: { regattaId?: string }) => {
      try {
        const url = opts?.regattaId
          ? `/api/admin/results?regattaId=${encodeURIComponent(opts.regattaId)}`
          : "/api/admin/results?all=1";
        const res = await fetch(url, { credentials: "include" });
        const data = await parseApi(res);
        if (!res.ok || !Array.isArray(data.results)) return;
        if (opts?.regattaId) {
          const rid = opts.regattaId;
          setResultsList((prev) => {
            const others = prev.filter((r) => r.regattaId !== rid);
            return [...others, ...data.results];
          });
        } else {
          setResultsList(data.results);
          setHasFullResults(true);
        }
      } catch {
        /* keep existing list */
      }
    },
    []
  );

  /** Import: merge single-regatta vs replace full dump. */
  const patchResultsFromImport = useCallback((incoming: ResultAdmin[]) => {
    const touched = new Set(incoming.map((r) => r.regattaId));
    if (touched.size <= 1) {
      const rid = [...touched][0];
      setResultsList((prev) =>
        rid
          ? [...prev.filter((r) => r.regattaId !== rid), ...incoming]
          : incoming
      );
    } else {
      setResultsList(incoming);
      setHasFullResults(true);
    }
  }, []);

  const patchRegattaUpsert = useCallback((regatta: RegattaAdmin) => {
    setRegattaList((prev) => {
      const exists = prev.some((r) => r.id === regatta.id);
      return exists
        ? prev.map((r) => (r.id === regatta.id ? regatta : r))
        : [...prev, regatta];
    });
  }, []);

  const patchRegattaPartial = useCallback(
    (reg: Partial<RegattaAdmin> & { id: string }) => {
      setRegattaList((prev) => {
        const exists = prev.some((r) => r.id === reg.id);
        return exists
          ? prev.map((r) => (r.id === reg.id ? { ...r, ...reg } : r))
          : [...prev, reg as RegattaAdmin];
      });
    },
    []
  );

  const patchSailorPartial = useCallback(
    (sailor: Partial<SailorAdmin> & { id: string }) => {
      setSailorList((prev) =>
        prev.map((s) => (s.id === sailor.id ? { ...s, ...sailor } : s))
      );
    },
    []
  );

  return {
    sailorList,
    setSailorList,
    regattaList,
    setRegattaList,
    resultsList,
    setResultsList,
    selectedRegattaIdForResultEdit,
    setSelectedRegattaIdForResultEdit,
    loadedData,
    hasFullResults,
    setHasFullResults,
    dataLoading,
    dataLoadError,
    refreshResultsList,
    patchResultsFromImport,
    patchRegattaUpsert,
    patchRegattaPartial,
    patchSailorPartial,
  };
}
