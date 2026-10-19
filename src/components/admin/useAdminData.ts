"use client";

import { useCallback, useMemo, useState } from "react";
import { useQuery, useQueryClient } from "@tanstack/react-query";
import type { SailorAdmin } from "@/types/sailor";
import type { RegattaAdmin } from "@/types/regatta";
import type { ResultAdmin } from "@/types/result";
import { adminQueryKeys } from "@/components/admin/adminQueryKeys";
import { invalidateAdminSummaries } from "./invalidateAdminSummaries";
import {
  fetchAdminRegattaEvents,
  fetchAdminRegattas,
  fetchAdminResultsAll,
  fetchAdminResultsForRegatta,
  fetchAdminSailors,
} from "@/components/admin/adminFetch";
import type {
  AdminActiveTab,
  AdminEditSubTab,
  AdminEventsView,
} from "@/components/admin/adminNav";

export type AdminDataKey = "sailors" | "regattas" | "results";

export type {
  AdminActiveTab,
  AdminEditSubTab,
  AdminDbSubTab,
  AdminOpsSubTab,
} from "@/components/admin/adminNav";

import { isAdminEventsQueueView } from "./adminNav";

const EMPTY_SAILORS: SailorAdmin[] = [];
const EMPTY_REGATTAS: RegattaAdmin[] = [];
const EMPTY_RESULTS: ResultAdmin[] = [];

