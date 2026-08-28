"use client";

import { useState } from "react";
import { useQuery, useQueryClient } from "@tanstack/react-query";
import { CheckCircle, GraduationCap, Mail, XCircle } from "lucide-react";
import { adminQueryKeys } from "@/components/admin/adminQueryKeys";
import { AdminEmptyState } from "@/components/admin/AdminEmptyState";
import { useFeedback } from "@/components/ui/FeedbackProvider";

export type CoachAccessRow = {
  id: string;
  requesterId: string;
  status: "pending" | "approved" | "rejected";
  requestedAt: string;
  reviewedAt: string | null;
  requesterName: string;
  requesterEmail: string;
  requesterRole: string;
};

export function CoachAccessAdminPanel({ isSuperadmin }: { isSuperadmin: boolean }) {
  const { toast, confirm } = useFeedback();
  const queryClient = useQueryClient();
  const [filter, setFilter] = useState<CoachAccessRow["status"] | "all">("pending");
  const [busyId, setBusyId] = useState<string | null>(null);
  const query = useQuery({
    queryKey: adminQueryKeys.coachAccess(),
    enabled: isSuperadmin,
    queryFn: async () => {
      const res = await fetch("/api/admin/coach-access");
      const data = await res.json();
      if (!res.ok) throw new Error(data.error || "Failed to load coach requests");
      return (data.requests || []) as CoachAccessRow[];
    },
  });

  const update = async (row: CoachAccessRow, action: "approve" | "reject") => {
    if (action === "approve") {
      const ok = await confirm({
        title: `Approve ${row.requesterName}?`,
        message: "This grants access to the private Coach Dashboard and squad tools.",
        confirmLabel: "Approve coach",
      });
      if (!ok) return;
    }
    setBusyId(row.id);
    try {
      const res = await fetch("/api/admin/coach-access", {
        method: "PATCH",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({ id: row.id, action }),
      });
      const data = await res.json();
      if (!res.ok) throw new Error(data.error || "Update failed");
      await queryClient.invalidateQueries({ queryKey: adminQueryKeys.coachAccess() });
      toast.success(action === "approve" ? "Coach access approved" : "Coach request rejected");
    } catch (err) {
      toast.error(err instanceof Error ? err.message : "Update failed");
    } finally {
      setBusyId(null);
    }
  };

  if (!isSuperadmin) {
    return <p className="text-sm text-slate-500">Coach access approvals require superadmin.</p>;
  }

  const requests = query.data ?? [];
  const visible = requests.filter((row) => filter === "all" || row.status === filter);

  return (
    <div className="space-y-4">
      <div className="glass-panel rounded-2xl border border-white/5 p-5">
        <h3 className="flex items-center gap-2 text-sm font-bold uppercase tracking-wider text-white">
          <GraduationCap className="h-4 w-4 text-orange-500" />
          Coach access
        </h3>
        <p className="mt-1 text-xs leading-relaxed text-slate-500">
          Approving changes the account role to Coach and unlocks its private squad dashboard.
          Signup alone never grants coach permissions.
        </p>
      </div>

      <div className="flex flex-wrap gap-2">
        {(["pending", "approved", "rejected", "all"] as const).map((item) => (
          <button
            key={item}
            type="button"
            onClick={() => setFilter(item)}
            className={`rounded-full px-3 py-1.5 text-[11px] font-bold capitalize ${filter === item ? "bg-orange-600 text-white" : "border border-white/10 bg-white/5 text-slate-400"}`}
          >
            {item}
            {item !== "all" && ` (${requests.filter((row) => row.status === item).length})`}
          </button>
        ))}
      </div>

      {query.isFetching && <p className="text-xs text-slate-500">Loading…</p>}
      {query.error instanceof Error && <p className="text-xs text-rose-400">{query.error.message}</p>}
      {!query.isFetching && visible.length === 0 && (
        <AdminEmptyState
          icon={GraduationCap}
          title="No coach requests"
          description={filter === "pending" ? "New coach access requests will appear here." : `No ${filter} requests.`}
        />
      )}

      <div className="space-y-3">
        {visible.map((row) => (
          <div key={row.id} className="glass-card grid gap-4 rounded-xl border border-white/5 p-4 sm:grid-cols-[1fr_auto] sm:items-center">
            <div className="min-w-0">
              <p className="font-bold text-white">{row.requesterName}</p>
              <p className="mt-1 flex items-center gap-1.5 text-xs text-slate-400">
                <Mail className="h-3.5 w-3.5" />
                <span className="truncate">{row.requesterEmail}</span>
              </p>
              <p className="mt-2 text-[10px] uppercase tracking-wider text-slate-500">
                Requested {new Date(row.requestedAt).toLocaleDateString("en-SG")} · Current role: {row.requesterRole}
              </p>
            </div>
            <div className="flex flex-wrap gap-2">
              {row.status === "pending" ? (
                <>
                  <button type="button" disabled={busyId === row.id} onClick={() => void update(row, "approve")} className="inline-flex items-center gap-1.5 rounded-full bg-emerald-600 px-4 py-2 text-xs font-bold text-white hover:bg-emerald-500 disabled:opacity-50">
                    <CheckCircle className="h-3.5 w-3.5" /> Approve
                  </button>
                  <button type="button" disabled={busyId === row.id} onClick={() => void update(row, "reject")} className="inline-flex items-center gap-1.5 rounded-full border border-rose-500/30 bg-rose-500/10 px-4 py-2 text-xs font-bold text-rose-300 hover:bg-rose-500/20 disabled:opacity-50">
                    <XCircle className="h-3.5 w-3.5" /> Reject
                  </button>
                </>
              ) : (
                <span className={`rounded-full px-3 py-1.5 text-[10px] font-black uppercase ${row.status === "approved" ? "border border-emerald-500/25 bg-emerald-500/10 text-emerald-300" : "border border-white/10 bg-white/5 text-slate-400"}`}>
                  {row.status}
                </span>
              )}
            </div>
          </div>
        ))}
      </div>
    </div>
  );
}
