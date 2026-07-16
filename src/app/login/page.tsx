"use client";

import { useState, Suspense } from "react";
import Link from "next/link";
import { Mail, Lock, ShieldAlert, Sparkles } from "lucide-react";
import { useRouter, useSearchParams } from "next/navigation";
import { createBrowserSupabase } from "@/lib/supabase/browser";

function LoginForm() {
  const router = useRouter();
  const searchParams = useSearchParams();
  const urlError = searchParams.get("error");

  const [email, setEmail] = useState("");
  const [password, setPassword] = useState("");
  const [useMagicLink, setUseMagicLink] = useState(false);
  const [message, setMessage] = useState<string | null>(null);
  const [error, setError] = useState<string | null>(urlError);
  const [isSubmitting, setIsSubmitting] = useState(false);

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    setIsSubmitting(true);
    setMessage(null);
    setError(null);

    const cleanEmail = email.trim().toLowerCase();

    try {
      const supabase = createBrowserSupabase();

      if (useMagicLink) {
        const { error: authError } = await supabase.auth.signInWithOtp({
          email: cleanEmail,
          options: {
            emailRedirectTo: `${window.location.origin}/auth/callback?next=/`,
          },
        });
        if (authError) {
          setError(authError.message);
        } else {
          setMessage(`Magic sign-in link sent to ${cleanEmail}. Check your inbox (and spam).`);
        }
      } else {
        const { data, error: authError } = await supabase.auth.signInWithPassword({
          email: cleanEmail,
          password,
        });

        if (authError) {
          const msg = authError.message || "Login failed";
          // Supabase returns this for wrong password AND for unconfirmed email
          if (/invalid login credentials/i.test(msg)) {
            setError(
              "Invalid email or password. If you just registered, confirm your email first (check inbox), or ask an admin to disable “Confirm email” in Supabase → Authentication → Providers → Email."
            );
          } else if (/email not confirmed/i.test(msg)) {
            setError(
              "Email not confirmed yet. Open the confirmation link we sent, or disable Confirm email in Supabase for testing."
            );
          } else {
            setError(msg);
          }
        } else if (data.session) {
          try {
            await fetch("/api/auth/ensure-profile", { method: "POST" });
          } catch {
            /* profile optional until DB works */
          }
          setMessage("Logged in successfully! Redirecting…");
          router.push("/");
          router.refresh();
        } else {
          setError("Login succeeded but no session was created. Try again.");
        }
      }
    } catch (err: unknown) {
      setError(err instanceof Error ? err.message : "An unexpected error occurred.");
    } finally {
      setIsSubmitting(false);
    }
  };

  return (
    <div className="min-h-[80vh] flex items-center justify-center bg-[#090a0f] py-12 px-4 sm:px-6 lg:px-8 relative overflow-hidden">
      <div className="absolute top-1/2 left-1/2 -translate-x-1/2 -translate-y-1/2 w-[400px] h-[400px] bg-orange-600/5 rounded-full blur-[100px] pointer-events-none -z-10" />

      <div className="w-full max-w-md space-y-8 glass-card border border-white/5 p-8 md:p-10 rounded-3xl shadow-2xl relative">
        <div className="text-center">
          <span className="inline-flex items-center gap-1 bg-orange-500/10 border border-orange-500/20 text-orange-400 px-3 py-1 rounded-full text-xs font-bold mb-4">
            <Sparkles className="h-3 w-3 animate-pulse" />
            Athlete Portal
          </span>
          <h2 className="text-3xl font-black text-white tracking-tight">Welcome back</h2>
          <p className="mt-2 text-xs text-slate-400 font-semibold">
            Sign in with the same email and password you used to register.
          </p>
        </div>

        {message && (
          <div className="rounded-xl bg-orange-600/10 border border-orange-500/20 p-4 text-xs font-bold text-orange-400 text-center">
            {message}
          </div>
        )}

        {error && (
          <div className="rounded-xl bg-rose-500/10 border border-rose-500/20 p-4 text-xs font-bold text-rose-400 text-center leading-relaxed">
            {error}
          </div>
        )}

        <form className="space-y-6" onSubmit={handleSubmit}>
          <div className="space-y-4">
            <div className="space-y-1.5">
              <label className="text-xs font-bold text-slate-400 uppercase">Email Address</label>
              <div className="relative">
                <Mail className="absolute left-3.5 top-3.5 h-4 w-4 text-slate-500" />
                <input
                  type="email"
                  required
                  autoComplete="email"
                  value={email}
                  onChange={(e) => setEmail(e.target.value)}
                  placeholder="name@club.com"
                  className="w-full rounded-xl border border-white/10 bg-slate-900/50 py-3 pl-11 pr-4 text-sm text-white placeholder-slate-500 focus:border-orange-500 focus:outline-none"
                />
              </div>
            </div>

            {!useMagicLink && (
              <div className="space-y-1.5">
                <label className="text-xs font-bold text-slate-400 uppercase">Password</label>
                <div className="relative">
                  <Lock className="absolute left-3.5 top-3.5 h-4 w-4 text-slate-500" />
                  <input
                    type="password"
                    required
                    autoComplete="current-password"
                    value={password}
                    onChange={(e) => setPassword(e.target.value)}
                    placeholder="••••••••"
                    className="w-full rounded-xl border border-white/10 bg-slate-900/50 py-3 pl-11 pr-4 text-sm text-white placeholder-slate-500 focus:border-orange-500 focus:outline-none"
                  />
                </div>
              </div>
            )}
          </div>

          <div className="space-y-3">
            <button
              type="submit"
              disabled={isSubmitting}
              className="flex w-full justify-center rounded-full bg-orange-600 py-3 text-sm font-bold text-white hover:bg-orange-500 transition-all disabled:opacity-50"
            >
              {isSubmitting
                ? "Please wait…"
                : useMagicLink
                  ? "Send Magic Link"
                  : "Log In"}
            </button>

            <button
              type="button"
              onClick={() => setUseMagicLink(!useMagicLink)}
              className="w-full text-center text-xs font-semibold text-slate-400 hover:text-white transition-colors"
            >
              {useMagicLink ? "Sign in with password instead" : "Send me a magic link instead"}
            </button>
          </div>
        </form>

        <div className="text-center text-xs text-slate-400">
          No account?{" "}
          <Link href="/register" className="font-bold text-orange-500 hover:underline">
            Register
          </Link>
        </div>

        <div className="border-t border-white/5 pt-6 flex gap-3 text-slate-500 text-[10px] font-semibold leading-relaxed">
          <ShieldAlert className="h-5 w-5 text-orange-500/80 flex-shrink-0 mt-0.5" />
          <p>
            If login fails right after register, confirm your email or disable “Confirm email” in
            Supabase Authentication → Providers → Email for testing.
          </p>
        </div>
      </div>
    </div>
  );
}

export default function LoginPage() {
  return (
    <Suspense
      fallback={
        <div className="min-h-[80vh] flex items-center justify-center bg-[#090a0f] text-slate-400 text-sm">
          Loading…
        </div>
      }
    >
      <LoginForm />
    </Suspense>
  );
}
