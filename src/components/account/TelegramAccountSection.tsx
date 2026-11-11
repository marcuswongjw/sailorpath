"use client";

import { useState } from "react";
import { TelegramMark } from "@/components/TelegramMark";

export type TelegramAccountStatus = {
  enabled: boolean;
  linked: boolean;
  username: string | null;
  canDisconnect: boolean;
};

export function TelegramAccountSection({
  status,
  notice,
  botEnabled = false,
  embedded = false,
}: {
  status: TelegramAccountStatus | null;
  notice: string | null;
  botEnabled?: boolean;
  embedded?: boolean;
}) {
  const [linked, setLinked] = useState(status?.linked ?? false);
  const [username, setUsername] = useState(status?.username ?? null);
  const [canDisconnect, setCanDisconnect] = useState(status?.canDisconnect ?? false);
  const [busy, setBusy] = useState(false);
  const [message, setMessage] = useState<string | null>(notice);
  const [allowMessages, setAllowMessages] = useState(false);

  if (!status?.enabled) return null;

  const disconnect = async () => {
    setBusy(true);
    setMessage(null);
    try {
      const res = await fetch("/api/auth/telegram", {
        method: "DELETE",
        credentials: "include",
      });
      const body = (await res.json().catch(() => ({}))) as { error?: string };
      if (!res.ok) throw new Error(body.error || "Could not disconnect Telegram");
      setLinked(false);
      setUsername(null);
      setCanDisconnect(false);
      setMessage("Telegram disconnected.");
    } catch (error) {
      setMessage(error instanceof Error ? error.message : "Could not disconnect Telegram");
    } finally {
      setBusy(false);
    }
  };

  return (
    <section
      className={
        embedded
          ? "pt-6 space-y-2.5 w-full"
          : "rounded-3xl border border-[var(--sp-cool-veil)] bg-[var(--sp-warm-white)] p-5 sm:p-6 space-y-3 w-full shadow-xs"
      }
    >
      <div className="flex items-center gap-2">
        <TelegramMark className="h-5 w-5" />
        <h2 className={embedded ? "text-base font-bold text-charcoal" : "text-sm font-bold text-[var(--sp-charcoal)] uppercase tracking-wider"}>
          Telegram
        </h2>
      </div>
      {message ? (
        <p className="text-xs font-semibold text-[var(--sp-charcoal)] leading-relaxed">{message}</p>
      ) : null}
      {linked ? (
        <>
          <p className="text-sm text-[var(--sp-charcoal)]">
            Connected{username ? ` as @${username}` : ""}. You can sign in with Telegram
            {canDisconnect ? " or your email and password" : ""}.
          </p>
          {canDisconnect ? (
            <button
              type="button"
              onClick={() => void disconnect()}
              disabled={busy}
              className="rounded-full border border-[var(--sp-cool-veil)] bg-white hover:bg-[var(--sp-sailcloth)] px-4 py-2 text-xs font-semibold text-[var(--sp-harbour-teal)] transition-colors disabled:opacity-50"
            >
              {busy ? "Disconnecting…" : "Disconnect Telegram"}
            </button>
          ) : (
            <p className="text-xs text-[var(--sp-slate-soft)] leading-relaxed">
              This account signs in with Telegram only, so it stays connected.
            </p>
          )}
        </>
      ) : (
        <>
          <p className="text-xs text-[var(--sp-slate-soft)] leading-relaxed">
            Connect Telegram to sign in with it as well. SailorPath asks only for your public
            name and username, not your phone number.
          </p>
          <a
            href={`/auth/telegram?mode=link&next=${encodeURIComponent("/account#settings")}${
              allowMessages ? "&updates=1" : ""
            }`}
            className="inline-flex items-center gap-2 rounded-full border border-[var(--sp-cool-veil)] bg-white hover:bg-[var(--sp-sailcloth)] px-4 py-2 text-xs font-semibold text-[var(--sp-harbour-shadow)]"
          >
            <TelegramMark className="h-4 w-4" />
            Connect Telegram
          </a>
          {botEnabled ? (
            <label className="flex items-start gap-2 text-xs leading-relaxed text-[var(--sp-slate-soft)]">
              <input
                type="checkbox"
                className="mt-0.5 h-4 w-4 accent-[var(--sp-harbour-teal)]"
                checked={allowMessages}
                onChange={(event) => setAllowMessages(event.target.checked)}
              />
              <span>Also let SailorPath message me on Telegram. Optional.</span>
            </label>
          ) : null}
        </>
      )}
    </section>
  );
}
