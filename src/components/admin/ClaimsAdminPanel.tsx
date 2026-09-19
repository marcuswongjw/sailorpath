"use client";

import { useState, useEffect } from "react";
import Link from "next/link";
import { useQuery } from "@tanstack/react-query";
import {
  UserCheck,
  CheckCircle,
  XCircle,
  Mail,
  ShieldQuestion,
  Save,
  Unlink,
  UserPlus,
  X,
  Search,
} from "lucide-react";
import {
  relationLabel,
  type ClaimRelation,
} from "@/lib/claimRelation";
import { useFeedback } from "@/components/ui/FeedbackProvider";
import { AdminEmptyState } from "@/components/admin/AdminEmptyState";
import { Inbox } from "lucide-react";
import { adminQueryKeys } from "@/components/admin/adminQueryKeys";

type ClaimRow = {
  id: string;
  sailorId: string;
  status: string;
  relation?: string | null;
  effectiveRelation?: ClaimRelation | null;
  note: string | null;
  sailorName: string;
  sailorHandle: string;
  sailorSailNumber?: string | null;
  sailorClub?: string | null;
  sailorOwnerRelation?: string | null;
  requesterEmail: string;
  requesterName: string;
  requesterRole?: string | null;
  createdAt: string;
};

const RELATIONS: ClaimRelation[] = ["parent", "sailor", "other"];

