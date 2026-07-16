"use client";

import { useState } from "react";
import Link from "next/link";
import { Compass, Mail, Lock, Globe, ArrowRight, UserCheck } from "lucide-react";
import { createBrowserSupabase } from "@/lib/supabase/browser";

export default function RegisterPage() {
  const [handle, setHandle] = useState("");
  const [email, setEmail] = useState("");
  const [password, setPassword] = useState("");
  const [isSubmitting, setIsSubmitting] = useState(false);
  const [isSuccess, setIsSuccess] = useState(false);
  const [needsEmailConfirm, setNeedsEmailConfirm] = useState(false);
  const [error, setError] = useState<string | null>(null);

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    setIsSubmitting(true);
    setError(null);

    const cleanEmail = email.trim().toLowerCase();
    const cleanPassword = password;
    const cleanHandle = handle.trim().toLowerCase();

    if (cleanPassword.length < 6) {
      setError("Password must be at least 6 characters.");
      setIsSubmitting(false);
      return;
    }

    try {
      const supabase = createBrowserSupabase();

      const { data, error: authError } = await supabase.auth.signUp({
        email: cleanEmail,
        password: cleanPassword,
        options: {
          data: {
            handle: cleanHandle,
            full_name: cleanHandle,
          },
          emailRedirectTo: `${window.location.origin}/auth/callback?next=/`,
        },
      });

      if (authError) {
        // Friendlier messages
        const msg = authError.message || "Registration failed";
        if (/already registered|already been registered|User already registered/i.test(msg)) {
          setError("This email is already registered. Try logging in instead.");
        } else {
          setError(msg);
        }
        setIsSubmitting(false);
        return;
      }

      // Supabase returns a user with empty identities when email already exists
      // (to avoid email enumeration) — treat as already registered.
      if (
        data.user &&
        Array.isArray(data.user.identities) &&
        data.user.identities.length === 0
      ) {
        setError("This email is already registered. Try logging in instead.");
        setIsSubmitting(false);
        return;
      }

      // Session present = email confirmation OFF → user can use the app now
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
          /* profile can be created later — do not block on missing DATABASE_URL */
        }
        setNeedsEmailConfirm(false);
        setIsSuccess(true);
        setTimeout(() => {
          window.location.assign("/");
        }, 800);
      } else {
        // Email confirmation ON — cannot log in until confirmed
        setNeedsEmailConfirm(true);
        setIsSuccess(true);
      }
    } catch (err: unknown) {
      const message =
        err instanceof Error ? err.message : "An unexpected error occurred.";
      setError(message);
    } finally {
      setIsSubmitting(false);
    }
  };

  const handleGoogleSignIn = async () => {
    try {
      const supabase = createBrowserSupabase();
      const { error: oauthError } = await supabase.auth.signInWithOAuth({
        provider: "google",
        options: {
          redirectTo: `${window.location.origin}/auth/callback?next=/`,
        },
      });
      if (oauthError) setError(oauthError.message);
    } catch (err: unknown) {
      setError(err instanceof Error ? err.message : "Google sign-in failed");
    }
  };

  if (isSuccess) {
    return (
      <div className="flex-1 bg-[#090a0f] flex items-center justify-center py-20 px-4 sm:px-6 lg:px-8">
        <div className="w-full max-w-md space-y-8 glass-panel p-8 rounded-3xl border border-white/5 text-center relative overflow-hidden">
          <div className="absolute top-0 right-0 w-32 h-32 bg-orange-600/5 rounded-full blur-2xl -z-10" />

          <div className="mx-auto flex h-12 w-12 items-center justify-center rounded-full bg-emerald-500/10 border border-emerald-500/20 text-emerald-400">
            <UserCheck className="h-6 w-6" />
          </div>

          <div className="space-y-2">
            <h2 className="text-2xl font-black text-white tracking-tight">
              {needsEmailConfirm ? "Confirm your email" : "Account created!"}
            </h2>
            <p className="text-xs text-slate-400 leading-relaxed">
              {needsEmailConfirm ? (
                <>
                  We created your account for <strong>{email}</strong>. Supabase requires
                  email confirmation before login — open the link in your inbox, then{" "}
                  <Link href="/login" className="text-orange-400 font-bold">
                    log in
                  </Link>
                  .
                  <br />
                  <br />
                  <span className="text-slate-500">
                    Dev tip: Supabase → Authentication → Providers → Email → turn off
                    “Confirm email” to allow immediate login.
                  </span>
                </>
              ) : (
                <>
                  You are signed in
                  {handle ? (
                    <>
                      {" "}
                      as <strong className="text-orange-400">sailorpath.com/{handle}</strong>
                    </>
                  ) : null}
                  . Redirecting…
                </>
              )}
            </p>
          </div>

          <div className="pt-4 flex flex-col gap-2">
            {needsEmailConfirm ? (
              <Link
                href="/login"
                className="inline-flex w-full justify-center rounded-full bg-orange-600 py-3 text-center text-sm font-bold text-white hover:bg-orange-500 transition-all"
              >
                Go to login
              </Link>
            ) : (
              <Link
                href="/"
                className="inline-flex w-full justify-center rounded-full bg-orange-600 py-3 text-center text-sm font-bold text-white hover:bg-orange-500 transition-all"
              >
                Continue
              </Link>
            )}
          </div>
        </div>
      </div>
    );
  }

  return (
    <div className="flex-1 bg-[#090a0f] flex items-center justify-center py-16 px-4 sm:px-6 lg:px-8">
      <div className="w-full max-w-md space-y-8 glass-panel p-8 md:p-10 rounded-3xl border border-white/5 relative overflow-hidden shadow-2xl">
        <div className="absolute top-0 right-0 w-32 h-32 bg-orange-600/5 rounded-full blur-2xl -z-10" />

        <div className="text-center space-y-3">
          <div className="mx-auto flex h-10 w-10 items-center justify-center rounded-full bg-orange-500/10 border border-orange-500/20 text-orange-400">
            <Compass className="h-5 w-5" />
          </div>
          <h2 className="text-2xl font-black text-white tracking-tight">Claim your sailor & ID</h2>
          <p className="text-xs text-slate-400 max-w-xs mx-auto leading-relaxed">
            Register with email and password. Google is optional and needs extra setup in Supabase.
          </p>
        </div>

        <div>
          <button
            type="button"
            onClick={handleGoogleSignIn}
            className="flex w-full items-center justify-center gap-3 rounded-full bg-white/5 border border-white/10 hover:border-white/20 py-2.5 px-4 text-xs font-bold text-white transition-all"
          >
            Sign in with Google
          </button>
        </div>

        <div className="relative flex items-center justify-center">
          <div className="absolute inset-0 flex items-center">
            <div className="w-full border-t border-white/5" />
          </div>
          <span className="relative bg-[#0d0f17] px-3 text-[10px] font-bold text-slate-500 uppercase tracking-wider">
            Or register with email
          </span>
        </div>

        {error && (
          <div className="rounded-xl bg-rose-500/10 border border-rose-500/20 p-4 text-xs font-bold text-rose-400 text-center">
            {error}
          </div>
        )}

        <form onSubmit={handleSubmit} className="space-y-4">
          <div className="space-y-1.5">
            <label className="text-[10px] font-bold text-slate-400 uppercase tracking-wide flex items-center gap-1.5">
              <Globe className="h-3 w-3 text-orange-500" />
              Desired Handle
            </label>
            <div className="flex rounded-xl bg-slate-950 border border-white/5 focus-within:border-orange-500/50 transition-all overflow-hidden">
              <span className="flex items-center pl-3 text-xs font-semibold text-slate-500 select-none">
                sailorpath.com/
              </span>
              <input
                required
                type="text"
                placeholder="sailorname"
                value={handle}
                onChange={(e) =>
                  setHandle(e.target.value.toLowerCase().replace(/[^a-z0-9_-]/g, ""))
                }
                className="w-full bg-transparent py-2.5 px-1.5 text-xs text-white placeholder-slate-600 focus:outline-none font-bold"
              />
            </div>
          </div>

          <div className="space-y-1.5">
            <label className="text-[10px] font-bold text-slate-400 uppercase tracking-wide flex items-center gap-1.5">
              <Mail className="h-3 w-3 text-orange-500" />
              Email Address
            </label>
            <input
              required
              type="email"
              autoComplete="email"
              placeholder="you@email.com"
              value={email}
              onChange={(e) => setEmail(e.target.value)}
              className="w-full rounded-xl bg-slate-950 border border-white/5 focus:border-orange-500/50 py-2.5 px-3.5 text-xs text-white focus:outline-none placeholder-slate-600"
            />
          </div>

          <div className="space-y-1.5">
            <label className="text-[10px] font-bold text-slate-400 uppercase tracking-wide flex items-center gap-1.5">
              <Lock className="h-3 w-3 text-orange-500" />
              Password (min 6 characters)
            </label>
            <input
              required
              type="password"
              autoComplete="new-password"
              minLength={6}
              placeholder="••••••••"
              value={password}
              onChange={(e) => setPassword(e.target.value)}
              className="w-full rounded-xl bg-slate-950 border border-white/5 focus:border-orange-500/50 py-2.5 px-3.5 text-xs text-white focus:outline-none placeholder-slate-600"
            />
          </div>

          <div className="pt-4">
            <button
              type="submit"
              disabled={isSubmitting}
              className="flex w-full items-center justify-center gap-2 rounded-full bg-orange-600 hover:bg-orange-500 py-3 text-xs font-bold text-white transition-all shadow-lg border border-orange-500/20 disabled:opacity-50"
            >
              {isSubmitting ? "Creating account…" : "Create account"}
              <ArrowRight className="h-4 w-4" />
            </button>
          </div>
        </form>

        <div className="text-center text-[10px] text-slate-400">
          Already have an account?{" "}
          <Link href="/login" className="font-extrabold text-orange-500 hover:underline">
            Log in
          </Link>
        </div>
      </div>
    </div>
  );
}
