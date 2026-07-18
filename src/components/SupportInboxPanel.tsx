"use client";

import { useEffect, useState } from "react";
import { LifeBuoy, CheckCircle, Mail } from "lucide-react";

type Msg = {
  id: string;
  email: string;
  name: string | null;
  topic: string | null;
  body: string;
  pageUrl: string | null;
  status: string;
  createdAt: string;
};

export function SupportInboxPanel({ isSuperadmin }: { isSuperadmin: boolean }) {
  const [messages, setMessages] = useState<Msg[]>([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<string | null>(null);
  const [filter, setFilter] = useState<"new" | "all" | "resolved">("new");

  const load = async () => {
    setLoading(true);
    setError(null);
    try {
      const q =
        filter === "all" ? "" : `?status=${filter === "resolved" ? "resolved" : "new"}`;
      const res = await fetch(`/api/support${q}`);
      const data = await res.json();
      if (!res.ok) throw new Error(data.error || "Failed to load");
      setMessages(data.messages || []);
    } catch (e) {
      setError(e instanceof Error ? e.message : "Error");
    } finally {
      setLoading(false);
    }
  };

  useEffect(() => {
    void load();
  }, [filter]);

  const setStatus = async (id: string, status: string) => {
    if (!isSuperadmin) return;
    try {
      const res = await fetch("/api/support", {
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
    <div className="w-full min-w-0 space-y-4">
      <div className="glass-panel rounded-2xl border border-white/5 p-5 w-full">
        <h3 className="text-sm font-bold text-white flex items-center gap-2 uppercase tracking-wider">
          <LifeBuoy className="h-4 w-4 text-orange-500" />
          Support inbox
        </h3>
        <p className="text-xs text-slate-500 mt-1">
          Messages from /support. Reply by email, then mark resolved.
        </p>
      </div>

      <div className="flex flex-wrap gap-2">
        {(["new", "resolved", "all"] as const).map((f) => (
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
          </button>
        ))}
      </div>

      {loading && <p className="text-xs text-slate-500">Loading…</p>}
      {error && <p className="text-xs text-rose-400">{error}</p>}

      <div className="space-y-3 w-full">
        {messages.map((m) => (
          <div
            key={m.id}
            className="glass-card rounded-xl border border-white/5 p-4 w-full space-y-2"
          >
            <div className="flex flex-col sm:flex-row sm:items-start justify-between gap-2">
              <div className="min-w-0">
                <a
                  href={`mailto:${m.email}`}
                  className="inline-flex items-center gap-1.5 text-sm font-bold text-orange-300 hover:text-orange-200 break-all"
                >
                  <Mail className="h-3.5 w-3.5 shrink-0" />
                  {m.email}
                </a>
                {m.name && (
                  <p className="text-[11px] text-slate-500 mt-0.5">{m.name}</p>
                )}
                <p className="text-[10px] text-slate-600 font-mono mt-1">
                  {m.topic || "other"} ·{" "}
                  {m.createdAt ? new Date(m.createdAt).toLocaleString() : ""}
                </p>
              </div>
              <span
                className={`self-start rounded-full px-2 py-0.5 text-[10px] font-black uppercase ${
                  m.status === "new"
                    ? "bg-amber-500/15 text-amber-200 border border-amber-500/25"
                    : m.status === "resolved"
                      ? "bg-emerald-500/15 text-emerald-300 border border-emerald-500/25"
                      : "bg-white/5 text-slate-400"
                }`}
              >
                {m.status}
              </span>
            </div>
            <p className="text-xs text-slate-300 whitespace-pre-wrap leading-relaxed">
              {m.body}
            </p>
            {m.pageUrl && (
              <p className="text-[10px] text-slate-600 truncate">
                From: {m.pageUrl}
              </p>
            )}
            {m.status !== "resolved" && isSuperadmin && (
              <button
                type="button"
                onClick={() => void setStatus(m.id, "resolved")}
                className="inline-flex items-center gap-1 rounded-full bg-emerald-600/90 px-3 py-1.5 text-[11px] font-bold text-white"
              >
                <CheckCircle className="h-3.5 w-3.5" />
                Mark resolved
              </button>
            )}
          </div>
        ))}
        {!loading && messages.length === 0 && (
          <p className="text-xs text-slate-500 text-center py-10">
            No messages in this filter.
          </p>
        )}
      </div>
    </div>
  );
}
