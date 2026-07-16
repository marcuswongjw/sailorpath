"use client";

import { useState } from "react";
import Link from "next/link";
import { Mail, Lock, ShieldAlert, Sparkles, Navigation } from "lucide-react";
import { createClient as createSupabaseClient } from "@supabase/supabase-js";
import { useRouter } from "next/navigation";

const supabase = createSupabaseClient(
  process.env.NEXT_PUBLIC_SUPABASE_URL || "https://placeholder-project.supabase.co",
  process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY || "placeholder-anon-key"
);

export default function LoginPage() {
  const router = useRouter();
  const [email, setEmail] = useState("");
  const [password, setPassword] = useState("");
  const [useMagicLink, setUseMagicLink] = useState(false);
  const [message, setMessage] = useState<string | null>(null);
  const [error, setError] = useState<string | null>(null);
  const [isSubmitting, setIsSubmitting] = useState(false);

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    setIsSubmitting(true);
    setMessage(null);
    setError(null);

    try {
      if (useMagicLink) {
        const { error: authError } = await supabase.auth.signInWithOtp({
          email,
          options: {
            emailRedirectTo: `${window.location.origin}/auth/callback`
          }
        });
        if (authError) {
          setError(authError.message);
        } else {
          setMessage(`Magic sign-in link sent to ${email}! Check your email inbox.`);
        }
      } else {
        const { error: authError } = await supabase.auth.signInWithPassword({
          email,
          password
        });
        if (authError) {
          setError(authError.message);
        } else {
          // Ensure profiles row exists (works even if SQL trigger not installed)
          try {
            await fetch("/api/auth/ensure-profile", { method: "POST" });
          } catch {
            /* DB may still be offline */
          }
          setMessage("Logged in successfully! Redirecting...");
          setTimeout(() => {
            router.push("/");
            router.refresh();
          }, 1000);
        }
      }
    } catch (err: any) {
      setError(err.message || "An unexpected error occurred.");
    } finally {
      setIsSubmitting(false);
    }
  };

  return (
    <div className="min-h-[80vh] flex items-center justify-center bg-[#090a0f] py-12 px-4 sm:px-6 lg:px-8 relative overflow-hidden">
      {/* Glow animations */}
      <div className="absolute top-1/2 left-1/2 -translate-x-1/2 -translate-y-1/2 w-[400px] h-[400px] bg-orange-600/5 rounded-full blur-[100px] pointer-events-none -z-10" />

      <div className="w-full max-w-md space-y-8 glass-card border border-white/5 p-8 md:p-10 rounded-3xl shadow-2xl relative">
        <div className="text-center">
          <span className="inline-flex items-center gap-1 bg-orange-500/10 border border-orange-500/20 text-orange-400 px-3 py-1 rounded-full text-xs font-bold mb-4">
            <Sparkles className="h-3 w.3 animate-pulse" />
            Athlete Portal
          </span>
          <h2 className="text-3xl font-black text-white tracking-tight">Welcome back</h2>
          <p className="mt-2 text-xs text-slate-400 font-semibold">
            Access your logbook, update gear logs, or view parent dashboard.
          </p>
        </div>

        {message && (
          <div className="rounded-xl bg-orange-600/10 border border-orange-500/20 p-4 text-xs font-bold text-orange-400 text-center">
            {message}
          </div>
        )}

        {error && (
          <div className="rounded-xl bg-rose-500/10 border border-rose-500/20 p-4 text-xs font-bold text-rose-400 text-center">
            {error}
          </div>
        )}

        <form className="space-y-6" onSubmit={handleSubmit}>
          <div className="space-y-4">
            {/* Email Field */}
            <div className="space-y-1.5">
              <label className="text-xs font-bold text-slate-400 uppercase">Email Address</label>
              <div className="relative">
                <Mail className="absolute left-3.5 top-3.5 h-4.5 w-4.5 text-slate-500" />
                <input
                  type="email"
                  required
                  value={email}
                  onChange={(e) => setEmail(e.target.value)}
                  placeholder="name@club.com"
                  className="w-full rounded-xl border border-white/10 bg-slate-900/50 py-3 pl-11 pr-4 text-sm text-white placeholder-slate-500 focus:border-orange-500 focus:outline-none focus:ring-2 focus:ring-orange-500/10 transition-all font-medium"
                />
              </div>
            </div>

            {/* Password Field */}
            {!useMagicLink && (
              <div className="space-y-1.5">
                <div className="flex justify-between items-center">
                  <label className="text-xs font-bold text-slate-400 uppercase">Password</label>
                  <a href="#" className="text-xs font-semibold text-orange-500 hover:text-orange-400">
                    Forgot?
                  </a>
                </div>
                <div className="relative">
                  <Lock className="absolute left-3.5 top-3.5 h-4.5 w-4.5 text-slate-500" />
                  <input
                    type="password"
                    required
                    value={password}
                    onChange={(e) => setPassword(e.target.value)}
                    placeholder="••••••••"
                    className="w-full rounded-xl border border-white/10 bg-slate-900/50 py-3 pl-11 pr-4 text-sm text-white placeholder-slate-500 focus:border-orange-500 focus:outline-none focus:ring-2 focus:ring-orange-500/10 transition-all font-medium"
                  />
                </div>
              </div>
            )}
          </div>

          {/* Action buttons */}
          <div className="space-y-3">
            <button
              type="submit"
              className="flex w-full justify-center rounded-full bg-orange-600 py-3 text-sm font-bold text-white hover:bg-orange-500 hover:scale-[1.01] transition-all shadow-md shadow-orange-950/20 border border-orange-500/30"
            >
              {useMagicLink ? "Send Magic Link" : "Log In"}
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

        {/* Account Logic Disclaimer */}
        <div className="border-t border-white/5 pt-6 flex gap-3 text-slate-500 text-[10px] font-semibold leading-relaxed">
          <ShieldAlert className="h-5 w-5 text-orange-500/80 flex-shrink-0 mt-0.5" />
          <p>
            **Account Registration Rules:** Sailors aged under 13 require parent registration and profile management. Sailors aged 13 and above can self-register. Parents can toggle and switch between multiple children's profiles from their personalized dashboard.
          </p>
        </div>
      </div>
    </div>
  );
}
