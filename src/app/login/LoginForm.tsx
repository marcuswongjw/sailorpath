"use client";

import { Suspense, useState, useSyncExternalStore } from "react";
import Link from "next/link";
import { useSearchParams } from "next/navigation";
import { TelegramMark } from "@/components/TelegramMark";
import { GoogleMark } from "@/components/GoogleMark";
import { trackClientUsage } from "@/lib/clientUsage";
import { startGoogleSignIn } from "@/lib/google/auth";
import { GOOGLE_LOGIN_ERRORS } from "@/lib/google/messages";
import { createBrowserSupabase } from "@/lib/supabase/browser";
import { safeAuthNext } from "@/lib/supabase/cookie-options";
import { TELEGRAM_LOGIN_ERRORS } from "@/lib/telegram/messages";

const subscribeToHost = () => () => {};
const getBrowserHost = () => window.location.hostname;
const getServerHost = () => "";

function loginErrorMessage(code: string | null): string | null {
  if (!code) return null;
  return (
    TELEGRAM_LOGIN_ERRORS[code] ??
    GOOGLE_LOGIN_ERRORS[code] ??
    "We couldn’t complete authentication. Please try again."
  );
}

function signInSubtitle(googleEnabled: boolean, telegramEnabled: boolean): string {
  if (googleEnabled && telegramEnabled) return "Email and password, Google, or Telegram";
  if (googleEnabled) return "Email and password, or Google";
  if (telegramEnabled) return "Email and password, or Telegram";
  return "Email + password login";
}

