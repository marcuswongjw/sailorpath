"use client";

import { useEffect, useState } from "react";
import Link from "next/link";
import { UserCheck, CheckCircle, XCircle } from "lucide-react";

type ClaimRow = {
  id: string;
  sailorId: string;
  status: string;
  sailorName: string;
  sailorHandle: string;
  requesterEmail: string;
  requesterName: string;
  createdAt: string;
};

export function ClaimsAdminPanel({ isSuperadmin }: { isSuperadmin: boolean }) {
  const [claims, setClaims] = useState<ClaimRow[]>([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<string | null>(null);

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

  return (
    <div className="space-y-4">
      <div className="glass-panel rounded-2xl border border-white/5 p-5">
        <h3 className="text-sm font-bold text-white flex items-center gap-2 uppercase tracking-wider">
          <UserCheck className="h-4 w-4 text-orange-500" />
          Profile claim requests
        </h3>
        <p className="text-xs text-slate-500 mt-1">
          Parents/sailors request claim on public profiles. Approve to set parent_id.
        </p>
      </div>
      {loading && <p className="text-xs text-slate-500">Loading…</p>}
      {error && <p className="text-xs text-rose-400">{error}</p>}
      <div className="space-y-2">
        {claims.map((c) => (
          <div
            key={c.id}
            className="glass-card rounded-xl border border-white/5 px-4 py-3 flex flex-col sm:flex-row sm:items-center justify-between gap-3"
          >
            <div>
              <Link
                href={`/${c.sailorHandle}`}
                className="font-bold text-white hover:text-orange-400"
              >
                {c.sailorName}
              </Link>
              <p className="text-[11px] text-slate-500 mt-0.5">
                Requested by {c.requesterName || c.requesterEmail} ·{" "}
                <span
                  className={
                    c.status === "pending"
                      ? "text-amber-400"
                      : c.status === "approved"
                        ? "text-emerald-400"
                        : "text-slate-400"
                  }
                >
                  {c.status}
                </span>
              </p>
            </div>
            {c.status === "pending" && (
              <div className="flex gap-2">
                <button
                  type="button"
                  onClick={() => void setStatus(c.id, "approved")}
                  className="inline-flex items-center gap-1 rounded-full bg-emerald-600 px-3 py-1.5 text-[11px] font-bold text-white"
                >
                  <CheckCircle className="h-3.5 w-3.5" />
                  Approve
                </button>
                <button
                  type="button"
                  onClick={() => void setStatus(c.id, "rejected")}
                  className="inline-flex items-center gap-1 rounded-full bg-slate-800 px-3 py-1.5 text-[11px] font-bold text-slate-300"
                >
                  <XCircle className="h-3.5 w-3.5" />
                  Reject
                </button>
              </div>
            )}
          </div>
        ))}
        {!loading && claims.length === 0 && (
          <p className="text-xs text-slate-500 text-center py-8">No claims yet.</p>
        )}
      </div>
    </div>
  );
}
