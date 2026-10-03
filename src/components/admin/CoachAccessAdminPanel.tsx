"use client";

import { useState } from "react";
import { useQuery, useQueryClient } from "@tanstack/react-query";
import {
  CheckCircle,
  GraduationCap,
  Mail,
  Search,
  UserCheck,
  UserMinus,
  UserPlus,
  XCircle,
} from "lucide-react";
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
  source?: "user" | "admin" | null;
};

export type ActiveCoachUser = {
  id: string;
  email: string;
  fullName: string;
  role: string;
  createdAt: string;
};

type UserSearchResult = {
  id: string;
  email: string;
  fullName: string;
  role: string;
  createdAt: string;
};

export function CoachAccessAdminPanel({ isSuperadmin }: { isSuperadmin: boolean }) {
  const { toast, confirm } = useFeedback();
  const queryClient = useQueryClient();
  const [filter, setFilter] = useState<CoachAccessRow["status"] | "all" | "active_coaches">("pending");
  const [busyId, setBusyId] = useState<string | null>(null);

  const query = useQuery({
    queryKey: adminQueryKeys.coachAccess(),
    enabled: isSuperadmin,
    queryFn: async () => {
      const res = await fetch("/api/admin/coach-access");
      const data = await res.json();
      if (!res.ok) throw new Error(data.error || "Failed to load coach requests");
      return {
        requests: (data.requests || []) as CoachAccessRow[],
        coaches: (data.coaches || []) as ActiveCoachUser[],
      };
    },
  });

  // Direct user search state
  const [userSearch, setUserSearch] = useState("");
  const trimmedSearch = userSearch.trim();

  const userSearchQuery = useQuery({
    queryKey: ["admin", "users", trimmedSearch],
    enabled: isSuperadmin && trimmedSearch.length >= 2,
    queryFn: async () => {
      const res = await fetch(`/api/admin/users?q=${encodeURIComponent(trimmedSearch)}`);
      const data = await res.json();
      if (!res.ok) throw new Error(data.error || "Failed to search users");
      return (data.users || []) as UserSearchResult[];
    },
  });

  const searchResults = trimmedSearch.length >= 2 ? userSearchQuery.data ?? [] : [];
  const isSearching = userSearchQuery.isFetching;

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

  const handleDirectRoleChange = async (
    targetUser: { id: string; fullName: string; email: string; role: string },
    action: "assign" | "revoke"
  ) => {
    const isAssign = action === "assign";
    const ok = await confirm({
      title: isAssign ? `Assign ${targetUser.fullName} as Coach?` : `Revoke Coach role from ${targetUser.fullName}?`,
      message: isAssign
        ? `This emails ${targetUser.email} links to accept or decline. Coach tools stay off until they accept.`
        : `This will revert ${targetUser.email}'s account role to Sailor and remove coach dashboard access.`,
      confirmLabel: isAssign ? "Assign as Coach" : "Revoke Coach",
      tone: isAssign ? "default" : "danger",
    });
    if (!ok) return;

    setBusyId(targetUser.id);
    try {
      const res = await fetch("/api/admin/coach-access", {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({ userId: targetUser.id, action }),
      });
      const data = await res.json();
      if (!res.ok) throw new Error(data.error || "Failed to update user role");

      await queryClient.invalidateQueries({ queryKey: adminQueryKeys.coachAccess() });
      await queryClient.invalidateQueries({ queryKey: ["admin", "users"] });
      toast.success(
        isAssign
          ? data.alreadyCoach
            ? `${targetUser.fullName} is already a Coach.`
            : `Invitation sent to ${targetUser.email}. They can accept or decline from the email.`
          : `Revoked Coach role from ${targetUser.fullName}`
      );
    } catch (err) {
      toast.error(err instanceof Error ? err.message : "Role update failed");
    } finally {
      setBusyId(null);
    }
  };

  if (!isSuperadmin) {
    return <p className="text-sm text-slate-500">Coach access approvals require superadmin.</p>;
  }

  const requests = query.data?.requests ?? [];
  const coaches = query.data?.coaches ?? [];
  const visible = requests.filter((row) => filter === "all" || row.status === filter);

  return (
    <div className="space-y-6">
      {/* Overview & explanation */}
      <div className="glass-panel rounded-2xl border border-white/5 p-5">
        <h3 className="flex items-center gap-2 text-sm font-bold uppercase tracking-wider text-white">
          <GraduationCap className="h-4 w-4 text-orange-500" />
          Coach Access & Management
        </h3>
        <p className="mt-1 text-xs leading-relaxed text-slate-400">
          Coaches receive access to private squad athlete monitoring, coach notes, and selection analytics.
          You can approve requests the user submitted, or email any registered user so they can accept or decline coach access.
        </p>
      </div>

      {/* Direct User Assignment Tool */}
      <div className="glass-panel rounded-2xl border border-white/10 bg-white/[0.03] p-5 space-y-3">
        <div className="flex items-center gap-2">
          <UserPlus className="h-4 w-4 text-[var(--sp-harbour-teal)]" />
          <h4 className="text-xs font-bold uppercase tracking-wider text-white">
            Directly Assign User as Coach
          </h4>
        </div>
        <p className="text-xs text-slate-400 leading-relaxed">
          Search any user by name or email. They get an email with Accept and Decline links before the account becomes a Coach.
        </p>

        <div className="relative">
          <Search className="pointer-events-none absolute left-3 top-2.5 h-4 w-4 text-slate-400" />
          <input
            type="search"
            value={userSearch}
            onChange={(e) => setUserSearch(e.target.value)}
            placeholder="Search by user name or email (min. 2 characters)…"
            className="w-full rounded-xl border border-white/10 bg-black/40 pl-9 pr-3 py-2 text-xs text-white placeholder:text-slate-500 focus:border-[var(--sp-harbour-teal)] focus:outline-none focus:ring-1 focus:ring-[var(--sp-harbour-teal)]"
          />
        </div>

        {isSearching && <p className="text-xs text-slate-400 animate-pulse">Searching users…</p>}

        {searchResults.length > 0 && (
          <div className="divide-y divide-white/5 rounded-xl border border-white/10 bg-black/30 overflow-hidden">
            {searchResults.map((user) => {
              const isCoach = user.role === "coach";
              const isSuper = user.role === "superadmin";
              const isBusy = busyId === user.id;

              return (
                <div
                  key={user.id}
                  className="flex flex-col sm:flex-row sm:items-center justify-between gap-3 p-3 hover:bg-white/[0.02]"
                >
                  <div className="min-w-0">
                    <p className="font-semibold text-xs text-white flex items-center gap-2">
                      <span>{user.fullName}</span>
                      <span
                        className={`rounded-full px-2 py-0.5 text-[10px] font-bold uppercase tracking-wide ${
                          isCoach
                            ? "bg-emerald-500/20 text-emerald-300 border border-emerald-500/30"
                            : isSuper
                              ? "bg-purple-500/20 text-purple-300 border border-purple-500/30"
                              : "bg-white/10 text-slate-400"
                        }`}
                      >
                        {user.role}
                      </span>
                    </p>
                    <p className="text-[11px] text-slate-400 truncate flex items-center gap-1.5 mt-0.5">
                      <Mail className="h-3 w-3 text-slate-500" />
                      {user.email}
                    </p>
                  </div>

                  <div className="shrink-0 flex items-center gap-2">
                    {isSuper ? (
                      <span className="text-[11px] text-slate-500 font-medium px-2 py-1">
                        Superadmin
                      </span>
                    ) : isCoach ? (
                      <div className="flex items-center gap-2">
                        <span className="inline-flex items-center gap-1 text-[11px] font-bold text-emerald-400">
                          <UserCheck className="h-3.5 w-3.5" />
                          Active Coach
                        </span>
                        <button
                          type="button"
                          disabled={isBusy}
                          onClick={() => void handleDirectRoleChange(user, "revoke")}
                          className="inline-flex items-center gap-1 rounded-full border border-rose-500/30 bg-rose-500/10 px-3 py-1 text-[11px] font-bold text-rose-300 hover:bg-rose-500/20 disabled:opacity-50"
                        >
                          <UserMinus className="h-3 w-3" />
                          Revoke
                        </button>
                      </div>
                    ) : (
                      <button
                        type="button"
                        disabled={isBusy}
                        onClick={() => void handleDirectRoleChange(user, "assign")}
                        className="inline-flex items-center gap-1.5 rounded-full bg-[var(--sp-harbour-teal)] hover:bg-[#16505c] px-3.5 py-1.5 text-xs font-bold text-white disabled:opacity-50 transition"
                      >
                        <UserPlus className="h-3.5 w-3.5" />
                        Assign as Coach
                      </button>
                    )}
                  </div>
                </div>
              );
            })}
          </div>
        )}

        {userSearch.trim().length >= 2 && !isSearching && searchResults.length === 0 && (
          <p className="text-xs text-slate-500 py-1">No users found matching &quot;{userSearch}&quot;.</p>
        )}
      </div>

      {/* Filter Tabs */}
      <div className="flex flex-wrap gap-2">
        <button
          type="button"
          onClick={() => setFilter("pending")}
          className={`rounded-full px-3 py-1.5 text-[13px] font-bold capitalize ${
            filter === "pending"
              ? "bg-[var(--sp-harbour-teal)] text-white"
              : "border border-white/10 bg-white/5 text-slate-400"
          }`}
        >
          Pending Requests ({requests.filter((r) => r.status === "pending").length})
        </button>

        <button
          type="button"
          onClick={() => setFilter("active_coaches")}
          className={`rounded-full px-3 py-1.5 text-[13px] font-bold capitalize ${
            filter === "active_coaches"
              ? "bg-emerald-600 text-white"
              : "border border-white/10 bg-white/5 text-slate-400"
          }`}
        >
          Active Coaches ({coaches.length})
        </button>

        <button
          type="button"
          onClick={() => setFilter("approved")}
          className={`rounded-full px-3 py-1.5 text-[13px] font-bold capitalize ${
            filter === "approved"
              ? "bg-[var(--sp-harbour-teal)] text-white"
              : "border border-white/10 bg-white/5 text-slate-400"
          }`}
        >
          Approved ({requests.filter((r) => r.status === "approved").length})
        </button>

        <button
          type="button"
          onClick={() => setFilter("rejected")}
          className={`rounded-full px-3 py-1.5 text-[13px] font-bold capitalize ${
            filter === "rejected"
              ? "bg-[var(--sp-harbour-teal)] text-white"
              : "border border-white/10 bg-white/5 text-slate-400"
          }`}
        >
          Rejected ({requests.filter((r) => r.status === "rejected").length})
        </button>

        <button
          type="button"
          onClick={() => setFilter("all")}
          className={`rounded-full px-3 py-1.5 text-[13px] font-bold capitalize ${
            filter === "all"
              ? "bg-[var(--sp-harbour-teal)] text-white"
              : "border border-white/10 bg-white/5 text-slate-400"
          }`}
        >
          All Requests ({requests.length})
        </button>
      </div>

      {query.isFetching && <p className="text-xs text-slate-500">Loading…</p>}
      {query.error instanceof Error && <p className="text-xs text-rose-400">{query.error.message}</p>}

      {/* Active Coaches view */}
      {filter === "active_coaches" && (
        <div className="space-y-3">
          {coaches.length === 0 ? (
            <AdminEmptyState
              icon={GraduationCap}
              title="No active coaches"
              description="No users currently have the Coach role. Use the search bar above to assign a user as coach."
            />
          ) : (
            coaches.map((coach) => (
              <div
                key={coach.id}
                className="glass-card grid gap-4 rounded-xl border border-emerald-500/20 bg-emerald-950/10 p-4 sm:grid-cols-[1fr_auto] sm:items-center"
              >
                <div className="min-w-0">
                  <div className="flex items-center gap-2">
                    <p className="font-bold text-white text-sm">{coach.fullName}</p>
                    <span className="rounded-full bg-emerald-500/20 text-emerald-300 border border-emerald-500/30 px-2 py-0.5 text-[10px] font-bold uppercase">
                      Coach
                    </span>
                  </div>
                  <p className="mt-1 flex items-center gap-1.5 text-xs text-slate-400">
                    <Mail className="h-3.5 w-3.5" />
                    <span className="truncate">{coach.email}</span>
                  </p>
                  <p className="mt-1.5 text-[11px] uppercase tracking-wider text-slate-500">
                    Joined {new Date(coach.createdAt).toLocaleDateString("en-SG")}
                  </p>
                </div>

                <div>
                  <button
                    type="button"
                    disabled={busyId === coach.id}
                    onClick={() => void handleDirectRoleChange(coach, "revoke")}
                    className="inline-flex items-center gap-1.5 rounded-full border border-rose-500/30 bg-rose-500/10 px-4 py-2 text-xs font-bold text-rose-300 hover:bg-rose-500/20 disabled:opacity-50 transition"
                  >
                    <UserMinus className="h-3.5 w-3.5" />
                    Revoke Coach Access
                  </button>
                </div>
              </div>
            ))
          )}
        </div>
      )}

      {/* Requests view */}
      {filter !== "active_coaches" && (
        <>
          {!query.isFetching && visible.length === 0 && (
            <AdminEmptyState
              icon={GraduationCap}
              title="No coach requests"
              description={
                filter === "pending"
                  ? "New coach access requests will appear here."
                  : `No ${filter} requests.`
              }
            />
          )}

          <div className="space-y-3">
            {visible.map((row) => (
              <div
                key={row.id}
                className="glass-card grid gap-4 rounded-xl border border-white/5 p-4 sm:grid-cols-[1fr_auto] sm:items-center"
              >
                <div className="min-w-0">
                  <p className="font-bold text-white">{row.requesterName}</p>
                  <p className="mt-1 flex items-center gap-1.5 text-xs text-slate-400">
                    <Mail className="h-3.5 w-3.5" />
                    <span className="truncate">{row.requesterEmail}</span>
                  </p>
                  <p className="mt-2 text-[12px] uppercase tracking-wider text-slate-500">
                    Requested {new Date(row.requestedAt).toLocaleDateString("en-SG")} · Current role: {row.requesterRole}
                  </p>
                </div>
                <div className="flex flex-wrap gap-2">
                  {row.status === "pending" && row.source === "admin" ? (
                    <div className="space-y-2">
                      <p className="text-[12px] font-semibold text-amber-200">
                        Waiting for {row.requesterEmail} to accept or decline the email.
                      </p>
                      <button
                        type="button"
                        disabled={busyId === row.id}
                        onClick={() => void update(row, "reject")}
                        className="inline-flex items-center gap-1.5 rounded-full border border-rose-500/30 bg-rose-500/10 px-4 py-2 text-xs font-bold text-rose-300 hover:bg-rose-500/20 disabled:opacity-50"
                      >
                        <XCircle className="h-3.5 w-3.5" /> Cancel invitation
                      </button>
                    </div>
                  ) : row.status === "pending" ? (
                    <>
                      <button
                        type="button"
                        disabled={busyId === row.id}
                        onClick={() => void update(row, "approve")}
                        className="inline-flex items-center gap-1.5 rounded-full bg-emerald-600 px-4 py-2 text-xs font-bold text-white hover:bg-emerald-500 disabled:opacity-50"
                      >
                        <CheckCircle className="h-3.5 w-3.5" /> Approve
                      </button>
                      <button
                        type="button"
                        disabled={busyId === row.id}
                        onClick={() => void update(row, "reject")}
                        className="inline-flex items-center gap-1.5 rounded-full border border-rose-500/30 bg-rose-500/10 px-4 py-2 text-xs font-bold text-rose-300 hover:bg-rose-500/20 disabled:opacity-50"
                      >
                        <XCircle className="h-3.5 w-3.5" /> Reject
                      </button>
                    </>
                  ) : (
                    <span
                      className={`rounded-full px-3 py-1.5 text-[12px] font-black uppercase ${
                        row.status === "approved"
                          ? "border border-emerald-500/25 bg-emerald-500/10 text-emerald-300"
                          : "border border-white/10 bg-white/5 text-slate-400"
                      }`}
                    >
                      {row.status}
                    </span>
                  )}
                </div>
              </div>
            ))}
          </div>
        </>
      )}
    </div>
  );
}