export function LoginForm({
  telegramEnabled,
  googleEnabled,
  telegramBotEnabled = false,
}: {
  telegramEnabled: boolean;
  googleEnabled: boolean;
  telegramBotEnabled?: boolean;
}) {
  const searchParams = useSearchParams();
  const currentHost = useSyncExternalStore(
    subscribeToHost,
    getBrowserHost,
    getServerHost
  );
  const nextTarget = safeAuthNext(
    searchParams.get("next"),
    "/account",
    currentHost
  );
  const [email, setEmail] = useState("");
  const [password, setPassword] = useState("");
  const [error, setError] = useState<string | null>(
    loginErrorMessage(searchParams.get("error"))
  );
  const [message, setMessage] = useState<string | null>(null);
  const [busy, setBusy] = useState(false);
  const [telegramUpdates, setTelegramUpdates] = useState(false);
  const telegramHref = `/auth/telegram?next=${encodeURIComponent(nextTarget)}${
    telegramUpdates ? "&updates=1" : ""
  }`;

  const onGoogle = async () => {
    setBusy(true);
    setError(null);
    setMessage(null);
    try {
      await startGoogleSignIn(createBrowserSupabase(), window.location.origin, nextTarget);
    } catch (googleError) {
      setError(
        googleError instanceof Error
          ? googleError.message
          : "We couldn’t start Google sign-in. Please try again."
      );
      setBusy(false);
    }
  };

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
          setError("The email or password is incorrect. Check both and try again.");
        } else if (/email not confirmed/i.test(msg)) {
          setError("Confirm your email before signing in. Check your inbox for the confirmation link.");
        } else {
          setError("We couldn’t sign you in. Try again or contact support if the problem continues.");
        }
        return;
      }
      if (!data.session) {
        setError("We couldn’t complete sign-in. Please try again.");
        return;
      }
      setMessage("Logged in — redirecting…");
      trackClientUsage("login", "/login");
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
      window.location.assign(
        safeAuthNext(
          searchParams.get("next"),
          "/account",
          window.location.hostname
        )
      );
    } catch {
      setError("Account services are temporarily unavailable. Please try again later.");
    } finally {
      setBusy(false);
    }
  };

  return (
    <div className="min-h-[70vh] flex items-center justify-center px-4 py-12">
      <div className="w-full max-w-md rounded-3xl border border-[var(--sp-cool-veil)] bg-[var(--sp-warm-white)] p-8 space-y-6 shadow-xs">
        <div className="text-center">
          <h1 className="text-2xl font-black text-[var(--sp-harbour-shadow)]">Welcome back</h1>
          <p className="text-xs text-[var(--sp-slate-soft)] mt-2">
            {signInSubtitle(googleEnabled, telegramEnabled)}
          </p>
        </div>
        {message && (
          <p className="text-xs font-bold text-[var(--sp-harbour-teal)] text-center">{message}</p>
        )}
        {error && (
          <p className="text-xs font-bold text-rose-600 text-center leading-relaxed">
            {error}
          </p>
        )}
        <form onSubmit={onSubmit} className="space-y-4">
          <label className="block space-y-1.5 text-xs font-bold text-[var(--sp-slate-soft)]">
            Email
            <input
              type="email"
              required
              autoComplete="email"
              value={email}
              onChange={(e) => setEmail(e.target.value)}
              placeholder="you@email.com"
              className="sp-input w-full text-sm font-normal"
            />
          </label>
          <label className="block space-y-1.5 text-xs font-bold text-[var(--sp-slate-soft)]">
            Password
            <input
              type="password"
              required
              autoComplete="current-password"
              value={password}
              onChange={(e) => setPassword(e.target.value)}
              className="sp-input w-full text-sm font-normal"
            />
          </label>
          <div className="text-right">
            <Link
              href="/forgot-password"
              className="text-xs font-semibold text-[var(--sp-slate-soft)] hover:text-[var(--sp-harbour-shadow)]"
            >
              Forgot password?
            </Link>
          </div>
          <button
            type="submit"
            disabled={busy}
            className="w-full sp-btn-primary py-3 text-sm font-bold disabled:opacity-50"
          >
            {busy ? "Signing in…" : "Log in"}
          </button>
        </form>
        {googleEnabled || telegramEnabled ? (
          <div className="space-y-3">
            <div className="flex items-center gap-3">
              <span className="h-px flex-1 bg-[var(--sp-cool-veil)]" />
              <span className="text-[11px] font-bold uppercase tracking-wider text-[var(--sp-slate-soft)]">
                or
              </span>
              <span className="h-px flex-1 bg-[var(--sp-cool-veil)]" />
            </div>
            {googleEnabled ? (
              <button
                type="button"
                disabled={busy}
                onClick={() => void onGoogle()}
                className="flex w-full items-center justify-center gap-2 rounded-full border border-[var(--sp-cool-veil)] bg-white py-3 text-sm font-bold text-[var(--sp-harbour-shadow)] hover:bg-[var(--sp-sailcloth)] disabled:opacity-50"
              >
                <GoogleMark className="h-5 w-5" />
                Continue with Google
              </button>
            ) : null}
            {telegramEnabled ? (
              <a
                href={telegramHref}
                className="flex w-full items-center justify-center gap-2 rounded-full border border-[var(--sp-cool-veil)] bg-white py-3 text-sm font-bold text-[var(--sp-harbour-shadow)] hover:bg-[var(--sp-sailcloth)]"
              >
                <TelegramMark className="h-5 w-5" />
                Log in with Telegram
              </a>
            ) : null}
            {telegramEnabled && telegramBotEnabled ? (
              <label className="flex items-start gap-2 text-left text-[11px] leading-relaxed text-[var(--sp-slate-soft)]">
                <input
                  type="checkbox"
                  className="mt-0.5 h-4 w-4 accent-[var(--sp-harbour-teal)]"
                  checked={telegramUpdates}
                  onChange={(event) => setTelegramUpdates(event.target.checked)}
                />
                <span>
                  Let SailorPath message me on Telegram. This is optional, and you can still sign in without it.
                </span>
              </label>
            ) : null}
            <p className="text-center text-[11px] leading-relaxed text-[var(--sp-slate-soft)]">
              {googleEnabled ? "Google uses the email on that account. " : ""}
              {telegramEnabled
                ? "Telegram uses your public name and username. "
                : ""}
              A phone number is not requested.
            </p>
          </div>
        ) : null}
        <p className="text-center text-xs text-[var(--sp-slate-soft)]">
          No account?{" "}
          <Link
            href={`/register?next=${encodeURIComponent(nextTarget)}`}
            className="text-[var(--sp-harbour-teal)] font-bold hover:underline"
          >
            Register
          </Link>
        </p>
      </div>
    </div>
  );
}

export function LoginFormFallback() {
  return (
    <div className="min-h-[70vh] flex items-center justify-center text-slate-500 text-sm">
      Loading…
    </div>
  );
}

export default function LoginFormWithSuspense(props: {
  telegramEnabled: boolean;
  googleEnabled: boolean;
  telegramBotEnabled?: boolean;
}) {
  return (
    <Suspense fallback={<LoginFormFallback />}>
      <LoginForm {...props} />
    </Suspense>
  );
}
