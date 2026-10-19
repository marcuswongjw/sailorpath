"use client";

import { useRef, useState, type Dispatch, type SetStateAction } from "react";
import { fetchAdminRegattas } from "./adminFetch";
import type { RegattaAdmin } from "@/types/regatta";

type UseAdminCompetitionsArgs = {
  refreshResultsList: (opts?: { regattaId?: string }) => Promise<void>;
  setRegattaList: Dispatch<SetStateAction<RegattaAdmin[]>>;
  setEditingResultId: Dispatch<SetStateAction<string | null>>;
};

/**
 * Per-sailor competitions modal open/close + data refresh.
 * Caller should clear editingSailorId when opening (sailors hook does this).
 */
export function useAdminCompetitions({
  refreshResultsList,
  setRegattaList,
  setEditingResultId,
}: UseAdminCompetitionsArgs) {
  const [competitionsSailorId, setCompetitionsSailorId] = useState<
    string | null
  >(null);
  const [competitionsLoading, setCompetitionsLoading] = useState(false);
  const [competitionsError, setCompetitionsError] = useState<string | null>(null);
  const requestVersion = useRef(0);

  const openSailorResults = async (sailorId: string) => {
    const version = ++requestVersion.current;
    setEditingResultId(null);
    setCompetitionsError(null);
    setCompetitionsSailorId(sailorId);
    setCompetitionsLoading(true);
    try {
      // Refresh results + regattas so ILCA 4 events appear alongside Optimist
      const reads = await Promise.allSettled([
        refreshResultsList(),
        fetchAdminRegattas().then((rows) => setRegattaList(rows)),
      ]);
      const failure = reads.find((read) => read.status === "rejected");
      if (failure?.status === "rejected") throw failure.reason;
    } catch (error) {
      if (version === requestVersion.current) {
        setCompetitionsError(error instanceof Error ? error.message : "Could not load sailor results.");
      }
    } finally {
      if (version === requestVersion.current) setCompetitionsLoading(false);
    }
  };

  const closeSailorResults = () => {
    requestVersion.current++;
    setCompetitionsLoading(false);
    setCompetitionsError(null);
    setCompetitionsSailorId(null);
    setEditingResultId(null);
  };

  return {
    competitionsSailorId,
    setCompetitionsSailorId,
    competitionsLoading,
    competitionsError,
    openSailorResults,
    closeSailorResults,
  };
}
