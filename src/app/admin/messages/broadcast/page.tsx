"use client";

import { useState } from "react";
import Link from "next/link";
import { AdminSidebar } from "@/components/admin/AdminSidebar";

type Preview = {
  text: string;
  buttonLabel: string | null;
  buttonUrl: string | null;
  targeted: number;
  audience: string;
  audienceValue: string;
};

export default function AdminBroadcastPage() {
  const [text, setText] = useState("");
  const [buttonLabel, setButtonLabel] = useState("");
  const [buttonUrl, setButtonUrl] = useState("");
  const [audience, setAudience] = useState("all");
  const [audienceValue, setAudienceValue] = useState("");
  const [preview, setPreview] = useState<Preview | null>(null);
  const [progress, setProgress] = useState<string | null>(null);
  const [error, setError] = useState<string | null>(null);
  const [busy, setBusy] = useState(false);

  const payload = {
    text,
    buttonLabel,
    buttonUrl,
    audience,
    audienceValue,
  };

  const previewMessage = async () => {
    setBusy(true);
    setError(null);
    setProgress(null);
    try {
      const res = await fetch("/api/admin/telegram/broadcasts", {
        method: "POST",
        credentials: "include",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify(payload),
      });
      const body = await res.json();
      if (!res.ok) throw new Error(body.error || "Could not preview");
      setPreview(body);
    } catch (previewError) {
      setError(previewError instanceof Error ? previewError.message : "Could not preview");
    } finally {
      setBusy(false);
    }
  };

  const send = async () => {
    setBusy(true);
    setError(null);
    try {
      const res = await fetch("/api/admin/telegram/broadcasts", {
        method: "POST",
        credentials: "include",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({ ...payload, confirm: true }),
      });
      const body = await res.json();
      if (!res.ok) throw new Error(body.error || "Could not send");
      let remaining = Number(body.remaining || 0);
      let delivered = Number(body.delivered || 0);
      let failed = Number(body.failed || 0);
      while (remaining > 0) {
        const next = await fetch(`/api/admin/telegram/broadcasts/${body.id}/send`, {
          method: "POST",
          credentials: "include",
        });
        const step = await next.json();
        if (!next.ok) throw new Error(step.error || "Could not continue sending");
        remaining = Number(step.remaining || 0);
        delivered = Number(step.delivered || 0);
        failed = Number(step.failed || 0);
      }
      setProgress(`Sent. Delivered ${delivered}, failed ${failed}.`);
      setPreview(null);
    } catch (sendError) {
      setError(sendError instanceof Error ? sendError.message : "Could not send");
    } finally {
      setBusy(false);
    }
  };

  return (
    <div className="mx-auto flex w-full max-w-6xl gap-6 px-4 py-6">
      <AdminSidebar activeArea="messages" />
      <main className="min-w-0 flex-1 space-y-4">
        <div>
          <Link href="/admin/messages" className="text-xs font-bold text-[var(--sp-harbour-teal)]">
            Telegram accounts
          </Link>
          <h1 className="mt-1 text-2xl font-black text-[var(--sp-harbour-shadow)]">Broadcast</h1>
          <p className="mt-1 text-sm text-slate-600">
            Sends only to people who opted in. Preview the message before it goes out.
          </p>
        </div>
        <label className="block text-xs font-bold text-slate-500">
          Message
          <textarea
            value={text}
            onChange={(event) => setText(event.target.value)}
            rows={6}
            className="sp-input mt-1 w-full font-normal"
            placeholder="Plain text, or **bold** and [a link](https://sailorpath.com)"
          />
        </label>
        <div className="grid gap-3 sm:grid-cols-2">
          <label className="block text-xs font-bold text-slate-500">
            Button label
            <input value={buttonLabel} onChange={(event) => setButtonLabel(event.target.value)} className="sp-input mt-1 w-full font-normal" />
          </label>
          <label className="block text-xs font-bold text-slate-500">
            Button link
            <input value={buttonUrl} onChange={(event) => setButtonUrl(event.target.value)} className="sp-input mt-1 w-full font-normal" placeholder="https://sailorpath.com" />
          </label>
        </div>
        <div className="grid gap-3 sm:grid-cols-2">
          <label className="block text-xs font-bold text-slate-500">
            Audience
            <select value={audience} onChange={(event) => setAudience(event.target.value)} className="sp-input mt-1 w-full font-normal">
              <option value="all">Everyone opted in</option>
              <option value="class">By class</option>
              <option value="country">By country</option>
            </select>
          </label>
          {audience !== "all" ? (
            <label className="block text-xs font-bold text-slate-500">
              {audience === "class" ? "Class" : "Country"}
              <input
                value={audienceValue}
                onChange={(event) => setAudienceValue(event.target.value)}
                className="sp-input mt-1 w-full font-normal"
                placeholder={audience === "class" ? "ILCA 4" : "SGP"}
              />
            </label>
          ) : null}
        </div>
        {error ? <p className="text-sm font-semibold text-rose-700">{error}</p> : null}
        {progress ? <p className="text-sm font-semibold text-emerald-800">{progress}</p> : null}
        <button type="button" className="sp-btn-primary text-sm" disabled={busy} onClick={() => void previewMessage()}>
          {busy ? "Working…" : "Preview"}
        </button>
        {preview ? (
          <section className="space-y-3 rounded-2xl border border-[var(--sp-cool-veil)] bg-white p-4">
            <h2 className="text-sm font-bold uppercase tracking-wide text-slate-500">Preview</h2>
            <p className="whitespace-pre-wrap text-sm text-[var(--sp-charcoal)]">{preview.text}</p>
            {preview.buttonLabel && preview.buttonUrl ? (
              <p className="text-sm font-semibold text-[var(--sp-harbour-teal)]">
                Button: {preview.buttonLabel}
              </p>
            ) : null}
            <p className="text-sm text-slate-600">
              This will go to {preview.targeted} opted-in {preview.targeted === 1 ? "person" : "people"}.
            </p>
            <button type="button" className="sp-btn-primary text-sm" disabled={busy || preview.targeted === 0} onClick={() => void send()}>
              Send to {preview.targeted}
            </button>
          </section>
        ) : null}
      </main>
    </div>
  );
}
