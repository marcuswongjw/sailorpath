"use client";

import { useCallback, useEffect, useMemo, useState } from "react";
import { useQuery, useQueryClient } from "@tanstack/react-query";
import type { SailorAdmin } from "@/types/sailor";
import type { RegattaAdmin } from "@/types/regatta";
import type { ResultAdmin } from "@/types/result";
import { adminQueryKeys } from "@/components/admin/adminQueryKeys";
import {
  fetchAdminRegattas,
  fetchAdminResultsAll,
  fetchAdminResultsForRegatta,
  fetchAdminSailors,
} from "@/components/admin/adminFetch";

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

type Updater<T> = T | ((prev: T) => T);

function applyUpdater<T>(prev: T, updater: Updater<T>): T {
  return typeof updater === "function"
    ? (updater as (p: T) => T)(prev)
    : updater;
}

/**
 * Lazy-loaded admin lists via TanStack Query.
 * Ranking tabs load full results; results editor merges per-regatta slices.
 * Owns selectedRegattaId because results fetch is coupled to it.
 */
export function useAdminData({
  isSuperadmin,
  activeTab,
  editSubTab,
}: UseAdminDataArgs) {
  const queryClient = useQueryClient();
  const [selectedRegattaIdForResultEdit, setSelectedRegattaIdForResultEdit] =
    useState<string>("");
  /** True once a full `?all=1` results payload has been cached this session. */
  const [hasFullResults, setHasFullResults] = useState(false);

  const needsFullResults =
    activeTab === "analysis" ||
    activeTab === "gold" ||
    activeTab === "ilca";

  const needSailors =
    isSuperadmin &&
    (needsFullResults ||
      (activeTab === "edit" &&
        (editSubTab === "sailors" || editSubTab === "results")));

  const needRegattas =
    isSuperadmin &&
    (needsFullResults ||
      (activeTab === "edit" &&
        (editSubTab === "regattas" ||
          editSubTab === "suggestions" ||
          editSubTab === "results")));

  const needResultsEditor =
    isSuperadmin && activeTab === "edit" && editSubTab === "results";

  const sailorsQuery = useQuery({
    queryKey: adminQueryKeys.sailors(),
    queryFn: fetchAdminSailors,
    enabled: needSailors,
  });

  const regattasQuery = useQuery({
    queryKey: adminQueryKeys.regattas(),
    queryFn: fetchAdminRegattas,
    enabled: needRegattas,
  });

  const resultsAllQuery = useQuery({
    queryKey: adminQueryKeys.resultsAll(),
    queryFn: fetchAdminResultsAll,
    enabled: isSuperadmin && needsFullResults,
  });

  const resultsRegattaQuery = useQuery({
    queryKey: adminQueryKeys.resultsByRegatta(
      selectedRegattaIdForResultEdit || "_"
    ),
    queryFn: () =>
      fetchAdminResultsForRegatta(selectedRegattaIdForResultEdit),
    enabled:
      needResultsEditor &&
      Boolean(selectedRegattaIdForResultEdit) &&
      !needsFullResults,
  });

  // Seed selected regatta when list first arrives
  useEffect(() => {
    if (!regattasQuery.data?.length) return;
    setSelectedRegattaIdForResultEdit((current) => current || regattasQuery.data![0].id);
  }, [regattasQuery.data]);

  // Mark full results once ranking tabs have loaded them
  useEffect(() => {
    if (resultsAllQuery.isSuccess && resultsAllQuery.data) {
      setHasFullResults(true);
    }
  }, [resultsAllQuery.isSuccess, resultsAllQuery.data]);

  const sailorList = sailorsQuery.data ?? [];
  const regattaList = regattasQuery.data ?? [];

  const resultsList = useMemo(() => {
    if (hasFullResults || needsFullResults) {
      return resultsAllQuery.data ?? [];
    }
    // Results editor: active regatta slice only (competitions forces a full load).
    return resultsRegattaQuery.data ?? [];
  }, [
    hasFullResults,
    needsFullResults,
    resultsAllQuery.data,
    resultsRegattaQuery.data,
  ]);

  const dataLoading =
    (needSailors && sailorsQuery.isFetching) ||
    (needRegattas && regattasQuery.isFetching) ||
    (needsFullResults && resultsAllQuery.isFetching) ||
    (needResultsEditor &&
      !needsFullResults &&
      Boolean(selectedRegattaIdForResultEdit) &&
      resultsRegattaQuery.isFetching);

  const dataLoadError =
    (sailorsQuery.error instanceof Error && sailorsQuery.error.message) ||
    (regattasQuery.error instanceof Error && regattasQuery.error.message) ||
    (resultsAllQuery.error instanceof Error && resultsAllQuery.error.message) ||
    (resultsRegattaQuery.error instanceof Error &&
      resultsRegattaQuery.error.message) ||
    null;

  const setSailorList = useCallback(
    (updater: Updater<SailorAdmin[]>) => {
      queryClient.setQueryData<SailorAdmin[]>(adminQueryKeys.sailors(), (prev) =>
        applyUpdater(prev ?? [], updater)
      );
    },
    [queryClient]
  );

  const setRegattaList = useCallback(
    (updater: Updater<RegattaAdmin[]>) => {
      queryClient.setQueryData<RegattaAdmin[]>(
        adminQueryKeys.regattas(),
        (prev) => applyUpdater(prev ?? [], updater)
      );
    },
    [queryClient]
  );

  const setResultsList = useCallback(
    (updater: Updater<ResultAdmin[]>) => {
      const next = applyUpdater(
        hasFullResults || needsFullResults
          ? (queryClient.getQueryData<ResultAdmin[]>(adminQueryKeys.resultsAll()) ??
              [])
          : resultsList,
        updater
      );

      if (hasFullResults || needsFullResults) {
        queryClient.setQueryData(adminQueryKeys.resultsAll(), next);
        setHasFullResults(true);
        return;
      }

      // Split updated rows back into per-regatta query caches
      const byRegatta = new Map<string, ResultAdmin[]>();
      for (const row of next) {
        const list = byRegatta.get(row.regattaId) || [];
        list.push(row);
        byRegatta.set(row.regattaId, list);
      }
      for (const [rid, rows] of byRegatta) {
        queryClient.setQueryData(adminQueryKeys.resultsByRegatta(rid), rows);
      }
    },
    [queryClient, hasFullResults, needsFullResults, resultsList]
  );

  const refreshResultsList = useCallback(
    async (opts?: { regattaId?: string }) => {
      try {
        if (opts?.regattaId) {
          const rows = await queryClient.fetchQuery({
            queryKey: adminQueryKeys.resultsByRegatta(opts.regattaId),
            queryFn: () => fetchAdminResultsForRegatta(opts.regattaId!),
          });
          if (hasFullResults) {
            queryClient.setQueryData<ResultAdmin[]>(
              adminQueryKeys.resultsAll(),
              (prev) => {
                const others = (prev ?? []).filter(
                  (r) => r.regattaId !== opts.regattaId
                );
                return [...others, ...rows];
              }
            );
          }
          return;
        }
        await queryClient.fetchQuery({
          queryKey: adminQueryKeys.resultsAll(),
          queryFn: fetchAdminResultsAll,
        });
        setHasFullResults(true);
      } catch {
        /* keep existing list */
      }
    },
    [queryClient, hasFullResults]
  );

  const patchResultsFromImport = useCallback(
    (incoming: ResultAdmin[]) => {
      const touched = new Set(incoming.map((r) => r.regattaId));
      if (touched.size <= 1) {
        const rid = [...touched][0];
        if (!rid) return;
        queryClient.setQueryData(
          adminQueryKeys.resultsByRegatta(rid),
          incoming
        );
        if (hasFullResults) {
          queryClient.setQueryData<ResultAdmin[]>(
            adminQueryKeys.resultsAll(),
            (prev) => {
              const others = (prev ?? []).filter((r) => r.regattaId !== rid);
              return [...others, ...incoming];
            }
          );
        }
      } else {
        queryClient.setQueryData(adminQueryKeys.resultsAll(), incoming);
        setHasFullResults(true);
      }
    },
    [queryClient, hasFullResults]
  );

  const patchRegattaUpsert = useCallback(
    (regatta: RegattaAdmin) => {
      setRegattaList((prev) => {
        const exists = prev.some((r) => r.id === regatta.id);
        return exists
          ? prev.map((r) => (r.id === regatta.id ? regatta : r))
          : [...prev, regatta];
      });
    },
    [setRegattaList]
  );

  const patchRegattaPartial = useCallback(
    (reg: Partial<RegattaAdmin> & { id: string }) => {
      setRegattaList((prev) => {
        const exists = prev.some((r) => r.id === reg.id);
        return exists
          ? prev.map((r) => (r.id === reg.id ? { ...r, ...reg } : r))
          : [...prev, reg as RegattaAdmin];
      });
    },
    [setRegattaList]
  );

  const patchSailorPartial = useCallback(
    (sailor: Partial<SailorAdmin> & { id: string }) => {
      setSailorList((prev) =>
        prev.map((s) => (s.id === sailor.id ? { ...s, ...sailor } : s))
      );
    },
    [setSailorList]
  );

  /** Refetch sailors from the server (after bulk/merge/actions). */
  const invalidateSailors = useCallback(() => {
    void queryClient.invalidateQueries({ queryKey: adminQueryKeys.sailors() });
  }, [queryClient]);

  const invalidateRegattas = useCallback(() => {
    void queryClient.invalidateQueries({ queryKey: adminQueryKeys.regattas() });
  }, [queryClient]);

  /** Invalidate all results caches (full + per-regatta). */
  const invalidateResults = useCallback(() => {
    void queryClient.invalidateQueries({ queryKey: ["admin", "results"] });
  }, [queryClient]);

  const invalidateAllLists = useCallback(() => {
    invalidateSailors();
    invalidateRegattas();
    invalidateResults();
  }, [invalidateSailors, invalidateRegattas, invalidateResults]);

  return {
    sailorList,
    setSailorList,
    regattaList,
    setRegattaList,
    resultsList,
    setResultsList,
    selectedRegattaIdForResultEdit,
    setSelectedRegattaIdForResultEdit,
    loadedData: {
      sailors: sailorsQuery.isSuccess || sailorList.length > 0,
      regattas: regattasQuery.isSuccess || regattaList.length > 0,
      results:
        resultsAllQuery.isSuccess ||
        resultsRegattaQuery.isSuccess ||
        resultsList.length > 0,
    } as Record<AdminDataKey, boolean>,
    hasFullResults,
    setHasFullResults,
    dataLoading,
    dataLoadError,
    refreshResultsList,
    patchResultsFromImport,
    patchRegattaUpsert,
    patchRegattaPartial,
    patchSailorPartial,
    invalidateSailors,
    invalidateRegattas,
    invalidateResults,
    invalidateAllLists,
  };
}
