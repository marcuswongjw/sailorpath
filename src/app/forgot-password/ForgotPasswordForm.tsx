"use client";

import Link from "next/link";
import { useState } from "react";
import { createBrowserSupabase } from "@/lib/supabase/browser";

export function ForgotPasswordForm() {
  const [email, setEmail] = useState("");
  const [busy, setBusy] = useState(false);
  const [sent, setSent] = useState(false);
  const [error, setError] = useState<string | null>(null);

  const onSubmit = async (event: React.FormEvent) => {
    event.preventDefault();
    setBusy(true);
    setError(null);
    try {
      const supabase = createBrowserSupabase();
      const { error: resetError } = await supabase.auth.resetPasswordForEmail(
        email.trim().toLowerCase(),
        {
          redirectTo: `${window.location.origin}/auth/callback?next=${encodeURIComponent("/reset-password")}`,
        }
      );
      if (resetError) {
        setError("We couldn’t send a reset email yet. Wait a moment and try again.");
        return;
      }
      setSent(true);
    } catch {
      setError("Account services are temporarily unavailable. Please try again later.");
    } finally {
      setBusy(false);
    }
  };

  return (
    <div className="min-h-[70vh] flex items-center justify-center px-4 py-12">
      <div className="w-full max-w-md rounded-3xl border border-[var(--sp-cool-veil)] bg-[var(--sp-warm-white)] p-8 space-y-6 shadow-xs">
        <div className="text-center">
          <h1 className="text-2xl font-black text-[var(--sp-harbour-shadow)]">Reset your password</h1>
          <p className="mt-2 text-xs leading-relaxed text-[var(--sp-slate-soft)]">
            Enter your account email and we’ll send a secure reset link.
          </p>
        </div>
        {sent ? (
          <div className="space-y-4 text-center">
            <p className="text-sm leading-relaxed text-emerald-700 font-semibold">
              If an account exists for that email, a password reset link is on its way.
            </p>
            <p className="text-xs leading-relaxed text-[var(--sp-slate-soft)]">
              Check your inbox and spam folder. The link returns you to SailorPath to choose a new password.
            </p>
          </div>
        ) : (
          <form onSubmit={onSubmit} className="space-y-4">
            {error && (
              <p className="text-center text-xs font-bold leading-relaxed text-rose-600">
                {error}
              </p>
            )}
            <label className="block space-y-1.5 text-xs font-bold text-[var(--sp-slate-soft)]">
              Email
              <input
                type="email"
                required
                autoComplete="email"
                value={email}
                onChange={(event) => setEmail(event.target.value)}
                placeholder="you@email.com"
                className="sp-input w-full text-sm font-normal"
              />
            </label>
            <button
              type="submit"
              disabled={busy}
              className="w-full sp-btn-primary py-3 text-sm font-bold disabled:opacity-50"
            >
              {busy ? "Sending…" : "Send reset link"}
            </button>
          </form>
        )}
        <p className="text-center text-xs text-[var(--sp-slate-soft)]">
          <Link href="/login" className="font-bold text-[var(--sp-harbour-teal)] hover:underline">
            Back to log in
          </Link>
        </p>
      </div>
    </div>
  );
}
