"use client";

import { useState, type Dispatch, type SetStateAction } from "react";
import { parseApi } from "@/components/admin/parseApi";
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

  const openSailorResults = async (sailorId: string) => {
    setEditingResultId(null);
    setCompetitionsSailorId(sailorId);
    setCompetitionsLoading(true);
    try {
      // Refresh results + regattas so ILCA 4 events appear alongside Optimist
      await Promise.all([
        refreshResultsList(),
        (async () => {
          try {
            const res = await fetch("/api/admin/regattas?all=1", {
              credentials: "include",
            });
            const data = await parseApi(res);
            if (res.ok && Array.isArray(data.regattas)) {
              setRegattaList(data.regattas);
            }
          } catch {
            /* keep existing list */
          }
        })(),
      ]);
    } finally {
      setCompetitionsLoading(false);
    }
  };

  const closeSailorResults = () => {
    setCompetitionsSailorId(null);
    setEditingResultId(null);
  };

  return {
    competitionsSailorId,
    setCompetitionsSailorId,
    competitionsLoading,
    openSailorResults,
    closeSailorResults,
  };
}
