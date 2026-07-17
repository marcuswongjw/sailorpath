"use client";

import { useState } from "react";
import Link from "next/link";
import { createBrowserSupabase } from "@/lib/supabase/browser";

export default function RegisterPage() {
  const [handle, setHandle] = useState("");
  const [email, setEmail] = useState("");
  const [password, setPassword] = useState("");
  const [error, setError] = useState<string | null>(null);
  const [done, setDone] = useState<"session" | "confirm" | null>(null);
  const [busy, setBusy] = useState(false);

  const onSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    setBusy(true);
    setError(null);
    if (password.length < 6) {
      setError("Password must be at least 6 characters.");
      setBusy(false);
      return;
    }
    try {
      const supabase = createBrowserSupabase();
      const cleanEmail = email.trim().toLowerCase();
      const cleanHandle = handle.trim().toLowerCase();
      const { data, error: authError } = await supabase.auth.signUp({
        email: cleanEmail,
        password,
        options: {
          data: { handle: cleanHandle, full_name: cleanHandle },
          emailRedirectTo: `${window.location.origin}/auth/callback?next=/`,
        },
      });
      if (authError) {
        if (/already registered/i.test(authError.message)) {
          setError("Email already registered. Try logging in.");
        } else {
          setError(authError.message);
        }
        return;
      }
      if (
        data.user &&
        Array.isArray(data.user.identities) &&
        data.user.identities.length === 0
      ) {
        setError("Email already registered. Try logging in.");
        return;
      }
      if (data.session) {
        try {
          const ac = new AbortController();
          const t = setTimeout(() => ac.abort(), 2500);
          await fetch("/api/auth/ensure-profile", {
            method: "POST",
            credentials: "include",
            signal: ac.signal,
          });
          clearTimeout(t);
        } catch {
          /* ok */
        }
        setDone("session");
        setTimeout(() => window.location.assign("/"), 800);
      } else {
        setDone("confirm");
      }
    } catch (err) {
      setError(err instanceof Error ? err.message : "Unexpected error");
    } finally {
      setBusy(false);
    }
  };

  if (done === "confirm") {
    return (
      <div className="min-h-[70vh] flex items-center justify-center px-4">
        <div className="max-w-md glass-card rounded-3xl p-8 text-center space-y-3 border border-white/5">
          <h1 className="text-xl font-black text-white">Confirm your email</h1>
          <p className="text-xs text-slate-400">
            Account created for {email}. Open the confirmation link, or turn off
            Confirm email in Supabase (for testing), then{" "}
            <Link href="/login" className="text-orange-400 font-bold">
              log in
            </Link>
            .
          </p>
        </div>
      </div>
    );
  }

  if (done === "session") {
    return (
      <div className="min-h-[70vh] flex items-center justify-center text-orange-400 text-sm font-bold">
        Account created — redirecting…
      </div>
    );
  }

  return (
    <div className="min-h-[70vh] flex items-center justify-center px-4 py-12">
      <div className="w-full max-w-md glass-card rounded-3xl border border-white/5 p-8 space-y-6">
        <div className="text-center">
          <h1 className="text-2xl font-black text-white">Create account</h1>
          <p className="text-xs text-slate-400 mt-2">Email + password (Google later)</p>
        </div>
        {error && (
          <p className="text-xs font-bold text-rose-400 text-center">{error}</p>
        )}
        <form onSubmit={onSubmit} className="space-y-4">
          <div className="flex rounded-xl bg-slate-950 border border-white/10 overflow-hidden">
            <span className="pl-3 self-center text-xs text-slate-500">
              sailorpath.com/
            </span>
            <input
              required
              value={handle}
              onChange={(e) =>
                setHandle(e.target.value.toLowerCase().replace(/[^a-z0-9_-]/g, ""))
              }
              placeholder="handle"
              className="w-full bg-transparent py-3 px-2 text-sm text-white focus:outline-none font-bold"
            />
          </div>
          <input
            type="email"
            required
            autoComplete="email"
            value={email}
            onChange={(e) => setEmail(e.target.value)}
            placeholder="you@email.com"
            className="w-full rounded-xl bg-slate-950 border border-white/10 px-4 py-3 text-sm text-white focus:border-orange-500 focus:outline-none"
          />
          <input
            type="password"
            required
            minLength={6}
            autoComplete="new-password"
            value={password}
            onChange={(e) => setPassword(e.target.value)}
            placeholder="Password (min 6)"
            className="w-full rounded-xl bg-slate-950 border border-white/10 px-4 py-3 text-sm text-white focus:border-orange-500 focus:outline-none"
          />
          <button
            type="submit"
            disabled={busy}
            className="w-full rounded-full bg-orange-600 py-3 text-sm font-bold text-white hover:bg-orange-500 disabled:opacity-50"
          >
            {busy ? "Creating…" : "Create account"}
          </button>
        </form>
        <p className="text-center text-xs text-slate-400">
          Have an account?{" "}
          <Link href="/login" className="text-orange-500 font-bold">
            Log in
          </Link>
        </p>
      </div>
    </div>
  );
}
