"use client";

import { useEffect, useState } from "react";
import Link from "next/link";
import { Trophy, ArrowUpCircle } from "lucide-react";

type Candidate = {
  id: string;
  name: string;
  handle: string;
  sailNumber: string;
  silverEntryDate?: string | null;
  currentFleet?: string | null;
  nationalSquadStatus?: string | null;
};

export function PromoteAdminPanel({
  isSuperadmin,
  onPromoted,
}: {
  isSuperadmin: boolean;
  onPromoted?: (sailor: any) => void;
}) {
  const [candidates, setCandidates] = useState<Candidate[]>([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<string | null>(null);

  const load = async () => {
    setLoading(true);
    setError(null);
    try {
      const res = await fetch("/api/admin/promote");
      const data = await res.json();
      if (!res.ok) throw new Error(data.error || "Failed");
      setCandidates(data.candidates || []);
    } catch (e) {
      setError(e instanceof Error ? e.message : "Error");
    } finally {
      setLoading(false);
    }
  };

  useEffect(() => {
    void load();
  }, []);

  const promote = async (sailorId: string, name: string) => {
    if (!isSuperadmin) {
      alert("Superadmin only");
      return;
    }
    if (!confirm(`Promote ${name} to Gold Fleet?`)) return;
    try {
      const res = await fetch("/api/admin/promote", {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({ sailorId }),
      });
      const data = await res.json();
      if (!res.ok) throw new Error(data.error || "Promote failed");
      onPromoted?.(data.sailor);
      alert(data.message || "Promoted");
      await load();
    } catch (e: any) {
      alert(e.message || "Failed");
    }
  };

  return (
    <div className="space-y-4">
      <div className="glass-panel rounded-2xl border border-white/5 p-5">
        <h3 className="text-sm font-bold text-white flex items-center gap-2 uppercase tracking-wider">
          <Trophy className="h-4 w-4 text-yellow-500" />
          Silver → Gold promotion board
        </h3>
        <p className="text-xs text-slate-500 mt-1">
          Sailors with Silver history who are not yet Gold. Promote sets fleet to Gold and
          stamps gold entry date (today if empty).
        </p>
      </div>
      {loading && <p className="text-xs text-slate-500">Loading…</p>}
      {error && <p className="text-xs text-rose-400">{error}</p>}
      <div className="overflow-x-auto rounded-2xl border border-white/5">
        <table className="w-full text-left text-xs">
          <thead className="bg-white/5 text-[10px] uppercase text-slate-400">
            <tr>
              <th className="px-4 py-3">Sailor</th>
              <th className="px-4 py-3">Sail #</th>
              <th className="px-4 py-3">Silver entry</th>
              <th className="px-4 py-3">Squad</th>
              <th className="px-4 py-3 text-right">Action</th>
            </tr>
          </thead>
          <tbody className="divide-y divide-white/5 text-slate-300">
            {candidates.map((c) => (
              <tr key={c.id} className="hover:bg-white/5">
                <td className="px-4 py-3">
                  <Link
                    href={`/${c.handle}`}
                    className="font-bold text-white hover:text-orange-400"
                  >
                    {c.name}
                  </Link>
                </td>
                <td className="px-4 py-3 font-mono text-slate-400">{c.sailNumber}</td>
                <td className="px-4 py-3 font-mono">
                  {c.silverEntryDate
                    ? String(c.silverEntryDate).slice(0, 10)
                    : "—"}
                </td>
                <td className="px-4 py-3">{c.nationalSquadStatus || "—"}</td>
                <td className="px-4 py-3 text-right">
                  <button
                    type="button"
                    onClick={() => void promote(c.id, c.name)}
                    className="inline-flex items-center gap-1 rounded-full bg-yellow-600/90 hover:bg-yellow-500 px-3 py-1.5 text-[11px] font-bold text-white"
                  >
                    <ArrowUpCircle className="h-3.5 w-3.5" />
                    Promote to Gold
                  </button>
                </td>
              </tr>
            ))}
          </tbody>
        </table>
        {!loading && candidates.length === 0 && (
          <p className="text-xs text-slate-500 text-center py-10">
            No Silver sailors waiting for Gold promotion.
          </p>
        )}
      </div>
    </div>
  );
}
