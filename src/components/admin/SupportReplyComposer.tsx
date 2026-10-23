"use client";
import { useRef, useState } from "react";

export type SupportDelivery = {
  id: string; kind: "acknowledgement" | "reply"; recipient: string; body: string;
  status: "sending" | "sent" | "failed" | "skipped"; createdAt: string;
};
const statusLabel = { sending: "Awaiting send confirmation", sent: "Accepted by email service", failed: "Send failed", skipped: "Email service unavailable" };
export function SupportReplyComposer({ messageId, email, deliveries = [], onUpdate }: {
  messageId: string; email: string; deliveries?: SupportDelivery[]; onUpdate: (sent: boolean) => void;
}) {
  const [draft, setDraft] = useState("");
  const [busy, setBusy] = useState(false);
  const [notice, setNotice] = useState("");
  const requestId = useRef<string | null>(null);
  const inFlight = useRef(false);
  async function send() {
    if (inFlight.current || !draft.trim()) return;
    inFlight.current = true; setBusy(true); setNotice("");
    requestId.current ??= crypto.randomUUID();
    try {
      const response = await fetch("/api/admin/support/reply", { method: "POST", headers: { "Content-Type": "application/json" },
        body: JSON.stringify({ messageId, requestId: requestId.current, text: draft.trim() }) });
      const data = await response.json();
      onUpdate(response.ok);
      if (!response.ok) throw new Error(data.error || "The email service did not accept your reply. Your draft is kept; you can retry.");
      setNotice("Reply accepted by the email service."); setDraft(""); requestId.current = null;
    } catch (error) { setNotice(error instanceof Error ? error.message : "Reply could not be sent. Your draft is kept."); }
    finally { inFlight.current = false; setBusy(false); }
  }
  return <section className="space-y-3 border-t border-white/10 pt-3" aria-label={`Email correspondence for ${email}`}>
    <details>
      <summary className="cursor-pointer text-xs font-semibold text-slate-400">Email history ({deliveries.length})</summary>
      <p className="mt-2 text-xs text-slate-500">Emails sent here are recorded below. Replies received in your email inbox are handled there.</p>
      {deliveries.length ? deliveries.map((item) => <div key={item.id} className="my-2 rounded-lg border border-white/10 p-3 text-xs">
        <p className="font-semibold text-slate-300">{item.kind === "reply" ? "Support reply" : "Automatic acknowledgement"} · {statusLabel[item.status]}</p>
        <p className="mt-1 text-slate-500">{new Date(item.createdAt).toLocaleString("en-SG", {timeZone:"Asia/Singapore"})} · {item.recipient}</p>
        <p className="mt-2 whitespace-pre-wrap text-slate-300">{item.body}</p>
      </div>) : <p className="mt-2 text-xs text-slate-500">No emails recorded. History starts with this release.</p>}
    </details>
    <label className="block text-xs font-semibold text-slate-300">Reply to {email}
      <textarea aria-label={`Reply to ${email}`} value={draft} disabled={busy} maxLength={8000} rows={4}
        onChange={(event) => { setDraft(event.target.value); requestId.current = null; setNotice(""); }}
        className="mt-2 block w-full rounded-lg border border-slate-500 bg-transparent p-3 text-sm text-slate-200" />
    </label>
    <button type="button" disabled={busy || !draft.trim()} onClick={() => void send()}
      className="rounded-lg bg-[var(--sp-harbour-teal)] px-4 py-2 text-sm font-bold text-white disabled:opacity-40">{busy ? "Sending…" : "Send reply"}</button>
    {notice && <p role="status" className="text-xs text-slate-400">{notice}</p>}
  </section>;
}
