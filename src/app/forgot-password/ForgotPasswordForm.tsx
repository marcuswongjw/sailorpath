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
      <div className="w-full max-w-md glass-card rounded-3xl border border-white/5 p-8 space-y-6">
        <div className="text-center">
          <h1 className="text-2xl font-black text-white">Reset your password</h1>
          <p className="mt-2 text-xs leading-relaxed text-slate-400">
            Enter your account email and we’ll send a secure reset link.
          </p>
        </div>
        {sent ? (
          <div className="space-y-4 text-center">
            <p className="text-sm leading-relaxed text-emerald-300">
              If an account exists for that email, a password reset link is on its way.
            </p>
            <p className="text-xs leading-relaxed text-slate-500">
              Check your inbox and spam folder. The link returns you to SailorPath to choose a new password.
            </p>
          </div>
        ) : (
          <form onSubmit={onSubmit} className="space-y-4">
            {error && (
              <p className="text-center text-xs font-bold leading-relaxed text-rose-400">
                {error}
              </p>
            )}
            <label className="block space-y-1.5 text-xs font-bold text-slate-300">
              Email
              <input
                type="email"
                required
                autoComplete="email"
                value={email}
                onChange={(event) => setEmail(event.target.value)}
                placeholder="you@email.com"
                className="w-full rounded-xl border border-white/10 bg-slate-950 px-4 py-3 text-sm font-normal text-white focus:border-orange-500 focus:outline-none"
              />
            </label>
            <button
              type="submit"
              disabled={busy}
              className="w-full rounded-full bg-orange-600 py-3 text-sm font-bold text-white hover:bg-orange-500 disabled:opacity-50"
            >
              {busy ? "Sending…" : "Send reset link"}
            </button>
          </form>
        )}
        <p className="text-center text-xs text-slate-400">
          <Link href="/login" className="font-bold text-orange-400 hover:text-orange-300">
            Back to log in
          </Link>
        </p>
      </div>
    </div>
  );
}
