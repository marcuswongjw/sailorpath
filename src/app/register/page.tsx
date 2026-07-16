"use client";

import { useState } from "react";
import Link from "next/link";
import { Compass, Mail, Lock, Globe, Shield, ArrowRight, UserCheck } from "lucide-react";
import { createClient as createSupabaseClient } from "@supabase/supabase-js";

const supabase = createSupabaseClient(
  process.env.NEXT_PUBLIC_SUPABASE_URL || "https://placeholder-project.supabase.co",
  process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY || "placeholder-anon-key"
);

export default function RegisterPage() {
  const [handle, setHandle] = useState("");
  const [email, setEmail] = useState("");
  const [password, setPassword] = useState("");
  const [isSubmitting, setIsSubmitting] = useState(false);
  const [isSuccess, setIsSuccess] = useState(false);
  const [error, setError] = useState<string | null>(null);

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    setIsSubmitting(true);
    setError(null);

    try {
      // Never send role from the client — role is assigned only in profiles via
      // server/trigger (default sailor/parent). Authorization reads profiles.role.
      const { data, error: authError } = await supabase.auth.signUp({
        email,
        password,
        options: {
          data: {
            handle: handle.trim().toLowerCase(),
            full_name: handle.trim(),
          },
          emailRedirectTo: `${window.location.origin}/auth/callback`
        }
      });

      if (authError) {
        setError(authError.message);
        setIsSubmitting(false);
        return;
      }

      setIsSuccess(true);
    } catch (err: any) {
      setError(err.message || "An unexpected error occurred.");
    } finally {
      setIsSubmitting(false);
    }
  };

  const handleGoogleSignIn = async () => {
    try {
      const { error: oauthError } = await supabase.auth.signInWithOAuth({
        provider: "google",
        options: {
          redirectTo: `${window.location.origin}/auth/callback`
        }
      });
      if (oauthError) alert(oauthError.message);
    } catch (err: any) {
      alert(err.message);
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
            <h2 className="text-2xl font-black text-white tracking-tight">Profile Reservation Pending!</h2>
            <p className="text-xs text-slate-400 leading-relaxed">
              We have reserved <strong className="text-orange-400">sailorpath.com/{handle}</strong> for your account. A verification link has been sent to <strong>{email}</strong> to confirm your identity.
            </p>
          </div>

          <div className="pt-4">
            <Link
              href="/"
              className="inline-flex w-full justify-center rounded-full bg-orange-600 py-3 text-center text-sm font-bold text-white hover:bg-orange-500 transition-all shadow-lg border border-orange-500/20"
            >
              Return Home
            </Link>
          </div>
        </div>
      </div>
    );
  }

  return (
    <div className="flex-1 bg-[#090a0f] flex items-center justify-center py-16 px-4 sm:px-6 lg:px-8">
      <div className="w-full max-w-md space-y-8 glass-panel p-8 md:p-10 rounded-3xl border border-white/5 relative overflow-hidden shadow-2xl">
        {/* Decorative Glow */}
        <div className="absolute top-0 right-0 w-32 h-32 bg-orange-600/5 rounded-full blur-2xl -z-10" />

        {/* Brand Header */}
        <div className="text-center space-y-3">
          <div className="mx-auto flex h-10 w-10 items-center justify-center rounded-full bg-orange-500/10 border border-orange-500/20 text-orange-400">
            <Compass className="h-5 w-5" />
          </div>
          <h2 className="text-2xl font-black text-white tracking-tight">Claim your sailor & ID</h2>
          <p className="text-xs text-slate-400 max-w-xs mx-auto leading-relaxed">
            Register (parents for under-13), reserve a handle, and link to an official sailor on the rankings board.
          </p>
        </div>

        {/* Google Sign In */}
        <div>
          <button
            onClick={handleGoogleSignIn}
            className="flex w-full items-center justify-center gap-3 rounded-full bg-white/5 border border-white/10 hover:border-white/20 py-2.5 px-4 text-xs font-bold text-white transition-all"
          >
            <svg className="h-4 w-4" viewBox="0 0 24 24" fill="currentColor">
              <path d="M22.56 12.25c0-.78-.07-1.53-.2-2.25H12v4.26h5.92c-.26 1.37-1.04 2.53-2.21 3.31v2.77h3.57c2.08-1.92 3.28-4.74 3.28-8.09z" fill="#4285F4"/>
              <path d="M12 23c2.97 0 5.46-.98 7.28-2.66l-3.57-2.77c-.98.66-2.23 1.06-3.71 1.06-2.86 0-5.29-1.93-6.16-4.53H2.18v2.84C3.99 20.53 7.7 23 12 23z" fill="#34A853"/>
              <path d="M5.84 14.09c-.22-.66-.35-1.36-.35-2.09s.13-1.43.35-2.09V7.06H2.18C1.43 8.55 1 10.22 1 12s.43 3.45 1.18 4.94l2.85-2.22.81-.63z" fill="#FBBC05"/>
              <path d="M12 5.38c1.62 0 3.06.56 4.21 1.64l3.15-3.15C17.45 2.09 14.97 1 12 1 7.7 1 3.99 3.47 2.18 7.06l3.66 2.84c.87-2.6 3.3-4.52 6.16-4.52z" fill="#EA4335"/>
            </svg>
            Sign in with Google
          </button>
        </div>

        {/* Separator */}
        <div className="relative flex items-center justify-center">
          <div className="absolute inset-0 flex items-center">
            <div className="w-full border-t border-white/5"></div>
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

        {/* Main form */}
        <form onSubmit={handleSubmit} className="space-y-4">
          {/* Handle Input */}
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
                onChange={(e) => setHandle(e.target.value.toLowerCase().replace(/[^a-z0-9_-]/g, ""))}
                className="w-full bg-transparent py-2.5 px-1.5 text-xs text-white placeholder-slate-600 focus:outline-none font-bold"
              />
            </div>
            <p className="text-[9px] text-slate-500">
              Reserved URL handle for your public dashboard. lowercase letters and numbers only.
            </p>
          </div>

          {/* Email Input */}
          <div className="space-y-1.5">
            <label className="text-[10px] font-bold text-slate-400 uppercase tracking-wide flex items-center gap-1.5">
              <Mail className="h-3 w-3 text-orange-500" />
              Email Address
            </label>
            <input
              required
              type="email"
              placeholder="parent@email.com or sailor@email.com"
              value={email}
              onChange={(e) => setEmail(e.target.value)}
              className="w-full rounded-xl bg-slate-950 border border-white/5 focus:border-orange-500/50 py-2.5 px-3.5 text-xs text-white focus:outline-none placeholder-slate-600"
            />
          </div>

          {/* Password Input */}
          <div className="space-y-1.5">
            <label className="text-[10px] font-bold text-slate-400 uppercase tracking-wide flex items-center gap-1.5">
              <Lock className="h-3 w-3 text-orange-500" />
              Password
            </label>
            <input
              required
              type="password"
              placeholder="••••••••"
              value={password}
              onChange={(e) => setPassword(e.target.value)}
              className="w-full rounded-xl bg-slate-950 border border-white/5 focus:border-orange-500/50 py-2.5 px-3.5 text-xs text-white focus:outline-none placeholder-slate-600"
            />
          </div>

          {/* Action Button */}
          <div className="pt-4">
            <button
              type="submit"
              disabled={isSubmitting}
              className="flex w-full items-center justify-center gap-2 rounded-full bg-orange-600 hover:bg-orange-500 py-3 text-xs font-bold text-white transition-all shadow-lg border border-orange-500/20 disabled:opacity-50"
            >
              {isSubmitting ? "Processing..." : "Create account"}
              <ArrowRight className="h-4 w-4" />
            </button>
          </div>
        </form>

        {/* Switch to Login Link */}
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
