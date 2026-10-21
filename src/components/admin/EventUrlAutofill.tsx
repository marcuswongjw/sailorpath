"use client";

import { useRef, useState } from "react";
import type { EventUrlDraft } from "@/lib/calendar/eventUrlDraft";

export function EventUrlAutofill({ onExtract, onBusyChange }: { onExtract: (draft: EventUrlDraft) => void; onBusyChange: (busy: boolean) => void }) {
  const [url, setUrl] = useState("");
  const [busy, setBusy] = useState(false);
  const [message, setMessage] = useState("");
  const [warnings, setWarnings] = useState<string[]>([]);
  const lock = useRef(false);
  async function extract() {
    if (lock.current) return;
    lock.current = true; setBusy(true); onBusyChange(true); setMessage(""); setWarnings([]);
    try {
      const response = await fetch("/api/admin/event-url", { method: "POST", headers: { "Content-Type": "application/json" }, body: JSON.stringify({ url }) });
      const data = await response.json();
      if (!response.ok) throw new Error(data.error || "Could not read this event page.");
      onExtract(data.draft);
      setWarnings(data.warnings || []);
      setMessage("Event details populated below. Review the dates, classes and links, then save the event.");
    } catch (error) { setMessage(error instanceof Error ? error.message : "Could not read this event page."); }
    finally { lock.current = false; setBusy(false); onBusyChange(false); }
  }
  return <section aria-label="Add event from URL" className="my-4 space-y-3 rounded-xl border border-orange-200 bg-orange-50 p-4">
    <h4 className="font-semibold text-slate-900">Paste event URL</h4>
    <label className="block text-sm text-slate-800">Official event webpage<input type="url" value={url} onChange={(e) => setUrl(e.target.value)} onKeyDown={(e) => { if (e.key === "Enter") { e.preventDefault(); if (url.trim()) void extract(); } }} disabled={busy} placeholder="https://organiser.org/regatta" className="mt-1 block w-full rounded-lg border border-slate-300 bg-white p-3" /></label>
    <button type="button" disabled={busy || !url.trim()} onClick={() => void extract()} className="min-h-11 rounded-full bg-orange-600 px-4 py-2 text-sm font-bold text-white disabled:opacity-40">{busy ? "Reading event page…" : "Extract event details"}</button>
    <p className="text-xs text-slate-600">Only details found on the page are filled in. Nothing is added to the calendar until you save.</p>
    {message && <p role="status" className="text-sm text-slate-800">{message}</p>}
    {warnings.length > 0 && <ul className="list-disc pl-5 text-sm text-amber-900">{warnings.map((warning) => <li key={warning}>{warning}</li>)}</ul>}
  </section>;
}
