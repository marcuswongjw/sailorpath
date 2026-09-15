"use client";

import Link from "next/link";
import { useEffect, useState } from "react";
import { createBrowserSupabase } from "@/lib/supabase/browser";

export function ResetPasswordForm() {
  const [ready, setReady] = useState(false);
  const [hasSession, setHasSession] = useState(false);
  const [password, setPassword] = useState("");
  const [confirmPassword, setConfirmPassword] = useState("");
  const [busy, setBusy] = useState(false);
  const [done, setDone] = useState(false);
  const [error, setError] = useState<string | null>(null);

  useEffect(() => {
    let active = true;
    const supabase = createBrowserSupabase();
    void supabase.auth
      .getSession()
      .then(({ data }) => {
        if (!active) return;
        setHasSession(Boolean(data.session));
        setReady(true);
      })
      .catch(() => {
        if (active) setReady(true);
      });
    return () => {
      active = false;
    };
  }, []);

  const onSubmit = async (event: React.FormEvent) => {
    event.preventDefault();
    setError(null);
    if (password.length < 6) {
      setError("Password must be at least 6 characters.");
      return;
    }
    if (password !== confirmPassword) {
      setError("The passwords do not match.");
      return;
    }
    setBusy(true);
    try {
      const supabase = createBrowserSupabase();
      const { error: updateError } = await supabase.auth.updateUser({ password });
      if (updateError) {
        setError("We couldn’t update your password. Request a new reset link and try again.");
        return;
      }
      setDone(true);
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
          <h1 className="text-2xl font-black text-[var(--sp-harbour-shadow)]">Choose a new password</h1>
          <p className="mt-2 text-xs leading-relaxed text-[var(--sp-slate-soft)]">
            Your new password must contain at least 6 characters.
          </p>
        </div>
        {!ready ? (
          <p className="text-center text-sm text-[var(--sp-slate-soft)]">Checking reset link…</p>
        ) : done ? (
          <div className="space-y-4 text-center">
            <p className="text-sm font-bold text-emerald-700">Password updated.</p>
            <Link href="/account" className="inline-flex sp-btn-primary px-5 py-2.5 text-sm font-bold">
              Open my account
            </Link>
          </div>
        ) : !hasSession ? (
          <div className="space-y-4 text-center">
            <p className="text-sm leading-relaxed text-rose-600">
              This reset link is invalid or has expired.
            </p>
            <Link href="/forgot-password" className="font-bold text-[var(--sp-racing-orange)] hover:underline">
              Request a new reset link
            </Link>
          </div>
        ) : (
          <form onSubmit={onSubmit} className="space-y-4">
            {error && <p className="text-center text-xs font-bold leading-relaxed text-rose-600">{error}</p>}
            <label className="block space-y-1.5 text-xs font-bold text-[var(--sp-slate-soft)]">
              New password
              <input
                type="password"
                required
                minLength={6}
                autoComplete="new-password"
                value={password}
                onChange={(event) => setPassword(event.target.value)}
                className="sp-input w-full text-sm font-normal"
              />
            </label>
            <label className="block space-y-1.5 text-xs font-bold text-[var(--sp-slate-soft)]">
              Confirm new password
              <input
                type="password"
                required
                minLength={6}
                autoComplete="new-password"
                value={confirmPassword}
                onChange={(event) => setConfirmPassword(event.target.value)}
                className="sp-input w-full text-sm font-normal"
              />
            </label>
            <button type="submit" disabled={busy} className="w-full sp-btn-primary py-3 text-sm font-bold disabled:opacity-50">
              {busy ? "Updating…" : "Update password"}
            </button>
          </form>
        )}
      </div>
    </div>
  );
}
