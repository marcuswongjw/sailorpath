"use client";

import { useState } from "react";
import { useQuery } from "@tanstack/react-query";
import { formatAdminAuditDetails, type JsonValue } from "@/lib/adminAuditDetails";

type Change = {
  id: string;
  createdAt: string;
  actorUserId: string | null;
  actorEmail: string | null;
  summary: string;
  action: string;
  source: string | null;
  details: JsonValue | null;
};

export function AdminUserChangesPanel({ isSuperadmin }: { isSuperadmin: boolean }) {
  const [days, setDays] = useState(30);
  const [emailInput, setEmailInput] = useState("");
  const [email, setEmail] = useState("");
  const [offset, setOffset] = useState(0);
  const query = useQuery({
    queryKey: ["admin", "user-changes", days, email, offset],
    enabled: isSuperadmin,
    queryFn: async () => {
      const params = new URLSearchParams({ days: String(days), email, offset: String(offset) });
      const response = await fetch(`/api/admin/user-changes?${params}`);
      const data = await response.json();
      if (!response.ok) throw new Error(data.error || "Unable to load user changes");
      return data as { changes: Change[]; hasMore: boolean };
    },
  });

  if (!isSuperadmin) return <p className="text-sm text-slate-400">User changes require superadmin access.</p>;

  return (
    <section className="space-y-4" aria-label="Registered user changes">
      <div className="glass-panel rounded-2xl border border-white/5 p-5">
        <h2 className="text-lg font-bold text-white">User changes</h2>
        <p className="mt-2 text-sm text-slate-400">Successful changes submitted by registered users, including account settings, sailor profiles, results, equipment and coaching records.</p>
        <p className="mt-2 text-xs text-slate-500">New tracking starts with this release. Previously logged profile edits and role acceptances are included. Activity details identify submitted fields and records; private note contents and credentials are omitted from new entries.</p>
      </div>

      <form className="flex flex-wrap items-end gap-3" onSubmit={(event) => {
        event.preventDefault();
        setEmail(emailInput.trim());
        setOffset(0);
      }}>
        <label className="text-sm text-slate-300">Period
          <select className="sp-input mt-1 block" value={days} onChange={(event) => { setDays(Number(event.target.value)); setOffset(0); }}>
            {[7, 30, 90].map((value) => <option key={value} value={value}>Last {value} days</option>)}
          </select>
        </label>
        <label className="text-sm text-slate-300">User email
          <input className="sp-input mt-1 block" type="search" maxLength={200} placeholder="All users" value={emailInput} onChange={(event) => setEmailInput(event.target.value)} />
        </label>
        <button type="submit" className="sp-btn-primary">Filter</button>
        <button type="button" className="sp-btn-primary" disabled={query.isFetching} onClick={() => void query.refetch()}>Refresh</button>
      </form>

      <div aria-live="polite">
        {query.isFetching && <p className="text-sm text-slate-400">Loading changes…</p>}
        {query.error && <p role="alert" className="text-sm text-rose-400">{query.error.message}</p>}
        {!query.isFetching && !query.error && query.data?.changes.length === 0 && <p className="text-sm text-slate-400">No user changes in this period matching the filter.</p>}
      </div>
      <ul className="space-y-2">
        {(query.data?.changes ?? []).map((change) => (
          <li key={change.id} className="glass-card rounded-xl border border-white/5 p-4">
            <p className="font-semibold text-white">{change.summary}</p>
            <p className="mt-1 break-all text-sm text-slate-400">{change.actorEmail || change.actorUserId || "Unknown user"} · <time dateTime={change.createdAt}>{new Date(change.createdAt).toLocaleString()}</time></p>
            <details className="mt-2 text-xs text-slate-400">
              <summary className="cursor-pointer">Change details</summary>
              <p className="mt-2 break-all">{change.action} · {change.source}</p>
              <pre className="mt-2 max-h-80 overflow-auto whitespace-pre-wrap break-all">{formatAdminAuditDetails(change.details) || "No additional details"}</pre>
            </details>
          </li>
        ))}
      </ul>
      <div className="flex items-center gap-3">
        <button type="button" className="sp-btn-primary" disabled={offset === 0 || query.isFetching} onClick={() => setOffset(Math.max(0, offset - 100))}>Previous</button>
        <span className="text-xs text-slate-400">Page {offset / 100 + 1}</span>
        <button type="button" className="sp-btn-primary" disabled={!query.data?.hasMore || query.isFetching} onClick={() => setOffset(offset + 100)}>Next</button>
      </div>
    </section>
  );
}
