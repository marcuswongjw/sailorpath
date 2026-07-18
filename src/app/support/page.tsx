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
  const [pageUrl, setPageUrl] = useState("");
  const [busy, setBusy] = useState(false);
  const [done, setDone] = useState(false);
  const [error, setError] = useState<string | null>(null);

  useEffect(() => {
    setPageUrl(
      searchParams.get("from") ||
        (typeof document !== "undefined" ? document.referrer : "") ||
        (typeof window !== "undefined" ? window.location.href : "")
    );
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
  }, [searchParams]);

  const onSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    setBusy(true);
    setError(null);
    try {
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
        <div className="inline-flex h-12 w-12 items-center justify-center rounded-2xl bg-emerald-500/15 text-emerald-400 border border-emerald-500/25">
          <LifeBuoy className="h-6 w-6" />
        </div>
        <h1 className="text-2xl font-black text-white">Message received</h1>
        <p className="text-sm text-slate-400 leading-relaxed">
          Thanks for writing in. We&apos;ll reply to{" "}
          <strong className="text-slate-200">{email}</strong> as soon as we can.
        </p>
        <Link
          href="/"
          className="inline-flex rounded-full bg-orange-600 px-5 py-2.5 text-xs font-bold text-white"
        >
          Back to home
        </Link>
      </div>
    );
  }

  return (
    <div className="mx-auto max-w-lg w-full px-4 py-10 sm:py-14 space-y-6">
      <div className="text-center sm:text-left">
        <h1 className="text-2xl sm:text-3xl font-black text-white tracking-tight">
          Help &amp; support
        </h1>
        <p className="mt-2 text-sm text-slate-400 leading-relaxed">
          Having trouble claiming a profile, rankings, or your account? Send us a
          note — we read every message.
        </p>
      </div>

      <form
        onSubmit={onSubmit}
        className="glass-card rounded-2xl border border-white/5 p-5 sm:p-6 space-y-4 w-full"
      >
        {error && (
          <p className="text-xs font-bold text-rose-400 text-center">{error}</p>
        )}
        <label className="block">
          <span className="text-[10px] font-bold text-slate-500 uppercase">
            Your name
          </span>
          <input
            value={name}
            onChange={(e) => setName(e.target.value)}
            className="mt-1 w-full rounded-xl bg-slate-950 border border-white/10 px-3 py-2.5 text-sm text-white"
            placeholder="Optional"
          />
        </label>
        <label className="block">
          <span className="text-[10px] font-bold text-slate-500 uppercase">
            Email *
          </span>
          <input
            type="email"
            required
            value={email}
            onChange={(e) => setEmail(e.target.value)}
            className="mt-1 w-full rounded-xl bg-slate-950 border border-white/10 px-3 py-2.5 text-sm text-white"
            placeholder="you@email.com"
          />
        </label>
        <label className="block">
          <span className="text-[10px] font-bold text-slate-500 uppercase">
            Topic
          </span>
          <select
            value={topic}
            onChange={(e) => setTopic(e.target.value)}
            className="mt-1 w-full rounded-xl bg-slate-950 border border-white/10 px-3 py-2.5 text-sm text-white"
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
          <span className="text-[10px] font-bold text-slate-500 uppercase">
            Message *
          </span>
          <textarea
            required
            rows={5}
            value={body}
            onChange={(e) => setBody(e.target.value)}
            className="mt-1 w-full rounded-xl bg-slate-950 border border-white/10 px-3 py-2.5 text-sm text-white"
            placeholder="What happened? What were you trying to do?"
          />
        </label>
        <input type="hidden" value={pageUrl} readOnly />
        <button
          type="submit"
          disabled={busy}
          className="w-full rounded-full bg-orange-600 py-3 text-sm font-bold text-white hover:bg-orange-500 disabled:opacity-50"
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
