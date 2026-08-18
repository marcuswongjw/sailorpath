"use client";

import { useEffect, useState } from "react";
import Link from "next/link";
import {
  UserCheck,
  CheckCircle,
  XCircle,
  Mail,
  ShieldQuestion,
  Save,
  Unlink,
} from "lucide-react";
import {
  relationLabel,
  type ClaimRelation,
} from "@/lib/claimRelation";
import { useFeedback } from "@/components/ui/FeedbackProvider";
import { AdminEmptyState } from "@/components/admin/AdminEmptyState";
import { Inbox } from "lucide-react";

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
  const [claims, setClaims] = useState<ClaimRow[]>([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<string | null>(null);
  const [filter, setFilter] = useState<
    "all" | "pending" | "approved" | "rejected"
  >("pending");
  /** Per-claim relation selection before approve / update */
  const [relationDraft, setRelationDraft] = useState<
    Record<string, ClaimRelation>
  >({});
  const [busyId, setBusyId] = useState<string | null>(null);

  const load = async () => {
    setLoading(true);
    setError(null);
    try {
      const res = await fetch("/api/admin/claims");
      const data = await res.json();
      if (!res.ok) throw new Error(data.error || "Failed to load claims");
      const list: ClaimRow[] = data.claims || [];
      setClaims(list);
      const drafts: Record<string, ClaimRelation> = {};
      for (const c of list) {
        const r = (c.effectiveRelation || "parent") as ClaimRelation;
        drafts[c.id] = RELATIONS.includes(r) ? r : "parent";
      }
      setRelationDraft(drafts);
    } catch (e) {
      setError(e instanceof Error ? e.message : "Error");
    } finally {
      setLoading(false);
    }
  };

  useEffect(() => {
    void load();
  }, []);

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
      await load();
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

      {loading && <p className="text-xs text-slate-500">Loading…</p>}
      {error && <p className="text-xs text-rose-400">{error}</p>}

      <div className="w-full space-y-3">
        {visible.map((c) => {
          const draft = relationDraft[c.id] || "parent";
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
    </div>
  );
}
