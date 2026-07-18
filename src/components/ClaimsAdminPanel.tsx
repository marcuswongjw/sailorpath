"use client";

import { useEffect, useState } from "react";
import Link from "next/link";
import { UserCheck, CheckCircle, XCircle, Mail, ShieldQuestion } from "lucide-react";

type ClaimRow = {
  id: string;
  sailorId: string;
  status: string;
  note: string | null;
  sailorName: string;
  sailorHandle: string;
  sailorSailNumber?: string | null;
  sailorClub?: string | null;
  requesterEmail: string;
  requesterName: string;
  createdAt: string;
};

export function ClaimsAdminPanel({ isSuperadmin }: { isSuperadmin: boolean }) {
  const [claims, setClaims] = useState<ClaimRow[]>([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<string | null>(null);
  const [filter, setFilter] = useState<"all" | "pending" | "approved" | "rejected">(
    "pending"
  );

  const load = async () => {
    setLoading(true);
    setError(null);
    try {
      const res = await fetch("/api/admin/claims");
      const data = await res.json();
      if (!res.ok) throw new Error(data.error || "Failed to load claims");
      setClaims(data.claims || []);
    } catch (e) {
      setError(e instanceof Error ? e.message : "Error");
    } finally {
      setLoading(false);
    }
  };

  useEffect(() => {
    void load();
  }, []);

  const setStatus = async (id: string, status: "approved" | "rejected") => {
    if (!isSuperadmin) {
      alert("Superadmin only");
      return;
    }
    try {
      const res = await fetch("/api/admin/claims", {
        method: "PATCH",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({ id, status }),
      });
      const data = await res.json();
      if (!res.ok) throw new Error(data.error || "Update failed");
      await load();
    } catch (e: any) {
      alert(e.message || "Failed");
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
          Account email is shown for every request. Approve only when you are
          confident the requester is the sailor or their parent/guardian.
        </p>
      </div>

      {/* Verification guidance for admins */}
      <div className="glass-panel rounded-2xl border border-sky-500/20 bg-sky-500/[0.04] p-5 w-full">
        <h4 className="text-xs font-black text-sky-300 uppercase tracking-wider flex items-center gap-2">
          <ShieldQuestion className="h-4 w-4" />
          How to verify a claim
        </h4>
        <ul className="mt-3 space-y-2 text-[11px] text-slate-400 leading-relaxed">
          <li>
            <strong className="text-slate-200">1. Email identity</strong> — match the
            signup email below to a known parent/sailor contact (club list, coach
            roster, prior correspondence).
          </li>
          <li>
            <strong className="text-slate-200">2. Claim note</strong> — requesters
            should state relationship (sailor / parent) and confirm sail number +
            club in the note when submitting.
          </li>
          <li>
            <strong className="text-slate-200">3. Spot-check</strong> — open the
            profile, confirm name/sail #/club; for youth, prefer parent email
            approval when in doubt.
          </li>
          <li>
            <strong className="text-slate-200">4. Out of band</strong> — if unclear,
            message the club/coach or reply to the email before approving. Reject
            and ask them to re-claim with more detail if needed.
          </li>
        </ul>
        <p className="mt-3 text-[10px] text-slate-600">
          Future: optional photo ID / club code. Today: human review + email is the
          gate.
        </p>
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
        {visible.map((c) => (
          <div
            key={c.id}
            className="glass-card rounded-xl border border-white/5 px-4 py-4 w-full grid grid-cols-1 lg:grid-cols-12 gap-4"
          >
            <div className="lg:col-span-5 min-w-0">
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
              {!c.note && (
                <p className="text-[10px] text-slate-600 mt-2 italic">
                  No verification note provided
                </p>
              )}
            </div>

            <div className="lg:col-span-3 flex flex-col sm:flex-row lg:flex-col gap-2 justify-center lg:items-end">
              {c.status === "pending" && (
                <>
                  <button
                    type="button"
                    onClick={() => void setStatus(c.id, "approved")}
                    className="inline-flex items-center justify-center gap-1 rounded-full bg-emerald-600 px-3 py-2 text-[11px] font-bold text-white w-full sm:w-auto"
                  >
                    <CheckCircle className="h-3.5 w-3.5" />
                    Approve
                  </button>
                  <button
                    type="button"
                    onClick={() => void setStatus(c.id, "rejected")}
                    className="inline-flex items-center justify-center gap-1 rounded-full bg-slate-800 px-3 py-2 text-[11px] font-bold text-slate-300 w-full sm:w-auto border border-white/10"
                  >
                    <XCircle className="h-3.5 w-3.5" />
                    Reject
                  </button>
                </>
              )}
              <p className="text-[10px] text-slate-600 font-mono">
                {c.createdAt
                  ? new Date(c.createdAt).toLocaleString()
                  : ""}
              </p>
            </div>
          </div>
        ))}
        {!loading && visible.length === 0 && (
          <p className="text-xs text-slate-500 text-center py-12 w-full">
            No {filter === "all" ? "" : filter} claims.
          </p>
        )}
      </div>
    </div>
  );
}
