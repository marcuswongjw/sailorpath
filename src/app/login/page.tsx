"use client";

import { useState, Suspense } from "react";
import Link from "next/link";
import { useSearchParams } from "next/navigation";
import { createBrowserSupabase } from "@/lib/supabase/browser";
import { safeAuthNext } from "@/lib/supabase/cookie-options";

function LoginForm() {
  const searchParams = useSearchParams();
  const nextTarget = safeAuthNext(searchParams.get("next"), "/account");
  const [email, setEmail] = useState("");
  const [password, setPassword] = useState("");
  const [error, setError] = useState<string | null>(searchParams.get("error"));
  const [message, setMessage] = useState<string | null>(null);
  const [busy, setBusy] = useState(false);

  const onSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    setBusy(true);
    setError(null);
    setMessage(null);
    try {
      const supabase = createBrowserSupabase();
      const cleanEmail = email.trim().toLowerCase();
      const { data, error: authError } = await supabase.auth.signInWithPassword({
        email: cleanEmail,
        password,
      });
      if (authError) {
        const msg = authError.message || "Login failed";
        if (/invalid login credentials/i.test(msg)) {
          setError(
            "Invalid email or password. If this account was created before Confirm email was turned off, confirm or delete it in Supabase → Authentication → Users, then register again."
          );
        } else {
          setError(msg);
        }
        return;
      }
      if (!data.session) {
        setError("No session returned. Try again.");
        return;
      }
      setMessage("Logged in — redirecting…");
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
        /* profile optional until DB live */
      }
      window.location.assign(nextTarget);
    } catch (err) {
      setError(err instanceof Error ? err.message : "Unexpected error");
    } finally {
      setBusy(false);
    }
  };

  return (
    <div className="min-h-[70vh] flex items-center justify-center px-4 py-12">
      <div className="w-full max-w-md glass-card rounded-3xl border border-white/5 p-8 space-y-6">
        <div className="text-center">
          <h1 className="text-2xl font-black text-white">Welcome back</h1>
          <p className="text-xs text-slate-400 mt-2">Email + password login</p>
        </div>
        {message && (
          <p className="text-xs font-bold text-orange-400 text-center">{message}</p>
        )}
        {error && (
          <p className="text-xs font-bold text-rose-400 text-center leading-relaxed">
            {error}
          </p>
        )}
        <form onSubmit={onSubmit} className="space-y-4">
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
            autoComplete="current-password"
            value={password}
            onChange={(e) => setPassword(e.target.value)}
            placeholder="Password"
            className="w-full rounded-xl bg-slate-950 border border-white/10 px-4 py-3 text-sm text-white focus:border-orange-500 focus:outline-none"
          />
          <button
            type="submit"
            disabled={busy}
            className="w-full rounded-full bg-orange-600 py-3 text-sm font-bold text-white hover:bg-orange-500 disabled:opacity-50"
          >
            {busy ? "Signing in…" : "Log in"}
          </button>
        </form>
        <p className="text-center text-xs text-slate-400">
          No account?{" "}
          <Link href="/register" className="text-orange-500 font-bold">
            Register
          </Link>
        </p>
      </div>
    </div>
  );
}

export default function LoginPage() {
  return (
    <Suspense
      fallback={
        <div className="min-h-[70vh] flex items-center justify-center text-slate-500 text-sm">
          Loading…
        </div>
      }
    >
      <LoginForm />
    </Suspense>
  );
}
