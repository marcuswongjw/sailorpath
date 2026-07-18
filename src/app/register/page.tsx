"use client";

import { useState } from "react";
import Link from "next/link";
import { createBrowserSupabase } from "@/lib/supabase/browser";

export default function RegisterPage() {
  const [displayName, setDisplayName] = useState("");
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
      const cleanName = displayName.trim() || cleanEmail.split("@")[0];
      const { data, error: authError } = await supabase.auth.signUp({
        email: cleanEmail,
        password,
        options: {
          data: { full_name: cleanName },
          emailRedirectTo: `${window.location.origin}/auth/callback?next=/account?welcome=1`,
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
        setTimeout(() => window.location.assign("/account?welcome=1"), 600);
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
          <p className="text-xs text-slate-400 leading-relaxed">
            We created an account for <strong className="text-white">{email}</strong>.
            Check your inbox for a confirmation link from Supabase. After
            confirming,{" "}
            <Link href="/login" className="text-orange-400 font-bold">
              log in
            </Link>
            , then claim your sailor profile from Search.
          </p>
          <p className="text-[11px] text-slate-600 leading-relaxed">
            If nothing arrives: site admin can turn off &quot;Confirm email&quot;
            in Supabase Auth settings for testing.
          </p>
        </div>
      </div>
    );
  }

  if (done === "session") {
    return (
      <div className="min-h-[70vh] flex items-center justify-center text-orange-400 text-sm font-bold">
        Account created — opening My account…
      </div>
    );
  }

  return (
    <div className="min-h-[70vh] flex items-center justify-center px-4 py-12">
      <div className="w-full max-w-md glass-card rounded-3xl border border-white/5 p-8 space-y-6">
        <div className="text-center">
          <h1 className="text-2xl font-black text-white">Create account</h1>
          <p className="text-xs text-slate-400 mt-2 leading-relaxed">
            Step 1 of 2 — create a login. You claim an existing sailor ranking
            profile after you sign in.
          </p>
        </div>
        {error && (
          <p className="text-xs font-bold text-rose-400 text-center">{error}</p>
        )}
        <form onSubmit={onSubmit} className="space-y-4">
          <input
            required
            value={displayName}
            onChange={(e) => setDisplayName(e.target.value)}
            placeholder="Your name (parent or sailor)"
            className="w-full rounded-xl bg-slate-950 border border-white/10 px-4 py-3 text-sm text-white focus:border-orange-500 focus:outline-none"
          />
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