type UseAdminDataArgs = {
  isSuperadmin: boolean;
  activeTab: AdminActiveTab;
  editSubTab: AdminEditSubTab;
  eventsView?: AdminEventsView;
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
  eventsView = "results",
}: UseAdminDataArgs) {
  const queryClient = useQueryClient();
  const [selectedRegattaIdForResultEdit, setSelectedRegattaIdForResultEdit] =
    useState<string>("");

  const needsFullResults =
    activeTab === "analysis" ||
    activeTab === "ilca" ||
    (activeTab === "edit" && editSubTab === "selection");

  const sheetOpen =
    isSuperadmin &&
    ((activeTab === "regattas" && eventsView === "results") ||
      (activeTab === "edit" && editSubTab === "regattas")) &&
    Boolean(selectedRegattaIdForResultEdit);

  const needSailors =
    isSuperadmin &&
    (needsFullResults ||
      sheetOpen ||
      (activeTab === "edit" &&
        (editSubTab === "sailors" ||
          editSubTab === "duplicates" ||
          editSubTab === "selection")));

  const needRegattas =
    isSuperadmin &&
    (needsFullResults ||
      sheetOpen ||
      (activeTab === "regattas" && !isAdminEventsQueueView(eventsView)) ||
      activeTab === "import" ||
      (activeTab === "edit" &&
        (editSubTab === "regattas" || editSubTab === "selection")) ||
      (activeTab === "ops" && editSubTab === "suggestions"));

  const needCalendarEvents = isSuperadmin && activeTab === "import";

  const needResultsEditor = sheetOpen;

  const sailorsQuery = useQuery({
    queryKey: adminQueryKeys.sailors(),
    queryFn: ({ signal }) => fetchAdminSailors({ signal }),
    enabled: needSailors,
  });

  const regattasQuery = useQuery({
    queryKey: adminQueryKeys.regattas(),
    queryFn: ({ signal }) => fetchAdminRegattas({ signal }),
    enabled: needRegattas,
  });

  const calendarEventsQuery = useQuery({
    queryKey: adminQueryKeys.regattaEvents(),
    queryFn: ({ signal }) => fetchAdminRegattaEvents({ signal }),
    enabled: needCalendarEvents,
  });

  // Do not fall back to the first regatta. An empty selection means the
  // weekend is open and no class sheet is being edited.
  const selectedRegattaId = selectedRegattaIdForResultEdit;

  const resultsAllQuery = useQuery({
    queryKey: adminQueryKeys.resultsAll(),
    queryFn: ({ signal }) => fetchAdminResultsAll({ signal }),
    enabled: isSuperadmin && needsFullResults,
  });

  const resultsRegattaQuery = useQuery({
    queryKey: adminQueryKeys.resultsByRegatta(selectedRegattaId || "_"),
    queryFn: ({ signal }) =>
      fetchAdminResultsForRegatta(selectedRegattaId, true, { signal }),
    enabled: needResultsEditor && Boolean(selectedRegattaIdForResultEdit),
  });

  // Query data remains cached even when its ranking tab is disabled.
  const hasFullResults = resultsAllQuery.data !== undefined;

  const sailorList = sailorsQuery.data ?? EMPTY_SAILORS;
  const regattaList = regattasQuery.data ?? EMPTY_REGATTAS;
  const calendarEvents = calendarEventsQuery.data ?? [];

  const resultsList = useMemo(() => {
    // When a specific class sheet is open in the results editor, prioritize
    // its detailed row results with attached individual official race finishes.
    if (sheetOpen && resultsRegattaQuery.data) {
      return resultsRegattaQuery.data;
    }
    if (hasFullResults || needsFullResults) {
      return resultsAllQuery.data ?? EMPTY_RESULTS;
    }
    // Results editor: active regatta slice only (competitions forces a full load).
    return resultsRegattaQuery.data ?? EMPTY_RESULTS;
  }, [
    sheetOpen,
    hasFullResults,
    needsFullResults,
    resultsAllQuery.data,
    resultsRegattaQuery.data,
  ]);

  // Only the current workspace can report loading/errors or be retried.
  const activeQueries = [
    ...(needSailors ? [sailorsQuery] : []),
    ...(needRegattas ? [regattasQuery] : []),
    ...(needCalendarEvents ? [calendarEventsQuery] : []),
    ...(isSuperadmin && needsFullResults ? [resultsAllQuery] : []),
    ...(needResultsEditor && selectedRegattaId ? [resultsRegattaQuery] : []),
  ];
  const dataLoading = activeQueries.some((query) => query.isFetching);
  // Keep the event form mounted while a newly selected class loads its rows.
  const workspaceQueries = activeQueries.filter((query) =>
    !sheetOpen || (query !== sailorsQuery && query !== resultsRegattaQuery));
  const dataReady = workspaceQueries.every((query) => query.data !== undefined);
  const resultsEditorReady = sailorsQuery.data !== undefined && resultsRegattaQuery.data !== undefined;
  const dataLoadError = activeQueries.find((query) => query.error instanceof Error)
    ?.error?.message ?? null;
  const retryActiveData = () => Promise.all(activeQueries.map((query) => query.refetch()));

  const setSailorList = useCallback(
    (updater: Updater<SailorAdmin[]>) => {
      queryClient.setQueryData<SailorAdmin[]>(
        adminQueryKeys.sailors(),
        (prev) => applyUpdater(prev ?? [], updater),
      );
    },
    [queryClient],
  );

  const setRegattaList = useCallback(
    (updater: Updater<RegattaAdmin[]>) => {
      queryClient.setQueryData<RegattaAdmin[]>(
        adminQueryKeys.regattas(),
        (prev) => applyUpdater(prev ?? [], updater),
      );
    },
    [queryClient],
  );

  const setResultsList = useCallback(
    (updater: Updater<ResultAdmin[]>) => {
      const next = applyUpdater(
        hasFullResults || needsFullResults
          ? (queryClient.getQueryData<ResultAdmin[]>(
              adminQueryKeys.resultsAll(),
            ) ?? [])
          : resultsList,
        updater,
      );

      if (hasFullResults || needsFullResults) {
        queryClient.setQueryData(adminQueryKeys.resultsAll(), next);
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
    [queryClient, hasFullResults, needsFullResults, resultsList],
  );

  const refreshResultsList = useCallback(
    async (opts?: { regattaId?: string }) => {
      if (opts?.regattaId) {
        const rows = await queryClient.fetchQuery({
          staleTime: 0,
          queryKey: adminQueryKeys.resultsByRegatta(opts.regattaId),
          queryFn: ({ signal }) => fetchAdminResultsForRegatta(opts.regattaId!, true, { signal }),
        });
        if (hasFullResults) {
          queryClient.setQueryData<ResultAdmin[]>(
            adminQueryKeys.resultsAll(),
            (prev) => {
              const others = (prev ?? []).filter(
                (r) => r.regattaId !== opts.regattaId,
              );
              return [...others, ...rows];
            },
          );
        }
        return;
      }
      await queryClient.fetchQuery({
        staleTime: 0,
        queryKey: adminQueryKeys.resultsAll(),
        queryFn: ({ signal }) => fetchAdminResultsAll({ signal }),
      });
    },
    [queryClient, hasFullResults],
  );

  const patchResultsFromImport = useCallback(
    (incoming: ResultAdmin[]) => {
      const touched = new Set(incoming.map((r) => r.regattaId));
      if (touched.size <= 1) {
        const rid = [...touched][0];
        if (!rid) return;
        queryClient.setQueryData(
          adminQueryKeys.resultsByRegatta(rid),
          incoming,
        );
        if (hasFullResults) {
          queryClient.setQueryData<ResultAdmin[]>(
            adminQueryKeys.resultsAll(),
            (prev) => {
              const others = (prev ?? []).filter((r) => r.regattaId !== rid);
              return [...others, ...incoming];
            },
          );
        }
      } else {
        queryClient.setQueryData(adminQueryKeys.resultsAll(), incoming);
      }
    },
    [queryClient, hasFullResults],
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
    [setRegattaList],
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
    [setRegattaList],
  );

  const patchSailorPartial = useCallback(
    (sailor: Partial<SailorAdmin> & { id: string }) => {
      setSailorList((prev) =>
        prev.map((s) => (s.id === sailor.id ? { ...s, ...sailor } : s)),
      );
    },
    [setSailorList],
  );

  /** Refetch sailors from the server (after bulk/merge/actions). */
  const invalidateSailors = useCallback(() => {
    void queryClient.invalidateQueries({ queryKey: adminQueryKeys.sailors() });
    invalidateAdminSummaries(queryClient);
  }, [queryClient]);

  const invalidateRegattas = useCallback(() => {
    void queryClient.invalidateQueries({ queryKey: adminQueryKeys.regattas() });
    void queryClient.invalidateQueries({
      queryKey: adminQueryKeys.regattaEvents(),
    });
    invalidateAdminSummaries(queryClient);
  }, [queryClient]);

  /** Invalidate all results caches (full + per-regatta). */
  const invalidateResults = useCallback(() => {
    void queryClient.invalidateQueries({ queryKey: ["admin", "results"] });
    invalidateAdminSummaries(queryClient);
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
    calendarEvents,
    calendarEventsReady:
      !needCalendarEvents ||
      calendarEventsQuery.isSuccess ||
      calendarEventsQuery.isError,
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
    dataLoading,
    dataReady,
    resultsEditorReady,
    dataLoadError,
    retryActiveData,
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
