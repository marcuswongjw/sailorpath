"use client";

import { useState } from "react";
import { TelegramMark } from "@/components/TelegramMark";

export type TelegramUpdatesStatus = {
  enabled: boolean;
  optedIn: boolean;
  username: string | null;
};

export function TelegramUpdatesSection({ status }: { status: TelegramUpdatesStatus | null }) {
  const [optedIn, setOptedIn] = useState(status?.optedIn ?? false);
  const [busy, setBusy] = useState(false);
  const [message, setMessage] = useState<string | null>(null);

  if (!status?.enabled) return null;

  const start = async () => {
    setBusy(true);
    setMessage(null);
    try {
      const res = await fetch("/api/account/telegram-updates", {
        method: "POST",
        credentials: "include",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({ action: "link" }),
      });
      const body = (await res.json().catch(() => ({}))) as { error?: string; url?: string };
      if (!res.ok || !body.url) throw new Error(body.error || "Could not open Telegram");
      window.open(body.url, "_blank", "noopener,noreferrer");
      setMessage("Press Start in Telegram to confirm. You can turn this off here or by sending /stop to the bot.");
    } catch (error) {
      setMessage(error instanceof Error ? error.message : "Could not open Telegram");
    } finally {
      setBusy(false);
    }
  };

  const stop = async () => {
    setBusy(true);
    setMessage(null);
    try {
      const res = await fetch("/api/account/telegram-updates", {
        method: "POST",
        credentials: "include",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({ action: "stop" }),
      });
      const body = (await res.json().catch(() => ({}))) as { error?: string };
      if (!res.ok) throw new Error(body.error || "Could not turn off updates");
      setOptedIn(false);
      setMessage("Telegram updates are off.");
    } catch (error) {
      setMessage(error instanceof Error ? error.message : "Could not turn off updates");
    } finally {
      setBusy(false);
    }
  };

  return (
    <section className="rounded-3xl border border-[var(--sp-cool-veil)] bg-[var(--sp-warm-white)] p-5 sm:p-6 space-y-3 w-full shadow-xs">
      <div className="flex items-center gap-2">
        <TelegramMark className="h-5 w-5" />
        <h2 className="text-sm font-bold text-[var(--sp-charcoal)] uppercase tracking-wider">
          Telegram updates
        </h2>
      </div>
      {message ? (
        <p className="text-xs font-semibold text-[var(--sp-charcoal)] leading-relaxed">{message}</p>
      ) : null}
      {optedIn ? (
        <>
          <p className="text-sm text-[var(--sp-charcoal)]">
            Updates are on{status.username ? ` for @${status.username}` : ""}. Send /stop to the bot, or turn them off here.
          </p>
          <button
            type="button"
            onClick={() => void stop()}
            disabled={busy}
            className="rounded-full border border-[var(--sp-cool-veil)] bg-white px-4 py-2 text-xs font-semibold text-[var(--sp-harbour-teal)] disabled:opacity-50"
          >
            {busy ? "Saving…" : "Stop Telegram updates"}
          </button>
        </>
      ) : (
        <>
          <p className="text-xs leading-relaxed text-[var(--sp-slate-soft)]">
            Get SailorPath updates on Telegram. This is optional and separate from signing in.
          </p>
          <button
            type="button"
            onClick={() => void start()}
            disabled={busy}
            className="inline-flex items-center gap-2 rounded-full border border-[var(--sp-cool-veil)] bg-white px-4 py-2 text-xs font-semibold text-[var(--sp-harbour-shadow)] disabled:opacity-50"
          >
            <TelegramMark className="h-4 w-4" />
            {busy ? "Opening…" : "Get SailorPath updates on Telegram"}
          </button>
        </>
      )}
    </section>
  );
}
