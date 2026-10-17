"use client";
import { useMemo } from "react";
import { useQuery, useQueryClient, useMutation } from "@tanstack/react-query";
import type { SailorDuplicateDecision } from "@/lib/sailorDuplicateDecisions";

const queryKey = ["admin", "sailor-duplicate-decisions"];
export function useSailorDuplicateDecisions(enabled = true) {
  const client = useQueryClient();
  const query = useQuery({ queryKey, enabled, staleTime: 0, refetchInterval: 60_000,
    queryFn: async () => {
      const res = await fetch("/api/admin/sailors/duplicate-decisions", { cache: "no-store", credentials: "include" });
      const body = await res.json();
      if (!res.ok) throw new Error(body.error || "Could not load identity decisions.");
      return body.decisions as SailorDuplicateDecision[];
    } });
  const mutation = useMutation({
    mutationFn: async (input: { aId: string; bId: string; reason: string; separate: boolean }) => {
      const res = await fetch("/api/admin/sailors/duplicate-decisions", { method: "POST", credentials: "include",
        headers: { "Content-Type": "application/json" }, body: JSON.stringify(input) });
      const body = await res.json();
      if (!res.ok) throw new Error(body.error || "Could not save identity decision.");
    },
    onSuccess: async () => { await client.invalidateQueries({ queryKey }); await client.invalidateQueries({ queryKey: ["admin", "overview"] }); },
  });
  const decisions = query.data;
  const keys = useMemo(() => new Set((decisions ?? []).map(d => d.pairKey)), [decisions]);
  return { decisions: decisions ?? [], keys, save: mutation.mutateAsync, loading: query.isPending, error: query.error, saving: mutation.isPending };
}
