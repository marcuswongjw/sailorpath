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
      <div className="w-full max-w-md glass-card rounded-3xl border border-white/5 p-8 space-y-6">
        <div className="text-center">
          <h1 className="text-2xl font-black text-white">Choose a new password</h1>
          <p className="mt-2 text-xs leading-relaxed text-slate-400">
            Your new password must contain at least 6 characters.
          </p>
        </div>
        {!ready ? (
          <p className="text-center text-sm text-slate-500">Checking reset link…</p>
        ) : done ? (
          <div className="space-y-4 text-center">
            <p className="text-sm font-bold text-emerald-300">Password updated.</p>
            <Link href="/account" className="inline-flex rounded-full bg-orange-600 px-5 py-2.5 text-sm font-bold text-white hover:bg-orange-500">
              Open my account
            </Link>
          </div>
        ) : !hasSession ? (
          <div className="space-y-4 text-center">
            <p className="text-sm leading-relaxed text-rose-300">
              This reset link is invalid or has expired.
            </p>
            <Link href="/forgot-password" className="font-bold text-orange-400 hover:text-orange-300">
              Request a new reset link
            </Link>
          </div>
        ) : (
          <form onSubmit={onSubmit} className="space-y-4">
            {error && <p className="text-center text-xs font-bold leading-relaxed text-rose-400">{error}</p>}
            <label className="block space-y-1.5 text-xs font-bold text-slate-300">
              New password
              <input
                type="password"
                required
                minLength={6}
                autoComplete="new-password"
                value={password}
                onChange={(event) => setPassword(event.target.value)}
                className="w-full rounded-xl border border-white/10 bg-slate-950 px-4 py-3 text-sm font-normal text-white focus:border-orange-500 focus:outline-none"
              />
            </label>
            <label className="block space-y-1.5 text-xs font-bold text-slate-300">
              Confirm new password
              <input
                type="password"
                required
                minLength={6}
                autoComplete="new-password"
                value={confirmPassword}
                onChange={(event) => setConfirmPassword(event.target.value)}
                className="w-full rounded-xl border border-white/10 bg-slate-950 px-4 py-3 text-sm font-normal text-white focus:border-orange-500 focus:outline-none"
              />
            </label>
            <button type="submit" disabled={busy} className="w-full rounded-full bg-orange-600 py-3 text-sm font-bold text-white hover:bg-orange-500 disabled:opacity-50">
              {busy ? "Updating…" : "Update password"}
            </button>
          </form>
        )}
      </div>
    </div>
  );
}
