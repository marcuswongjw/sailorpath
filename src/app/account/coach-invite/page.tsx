"use client";

import { Suspense, useEffect, useState, type ReactNode } from "react";
import Link from "next/link";
import { useRouter, useSearchParams } from "next/navigation";
import { createBrowserSupabase } from "@/lib/supabase/browser";

function CoachInviteInner() {
  const router = useRouter();
  const searchParams = useSearchParams();
  const token = searchParams.get("token")?.trim() || "";
  const action = searchParams.get("action") === "decline" ? "decline" : "accept";
  const [ready, setReady] = useState(false);
  const [busy, setBusy] = useState(false);
  const [message, setMessage] = useState<string | null>(null);
  const [done, setDone] = useState<"approved" | "rejected" | null>(null);

  useEffect(() => {
    let cancelled = false;
    (async () => {
      const supabase = createBrowserSupabase();
      const {
        data: { session },
      } = await supabase.auth.getSession();
      if (cancelled) return;
      if (!session) {
        const next = `/account/coach-invite?token=${encodeURIComponent(token)}&action=${action}`;
        router.replace(`/login?next=${encodeURIComponent(next)}`);
        return;
      }
      setReady(true);
    })();
    return () => {
      cancelled = true;
    };
  }, [action, router, token]);

  const respond = async (choice: "accept" | "decline") => {
    setBusy(true);
    setMessage(null);
    try {
      const res = await fetch("/api/account/coach-invites", {
        method: "POST",
        credentials: "include",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({ token, action: choice }),
      });
      const data = await res.json().catch(() => ({}));
      if (!res.ok) throw new Error(data.error || "Could not update the invitation");
      setDone(choice === "accept" ? "approved" : "rejected");
    } catch (error) {
      setMessage(error instanceof Error ? error.message : "Could not update the invitation");
    } finally {
      setBusy(false);
    }
  };

  if (!token) {
    return (
      <InviteCard>
        <h1 className="text-xl font-black text-[var(--sp-charcoal)]">Invitation link is incomplete</h1>
        <p className="text-sm text-[var(--sp-slate-soft)]">
          Open the Accept or Decline link from the email again.
        </p>
      </InviteCard>
    );
  }

  if (done === "approved") {
    return (
      <InviteCard>
        <h1 className="text-xl font-black text-[var(--sp-charcoal)]">Coach access accepted</h1>
        <p className="text-sm text-[var(--sp-slate-soft)]">
          This account is now a Coach. Coach tools are available.
        </p>
        <Link
          href="/coach-tools"
          className="inline-flex rounded-full bg-[var(--sp-harbour-teal)] px-4 py-2 text-sm font-bold text-white"
        >
          Open coach tools
        </Link>
      </InviteCard>
    );
  }

  if (done === "rejected") {
    return (
      <InviteCard>
        <h1 className="text-xl font-black text-[var(--sp-charcoal)]">Coach access declined</h1>
        <p className="text-sm text-[var(--sp-slate-soft)]">
          This account stays as it is. Coach tools were not added.
        </p>
        <Link
          href="/account"
          className="inline-flex rounded-full border border-[var(--sp-cool-veil)] px-4 py-2 text-sm font-bold text-[var(--sp-charcoal)]"
        >
          Back to account
        </Link>
      </InviteCard>
    );
  }

  return (
    <InviteCard>
      <h1 className="text-xl font-black text-[var(--sp-charcoal)]">Coach invitation</h1>
      <p className="text-sm text-[var(--sp-slate-soft)]">
        A SailorPath admin invited this account to be a Coach. Accept to turn on coach tools, or decline to leave the account unchanged.
      </p>
      {message && <p className="text-sm font-semibold text-rose-700">{message}</p>}
      <div className="flex flex-wrap gap-2">
        <button
          type="button"
          disabled={!ready || busy}
          onClick={() => void respond("accept")}
          className="rounded-full bg-[var(--sp-harbour-teal)] px-4 py-2 text-sm font-bold text-white disabled:opacity-50"
        >
          {action === "accept" ? "Accept coach access" : "Accept"}
        </button>
        <button
          type="button"
          disabled={!ready || busy}
          onClick={() => void respond("decline")}
          className="rounded-full border border-[var(--sp-cool-veil)] bg-white px-4 py-2 text-sm font-bold text-[var(--sp-charcoal)] disabled:opacity-50"
        >
          {action === "decline" ? "Decline coach access" : "Decline"}
        </button>
      </div>
    </InviteCard>
  );
}

function InviteCard({ children }: { children: ReactNode }) {
  return (
    <div className="mx-auto max-w-lg px-4 py-16">
      <section className="rounded-3xl border border-[var(--sp-cool-veil)] bg-[var(--sp-warm-white)] p-6 space-y-4 shadow-xs">
        {children}
      </section>
    </div>
  );
}

export default function CoachInvitePage() {
  return (
    <Suspense
      fallback={
        <div className="min-h-[40vh] flex items-center justify-center text-sm text-slate-500">
          Loading…
        </div>
      }
    >
      <CoachInviteInner />
    </Suspense>
  );
}
