"use client";

import { useEffect, useState, Suspense } from "react";
import Link from "next/link";
import { useSearchParams } from "next/navigation";
import { createBrowserSupabase } from "@/lib/supabase/browser";
import { LifeBuoy } from "lucide-react";

function SupportForm() {
  const searchParams = useSearchParams();
  const [name, setName] = useState("");
  const [email, setEmail] = useState("");
  const [topic, setTopic] = useState("bug");
  const [body, setBody] = useState("");
  const [busy, setBusy] = useState(false);
  const [done, setDone] = useState(false);
  const [error, setError] = useState<string | null>(null);

  useEffect(() => {
    (async () => {
      try {
        const supabase = createBrowserSupabase();
        const {
          data: { session },
        } = await supabase.auth.getSession();
        if (session?.user?.email) setEmail(session.user.email);
      } catch {
        /* optional */
      }
    })();
  }, []);

  const onSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    setBusy(true);
    setError(null);
    try {
      const pageUrl =
        searchParams.get("from") || document.referrer || window.location.href;
      const res = await fetch("/api/support", {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({ name, email, topic, body, pageUrl }),
      });
      const data = await res.json();
      if (!res.ok) throw new Error(data.error || "Send failed");
      setDone(true);
    } catch (err) {
      setError(err instanceof Error ? err.message : "Could not send message");
    } finally {
      setBusy(false);
    }
  };

  if (done) {
    return (
      <div className="mx-auto max-w-lg w-full px-4 py-12 sm:py-16 text-center space-y-4">
        <div className="inline-flex h-12 w-12 items-center justify-center rounded-2xl bg-emerald-500/15 text-emerald-600 border border-emerald-500/25">
          <LifeBuoy className="h-6 w-6" />
        </div>
        <h1 className="text-2xl sm:text-3xl font-black text-[var(--sp-harbour-shadow)]">Message received</h1>
        <p className="text-sm text-[var(--sp-charcoal-slate)] leading-relaxed">
          Thanks for writing in. We&apos;ll reply to{" "}
          <strong className="text-[var(--sp-harbour-shadow)]">{email}</strong> as soon as we can.
        </p>
        <Link
          href="/"
          className="inline-flex sp-btn-primary px-6 py-2.5 text-xs font-bold"
        >
          Back to home
        </Link>
      </div>
    );
  }

  return (
    <div className="mx-auto max-w-lg w-full px-4 py-10 sm:py-14 space-y-6">
      <div className="text-center sm:text-left">
        <h1 className="text-2xl sm:text-3xl font-black text-[var(--sp-harbour-shadow)] tracking-tight">
          Help &amp; support
        </h1>
        <p className="mt-2 text-sm text-[var(--sp-charcoal-slate)] leading-relaxed">
          Having trouble claiming a profile, rankings, or your account? Send us a
          note — we read every message.
        </p>
      </div>

      <form
        onSubmit={onSubmit}
        className="rounded-2xl border border-[var(--sp-cool-veil)] bg-[var(--sp-warm-white)] p-5 sm:p-6 space-y-4 w-full shadow-xs"
      >
        {error && (
          <p className="text-xs font-bold text-rose-600 text-center">{error}</p>
        )}
        <label className="block">
          <span className="text-xs font-bold text-[var(--sp-slate-soft)] uppercase tracking-wider">
            Your name
          </span>
          <input
            value={name}
            onChange={(e) => setName(e.target.value)}
            className="mt-1.5 sp-input w-full text-sm"
            placeholder="Optional"
          />
        </label>
        <label className="block">
          <span className="text-xs font-bold text-[var(--sp-slate-soft)] uppercase tracking-wider">
            Email *
          </span>
          <input
            type="email"
            required
            value={email}
            onChange={(e) => setEmail(e.target.value)}
            className="mt-1.5 sp-input w-full text-sm"
            placeholder="you@email.com"
          />
        </label>
        <label className="block">
          <span className="text-xs font-bold text-[var(--sp-slate-soft)] uppercase tracking-wider">
            Topic
          </span>
          <select
            value={topic}
            onChange={(e) => setTopic(e.target.value)}
            className="mt-1.5 sp-select w-full text-sm"
          >
            <option value="account">Account / login</option>
            <option value="claim">Profile claim</option>
            <option value="ranking">Rankings / results</option>
            <option value="profile">My profile / photo</option>
            <option value="bug">Bug / something broken</option>
            <option value="other">Other</option>
          </select>
        </label>
        <label className="block">
          <span className="text-xs font-bold text-[var(--sp-slate-soft)] uppercase tracking-wider">
            Message *
          </span>
          <textarea
            required
            rows={5}
            value={body}
            onChange={(e) => setBody(e.target.value)}
            className="mt-1.5 sp-input w-full text-sm"
            placeholder="What happened? What were you trying to do?"
          />
        </label>
        <button
          type="submit"
          disabled={busy}
          className="w-full sp-btn-primary py-3 text-sm font-bold disabled:opacity-50"
        >
          {busy ? "Sending…" : "Send message"}
        </button>
      </form>
    </div>
  );
}

export default function SupportPage() {
  return (
    <Suspense
      fallback={
        <div className="min-h-[40vh] flex items-center justify-center text-sm text-slate-500">
          Loading…
        </div>
      }
    >
      <SupportForm />
    </Suspense>
  );
}
