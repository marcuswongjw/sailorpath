"use client";

import { useState } from "react";
import { createBrowserSupabase } from "@/lib/supabase/browser";
import { startGoogleConnect } from "@/lib/google/auth";
import { GoogleMark } from "@/components/GoogleMark";

export type GoogleAccountStatus = {
  enabled: boolean;
  linked: boolean;
};

export function GoogleAccountSection({
  status,
  notice,
}: {
  status: GoogleAccountStatus | null;
  notice: string | null;
}) {
  const [busy, setBusy] = useState(false);
  const [message, setMessage] = useState<string | null>(notice);
  const linked = status?.linked ?? false;

  if (!status?.enabled) return null;

  const connect = async () => {
    setBusy(true);
    setMessage(null);
    try {
      await startGoogleConnect(createBrowserSupabase(), window.location.origin);
    } catch (error) {
      setMessage(error instanceof Error ? error.message : "Could not connect Google");
      setBusy(false);
    }
  };

  return (
    <section className="rounded-3xl border border-[var(--sp-cool-veil)] bg-[var(--sp-warm-white)] p-5 sm:p-6 space-y-3 w-full shadow-xs">
      <div className="flex items-center gap-2">
        <GoogleMark className="h-5 w-5" />
        <h2 className="text-sm font-bold text-[var(--sp-charcoal)] uppercase tracking-wider">
          Google
        </h2>
      </div>
      {message ? (
        <p className="text-xs font-semibold text-[var(--sp-charcoal)] leading-relaxed">{message}</p>
      ) : null}
      {linked ? (
        <p className="text-sm text-[var(--sp-charcoal)]">
          Connected. You can sign in with Google or your other methods.
        </p>
      ) : (
        <>
          <p className="text-xs text-[var(--sp-slate-soft)] leading-relaxed">
            Connect Google to sign in with it as well. This adds Google to this account.
            It does not combine two SailorPath accounts.
          </p>
          <button
            type="button"
            onClick={() => void connect()}
            disabled={busy}
            className="inline-flex items-center gap-2 rounded-full border border-[var(--sp-cool-veil)] bg-white hover:bg-[var(--sp-sailcloth)] px-4 py-2 text-xs font-semibold text-[var(--sp-harbour-shadow)] disabled:opacity-50"
          >
            <GoogleMark className="h-4 w-4" />
            {busy ? "Opening Google…" : "Connect Google"}
          </button>
        </>
      )}
    </section>
  );
}
