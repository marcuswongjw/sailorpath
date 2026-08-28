"use client";

import { Suspense, useState } from "react";
import Link from "next/link";
import { useRouter, useSearchParams } from "next/navigation";
import { createBrowserSupabase } from "@/lib/supabase/browser";
import { safeAuthNext } from "@/lib/supabase/cookie-options";
import { trackClientUsage } from "@/lib/clientUsage";

function RegisterForm() {
  const router = useRouter();
  const searchParams = useSearchParams();
  const isCoachSignup = searchParams.get("role") === "coach";
  const nextTarget = safeAuthNext(
    searchParams.get("next"),
    isCoachSignup ? "/coach-tools" : "/account?welcome=1"
  );
  const [displayName, setDisplayName] = useState("");
  const [email, setEmail] = useState("");
  const [password, setPassword] = useState("");
  const [error, setError] = useState<string | null>(null);
  const [done, setDone] = useState<"session" | "confirm" | null>(null);
  const [busy, setBusy] = useState(false);
  const [resendBusy, setResendBusy] = useState(false);
  const [resendMessage, setResendMessage] = useState<string | null>(null);

  const confirmationRedirect = () =>
    `${window.location.origin}/auth/callback?next=${encodeURIComponent(nextTarget)}`;

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
          data: {
            full_name: cleanName,
            account_intent: isCoachSignup ? "coach" : "sailor_or_parent",
          },
          emailRedirectTo: confirmationRedirect(),
        },
      });
      if (authError) {
        if (/already registered/i.test(authError.message)) {
          setError("Email already registered. Try logging in.");
        } else {
          setError(
            "We couldn’t create the account. Check your details and try again."
          );
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
        trackClientUsage("register", "/register", { mode: "session" });
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
        setTimeout(() => router.replace(nextTarget), 600);
      } else {
        trackClientUsage("register", "/register", { mode: "confirm" });
        setDone("confirm");
      }
    } catch {
      setError(
        "Account services are temporarily unavailable. Please try again later."
      );
    } finally {
      setBusy(false);
    }
  };

  const resendConfirmation = async () => {
    setResendBusy(true);
    setResendMessage(null);
    try {
      const supabase = createBrowserSupabase();
      const { error: resendError } = await supabase.auth.resend({
        type: "signup",
        email: email.trim().toLowerCase(),
        options: { emailRedirectTo: confirmationRedirect() },
      });
      setResendMessage(
        resendError
          ? "We couldn’t resend the email yet. Wait a moment and try again."
          : "Confirmation email sent. Check your inbox and spam folder."
      );
    } catch {
      setResendMessage("Account services are temporarily unavailable.");
    } finally {
      setResendBusy(false);
    }
  };

  if (done === "confirm") {
    return (
      <div className="min-h-[70vh] flex items-center justify-center px-4">
        <div className="max-w-md glass-card rounded-3xl p-8 text-center space-y-3 border border-white/5">
          <h1 className="text-xl font-black text-white">Confirm your email</h1>
          <p className="text-xs text-slate-400 leading-relaxed">
            We created an account for <strong className="text-white">{email}</strong>.
            Check your inbox and open the confirmation link. We&apos;ll return you
            {isCoachSignup
              ? " to the Coach Dashboard, where you can request coach approval."
              : " to SailorPath, where you can claim a profile or continue to your account."}
          </p>
          <button
            type="button"
            disabled={resendBusy}
            onClick={() => void resendConfirmation()}
            className="text-xs font-bold text-orange-400 hover:text-orange-300 disabled:opacity-50"
          >
            {resendBusy ? "Sending…" : "Resend confirmation email"}
          </button>
          {resendMessage && (
            <p className="text-[11px] text-slate-400 leading-relaxed">
              {resendMessage}
            </p>
          )}
        </div>
      </div>
    );
  }

  if (done === "session") {
    return (
      <div className="min-h-[70vh] flex items-center justify-center text-orange-400 text-sm font-bold">
        Account created — opening {isCoachSignup ? "Coach Dashboard" : "My account"}…
      </div>
    );
  }

  return (
    <div className="min-h-[70vh] flex items-center justify-center px-4 py-12">
      <div className="w-full max-w-md glass-card rounded-3xl border border-white/5 p-8 space-y-6">
        <div className="text-center">
          <h1 className="text-2xl font-black text-white">
            {isCoachSignup ? "Create coach account" : "Create account"}
          </h1>
          <p className="text-xs text-slate-400 mt-2 leading-relaxed">
            {isCoachSignup
              ? "Create your login first. SailorPath reviews coach access before the private squad dashboard is enabled."
              : "Create your login. Sailors and parents can claim a ranking profile; coaches can request dashboard access after signing in."}
          </p>
        </div>
        {error && (
          <p className="text-xs font-bold text-rose-400 text-center">{error}</p>
        )}
        <form onSubmit={onSubmit} className="space-y-4">
          <label className="block space-y-1.5 text-xs font-bold text-slate-300">
            Full name
            <input
              required
              autoComplete="name"
              value={displayName}
              onChange={(e) => setDisplayName(e.target.value)}
              placeholder={isCoachSignup ? "Coach name" : "Parent, sailor, or coach name"}
              className="w-full rounded-xl bg-slate-950 border border-white/10 px-4 py-3 text-sm font-normal text-white focus:border-orange-500 focus:outline-none"
            />
          </label>
          <label className="block space-y-1.5 text-xs font-bold text-slate-300">
            Email
            <input
              type="email"
              required
              autoComplete="email"
              value={email}
              onChange={(e) => setEmail(e.target.value)}
              placeholder="you@email.com"
              className="w-full rounded-xl bg-slate-950 border border-white/10 px-4 py-3 text-sm font-normal text-white focus:border-orange-500 focus:outline-none"
            />
          </label>
          <label className="block space-y-1.5 text-xs font-bold text-slate-300">
            Password
            <input
              type="password"
              required
              minLength={6}
              autoComplete="new-password"
              value={password}
              onChange={(e) => setPassword(e.target.value)}
              aria-describedby="password-help"
              className="w-full rounded-xl bg-slate-950 border border-white/10 px-4 py-3 text-sm font-normal text-white focus:border-orange-500 focus:outline-none"
            />
            <span id="password-help" className="block font-normal text-slate-500">
              Use at least 6 characters.
            </span>
          </label>
          <button
            type="submit"
            disabled={busy}
            className="w-full rounded-full bg-orange-600 py-3 text-sm font-bold text-white hover:bg-orange-500 disabled:opacity-50"
          >
            {busy ? "Creating…" : isCoachSignup ? "Create coach account" : "Create account"}
          </button>
        </form>
        <p className="text-center text-[11px] leading-relaxed text-slate-500">
          By creating an account, you agree to the{" "}
          <Link href="/terms" className="font-semibold text-slate-300 hover:text-white">
            Terms
          </Link>{" "}
          and acknowledge the{" "}
          <Link href="/privacy" className="font-semibold text-slate-300 hover:text-white">
            Privacy notice
          </Link>
          .
        </p>
        <p className="text-center text-xs text-slate-400">
          Have an account?{" "}
          <Link
            href={`/login?next=${encodeURIComponent(nextTarget)}`}
            className="text-orange-500 font-bold"
          >
            Log in
          </Link>
        </p>
        {!isCoachSignup && (
          <p className="text-center text-xs text-slate-400">
            Signing up as a coach?{" "}
            <Link href="/register?role=coach&next=%2Fcoach-tools" className="font-bold text-sky-400 hover:text-sky-300">
              Use coach registration
            </Link>
          </p>
        )}
      </div>
    </div>
  );
}

export default function RegisterPage() {
  return (
    <Suspense
      fallback={
        <div className="min-h-[70vh] flex items-center justify-center text-slate-500 text-sm">
          Loading…
        </div>
      }
    >
      <RegisterForm />
    </Suspense>
  );
}
