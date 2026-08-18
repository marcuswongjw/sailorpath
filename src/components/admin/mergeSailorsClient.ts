"use client";

import type { Dispatch, SetStateAction } from "react";
import { parseApi, apiErr, apiStr, apiNum } from "@/components/admin/parseApi";
import type { SailorAdmin } from "@/types/sailor";
import type { ResultAdmin } from "@/types/result";

export type MergeSailorsResponse = {
  message?: string;
  keep?: SailorAdmin;
  resultsMoved?: number;
  resultsMergedConflict?: number;
  resultsDroppedConflict?: number;
  error?: string;
};

type MergeArgs = {
  keepId: string;
  mergeId: string;
  setSailorList: Dispatch<SetStateAction<SailorAdmin[]>>;
  setResultsList: Dispatch<SetStateAction<ResultAdmin[]>>;
  /**
   * When provided, refresh results from the API after merge (bulk / Database path).
   * When omitted, remap `sailorId` locally (ILCA onMergePair path).
   */
  refreshResultsList?: () => Promise<void>;
};

/**
 * Shared POST /api/admin/sailors/merge + list updates.
 * Used by Database merge and ILCA ranking onMergePair.
 */
export async function mergeSailorsClient(
  args: MergeArgs
): Promise<MergeSailorsResponse> {
  const { keepId, mergeId, setSailorList, setResultsList, refreshResultsList } =
    args;

  const res = await fetch("/api/admin/sailors/merge", {
    method: "POST",
    headers: { "Content-Type": "application/json" },
    body: JSON.stringify({ keepId, mergeId }),
  });
  const data = await parseApi(res);
  if (!res.ok) throw new Error(apiErr(data, "Merge failed"));

  const keep =
    data.keep && typeof data.keep === "object"
      ? (data.keep as SailorAdmin)
      : undefined;

  setSailorList((prev) => {
    const without = prev.filter((s) => s.id !== mergeId);
    return without.map((s) => (s.id === keepId && keep ? keep : s));
  });

  if (refreshResultsList) {
    try {
      await refreshResultsList();
    } catch {
      /* ignore */
    }
  } else {
    setResultsList((prev) =>
      prev.map((r) =>
        r.sailorId === mergeId ? { ...r, sailorId: keepId } : r
      )
    );
  }

  return {
    message: apiStr(data, "message"),
    keep,
    resultsMoved: apiNum(data, "resultsMoved"),
    resultsMergedConflict: apiNum(data, "resultsMergedConflict"),
    resultsDroppedConflict: apiNum(data, "resultsDroppedConflict"),
    error: apiStr(data, "error"),
  };
}