export function ClaimsAdminPanel({ isSuperadmin }: { isSuperadmin: boolean }) {
  const { toast, confirm } = useFeedback();
  const [filter, setFilter] = useState<
    "all" | "pending" | "approved" | "rejected"
  >("pending");
  /** Per-claim relation selection before approve / update */
  const [relationDraft, setRelationDraft] = useState<
    Record<string, ClaimRelation>
  >({});
  const [busyId, setBusyId] = useState<string | null>(null);

  // Assign user to sailor state
  const [isAssignOpen, setIsAssignOpen] = useState(false);
  const [assignUserId, setAssignUserId] = useState("");
  const [assignUserQuery, setAssignUserQuery] = useState("");
  const [assignUsers, setAssignUsers] = useState<
    Array<{ id: string; email: string; fullName: string; role: string }>
  >([]);
  const [assignUserLoading, setAssignUserLoading] = useState(false);
  const [selectedUser, setSelectedUser] = useState<{
    id: string;
    email: string;
    fullName: string;
  } | null>(null);

  const [assignSailorId, setAssignSailorId] = useState("");
  const [assignSailorQuery, setAssignSailorQuery] = useState("");
  const [assignSailors, setAssignSailors] = useState<
    Array<{ id: string; name: string; sailNumber: string | null; club: string | null }>
  >([]);
  const [assignSailorLoading, setAssignSailorLoading] = useState(false);
  const [selectedSailor, setSelectedSailor] = useState<{
    id: string;
    name: string;
    sailNumber: string | null;
    club: string | null;
  } | null>(null);

  const [assignRelation, setAssignRelation] = useState<ClaimRelation>("parent");
  const [assignNote, setAssignNote] = useState("");
  const [isSubmittingAssign, setIsSubmittingAssign] = useState(false);

  useEffect(() => {
    const trimmed = assignUserQuery.trim();
    if (trimmed.length < 2) {
      const timer = window.setTimeout(() => setAssignUsers([]), 0);
      return () => window.clearTimeout(timer);
    }
    const timer = window.setTimeout(async () => {
      setAssignUserLoading(true);
      try {
        const res = await fetch(`/api/admin/users?q=${encodeURIComponent(trimmed)}`);
        const data = await res.json();
        setAssignUsers(data.users || []);
      } catch {
        setAssignUsers([]);
      } finally {
        setAssignUserLoading(false);
      }
    }, 250);
    return () => window.clearTimeout(timer);
  }, [assignUserQuery]);

  useEffect(() => {
    const trimmed = assignSailorQuery.trim();
    if (trimmed.length < 2) {
      const timer = window.setTimeout(() => setAssignSailors([]), 0);
      return () => window.clearTimeout(timer);
    }
    const timer = window.setTimeout(async () => {
      setAssignSailorLoading(true);
      try {
        const res = await fetch(`/api/admin/sailors?q=${encodeURIComponent(trimmed)}&limit=15`);
        const data = await res.json();
        setAssignSailors(data.sailors || []);
      } catch {
        setAssignSailors([]);
      } finally {
        setAssignSailorLoading(false);
      }
    }, 250);
    return () => window.clearTimeout(timer);
  }, [assignSailorQuery]);

  const resetAssignForm = () => {
    setSelectedUser(null);
    setSelectedSailor(null);
    setAssignUserId("");
    setAssignSailorId("");
    setAssignUserQuery("");
    setAssignSailorQuery("");
    setAssignUsers([]);
    setAssignSailors([]);
    setAssignNote("");
    setAssignRelation("parent");
  };

  const handleAssignSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    if (!assignUserId || !assignSailorId) {
      toast.error("Please select both a user account and a sailor profile.");
      return;
    }
    setIsSubmittingAssign(true);
    try {
      const res = await fetch("/api/admin/claims", {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({
          userId: assignUserId,
          sailorId: assignSailorId,
          relation: assignRelation,
          note: assignNote || "Assigned directly by admin",
        }),
      });
      const data = await res.json();
      if (!res.ok) throw new Error(data.error || "Failed to assign user to sailor");
      toast.success(
        `Assigned ${selectedUser?.email || "user"} to ${selectedSailor?.name || "sailor"} as ${assignRelation}!`
      );
      setIsAssignOpen(false);
      resetAssignForm();
      await claimsQuery.refetch();
    } catch (err: unknown) {
      toast.error(err instanceof Error ? err.message : "Assignment failed");
    } finally {
      setIsSubmittingAssign(false);
    }
  };

  const claimsQuery = useQuery({
    queryKey: adminQueryKeys.claims(),
    enabled: isSuperadmin,
    queryFn: async () => {
      const res = await fetch("/api/admin/claims");
      const data = await res.json();
      if (!res.ok) throw new Error(data.error || "Failed to load claims");
      return (data.claims || []) as ClaimRow[];
    },
  });
  const claims = claimsQuery.data ?? [];
  const loading = claimsQuery.isFetching;
  const error =
    claimsQuery.error instanceof Error ? claimsQuery.error.message : null;

  const patch = async (
    id: string,
    body: Record<string, unknown>
  ): Promise<void> => {
    if (!isSuperadmin) {
      toast.error("Superadmin only");
      return;
    }
    setBusyId(id);
    try {
      const res = await fetch("/api/admin/claims", {
        method: "PATCH",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({ id, ...body }),
      });
      const data = await res.json();
      if (!res.ok) throw new Error(data.error || "Update failed");
      await claimsQuery.refetch();
    } catch (e: unknown) {
      toast.error(e instanceof Error ? e.message : "Failed");
    } finally {
      setBusyId(null);
    }
  };

  const visible = claims.filter((c) =>
    filter === "all" ? true : c.status === filter
  );

  return (
    <div className="w-full min-w-0 space-y-4">
      <div className="glass-panel rounded-2xl border border-white/5 p-5 w-full">
        <h3 className="text-sm font-bold text-white flex items-center gap-2 uppercase tracking-wider">
          <UserCheck className="h-4 w-4 text-orange-500" />
          Profile claim requests
        </h3>
        <p className="text-xs text-slate-500 mt-1 leading-relaxed">
          Set <strong className="text-slate-300">Parent</strong> or{" "}
          <strong className="text-slate-300">Sailor</strong> when approving.
          That updates account role (except superadmin) and how the owner
          dashboard is labelled. You can change the role later on approved
          claims.
        </p>
      </div>

      <div className="glass-panel rounded-2xl border border-sky-500/20 bg-sky-500/[0.04] p-5 w-full">
        <h4 className="text-xs font-black text-sky-300 uppercase tracking-wider flex items-center gap-2">
          <ShieldQuestion className="h-4 w-4" />
          How to verify a claim
        </h4>
        <ul className="mt-3 space-y-2 text-[11px] text-slate-400 leading-relaxed">
          <li>
            <strong className="text-slate-200">1. Email identity</strong> —
            match signup email to a known parent/sailor contact.
          </li>
          <li>
            <strong className="text-slate-200">2. Relation</strong> — use the
            dropdown (Parent / Sailor / Other). Pre-filled from their claim
            form when present.
          </li>
          <li>
            <strong className="text-slate-200">3. Note</strong> — sail number +
            club should match the profile.
          </li>
          <li>
            <strong className="text-slate-200">4. Unclaim</strong> — if the wrong
            person was approved, Unlink owner clears ownership so they can
            re-claim.
          </li>
        </ul>
      </div>

      <div className="flex flex-wrap items-center justify-between gap-3">
        <div className="flex flex-wrap gap-2">
          {(["pending", "approved", "rejected", "all"] as const).map((f) => (
            <button
              key={f}
              type="button"
              onClick={() => setFilter(f)}
              className={`rounded-full px-3 py-1.5 text-[11px] font-bold capitalize ${
                filter === f
                  ? "bg-orange-600 text-white"
                  : "bg-white/5 text-slate-400 border border-white/10"
              }`}
            >
              {f}
              {f !== "all" && (
                <span className="ml-1 opacity-70">
                  ({claims.filter((c) => c.status === f).length})
                </span>
              )}
            </button>
          ))}
        </div>

        {isSuperadmin && (
          <button
            type="button"
            onClick={() => setIsAssignOpen(true)}
            className="sp-btn-primary px-3.5 py-1.5 text-xs font-bold flex items-center gap-1.5 shadow-xs"
          >
            <UserPlus className="h-3.5 w-3.5" />
            <span>Assign User to Sailor</span>
          </button>
        )}
      </div>

      {loading && <p className="text-xs text-slate-500">Loading…</p>}
      {error && <p className="text-xs text-rose-400">{error}</p>}

      <div className="w-full space-y-3">
        {visible.map((c) => {
          const effectiveRelation = (c.effectiveRelation || "parent") as ClaimRelation;
          const draft = relationDraft[c.id] ||
            (RELATIONS.includes(effectiveRelation) ? effectiveRelation : "parent");
          const busy = busyId === c.id;
          return (
            <div
              key={c.id}
              className="glass-card rounded-xl border border-white/5 px-4 py-4 w-full grid grid-cols-1 lg:grid-cols-12 gap-4"
            >
              <div className="lg:col-span-4 min-w-0">
                <p className="text-[10px] font-bold text-slate-500 uppercase">
                  Sailor profile
                </p>
                <Link
                  href={`/${c.sailorHandle}`}
                  className="font-bold text-white hover:text-orange-400"
                >
                  {c.sailorName}
                </Link>
                <p className="text-[11px] text-slate-500 mt-0.5 font-mono">
                  /{c.sailorHandle}
                  {c.sailorSailNumber ? ` · ${c.sailorSailNumber}` : ""}
                  {c.sailorClub ? ` · ${c.sailorClub}` : ""}
                </p>
                <span
                  className={`inline-block mt-2 rounded-full px-2 py-0.5 text-[10px] font-black uppercase ${
                    c.status === "pending"
                      ? "bg-amber-500/15 text-amber-300 border border-amber-500/25"
                      : c.status === "approved"
                        ? "bg-emerald-500/15 text-emerald-300 border border-emerald-500/25"
                        : "bg-slate-500/15 text-slate-400 border border-white/10"
                  }`}
                >
                  {c.status}
                </span>
                {c.sailorOwnerRelation && (
                  <p className="text-[10px] text-slate-500 mt-1.5">
                    Linked as:{" "}
                    <span className="text-slate-300 font-semibold">
                      {relationLabel(
                        c.sailorOwnerRelation as ClaimRelation
                      )}
                    </span>
                  </p>
                )}
              </div>

              <div className="lg:col-span-4 min-w-0">
                <p className="text-[10px] font-bold text-slate-500 uppercase flex items-center gap-1">
                  <Mail className="h-3 w-3" />
                  Signup email (account)
                </p>
                <a
                  href={`mailto:${c.requesterEmail}`}
                  className="text-sm font-bold text-orange-300 hover:text-orange-200 break-all"
                >
                  {c.requesterEmail || "—"}
                </a>
                {c.requesterName && (
                  <p className="text-[11px] text-slate-500 mt-1">
                    Display name: {c.requesterName}
                  </p>
                )}
                {c.requesterRole && (
                  <p className="text-[10px] text-slate-600 mt-0.5">
                    Account role:{" "}
                    <span className="font-mono text-slate-400">
                      {c.requesterRole}
                    </span>
                  </p>
                )}
                {c.note && (
                  <div className="mt-2 rounded-lg bg-white/5 border border-white/5 px-2.5 py-2">
                    <p className="text-[10px] font-bold text-slate-500 uppercase">
                      Verification note
                    </p>
                    <p className="text-[11px] text-slate-300 mt-0.5 whitespace-pre-wrap">
                      {c.note}
                    </p>
                  </div>
                )}
              </div>

              <div className="lg:col-span-4 flex flex-col gap-2 justify-center">
                <label className="block">
                  <span className="text-[10px] font-bold text-slate-500 uppercase">
                    Role for this profile
                  </span>
                  <select
                    value={draft}
                    disabled={busy || !isSuperadmin}
                    onChange={(e) =>
                      setRelationDraft((prev) => ({
                        ...prev,
                        [c.id]: e.target.value as ClaimRelation,
                      }))
                    }
                    className="mt-1 w-full rounded-lg bg-slate-950 border border-white/10 px-2.5 py-2 text-xs text-white font-semibold"
                  >
                    {RELATIONS.map((r) => (
                      <option key={r} value={r}>
                        {relationLabel(r)}
                      </option>
                    ))}
                  </select>
                </label>

                {c.status === "pending" && (
                  <div className="flex flex-col sm:flex-row gap-2">
                    <button
                      type="button"
                      disabled={busy}
                      onClick={() =>
                        void patch(c.id, {
                          status: "approved",
                          relation: draft,
                          setAccountRole: true,
                        })
                      }
                      className="inline-flex items-center justify-center gap-1 rounded-full bg-emerald-600 px-3 py-2 text-[11px] font-bold text-white flex-1 disabled:opacity-50"
                    >
                      <CheckCircle className="h-3.5 w-3.5" />
                      Approve as {relationLabel(draft)}
                    </button>
                    <button
                      type="button"
                      disabled={busy}
                      onClick={() =>
                        void patch(c.id, { status: "rejected" })
                      }
                      className="inline-flex items-center justify-center gap-1 rounded-full bg-slate-800 px-3 py-2 text-[11px] font-bold text-slate-300 border border-white/10 disabled:opacity-50"
                    >
                      <XCircle className="h-3.5 w-3.5" />
                      Reject
                    </button>
                  </div>
                )}

                {c.status === "approved" && (
                  <div className="flex flex-col sm:flex-row gap-2">
                    <button
                      type="button"
                      disabled={busy}
                      onClick={() =>
                        void patch(c.id, {
                          relation: draft,
                          setAccountRole: true,
                        })
                      }
                      className="inline-flex items-center justify-center gap-1 rounded-full bg-sky-600 px-3 py-2 text-[11px] font-bold text-white flex-1 disabled:opacity-50"
                    >
                      <Save className="h-3.5 w-3.5" />
                      Update role
                    </button>
                    <button
                      type="button"
                      disabled={busy}
                      onClick={() => {
                        void (async () => {
                          const ok = await confirm({
                            title: `Unlink owner from ${c.sailorName}?`,
                            message:
                              `Sailor: ${c.sailorName}\n` +
                              `Requester claim will stay in history as unlinked.\n\n` +
                              `The profile becomes unclaimed — private logbook access for the current owner ends.`,
                            confirmLabel: "Unlink owner",
                            tone: "danger",
                          });
                          if (!ok) return;
                          await patch(c.id, { unclaim: true });
                        })();
                      }}
                      className="inline-flex items-center justify-center gap-1 rounded-full border border-rose-500/30 bg-rose-500/10 px-3 py-2 text-[11px] font-bold text-rose-200 disabled:opacity-50"
                    >
                      <Unlink className="h-3.5 w-3.5" />
                      Unlink
                    </button>
                  </div>
                )}

                <p className="text-[10px] text-slate-600 font-mono">
                  {c.createdAt
                    ? new Date(c.createdAt).toLocaleString()
                    : ""}
                </p>
              </div>
            </div>
          );
        })}
        {!loading && visible.length === 0 && (
          <div className="w-full">
            <AdminEmptyState
              icon={Inbox}
              title={
                filter === "all"
                  ? "No claims yet"
                  : `No ${filter} claims`
              }
              description="When parents or sailors submit a profile claim, they show up here for review."
            />
          </div>
        )}
      </div>
      {/* Assign User to Sailor Modal */}
      {isAssignOpen && (
        <div className="fixed inset-0 z-50 bg-black/60 backdrop-blur-xs flex items-center justify-center p-4">
          <div className="bg-[var(--sp-warm-white)] border border-[var(--sp-cool-veil)] rounded-3xl p-6 max-w-lg w-full space-y-4 shadow-2xl text-[var(--sp-harbour-shadow)]">
            <div className="flex items-center justify-between border-b border-[var(--sp-cool-veil)] pb-3">
              <div className="flex items-center gap-2">
                <div className="h-8 w-8 rounded-xl bg-[var(--sp-racing-mist)]/40 flex items-center justify-center text-[var(--sp-racing-deep)]">
                  <UserPlus className="h-4 w-4" />
                </div>
                <div>
                  <h3 className="text-base font-black font-display text-[var(--sp-harbour-shadow)]">
                    Assign User to Sailor
                  </h3>
                  <p className="text-[11px] text-[var(--sp-slate-soft)]">
                    Link a registered account directly to an athlete profile.
                  </p>
                </div>
              </div>
              <button
                type="button"
                onClick={() => {
                  setIsAssignOpen(false);
                  resetAssignForm();
                }}
                className="p-1 rounded-lg text-[var(--sp-slate-soft)] hover:text-[var(--sp-harbour-shadow)]"
              >
                <X className="h-4 w-4" />
              </button>
            </div>

            <form onSubmit={handleAssignSubmit} className="space-y-3.5 text-xs">
              {/* User Selection */}
              <div>
                <label className="block font-semibold text-[var(--sp-charcoal-slate)] mb-1">
                  1. Select User Account <span className="text-rose-500">*</span>
                </label>
                {selectedUser ? (
                  <div className="flex items-center justify-between p-2.5 rounded-xl border border-[var(--sp-cool-veil)] bg-[var(--sp-sailcloth)]">
                    <div>
                      <p className="font-bold text-[var(--sp-harbour-shadow)]">{selectedUser.fullName || "User"}</p>
                      <p className="text-[11px] text-[var(--sp-slate-soft)] font-mono">{selectedUser.email}</p>
                    </div>
                    <button
                      type="button"
                      onClick={() => {
                        setSelectedUser(null);
                        setAssignUserId("");
                      }}
                      className="text-xs text-[var(--sp-racing-orange)] hover:underline font-bold"
                    >
                      Change
                    </button>
                  </div>
                ) : (
                  <div className="relative">
                    <input
                      type="text"
                      placeholder="Search user by email or name…"
                      value={assignUserQuery}
                      onChange={(e) => setAssignUserQuery(e.target.value)}
                      className="w-full sp-input py-2 pl-8"
                    />
                    <Search className="absolute left-2.5 top-2.5 h-3.5 w-3.5 text-[var(--sp-slate-soft)]" />
                    {assignUserLoading && (
                      <span className="absolute right-3 top-2.5 text-[10px] text-[var(--sp-slate-soft)]">Searching…</span>
                    )}
                    {assignUsers.length > 0 && (
                      <div className="absolute z-10 top-full left-0 right-0 mt-1 max-h-48 overflow-y-auto rounded-xl border border-[var(--sp-cool-veil)] bg-[var(--sp-warm-white)] shadow-lg divide-y divide-[var(--sp-cool-veil)]">
                        {assignUsers.map((u) => (
                          <div
                            key={u.id}
                            onClick={() => {
                              setSelectedUser(u);
                              setAssignUserId(u.id);
                              setAssignUsers([]);
                              setAssignUserQuery("");
                            }}
                            className="p-2.5 hover:bg-[var(--sp-sailcloth)] cursor-pointer text-left transition-colors"
                          >
                            <p className="font-bold text-[var(--sp-harbour-shadow)]">{u.fullName || "Unnamed User"}</p>
                            <p className="text-[11px] text-[var(--sp-slate-soft)] font-mono">{u.email} ({u.role})</p>
                          </div>
                        ))}
                      </div>
                    )}
                  </div>
                )}
              </div>

              {/* Sailor Selection */}
              <div>
                <label className="block font-semibold text-[var(--sp-charcoal-slate)] mb-1">
                  2. Select Sailor Profile <span className="text-rose-500">*</span>
                </label>
                {selectedSailor ? (
                  <div className="flex items-center justify-between p-2.5 rounded-xl border border-[var(--sp-cool-veil)] bg-[var(--sp-sailcloth)]">
                    <div>
                      <p className="font-bold text-[var(--sp-harbour-shadow)]">{selectedSailor.name}</p>
                      <p className="text-[11px] text-[var(--sp-slate-soft)]">
                        {selectedSailor.sailNumber ? `Sail #${selectedSailor.sailNumber}` : "No sail #"} {selectedSailor.club ? `· ${selectedSailor.club}` : ""}
                      </p>
                    </div>
                    <button
                      type="button"
                      onClick={() => {
                        setSelectedSailor(null);
                        setAssignSailorId("");
                      }}
                      className="text-xs text-[var(--sp-racing-orange)] hover:underline font-bold"
                    >
                      Change
                    </button>
                  </div>
                ) : (
                  <div className="relative">
                    <input
                      type="text"
                      placeholder="Search sailor by name or sail number…"
                      value={assignSailorQuery}
                      onChange={(e) => setAssignSailorQuery(e.target.value)}
                      className="w-full sp-input py-2 pl-8"
                    />
                    <Search className="absolute left-2.5 top-2.5 h-3.5 w-3.5 text-[var(--sp-slate-soft)]" />
                    {assignSailorLoading && (
                      <span className="absolute right-3 top-2.5 text-[10px] text-[var(--sp-slate-soft)]">Searching…</span>
                    )}
                    {assignSailors.length > 0 && (
                      <div className="absolute z-10 top-full left-0 right-0 mt-1 max-h-48 overflow-y-auto rounded-xl border border-[var(--sp-cool-veil)] bg-[var(--sp-warm-white)] shadow-lg divide-y divide-[var(--sp-cool-veil)]">
                        {assignSailors.map((s) => (
                          <div
                            key={s.id}
                            onClick={() => {
                              setSelectedSailor(s);
                              setAssignSailorId(s.id);
                              setAssignSailors([]);
                              setAssignSailorQuery("");
                            }}
                            className="p-2.5 hover:bg-[var(--sp-sailcloth)] cursor-pointer text-left transition-colors"
                          >
                            <p className="font-bold text-[var(--sp-harbour-shadow)]">{s.name}</p>
                            <p className="text-[11px] text-[var(--sp-slate-soft)]">
                              {s.sailNumber ? `Sail #${s.sailNumber}` : "No sail #"} {s.club ? `· ${s.club}` : ""}
                            </p>
                          </div>
                        ))}
                      </div>
                    )}
                  </div>
                )}
              </div>

              {/* Relation */}
              <div>
                <label className="block font-semibold text-[var(--sp-charcoal-slate)] mb-1">
                  3. Account Relationship
                </label>
                <select
                  value={assignRelation}
                  onChange={(e) => setAssignRelation(e.target.value as ClaimRelation)}
                  className="w-full sp-select py-2"
                >
                  <option value="parent">Parent / Guardian</option>
                  <option value="sailor">Sailor (Athlete Direct)</option>
                  <option value="other">Other / Support</option>
                </select>
              </div>

              {/* Note */}
              <div>
                <label className="block font-semibold text-[var(--sp-charcoal-slate)] mb-1">
                  Note (optional)
                </label>
                <input
                  type="text"
                  placeholder="e.g. Assigned by admin via support request"
                  value={assignNote}
                  onChange={(e) => setAssignNote(e.target.value)}
                  className="w-full sp-input py-2"
                />
              </div>

              <div className="flex items-center justify-end gap-2 pt-3 border-t border-[var(--sp-cool-veil)]">
                <button
                  type="button"
                  onClick={() => {
                    setIsAssignOpen(false);
                    resetAssignForm();
                  }}
                  className="rounded-xl border border-[var(--sp-cool-veil)] bg-[var(--sp-sailcloth)] px-4 py-2 text-xs font-bold text-[var(--sp-charcoal-slate)] hover:bg-[var(--sp-cool-veil)]/50"
                >
                  Cancel
                </button>
                <button
                  type="submit"
                  disabled={!assignUserId || !assignSailorId || isSubmittingAssign}
                  className="sp-btn-primary px-4 py-2 text-xs font-bold flex items-center gap-1.5 shadow-xs disabled:opacity-50"
                >
                  <UserPlus className="h-3.5 w-3.5" />
                  <span>{isSubmittingAssign ? "Assigning…" : "Assign User"}</span>
                </button>
              </div>
            </form>
          </div>
        </div>
      )}
    </div>
  );
}
