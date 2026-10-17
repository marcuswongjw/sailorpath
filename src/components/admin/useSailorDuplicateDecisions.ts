"use client";
import { useMemo } from "react";
import { useQuery, useQueryClient, useMutation } from "@tanstack/react-query";
import { useFeedback } from "@/components/ui/FeedbackProvider";
import type { SailorDuplicateDecision } from "@/lib/sailorDuplicateDecisions";

const queryKey = ["admin", "sailor-duplicate-decisions"];
export function useSailorDuplicateDecisions(enabled = true) {
  const client = useQueryClient();
  const { toast } = useFeedback();
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
  const decide = async (aId: string, bId: string, separate = true) => {
    const reason = window.prompt(separate
      ? "Confirm these are different sailors. Enter the source evidence or reason (at least 10 characters). This decision is shared with all administrators."
      : "Why should this pair be reopened for identity review? (At least 10 characters)");
    if (reason === null) return;
    if (reason.trim().length < 10 || reason.trim().length > 2000) { toast.error("Enter a reason of 10–2000 characters."); return; }
    try { await mutation.mutateAsync({ aId, bId, separate, reason: reason.trim() });
      toast.success(separate ? "Saved: confirmed different sailors." : "Pair reopened for review.");
    } catch (error) { toast.error(error instanceof Error ? error.message : "Could not save identity decision."); }
  };
  const decisions = query.data;
  const keys = useMemo(() => new Set((decisions ?? []).map(d => d.pairKey)), [decisions]);
  return { decisions: decisions ?? [], keys, decide, loading: query.isPending, error: query.error, saving: mutation.isPending };
}
